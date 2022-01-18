--GAME OBJECT

Game = {}
    local bgColor = { 222/255, 222/255, 222/255, 100/100 };
    local timer = 0;
    local tickCount = 0.5;
    
    function Game.getbgColor()
        return bgColor;
    end

    function Game.init( in_bgColor, in_lineColor)
        bgColor = in_bgColor or bgColor;
    end

    function Game.tick( dt )
        timer = timer + dt;
        if timer >= tickCount then
            timer = 0;
        end
        return timer == 0;
    end


return Game;