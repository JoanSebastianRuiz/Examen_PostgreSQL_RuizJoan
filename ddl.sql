--Base de datos Concesionario

create table Departamento(
	id serial primary key,
	departamento varchar(100) not null unique
);

create table Rol(
	id serial primary key,
	idDepartamento int not null,
	rol varchar(100) not null unique,
	foreign key (idDepartamento) references Departamento(id)
);

create table Empleado(
	id serial primary key,
	idRol int not null,
	documento varchar(10) not null unique,
	nombre varchar(100) not null,
	apellido varchar(100) not null,
	telefono varchar(10)[2] not null,
	email varchar(150) not null unique,
	fechaContratacion date not null,
	comision numeric(5,2) null,
	foreign key (idRol) references Rol(id)
);

create type dia_enum 
as enum ('lunes','martes','miercoles','jueves','viernes','sabado','domingo');

create table Horario(
	id serial primary key,
	idEmpleado int not null,
	dia dia_enum not null,
	horaEntrada time not null,
	horaSalida time not null,
	foreign key (idEmpleado) references Empleado(id)
);

create table Cliente(
	id serial primary key,
	documento varchar(10) not null unique,
	nombre varchar(100) not null,
	apellido varchar(100) not null,
	telefono varchar(10)[2] not null,
	email varchar(150) not null unique
);

create type estado_enum
as enum ('nuevo','usado');


create table Vehiculo(
	id serial primary key,
	idCliente int null,
	placa varchar(6) not null unique,
	marca varchar(50) not null,
	modelo varchar(50) not null,
	anio varchar(4) not null,
	precio numeric(14,2) null,
	estado estado_enum null,
	foreign key (idCliente) references Cliente(id)
);

create table InteresVehiculo(
	id serial primary key,
	idCliente int not null,
	idVehiculo int not null,
	compraRealizada boolean not null,
	descripcion text not null,
	foreign key (idCliente) references Cliente(id),
	foreign key (idVehiculo) references Vehiculo(id)
);

create table Venta(
	id serial primary key,
	idCliente int not null,
	idVehiculo int not null,
	idEmpleado int not null,
	fecha date not null,
	comision numeric(10,2) not null check (comision>0),
	total numeric(14,2) not null check (total>0),
	foreign key (idCliente) references Cliente(id),
	foreign key (idVehiculo) references Vehiculo(id),
	foreign key (idEmpleado) references Empleado(id)
);

create table TipoServicio(
	id serial primary key,
	servicio varchar(100) not null unique,
	precio numeric(10,2) not null check (precio>0)
);

create table Servicio(
	id serial primary key,
	idTipoServicio int not null,
	idVehiculo int not null,
	idEmpleado int not null,
	fecha date not null,
	total numeric(10,2) not null check (total>0),
	foreign key (idTipoServicio) references TipoServicio(id),
	foreign key (idVehiculo) references Vehiculo(id),
	foreign key (idEmpleado) references Empleado(id)
);

create table Proveedor(
	id serial primary key,
	nombre varchar(100) not null unique,
	telefono varchar(10)[2] not null,
	email varchar(150) not null unique
);

create table Pieza(
	id serial primary key,
	pieza varchar(100) not null unique,
	precio numeric(10,2) not null,
	cantidad int not null
);

create table PiezaxServicio(
	id serial primary key,
	idServicio int not null,
	idPieza int not null,
	cantidad int not null,
	foreign key (idServicio) references Servicio(id),
	foreign key (idPieza) references Pieza(id)
);

create table ProveedorxPieza(
	id serial primary key,
	idProveedor int not null,
	idPieza int not null,
	foreign key (idProveedor) references Proveedor(id),
	foreign key (idPieza) references Pieza(id)
);

create or replace function calcular_comision(idEmpleado int, idVehiculo int)
returns numeric(10,2) as $$
declare
	comision_porcentaje numeric;
	precio_vehiculo numeric;
	resultado numeric;

begin
	select comision into comision_porcentaje from empleado where id=idEmpleado;
	select precio into precio_vehiculo from vehiculo where id=idVehiculo;
	
	resultado:=precio_vehiculo*comision_porcentaje;
	return resultado;
end;
$$ language plpgsql;
