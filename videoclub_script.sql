drop schema if exists miguelferlez_videoclub cascade;

create schema miguelferlez_videoclub;

set schema 'miguelferlez_videoclub';

-- Tablas

create table director (
	id serial primary key,
	nombre varchar(50) not null,
	apellidos varchar(50) not null
);

create table pelicula (
	id serial primary key,
	titulo varchar(80) not null,
	id_director integer not null,
	sinopsis text not null,
	
	constraint pelicula_director_fk foreign key (id_director) references director(id)
);

create table genero (
	id serial primary key,
	nombre varchar(50) not null
);

create table genero_pelicula (
	id serial primary key,
	id_pelicula integer not null,
	id_genero integer not null,
	
	constraint genero_pel_pelicula_fk foreign key (id_pelicula) references pelicula(id),
	constraint genero_pel_genero_fk foreign key (id_genero) references genero(id)
);

create table copia_pelicula (
	id serial primary key,
	id_pelicula integer not null,
	
	constraint copia_pel_pelicula_fk foreign key (id_pelicula) references pelicula(id)
);

create table correspondencia (
	id serial primary key,
	calle varchar(80) not null,
	numero varchar(5) not null,
	piso varchar(5),
	codigo_postal integer not null
);

create table socio (
	id serial primary key,
	nombre varchar(50) not null,
	apellidos varchar(50) not null,
	fecha_nacimiento date not null,
	dni varchar(9) not null,
	telefono varchar(15) not null,
	id_correspondencia integer,
	
	constraint socio_correspondencia_fk foreign key (id_correspondencia) references correspondencia(id)
);

create table carnet (
	id serial primary key,
	id_socio integer unique not null,
	serie varchar(10) not null,
	
	constraint carnet_socio_fk foreign key (id_socio) references socio(id)
);

create table prestamo (
	id serial primary key,
	id_carnet integer not null,
	id_copia integer not null,
	fecha_prestamo date not null,
	fecha_devolucion date,
	
	constraint prestamo_carnet_fk foreign key (id_carnet) references carnet(id),
	constraint prestamo_copia_fk foreign key (id_copia) references copia_pelicula(id)
);

-- Indexes

create unique index nombre_genero_unique on genero (lower(nombre));

create unique index dni_socio_unique on socio (lower(dni));

create unique index serie_carnet_unique on carnet (lower(serie));

create unique index pelicula_unique on pelicula (lower(titulo), id_director);

-- Inserts

insert into director (nombre, apellidos) values
	('Alejandro', 'González Iñárritu'),
	('Ang', 'Lee'),
	('Bong', 'Joon-ho'),
	('Christopher', 'Nolan'),
	('Clint', 'Eastwood'),
	('David', 'Fincher'),
	('Denis', 'Villeneuve'),
	('Francis Ford', 'Coppola'),
	('Greta', 'Gerwig'),
	('Guillermo', 'del Toro'),
	('Hayao', 'Miyazaki'),
	('James', 'Cameron'),
	('Jane', 'Campion'),
	('John', 'Carpenter'),
	('Kathryn', 'Bigelow'),
	('Kenji', 'Mizoguchi'),
	('Martin', 'Scorsese'),
	('Paul', 'Thomas Anderson'),
	('Pedro', 'Almodóvar'),
	('Quentin', 'Tarantino'),
	('Ridley', 'Scott'),
	('Robert', 'Zemeckis'),
	('Ron', 'Howard'),
	('Sofia', 'Coppola'),
	('Spike', 'Lee'),
	('Stanley', 'Kubrick'),
	('Steven', 'Spielberg'),
	('Tim', 'Burton'),
	('Wes', 'Anderson')
;

