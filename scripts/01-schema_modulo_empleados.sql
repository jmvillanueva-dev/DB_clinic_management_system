-- ==========================================================
-- MODULO DE EMPLEADOS
-- ==========================================================

CREATE TABLE roles (
    id UUID PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    area VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE
);

CREATE TABLE empleados (
    id UUID PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cedula VARCHAR(20) NOT NULL UNIQUE,
    especialidad VARCHAR(255),
    codigo_profesional VARCHAR(50),
    telefono VARCHAR(255),
    esta_activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE
);
