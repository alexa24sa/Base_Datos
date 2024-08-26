-- SE CREA LA BASE DE DATOS DESDE ESTE PUNTO

CREATE DATABASE canalonce
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE canalonce;

-- CREACIÓN DE LAS TABLAS PARA CADA UNO DE LOS DATOS QUE SE ALMACENARÁN EN LA BASE
CREATE TABLE seccion
(
  idSeccion INT(5) NOT NULL,
  nombre VARCHAR(12) NOT NULL,
  PRIMARY KEY (idSeccion)
);

CREATE TABLE categoria
(
  idCategoria INT(5) NOT NULL,
  nombre VARCHAR(60) NOT NULL,
  PRIMARY KEY (idCategoria)
);

CREATE TABLE clasificacion
(
  idClasificacion INT(5) NOT NULL,
  nombreNivel VARCHAR(5) NOT NULL,
  horarioPreferente VARCHAR(30) NOT NULL,
  descripcion VARCHAR(80) NOT NULL,
  PRIMARY KEY (idClasificacion)
);

CREATE TABLE conductores
(
  idConductor INT(5) NOT NULL,
  nombre VARCHAR(60) NOT NULL,
  PRIMARY KEY (idConductor)
);

CREATE TABLE pais
(
  idPais INT(5) NOT NULL,
  nombre VARCHAR(40) NOT NULL,
  PRIMARY KEY (idPais)
);

CREATE TABLE region
(
  idRegion INT(5) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  idPais INT(5) NOT NULL,
  PRIMARY KEY (idRegion),
  FOREIGN KEY (idPais) REFERENCES pais(idPais)
);

CREATE TABLE distribuidor_distintivo
(
  idDistintivo INT(5) NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  plataforma VARCHAR(15) NOT NULL,
  PRIMARY KEY (idDistintivo)
);

CREATE TABLE podcast
( 
   idPodcast INT(5) NOT NULL,
  nombre VARCHAR(25) NOT NULL,
  descripcion VARCHAR(80) NOT NULL,
  idCategoria INT(5) NOT NULL,
  PRIMARY KEY (idPodcast),
  FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria)
);

CREATE TABLE blogs
( 
  idBlog INT(5) NOT NULL,
  nombre VARCHAR(25) NOT NULL,
  descripcion VARCHAR(80) NOT NULL,
  idCategoria INT(5) NOT NULL,
  PRIMARY KEY (idBlog),
  FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria)
);

CREATE TABLE distribuidorRegion
(
  idRegion INT(5) NOT NULL,
  idDistintivo INT(5) NOT NULL,
  PRIMARY KEY (idRegion, idDistintivo),
  FOREIGN KEY (idRegion) REFERENCES region(idRegion),
  FOREIGN KEY (idDistintivo) REFERENCES distribuidor_distintivo(idDistintivo)
);

CREATE TABLE seccionBlog
(
  idSeccion INT(5) NOT NULL,
  idBlog INT(5) NOT NULL,
  PRIMARY KEY (idSeccion, idBlog),
  FOREIGN KEY (idSeccion) REFERENCES seccion(idSeccion),
  FOREIGN KEY (idBlog) REFERENCES blogs(idBlog)
);

CREATE TABLE seccionPodcast
( 
  idSeccion INT(5) NOT NULL,
  idPodcast INT(5) NOT NULL,
  PRIMARY KEY (idPodcast, idSeccion),
  FOREIGN KEY (idPodcast) REFERENCES podcast(idPodcast),
  FOREIGN KEY (idSeccion) REFERENCES seccion(idSeccion)
);

CREATE TABLE programas
(
  idPrograma CHAR(5) NOT NULL,
  nombre VARCHAR(40) NOT NULL,
  descripcion VARCHAR(118) NOT NULL,
  idClasificacion INT(5),
  idCategoria INT(5) NOT NULL,
  PRIMARY KEY (idPrograma),
  FOREIGN KEY (idClasificacion) REFERENCES clasificacion(idClasificacion),
  FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria)
);

CREATE TABLE horario
(
  idHorario INT(5) NOT NULL,
  hora_Inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  fecha DATE NOT NULL,
  idPrograma INT(5) NOT NULL,
  PRIMARY KEY (idHorario),
  FOREIGN KEY (idPrograma) REFERENCES programas(idPrograma)
);

CREATE TABLE programaPais
(
  idPrograma INT(5) NOT NULL,
  idPais INT(5) NOT NULL,
  PRIMARY KEY (idPrograma, idPais),
  FOREIGN KEY (idPrograma) REFERENCES programas(idPrograma),
  FOREIGN KEY (idPais) REFERENCES pais(idPais)
);

CREATE TABLE programaConductores
(
  idConductor INT(5) NOT NULL,
  idPrograma INT(5) NOT NULL,
  PRIMARY KEY (idConductor, idPrograma),
  FOREIGN KEY (idConductor) REFERENCES conductores(idConductor),
  FOREIGN KEY (idPrograma) REFERENCES programas(idPrograma)
);

CREATE TABLE seccionProgramas
(
  idPrograma INT(5) NOT NULL,
  idSeccion INT(5) NOT NULL,
  PRIMARY KEY (idPrograma, idSeccion),
  FOREIGN KEY (idPrograma) REFERENCES programas(idPrograma),
  FOREIGN KEY (idSeccion) REFERENCES seccion(idSeccion)
);

-- APARTADO PARA LA INSERCIÓN DE DATOS DENTRO DE LAS TABLAS (IMPORTANTE SEGUIR EL MISMO ORDEN DE DECLARACIÓN DE LAS TABLAS).
INSERT INTO seccion (nombre, idSeccion)
VALUES (NULL, NULL); /*LO DEJO ASÍ PORQUE ESO TE TOCA A TI*/

INSERT INTO categoria (idCategoria, nombre)
VALUES (01, 'Cocina'),
        (02, 'Cultura'),
        (03, 'Digital'),
        (04, 'Conversación'),
        (05, 'Deporte'),
        (06, 'Entretenimiento'), 
        (07, 'Historia'),
        (08, 'Música'),
        (09, 'Niñas y Niños'),
        (10, 'Información e Investigación'),
        (11, 'Naturaleza'),
        (12, 'Opinión'),
        (13, 'Porgramas Politécnicos'),
        (14, 'Sociedad'), 
        (15, 'Series');

INSERT INTO clasificacion (idClasificacion, nombreNivel, horarioPreferente, descripcion)
VALUES (001, 'AA', 'Cualquier horario', 'Todos los públicos son aptos de ver la programación; comprensible para menores de 7 años' ),
	   (002, 'A', 'Cualquier horario', 'Todos los públicos son aptos para ver la programación'),
       (003, 'B', 'A partir de las 16 y hasta las 5 horas', 'Programación para mayores de 12 años, menores requieren supervisión.'),
       (004, 'B-15', 'A partir de las 21 horas', 'Programación para mayores de 15 años, menores requieren supervisión.'),
       (005, 'C', 'A partir de las 22 horas', 'Programación para mayores de 18 años'),
       (006, 'D', 'A partir de la medianoche', 'Programación exclusivamente para adultos');
       
