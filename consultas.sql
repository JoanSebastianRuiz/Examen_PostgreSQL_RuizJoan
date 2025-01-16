/*1. Listar Vehículos Disponibles: Obtener una lista de todos los vehículos disponibles para la venta, incluyendo detalles como marca, modelo, y precio.*/

select placa, marca, modelo, anio, precio
from vehiculo
where idCliente is null;

/*2.Clientes con Compras Recientes: Mostrar los clientes que han realizado compras recientemente, junto con la información de los vehículos adquiridos.*/

select c.nombre, c.apellido, v.placa, v.modelo, v.anio, ve.total, ve.fecha
from cliente c
join venta ve on c.id = ve.idcliente
join vehiculo v on ve.idvehiculo = v.id;

/*3. Historial de Servicios por Vehículo: Obtener el historial completo de servicios realizados para un vehículo específico, incluyendo detalles sobre los empleados involucrados y las fechas de servicio.*/

select t.servicio, v.placa, e.nombre, e.apellido, s.fecha
from tipoServicio t
join servicio s on t.id=s.idTipoServicio
join empleado e on e.id=s.idEmpleado
join vehiculo v on v.id=s.idVehiculo
where v.placa='KLS789';

/*4. Proveedores de Piezas Utilizados: Listar los proveedores de piezas que han suministrado componentes utilizados en los servicios de mantenimiento.*/

select p.nombre
from proveedor p
join proveedorxpieza pp on p.id=pp.idproveedor
join pieza pi on pp.idPieza=pi.id
join piezaxservicio ps on pi.id=ps.idPieza
where ps.idPieza is not null;

/*5. Rendimiento del Personal de Ventas: Calcular las comisiones generadas por cada empleado del departamento de ventas en un período específico.*/

select e.nombre, e.apellido, sum(v.comision)
from venta v
join empleado e on v.idEmpleado=e.id
where v.fecha between '2024-01-01' and '2024-12-31'
group by e.nombre, e.apellido;

/*6. Servicios Realizados por un Empleado: Identificar todos los servicios de mantenimiento realizados por un empleado específico, incluyendo detalles sobre los vehículos atendidos.*/

select v.placa, v.modelo, v.anio, v.marca, s.fecha
from tipoServicio t
join servicio s on t.id=s.idTipoServicio
join empleado e on e.id=s.idEmpleado
join vehiculo v on v.id=s.idVehiculo
where t.servicio='mantenimiento' and e.documento='1078963214';

/*7. Clientes Potenciales y Vehículos de Interés: Mostrar información sobre los clientes potenciales y los vehículos de su interés, proporcionando pistas valiosas para estrategias de marketing.*/

select c.nombre, c.apellido, v.placa, v.marca, v.modelo, v.anio, i.descripcion as interes
from vehiculo v
join interesvehiculo i on v.id=i.idVehiculo
join cliente c on c.id=i.idCliente
where i.compraRealizada = false;

/*8. Empleados del Departamento de Servicio: Listar todos los empleados que pertenecen al departamento de servicio, junto con sus horarios de trabajo.*/

select e.nombre, e.apellido, h.dia, h.horaEntrada, h.horaSalida
from horario h
join empleado e on h.idEmpleado=e.id
join rol r on r.id=e.idRol
join departamento d on d.id=r.idDepartamento
where d.departamento='servicio';

/*9. Vehículos Vendidos en un Rango de Precios: Encontrar los vehículos vendidos en un rango de precios específico, proporcionando datos útiles para análisis de ventas.*/

select v.placa, v.modelo, v.anio, v.marca, v.estado, ve.total, ve.fecha
from vehiculo v
join venta ve on v.id=ve.idVehiculo
where ve.total between 90000000 and 120000000;

/*10. Clientes con Múltiples Compras: Identificar a aquellos clientes que han realizado más de una compra en el concesionario, destacando la lealtad del cliente.*/

select c.nombre, c.apellido, count(v.idCliente) as numeroCompras
from venta v
join cliente c on c.id=v.idCliente
group by c.nombre, c.apellido
order by numeroCompras desc;