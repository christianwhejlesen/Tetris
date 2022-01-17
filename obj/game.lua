--GAME OBJECT

Game = {}
    local bgColor = { 36/255, 92/255, 117/255, 100/100 };

    function Game.getbgColor()
        return bgColor;
    end

    function Game.init( in_bgColor, in_lineColor)
        bgColor = in_bgColor or bgColor;
    end

return Game;