INSERT INTO conductores (idConductor, nombre)
VALUES  (001, 'Óscar Uriel Macías Mora'), -- TAP (programa), EN LA BARRA (programa)
        (002, 'Pablo L. Morán'), -- ENTRE REDES (programa)
        (003, 'Andi Martín del Campp'), -- ENTRE REDES (programa)
        (004, 'Hector Trejo'), -- ENTRE REDES (programa)
        (005, 'Jaime Gama'), -- ENTRE REDES (programa)
        (006, 'Jerry Velezquez'), -- ENTRE REDES (programa)
        (007, 'Victoria Islas'), -- ENTRE REDES (programa)
        (008, 'Julia Didriksson'), -- SI SOMOS (audiopodcast)
        (009, 'Nancy Mejía'), -- SI SOMOS (audiopodcast)
        (010, 'Ana Grimaldo'), -- SI SOMOS (audiopodcast)
        (011, 'Gracia Alzaga'), -- SI SOMOS (audiopodcast)
        (012, 'Miguel Conde'), -- PASO A PASO (programa)
		(013, 'Heriberto Javier Murrieta Cantú'), -- M/Aquí (programa)
		(014, 'Ezra Alcázar'), -- El desfiladero (programa)
        (015, 'Alejandro García Moreno'),-- Factor Ciencia (programa)
        (016, 'Rafael Guadarrama'),-- Factor Ciencia (programa)
        (017, 'Alejandro García Moreno'),-- Factor Ciencia (programa)
        (018, 'Lucía VazqueZ Corona'),-- Factor Ciencia (programa)
        (019, 'Amanda Drag'), -- La VerDrag (programa)
        (020, 'Paco Ignacio Taibo II'), -- El mitote Librero (programa)
        (021, 'Norma Márquez'), -- El mitote Librero (programa)
        (022, 'Andrés Ruiz'), -- El mitote Librero (programa)
        (023, 'Guadalupe Contreras'), -- Dialogos en Confianza (programa), Res?uestas (programa)
        (024, 'Anahí Vázquez'), -- Dialogos en Confianza (programa)
        (025, 'Citlaly López'), -- Dialogos en Confianza (programa)
        (026, 'José Bandera'), -- Dialogos en Confianza (programa)
        (027, 'Cristina Jáuregui'), -- Dialogos en Confianza (programa)
        (028, 'Natalia Jiménez '), -- Dialogos en Confianza (programa)
        (029, 'Eduardo Valenzuela'), -- Dialogos en Confianza (programa)
        (030, 'Leticia Carbajal'), -- Dialogos en Confianza (programa)
        (031, 'Azucena Celis'), -- Dialogos en Confianza (programa)
        (032, 'Diana Laura Gómez'), -- Dialogos en Confianza (programa)
        (033, 'Daniel Herrera'), -- Boleros, Noches y Son (programa)
        (034, 'Nacho Mendéz'), -- Boleros, Noches y Son (programa)
        (035, 'Rodrigo de la Cadena'), -- Boleros, Noches y Son (programa)
        (036, 'Luhana Gardi'), -- Boleros, Noches y Son (programa)
        (037, 'Gabriela Tinajero'), -- Huélum (programa)
        (038, 'Fernando Rivera Calderón'), -- Operación Mamut (programa)
        (039, 'Nora Huerta'), -- Operación Mamut (programa)
        (040, 'Jairo Calixto Albarrán'), -- Operación Mamut (programa)
        (041, 'Ana María Lomeli'), -- Hagamos que suceda (programa)
        (042, 'Alejandra Ley'), -- Contigo (programa)
        (043, 'Cecilia Gallardo'), -- Contigo (programa)
        (044, 'Joao Henrique'), -- Contigo (programa)
        (045, 'Sabina Berman'), -- Largo Aliento (programa), John y Sabina (programa)
        (046, 'Zohar Salgado Álvarez'), -- A+A Especial de Navidad (programa)
        (047, 'Erick Tejeda'), -- A+A Especial de Navidad (programa)
        (048, 'Beatriz Pereyra'), -- A+A Amor y Amistad (programa)
        (049, 'Miguel Conde'), -- La Ruta del Sabor (programa)
        (050, 'Bruno Bichir'), -- Yo sólo sé que no he cenado (programa)
        (051, 'Daniel Giménez Cacho'), -- En materias de pescado (programa), Bebidas de México (Serie/Documental) 
        (052, 'Noé Hernández'), -- Bebidas de México (Serie/Documental) 
        (053, 'Joaquín Cosio'), -- Bebidas de México (Serie/Documental)
        (054, 'Eduardo Victoria'), -- Bebidas de México (Serie/Documental)
        (055, 'Patricia Bernal'), -- Bebidas de México (Serie/Documental)
        (056, 'Karina Gidi'), -- Bebidas de México (Serie/Documental)
        (057, 'Pablo San Román'), -- Tu cocina (programa), Del Mundo al Plato (programa)
        (058, 'Graciela Montaño'), -- Tu cocina (programa)
        (059, 'Yuri de Gortari'), -- Tu cocina (programa)
        (060, 'Gerardo Vázquez Lugo'),-- Tu cocina (programa)
        (061, 'León Aguirre'), -- Tu cocina (programa)
        (062, 'Lucero Soto'), -- Tu cocina (programa)
        (063, 'Pepe Salinas'), -- Tu cocina (programa)
        (064, 'Lucero Soto'), -- Tu cocina (programa)
        (065, 'Marco Rascón'), -- En materia de Pescado (programa)
        (066, 'Enrique Olvera'), -- Diario de un cocinero (programa)
        (067, 'Phillippe Ollé Laprune'), -- Ámerica. Escritores extranjeros de México (Serie/Documental)
		(068, 'Susana Harp'), -- Afroméxico (serie), Diáspora (Serie/Documental) 
        (069, 'Alejandra Robles'), -- Las joyas de Oaxaca (programa)
        (070, 'César González Madruga'), -- México Renace Sostenible (programa)
        (071, 'Heriberto Murrieta'), -- Toros, Sol y Sombra (programa)
        (072, 'Rafael Cué'), -- Toros, Sol y Sombra (programa)
        (073, 'Rodrigo Castaño Valencia'), -- Manos de Artesano (programa)
        (074, 'Carlos Pascual'), -- Palabra de Autor (programa)
        (075, 'Mónica Lavín'), -- Palabra de Autor (programa)
        (076, 'Adriana Morales'), -- ¡Hagamos Clic! (programa)
        (077, 'Jazmín Cato Sosa'), -- Inclusión Radical (programa)
        (078, 'Itzel Aguilar Mora'), -- Inclusión Radical (programa)
        (079, 'Vania R. Belmont'), -- Inclusión Radical (programa)
        (080, 'Eduardo Valenzuela'), -- Inclusión Radical (programa)
        (081, 'Ophelia Pastrana'), -- Multipass (programa)
        (082, 'Alessandra Santamaría'), -- Pop 11.0 (programa)
        (083, 'Rodrigo Garcia'), -- Pop 11.0 (programa)
        (084, 'Patricio Córdova'), -- Economía en corto (serie)
        (085, 'Cristina Pachecho'), -- Conversando con Cristina Pachecho (serie), Aquí nos tocó vivir (programa)
        (086, 'Guadalupe Contreras'), -- En Persona (programa), Once Noticias Matutino (noticias/programa)
        (087, 'Rubén Álvarez Mendiola'), -- Aquí en corto (programa)
        (088, 'Marta de la Lama'), -- El gusto es mio (programa)
        (089, 'Guadalupe Loaeza'), -- La Cita (programa)
        (090, 'Javier Solórzano'), -- Solórzano 3.0 (programa), Perfil Público (programa)
        (091, 'Catalina Noriega'), -- Entre Mitos y Realidades (programa)
        (092, 'Pilar Ferreira'), -- Entre Mitos y Realidades (programa)
        (093, 'Javier Trejo Garay'), -- Pelotero a la bola (programa)
        (094, 'Diana Laura Gómez'), -- Pelotero a la bola (programa)
        (095, 'Gustavo Torrero'), -- Pelotero a la bola (programa)
        (096, 'Alfonso Lanzagorta'), -- Pelotero a la bola (programa)
        (097, 'Beatriz Pereyra'), -- Pelotero a la bola (programa)
        (098, 'Verónica Toussaint '), -- Yoga (programa)
        (099, 'Adriana Bautista'), -- Baile Latino (programa)
        (100, 'Caly Minero'), -- Activate (programa)
		(101, 'Laura Santín'), -- Body Jam (programa)
		(102, 'Aldo Sánchez Vera'), -- Carrera Panamericana (programa)
        (103, 'Alejandro Schenini'), -- En forma (programa)
        (104, 'Joss Waleska'), -- NED, La nueva era del deporte (programa)
        (105, 'Alfredo Dominguez Muro'), -- Palco a Debate (programa)
        (106, 'Rodrigo Mendoza'), -- Tablero de Ajedrez (programa)
        (107, 'Marcela Pezet'), -- Todos a Bordo (programa)
        (108, 'Tamara de Anda'), -- Itinerario (programa)
        (109, 'Jean-Christophe Berjon'), -- Mi cine, tu Cine (programa)
        (110, 'Alejandra López'), -- Viaje Todo Incluyente (programa)
        (111, 'Jocelyn Chávez'), -- Viaje Todo Incluyente (programa)
        (112, 'Abel Ponce'), -- Viaje Todo Incluyente (programa)
        (113, 'Julio César Hernández'), -- Viaje Todo Incluyente (programa)
        (114, 'Joaquín Alva'), -- Viaje Todo Incluyente (programa)
        (115, 'Luis Gerardo Méndez'), -- ¿Quién Dijo Yo? (programa)
		(116, 'Bernardo Barranco'), -- Cristianos en Armas (programa)
		(117, 'Sofía Álvarez'), -- De puño y Letra (programa)
		(118, 'Margarita  Vesquez Montaño '), -- Perspectivas Históricas (programa)
		(119, 'Ángeles González Gamio'), -- Crónicas y relatos de México a dos voces (serie documental), Crónicas y relatos de México (serie documental) 
	    (120, 'Maria Elena Cantú'), -- Arquitectura del Poder (programa)
        (121, 'Mauricio Isaac'), -- La educación en México (programa)
        (122, 'José Crriedo'), -- Voces de la Constitución (programa)
        (123, 'Eugenia León'), -- Ven Acá... con Eugenia León y Pavel Granados (programa)
        (124, 'Pavel Granados'), -- Ven Acá... con Eugenia León y Pavel Granados (programa)
        (125, 'Alexia Ávila'), -- Concurso de Tunas (programa), Ninguna como mi Tuna (programa), Conecta con la Lectura (programa), D TODO (podcast)
        (126, 'Ausencio Cruz'), -- Concurso Nacional de Estudiantinas (programa), Ninguna como mi Tuna (programa)
        (127, 'Davis Filio'), -- El timpano (programa)
        (128, 'Sergio Félix'), -- El timpano (programa)
        (129, 'Aldo Sánchez Vera'), -- La Central (programa)
        (130, 'Edgar Barroso'), -- Musivolución (programa)
        (131, 'Jorge Saldaña'), -- Añoranzas (programa)
        (132, 'Alejandra Moreno'), -- Rock en contacto (programa)
        (133, 'Alonso Ruizpalacios'), -- Rock en contacto (programa)
        (134, 'Aldo Sánchez Vera'), -- EMCO (programa)
        (135, 'Fabián Garza'), -- El show de los Once (programa)
        (136, 'Micaela Gramajo'), -- El show de los Once (programa)
        (137, 'Ricardo Zárraga'), -- El show de los Once (programa)
        (138, 'Luisa Garibay'), -- El show de los Once (programa)
        (139, 'Ahichell Sánchez'), -- El show de los Once (programa)
        (140, 'Mirelle Romo de Vivar'), -- El show de los Once (programa)
        (141, 'Alfredo Farias'), -- El show de los Once (programa)
        (142, 'Neyzer Constantino'), -- El show de los Once (programa)
        (143, 'Yair Prado'), -- El show de los Once (programa)
        (144, 'Alejandro Lago'), -- El show de los Once (programa)
        (145, 'Omar Esquinca'), -- Los reportajes de Onn (programa)
        (146, 'José Luis Arévalo'), -- Los reportajes de Onn (programa)
        (147, 'Xareny Orzal'), -- Los reportajes de Onn (programa)
        (148, 'Giuliana Vega'), -- Los reportajes de Onn (programa)
        (149, 'Aarón Herández Farfán'), -- Los reportajes de Onn (programa)
        (150, 'Ulises David'), -- Los reportajes de Onn (programa)
        (151, 'Alejandra Rodríguez'), -- Intelige (programa)
        (152, 'Iván González'), -- Intelige (programa)
        (153, 'Sofía Luna'), -- Sofía Luna, Agente Especial (programa)
        (154, 'Max Espejel Hernández'), -- Alcanzame si puedes (programa), Agenda Verde (programa), Hospital Veterinario (programa)
        (155, 'Esther Oldak'), -- Creciendo Juntos (programa)
        (156, 'Rocío Brauer'), -- Digital (programa) 
        (157, 'Khristina Giles'), -- Un lugar llamado México (programa)
        (158, 'Magali Boyselle Hernández'), -- Detrás de un Click (programa)
        (159, 'Manuel Lazcano'), -- Entre Mares (programa)
        (160, 'Javier Solórzano'), -- México Vive (programa), Perfil Público (programa), Francisco, Visita Papal a México (programa)
        (161, 'Alejandro García Moreno'), -- Naturaleza (programa)
        (162, 'Fisgón-Rapé-Hernández'), -- Chamuco TV (programa)
        (163, 'Guadalupe Contreras'), -- Nuestra Energía (programa)
        (164, 'Margarita González Gamio'), -- A favor y en Contra (programa)
        (165, 'Jorge del Villar'), -- A favor y en Contra (programa)
        (166, 'José Buendía Hegewisch'), -- Agenda a Fondo (programa)
        (167, 'Kimberly Armengol'), -- Apuesto al Sexo Opuesto (programa)
        (168, 'Ezra Shabot Askenazi'), -- Dinero y poder (programa), Línea Directa (programa)
        (169, 'John Ackerman'), -- John y Sabina (programa), De Todos Modos... John Te Llamas (programa)
        (170, 'Sergio Aguayo'), -- Primer Plano (programa)
        (171, 'María Amparo Casar'), -- Primer Plano (programa)
        (172, 'José Antonio Crespo'), -- Primer Plano (programa)
        (173, 'Leonardo Curzio'), -- Primer Plano (programa)
        (174, 'Lorenzo Meyer'), -- Primer Plano (programa)
        (175, 'Francisco Paoli Bolio'), -- Primer Plano (programa)
        (176, 'Bernardo Barranco'), -- Sacro y Profano
        (177, 'Gibrán Ramírez Reyes'), -- De Buena Fe (programa)
        (178, 'Estefanía Veloz'), -- De Buena Fe (programa)
        (179, 'Danger AK'), -- De Buena Fe (programa)
        (180, 'Alejandro García Moreno'), -- Gaceta Politécnica (programa)
        (181, 'Ricardo Raphael'), -- Espiral Politécnica (programa), Espiral (programa), #Calle11 (programa)
        (182, 'Sandra Arguelles'), -- Presente (programa) 
        (183, 'Estela Livera'), -- Entre Nosotras (programa)
        (184, 'Patricia Kelly'), -- 80 Millones (programa)
        (185, 'Carlos Bolado'), -- A medio siglo de México 68
        (186, 'Valentina Sierra'), -- Altoparlante (programa)
        (187, 'Fernando Bonilla'), -- Altoparlante (programa)
        (188, 'Luis Lesher'), -- Altoparlante (programa)
        (189, 'Mario Luis Fuentes Alcalá'), -- Conductor (programa)
        (190, 'Mariana Lapuente Flores'), -- Mexicanos en el extranjero 
        (191, 'Carmen Muñoz'), -- Nuevos Pasos
        (192, 'María Roiz'), -- Fuerza Interior (programa)
        (193, 'Jorge del Villar'), -- Habla de Frente (programa)
        (194, 'Fernanda Tapia'), -- Hacer el Bien (serie), Hacen El Bien y Miran A Quién (programa)
        (195, 'Axel Escalante'), -- Interesados Presentarse (programa)
        (196, 'Zandra Zittle'), -- Once Noticias Meridiano (noticias/programa), Once Noticias Dominical (noticias/programa)
        (197, 'Leticia Carbajal'), -- Once Noticias Nocturno (noticias/programa)
        (198, 'Elvira Angélica Rivera'); -- Once Noticias Sabatino (noticias/programa)

INSERT INTO pais (idPais, nombre)
VALUES (01, 'Estados Unidos'),
	   (02, 'México');

INSERT INTO region (idRegion, nombre, idPais)
VALUES (001, 'Alabama', 01),
       (002, 'Alaska', 01),
       (003, 'Arizona', 01),
       (004, 'Arkansas', 01),
       (005, 'California', 01),
       (006, 'Colorado', 01),
       (007, 'Connecticut', 01),
       (008, 'Delaware', 01),
       (009, 'District of Columbia', 01),
       (010, 'Florida', 01),
       (011, 'Georgia', 01),
       (012, 'Hawai', 01),
       (013, 'Idaho', 01),
       (014, 'Illinois', 01),
       (015, 'Indiana', 01),
       (016, 'Kansas', 01),
       (017, 'Kentucky', 01),
       (018, 'Lousiana', 01),
       (019, 'Maine', 01),
       (020, 'Maryland', 01),
       (021, 'Massachusetts', 01),
       (022, 'Michigan', 01),
       (023, 'Minnesota', 01),
       (024, 'Mississipi', 01),
       (025, 'Missouri', 01),
       (026, 'Montana', 01),
       (027, 'Nebraska', 01),
       (028, 'Nevada', 01),
       (029, 'New Hampshire', 01),
       (030, 'New Jersey', 01),
       (031, 'New York', 01),
       (032, 'North Carolina', 01),
       (033, 'Nuevo México', 01),
       (034, 'Ohio', 01),
       (035, 'Oklahoma', 01),
       (036, 'Oregon', 01),
       (037, 'Pennsylvania', 01),
       (038, 'Puerto Rico', 01),
       (039, 'República Dominicana', 01),
       (040, 'South Carolina', 01),
       (041, 'Tennessee', 01),
       (042, 'Texas', 01),
       (043, 'United States', 01),
       (044, 'Utah', 01),
       (045, 'Vermont', 01),
       (046, 'Virginia', 01),
       (047, 'Washington', 01),
       (048, 'West Virginia', 01),
       (049, 'Wisconsin', 01),
       (050, 'Wyoming', 01),
       (051, 'Aguascalientes, Aguascalientes', 02),
       (052, 'Campeche, Campeche', 02),
       (053, 'Cancún, Quintana Roo', 02),
       (054, 'Celaya, Guanajuato', 02),
       (055, 'Chetumal, Quintana Roo', 02),
       (056, 'Chihuahua, Chihuahua', 02),
       (057, 'Ciudad de México', 02),
       (058, 'Ciudad Obregón, Sonora', 02),
       (059, 'Coatzacoalcos, Veracruz', 02),
       (060, 'Colima, Colima', 02),
       (061, 'Culiacán, Sinaloa', 02),
       (062, 'Durango, Durango', 02),
       (063, 'Gómez Palacio, Durango', 02),
       (064, 'Guadalajara, Jalisco', 02),
       (065, 'Hermosillo, Sonora', 02),
       (066, 'León, Guanajuato', 02),
       (067, 'Los Mochis, Sinaloa', 02),
       (068, 'Mazatlán, Sinaloa', 02),
       (069, 'Mérida, Yucatán', 02),
       (070, 'Monterrey, Nuevo León', 02),
       (071, 'Morelia, Michoacán', 02),
       (072, 'Oaxaca, Oaxaca', 02),
       (073, 'Cozumel, Quintana Roo', 02),
       (074, 'Puebla, Puebla', 02),
       (075, 'Querétaro, Querétaro', 02),
       (076, 'Saltillo, Coahuila', 02),
       (077, 'San Cristóbal de las Casas, Chiapas', 02),
       (078, 'San Luis Potosí, S.L.P.', 02),
       (079, 'Tapachula, Chiapas', 02),
       (080, 'Tijuana, Baja California', 02),
       (081, 'Toluca, Estado de México', 02),
       (082, 'Cuernavaca, Morelos', 02),
       (083, 'Tuxtla Gutiérrez, Chiapas', 02),
       (084, 'Uruapan, Michoacán', 02),
       (085, 'Valle de Bravo, Edo. de México', 02),
       (086, 'Villahermosa, Tabasco', 02),
       (087, 'Xalapa, Veracruz', 02),
       (088, 'Zacatecas, Zacatecas', 02),
       (089, 'Monterrey, Nuevo Leon', 02);