insert into pelicula (titulo, id_director, sinopsis) values 
	('2001: A Space Odyssey', 26, 'Una obra maestra de la ciencia ficción que explora la evolución de la humanidad, el surgimiento de la inteligencia artificial y el futuro del espacio, con imágenes impactantes y una narrativa filosófica.'),
	('A Beautiful Mind', 23, 'La emocionante vida de John Nash, un matemático brillante cuyas teorías revolucionarias cambian el curso de la economía, mientras lucha con la esquizofrenia y encuentra apoyo en el amor de su vida.'),
	('Avatar', 12, 'Una historia épica ambientada en el exuberante mundo de Pandora, donde los humanos intentan explotar los recursos del planeta, enfrentándose a los nativos Navi en una lucha por la supervivencia y la conservación.'),
	('Apocalypse Now', 8, 'Un impactante viaje psicológico a través de la guerra de Vietnam, mientras un capitán del ejército busca a un coronel rebelde en lo profundo de la jungla.'),
	('Back to the Future', 22, 'Un joven estudiante es enviado accidentalmente al pasado en una máquina del tiempo creada por un excéntrico científico, donde debe asegurarse de que sus futuros padres se enamoren para salvar su propia existencia.'),
	('Babel', 1, 'Un intenso drama que entrelaza cuatro historias de diferentes continentes, exponiendo los profundos malentendidos y las conexiones humanas en un mundo dividido por barreras culturales y lingüísticas.'),
	('Barbie', 9, 'Un relato introspectivo que explora la evolución de Barbie desde un símbolo cultural hasta una figura que busca su propósito en un mundo cambiante.'),
	('Blade Runner', 21, 'Un futuro distópico donde un cazador de androides debe enfrentarse a preguntas sobre la humanidad y la ética mientras persigue réplicas fugitivas.'),
	('Casino', 17, 'La fascinante crónica del ascenso y la caída de un casino dirigido por la mafia en Las Vegas, donde el poder y la ambición llevan al colapso personal.'),
	('Django Unchained', 20, 'Ambientada en el sur de Estados Unidos antes de la Guerra Civil, esta historia de venganza sigue a un esclavo liberado que se une a un cazarrecompensas alemán para rescatar a su esposa de un brutal propietario de plantaciones.'),
	('Do the Right Thing', 25, 'Ambientada en un caluroso día de verano en Brooklyn, esta película examina las tensiones raciales y las complejidades de las relaciones humanas, culminando en un acto de violencia que cambiará la comunidad para siempre.'),
	('Dune: Part One', 7, 'La épica saga de Paul Atreides, un joven destinado a liderar a los habitantes del planeta desértico Arrakis. En un mundo lleno de intrigas políticas y lucha por el control del recurso más valioso del universo, Paul debe enfrentarse a su destino.'),
	('Edward Scissorhands', 28, 'Un cuento gótico sobre un hombre incompleto con tijeras en lugar de manos, que intenta encontrar aceptación en un mundo que teme lo diferente. La película es una reflexión sobre el amor, la soledad y la belleza de ser único.'),
	('E.T. the Extra-Terrestrial', 27, 'Un niño solitario forma una conmovedora amistad con un extraterrestre varado en la Tierra, trabajando juntos para encontrar una manera de devolverlo a su planeta natal mientras escapan de las autoridades.'),
	('Fight Club', 6, 'Un oficinista y un vendedor de jabón forman un club de lucha clandestino que evoluciona hacia algo mucho más grande.'),
	('Forrest Gump', 22, 'La extraordinaria vida de Forrest, un hombre de corazón puro que, a pesar de sus limitaciones, deja una marca indeleble en la historia de Estados Unidos mientras busca el amor de su vida, Jenny.'),
	('Gladiator', 21, 'La épica historia de un general romano convertido en esclavo, que lucha por vengar a su familia y restaurar su honor enfrentándose a un emperador corrupto.'),
	('Gone Girl', 6, 'Un suspense psicológico que explora las complejidades de un matrimonio que se desmorona cuando la esposa desaparece misteriosamente, dejando al marido como el principal sospechoso en una intensa investigación mediática.'),
	('Goodfellas', 17, 'La apasionante historia de Henry Hill, quien se adentra en el mundo del crimen organizado. Desde su ascenso en la jerarquía de la mafia hasta su eventual caída, la película ofrece un vistazo sin filtros al estilo de vida gangster.'),
	('Gran Torino', 5, 'Un veterano de guerra gruñón establece un vínculo inesperado con su joven vecino en un barrio cambiante.'),
	('Halloween', 14, 'Una noche de terror en la que Michael Myers, un asesino enmascarado que escapó de un manicomio, regresa a su pueblo natal para desatar el caos. La película sigue a Laurie Strode mientras lucha por sobrevivir y enfrentarse a su peor pesadilla.'),
	('Inception', 4, 'Un ladrón especializado en infiltrarse en los sueños de las personas para robar secretos corporativos es reclutado para una misión única: implantar una idea en la mente de un ejecutivo, desafiando los límites de la realidad.'),
	('Interstellar', 4, 'En un futuro donde la Tierra se enfrenta a una crisis ambiental, un grupo de astronautas se embarca en un viaje interestelar para encontrar un nuevo hogar para la humanidad, explorando los misterios del tiempo y el espacio.'),
	('Jaws', 27, 'Un thriller que sigue a un pueblo costero aterrorizado por un gran tiburón blanco, donde un jefe de policía, un biólogo marino y un cazador intentan detenerlo.'),
	('Kill Bill: Volume 1', 20, 'Una exasesina emprende un sangriento viaje de venganza contra aquellos que la traicionaron y dejaron al borde de la muerte, utilizando sus letales habilidades de combate para buscar justicia.'),
	('Life of Pi', 2, 'La increíble historia de un joven llamado Pi, quien sobrevive un devastador naufragio y se encuentra atrapado en un bote salvavidas con un tigre de Bengala. La película explora temas de fe, supervivencia y el intrincado vínculo entre el hombre y la naturaleza.'),
	('Lost in Translation', 24, 'Dos almas perdidas, un actor y una joven recién casada, forman una inesperada conexión emocional mientras navegan por la soledad en el vibrante pero alienante mundo de Tokio.'),
	('Parasite', 3, 'Una sátira oscura y cautivadora sobre dos familias de orígenes opuestos, cuyas vidas se entrelazan en una espiral de engaños y manipulaciones que desvelan las profundas desigualdades sociales.'),
	('Pulp Fiction', 20, 'Una narrativa no lineal que entrelaza las historias de gánsteres, boxeadores y criminales en Los Ángeles, destacando las ironías y absurdos de su peligrosa vida cotidiana.'),
	('Schindlers List', 27, 'La desgarradora historia real de Oskar Schindler, un empresario alemán que arriesga todo para salvar las vidas de más de mil judíos durante el Holocausto al emplearlos en su fábrica.'),
	('Spirited Away', 11, 'Una niña de diez años se adentra en un mundo mágico lleno de extrañas criaturas y espíritus, donde debe encontrar el valor para rescatar a sus padres y regresar al mundo real.'),
	('Taxi Driver', 17, 'Un veterano de guerra convertido en taxista se sumerge en la locura mientras lucha por encontrar sentido en su vida.'),
	('The Dark Knight', 4, 'Un superhéroe lucha contra un villano anárquico que siembra el caos en Gotham, explorando los límites de la moralidad y el sacrificio personal.'),
	('The Hurt Locker', 15, 'Un impactante retrato de la vida de un equipo de desactivación de explosivos en Irak. Mientras enfrentan peligros diarios, sus miembros lidian con los efectos psicológicos de la guerra y las complejas relaciones entre ellos.'),
	('The Godfather', 8, 'La épica historia de la familia Corleone, una de las mafias más influyentes de Nueva York, explorando el poder, la lealtad y la tragedia que conlleva el mundo del crimen organizado.'),
	('The Grand Budapest Hotel', 29, 'Una comedia visualmente deslumbrante que narra las aventuras de un conserje excéntrico y su joven protegido en un hotel de lujo, mientras se enfrentan a intrigas familiares y robos de arte.'),
	('The Power of the Dog', 13, 'Un western psicológico que examina la masculinidad tóxica a través de la relación entre un ranchero dominante y la familia de su hermano. En un paisaje desolado, secretos y emociones reprimidas salen a la superficie con un desenlace sorprendente.'),
	('The Shape of Water', 10, 'Una historia de amor poco convencional entre una mujer muda que trabaja como conserje en un laboratorio y una criatura anfibia capturada, explorando la empatía y la lucha por la libertad.'),
	('There Will Be Blood', 18, 'Un drama sobre la avaricia, el poder y la corrupción, centrado en un magnate del petróleo cuyo deseo insaciable de riqueza lo lleva a destruir todo lo que ama. Una meditación sobre los costos del progreso y la moralidad humana.'),
	('Titanic', 12, 'Una trágica historia de amor entre dos jóvenes de diferentes clases sociales que se embarcan en el transatlántico más famoso de la historia, enfrentándose al desastre en su viaje inaugural.'),
	('Ugetsu', 16, 'Un cuento clásico japonés que mezcla la ambición, el amor y lo sobrenatural en tiempos de guerra.'),
	('Volver', 19, 'La conmovedora historia de mujeres fuertes y sus relaciones familiares en un pequeño pueblo español.')
