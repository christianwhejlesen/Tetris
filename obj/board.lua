--BOARD OBJECT

Board = {}
--PRIVATE:
    local width = 10;
    local height = 18;
    local cellSize = 20;
    local bgColor = { 222/255, 222/255, 222/255, 100/100 };
    local padding = 0;
    local rounding = 0;

    local function getVars()
        local v = {
            width = width;
            height = height;
            cellSize = cellSize;
            padding = padding;
            rounding = rounding;
            bgColor = bgColor;
        }
        return v;
    end

--PUBLIC:
    function Board.init(in_width, in_height, in_cellSize, in_padding, in_rounding, in_cellColor)
        width = in_width or width;
        height = in_height or height;
        cellSize = in_cellSize or cellSize;
        padding = in_padding or padding;
        rounding = in_rounding or rounding;
        bgColor = in_cellColor or bgColor;
    end

    function Board.draw( posX, posY )
        local vars = getVars();
        local posX = posX or 0;
        local posY = posY or 0;
        for y = 1, vars.height do
            for x = 1, vars.width do
                love.graphics.rectangle('fill', posX + (x * vars.cellSize), posY + (y  * vars.cellSize), vars.cellSize - vars.padding, vars.cellSize - vars.padding, vars.rounding, vars.rounding);
            end
        end
    end


return Board;