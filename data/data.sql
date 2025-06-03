/* ===== Inserts de prueba ===== */

/* Áreas */
INSERT INTO Areas (id_area, nomArea) VALUES
(1, 'Matemáticas'),
(2, 'Programación'),
(3, 'Historia');

/* Estudiantes */
INSERT INTO Estudiante (id_estudiante, nombreEstudiante, apellidoEstudiante, email) VALUES
(1, 'Ana', 'García', 'ana.garcia@example.com'),
(2, 'Luis', 'Martinez', 'luis.martinez@example.com'),
(3, 'Sofía', 'Rodriguez', 'sofia.rodriguez@example.com'),
(4, 'Carlos', 'Lopez', 'carlos.lopez@example.com'),
(5, 'Laura', 'Perez', 'laura.perez@example.com'),
(6, 'Pedro', 'Sanchez', 'pedro.sanchez@example.com'),
(7, 'Elena', 'Gomez', 'elena.gomez@example.com'),
(8, 'Miguel', 'Diaz', 'miguel.diaz@example.com'),
(9, 'Carmen', 'Fernandez', 'carmen.fernandez@example.com'),
(10,'Jorge', 'Ruiz', 'jorge.ruiz@example.com');

/* Evaluaciones */
INSERT INTO Evaluacion (id_evaluacion, titulo, id_area, fechaCrea, fechaInicio, fechaFin, tiempoLimite, puntajeMaximo) VALUES
(1, 'Álgebra Básica', 1, '2025-05-01 10:00:00', '2025-06-01 00:00:00', '2025-06-07 23:59:59', 60, 20.00),
(2, 'Geometría Euclidiana', 1, '2025-05-01 11:00:00', '2025-06-08 00:00:00', '2025-06-14 23:59:59', 90, 20.00),
(3, 'Introducción a Python', 2, '2025-05-02 09:00:00', '2025-06-15 00:00:00', '2025-06-21 23:59:59', 120, 20.00),
(4, 'Algoritmos y Estructuras de Datos', 2, '2025-05-02 10:00:00', '2025-06-22 00:00:00', '2025-06-28 23:59:59', 120, 20.00),
(5, 'Historia Universal I', 3, '2025-05-03 08:00:00', '2025-06-29 00:00:00', '2025-07-05 23:59:59', 60, 20.00);

/* Preguntas */
INSERT INTO Pregunta (id_pregunta, texto_pregunta, puntaje, id_evaluacion) VALUES
(1,'Resolver: 2x + 5 = 11',4.00,1),(2,'¿Cuál es el valor de x en x - 7 = 3?',4.00,1),
(3,'Simplificar: 3(a + 2b) - 2a',4.00,1),(4,'Factorizar: x^2 - 9',4.00,1),
(5,'Si y = 2x y x = 4, ¿cuál es el valor de y?',4.00,1),
(6,'¿Cuántos lados tiene un hexágono?',4.00,2),(7,'La suma de los ángulos internos de un triángulo es:',4.00,2),
(8,'¿Qué es un ángulo recto?',4.00,2),(9,'Fórmula del área de un círculo:',4.00,2),
(10,'Teorema de Pitágoras se aplica a triángulos de tipo:',4.00,2),
(11,'¿Palabra clave para definir una función en Python?',4.00,3),(12,'Tipo de dato para números enteros en Python:',4.00,3),
(13,'¿Cómo se imprime "Hola Mundo" en Python?',4.00,3),(14,'Operador para la potencia en Python:',4.00,3),
(15,'¿Python es un lenguaje compilado o interpretado?',4.00,3),
(16,'¿Qué es una pila (stack)?',4.00,4),(17,'Complejidad temporal de la búsqueda binaria:',4.00,4),
(18,'¿Qué significa FIFO?',4.00,4),(19,'Ejemplo de algoritmo de ordenamiento:',4.00,4),
(20,'¿Un árbol binario de búsqueda está siempre balanceado?',4.00,4),
(21,'¿En qué continente se originó la especie Homo sapiens?',4.00,5),(22,'Principal actividad económica en el Neolítico:',4.00,5),
(23,'Civilización que se desarrolló entre los ríos Tigris y Éufrates:',4.00,5),
(24,'¿Quién fue el primer emperador romano?',4.00,5),(25,'La democracia se originó en la antigua:',4.00,5);

