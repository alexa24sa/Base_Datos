-- SE CREA LA BASE DE DATOS DESDE ESTE PUNTO

-- SE CREA LA BASE DE DATOS DESDE ESTE PUNTO
DROP DATABASE IF EXISTS pagecanalonce;
CREATE DATABASE pagecanalonce
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE pagecanalonce;

-- CREACIÓN DE LAS TABLAS PARA CADA UNO DE LOS DATOS QUE SE ALMACENARÁN EN LA BASE
CREATE TABLE seccion (
  idSeccion CHAR(6) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  PRIMARY KEY (idSeccion)
);

CREATE TABLE categoria
(
  idCategoria CHAR(5) NOT NULL,
  nombre VARCHAR(60) NOT NULL,
  PRIMARY KEY (idCategoria)
);

CREATE TABLE clasificacion
(
  idClasificacion CHAR(5) NOT NULL,
  nombreNivel VARCHAR(5) NOT NULL,
  HorarioPreferente VARCHAR(80) NOT NULL,
  descripcion VARCHAR(110) NOT NULL,
  PRIMARY KEY (idClasificacion)
);

CREATE TABLE conductores
(
  idConductor CHAR(7) NOT NULL, -- quitar not null si es necesario
  nombre VARCHAR(60) NOT NULL,
  PRIMARY KEY (idConductor)
);

CREATE TABLE pais
(
  idPais CHAR(5) NOT NULL,
  nombre VARCHAR(60) NOT NULL,
  PRIMARY KEY (idPais)
);

CREATE TABLE region
(
  idRegion CHAR(5) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  idPais CHAR(5) NOT NULL,
  PRIMARY KEY (idRegion),
  FOREIGN KEY (idPais) REFERENCES pais(idPais) ON DELETE CASCADE ON UPDATE CASCADE
);
 -- el codigo anterior agregó primero pais, region y despues distribuidor ojo
CREATE TABLE distribuidor_distintivo
(
  idDistintivo CHAR(5) NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  plataforma VARCHAR(15) NOT NULL,
  PRIMARY KEY (idDistintivo)
);

