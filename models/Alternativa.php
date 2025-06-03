<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/Database.php';

class Alternativa
{
    private ?PDO $conn;
    private string $table_name = "Alternativa";

    public ?int $id = null;
    public int $pregunta_id;
    public string $texto_alternativa;
    public int $es_correcta;

    public function __construct()
    {
        $database = new Database();
        $this->conn = $database->getConnection();
        if ($this->conn === null) {
            throw new RuntimeException("No se pudo conectar a la base de datos.");
        }
    }

    public function create(): int|false
    {
        $query = "INSERT INTO {$this->table_name} (texto_alternativa, esCorrecta, id_pregunta)
                  VALUES (:texto_alternativa, :esCorrecta, :id_pregunta)";

        $stmt = $this->conn->prepare($query);

        $this->texto_alternativa = htmlspecialchars(strip_tags($this->texto_alternativa));

        $stmt->bindParam(':texto_alternativa', $this->texto_alternativa);
        $stmt->bindParam(':esCorrecta', $this->es_correcta, PDO::PARAM_INT);
        $stmt->bindParam(':id_pregunta', $this->pregunta_id, PDO::PARAM_INT);

        if ($stmt->execute()) {
            $lastId = $this->conn->lastInsertId();
            return $lastId ? (int)$lastId : false;
        }
        return false;
    }

    public function getAll(): array
    {
        $query = "SELECT a.id_alternativa AS id, a.id_pregunta AS pregunta_id,
                         p.texto_pregunta, a.texto_alternativa, a.esCorrecta AS es_correcta
                  FROM {$this->table_name} a
                  LEFT JOIN Pregunta p ON a.id_pregunta = p.id_pregunta
                  ORDER BY a.id_pregunta, a.id_alternativa ASC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getById(int $id): array|false
    {
        $query = "SELECT a.id_alternativa AS id, a.id_pregunta AS pregunta_id,
                         p.texto_pregunta, a.texto_alternativa, a.esCorrecta AS es_correcta
                  FROM {$this->table_name} a
                  LEFT JOIN Pregunta p ON a.id_pregunta = p.id_pregunta
                  WHERE a.id_alternativa = :id
                  LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getByPregunta(int $pregunta_id): array
    {
        $query = "SELECT a.id_alternativa AS id, a.id_pregunta AS pregunta_id,
                         p.texto_pregunta, a.texto_alternativa, a.esCorrecta AS es_correcta
                  FROM {$this->table_name} a
                  LEFT JOIN Pregunta p ON a.id_pregunta = p.id_pregunta
                  WHERE a.id_pregunta = :pregunta_id
                  ORDER BY a.id_alternativa ASC";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':pregunta_id', $pregunta_id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getCorrectasByPregunta(int $pregunta_id): array
    {
        $query = "SELECT a.id_alternativa AS id, a.id_pregunta AS pregunta_id,
                         p.texto_pregunta, a.texto_alternativa, a.esCorrecta AS es_correcta
                  FROM {$this->table_name} a
                  LEFT JOIN Pregunta p ON a.id_pregunta = p.id_pregunta
                  WHERE a.id_pregunta = :pregunta_id AND a.esCorrecta = 1
                  ORDER BY a.id_alternativa ASC";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':pregunta_id', $pregunta_id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    public function createMultiple(array $alternativas): array|false
    {
        $query = "INSERT INTO {$this->table_name} (texto_alternativa, esCorrecta, id_pregunta)
                  VALUES (:texto_alternativa, :esCorrecta, :id_pregunta)";
        
        try {
            $this->conn->beginTransaction();
            $stmt = $this->conn->prepare($query);
            $inserted_ids = [];

            foreach ($alternativas as $item) {
                $text   = htmlspecialchars(strip_tags($item['texto_alternativa']));
                $isCorr = (int) $item['es_correcta'];
                $pid    = (int) $item['pregunta_id'];

                $stmt->bindParam(':texto_alternativa', $text);
                $stmt->bindParam(':esCorrecta', $isCorr, PDO::PARAM_INT);
                $stmt->bindParam(':id_pregunta', $pid, PDO::PARAM_INT);

                if ($stmt->execute()) {
                    $lastId = $this->conn->lastInsertId();
                    if ($lastId) {
                        $inserted_ids[] = (int)$lastId;
                    } else {
                        throw new Exception("No se pudo obtener el ID de la alternativa insertada.");
                    }
                } else {
                    throw new Exception("No se pudo insertar una de las alternativas.");
                }
            }
            $this->conn->commit();
            return $inserted_ids;
        } catch (Exception $e) {
            if ($this->conn->inTransaction()) {
                $this->conn->rollBack();
            }
            error_log("Error en createMultiple Alternativa: " . $e->getMessage());
            return false;
        }
    }

    public function validateCorrectAnswers(int $pregunta_id): bool
    {
        $query = "SELECT COUNT(*) AS total_correctas
                  FROM {$this->table_name}
                  WHERE id_pregunta = :pregunta_id AND esCorrecta = 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':pregunta_id', $pregunta_id, PDO::PARAM_INT);
        $stmt->execute();
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row && (int)$row['total_correctas'] > 0;
    }
}
