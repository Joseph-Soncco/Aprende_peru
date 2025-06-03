<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/Database.php';

class Pregunta
{
    private ?PDO $conn;
    private string $table_name = "Pregunta";

    public ?int $id = null;
    public string $texto_pregunta;
    public float $puntaje;
    public int $id_evaluacion;

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
        $query = "INSERT INTO {$this->table_name} (texto_pregunta, puntaje, id_evaluacion)
                  VALUES (:texto_pregunta, :puntaje, :id_evaluacion)";

        $stmt = $this->conn->prepare($query);

        $this->texto_pregunta = htmlspecialchars(strip_tags($this->texto_pregunta));

        $stmt->bindParam(':texto_pregunta', $this->texto_pregunta);
        $stmt->bindParam(':puntaje', $this->puntaje);
        $stmt->bindParam(':id_evaluacion', $this->id_evaluacion, PDO::PARAM_INT);

        if ($stmt->execute()) {
            $lastId = $this->conn->lastInsertId();
            return $lastId ? (int)$lastId : false;
        }
        return false;
    }

    public function getAll(): array
    {
        $query = "SELECT p.id_pregunta AS id, p.texto_pregunta, p.puntaje,
                         p.id_evaluacion AS evaluacion_id, e.titulo AS evaluacion_titulo
                  FROM {$this->table_name} p
                  LEFT JOIN Evaluacion e ON p.id_evaluacion = e.id_evaluacion
                  ORDER BY p.id_evaluacion, p.id_pregunta ASC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getById(int $id): array|false
    {
        $query = "SELECT p.id_pregunta AS id, p.texto_pregunta, p.puntaje,
                         p.id_evaluacion AS evaluacion_id, e.titulo AS evaluacion_titulo
                  FROM {$this->table_name} p
                  LEFT JOIN Evaluacion e ON p.id_evaluacion = e.id_evaluacion
                  WHERE p.id_pregunta = :id
                  LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getByEvaluacion(int $evaluacion_id): array
    {
        $query = "SELECT p.id_pregunta AS id, p.texto_pregunta, p.puntaje,
                         p.id_evaluacion AS evaluacion_id, e.titulo AS evaluacion_titulo
                  FROM {$this->table_name} p
                  LEFT JOIN Evaluacion e ON p.id_evaluacion = e.id_evaluacion
                  WHERE p.id_evaluacion = :evaluacion_id
                  ORDER BY p.id_pregunta ASC";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':evaluacion_id', $evaluacion_id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getWithAlternativas(int $evaluacion_id): array
    {
        $query = "SELECT p.id_pregunta AS pregunta_id, p.texto_pregunta, p.puntaje,
                         a.id_alternativa AS alternativa_id, a.texto_alternativa, a.esCorrecta AS es_correcta
                  FROM {$this->table_name} p
                  LEFT JOIN Alternativa a ON p.id_pregunta = a.id_pregunta
                  WHERE p.id_evaluacion = :evaluacion_id
                  ORDER BY p.id_pregunta ASC, a.id_alternativa ASC";

        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':evaluacion_id', $evaluacion_id, PDO::PARAM_INT);
        $stmt->execute();
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $preguntas = [];
        foreach ($rows as $row) {
            $preguntaId = (int) $row['pregunta_id'];
            if (!isset($preguntas[$preguntaId])) {
                $preguntas[$preguntaId] = [
                    'id' => $preguntaId,
                    'texto_pregunta' => (string) $row['texto_pregunta'],
                    'puntaje' => (float) $row['puntaje'],
                    'alternativas' => []
                ];
            }

            if ($row['alternativa_id'] !== null) {
                $preguntas[$preguntaId]['alternativas'][] = [
                    'id' => (int) $row['alternativa_id'],
                    'texto_alternativa' => (string) $row['texto_alternativa'],
                    'es_correcta' => (int) $row['es_correcta']
                ];
            }
        }
        return array_values($preguntas);
    }
}
