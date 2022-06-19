drop trigger actualizar_num_matricula;
 drop table estudiante;
 drop table matricula;
 

--PRIMER PASO----
CREATE TABLE ESTUDIANTE(
    idestudiante int primary key,
    nombre varchar(40),
    fechaingreso date,
    repeticiones int
);

CREATE TABLE MATRICULA(
    idmatricula int primary key,
    fechaingreso date,
    nivel int,
    idestudiante int
);
/*DESPUES DE INSERTAR EN MATRICULA UN ESTUDIANTE MEDIANTE SU FK , EN LA TABLA ESTUDIANTE DEBE REFLEJARSE EL CAMBIO EN EL CAMPO REPETICIONES 
ESE EVENTO , SI SE INSERTAR UNA NUEVA MATRICULA EN REPETICIONES AUMENTA A +1 Y SI SE ELIMINA SU MATRICULA EL CAMPO DISMINIYE EN -1. ESTE TRIGGER SOLO PUEDE
EXISTIR EN EL EVENTO AFTER*/
----Foreign key-----
alter table matricula add constraint fk_estudiante foreign key(idestudiante) references matricula(idmatricula);


 ---SEGUNDO PASO CREAR TRIGGER---------
 ----Trigger----------
 create or replace trigger actualizar_num_matricula
 before insert or delete on matricula
 for each row
 declare
 begin
  if INSERTING THEN 
  update estudiante
  set repeticiones  = repeticiones + 1 
  where idestudiante = :new.idestudiante ; ---USAMOS NEW PORQUE EN EL INSERT RECIEN SE CREARA UN DATO----
  ELSIF DELETING THEN 
  update estudiante
  set repeticiones =repeticiones -1
  where idestudiante = :old.idestudiante; ---USAMOS OLD PORQUE EN LA OPCION DELETE EXISTE YA UN DATO----
  end if;
 end;
 
---FIN DEL SEGUNDO PASO CREAR TRIGGER---------


 --- TERCER PASO ----
----Datos insertados-----
insert into ESTUDIANTE values(1,'robert','1-may-22', -1);
insert into ESTUDIANTE values(2,'dennis','26-may-22', -1);
 --- FIN DEL TERCER PASO ----

--CUARTO PASO: VERIFICAMOS QUE EL ESTUDIANTE ESTA ACTUALIZANDO EL CAMPO REPETICION MATRICULA-----
select * from estudiante
---FIN DE CUARTO PASO----


---INICIO DE QUINTO  PASO---
insert into MATRICULA values(1,'15-may-22',1,1);
insert into MATRICULA values(2,'20-may-22',1,1);
insert into MATRICULA values(3,'30-may-22',1,1);
insert into MATRICULA values(4,'30-may-22',1,2);
---FIN  DE QUINTO  PASO---


--SEXTO PASO: VERIFICACION DEL TRIGGER-----
select * from estudiante
--FIN SEXTO PASO-----



----SEPTIMO PASO: VERIFICAMOS DEL TRIGGER AL ELIMINAR-----
--PARA QUITAR UNA REPETICION------
delete from matricula where idmatricula=3
----FIN DEL SEPTIMO PASO-----



---OPCIONAL-----
----INNER JOIN ENTRE LAS DOS TABLAS---------
select *
from ESTUDIANTE 
inner join MATRICULA on ESTUDIANTE.idestudiante = MATRICULA.idestudiante
  
---SI LO PUEDES IMAGINAR , LO PUEEDS PROGRAMAR :D PD.PROGRAMACION ATS ----
 
