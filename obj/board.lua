--BOARD OBJECT

Board = {}
--PRIVATE:
    local width = 10;
    local height = 18;
    local cellSize = 20;
    local bgColor = { 36/255, 92/255, 117/255, 100/100 };
    local padding = 0;
    local rounding = 0;
    local offsetX = 0;
    local offsetY = 0;
    local field;

    local colors = {
        [' '] = bgColor,
        i = {120/255, 194/255, 240/255, 100/100},
        j = {237/255, 232/255, 107/255, 100/100},
        l = {125/255, 217/255, 194/255, 100/100},
        o = {235/255, 176/255, 120/255, 100/100},
        s = {212/255, 138/255, 237/255, 100/100},
        t = {247/255, 148/255, 196/255, 100/100},
        z = {168/255, 212/255, 117/255, 100/100},
        preview = bgColor
    }

--PUBLIC:
    function Board.init(in_width, in_height, in_cellSize, in_padding, in_rounding, in_offsetX, in_offsetY, in_cellColor)
        width = in_width or width;
        height = in_height or height;
        cellSize = in_cellSize or cellSize;
        padding = in_padding or padding;
        rounding = in_rounding or rounding;
        offsetX = in_offsetX or offsetX;
        offsetY = in_offsetY or offsetY;
        bgColor = in_cellColor or bgColor;

        --Generate empty field
        field = {}
        for y = 1, height do
            field[y] = {}
            for x = 1, width do
                field[y][x] = ' ';
            end
        end
        return field;
    end

    function Board.draw( in_field )
        for y = 1, height do
            for x = 1, width do
                love.graphics.setColor(colors[in_field[y][x]]);
                love.graphics.rectangle('fill', offsetX + ((x - 1) * cellSize), offsetY + ((y - 1)  * cellSize), cellSize - padding, cellSize - padding, rounding, rounding);
            end
        end
    end

    function Board.getVars()
        local o = {
            offsetX = offsetX,
            offsetY = offsetY,
            colors = colors,
            blockSize = cellSize,
            blockDrawSize = cellSize - padding,
            rounding = rounding,
            width = width,
            height = height,
            field = field;
        };
        return o;
    end

    function Board.addToInert(piece, tileset)
        for y = 1, 4 do
            for x = 1, 4 do
                local block = tileset[piece.type][piece.rotation][y][x];
                if block ~= ' ' then
                    field[piece.y + y][piece.x + x] = block;
                end
            end
        end
    end

    function Board.checkComplete()
        local completeRows = 0;
        for y = 1, height do
            local complete = true;
            for x = 1, width do
                if field[y][x] == ' ' then
                    complete = false;
                    break;
                end
            end
            if complete then
                completeRows = completeRows + 1;
                for removeY = y, 2, -1 do
                    for removeX = 1, width do
                        field[removeY][removeX] = field[removeY - 1][removeX];
                    end
                end
                for removeX = 1, width do
                    field[1][removeX] = ' ';
                end
            end
        end
        return completeRows;
    end

return Board;