/* Alternativas */
INSERT INTO Alternativa (id_alternativa, texto_alternativa, esCorrecta, id_pregunta) VALUES
-- Pregunta 1
(1,'x = 2',0,1),(2,'x = 3',1,1),(3,'x = 4',0,1),(4,'x = 5',0,1),
-- Pregunta 2
(5,'x = 4',0,2),(6,'x = 10',1,2),(7,'x = -4',0,2),(8,'x = 7/3',0,2),
-- Pregunta 3
(9,'a + 6b',1,3),(10,'5a + 6b',0,3),(11,'a - 6b',0,3),(12,'a + 3b',0,3),
-- Pregunta 4
(13,'(x - 3)(x - 3)',0,4),(14,'(x + 3)(x + 3)',0,4),(15,'(x - 3)(x + 3)',1,4),(16,'No se puede factorizar',0,4),
-- Pregunta 5
(17,'y = 2',0,5),(18,'y = 4',0,5),(19,'y = 6',0,5),(20,'y = 8',1,5),
-- Pregunta 6
(21,'5',0,6),(22,'6',1,6),(23,'7',0,6),(24,'8',0,6),
-- Pregunta 7
(25,'90 grados',0,7),(26,'180 grados',1,7),(27,'270 grados',0,7),(28,'360 grados',0,7),
-- Pregunta 8
(29,'Un ángulo menor a 90°',0,8),(30,'Un ángulo de 90°',1,8),(31,'Un ángulo mayor a 90°',0,8),(32,'Un ángulo de 180°',0,8),
-- Pregunta 9
(33,'pi * radio',0,9),(34,'2 * pi * radio',0,9),(35,'pi * radio^2',1,9),(36,'base * altura / 2',0,9),
-- Pregunta 10
(37,'Isósceles',0,10),(38,'Equiláteros',0,10),(39,'Rectángulos',1,10),(40,'Escalenos',0,10),
-- Pregunta 11
(41,'function',0,11),(42,'def',1,11),(43,'fun',0,11),(44,'define',0,11),
-- Pregunta 12
(45,'float',0,12),(46,'str',0,12),(47,'int',1,12),(48,'integer',0,12),
-- Pregunta 13
(49,'echo "Hola Mundo"',0,13),(50,'System.out.println("Hola Mundo")',0,13),(51,'print("Hola Mundo")',1,13),(52,'printf("Hola Mundo")',0,13),
-- Pregunta 14
(53,'^',0,14),(54,'**',1,14),(55,'pow()',0,14),(56,'exp()',0,14),
-- Pregunta 15
(57,'Compilado',0,15),(58,'Interpretado',1,15),(59,'Ambos',0,15),(60,'Ninguno',0,15),
-- Pregunta 16
(61,'Una estructura de datos LIFO',1,16),(62,'Una estructura de datos FIFO',0,16),(63,'Un tipo de árbol',0,16),(64,'Un algoritmo de ordenamiento',0,16),
-- Pregunta 17
(65,'O(n)',0,17),(66,'O(log n)',1,17),(67,'O(n^2)',0,17),(68,'O(1)',0,17),
-- Pregunta 18
(69,'First In, Last Out',0,18),(70,'First In, First Out',1,18),(71,'Last In, First Out',0,18),(72,'Last In, Last Out',0,18),
-- Pregunta 19
(73,'Búsqueda Binaria',0,19),(74,'QuickSort',1,19),(75,'Recorrido DFS',0,19),(76,'Dijkstra',0,19),
-- Pregunta 20
(77,'Sí, siempre',0,20),(78,'No, nunca',0,20),(79,'No necesariamente',1,20),(80,'Solo si tiene pocos nodos',0,20),
-- Pregunta 21
(81,'Asia',0,21),(82,'África',1,21),(83,'Europa',0,21),(84,'América',0,21),
-- Pregunta 22
(85,'Caza y recolección',0,22),(86,'Pesca',0,22),(87,'Agricultura y ganadería',1,22),(88,'Comercio',0,22),
-- Pregunta 23
(89,'Egipcia',0,23),(90,'Griega',0,23),(91,'Mesopotámica',1,23),(92,'Romana',0,23),
-- Pregunta 24
(93,'Julio César',0,24),(94,'Augusto',1,24),(95,'Nerón',0,24),(96,'Marco Aurelio',0,24),
-- Pregunta 25
(97,'Esparta',0,25),(98,'Roma',0,25),(99,'Atenas',1,25),(100,'Egipto',0,25);

