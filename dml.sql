insert into cliente
values
	(default,'1058741259','Joan','Ruiz',array['3054785996'],'joan@gmail.com'),
	(default,'1058221456','Juan','Torres',array['3054785996','3045698774'],'juan@gmail.com');

insert into vehiculo
values
	(default,null,'DES582','BMW','BMW1','2014',47000000,'usado'),
	(default,null,'TDS458','BMW','BMW4','2024',10000000,'nuevo'),
    (default,1,'KLS789','Ferrari','Ferrari1','2025',120000000,'nuevo'),
    (default,2,'DCK256','Ferrari','Ferrari2','2025',130000000,'nuevo');

insert into departamento
values
	(default, 'servicio'),
	(default, 'ventas');

insert into rol
values
	(default,2,'asesor ventas'),
	(default,1,'tecnico' );

insert into empleado
values
	(default,1,'1452638574','Raul','Gonsalez',array['3052478999'],'raul@gmail.com','2024-01-01',0.02),
	(default,2,'1078963214','Ibai','Llanos',array['3052478996'],'ibai@gmail.com','2023-01-01',null);

insert into venta
values
	(default,1,3,1,'2024-05-10',calcular_comision(1,3),120000000),
	(default,2,4,1,'2024-06-10',calcular_comision(1,4),130000000);

insert into interesvehiculo
values
	(default,1,1,false,'le gusto el modelo'),
	(default,2,2,false,'le gusto la carroceria');

insert into horario
values
	(default,2,'lunes','8:00','14:00'),
	(default,2,'martes','8:00','14:00'),
	(default,2,'miercoles','8:00','14:00');

insert into tiposervicio
values
	(default,'mantenimiento',120000),
	(default,'reparacion',100000);

insert into servicio
values
	(default,1,3,2,'2024-07-10',120000),
	(default,1,4,2,'2024-08-10',120000);