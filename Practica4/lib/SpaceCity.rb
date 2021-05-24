# encoding: utf-8

require_relative 'SpaceStation'
require_relative 'Transformation'

module DeepSpace
    class SpaceCity < SpaceStation
        def initialize(base, rest)
            super(base)
            @base = base
            @collaborators = rest
        end
#metodo get o sin el get?¿
        def collaborators
            return @collaborators
        end

        def fire
            fuego=super

            collaborators.each do |colab|
                fuego += colab.fire
            end

            return fuego
        end
        
        def protection
            protec=super

            collaborators.each do |colab|
                protec += colab.protetion
            end

            return protec
        end

        def setLoot(loot)
            super
            return Transformation::NOTRANSFORM
        end
    end
end