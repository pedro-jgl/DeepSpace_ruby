module DeepSpace
    class BetaPowerEfficientSpaceStation < PowerEfficientStation
        @@EXTRAEFFICIENCY=1.2
        def initialize(station)
            super
            @dice = Dice.new
        end
    
        def fire
            if dice.extraEfficiency
                return super*@@EXTRAEFFICIENCY
            end
            
            return super
        end

        def to_s
            return "BETA " + super
        end
    end
end