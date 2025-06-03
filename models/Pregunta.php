<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/Database.php';

class Pregunta
{
    private PDO $conn;
    private string $table = 'Pregunta';

    public function __construct()
    {
        $this->conn = (new Database())->getConnection()
            ?? throw new RuntimeException("No se pudo conectar a la base de datos.");
    }

    public function create(string $texto_pregunta, float $puntaje, int $id_evaluacion): int|false
    {
        $sql = "INSERT INTO {$this->table} (texto_pregunta, puntaje, id_evaluacion)
                VALUES (?,?,?)";
        $stmt = $this->conn->prepare($sql);
        $texto = htmlspecialchars(strip_tags($texto_pregunta));

        if ($stmt->execute([$texto, $puntaje, $id_evaluacion])) {
            return (int)$this->conn->lastInsertId();
        }
        return false;
    }

    public function getAll(): array
    {
        $sql = "SELECT
                    id_pregunta AS id,
                    texto_pregunta,
                    puntaje,
                    id_evaluacion AS evaluacion_id
                FROM {$this->table}
                ORDER BY id_evaluacion, id_pregunta";
        return $this->conn->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }
}
