# encoding: utf-8

=begin
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
=end

#Añade todos los require_relative:
Directorio = "./DeepSpace_ruby/Practica2/src/"
Dir[Directorio+"*"].each do |file|
  file = file[Directorio.size,file.size]  #Le quitamos la ruta hasta el archivo
  file = file[0,file.size-3]              #Le quitamos el tipo de archivo (.rb)

  if file != "Principal"                  #Si es Principal, no lo añadimos porque se ejecutaría dos veces
    require_relative file
  end
end

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


hangar = Hangar.new(4) #4 elementos maximo
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



arrayescudos = [shield1, shield2, shield3]

#Prueba GameUniverse


#Prueba Hangar
puts "Hangar: ¿Tiene Espacio Libre? " + hangar.spaceAvailable.to_s
puts "Hangar: Vacio " + hangar.to_s
hangar.addWeapon(weapon1)
hangar.addWeapon(weapon2)
hangar.addShieldBooster(shield1)
hangar.addShieldBooster(shield2)
hangar.addShieldBooster(shield3)  #Esto ya no lo añade, el máximo son 4 elementos (narmas + nescudos <= 4)
puts "Hangar: " + hangar.to_s
hangar.addWeapon(weapon2)
puts "Hangar: " + hangar.to_s
hangar.addWeapon(weapon3)
hangar.addShieldBooster(shield4)
puts "Hangar: " + hangar.to_s
puts "Hangar: ¿Tiene Espacio Libre? " + hangar.spaceAvailable.to_s
puts "Hangar: Arma 1 eliminada: " + hangar.removeWeapon(1).to_s 
puts "Hangar: Arma 0 eliminada: " + hangar.removeWeapon(0).to_s 
puts "Hangar: " + hangar.to_s
puts "Hangar: Arma inexistente eliminada: " + hangar.removeWeapon(4).to_s
puts "Hangar: Escudo 4 eliminado: " + hangar.removeShieldBooster(1).to_s
puts "Hangar: " + hangar.to_s

#Prueba Damage1
puts "Damage1: ¿No Tiene Efecto? " + damage1.hasNoEffect.to_s
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
puts "Damage1: ¿No Tiene Efecto? " + damage1.hasNoEffect.to_s

#Prueba Damage2
puts "Damage2: ¿No Tiene Efecto? " + damage2.hasNoEffect.to_s
puts "Damage2: " + damage2.to_s
damage2.discardWeapon(weapon1)
puts "Damage2: " + damage2.to_s
puts "Damage2: ArrayArmas Posicion PLASMA: " + damage2.arrayContainsType(arrayarmas, WeaponType::PLASMA).to_s
puts "Damage2: ArrayArmas Posicion MISSILE: " + damage2.arrayContainsType(arrayarmas, WeaponType::MISSILE).to_s
puts "Damage2: ArrayArmas Posicion LASER: " + damage2.arrayContainsType(arrayarmas, WeaponType::LASER).to_s
puts "Damage adjust: " + damage2.adjust(arrayarmas, [shield1, shield2]).to_s
damage2.discardWeapon(weapon2)
damage2.discardWeapon(weapon3)
damage2.discardShieldBooster
damage2.discardShieldBooster
damage2.discardShieldBooster
puts "Damage2: " + damage2.to_s
puts "Damage2: ¿No Tiene Efecto? " + damage2.hasNoEffect.to_s

#Prueba EnemyStarShip
puts "EnemyStarShip: " + naveenemiga.to_s
puts "EnemyStarShip: Proteccion " + naveenemiga.protection.to_s
puts "EnemyStarShip: Potencia de Fuego " + naveenemiga.fire.to_s
puts "EnemyStarShip: Resultado de Disparo 1" + naveenemiga.receiveShot(1).to_s
puts "EnemyStarShip: Resultado de Disparo 100" + naveenemiga.receiveShot(100).to_s
puts "EnemyStarShip: " + naveenemiga.to_s

arrayarmas = [weapon1, weapon2, weapon3]

#Prueba SpaceStation
estacionespacial = SpaceStation.new(1.0, 2.0, "Nombre estación", 10, 23.0, damage1, arrayarmas, arrayescudos,hangar)
puts "SpaceStation: " + estacionespacial.to_s
estacionespacial.cleanUpMountedItems
puts "SpaceStation CleanUp: " + estacionespacial.to_s
estacionespacial.discardShieldBoosterInHangar(1).to_s
puts "SpaceStation DiscardShield: " + estacionespacial.to_s
estacionespacial.discardWeaponInHangar(2)
puts "SpaceStation DiscardWeapon: " + estacionespacial.to_s
puts "SpaceStation Speed: " + estacionespacial.speed.to_s
estacionespacial.mountShieldBooster(0)
puts "SpaceStation MountShield: " + estacionespacial.to_s
estacionespacial.mountWeapon(1)
puts "SpaceStation MountWeapon: " + estacionespacial.to_s
estacionespacial.move
puts "SpaceStation Move: " + estacionespacial.to_s
estacionespacial.discardHangar
puts "SpaceStation DiscardHangar: " + estacionespacial.to_s
estacionespacial.receiveHangar(hangar)
puts "SpaceStation ReceiveHangar: " + estacionespacial.to_s
estacionespacial.receiveShieldBooster(shield2)
puts "SpaceStation ReceiveShield: " + estacionespacial.to_s
estacionespacial.receiveSupplies(paquete2)
puts "SpaceStation ReceiveSupplies: " + estacionespacial.to_s
estacionespacial.receiveWeapon(weapon2)
puts "SpaceStation ReceiveWeapon: " + estacionespacial.to_s
puts "SpaceStation PendingDamage: " + estacionespacial.to_s
puts "SpaceStation validState: " + estacionespacial.validState.to_s



=begin
/home/pedrojgl/VSCProjects/DeepSpace_ruby/Practica2/src/SpaceStation.rb:46:in `block in cleanUpMountedItems': undefined method `uses' for nil:NilClass (NoMethodError)
	from /home/pedrojgl/VSCProjects/DeepSpace_ruby/Practica2/src/SpaceStation.rb:45:in `each'
	from /home/pedrojgl/VSCProjects/DeepSpace_ruby/Practica2/src/SpaceStation.rb:45:in `cleanUpMountedItems'
	from /home/pedrojgl/VSCProjects/DeepSpace_ruby/Practica2/src/Principal.rb:148:in `<module:Deepspace>'
	from /home/pedrojgl/VSCProjects/DeepSpace_ruby/Practica2/src/Principal.rb:41:in `<main>'
=end


end #module
    
