
-- ==========================================================
-- MÓDULO DE EVOLUCIONES MÉDICAS
-- ==========================================================

-- 1. Tabla Principal de Evoluciones Médicas
CREATE TABLE evoluciones_medicas (
    id UUID PRIMARY KEY,
    historia_clinica_id UUID NOT NULL,
    empleado_id UUID NOT NULL,
    fecha_consulta TIMESTAMP WITHOUT TIME ZONE,
    tipo_consulta VARCHAR(100), -- Ej: Primera vez, control, emergencia
    estado VARCHAR(50) DEFAULT 'ACTIVA', -- ACTIVA, CERRADA, CANCELADA
    observaciones_generales TEXT,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_evol_hc FOREIGN KEY (historia_clinica_id) REFERENCES historias_clinicas(id),
    CONSTRAINT fk_evol_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id)
);

-- 2. Sección: Motivo de Atención (Relación 1:1)
CREATE TABLE evolucion_motivo_atencion (
    id UUID PRIMARY KEY,
    evolucion_medica_id UUID NOT NULL UNIQUE,
    motivo_consulta TEXT NOT NULL,
    enfermedad_actual TEXT,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_motivo_evolucion FOREIGN KEY (evolucion_medica_id) REFERENCES evoluciones_medicas(id)
);

-- 3. Sección: Valoración Clínica / Examen Físico (Relación 1:1)
CREATE TABLE evolucion_valoracion_clinica (
    id UUID PRIMARY KEY,
    evolucion_medica_id UUID NOT NULL UNIQUE,
    inspeccion_general TEXT,
    cabeza_cuello TEXT,
    torax TEXT,
    abdomen TEXT,
    extremidades TEXT,
    neurologico TEXT,
    piel_tegumentos TEXT,
    otros_hallazgos TEXT,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_valoracion_evolucion FOREIGN KEY (evolucion_medica_id) REFERENCES evoluciones_medicas(id)
);

-- 4. Sección: Signos Vitales (Relación 1:1)
CREATE TABLE evolucion_signos_vitales (
    id UUID PRIMARY KEY,
    evolucion_medica_id UUID NOT NULL UNIQUE,
    presion_arterial_sistolica INTEGER,
    presion_arterial_diastolica INTEGER,
    frecuencia_cardiaca INTEGER,
    frecuencia_respiratoria INTEGER,
    temperatura DECIMAL(4, 2),
    saturacion_oxigeno INTEGER,
    peso DECIMAL(5, 2),
    talla DECIMAL(5, 2),
    imc DECIMAL(4, 2),
    glucosa DECIMAL(5, 2),
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_signos_evolucion FOREIGN KEY (evolucion_medica_id) REFERENCES evoluciones_medicas(id)
);

Con estas entidades se completa la estructura detallada de la Evolución Médica, permitiendo un registro exhaustivo que abarca desde los antecedentes del incidente hasta el alta y plan terapéutico.

Aquí tienes la actualización integral para tu repositorio de documentación.

1. Continuación del Script SQL (01-schema.sql)
Este bloque de código debe añadirse a continuación de las tablas de evoluciones previas. He respetado las relaciones 1:1 y 1:N definidas en tus entidades.

SQL

-- 5. Sección: Antecedentes del Incidente (Relación 1:1)
CREATE TABLE evolucion_antecedentes_incidente (
    id UUID PRIMARY KEY,
    evolucion_medica_id UUID NOT NULL UNIQUE,
    antecedentes_personales TEXT,
    antecedentes_familiares TEXT,
    habitos_toxicos TEXT,
    alergias TEXT,
    medicamentos_actuales TEXT,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_ant_incidente_evolucion FOREIGN KEY (evolucion_medica_id) REFERENCES evoluciones_medicas(id)
);

-- 6. Sección: Diagnósticos (Relación N:1)
CREATE TABLE evolucion_diagnosticos (
    id UUID PRIMARY KEY,
    evolucion_medica_id UUID NOT NULL,
    codigo_cie VARCHAR(20),
    diagnostico VARCHAR(500) NOT NULL,
    tipo VARCHAR(50), -- Presuntivo, Definitivo
    observaciones TEXT,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_diag_evolucion FOREIGN KEY (evolucion_medica_id) REFERENCES evoluciones_medicas(id)
);

