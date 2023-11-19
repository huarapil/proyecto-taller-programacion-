

---Elber Huarapil
create database proyecto1_taller
go
use proyecto1_taller

go
create table profesion(
id_profesion varchar(3)  primary key,
profesion varchar(100)
) 
go
create table cliente(
rut numeric(9) primary key,
nombre varchar(100),
apellido1 varchar(100),
apellido2 varchar(100),
fecha_nacimiento date,
sueldo_liquido numeric(10),
profesion varchar (100),

)
go
create table tipos_de_creditos(
codigo varchar(5) primary key,
nombre_credito varchar(100),
tasa_interes numeric(6,3),
edad_maxima int,
monto_minimo int,
monto_maximo int,
sueldo_minimo int
)
go
 create table creditos_solicitados (
 codigo_solicitud int   primary key,
codigo varchar(5) foreign key references   tipos_de_creditos(codigo),
 monto_solicitado int,
 años_plazo_pago numeric(4),
 )
 
 go
 create table credito_cliente(
  codigo_solicitud int  foreign key references creditos_solicitados(codigo_solicitud),
   rut numeric(9) foreign key references cliente(rut),
 )

go
 insert into profesion (profesion,id_profesion)
values ('Actuación y Teatro',1),
('Administración de Empresas e Ing. Asociadas',2),
('Administración Gastronómica',3),
('Administración Pública',4),
('Administración Pública Antropología',5),
('Administración Turística y Hotelera',6),
('Agronomía',7),
('Analista Químico',8),
('Arquitectura',9),
('Artes y Licenciatura en Artes',10),
('Bibliotecología',11),
('Biología Marina y Ecología Marina',12),
('Bioquímica',13),
('Ciencias Políticas',14),
('Comunicación Audiovisual y/o Multimedia',15),
('Construcción Civil',16),
('Contador Auditor',17),
('Derecho',18),
('Diseño',19),
('Diseño de Ambientes e Interiores',20),
('Diseño de Vestuario',21),
('Diseño Gráfico',22),
('Diseño Industrial',23),
('Enfermería',24),
('Fonoaudiología',25),
('Fotografía',26),
('Geografía',27),
('Geología',28),
('Ingeniería Agrícola',29),
('Ingeniería Civil Ambiental',30),
('Ingeniería Civil Eléctrica',31),
('Ingeniería Civil Electrónica',32),
('Ingeniería Civil en Biotecnología y/o Bioingeniería',33),
('Ingeniería Civil en Computación e Informática',34),
('Ingeniería Civil en Minas',35),
('Ingeniería Civil en Obras Civiles',36),
('Ingeniería Civil Industrial',37),
('Ingeniería Civil Mecánica',38),
('Ingeniería Civil Metalúrgica',39),
('Ingeniería Civil Química',40),
('Ingeniería Civil, plan común y licenciatura en Ciencias de la Ingeniería',41),
('Ingeniería Comercial',42),
('Ingeniería en Acuicultura y Pesca',43),
('Ingeniería en Alimentos',44),
('Ingeniería en Automatización, Instrumentación y Control',45),
('Ingeniería en Biotecnología y Bioingeniería',46),
('Ingeniería en Comercio Exterior',47),
('Ingeniería en Computación e Informática',48),
('Ingeniería en Conectividad y Redes',49),
('Ingeniería en Construcción',50),
('Ingeniería en Control de Gestión',51),
('Ingeniería en Electricidad',52),
('Ingeniería en Electrónica',53),
('Ingeniería en Finanzas',54),
('Ingeniería en Geomensura y Cartografía',55),
('Ingeniería en Gestión Pública',56),
('Ingeniería en Logística',57),
('Ingeniería en Marketing',58),
('Ingeniería en Matemática y Estadística',59),
('Ingeniería en Mecánica Automotriz',60),
('Ingeniería en Medio Ambiente',61),
('Ingeniería en Minas y Metalurgia',62),
('Ingeniería en Prevención de Riesgos',63),
('Ingeniería en Química',64),
('Ingeniería en Recursos Humanos',65),
('Ingeniería en Recursos Renovables',66),
('Ingeniería en Sonido',67),
('Ingeniería en Telecomunicaciones',68),
('Ingeniería en Transporte y Tránsito',69),
('Ingeniería Forestal',70),
('Ingeniería Industrial',71),
('Ingeniería Marina y Marítimo Portuaria',72),
('Ingeniería Mecánica',73),
('Kinesiología',74),
('Licenciatura en Letras y Literatura',75),
('Matemáticas y/o Estadísticas',76),
('Medicina',77),
('Medicina Veterinaria',78),
('Música, Canto o Danza',79),
('Nutrición y Dietética',80),
('Obstetricia y Puericultura',81),
('Odontología',82),
('Orientación Familiar y Relaciones Humanas',83),
('Pedagogía en Artes y Música',84),
('Pedagogía en Ciencias',85),
('Pedagogía en Educación Básica',86),
('Pedagogía en Educación de Párvulos',87),
('Pedagogía en Educación Diferencial',88),
('Pedagogía en Educación Física',89),
('Pedagogía en Filosofía y Religión',90),
('Pedagogía en Historia, Geografía y Ciencias Sociales',91),
('Pedagogía en Inglés',92),
('Pedagogía en Lenguaje, Comunicación y/o Castellano',93),
('Pedagogía en Matemáticas y Computación',94),
('Periodismo',95),
('Psicología',96),
('Psicopedagogía',97),
('Publicidad',98),
('Química Ambiental',99),
('Química y Farmacia',100),
('Química, Licenciado en Química',101),
('Realizador de Cine y Televisión',102),
('Relaciones Públicas',103),
('Sociología',104),
('Tecnología Médica',105),
('Terapia Ocupacional',106),
('Trabajo Social',107),
('Sin profesion o tiene oficio',108)

