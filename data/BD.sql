CREATE DATABASE aprendePeru;
USE aprendePeru;

-- Tabla Areas
CREATE TABLE Areas (
    id_area      INT          PRIMARY KEY AUTO_INCREMENT,
    nomArea      VARCHAR(255) NOT NULL UNIQUE
);

-- Tabla Estudiante
CREATE TABLE Estudiante (
    id_estudiante      INT           PRIMARY KEY AUTO_INCREMENT,
    nombreEstudiante   VARCHAR(100)  NOT NULL,
    apellidoEstudiante VARCHAR(100)  NOT NULL,
    email              VARCHAR(255)  NOT NULL UNIQUE
);

-- Tabla Evaluacion
CREATE TABLE Evaluacion (
    id_evaluacion INT PRIMARY KEY AUTO_INCREMENT,
    titulo        VARCHAR(255) NOT NULL,
    id_area       INT          NOT NULL,
    fechaCrea     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fechaInicio   DATETIME     NOT NULL,
    fechaFin      DATETIME     NOT NULL,
    tiempoLimite  INT          NOT NULL,
    puntajeMaximo DECIMAL(4,2) NOT NULL,
    FOREIGN KEY (id_area) REFERENCES Areas(id_area)
);

-- Tabla Pregunta
CREATE TABLE Pregunta (
    id_pregunta    INT          PRIMARY KEY AUTO_INCREMENT,
    texto_pregunta TEXT         NOT NULL,
    puntaje        DECIMAL(4,2) NOT NULL,
    id_evaluacion  INT          NOT NULL,
    FOREIGN KEY (id_evaluacion) REFERENCES Evaluacion(id_evaluacion)
);

-- Tabla Alternativa
CREATE TABLE Alternativa (
    id_alternativa    INT  PRIMARY KEY AUTO_INCREMENT,
    texto_alternativa TEXT NOT NULL,
    esCorrecta        BOOLEAN NOT NULL,
    id_pregunta       INT  NOT NULL,
    FOREIGN KEY (id_pregunta) REFERENCES Pregunta(id_pregunta)
);

-- Tabla AsignacionEvaluacion
CREATE TABLE AsignacionEvaluacion (
    id_asignacion   INT PRIMARY KEY AUTO_INCREMENT,
    fechaAsignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_estudiante   INT NOT NULL,
    id_evaluacion   INT NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    FOREIGN KEY (id_evaluacion) REFERENCES Evaluacion(id_evaluacion),
    UNIQUE (id_estudiante, id_evaluacion)
);

-- Tabla IntentoEvaluacion
CREATE TABLE IntentoEvaluacion (
    id_intento       INT PRIMARY KEY AUTO_INCREMENT,
    id_asignacion    INT NOT NULL UNIQUE,
    fechaInicio      DATETIME NOT NULL,
    fechaFin         DATETIME NULL,
    puntajeObtenido  DECIMAL(4,2) NULL,
    FOREIGN KEY (id_asignacion) REFERENCES AsignacionEvaluacion(id_asignacion)
);

-- Tabla Respuestas
CREATE TABLE Respuestas (
    id_respuesta   INT PRIMARY KEY AUTO_INCREMENT,
    id_intento     INT NOT NULL,
    id_pregunta    INT NOT NULL,
    id_alternativa INT NOT NULL,
    FOREIGN KEY (id_intento)     REFERENCES IntentoEvaluacion(id_intento),
    FOREIGN KEY (id_pregunta)    REFERENCES Pregunta(id_pregunta),
    FOREIGN KEY (id_alternativa) REFERENCES Alternativa(id_alternativa),
    UNIQUE (id_intento, id_pregunta)
);
