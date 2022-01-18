--TILE OBJECT

Tile = {}
--PRIVATE:
local tileset;
local sequence = {};
local function drawBlock(block, x, y, board)
    local brd = board.getVars();
    local color = brd.colors[block]
    love.graphics.setColor(color)
    love.graphics.rectangle('fill', ((x - 1) * brd.blockSize) + brd.offsetX, ((y - 1) * brd.blockSize) + brd.offsetY, brd.blockDrawSize, brd.blockDrawSize, brd.rounding, brd.rounding);
end

--PUBLIC:
    function Tile.init()
        tileset = {
            {
                {
                    {' ', ' ', ' ', ' '},
                    {'i', 'i', 'i', 'i'},
                    {' ', ' ', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {' ', 'i', ' ', ' '},
                    {' ', 'i', ' ', ' '},
                    {' ', 'i', ' ', ' '},
                    {' ', 'i', ' ', ' '},
                },
            },
            {
                {
                    {' ', ' ', ' ', ' '},
                    {' ', 'o', 'o', ' '},
                    {' ', 'o', 'o', ' '},
                    {' ', ' ', ' ', ' '},
                },
            },
            {
                {
                    {' ', ' ', ' ', ' '},
                    {'j', 'j', 'j', ' '},
                    {' ', ' ', 'j', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {' ', 'j', ' ', ' '},
                    {' ', 'j', ' ', ' '},
                    {'j', 'j', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {'j', ' ', ' ', ' '},
                    {'j', 'j', 'j', ' '},
                    {' ', ' ', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {' ', 'j', 'j', ' '},
                    {' ', 'j', ' ', ' '},
                    {' ', 'j', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
            },
            {
                {
                    {' ', ' ', ' ', ' '},
                    {'l', 'l', 'l', ' '},
                    {'l', ' ', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {' ', 'l', ' ', ' '},
                    {' ', 'l', ' ', ' '},
                    {' ', 'l', 'l', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {' ', ' ', 'l', ' '},
                    {'l', 'l', 'l', ' '},
                    {' ', ' ', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {'l', 'l', ' ', ' '},
                    {' ', 'l', ' ', ' '},
                    {' ', 'l', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
            },
            {
                {
                    {' ', ' ', ' ', ' '},
                    {'t', 't', 't', ' '},
                    {' ', 't', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {' ', 't', ' ', ' '},
                    {' ', 't', 't', ' '},
                    {' ', 't', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {' ', 't', ' ', ' '},
                    {'t', 't', 't', ' '},
                    {' ', ' ', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {' ', 't', ' ', ' '},
                    {'t', 't', ' ', ' '},
                    {' ', 't', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
            },
            {
                {
                    {' ', ' ', ' ', ' '},
                    {' ', 's', 's', ' '},
                    {'s', 's', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {'s', ' ', ' ', ' '},
                    {'s', 's', ' ', ' '},
                    {' ', 's', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
            },
            {
                {
                    {' ', ' ', ' ', ' '},
                    {'z', 'z', ' ', ' '},
                    {' ', 'z', 'z', ' '},
                    {' ', ' ', ' ', ' '},
                },
                {
                    {' ', 'z', ' ', ' '},
                    {'z', 'z', ' ', ' '},
                    {'z', ' ', ' ', ' '},
                    {' ', ' ', ' ', ' '},
                },
            },
        }
        return tileset;
    end

    function Tile.drawTile(piece, rotation, posX, posY, board)
        for y = 1, 4 do
            for x = 1, 4 do
                local block = tileset[piece][rotation][y][x]
                if block ~= ' ' then
                    drawBlock(block, x + posX, y + posY, board);
                end
            end
        end
    end

    function Tile.canTileMove(piece, rotation, testX, testY, board)
        local brd = board.getVars();
        for y = 1, 4 do
            for x = 1, 4 do
                local xBlock = testX + x;
                local yBlock = testY + y;
                if yBlock < 1 then
                    return false;
                end
                if tileset[piece][rotation][y][x] ~= ' ' and (xBlock < 1 or xBlock > brd.width or yBlock > brd.height or brd.field[yBlock][xBlock] ~= ' ') then
                    return false
                end
            end
        end

        return true

    end

    local function newSequence()
        for pieceTypeIndex = 1, #tileset do
            local position = math.random(#sequence +1);
            table.insert(sequence, position, pieceTypeIndex);
        end
    end
        
    function Tile.newPiece()
        if #sequence == 0 then
            newSequence();
        end
        local piece ={
            x = 3,
            y = -1;
            type = table.remove(sequence),
            rotation = 1
        };
        return piece;
    end

    function Tile.drawNextTile(brdVars)
        if #sequence == 0 then
            newSequence();
        end
        local offsetX = brdVars.offsetX + (brdVars.width * brdVars.blockSize) + 50;
        for y = 1, 4 do
            for x = 1, 4 do
                local block = tileset[sequence[#sequence]][1][y][x];
                if block ~= ' ' then
                    local color = brdVars.colors['preview']
                    love.graphics.setColor(color)
                    love.graphics.rectangle('fill', ((x - 1) * brdVars.blockSize) + offsetX, ((y - 1) * brdVars.blockSize) + brdVars.offsetY, brdVars.blockDrawSize, brdVars.blockDrawSize, brdVars.rounding, brdVars.rounding);
                end
            end
        end
    end

return Tile;