go 

create or alter procedure ValidarMontoCredito (@rut_cliente numeric (9),
										@monto_solicitado numeric(9),
										@Codigo_Credito varchar (5))
as
begin
  -- validar que el monto solicitasdo esté dentro del rango
  declare @monto_min numeric(9)
  declare @monto_max numeric(9)
  
  select @monto_min = monto_minimo,
		 @monto_max  = monto_maximo
  from tipos_de_creditos where codigo = @Codigo_Credito

  if(@monto_solicitado >=@monto_min AND @monto_solicitado <=@monto_max)
	  select 0 as cod_retorno, 'Monto dentro del rango' as Mensaje
  else
	  select 1 as cod_retorno, 'Error monto fuera del rango' as Mensaje
end
-------------------------------------------------------------------------------------------
--exec ValidarEdad 1,co03,1
go


create or alter procedure ValidarEdad  (@rut_cliente numeric (9),										
										@Codigo_Credito varchar (5),
										@plazo int)
as
begin
  declare @fecha_nac date
  select @fecha_nac = fecha_nacimiento
  from cliente where rut = @rut_cliente
  declare @cliente_año_nac int
  declare @edad_cliente int
  select @cliente_año_nac = year(@fecha_nac)
  select @edad_cliente = year(getdate()) - @cliente_año_nac
  declare @edad_maxima int  
  select @edad_maxima = edad_maxima
  from tipos_de_creditos where codigo = @Codigo_Credito
  if( @edad_cliente + @plazo <= @edad_maxima)
	  select 0 as cod_retorno, 'Edad valida' as Mensaje
  else
	  select 1 as cod_retorno, 'Error, no cumple edad maxima permitida' as Mensaje
end


--El sueldo del cliente debe ser mayor o igual al sueldo mínimo del tipo de crédito seleccionado. 
go

create or alter procedure comprobarsueldo (@rut_cliente numeric (9),									
										@Codigo_Credito varchar (5))
as
begin
  -- validar que el monto solicitasdo esté dentro del rango
  declare @sueldo_liquido numeric(10)
  declare @sueldo_minimo int

  select @sueldo_liquido = sueldo_liquido		
  from cliente where rut = @rut_cliente

    select  @sueldo_minimo=sueldo_minimo	
  from tipos_de_creditos where codigo = @Codigo_Credito

  if(@sueldo_liquido >= @sueldo_minimo )
	  select 0 as cod_retorno, 'El sueldo del cliente esta en el rango' as Mensaje
  else
	  select 1 as cod_retorno, 'Error sueldo fuera del rango' as Mensaje
end

