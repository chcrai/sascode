/* datagridupload.sas */

proc datasets library=vidgloc nolist;
repair transactionsgrid;
run;



LIBNAME vidg postgres server="esp.eahub.sashq-d.openstack.sas.com" 
	PRESERVE_TAB_NAMES=YES schema=datagrid DATABASE=postgres port=55436 
	USER=postgres password=password;

LIBNAME datagrid postgres server="pdcesx14046.exnet.sas.com" port=5432
  schema=datagrid
  DATABASE=postgres
  USER=dbmsowner
  conopts="sslmode=required"
  password=Go4thsas;

LIBNAME bnicrc postgres server="pdcesx14046.exnet.sas.com" port=5432
  schema=bni
  DATABASE=postgres
  USER=dbmsowner
  conopts="sslmode=required"
  password=Go4thsas;


libname vidgloc 'C:\z_DATA_AND_TECHNICAL\Technical\EIaT\Datagrids';

data vidgloc.DGTrans;
length transactions $9000;
format transactions $9000.;
set datagrid.transactionsgrid_new(obs=2);
run;

/*
%macro load(fname);
proc sql;
create table pdc.&fname (bulkload=YES bl_psql_path='C:\Program Files\SASHome\SASODBCDriversfortheWebInfrastructurePlatformDataServer\9.4\Driver\psql.exe') 
        as select * from vidgloc.&fname;
quit;
%mend load;
%load(transactionsgrid1000);
*/
