function _init()
  -- jugador (canasta)
  p = {
    x = 56,
    y = 110,
    w = 18, -- un poquito mas ancha para que luzca mas
    h = 10, -- un poquito mas alta
    spd = 2
  }
  
  -- objeto que cae
  o = {
    x = flr(rnd(110)) + 9,
    y = 0,
    type = flr(rnd(3)) + 1,
    is_bad = false,
    spd = 1.5
  }
  
  -- variables del juego
  score = 0
  lives = 3
  game_over = false
  bg_color = 12 
end

function _update()
  if (game_over) return

  -- actualizar color de fondo segun el puntaje
  if score < 5 then
    bg_color = 12 -- dia (azul)
  elseif score < 10 then
    bg_color = 9  -- atardecer (naranja)
  elseif score < 15 then
    bg_color = 2  -- noche (morado)
  elseif score < 20 then
    bg_color = 3  -- bosque (verde oscuro)
  else
    bg_color = 0  -- espacio (negro)
  end

  -- controles
  if (btn(0) and p.x > 0) p.x -= p.spd
  if (btn(1) and p.x < 128 - p.w) p.x += p.spd

  -- movimiento del objeto
  o.y += o.spd

  -- colision con la canasta (ajustada al nuevo tamaño)
  if o.y + 4 >= p.y and o.y - 4 <= p.y + p.h and
     o.x + 4 >= p.x and o.x - 4 <= p.x + p.w then
    if o.is_bad then
      lives -= 1
      if (lives <= 0) game_over = true
    else
      score += 1
    end
    reset_object()
  end

  -- el objeto cae al suelo
  if o.y > 120 then
    if not o.is_bad then
      lives -= 1
      if (lives <= 0) game_over = true
    end
    reset_object()
  end
end

function reset_object()
  o.x = flr(rnd(110)) + 9
  o.y = 0
  o.is_bad = rnd(100) < 35
  o.type = flr(rnd(o.is_bad and 2 or 3)) + 1
  o.spd += 0.05
end

function draw_object(x, y, type, is_bad)
  if is_bad then
    if type == 1 then
      -- bomba
      circfill(x, y, 4, 0)
      line(x + 2, y - 2, x + 4, y - 5, 5)
      pset(x + 4, y - 5, 8)
      pset(x + 5, y - 6, 10)
    else
      -- roca con puas
      rectfill(x - 3, y - 3, x + 3, y + 3, 5)
      pset(x - 4, y, 6)
      pset(x + 4, y, 6)
      pset(x, y - 4, 6)
      pset(x, y + 4, 6)
    end
  else
    if type == 1 then
      -- manzana
      circfill(x, y, 4, 8)
      line(x, y - 3, x, y - 5, 4)
      pset(x + 1, y - 4, 11)
    elseif type == 2 then
      -- banana
      line(x - 3, y - 2, x + 3, y + 2, 10)
      line(x - 3, y - 1, x + 3, y + 3, 10)
      pset(x - 4, y - 3, 4)
      pset(x + 4, y + 4, 4)
    elseif type == 3 then
      -- cerezas
      circfill(x - 3, y + 2, 2, 8)
      circfill(x + 3, y + 2, 2, 8)
      line(x - 3, y + 1, x, y - 3, 3)
      line(x + 3, y + 1, x, y - 3, 3)
    end
  end
end

-- nueva funcion para dibujar la canasta linda y visible
function draw_basket(x, y, w, h)
  -- cuerpo principal (blanco brillante para contraste maximo)
  rectfill(x, y, x + w, y + h, 7)
  
  -- efecto de tejido (lineas grises)
  -- lineas verticales
  for i=0, w, 4 do
    line(x + i, y, x + i, y + h, 6)
  end
  -- lineas horizontales
  for i=0, h, 3 do
    line(x, y + i, x + w, y + i, 6)
  end
  
  -- borde superior reforzado
  rectfill(x - 1, y - 2, x + w + 1, y, 7)
  line(x - 1, y - 1, x + w + 1, y - 1, 6)
  
  -- asas (pequeños arcos a los lados)
  arc(x, y + 2, 2, 0.5, 0.75, 7)
  arc(x + w, y + 2, 2, 0.25, 0.5, 7)
end

-- funcion auxiliar para dibujar arcos simples
function arc(x, y, r, sa, ea, col)
  for i=sa, ea, 0.02 do
    pset(x + cos(i) * r, y + sin(i) * r, col)
  end
end

function _draw()
  cls(bg_color) 

  if game_over then
    print("game over", 46, 50, 7)
    print("puntaje final: "..score, 30, 62, 7)
    return
  end

  -- dibujar suelo
  rectfill(0, 118, 128, 128, 4)

  -- dibujar la NUEVA canasta linda y visible
  draw_basket(p.x, p.y, p.w, p.h)

  -- dibujar objeto
  draw_object(o.x, o.y, o.type, o.is_bad)

  -- interfaz
  print("puntos: "..score, 4, 4, 7)
  print("vidas: "..lives, 90, 4, 7)
end