/* Asignaciones de evaluaciones a estudiantes */
INSERT INTO AsignacionEvaluacion (id_asignacion, fechaAsignacion, id_estudiante, id_evaluacion) VALUES
(1,'2025-05-20 10:00:00',1,1),(2,'2025-05-20 10:00:00',1,2),(3,'2025-05-20 10:00:00',1,3),
(4,'2025-05-20 10:00:00',2,1),(5,'2025-05-20 10:00:00',2,2),(6,'2025-05-20 10:00:00',2,3),
(7,'2025-05-20 10:00:00',3,1),(8,'2025-05-20 10:00:00',3,2),(9,'2025-05-20 10:00:00',3,3),
(10,'2025-05-20 10:00:00',4,1),(11,'2025-05-20 10:00:00',4,2),(12,'2025-05-20 10:00:00',4,3),
(13,'2025-05-21 10:00:00',5,4),(14,'2025-05-21 10:00:00',5,5),
(15,'2025-05-21 10:00:00',6,4),(16,'2025-05-21 10:00:00',6,5),
(17,'2025-05-21 10:00:00',7,4),(18,'2025-05-21 10:00:00',7,5);

/* Intentos de evaluación */
INSERT INTO IntentoEvaluacion (id_intento, id_asignacion, fechaInicio, fechaFin, puntajeObtenido) VALUES
(1,1,'2025-06-01 09:00:00','2025-06-01 09:50:00',16.00),
(2,2,'2025-06-08 10:00:00','2025-06-08 11:20:00',20.00),
(3,3,'2025-06-15 14:00:00','2025-06-15 15:45:00',16.00),
(4,4,'2025-06-02 09:00:00','2025-06-02 09:45:00',20.00),
(5,5,'2025-06-09 10:00:00','2025-06-09 11:15:00',16.00),
(6,6,'2025-06-16 14:00:00','2025-06-16 15:30:00',20.00),
(7,7,'2025-06-03 09:00:00','2025-06-03 09:55:00',12.00),
(8,8,'2025-06-10 10:00:00','2025-06-10 11:25:00',16.00),
(9,9,'2025-06-17 14:00:00','2025-06-17 15:50:00',12.00),
(10,10,'2025-06-04 09:00:00','2025-06-04 09:40:00',16.00),
(11,11,'2025-06-11 10:00:00','2025-06-11 11:10:00',12.00),
(12,12,'2025-06-18 14:00:00','2025-06-18 15:40:00',8.00),
(13,13,'2025-06-22 09:00:00','2025-06-22 10:50:00',20.00),
(14,14,'2025-06-29 10:00:00','2025-06-29 10:45:00',16.00),
(15,15,'2025-06-23 09:00:00','2025-06-23 10:30:00',16.00),
(16,16,'2025-06-30 10:00:00','2025-06-30 10:55:00',12.00),
(17,17,'2025-06-24 09:00:00','2025-06-24 10:40:00',4.00),
(18,18,'2025-07-01 10:00:00','2025-07-01 10:40:00',20.00);