INSERT INTO distribuidor_distintivo (idDistintivo, nombre, plataforma) 
VALUES (01, 'XEIPN-TDT', 'TV abierta'),
		(02, 'XHTJB-TDT', 'TV abierta'),
		(03, 'XHCPES-TDT', 'TV abierta'),
		(04, 'XHCHI-TDT', 'TV abierta'),
		(05, 'XHCHU-TDT', 'TV abierta'),
		(06, 'XHCHD-TDT', 'TV abierta'),
		(07, 'XHSCE-TDT', 'TV abierta'),
		(08, 'XHDGO-TDT', 'TV abierta'),
		(09, 'XHGPD-TDT', 'TV abierta'),
		(10, 'XHPBGD-TDT', 'TV abierta'),
		(11, 'XHVBM-TDT', 'TV abierta'),
		(12, 'XHCIP-TDT', 'TV abierta'),
		(13, 'XHPBMY-TDT', 'TV abierta'),
		(14, 'XHCPBS-TDT', 'TV abierta'),
		(15, 'XHCPAN-TDT', 'TV abierta'),
		(16, 'XHCPAC-TDT', 'TV abierta'),
		(17, 'XHPBCN-TDT', 'TV abierta'),
		(18, 'XHSLP-TDT', 'TV abierta'),
		(19, 'XHSIN-TDT', 'TV abierta'),
		(20, 'XHSPRAG-TDT', 'TV abierta'),
		(21, 'XHSPRCC-TDT', 'TV abierta'),
		(22, 'XHSPRSC-TDT', 'TV abierta'),
		(23, 'XHSPRTP-TDT', 'TV abierta'),
		(24, 'XHSPRTC-TDT', 'TV abierta'),
		(25, 'XHSPRCO-TDT', 'TV abierta'),
		(26, 'XHSPRCE-TDT', 'TV abierta'),
		(27, 'XHSPRLA-TDT', 'TV abierta'),
		(28, 'XHSPREM-TDT', 'TV abierta'),
		(29, 'XHSPRMO-TDT', 'TV abierta'),
		(30, 'XHSPRUM-TDT', 'TV abierta'),
		(31, 'XHSPROA-TDT', 'TV abierta'),
		(32, 'XHSPRMQ-TDT', 'TV abierta'),
		(33, 'XHSPRMS-TDT', 'TV abierta'),
		(34, 'XHSPROS-TDT', 'TV abierta'),
		(35, 'XHSPRHA-TDT', 'TV abierta'),
		(36, 'XHSPRVT-TDT', 'TV abierta'),
		(37, 'XHSPRTA-TDT', 'TV abierta'),
		(38, 'XHSPRCA-TDT', 'TV abierta'),
		(39, 'XHSPRXA-TDT', 'TV abierta'),
		(40, 'XHSPRME-TDT', 'TV abierta'),
		(41, 'XHSPRZC-TDT', 'TV abierta'),
		(42, 'XHCOZ-TDT', 'TV abierta'),
        (43, 'DIRECTV', 'DTH'),
        (44, 'XFINITY', 'CABLE'),
        (45, 'SLING', 'OTT'),
        (46, 'CHARTER SPECTRUM', 'CABLE'),
        (47, 'FRONTIER', 'CABLE'),
        (48, 'WAVE', 'CABLE'),
        (49, 'GRANDE COMMUNICATIONS', 'CABLE'),
        (50, 'AT&T', 'CABLE'),
        (51, 'VERIZON', 'INTERNET'),
        (52, 'XHPBMY-TDT', 'TV abierta'),
        (53, 'XHPBGD-TDT', 'TV abierta'),
        (54, 'XHSIM-TDT', 'TV abierta');