-- 7. Sección: Exámenes Solicitados (Relación N:1)
CREATE TABLE evolucion_examenes_solicitados (
    id UUID PRIMARY KEY,
    evolucion_medica_id UUID NOT NULL,
    tipo_examen VARCHAR(200) NOT NULL, -- Laboratorio, Rayos X, etc.
    nombre_examen VARCHAR(200) NOT NULL,
    indicaciones TEXT,
    urgencia VARCHAR(50) DEFAULT 'ROUTINA',
    estado VARCHAR(50) DEFAULT 'SOLICITADO',
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_exam_evolucion FOREIGN KEY (evolucion_medica_id) REFERENCES evoluciones_medicas(id)
);

-- 8. Sección: Localización de Lesiones (Relación N:1)
CREATE TABLE evolucion_localizacion_lesiones (
    id UUID PRIMARY KEY,
    evolucion_medica_id UUID NOT NULL,
    localizacion VARCHAR(200) NOT NULL,
    tipo_lesion VARCHAR(100),
    descripcion TEXT,
    gravedad VARCHAR(50),
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_lesion_evolucion FOREIGN KEY (evolucion_medica_id) REFERENCES evoluciones_medicas(id)
);

-- 9. Sección: Emergencia Obstétrica (Relación 1:1)
CREATE TABLE evolucion_emergencia_obstetrica (
    id UUID PRIMARY KEY,
    evolucion_medica_id UUID NOT NULL UNIQUE,
    gestas_previas INTEGER,
    partos_previos INTEGER,
    abortos_previos INTEGER,
    fum DATE, -- Fecha última menstruación
    fpp DATE, -- Fecha probable parto
    semanas_gestacion INTEGER,
    presentacion VARCHAR(100),
    dinamica_uterina TEXT,
    latidos_fetales VARCHAR(100),
    observaciones TEXT,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_obst_evolucion FOREIGN KEY (evolucion_medica_id) REFERENCES evoluciones_medicas(id)
);

-- 10. Sección: Planes de Tratamiento (Relación N:1)
CREATE TABLE evolucion_planes_tratamiento (
    id UUID PRIMARY KEY,
    evolucion_medica_id UUID NOT NULL,
    nombre_tratamiento VARCHAR(200) NOT NULL,
    descripcion TEXT,
    tipo_tratamiento VARCHAR(100), -- Farmacológico, Quirúrgico, etc.
    duracion VARCHAR(100),
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_plan_evolucion FOREIGN KEY (evolucion_medica_id) REFERENCES evoluciones_medicas(id)
);

-- 11. Sección: Indicaciones Médicas (Relación N:1 con Plan de Tratamiento)
CREATE TABLE evolucion_indicaciones_medicas (
    id UUID PRIMARY KEY,
    plan_tratamiento_id UUID NOT NULL,
    medicamento VARCHAR(200),
    dosis VARCHAR(100),
    frecuencia VARCHAR(100),
    via_administracion VARCHAR(100),
    duracion VARCHAR(100),
    indicaciones_especiales TEXT,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_ind_plan FOREIGN KEY (plan_treatment_id) REFERENCES evolucion_planes_tratamiento(id)
);

-- 12. Sección: Alta Médica (Relación 1:1)
CREATE TABLE evolucion_alta_medica (
    id UUID PRIMARY KEY,
    evolucion_medica_id UUID NOT NULL UNIQUE,
    fecha_alta TIMESTAMP WITHOUT TIME ZONE,
    tipo_alta VARCHAR(100), -- Mejoría, Traslado, Fallecimiento, etc.
    condicion_alta VARCHAR(100), -- Buena, Regular, Grave
    recomendaciones TEXT,
    control_programado DATE,
    especialidad_control VARCHAR(100),
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_alta_evolucion FOREIGN KEY (evolucion_medica_id) REFERENCES evoluciones_medicas(id)
);