/* Respuestas de cada intento (id_intento, id_pregunta, id_alternativa) */
/* Intento 1 – 16 pts (P5 incorrecta) */
INSERT INTO Respuestas VALUES
(1,1,1,2),(2,1,2,6),(3,1,3,9),(4,1,4,15),(5,1,5,17);
/* Intento 2 – 20 pts */
INSERT INTO Respuestas VALUES
(6,2,6,22),(7,2,7,26),(8,2,8,30),(9,2,9,35),(10,2,10,39);
/* Intento 3 – 16 pts (P15 incorrecta) */
INSERT INTO Respuestas VALUES
(11,3,11,42),(12,3,12,47),(13,3,13,51),(14,3,14,54),(15,3,15,57);
/* Intento 4 – 20 pts */
INSERT INTO Respuestas VALUES
(16,4,1,2),(17,4,2,6),(18,4,3,9),(19,4,4,15),(20,4,5,20);
/* Intento 5 – 16 pts (P10 incorrecta) */
INSERT INTO Respuestas VALUES
(21,5,6,22),(22,5,7,26),(23,5,8,30),(24,5,9,35),(25,5,10,37);
/* Intento 6 – 20 pts */
INSERT INTO Respuestas VALUES
(26,6,11,42),(27,6,12,47),(28,6,13,51),(29,6,14,54),(30,6,15,58);
/* Intento 7 – 12 pts (P4,5 incorrectas) */
INSERT INTO Respuestas VALUES
(31,7,1,2),(32,7,2,6),(33,7,3,9),(34,7,4,13),(35,7,5,17);
/* Intento 8 – 16 pts (P8 incorrecta) */
INSERT INTO Respuestas VALUES
(36,8,6,22),(37,8,7,26),(38,8,8,29),(39,8,9,35),(40,8,10,39);
/* Intento 9 – 12 pts (P13,14 incorrectas) */
INSERT INTO Respuestas VALUES
(41,9,11,42),(42,9,12,47),(43,9,13,49),(44,9,14,53),(45,9,15,58);
/* Intento 10 – 16 pts (P1 incorrecta) */
INSERT INTO Respuestas VALUES
(46,10,1,1),(47,10,2,6),(48,10,3,9),(49,10,4,15),(50,10,5,20);
/* Intento 11 – 12 pts (P6,7 incorrectas) */
INSERT INTO Respuestas VALUES
(51,11,6,21),(52,11,7,25),(53,11,8,30),(54,11,9,35),(55,11,10,39);
/* Intento 12 – 8 pts (P13-15 incorrectas) */
INSERT INTO Respuestas VALUES
(56,12,11,42),(57,12,12,47),(58,12,13,49),(59,12,14,53),(60,12,15,57);
/* Intento 13 – 20 pts */
INSERT INTO Respuestas VALUES
(61,13,16,61),(62,13,17,66),(63,13,18,70),(64,13,19,74),(65,13,20,79);
/* Intento 14 – 16 pts (P21 incorrecta) */
INSERT INTO Respuestas VALUES
(66,14,21,81),(67,14,22,87),(68,14,23,91),(69,14,24,94),(70,14,25,99);
/* Intento 15 – 16 pts (P18 incorrecta) */
INSERT INTO Respuestas VALUES
(71,15,16,61),(72,15,17,66),(73,15,18,69),(74,15,19,74),(75,15,20,79);
/* Intento 16 – 12 pts (P23,24 incorrectas) */
INSERT INTO Respuestas VALUES
(76,16,21,82),(77,16,22,87),(78,16,23,89),(79,16,24,93),(80,16,25,99);
/* Intento 17 – 4 pts (P17-20 incorrectas) */
INSERT INTO Respuestas VALUES
(81,17,16,61),(82,17,17,65),(83,17,18,69),(84,17,19,73),(85,17,20,77);
/* Intento 18 – 20 pts */
INSERT INTO Respuestas VALUES
(86,18,21,82),(87,18,22,87),(88,18,23,91),(89,18,24,94),(90,18,25,99);
