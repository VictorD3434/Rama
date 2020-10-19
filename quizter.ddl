-- Generado por Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   en:        2020-10-06 17:56:25 CDT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE catalogo_contacto (
    id           INTEGER NOT NULL,
    descripcion  VARCHAR2(128 BYTE) NOT NULL
);

COMMENT ON COLUMN catalogo_contacto.descripcion IS
    'TELEFONO RESIDENCIAL
TELEFONO TRABAJO
TELEFONO CELULAR
EMAIL
FACEBOOK
TWITTER
INSTAGRAM
URL';

ALTER TABLE catalogo_contacto ADD CONSTRAINT catalogo_contacto_pk PRIMARY KEY ( id );

CREATE TABLE catalogo_contactov1 (
    id           INTEGER NOT NULL,
    descripcion  VARCHAR2(128 BYTE) NOT NULL
);

COMMENT ON COLUMN catalogo_contactov1.descripcion IS
    'TELEFONO RESIDENCIAL
TELEFONO TRABAJO
TELEFONO CELULAR
EMAIL
FACEBOOK
TWITTER
INSTAGRAM
URL';

ALTER TABLE catalogo_contactov1 ADD CONSTRAINT catalogo_contactov1_pk PRIMARY KEY ( id );

CREATE TABLE dcontacto (
    contacto              VARCHAR2(256 CHAR) NOT NULL,
    estatus               CHAR(1 BYTE) NOT NULL,
    fecha_actualizacion   DATE NOT NULL,
    catalogo_contacto_id  INTEGER NOT NULL,
    users_id              INTEGER NOT NULL
);

COMMENT ON COLUMN dcontacto.contacto IS
    'Este datos puede ser email, telefono, ruta de facebook, twitter, instagram, etc.';

COMMENT ON COLUMN dcontacto.estatus IS
    'A-Actual
C-Cancelado
L-Anterior';

CREATE TABLE domicilio (
    calle                VARCHAR2(256) NOT NULL,
    numero               VARCHAR2(64 BYTE),
    numero_int           VARCHAR2(64 BYTE),
    colonia              VARCHAR2(256 CHAR),
    mpio                 VARCHAR2(256 CHAR),
    cp                   CHAR(5 BYTE),
    estado               VARCHAR2(128 CHAR),
    estatus              CHAR 
--  WARNING: CHAR size not specified 
    ,
    fecha_actualizacion  DATE,
    users_id             INTEGER NOT NULL
);

COMMENT ON COLUMN domicilio.estatus IS
    'A-actual
C-cancelado
D-descontinuado';

CREATE TABLE evaluaciones (
    id                        INTEGER,
    respuesta                 INTEGER NOT NULL,
    fecha_aplicaion           DATE NOT NULL,
    fecha_evaluacion          DATE,
    respuestas_id_respuestas  INTEGER NOT NULL,
    preguntas_id              INTEGER NOT NULL,
    inciso                    CHAR(1 BYTE),
    examen_id                 INTEGER NOT NULL
);

COMMENT ON COLUMN evaluaciones.inciso IS
    'a
b
c
d';

CREATE TABLE examen (
    id                     INTEGER NOT NULL,
    fecha_aplicacion       DATE NOT NULL,
    tiempo_limite          INTEGER,
    fecha_hora_iniciio     DATE,
    fecha_hora_fin         DATE,
    fecha_vigencia_inicio  DATE NOT NULL,
    fecha_vigencia_fin     DATE,
    resultado              NUMBER(4, 2),
    estatus                CHAR(1 BYTE) NOT NULL,
    users_id2              INTEGER NOT NULL,
    users_id               INTEGER NOT NULL
);

COMMENT ON COLUMN examen.estatus IS
    'A-ACTIVO
T-TERMINADO
C-CANCELADO';

ALTER TABLE examen ADD CONSTRAINT examen_pk PRIMARY KEY ( id );

CREATE TABLE modulos (
    id           INTEGER NOT NULL,
    descripcion  VARCHAR2(128 BYTE)
);

ALTER TABLE modulos ADD CONSTRAINT modulos_pk PRIMARY KEY ( id );

CREATE TABLE preguntas (
    id                   INTEGER NOT NULL,
    pregunta             VARCHAR2(512 CHAR) NOT NULL,
    tipo_respuesta       INTEGER NOT NULL,
    estatus              CHAR 
--  WARNING: CHAR size not specified 
     NOT NULL,
    fecha_actualizacion  DATE,
    tema_id              INTEGER NOT NULL,
    users_id             INTEGER NOT NULL
);

COMMENT ON COLUMN preguntas.tipo_respuesta IS
    '1- Una opcion
2- dos  opcion
3.-3 opciones';

COMMENT ON COLUMN preguntas.estatus IS
    'A-Activa
C-Cancelada';

ALTER TABLE preguntas ADD CONSTRAINT preguntas_pk PRIMARY KEY ( id );

CREATE TABLE privilegios (
    estatus              CHAR(1),
    fecha_actualizacion  DATE NOT NULL,
    users_id             INTEGER NOT NULL,
    roles_id             INTEGER NOT NULL,
    modulos_id           INTEGER NOT NULL
);

COMMENT ON COLUMN privilegios.estatus IS
    '	A-ACTIVO
	C-REVOCADO';