;

insert into genero (nombre) values
	('Acción'), 
	('Animación'), 
	('Aventura'), 
	('Bélico'), 
	('Ciencia ficción'), 
	('Clásico'), 
	('Comedia'), 
	('Crimen'), 
	('Drama'), 
	('Fantástico'), 
	('Horror'), 
	('Independiente'), 
	('Romántico'), 
	('Thriller'), 
	('Western')
;

insert into genero_pelicula (id_pelicula, id_genero) values
	(1, 5),
	(2, 9),
	(3, 1),
	(3, 5),
	(4, 4),
	(4, 6),
	(5, 5),
	(5, 7),
	(6, 9),
	(6, 12),
	(7, 7),
	(8, 5),
	(8, 14),
	(9, 8),
	(10, 15),
	(11, 9),
	(11, 12),
	(12, 5),
	(13, 10),
	(13, 13),
	(14, 3),
	(14, 5),
	(15, 9),
	(16, 3),
	(16, 9),
	(16, 13),
	(17, 1),
	(17, 9),
	(18, 14),
	(19, 8),
	(20, 9),
	(20, 15),
	(21, 11),
	(22, 5),
	(22, 14),
	(23, 5),
	(24, 11),
	(25, 1),
	(26, 3),
	(27, 7),
	(27, 9),
	(28, 9),
	(28, 12),
	(29, 8),
	(30, 9),
	(31, 2),
	(31, 10),
	(32, 6),
	(32, 9),
	(33, 1),
	(33, 5),
	(34, 4),
	(35, 8),
	(35, 9),
	(36, 7),
	(37, 9),
	(37, 15),
	(38, 10),
	(39, 9),
	(40, 9),
	(40, 13),
	(41, 6),
	(42, 9)
