<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/Database.php';

class Evaluacion
{
    private PDO $conn;
    private string $table = 'Evaluacion';

    public function __construct()
    {
        $this->conn = (new Database())->getConnection()
            ?? throw new RuntimeException("No se pudo conectar a la base de datos.");
    }

    public function create(
        string $titulo,
        int $id_area,
        string $fechaInicio,
        string $fechaFin,
        int $tiempoLimite,
        float $puntajeMaximo
    ): int|false {
        $sql = "INSERT INTO {$this->table}
                    (titulo, id_area, fechaInicio, fechaFin, tiempoLimite, puntajeMaximo)
                VALUES (?,?,?,?,?,?)";
        $stmt = $this->conn->prepare($sql);
        $titulo = htmlspecialchars(strip_tags($titulo));

        if ($stmt->execute([$titulo, $id_area, $fechaInicio, $fechaFin, $tiempoLimite, $puntajeMaximo])) {
            return (int)$this->conn->lastInsertId();
        }
        return false;
    }

    public function getAll(): array
    {
        $sql = "SELECT
                    id_evaluacion AS id,
                    titulo,
                    id_area AS area_id,
                    fechaCrea AS fecha_creacion,
                    fechaInicio AS fecha_inicio,
                    fechaFin AS fecha_fin,
                    tiempoLimite AS duracion,
                    puntajeMaximo AS puntaje
                FROM {$this->table}
                ORDER BY fechaCrea DESC";
        return $this->conn->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }
}
