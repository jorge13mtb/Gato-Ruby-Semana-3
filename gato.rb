		
				# Lógica del Juego de Gato - Ruby
				# Jorge Chavarría Rodríguez

# Constantes del Juego de Gato
JUGADOR_X = 1
JUGADOR_0 = 2
CASILLA_VACIA = 0
CASILLA_CON_VALOR_X = 3
CASILLA_CON_VALOR_0 = 5
CONSTANTE_GANADOR_JUGADOR_1 = 9
CONSTANTE_GANADOR_JUGADOR_2 = 15
CANTIDAD_MAXIMA_DE_FICHAS_EN_JUEGO = 9

class Gato
	attr_accessor :tablero
	attr_accessor :jugador_actual

	# Contructor, crea una matriz de 3x3 de ceros
	def initialize	
            @tablero = [[0,0,0],[0,0,0],[0,0,0]] 
	    @jugador_actual = JUGADOR_X            
	end


	# Colocar una ficha el tablero
        def colocar_ficha_en_el_tablero(fila, columna) 
	    if @tablero[fila][columna] == CASILLA_VACIA and @jugador_actual == JUGADOR_X
	        @tablero[fila][columna] = CASILLA_CON_VALOR_X
		@jugador_actual = JUGADOR_0 
	    
	    elsif @tablero[fila][columna] == CASILLA_VACIA and @jugador_actual == JUGADOR_0
                @tablero[fila][columna] = CASILLA_CON_VALOR_0
                @jugador_actual = JUGADOR_X
 	    end
	end 


	# Valida si alguien gana
	def hay_un_ganador?
	    hay_ganador_en_filas? || hay_ganador_en_columnas? || hay_ganador_en_diagonal1? || hay_ganador_en_diagonal2?          
	end


	# Validar si alguien gana en una filas
	def hay_ganador_en_filas?
	    valor_total_fila_actual = 0	    
	    for fila_actual in (0..2)
	        valor_total_fila_actual = @tablero[fila_actual][0] + @tablero[fila_actual][1] + @tablero[fila_actual][2] 
		return true if hay_ganador_en_linea?(valor_total_fila_actual)
	    end
	    false
	end


	# Validar Si alguien gana en una columna
	def hay_ganador_en_columnas?
	    valor_total_columna_actual = 0
   	    for columna_actual in (0..2)
		valor_total_columna_actual = @tablero[0][columna_actual] + @tablero[1][columna_actual] + @tablero[2][columna_actual]
		return true if hay_ganador_en_linea?(valor_total_columna_actual)
	    end
	    false
	end


	# Validar si alguien gana en la diagonal 1
	def hay_ganador_en_diagonal1?
	    valor_total_diagonal1 = @tablero[0][0] + @tablero[1][1] + @tablero[2][2]
	    hay_ganador_en_linea?(valor_total_diagonal1)
	end

	
	# Validar si alguien gana en la diagonal 2
	def hay_ganador_en_diagonal2?
	    valor_total_diagonal2 = @tablero[0][2] + @tablero[1][1] + @tablero[2][0]
	    hay_ganador_en_linea?(valor_total_diagonal2)
	end

	
	# Validad si un jugador ha puesto tres fichas seguidas en una linea 
	def hay_ganador_en_linea?(valor_total_linea)
	    valor_total_linea == CONSTANTE_GANADOR_JUGADOR_1 || valor_total_linea == CONSTANTE_GANADOR_JUGADOR_2
	end


	# Verifica si el tablero esta lleno de fichas
	def esta_lleno_el_tablero?
	    total_de_fichas_en_juego = 0
	    for fila_actual in (0..2)
		for columna_actual in (0..2)
		    if @tablero[fila_actual][columna_actual] != 0
		        total_de_fichas_en_juego += 1
		    end
		end
	    end
	    total_de_fichas_en_juego == CANTIDAD_MAXIMA_DE_FICHAS_EN_JUEGO
	end


	# Pone el tablero como al inicio del juego, todos los valores en 0
	def vaciar_tablero
	    for fila_actual in (0..2)
		for columna_actual in (0..2)
		    @tablero[fila_actual][columna_actual] = 0
		end
	    end
	end
end