;

insert into copia_pelicula (id_pelicula) values
	(1), 
	(1), 
	(2), 
	(2), 
	(3), 
	(4), 
	(4), 
	(5), 
	(5), 
	(5), 
	(6), 
	(6), 
	(6), 
	(7), 
	(7), 
	(8), 
	(9), 
	(9), 
	(10), 
	(10), 
	(11), 
	(11), 
	(12), 
	(13), 
	(14), 
	(15), 
	(16), 
	(16), 
	(17), 
	(17), 
	(18), 
	(18), 
	(18), 
	(18), 
	(19), 
	(20), 
	(21), 
	(22), 
	(22), 
	(23), 
	(23), 
	(23), 
	(24), 
	(25), 
	(25), 
	(25), 
	(26), 
	(26), 
	(26), 
	(26), 
	(26), 
	(27), 
	(28), 
	(29), 
	(30), 
	(31), 
	(31), 
	(31), 
	(32), 
	(32), 
	(32), 
	(32), 
	(33), 
	(33), 
	(33), 
	(34), 
	(35), 
	(35), 
	(35), 
	(36), 
	(36), 
	(36), 
	(37), 
	(37), 
	(37), 
	(37), 
	(38), 
	(38), 
	(39), 
	(40), 
	(41), 
	(41), 
	(41), 
	(42)
;

insert into correspondencia (calle, numero, piso, codigo_postal) values
	('Avenida El Viso', '12', null, 28002),
	('Calle Alcalá', '40', '2B', 28014),
	('Calle Serrano', '55', '1C', 28006),
	('Calle Fuencarral', '92', null, 28010),
	('Calle Atocha', '75', '4E', 28012),
	('Calle Goya', '18', '1B', 28001),
	('Calle Huertas', '15', null, 28012),
	('Calle Bravo Murillo', '80', '2A', 28015),
	('Calle Princesa', '3', '3B', 28008),
	('Calle Hortaleza', '30', '4C', 28004),
	('Calle Embajadores', '120', '5B', 28012)
;

