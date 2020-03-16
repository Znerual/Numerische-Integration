    !  Integral.f90
    !
    !  FUNCTIONS:
    !  Integral - Entry point of console application.
    !

    !****************************************************************************
    !
    !  PROGRAM: Integral
    !
    !  PURPOSE:  Entry point for the console application.
    !
    !****************************************************************************

    program Integral

        implicit none
        
        integer error_stat, error_stat_write
        
        double precision x1, x2, delta_x, fx1, fx2, sum, c
        print*,"Integration des Quadrats der Wellenfunktion in WF.dat"
        !initialise the values
        sum = 0
        
        !Open the file
        open(unit=1, file="WF.dat", action="read",iostat=error_stat)
        !check whether it was successfull
        if (error_stat == 0) then
            read(1,*) x1, fx1
            print*, "Einlesen liefert: x:" , x1, " f(x): " , fx1
            read(1,*) x2, fx2
            delta_x = x2 - x1
            
            sum = sum + fx1**2 + 2 * fx2**2
            do 
                read(1,*, iostat=error_stat) x1, fx1
                if (error_stat == 0) then
                    sum = sum + 2* fx1**2
                    fx2 = fx1
                elseif(error_stat > 0) then
                    print*, "Fehler beim Einlesen der Daten!: " , error_stat
                elseif(error_stat < 0) then          
                    sum = sum + fx2**2
                    sum = (sum / 2d0) * delta_x 
                    print*, "Letzter Eintrag"
                    exit
                else
                    print*, "WTF?"
                end if
            end do
            print*,"Die Integration war erfolgreich und das Ergebnis lautet: ", sum
            c = 1d0/sqrt(sum)
            print*,"Normierungskonstante ", c
            close(1)
            open(unit=3, file="WF.dat", action="read", iostat=error_stat, position="rewind")
            open(unit=2, file="WF_normiert.dat", action="write",iostat=error_stat_write)
            if (error_stat == 0 .and. error_stat_write == 0) then
                print*,"Ergebnis schreiben"
                do
                    
                    if (error_stat < 0) then 
                        print*,"Alle Werte gelesen und geschrieben"
                        exit
                    else if(error_stat > 0) then
                        print*, "Fehler beim Schreiben des Ergebnisses: " , error_stat
                    end if
                    read(3,*,iostat=error_stat) x1, fx1
                    write(2,*, iostat= error_stat_write) x1, fx1/c
                end do
                close(1)
                close(2)
            else
                print*,"Fehler beim Anlegen der Datei zum Schreiben der Ergebnisse oder beim Öffnen der Datei"
            end if
        else
            print*, "Fehler beim Öffnen der Datei: ", error_stat
        end if
   

    end program Integral

