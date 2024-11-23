extends Control

const LAMINAS_POR_PAGINA = 6
const NUM_PAGINAS = 6
const COOLDOWN_TIME = 15  # 60 segundos = 1 minuto
var pagina_actual = 0
var laminas_totales = LAMINAS_POR_PAGINA * NUM_PAGINAS
var laminas_obtenidas = []
var animando = false
var indicador_pagina: Label
var flecha_izquierda
var flecha_derecha
var tiempo_restante = 0
var boton_obtener: Button
var boton_guardar: Button
var timer_label: Label
var contador_epico = 0
var contador_legendario = 0

# Diccionario para guardar el estado de cada lámina
var estado_laminas = {}

var total_probabilidad = 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.6 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.01 + 0.01 + 0.01 + 0.01 + 0.01  # Suma total de las probabilidades
var gatos_disponibles = [
	{"imagen": "res://images/gatos/comun1.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun2.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun3.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun4.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun5.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun6.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun7.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun8.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun9.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun10.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun11.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun12.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun13.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun14.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun15.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun16.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun17.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun18.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun19.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun20.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun21.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun22.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun23.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun24.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/comun25.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
	{"imagen": "res://images/gatos/epico1.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad},
	{"imagen": "res://images/gatos/epico2.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad},
	{"imagen": "res://images/gatos/epico3.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad},
	{"imagen": "res://images/gatos/epico4.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad},
	{"imagen": "res://images/gatos/epico5.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad},
	{"imagen": "res://images/gatos/epico6.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad},
	{"imagen": "res://images/gatos/epico7.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad},
	{"imagen": "res://images/gatos/epico8.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad},
	{"imagen": "res://images/gatos/epico9.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad},
	{"imagen": "res://images/gatos/epico10.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad},
	{"imagen": "res://images/gatos/legendario1.png", "rareza": "LEGENDARIO", "probabilidad": 0.01 / total_probabilidad},
	{"imagen": "res://images/gatos/legendario2.png", "rareza": "LEGENDARIO", "probabilidad": 0.01 / total_probabilidad},
	{"imagen": "res://images/gatos/legendario3.png", "rareza": "LEGENDARIO", "probabilidad": 0.01 / total_probabilidad},
	{"imagen": "res://images/gatos/legendario4.png", "rareza": "LEGENDARIO", "probabilidad": 0.01 / total_probabilidad},
	{"imagen": "res://images/gatos/legendario5.png", "rareza": "LEGENDARIO", "probabilidad": 0.01 / total_probabilidad}
]


func _ready():
	cargar_progreso()
	_crear_paginas()
	_crear_flechas_navegacion()
	_crear_boton_obtener_lamina()
	_crear_indicador_pagina()
	_crear_timer_label()
	_actualizar_visibilidad_pagina()
	_centrar_paginas()
	_centrar_indicador_pagina()
	_centrar_flechas()
	_inicializar_estado_laminas()
	#cargar_progreso()
func _centrar_paginas():
	var paginas_node = get_node("CenterContainer/Paginas")
	var ventana_size = get_viewport().size
	var ancho_paginas = (150 * 3) + 200  # Ajustar el ancho de la página
	var alto_paginas = (150 * 2) + 200   # Ajustar el alto de la página
	paginas_node.position.x = (ventana_size.x - ancho_paginas) / 2
	paginas_node.position.y = (ventana_size.y - alto_paginas) / 2

func _centrar_indicador_pagina():
	var ventana_size = get_viewport().size
	var size_label = indicador_pagina.get_minimum_size() 
	indicador_pagina.position.x = (ventana_size.x - size_label.x) / 2
	indicador_pagina.position.y = 50

func _centrar_flechas():
	var ventana_size = get_viewport().size
	var paginas_node = get_node("CenterContainer/Paginas")
	var ancho_paginas = (110 * 3) + 100
	
	flecha_izquierda.position.x = paginas_node.position.x - 100
	flecha_izquierda.position.y = paginas_node.position.y + 180
	
	flecha_derecha.position.x = paginas_node.position.x + ancho_paginas + 120
	flecha_derecha.position.y = paginas_node.position.y + 180

func _crear_paginas():
	# Crear el CenterContainer primero
	var center_container = CenterContainer.new()
	center_container.name = "CenterContainer"
	add_child(center_container)

	# Crear el nodo Paginas y añadirlo al CenterContainer
	var paginas = Node2D.new()
	paginas.name = "Paginas"
	center_container.add_child(paginas)

	# Crear las páginas individuales
	for i in range(NUM_PAGINAS):
		var pagina = Node2D.new()
		pagina.name = "Pagina" + str(i)
		pagina.visible = false
		paginas.add_child(pagina)

		for j in range(LAMINAS_POR_PAGINA):
			var lamina_id = i * LAMINAS_POR_PAGINA + j + 1
			var espacio = Node2D.new()
			espacio.position = Vector2((j % 3) * 150 + 150, (j / 3) * 150 + 150)  # Más espacio entre las láminas
			espacio.name = "Lamina" + str(lamina_id)
			pagina.add_child(espacio)

			# Crear borde manual usando ColorRects
			var borde = Node2D.new()

			# Bordes superiores e inferiores
			var borde_superior = ColorRect.new()
			borde_superior.color = Color.BLACK
			borde_superior.size = Vector2(140, 2)  # Ajustar el tamaño
			borde_superior.position = Vector2(-70, -70)
			borde.add_child(borde_superior)

			var borde_inferior = ColorRect.new()
			borde_inferior.color = Color.BLACK
			borde_inferior.size = Vector2(140, 2)
			borde_inferior.position = Vector2(-70, 68)
			borde.add_child(borde_inferior)

			# Bordes laterales
			var borde_izquierdo = ColorRect.new()
			borde_izquierdo.color = Color.BLACK
			borde_izquierdo.size = Vector2(2, 140)
			borde_izquierdo.position = Vector2(-70, -70)
			borde.add_child(borde_izquierdo)

			var borde_derecho = ColorRect.new()
			borde_derecho.color = Color.BLACK
			borde_derecho.size = Vector2(2, 140)
			borde_derecho.position = Vector2(68, -70)
			borde.add_child(borde_derecho)

			espacio.add_child(borde)

			# Crear número casi transparente
			var numero = Label.new()
			numero.text = str(lamina_id)
			numero.add_theme_font_size_override("font_size", 50)  # Tamaño del texto
			numero.modulate = Color(0.5, 0.5, 0.5, 0.2)
			numero.position = Vector2(-35, -35)
			espacio.add_child(numero)

func _crear_timer_label():
	timer_label = Label.new()
	timer_label.position = Vector2(350, 520)
	timer_label.add_theme_font_size_override("font_size", 16)
	add_child(timer_label)
	timer_label.hide()

func _crear_boton_obtener_lamina():
	boton_obtener = Button.new()
	boton_obtener.name = "ObtenerLamina"
	boton_obtener.text = "Obtener lámina"
	boton_obtener.custom_minimum_size = Vector2(300,100)
	boton_obtener.position = Vector2(get_viewport().size.x / 2 - 150, get_viewport().size.y - 280)
	boton_obtener.connect("pressed", Callable(self, "_obtener_lamina"))
	add_child(boton_obtener)
	boton_guardar = Button.new()
	boton_guardar.name = "Guardar"
	boton_guardar.text = "Guardar"
	boton_guardar.custom_minimum_size = Vector2(300,100)
	boton_guardar.position = Vector2(get_viewport().size.x / 2 - 150, get_viewport().size.y - 160)
	boton_guardar.connect("pressed", Callable(self, "guardar_progreso"))
	add_child(boton_guardar)

func _process(delta):
	if tiempo_restante > 0:
		tiempo_restante -= delta
		_actualizar_timer_label()
		if tiempo_restante <= 0:
			_resetear_cooldown()

func _actualizar_timer_label():
	var segundos = ceil(tiempo_restante)
	timer_label.text = "Espera %d segundos" % segundos
	timer_label.add_theme_font_size_override("font_size", 32)
	timer_label.position = Vector2(get_viewport().size.x / 2 - 140, get_viewport().size.y - 380)
	timer_label.show()

func _resetear_cooldown():
	tiempo_restante = 0
	timer_label.hide()
	boton_obtener.disabled = false

func _inicializar_estado_laminas():
	# Cargar estado guardado o inicializar
	for i in range(1, laminas_totales + 1):
		estado_laminas[i] = {
			"ocupada": false,
			"gato": null
		}

func _obtener_lamina():
	# Encontrar espacios libres
	var espacios_libres = []
	for id in estado_laminas:
		if not estado_laminas[id]["ocupada"]:
			espacios_libres.append(id)

	if espacios_libres.is_empty():
		print("¡Álbum completado!")
		return

	# Seleccionar un espacio libre al azar
	var lamina_id = espacios_libres[randi() % espacios_libres.size()]

	# Seleccionar gato según probabilidades
	var gato_seleccionado = _seleccionar_gato()

	# Verificar si el gato ya está en el álbum
	var gato_repetido = false
	for id in estado_laminas:
		if estado_laminas[id]["ocupada"] and estado_laminas[id]["gato"]["imagen"] == gato_seleccionado["imagen"]:
			gato_repetido = true
			break

	# Iniciar cooldown en ambos casos (gato nuevo o repetido)
	tiempo_restante = COOLDOWN_TIME
	boton_obtener.disabled = true

	# Si es un gato repetido, mostrar alerta sin añadirlo
	if gato_repetido:
		_mostrar_alerta_repetido(gato_seleccionado)
		return

	# Colocar gato en la lámina si no es repetido
	estado_laminas[lamina_id]["ocupada"] = true
	estado_laminas[lamina_id]["gato"] = gato_seleccionado

	# Crear visualización de la lámina
	var pagina = (lamina_id - 1) / LAMINAS_POR_PAGINA
	var espacio = get_node("CenterContainer/Paginas/Pagina%d/Lamina%d" % [pagina, lamina_id])

	var lamina = TextureRect.new()
	lamina.texture = load(gato_seleccionado["imagen"])
	lamina.expand_mode = TextureRect.SIZE_EXPAND_FILL
	lamina.custom_minimum_size = Vector2(140, 140)
	lamina.size = Vector2(140, 140)
	lamina.position = Vector2(-70, -70)
	lamina.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	# Añadir etiqueta de rareza
	var label_rareza = Label.new()
	label_rareza.text = gato_seleccionado["rareza"]
	label_rareza.add_theme_font_size_override("font_size", 12)
	label_rareza.position = Vector2(-45, 50)

	espacio.add_child(lamina)

	print("Obtuviste un gato %s en la lámina %d" % [gato_seleccionado["rareza"], lamina_id])
	


func _mostrar_alerta_repetido(gato):
	# Crear una ventana emergente o label de alerta
	var alerta = AcceptDialog.new()
	alerta.dialog_text = "¡Ya tienes este gato %s! Intenta de nuevo." % gato["rareza"]
	add_child(alerta)
	alerta.popup_centered()

	print("Gato repetido: %s" % gato["rareza"])
	
func _seleccionar_gato():
	# Lógica de pity para épicos (hard pity)
	if contador_epico >= 10:
		contador_epico = 0
		return _encontrar_gato_por_rareza("EPICO")

	# Lógica de pity para legendarios (hard pity)
	if contador_legendario >= 40:
		contador_legendario = 0
		return _encontrar_gato_por_rareza("LEGENDARIO")

	# Sistema de soft pity
	var probabilidad = randf()  # Genera un número aleatorio entre 0.0 y 1.0
	var acumulado = 0.0  # Para acumular las probabilidades
	var soft_pity_multiplier = 1.0  # Factor de incremento de probabilidad para soft pity

	# Aumentamos las probabilidades de gatos épicos y legendarios si estamos cerca del soft pity
	if contador_epico > 2:
		soft_pity_multiplier = 1.5  # Aumentamos la probabilidad para épicos
	if contador_legendario > 10:
		soft_pity_multiplier = 2.0  # Aumentamos la probabilidad para legendarios

	# Recalculamos las probabilidades de cada gato con el multiplicador de soft pity
	var gatos_disponibles_modificados = [
		{"imagen": "res://images/gatos/comun1.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun2.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun3.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun4.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun5.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun6.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun7.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun8.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun9.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun10.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun11.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun12.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun13.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun14.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun15.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun16.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun17.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun18.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun19.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun20.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun21.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun22.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun23.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun24.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/comun25.png", "rareza": "COMUN", "probabilidad": 0.6 / total_probabilidad},
		{"imagen": "res://images/gatos/epico1.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/epico2.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/epico3.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/epico4.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/epico5.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/epico6.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/epico7.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/epico8.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/epico9.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/epico10.png", "rareza": "EPICO", "probabilidad": 0.1 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/legendario1.png", "rareza": "LEGENDARIO", "probabilidad": 0.01 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/legendario2.png", "rareza": "LEGENDARIO", "probabilidad": 0.01 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/legendario3.png", "rareza": "LEGENDARIO", "probabilidad": 0.01 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/legendario4.png", "rareza": "LEGENDARIO", "probabilidad": 0.01 / total_probabilidad*soft_pity_multiplier},
		{"imagen": "res://images/gatos/legendario5.png", "rareza": "LEGENDARIO", "probabilidad": 0.01 / total_probabilidad*soft_pity_multiplier}
	]

	# Ahora seleccionamos el gato de acuerdo con las probabilidades actualizadas
	for gato in gatos_disponibles_modificados:
		acumulado += gato["probabilidad"]  # Sumamos la probabilidad de cada gato
		if probabilidad <= acumulado:  # Si el número aleatorio cae en este rango, seleccionamos este gato
			# Incrementar contadores solo si no es un gato épico o legendario
			if gato["rareza"] == "COMUN" or gato["rareza"] == "RARO":
				contador_epico += 1  # Incrementar el contador de pity para épicos
				contador_legendario += 1  # Incrementar el contador de pity para legendarios

			return gato  # Retornar el gato seleccionado

	# Caso por defecto, aunque nunca debería llegar aquí si las probabilidades están bien
	return gatos_disponibles_modificados[-1]


func _encontrar_gato_por_rareza(rareza_buscada):
	var gatos_de_rareza = []
	for gato in gatos_disponibles:
		if gato["rareza"] == rareza_buscada:
			gatos_de_rareza.append(gato)

	# Si hay gatos de esa rareza, devolver uno al azar
	if not gatos_de_rareza.is_empty():
		return gatos_de_rareza[randi() % gatos_de_rareza.size()]

	# Si no hay, devolver un gato por defecto
	return gatos_disponibles[0]
	
	
func _crear_flechas_navegacion():
	flecha_izquierda = TextureButton.new()
	flecha_izquierda.texture_normal = load("res://images/flechai.png")
	flecha_izquierda.custom_minimum_size = Vector2(100, 100)  # Tamaño más grande
	flecha_izquierda.position = Vector2(50, (get_viewport().size.y / 2 ) - 1000)
	flecha_izquierda.connect("pressed", Callable(self, "_pagina_anterior"))
	add_child(flecha_izquierda)
	
	flecha_derecha = TextureButton.new()
	flecha_derecha.texture_normal = load("res://images/flecha.png")
	flecha_derecha.custom_minimum_size = Vector2(100, 100)  # Tamaño más grande
	flecha_derecha.position = Vector2(900, get_viewport().size.y / 2 - 50)
	flecha_derecha.connect("pressed", Callable(self, "_pagina_siguiente"))
	add_child(flecha_derecha)

func _crear_indicador_pagina():
	indicador_pagina = Label.new()
	indicador_pagina.position = Vector2(250, 50)
	indicador_pagina.add_theme_font_size_override("font_size", 40)
	add_child(indicador_pagina)
	_actualizar_indicador_pagina()

func _actualizar_indicador_pagina():
	indicador_pagina.text = "Página %d de %d" % [pagina_actual + 1, NUM_PAGINAS]

func _pagina_anterior():
	if pagina_actual > 0 and not animando:
		_animar_cambio_pagina(pagina_actual - 1)

func _pagina_siguiente():
	if pagina_actual < NUM_PAGINAS - 1 and not animando:
		_animar_cambio_pagina(pagina_actual + 1)

func _animar_cambio_pagina(nueva_pagina):
	animando = true
	var pagina_actual_node = get_node("CenterContainer/Paginas/Pagina" + str(pagina_actual))
	var pagina_nueva_node = get_node("CenterContainer/Paginas/Pagina" + str(nueva_pagina))
	
	pagina_nueva_node.modulate = Color(1, 1, 1, 0)
	pagina_nueva_node.visible = true
	
	var tween = create_tween()
	tween.tween_property(pagina_actual_node, "modulate", Color(1, 1, 1, 0), 0.5)
	tween.parallel().tween_property(pagina_nueva_node, "modulate", Color(1, 1, 1, 1), 0.5)
	tween.tween_callback(Callable(self, "_finalizar_animacion").bind(nueva_pagina))

func _finalizar_animacion(nueva_pagina):
	get_node("CenterContainer/Paginas/Pagina" + str(pagina_actual)).visible = false
	pagina_actual = nueva_pagina
	_actualizar_indicador_pagina()
	animando = false

func _actualizar_visibilidad_pagina():
	for i in range(NUM_PAGINAS):
		get_node("CenterContainer/Paginas/Pagina" + str(i)).visible = (i == pagina_actual)
	_actualizar_indicador_pagina()



func guardar_progreso():
	var save_file = ConfigFile.new()
	save_file.set_value("Progreso", "estado_laminas", estado_laminas)
	save_file.set_value("Progreso", "pagina_actual", pagina_actual)
	save_file.set_value("Progreso", "contador_epico", contador_epico)
	save_file.set_value("Progreso", "contador_legendario", contador_legendario)
	save_file.set_value("Temporizador", "tiempo_restante", tiempo_restante)

	var file_path = "user://save_game.cfg"
	var err = save_file.save(file_path)
	if err == OK:
		print("Progreso guardado correctamente en:", file_path)
	else:
		print("Error al guardar progreso:", err)
		
		
func cargar_progreso():
	var save_file = ConfigFile.new()
	if save_file.load("user://save_game.cfg") == OK:
		estado_laminas = save_file.get_value("Progreso", "estado_laminas", {})
		pagina_actual = save_file.get_value("Progreso", "pagina_actual", 0)
		contador_epico = save_file.get_value("Progreso", "contador_epico", 0)
		contador_legendario = save_file.get_value("Progreso", "contador_legendario", 0)
		tiempo_restante = save_file.get_value("Temporizador", "tiempo_restante", 0)
		print("Progreso cargado correctamente.")
	else:
		print("No se encontró un archivo de guardado, iniciando progreso desde cero.")
		estado_laminas = {}
		pagina_actual = 0
		contador_epico = 0
		contador_legendario = 0
		tiempo_restante = 0


# Usar _notification para escuchar el cierre del juego
func _notification(what):
	if what == NOTIFICATION_APPLICATION_PAUSED:
		guardar_progreso()  # Guardar progreso antes de cerrar el juego

func _exit_tree():
	guardar_progreso()
