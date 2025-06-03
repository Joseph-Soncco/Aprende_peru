<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/Database.php';

class Evaluacion
{
    private ?PDO $conn;
    private string $table_name = "Evaluacion";

    public ?int $id = null;
    public string $titulo;
    public int $id_area;
    public ?string $fechaCrea = null;
    public string $fechaInicio;
    public string $fechaFin;
    public int $tiempoLimite;
    public float $puntajeMaximo;

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
        $query = "INSERT INTO {$this->table_name}
                    (titulo, id_area, fechaInicio, fechaFin, tiempoLimite, puntajeMaximo)
                  VALUES
                    (:titulo, :id_area, :fechaInicio, :fechaFin, :tiempoLimite, :puntajeMaximo)";

        $stmt = $this->conn->prepare($query);

        $this->titulo = htmlspecialchars(strip_tags($this->titulo));
        // id_area, tiempoLimite son int por tipado de propiedad
        // puntajeMaximo es float por tipado de propiedad
        $this->fechaInicio = htmlspecialchars(strip_tags($this->fechaInicio));
        $this->fechaFin = htmlspecialchars(strip_tags($this->fechaFin));

        $stmt->bindParam(':titulo', $this->titulo);
        $stmt->bindParam(':id_area', $this->id_area, PDO::PARAM_INT);
        $stmt->bindParam(':fechaInicio', $this->fechaInicio);
        $stmt->bindParam(':fechaFin', $this->fechaFin);
        $stmt->bindParam(':tiempoLimite', $this->tiempoLimite, PDO::PARAM_INT);
        $stmt->bindParam(':puntajeMaximo', $this->puntajeMaximo);

        if ($stmt->execute()) {
            $lastId = $this->conn->lastInsertId();
            return $lastId ? (int)$lastId : false;
        }
        return false;
    }

    public function getAll(): array
    {
        $query = "SELECT e.id_evaluacion AS id, e.titulo, e.id_area AS area_id,
                         a.nomArea AS area_nombre, e.fechaCrea AS fecha_creacion,
                         e.fechaInicio AS fecha_inicio, e.fechaFin AS fecha_fin,
                         e.tiempoLimite AS duracion, e.puntajeMaximo AS puntaje
                  FROM {$this->table_name} e
                  LEFT JOIN Areas a ON e.id_area = a.id_area
                  ORDER BY e.fechaCrea DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getById(int $id): array|false
    {
        $query = "SELECT e.id_evaluacion AS id, e.titulo, e.id_area AS area_id,
                         a.nomArea AS area_nombre, e.fechaCrea AS fecha_creacion,
                         e.fechaInicio AS fecha_inicio, e.fechaFin AS fecha_fin,
                         e.tiempoLimite AS duracion, e.puntajeMaximo AS puntaje
                  FROM {$this->table_name} e
                  LEFT JOIN Areas a ON e.id_area = a.id_area
                  WHERE e.id_evaluacion = :id
                  LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getByArea(int $area_id): array
    {
        $query = "SELECT e.id_evaluacion AS id, e.titulo, e.id_area AS area_id,
                         a.nomArea AS area_nombre, e.fechaCrea AS fecha_creacion,
                         e.fechaInicio AS fecha_inicio, e.fechaFin AS fecha_fin,
                         e.tiempoLimite AS duracion, e.puntajeMaximo AS puntaje
                  FROM {$this->table_name} e
                  LEFT JOIN Areas a ON e.id_area = a.id_area
                  WHERE e.id_area = :area_id
                  ORDER BY e.fechaCrea DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':area_id', $area_id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