insert into socio (nombre, apellidos, fecha_nacimiento, dni, telefono, id_correspondencia) values 
	('Alberto', 'Moreno Smith', '1992-09-15', '56789012P', '600567102', null),
	('Ana', 'Martínez Rubio', '1992-04-04', '45678901D', '634456789', 4),
	('Carlos', 'Rodríguez Montoya', '1990-03-03', '34567890C', '622345678', 3),
	('Carmen', 'Ortiz Méndez', '1988-02-22', '23456789V', '601234109', null),
	('Cristina', 'Ruiz Carvajal', '1980-12-12', '23456709L', '640234098', null),
	('David', 'Díaz Vivar', '1974-09-09', '98123456I', '612901234', 9),
	('Elena', 'Fernández Torrijo', '1966-10-10', '01234567J', '623012345', 10),
	('Hugo', 'Ortega López', '1972-05-19', '90123436S', '634901106', null),
	('Isabel', 'Muñoz Tavira', '1990-08-16', '67890123P', '645678103', null),
	('Javier', 'Hernández Hernández', '1980-07-07', '78901234G', '656789012', 7),
	('Jorge', 'Iglesias Pérez', '1979-07-29', '90123456C', '667901116', null),
	('Juan', 'Pérez Castilla', '1980-01-01', '12345678A', '678123456', 1),
	('Laura', 'González Capone', '1988-06-06', '67890123F', '689678901', 6),
	('Lucas', 'Santos Bardem', '1975-05-27', '78901234A', '690789114', null),
	('Luis', 'Ferguson López', '1965-05-05', '56789012E', '609567890', 5),
	('María', 'García Márquez', '1985-02-02', '23456789B', '698234567', 2),
	('Marta', 'Sánchez de León', '2002-08-08', '89012345H', '687890123', 8),
	('Miguel', 'Torres Barrera', '1998-11-11', '12345098K', '676123098', 11),
	('Nuria', 'Delgado Salazar', '1984-04-20', '01234567T', '665012107', null),
	('Pedro', 'Herbert Montesinos', '2000-03-21', '12345678U', '654123108', null),
	('Raúl', 'Álvarez Gómez', '1998-07-17', '77901234Q', '643789104', null),
	('Rosa', 'Navarro Blanco', '1992-04-26', '67860123Z', '632678113', null),
	('Sofía', 'Jiménez Vargas', '1990-10-14', '45678901N', '621456091', null),
	('Victor', 'Rubio Chacón', '1980-01-23', '34567890W', '610345110', null)
;

insert into carnet (id_socio, serie) values 
	(1, 'A00001'),
	(2, 'A00002'),
	(3, 'A00003'),
	(4, 'A00004'),
	(5, 'A00005'),
	(6, 'A00006'),
	(7, 'A00007'),
	(8, 'A00008'),
	(9, 'A00009'),
	(10, 'A00010'),
	(11, 'A00011'),
	(12, 'A00012'),
	(13, 'A00013'),
	(14, 'A00014'),
	(15, 'A00015'),
	(16, 'A00016'),
	(17, 'A00017'),
	(18, 'A00018'),
	(19, 'A00019'),
	(20, 'A00020'),
	(21, 'A00021'),
	(22, 'A00022'),
	(23, 'A00023'),
	(24, 'A00024')
;

insert into prestamo (id_carnet, id_copia, fecha_prestamo, fecha_devolucion) values
	(2, 47, '2024-11-17', '2025-02-24'),
	(1, 21, '2025-02-18', null),
	(16, 30, '2025-01-19', null),
	(5, 24, '2025-02-20', null),
	(4, 19, '2025-02-21', null),
	(13, 70, '2025-02-22', null),
	(2, 6, '2025-02-23', '2025-03-02'),
	(1, 4, '2025-02-24', null),
	(5, 2, '2025-02-26', null),
	(4, 49, '2025-02-27', '2025-03-06'),
	(3, 11, '2025-02-28', null),
	(22, 48, '2025-03-01', '2025-03-08'),
	(1, 35, '2025-03-02', null),
	(16, 30, '2025-03-03', null),
	(5, 16, '2025-03-04', null),
	(4, 20, '2025-03-05', null),
	(3, 16, '2025-03-06', null),
	(2, 10, '2024-12-07', '2024-12-20'),
	(1, 50, '2025-03-08', null),
	(15, 51, '2025-01-02', null),
	(24, 3, '2025-01-26', null),
	(12, 49, '2025-02-07', null),
	(14, 1, '2025-02-25', null)
;

-- Queries

create view peliculas_disponibles as
	select 
		p.titulo as pelicula,
		count(cp.id) as copias_disponibles
	from pelicula p
	inner join copia_pelicula cp on p.id = cp.id_pelicula
	left join prestamo pr on cp.id = pr.id_copia and pr.fecha_devolucion is null
	where pr.id_copia is null
	group by p.titulo
	order by p.titulo
;


create view peliculas_disponibles_all as
	select
		p.titulo as pelicula, 
	    count(cp.id) - count(pr.id_copia) AS copias_disponibles,
	    count(cp.id) as copias_totales
	from pelicula p
	inner join copia_pelicula cp on p.id = cp.id_pelicula
	left join prestamo pr on cp.id = pr.id_copia and pr.fecha_devolucion is null
	group by p.titulo
	order by p.titulo
;

select * from peliculas_disponibles_all;

select * from peliculas_disponibles;

