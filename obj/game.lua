--GAME OBJECT

Game = {}
    local bgColor;

    function Game.getbgColor()
        return bgColor;
    end

    function Game.init( in_bgColor, in_lineColor)
        bgColor = in_bgColor or { 36/255, 92/255, 117/255, 100/100 };
    end

return Game;