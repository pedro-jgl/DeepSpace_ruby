# encoding: utf-8

module Deepspace

    class SpaceCity < SpaceStation

        def initialize(base,rest)
            newCopy(base)
            @base = base
            @collaborators = rest.dup

        end


        def collaborators
            @collaborators

        end


        def fire
            f = super

            collaborators.each do |collab|
                f += collab.fire
            end

            return f 

        end


        def protection
            p = super

            collaborators.each do |collab|
                p += collab.protection
            end

            return p 
        
        end
        
        
        def setLoot(loot)
            super(loot)

            return Transformation::NOTRANSFORM
            
        end

        def getUIversion
            SpaceCityToUI.new(self)
        end
        

    end

end