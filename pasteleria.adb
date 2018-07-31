with Auxiliar;
use Auxiliar;

procedure pasteleria is

    -- TASK ASISTENTE
    task asistente is
        entry solicitarBatidoraMezcla1;
        entry devolverBatidoraMezcla1;

        entry solicitarBatidoraMezcla2;
        entry devolverBatidoraMezcla2;

        entry solicitarAmasadoraMezcla1;
        entry devolverAmasadoraMezcla1;

        entry solicitarAmasadoraMezcla2;
        entry devolverAmasadoraMezcla2;
    end asistente;

    task body asistente is
        batidoraUsada  : Boolean;
        amasadoraUsada : Boolean;
        mezcla1Usada   : Boolean;
        mezcla2Usada   : Boolean;
    begin
        batidoraUsada  := False;
        amasadoraUsada := False;
        mezcla1Usada   := False;
        mezcla2Usada   := False;
        loop
            select
                when not (batidoraUsada or mezcla1Usada) =>
                    accept solicitarBatidoraMezcla1 do
                        batidoraUsada := True;
                        mezcla1Usada  := True;
                    end solicitarBatidoraMezcla1;
            or
                when batidoraUsada and mezcla1Usada =>
                    accept devolverBatidoraMezcla1 do
                        batidoraUsada := False;
                        mezcla1Usada  := False;
                    end devolverBatidoraMezcla1;
            or
                when not (batidoraUsada or mezcla2Usada) =>
                    accept solicitarBatidoraMezcla2 do
                        batidoraUsada := True;
                        mezcla2Usada  := True;
                    end solicitarBatidoraMezcla2;
            or
                when batidoraUsada and mezcla2Usada =>
                    accept devolverBatidoraMezcla2 do
                        batidoraUsada := False;
                        mezcla2Usada  := False;
                    end devolverBatidoraMezcla2;
            or
                when not (amasadoraUsada or mezcla1Usada) =>
                    accept solicitarAmasadoraMezcla1 do
                        amasadoraUsada := True;
                        mezcla1Usada   := True;
                    end solicitarAmasadoraMezcla1;
            or
                when amasadoraUsada and mezcla1Usada =>
                    accept devolverAmasadoraMezcla1 do
                        amasadoraUsada := False;
                        mezcla1Usada   := False;
                    end devolverAmasadoraMezcla1;
            or
                when not (amasadoraUsada or mezcla2Usada) =>
                    accept solicitarAmasadoraMezcla2 do
                        amasadoraUsada := True;
                        mezcla2Usada   := True;
                    end solicitarAmasadoraMezcla2;
            or
                when amasadoraUsada and mezcla2Usada =>
                    accept devolverAmasadoraMezcla2 do
                        amasadoraUsada := False;
                        mezcla2Usada   := False;
                    end devolverAmasadoraMezcla2;
            end select;
        end loop;
    end asistente;

    -- TASK DESPACHADOR
    task despachador is
        entry cambiar(i : in Integer);
    end despachador;

    task body despachador is
    begin
        loop
            select
                accept cambiar(i : in Integer) do
                    cambiarCaja(i);
                end cambiar;
            or
                delay (900.0); -- 900 segundos son 15 minutos
                avisarSupervisor;
            end select;
        end loop;
    end despachador;

    -- TASK CAJA1
    task caja1 is
        entry tomar;
        entry dejar;
    end caja1;

    task body caja1 is
        elabs, cantCocineros : Integer;
    begin
        elabs := 0; -- contador de elaboraciones
        cantCocineros := 0;
        loop
            select
                when elabs < 6 =>
                    accept tomar do
                        elabs := elabs + 1;
                        cantCocineros := cantCocineros + 1;
                    end tomar;
            or
                accept dejar do
                    cantCocineros := cantCocineros - 1;
                    if elabs = 6 and cantCocineros = 0 then
                        despachador.cambiar(1);
                        elabs := 0;
                    end if;
                end dejar;
            end select;
        end loop;
    end caja1;

    -- TASK CAJA2
    task caja2 is
        entry tomar;
        entry dejar;
    end caja2;

    task body caja2 is
        elabs : Integer;
    begin
        elabs := 0; -- contador de elaboraciones
        loop
            select
                when elabs < 4 =>
                    accept tomar do
                        elabs := elabs + 1;
                    end tomar;
            or
                accept dejar do
                    if elabs = 4 then
                        despachador.cambiar(2);
                        elabs := 0;
                    end if;
                end dejar;
            end select;
        end loop;
    end caja2;

    -- TASK COCINERO
    task type cocinero is
        entry init(i : Integer);
    end cocinero;

    task body cocinero is
        N : Integer;
    begin
        accept init(i : Integer) do
            N:=i;
        end init;
        loop
            if N = 1 then
                asistente.solicitarBatidoraMezcla1;  -- espera a que la batidora y la mezcla 1 estén ambas disponibles
                TomarHerramienta(1, "Batidora ");
                tomarMezcla(1,1);
                elaborar(1);
                asistente.devolverBatidoraMezcla1;
                caja1.tomar;
                ponerEnCaja(1,1);
                caja1.dejar;
            elsif N = 2 then
                asistente.solicitarAmasadoraMezcla1;  -- espera a que la mezcla1 y la amasadora estén ambas disponibles
                tomarMezcla(2,1);
                TomarHerramienta(2, "Amasadora");
                elaborar(2);
                asistente.devolverAmasadoraMezcla1;
                caja1.tomar;
                ponerEnCaja(2,1);
                caja1.dejar;
            elsif N = 3 then
                asistente.solicitarAmasadoraMezcla2;  -- espera a que la amasadora y la mezcla2 estén ambas disponibles
                TomarHerramienta(3, "Amasadora");
                tomarMezcla(3,2);
                elaborar(3);
                asistente.devolverAmasadoraMezcla2;
                caja1.tomar;
                ponerEnCaja(3,1);
                caja1.dejar;
            end if;
        end loop;
    end cocinero;

    -- TASK CHEF
    task chef;
    task body chef is
        mez : Integer;
        her : String(1..9);
    begin
        loop
            seleccionChef(mez, her);  -- selecciona mezcla y herramienta del Mostrador 1

            if mez = 1 and her = "Batidora " then
                asistente.solicitarBatidoraMezcla1;
                tomarMezcla(0,1);
                TomarHerramienta(0, "Batidora ");
            elsif mez = 1 and her = "Amasadora" then
                asistente.solicitarAmasadoraMezcla1;
                tomarMezcla(0,1);
                TomarHerramienta(0, "Amasadora");
            elsif mez = 2 and her = "Batidora " then
                asistente.solicitarBatidoraMezcla2;
                tomarMezcla(0,2);
                TomarHerramienta(0, "Batidora ");
            elsif mez = 2 and her = "Amasadora" then
                asistente.solicitarAmasadoraMezcla2;
                tomarMezcla(0,2);
                TomarHerramienta(0, "Amasadora");
            end if;

            tomarMezcla(0,3); -- toma la mezcla3, no hay problema de mutuo-exlusión porque el chef es el único que la usa
            elaborar(0);

            if mez = 1 and her = "Batidora " then
                asistente.devolverBatidoraMezcla1;
            elsif mez = 1 and her = "Amasadora" then
                asistente.devolverAmasadoraMezcla1;
            elsif mez = 2 and her = "Batidora " then
                asistente.devolverBatidoraMezcla2;
            elsif mez = 2 and her = "Amasadora" then
                asistente.devolverAmasadoraMezcla2;
            end if;

            caja2.tomar;
            ponerEnCaja(0,2);
            caja2.dejar;

        end loop;
    end chef;

    cocineros : array(1..3) of cocinero;

--programa principal
begin
    for j in 1..3 loop
        cocineros(j).init(j);
    end loop;
end pasteleria;
