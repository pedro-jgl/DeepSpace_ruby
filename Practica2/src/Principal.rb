# encoding: utf-8

require_relative 'CombatResult'
require_relative 'Damage'
require_relative 'DamageToUI'
require_relative 'Dice'
require_relative 'EnemyStarShip'
require_relative 'EnemyToUI'
require_relative 'GameCharacter'
require_relative 'GameState'
require_relative 'GameStateController'
require_relative 'GameUniverse'
require_relative 'GameUniverseToUI'
require_relative 'Hangar'
require_relative 'HangarToUI'
require_relative 'Loot' 
require_relative 'LootToUI' 
require_relative 'ShieldBooster'
require_relative 'ShieldToUI'
require_relative 'ShotResult'
require_relative 'SpaceStation' 
require_relative 'SpaceStationToUI' 
require_relative 'SuppliesPackage'
require_relative 'Weapon'
require_relative 'WeaponToUI'
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


hangar = Hangar.new(3) #4 elementos maximo
weapon1 = Weapon.new("nombre1", WeaponType::LASER , 1) #nombre, tipo, usos
weapon2 = Weapon.new("nombre2", WeaponType::MISSILE , 2) #nombre, tipo, usos
weapon3 = Weapon.new("nombre3", WeaponType::PLASMA , 3) #nombre, tipo, usos
shield1 = ShieldBooster.new("nombre", 0.5, 0)
shield2 = ShieldBooster.new("nombre", 1.5, 1)
shield3 = ShieldBooster.new("nombre", 4.44, 2)
shield4 = ShieldBooster.new("nombre", 2.2, 3)


damage1 = Damage.newNumericWeapons(3, 4)
arrayarmas = [weapon1, weapon2, weapon3]
damage2 = Damage.newSpecificWeapons([weapon1, weapon2, weapon3], 3)

naveenemiga = EnemyStarShip.new("nombre", 1, 3, lote, damage1)

#estacionespacial = SpaceStation.new()
#Prueba SpaceStation

#Prueba GameUniverse


#Prueba Hangar
puts "Hangar: ¿Tiene Espacio Libre? " + hangar.spaceAvailable
puts "Hangar: Vacio " + hangar.to_s
hangar.addWeapon(weapon1)
hangar.addWeapon(weapon2)
hangar.addShieldBooster(shield1)
hangar.addShieldBooster(shield2)
hangar.addShieldBooster(shield3)
puts "Hangar: " + hangar.to_s
hangar.addWeapon(weapon2)
puts "Hangar: " + hangar.to_s
hangar.addWeapon(weapon3)
hangar.addShieldBooster(shield4)
puts "Hangar: " + hangar.to_s
puts "Hangar: ¿Tiene Espacio Libre? " + hangar.spaceAvailable
puts "Hangar: Arma 2 eliminada: " + hangar.removeWeapon(2).to_s
puts "Hangar: Arma 0 eliminada: " + hangar.removeWeapon(0).to_s
puts "Hangar: " + hangar.to_s
puts "Hangar: Arma inexistente eliminada: " + hangar.removeWeapon(4).to_s
puts "Hangar: Escudo 4 eliminado: " + hangar.removeShieldBooster(4).to_s
puts "Hangar: " + hangar.to_s

#Prueba Damage1
puts "Damage1: ¿No Tiene Efecto? " + damage1.hasNoEffect
puts "Damage1: " + damage1.to_s
damage1.discardWeapon(weapon1)
puts "Damage1: " + damage1.to_s
#damage1.adjust(arrayarmas, [shield1, shield2])
damage1.discardShieldBooster
damage1.discardShieldBooster
damage1.discardShieldBooster
damage1.discardShieldBooster
damage1.discardShieldBooster
damage1.discardWeapon(weapon1)
damage1.discardWeapon(weapon1)
puts "Damage1: " + damage1.to_s
puts "Damage1: ¿No Tiene Efecto? " + damage1.hasNoEffect

#Prueba Damage2
puts "Damage2: ¿No Tiene Efecto? " + damage2.hasNoEffect
puts "Damage2: " + damage2.to_s
damage2.discardWeapon(weapon1)
puts "Damage2: " + damage2.to_s
puts "Damage2: ArrayArmas Posicion PLASMA: " + damage2.arrayContainsType(arrayarmas, WeaponType::PLASMA)
puts "Damage2: ArrayArmas Posicion MISSILE: " + damage2.arrayContainsType(arrayarmas, WeaponType::MISSILE)
puts "Damage2: ArrayArmas Posicion LASER: " + damage2.arrayContainsType(arrayarmas, WeaponType::LASER)
#damage2.adjust(arrayarmas, [shield1, shield2])
damage2.discardWeapon(weapon2)
damage2.discardWeapon(weapon3)
damage2.discardShieldBooster
damage2.discardShieldBooster
damage2.discardShieldBooster
puts "Damage2: " + damage2.to_s
puts "Damage2: ¿No Tiene Efecto? " + damage2.hasNoEffect

#Prueba EnemyStarShip
puts "EnemyStarShip: " + naveenemiga.to_s
puts "EnemyStarShip: Proteccion " + naveenemiga.protection
puts "EnemyStarShip: Potencia de Fuego " + naveenemiga.fire
puts "EnemyStarShip: Resultado de Disparo 1" + naveenemiga.receiveShot(1)
puts "EnemyStarShip: Resultado de Disparo 100" + naveenemiga.receiveShot(100)
puts "EnemyStarShip: " + naveenemiga.to_s



end #module
    