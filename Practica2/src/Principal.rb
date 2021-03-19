# encoding: utf-8

require_relative 'Loot' 
require_relative 'CombatResult'
require_relative 'Dice'
require_relative 'GameCharacter'
require_relative 'ShieldBooster'
require_relative 'ShotResult'
require_relative 'SuppliesPackage'
require_relative 'Weapon'
require_relative 'WeaponType'


#Dir["./*"].each {|file| require_relative file }

module Deepspace #Es necesario??

VECES_A_TIRAR = 100
PLAYERS = 3
SPEED = 0.25


lote = Loot.new(1,2,3,4,5)
dado1 = Dice.new
escudo2 = ShieldBooster.new("nombre", 0.5, 0)
paquete2 = SuppliesPackage.new(2.0,2.0,2.0)
arma2 = Weapon.new("Pistola", WeaponType::LASER, 1)
paquete = SuppliesPackage.newCopy(paquete2)
arma = Weapon.newCopy(arma2)
escudo = ShieldBooster.newCopy(escudo2)
dado = Dice.new()

nhangar = 0
nescudo = 0
arma_1 = 0
arma_2 = 0
empieza_pl1 = 0
empieza_pl2 = 0
tiro = 0
semueve = 0
aux = nil

puts lote.inspect
puts dado1.inspect
puts escudo2.inspect
puts escudo.inspect
puts "\n"

puts dado1.initWithNHangars
puts dado1.initWithNWeapons
puts dado1.initWithNShields
puts dado1.whoStarts(PLAYERS)
puts dado1.firstShot
puts dado1.spaceStationMoves(SPEED)

puts lote.nSupplies
puts lote.nWeapons
puts lote.nHangars
puts lote.nMedals
puts lote.nShields

puts escudo.boost
puts escudo.useIt
puts escudo.uses
puts escudo.useIt


puts paquete.ammoPower
puts paquete.fuelUnits
puts paquete.shieldPower

puts arma.inspect
puts arma.type
puts arma.useIt
puts arma.uses
puts arma.useIt
puts arma.power

for i in 0..VECES_A_TIRAR
  if dado.initWithNHangars == 1
    nhangar += 1
  end

  if dado.initWithNShields == 1
    nescudo += 1
  end

  aux = dado.initWithNWeapons

  if aux == 1
    arma_1 += 1
  elsif aux == 2
    arma_2 += 1
  end 


    
  case dado.whoStarts(PLAYERS)
  when 1
    empieza_pl1 +=1
  when 2
    empieza_pl2 +=1
  
  end

  if dado.spaceStationMoves(SPEED)
    semueve += 1
  end

  if(dado.firstShot == GameCharacter::SPACESTATION)
    tiro += 1
  end

end

puts "Número de Hangars con resultado 1: " + nhangar.to_s
puts "Número de Hangars con resultado 0: " + (VECES_A_TIRAR - nhangar).to_s
puts "Número de Shields con resultado 1: " + nescudo.to_s
puts "Número de Shields con resultado 0: " + (VECES_A_TIRAR - nescudo).to_s
puts "Número de Weapons con resultado 3: " + arma_1.to_s
puts "Número de Weapons con resultado 2: " + arma_2.to_s
puts "Número de Weapons con resultado 1: " + (VECES_A_TIRAR - arma_1 - arma_2).to_s
puts "Empieza jugador número 1: " + empieza_pl1.to_s
puts "Empieza jugador número 2: " + empieza_pl2.to_s
puts "Empieza jugador número 3: " + (VECES_A_TIRAR - empieza_pl1 - empieza_pl2).to_s
puts "Primer tiro ESTACIÓN: " + tiro.to_s
puts "Primer tiro VILLANOS: " + (VECES_A_TIRAR - tiro).to_s
puts "Número de veces que se mueve: " + semueve.to_s
puts "Número de veces que no se mueve: " + (VECES_A_TIRAR - semueve).to_s

end #module
    