CREATE TABLE podcast
(
  idPodcast CHAR(5) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(800) NOT NULL,
  idCategoria CHAR(5) NOT NULL,
  PRIMARY KEY (idPodcast),
  FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE blogs
(
  idBlog CHAR(5) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(800) NOT NULL,
  idCategoria CHAR(5) NOT NULL,
  PRIMARY KEY (idBlog),
  FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE fecha
(
  idFecha CHAR(6) NOT NULL,
  fecha DATE NOT NULL,
  PRIMARY KEY (idFecha)
);
-- el anterior codigo aqui agregó distribuidorRegion
CREATE TABLE distribuidorRegion
(
  idRegion CHAR(5) NOT NULL,
  idDistintivo CHAR(5) NOT NULL,
  PRIMARY KEY (idRegion, idDistintivo),
  FOREIGN KEY (idRegion) REFERENCES region(idRegion) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idDistintivo) REFERENCES distribuidor_distintivo(idDistintivo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE seccionBlog (
  idSeccion CHAR(5) NOT NULL,
  idBlog CHAR(5) NOT NULL,
  PRIMARY KEY (idSeccion, idBlog),
  FOREIGN KEY (idSeccion) REFERENCES seccion(idSeccion) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idBlog) REFERENCES blogs(idBlog) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE seccionPodcast (
  idSeccion CHAR(5) NOT NULL,
  idPodcast CHAR(5) NOT NULL,
  PRIMARY KEY (idPodcast, idSeccion), -- Corregido aquí: Nombre de la columna idSeccion sin tilde
  FOREIGN KEY (idPodcast) REFERENCES podcast(idPodcast) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idSeccion) REFERENCES seccion(idSeccion) ON DELETE CASCADE ON UPDATE CASCADE -- Corregido aquí: Nombre de la columna idSeccion sin tilde
);

CREATE TABLE programas
(
  idPrograma CHAR(5),
  nombre VARCHAR(80) NOT NULL,
  descripcion VARCHAR(1000) NOT NULL,
  idClasificacion CHAR(5),
  idCategoria CHAR(5) NOT NULL,
  PRIMARY KEY (idPrograma),
  FOREIGN KEY (idClasificacion) REFERENCES clasificacion(idClasificacion) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE horarioNacional
(
  idHorarioN CHAR(6) NOT NULL,
  hora_Inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  idPrograma CHAR(5),
  idFecha CHAR(6),
  idPais CHAR(5) NOT NULL,
  PRIMARY KEY (idHorarioN),
  FOREIGN KEY (idPrograma) REFERENCES programas(idPrograma) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idFecha) REFERENCES fecha(idFecha) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE horarioInternacional
(
  idHorarioI CHAR(6) NOT NULL,
  hora_Inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  idPrograma CHAR(5),
  idFecha CHAR(6),
  idPais CHAR(5) NOT NULL,
  PRIMARY KEY (idHorarioI),
  FOREIGN KEY (idFecha) REFERENCES fecha(idFecha) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idPrograma) REFERENCES programas(idPrograma) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE programaPais
(
  idPrograma CHAR(5),
  idPais CHAR(5) NOT NULL,
  PRIMARY KEY (idPrograma, idPais),
  FOREIGN KEY (idPrograma) REFERENCES programas(idPrograma) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idPais) REFERENCES pais(idPais) ON DELETE CASCADE ON UPDATE CASCADE
);
-- el codigo anterior agrega primer el programaPais
CREATE TABLE programaConductores (
  idPrograma CHAR(5),
  idConductor CHAR(7), -- Cambiar el tipo de datos a CHAR(7)
  PRIMARY KEY (idConductor, idPrograma),
  FOREIGN KEY (idConductor) REFERENCES conductores(idConductor) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idPrograma) REFERENCES programas(idPrograma) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE seccionProgramas (
  idPrograma CHAR(5),
  idSeccion char(6) NOT NULL,
  PRIMARY KEY (idPrograma, idSeccion),
  FOREIGN KEY (idPrograma) REFERENCES programas(idPrograma) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idSeccion) REFERENCES seccion(idSeccion) ON DELETE CASCADE ON UPDATE CASCADE
);

-- APARTADO PARA LA INSERCIÓN DE DATOS DENTRO DE LAS TABLAS (IMPORTANTE SEGUIR EL MISMO ORDEN DE DECLARACIÓN DE LAS TABLAS).
INSERT INTO seccion (idSeccion, nombre)
VALUES  
  ('S001', 'Once +'),
  ('S002', 'Once Noticias'),
  ('S003', 'Once Niños y Niñas'),
  ('S004', 'Once Mexico'),
  ('S005', 'Once Digital');
 
        select * from seccion;

INSERT INTO categoria (idCategoria, nombre)
VALUES  
  ('C01', 'Cocina'),
  ('C02', 'Cultura'),
  ('C03', 'Digital'),
  ('C04', 'Conversación'),
  ('C05', 'Deporte'),
  ('C06', 'Entretenimiento'), 
  ('C07', 'Historia'),
  ('C08', 'Música'),
  ('C09', 'Niñas y Niños'),
  ('C10', 'Información e Investigación'),
  ('C11', 'Naturaleza'),
  ('C12', 'Opinión'),
  ('C13', 'Programas Politécnicos'),
  ('C14', 'Sociedad'), 
  ('C15', 'Series');

select * from categoria;

INSERT INTO clasificacion (idClasificacion, nombreNivel, horarioPreferente, descripcion)
VALUES 
  ('CL001', 'AA', 'Cualquier horario', 'Todos los públicos son aptos de ver la programación; comprensible para menores de 7 años' ),
  ('CL002', 'A', 'Cualquier horario', 'Todos los públicos son aptos para ver la programación'),
  ('CL003', 'B', 'A partir de las 16 y hasta las 5 horas', 'Programación para mayores de 12 años, menores requieren supervisión.'),
  ('CL004', 'B-15', 'A partir de las 21 horas', 'Programación para mayores de 15 años, menores requieren supervisión.'),
  ('CL005', 'C', 'A partir de las 22 horas', 'Programación para mayores de 18 años'),
  ('CL006', 'D', 'A partir de la medianoche', 'Programación exclusivamente para adultos');
       select * from clasificacion;
       
INSERT INTO conductores (idConductor, nombre)
VALUES  
    ('CON1', 'Óscar Uriel Macías Mora'), 
    ('CON2', 'Pablo L. Morán'), 
    ('CON3', 'Andi Martín del Campp'), 
    ('CON4', 'Hector Trejo'),
    ('CON5', 'Jaime Gama'),
    ('CON6', 'Jerry Velezquez'),
    ('CON7', 'Victoria Islas'),
    ('CON8', 'Julia Didriksson'),
    ('CON9', 'Nancy Mejía'),
    ('CON10', 'Ana Grimaldo'),
    ('CON11', 'Gracia Alzaga'),
    ('CON12', 'Miguel Conde'),
    ('CON13', 'Heriberto Javier Murrieta Cantú'),
    ('CON14', 'Ezra Alcázar'),
    ('CON15', 'Alejandro García Moreno'),
    ('CON16', 'Rafael Guadarrama'),
    ('CON17', 'Alejandro García Moreno'),
    ('CON18', 'Lucía Vazquez Corona'),
    ('CON19', 'Amanda Drag'),
    ('CON20', 'Paco Ignacio Taibo II'),
    ('CON21', 'Norma Márquez'),
    ('CON22', 'Andrés Ruiz'),
    ('CON23', 'Guadalupe Contreras'),
    ('CON24', 'Anahí Vázquez'),
    ('CON25', 'Citlaly López'),
    ('CON26', 'José Bandera'),
    ('CON27', 'Cristina Jáuregui'),
    ('CON28', 'Natalia Jiménez '),
    ('CON29', 'Eduardo Valenzuela'),
    ('CON30', 'Leticia Carbajal'),
    ('CON31', 'Azucena Celis'),
    ('CON32', 'Diana Laura Gómez'),
    ('CON33', 'Daniel Herrera'),
    ('CON34', 'Nacho Mendéz'),
    ('CON35', 'Rodrigo de la Cadena'),
    ('CON36', 'Luhana Gardi'),
    ('CON37', 'Gabriela Tinajero'),
    ('CON38', 'Fernando Rivera Calderón'),
    ('CON39', 'Nora Huerta'),
    ('CON40', 'Jairo Calixto Albarrán'),
    ('CON41', 'Ana María Lomeli'),
    ('CON42', 'Alejandra Ley'),
    ('CON43', 'Cecilia Gallardo'),
    ('CON44', 'Joao Henrique'),
    ('CON45', 'Sabina Berman'),
    ('CON46', 'Zohar Salgado Álvarez'),
    ('CON47', 'Erick Tejeda'),
    ('CON48', 'Beatriz Pereyra'),
    ('CON49', 'Miguel Conde'),
    ('CON50', 'Bruno Bichir'),
    ('CON51', 'Daniel Giménez Cacho'),
    ('CON52', 'Noé Hernández'),
    ('CON53', 'Joaquín Cosio'),
    ('CON54', 'Eduardo Victoria'),
    ('CON55', 'Patricia Bernal'),
    ('CON56', 'Karina Gidi'),
    ('CON57', 'Pablo San Román'),
    ('CON58', 'Graciela Montaño'),
    ('CON59', 'Yuri de Gortari'),
    ('CON60', 'Gerardo Vázquez Lugo'),
    ('CON61', 'León Aguirre'),
    ('CON62', 'Lucero Soto'),
    ('CON63', 'Pepe Salinas'),
    ('CON64', 'Lucero Soto'),
    ('CON65', 'Marco Rascón'),
    ('CON66', 'Enrique Olvera'),
    ('CON67', 'Phillippe Ollé Laprune'),
    ('CON68', 'Susana Harp'),
    ('CON69', 'Alejandra Robles'),
    ('CON70', 'César González Madruga'),
    ('CON71', 'Heriberto Murrieta'),
    ('CON72', 'Rafael Cué'),
    ('CON73', 'Rodrigo Castaño Valencia'),
    ('CON74', 'Carlos Pascual'),
    ('CON75', 'Mónica Lavín'),
    ('CON76', 'Adriana Morales'),
    ('CON77', 'Jazmín Cato Sosa'),
    ('CON78', 'Itzel Aguilar Mora'),
    ('CON79', 'Vania R. Belmont'),
    ('CON80', 'Eduardo Valenzuela'),
    ('CON81', 'Ophelia Pastrana'),
    ('CON82', 'Alessandra Santamaría'),
    ('CON83', 'Rodrigo Garcia'),
    ('CON84', 'Patricio Córdova'),
    ('CON85', 'Cristina Pachecho'),
    ('CON86', 'Guadalupe Contreras'),
    ('CON87', 'Rubén Álvarez Mendiola'),
    ('CON88', 'Marta de la Lama'),
    ('CON89', 'Guadalupe Loaeza'),
    ('CON90', 'Javier Solórzano'),
    ('CON91', 'Catalina Noriega'),
    ('CON92', 'Pilar Ferreira'),
    ('CON93', 'Javier Trejo Garay'),
    ('CON94', 'Diana Laura Gómez'),
    ('CON95', 'Gustavo Torrero'),
    ('CON96', 'Alfonso Lanzagorta'),
    ('CON97', 'Beatriz Pereyra'),
    ('CON98', 'Verónica Toussaint '),
    ('CON99', 'Adriana Bautista'),
    ('CON100', 'Caly Minero'),
    ('CON101', 'Laura Santín'),
    ('CON102', 'Aldo Sánchez Vera'),
    ('CON103', 'Alejandro Schenini'),
    ('CON104', 'Joss Waleska'),
    ('CON105', 'Alfredo Dominguez Muro'),
    ('CON106', 'Rodrigo Mendoza'),
    ('CON107', 'Marcela Pezet'),
    ('CON108', 'Tamara de Anda'),
    ('CON109', 'Jean-Christophe Berjon'),
    ('CON110', 'Alejandra López'),
    ('CON111', 'Jocelyn Chávez'),
    ('CON112', 'Abel Ponce'),
    ('CON113', 'Julio César Hernández'),
    ('CON114', 'Joaquín Alva'),
    ('CON115', 'Luis Gerardo Méndez'),
    ('CON116', 'Bernardo Barranco'),
    ('CON117', 'Sofía Álvarez'),
    ('CON118', 'Margarita  Vesquez Montaño '),
    ('CON119', 'Ángeles González Gamio'),
    ('CON120', 'Maria Elena Cantú'),
    ('CON121', 'Mauricio Isaac'),
    ('CON122', 'José Crriedo'),
    ('CON123', 'Eugenia León'),
    ('CON124', 'Pavel Granados'),
    ('CON125', 'Alexia Ávila'),
    ('CON126', 'Ausencio Cruz'),
    ('CON127', 'Davis Filio'),
    ('CON128', 'Sergio Félix'),
    ('CON129', 'Aldo Sánchez Vera'),
    ('CON130', 'Edgar Barroso'),
    ('CON131', 'Jorge Saldaña'),
    ('CON132', 'Alejandra Moreno'),
    ('CON133', 'Alonso Ruizpalacios'),
    ('CON134', 'Aldo Sánchez Vera'),
    ('CON135', 'Fabián Garza'),
    ('CON136', 'Micaela Gramajo'),
    ('CON137', 'Ricardo Zárraga'),
    ('CON138', 'Luisa Garibay'),
    ('CON139', 'Ahichell Sánchez'),
    ('CON140', 'Mirelle Romo de Vivar'),
    ('CON141', 'Alfredo Farias'),
    ('CON142', 'Neyzer Constantino'),
    ('CON143', 'Yair Prado'),
    ('CON144', 'Alejandro Lago'),
    ('CON145', 'Omar Esquinca'),
    ('CON146', 'José Luis Arévalo'),
    ('CON147', 'Xareny Orzal'),
    ('CON148', 'Giuliana Vega'),
    ('CON149', 'Aarón Herández Farfán'),
    ('CON150', 'Ulises David'),
    ('CON151', 'Alejandra Rodríguez'),
    ('CON152', 'Iván González'),
    ('CON153', 'Sofía Luna'),
    ('CON154', 'Max Espejel Hernández'),
    ('CON155', 'Esther Oldak'),
    ('CON156', 'Rocío Brauer'),
    ('CON157', 'Khristina Giles'),
    ('CON158', 'Magali Boyselle Hernández'),
    ('CON159', 'Manuel Lazcano'),
    ('CON160', 'Javier Solórzano'),
    ('CON161', 'Alejandro García Moreno'),
    ('CON162', 'Fisgón-Rapé-Hernández'),
    ('CON163', 'Guadalupe Contreras'),
    ('CON164', 'Margarita González Gamio'),
    ('CON165', 'Jorge del Villar'),
    ('CON166', 'José Buendía Hegewisch'),
    ('CON167', 'Kimberly Armengol'),
    ('CON168', 'Ezra Shabot Askenazi'),
    ('CON169', 'John Ackerman'),
    ('CON170', 'Sergio Aguayo'),
    ('CON171', 'María Amparo Casar'),
    ('CON172', 'José Antonio Crespo'),
    ('CON173', 'Leonardo Curzio'),
    ('CON174', 'Lorenzo Meyer'),
    ('CON175', 'Francisco Paoli Bolio'),
    ('CON176', 'Bernardo Barranco'),
    ('CON177', 'Gibrán Ramírez Reyes'),
    ('CON178', 'Estefanía Veloz'),
    ('CON179', 'Danger AK'),
    ('CON180', 'Alejandro García Moreno'),
    ('CON181', 'Ricardo Raphael'),
    ('CON182', 'Sandra Arguelles'),
    ('CON183', 'Estela Livera'),
    ('CON184', 'Patricia Kelly'),
    ('CON185', 'Carlos Bolado'),
    ('CON186', 'Valentina Sierra'),
    ('CON187', 'Fernando Bonilla'),
    ('CON188', 'Luis Lesher'),
    ('CON189', 'Mario Luis Fuentes Alcalá'),
    ('CON190', 'Mariana Lapuente Flores'),
    ('CON191', 'Carmen Muñoz'),
    ('CON192', 'María Roiz'),
    ('CON193', 'Jorge del Villar'),
    ('CON194', 'Fernanda Tapia'),
    ('CON195', 'Axel Escalante'),
    ('CON196', 'Zandra Zittle'),
    ('CON197', 'Leticia Carbajal'),
    ('CON198', 'Elvira Angélica Rivera');

        select * from conductores;

INSERT INTO pais (idPais, nombre)
VALUES ('PA01', 'Estados Unidos'),
	   ('PA02', 'México');
       
       select * from pais;

INSERT INTO region (idRegion, nombre, idPais)
VALUES 
    ('R001', 'Alabama', 'PA01'),
    ('R002', 'Alaska', 'PA01'),
    ('R003', 'Arizona', 'PA01'),
    ('R004', 'Arkansas', 'PA01'),
    ('R005', 'California', 'PA01'),
    ('R006', 'Colorado', 'PA01'),
    ('R007', 'Connecticut', 'PA01'),
    ('R008', 'Delaware', 'PA01'),
    ('R009', 'District of Columbia', 'PA01'),
    ('R010', 'Florida', 'PA01'),
    ('R011', 'Georgia', 'PA01'),
    ('R012', 'Hawai', 'PA01'),
    ('R013', 'Idaho', 'PA01'),
    ('R014', 'Illinois', 'PA01'),
    ('R015', 'Indiana', 'PA01'),
    ('R016', 'Kansas', 'PA01'),
    ('R017', 'Kentucky', 'PA01'),
    ('R018', 'Lousiana', 'PA01'),
    ('R019', 'Maine', 'PA01'),
    ('R020', 'Maryland', 'PA01'),
    ('R021', 'Massachusetts', 'PA01'),
    ('R022', 'Michigan', 'PA01'),
    ('R023', 'Minnesota', 'PA01'),
    ('R024', 'Mississipi', 'PA01'),
    ('R025', 'Missouri', 'PA01'),
    ('R026', 'Montana', 'PA01'),
    ('R027', 'Nebraska', 'PA01'),
    ('R028', 'Nevada', 'PA01'),
    ('R029', 'New Hampshire', 'PA01'),
    ('R030', 'New Jersey', 'PA01'),
    ('R031', 'New York', 'PA01'),
    ('R032', 'North Carolina', 'PA01'),
    ('R033', 'Nuevo México', 'PA01'),
    ('R034', 'Ohio', 'PA01'),
    ('R035', 'Oklahoma', 'PA01'),
    ('R036', 'Oregon', 'PA01'),
    ('R037', 'Pennsylvania', 'PA01'),
    ('R038', 'Puerto Rico', 'PA01'),
    ('R039', 'República Dominicana', 'PA01'),
    ('R040', 'South Carolina', 'PA01'),
    ('R041', 'Tennessee', 'PA01'),
    ('R042', 'Texas', 'PA01'),
    ('R043', 'United States', 'PA01'),
    ('R044', 'Utah', 'PA01'),
    ('R045', 'Vermont', 'PA01'),
    ('R046', 'Virginia', 'PA01'),
    ('R047', 'Washington', 'PA01'),
    ('R048', 'West Virginia', 'PA01'),
    ('R049', 'Wisconsin', 'PA01'),
    ('R050', 'Wyoming', 'PA01'),
    ('R051', 'Aguascalientes, Aguascalientes', 'PA02'),
    ('R052', 'Campeche, Campeche', 'PA02'),
    ('R053', 'Cancún, Quintana Roo', 'PA02'),
    ('R054', 'Celaya, Guanajuato', 'PA02'),
    ('R055', 'Chetumal, Quintana Roo', 'PA02'),
    ('R056', 'Chihuahua, Chihuahua', 'PA02'),
    ('R057', 'Ciudad de México', 'PA02'),
    ('R058', 'Ciudad Obregón, Sonora', 'PA02'),
    ('R059', 'Coatzacoalcos, Veracruz', 'PA02'),
    ('R060', 'Colima, Colima', 'PA02'),
    ('R061', 'Culiacán, Sinaloa', 'PA02'),
    ('R062', 'Durango, Durango', 'PA02'),
    ('R063', 'Gómez Palacio, Durango', 'PA02'),
    ('R064', 'Guadalajara, Jalisco', 'PA02'),
    ('R065', 'Hermosillo, Sonora', 'PA02'),
    ('R066', 'León, Guanajuato', 'PA02'),
    ('R067', 'Los Mochis, Sinaloa', 'PA02'),
    ('R068', 'Mazatlán, Sinaloa', 'PA02'),
    ('R069', 'Mérida, Yucatán', 'PA02'),
    ('R070', 'Monterrey, Nuevo León', 'PA02'),
    ('R071', 'Morelia, Michoacán', 'PA02'),
    ('R072', 'Oaxaca, Oaxaca', 'PA02'),
    ('R073', 'Cozumel, Quintana Roo', 'PA02'),
    ('R074', 'Puebla, Puebla', 'PA02'),
    ('R075', 'Querétaro, Querétaro', 'PA02'),
    ('R076', 'Saltillo, Coahuila', 'PA02'),
    ('R077', 'San Cristóbal de las Casas, Chiapas', 'PA02'),
    ('R078', 'San Luis Potosí, S.L.P.', 'PA02'),
    ('R079', 'Tapachula, Chiapas', 'PA02'),
    ('R080', 'Tijuana, Baja California', 'PA02'),
    ('R081', 'Toluca, Estado de México', 'PA02'),
    ('R082', 'Cuernavaca, Morelos', 'PA02'),
    ('R083', 'Tuxtla Gutiérrez, Chiapas', 'PA02'),
    ('R084', 'Uruapan, Michoacán', 'PA02'),
    ('R085', 'Valle de Bravo, Edo. de México', 'PA02'),
    ('R086', 'Villahermosa, Tabasco', 'PA02'),
    ('R087', 'Xalapa, Veracruz', 'PA02'),
    ('R088', 'Zacatecas, Zacatecas', 'PA02'),
    ('R089', 'Monterrey, Nuevo Leon', 'PA02');
       select * from region;


INSERT INTO distribuidor_distintivo (idDistintivo, nombre, plataforma) 
VALUES ('D01', 'XEIPN-TDT', 'TV abierta'),
       ('D02', 'XHTJB-TDT', 'TV abierta'),
       ('D03', 'XHCPES-TDT', 'TV abierta'),
       ('D04', 'XHCHI-TDT', 'TV abierta'),
       ('D05', 'XHCHU-TDT', 'TV abierta'),
       ('D06', 'XHCHD-TDT', 'TV abierta'),
       ('D07', 'XHSCE-TDT', 'TV abierta'),
       ('D08', 'XHDGO-TDT', 'TV abierta'),
       ('D09', 'XHGPD-TDT', 'TV abierta'),
       ('D10', 'XHPBGD-TDT', 'TV abierta'),
       ('D11', 'XHVBM-TDT', 'TV abierta'),
       ('D12', 'XHCIP-TDT', 'TV abierta'),
       ('D13', 'XHPBMY-TDT', 'TV abierta'),
       ('D14', 'XHCPBS-TDT', 'TV abierta'),
       ('D15', 'XHCPAN-TDT', 'TV abierta'),
       ('D16', 'XHCPAC-TDT', 'TV abierta'),
       ('D17', 'XHPBCN-TDT', 'TV abierta'),
       ('D18', 'XHSLP-TDT', 'TV abierta'),
       ('D19', 'XHSIN-TDT', 'TV abierta'),
       ('D20', 'XHSPRAG-TDT', 'TV abierta'),
       ('D21', 'XHSPRCC-TDT', 'TV abierta'),
       ('D22', 'XHSPRSC-TDT', 'TV abierta'),
       ('D23', 'XHSPRTP-TDT', 'TV abierta'),
       ('D24', 'XHSPRTC-TDT', 'TV abierta'),
       ('D25', 'XHSPRCO-TDT', 'TV abierta'),
       ('D26', 'XHSPRCE-TDT', 'TV abierta'),
       ('D27', 'XHSPRLA-TDT', 'TV abierta'),
       ('D28', 'XHSPREM-TDT', 'TV abierta'),
       ('D29', 'XHSPRMO-TDT', 'TV abierta'),
       ('D30', 'XHSPRUM-TDT', 'TV abierta'),
       ('D31', 'XHSPROA-TDT', 'TV abierta'),
       ('D32', 'XHSPRMQ-TDT', 'TV abierta'),
       ('D33', 'XHSPRMS-TDT', 'TV abierta'),
       ('D34', 'XHSPROS-TDT', 'TV abierta'),
       ('D35', 'XHSPRHA-TDT', 'TV abierta'),
       ('D36', 'XHSPRVT-TDT', 'TV abierta'),
       ('D37', 'XHSPRTA-TDT', 'TV abierta'),
       ('D38', 'XHSPRCA-TDT', 'TV abierta'),
       ('D39', 'XHSPRXA-TDT', 'TV abierta'),
       ('D40', 'XHSPRME-TDT', 'TV abierta'),
       ('D41', 'XHSPRZC-TDT', 'TV abierta'),
       ('D42', 'XHCOZ-TDT', 'TV abierta'),
       ('D43', 'DIRECTV', 'DTH'),
       ('D44', 'XFINITY', 'CABLE'),
       ('D45', 'SLING', 'OTT'),
       ('D46', 'CHARTER SPECTRUM', 'CABLE'),
       ('D47', 'FRONTIER', 'CABLE'),
       ('D48', 'WAVE', 'CABLE'),
       ('D49', 'GRANDE COMMUNICATIONS', 'CABLE'),
       ('D50', 'AT&T', 'CABLE'),
       ('D51', 'VERIZON', 'INTERNET'),
       ('D52', 'XHPBMY-TDT', 'TV abierta'),
       ('D53', 'XHPBGD-TDT', 'TV abierta'),
       ('D54', 'XHSIM-TDT', 'TV abierta');

        select * from distribuidor_distintivo;

INSERT INTO podcast (idPodcast, nombre, descripcion, idCategoria)
VALUES ('PO01', 'Acción Artística', 'En México hay muchas propuestas creativas, y El Once les da visibilidad en esta serie de cápsulas, 
             en las cuales documentamos diversos procesos artísticos a través de los cuales descubrimos no sólo su carácter diferenciador,
             sino también que el arte se encuentra en donde menos se espera. Desde su propia área de trabajo, 
             observamos cómo fluyen los procesos creativos mientras el artista nos cuenta su historia y experiencia. 
             El resultado, aunque casi siempre personal, fortalece la confianza colectiva y redefine los espacios, para habitarlos desde
             otro punto de vista.', 'C03'),
       ('PO02', 'Cultura a Voces', 'Desde el principio de los tiempos la cultura se comparte de voz en voz. Acompáñanos por este recorrido en donde 
             contaremos la historia de personas, lugares y objetos que forman parte de la cultura mexicana.', 'C03'),
       ('PO03', 'Estación Global', 'La comunidad internacional suele tener problemáticas complejas y difíciles de entender. A lo largo de 10 capítulos,
             explicaremos y discutiremos cómo afectan a las y los ciudadanos de nuestro país.','C14'),
       ('PO04', 'Pop 11.0', 'Once Digital ofrece una visión diferente de la cultura pop. Relacionamos los acontecimientos icónicos del mundo del espectáculo
             con la realidad mexicana.', 'C03'),
       ('PO05', 'Innovación Politécnica', 'Las y los investigadores e ingenieros del Instituto Politécnico Nacional han creado innovaciones que nos benefician día con día. 
             En Innovación Politécnica, expondremos la historia y el legado de los proyectos más destacados que se han desarrollado en esta gran institución mexicana. 
             La Técnica al Servicio de la Patria.', 'C13'),
       ('PO06', 'Échale Piquete', 'Échale Piquete es una producción digital en la que abordamos la historia, la cultura y los lugares que orbitan alrededor de las bebidas más
             emblemáticas que se producen en México. A lo largo de cinco episodios, nos acercamos al proceso de producción y a la importancia social, económica y cultural
             de estas bebidas en nuestro país, de la mano de quienes las han hecho parte de su vida.','C03'),
       ('PO07', 'Inclusión Radical', 'Diversidad e inclusión suelen ser tratados como sinónimos, pero en realidad son complementarios. Durante 10 episodios analizamos 
             las problemáticas en relación con la diversidad, que nos ayudarán a practicar la inclusión en nuestra vida cotidiana.', 'C03'),
       ('PO08', 'D TODO', 'Conoce los espectáculos más impresionantes, las tradiciones y los festejos de diversas regiones, deportes extremos que te pondrán a prueba,
             y atractivas aventuras por aire, mar y tierra en D Todo, donde cualquier cosa puede ocurrir. Elenco: ALEXIA ÁVILA.','C14'),
       ('PO09', 'Sí Somos', 'El Once es la primera televisora pública de México y una de las primeras aliadas de la diversidad y la Inclusión. 
             Consulta los horarios de nuestras producciones y conéctate a los contenidos que tenemos para ti en TV, redes sociales y Once+', 'C03'),
       ('PO10', 'Aprender a Envejecer', 'Aprender a Envejecer, Patricia Kelly e invitados fomentan la cultura del envejecimiento activo y saludable, 
             al tiempo que aportan un nuevo significado a la vejez: el comienzo de una nueva etapa que podemos diseñar para que sea 
             enriquecedora y disfrutable.','C04');

		select * from podcast;


INSERT INTO blogs (idBlog, nombre, descripcion, idCategoria)
VALUES ('B01', 'Espacio Politécnico', 'El Instituto Politécnico Nacional es una institución formativa y de investigación trascendental para la sociedad. 
             Descubre en la programación de El Once el talento de los jóvenes politécnicos, la fortaleza de sus investigadores e investigaciones de punta, 
             sus conciertos de música clásica y popular, y sus eventos educativos y deportivos..', 'C14'),
       ('B02', 'Aprender a Envejecer', 'En "Aprender a Envejecer", Patricia Kelly e invitados fomentan la cultura del envejecimiento activo y saludable, 
             al tiempo que aportan un nuevo significado a la vejez: el comienzo de una nueva etapa que podemos diseñar para que sea enriquecedora y 
             disfrutable.', 'C04'),
       ('B03', 'Dialogos en Confianza', 'Diálogos en Confianza es un espacio en el que se genera información confiable con la cual podemos resolver 
             problemáticas cotidianas en relación a nuestra salud, familia, pareja, desarrollo humano y ámbito social. En este programa te escuchamos
             y crecemos juntos.', 'C04'),
       ('B04', '8M - Dia Internacional de la Mujer', 'En la actualidad sabemos que esta lucha incluye muchas aristas: mujeres líderes y en puestos de poder,
			familias, organizaciones, medios y ciudadanos. La verdadera equidad y justicia no llegarán si la conversación no se extiende en todas las áreas 
            y rincones de México. ¿Te animas a ser parte del cambio?', 'C04'),
       ('B05', 'Día Naranja', 'La Violencia De Género No Solo Se Manifiesta Mediante Una Agresión Física, Existen Acciones Sutiles Que Pasan Desapercibidas 
             Como: El Control Económico Y Social, Aislamiento Familiar Y Social, Humillaciones, Acoso, Intimidación, Amenazas, Etc. Es Por Eso Que En El Once
             Queremos Que La Violencia Silenciosa Haga Ruido. #TambiénEstoEs', 'C12');
             
	   select * from blogs;

INSERT INTO fecha (idFecha, fecha)
VALUES ('F00001', '2023-12-10'),
       ('F00002', '2023-12-11'),
       ('F00003', '2023-12-12'),
       ('F00004', '2023-12-13'),
       ('F00005', '2023-12-14'),
       ('F00006', '2023-12-15'),
       ('F00007', '2023-12-16'),
       ('F00008', '2023-12-17'),
       ('F00009', '2023-12-18'),
       ('F00010', '2023-12-19'),
       ('F00011', '2023-12-20'),
       ('F00012', '2023-12-21'),
       ('F00013', '2023-12-22'),
       ('F00014', '2023-12-23'),
       ('F00015', '2023-12-24'),
       ('F00016', '2023-12-25'),
       ('F00017', '2023-12-26'),
       ('F00018', '2023-12-27'),
       ('F00019', '2023-12-28'),
       ('F00020', '2023-12-29'),
       ('F00021', '2023-12-30'),
       ('F00022', '2023-12-31'),
       ('F00023', '2024-01-01'),
       ('F00024', '2024-01-02'),
       ('F00025', '2024-01-03'),
       ('F00026', '2024-01-04'),
       ('F00027', '2024-01-05'),
       ('F00028', '2024-01-06'),
       ('F00029', '2024-01-07'),
       ('F00030', '2024-01-08'),
       ('F00031', '2024-01-09'),
       ('F00032', '2024-01-10');

	   select * from fecha;
       
INSERT INTO distribuidorRegion (idRegion, idDistintivo) VALUES
    ('R001', 'D46'), -- CHARACTER SPECTRUM - ALABAMA
    ('R001', 'D50'), -- AT&T - ALABAMA
    ('R003', 'D44'), -- XFINITY - ARIZONA
    ('R003', 'D46'), -- CHARACTER SPECTRUM - ARIZONA
    ('R004', 'D44'), -- XFINITY - ARKANSAS
    ('R004', 'D50'), -- AT&T - ARKANSAS
    ('R005', 'D44'), -- XFINITY - CALIFORNIA
    ('R005', 'D46'), -- CHARACTER SPECTRUM - CALIFORNIA
    ('R005', 'D47'), -- FRONTIER - CALIFORNIA
    ('R005', 'D48'), -- WAVE - CALIFORNIA
    ('R005', 'D49'), -- GRANDE COMMUNICATIONS - CALIFORNIA
    ('R005', 'D50'), -- AT&T - CALIFORNIA
    ('R006', 'D44'), -- XFINITY - COLORADO
    ('R006', 'D46'), -- CHARACTER SPECTRUM - COLORADO 
    ('R006', 'D48'), -- WAVE - COLORADO
    ('R007', 'D44'), -- XFINITY - CONNECTICUT
    ('R007', 'D46'), -- CHARACTER SPECTRUM - CONNECTICUT
    ('R007', 'D47'), -- FRONTIER - CONNECTICUT
    ('R008', 'D44'), -- XFINITY - DELAWARE 
    ('R008', 'D50'), -- AT&T - DELAWARE
    ('R009', 'D44'), -- XFINITY - DISTRICT OF COLUMBIA
    ('R010', 'D44'), -- XFINITY - FLORIDA
    ('R010', 'D46'), -- CHARACTER SPECTRUM - FLORIDA
    ('R010', 'D47'), -- FRONTIER - FLORIDA
    ('R010', 'D50'), -- AT&T - FLORIDA
    ('R011', 'D44'), -- XFINITY - GEORGIA
    ('R011', 'D46'), -- CHARACTER SPECTRUM - GEORGIA
    ('R011', 'D50'), -- AT&T - GEORGIA
    ('R012', 'D46'), -- CHARACTER SPECTRUM - HAWAI
    ('R013', 'D46'), -- CHARACTER SPECTRUM - IDAHO
    ('R014', 'D44'), -- XFINITY - ILLINOIS
    ('R014', 'D50'), -- AT&T - ILLINOIS
    ('R015', 'D44'), -- XFINITY - INDIANA
    ('R015', 'D46'), -- CHARACTER SPECTRUM - INDIANA
    ('R015', 'D47'), -- FRONTIER - INDIANA
    ('R015', 'D50'), -- AT&T - INDIANA
    ('R016', 'D44'), -- XFINITY - KANSAS
    ('R016', 'D46'), -- CHARACTER SPECTRUM - KANSAS
    ('R016', 'D50'), -- AT&T - KANSAS
    ('R017', 'D44'), -- XFINITY - KENTUCKY
    ('R017', 'D46'), -- CHRACTER SPECTRUM - KENTUCKY
    ('R017', 'D50'), -- AT&T - KENTUCKY
    ('R018', 'D46'), -- CHARACTER SPECTRUM - LOUSIANA 
    ('R018', 'D50'), -- AT&T - LOUSIANA
    ('R019', 'D44'), -- XFINITY - MAINE
    ('R019', 'D46'), -- CHARACTER SPECTRUM - MAINE
    ('R020', 'D44'), -- XFINITY - MARYLAND
    ('R021', 'D44'), -- XFINITY - MASSACHUSETTS
    ('R021', 'D46'), -- CHARACTER SPECTRUM - MASSACHUSETTS
    ('R021', 'D48'), -- WAVE - MASSACHUSETTS
    ('R022', 'D44'), -- XFINITY - MICHIGAN
    ('R022', 'D46'), -- CHARACTER SPECTRUM - MICHIGAN
    ('R022', 'D50'), -- AT&T - MICHIGAN
    ('R023', 'D44'), -- XFINITY - MINNESOTA 
    ('R023', 'D46'), -- CHARACTER SPECTRUM - MINNESOTA
    ('R023', 'D47'), -- FRONTIER - MINNESOTA
    ('R024', 'D50'), -- AT&T - MISSISSIPI 
    ('R025', 'D44'), -- XFINITY - MISSOURI
    ('R025', 'D46'), -- CHARACTER SPECTRUM - MISSOURI
    ('R025', 'D50'), -- AT&T - MISSOURI
    ('R026', 'D46'), -- CHARACTER SPECTRUM - MONTANA
    ('R027', 'D46'), -- CHARACTER SPECTRUM - NEBRASKA
    ('R028', 'D46'), -- CHARACTER SPECTRUM - NEVADA
    ('R028', 'D50'), -- AT&T - NEVADA
    ('R029', 'D44'), -- XFINITY - NEW HAMPSHIRE
    ('R029', 'D46'), -- CHARACTER SPECTRUM - NEW HAMPSHIRE
    ('R029', 'D48'), -- WAVE - NEW HAMPSHIRE
    ('R030', 'D44'), -- XFINITY - NEW JERSEY
    ('R030', 'D46'), -- CHARACTER SPECTRUM - NEW JERSEY
    ('R031', 'D44'), -- XFINITY - NEW YORK
    ('R031', 'D46'), -- CHARACTER SPECTRUM - NEW YORK
    ('R031', 'D47'), -- FRONTIER - NEW YORK
    ('R032', 'D44'), -- XFINITY - NORTH CAROLINA
    ('R032', 'D46'), -- CHARACTER SPECTRUM - NORTH CAROLINA
    ('R032', 'D47'), -- FRONTIER - NORTH CAROLINA
    ('R032', 'D50'), -- AT&T - NORTH CAROLINA
    ('R033', 'D44'), -- XFINITY - NUEVO MEXICO
    ('R034', 'D44'), -- XFINITY - OHIO
    ('R034', 'D46'), -- CHARACTER SPECRTUM - OHIO 
    ('R034', 'D50'), -- AT&T - OHIO
    ('R035', 'D50'), -- AT&T - OKLAHOMA 
    ('R036', 'D44'), -- XFINITY - OREGON
    ('R036', 'D48'), -- WAVE -- OREGON
    ('R037', 'D44'), -- XFINITY - PENNSYLVANIA
    ('R037', 'D46'), -- CHARACTER SPECTRUM - PENNSYLVANIA
    ('R038', 'D45'), -- SLING - PUERTO RICO
    ('R039', 'D45'), -- SLING - REPUBLICA DOMINICANA
    ('R040', 'D44'), -- XFINITY - SOUTH CAROLINA
    ('R040', 'D46'), -- CHARACTER SPECTRUM - SOUTH CAROLINA
    ('R040', 'D47'), -- FRONTIER - SOUTH CAROLINA
    ('R040', 'D50'), -- AT&T - SOUTH CAROLINA
    ('R041', 'D44'), -- XININITY - TENNESSEE
    ('R041', 'D46'), -- CHARACTER SPECTRUM - TENNESSEE
    ('R041', 'D50'), -- AT&T - TENNESSEE
    ('R042', 'D44'), -- XFINITY - TEXAS
    ('R042', 'D46'), -- CHARACTER SPECTRUM - TEXAS
    ('R042', 'D47'), -- FRONTIER - TEXAS
    ('R042', 'D49'), -- GRANDE COMMUNICATIONS - TEXAS
    ('R042', 'D50'), -- AT&T - TEXAS
    ('R043', 'D43'), -- DIRECTV - UNITED STATES
    ('R043', 'D45'), -- SLING - UNITED STATES
    ('R043', 'D51'), -- VERIZON - UNITED STATES
    ('R044', 'D44'), -- XFINITY - UTAH 
    ('R044', 'D48'), -- WAVE - UTAH
    ('R045', 'D44'), -- XFINITY - VERMONT
    ('R045', 'D46'), -- CHARACTER SPECTRUM - VERMONT
    ('R046', 'D44'), -- XFINITY - VIRGINIA
    ('R046', 'D46'), -- CHARACTER SPECTRUM - VIRGINIA
    ('R047', 'D44'), -- XFINITY - WASHINGTON
    ('R047', 'D46'), -- CHARACTER SPECTRUM - WASHINGTON
    ('R047', 'D48'), -- WAVE - WASHINGTON
    ('R048', 'D44'), -- XFINITY - WEST VIRGINIA
    ('R049', 'D44'), -- XININITY - WISCONSIN
    ('R049', 'D46'), -- CHARACTER SPECTRUM - WISCONSIN
    ('R049', 'D50'), -- AT&T - WISCONSIN
    ('R050', 'D44'), -- XININITY - WYOMING
    ('R050', 'D46'), -- CHARACTER SPECTRUM - WYOMING
    ('R051', 'D20'), -- 'Aguascalientes, Aguascalientes',
    ('R052', 'D03'), -- 'Campeche, Campeche',
    ('R053', 'D17'), --  'Cancún, Quintana Roo',
    ('R054', 'D26'), -- 'Celaya, Guanajuato',
    ('R089', 'D52'), --  'Monterrey, Nuevo Leon',
    ('R055', 'D17'), -- 'Chetumal, Quintana Roo', 
    ('R056', 'D04'), -- 'Chihuahua, Chihuahua',
    ('R057', 'D01'), -- 'Ciudad de México',
    ('R058', 'D34'), --  'Ciudad Obregón, Sonora',
    ('R059', 'D38'), -- 'Coatzacoalcos, Veracruz',
    ('R060', 'D25'), --  'Colima, Colima',
    ('R061', 'D19'), --  'Culiacán, Sinaloa',
    ('R062', 'D08'), --  'Durango, Durango',
    ('R063', 'D09'), --  'Gómez Palacio, Durango',
    ('R064', 'D53'), --  'Guadalajara, Jalisco',
    ('R065', 'D37'), --  'Hermosillo, Sonora',
    ('R066', 'D27'), --  'León, Guanajuato',
    ('R067', 'D54'), --  'Los Mochis, Sinaloa',
    ('R068', 'D33'), --  'Mazatlán, Sinaloa',
    ('R069', 'D40'), --  'Mérida, Yucatán',
    ('R070', 'D17'), --  'Monterrey, Nuevo León',
    ('R071', 'D29'), -- 'Morelia, Michoacán',
    ('R072', 'D14'), -- 'Oaxaca, Oaxaca',
    ('R073', 'D42'), -- Cozumel, Quintana Roo', 
    ('R074', 'D15'), -- 'Puebla, Puebla',
    ('R075', 'D32'), -- 'Querétaro, Querétaro',
    ('R076', 'D07'), -- 'Saltillo, Coahuila',
    ('R077', 'D22'), -- 'San Cristóbal de las Casas, Chiapas',
    ('R078', 'D18'), -- 'San Luis Potosí, S.L.P.',
    ('R079', 'D23'), -- 'Tapachula, Chiapas',
    ('R080', 'D02'), -- 'Tijuana, Baja California',
    ('R081', 'D28'), -- 'Toluca, Estado de México',
    ('R082', 'D12'), -- 'Tres Cumbres, Morelos',
    ('R083', 'D24'), -- 'Tuxtla Gutiérrez, Chiapas',
    ('R084', 'D30'), -- 'Uruapan, Michoacán',
    ('R085', 'D11'), -- 'Valle de Bravo, Edo. de México',
    ('R086', 'D36'), -- 'Villahermosa, Tabasco',
    ('R087', 'D39'), -- 'Xalapa, Veracruz',
    ('R088', 'D41'); -- 'Zacatecas, Zacatecas'

select * from distribuidorRegion;


INSERT INTO seccionBlog (idSeccion, idBlog)
VALUES ('S001', 'B01'), -- Once + - Espacio Politecnico
	   ('S001', 'B02'), -- Once +  - Aprender a Envejecer
       ('S001', 'B03'), -- Once +  - Dialogos en Confianza
       ('S001', 'B04'), -- Once + - 8M - Dia Internacional de las Mujeres
       ('S001', 'B05'); -- Once + - Dia Naranja

       select * from seccionBlog;

INSERT INTO seccionPodcast (idSeccion, idPodcast)
VALUES ('S005','PO01'), -- Once Digital - Accion Artisitica
       ('S005','PO02'), -- Once Digital - Cultura a Voces
       ('S005','PO03'), -- Once Digital - Estacion Global
       ('S005','PO04'), -- Once Digital - Pop 11.0
       ('S005','PO05'), -- Once Digital - Innovacion Politecnica
       ('S005','PO06'), -- Once Digital - Échale Piquete
       ('S005','PO07'), -- Once Digital - Inclusión Radical
       ('S001','PO08'), -- Once + - D TODO
       ('S001','PO09'), -- Once + - Sí Somos
       ('S001','PO10'); --  Once + - Aprender a Envejecer
       
       select * from seccionPodcast;

INSERT INTO programas (idPrograma, nombre, descripcion, idClasificacion, idCategoria)
VALUES ('P0001', 'La Ruta Del Sabor', 'Explora los secretos mejor guardados de la cocina mexicana en esta aventura culinaria, en la que Miguel Conde nos guía para descubrir el mapa de la gastronomía mexicana, un semillero internacional de sabores, aromas y senderos.', 'CL002', 'C01'),
	   ('P0002', 'La sazón de mi mercado', 'En este espacio semanal se retratan tanto los mercados públicos, como los platillos de la cocina tradicional mexicana, la cual fue reconocida por la UNESCO como Patrimonio Cultural Inmaterial de la Humanidad en el año 2010.', 'CL002', 'C01'),
       ('P0003', 'Yo Sólo Sé Que No He Cenado', 'Bruno Bichir visita diferentes lugares de México con la misión de descubrir los mejores platillos, las historias que hay detrás de ellos, y todos los secretos que los coronan como los más sabrosos. Acompáñalo a disfrutar de manjares en puestos callejeros, restaurantes tradicionales y de vanguardia, cantinas, mercados, merenderos y más. Elenco: Bruno Bichir.', 'CL004', 'C01'),
       ('P0004', 'Bebidas de México', 'En esta serie documental hacemos un recorrido por las bebidas que forman parte del patrimonio cultural y biológico que se mantiene vivo en el país. Junto a grandes actores mexicanos, descubre los secretos de bebidas ancestrales como el pulque; destiladas como el mezcal, el tequila, el bacanora y la raicilla; así como delicias adaptadas al clima y al paladar de los mexicanos, como el vino y la cerveza. Hoy, todos estos productos son parte de nuestra cultura y sus múltiples sabores llegan a todo el mundo.', 'CL004', 'C01'),
       ('P0005', 'Nuestra riqueza, el chile', 'Acompaña a Miguel Conde en este recorrido por La Ruta del Sabor del Chile y únete a la celebración nacional del corazón de los guisos mexicanos y una de nuestras mayores riquezas.', 'CL002', 'C01'),
       ('P0006', 'Del Mundo Al Plato', '¿Dónde tomar un desayuno típico inglés? ¿En qué restaurante se ofrece el auténtico curry? ¿Hay cerveza alemana en nuestra ciudad? ¿Dónde se prepara el mejor kepe charola? El chef Pablo San Román inicia una travesía para descubrir las gastronomías del mundo en la capital de nuestro país y, a través de la cocina, las historias de vida de quienes trajeron sus recetas a nuestra ciudad.', 'CL002', 'C01'),
       ('P0007', 'Tu Cocina', 'Cada temporada, un reconocido chef nos comparte atractivos y prácticos menús preparados con productos locales y de temporada, inspirados en mercados, antiguos recetarios y cocina regional. Este programa es una oportunidad para revalorar la cultura gastronómica de México. Elenco: Gerardo Vázquez Lugo, Graciela Montaño, León Aguirre, Lucero Soto, Lula Chef, Pablo San Román, Pepe Salinas, Yuri de Gortari.','CL001', 'C01'),
       ('P0008', 'Elogio De La Cocina Mexicana', 'En el 2010 la UNESCO declaró a la gastronomía mexicana como Patrimonio Inmaterial de la Humanidad, al ser un elemento esencial de nuestra identidad cultural que hay que proteger, pues se encuentra amenazada por los embates de la globalización. La cocina tradicional de México es una amalgama de lo prehispánico con elementos de otras naciones y épocas, lo que da como resultado platillos y sabores muy mexicanos que implican preparaciones típicas. En este programa recorremos el país para conocer a las personas que mantienen viva nuestra gastronomía, al tiempo que la recrean, protegen, transmiten y transforman.', 'CL001', 'C01'),
       ('P0009', 'En Materia De Pescado', 'Daniel Giménez Cacho y Marco Rascón navegan a través de la gastronomía y diversidad cultural de la Ciudad de México.', 'CL002', 'C01'),
       ('P0010', 'Diario de un Cocinero', 'En "Diarios de un cocinero", Enrique Olvera, uno de los chefs más importantes de México, nos revela cada uno de los elementos que forman parte de su experiencia gastronómica como persona, chef y comensal.', NULL, 'C01'),
       ('P0011', 'Memoria de los Sabores', 'El sentido del gusto es un disparador automático de recuerdos. Los sabores nos evocan a personas, tiempos o situaciones que vuelven a nosotros en un bocado. Esta serie explora las memorias que provocan esos sabores para algunos personajes del medio cultural mexicano.', NULL ,'C01' ),
       ('P0012', 'América. Escritores extranjeros en México', 'Una serie documental fascinante sobre escritores extranjeros que vivieron en México en distintos momentos del siglo XX. En cada episodio, un escritor latinoamericano nos guía en la trayectoria y la estadía del escritor extranjero, con quien ha construido un vínculo creativo y emocional.', NULL,'C02'),
       ('P0013', 'El Mitote Librero', 'Un recorrido literario por los temas y personajes más relevantes en los libros universales, a partir de las versiones y referencias más destacadas, así como sus adaptaciones visuales. Charlas mágicas en la Librería Rosario Castellanos con Paco Ignacio Taibo II, Norma Márquez Cuevas y Andrés Enrique Ruiz González.', 'CL002', 'C01'),
       ('P0014', 'Lenguas en Resistencia', 'Lenguas en Resistencia aborda los idiomas indígenas que han ido poblando el territorio de la Ciudad de México, como el nahua, mazateco, mazahua, otomí, tzeltal, mixteco, triqui, entre otros, para construir una narrativa histórica de la gama lingüística que existe en la capital de nuestro país. Una serie narrada por las y los protagonistas, quienes nos comparten historias sobre su identidad cultural y lingüística, así como los momentos significativos de su vida en la ciudad.', 'CL001', 'C01'),
       ('P0015', 'Diáspora', 'Con una bella fotografía en blanco y negro, Diáspora es una serie documental en la que se narran relatos afromexicanos en voz de sus propios personajes. Conducida por la cantante Susana Harp, se muestra la identidad y diversidad del pueblo afromexicano, su crecimiento en regiones de Coahuila, Guerrero, Veracruz, Oaxaca y Ciudad de México, lo que ha brindado nuevos modelos culturales, formas de vida, rituales, gastronomía y arte, como la música y la danza. Diáspora reconoce, enaltece y da visibilidad a los pueblos y a comunidades afrodescendientes de México, pues su herencia artístico-cultural es esencial para nuestro mestizaje.', NULL, 'C02'),
       ('P0016', 'Afroméxico', 'Afroméxico es una serie dedicada al conocimiento, reconocimiento, respeto y visibilización de la herencia y cultura de las mujeres, los hombres, las niñas y los niños de África trasladados a México. "Afroméxico" celebra cosmovisiones, usos culinarios, bailes, cantos, vestimentas, ceremonias religiosas y medicina tradicional, entre muchas otras prácticas culturales', 'CL001', 'C01'),
       ('P0017', 'Las joyas de Oaxaca', 'Las joyas de Oaxaca, un programa que busca revalorizar la importancia y trascendencia que ha dado el estado de Oaxaca al mundo dentro de la cultura popular, gracias a los artesanos de la región.', 'CL002', 'C02'),
       ('P0018', 'México Renace Sostenible', 'México Renace Sostenible tiene como finalidad promover la actividad turística y los procesos bioculturales de las comunidades de los pueblos mágicos, así como fomentar los valores ancestrales para el renacer humano de México, además de poder transmitir la enorme importancia histórica y sus saberes tradicionales que integra la preservación de recursos naturales.', NULL,'C02'),
       ('P0019', 'Toros, Sol y Sombra', 'Este programa de análisis taurino es conducido por los periodistas Heriberto Murrieta y Rafael Cué, quienes analizan y comentan aspectos diversos que se entretejen alrededor de la fiesta brava.', NULL, 'C02'),
       ('P0020', 'Sensacional De Diseño Mexicano', 'Sensacional de Diseño Mexicano es una serie documental que explora gremios y oficios de la gráfica mexicana. Este vistazo al universo de los creadores de rótulos, imágenes de productos, anuncios y literatura de bolsillo, nos permite conocer sus procesos, técnicas y contextos. Acompáñanos en esta travesía creativa y visual de las tradiciones antiguas y contemporáneas del diseño de México.', 'CL002', 'C02'),
       ('P0021', 'Minigrafías', 'Un breve, pero intenso recorrido en técnica de animación a través de la vida y obra de importantes escritoras y escritores de México.', NULL, 'C02'),
       ('P0022', 'Manos de Artesano', 'Esta serie, dirigida por Rodrigo Castaño Valencia, es ante todo un homenaje a las y los grandes maestros artesanos de México. Cada episodio narra la elaboración de un objeto único y, a la vez, da testimonio de la paciente y minuciosa labor de las y los talentosos maestros que encontramos en distintas regiones del país, pues ellas y ellos son herederos de técnicas ancestrales que se preservan con grandes esfuerzos a través de la práctica, la enseñanza y el perfeccionamiento constante.', 'CL001', 'C02'),
       ('P0023', 'Palabra De Autor', 'El lenguaje y las ideas que habitan el territorio literario enriquecen a todo aquel que lo transita. Este programa del Once introduce a grandes exponentes de la literatura mexicana contemporánea y presenta pláticas con ellos acerca de su obra y sus procesos creativos.', NULL,'C02'),
       ('P0024', 'Artes', 'El Instituto Nacional de Bellas Artes y Literatura (INBAL) y el Once presentan esta serie documental dedicada a la difusión del arte en sus diversas manifestaciones, para conocer a los artistas nacionales y extranjeros, seguir sus procesos creativos y apreciar la gran riqueza cultural de México.', 'CL002', 'C02'),
       ('P0025', 'Letras De La Diplomacia', 'Letras de la Diplomacia es una serie rica en anécdotas y reflexiones en torno al quehacer diplomático y literario de destacados escritores mexicanos. Conoce las trayectorias y los logros de algunos de los máximos representantes de México en el mundo.', NULL, 'C01'),
       ('P0026', 'Moneros', 'Como un reconocimiento a la labor y talento de los ilustradores y caricaturistas, el Once presenta un retrato de las y los moneros mexicanos, quienes con su obra aportan a la sociedad una crítica aguda del acontecer nacional e internacional. A manera de diálogo íntimo, esta serie documental retrata la vida diaria de los moneros, sus inspiraciones, motivaciones, influencias y obstáculos que han sorteado para trazar su camino de vida y, finalmente, poder vivir de sus creaciones.', NULL, 'C02'),
       ('P0027', 'Teatro Estudio', 'Un espacio único de lecturas dramatizadas en televisión a cargo de reconocidas actrices y actores mexicanos. Esta serie ofrece lo mejor de la dramaturgia mexicana clásica y contemporánea que, con obras de grandes autores, nos muestra una cara poco vista del teatro: el guión en la mano de los actores.', NULL, 'C02'),
       ('P0028', 'Artesanos de México: Rutas del arte popular', 'Artesanos de México: Rutas del arte popular es un proyecto documental que busca retratar el trabajo y técnica de los más reconocidos artesanos mexicanos, en un viaje donde conoceremos las expresiones de arte popular en el que los objetos son los personajes principales de nuestra historia y cultura.', NULL,'C02'),
       ('P0029', 'M/Aquí', 'Como una expresión de resistencia ante los obstáculos que se nos van presentando a lo largo de la vida, en M/Aquí Heriberto Murrieta entrevista a celebridades de diversos ámbitos, quienes nos muestran su gran creatividad para superar las dificultades.', NULL, 'C03'),
       ('P0030', 'Once digital investigación', 'Conoce Once digital investigación, el espacio donde nos preguntamos de todo e investigamos sobre nuestra actualidad, historia y cultura desde otro ángulo.', NULL, 'C03'),
       ('P0031', 'De la casa a la casilla', 'La lucha de las mujeres por conseguir el voto fue larga. Conoce los pormenores de este hecho histórico, desde sus inicios hasta la actualidad, con el toque humorístico de cinco standuperas mexicanas: Pamonstruo, Pachis, Paty Bacelis, Ana Tamez y Karo Plascencia.', NULL, 'C03'),
       ('P0032', 'Gradiente', 'La vida está llena de matices. Aunque la historia de cada persona es distinta, siempre hay una sensación, un color o una lucha que nos une. Gradiente es una serie de fotografías animadas, en colaboración con el Centro de la Imagen, dedicada a eso, que, sin importar el tiempo o el espacio, tenemos en común.', NULL,'C03'),
       ('P0033', 'Abraza la diversidad', '#TejiendoMiBandera nos invita a descubrir el amplio entramado de realidades, voces e historias diversas; de contextos, diálogos, acciones, intercambios, preguntas, propuestas y posibles construcciones colectivas, necesariamente marcadas por la interseccionalidad.', 'CL002', 'C03'),
       ('P0034', 'Entre Redes', 'Entre Redes es una producción digital de una sola parada dirigida a las personas jóvenes de México. Un espacio diverso en el que podrán encontrar información relevante para cada aspecto de su vida: identidad; salud sexual, física y emocional; amor; finanzas; vida profesional; familia; tecnología y hasta opciones para turistear.', 'CL004', 'C03'),
       ('P0035', 'Acción Artística', 'En México hay muchas propuestas creativas, y El Once les da visibilidad en esta serie de cápsulas, en las cuales documentamos diversos procesos artísticos a través de los cuales descubrimos no sólo su carácter diferenciador, sino también que el arte se encuentra en donde menos se espera. Desde su propia área de trabajo, observamos cómo fluyen los procesos creativos mientras el artista nos cuenta su historia y experiencia. El resultado, aunque casi siempre personal, fortalece la confianza colectiva y redefine los espacios, para habitarlos desde otro punto de vista.', NULL, 'C03'),
       ('P0036', 'Sí somos', 'Sí somos es un videopodcast 100% digital creado en colaboración con Inmujeres, Radio IPN e IMER, donde hablamos de los temas más importantes de la agenda de las mujeres en México y de la lucha por la igualdad de género.', NULL, 'C03'),
       ('P0037', 'Échale Piquete', 'Échale Piquete es una producción digital en la que abordamos la historia, la cultura y los lugares que orbitan alrededor de las bebidas más emblemáticas que se producen en México. A lo largo de cinco episodios, nos acercamos al proceso de producción y a la importancia social, económica y cultural de estas bebidas en nuestro país, de la mano de quienes las han hecho parte de su vida.', NULL,'C03'),
       ('P0038', '¡Hagamos clic!', 'Hagamos clic es un programa digital sobre salud femenina, en el que hablaremos sin censura sobre temas que son considerados tabú por la sociedad. Buscamos que, con la información adecuada, se rompan estigmas y prejuicios sobre estos temas que nos conciernen a todas y todos.', 'CL005', 'C03'),
       ('P0039', 'Había Una vez… Mexicanas que hicieron historia', 'Acompaña a las mujeres que han marcado la memoria de nuestro país. Conoce las historias de estas heroínas de carne y hueso, quienes tuvieron el valor de levantar la voz para luchar contra las injusticias que existían a su alrededor.', 'CL003', 'C03'),
       ('P0040', 'Cultura a Voces', 'Desde el principio de los tiempos la cultura se comparte de voz en voz. Acompáñanos por este recorrido en donde contaremos la historia de personas, lugares y objetos que forman parte de la cultura mexicana.', 'CL002', 'C03'),
       ('P0041', 'Somos lxs que fueron', 'Somos lxs que fueron cuenta la historia de distintas personas, sucesos y movimientos históricos de la comunidad LGBTTTIQ+ en México, para generar memoria e identidad dentro de un sector históricamente discriminado que está siempre en búsqueda de dignidad y equidad.', 'CL004', 'C03'),
       ('P0042', 'En la Barra', 'La nueva generación de actrices y actores de talento llega a nuestras pantallas. Y nadie mejor que Óscar Uriel para departir y charlar con cada invitada e invitado, a quien se le da la bienvenida como se debe: En La Barra, con una deliciosa bebida personalizada.', NULL,'C03'),
       ('P0043', 'Inclusión Radical', 'Diversidad e inclusión suelen ser tratados como sinónimos, pero en realidad son complementarios. Durante 10 episodios analizamos las problemáticas en relación con la diversidad, que nos ayudarán a practicar la inclusión en nuestra vida cotidiana.', 'CL004', 'C03'),
       ('P0044', 'Innovación Politécnica', 'Las y los investigadores e ingenieros del Instituto Politécnico Nacional han creado innovaciones que nos benefician día con día. En Innovación Politécnica, expondremos la historia y el legado de los proyectos más destacados que se han desarrollado en esta gran institución mexicana. La Técnica al Servicio de la Patria.', 'CL002', 'C03'),
       ('P0045', 'Multipass', 'Multipass es el recorrido de Ophelia Pastrana, mujer transgénero, entusiasta de lo nuevo y lo diverso, para adentrarse en las comunidades más interesantes y comentadas: gamers, cosplayers, trabajores sexuales, emprendedores, entusiastas y disruptores apasionades.', NULL, 'C03'),
       ('P0046', 'Yo, ellas, nosotras', 'A través de la historia de vida de cada una de las mujeres trans que presentamos en esta serie, ponemos en evidencia por qué es importante visibilizarlas, así como su representación, lucha y participación dentro del movimiento feminista.', NULL, 'C03'),
       ('P0047', 'A Tono', 'A Tono es un programa digital de conciertos de corta duración con un enfoque íntimo, dentro de un espacio minimalista y lleno de color. Buscamos promover proyectos mexicanos de diversos estilos que representen la diversidad musical de nuestro país y conectarlos con una audiencia digital.', 'CL002', 'C03'),
       ('P0048', 'Pop 11.0', 'Once Digital ofrece una visión diferente de la cultura pop. Relacionamos los acontecimientos icónicos del mundo del espectáculo con la realidad mexicana.', 'CL002', 'C03'),
       ('P0049', 'Economía en corto', 'Economía en corto es una serie en la que mujeres y hombres jóvenes analizan y debaten sobre temas de interés nacional y sus implicaciones con la economía.', 'CL003', 'C03'),
       ('P0050', 'Más allá de la piel', 'Más allá de la piel: decálogo para entender el racismo en México es un proyecto que reúne a 10 personalidades del cine, la televisión y el activismo que hacen parte de la lucha antirracista en el país. Cada cápsula explicará un punto del decálogo creado por Racismo Mx, el cual explica y evidencia esta problemática a la que se enfrentan las y los mexicanos.', 'CL004', 'C03'),
       ('P0051', 'Conversando con Cristina Pacheco', 'Una de las series más icónicas de México, en la que Cristina Pacheco, extraordinaria periodista y conductora, convierte este don suyo de conversar en un programa de televisión al que acuden célebres personalidades, que con su trabajo y talento han dejado huella en el acontecer de nuestro país.', 'CL002', 'C04'),
       ('P0052', 'En Persona', 'En Persona la conversación fluye cálida y espontánea, y permite que cada personaje se sienta con la confianza de contar más sobre las diversas facetas en las que ha sobresalido. El Once presenta En Persona, un programa con Guadalupe Contreras, quien entrevista a figuras destacadas para conocer más a fondo su trayectoria, los retos a los que se han enfrentado, sus proyectos más importantes y sus planes a futuro.', NULL, 'C04'),
       ('P0053', 'Diálogos en Confianza', 'Diálogos en Confianza es un espacio en el que se genera información confiable con la cual podemos resolver problemáticas cotidianas en relación a nuestra salud, familia, pareja, desarrollo humano y ámbito social. En este programa te escuchamos y crecemos juntos.', 'CL004', 'C04'),
       ('P0054', 'Aprender a envejecer', 'En "Aprender a Envejecer", Patricia Kelly e invitados fomentan la cultura del envejecimiento activo y saludable, al tiempo que aportan un nuevo significado a la vejez: el comienzo de una nueva etapa que podemos diseñar para que sea enriquecedora y disfrutable.', NULL, 'C04'),
       ('P0055', 'Aquí Nos Tocó Vivir', 'La periodista Cristina Pacheco es un ícono en el retrato de los personajes que conforman la cultura y la sociedad mexicana, relatando la cotidianeidad a través de amenas entrevistas que rompen con los formatos rígidos tradicionales. "Aquí nos tocó vivir" es prueba del arduo trabajo que Cristina Pacheco ha desempeñado durante décadas para mostrar el mosaico de voces e imágenes que dan testimonio de las innumerables formas de vida que amalgama nuestro país. Viaja junto con el Once a rincones poco conocidos en busca de las historias más entrañables de estas personalidades. Explora y disfruta de los diferentes relatos y experiencias que conforman nuestro país, en "Aquí nos tocó vivir". Elenco: Cristina Pacheco.', NULL, 'C04'),
       ('P0056', 'Aquí En Corto', 'Aquí en corto explora algunos de los temas de mayor interés para las y los jóvenes de nuestro país. Este programa de opinión, moderado por Rubén Álvarez, consiste en debates de jóvenes de 15 a 23 años, en los que expresan lo que piensan y sienten sobre temas de su interés.', 'CL004', 'C04'),
       ('P0057', 'El Gusto Es Mío', 'El gusto es mío, es un espacio donde Marta de la Lama entrevista y conversa con los más interesantes personajes de la cultura mexicana, desde actores, íconos de la moda, médicos y toda clase de eruditos. Las charlas que componen "El gusto es mío" son simplemente un deleite para la mente. Descubre los relatos personales y profesionales de estos agentes de la historia contemporánea de México, junto a una de las grandes periodistas y conductoras de nuestro país. Elenco: Marta de la Lama', 'CL003', 'C04'),
       ('P0058', 'La Cita', 'La escritora y periodista Guadalupe Loaeza nos invita a una íntima y amena entrevista, donde nos presenta a los personajes más destacados de México en los ámbitos cultural, artístico y político. Conoce la trayectoria profesional y las anécdotas que han marcado a grandes personalidades, quienes en su propia voz nos comparten momentos entrañables de su vida. Disfruta de este recorrido de anécdotas de la mano de Pedro Friedeberg, Marcelo Vargas, Eugenio Aguirre, Michel Rowe, Karine Tinat, Jordi Mariscal, Elena Talavera, Susana Corcuera, Homero Aridjis, Frédéric García y Ricardo Muñoz Zurita, quienes destacan en áreas muy diversas, desde la diplomacia hasta la gastronomía.', 'CL003', 'C04'),
       ('P0059', 'Solórzano 3.0', 'Una revista nocturna -estilo late night y conducida por Javier Solórzano- en la que se abordan de manera ágil y amena diversos temas de actualidad e interés. La interacción con el público se realiza a través de las redes sociales para lograr una conversación y construir un espacio público donde el diálogo y la pluralidad son el eje que guía el programa en la búsqueda de una construcción colectiva de contenidos para lograr un concepto incluyente, crítico, plural e interactivo.', 'CL004', 'C04'),
       ('P0060', 'Entre Mitos y Realidades', 'Un programa conducido por Catalina Noriega y Pilar Ferreira que cuestiona, analiza y desmitifica creencias y comportamientos que están profundamente arraigados en la sociedad. Para ello contrasta puntos de vista basados en hechos y argumentos de los expertos, y, a partir de información seria, precisa y clara, desentraña la verdad sobre temas controvertidos.', NULL, 'C04'),
       ('P0061', 'La historia del tenis en México', 'El tenis mexicano comenzó a finales del siglo XIX, cuando un puñado de jugadores aprendió que victorias y derrotas son esenciales para crecer. Así nacieron nuestras primeras leyendas. Esta serie, narrada por sus propios protagonistas, nos acerca a sus historias, sus hazañas y a las jóvenes promesas.', 'CL001', 'C05'),
       ('P0062', 'Pelotero a la bola', 'Pelotero a la bola presenta todo acerca del apasionante mundo del béisbol, en donde un equipo de especialistas en esta materia deportiva analiza, discute y conversa acerca de los resultados de los partidos de la temporada.', 'CL001', 'C05'),
       ('P0063', 'Yoga', 'Serie de 130 episodios dirigida a mujeres de 30 a 40 años en los que a través de diferentes disciplinas se les invita a realizar las rutinas de ejercicios de manera conjunta con el instructor con el objetivo de mejorar su condición física.Las diferentes disciplinas son: Body Jam, En forma, Yoga, Perfect Shape y Pilates.', 'CL001', 'C05'),
       ('P0064', 'Somos Equipo', 'Esta serie documental nos introduce a los deportes que se practican en equipo. Jugadores y entrenadores explican cómo la colectividad es clave para poder practicar basquetbol, nado sincronizado y otros deportes. Descubre, junto con ellos, la importancia de trabajar en conjunto para crecer y lograr los cometidos.', 'CL001', 'C05'),
       ('P0065', 'Baile Latino', 'Serie de 130 episodios dirigida a mujeres de 30 a 40 años en los que a través de diferentes disciplinas se les invita a realizar las rutinas de ejercicios de manera conjunta con el instructor con el objetivo de mejorar su condición física.Las diferentes disciplinas son: Body Jam, En forma, Yoga, Perfect Shape y Pilates.', 'CL001', 'C05'),
       ('P0066', 'Actívate', 'Este programa del Once te presenta una serie de rutinas de actividad física en la que distintos entrenadores muestran ejercicios que combinan artes marciales mixtas y gimnasia natural que podemos hacer todas y todos. ¡Actívate y mejora tu salud!', 'CL001', 'C05'),
       ('P0067', 'Body Jam', 'Serie de 130 episodios dirigida a mujeres de 30 a 40 años en los que a través de diferentes disciplinas se les invita a realizar las rutinas de ejercicios de manera conjunta con el instructor con el objetivo de mejorar su condición física.Las diferentes disciplinas son: Body Jam, En forma, Yoga, Perfect Shape y Pilates.', 'CL001', 'C05'),
       ('P0068', 'Cápsulas De Deportes', 'Con la ayuda de la ciencia y la cámara lenta, conocerás lo más fascinante de realizar un deporte olímpico.', 'CL001', 'C05'),
       ('P0069', 'Carrera Panamericana', 'En conmemoración de los 30 años de la Carrera Panamericana, este programa del Once captura el recorrido de siete días que automóviles de 1940 a 1972 hacen a más de doscientos kilómetros por hora, a lo largo de la República Mexicana. En 7 episodios, se recopilan anécdotas, vivencias y la transformación de este evento a lo largo de 3 décadas.', 'CL001', 'C05'),
       ('P0070', 'Leyendas Del Deporte Mexicano', 'México tiene una férrea tradición deportiva en todas las disciplinas, y por ello es reconocido fuera de nuestras fronteras. Esta serie del Once muestra esa pasión a través de la mirada y la trayectoria de legendarios atletas nacidos en nuestro país. Este programa del Once se trata de una exploración narrativa y audiovisual de la intensidad que suscita el deporte, a lo largo de trece programas en los que consagrados deportistas mexicanos narrarán de viva voz su carrera, su trayectoria, sus triunfos y sus hazañas.', 'CL001', 'C05'),
       ('P0071', 'Leyendas Del Fútbol Mexicano', 'México tiene una larga tradición futbolística y por ello es reconocido internacionalmente. Esta serie del Once muestra esa pasión por el fútbol a través de la mirada y la trayectoria de futbolistas legendarios nacidos en nuestro país. Tales deportistas emblemáticos y sus experiencias, dentro y fuera de la cancha, conforman Leyendas del Futbol Mexicano.', 'CL001', 'C05'),
       ('P0072', 'En Forma', 'Serie de 130 episodios dirigida a mujeres de 30 a 40 años en los que a través de diferentes disciplinas se les invita a realizar las rutinas de ejercicios de manera conjunta con el instructor con el objetivo de mejorar su condición física.Las diferentes disciplinas son: Body Jam, En forma, Yoga, Perfect Shape y Pilates.', 'CL001', 'C05'),
       ('P0073', 'Los Juegos de la Amistad a 50 Años de Distancia', '50 años: 50 cápsulas. En 2018 se cumplieron 50 años de la realización de los Juegos Olímpicos México 68 y, para celebrarlo, estas cápsulas rememoran esta justa deportiva y nos muestran algunos de los momentos más entrañables e históricos que se vivieron a partir de la emotiva y ovacionada inauguración.', 'CL002', 'C05'),
       ('P0074', 'NED, La Nueva Era del Deporte', 'Joss Waleska conversa con deportistas, atletas de alto rendimiento y especialistas. Juntos analizan el desarrollo actual de los deportes, las nuevas tecnologías y otras posibilidades que permiten mejorar el rendimiento físico, las técnicas y los equipos necesarios para lograr los mejores resultados al practicar un deporte.', 'CL001', 'C05'),
       ('P0075', 'Palco a Debate', 'Este programa del Once trae a la mesa los temas más polémicos del deporte para analizarlos con periodistas, deportistas, directivos, promotores y demás especialistas en el tema. Cada episodio está dedicado a un deporte distinto. Acompáñanos en estos debates sobre este apasionante mundo. Elenco: Alfredo Domínguez Muro.', 'CL001', 'C05'),
       ('P0076', 'Tablero de Ajedrez', 'Desde la antigüedad, el ajedrez ha sido considerado uno de los juegos que más desarrollan el pensamiento estratégico. "Tablero de Ajedrez" es un deleite para los fanáticos del tablero, y a la vez es una excelente introducción a profundidad para quienes no lo conocen o no están tan familiarizados. Desde piezas, partidas y hasta historia y significado, este programa del Once ofrece un amplio y rico panorama del universo del ajedrez.', 'CL001', 'C05'),
       ('P0077', 'Figuras del Deporte Mexicano', 'En la actualidad, México cuenta con jóvenes promesas del deporte en todas las disciplinas, los cuales nos representaron en los Juegos Panamericanos Guadalajara 2011 y los Juegos Olímpicos de Londres 2012. Por eso, nos hemos propuesto mostrar la calidad deportiva actual de nuestro país a través de la mirada y la trayectoria de nuestras jóvenes promesas deportivas.', 'CL001', 'C05'),
       ('P0078', 'Fútbol Americano Liga Intermedia 2020', 'Encuentros deportivos en la temporada 2018 en los que se destaca la participación de los equipos de la categoría intermedia de la ONEFA, el máximo circuito de fútbol americano estudiantil en México.','CL001', 'C05'),
       ('P0079', 'Guinda y Blanco. Historia De Una Pasión', 'Narración histórica del fútbol americano del Instituto Politécnico Nacional como fundamento de la identidad politécnica.', 'CL001', 'C05'),
       ('P0080', 'Todos a Bordo', 'En este programa caben todos los oficios y las profesiones hechas con empeño, cariño y compromiso. A través de emotivas entrevistas, esta serie del Once nos presenta las historias de quienes ejercen variadas ocupaciones en México, algunas de ellas con una larga tradición y otras con innovadoras propuestas, todas indispensables para el bienestar común.', 'CL001', 'C05'),
       ('P0081', 'Itinerario', 'En una ciudad tan rica en propuestas culturales como lo es la nuestra, "Itinerario" es todo un imprescindible. Esta revista de TV es un recuento de la actualidad cultural de México y sus variadas expresiones. Los programas son ante todo un guiño de ojo: se trata de que cada uno de nosotros haga sus itinerarios a la carta, para lo cual -semana a semana- se comentan las múltiples posibilidades de elección. Lugares, personajes y eventos que integran tanto la oferta permanente, como la cartelera cultural de la Ciudad de México y otras localidades del país. No te pierdas todo lo relativo a museos, libros, cine, música, artes escénicas, recorridos gastronómicos, rincones secretos y mucho más...', 'CL002', 'C05'),
       ('P0082', 'El Ojo Detrás de la Lente, Cinefotógrafos de México', 'La mirada artística de los cinefotógrafos se plasma en cada una de sus creaciones, y en ellas se revelan imágenes de profunda belleza que exaltan la obra cinematográfica. Cuatro cinefotógrafos Carlos Hidalgo, Kenji Katori, Carlos Marcovich y Damián García hablan de su trabajo. Conoce sus proyectos, estilos, trayectorias y técnicas con el Once.', 'CL001', 'C05'),
       ('P0083', 'Mi Cine, Tu Cine', 'Mi cine, tu cine es un espacio de interacción y reflexión en torno a la cartelera cinematográfica, donde un especialista, tres jóvenes críticos y un invitado comparten su opinión sobre la oferta de películas en el cine. Elenco: Jean-Christophe Berjon', 'CL002', 'C05'),
       ('P0084', 'T.A.P.: Taller de Actores Profesionales', 'Óscar Uriel conversa con actrices y actores mexicanos, de distintos perfiles y generaciones, para charlar sobre sus experiencias en la industria del teatro, el cine y la televisión.', 'CL003', 'C05'),
       ('P0085', 'Viaje Todo Incluyente', 'Esta serie está dedicada a todas las personas que viven con una discapacidad. Alejandra, Jocelyn, Abel, Julio César y Joaquín son cinco jóvenes viajeros y aventureros con discapacidad. Juntos, realizan viajes por distintos destinos nacionales. Acompáñalos y maravíllate con los paisajes y las aventuras que nos muestran, mientras nos dejan ver cómo los prejuicios sociales y la infraestructura excluyente son realmente los impedimentos más grandes a los que se enfrentan en sus travesías.', 'CL004', 'C05'),
       ('P0086', '¿Quién Dijo Yo?', 'Quién dijo yo?" es un programa de humor en el que a través de improvisaciones, los actores representan diferentes situaciones presionados por un conductor que les impone condiciones y tiempo, dando como resultado ingeniosos sketches.', 'CL003', 'C05'),
       ('P0087', 'Cristianos en armas', 'Bernardo Barranco conduce esta nueva serie documental, en la que especialistas invitados recuerdan y analizan a fondo momentos clave en la historia de México, en los cuales integrantes de la Iglesia Católica han intervenido con ideología y acción armada.', 'CL005', 'C06'),
       ('P0088', 'Historia del pueblo mexicano', 'Desde la resistencia indígena al siglo XX, la historia de México ha sido forjada en la lucha por conquistar derechos. En esta serie documental se muestra el trabajo de numerosísimas generaciones que nos heredaron el país que hoy habitamos. Una obra colectiva que nos corresponde continuar.', NULL, 'C06'),
       ('P0089', 'De puño y letra', 'De puño y letra rescata el valor del correo postal, de la escritura sin pantallas y las relaciones epistolares. Cobijada por la Quinta Casa de Correos, nuestro hermoso Palacio Postal, Sofía Álvarez nos guía en un recorrido por las cartas que cambiaron el rumbo de la historia de México.', 'CL002', 'C06'),
       ('P0090', 'Perspectivas históricas', 'Un espacio dirigido por especialistas historiadores para el análisis y la reflexión de las problemáticas actuales desde la perspectiva histórica, en el que se abordan temas como El cambio de régimen; Las raíces del racismo en México; Prensa de oposición y libertad de expresión, entre otros.', 'CL004', 'C06'),
       ('P0091', 'Crónicas Y Relatos De México A Dos Voces', 'Serie documental conducida por la cronista del Centro Histórico de la Ciudad de México, Ángeles González Gamio quien departe amena y espontáneamente, cada emisión con un invitado diferente, anécdotas relacionadas con la transformación, restauración y cambios acontecidos al paso del tiempo de la arquitectura, diseño, cultura y tradiciones de México.', 'CL003', 'C06'),
       ('P0092', '6 Grados de Separación', 'Una persona o hecho puede estar conectado a otro que, por más lejano que parezca, dista sólo 6 niveles de intermediación. Esta serie animada nos muestra expresiones culturales y tradiciones mexicanas que evolucionaron a partir de un origen tan interesante como lejano gracias a estos famosos 6 grados de separación.', 'CL001', 'C06'), -- caricatura ONCE NIÑOS
       ('P0093', 'Arquitectura del Poder', 'Las civilizaciones se reconocen a través de sus logros arquitectónicos. Una de sus expresiones más relevantes en el ámbito público es la arquitectura parlamentaria. ¿Se podría hablar de una "arquitectura del poder"? Recorre con nosotros los inmuebles que dan muestra de ello.', 'CL002', 'C06'),
       ('P0094', 'Los Que Llegaron', 'Esta serie documental del Once aborda la vida de quienes, durante los últimos dos siglos, llegaron para quedarse y perfilar así el rostro de México. "Los que llegaron" relata la historia de los inmigrantes cuya riqueza cultural ha contribuido en la conformación de nuestra identidad nacional.', 'CL002', 'C06'),
       ('P0095', 'La Educación En México', 'La educación tiene un papel preponderante en la formación de una sociedad. Esta serie nos presenta la historia de la educación en México y sus principales personajes, instituciones y acontecimientos. Acompaña al Once en este recorrido sobre las diversas formas de educar en México, desde las culturas prehispánicas hasta nuestros días.', 'CL002', 'C06'), -- educativo ONCE NIÑOS Y ONCE DIGITAL
       ('P0096', 'Voces de la Constitución', 'La promulgación de la Constitución Política de los Estados Unidos Mexicanos fue el resultado de largos e intensos debates en los que participaron jóvenes constituyentes. Esta serie nos propone un juego de imaginación en torno a los debates del Congreso Constituyente de 1917. Conoce a fondo la historia de la Carta Magna y de algunos de sus artículos más relevantes.', 'CL003', 'C06'),
       ('P0097', 'Especiales La Ciudad de México en el Tiempo', 'Seis episodios que a través de sus protagonistas calles, edificios, leyendas, oficios y personajes dan cuenta del pasado y el presente del Centro Histórico de la Ciudad de México, desde Bucareli hasta Circunvalación. Esta serie retrata las ruinas de un imperio y los recuerdos de una urbe que desapareció para que otra naciera, las voces de una metrópoli que cada tarde deja atrás sus antiguos palacios para volver al día siguiente, y espacios que han dejado huella en las viejas postales y se mantienen vivos en todos sus rincones.', 'CL001', 'C06'),
       ('P0098', 'Historias De Vida', 'Semblanza de la vida y trayectoria profesional de consolidados artistas, personajes relevantes y creadores mexicanos en todos los ámbitos, que por su obra son reconocidos más allá de nuestras fronteras.', 'CL002', 'C06'),
       ('P0099', 'Ven acá... con Eugenia León y Pavel Granados', 'Ven acá nos lleva en un viaje de armonías y compases para explorar los diferentes géneros de la música popular, a través de las interpretaciones de Eugenia León, Pavel Granados y sus invitados. Una producción conjunta de la Secretaría de Cultura, el SPR, el Once y Canal 22.', 'CL001', 'C08'),
       ('P0101', 'Emergentes', ' Emergentes es una serie documental en la que se relatan las frustraciones y satisfacciones al emprender un proyecto musical: lo que se vive en el estudio; la relación entre músicos, productores e ingenieros; los sonidos y ritmos que surgen tanto del trabajo colaborativo como de la creatividad artística. Un proceso que muy pocos han vivido, y que pocas veces ha sido documentado.', 'CL003', 'C08'),
       ('P0102', 'Noche, Boleros y Son', 'Noche, Boleros y Son es un programa dedicado a los ritmos latinos más románticos. En cada episodio escucha a grandes exponentes de los géneros del bolero y el son. A través de entrevistas y espectaculares presentaciones, músicos, cantantes, compositores y arreglistas homenajean y mantienen viva la esencia de estos bellos estilos musicales.', NULL, 'C08'),
       ('P0103', 'Contigo', 'Contigo es un programa musical donde el protagonista es la buena música. Teniendo como anfitrión al gran pianista Joao Henrique. En estas emociones las notas musicales y las grandes composiciones nos harán recordar el pasado y vivir la música de hoy y de siempre.', 'CL001', 'C08'),
       ('P0104', 'Conciertos OSIPN', 'Esta serie de conciertos compila extraordinarias colaboraciones de distintas naturalezas con la Orquesta Sinfónica del Instituto Politécnico Nacional, con el fin de propiciar y expandir acercamientos integrales a la música y las artes.', 'CL001', 'C08'),
       ('P0105', 'Concurso Nacional De Estudiantinas: La Serie', 'El objetivo del Concurso Nacional de Estudiantinas es retomar y promover entre la juventud las raíces de la estudiantina, una tradición musical propia de los jóvenes estudiantes. Este concurso es un encuentro que coloca a la música de tuna como parte importante de la cultura nacional.', 'CL001', 'C08'),
       ('P0106', 'Bandas en Construcción', 'Serie dedicada a la difusión de la música independiente en México. A través de entrevistas con bandas emergentes y una sesión musical, conoce las nuevas propuestas del rock nacional.', 'CL001', 'C08'),
       ('P0107', 'Ninguna Como Mi Tuna', 'La tuna, también conocida popularmente como la estudiantina, es una tradición musical de gran arraigo cultural en nuestro país. Esta serie recopila presentaciones musicales de distintos ensambles para un disfrute en familia. Con la conducción de Alexia Ávila y Ausencio Cruz, este programa tiene el objetivo de difundir entre las y los jóvenes los valores de hermandad, respeto y disciplina, que promueven las estudiantinas.', 'CL001', 'C08'),
       ('P0108', 'Foro Once', 'Para quienes buscan entretenimiento inteligente, Foro Once es el espacio del Once dedicado al espectáculo de calidad en todas sus posibilidades, donde por igual disfrutamos la pasión por el flamenco que por sones, marimbas y danzones.', 'CL001', 'C08'),
       ('P0109', 'El Timpano', 'El Tímpano te ofrece pláticas sinceras y veladas con música en vivo. Acompaña a David Filio, Sergio Félix e invitados en este programa, donde la música y una buena charla bohemia son los protagonistas, gracias a los diversos talentos que comparten su diario vivir en el arte.', 'CL001', 'C08'),
       ('P0110', 'Acústicos Central Once', 'Los "Acústicos Central Once", en el Museo Universitario del Chopo, presentan en cada edición una propuesta de diversos géneros musicales en versión acústica, utilizando diferentes tipos de instrumentos, electroacústicos, con resonancia y arreglos musicales especiales. Cuentan con la participación de público en vivo en el foro del dinosaurio y una entrevista en la que conocemos más del proyecto musical.', 'CL001', 'C08'),
       ('P0111', 'La Central', 'Conciertos acústicos desde el Museo del Chopo con bandas reconocidas y de la escena independiente.', 'CL001', 'C08'),
       ('P0112', 'Musivolución', 'La música es parte esencial de nosotros, es el pulso de nuestras emociones. ¿Cuál es la relación de la música con el humano? Acompaña a Edgar Barroso a descifrar esta pregunta. Este programa del Once presenta entrevistas a especialistas para conocer los orígenes de la música, así como los lazos que unen su práctica con aspectos del desarrollo y el conocimiento humano. La música es la banda sonora de la evolución humana. ¡Descúbrela en "Musivolución"!', 'CL001', 'C08'),
       ('P0113', 'Añoranzas', 'Jorge Saldaña e invitados hacen un recuento musical y anecdótico de épocas pasadas, en especial de lo sucedido hace más de tres décadas y con un tema de conversación particular en cada emisión. Vuelve a disfrutar algunos de los años más memorables de la vida musical de nuestro país con este relato de vivencias.', NULL, 'C08'),
       ('P0114', 'Rock En Contacto', 'Rock en Contacto DF es un concurso para encontrar a la mejor banda de rock de la Ciudad de México. De un casting público, se eligieron sólo a 12 bandas, que a lo largo de la temporada competirán por convertirse en la mejor. Al final, tres bandas tocarán en vivo y el público escogerá a la ganadora. ¡Elige a tu favorita!', 'CL003', 'C08'),
       ('P0115', 'Especiales Musicales de Central Once', 'Especiales Musicales de Central Once son documentales de algunas de las bandas nacionales más entrañables, en donde aprenderás de la historia de la agrupación a través de entrevistas y disfrutarás de una presentación en vivo en el Foro de D del Once.', 'CL001', 'C08'),
       ('P0116', 'Especial Sonoro 2013', 'Un documental que nos introduce en el evento "Sonoro 2013": un encuentro académico y artístico dirigido a músicos de alto nivel desde la ciudad de Cuernavaca, Morelos. Los temas se centran en la experiencia de Jazmín Torres (clarinete), Daniel Rodríguez (oboe), Nabani Aguilar (violín) y Alejandra Roni (contrabajo), cuatro jóvenes que participaron de las clases magistrales, encuentros culturales y conciertos en distintas locaciones del estado, durante doce días de actividades.', 'CL001', 'C08'),
       ('P0117', 'Big Band Fest En El Lunario', 'Big Band Fest compila un exquisito repertorio de las grandes bandas de jazz en México. Una serie de presentaciones realizadas en el Lunario te deleitarán con lo mejor de los clásicos y éxitos del género, además de arreglos de música mexicana en estilo jazz.', 'CL001', 'C08'),
       ('P0118', 'El Show de los Once', 'Dos chistes son mejor que uno, ¡y ni se diga de once al mismo tiempo! Conoce El Show de los Once y prepárate para reír.', 'CL001', 'C09'),
       ('P0119', 'Trillizas de colores', 'Estas trillizas son inseparables porque además de ser hermanas adoptivas son las mejores amigas. ¡Conócelas!', 'CL001', 'C09'),
       ('P0120', 'Pie rojo', 'Alex es el único gorila rojo que existe, por eso el Dr. Pietroff quiere conocer todo acerca de él. ¡Únete a su búsqueda!', 'CL001', 'C09'),
       ('P0121', 'De viaje por un libro', 'Las historias de los libros nos hacen reflexionar acerca de las cosas que nos pasan, comparte lo que piensas con nosotros. ', 'CL001', 'C09'),
       ('P0122', 'Las viejas cintas de Staff', '¡Las viejas cintas de Staff están llenas de recetas deliciosas!', 'CL001', 'C09'),
       ('P0123', 'Las nuevas cintas de Staff', 'Staff está de regreso en la cocina para compartirte deliciosas y nutritivas recetas, conócelas y come como campeón y campeona', 'CL001', 'C09'),
       ('P0124', 'Los reportajes de ONN', 'Con micrófono en mano y cámara lista, el equipo ONN tiene para ti reportajes de distintos temas. Te recomendamos verlos todos.', 'CL001', 'C09'),
       ('P0125', 'T-Reto', 'Dos equipos de niñas y niños compiten por lograr retos relacionados a experimentos científicos.', 'CL001', 'C09'),
       ('P0126', 'Intelige', 'Programa de concurso de cultura general, ciencia, ingeniería, tecnología, arte y matemáticas, donde los integrantes de cada equipo se enfrentan en una sana competencia por demostrar sus conocimientos y habilidades. La diversión, el respeto, el trabajo en equipo y las experiencias de vida, son indispensables en este programa para lograr su desarrollo y éxito.', 'CL001', 'C09'),
       ('P0127', 'Galería Once Niñas y Niños', 'Observa las obras de arte que son parte de la Galería de #OnceNiñasyNiños y descubre las texturas, colores y técnicas de dibujo que los artistas usaron en cada una de sus creaciones.', 'CL001', 'C09'),
       ('P0128', 'Ahorrando Ando', 'Isa y Jonás son los protagonistas de este programa, juntos descubren datos interesantes acerca del dinero, de ahorrar y de ser responsables al gastarlo. ¡Descubre nuevas formas de ver el dinero!', 'CL001', 'C09'),
       ('P0129', 'Ek', 'Ek es un simpático perro negro, que tiene un gato al que llama Filete y que quiere mucho. A Ek le gusta investigar y compartir lo que sabe y aprende, como el cuidado de los animales, los derechos de las niñas y los niños, el medio ambiente, entre otros.', 'CL001', 'C09'),
       ('P0130', 'Libros En Acción', 'A Dana le encanta descubrir las historias que se viven en los libros y, junto con un grupo entusiasta de niñas y niños, charla de manera entretenida y breve con algunas escritoras y escritores.', 'CL001', 'C09'),
       ('P0131', 'El Diván de Valentina', 'Valentina es una niña que, a través de sus experiencias cotidianas, reflexiona y se enfrenta a la aventura de crecer: aprender a conocerse y a tomar decisiones, hacer nuevos amigos, enfrentar problemas... Así, Valentina cada día aprende lo que significa vivir, reír y hasta llorar en familia.', 'CL001', 'C09'),
       ('P0132', 'Preguntas del planeta con Lucy', 'Lucy y Camila harán todo por responder tus dudas e inquietudes de la naturaleza y el medio ambiente.', 'CL001', 'C09'),
       ('P0133', 'Verdadero o falso', 'Verfal es un dragón muy curioso que ha vivido muchos años y gracias a su conocimiento del mundo puede descifrar grandes enigmas.', 'CL001', 'C09'),
       ('P0134', '¿Cómo? con Mo', 'Mo es curiosa y quiere conocer cómo funcionan y se hacen las cosas, su comida favorita, juguetes y ropa, ¡acompáñala!', 'CL001', 'C09'),
       ('P0135', '¿Qué pasaría si…?', 'El equipo de Once Niñas y Niños juegan a imaginar qué pasaría si algo fuera de lo común ocurriera, ¡diviértete con su ingenio!', 'CL001', 'C09'),
       ('P0136', 'Un Día en... ON', 'Alan, Lucy y Staff tienen divertidas aventuras, anécdotas e historias que compartir. Conoce más sobre lo que les gusta hacer y disfruta con ellos de increíbles y entretenidos momentos.', 'CL001', 'C09'),
       ('P0137', 'Abuelos', 'Las y los abuelos son la memoria familiar. Por su autenticidad, su perspectiva se liga a las cosas y momentos más valiosos de la vida. Ellos atesoran valiosos recuerdos y anécdotas que conforman la trama multicolor de una familia. En este programa las niñas y niños de México nos cuentan todo sobre sus abuelos.', 'CL001', 'C09'),
       ('P0138', 'Canciones Once Niñas y Niños', 'Alan, Lucy, Staff y todo el equipo de Once Niñas y Niños te invitan a disfrutar a lo grande de todas sus canciones y bailes. Así que... ¡a mover el cuerpo para divertirnos!', 'CL001', 'C09'),
       ('P0139', 'Código – L', 'Déjate sorprender por la tecnología y conoce los inventos más interesantes que han cambiado al mundo.', 'CL001', 'C09'),
       ('P0140', 'Kipatla LSM', 'En este pueblo, todos son como quieren ser y eso es lo que hace único a este lugar que tal vez te resulte familiar.', 'CL001', 'C09'),
       ('P0141', 'Sofía Luna, Agente Especial', 'Incursiona en el universo de una agente científica muy especial: Sofía Luna. Ella es una estudiante universitaria de Física y su mejor amigo es Pato, su hermano de 8 años que la acompaña por todas partes para descubrir que la ciencia está presente en nuestra cotidianidad, en cada rincón. Cabe destacar que esta serie contó con la colaboración y asesoría de la doctora Julieta Fierro, una de las máximas autoridades mundiales en la materia.', 'CL001', 'C09'),
       ('P0142', 'Alcánzame Si Puedes', 'Dos equipos de 4 participantes cada uno, compiten en un campamento para demostrar destreza física e ingenio. Tendrán que ganar dos de tres retos, y estos serán una mezcla de trabajo en equipo, estrategia y resistencia física. También habrá actividades al aire libre, acuáticas y de deporte extremo. El equipo ganador obtendrá una pulsera que representa una habilidad calificada durante ese capítulo. Al término de la aventura, el equipo que haya reunido el mayor número de pulseras será el ganador.', 'CL001', 'C09'),
       ('P0143', 'Arte Al Rescate', 'Arte al Rescate escoge un caso que una niña o un niño manda al Once y que necesita de la cooperación de todo el equipo para ser resuelto. En conjunto, el equipo utilizará todas sus habilidades creativas y ayudará a crear el proyecto artístico para alguien que desesperadamente lo necesita. El equipo lo conforman un artista joven que funge como conductor, 5 niños y un artista invitado. ¡Tienen sólo 3 días para lograr su obra!', 'CL001', 'C09'),
       ('P0144', 'De Compras', 'De Compras fomenta el consumo inteligente y responsable en los más pequeños de la casa. En este programa, un grupo de niños reflexionan, de manera lúdica e interactiva, sobre el precio y la calidad de algunos de los productos de nuestra vida cotidiana. ¡Analiza, compara y aprende acerca del valor de las cosas en DeC!', 'CL001', 'C09'),
       ('P0145', 'DIZI', 'Dizi, una niña con voz de flauta, se embarca en aventuras para descubrir, a través de sus sentidos, nuevas cosas sobre la música. En cápsulas de un minuto, este programa animado de apreciación musical nivel preescolar presenta elementos formales, instrumentos musicales, géneros y más.', 'CL001', 'C09'),
       ('P0146', 'Secretos culinarios de Staff', 'Acompaña a Staff a conseguir los ingredientes que necesita para preparar sus platillos favoritos.', 'CL001', 'C09'),
       ('P0147', 'DXT', 'A las niñas y niños que aquí figuran les encanta correr, saltar y estirar cada parte de su cuerpo. ¡Descubre qué es lo que más les gusta sobre su deporte favorito!', 'CL001', 'C09'),
       ('P0148', 'Las Piezas del Rompecabezas', 'Yola tiene ocho años y descubre un nuevo significado del amor al lado de Rodrigo, su pequeño y especial hermano. Yola nos hará reflexionar sobre la importancia de educar a los niños en el espíritu de la No Discriminación.', 'CL001', 'C09'),
       ('P0149', 'Mi Lugar', 'Un espacio que retrata la vida de niñas y niños de diversas regiones de México. Desde Tijuana hasta San Cristóbal de las Casas, tendremos maravillosos testimonios de los espacios, juegos y amigos de diferentes niñas y niños en todo el país.', 'CL001', 'C09'),
       ('P0150', 'Cuentos De Pelos', 'Princesas en apuros, lobos feroces, todo puede ocurrir cuando Chema y Meche empiezan a contar. ¡Los Cuentos de Pelos!', 'CL001', 'C09'),
       ('P0151', 'Perros Y Gatos', 'Jessica e Iván tienen toda la información acerca de perros y gatos: historias, trucos, tips, datos curiosos y mucho más.', 'CL001', 'C09'),
       ('P0152', 'Consulta con el doctor Pelayo', 'El Dr. Pelayo está listo para resolver las dudas de sus pacientes y compartir datos asombrosos sobre salud y el cuerpo humano.', 'CL001', 'C09'),
       ('P0153', 'Una vez soñé', 'En "Una vez soñé...", conoce los mejores sueños y las peores pesadillas de niñas y niños, quienes de viva voz nos relatan lo que pasa por sus mentes cuando duermen. En estas breves cápsulas, vive con ellos estos relatos ilustrados.', 'CL001', 'C09'),
       ('P0154', 'La palabra de Memo', 'Descubre el significado de algunas palabras que usamos todos los días. ¡Te sorprenderás!', 'CL001', 'C09'),
       ('P0155', 'Zoológicos Azoombrosos', 'En estas cápsulas de tan solo tres minutos, una niña y un niño: Scarlet y Diego, hacen un recorrido por los zoológicos más importantes de México para descubrir todo tipo de animales. Con la ayuda de un experto en la materia, ellos descubren todo sobre los animales: de dónde vienen, cuál es su hábitat, cómo llegaron al parque, qué comen, cómo se comportan, quiénes son sus depredadores y mucho más.', 'CL001', 'C09'),
       ('P0156', 'Creciendo Juntos', 'Creciendo juntos incentiva el desarrollo armónico de niñas y niños con relación a temas y situaciones que los vulneran y colocan en situación de riesgo y violencia. Con la participación de niñas y niños, cápsulas, marionetas y otros medios, este programa del Once explora valores, reglas y formas de crecer juntos de manera respetuosa y próspera.', 'CL001', 'C09'),
       ('P0157', 'Timora y Sus Extrañas Historias', 'Monstruos, fantasmas, gatos y escobas con poderes mágicos son algunos de los personajes que descubrirás junto a Timora.', 'CL001', 'C09'),
       ('P0158', 'Concierto. A mover el bote en casa', 'El equipo de Once Niñas y Niños te invita a disfrutar de un recorrido por todos sus éxitos musicales y momentos especiales en este divertido concierto.', 'CL001', 'C09'),
       ('P0159', 'Concierto Conmemorativo UNICEF 70 Años', 'El 11 de diciembre de 2016, el Fondo de las Naciones Unidas para la Infancia (UNICEF) cumplió 70 años de hacer magia y cambiar vidas. Y eso ¡hubo que celebrarlo! Este concierto dio muestra de ello a través del arte de las niñas y niños. Así, los músicos, el coro, nuestras invitadas e invitados y, por supuesto: Alan, Lucy y Staff fueron los anfitriones de esta importante celebración.', 'CL001', 'C09'),
       ('P0160', 'Cuenta Con Sofía', 'En cada episodio, Sofía Álvarez nos cuenta las historias más fascinantes y entretenidas. En su espacio mágico, títeres, objetos e invitados la acompañan para narrar los más divertidos relatos. Al ritmo de canciones, con disfraces y todo tipo de utensilios, acompáñala en esta travesía única.', 'CL001', 'C09'),
       ('P0161', 'La Doctora Noyolo y yo', 'Aprender a identificar lo que sentimos es muy importante para conocernos mejor. Acompaña a la doctora Noyolo en un viaje por las emociones y descubre algunos ejercicios que te ayudarán a sentirte mejor.', 'CL001', 'C09'),
       ('P0162', 'Kin', 'Joaquín Guerrero ha desaparecido y el presente, como lo conocemos, depende de que logren encontrarlo.', 'CL001', 'C09'),
       ('P0163', 'Un espacio sin límites', 'En el Día Internacional de las personas con discapacidad celebramos a todos los seres humanos por igual. Hagamos que el mundo sea... "un espacio sin límites".', 'CL001', 'C09'),
       ('P0164', 'Especiales Canal Once', 'Te invitamos a explorar este espacio, ponemos a tu alcance nuestros programas unitarios; series cortas; cápsulas noticiosas, informativas o culturales; reportajes y programas de diferentes temas y contenidos, etc. Recuerda, son “especiales” por eso, no te los puedes perder.', 'CL003', 'C10'),
       ('P0278', 'Hagamos Que Suceda: La Cuarentena', 'Manteniendo la sana distancia, muchas personas en todo el país envían sus experiencias, inquietudes y actividades realizadas durante el aislamiento por COVID-19. Aunado a esto, especialistas en diversos campos ofrecen un panorama sobre cómo enfrentar de mejor manera la cuarentena.', 'CL004', 'C10'),
       ('P0165', 'Digital', 'Digital es un programa que nos invita a reflexionar en torno a las Tecnologías de la Información y Comunicación (TIC) y al alcance e importancia que tienen en nuestra sociedad. Conversando con expertos, usuarios y esbozando diversos ejemplos, "Digital" busca reducir las brechas generacionales y digitales.', 'CL001', 'C10'),
       ('P0166', 'México en el Exterior', 'Reflexionar sobre nuestra política exterior es un tema de interés público. La serie "México en el exterior", realizada por el Once en colaboración con la Secretaría de Relaciones Exteriores (SRE), nos invita a dialogar sobre los retos y prioridades de la política exterior mexicana a lo largo de ocho programas. El objetivo de esta serie es, ante todo, abrir un debate plural y profundo sobre la diplomacia mexicana en la conversación pública. Disfruta y reflexiona de la mano de las opiniones de especialistas, investigadores, académicos y diplomáticos en "México en el exterior".', NULL, 'C10'),
       ('P0167', 'Factor Ciencia', 'En Factor Ciencia abordamos temas actuales y reflexionamos sobre el rumbo científico, su huella en la sociedad y su aplicación tecnológica. Mantente al día del acontecer científico de México y el mundo.', 'CL002', 'C10'),
       ('P0168', 'Hagamos Que Suceda: La Sana Distancia', 'En este programa, Ana María Lomelí nos ofrece un amplio abanico de experiencias durante la cuarentena provocada por Covid-19 y reúne a expertos en diversas áreas que nos brindan su conocimiento y consejos para enfrentarnos de la manera más sana y sencilla a la nueva normalidad.', NULL, 'C10'),
       ('P0169', 'Hagamos Que Suceda', 'Este programa del Once de gran trayectoria ha tratado algunas de las temáticas más importantes para el acontecer nacional que nos afectan a todas y todos en nuestro día a día. "Hagamos que suceda" es una serie de reportajes especiales en los que se aborda la situación económica, política y social de México, contada a partir de testimonios de ciudadanos y funcionarios involucrados en estos temas. ¡Conoce, reflexiona y opina con Hagamos que Suceda!', 'CL002', 'C10'),
       ('P0170', 'Un lugar llamado México', 'La UNESCO, el Instituto Nacional de Antropología e Historia y El Once, presentan esta serie documental en la que se muestra la belleza natural y patrimonial de nuestro país, a través de un recorrido por diferentes rutas históricas, reservas naturales y personajes emblemáticos de cada rincón, que son descubiertos en un viaje por el extenso territorio de la república mexicana. Iniciemos juntos este recorrido por un lugar llamado México.', 'CL002', 'C11'),
       ('P0171', 'México Biocultural', 'Manglares e islotes con vegetación de selva mediana que esconden la arqueología de la cultura maya, hogar de peces, aves y reptiles endémicos. En este programa, arqueólogos, biólogos, artesanos y difusores culturales nos explican la simbiosis entre la naturaleza y la cultura maya ancestral, así como la importancia para nuestro país de conservarla. México Biocultural difunde nuestra gran riqueza natural y arqueológica, al tiempo que muestra cómo los antiguos pobladores de México, en su sabiduría y respeto por la vida, se adaptaron y vivieron en equilibrio con su entorno.', 'CL002', 'C11'),
       ('P0172', 'Agenda Verde', 'Conoce alternativas e historias de éxito en torno a diversas personas que ayudan a generar un cambio positivo en el medio ambiente. Este programa nos ofrece desde reportajes especiales en torno a la preservación de especies animales y vegetales, hasta consejos para generar menos basura. Conduce Max Espejel.', 'CL002', 'C11'),
       ('P0173', 'Chapultepec un Zoológico Desde Adentro', 'Esta serie nos mostrará cómo funciona un parque zoológico, cuáles son sus necesidades, sus retos, el trabajo y la pasión de la gente que trabaja para que los animales tengan una vida sana y digna; su papel en la conservación de las especies a nivel local y mundial.', 'CL002', 'C11'),
       ('P0174', 'Detrás de un Click', 'A través de la lente de su cámara, Magali Boysselle captura imágenes impresionantes de sus viajes a diferentes destinos del país, fotografías que retratan aspectos naturales con los que nunca habíamos estado tan conectados. Viaja con Magali y comparte su experiencia sobre lo que ve y admira de los paisajes naturales.', 'CL002', 'C11'),
       ('P0175', 'El Libro Rojo, Especies Amenazadas', 'Nuestro país es uno de los recintos megadiversos de flora y fauna más importantes del mundo. Sin embargo, debido a una serie de factores que incluyen la actividad humana, cientos de especies están en peligro de desaparecer. Conoce la pasión con la que organizaciones, comunidades, sector privado e individuos luchan para revertir la tendencia que conduce a estos seres hacia el fin de su especie. Sé testigo de importantes historias de conservación de las especies animales más emblemáticas de México.', 'CL002', 'C11'),
       ('P0176', 'Nuestros Mares', 'En breves cápsulas conoce los secretos de la riqueza de los mares y océanos mexicanos, así como la importancia esencial de su cuidado para la conservación de la vida en el planeta. Maravíllate con los paisajes, especies y ecosistemas acuáticos de nuestra nación.', 'CL002', 'C11'),
       ('P0177', 'Islas de México', 'Serie documental de naturaleza producida por Canal Once con apoyo del Consejo Nacional de Ciencia y Tecnología, CONACyT, que muestra la biodiversidad de las islas localizadas en el Océano Pacífico, consideradas como reservas naturales debido a sus altos niveles de endemismo y grado de conservación; además reconoce y retrata la labor de científicos y conservacionistas.', 'CL002', 'C11'),
       ('P0178', 'Entre Mares', 'Manuel Lazcano, un experimentado buzo y fotógrafo mexicano, nos muestra tanto la belleza como la fragilidad de la vida marina, revelándonos algunas de sus maravillas y misterios. Esta serie es una aventura fascinante para celebrar la vida marina y explorar las riquezas de los litorales mexicanos.', 'CL002', 'C11'),
       ('P0180', 'México Vive', 'Los efectos del cambio climático tienen un impacto directo en los sistemas naturales y humanos. "México vive" es un espacio de reflexión que incentiva la concientización de la importancia de conservar nuestro medio ambiente, así como de la urgente necesidad de tomar medidas para protegerlo y preservarlo. Acompaña a Javier Solórzano y a un grupo de expertos en esta conversación, donde abordan temas como un país en equilibrio, biodiversidad, leyes forestales, áreas naturales protegidas, contaminación, energía renovable, especies endémicas, calentamiento global, reciclaje y explotación sustentable de los recursos naturales. "México vive" y necesita de todos para seguir latiendo.', 'CL002', 'C11'),
       ('P0181', 'Patrimonio Mundial Natural En México', 'Una serie documental producida por el Once, Bravo Films y SEMARNAT-CONANP donde se muestran las cinco Áreas Naturales Protegidas de México catalogadas como Patrimonio Mundial por la UNESCO. Embárcate en esta exploración por la Reserva de la Biosfera de la mariposa Monarca, Michoacán; la Reserva de la Biosfera El Pinacate y Gran Desierto de Altar, Sonora; la Reserva de la Biosfera de Sian Kaan, Quintana Roo; la Reserva de la Biosfera El Vizcaíno, Baja California; y las Islas y áreas protegidas del Golfo de California.', 'CL001', 'C11'),
       ('P0182', 'Hospital Veterinario', 'Este programa del Once nos invita al interior del mundo veterinario. A través de casos específicos, conoce más sobre el reino animal, los padecimientos que lo aquejan y la extraordinaria labor de los médicos, cuidadores y entrenadores dedicados a preservar la vida y salud de los animales.', 'CL001', 'C11'),
       ('P0183', 'México En La Edad De Hielo', 'Durante 126 mil años, nuestro planeta estuvo inmerso en la última glaciación. Grandes porcentajes de la superficie de la Tierra se encontraron bajo gruesas capas de hielo, las cuales contenían tanta agua que los mares se encontraban 100 metros por debajo del nivel actual, y la temperatura de los polos disminuyó significativamente. Esto llevó a que grandes mamíferos y depredadores migraran hacia los trópicos. El territorio que hoy ocupa México se convirtió en un paraíso para miles de especies. Esta serie muestra la vida de este maravilloso mundo, desconocido hasta ahora, en lo que hoy conforma el territorio nacional.', NULL, 'C11'),
       ('P0184', 'Naturaleza', 'Naturaleza es una serie, realizada por el Once y la Comisión Nacional para el Conocimiento y Uso de la Biodiversidad (CONABIO), que tiene como objetivo reflexionar sobre la relación que existe entre una alimentación saludable tanto para nuestro cuerpo como para los ecosistemas.', 'CL001', 'C11'),
       ('P0185', 'Contra VS', 'En esta mesa de análisis dos participantes se enfrentan en un versus, a partir de sus argumentos y capacidad de debate. Al terminar esa ronda participan otras dos personas, con la misma dinámica, para luego intercambiar a los participantes, y que todos compitan entre sí.', NULL, 'C12'),
       ('P0186', 'Chamuco TV', 'Los moneros de la revista El Chamuco y Los Hijos del Averno conducen este programa semanal de sátira política y análisis inteligente, en el que platican con los invitados acerca de los temas coyunturales de México y del mundo.', 'CL005', 'C12'),
       ('P0187', 'El Desfiladero', 'Una mesa redonda conformada por jóvenes en la que cada participante brinda su perspectiva en torno al tema del día, al tiempo que complementa la información y profundiza en sus implicaciones en nuestra sociedad.', 'CL004', 'C12'),
       ('P0188', 'Cápsulas Politécnicas', 'Guinda y blanco representan más que dos colores, significan el orgullo de una institución con más de 80 años de historia. Conoce los rostros de las y los miembros de la comunidad politécnica así como sus historias. ¡HUELUM!', 'CL002', 'C12'),
       ('P0189', 'Nuestra Energía', 'Nuestra Energía, es una serie de análisis que busca acercar a las audiencias a la Comisión Federal de Electricidad, el organismo estatal encargado de controlar, generar, transmitir y comercializar la energía eléctrica en México. Al conocer su historia, funcionamiento y marco legal, se busca otorgar a los espectadores herramientas para analizar y comprender lo que ocurre día a día en México en materia energética', 'CL003', 'C12'),
       ('P0190', 'Largo Aliento', 'Entrevista, como el nombre del programa lo indica, es de "Largo Aliento". Tratamos de indagar, preguntar y volver a preguntar sobre los temas de interés en la vida política, económica e intelectual del acontecer del mundo.', 'CL004', 'C12'),
       ('P0191', 'La ruta de la ciencia', 'La Ruta de la Ciencia es una travesía por el mundo del conocimiento. En esta serie Tamara de Anda explora Museos y Centros de Ciencia y Tecnología para descubrir el panorama cultural, educativo y artístico que ofrecen estos singulares espacios, recorre con nosotros La Ruta de la Ciencia.', 'CL002', 'C12'),
       ('P0192', 'Especiales de mayo', 'Programas especiales en los que se hace un recorrido a través de dos de las fechas históricas más relevantes para el país: el 1 de mayo, día del trabajo, y el 5 de mayo, día de la batalla de Puebla.', 'CL003', 'C12'),
       ('P0193', 'Conmemoraciones', 'Programas especiales de las conmemoraciones más emblemáticas del año 2021; en las que se busca revalorizar, recuperar los verdaderos motivos de hacer una celebración y la reafirmación de nuestra identidad nacional.', 'CL003', 'C12'),
       ('P0194', 'Especiales del Once', 'Entrevistas, investigaciones y reportajes de fondo dan cuenta del quehacer en México y el mundo.', 'CL003', 'C12'),
       ('P0195', 'Operación Mamut', 'Un programa de humor político en el que las noticias de cada día son la materia prima de una puesta en escena crítica y divertida sobre el acontecer nacional e internacional.', 'CL003', 'C12'),
       ('P0196', 'La Maroma Estelar', 'En un país tan plural y complejo como México, hay que dar saltos enormes para entender las problemáticas más apremiantes en la sociedad. Con especialistas, investigaciones, análisis y diversidad de voces, "La Maroma Estelar" es un diálogo dedicado a los jóvenes, sobre los temas del momento, con un estilo creativo e inusual. Este programa del Once presenta un tema que se analiza mediante mesas, reportajes, entrevistas de calle, e invitados especiales.', 'CL002', 'C12'),
       ('P0197', 'A Favor y En Contra', 'Margarita González Gamio y Jorge del Villar plantean a los especialistas las diversas aristas y los polos opuestos de los temas más controvertidos del panorama nacional, para construir juntos un debate que enriquezca nuestra opinión sobre las decisiones que nos afectan a todas y todos.', 'CL003', 'C12'),
       ('P0198', 'Agenda a Fondo', 'Un programa de investigación periodística que ofrece reportajes desarrollados a partir de las noticias más relevantes. El analista político José Buendía comenta y analiza las ideas centrales de cada tema, además de escuchar las opiniones de la audiencia.', NULL,'C12'),
       ('P0199', 'Apuesto al Sexo Opuesto', 'Con el fin de promover y difundir la equidad de género, así como de generar mejores escenarios para las mujeres, este programa pone sobre la mesa temas de actualidad, interés y relevancia para la vida de las mujeres y los hombres contemporáneos. Opiniones, datos y experiencias de expertas dan pie a conversaciones, preguntas y participaciones que permiten ahondar en las problemáticas actuales con respecto a la igualdad y la convivencia entre los sexos, de modo tal que se propongan soluciones y alternativas para el mejoramiento de las mismas.', 'CL004', 'C12'),
       ('P0200', 'Dinero y Poder', 'Entérate y comprende los sucesos y temas más relevantes del mundo en materia de economía y poder junto a Ezra Shabot, quien cada episodio tiene prestigiosos invitados especialistas. Estas conversaciones informan y analizan de manera ágil y accesible, sin dejar de lado la complejidad y profundidad propias de los hechos a abordar.', 'CL002', 'C12'),
       ('P0201', 'Línea Directa', 'Línea directa es un programa plural en el que caben todas las ideologías, religiones, culturas y políticas, y en el cual se entrevista lo mismo a un artista, un empresario y a un deportista, que a un político o a un funcionario público. Este programa presenta entrevistas a personajes destacados de la economía, la política y la cultura para conocer sus posturas en temas distintos a los esperados, para profundizar en aspectos esenciales que impactan el acontecer nacional e internacional', 'CL003', 'C12'),
       ('P0202', 'John y Sabina', 'Un programa dinámico e innovador que busca poner a debate los grandes temas de la agenda nacional, con las personalidades clave del ámbito político, social y cultural de México. Diálogo y entretenimiento que buscan romper los esquemas y jerarquías informativas, fomentando la conciencia crítica y la participación ciudadana, para la reconstrucción del país y la reinterpretación de la realidad.', 'CL003', 'C12'),
       ('P0203', 'Encuentros: Educacíon, Ciencia Y Cultura Desde El Politécnico', 'Mesa de diálogo entre especialistas que debatirán sobre el momento actual, programas y dirección de la educación de nuestro país.', 'CL003', 'C12'),
       ('P0204', 'Primer Plano', 'En este programa icónico del Once, los analistas Sergio Aguayo, María Amparo Casar, José Antonio Crespo, Leonardo Curzio, Lorenzo Meyer y Francisco Paoli Bolio, reflexionan en torno a las realidades económicas, políticas y sociales de México y del mundo, de manera clara, concisa y comprensible.', 'CL003', 'C12'),
       ('P0205', 'Sacro y Profano', 'Bernardo Barranco y destacados investigadores, antropólogos, sacerdotes y escritores nos invitan a conocer más acerca de los temas que rodean a las religiones, a fin de fomentar la pluralidad, la diversidad y la tolerancia, en el marco de un estado laico.', 'CL003', 'C12'),
       ('P0206', 'De Buena Fe', 'De Buena Fe es conversación informal, analítica y sincera sobre los principales temas de la coyuntura actual del país. Acompaña a Gibrán Ramírez Reyes, a Estefanía Veloz y a Danger AK en este debate sobre la agenda nacional y sobre los temas que nos afectan a todas y todos como mexicanos. La estructura de este programa se integra con la participación de un invitado, cápsulas con sondeos realizados en la calle, una sección con las paparruchas más sobresalientes en los medios de comunicación, entrevistas en el estudio y un número musical donde Danger AK nos presenta un rap sobre el tema del día. ', 'CL004', 'C12'),
       ('P0207', 'De Todos Modos... John Te Llamas', 'De todos modos... John te llamas da un espacio a la audiencia interesada en debatir, cuestionar, coincidir o diferir en los hechos de la vida pública. Cuenta con la conducción de John Ackerman, quien habla con los personajes más relevantes de la vida política y cultural.', 'CL003', 'C12'),
       ('P0208', 'Del sueño al orgullo Politécnico', 'Enseñar, aprender, crecer, luchar y compartir. Para ser parte del IPN solo se necesita querer saber, tener curiosidad, explorar, hacer preguntas, buscar respuestas, deconstruir, proponer y crear. En las aulas, los laboratorios y los talleres te vamos a dar las herramientas para que construyas tu propio camino y encuentres las respuestas que estás buscando, para que puedas expandir el conocimiento y la técnica en ti y los compartas con el mundo. Hazlo con nosotros, en el Instituto Politécnico Nacional.', 'CL001', 'C13'),
       ('P0209', 'Huélum', 'Una revista informativa que da voz a la comunidad politécnica. Conoce cómo el trabajo constante y disciplinado de los politécnicos brinda logros cotidianos a la sociedad en su conjunto. Esto es, Huélum.', 'CL001', 'C13'),
       ('P0210', 'A La Cachi Cachi Porra', 'A la cachi cachi porra es un ágil y entretenido programa de concurso entre estudiantes de las escuelas de Educación Medio Superior del Instituto Politécnico Nacional, donde se presenta el conocimiento de manera lúdica, espontánea y dinámica, como lo exige el ritmo de vida de los jóvenes de hoy.', 'CL002', 'C13'),
       ('P0211', 'Gaceta Politécnica', 'Uno de los pilares del desarrollo en México es el Instituto Politécnico Nacional, debido a que la familia politécnica vive su vocación, "La técnica al servicio de la patria". Descubre sus logros tanto en su oferta académica, cultural y deportiva, como en sus aportaciones a proyectos estratégicos de los sectores público y privado.', 'CL002', 'C13' ),
       ('P0212', 'Escaparate de Ideas', 'Este programa te presenta los proyectos que están cambiando nuestra realidad tecnológica y social. Los proyectos que desarrollan las y los estudiantes y egresados del Instituto Politécnico Nacional son, además de fuentes de inspiración para México y el mundo, generadores de progreso para todas y todos. Este programa impulsa sus innovaciones.', 'CL002', 'C13'),
       ('P0213', 'Jóvenes Politécnicos', 'Conoce las historias y los proyectos de estos destacados estudiantes del Instituto Politécnico Nacional. A su lado, descubre los últimos desarrollos de ingeniería, tecnología y ciencia del país.', 'CL002', 'C13'),
       ('P0214', 'Espiral Politécnica', 'Ricardo Raphael visita planteles del Instituto Politécnico Nacional para platicar con los jóvenes que están construyendo el futuro de México.', 'CL002', 'C13'),
       ('P0215', 'Burros Blancos, "El Año Que Fuimos Campeones"', 'Burros Blancos “El año que fuimos campeones” narra el proceso que vive un equipo de futbol americano durante todo un año para poder convertirse en campeón, pasando por dificultades y todo tipo de pruebas para lograr un solo objetivo, el campeonato de la Liga Mayor.', 'CL002', 'C13'),
       ('P0216', 'La VerDrag', 'Bienvenides a La VerDrag, el programa donde las minorías se convierten en mayoría. Un espacio informativo donde hablamos de los asuntos sociales que preocupan pero poco foco reciben, de las realidades que enfrentan los grupos vulnerados y de los mitos y prejuicios que durante años han ocasionado que nos vean como personas de segunda categoría.', 'CL004', 'C14'),
       ('P0217', 'DÍA MUNDIAL DE LA LUCHA CONTRA EL VIH/SIDA 2023', 'En México, las personas que viven con el virus de inmunodeficiencia humana (VIH) representan 0.06% de la población y aunque algunas fuentes consideran que la epidemia se ha estabilizado, ésta continúa siendo una de las principales causas de mortalidad en el mundo. Para entender el contexto actual de esta pandemia en el mundo y principalmente en México, buscamos informar y fomentar las prácticas sexuales seguras como método de prevención de transmisión de la infección por el virus del VIH. Visibilicemos, Incluyamos, Humanicemos.', 'CL004', 'C14'),
       ('P0218', 'Respuestas', 'En "Respuestas" se da voz a las preguntas directas de los ciudadanos en torno a los temas que está implementando el gobierno en la actualidad. Un programa de entrevista moderado por Guadalupe Contreras, en el cual el público en el estudio, personas en diferentes locaciones y por redes sociales, dirigen sus cuestionamientos a las servidoras y los servidores públicos y especialistas invitados. Con ello, El Once abre un espacio para el diálogo directo con nuestros representantes en el gobierno sobre los temas coyunturales que a todos nos conciernen.', 'CL004', 'C14'),
       ('P0219', 'Acá los paisanos', 'Los connacionales que reiniciaron su historia personal en Estados Unidos dejaron atrás familia, amigos, espacios y raíces, en búsqueda de un futuro mejor. Acá los paisanos es un retrato entrañable de algunos de los cientos de mexicanos que cruzan cada año la frontera del norte, quienes nos abren las puertas de su casa para hablar de cómo fue volverse migrantes y reinventar su vida.', 'CL003', 'C14'),
       ('P0220', 'Mujeres Transformando México', 'Las mujeres mexicanas conformamos el 52 por ciento de la población del país, sin embargo, nuestra participación no está en un terreno equitativo. En Mujeres Transformando México recuperamos las historias, las metas y los logros de las mujeres, quienes, como un acto constante de resistencia y transformación de todos los sectores de la sociedad, lograron romper el techo de cristal. Este programa es un testimonio del liderazgo de las mujeres en la política mexicana.', 'CL003', 'C14'),
       ('P0221', 'Conecta con la Lectura', 'Celebramos el Día Internacional del Libro en El Once con nuestros programas favoritos que abordan esta temática. No te los pierdas y sumérgete en el mundo de la lectura', 'CL002', 'C14'),
       ('P0222', 'A+A Amor y Amistad', 'En A+A compartimos cómo brindar bienestar a nuestros perros y gatos, con Don Jile, su perro Futuro y Flor. Beatriz Pereyra y Erick Tejeda visitan albergues para conocer las historias de quienes ahí viven, mientras sabemos más de adiestramiento, salud, calidad de vida, etología y humanitarismo.', 'CL004', 'C14'),
       ('P0223', 'Aprender en Comunidad', 'Los maestros de primaria multigrado de las comunidades lejanas y marginadas han desarrollado un método novedoso de enseñanza, a través del cual los estudiantes aprenden en conjunto por medio de la intuición, la investigación y el diálogo constante. "Aprender en comunidad" retrata esta invaluable labor, que ya es un legado para la educación tanto de las comunidades visitadas, como de toda la nación.', 'CL002', 'C14'),
       ('P0224', 'Presente', 'Para entender el nuevo modelo educativo mexicano, Presente se acerca al trabajo de maestras, maestros, directivos, estudiantes, madres y padres de familia, egresados y todas las personas involucradas en el sector, para conocer el proyecto de transformación educativa. A través de entrevistas, reportajes, crónicas, cápsulas, infografías y notas informativas, El Once abre una ventana al Presente de la educación en México, con la cual se busca hacer realidad este derecho humano fundamental, al combatir el rezago y la desigualdad en nuestro país.', 'CL004', 'C14'),
       ('P0225', 'México en Centroamérica: latidos de hermandad', 'A través de testimonios de los beneficiarios, tutores y responsables de los proyectos, en este programa conocemos el desarrollo en Honduras y El Salvador de los programas sociales Sembrando Vida y Jóvenes Construyendo el Futuro. A partir de las historias de vida de los participantes, observamos cómo les han abierto oportunidades en el ámbito laboral los proyectos promovidos por autoridades mexicanas, en colaboración con instituciones de Honduras y El Salvador.', NULL,'C14'),
       ('P0226', 'Tu futuro, nuestro futuro', 'Los oficios son una suma cultural y civilizatoria del trabajo que acumula maestría y dominio, los cuales se transmiten de maestro a aprendiz. Así, el programa social Jóvenes Construyendo el Futuro, a partir del proceso de aprendizaje del oficio, ha sido una respuesta ante la cancelación de las expectativas de vida, por falta de trabajo y oportunidades. Así, este programa social se ha convertido en una alternativa real para dar empleo a millones de jóvenes que no tienen opciones de vida ni esperanza. Y la belleza de estos oficios es que se convierten en una forma de vida que genera economía, estabilidad, pertenencia y orgullo. ', 'CL001', 'C14'),
       ('P0227', 'Abraza la diversidad', 'Para conmemorar, apoyar y dar visibilidad a la comunidad LGBTTTIQ+, creamos una lista con algunos de nuestros programas que abordan el tema. Con el objetivo de que México sea un país libre de prejuicios y prácticas discriminatorias ¡El Once abraza la diversidad!', 'CL004', 'C14'),
       ('P0228', 'Entre nosotras', 'Entre Nosotras, buscamos la igualdad de género a partir de la nueva agenda de los derechos de las mujeres a la educación, a la salud, al desarrollo, al trabajo, a una vida libre de violencia. Entre Nosotras hablamos de la agenda feminista desde las colectivas de mujeres, y también desde los colectivos de hombres que comparten su labor para sanar el tejido social y visibilizar la inequidad: todas las opiniones enriquecen el debate. Un programa plural e incluyente que escucha la voz de las, los y les protagonistas cuyo objetivo es acabar con la superioridad de género, en pro de una sociedad justa para todas, todes, todos.', 'CL001', 'C14'),
       ('P0229', 'Pinta tu barrio', 'Una forma de combatir las grandes desigualdades es a través del arte. "Pinta tu barrio" es una miniserie creada en conjunto con la Secretaría de Desarrollo Agrario, Territorial y Urbano (SEDATU), que da un paso adelante hacia la inclusión de todas las formas de expresión humana, al tiempo que ayuda a restaurar el tejido social.', 'CL002', 'C14'),
       ('P0230', '80 millones', 'La discapacidad es un concepto que evoluciona y que resulta de la interacción entre las personas con deficiencias y las barreras debidas a la actitud y al entorno que evitan su participación plena y efectiva en la sociedad, en igualdad de condiciones con las demás.', 'CL004', 'C14'),
       ('P0231', 'D Todo', 'Conoce los espectáculos más impresionantes, las tradiciones y los festejos de diversas regiones, deportes extremos que te pondrán a prueba, y atractivas aventuras por aire, mar y tierra en D Todo, donde cualquier cosa puede ocurrir.', 'CL002', 'C14'),
       ('P0232', 'A Medio Siglo de México 68', 'Reflexionemos juntos sobre los profundos acontecimientos que tuvieron lugar durante 1968 en México y en el mundo, así como sus repercusiones en la vida social, cultural y política de nuestro país hasta la actualidad.', 'CL002', 'C14'),
       ('P0233', 'Estación Global', 'La comunidad internacional suele tener problemáticas complejas y difíciles de entender. A lo largo de 10 capítulos, explicaremos y discutiremos cómo afectan a las y los ciudadanos de nuestro país.', 'CL003', 'C14'),
       ('P0234', 'Altoparlante', 'Una serie de trece cápsulas de siete minutos cada una que aborda contenidos sobre política, democracia y ciudadanía con el objetivo de interesar a los jóvenes para que puedan involucrarse activamente en la toma de decisiones del país de cara a las elecciones presidenciales de 2012.', 'CL002', 'C14'),
       ('P0235', '#Calle 11', 'Contamos historias de la Ciudad de México, entrevistamos a sus personajes y debatimos sobre calle, cultura y política. Cuestionamos todo, y nos hablamos de tú y a risas con la cotidianidad.', 'CL003', 'C14'),
       ('P0236', 'Casos Médicos, Nuevos Tratamientos', 'Cada caso médico es único. En esta serie de divulgación científica presentamos casos de extraordinarios retos para la medicina y cómo los especialistas plantean novedosas formas para curarlos.', 'CL002', 'C14'),
       ('P0237', 'Cómo Lo Celebro', 'Este programa, coproducido por el Once y Pisito Trece Producciones, explora festividades en diversas partes de México. Conoce cómo el mismo ritual se realiza de formas distintas en diversos sitios del país. ', 'CL002', 'C14'),
       ('P0238', 'Diversos Somos', 'Esta serie documental presenta acercamientos al amplio espectro de la diversidad y las disidencias sexuales. Presentados desde múltiples ángulos, conoce tabús, juicios, prejuicios y conquistas cotidianas que experimentan quienes todos los días luchan por lograr el pleno ejercicio de sus derechos.', 'CL003', 'C14'),
       ('P0239', 'Mi historia de amor', 'Una serie de minidocumentales creados a partir de historias enviadas por jóvenes. En cada episodio conoceremos a una pareja distinta y su particular forma de amarse.', 'CL002', 'C14'),
       ('P0240', 'Lo Que Me Prende', 'Aquí hay cabida para todo y para todas y todos mientras el común denominador sea el respeto por lo otro y por las y los otros. ', 'CL004', 'C14'),
       ('P0241', 'México Social', 'En este programa, Mario Luis Fuentes e invitados revisan los temas sociales en el país en un diálogo abierto con académicos, servidores públicos, legisladores, líderes sociales e integrantes de la sociedad civil. ', 'CL002', 'C14'),
       ('P0242', 'Mexicanos en el extranjero', 'Esta serie es una mirada fraterna a través de la cual conoceremos el día a día de los compatriotas que han dejado México y se han adaptado a las costumbres y a la cultura de los países donde ahora residen. ', 'CL002', 'C14'),
       ('P0243', 'Me Mueves', 'Vive de cerca las historias que les ocurren a estos cinco jóvenes que aprenden, ante todo, que nadie puede decidir por ellos.', 'CL001', 'C14'),
       ('P0244', 'Juicios Orales', 'Juicios Orales, justicia diferente es un programa que recrea casos de la vida real con el objetivo de acercarnos al nuevo Sistema de Justicia Penal de México.', 'CL003', 'C14'),
       ('P0245', 'Los Otros Mexicanos', 'Los otros mexicanos rinde homenaje a las vidas de aquellos compatriotas que ponen el nombre de México en alto en Estados Unidos.', 'CL002', 'C14'),
       ('P0246', 'Maestros', 'Maestros es una serie de documentales del Once que muestran la vida y el trabajo de educadores en escuelas de distintas regiones del país.','CL001', 'C14'),
       ('P0247', 'Nuevos Pasos', 'En "Nuevos Pasos", conversamos con diversos especialistas que explican y nos ayudan a entender importantes aspectos de la maternidad y paternidad, desde el embarazo y la formación de una familia, hasta el desarrollo y la educación de niñas y niños. ', 'CL002', 'C14'),
       ('P0248', 'Oficios', 'Conoceremos por medio de este recorrido los oficios que tienen historia y tradición en nuestro país.', 'CL002', 'C14'),
       ('P0249', 'Perfil Público', 'Programa conducido por Javier Solórzano, quien cada lunes tendrá jóvenes invitados en el estudio para debatir temas de interés general.', 'CL002', 'C14'),
       ('P0250', 'Pies En La Tierra', 'Imagínate pasar una semana lejos de tu casa, de tus amigos y de las comodidades a las que estás acostumbrado, para ayudar a una comunidad.', NULL,'C14'),
       ('P0251', 'Retratos', 'Retratos es una serie documental que ofrece un amplísimo panorama de profesiones y formas de vida de nosotros, los mexicanos. ', 'CL002', 'C14' ),
       ('P0252', 'Signos De Los Tiempos', 'Signos de los Tiempos nos introduce en cultos y ritos religiosos populares en México. A partir de experiencias personales y colectivas, esta serie nos permite conocer las formas y los motivos por los que las personas se sienten convocadas por ciertas creencias.', 'CL003', 'C14'),
       ('P0253', 'Espiral', 'Ricardo Raphael conduce este espacio dedicado al análisis de las políticas públicas en nuestro país, basado en el intercambio de puntos de vista entre los responsables del diseño de dichas políticas y los representantes de los sectores donde éstas impactan.', 'CL002', 'C14'),
       ('P0254', 'Francisco, Visita Papal a México', 'Con motivo del viaje que realizará el Papa Francisco a México, este programa contiene mesas de diálogos entre diversos especialistas para analizar lo que representan las figuras El Vaticano y el Papa.', 'CL004', 'C14'),
       ('P0255', 'Fuerza Interior', 'Esta serie del Once muestra testimonios en torno al poder de la voluntad de quienes han logrado sobreponerse a alguna discapacidad.', 'CL001', 'C14'),
       ('P0256', 'Habla de Frente', 'Cada semana dos equipos de estudiantes de diferentes escuelas, exponen y defienden posturas contrarias sobre temas polémicos.', 'CL004', 'C14'),
       ('P0257', 'Hacer El Bien', 'Esta serie del Once nos presenta proyectos sociales realizados por fundaciones, asociaciones civiles, organizaciones no gubernamentales y voluntarios. Conoce las historias de estas iniciativas y quiénes las hacen posibles.', 'CL002', 'C14'),
       ('P0258', 'Hacen El Bien y Miran A Quién', 'Esta serie del Once recorre algunos puntos del país para conocer los principales proyectos sociales, el impacto humano de la iniciativa y por supuesto, a sus protagonistas.', NULL,'C14'),
       ('P0259', 'Interesados Presentarse', 'En este programa tú mismo descubrirás y te responderás al respecto: en este reality show podrás ensayar la práctica cotidiana y el ejercicio real de una serie de atractivas profesiones para que sólo tú elijas cuál te va mejor.', 'CL002', 'C14'),
       ('P0260', 'Instantáneas', 'En este programa, ellas y ellos, desde sus espacios, vivencias, sentimientos, ocurrencias y vida cotidiana, reflexionan y se expresan sobre temas delicados, e incluso algunos considerados ¿tabú¿ en diversos medios.', 'CL002', 'C14'),
       ('P0261', 'Independientes', 'Descubre qué está sucediendo en los mundos de la moda, el arte, la gastronomía, la literatura y la cultura contemporánea fuera de las instituciones.', 'CL002', 'C14'),
       ('P0262', 'Haciendo Eco', 'En la serie Haciendo eco contamos las historias de chicas y chicos de entre 13 y 18 años que han dejado de ser observadores para brindar acciones positivas que reduzcan nuestro impacto contaminante en el planeta.', 'CL002', 'C14'),
       ('P0263', 'Hechas En México', 'Conoce la vida de pintores, médicos, escritores, astronautas, políticos, historiadores y otros fascinantes personajes del país.', 'CL002', 'C14'),
       ('P0264', 'Antípodas', 'Esta serie hace especial énfasis en la documentación de hechos políticos y culturales de alto impacto social, para abordar temas y situaciones ligadas a la violencia, el abuso de poder, la migración, la inequidad de género, la corrupción, entre otros.', 'CL004', 'C14'),
       ('P0265', 'Juana Inés', 'Sor Juana fue una mujer que buscó con desesperación desarrollarse intelectualmente, aferrada a su derecho a ser y a escribir. Cortesana y después monja jerónima, protegida de virreyes y virreinas, fue obligada a firmar con sangre su protesta de fe, en un intento por acallar su voz e ingenio.', 'CL005', 'C15'),
       ('P0266', 'Soy tu fan', 'Soy tu fan no es una historia de grandes amores ni de ídolos inalcanzables, sino de personajes reales que nos muestran cómo podemos volvernos fanáticos de alguien que está a nuestro lado, pero a quien no podemos acceder.', 'CL005', 'C15'),
       ('P0267', 'XY', 'XY pone en entredicho la masculinidad tradicional e intenta responder la pregunta ¿en qué consiste ser hombre?', NULL, 'C15'),
       ('P0268', 'Crónica de Castas', 'Serie dramatizada que muestra un mosaico de historias, que corren en paralelo y a veces se entrelazan, en torno a Tepito y su identidad como barrio, dejando ver los prejuicios sociales que se manifiestan en el clasismo y el racismo, como parte de una realidad histórica en México.', 'CL005', 'C15'),
       ('P0269', 'Woki Tokis', 'Una divertida historia de cuatro niños, Mariel, Jonás, Pablo y Maki, que se conocen en el fraccionamiento donde viven, y deciden formar una banda de rock.', 'CL001', 'C15'), -- SECCION NIÑOS
       ('P0270', 'Fonda Susilla.', 'Esta serie se desarrolla en el negocio propiedad de la familia Susilla, integrada por Florencio, el papá y sus cinco hijos, Italia, Alemania, Hipódromo, Condesa y Marbella, quienes a través de la comedia de situación, rescatan lo positivo de vivir en familia.', 'CL003', 'C15'),
       ('P0271', 'Malinche', 'La conquista de México a través de la mirada de una mujer indígena y en una gran variedad de lenguas originarias como el totonaco, popoluca, maya y náhuatl.', 'CL003', 'C15'),
       ('P0272', 'Pacientes', 'Pacientes es una serie ficción que gira en torno a las historias de cinco pacientes y su terapeuta. Los traumas de todos convergen en una búsqueda por superar las angustias, aceptarse y sanar sus relaciones.', NULL, 'C15'),
       ('P0273', 'Futboleros', 'En esta serie, la pasión que despierta el futbol tiene que ver con la amistad, con unos zapatos rotos, con lo que extraña un niño al cambiarse de casa e, incluso, con un balón que cumple deseos. ', 'CL001', 'C15'), -- SECCIÓN NIÑOS
       ('P0274', 'Noctámbulos, Historia de Una Noche', 'Entre el atardecer y el alba, los noctámbulos recorren la oscuridad en busca del sustento o la aventura.', 'CL006', 'C15'),
       ('P0275', 'Muerte Sin fin', 'Esta serie documental se adentra en el mundo de las drogas de la Ciudad de México, en el que personas de diferentes edades y géneros abusan del consumo de estupefacientes sin pensar en las consecuencias que deberán enfrentar.', 'CL003', 'C15'), -- SE REPITE KIPATLA AAAAAAAAAAAA
       ('P0276', 'Los Minondo', 'Historia de dos familias, entremezcladas con la lucha de independencia, cuyo tronco en común es Manuel Minondo.', NULL, 'C15'),
       ('P0277', 'Todo Por Nada', 'TODO POR NADA es la historia de una familia común de clase media mexicana, cuya vida cotidiana transcurre dentro de una aparente normalidad hasta que un peligroso incidente revela la realidad de su silenciosa convivencia con las adicciones.', 'CL006', 'C15'),
       ('P0279', 'Paso a Paso', 'Miguel Conde, nos lleva a conocer los pueblos mágicos de la República Mexicana. Un Pueblo Mágico es una localidad que tiene atributos simbólicos, leyendas, historia, hechos trascendentes, cotidianidad, en fin magia que te emanan en cada una de sus manifestaciones socio-culturales, y que significan hoy día una gran oportunidad para el aprovechamiento turístico.', 'CL002', 'C02'),
       ('P0280', 'Noticiario Mañanero', 'Despierta con las últimas noticias y análisis en profundidad de los temas más relevantes del día, cada mañana en Noticiario Mañanero Once, su fuente confiable de información en Canal Once.', 'CL002', 'C10'),
       ('P0281', 'Noticiario Meridiano', 'Noticias Meridiano de Canal Once: cobertura actualizada de eventos nacionales e internacionales, reportajes especiales, análisis en profundidad y entrevistas, para mantenerte informado al mediodía.', 'CL002', 'C10'),
       ('P0282', 'Noticiario nocturno', 'Explora las noticias más relevantes y actuales con un enfoque profundo y analítico. Canal Once Nocturno te trae lo último en eventos nacionales e internacionales, cada noche.', 'CL005', 'C10'),
       ('P0283', 'Noticiario Sabatino', 'Un noticiario sabatino de "Canal Once" que presenta los acontecimientos más relevantes de la semana, con análisis profundos, reportajes especiales y entrevistas, ofreciendo una perspectiva única sobre las noticias nacionales e internacionales.', 'CL004', 'C10'),
       ('P0284', 'Noticiario Dominical', 'Resumen semanal de noticias nacionales e internacionales, con análisis profundos y entrevistas exclusivas, presentado por destacados periodistas de Canal Once cada domingo.', 'CL003', 'C10'),
       ('P0285', 'Noticiario', 'Noticiario de Canal Once: Cobertura actualizada y confiable de eventos nacionales e internacionales, con análisis profundos y reportajes especiales, reflejando la diversidad y dinamismo de México y el mundo.', NULL, 'C10'),
       ('P0286', 'Himno Nacional', 'Una retransmición del Himno Nacional Mexicano con la Orquesta Nacional', 'CL001', 'C10'),
       ('P0287', 'Cine del Once', 'Una selección especial de canal Once.', 'CL003', 'C10');
       SELECT * FROM programas;


INSERT INTO horarioNacional(idHorarioN, hora_Inicio, hora_fin, idPrograma, idFecha, idPais)
VALUES  ('H00001', '00:00', '00:05', 'P0286', 'F00016', 'PA02'),
        ('H00002', '00:05', '01:00', 'P0013', 'F00016', 'PA02'),
        ('H00003', '01:00', '02:45', 'P0286', 'F00016', 'PA02'),
        ('H00004', '02:45', '03:15', 'P0268', 'F00016', 'PA02'),
        ('H00005', '03:15', '03:45', 'P0272', 'F00016', 'PA02'),
        ('H00006', '03:45', '04:15', 'P0272', 'F00016', 'PA02'),
        ('H00007', '04:15', '04:30', 'P0276', 'F00016', 'PA02'),
        ('H00008', '04:30', '05:00', 'P0071', 'F00016', 'PA02'),
        ('H00009', '05:00', '05:30', 'P0054', 'F00016', 'PA02'),
        ('H00010', '05:30', '06:00', 'P0066', 'F00016', 'PA02'),
        ('H00011', '06:00', '06:05', 'P0286', 'F00016', 'PA02'),
        ('H00012', '06:05', '07:30', 'P0104', 'F00016', 'PA02'),
        ('H00013', '07:30', '09:30', 'P0287', 'F00016', 'PA02'),
        ('H00014', '09:30', '11:30', 'P0053', 'F00016', 'PA02'),
        ('H00015', '11:30', '12:00', 'P0054', 'F00016', 'PA02'),
        ('H00016', '12:00', '12:05', 'P0069', 'F00016', 'PA02'),
        ('H00017', '12:05', '13:45', 'P0287', 'F00016', 'PA02'),
        ('H00018', '13:45', '14:00', 'P0063', 'F00016', 'PA02'),
        ('H00019', '14:00', '14:30', 'P0285', 'F00016', 'PA02'),
        ('H00020', '14:30', '15:00', 'P0017', 'F00016', 'PA02'),
        ('H00021', '15:00', '16:00', 'P0013', 'F00016', 'PA02'),
        ('H00022', '16:00', '17:00', 'P0070', 'F00016', 'PA02'),
        ('H00023', '17:00', '17:30', 'P0149', 'F00016', 'PA02'),
        ('H00024', '17:30', '18:00', 'P0175', 'F00016', 'PA02'),
        ('H00025', '18:00', '18:05', 'P0006', 'F00016', 'PA02'),
        ('H00026', '18:05', '18:30', 'P0165', 'F00016', 'PA02'),
        ('H00027', '18:30', '19:00', 'P0231', 'F00016', 'PA02'),
        ('H00028', '19:00', '19:05', 'P0005', 'F00016', 'PA02'),
        ('H00029', '19:05', '20:00', 'P0084', 'F00016', 'PA02'),
        ('H00030', '20:00', '20:05', 'P0048', 'F00016', 'PA02'),
        ('H00031', '20:05', '21:00', 'P0265', 'F00016', 'PA02'),
        ('H00032', '21:00', '22:00', 'P0282', 'F00016', 'PA02'),
        ('H00033', '22:00', '23:00', 'P0186', 'F00016', 'PA02'),
        ('H00034', '23:00', '00:00', 'P0285', 'F00016', 'PA02'),
        ('H00035', '00:00', '00:05', 'P0286', 'F00017', 'PA02'),
        ('H00036', '00:05', '02:45', 'P0287', 'F00017', 'PA02'),
        ('H00037', '02:45', '03:15', 'P0033', 'F00017', 'PA02'),
        ('H00038', '03:15', '03:45', 'P0006', 'F00017', 'PA02'),
        ('H00039', '03:45', '04:15', 'P0040', 'F00017', 'PA02'),
        ('H00040', '04:15', '04:30', 'P0282', 'F00017', 'PA02'),
        ('H00041', '04:30', '05:00', 'P0086', 'F00017', 'PA02'),
        ('H00042', '05:00', '05:30', 'P0048', 'F00017', 'PA02'),
        ('H00043', '05:30', '06:00', 'P0083', 'F00017', 'PA02'),
        ('H00044', '06:00', '06:05', 'P0169', 'F00017', 'PA02'),
        ('H00045', '06:05', '07:30', 'P0167', 'F00017', 'PA02'),
        ('H00046', '07:30', '09:30', 'P0280', 'F00017', 'PA02'),
        ('H00047', '09:30', '11:30', 'P0198', 'F00017', 'PA02'),
        ('H00048', '11:30', '12:00', 'P0001', 'F00017', 'PA02'),
        ('H00049', '12:00', '12:05', 'P0286', 'F00017', 'PA02'),
        ('H00050', '12:05', '13:45', 'P0176', 'F00017', 'PA02'),
        ('H00051', '13:45', '14:00', 'P0253', 'F00017', 'PA02'),
        ('H00052', '14:00', '14:30', 'P0251', 'F00017', 'PA02'),
        ('H00053', '14:30', '15:00', 'P0196', 'F00017', 'PA02'),
        ('H00054', '15:00', '16:00', 'P0241', 'F00017', 'PA02'),
        ('H00055', '16:00', '17:00', 'P0057', 'F00017', 'PA02'),
        ('H00056', '17:00', '17:30', 'P0039', 'F00017', 'PA02'),
        ('H00057', '17:30', '18:00', 'P0049', 'F00017', 'PA02'),
        ('H00058', '18:00', '18:05', 'P0164', 'F00017', 'PA02'),
        ('H00059', '18:05', '18:30', 'P0114', 'F00017', 'PA02'),
        ('H00060', '18:30', '19:00', 'P0101', 'F00017', 'PA02'),
        ('H00061', '19:00', '19:05', 'P0096', 'F00017', 'PA02'),
        ('H00062', '19:05', '20:00', 'P0201', 'F00017', 'PA02'),
        ('H00063', '20:00', '20:05', 'P0202', 'F00017', 'PA02'),
        ('H00064', '20:05', '21:00', 'P0195', 'F00017', 'PA02'),
        ('H00065', '21:00', '22:00', 'P0219', 'F00017', 'PA02'),
        ('H00066', '22:00', '23:00', 'P0240', 'F00017', 'PA02'),
        ('H00067', '23:00', '00:00', 'P0266', 'F00017', 'PA02'),
        ('H00068', '00:00', '00:05', 'P0286', 'F00017', 'PA02'),
        ('H00069', '00:05', '01:00', 'P0087', 'F00018', 'PA02'),
        ('H00070', '01:00', '02:45', 'P0038', 'F00018', 'PA02'),
        ('H00071', '02:45', '03:15', 'P0266', 'F00018', 'PA02'),
        ('H00072', '03:15', '03:45', 'P0186', 'F00018', 'PA02'),
        ('H00073', '03:45', '04:15', 'P0034', 'F00018', 'PA02'),
        ('H00074', '04:15', '04:30', 'P0041', 'F00018', 'PA02'),
		('H00075', '04:30', '05:00', 'P0006', 'F00018', 'PA02'),
        ('H00076', '05:00', '05:30', 'P0044', 'F00018', 'PA02'),
        ('H00077', '05:30', '06:00', 'P0047', 'F00018', 'PA02'),
        ('H00078', '06:00', '06:05', 'P0040', 'F00018', 'PA02'),
        ('H00079', '06:05', '07:30', 'P0033', 'F00018', 'PA02'),
        ('H00080', '07:30', '09:30', 'P0083', 'F00018', 'PA02'),
        ('H00081', '09:30', '11:30', 'P0081', 'F00018', 'PA02'),
        ('H00082', '11:30', '12:00', 'P0070', 'F00018', 'PA02'),
        ('H00083', '12:00', '12:05', 'P0286', 'F00018', 'PA02'),
        ('H00084', '12:05', '13:45', 'P0007', 'F00018', 'PA02'),
        ('H00085', '13:45', '14:00', 'P0069', 'F00018', 'PA02'),
        ('H00086', '14:00', '14:30', 'P0068', 'F00018', 'PA02'),
        ('H00087', '14:30', '15:00', 'P0070', 'F00018', 'PA02'),
        ('H00088', '15:00', '16:00', 'P0074', 'F00018', 'PA02'),
        ('H00089', '16:00', '17:00', 'P0201', 'F00018', 'PA02'),
        ('H00090', '17:00', '17:30', 'P0233', 'F00018', 'PA02'),
        ('H00091', '17:30', '18:00', 'P0235', 'F00018', 'PA02'),
        ('H00092', '18:00', '18:05', 'P0171', 'F00018', 'PA02'),
        ('H00093', '18:05', '18:30', 'P0176', 'F00018', 'PA02'),
        ('H00094', '18:30', '19:00', 'P0177', 'F00018', 'PA02'),
        ('H00095', '19:00', '19:05', 'P0275', 'F00018', 'PA02'),
        ('H00096', '19:05', '20:00', 'P0284', 'F00018', 'PA02'),
        ('H00097', '20:00', '20:05', 'P0180', 'F00018', 'PA02'),
        ('H00098', '20:05', '21:00', 'P0271', 'F00018', 'PA02'),
        ('H00099', '21:00', '22:00', 'P0287', 'F00018', 'PA02'),
        ('H00100', '22:00', '23:00', 'P0178', 'F00018', 'PA02'),
        ('H00101', '23:00', '00:00', 'P0266', 'F00018', 'PA02'),
        ('H00102', '00:00', '00:05', 'P0286', 'F00019', 'PA02'),
        ('H00103', '00:05', '02:45', 'P0274', 'F00019', 'PA02'),
        ('H00104', '02:45', '03:15', 'P0277', 'F00019', 'PA02'),
        ('H00105', '03:15', '03:45', 'P0186', 'F00019', 'PA02'),
        ('H00106', '03:45', '04:15', 'P0038', 'F00019', 'PA02'),
        ('H00107', '04:15', '04:30', 'P0002', 'F00019', 'PA02'),
        ('H00108', '04:30', '05:00', 'P0040', 'F00019', 'PA02'),
        ('H00109', '05:00', '05:30', 'P0024', 'F00019', 'PA02'),
        ('H00110', '05:30', '06:00', 'P0089', 'F00019', 'PA02'),
        ('H00111', '06:00', '06:05', 'P0093', 'F00019', 'PA02'),
        ('H00112', '06:05', '07:30', 'P0089', 'F00019', 'PA02'),
        ('H00113', '07:30', '09:30', 'P0280', 'F00019', 'PA02'),
        ('H00114', '09:30', '11:30', 'P0164', 'F00019', 'PA02'),
        ('H00115', '11:30', '12:00', 'P0066', 'F00019', 'PA02'),
        ('H00116', '12:00', '12:05', 'P0286', 'F00019', 'PA02'),
        ('H00117', '12:05', '13:45', 'P0016', 'F00019', 'PA02'),
        ('H00118', '13:45', '14:00', 'P0142', 'F00019', 'PA02'),
        ('H00119', '14:00', '14:30', 'P0065', 'F00019', 'PA02'),
        ('H00120', '14:30', '15:00', 'P0106', 'F00019', 'PA02'),
        ('H00121', '15:00', '16:00', 'P0117', 'F00019', 'PA02'),
        ('H00122', '16:00', '17:00', 'P0101', 'F00019', 'PA02'),
        ('H00123', '17:00', '17:30', 'P0164', 'F00019', 'PA02'),
        ('H00124', '17:30', '18:00', 'P0270', 'F00019', 'PA02'),
        ('H00125', '18:00', '18:05', 'P0039', 'F00019', 'PA02'),
        ('H00126', '18:05', '18:30', 'P0244', 'F00019', 'PA02'),
        ('H00127', '18:30', '19:00', 'P0039', 'F00019', 'PA02'),
        ('H00128', '19:00', '19:05', 'P0252', 'F00019', 'PA02'),
        ('H00129', '19:05', '20:00', 'P0096', 'F00019', 'PA02'),
        ('H00130', '20:00', '20:05', 'P0257', 'F00019', 'PA02'),
        ('H00131', '20:05', '21:00', 'P0262', 'F00019', 'PA02'),
        ('H00132', '21:00', '22:00', 'P0177', 'F00019', 'PA02'),
        ('H00133', '22:00', '23:00', 'P0081', 'F00019', 'PA02'),
        ('H00134', '23:00', '00:00', 'P0213', 'F00019', 'PA02'),
        ('H00135', '00:00', '00:05', 'P0286', 'F00020', 'PA02'),
        ('H00136', '00:05', '01:00', 'P0059', 'F00020', 'PA02'),
        ('H00137', '01:00', '02:45', 'P0085', 'F00020', 'PA02'),
        ('H00138', '02:45', '03:15', 'P0003', 'F00020', 'PA02'),
        ('H00139', '03:15', '03:45', 'P0059', 'F00020', 'PA02'),
        ('H00140', '03:45', '04:15', 'P0189', 'F00020', 'PA02'),
        ('H00141', '04:15', '04:30', 'P0195', 'F00020', 'PA02'),
        ('H00142', '04:30', '05:00', 'P0252', 'F00020', 'PA02'),
        ('H00143', '05:00', '05:30', 'P0084', 'F00020', 'PA02'),
        ('H00144', '05:30', '06:00', 'P0145', 'F00020', 'PA02'),
        ('H00145', '06:00', '06:05', 'P0129', 'F00020', 'PA02'),
        ('H00146', '06:05', '07:30', 'P0131', 'F00020', 'PA02'),
        ('H00147', '07:30', '09:30', 'P0280', 'F00020', 'PA02'),
        ('H00148', '09:30', '11:30', 'P0117', 'F00020', 'PA02'),
        ('H00149', '11:30', '12:00', 'P0152', 'F00020', 'PA02'),
        ('H00150', '12:00', '12:05', 'P0103', 'F00020', 'PA02'),
        ('H00151', '12:05', '13:45', 'P0165', 'F00020', 'PA02'),
        ('H00152', '13:45', '14:00', 'P0109', 'F00020', 'PA02'),
        ('H00153', '14:00', '14:30', 'P0261', 'F00020', 'PA02'),
        ('H00154', '14:30', '15:00', 'P0177', 'F00020', 'PA02'),
        ('H00155', '15:00', '16:00', 'P0073', 'F00020', 'PA02'),
        ('H00156', '16:00', '17:00', 'P0017', 'F00020', 'PA02'),
        ('H00157', '17:00', '17:30', 'P0073', 'F00020', 'PA02'),
        ('H00158', '17:30', '18:00', 'P0086', 'F00020', 'PA02'),
        ('H00159', '18:00', '18:05', 'P0096', 'F00020', 'PA02'),
        ('H00160', '18:05', '18:30', 'P0189', 'F00020', 'PA02'),
        ('H00161', '18:30', '19:00', 'P0195', 'F00020', 'PA02'),
        ('H00162', '19:00', '19:05', 'P0220', 'F00020', 'PA02'),
        ('H00163', '19:05', '20:00', 'P0235', 'F00020', 'PA02'),
        ('H00164', '20:00', '20:05', 'P0197', 'F00020', 'PA02'),
        ('H00165', '20:05', '21:00', 'P0219', 'F00020', 'PA02'),
        ('H00166', '21:00', '22:00', 'P0207', 'F00020', 'PA02'),
        ('H00167', '22:00', '23:00', 'P0096', 'F00020', 'PA02'),
        ('H00168', '23:00', '00:00', 'P0038', 'F00020', 'PA02'),
        ('H00169', '00:00', '00:05', 'P0286', 'F00021', 'PA02'),
        ('H00170', '00:05', '02:45', 'P0056', 'F00021', 'PA02'),
        ('H00171', '02:45', '03:15', 'P0004', 'F00021', 'PA02'),
        ('H00172', '03:15', '03:45', 'P0224', 'F00021', 'PA02'),
        ('H00173', '03:45', '04:15', 'P0003', 'F00021', 'PA02'),
        ('H00174', '04:15', '04:30', 'P0227', 'F00021', 'PA02'),
        ('H00175', '04:30', '05:00', 'P0222', 'F00021', 'PA02'),
        ('H00176', '05:00', '05:30', 'P0264', 'F00021', 'PA02'),
        ('H00177', '05:30', '06:00', 'P0187', 'F00021', 'PA02'),
        ('H00178', '06:00', '06:05', 'P0024', 'F00021', 'PA02'),
        ('H00179', '06:05', '07:30', 'P0173', 'F00021', 'PA02'),
        ('H00180', '07:30', '09:30', 'P0280', 'F00021', 'PA02'),
        ('H00181', '09:30', '11:30', 'P0210', 'F00021', 'PA02'),
        ('H00182', '11:30', '12:00', 'P0047', 'F00021', 'PA02'),
        ('H00183', '12:00', '12:05', 'P0286', 'F00021', 'PA02'),
        ('H00184', '12:05', '13:45', 'P0024', 'F00021', 'PA02'),
        ('H00185', '13:45', '14:00', 'P0093', 'F00021', 'PA02'),
        ('H00186', '14:00', '14:30', 'P0040', 'F00021', 'PA02'),
        ('H00187', '14:30', '15:00', 'P0237', 'F00021', 'PA02'),
        ('H00188', '15:00', '16:00', 'P0270', 'F00021', 'PA02'),
        ('H00189', '16:00', '17:00', 'P0189', 'F00021', 'PA02'),
        ('H00190', '17:00', '17:30', 'P0195', 'F00021', 'PA02'),
        ('H00191', '17:30', '18:00', 'P0253', 'F00021', 'PA02'),
        ('H00192', '18:00', '18:05', 'P0261', 'F00021', 'PA02'),
        ('H00193', '18:05', '18:30', 'P0098', 'F00021', 'PA02'),
        ('H00194', '18:30', '19:00', 'P0177', 'F00021', 'PA02'),
        ('H00195', '19:00', '19:05', 'P0213', 'F00021', 'PA02'),
        ('H00196', '19:05', '20:00', 'P0247', 'F00021', 'PA02'),
        ('H00197', '20:00', '20:05', 'P0248', 'F00021', 'PA02'),
        ('H00198', '20:05', '21:00', 'P0084', 'F00021', 'PA02'),
        ('H00199', '21:00', '22:00', 'P0041', 'F00021', 'PA02'),
        ('H00200', '22:00', '23:00', 'P0230', 'F00021', 'PA02'),
        ('H00201', '23:00', '00:00', 'P0264', 'F00021', 'PA02'),
        ('H00202', '00:00', '02:45', 'P0287', 'F00022', 'PA02'),
        ('H00203', '02:45', '03:15', 'P0235', 'F00022', 'PA02'),
        ('H00204', '03:15', '03:45', 'P0287', 'F00022', 'PA02'),
        ('H00205', '03:45', '04:15', 'P0219', 'F00022', 'PA02'),
        ('H00206', '04:15', '04:30', 'P0244', 'F00022', 'PA02'),
        ('H00207', '04:30', '05:00', 'P0058', 'F00022', 'PA02'),
        ('H00208', '05:00', '05:30', 'P0263', 'F00022', 'PA02'),
        ('H00209', '05:30', '06:00', 'P0262', 'F00022', 'PA02'),
        ('H00210', '06:00', '06:05', 'P0044', 'F00022', 'PA02'),
        ('H00211', '06:05', '07:30', 'P0281', 'F00022', 'PA02'),
        ('H00212', '07:30', '09:30', 'P0002', 'F00022', 'PA02'),
        ('H00213', '09:30', '11:30', 'P0176', 'F00022', 'PA02'),
        ('H00214', '11:30', '12:00', 'P0248', 'F00022', 'PA02'),
        ('H00215', '12:00', '12:05', 'P0110', 'F00022', 'PA02'),
        ('H00216', '12:05', '13:45', 'P0128', 'F00022', 'PA02'),
        ('H00217', '13:45', '14:00', 'P0117', 'F00022', 'PA02'),
        ('H00218', '14:00', '14:30', 'P0138', 'F00022', 'PA02'),
        ('H00219', '14:30', '15:00', 'P0069', 'F00022', 'PA02'),
        ('H00220', '15:00', '16:00', 'P0103', 'F00022', 'PA02'),
        ('H00221', '16:00', '17:00', 'P0165', 'F00022', 'PA02'),
        ('H00222', '17:00', '17:30', 'P0118', 'F00022', 'PA02'),
        ('H00223', '17:30', '18:00', 'P0057', 'F00022', 'PA02'),
        ('H00224', '18:00', '18:05', 'P0049', 'F00022', 'PA02'),
        ('H00225', '18:05', '18:30', 'P0275', 'F00022', 'PA02'),
        ('H00226', '18:30', '19:00', 'P0220', 'F00022', 'PA02'),
        ('H00227', '19:00', '19:05', 'P0201', 'F00022', 'PA02'),
        ('H00228', '19:05', '20:00', 'P0096', 'F00022', 'PA02'),
        ('H00229', '20:00', '20:05', 'P0194', 'F00022', 'PA02'),
        ('H00230', '20:05', '21:00', 'P0203', 'F00022', 'PA02'),
        ('H00231', '21:00', '22:00', 'P0084', 'F00022', 'PA02'),
        ('H00232', '22:00', '23:00', 'P0096', 'F00022', 'PA02'),
        ('H00233', '23:00', '00:00', 'P0086', 'F00022', 'PA02');       
        select * from horarioNacional;


INSERT INTO horarioInternacional(idHorarioI, hora_Inicio, hora_fin, idPrograma, idFecha, idPais) VALUES  
--  FECHA: 'F00016', '2023-12-25'
        ('HI0001', '12:00', '01:30', 'P0287', 'F00016', 'PA01'),
        ('HI0002', '01:30', '02:00', 'P0263', 'F00016', 'PA01'),
        ('HI0003', '02:00', '02:30', 'P0081', 'F00016', 'PA01'),
        ('HI0004', '02:30', '03:45', 'P0053', 'F00016', 'PA01'),
        ('HI0005', '03:45', '04:00', 'P0140', 'F00016', 'PA01'),
        ('HI0006', '04:00', '04:30', 'P0091', 'F00016', 'PA01'),
        ('HI0007', '04:30', '05:00', 'P0055', 'F00016', 'PA01'),
        ('HI0008', '05:00', '05:30', 'P0054', 'F00016', 'PA01'),
        ('HI0009', '05:30', '06:05', 'P0026', 'F00016', 'PA01'),
        ('HI0010', '06:05', '07:30', 'P0104', 'F00016', 'PA01'),
        ('HI0011', '07:30', '08:30', 'P0104', 'F00016', 'PA01'),
        ('HI0012', '08:30', '09:00', 'P0231', 'F00016', 'PA01'),
        ('HI0013', '09:00', '09:10', 'P0280', 'F00016', 'PA01'),
        ('HI0014', '09:10', '09:30', 'P0020', 'F00016', 'PA01'),
        ('HI0015', '09:30', '11:30', 'P0053', 'F00016', 'PA01'),
        ('HI0016', '11:30', '12:00', 'P0054', 'F00016', 'PA01'),
        ('HI0017', '12:00', '12:30', 'P0001', 'F00016', 'PA01'),
        ('HI0018', '12:30', '13:00', 'P0007', 'F00016', 'PA01'),
        ('HI0019', '13:00', '14:00', 'P0084', 'F00016', 'PA01'),
        ('HI0020', '14:00', '14:30', 'P0285', 'F00016', 'PA01'),
        ('HI0021', '14:30', '15:00', 'P0091', 'F00016', 'PA01'),
        ('HI0022', '15:00', '16:00', 'P0210', 'F00016', 'PA01'),
        ('HI0023', '16:00', '16:15', 'P0157', 'F00016', 'PA01'),
        ('HI0024', '16:15', '16:30', 'P0134', 'F00016', 'PA01'),
        ('HI0025', '16:30', '16:45', 'P0136', 'F00016', 'PA01'),
        ('HI0026', '16:45', '17:00', 'P0128', 'F00016', 'PA01'),
        ('HI0027', '17:00', '17:30', 'P0149', 'F00016', 'PA01'),
        ('HI0028', '17:30', '18:00', 'P0175', 'F00016', 'PA01'),
        ('HI0029', '18:00', '18:30', 'P0165', 'F00016', 'PA01'),
        ('HI0030', '18:30', '19:00', 'P0231', 'F00016', 'PA01'),
        ('HI0031', '19:00', '20:00', 'P0084', 'F00016', 'PA01'),
        ('HI0032', '20:00', '21:00', 'P0276', 'F00016', 'PA01'),
        ('HI0033', '21:00', '22:00', 'P0082', 'F00016', 'PA01'),
        ('HI0034', '22:00', '23:00', 'P0001', 'F00016', 'PA01'),
        ('HI0035', '23:00', '00:00', 'P0285', 'F00016', 'PA01'),
--  FECHA: 'F00017', '2023-12-26'
        ('HI0036', '12:00', '01:30', 'P0287', 'F00017', 'PA01'),
        ('HI0037', '01:30', '02:00', 'P0263', 'F00017', 'PA01'),
        ('HI0038', '02:00', '02:30', 'P0002', 'F00017', 'PA01'),
        ('HI0039', '02:30', '03:45', 'P0081', 'F00017', 'PA01'),
        ('HI0040', '03:45', '04:00', 'P0180', 'F00017', 'PA01'),
        ('HI0041', '04:00', '04:30', 'P0091', 'F00017', 'PA01'),
        ('HI0042', '04:30', '05:00', 'P0196', 'F00017', 'PA01'),
        ('HI0043', '05:00', '05:30', 'P0098', 'F00017', 'PA01'),
        ('HI0044', '05:30', '06:05', 'P0047', 'F00017', 'PA01'),
        ('HI0045', '06:05', '07:30', 'P0073', 'F00017', 'PA01'),
        ('HI0046', '07:30', '08:30', 'P0167', 'F00017', 'PA01'),
        ('HI0047', '08:30', '09:00', 'P0173', 'F00017', 'PA01'),
        ('HI0048', '09:00', '09:10', 'P0213', 'F00017', 'PA01'),
        ('HI0049', '09:10', '09:30', 'P0215', 'F00017', 'PA01'),
        ('HI0050', '09:30', '11:30', 'P0237', 'F00017', 'PA01'),
        ('HI0051', '11:30', '12:00', 'P0054', 'F00017', 'PA01'),
        ('HI0052', '12:00', '12:30', 'P0001', 'F00017', 'PA01'),
        ('HI0053', '12:30', '13:00', 'P0257', 'F00017', 'PA01'),
        ('HI0054', '13:00', '14:00', 'P0260', 'F00017', 'PA01'),
        ('HI0055', '14:00', '14:30', 'P0237', 'F00017', 'PA01'),
        ('HI0056', '14:30', '15:00', 'P0213', 'F00017', 'PA01'),
        ('HI0057', '15:00', '16:00', 'P0009', 'F00017', 'PA01'),
        ('HI0058', '16:00', '16:15', 'P0047', 'F00017', 'PA01'),
        ('HI0059', '16:15', '16:30', 'P0081', 'F00017', 'PA01'),
        ('HI0060', '16:30', '16:45', 'P0093', 'F00017', 'PA01'),
        ('HI0061', '16:45', '17:00', 'P0167', 'F00017', 'PA01'),
        ('HI0062', '17:00', '17:30', 'P0080', 'F00017', 'PA01'),
        ('HI0063', '17:30', '18:00', 'P0099', 'F00017', 'PA01'),
        ('HI0064', '18:00', '18:30', 'P0111', 'F00017', 'PA01'),
        ('HI0065', '18:30', '19:00', 'P0112', 'F00017', 'PA01'),
        ('HI0066', '19:00', '20:00', 'P0084', 'F00017', 'PA01'),
        ('HI0067', '20:00', '21:00', 'P0276', 'F00017', 'PA01'),
        ('HI0068', '21:00', '22:00', 'P0283', 'F00017', 'PA01'),
        ('HI0069', '22:00', '23:00', 'P0256', 'F00017', 'PA01'),
        ('HI0070', '23:00', '00:00', 'P0285', 'F00017', 'PA01'), 
        --  FECHA: 'F00018', '2023-12-27'
        ('HI0071', '12:00', '01:30', 'P0287', 'F00018', 'PA01'),
        ('HI0072', '01:30', '02:00', 'P0263', 'F00018', 'PA01'),
        ('HI0073', '02:00', '02:30', 'P0256', 'F00018', 'PA01'),
        ('HI0074', '02:30', '03:45', 'P0153', 'F00018', 'PA01'),
        ('HI0075', '03:45', '04:00', 'P0050', 'F00018', 'PA01'),
        ('HI0076', '04:00', '04:30', 'P0090', 'F00018', 'PA01'),
        ('HI0077', '04:30', '05:00', 'P0199', 'F00018', 'PA01'),
        ('HI0078', '05:00', '05:30', 'P0034', 'F00018', 'PA01'),
        ('HI0079', '05:30', '06:05', 'P0003', 'F00018', 'PA01'),
        ('HI0080', '06:05', '07:30', 'P0187', 'F00018', 'PA01'),
        ('HI0081', '07:30', '08:30', 'P0222', 'F00018', 'PA01'),
        ('HI0082', '08:30', '09:00', 'P0216', 'F00018', 'PA01'),
        ('HI0083', '09:00', '09:10', 'P0230', 'F00018', 'PA01'),
        ('HI0084', '09:10', '09:30', 'P0264', 'F00018', 'PA01'),
        ('HI0085', '09:30', '11:30', 'P0199', 'F00018', 'PA01'),
        ('HI0086', '11:30', '12:00', 'P0004', 'F00018', 'PA01'),
        ('HI0087', '12:00', '12:30', 'P0056', 'F00018', 'PA01'),
        ('HI0088', '12:30', '13:00', 'P0059', 'F00018', 'PA01'),
        ('HI0089', '13:00', '14:00', 'P0187', 'F00018', 'PA01'),
        ('HI0090', '14:00', '14:30', 'P0206', 'F00018', 'PA01'),
        ('HI0091', '14:30', '15:00', 'P0240', 'F00018', 'PA01'),
        ('HI0092', '15:00', '16:00', 'P0254', 'F00018', 'PA01'),
        ('HI0093', '16:00', '16:15', 'P0047', 'F00018', 'PA01'),
        ('HI0094', '16:15', '16:30', 'P0081', 'F00018', 'PA01'),
        ('HI0095', '16:30', '16:45', 'P0093', 'F00018', 'PA01'),
        ('HI0096', '16:45', '17:00', 'P0167', 'F00018', 'PA01'),
        ('HI0097', '17:00', '17:30', 'P0110', 'F00018', 'PA01'),
        ('HI0098', '17:30', '18:00', 'P0112', 'F00018', 'PA01'),
        ('HI0099', '18:00', '18:30', 'P0110', 'F00018', 'PA01'),
        ('HI0100', '18:30', '19:00', 'P0120', 'F00018', 'PA01'),
        ('HI0101', '19:00', '20:00', 'P0125', 'F00018', 'PA01'),
        ('HI0102', '20:00', '21:00', 'P0129', 'F00018', 'PA01'),
        ('HI0103', '21:00', '22:00', 'P0208', 'F00018', 'PA01'),
        ('HI0104', '22:00', '23:00', 'P0256', 'F00018', 'PA01'),
        ('HI0105', '23:00', '00:00', 'P0285', 'F00018', 'PA01'),
--  FECHA: 'F00019', '2023-12-28'
        ('HI0106', '12:00', '01:30', 'P0287', 'F00019', 'PA01'),
        ('HI0107', '01:30', '02:00', 'P0263', 'F00019', 'PA01'),
        ('HI0108', '02:00', '02:30', 'P0274', 'F00019', 'PA01'),
        ('HI0109', '02:30', '03:45', 'P0274', 'F00019', 'PA01'),
        ('HI0110', '03:45', '04:00', 'P0277', 'F00019', 'PA01'),
        ('HI0111', '04:00', '04:30', 'P0006', 'F00019', 'PA01'),
        ('HI0112', '04:30', '05:00', 'P0048', 'F00019', 'PA01'),
        ('HI0113', '05:00', '05:30', 'P0098', 'F00019', 'PA01'),
        ('HI0114', '05:30', '06:05', 'P0189', 'F00019', 'PA01'),
        ('HI0115', '06:05', '07:30', 'P0187', 'F00019', 'PA01'),
        ('HI0116', '07:30', '08:30', 'P0222', 'F00019', 'PA01'),
        ('HI0117', '08:30', '09:00', 'P0173', 'F00019', 'PA01'),
        ('HI0118', '09:00', '09:10', 'P0170', 'F00019', 'PA01'),
        ('HI0119', '09:10', '09:30', 'P0047', 'F00019', 'PA01'),
        ('HI0120', '09:30', '11:30', 'P0017', 'F00019', 'PA01'),
        ('HI0121', '11:30', '12:00', 'P0006', 'F00019', 'PA01'),
        ('HI0122', '12:00', '12:30', 'P0024', 'F00019', 'PA01'),
        ('HI0123', '12:30', '13:00', 'P0081', 'F00019', 'PA01'),
        ('HI0124', '13:00', '14:00', 'P0187', 'F00019', 'PA01'),
        ('HI0125', '14:00', '14:30', 'P0210', 'F00019', 'PA01'),
        ('HI0126', '14:30', '15:00', 'P0221', 'F00019', 'PA01'),
        ('HI0127', '15:00', '16:00', 'P0237', 'F00019', 'PA01'),
        ('HI0128', '16:00', '16:15', 'P0047', 'F00019', 'PA01'),
        ('HI0129', '16:15', '16:30', 'P0081', 'F00019', 'PA01'),
        ('HI0130', '16:30', '16:45', 'P0093', 'F00019', 'PA01'),
        ('HI0131', '16:45', '17:00', 'P0053', 'F00019', 'PA01'),
        ('HI0132', '17:00', '17:30', 'P0248', 'F00019', 'PA01'),
        ('HI0133', '17:30', '18:00', 'P0112', 'F00019', 'PA01'),
        ('HI0134', '18:00', '18:30', 'P0110', 'F00019', 'PA01'),
        ('HI0135', '18:30', '19:00', 'P0016', 'F00019', 'PA01'),
        ('HI0136', '19:00', '20:00', 'P0061', 'F00019', 'PA01'),
        ('HI0137', '20:00', '21:00', 'P0062', 'F00019', 'PA01'),
        ('HI0138', '21:00', '22:00', 'P0107', 'F00019', 'PA01'),
        ('HI0139', '22:00', '23:00', 'P0108', 'F00019', 'PA01'),
        ('HI0140', '23:00', '00:00', 'P0285', 'F00019', 'PA01'),
--  FECHA: 'F00020', '2023-12-29'
        ('HI0141', '12:00', '01:30', 'P0287', 'F00020', 'PA01'),
        ('HI0142', '01:30', '02:00', 'P0105', 'F00020', 'PA01'),
        ('HI0143', '02:00', '02:30', 'P0109', 'F00020', 'PA01'),
        ('HI0144', '02:30', '03:45', 'P0111', 'F00020', 'PA01'),
        ('HI0145', '03:45', '04:00', 'P0123', 'F00020', 'PA01'),
        ('HI0146', '04:00', '04:30', 'P0126', 'F00020', 'PA01'),
        ('HI0147', '04:30', '05:00', 'P0209', 'F00020', 'PA01'),
        ('HI0148', '05:00', '05:30', 'P0273', 'F00020', 'PA01'),
        ('HI0149', '05:30', '06:05', 'P0158', 'F00020', 'PA01'),
        ('HI0150', '06:05', '07:30', 'P0152', 'F00020', 'PA01'),
        ('HI0151', '07:30', '08:30', 'P0079', 'F00020', 'PA01'),
        ('HI0152', '08:30', '09:00', 'P0228', 'F00020', 'PA01'),
        ('HI0153', '09:00', '09:10', 'P0255', 'F00020', 'PA01'),
        ('HI0154', '09:10', '09:30', 'P0155', 'F00020', 'PA01'),
        ('HI0155', '09:30', '11:30', 'P0137', 'F00020', 'PA01'),
        ('HI0156', '11:30', '12:00', 'P0120', 'F00020', 'PA01'),
        ('HI0157', '12:00', '12:30', 'P0099', 'F00020', 'PA01'),
        ('HI0158', '12:30', '13:00', 'P0109', 'F00020', 'PA01'),
        ('HI0159', '13:00', '14:00', 'P0123', 'F00020', 'PA01'),
        ('HI0160', '14:00', '14:30', 'P0107', 'F00020', 'PA01'),
        ('HI0161', '14:30', '15:00', 'P0092', 'F00020', 'PA01'),
        ('HI0162', '15:00', '16:00', 'P0122', 'F00020', 'PA01'),
        ('HI0163', '16:00', '16:15', 'P0127', 'F00020', 'PA01'),
        ('HI0164', '16:15', '16:30', 'P0145', 'F00020', 'PA01'),
        ('HI0165', '16:30', '16:45', 'P0093', 'F00020', 'PA01'),
        ('HI0166', '16:45', '17:00', 'P0053', 'F00020', 'PA01'),
        ('HI0167', '17:00', '17:30', 'P0248', 'F00020', 'PA01'),
        ('HI0168', '17:30', '18:00', 'P0112', 'F00020', 'PA01'),
        ('HI0169', '18:00', '18:30', 'P0110', 'F00020', 'PA01'),
        ('HI0170', '18:30', '19:00', 'P0165', 'F00020', 'PA01'),
        ('HI0171', '19:00', '20:00', 'P0228', 'F00020', 'PA01'),
        ('HI0172', '20:00', '21:00', 'P0255', 'F00020', 'PA01'),
        ('HI0173', '21:00', '22:00', 'P0273', 'F00020', 'PA01'),
        ('HI0174', '22:00', '23:00', 'P0108', 'F00020', 'PA01'),
        ('HI0175', '23:00', '00:00', 'P0285', 'F00020', 'PA01'),
--  FECHA: 'F00021', '2023-12-30'
        ('HI0176', '12:00', '01:30', 'P0287', 'F00021', 'PA01'),
        ('HI0177', '01:30', '02:00', 'P0229', 'F00021', 'PA01'),
        ('HI0178', '02:00', '02:30', 'P0239', 'F00021', 'PA01'),
        ('HI0179', '02:30', '03:45', 'P0260', 'F00021', 'PA01'),
        ('HI0180', '03:45', '04:00', 'P0262', 'F00021', 'PA01'),
        ('HI0181', '04:00', '04:30', 'P0237', 'F00021', 'PA01'),
        ('HI0182', '04:30', '05:00', 'P0223', 'F00021', 'PA01'),
        ('HI0183', '05:00', '05:30', 'P0083', 'F00021', 'PA01'),
        ('HI0184', '05:30', '06:05', 'P0009', 'F00021', 'PA01'),
        ('HI0185', '06:05', '07:30', 'P0001', 'F00021', 'PA01'),
        ('HI0186', '07:30', '08:30', 'P0020', 'F00021', 'PA01'),
        ('HI0187', '08:30', '09:00', 'P0061', 'F00021', 'PA01'),
        ('HI0188', '09:00', '09:10', 'P0075', 'F00021', 'PA01'),
        ('HI0189', '09:10', '09:30', 'P0097', 'F00021', 'PA01'),
        ('HI0190', '09:30', '11:30', 'P0123', 'F00021', 'PA01'),
        ('HI0191', '11:30', '12:00', 'P0129', 'F00021', 'PA01'),
        ('HI0192', '12:00', '12:30', 'P0128', 'F00021', 'PA01'),
        ('HI0193', '12:30', '13:00', 'P0111', 'F00021', 'PA01'),
        ('HI0194', '13:00', '14:00', 'P0066', 'F00021', 'PA01'),
        ('HI0195', '14:00', '14:30', 'P0007', 'F00021', 'PA01'),
        ('HI0196', '14:30', '15:00', 'P0069', 'F00021', 'PA01'),
        ('HI0197', '15:00', '16:00', 'P0103', 'F00021', 'PA01'),
        ('HI0198', '16:00', '16:15', 'P0127', 'F00021', 'PA01'),
        ('HI0199', '16:15', '16:30', 'P0145', 'F00021', 'PA01'),
        ('HI0200', '16:30', '16:45', 'P0093', 'F00021', 'PA01'),
        ('HI0201', '16:45', '17:00', 'P0053', 'F00021', 'PA01'),
        ('HI0202', '17:00', '17:30', 'P0248', 'F00021', 'PA01'),
        ('HI0203', '17:30', '18:00', 'P0112', 'F00021', 'PA01'),
        ('HI0204', '18:00', '18:30', 'P0110', 'F00021', 'PA01'),
        ('HI0205', '18:30', '19:00', 'P0165', 'F00021', 'PA01'),
        ('HI0206', '19:00', '20:00', 'P0228', 'F00021', 'PA01'),
        ('HI0207', '20:00', '21:00', 'P0265', 'F00021', 'PA01'),
        ('HI0208', '21:00', '22:00', 'P0266', 'F00021', 'PA01'),
        ('HI0209', '22:00', '23:00', 'P0282', 'F00021', 'PA01'),
        ('HI0210', '23:00', '00:00', 'P0285', 'F00021', 'PA01'),
--  FECHA: 'F00022', '2023-12-31'
        ('HI0211', '12:00', '01:30', 'P0287', 'F00022', 'PA01'),
        ('HI0212', '01:30', '02:00', 'P0274', 'F00022', 'PA01'),
        ('HI0213', '02:00', '02:30', 'P0277', 'F00022', 'PA01'),
        ('HI0214', '02:30', '03:45', 'P0186', 'F00022', 'PA01'),
        ('HI0215', '03:45', '04:00', 'P0038', 'F00022', 'PA01'),
        ('HI0216', '04:00', '04:30', 'P0265', 'F00022', 'PA01'),
        ('HI0217', '04:30', '05:00', 'P0087', 'F00022', 'PA01'),
        ('HI0218', '05:00', '05:30', 'P0268', 'F00022', 'PA01'),
        ('HI0219', '05:30', '06:05', 'P0009', 'F00022', 'PA01'),
        ('HI0220', '06:05', '07:30', 'P0002', 'F00022', 'PA01'),
        ('HI0221', '07:30', '08:30', 'P0051', 'F00022', 'PA01'),
        ('HI0222', '08:30', '09:00', 'P0083', 'F00022', 'PA01'),
        ('HI0223', '09:00', '09:10', 'P0093', 'F00022', 'PA01'),
        ('HI0224', '09:10', '09:30', 'P0169', 'F00022', 'PA01'),
        ('HI0225', '09:30', '11:30', 'P0172', 'F00022', 'PA01'),
        ('HI0226', '11:30', '12:00', 'P0213', 'F00022', 'PA01'),
        ('HI0227', '12:00', '12:30', 'P0232', 'F00022', 'PA01'),
        ('HI0228', '12:30', '13:00', 'P0210', 'F00022', 'PA01'),
        ('HI0229', '13:00', '14:00', 'P0191', 'F00022', 'PA01'),
        ('HI0230', '14:00', '14:30', 'P0173', 'F00022', 'PA01'),
        ('HI0231', '14:30', '15:00', 'P0017', 'F00022', 'PA01'),
        ('HI0232', '15:00', '16:00', 'P0024', 'F00022', 'PA01'),
        ('HI0233', '16:00', '16:15', 'P0127', 'F00022', 'PA01'),
        ('HI0234', '16:15', '16:30', 'P0145', 'F00022', 'PA01'),
        ('HI0235', '16:30', '16:45', 'P0093', 'F00022', 'PA01'),
        ('HI0236', '16:45', '17:00', 'P0047', 'F00022', 'PA01'),
        ('HI0237', '17:00', '17:30', 'P0248', 'F00022', 'PA01'),
        ('HI0238', '17:30', '18:00', 'P0112', 'F00022', 'PA01'),
        ('HI0239', '18:00', '18:30', 'P0110', 'F00022', 'PA01'),
        ('HI0240', '18:30', '19:00', 'P0165', 'F00022', 'PA01'),
        ('HI0241', '19:00', '20:00', 'P0048', 'F00022', 'PA01'),
        ('HI0242', '20:00', '21:00', 'P0265', 'F00022', 'PA01'),
        ('HI0243', '21:00', '22:00', 'P0266', 'F00022', 'PA01'),
        ('HI0244', '22:00', '23:00', 'P0167', 'F00022', 'PA01'),
        ('HI0245', '23:00', '00:00', 'P0285', 'F00022', 'PA01');
		select * from horarioInternacional;


INSERT INTO programaPais (idPrograma, idPais)
VALUES 
('P0001', 'PA01'),
('P0002', 'PA01'),
('P0003', 'PA01'),
('P0004', 'PA01'),
('P0005', 'PA01'),
('P0006', 'PA01'),
('P0007', 'PA01'),
('P0008', 'PA01'),
('P0009', 'PA01'),
('P0010', 'PA01'),
('P0011', 'PA01'),
('P0012', 'PA01'),
('P0013', 'PA01'),
('P0014', 'PA01'),
('P0015', 'PA01'),
('P0016', 'PA01'),
('P0017', 'PA01'),
('P0018', 'PA01'),
('P0019', 'PA01'),
('P0020', 'PA01'),
('P0021', 'PA01'),
('P0022', 'PA01'),
('P0023', 'PA01'),
('P0024', 'PA01'),
('P0025', 'PA01'),
('P0026', 'PA01'),
('P0027', 'PA01'),
('P0028', 'PA01'),
('P0029', 'PA01'),
('P0030', 'PA01'),
('P0031', 'PA01'),
('P0032', 'PA01'),
('P0033', 'PA01'),
('P0034', 'PA01'),
('P0035', 'PA01'),
('P0036', 'PA01'),
('P0037', 'PA01'),
('P0038', 'PA01'),
('P0039', 'PA01'),
('P0040', 'PA01'),
('P0041', 'PA01'),
('P0042', 'PA01'),
('P0043', 'PA01'),
('P0044', 'PA01'),
('P0045', 'PA01'),
('P0046', 'PA01'),
('P0047', 'PA01'),
('P0048', 'PA01'),
('P0049', 'PA01'),
('P0050', 'PA01'),
('P0051', 'PA01'),
('P0052', 'PA01'),
('P0053', 'PA01'),
('P0054', 'PA01'),
('P0055', 'PA01'),
('P0056', 'PA01'),
('P0057', 'PA01'),
('P0058', 'PA01'),
('P0059', 'PA01'),
('P0060', 'PA01'),
('P0061', 'PA01'),
('P0062', 'PA01'),
('P0063', 'PA01'),
('P0064', 'PA01'),
('P0065', 'PA01'),
('P0066', 'PA01'),
('P0067', 'PA01'),
('P0068', 'PA01'),
('P0069', 'PA01'),
('P0070', 'PA01'),
('P0071', 'PA01'),
('P0072', 'PA01'),
('P0073', 'PA01'),
('P0074', 'PA01'),
('P0075', 'PA01'),
('P0076', 'PA01'),
('P0077', 'PA01'),
('P0078', 'PA01'),
('P0079', 'PA01'),
('P0080', 'PA01'),
('P0081', 'PA01'),
('P0082', 'PA01'),
('P0083', 'PA01'),
('P0084', 'PA01'),
('P0085', 'PA01'),
('P0086', 'PA01'),
('P0087', 'PA01'),
('P0088', 'PA01'),
('P0089', 'PA01'),
('P0090', 'PA01'),
('P0091', 'PA01'),
('P0092', 'PA01'),
('P0093', 'PA01'),
('P0094', 'PA01'),
('P0095', 'PA01'),
('P0096', 'PA01'),
('P0097', 'PA01'),
('P0098', 'PA01'),
('P0099', 'PA01'),
('P0101', 'PA01'),
('P0102', 'PA01'),
('P0103', 'PA01'),
('P0104', 'PA01'),
('P0105', 'PA01'),
('P0106', 'PA01'),
('P0107', 'PA01'),
('P0108', 'PA01'),
('P0109', 'PA01'),
('P0110', 'PA01'),
('P0111', 'PA01'),
('P0112', 'PA01'),
('P0113', 'PA01'),
('P0114', 'PA01'),
('P0115', 'PA01'),
('P0116', 'PA01'),
('P0117', 'PA01'),
('P0118', 'PA01'),
('P0119', 'PA01'),
('P0120', 'PA01'),
('P0121', 'PA01'),
('P0122', 'PA01'),
('P0123', 'PA01'),
('P0124', 'PA01'),
('P0125', 'PA01'),
('P0126', 'PA01'),
('P0127', 'PA01'),
('P0128', 'PA01'),
('P0129', 'PA01'),
('P0130', 'PA01'),
('P0131', 'PA01'),
('P0132', 'PA01'),
('P0133', 'PA01'),
('P0134', 'PA01'),
('P0135', 'PA01'),
('P0136', 'PA01'),
('P0137', 'PA01'),
('P0138', 'PA01'),
('P0139', 'PA01'),
('P0140', 'PA01'),
('P0141', 'PA01'),
('P0142', 'PA01'),
('P0143', 'PA01'),
('P0144', 'PA01'),
('P0145', 'PA01'),
('P0146', 'PA01'),
('P0147', 'PA01'),
('P0148', 'PA01'),
('P0149', 'PA01'),
('P0150', 'PA01'),
('P0151', 'PA01'),
('P0152', 'PA01'),
('P0153', 'PA01'),
('P0154', 'PA01'),
('P0155', 'PA01'),
('P0156', 'PA01'),
('P0157', 'PA01'),
('P0158', 'PA01'),
('P0159', 'PA01'),
('P0160', 'PA01'),
('P0161', 'PA01'),
('P0162', 'PA01'),
('P0163', 'PA01'),
('P0164', 'PA01'),
('P0165', 'PA01'),
('P0166', 'PA01'),
('P0167', 'PA01'),
('P0168', 'PA01'),
('P0169', 'PA01'),
('P0170', 'PA01'),
('P0171', 'PA01'),
('P0172', 'PA01'),
('P0173', 'PA01'),
('P0174', 'PA01'),
('P0175', 'PA01'),
('P0176', 'PA01'),
('P0177', 'PA01'),
('P0178', 'PA01'),
('P0180', 'PA01'),
('P0181', 'PA01'),
('P0182', 'PA01'),
('P0183', 'PA01'),
('P0184', 'PA01'),
('P0185', 'PA01'),
('P0186', 'PA01'),
('P0187', 'PA01'),
('P0188', 'PA01'),
('P0189', 'PA01'),
('P0190', 'PA01'),
('P0191', 'PA01'),
('P0192', 'PA01'),
('P0193', 'PA01'),
('P0194', 'PA01'),
('P0195', 'PA01'),
('P0196', 'PA01'),
('P0197', 'PA01'),
('P0198', 'PA01'),
('P0199', 'PA01'),
('P0200', 'PA01'),
('P0201', 'PA01'),
('P0202', 'PA01'),
('P0203', 'PA01'),
('P0204', 'PA01'),
('P0205', 'PA01'),
('P0206', 'PA01'),
('P0207', 'PA01'),
('P0208', 'PA01'),
('P0209', 'PA01'),
('P0210', 'PA01'),
('P0211', 'PA01'),
('P0212', 'PA01'),
('P0213', 'PA01'),
('P0214', 'PA01'),
('P0215', 'PA01'),
('P0216', 'PA01'),
('P0217', 'PA01'),
('P0218', 'PA01'),
('P0219', 'PA01'),
('P0220', 'PA01'),
('P0221', 'PA01'),
('P0222', 'PA01'),
('P0223', 'PA01'),
('P0224', 'PA01'),
('P0225', 'PA01'),
('P0226', 'PA01'),
('P0227', 'PA01'),
('P0228', 'PA01'),
('P0229', 'PA01'),
('P0230', 'PA01'),
('P0231', 'PA01'),
('P0232', 'PA01'),
('P0233', 'PA01'),
('P0234', 'PA01'),
('P0235', 'PA01'),
('P0236', 'PA01'),
('P0237', 'PA01'),
('P0238', 'PA01'),
('P0239', 'PA01'),
('P0240', 'PA01'),
('P0241', 'PA01'),
('P0242', 'PA01'),
('P0243', 'PA01'),
('P0244', 'PA01'),
('P0245', 'PA01'),
('P0246', 'PA01'),
('P0247', 'PA01'),
('P0248', 'PA01'),
('P0249', 'PA01'),
('P0250', 'PA01'),
('P0251', 'PA01'),
('P0252', 'PA01'),
('P0253', 'PA01'),
('P0254', 'PA01'),
('P0255', 'PA01'),
('P0256', 'PA01'),
('P0257', 'PA01'),
('P0258', 'PA01'),
('P0259', 'PA01'),
('P0260', 'PA01'),
('P0261', 'PA01'),
('P0262', 'PA01'),
('P0263', 'PA01'),
('P0264', 'PA01'),
('P0265', 'PA01'),
('P0266', 'PA01'),
('P0267', 'PA01'),
('P0268', 'PA01'),
('P0269', 'PA01'),
('P0270', 'PA01'),
('P0271', 'PA01'),
('P0272', 'PA01'),
('P0273', 'PA01'),
('P0274', 'PA01'),
('P0275', 'PA01'),
('P0276', 'PA01'),
('P0277', 'PA01'),
('P0278', 'PA01'),
('P0001', 'PA02'),
('P0002', 'PA02'),
('P0003', 'PA02'),
('P0004', 'PA02'),
('P0005', 'PA02'),
('P0006', 'PA02'),
('P0007', 'PA02'),
('P0008', 'PA02'),
('P0009', 'PA02'),
('P0010', 'PA02'),
('P0011', 'PA02'),
('P0012', 'PA02'),
('P0013', 'PA02'),
('P0014', 'PA02'),
('P0015', 'PA02'),
('P0016', 'PA02'),
('P0017', 'PA02'),
('P0018', 'PA02'),
('P0019', 'PA02'),
('P0020', 'PA02'),
('P0021', 'PA02'),
('P0022', 'PA02'),
('P0023', 'PA02'),
('P0024', 'PA02'),
('P0025', 'PA02'),
('P0026', 'PA02'),
('P0027', 'PA02'),
('P0028', 'PA02'),
('P0029', 'PA02'),
('P0030', 'PA02'),
('P0031', 'PA02'),
('P0032', 'PA02'),
('P0033', 'PA02'),
('P0034', 'PA02'),
('P0035', 'PA02'),
('P0036', 'PA02'),
('P0037', 'PA02'),
('P0038', 'PA02'),
('P0039', 'PA02'),
('P0040', 'PA02'),
('P0041', 'PA02'),
('P0042', 'PA02'),
('P0043', 'PA02'),
('P0044', 'PA02'),
('P0045', 'PA02'),
('P0046', 'PA02'),
('P0047', 'PA02'),
('P0048', 'PA02'),
('P0049', 'PA02'),
('P0050', 'PA02'),
('P0051', 'PA02'),
('P0052', 'PA02'),
('P0053', 'PA02'),
('P0054', 'PA02'),
('P0055', 'PA02'),
('P0056', 'PA02'),
('P0057', 'PA02'),
('P0058', 'PA02'),
('P0059', 'PA02'),
('P0060', 'PA02'),
('P0061', 'PA02'),
('P0062', 'PA02'),
('P0063', 'PA02'),
('P0064', 'PA02'),
('P0065', 'PA02'),
('P0066', 'PA02'),
('P0067', 'PA02'),
('P0068', 'PA02'),
('P0069', 'PA02'),
('P0070', 'PA02'),
('P0071', 'PA02'),
('P0072', 'PA02'),
('P0073', 'PA02'),
('P0074', 'PA02'),
('P0075', 'PA02'),
('P0076', 'PA02'),
('P0077', 'PA02'),
('P0078', 'PA02'),
('P0079', 'PA02'),
('P0080', 'PA02'),
('P0081', 'PA02'),
('P0082', 'PA02'),
('P0083', 'PA02'),
('P0084', 'PA02'),
('P0085', 'PA02'),
('P0086', 'PA02'),
('P0087', 'PA02'),
('P0088', 'PA02'),
('P0089', 'PA02'),
('P0090', 'PA02'),
('P0091', 'PA02'),
('P0092', 'PA02'),
('P0093', 'PA02'),
('P0094', 'PA02'),
('P0095', 'PA02'),
('P0096', 'PA02'),
('P0097', 'PA02'),
('P0098', 'PA02'),
('P0099', 'PA02'),
    ('P0101', 'PA02'),
    ('P0102', 'PA02'),
    ('P0103', 'PA02'),
    ('P0104', 'PA02'),
    ('P0105', 'PA02'),
    ('P0106', 'PA02'),
    ('P0107', 'PA02'),
    ('P0108', 'PA02'),
    ('P0109', 'PA02'),
    ('P0110', 'PA02'),
    ('P0111', 'PA02'),
    ('P0112', 'PA02'),
    ('P0113', 'PA02'),
    ('P0114', 'PA02'),
    ('P0115', 'PA02'),
    ('P0116', 'PA02'),
    ('P0117', 'PA02'),
    ('P0118', 'PA02'),
    ('P0119', 'PA02'),
    ('P0120', 'PA02'),
    ('P0121', 'PA02'),
    ('P0122', 'PA02'),
    ('P0123', 'PA02'),
    ('P0124', 'PA02'),
    ('P0125', 'PA02'),
    ('P0126', 'PA02'),
    ('P0127', 'PA02'),
    ('P0128', 'PA02'),
    ('P0129', 'PA02'),
    ('P0130', 'PA02'),
    ('P0131', 'PA02'),
    ('P0132', 'PA02'),
    ('P0133', 'PA02'),
    ('P0134', 'PA02'),
    ('P0135', 'PA02'),
    ('P0136', 'PA02'),
    ('P0137', 'PA02'),
    ('P0138', 'PA02'),
    ('P0139', 'PA02'),
    ('P0140', 'PA02'),
    ('P0141', 'PA02'),
    ('P0142', 'PA02'),
    ('P0143', 'PA02'),
    ('P0144', 'PA02'),
    ('P0145', 'PA02'),
    ('P0146', 'PA02'),
    ('P0147', 'PA02'),
    ('P0148', 'PA02'),
    ('P0149', 'PA02'),
    ('P0150', 'PA02'),
    ('P0151', 'PA02'),
    ('P0152', 'PA02'),
    ('P0153', 'PA02'),
    ('P0154', 'PA02'),
    ('P0155', 'PA02'),
    ('P0156', 'PA02'),
    ('P0157', 'PA02'),
    ('P0158', 'PA02'),
    ('P0159', 'PA02'),
    ('P0160', 'PA02'),
    ('P0161', 'PA02'),
    ('P0162', 'PA02'),
    ('P0163', 'PA02'),
    ('P0164', 'PA02'),
    ('P0165', 'PA02'),
    ('P0166', 'PA02'),
    ('P0167', 'PA02'),
    ('P0168', 'PA02'),
    ('P0169', 'PA02'),
    ('P0170', 'PA02'),
    ('P0171', 'PA02'),
    ('P0172', 'PA02'),
    ('P0173', 'PA02'),
    ('P0174', 'PA02'),
    ('P0175', 'PA02'),
    ('P0176', 'PA02'),
    ('P0177', 'PA02'),
    ('P0178', 'PA02'),
    ('P0180', 'PA02'),
    ('P0181', 'PA02'),
    ('P0182', 'PA02'),
    ('P0183', 'PA02'),
    ('P0184', 'PA02'),
    ('P0185', 'PA02'),
    ('P0186', 'PA02'),
    ('P0187', 'PA02'),
    ('P0188', 'PA02'),
    ('P0189', 'PA02'),
    ('P0190', 'PA02'),
    ('P0191', 'PA02'),
    ('P0192', 'PA02'),
    ('P0193', 'PA02'),
    ('P0194', 'PA02'),
    ('P0195', 'PA02'),
    ('P0196', 'PA02'),
    ('P0197', 'PA02'),
    ('P0198', 'PA02'),
    ('P0199', 'PA02'),
    ('P0200', 'PA02'),
    ('P0201', 'PA02'),
    ('P0202', 'PA02'),
    ('P0203', 'PA02'),
    ('P0204', 'PA02'),
    ('P0205', 'PA02'),
    ('P0206', 'PA02'),
    ('P0207', 'PA02'),
    ('P0208', 'PA02'),
    ('P0209', 'PA02'),
    ('P0210', 'PA02'),
    ('P0211', 'PA02'),
    ('P0212', 'PA02'),
    ('P0213', 'PA02'),
    ('P0214', 'PA02'),
    ('P0215', 'PA02'),
    ('P0216', 'PA02'),
    ('P0217', 'PA02'),
    ('P0218', 'PA02'),
    ('P0219', 'PA02'),
    ('P0220', 'PA02'),
    ('P0221', 'PA02'),
    ('P0222', 'PA02'),
    ('P0223', 'PA02'),
    ('P0224', 'PA02'),
    ('P0225', 'PA02'),
    ('P0226', 'PA02'),
    ('P0227', 'PA02'),
    ('P0228', 'PA02'),
    ('P0229', 'PA02'),
    ('P0230', 'PA02'),
    ('P0231', 'PA02'),
    ('P0232', 'PA02'),
    ('P0233', 'PA02'),
    ('P0234', 'PA02'),
    ('P0235', 'PA02'),
    ('P0236', 'PA02'),
    ('P0237', 'PA02'),
    ('P0238', 'PA02'),
    ('P0239', 'PA02'),
    ('P0240', 'PA02'),
    ('P0241', 'PA02'),
    ('P0242', 'PA02'),
    ('P0243', 'PA02'),
    ('P0244', 'PA02'),
    ('P0245', 'PA02'),
    ('P0246', 'PA02'),
    ('P0247', 'PA02'),
    ('P0248', 'PA02'),
    ('P0249', 'PA02'),
    ('P0250', 'PA02'),
    ('P0251', 'PA02'),
    ('P0252', 'PA02'),
    ('P0253', 'PA02'),
    ('P0254', 'PA02'),
    ('P0255', 'PA02'),
    ('P0256', 'PA02'),
    ('P0257', 'PA02'),
    ('P0258', 'PA02'),
    ('P0259', 'PA02'),
    ('P0260', 'PA02'),
    ('P0261', 'PA02'),
    ('P0262', 'PA02'),
    ('P0263', 'PA02'),
    ('P0264', 'PA02'),
    ('P0265', 'PA02'),
    ('P0266', 'PA02'),
    ('P0267', 'PA02'),
    ('P0268', 'PA02'),
    ('P0269', 'PA02'),
    ('P0270', 'PA02'),
    ('P0271', 'PA02'),
    ('P0272', 'PA02'),
    ('P0273', 'PA02'),
    ('P0274', 'PA02'),
    ('P0275', 'PA02'),
    ('P0276', 'PA02'),
    ('P0277', 'PA02'),
    ('P0278', 'PA02');

select * from programaPais;


INSERT INTO programaConductores(idPrograma, idConductor)
VALUES  
       ('P0001', 'CON49'), -- Miguel Conde - La Ruta del Sabor (programa)
	   ('P0003', 'CON50'), -- Bruno Bichir - Yo sólo sé que no he cenado (programa)
       ('P0004', 'CON52'), -- Bebidas de México (Serie/Documental) 
	   ('P0004', 'CON53'), -- Joaquín Cosio - Bebidas de México (Serie/Documental)
	   ('P0006', 'CON57'), -- Pablo San Román - Del Mundo al Plato (programa)
       ('P0007', 'CON57'), -- Pablo San Román - Tu cocina (programa)
       ('P0007', 'CON58'), -- Graciela Montaño - Tu cocina (programa)
	   ('P0007', 'CON59'), -- Yuri de Gortari - Tu cocina (programa)
	   ('P0007', 'CON60'), -- Gerardo Vázquez Lugo - Tu cocina (programa)
	   ('P0007', 'CON61'), -- León Aguirre - Tu cocina (programa)
	   ('P0007', 'CON62'), -- Lucero Soto - Tu cocina (programa)
	   ('P0007', 'CON63'), -- Pepe Salinas - Tu cocina (programa)--  
	   ('P0007', 'CON64'), -- Lucero Soto - Tu cocina (programa)
       ('P0009', 'CON51'), -- Daniel Giménez Cacho - En materia de pescado (programa)
       ('P0009', 'CON65'), -- Marco Rascón - En materia de Pescado (programa)
       ('P0010', 'CON66'), -- Enrique Olvera - Diario de un cocinero (programa)
       ('P0012', 'CON67'), -- Phillippe Ollé Laprune -  américa. Escritores extranjeros de México (Serie/Documental)
       ('P0015', 'CON68'), -- Susana Harp - Diáspora (Serie/Documental) 
       ('P0016', 'CON68'), -- Susana Harp - Afroméxico (serie)
       ('P0017', 'CON69'), -- Alejandra Robles - Las joyas de Oaxaca (programa)
       ('P0018', 'CON70'), -- César González Madruga - México Renace Sostenible (programa)
       ('P0019', 'CON71'), -- Heriberto Murrieta - Toros, Sol y Sombra (programa)
       ('P0019', 'CON72'), -- Rafael Cué - Toros, Sol y Sombra (programa)
       ('P0022', 'CON73'), -- Rodrigo Castaño Valencia - Manos de Artesano (programa)
	   ('P0023', 'CON74'), -- Carlos Pascual - Palabra de Autor (programa)
	   ('P0023', 'CON75'), -- Mónica Lavín - Palabra de Autor (programa)
       ('P0029', 'CON13'), -- Heriberto Javier Murrieta Cantú - M/Aquí (programa)
('P0034', 'CON2'),  -- Pablo L. Morán - ENTRE REDES (programa)
('P0034', 'CON3'),  -- Andi Martín del Campo - ENTRE REDES (programa)
('P0034', 'CON4'),  -- Hector Trejo - ENTRE REDES (programa)
('P0034', 'CON5'),  -- Jaime Gama - ENTRE REDES (programa)
('P0034', 'CON6'),  -- Jerry Velezquez - ENTRE REDES (programa)
('P0034', 'CON7'),  -- Victoria Islas - ENTRE REDES (programa)
('P0036', 'CON8'),  -- Julia Didriksson - SÍ SOMOS (audiopodcast)
('P0036', 'CON9'),  -- Nancy Mejía - SÍ SOMOS (audiopodcast)
('P0036', 'CON10'), -- Ana Grimaldo - SÍ SOMOS (audiopodcast)
('P0036', 'CON11'), -- Gracia Alzaga - SÍ SOMOS (audiopodcast)
('P0036', 'CON12'), -- PASO A PASO (programa)
('P0038', 'CON76'), -- Adriana Morales - ¡Hagamos Clic! (programa)
('P0042', 'CON1'),  -- Óscar Uriel Macías Mora - EN LA BARRA (programa)
('P0043', 'CON77'), -- Jazmín Cato Sosa - Inclusión Radical (programa)
('P0043', 'CON78'), -- Itzel Aguilar Mora - Inclusión Radical (programa)
('P0043', 'CON79'), -- Vania R. Belmont - Inclusión Radical (programa)
('P0043', 'CON80'), -- Eduardo Valenzuela - Inclusión Radical (programa)
('P0045', 'CON81'), -- Ophelia Pastrana - Multipass (programa)
('P0048', 'CON82'), -- Alessandra Santamaría - Pop 11.0 (programa)
('P0048', 'CON83'), -- Rodrigo Garcia - Pop 11.0 (programa)
('P0049', 'CON84'), -- Patricio Córdova - Economía en corto (serie)
('P0051', 'CON85'), -- Cristina Pachecho - Conversando con Cristina Pachecho (serie)
('P0052', 'CON86'), -- Guadalupe Contreras - En Persona (programa),
('P0053', 'CON23'), -- Guadalupe Contreras - Dialogos en Confianza (programa)
('P0053', 'CON24'), -- Anahí Vázquez - Dialogos en Confianza (programa)
('P0053', 'CON25'), -- Citlaly López - Dialogos en Confianza (programa)
('P0053', 'CON26'), -- José Bandera - Dialogos en Confianza (programa)
('P0053', 'CON27'), -- Cristina Jáuregui - Dialogos en Confianza (programa)
('P0053', 'CON28'), -- Natalia Jiménez - Dialogos en Confianza (programa)
('P0053', 'CON29'), -- Eduardo Valenzuela - Dialogos en Confianza (programa)
('P0053', 'CON30'), -- Leticia Carbajal - Dialogos en Confianza (programa)
('P0053', 'CON31'), -- Azucena Celis - Dialogos en Confianza (programa)
('P0053', 'CON32'), -- Diana Laura Gómez - Dialogos en Confianza (programa)
('P0055', 'CON85'), -- Cristina Pachecho - Aquí nos tocó vivir (programa)
('P0056', 'CON87'), -- Rubén Álvarez Mendiola - Aquí en corto (programa)
('P0057', 'CON88'), -- Marta de la Lama - El gusto es mio (programa)
('P0058', 'CON89'), -- Guadalupe Loaeza - La Cita (programa)
('P0059', 'CON90'), -- Javier Solórzano - Solórzano 3.0 (programa) 
('P0060', 'CON91'), -- Catalina Noriega - Entre Mitos y Realidades (programa)
('P0060', 'CON92'),  -- Pilar Ferreira - Entre Mitos y Realidades (programa)
('P0062', 'CON93'),  -- Javier Trejo Garay - Pelotero a la bola (programa)
('P0062', 'CON94'),  -- Diana Laura Gómez - Pelotero a la bola (programa)
('P0062', 'CON95'),  -- Gustavo Torrero - Pelotero a la bola (programa)
('P0062', 'CON96'),  -- Alfonso Lanzagorta - Pelotero a la bola (programa)
('P0062', 'CON97'),  -- Beatriz Pereyra - Pelotero a la bola (programa)
('P0263', 'CON98'),  -- Verónica Toussaint - Yoga (programa)
('P0065', 'CON99'),  -- Adriana Bautista - Baile Latino (programa)
('P0066', 'CON100'), -- Caly Minero - Activate (programa)
('P0067', 'CON101'), -- Laura Santín - Body Jam (programa)
('P0069', 'CON102'), -- Aldo Sánchez Vera - Carrera Panamericana (programa)
('P0072', 'CON103'), -- Alejandro Schenini - En forma (programa) 
('P0074', 'CON104'), -- Joss Waleska - NED, La nueva era del deporte (programa)
('P0075', 'CON105'), -- Alfredo Dominguez Muro - Palco a Debate (programa)
('P0076', 'CON106'), -- Tablero de Ajedrez (programa)
('P0080', 'CON107'), -- Marcela Pezet - Todos a Bordo (programa)
('P0081', 'CON108'), -- Tamara de Anda - Itinerario (programa)
('P0083', 'CON109'), -- Jean-Christophe Berjon - Mi cine, tu Cine (programa)
('P0084', 'CON1'),   -- Óscar Uriel Macías Mora - TAP (programa),
('P0085', 'CON110'), -- Alejandra López -Viaje Todo Incluyente (programa)
('P0085', 'CON111'), -- Jocelyn Chávez - Viaje Todo Incluyente (programa)
('P0085', 'CON112'), -- Abel Ponce - Viaje Todo Incluyente (programa)
('P0085', 'CON113'), -- Julio César Hernández - Viaje Todo Incluyente (programa)
('P0085', 'CON114'), -- Joaquín Alva - Viaje Todo Incluyente (programa)
('P0086', 'CON115'), -- Luis Gerardo Méndez - ¿Quién Dijo Yo? (programa)
('P0087', 'CON116'), -- Bernardo Barranco - Cristianos en Armas (programa)
('P0089', 'CON117'), -- Sofía Álvarez - De puño y Letra (programa)
('P0090', 'CON118'), -- Margarita  Vasquez Montaño - Perspectivas Históricas (programa)
('P0091', 'CON119'), -- Ángeles González Gamio - Crónicas y relatos de México a dos voces (serie documental), Crónicas y relatos de México (serie documental) 
('P0093', 'CON120'), -- Maria Elena Cantú - Arquitectura del Poder (programa)
('P0095', 'CON121'), -- Mauricio Isaac - La educación en México (programa)
('P0096', 'CON122'), -- José Crriedo - Voces de la Constitución (programa)
('P0099', 'CON123'), -- Eugenia León - Ven Acá... con Eugenia León y Pavel Granados (programa)
('P0099', 'CON124'), -- Pavel Granados - Ven Acá... con Eugenia León y Pavel Granados (programa)   
('P0102', 'CON33'),  -- Daniel Herrera - Boleros, Noches y Son (programa)
('P0102', 'CON34'),  -- Nacho Mendéz - Boleros, Noches y Son (programa)
('P0102', 'CON35'),  -- Nacho Mendéz - Boleros, Noches y Son (programa)
('P0102', 'CON36'),  -- Luhana Gardi - Boleros, Noches y Son (programa)
('P0103', 'CON42'),  -- Alejandra Ley - Contigo (programa)
('P0103', 'CON43'),  -- Cecilia Gallardo - Contigo (programa)
('P0103', 'CON44'),  -- Joao Henrique - Contigo (programa)
('P0105', 'CON125'), -- Alexia Ávila - Concurso Nacional De Estudiantinas: La Serie (serie), 
('P0105', 'CON126'), -- Ausencio Cruz - Concurso Nacional de Estudiantinas: La Serie (serie)
('P0107', 'CON125'), -- Alexia Ávila- Ninguna como mi Tuna (programa),
('P0107', 'CON126'), -- Ausencio Cruz -  Ninguna como mi Tuna (programa)
('P0109', 'CON127'), -- Davis Filio - El timpano (programa)
('P0109', 'CON128'), -- Davis Filio - El timpano (programa)
('P0111', 'CON129'), -- Aldo Sánchez Vera - La Central (programa)
('P0112', 'CON130'), -- Edgar Barroso - Musivolución (programa)
('P0113', 'CON131'), -- Jorge Saldaña - Añoranzas (programa)
('P0114', 'CON132'), -- Alejandra Moreno - Rock en contacto (programa)
('P0114', 'CON133'), -- Alonso Ruizpalacios - Rock en contacto (programa)
('P0115', 'CON134'), -- Aldo Sánchez Vera - Especiales Musicales (programa)
('P0118', 'CON135'), -- Fabián Garza - El show de los Once (programa)
('P0118', 'CON136'), -- Micaela Gramajo - El show de los Once (programa)
('P0118', 'CON137'), -- Ricardo Zárraga - El show de los Once (programa)
('P0118', 'CON138'), -- Luisa Garibay - El show de los Once (programa)
('P0118', 'CON139'), -- Ahichell Sánchez - El show de los Once (programa)
('P0118', 'CON140'), -- Mirelle Romo de Vivar - El show de los Once (programa)
('P0118', 'CON141'), -- Alfredo Farias - El show de los Once (programa)
('P0118', 'CON142'), -- Neyzer Constantino - El show de los Once (programa)
('P0118', 'CON143'), -- Yair Prado - El show de los Once (programa)
('P0118', 'CON144'), -- Alejandro Lago - El show de los Once (programa)
('P0124', 'CON145'), -- Omar Esquinca - Los reportajes de Onn (programa)
('P0124', 'CON146'), -- José Luis Arévalo - Los reportajes de Onn (programa)
('P0124', 'CON147'), -- Xareny Orzal - Los reportajes de Onn (programa)
('P0124', 'CON148'), -- Giuliana Vega - Los reportajes de Onn (programa)
('P0124', 'CON149'), -- Aarón Herández Farfán - Los reportajes de Onn (programa)
('P0124', 'CON150'), -- Ulises David - Los reportajes de Onn (programa)
('P0126', 'CON151'), -- Alejandra Rodríguez - Intelige (programa)
('P0126', 'CON152'), -- Iván González - Intelige (programa)
('P0141', 'CON153'), -- Sofía Luna - Sofía Luna, Agente Especial (programa)
('P0142', 'CON154'), -- Max Espejel Hernández - Alcanzame si puedes (programa)
('P0156', 'CON155'), -- Esther Oldak - Creciendo Juntos (programa)
('P0165', 'CON156'), -- Rocío Brauer - Digital (programa) 
('P0167', 'CON15'),  -- Alejandro García Moreno - Factor Ciencia (programa)
('P0167', 'CON16'),  -- Rafael Guadarrama - Factor Ciencia (programa)
('P0167', 'CON17'),  -- Alejandro García Moreno - Factor Ciencia (programa)
('P0167', 'CON18'),  -- Lucía Vazquez Corona - Factor Ciencia (programa)
('P0169', 'CON41'),  -- Ana María Lomeli - Hagamos que suceda (programa)
('P0170', 'CON157'), -- Khristina Giles - Un lugar llamado México (programa)
('P0172', 'CON154'), -- Max Espejel Hernández - Agenda Verde (programa),
('P0174', 'CON158'), -- Magali Boyselle Hernández - Detrás de un Click (programa)
('P0178', 'CON159'), -- Manuel Lazcano - Entre Mares (programa)
('P0180', 'CON90'),  -- Javier Solórzano - México Vive (programa)
('P0182', 'CON154'), -- Max Espejel Hernández - Hospital Veterinario (programa)
('P0183', 'CON155'), -- Esther Oldak - Creciendo Juntos (programa)
('P0184', 'CON160'), -- Alejandro García Moreno - Naturaleza (programa)
('P0186', 'CON161'), -- Fisgón-Rapé-Hernández - Chamuco TV (programa)
('P0187', 'CON14'),  -- Ezra Alcázar - El desfiladero (programa)
('P0189', 'CON162'), -- Guadalupe Contreras - Nuestra Energía (programa)
('P0190', 'CON45'),  -- Sabina Berman - Largo Aliento (programa),
('P0195', 'CON38'),  -- Fernando Rivera Calderón - Operación Mamut (programa)
('P0195', 'CON39'),  -- Nora Huerta - Operación Mamut (programa)
('P0195', 'CON40'),  -- Jairo Calixto Albarrán - Operación Mamut (programa)
('P0197', 'CON163'), -- Margarita González Gamio - A favor y en Contra (programa)
('P0197', 'CON164'), -- Jorge del Villar - A favor y en Contra (programa)
('P0198', 'CON165'), -- José Buendía Hegewisch - Agenda a Fondo (programa)
('P0199', 'CON166'), -- Kimberly Armengol - Apuesto al Sexo Opuesto (programa)
('P0200', 'CON167'), -- Dinero y poder (programa), Línea Directa (programa) 
('P0202', 'CON168'), -- John Ackerman - John y Sabina (programa), De Todos Modos... John Te Llamas (programa)
('P0202', 'CON45'),  -- Sabina Berman - John y Sabina (programa)
('P0204', 'CON169'), -- Sergio Aguayo - Primer Plano (programa)
('P0204', 'CON170'), -- María Amparo Casar - Primer Plano (programa)
('P0204', 'CON171'), -- José Antonio Crespo - Primer Plano (programa)
('P0204', 'CON172'), -- Leonardo Curzio - Primer Plano (programa)
('P0204', 'CON173'), -- Lorenzo Meyer - Primer Plano (programa)
('P0204', 'CON174'), -- Francisco Paoli Bolio - Primer Plano (programa)
('P0205', 'CON175'), -- Bernardo Barranco - Sacro y Profano
('P0206', 'CON176'), -- Gibrán Ramírez Reyes - De Buena Fe (programa)
('P0206', 'CON177'), -- Estefanía Veloz - De Buena Fe (programa)
('P0206', 'CON178'), -- Danger AK - De Buena Fe (programa)
('P0207', 'CON168'), -- -- John Ackerman - De Todos Modos... John Te Llamas (programa)
('P0209', 'CON37'),  -- Gabriela Tinajero - Huélum (programa) 
('P0211', 'CON179'), -- Alejandro García Moreno - Gaceta Politécnica (programa)
('P0213', 'CON20'),  -- Paco Ignacio Taibo II - El mitote Librero (programa)
('P0213', 'CON21'),  -- Norma Márquez - El mitote Librero (programa)
('P0213', 'CON22'),  -- Andrés Ruiz - El mitote Librero (programa)
('P0214', 'CON180'), -- Ricardo Raphael - Espiral Politécnica (programa), Espiral (programa), #Calle11 (programa)
('P0216', 'CON19'),  -- Amanda Drag - La VerDrag (programa)
('P0218', 'CON23'),  -- Guadalupe Contreras - Res?uestas (programa)
('P0221', 'CON125'), -- Alexia Ávila - Conecta con la Lectura (programa)
('P0222', 'CON46'), -- Zohar Salgado Álvarez - A+A Especial de Navidad (programa)
('P0222', 'CON47'), -- Erick Tejeda - A+A Especial de Navidad (programa)
('P0222', 'CON48'), -- Beatriz Pereyra - A+A Amor y Amistad (programa)
('P0224', 'CON181'), -- Sandra Arguelles - Presente (programa)
('P0228', 'CON182'), -- Estela Livera - Entre Nosotras (programa)
('P0230', 'CON183'), -- Patricia Kelly - 80 Millones (programa)
('P0231', 'CON125'), -- Alexia Ávila - D TODO (podcast)
('P0232', 'CON184'), -- Carlos Bolado - A medio siglo de México 68
('P0234', 'CON185'), -- Valentina Sierra - Altoparlante (programa)
('P0234', 'CON186'), -- Fernando Bonilla - Altoparlante (programa)
('P0234', 'CON187'), -- Luis Lesher - Altoparlante (programa)
('P0241', 'CON188'), -- México Social (programa)
('P0242', 'CON189'), -- Mariana Lapuente Flores - Mexicanos en el extranjero
('P0247', 'CON190'), -- Nuevos Pasos (programa)
('P0254', 'CON90'), -- Javier Solórzano - Francisco, Visita Papa a México (programa)
('P0255', 'CON191'), -- Fuerza Interior (programa)
('P0256', 'CON192'), -- Jorge del Villar - Habla de Frente (programa)
('P0257', 'CON193'), -- Fernanda Tapia - Hacer el Bien (serie), Hacen El Bien y Miran A Quién (programa)
('P0259', 'CON194'), -- Javier Solórzano - Perfil Público (programa) 
('P0265', 'CON99'), -- Adriana Bautista - Baile Latino (programa)
('P0266', 'CON100'), -- Caly Minero - Activate (programa)
('P0280', 'CON86'), -- Guadalupe Contreras - Once Noticias Matutino (noticias/programa)
('P0281', 'CON196'), -- Zandra Zittle - Noticiario Meridiano
('P0282', 'CON197'), -- Leticia Carbajal - Noticiario nocturno
('P0283', 'CON198'), -- Noticiario Sabatino
('P0284', 'CON196'); -- Noticiario Dominical

       select * from programaConductores;

INSERT INTO seccionProgramas(idPrograma,idSeccion)
VALUES 
    ('P0001', 'S001'), -- 'La Ruta Del Sabor' - Once +
    ('P0001', 'S004'), -- 'La Ruta Del Sabor' - Once México
    ('P0002', 'S001'), -- 'La sazón de mi mercado' - Once +
    ('P0003', 'S001'), -- 'Yo Sólo Sé Que No He Cenado' - Once +
    ('P0004', 'S001'), -- 'Bebidas de México - Once +
    ('P0005', 'S001'), -- 'Nuestra riqueza, el chile - Once +
    ('P0006', 'S001'), -- 'Del Mundo Al Plato' - Once +
    ('P0007', 'S001'), -- 'Tu Cocina - Once +
    ('P0008', 'S001'), -- 'Elogio De La Cocina Mexicana - Once +
    ('P0009', 'S001'), -- 'En Materia De Pescado', - Once +
    ('P0010', 'S001'), -- 'Diario de un Cocinero',  - Once +
    ('P0011', 'S001'), -- 'Memoria de los Sabores',- Once +
    ('P0012', 'S002'), -- 'América. Escritores extranjeros en México', - Once +
    ('P0013', 'S001'), -- 'El Mitote Librero' - Once +
    ('P0014', 'S001'), -- 'Lenguas en Resistencia',  - Once +
    ('P0015', 'S001'), -- 'Diáspora',  - Once +
    ('P0016', 'S001'), -- 'Afroméxico',  - Once +
    ('P0017', 'S001'), -- 'Las joyas de Oaxaca', - Once +
    ('P0018', 'S001'), -- 'México Renace Sostenible',  - Once +
    ('P0019', 'S001'), -- 'Toros, Sol y Sombra',  - Once +
    ('P0020', 'S001'), -- 'Sensacional De Diseño Mexicano' - Once +
    ('P0021', 'S001'), -- 'Minigrafías',  - Once +
    ('P0022', 'S001'), -- 'Manos de Artesano', - Once +
    ('P0023', 'S001'), -- 'Palabra De Autor', - Once +
    ('P0024', 'S001'), -- 'Artes',  - Once +
    ('P0025', 'S001'), -- 'Letras De La Diplomacia',  - Once +
    ('P0026', 'S001'), -- 'Moneros',  - Once +
    ('P0027', 'S001'), -- 'Teatro Estudio', - Once + 
    ('P0028', 'S001'), -- 'Artesanos de México: Rutas del arte popular', - Once +
    ('P0029', 'S001'), -- M/Aquí - Once +
    ('P0029', 'S005'), -- M/Aquí - Once Digital
    ('P0030', 'S001'), -- Once digital investigación - Once +
    ('P0030', 'S005'), -- Once digital investigación - Once Digital
    ('P0031', 'S001'), -- 'De la casa a la casilla' - Once +
    ('P0031', 'S005'), -- 'De la casa a la casilla' - Once Digital
    ('P0032', 'S001'), -- 'Gradiente - Once +
    ('P0032', 'S005'), -- 'Gradiente - Once Digital
    ('P0033', 'S003'), -- 'Abraza la diversidad' - Once Digital
    ('P0034', 'S001'), -- 'Entre Redes' - Once +
    ('P0034', 'S005'), -- 'Entre Redes' - Once Digital
    ('P0035', 'S001'), -- 'Acción Artística' - Once +
    ('P0035', 'S005'), -- 'Acción Artística' - Once Digital
    ('P0036', 'S001'), -- Sí somos - Once +
    ('P0036', 'S005'), -- Sí somos - Once Digital
    ('P0037', 'S001'), -- 'Échale Piquete - Once +
    ('P0037', 'S005'), -- 'Échale Piquete - Once Digital
    ('P0038', 'S001'), -- '¡Hagamos clic! - Once +
    ('P0038', 'S005'), -- '¡Hagamos clic! - Once Digital
    ('P0039', 'S005'), -- 'Había Una vez… Mexicanas que hicieron historia - Once Digital
    ('P0040', 'S001'), -- 'Cultura a Voces - Once +
    ('P0040', 'S005'), -- 'Cultura a Voces - Once Digital
    ('P0041', 'S001'), -- Somos lxs que fueron - Once +
    ('P0041', 'S005'), -- Somos lxs que fueron - Once Digital
    ('P0042', 'S001'), -- 'En la Barra' - Once +
    ('P0042', 'S005'), -- 'En la Barra' - Once Digital
    ('P0043', 'S001'), -- 'Inclusión Radical - Once +
    ('P0043', 'S005'), -- 'Inclusión Radical - Once Digital
    ('P0044', 'S005'), -- 'Innovación Politécnica - Once Digital
    ('P0045', 'S001'), -- 'Multipass - Once +
    ('P0045', 'S005'), -- 'Multipass - Once Digital
    ('P0046', 'S005'), -- 'Yo, ellas, nosotras - Once Digital
    ('P0047', 'S001'), -- 'A Tono - Once +
    ('P0047', 'S005'), -- 'A Tono - Once Digital
    ('P0048', 'S005'), -- 'Pop 11.0 - Once Digital
    ('P0049', 'S003'), -- 'Economía en corto - Once Digital
    ('P0050', 'S005'), -- 'Más allá de la piel - Once Digital
    ('P0051', 'S004'), -- 'Conversando con Cristina Pacheco' - Once México
    ('P0052', 'S001'), -- 'En Persona' - Once +
    ('P0053', 'S001'), -- 'Diálogos en Confianza' - Once +
    ('P0053', 'S004'), -- 'Diálogos en Confianza' - Once México
    ('P0054', 'S001'), -- 'Aprender a envejecer' - Once +
    ('P0054', 'S004'), -- 'Aprender a envejecer' - Once México
    ('P0055', 'S001'), -- 'Aquí Nos Tocó Vivir' - Once +
    ('P0056', 'S001'), -- 'Aquí En Corto' - Once +
    ('P0057', 'S001'), -- 'El Gusto Es Mío' - Once +
    ('P0058', 'S001'), -- 'La Cita' - Once +
    ('P0059', 'S001'), -- 'Solórzano 3.0' - Once +
    ('P0060', 'S001'), -- 'Entre Mitos y Realidades' - Once +
    ('P0061', 'S001'), -- 'La historia del tenis en México' - Once +
    ('P0062', 'S001'), -- 'Pelotero a la bola' - Once +
    ('P0063', 'S001'), -- 'Yoga' - Once +
    ('P0064', 'S001'), -- 'Somos Equipo' - Once +
    ('P0065', 'S001'), -- 'Baile Latino' - Once +
    ('P0066', 'S001'), -- 'Actívate' - Once +
    ('P0067', 'S001'), -- 'Body Jam' - Once +
    ('P0068', 'S001'), -- 'Cápsulas De Deportes' - Once +
    ('P0069', 'S001'), -- 'Carrera Panamericana' - Once +
    ('P0070', 'S001'), -- 'Leyendas Del Deporte Mexicano' - Once +
    ('P0071', 'S001'), -- 'Leyendas Del Fútbol Mexicano' - Once +
    ('P0072', 'S001'), -- 'En Forma' - Once +
    ('P0073', 'S001'), -- 'Los Juegos de la Amistad a 50 Años de Distancia' - Once +
    ('P0074', 'S001'), -- 'NED, La Nueva Era del Deporte' - Once +
    ('P0075', 'S001'), -- 'Palco a Debate' - Once +
    ('P0076', 'S001'), -- 'Tablero de Ajedrez' - Once +
    ('P0077', 'S001'), -- 'Figuras del Deporte Mexicano' - Once +
    ('P0078', 'S001'), -- 'Fútbol Americano Liga Intermedia 2020' - Once +
    ('P0079', 'S001'), -- 'Guinda y Blanco. Historia De Una Pasión' - Once +
    ('P0080', 'S001'), -- 'Todos a Bordo' - Once +
    ('P0081', 'S001'), -- 'Itinerario' - Once +
    ('P0082', 'S001'), -- 'El Ojo Detrás de la Lente, Cinefotógrafos de México' - Once +
    ('P0083', 'S001'), -- 'Mi Cine, Tu Cine' - Once +
    ('P0084', 'S001'), -- 'T.A.P.: Taller de Actores Profesionales' - Once +
    ('P0085', 'S001'), -- 'Viaje Todo Incluyente' - Once + 
    ('P0086', 'S001'), -- '¿Quién Dijo Yo?' - Once +
    ('P0087', 'S001'), -- 'Cristianos en armas' - Once +
    ('P0088', 'S001'), -- 'Historia del pueblo mexicano' - Once +
    ('P0089', 'S001'), -- 'De puño y letra' - Once +
    ('P0090', 'S001'), -- 'Perspectivas históricas' - Once +
    ('P0091', 'S001'), -- 'Crónicas Y Relatos De México A Dos Voces' - Once +
    ('P0092', 'S001'), -- '6 Grados de Separación' - caricatura ONCE NIÑOS
    ('P0093', 'S001'), -- 'Arquitectura del Poder' - Once +
    ('P0094', 'S001'), -- 'Los Que Llegaron' - Once +
    ('P0095', 'S001'), -- 'La Educación En México' - educativo ONCE NIÑOS Y ONCE DIGITAL
    ('P0096', 'S001'), -- 'Voces de la Constitución' - Once +
    ('P0097', 'S001'), -- 'Especiales La Ciudad de México en el Tiempo' - Once +
    ('P0098', 'S001'), -- 'Historias De Vida' - Once +
    ('P0099', 'S001'), -- 'Ven acá... con Eugenia León y Pavel Granados' - Once +
    ('P0101', 'S001'), -- 'Emergentes' - Once +
    ('P0102', 'S001'), -- 'Noche, Boleros y Son' - Once +
    ('P0103', 'S001'), -- 'Contigo' - Once +
    ('P0104', 'S001'), -- 'Conciertos OSIPN' - Once +
    ('P0105', 'S001'), -- 'Concurso Nacional De Estudiantinas: La Serie' - Once +
    ('P0106', 'S001'), -- 'Bandas en Construcción' - Once +
    ('P0107', 'S001'), -- 'Ninguna Como Mi Tuna' - Once +
    ('P0108', 'S004'), -- 'Foro Once' - Once México  
    ('P0109', 'S001'), -- 'El Timpano' - Once +
    ('P0110', 'S001'), -- 'Acústicos Central Once' - Once +
    ('P0111', 'S001'), -- 'La Central' - Once +
    ('P0112', 'S001'), -- 'Musivolución' - Once +
    ('P0113', 'S001'), -- 'Añoranzas' - Once +
    ('P0114', 'S001'), -- 'Rock En Contacto' - Once +
    ('P0115', 'S001'), -- 'Especiales Musicales de Central Once' - Once +
    ('P0116', 'S001'), -- 'Especial Sonoro 2013' - Once +
    ('P0117', 'S001'), -- 'Big Band Fest En El Lunario' - Once +    
    ('P0118', 'S003'), -- 'El Show de los Once' - Once Niños y Niñas
    ('P0119', 'S003'), -- 'Trillizas de colores' - Once Niños y Niñas
    ('P0120', 'S003'), -- 'Pie rojo' - Once Niños y Niñas
    ('P0121', 'S003'), -- 'De viaje por un libro' - Once Niños y Niñas
    ('P0122', 'S003'), -- 'Las viejas cintas de Staff' - Once Niños y Niñas
    ('P0123', 'S003'), -- 'Las nuevas cintas de Staff' - Once Niños y Niñas
    ('P0124', 'S003'), -- 'Los reportajes de ONN' - Once Niños y Niñas
    ('P0125', 'S003'), -- 'T-Reto' - Once Niños y Niñas
    ('P0126', 'S003'), -- 'Intelige' - Once Niños y Niñas
    ('P0127', 'S003'), -- 'Galería Once Niñas y Niños' - Once niños y niñas
    ('P0128', 'S003'), -- 'Ahorrando Ando' - Once niños y niñas
    ('P0129', 'S003'), -- 'Ek' - Once Niños y Niñas
    ('P0130', 'S003'), -- 'Libros En Acción' - Once Niños y Niñas
    ('P0131', 'S001'), -- 'El Diván de Valentina' - Once +
    ('P0131', 'S003'), -- 'El Diván de Valentina' - Once Niños y Niñas
    ('P0132', 'S003'), -- 'Preguntas del planeta con Lucy' - Once Niños y Niñas
    ('P0133', 'S003'), -- 'Verdadero o falso' - Once Niños y Niñas
    ('P0134', 'S003'), -- '¿Cómo? con Mo' - Once Niños y Niñas
    ('P0135', 'S003'), -- '¿Qué pasaría si…?' - Once Niños y Niñas
    ('P0136', 'S003'), -- 'Un Día en... ON' - Once Niños y Niñas
    ('P0137', 'S003'), -- 'Abuelos' - Once Niños y Niñas
    ('P0138', 'S003'), -- 'Canciones Once Niños y Niñas' - 
    ('P0139', 'S003'), -- 'Código – L' - Once Niños y Niñas
    ('P0140', 'S001'), -- 'Kipatla LSM' - Once +
    ('P0140', 'S003'), -- 'Kipatla LSM' - Once Niños y Niñas
    ('P0141', 'S003'), -- 'Sofía Luna, Agente Especial' - Once Niños y Niñas
    ('P0142', 'S003'), -- 'Alcánzame Si Puedes' - Once Niños y Niñas
    ('P0143', 'S003'), -- 'Arte Al Rescate' - Once Niños y Niñas
    ('P0144', 'S001'), -- 'De Compras' - Once +
    ('P0144', 'S003'), -- 'De Compras' - Once Niños y Niñas
    ('P0145', 'S003'), -- 'DIZI' - Once Niños y Niñas
    ('P0146', 'S003'), -- 'Secretos culinarios de Staff' - Once Niños y Niñas
    ('P0147', 'S003'), -- 'DXT' - Once Niños y Niñas
    ('P0148', 'S003'), -- 'Las Piezas del Rompecabezas' - Once Niños y Niñas
    ('P0149', 'S003'), -- 'Mi Lugar' - Once Niños y Niñas
    ('P0150', 'S003'), -- 'Cuentos De Pelos' - Once Niños y Niñas
    ('P0151', 'S003'), -- 'Perros Y Gatos' - Once Niños y Niñas
    ('P0152', 'S003'), -- 'Consulta con el doctor Pelayo' - Once Niños y Niñas
    ('P0153', 'S003'), -- 'Una vez soñé' - Once Niños y Niñas
    ('P0154', 'S003'), -- 'La palabra de Memo' - Once Niños y Niñas
    ('P0155', 'S003'), -- 'Zoológicos Azoombrosos' - Once Niños y Niñas
    ('P0156', 'S003'), -- 'Creciendo Juntos' - Once Niños y Niñas
    ('P0157', 'S003'), -- 'Timora y Sus Extrañas Historias' - Once Niños y Niñas
    ('P0158', 'S003'), -- 'Concierto. A mover el bote en casa' - Once Niños y Niñas
    ('P0159', 'S003'), -- 'Concierto Conmemorativo UNICEF 70 Años' - Once Niños y Niñas
    ('P0160', 'S003'), -- 'Cuenta Con Sofía' - Once Niños y Niñas
    ('P0161', 'S003'), -- 'La Doctora Noyolo y yo' - Once Niños y Niñas
    ('P0162', 'S003'), -- 'Kin' - Once Niños y Niñas
    ('P0163', 'S001'), -- 'Un espacio sin límites' - Once +
    ('P0163', 'S003'), -- 'Un espacio sin límites' - Once Niños y Niñas
    ('P0164', 'S001'), -- 'Especiales Canal Once' - Once +
    ('P0165', 'S001'), -- 'Digital' - Once +
    ('P0278', 'S001'), -- 'Hagamos Que Suceda: La Cuarentena' - Once +
    ('P0166', 'S001'), -- 'México en el Exterior' - Once +
    ('P0167', 'S001'), -- 'Factor Ciencia' - Once +
    ('P0167', 'S004'), -- 'Factor Ciencia' - Once México
    ('P0168', 'S001'), -- 'Hagamos Que Suceda: La Sana Distancia' - Once +
    ('P0169', 'S001'), -- 'Hagamos Que Suceda' - Once +
    ('P0170', 'S001'), -- 'Un lugar llamado México' - Once +
    ('P0171', 'S001'), -- 'México Biocultural' - Once +
    ('P0172', 'S001'), -- 'Agenda Verde' - Once +
    ('P0173', 'S001'), -- 'Chapultepec un Zoológico Desde Adentro' - Once +
    ('P0174', 'S001'), -- 'Detrás de un Click' - Once +
    ('P0175', 'S001'), -- 'El Libro Rojo, Especies Amenazadas' - Once +
    ('P0176', 'S001'), -- 'Nuestros Mares' - Once +
    ('P0177', 'S001'), -- 'Islas de México' - Once +
    ('P0178', 'S001'), -- 'Entre Mares' - Once +
    ('P0180', 'S001'), -- 'México Vive' - Once +
    ('P0181', 'S001'), -- 'Patrimonio Mundial Natural En México' - Once +
    ('P0182', 'S001'), -- 'Hospital Veterinario' - Once +
    ('P0183', 'S001'), -- 'México En La Edad De Hielo' - Once +
    ('P0184', 'S001'), -- 'Naturaleza' - Once +
    ('P0185', 'S001'), -- 'Contra VS' - Once +
    ('P0186', 'S001'), -- 'Chamuco TV' - Once +
    ('P0187', 'S001'), -- 'El Desfiladero' - Once +
    ('P0188', 'S001'), -- 'Cápsulas Politécnicas' - Once +
    ('P0189', 'S001'), -- 'Nuestra Energía' - Once +
    ('P0190', 'S001'), -- 'Largo Aliento' - Once +
    ('P0191', 'S001'), -- 'La ruta de la ciencia' - Once +
    ('P0192', 'S001'), -- 'Especiales de mayo' - Once +
    ('P0193', 'S001'), -- 'Conmemoraciones' - Once +
    ('P0194', 'S001'), -- 'Especiales del Once' - Once +
    ('P0195', 'S001'), -- 'Operación Mamut' - Once +
    ('P0196', 'S001'), -- 'La Maroma Estelar' - Once +
    ('P0197', 'S001'), -- 'A Favor y En Contra' - Once +
    ('P0198', 'S001'), -- 'Agenda a Fondo' - Once +
    ('P0199', 'S001'), -- 'Apuesto al Sexo Opuesto' - Once +
    ('P0200', 'S001'), -- 'Dinero y Poder' - Once +
    ('P0201', 'S001'), -- 'Línea Directa' - Once +
    ('P0202', 'S001'), -- 'John y Sabina' - Once +
    ('P0203', 'S001'), -- 'Encuentros: Educacíon, Ciencia Y Cultura Desde El Politécnico' - Once +
    ('P0204', 'S001'), -- 'Primer Plano' - Once +
    ('P0205', 'S001'), -- 'Sacro y Profano' - Once +
    ('P0206', 'S001'), -- 'De Buena Fe' - Once +
    ('P0207', 'S001'), -- 'De Todos Modos... John Te Llamas' - Once +
    ('P0208', 'S001'), -- 'Del sueño al orgullo Politécnico' - Once +
    ('P0209', 'S001'), -- 'Huélum' - Once +
    ('P0210', 'S001'), -- 'A La Cachi Cachi Porra' - Once +
    ('P0211', 'S001'), -- 'nica' - Once +
    ('P0212', 'S001'), -- 'as' - Once +
    ('P0213', 'S001'), -- 'Jóvenes Politécnicos' - Once +
    ('P0214', 'S001'), -- 'Espiral Politécnica' - Once +
    ('P0215', 'S001'), -- 'Burros Blancos' - Once +
    ('P0216', 'S001'), -- La VerDrag - Once +
    ('P0217', 'S001'), -- 'DÍA MUNDIAL DE LA LUCHA CONTRA EL VIH/SIDA 2023' - Once +
    ('P0217', 'S005'), -- 'DÍA MUNDIAL DE LA LUCHA CONTRA EL VIH/SIDA 2023' - Once Digital
    ('P0218', 'S004'), -- 'Respuestas' - Once México
    ('P0219', 'S001'), -- 'Acá los paisanos' - Once +
    ('P0220', 'S001'), -- 'Mujeres Transformando México' - Once +
    ('P0220', 'S005'), -- 'Mujeres Transformando México' - Once Digital
    ('P0221', 'S001'), -- 'Conecta con la Lectura' - Once +
    ('P0222', 'S001'), -- 'A+A Amor y Amistad' - Once +
    ('P0223', 'S001'), -- 'Aprender en Comunidad' - Once +
    ('P0224', 'S001'), -- 'Presente' - Once +
    ('P0225', 'S001'), -- 'México en Centroamérica: latidos de hermandad' - Once +
    ('P0226', 'S001'), -- 'Tu futuro, nuestro futuro' - Once +
    ('P0227', 'S001'), -- 'Abraza la diversidad' - Once +
    ('P0228', 'S001'), -- 'Entre nosotras' - Once +
    ('P0229', 'S001'), -- 'Pinta tu barrio' - Once +
    ('P0230', 'S001'), -- '80 millones' - Once + 
    ('P0231', 'S004'), -- 'D Todo' - Once México 
    ('P0232', 'S001'), -- 'A Medio Siglo de México 68' - Once +
    ('P0233', 'S005'), -- 'Estación Global' - Once Digital
    ('P0234', 'S001'), -- 'Altoparlante' - Once +
    ('P0235', 'S001'), -- '#Calle 11' - Once +
    ('P0235', 'S004'), -- '#Calle 11' - Once México
    ('P0236', 'S001'), -- 'Casos Médicos, Nuevos Tratamientos' - Once +
    ('P0237', 'S001'), -- 'Cómo Lo Celebro' - Once +
    ('P0238', 'S001'), -- 'Diversos Somos' - Once +
    ('P0239', 'S001'), -- 'Mi historia de amor' - Once +
    ('P0240', 'S001'), -- 'Lo Que Me Prende' - Once +
    ('P0241', 'S001'), -- 'México Social' - Once +
    ('P0242', 'S001'), -- 'Mexicanos en el extranjero' - Once +
    ('P0243', 'S001'), -- 'Me Mueves' - Once +
    ('P0244', 'S001'), -- 'Juicios Orales' - Once +
    ('P0245', 'S001'), -- 'Los Otros Mexicanos' - Once +
    ('P0246', 'S001'), -- 'Maestros' - Once +
    ('P0247', 'S001'), -- 'Nuevos Pasos' - Once +
    ('P0248', 'S001'), -- 'Oficios' - Once +
    ('P0249', 'S001'), -- 'Perfil Público' - Once +
    ('P0250', 'S001'), -- 'Pies En La Tierra' - Once +
    ('P0251', 'S001'), -- 'Retratos' - Once +
    ('P0252', 'S001'), -- 'Signos De Los Tiempos' - Once +
    ('P0253', 'S001'), -- 'Espiral' - Once +
    ('P0254', 'S001'), -- 'Francisco, Visita Papal a México' - Once +
    ('P0255', 'S001'), -- 'Fuerza Interior' - Once +
    ('P0256', 'S001'), -- 'Habla de Frente' - Once +
    ('P0257', 'S001'), -- 'Hacer El Bien' - Once +
    ('P0258', 'S001'), -- 'Hacen El Bien y Miran A Quién' - Once +
    ('P0259', 'S001'), -- 'Interesados Presentarse' - Once +
    ('P0260', 'S001'), -- 'Instantáneas' - Once +
    ('P0261', 'S001'), -- 'Independientes' - Once +
    ('P0262', 'S001'), -- 'Haciendo Eco' - Once +
    ('P0263', 'S001'), -- 'Hechas En México' - Once +
    ('P0264', 'S001'), -- 'Antípodas' - Once +
    ('P0265', 'S001'), -- 'Juana Inés' - Once +
    ('P0266', 'S001'), -- 'Soy tu fan' - Once +
    ('P0267', 'S001'), -- 'XY' - Once +
    ('P0268', 'S001'), -- 'Crónica de Castas' - Once +
    ('P0269', 'S001'), -- 'Woki Tokis' - Once Niños +
    ('P0270', 'S001'), -- 'Fonda Susilla' - Once +
    ('P0271', 'S001'), -- 'Malinche' - Once +
    ('P0272', 'S001'), -- 'Pacientes' - Once +
    ('P0273', 'S001'), -- 'Futboleros' - Once Niños +
    ('P0274', 'S001'), -- 'Noctámbulos, Historia de Una Noche' - Once +
    ('P0275', 'S001'), -- 'Muerte Sin fin' - Once +
    ('P0276', 'S001'), -- 'Los Minondo' - Once +
    ('P0277', 'S001'), -- 'Todo Por Nada' - Once +
    ('P0280', 'S002'), -- 'Noticiario Mañanero' - Once Noticias +
    ('P0281', 'S002'), -- 'Noticiario Mañanero' - Once Noticias +
    ('P0282', 'S002'), -- 'Noticiario Meridiano' - Once Noticias +
    ('P0283', 'S002'), -- 'Noticiario Nocturno' - Once Noticias +
    ('P0284', 'S002'), -- 'Noticiario Sabatino' - Once Noticias +
    ('P0285', 'S002'), -- 'Noticiario Dominical' - Once Noticias +
    ('P0286', 'S002'), -- 'Noticiario Noticiario' - Once Noticias +
    ('P0286', 'S001'); -- 'Noticiario' - Once +
       select * from seccionProgramas;