CREATE TABLE relation_contcato_usuarios (
    catalogo_contactov1_id  INTEGER NOT NULL,
    usuariosv1_id           INTEGER NOT NULL
);

ALTER TABLE relation_contcato_usuarios ADD CONSTRAINT relation_contcato_usuarios_pk PRIMARY KEY ( catalogo_contactov1_id,
                                                                                                  usuariosv1_id );

CREATE TABLE respuestas (
    opcion               VARCHAR2(512 CHAR),
    tipo_opcion          CHAR(1 BYTE),
    estatus              CHAR(1 BYTE),
    fecha_actualizacion  DATE NOT NULL,
    preguntas_id         INTEGER NOT NULL,
    id_respuestas        INTEGER NOT NULL
);

COMMENT ON COLUMN respuestas.tipo_opcion IS
    'C-Correcta
I-Incorrecta';

COMMENT ON COLUMN respuestas.estatus IS
    'A- activa
C-Cancelada';

ALTER TABLE respuestas ADD CONSTRAINT respuestas_pk PRIMARY KEY ( id_respuestas );

CREATE TABLE roles (
    id           INTEGER NOT NULL,
    descripcion  VARCHAR2(128 BYTE) NOT NULL
);

ALTER TABLE roles ADD CONSTRAINT roles_pk PRIMARY KEY ( id );

CREATE TABLE tema (
    id    INTEGER NOT NULL,
    tema  VARCHAR2(256 CHAR) NOT NULL
);

ALTER TABLE tema ADD CONSTRAINT tema_pk PRIMARY KEY ( id );

CREATE TABLE users (
    id      INTEGER NOT NULL,
    nombre  VARCHAR2(128 CHAR) NOT NULL,
    app     VARCHAR2(128 CHAR),
    apm     VARCHAR2(128 CHAR),
    rfc     CHAR(13 BYTE),
    curp    CHAR(18 BYTE)
);

ALTER TABLE users ADD CONSTRAINT users_pk PRIMARY KEY ( id );

CREATE TABLE usuariosv1 (
    id      INTEGER NOT NULL,
    nombre  VARCHAR2(128 CHAR) NOT NULL,
    app     VARCHAR2(128 CHAR),
    apm     VARCHAR2(128 CHAR),
    rfc     CHAR(13 BYTE),
    curp    CHAR(18 BYTE)
);

ALTER TABLE usuariosv1 ADD CONSTRAINT usuariosv1_pk PRIMARY KEY ( id );

ALTER TABLE dcontacto
    ADD CONSTRAINT dcontacto_catalogo_contacto_fk FOREIGN KEY ( catalogo_contacto_id )
        REFERENCES catalogo_contacto ( id );

ALTER TABLE dcontacto
    ADD CONSTRAINT dcontacto_users_fk FOREIGN KEY ( users_id )
        REFERENCES users ( id );

ALTER TABLE domicilio
    ADD CONSTRAINT domicilio_users_fk FOREIGN KEY ( users_id )
        REFERENCES users ( id );

ALTER TABLE evaluaciones
    ADD CONSTRAINT evaluaciones_examen_fk FOREIGN KEY ( examen_id )
        REFERENCES examen ( id );

ALTER TABLE evaluaciones
    ADD CONSTRAINT evaluaciones_preguntas_fk FOREIGN KEY ( preguntas_id )
        REFERENCES preguntas ( id );

ALTER TABLE evaluaciones
    ADD CONSTRAINT evaluaciones_respuestas_fk FOREIGN KEY ( respuestas_id_respuestas )
        REFERENCES respuestas ( id_respuestas );

ALTER TABLE examen
    ADD CONSTRAINT examen_users_fk FOREIGN KEY ( users_id )
        REFERENCES users ( id );

ALTER TABLE examen
    ADD CONSTRAINT examen_users_fkv1 FOREIGN KEY ( users_id2 )
        REFERENCES users ( id );

ALTER TABLE preguntas
    ADD CONSTRAINT preguntas_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );

ALTER TABLE preguntas
    ADD CONSTRAINT preguntas_users_fk FOREIGN KEY ( users_id )
        REFERENCES users ( id );

ALTER TABLE privilegios
    ADD CONSTRAINT privilegios_modulos_fk FOREIGN KEY ( modulos_id )
        REFERENCES modulos ( id );

ALTER TABLE privilegios
    ADD CONSTRAINT privilegios_roles_fk FOREIGN KEY ( roles_id )
        REFERENCES roles ( id );

ALTER TABLE privilegios
    ADD CONSTRAINT privilegios_users_fk FOREIGN KEY ( users_id )
        REFERENCES users ( id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE relation_contcato_usuarios
    ADD CONSTRAINT relation_contcato_usuarios_catalogo_contactov1_fk FOREIGN KEY ( catalogo_contactov1_id )
        REFERENCES catalogo_contactov1 ( id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE relation_contcato_usuarios
    ADD CONSTRAINT relation_contcato_usuarios_usuariosv1_fk FOREIGN KEY ( usuariosv1_id )
        REFERENCES usuariosv1 ( id );

ALTER TABLE respuestas
    ADD CONSTRAINT respuestas_preguntas_fk FOREIGN KEY ( preguntas_id )
        REFERENCES preguntas ( id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             0
-- ALTER TABLE                             27
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   2
-- WARNINGS                                 2
