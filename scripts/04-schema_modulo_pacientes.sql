-- ==========================================================
-- MODULO DE PACIENTES
-- ==========================================================

-- 1. Tabla Principal de Pacientes
CREATE TABLE pacientes (
    id UUID PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL UNIQUE,
    primer_nombre VARCHAR(100) NOT NULL,
    segundo_nombre VARCHAR(100),
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100),
    email VARCHAR(255),
    telefono VARCHAR(20),
    grupo_sanguineo_id UUID,
    esta_activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_paciente_grupo_sanguineo FOREIGN KEY (grupo_sanguineo_id) REFERENCES items_catalogo(id)
);

-- 2. Datos Demográficos (Relación 1:1)
CREATE TABLE pacientes_datos_demograficos (
    id UUID PRIMARY KEY,
    paciente_id UUID NOT NULL UNIQUE,
    fecha_nacimiento DATE NOT NULL,
    lugar_nacimiento VARCHAR(200),
    genero_id UUID NOT NULL,
    nacionalidad VARCHAR(100),
    grupo_cultural_id UUID,
    estado_civil_id UUID,
    nivel_instruccion_id UUID,
    ubicacion_geografica_id UUID,
    ocupacion_id UUID,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_demog_paciente FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    CONSTRAINT fk_demog_genero FOREIGN KEY (genero_id) REFERENCES items_catalogo(id),
    CONSTRAINT fk_demog_grupo_cult FOREIGN KEY (grupo_cultural_id) REFERENCES items_catalogo(id),
    CONSTRAINT fk_demog_est_civil FOREIGN KEY (estado_civil_id) REFERENCES items_catalogo(id),
    CONSTRAINT fk_demog_instruccion FOREIGN KEY (nivel_instruccion_id) REFERENCES items_catalogo(id)
);

-- 3. Ubicación Geográfica (Relación 1:1)
CREATE TABLE pacientes_ubicacion_geografica (
    id UUID PRIMARY KEY,
    paciente_id UUID NOT NULL UNIQUE,
    direccion TEXT NOT NULL,
    provincia_id UUID,
    canton VARCHAR(100),
    parroquia VARCHAR(100),
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_ubic_paciente FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    CONSTRAINT fk_ubic_provincia FOREIGN KEY (provincia_id) REFERENCES items_catalogo(id)
);

-- 4. Ocupación Laboral (Relación 1:1)
CREATE TABLE pacientes_ocupacion (
    id UUID PRIMARY KEY,
    paciente_id UUID NOT NULL UNIQUE,
    ocupacion_id UUID NOT NULL,
    nombre_empresa VARCHAR(200),
    cargo VARCHAR(100),
    telefono_empresa VARCHAR(20),
    direccion_empresa TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    actual BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_ocup_paciente FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    CONSTRAINT fk_ocup_item FOREIGN KEY (ocupacion_id) REFERENCES items_catalogo(id)
);

-- 5. Fuente de Información (Relación 1:1)
CREATE TABLE pacientes_fuente_informacion (
    id UUID PRIMARY KEY,
    paciente_id UUID NOT NULL UNIQUE,
    fuente_informacion_id UUID NOT NULL,
    nombre_fuente_info VARCHAR(200) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    observaciones TEXT,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_fuente_paciente FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    CONSTRAINT fk_fuente_item FOREIGN KEY (fuente_informacion_id) REFERENCES items_catalogo(id)
);

-- 6. Contactos de Emergencia (Relación 1:N)
CREATE TABLE pacientes_contacto_emergencia (
    id UUID PRIMARY KEY,
    paciente_id UUID NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    parentesco_id UUID NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion TEXT,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_cont_paciente FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    CONSTRAINT fk_cont_parentesco FOREIGN KEY (parentesco_id) REFERENCES items_catalogo(id)
);

-- 7. Antecedentes Clínicos (Relación 1:N)
CREATE TABLE pacientes_antecedentes_clinicos (
    id UUID PRIMARY KEY,
    paciente_id UUID NOT NULL,
    tipo_antecedente_id UUID NOT NULL,
    patologia_id UUID NOT NULL,
    descripcion TEXT,
    fecha_diagnostico DATE,
    tratamiento TEXT,
    esta_activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_ant_paciente FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    CONSTRAINT fk_ant_tipo FOREIGN KEY (tipo_antecedente_id) REFERENCES items_catalogo(id),
    CONSTRAINT fk_ant_patologia FOREIGN KEY (patologia_id) REFERENCES items_catalogo(id)
);