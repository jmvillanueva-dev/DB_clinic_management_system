-- ==========================================================
-- MODULO DE CATALOGOS
-- ==========================================================

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