<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/Database.php';

class Alternativa
{
    private PDO $conn;
    private string $table = 'Alternativa';

    public function __construct()
    {
        $this->conn = (new Database())->getConnection()
            ?? throw new RuntimeException("No se pudo conectar a la base de datos.");
    }

    public function create(string $texto_alternativa, int $esCorrecta, int $pregunta_id): int|false
    {
        $sql = "INSERT INTO {$this->table} (texto_alternativa, esCorrecta, id_pregunta)
                VALUES (?,?,?)";
        $stmt = $this->conn->prepare($sql);
        $texto = htmlspecialchars(strip_tags($texto_alternativa));

        if ($stmt->execute([$texto, $esCorrecta, $pregunta_id])) {
            return (int)$this->conn->lastInsertId();
        }
        return false;
    }

    public function getAll(): array
    {
        $sql = "SELECT
                    id_alternativa AS id,
                    id_pregunta AS pregunta_id,
                    texto_alternativa,
                    esCorrecta AS es_correcta
                FROM {$this->table}
                ORDER BY id_pregunta, id_alternativa";
        return $this->conn->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }
}
