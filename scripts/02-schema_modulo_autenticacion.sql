-- ==========================================================
-- MODULO DE AUTENTICACION
-- ==========================================================

CREATE TABLE usuarios (
    id UUID PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    empleado_id UUID NOT NULL,
    token_verificacion VARCHAR(255),
    token_recuperacion VARCHAR(255),
    fecha_expiracion_recuperacion TIMESTAMP WITHOUT TIME ZONE,
    esta_activo BOOLEAN DEFAULT TRUE,
    esta_verificado BOOLEAN DEFAULT FALSE,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_usuario_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id)
);

CREATE TABLE usuario_rol (
    usuario_id UUID NOT NULL,
    rol_id UUID NOT NULL,
    PRIMARY KEY (usuario_id, rol_id),
    CONSTRAINT fk_rel_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    CONSTRAINT fk_rel_rol FOREIGN KEY (rol_id) REFERENCES roles(id)
);

CREATE TABLE refresh_tokens (
    id UUID PRIMARY KEY,
    token VARCHAR(255) NOT NULL UNIQUE,
    expiry_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    usuario_id UUID UNIQUE,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_token_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- 3. Módulo de Catálogos
CREATE TABLE catalogos (
    id UUID PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    tipo VARCHAR(50) NOT NULL, -- 'SISTEMA' o 'MEDICO'
    esta_activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE
);

CREATE TABLE items_catalogo (
    id UUID PRIMARY KEY,
    catalogo_id UUID NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    codigo VARCHAR(50),
    valor TEXT,
    esta_activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT fk_item_catalogo FOREIGN KEY (catalogo_id) REFERENCES catalogos(id)
);