INSERT INTO podcast (idPodcast, nombre, descripcion, idCategoria)
VALUES (01, 'Acción Artística', 'En México hay muchas propuestas creativas, y El Once les da visibilidad en esta serie de cápsulas, 
             en las cuales documentamos diversos procesos artísticos a través de los cuales descubrimos no sólo su carácter diferenciador,
             sino también que el arte se encuentra en donde menos se espera. Desde su propia área de trabajo, 
             observamos cómo fluyen los procesos creativos mientras el artista nos cuenta su historia y experiencia. 
             El resultado, aunque casi siempre personal, fortalece la confianza colectiva y redefine los espacios, para habitarlos desde
             otro punto de vista.', 03),
		(02, 'Cultura a Voces', 'Desde el principio de los tiempos la cultura se comparte de voz en voz. Acompáñanos por este recorrido en donde 
             contaremos la historia de personas, lugares y objetos que forman parte de la cultura mexicana.', 03),
        (03, 'Estación Global', 'La comunidad internacional suele tener problemáticas complejas y difíciles de entender. A lo largo de 10 capítulos,
             explicaremos y discutiremos cómo afectan a las y los ciudadanos de nuestro país.',14),
        (04, 'Pop 11.0', 'Once Digital ofrece una visión diferente de la cultura pop. Relacionamos los acontecimientos icónicos del mundo del espectáculo
			 con la realidad mexicana.', 03),
        (05, 'Innovación Politécnica', 'Las y los investigadores e ingenieros del Instituto Politécnico Nacional han creado innovaciones que nos benefician día con día. 
             En Innovación Politécnica, expondremos la historia y el legado de los proyectos más destacados que se han desarrollado en esta gran institución mexicana. 
			 La Técnica al Servicio de la Patria.', 13),
        (06, 'Échale Piquete', 'Échale Piquete es una producción digital en la que abordamos la historia, la cultura y los lugares que orbitan alrededor de las bebidas más
              emblemáticas que se producen en México. A lo largo de cinco episodios, nos acercamos al proceso de producción y a la importancia social, económica y cultural
			  de estas bebidas en nuestro país, de la mano de quienes las han hecho parte de su vida.',03),
        (07, 'Inclusión Radical', 'Diversidad e inclusión suelen ser tratados como sinónimos, pero en realidad son complementarios. Durante 10 episodios analizamos 
              las problemáticas en relación con la diversidad, que nos ayudarán a practicar la inclusión en nuestra vida cotidiana.', 03),
        (08, 'D TODO', 'Conoce los espectáculos más impresionantes, las tradiciones y los festejos de diversas regiones, deportes extremos que te pondrán a prueba,
              y atractivas aventuras por aire, mar y tierra en D Todo, donde cualquier cosa puede ocurrir. Elenco: ALEXIA ÁVILA.',14),
        (09, 'Sí Somos', 'El Once es la primera televisora pública de México y una de las primeras aliadas de la diversidad y la Inclusión. 
             Consulta los horarios de nuestras producciones y conéctate a los contenidos que tenemos para ti en TV, redes sociales y Once+',03),
        (10, 'Aprender a Envejecer', 'Aprender a Envejecer, Patricia Kelly e invitados fomentan la cultura del envejecimiento activo y saludable, 
              al tiempo que aportan un nuevo significado a la vejez: el comienzo de una nueva etapa que podemos diseñar para que sea 
              enriquecedora y disfrutable.',04);


INSERT INTO blogs (idBlog, nombre, descripcion, idCategoria)
VALUES (01, 'Espacio Politécnico', 'El Instituto Politécnico Nacional es una institución formativa y de investigación trascendental para la sociedad. 
             Descubre en la programación de El Once el talento de los jóvenes politécnicos, la fortaleza de sus investigadores e investigaciones de punta, 
             sus conciertos de música clásica y popular, y sus eventos educativos y deportivos..', 14),
       (02, 'Aprender a Envejecer', 'En "Aprender a Envejecer", Patricia Kelly e invitados fomentan la cultura del envejecimiento activo y saludable, 
             al tiempo que aportan un nuevo significado a la vejez: el comienzo de una nueva etapa que podemos diseñar para que sea enriquecedora y 
             disfrutable.', 04),
       (03, 'Dialogos en Confianza', 'Diálogos en Confianza es un espacio en el que se genera información confiable con la cual podemos resolver 
             problemáticas cotidianas en relación a nuestra salud, familia, pareja, desarrollo humano y ámbito social. En este programa te escuchamos
             y crecemos juntos.', 04),
       (04, '8M - Dia Internacional de la Mujer', 'En la actualidad sabemos que esta lucha incluye muchas aristas: mujeres líderes y en puestos de poder,
			familias, organizaciones, medios y ciudadanos. La verdadera equidad y justicia no llegarán si la conversación no se extiende en todas las áreas 
            y rincones de México. ¿Te animas a ser parte del cambio?', 14),
       (05, 'Día Naranja', 'La Violencia De Género No Solo Se Manifiesta Mediante Una Agresión Física, Existen Acciones Sutiles Que Pasan Desapercibidas 
             Como: El Control Económico Y Social, Aislamiento Familiar Y Social, Humillaciones, Acoso, Intimidación, Amenazas, Etc. Es Por Eso Que En El Once
             Queremos Que La Violencia Silenciosa Haga Ruido. #TambiénEstoEs', 12);

-- INSERT INTO distribuidorRegion (idRegion, idDistintivo)
-- VALUES ()

INSERT INTO distribuidorRegion (idRegion, idDistintivo) VALUES
(001, 46), -- CHARACTER SPECTRUM - ALABAMA
(001, 50), -- AT&T - ALABAMA
(003, 44), -- XFINITY - ARIZONA
(003, 46), -- CHARACTER SPECTRUM - ARIZONA
(004, 44), -- XFINITY - ARKANSAS
(004, 50), -- AT&T - ARKANSAS
(005, 44), -- XFINITY - CALIFORNIA
(005, 46), -- CHARACTER SPECTRUM - CALIFORNIA
(005, 47), -- FRONTIER - CALIFORNIA
(005, 48), -- WAVE - CALIFORNIA
(005, 49), -- GRANDE COMMUNICATIONS - CALIFORNIA
(005, 50), -- AT&T - CALIFORNIA
(006, 44), -- XFINITY - COLORADO
(006, 46), -- CHARACTER SPECTRUM - COLORADO 
(006, 48), -- WAVE - COLORADO
(007, 44), -- XFINITY - CONNECTICUT
(007, 46), -- CHARACTER SPECTRUM - CONNECTICUT
(007, 47), -- FRONTIER - CONNECTICUT
(008, 44), -- XFINITY - DELAWARE 
(008, 50), -- AT&T - DELAWARE
(009, 44), -- XFINITY - DISTRICT OF COLUMBIA
(010, 44), -- XFINITY - FLORIDA
(010, 46), -- CHARACTER SPECTRUM - FLORIDA
(010, 47), -- FRONTIER - FLORIDA
(010, 50), -- AT&T - FLORIDA
(011, 44), -- XFINITY - GEORGIA
(011, 46), -- CHARACTER SPECTRUM - GEORGIA
(011, 50), -- AT&T - GEORGIA
(012, 46), -- CHARACTER SPECTRUM - HAWAI
(013, 46), -- CHARACTER SPECTRUM - IDAHO
(014, 44), -- XFINITY - ILLINOIS
(014, 50), -- AT&T - ILLINOIS
(015, 44), -- XFINITY - INDIANA
(015, 46), -- CHARACTER SPECTRUM - INDIANA
(015, 47), -- FRONTIER - INDIANA
(015, 50), -- AT&T - INDIANA
(016, 44), -- XFINITY - KANSAS
(016, 46), -- CHARACTER SPECTRUM - KANSAS
(016, 50), -- AT&T - KANSAS
(017, 44), -- XFINITY - KENTUCKY
(017, 46), -- CHRACTER SPECTRUM - KENTUCKY
(017, 50), -- AT&T - KENTUCKY
(018, 46), -- CHARACTER SPECTRUM - LOUSIANA 
(018, 50), -- AT&T - LOUSIANA
(019, 44), -- XFINITY - MAINE
(019, 46), -- CHARACTER SPECTRUM - MAINE
(020, 44), -- XFINITY - MARYLAND
(021, 44), -- XFINITY - MASSACHUSETTS
(021, 46), -- CHARACTER SPECTRUM - MASSACHUSETTS
(021, 48), -- WAVE - MASSACHUSETTS
(022, 44), -- XFINITY - MICHIGAN
(022, 46), -- CHARACTER SPECTRUM - MICHIGAN
(022, 50), -- AT&T - MICHIGAN
(023, 44), -- XFINITY - MINNESOTA 
(023, 46), -- CHARACTER SPECTRUM - MINNESOTA
(023, 47), -- FRONTIER - MINNESOTA
(024, 50), -- AT&T - MISSISSIPI 
(025, 44), -- XFINITY - MISSOURI
(025, 46), -- CHARACTER SPECTRUM - MISSOURI
(025, 50), -- AT&T - MISSOURI
(026, 46), -- CHARACTER SPECTRUM - MONTANA
(027, 46), -- CHARACTER SPECTRUM - NEBRASKA
(028, 46), -- CHARACTER SPECTRUM - NEVADA
(028, 50), -- AT&T - NEVADA
(029, 44), -- XFINITY - NEW HAMPSHIRE
(029, 46), -- CHARACTER SPECTRUM - NEW HAMPSHIRE
(029, 48), -- WAVE - NEW HAMPSHIRE
(030, 44), -- XFINITY - NEW JERSEY
(030, 46), -- CHARACTER SPECTRUM - NEW JERSEY
(031, 44), -- XFINITY - NEW YORK
(031, 46), -- CHARACTER SPECTRUM - NEW YORK
(031, 47), -- FRONTIER - NEW YORK
(032, 44), -- XFINITY - NORTH CAROLINA
(032, 46), -- CHARACTER SPECTRUM - NORTH CAROLINA
(032, 47), -- FRONTIER - NORTH CAROLINA
(032, 50), -- AT&T - NORTH CAROLINA
(033, 44), -- XFINITY - NUEVO MEXICO
(034, 44), -- XFINITY - OHIO
(034, 46), -- CHARACTER SPECRTUM - OHIO 
(034, 50), -- AT&T - OHIO
(035, 50), -- AT&T - OKLAHOMA 
(036, 44), -- XFINITY - OREGON
(036, 48), -- WAVE -- OREGON
(037, 44), -- XFINITY - PENNSYLVANIA
(037, 46), -- CHARACTER SPECTRUM - PENNSYLVANIA
(038, 45), -- SLING - PUERTO RICO
(039, 45), -- SLING - REPUBLICA DOMINICANA
(040, 44), -- XFINITY - SOUTH CAROLINA
(040, 46), -- CHARACTER SPECTRUM - SOUTH CAROLINA
(040, 47), -- FRONTIER - SOUTH CAROLINA
(040, 50), -- AT&T - SOUTH CAROLINA
(041, 44), -- XININITY - TENNESSEE
(041, 46), -- CHARACTER SPECTRUM - TENNESSEE
(041, 50), -- AT&T - TENNESSEE
(042, 44), -- XFINITY - TEXAS
(042, 46), -- CHARACTER SPECTRUM - TEXAS
(042, 47), -- FRONTIER - TEXAS
(042, 49), -- GRANDE COMMUNICATIONS - TEXAS
(042, 50), -- AT&T - TEXAS
(043, 43), -- DIRECTV - UNITED STATES
(043, 45), -- SLING - UNITED STATES
(043, 51), -- VERIZON - UNITED STATES
(044, 44), -- XFINITY - UTAH 
(044, 48), -- WAVE - UTAH
(045, 44), -- XFINITY - VERMONT
(045, 46), -- CHARACTER SPECTRUM - VERMONT
(046, 44), -- XFINITY - VIRGINIA
(046, 46), -- CHARACTER SPECTRUM - VIRGINIA
(047, 44), -- XFINITY - WASHINGTON
(047, 46), -- CHARACTER SPECTRUM - WASHINGTON
(047, 48), -- WAVE - WASHINGTON
(048, 44), -- XFINITY - WEST VIRGINIA
(049, 44), -- XININITY - WISCONSIN
(049, 46), -- CHARACTER SPECTRUM - WISCONSIN
(049, 50), -- AT&T - WISCONSIN
(050, 44), -- XININITY - WYOMING
(050, 46), -- CHARACTER SPECTRUM - WYOMING
(051, 20), -- 'Aguascalientes, Aguascalientes',
(052, 03), -- 'Campeche, Campeche',
(053, 17), --  'Cancún, Quintana Roo',
(054, 26), -- 'Celaya, Guanajuato',
(089, 52), --  'Monterrey, Nuevo Leon',
(055, 17), -- 'Chetumal, Quintana Roo', 
(056, 04), -- 'Chihuahua, Chihuahua',
(057, 01), -- 'Ciudad de México',
(058, 34), --  'Ciudad Obregón, Sonora',
(059, 38), -- 'Coatzacoalcos, Veracruz',
(060, 25), --  'Colima, Colima',
(061, 19), --  'Culiacán, Sinaloa',
(062, 08), --  'Durango, Durango',
(063, 09), --  'Gómez Palacio, Durango',
(064, 53), --  'Guadalajara, Jalisco',
(065, 37), --  'Hermosillo, Sonora',
(066, 27), --  'León, Guanajuato',
(067, 54), --  'Los Mochis, Sinaloa',
(068, 33), --  'Mazatlán, Sinaloa',
(069, 40), --  'Mérida, Yucatán',
(070, 17), --  'Monterrey, Nuevo León',
(071, 29), -- 'Morelia, Michoacán',
(072, 14), -- 'Oaxaca, Oaxaca',
(073, 42), -- Cozumel, Quintana Roo', 
(074, 15), -- 'Puebla, Puebla',
(075, 32), -- 'Querétaro, Querétaro',
(076, 07), -- 'Saltillo, Coahuila',
(077, 22), -- 'San Cristóbal de las Casas, Chiapas',
(078, 18), -- 'San Luis Potosí, S.L.P.',
(079, 23), -- 'Tapachula, Chiapas',
(080, 02), -- 'Tijuana, Baja California',
(081, 28), -- 'Toluca, Estado de México',
(082, 12), -- 'Tres Cumbres, Morelos', 
(083, 24), -- 'Tuxtla Gutiérrez, Chiapas',
(084, 30), --  'Uruapan, Michoacán',
(085, 11), --  'Valle de Bravo, Edo. de México',
(086, 36), --  'Villahermosa, Tabasco',
(087, 39), --  'Xalapa, Veracruz',
(088, 41); -- 'Zacatecas, Zacatecas'

INSERT INTO seccionBlog (idSeccion, idBlog)
VALUES (001,01), -- Once + - Espacio Politecnico
	   (001,02), -- Once +  - Aprender a Envejecer
       (001,03), -- Once +  - Dialogos en Confianza
       (001,04), -- Once + - 8M - Dia Internacional de las Mujeres
       (001,05); -- Once + - Dia Naranja

INSERT INTO seccionPodcast (idSeccion, idPodcast)
VALUES (005,01), -- Once Digital - Accion Artisitica
       (005,02), -- Once Digital - Cultura a Voces
       (005,03), -- Once Digital - Estacion Global
       (005,04), -- Once Digital - Pop 11.0
       (005,05), -- Once Digital - Innovacion Politecnica
       (005,06), -- Once Digital - Échale Piquete
       (005,07), -- Once Digital - Inclusión Radical
       (001,08), -- Once + - D TODO
       (001,09), -- Once + - Sí Somos
       (001,10); --  Once + - Aprender a Envejecer

INSERT INTO programas (idPrograma, nombre, descripcion, idClasificacion, idCategoria)
VALUES ('P0001', 'La Ruta Del Sabor', 'Explora los secretos mejor guardados de la cocina mexicana en esta aventura culinaria, en la que Miguel Conde nos guía para descubrir el mapa de la gastronomía mexicana, un semillero internacional de sabores, aromas y senderos.', 002, 01),
	   ('P0002', 'La sazón de mi mercado', 'En este espacio semanal se retratan tanto los mercados públicos, como los platillos de la cocina tradicional mexicana, la cual fue reconocida por la UNESCO como Patrimonio Cultural Inmaterial de la Humanidad en el año 2010.', 002, 01),
       ('P0003', 'Yo Sólo Sé Que No He Cenado', 'Bruno Bichir visita diferentes lugares de México con la misión de descubrir los mejores platillos, las historias que hay detrás de ellos, y todos los secretos que los coronan como los más sabrosos. Acompáñalo a disfrutar de manjares en puestos callejeros, restaurantes tradicionales y de vanguardia, cantinas, mercados, merenderos y más. Elenco: Bruno Bichir.', 004, 01),
       ('P0004', 'Bebidas de México', 'En esta serie documental hacemos un recorrido por las bebidas que forman parte del patrimonio cultural y biológico que se mantiene vivo en el país. Junto a grandes actores mexicanos, descubre los secretos de bebidas ancestrales como el pulque; destiladas como el mezcal, el tequila, el bacanora y la raicilla; así como delicias adaptadas al clima y al paladar de los mexicanos, como el vino y la cerveza. Hoy, todos estos productos son parte de nuestra cultura y sus múltiples sabores llegan a todo el mundo.', 004, 01),
       ('P0005', 'Nuestra riqueza, el chile', 'Acompaña a Miguel Conde en este recorrido por La Ruta del Sabor del Chile y únete a la celebración nacional del corazón de los guisos mexicanos y una de nuestras mayores riquezas.', 002, 01),
       ('P0006', 'Del Mundo Al Plato', '¿Dónde tomar un desayuno típico inglés? ¿En qué restaurante se ofrece el auténtico curry? ¿Hay cerveza alemana en nuestra ciudad? ¿Dónde se prepara el mejor kepe charola? El chef Pablo San Román inicia una travesía para descubrir las gastronomías del mundo en la capital de nuestro país y, a través de la cocina, las historias de vida de quienes trajeron sus recetas a nuestra ciudad.', 002, 01),
       ('P0007', 'Tu Cocina', 'Cada temporada, un reconocido chef nos comparte atractivos y prácticos menús preparados con productos locales y de temporada, inspirados en mercados, antiguos recetarios y cocina regional. Este programa es una oportunidad para revalorar la cultura gastronómica de México. Elenco: Gerardo Vázquez Lugo, Graciela Montaño, León Aguirre, Lucero Soto, Lula Chef, Pablo San Román, Pepe Salinas, Yuri de Gortari.', 001, 01),
       ('P0008', 'Elogio De La Cocina Mexicana', 'En el 2010 la UNESCO declaró a la gastronomía mexicana como Patrimonio Inmaterial de la Humanidad, al ser un elemento esencial de nuestra identidad cultural que hay que proteger, pues se encuentra amenazada por los embates de la globalización. La cocina tradicional de México es una amalgama de lo prehispánico con elementos de otras naciones y épocas, lo que da como resultado platillos y sabores muy mexicanos que implican preparaciones típicas. En este programa recorremos el país para conocer a las personas que mantienen viva nuestra gastronomía, al tiempo que la recrean, protegen, transmiten y transforman.', 001, 01),
       ('P0009', 'En Materia De Pescado', 'Daniel Giménez Cacho y Marco Rascón navegan a través de la gastronomía y diversidad cultural de la Ciudad de México.', 002, 01),
       ('P0010', 'Diario de un Cocinero', 'En "Diarios de un cocinero", Enrique Olvera, uno de los chefs más importantes de México, nos revela cada uno de los elementos que forman parte de su experiencia gastronómica como persona, chef y comensal.', NULL, 01),
       ('P0011', 'Memoria de los Sabores', 'El sentido del gusto es un disparador automático de recuerdos. Los sabores nos evocan a personas, tiempos o situaciones que vuelven a nosotros en un bocado. Esta serie explora las memorias que provocan esos sabores para algunos personajes del medio cultural mexicano.', NULL , 01),
       ('P0012', 'América. Escritores extranjeros en México', 'Una serie documental fascinante sobre escritores extranjeros que vivieron en México en distintos momentos del siglo XX. En cada episodio, un escritor latinoamericano nos guía en la trayectoria y la estadía del escritor extranjero, con quien ha construido un vínculo creativo y emocional.', NULL, 02),
       ('P0013', 'El Mitote Librero', 'Un recorrido literario por los temas y personajes más relevantes en los libros universales, a partir de las versiones y referencias más destacadas, así como sus adaptaciones visuales. Charlas mágicas en la Librería Rosario Castellanos con Paco Ignacio Taibo II, Norma Márquez Cuevas y Andrés Enrique Ruiz González.', 002, 02),
       ('P0014', 'Lenguas en Resistencia', 'Lenguas en Resistencia aborda los idiomas indígenas que han ido poblando el territorio de la Ciudad de México, como el nahua, mazateco, mazahua, otomí, tzeltal, mixteco, triqui, entre otros, para construir una narrativa histórica de la gama lingüística que existe en la capital de nuestro país. Una serie narrada por las y los protagonistas, quienes nos comparten historias sobre su identidad cultural y lingüística, así como los momentos significativos de su vida en la ciudad.', 001, 02),
       ('P0015', 'Diáspora', 'Con una bella fotografía en blanco y negro, Diáspora es una serie documental en la que se narran relatos afromexicanos en voz de sus propios personajes. Conducida por la cantante Susana Harp, se muestra la identidad y diversidad del pueblo afromexicano, su crecimiento en regiones de Coahuila, Guerrero, Veracruz, Oaxaca y Ciudad de México, lo que ha brindado nuevos modelos culturales, formas de vida, rituales, gastronomía y arte, como la música y la danza. Diáspora reconoce, enaltece y da visibilidad a los pueblos y a comunidades afrodescendientes de México, pues su herencia artístico-cultural es esencial para nuestro mestizaje.', NULL, 02),
       ('P0016', 'Afroméxico', 'Afroméxico es una serie dedicada al conocimiento, reconocimiento, respeto y visibilización de la herencia y cultura de las mujeres, los hombres, las niñas y los niños de África trasladados a México. "Afroméxico" celebra cosmovisiones, usos culinarios, bailes, cantos, vestimentas, ceremonias religiosas y medicina tradicional, entre muchas otras prácticas culturales', 001, 02),
       ('P0017', 'Las joyas de Oaxaca', 'Las joyas de Oaxaca, un programa que busca revalorizar la importancia y trascendencia que ha dado el estado de Oaxaca al mundo dentro de la cultura popular, gracias a los artesanos de la región.', 002, 02),
       ('P0018', 'México Renace Sostenible', 'México Renace Sostenible tiene como finalidad promover la actividad turística y los procesos bioculturales de las comunidades de los pueblos mágicos, así como fomentar los valores ancestrales para el renacer humano de México, además de poder transmitir la enorme importancia histórica y sus saberes tradicionales que integra la preservación de recursos naturales.', NULL, 02),
       ('P0019', 'Toros, Sol y Sombra', 'Este programa de análisis taurino es conducido por los periodistas Heriberto Murrieta y Rafael Cué, quienes analizan y comentan aspectos diversos que se entretejen alrededor de la fiesta brava.', NULL, 02),
       ('P0020', 'Sensacional De Diseño Mexicano', 'Sensacional de Diseño Mexicano es una serie documental que explora gremios y oficios de la gráfica mexicana. Este vistazo al universo de los creadores de rótulos, imágenes de productos, anuncios y literatura de bolsillo, nos permite conocer sus procesos, técnicas y contextos. Acompáñanos en esta travesía creativa y visual de las tradiciones antiguas y contemporáneas del diseño de México.', 002, 02),
       ('P0021', 'Minigrafías', 'Un breve, pero intenso recorrido en técnica de animación a través de la vida y obra de importantes escritoras y escritores de México.', NULL, 02),
       ('P0022', 'Manos de Artesano', 'Esta serie, dirigida por Rodrigo Castaño Valencia, es ante todo un homenaje a las y los grandes maestros artesanos de México. Cada episodio narra la elaboración de un objeto único y, a la vez, da testimonio de la paciente y minuciosa labor de las y los talentosos maestros que encontramos en distintas regiones del país, pues ellas y ellos son herederos de técnicas ancestrales que se preservan con grandes esfuerzos a través de la práctica, la enseñanza y el perfeccionamiento constante.', 001, 02),
       ('P0023', 'Palabra De Autor', 'El lenguaje y las ideas que habitan el territorio literario enriquecen a todo aquel que lo transita. Este programa del Once introduce a grandes exponentes de la literatura mexicana contemporánea y presenta pláticas con ellos acerca de su obra y sus procesos creativos.', NULL, 02),
       ('P0024', 'Artes', 'El Instituto Nacional de Bellas Artes y Literatura (INBAL) y el Once presentan esta serie documental dedicada a la difusión del arte en sus diversas manifestaciones, para conocer a los artistas nacionales y extranjeros, seguir sus procesos creativos y apreciar la gran riqueza cultural de México.', 002, 02),
       ('P0025', 'Letras De La Diplomacia', 'Letras de la Diplomacia es una serie rica en anécdotas y reflexiones en torno al quehacer diplomático y literario de destacados escritores mexicanos. Conoce las trayectorias y los logros de algunos de los máximos representantes de México en el mundo.', NULL, 02),
       ('P0026', 'Moneros', 'Como un reconocimiento a la labor y talento de los ilustradores y caricaturistas, el Once presenta un retrato de las y los moneros mexicanos, quienes con su obra aportan a la sociedad una crítica aguda del acontecer nacional e internacional. A manera de diálogo íntimo, esta serie documental retrata la vida diaria de los moneros, sus inspiraciones, motivaciones, influencias y obstáculos que han sorteado para trazar su camino de vida y, finalmente, poder vivir de sus creaciones.', NULL, 02),
       ('P0027', 'Teatro Estudio', 'Un espacio único de lecturas dramatizadas en televisión a cargo de reconocidas actrices y actores mexicanos. Esta serie ofrece lo mejor de la dramaturgia mexicana clásica y contemporánea que, con obras de grandes autores, nos muestra una cara poco vista del teatro: el guión en la mano de los actores.', NULL, 02),
       ('P0028', 'Artesanos de México: Rutas del arte popular', 'Artesanos de México: Rutas del arte popular es un proyecto documental que busca retratar el trabajo y técnica de los más reconocidos artesanos mexicanos, en un viaje donde conoceremos las expresiones de arte popular en el que los objetos son los personajes principales de nuestra historia y cultura.', NULL, 02),
       ('P0029', 'M/Aquí', 'Como una expresión de resistencia ante los obstáculos que se nos van presentando a lo largo de la vida, en M/Aquí Heriberto Murrieta entrevista a celebridades de diversos ámbitos, quienes nos muestran su gran creatividad para superar las dificultades.', NULL, 03),
       ('P0030', 'Once digital investigación', 'Conoce Once digital investigación, el espacio donde nos preguntamos de todo e investigamos sobre nuestra actualidad, historia y cultura desde otro ángulo.', NULL, 03),
       ('P0031', 'De la casa a la casilla', 'La lucha de las mujeres por conseguir el voto fue larga. Conoce los pormenores de este hecho histórico, desde sus inicios hasta la actualidad, con el toque humorístico de cinco standuperas mexicanas: Pamonstruo, Pachis, Paty Bacelis, Ana Tamez y Karo Plascencia.', NULL, 03),
       ('P0032', 'Gradiente', 'La vida está llena de matices. Aunque la historia de cada persona es distinta, siempre hay una sensación, un color o una lucha que nos une. Gradiente es una serie de fotografías animadas, en colaboración con el Centro de la Imagen, dedicada a eso, que, sin importar el tiempo o el espacio, tenemos en común.', NULL, 03),
       ('P0033', 'Abraza la diversidad', '#TejiendoMiBandera nos invita a descubrir el amplio entramado de realidades, voces e historias diversas; de contextos, diálogos, acciones, intercambios, preguntas, propuestas y posibles construcciones colectivas, necesariamente marcadas por la interseccionalidad.', 002, 03),
       ('P0034', 'Entre Redes', 'Entre Redes es una producción digital de una sola parada dirigida a las personas jóvenes de México. Un espacio diverso en el que podrán encontrar información relevante para cada aspecto de su vida: identidad; salud sexual, física y emocional; amor; finanzas; vida profesional; familia; tecnología y hasta opciones para turistear.', 004, 03),
       ('P0035', 'Acción Artística', 'En México hay muchas propuestas creativas, y El Once les da visibilidad en esta serie de cápsulas, en las cuales documentamos diversos procesos artísticos a través de los cuales descubrimos no sólo su carácter diferenciador, sino también que el arte se encuentra en donde menos se espera. Desde su propia área de trabajo, observamos cómo fluyen los procesos creativos mientras el artista nos cuenta su historia y experiencia. El resultado, aunque casi siempre personal, fortalece la confianza colectiva y redefine los espacios, para habitarlos desde otro punto de vista.', NULL, 03),
       ('P0036', 'Sí somos', 'Sí somos es un videopodcast 100% digital creado en colaboración con Inmujeres, Radio IPN e IMER, donde hablamos de los temas más importantes de la agenda de las mujeres en México y de la lucha por la igualdad de género.', NULL, 03),
       ('P0037', 'Échale Piquete', 'Échale Piquete es una producción digital en la que abordamos la historia, la cultura y los lugares que orbitan alrededor de las bebidas más emblemáticas que se producen en México. A lo largo de cinco episodios, nos acercamos al proceso de producción y a la importancia social, económica y cultural de estas bebidas en nuestro país, de la mano de quienes las han hecho parte de su vida.', NULL, 03),
       ('P0038', '¡Hagamos clic!', 'Hagamos clic es un programa digital sobre salud femenina, en el que hablaremos sin censura sobre temas que son considerados tabú por la sociedad. Buscamos que, con la información adecuada, se rompan estigmas y prejuicios sobre estos temas que nos conciernen a todas y todos.', 005, 03),
       ('P0039', 'Había Una vez… Mexicanas que hicieron historia', 'Acompaña a las mujeres que han marcado la memoria de nuestro país. Conoce las historias de estas heroínas de carne y hueso, quienes tuvieron el valor de levantar la voz para luchar contra las injusticias que existían a su alrededor.', 003, 03),
       ('P0040', 'Cultura a Voces', 'Desde el principio de los tiempos la cultura se comparte de voz en voz. Acompáñanos por este recorrido en donde contaremos la historia de personas, lugares y objetos que forman parte de la cultura mexicana.', 002, 03),
       ('P0041', 'Somos lxs que fueron', 'Somos lxs que fueron cuenta la historia de distintas personas, sucesos y movimientos históricos de la comunidad LGBTTTIQ+ en México, para generar memoria e identidad dentro de un sector históricamente discriminado que está siempre en búsqueda de dignidad y equidad.', 004, 03),
       ('P0042', 'En la Barra', 'La nueva generación de actrices y actores de talento llega a nuestras pantallas. Y nadie mejor que Óscar Uriel para departir y charlar con cada invitada e invitado, a quien se le da la bienvenida como se debe: En La Barra, con una deliciosa bebida personalizada.', NULL, 03),
       ('P0043', 'Inclusión Radical', 'Diversidad e inclusión suelen ser tratados como sinónimos, pero en realidad son complementarios. Durante 10 episodios analizamos las problemáticas en relación con la diversidad, que nos ayudarán a practicar la inclusión en nuestra vida cotidiana.', 004, 03),
       ('P0044', 'Innovación Politécnica', 'Las y los investigadores e ingenieros del Instituto Politécnico Nacional han creado innovaciones que nos benefician día con día. En Innovación Politécnica, expondremos la historia y el legado de los proyectos más destacados que se han desarrollado en esta gran institución mexicana. La Técnica al Servicio de la Patria.', 002, 03),
       ('P0045', 'Multipass', 'Multipass es el recorrido de Ophelia Pastrana, mujer transgénero, entusiasta de lo nuevo y lo diverso, para adentrarse en las comunidades más interesantes y comentadas: gamers, cosplayers, trabajores sexuales, emprendedores, entusiastas y disruptores apasionades.', NULL, 03),
       ('P0046', 'Yo, ellas, nosotras', 'A través de la historia de vida de cada una de las mujeres trans que presentamos en esta serie, ponemos en evidencia por qué es importante visibilizarlas, así como su representación, lucha y participación dentro del movimiento feminista.', NULL, 03),
       ('P0047', 'A Tono', 'A Tono es un programa digital de conciertos de corta duración con un enfoque íntimo, dentro de un espacio minimalista y lleno de color. Buscamos promover proyectos mexicanos de diversos estilos que representen la diversidad musical de nuestro país y conectarlos con una audiencia digital.', 002, 03),
       ('P0048', 'Pop 11.0', 'Once Digital ofrece una visión diferente de la cultura pop. Relacionamos los acontecimientos icónicos del mundo del espectáculo con la realidad mexicana.', 002, 03),
       ('P0049', 'Economía en corto', 'Economía en corto es una serie en la que mujeres y hombres jóvenes analizan y debaten sobre temas de interés nacional y sus implicaciones con la economía.', 003, 03),
       ('P0050', 'Más allá de la piel', 'Más allá de la piel: decálogo para entender el racismo en México es un proyecto que reúne a 10 personalidades del cine, la televisión y el activismo que hacen parte de la lucha antirracista en el país. Cada cápsula explicará un punto del decálogo creado por Racismo Mx, el cual explica y evidencia esta problemática a la que se enfrentan las y los mexicanos.', 004, 03),
       ('P0051', 'Conversando con Cristina Pacheco', 'Una de las series más icónicas de México, en la que Cristina Pacheco, extraordinaria periodista y conductora, convierte este don suyo de conversar en un programa de televisión al que acuden célebres personalidades, que con su trabajo y talento han dejado huella en el acontecer de nuestro país.', 002, 04),
       ('P0052', 'En Persona', 'En Persona la conversación fluye cálida y espontánea, y permite que cada personaje se sienta con la confianza de contar más sobre las diversas facetas en las que ha sobresalido. El Once presenta En Persona, un programa con Guadalupe Contreras, quien entrevista a figuras destacadas para conocer más a fondo su trayectoria, los retos a los que se han enfrentado, sus proyectos más importantes y sus planes a futuro.', NULL, 04),
       ('P0053', 'Diálogos en Confianza', 'Diálogos en Confianza es un espacio en el que se genera información confiable con la cual podemos resolver problemáticas cotidianas en relación a nuestra salud, familia, pareja, desarrollo humano y ámbito social. En este programa te escuchamos y crecemos juntos.', 004, 04),
       ('P0054', 'Aprender a envejecer', 'En "Aprender a Envejecer", Patricia Kelly e invitados fomentan la cultura del envejecimiento activo y saludable, al tiempo que aportan un nuevo significado a la vejez: el comienzo de una nueva etapa que podemos diseñar para que sea enriquecedora y disfrutable.', NULL, 04),
       ('P0055', 'Aquí Nos Tocó Vivir', 'La periodista Cristina Pacheco es un ícono en el retrato de los personajes que conforman la cultura y la sociedad mexicana, relatando la cotidianeidad a través de amenas entrevistas que rompen con los formatos rígidos tradicionales. "Aquí nos tocó vivir" es prueba del arduo trabajo que Cristina Pacheco ha desempeñado durante décadas para mostrar el mosaico de voces e imágenes que dan testimonio de las innumerables formas de vida que amalgama nuestro país. Viaja junto con el Once a rincones poco conocidos en busca de las historias más entrañables de estas personalidades. Explora y disfruta de los diferentes relatos y experiencias que conforman nuestro país, en "Aquí nos tocó vivir". Elenco: Cristina Pacheco.', NULL, 04),
       ('P0056', 'Aquí En Corto', 'Aquí en corto explora algunos de los temas de mayor interés para las y los jóvenes de nuestro país. Este programa de opinión, moderado por Rubén Álvarez, consiste en debates de jóvenes de 15 a 23 años, en los que expresan lo que piensan y sienten sobre temas de su interés.', 004, 04),
       ('P0057', 'El Gusto Es Mío', 'El gusto es mío, es un espacio donde Marta de la Lama entrevista y conversa con los más interesantes personajes de la cultura mexicana, desde actores, íconos de la moda, médicos y toda clase de eruditos. Las charlas que componen "El gusto es mío" son simplemente un deleite para la mente. Descubre los relatos personales y profesionales de estos agentes de la historia contemporánea de México, junto a una de las grandes periodistas y conductoras de nuestro país. Elenco: Marta de la Lama', 003, 04),
       ('P0058', 'La Cita', 'La escritora y periodista Guadalupe Loaeza nos invita a una íntima y amena entrevista, donde nos presenta a los personajes más destacados de México en los ámbitos cultural, artístico y político. Conoce la trayectoria profesional y las anécdotas que han marcado a grandes personalidades, quienes en su propia voz nos comparten momentos entrañables de su vida. Disfruta de este recorrido de anécdotas de la mano de Pedro Friedeberg, Marcelo Vargas, Eugenio Aguirre, Michel Rowe, Karine Tinat, Jordi Mariscal, Elena Talavera, Susana Corcuera, Homero Aridjis, Frédéric García y Ricardo Muñoz Zurita, quienes destacan en áreas muy diversas, desde la diplomacia hasta la gastronomía.', 003, 04),
       ('P0059', 'Solórzano 3.0', 'Una revista nocturna -estilo late night y conducida por Javier Solórzano- en la que se abordan de manera ágil y amena diversos temas de actualidad e interés. La interacción con el público se realiza a través de las redes sociales para lograr una conversación y construir un espacio público donde el diálogo y la pluralidad son el eje que guía el programa en la búsqueda de una construcción colectiva de contenidos para lograr un concepto incluyente, crítico, plural e interactivo.', 004, 04),
       ('P0060', 'Entre Mitos y Realidades', 'Un programa conducido por Catalina Noriega y Pilar Ferreira que cuestiona, analiza y desmitifica creencias y comportamientos que están profundamente arraigados en la sociedad. Para ello contrasta puntos de vista basados en hechos y argumentos de los expertos, y, a partir de información seria, precisa y clara, desentraña la verdad sobre temas controvertidos.', NULL, 04),
       ('P0061', 'La historia del tenis en México', 'El tenis mexicano comenzó a finales del siglo XIX, cuando un puñado de jugadores aprendió que victorias y derrotas son esenciales para crecer. Así nacieron nuestras primeras leyendas. Esta serie, narrada por sus propios protagonistas, nos acerca a sus historias, sus hazañas y a las jóvenes promesas.', 001, 05),
       ('P0062', 'Pelotero a la bola', 'Pelotero a la bola presenta todo acerca del apasionante mundo del béisbol, en donde un equipo de especialistas en esta materia deportiva analiza, discute y conversa acerca de los resultados de los partidos de la temporada.', 001, 05),
       ('P0063', 'Yoga', 'Serie de 130 episodios dirigida a mujeres de 30 a 40 años en los que a través de diferentes disciplinas se les invita a realizar las rutinas de ejercicios de manera conjunta con el instructor con el objetivo de mejorar su condición física.Las diferentes disciplinas son: Body Jam, En forma, Yoga, Perfect Shape y Pilates.', 001, 05),
       ('P0064', 'Somos Equipo', 'Esta serie documental nos introduce a los deportes que se practican en equipo. Jugadores y entrenadores explican cómo la colectividad es clave para poder practicar basquetbol, nado sincronizado y otros deportes. Descubre, junto con ellos, la importancia de trabajar en conjunto para crecer y lograr los cometidos.', 001, 05),
       ('P0065', 'Baile Latino', 'Serie de 130 episodios dirigida a mujeres de 30 a 40 años en los que a través de diferentes disciplinas se les invita a realizar las rutinas de ejercicios de manera conjunta con el instructor con el objetivo de mejorar su condición física.Las diferentes disciplinas son: Body Jam, En forma, Yoga, Perfect Shape y Pilates.', 001, 05),
       ('P0066', 'Actívate', 'Este programa del Once te presenta una serie de rutinas de actividad física en la que distintos entrenadores muestran ejercicios que combinan artes marciales mixtas y gimnasia natural que podemos hacer todas y todos. ¡Actívate y mejora tu salud!', 001, 05),
       ('P0067', 'Body Jam', 'Serie de 130 episodios dirigida a mujeres de 30 a 40 años en los que a través de diferentes disciplinas se les invita a realizar las rutinas de ejercicios de manera conjunta con el instructor con el objetivo de mejorar su condición física.Las diferentes disciplinas son: Body Jam, En forma, Yoga, Perfect Shape y Pilates.', 001, 05),
       ('P0068', 'Cápsulas De Deportes', 'Con la ayuda de la ciencia y la cámara lenta, conocerás lo más fascinante de realizar un deporte olímpico.', 001, 05),
       ('P0069', 'Carrera Panamericana', 'En conmemoración de los 30 años de la Carrera Panamericana, este programa del Once captura el recorrido de siete días que automóviles de 1940 a 1972 hacen a más de doscientos kilómetros por hora, a lo largo de la República Mexicana. En 7 episodios, se recopilan anécdotas, vivencias y la transformación de este evento a lo largo de 3 décadas.', 001, 05),
       ('P0070', 'Leyendas Del Deporte Mexicano', 'México tiene una férrea tradición deportiva en todas las disciplinas, y por ello es reconocido fuera de nuestras fronteras. Esta serie del Once muestra esa pasión a través de la mirada y la trayectoria de legendarios atletas nacidos en nuestro país. Este programa del Once se trata de una exploración narrativa y audiovisual de la intensidad que suscita el deporte, a lo largo de trece programas en los que consagrados deportistas mexicanos narrarán de viva voz su carrera, su trayectoria, sus triunfos y sus hazañas.', 001, 05),
       ('P0071', 'Leyendas Del Fútbol Mexicano', 'México tiene una larga tradición futbolística y por ello es reconocido internacionalmente. Esta serie del Once muestra esa pasión por el fútbol a través de la mirada y la trayectoria de futbolistas legendarios nacidos en nuestro país. Tales deportistas emblemáticos y sus experiencias, dentro y fuera de la cancha, conforman Leyendas del Futbol Mexicano.', 001, 05),
       ('P0072', 'En Forma', 'Serie de 130 episodios dirigida a mujeres de 30 a 40 años en los que a través de diferentes disciplinas se les invita a realizar las rutinas de ejercicios de manera conjunta con el instructor con el objetivo de mejorar su condición física.Las diferentes disciplinas son: Body Jam, En forma, Yoga, Perfect Shape y Pilates.', 001, 05),
       ('P0073', 'Los Juegos de la Amistad a 50 Años de Distancia', '50 años: 50 cápsulas. En 2018 se cumplieron 50 años de la realización de los Juegos Olímpicos México 68 y, para celebrarlo, estas cápsulas rememoran esta justa deportiva y nos muestran algunos de los momentos más entrañables e históricos que se vivieron a partir de la emotiva y ovacionada inauguración.', 002, 05),
       ('P0074', 'NED, La Nueva Era del Deporte', 'Joss Waleska conversa con deportistas, atletas de alto rendimiento y especialistas. Juntos analizan el desarrollo actual de los deportes, las nuevas tecnologías y otras posibilidades que permiten mejorar el rendimiento físico, las técnicas y los equipos necesarios para lograr los mejores resultados al practicar un deporte.', 001, 05),
       ('P0075', 'Palco a Debate', 'Este programa del Once trae a la mesa los temas más polémicos del deporte para analizarlos con periodistas, deportistas, directivos, promotores y demás especialistas en el tema. Cada episodio está dedicado a un deporte distinto. Acompáñanos en estos debates sobre este apasionante mundo. Elenco: Alfredo Domínguez Muro.', 001, 05),
       ('P0076', 'Tablero de Ajedrez', 'Desde la antigüedad, el ajedrez ha sido considerado uno de los juegos que más desarrollan el pensamiento estratégico. "Tablero de Ajedrez" es un deleite para los fanáticos del tablero, y a la vez es una excelente introducción a profundidad para quienes no lo conocen o no están tan familiarizados. Desde piezas, partidas y hasta historia y significado, este programa del Once ofrece un amplio y rico panorama del universo del ajedrez.', 001, 05),
       ('P0077', 'Figuras del Deporte Mexicano', 'En la actualidad, México cuenta con jóvenes promesas del deporte en todas las disciplinas, los cuales nos representaron en los Juegos Panamericanos Guadalajara 2011 y los Juegos Olímpicos de Londres 2012. Por eso, nos hemos propuesto mostrar la calidad deportiva actual de nuestro país a través de la mirada y la trayectoria de nuestras jóvenes promesas deportivas.', 001, 05),
       ('P0078', 'Fútbol Americano Liga Intermedia 2020', 'Encuentros deportivos en la temporada 2018 en los que se destaca la participación de los equipos de la categoría intermedia de la ONEFA, el máximo circuito de fútbol americano estudiantil en México.', 001, 05),
       ('P0079', 'Guinda y Blanco. Historia De Una Pasión', 'Narración histórica del fútbol americano del Instituto Politécnico Nacional como fundamento de la identidad politécnica.', 001, 05),
       ('P0080', 'Todos a Bordo', 'En este programa caben todos los oficios y las profesiones hechas con empeño, cariño y compromiso. A través de emotivas entrevistas, esta serie del Once nos presenta las historias de quienes ejercen variadas ocupaciones en México, algunas de ellas con una larga tradición y otras con innovadoras propuestas, todas indispensables para el bienestar común.', 001, 05),
       ('P0081', 'Itinerario', 'En una ciudad tan rica en propuestas culturales como lo es la nuestra, "Itinerario" es todo un imprescindible. Esta revista de TV es un recuento de la actualidad cultural de México y sus variadas expresiones. Los programas son ante todo un guiño de ojo: se trata de que cada uno de nosotros haga sus itinerarios a la carta, para lo cual -semana a semana- se comentan las múltiples posibilidades de elección. Lugares, personajes y eventos que integran tanto la oferta permanente, como la cartelera cultural de la Ciudad de México y otras localidades del país. No te pierdas todo lo relativo a museos, libros, cine, música, artes escénicas, recorridos gastronómicos, rincones secretos y mucho más...', 002, 05),
       ('P0082', 'El Ojo Detrás de la Lente, Cinefotógrafos de México', 'La mirada artística de los cinefotógrafos se plasma en cada una de sus creaciones, y en ellas se revelan imágenes de profunda belleza que exaltan la obra cinematográfica. Cuatro cinefotógrafos Carlos Hidalgo, Kenji Katori, Carlos Marcovich y Damián García hablan de su trabajo. Conoce sus proyectos, estilos, trayectorias y técnicas con el Once.', 001, 05),
       ('P0083', 'Mi Cine, Tu Cine', 'Mi cine, tu cine es un espacio de interacción y reflexión en torno a la cartelera cinematográfica, donde un especialista, tres jóvenes críticos y un invitado comparten su opinión sobre la oferta de películas en el cine. Elenco: Jean-Christophe Berjon', 002, 05),
       ('P0084', 'T.A.P.: Taller de Actores Profesionales', 'Óscar Uriel conversa con actrices y actores mexicanos, de distintos perfiles y generaciones, para charlar sobre sus experiencias en la industria del teatro, el cine y la televisión.', 003, 05),
       ('P0085', 'Viaje Todo Incluyente', 'Esta serie está dedicada a todas las personas que viven con una discapacidad. Alejandra, Jocelyn, Abel, Julio César y Joaquín son cinco jóvenes viajeros y aventureros con discapacidad. Juntos, realizan viajes por distintos destinos nacionales. Acompáñalos y maravíllate con los paisajes y las aventuras que nos muestran, mientras nos dejan ver cómo los prejuicios sociales y la infraestructura excluyente son realmente los impedimentos más grandes a los que se enfrentan en sus travesías.', 004, 05),
       ('P0086', '¿Quién Dijo Yo?', 'Quién dijo yo?" es un programa de humor en el que a través de improvisaciones, los actores representan diferentes situaciones presionados por un conductor que les impone condiciones y tiempo, dando como resultado ingeniosos sketches.', 003, 05),
       ('P0087', 'Cristianos en armas', 'Bernardo Barranco conduce esta nueva serie documental, en la que especialistas invitados recuerdan y analizan a fondo momentos clave en la historia de México, en los cuales integrantes de la Iglesia Católica han intervenido con ideología y acción armada.', 005, 06),
       ('P0088', 'Historia del pueblo mexicano', 'Desde la resistencia indígena al siglo XX, la historia de México ha sido forjada en la lucha por conquistar derechos. En esta serie documental se muestra el trabajo de numerosísimas generaciones que nos heredaron el país que hoy habitamos. Una obra colectiva que nos corresponde continuar.', NULL, 06),
       ('P0089', 'De puño y letra', 'De puño y letra rescata el valor del correo postal, de la escritura sin pantallas y las relaciones epistolares. Cobijada por la Quinta Casa de Correos, nuestro hermoso Palacio Postal, Sofía Álvarez nos guía en un recorrido por las cartas que cambiaron el rumbo de la historia de México.', 002, 06),
       ('P0090', 'Perspectivas históricas', 'Un espacio dirigido por especialistas historiadores para el análisis y la reflexión de las problemáticas actuales desde la perspectiva histórica, en el que se abordan temas como El cambio de régimen; Las raíces del racismo en México; Prensa de oposición y libertad de expresión, entre otros.', 004, 06),
       ('P0091', 'Crónicas Y Relatos De México A Dos Voces', 'Serie documental conducida por la cronista del Centro Histórico de la Ciudad de México, Ángeles González Gamio quien departe amena y espontáneamente, cada emisión con un invitado diferente, anécdotas relacionadas con la transformación, restauración y cambios acontecidos al paso del tiempo de la arquitectura, diseño, cultura y tradiciones de México.', 003, 06),
       ('P0092', '6 Grados de Separación', 'Una persona o hecho puede estar conectado a otro que, por más lejano que parezca, dista sólo 6 niveles de intermediación. Esta serie animada nos muestra expresiones culturales y tradiciones mexicanas que evolucionaron a partir de un origen tan interesante como lejano gracias a estos famosos 6 grados de separación.', 001, 06), -- caricatura ONCE NIÑOS
       ('P0093', 'Arquitectura del Poder', 'Las civilizaciones se reconocen a través de sus logros arquitectónicos. Una de sus expresiones más relevantes en el ámbito público es la arquitectura parlamentaria. ¿Se podría hablar de una "arquitectura del poder"? Recorre con nosotros los inmuebles que dan muestra de ello.', 002, 06),
       ('P0094', 'Los Que Llegaron', 'Esta serie documental del Once aborda la vida de quienes, durante los últimos dos siglos, llegaron para quedarse y perfilar así el rostro de México. "Los que llegaron" relata la historia de los inmigrantes cuya riqueza cultural ha contribuido en la conformación de nuestra identidad nacional.', 002, 06),
       ('P0095', 'La Educación En México', 'La educación tiene un papel preponderante en la formación de una sociedad. Esta serie nos presenta la historia de la educación en México y sus principales personajes, instituciones y acontecimientos. Acompaña al Once en este recorrido sobre las diversas formas de educar en México, desde las culturas prehispánicas hasta nuestros días.', 002, 06), -- educativo ONCE NIÑOS Y ONCE DIGITAL
       ('P0096', 'Voces de la Constitución', 'La promulgación de la Constitución Política de los Estados Unidos Mexicanos fue el resultado de largos e intensos debates en los que participaron jóvenes constituyentes. Esta serie nos propone un juego de imaginación en torno a los debates del Congreso Constituyente de 1917. Conoce a fondo la historia de la Carta Magna y de algunos de sus artículos más relevantes.', 003, 06),
       ('P0097', 'Especiales La Ciudad de México en el Tiempo', 'Seis episodios que a través de sus protagonistas calles, edificios, leyendas, oficios y personajes dan cuenta del pasado y el presente del Centro Histórico de la Ciudad de México, desde Bucareli hasta Circunvalación. Esta serie retrata las ruinas de un imperio y los recuerdos de una urbe que desapareció para que otra naciera, las voces de una metrópoli que cada tarde deja atrás sus antiguos palacios para volver al día siguiente, y espacios que han dejado huella en las viejas postales y se mantienen vivos en todos sus rincones.', 001, 06),
       ('P0098', 'Historias De Vida', 'Semblanza de la vida y trayectoria profesional de consolidados artistas, personajes relevantes y creadores mexicanos en todos los ámbitos, que por su obra son reconocidos más allá de nuestras fronteras.', 002, 06),
       ('P0099', 'Ven acá... con Eugenia León y Pavel Granados', 'Ven acá nos lleva en un viaje de armonías y compases para explorar los diferentes géneros de la música popular, a través de las interpretaciones de Eugenia León, Pavel Granados y sus invitados. Una producción conjunta de la Secretaría de Cultura, el SPR, el Once y Canal 22.', 001, 08),
       ('P0101', 'Emergentes', ' Emergentes es una serie documental en la que se relatan las frustraciones y satisfacciones al emprender un proyecto musical: lo que se vive en el estudio; la relación entre músicos, productores e ingenieros; los sonidos y ritmos que surgen tanto del trabajo colaborativo como de la creatividad artística. Un proceso que muy pocos han vivido, y que pocas veces ha sido documentado.', 003, 08),
       ('P0102', 'Noche, Boleros y Son', 'Noche, Boleros y Son es un programa dedicado a los ritmos latinos más románticos. En cada episodio escucha a grandes exponentes de los géneros del bolero y el son. A través de entrevistas y espectaculares presentaciones, músicos, cantantes, compositores y arreglistas homenajean y mantienen viva la esencia de estos bellos estilos musicales.', NULL, 08),
       ('P0103', 'Contigo', 'Contigo es un programa musical donde el protagonista es la buena música. Teniendo como anfitrión al gran pianista Joao Henrique. En estas emociones las notas musicales y las grandes composiciones nos harán recordar el pasado y vivir la música de hoy y de siempre.', 001, 08),
       ('P0104', 'Conciertos OSIPN', 'Esta serie de conciertos compila extraordinarias colaboraciones de distintas naturalezas con la Orquesta Sinfónica del Instituto Politécnico Nacional, con el fin de propiciar y expandir acercamientos integrales a la música y las artes.', 001, 08),
       ('P0105', 'Concurso Nacional De Estudiantinas: La Serie', 'El objetivo del Concurso Nacional de Estudiantinas es retomar y promover entre la juventud las raíces de la estudiantina, una tradición musical propia de los jóvenes estudiantes. Este concurso es un encuentro que coloca a la música de tuna como parte importante de la cultura nacional.', 001, 08),
       ('P0106', 'Bandas en Construcción', 'Serie dedicada a la difusión de la música independiente en México. A través de entrevistas con bandas emergentes y una sesión musical, conoce las nuevas propuestas del rock nacional.', 001, 08),
       ('P0107', 'Ninguna Como Mi Tuna', 'La tuna, también conocida popularmente como la estudiantina, es una tradición musical de gran arraigo cultural en nuestro país. Esta serie recopila presentaciones musicales de distintos ensambles para un disfrute en familia. Con la conducción de Alexia Ávila y Ausencio Cruz, este programa tiene el objetivo de difundir entre las y los jóvenes los valores de hermandad, respeto y disciplina, que promueven las estudiantinas.', 001, 08),
       ('P0108', 'Foro Once', 'Para quienes buscan entretenimiento inteligente, Foro Once es el espacio del Once dedicado al espectáculo de calidad en todas sus posibilidades, donde por igual disfrutamos la pasión por el flamenco que por sones, marimbas y danzones.', 001, 08),
       ('P0109', 'El Timpano', 'El Tímpano te ofrece pláticas sinceras y veladas con música en vivo. Acompaña a David Filio, Sergio Félix e invitados en este programa, donde la música y una buena charla bohemia son los protagonistas, gracias a los diversos talentos que comparten su diario vivir en el arte.', 001, 08),
       ('P0110', 'Acústicos Central Once', 'Los "Acústicos Central Once", en el Museo Universitario del Chopo, presentan en cada edición una propuesta de diversos géneros musicales en versión acústica, utilizando diferentes tipos de instrumentos, electroacústicos, con resonancia y arreglos musicales especiales. Cuentan con la participación de público en vivo en el foro del dinosaurio y una entrevista en la que conocemos más del proyecto musical.', 001, 08),
       ('P0111', 'La Central', 'Conciertos acústicos desde el Museo del Chopo con bandas reconocidas y de la escena independiente.', 001, 08),
       ('P0112', 'Musivolución', 'La música es parte esencial de nosotros, es el pulso de nuestras emociones. ¿Cuál es la relación de la música con el humano? Acompaña a Edgar Barroso a descifrar esta pregunta. Este programa del Once presenta entrevistas a especialistas para conocer los orígenes de la música, así como los lazos que unen su práctica con aspectos del desarrollo y el conocimiento humano. La música es la banda sonora de la evolución humana. ¡Descúbrela en "Musivolución"!', 001, 08),
       ('P0113', 'Añoranzas', 'Jorge Saldaña e invitados hacen un recuento musical y anecdótico de épocas pasadas, en especial de lo sucedido hace más de tres décadas y con un tema de conversación particular en cada emisión. Vuelve a disfrutar algunos de los años más memorables de la vida musical de nuestro país con este relato de vivencias.', NULL, 08),
       ('P0114', 'Rock En Contacto', 'Rock en Contacto DF es un concurso para encontrar a la mejor banda de rock de la Ciudad de México. De un casting público, se eligieron sólo a 12 bandas, que a lo largo de la temporada competirán por convertirse en la mejor. Al final, tres bandas tocarán en vivo y el público escogerá a la ganadora. ¡Elige a tu favorita!', 003, 08),
       ('P0115', 'Especiales Musicales de Central Once', 'Especiales Musicales de Central Once son documentales de algunas de las bandas nacionales más entrañables, en donde aprenderás de la historia de la agrupación a través de entrevistas y disfrutarás de una presentación en vivo en el Foro de D del Once.', 001, 08),
       ('P0116', 'Especial Sonoro 2013', 'Un documental que nos introduce en el evento "Sonoro 2013": un encuentro académico y artístico dirigido a músicos de alto nivel desde la ciudad de Cuernavaca, Morelos. Los temas se centran en la experiencia de Jazmín Torres (clarinete), Daniel Rodríguez (oboe), Nabani Aguilar (violín) y Alejandra Roni (contrabajo), cuatro jóvenes que participaron de las clases magistrales, encuentros culturales y conciertos en distintas locaciones del estado, durante doce días de actividades.', 001, 08),
       ('P0117', 'Big Band Fest En El Lunario', 'Big Band Fest compila un exquisito repertorio de las grandes bandas de jazz en México. Una serie de presentaciones realizadas en el Lunario te deleitarán con lo mejor de los clásicos y éxitos del género, además de arreglos de música mexicana en estilo jazz.', 001, 08),
       ('P0118', 'El Show de los Once', 'Dos chistes son mejor que uno, ¡y ni se diga de once al mismo tiempo! Conoce El Show de los Once y prepárate para reír.', 001, 09),
       ('P0119', 'Trillizas de colores', 'Estas trillizas son inseparables porque además de ser hermanas adoptivas son las mejores amigas. ¡Conócelas!', 001, 09),
       ('P0120', 'Pie rojo', 'Alex es el único gorila rojo que existe, por eso el Dr. Pietroff quiere conocer todo acerca de él. ¡Únete a su búsqueda!', 001, 09),
       ('P0121', 'De viaje por un libro', 'Las historias de los libros nos hacen reflexionar acerca de las cosas que nos pasan, comparte lo que piensas con nosotros. ', 001, 09),
       ('P0122', 'Las viejas cintas de Staff', '¡Las viejas cintas de Staff están llenas de recetas deliciosas!', 001, 09),
       ('P0123', 'Las nuevas cintas de Staff', 'Staff está de regreso en la cocina para compartirte deliciosas y nutritivas recetas, conócelas y come como campeón y campeona', 001, 09),
       ('P0124', 'Los reportajes de ONN', 'Con micrófono en mano y cámara lista, el equipo ONN tiene para ti reportajes de distintos temas. Te recomendamos verlos todos.', 001, 09),
       ('P0125', 'T-Reto', 'Dos equipos de niñas y niños compiten por lograr retos relacionados a experimentos científicos.', 001, 09),
       ('P0126', 'Intelige', 'Programa de concurso de cultura general, ciencia, ingeniería, tecnología, arte y matemáticas, donde los integrantes de cada equipo se enfrentan en una sana competencia por demostrar sus conocimientos y habilidades. La diversión, el respeto, el trabajo en equipo y las experiencias de vida, son indispensables en este programa para lograr su desarrollo y éxito.', 001, 09),
       ('P0127', 'Galería Once Niñas y Niños', 'Observa las obras de arte que son parte de la Galería de #OnceNiñasyNiños y descubre las texturas, colores y técnicas de dibujo que los artistas usaron en cada una de sus creaciones.', 001, 09),
       ('P0128', 'Ahorrando Ando', 'Isa y Jonás son los protagonistas de este programa, juntos descubren datos interesantes acerca del dinero, de ahorrar y de ser responsables al gastarlo. ¡Descubre nuevas formas de ver el dinero!', 001, 09),
       ('P0129', 'Ek', 'Ek es un simpático perro negro, que tiene un gato al que llama Filete y que quiere mucho. A Ek le gusta investigar y compartir lo que sabe y aprende, como el cuidado de los animales, los derechos de las niñas y los niños, el medio ambiente, entre otros.', 001, 09),
       ('P0130', 'Libros En Acción', 'A Dana le encanta descubrir las historias que se viven en los libros y, junto con un grupo entusiasta de niñas y niños, charla de manera entretenida y breve con algunas escritoras y escritores.', 001, 09),
       ('P0131', 'El Diván de Valentina', 'Valentina es una niña que, a través de sus experiencias cotidianas, reflexiona y se enfrenta a la aventura de crecer: aprender a conocerse y a tomar decisiones, hacer nuevos amigos, enfrentar problemas... Así, Valentina cada día aprende lo que significa vivir, reír y hasta llorar en familia.', 001, 09),
       ('P0132', 'Preguntas del planeta con Lucy', 'Lucy y Camila harán todo por responder tus dudas e inquietudes de la naturaleza y el medio ambiente.', 001, 09),
       ('P0133', 'Verdadero o falso', 'Verfal es un dragón muy curioso que ha vivido muchos años y gracias a su conocimiento del mundo puede descifrar grandes enigmas.', 001, 09),
       ('P0134', '¿Cómo? con Mo', 'Mo es curiosa y quiere conocer cómo funcionan y se hacen las cosas, su comida favorita, juguetes y ropa, ¡acompáñala!', 001, 09),
       ('P0135', '¿Qué pasaría si…?', 'El equipo de Once Niñas y Niños juegan a imaginar qué pasaría si algo fuera de lo común ocurriera, ¡diviértete con su ingenio!', 001, 09),
       ('P0136', 'Un Día en... ON', 'Alan, Lucy y Staff tienen divertidas aventuras, anécdotas e historias que compartir. Conoce más sobre lo que les gusta hacer y disfruta con ellos de increíbles y entretenidos momentos.', 001, 09),
       ('P0137', 'Abuelos', 'Las y los abuelos son la memoria familiar. Por su autenticidad, su perspectiva se liga a las cosas y momentos más valiosos de la vida. Ellos atesoran valiosos recuerdos y anécdotas que conforman la trama multicolor de una familia. En este programa las niñas y niños de México nos cuentan todo sobre sus abuelos.', 001, 09),
       ('P0138', 'Canciones Once Niñas y Niños', 'Alan, Lucy, Staff y todo el equipo de Once Niñas y Niños te invitan a disfrutar a lo grande de todas sus canciones y bailes. Así que... ¡a mover el cuerpo para divertirnos!', 001, 09),
       ('P0139', 'Código – L', 'Déjate sorprender por la tecnología y conoce los inventos más interesantes que han cambiado al mundo.', 001, 09),
       ('P0140', 'Kipatla LSM', 'En este pueblo, todos son como quieren ser y eso es lo que hace único a este lugar que tal vez te resulte familiar.', 001, 09),
       ('P0141', 'Sofía Luna, Agente Especial', 'Incursiona en el universo de una agente científica muy especial: Sofía Luna. Ella es una estudiante universitaria de Física y su mejor amigo es Pato, su hermano de 8 años que la acompaña por todas partes para descubrir que la ciencia está presente en nuestra cotidianidad, en cada rincón. Cabe destacar que esta serie contó con la colaboración y asesoría de la doctora Julieta Fierro, una de las máximas autoridades mundiales en la materia.', 001, 09),
       ('P0142', 'Alcánzame Si Puedes', 'Dos equipos de 4 participantes cada uno, compiten en un campamento para demostrar destreza física e ingenio. Tendrán que ganar dos de tres retos, y estos serán una mezcla de trabajo en equipo, estrategia y resistencia física. También habrá actividades al aire libre, acuáticas y de deporte extremo. El equipo ganador obtendrá una pulsera que representa una habilidad calificada durante ese capítulo. Al término de la aventura, el equipo que haya reunido el mayor número de pulseras será el ganador.', 001, 09),
       ('P0143', 'Arte Al Rescate', 'Arte al Rescate escoge un caso que una niña o un niño manda al Once y que necesita de la cooperación de todo el equipo para ser resuelto. En conjunto, el equipo utilizará todas sus habilidades creativas y ayudará a crear el proyecto artístico para alguien que desesperadamente lo necesita. El equipo lo conforman un artista joven que funge como conductor, 5 niños y un artista invitado. ¡Tienen sólo 3 días para lograr su obra!', 001, 09),
       ('P0144', 'De Compras', 'De Compras fomenta el consumo inteligente y responsable en los más pequeños de la casa. En este programa, un grupo de niños reflexionan, de manera lúdica e interactiva, sobre el precio y la calidad de algunos de los productos de nuestra vida cotidiana. ¡Analiza, compara y aprende acerca del valor de las cosas en DeC!', 001, 09),
       ('P0145', 'DIZI', 'Dizi, una niña con voz de flauta, se embarca en aventuras para descubrir, a través de sus sentidos, nuevas cosas sobre la música. En cápsulas de un minuto, este programa animado de apreciación musical nivel preescolar presenta elementos formales, instrumentos musicales, géneros y más.', 001, 09),
       ('P0146', 'Secretos culinarios de Staff', 'Acompaña a Staff a conseguir los ingredientes que necesita para preparar sus platillos favoritos.', 001, 09),
       ('P0147', 'DXT', 'A las niñas y niños que aquí figuran les encanta correr, saltar y estirar cada parte de su cuerpo. ¡Descubre qué es lo que más les gusta sobre su deporte favorito!', 001, 09),
       ('P0148', 'Las Piezas del Rompecabezas', 'Yola tiene ocho años y descubre un nuevo significado del amor al lado de Rodrigo, su pequeño y especial hermano. Yola nos hará reflexionar sobre la importancia de educar a los niños en el espíritu de la No Discriminación.', 001, 09),
       ('P0149', 'Mi Lugar', 'Un espacio que retrata la vida de niñas y niños de diversas regiones de México. Desde Tijuana hasta San Cristóbal de las Casas, tendremos maravillosos testimonios de los espacios, juegos y amigos de diferentes niñas y niños en todo el país.', 001, 09),
       ('P0150', 'Cuentos De Pelos', 'Princesas en apuros, lobos feroces, todo puede ocurrir cuando Chema y Meche empiezan a contar. ¡Los Cuentos de Pelos!', 001, 09),
       ('P0151', 'Perros Y Gatos', 'Jessica e Iván tienen toda la información acerca de perros y gatos: historias, trucos, tips, datos curiosos y mucho más.', 001, 09),
       ('P0152', 'Consulta con el doctor Pelayo', 'El Dr. Pelayo está listo para resolver las dudas de sus pacientes y compartir datos asombrosos sobre salud y el cuerpo humano.', 001, 09),
       ('P0153', 'Una vez soñé', 'En "Una vez soñé...", conoce los mejores sueños y las peores pesadillas de niñas y niños, quienes de viva voz nos relatan lo que pasa por sus mentes cuando duermen. En estas breves cápsulas, vive con ellos estos relatos ilustrados.', 001, 09),
       ('P0154', 'La palabra de Memo', 'Descubre el significado de algunas palabras que usamos todos los días. ¡Te sorprenderás!', 001, 09),
       ('P0155', 'Zoológicos Azoombrosos', 'En estas cápsulas de tan solo tres minutos, una niña y un niño: Scarlet y Diego, hacen un recorrido por los zoológicos más importantes de México para descubrir todo tipo de animales. Con la ayuda de un experto en la materia, ellos descubren todo sobre los animales: de dónde vienen, cuál es su hábitat, cómo llegaron al parque, qué comen, cómo se comportan, quiénes son sus depredadores y mucho más.', 001, 09),
       ('P0156', 'Creciendo Juntos', 'Creciendo juntos incentiva el desarrollo armónico de niñas y niños con relación a temas y situaciones que los vulneran y colocan en situación de riesgo y violencia. Con la participación de niñas y niños, cápsulas, marionetas y otros medios, este programa del Once explora valores, reglas y formas de crecer juntos de manera respetuosa y próspera.', 001, 09),
       ('P0157', 'Timora y Sus Extrañas Historias', 'Monstruos, fantasmas, gatos y escobas con poderes mágicos son algunos de los personajes que descubrirás junto a Timora.', 001, 09),
       ('P0158', 'Concierto. A mover el bote en casa', 'El equipo de Once Niñas y Niños te invita a disfrutar de un recorrido por todos sus éxitos musicales y momentos especiales en este divertido concierto.', 001, 09),
       ('P0159', 'Concierto Conmemorativo UNICEF 70 Años', 'El 11 de diciembre de 2016, el Fondo de las Naciones Unidas para la Infancia (UNICEF) cumplió 70 años de hacer magia y cambiar vidas. Y eso ¡hubo que celebrarlo! Este concierto dio muestra de ello a través del arte de las niñas y niños. Así, los músicos, el coro, nuestras invitadas e invitados y, por supuesto: Alan, Lucy y Staff fueron los anfitriones de esta importante celebración.', 001, 09),
       ('P0160', 'Cuenta Con Sofía', 'En cada episodio, Sofía Álvarez nos cuenta las historias más fascinantes y entretenidas. En su espacio mágico, títeres, objetos e invitados la acompañan para narrar los más divertidos relatos. Al ritmo de canciones, con disfraces y todo tipo de utensilios, acompáñala en esta travesía única.', 001, 09),
       ('P0161', 'La Doctora Noyolo y yo', 'Aprender a identificar lo que sentimos es muy importante para conocernos mejor. Acompaña a la doctora Noyolo en un viaje por las emociones y descubre algunos ejercicios que te ayudarán a sentirte mejor.', 001, 09),
       ('P0162', 'Kin', 'Joaquín Guerrero ha desaparecido y el presente, como lo conocemos, depende de que logren encontrarlo.', 001, 09),
       ('P0163', 'Un espacio sin límites', 'En el Día Internacional de las personas con discapacidad celebramos a todos los seres humanos por igual. Hagamos que el mundo sea... "un espacio sin límites".', 001, 09),
       ('P0164', 'Especiales Canal Once', 'Te invitamos a explorar este espacio, ponemos a tu alcance nuestros programas unitarios; series cortas; cápsulas noticiosas, informativas o culturales; reportajes y programas de diferentes temas y contenidos, etc. Recuerda, son “especiales” por eso, no te los puedes perder.', 003, 10),
       ('P0164', 'Hagamos Que Suceda: La Cuarentena', 'Manteniendo la sana distancia, muchas personas en todo el país envían sus experiencias, inquietudes y actividades realizadas durante el aislamiento por COVID-19. Aunado a esto, especialistas en diversos campos ofrecen un panorama sobre cómo enfrentar de mejor manera la cuarentena.', 004, 10),
       ('P0165', 'Digital', 'Digital es un programa que nos invita a reflexionar en torno a las Tecnologías de la Información y Comunicación (TIC) y al alcance e importancia que tienen en nuestra sociedad. Conversando con expertos, usuarios y esbozando diversos ejemplos, "Digital" busca reducir las brechas generacionales y digitales.', 001, 10),
       ('P0166', 'México en el Exterior', 'Reflexionar sobre nuestra política exterior es un tema de interés público. La serie "México en el exterior", realizada por el Once en colaboración con la Secretaría de Relaciones Exteriores (SRE), nos invita a dialogar sobre los retos y prioridades de la política exterior mexicana a lo largo de ocho programas. El objetivo de esta serie es, ante todo, abrir un debate plural y profundo sobre la diplomacia mexicana en la conversación pública. Disfruta y reflexiona de la mano de las opiniones de especialistas, investigadores, académicos y diplomáticos en "México en el exterior".', NULL, 10),
       ('P0167', 'Factor Ciencia', 'En Factor Ciencia abordamos temas actuales y reflexionamos sobre el rumbo científico, su huella en la sociedad y su aplicación tecnológica. Mantente al día del acontecer científico de México y el mundo.', 002, 10),
       ('P0168', 'Hagamos Que Suceda: La Sana Distancia', 'En este programa, Ana María Lomelí nos ofrece un amplio abanico de experiencias durante la cuarentena provocada por Covid-19 y reúne a expertos en diversas áreas que nos brindan su conocimiento y consejos para enfrentarnos de la manera más sana y sencilla a la nueva normalidad.', NULL, 10),
       ('P0169', 'Hagamos Que Suceda', 'Este programa del Once de gran trayectoria ha tratado algunas de las temáticas más importantes para el acontecer nacional que nos afectan a todas y todos en nuestro día a día. "Hagamos que suceda" es una serie de reportajes especiales en los que se aborda la situación económica, política y social de México, contada a partir de testimonios de ciudadanos y funcionarios involucrados en estos temas. ¡Conoce, reflexiona y opina con Hagamos que Suceda!', 002, 10),
       ('P0170', 'Un lugar llamado México', 'La UNESCO, el Instituto Nacional de Antropología e Historia y El Once, presentan esta serie documental en la que se muestra la belleza natural y patrimonial de nuestro país, a través de un recorrido por diferentes rutas históricas, reservas naturales y personajes emblemáticos de cada rincón, que son descubiertos en un viaje por el extenso territorio de la república mexicana. Iniciemos juntos este recorrido por un lugar llamado México.', 002, 11),
       ('P0171', 'México Biocultural', 'Manglares e islotes con vegetación de selva mediana que esconden la arqueología de la cultura maya, hogar de peces, aves y reptiles endémicos. En este programa, arqueólogos, biólogos, artesanos y difusores culturales nos explican la simbiosis entre la naturaleza y la cultura maya ancestral, así como la importancia para nuestro país de conservarla. México Biocultural difunde nuestra gran riqueza natural y arqueológica, al tiempo que muestra cómo los antiguos pobladores de México, en su sabiduría y respeto por la vida, se adaptaron y vivieron en equilibrio con su entorno.', 002, 11),
       ('P0172', 'Agenda Verde', 'Conoce alternativas e historias de éxito en torno a diversas personas que ayudan a generar un cambio positivo en el medio ambiente. Este programa nos ofrece desde reportajes especiales en torno a la preservación de especies animales y vegetales, hasta consejos para generar menos basura. Conduce Max Espejel.', 002, 11),
       ('P0173', 'Chapultepec un Zoológico Desde Adentro', 'Esta serie nos mostrará cómo funciona un parque zoológico, cuáles son sus necesidades, sus retos, el trabajo y la pasión de la gente que trabaja para que los animales tengan una vida sana y digna; su papel en la conservación de las especies a nivel local y mundial.', 002, 11),
       ('P0174', 'Detrás de un Click', 'A través de la lente de su cámara, Magali Boysselle captura imágenes impresionantes de sus viajes a diferentes destinos del país, fotografías que retratan aspectos naturales con los que nunca habíamos estado tan conectados. Viaja con Magali y comparte su experiencia sobre lo que ve y admira de los paisajes naturales.', 002, 11),
       ('P0175', 'El Libro Rojo, Especies Amenazadas', 'Nuestro país es uno de los recintos megadiversos de flora y fauna más importantes del mundo. Sin embargo, debido a una serie de factores que incluyen la actividad humana, cientos de especies están en peligro de desaparecer. Conoce la pasión con la que organizaciones, comunidades, sector privado e individuos luchan para revertir la tendencia que conduce a estos seres hacia el fin de su especie. Sé testigo de importantes historias de conservación de las especies animales más emblemáticas de México.', 002, 11),
       ('P0176', 'Nuestros Mares', 'En breves cápsulas conoce los secretos de la riqueza de los mares y océanos mexicanos, así como la importancia esencial de su cuidado para la conservación de la vida en el planeta. Maravíllate con los paisajes, especies y ecosistemas acuáticos de nuestra nación.', 002, 11),
       ('P0177', 'Islas de México', 'Serie documental de naturaleza producida por Canal Once con apoyo del Consejo Nacional de Ciencia y Tecnología, CONACyT, que muestra la biodiversidad de las islas localizadas en el Océano Pacífico, consideradas como reservas naturales debido a sus altos niveles de endemismo y grado de conservación; además reconoce y retrata la labor de científicos y conservacionistas.', 001, 11),
       ('P0178', 'Entre Mares', 'Manuel Lazcano, un experimentado buzo y fotógrafo mexicano, nos muestra tanto la belleza como la fragilidad de la vida marina, revelándonos algunas de sus maravillas y misterios. Esta serie es una aventura fascinante para celebrar la vida marina y explorar las riquezas de los litorales mexicanos.', 001, 11),
       ('P0180', 'México Vive', 'Los efectos del cambio climático tienen un impacto directo en los sistemas naturales y humanos. "México vive" es un espacio de reflexión que incentiva la concientización de la importancia de conservar nuestro medio ambiente, así como de la urgente necesidad de tomar medidas para protegerlo y preservarlo. Acompaña a Javier Solórzano y a un grupo de expertos en esta conversación, donde abordan temas como un país en equilibrio, biodiversidad, leyes forestales, áreas naturales protegidas, contaminación, energía renovable, especies endémicas, calentamiento global, reciclaje y explotación sustentable de los recursos naturales. "México vive" y necesita de todos para seguir latiendo.', 002, 11),
       ('P0181', 'Patrimonio Mundial Natural En México', 'Una serie documental producida por el Once, Bravo Films y SEMARNAT-CONANP donde se muestran las cinco Áreas Naturales Protegidas de México catalogadas como Patrimonio Mundial por la UNESCO. Embárcate en esta exploración por la Reserva de la Biosfera de la mariposa Monarca, Michoacán; la Reserva de la Biosfera El Pinacate y Gran Desierto de Altar, Sonora; la Reserva de la Biosfera de Sian Kaan, Quintana Roo; la Reserva de la Biosfera El Vizcaíno, Baja California; y las Islas y áreas protegidas del Golfo de California.', 001, 11),
       ('P0182', '', '', 001, 11),
       ('P0183', '', '', 001, 11),
       ('P0184', '', '', 001, 11),
       ('P0185', '', '', 001, 11),
       ('P0186', '', '', 001, 11),
       ('P0187', '', '', 001, 11),
       ('P0188', '', '', 001, 11),
       ('P0189', '', '', 001, 11),
       ('P0190', '', '', 001, 11),
       ('P0191', '', '', 001, 11),
       ('P0192', '', '', 001, 11),
       ('P0193', '', '', 001, 11),
       ('P0194', '', '', 001, 11),
       ('P0195', '', '', 001, 11),
       ('P0196', '', '', 001, 11),
       ('P0198', '', '', 001, 11),
       
       
       
       

