-- ==========================================================
-- MÓDULO DE HISTORIAS CLÍNICAS 
-- ==========================================================

-- 1. Tabla de Historia Clínica (Contenedor principal por paciente)
CREATE TABLE historias_clinicas (
    id UUID PRIMARY KEY,
    paciente_id UUID NOT NULL UNIQUE,
    numero_historia_clinica VARCHAR(20) NOT NULL UNIQUE,
    institucion_sistema VARCHAR(200) DEFAULT 'Red Pública Integral de Salud',
    unidad_operativa VARCHAR(200) DEFAULT 'Centro Médico Urdiales Espinoza',
    cod_unidad VARCHAR(20) DEFAULT '59890',
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_hc_paciente FOREIGN KEY (paciente_id) REFERENCES pacientes(id)
);