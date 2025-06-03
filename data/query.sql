/* ===== Consultas útiles ===== */

/* a) Total de alumnos que han desaprobado al menos un examen */
SELECT COUNT(DISTINCT E.id_estudiante) AS total_alumnos_desaprobados
FROM Estudiante E
JOIN AsignacionEvaluacion AE ON E.id_estudiante = AE.id_estudiante
JOIN IntentoEvaluacion IE ON AE.id_asignacion = IE.id_asignacion
WHERE IE.puntajeObtenido IS NOT NULL AND IE.puntajeObtenido < 10.5;

/* Total de exámenes desaprobados (puede haber varios por alumno) */
SELECT COUNT(*) AS total_examenes_desaprobados
FROM IntentoEvaluacion
WHERE puntajeObtenido IS NOT NULL AND puntajeObtenido < 10.5;


/* b) Aprobados en una evaluación específica (id_evaluacion = 1) */
SELECT EV.titulo,
       COUNT(DISTINCT E.id_estudiante) AS total_aprobados
FROM Estudiante E
JOIN AsignacionEvaluacion AE ON E.id_estudiante = AE.id_estudiante
JOIN IntentoEvaluacion IE ON AE.id_asignacion = IE.id_asignacion
JOIN Evaluacion EV ON AE.id_evaluacion = EV.id_evaluacion
WHERE AE.id_evaluacion = 1
  AND IE.puntajeObtenido >= 10.5
GROUP BY EV.titulo;

/* Aprobados por cada evaluación */
SELECT EV.id_evaluacion,
       EV.titulo,
       COUNT(DISTINCT E.id_estudiante) AS total_aprobados
FROM Estudiante E
JOIN AsignacionEvaluacion AE ON E.id_estudiante = AE.id_estudiante
JOIN IntentoEvaluacion IE ON AE.id_asignacion = IE.id_asignacion
JOIN Evaluacion EV ON AE.id_evaluacion = EV.id_evaluacion
WHERE IE.puntajeObtenido >= 10.5
GROUP BY EV.id_evaluacion, EV.titulo
ORDER BY EV.id_evaluacion;


/* c) Exámenes inscritos / resueltos / pendientes por estudiante (id_estudiante = 1) */
SELECT E.nombreEstudiante, E.apellidoEstudiante,
       COUNT(AE.id_asignacion) AS inscritos,
       SUM(CASE WHEN IE.id_intento IS NOT NULL 
                 AND IE.fechaFin IS NOT NULL THEN 1 ELSE 0 END) AS resueltos,
       SUM(CASE WHEN IE.id_intento IS NULL 
                 OR IE.fechaFin IS NULL THEN 1 ELSE 0 END) AS pendientes
FROM Estudiante E
LEFT JOIN AsignacionEvaluacion AE ON E.id_estudiante = AE.id_estudiante
LEFT JOIN IntentoEvaluacion IE ON AE.id_asignacion = IE.id_asignacion
WHERE E.id_estudiante = 1
GROUP BY E.id_estudiante;

/* Resumen para todos los estudiantes */
SELECT E.id_estudiante,
       E.nombreEstudiante, E.apellidoEstudiante,
       COUNT(AE.id_asignacion) AS inscritos,
       SUM(CASE WHEN IE.id_intento IS NOT NULL 
                 AND IE.fechaFin IS NOT NULL THEN 1 ELSE 0 END) AS resueltos,
       SUM(CASE WHEN IE.id_intento IS NULL 
                 OR IE.fechaFin IS NULL THEN 1 ELSE 0 END) AS pendientes
FROM Estudiante E
LEFT JOIN AsignacionEvaluacion AE ON E.id_estudiante = AE.id_estudiante
LEFT JOIN IntentoEvaluacion IE ON AE.id_asignacion = IE.id_asignacion
GROUP BY E.id_estudiante
ORDER BY E.id_estudiante;


/* d) Mejor, peor y promedio de una evaluación (id_evaluacion = 1) */
SELECT EV.titulo,
       MAX(IE.puntajeObtenido) AS mejor,
       MIN(IE.puntajeObtenido) AS peor,
       ROUND(AVG(IE.puntajeObtenido),2) AS promedio
FROM Evaluacion EV
JOIN AsignacionEvaluacion AE ON EV.id_evaluacion = AE.id_evaluacion
JOIN IntentoEvaluacion IE ON AE.id_asignacion = IE.id_asignacion
WHERE EV.id_evaluacion = 1
  AND IE.puntajeObtenido IS NOT NULL
GROUP BY EV.id_evaluacion;

/* Resumen para todas las evaluaciones con intentos */
SELECT EV.id_evaluacion,
       EV.titulo,
       MAX(IE.puntajeObtenido) AS mejor,
       MIN(IE.puntajeObtenido) AS peor,
       ROUND(AVG(IE.puntajeObtenido),2) AS promedio,
       COUNT(*) AS num_intentos
FROM Evaluacion EV
JOIN AsignacionEvaluacion AE ON EV.id_evaluacion = AE.id_evaluacion
JOIN IntentoEvaluacion IE ON AE.id_asignacion = IE.id_asignacion
WHERE IE.puntajeObtenido IS NOT NULL
GROUP BY EV.id_evaluacion, EV.titulo
ORDER BY EV.id_evaluacion;


/* e) Promedio general de un estudiante (id_estudiante = 1) */
SELECT E.nombreEstudiante, E.apellidoEstudiante,
       ROUND(AVG(IE.puntajeObtenido),2) AS promedio_general
FROM Estudiante E
JOIN AsignacionEvaluacion AE ON E.id_estudiante = AE.id_estudiante
JOIN IntentoEvaluacion IE ON AE.id_asignacion = IE.id_asignacion
WHERE E.id_estudiante = 1
  AND IE.puntajeObtenido IS NOT NULL
GROUP BY E.id_estudiante;

/* Promedio de todos los estudiantes con al menos un puntaje */
SELECT E.id_estudiante,
       E.nombreEstudiante, E.apellidoEstudiante,
       ROUND(AVG(IE.puntajeObtenido),2) AS promedio_general,
       COUNT(*) AS examenes_rendidos
FROM Estudiante E
JOIN AsignacionEvaluacion AE ON E.id_estudiante = AE.id_estudiante
JOIN IntentoEvaluacion IE ON AE.id_asignacion = IE.id_asignacion
WHERE IE.puntajeObtenido IS NOT NULL
GROUP BY E.id_estudiante
ORDER BY E.id_estudiante;
