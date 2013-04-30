
				# Interfaz del Juego de Gato - Ruby
				# Jorge Chavarria Rodriguez

require_relative 'gato.rb'

@esta_jugando = false

class InterfazConsola

	def initialize     
	    @gato = Gato.new 	
	    @poscision_fila = 0                     
	    @poscision_columna = 0
         end
 
	
	# Método para inciar con el juego del gato	
	def jugar
	    dibujar_tablero_del_gato(@gato.tablero)
	    @esta_jugando = true
	    while @esta_jugando	
		identificar_siguiente_movimiento
		validar_posible_ganador
	    end
	end


	# Indentifica el siguiente moviento que quiere hacer el jugador
	def identificar_siguiente_movimiento
	    digitado_del_jugador = gets.chomp
	    if digitado_del_jugador == " "
 		@gato.colocar_ficha_en_el_tablero(@poscision_fila, @poscision_columna)
	        dibujar_tablero_del_gato(@gato.tablero)
	    elsif digitado_del_jugador == "\e[A"
     	        moverse_hacia_arriba()
	    elsif digitado_del_jugador == "\e[B"
 	        moverse_hacia_abajo()
	    elsif digitado_del_jugador == "\e[D"
		moverse_hacia_la_izquierda()
	    elsif digitado_del_jugador == "\e[C"
		moverse_hacia_la_derecha()
	    elsif digitado_del_jugador == "exit"
   	        @esta_jugando = false
	    elsif digitado_del_jugador == "s"
		dibujar_tablero_del_gato(@gato.tablero)
	    else
 	        puts "Digito una tecla invalida"		 
	    end
	end
	    	

	# Valida si existe un ganador o un empate
	def validar_posible_ganador
	    if @gato.hay_un_ganador?
		if @gato.jugador_actual == JUGADOR_0
		    ha_ganado_el_jugador_x
		else
                    ha_ganado_el_jugador_0
		end
	    elsif @gato.esta_lleno_el_tablero?
		puts "Se produjo un empate"
		mensaje_para_continuar
	    end    
	end


	def ha_ganado_el_jugador_x
     	    puts "Felicidades, gano el jugador X"
            @gato.jugador_actual = JUGADOR_X
	    mensaje_para_continuar
	end


	def ha_ganado_el_jugador_0
	    puts "Felicidades, gano el jugador 0"
	    @gato.jugador_actual = JUGADOR_0
            mensaje_para_continuar
	end


	# vacia el tablero, y muestra un mensaje de que si quiere seguir jugando
	def mensaje_para_continuar
	    @gato.vaciar_tablero
	    puts " "
	    puts "Presione s para continuar o exit para salir...."
	end


	# Se mueve una poscisión en el tablero hacia arriba
	def moverse_hacia_arriba
            if @poscision_fila != 0
		@poscision_fila -= 1
	    end
	    dibujar_tablero_del_gato(@gato.tablero)
	end


	# Se mueve una poscisión en el teblaro hacia abajo
	def moverse_hacia_abajo
	    if @poscision_fila == 2
		@poscision_fila = 0
	    else
	        @poscision_fila += 1
	    end	
	    dibujar_tablero_del_gato(@gato.tablero)
	end

	
	# Se mueve una poscisión en el tablero hacia la derecha
	def moverse_hacia_la_derecha
	    if @poscision_fila == 2 and @poscision_columna == 2
		dibujar_tablero_del_gato(@gato.tablero)
	    elsif @poscision_columna == 2
		@poscision_columna = 0
		@poscision_fila += 1
	    else
		@poscision_columna += 1
	    end
	    dibujar_tablero_del_gato(@gato.tablero)
	end


	# Se mueve una poscisión en el tablero hacia la izquierda
	def moverse_hacia_la_izquierda	
	    if @poscision_fila == 0 and @poscision_columna == 0
		dibujar_tablero_del_gato(@gato.tablero)
	    elsif @poscision_columna == 0
		@poscision_fila -= 1
		@poscision_columna = 2
	    else
	        @poscision_columna -= 1
	    end
	    dibujar_tablero_del_gato(@gato.tablero)
	end


        # Dibuja el tablero
	def dibujar_tablero_del_gato(tablero)
	    puts "Juego de Gato"
	    puts "\n"
	    for fila_actual in (0..2)
	        for columna_actual in (0..2)
		    if tablero[fila_actual][columna_actual] == CASILLA_VACIA
		        pintar_celda_del_tablero(fila_actual, columna_actual, " ")			
		    
		    elsif tablero[fila_actual][columna_actual] == CASILLA_CON_VALOR_X
			pintar_celda_del_tablero(fila_actual, columna_actual , "X")
		    
		    elsif tablero[fila_actual][columna_actual] == CASILLA_CON_VALOR_0
			pintar_celda_del_tablero(fila_actual, columna_actual, "0")
		    end
    		end	
	    puts " "
	    end	
	end


        # Pinta una celda en el tablero
	def pintar_celda_del_tablero(fila_actual, columna_actual, ficha)
             if @poscision_fila == fila_actual and @poscision_columna == columna_actual
	         print "> ["
	     else
		print "  ["
	     end
	     print ficha
	     print "]"
	end
end

JueGato = InterfazConsola.new
JueGato.jugar()
