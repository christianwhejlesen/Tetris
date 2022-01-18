--LuTris

--REQUIRE SECTION
local game = require("obj.game");
local board = require("obj.board");
local tiles = require("obj.tiles")

--VARIABLES
local gameOver = false;
local inert;
local pieceStructures;
local piece;
local sequence;
--INITIALIZATION

--FUNCTIONS

--LOVE FUNCTIONS
function love.keyreleased( key )
    if key == 'escape' then
        love.event.quit();

    elseif key == 'up' then
        local testRotation = piece.rotation + 1
        if testRotation > #pieceStructures[piece.type] then
            testRotation = 1
        end
        if tiles.canTileMove(piece.type, testRotation, piece.x, piece.y, board) then
            piece.rotation = testRotation;
        end

    elseif key == 'down' then
        while tiles.canTileMove(piece.type, piece.rotation, piece.x, piece.y + 1, board) do
            piece.y = piece.y + 1
        end

    elseif key == 'left' then
        if tiles.canTileMove(piece.type, piece.rotation, piece.x - 1, piece.y, board) then
            piece.x = piece.x - 1;
        end
    
    elseif key == 'right' then
        if tiles.canTileMove(piece.type, piece.rotation, piece.x + 1, piece.y, board) then
            piece.x = piece.x + 1;
        end
    end


end

function love.load()
    game.init();
    inert = board.init(nil, nil, nil, 1, 2, 100, 50, nil);
    pieceStructures = tiles.init();
    love.graphics.setBackgroundColor(game.getbgColor());
    piece = tiles.newPiece();
end

function love.update( dt )
    board.checkComplete();
    if game.tick(dt) then
        if tiles.canTileMove(piece.type, piece.rotation, piece.x, piece.y + 1, board) then
            piece.y = piece.y + 1;
        else
            board.addToInert(piece, pieceStructures);
            piece = tiles.newPiece();
        end
    end
    --inert[14][5] = 'z';
end

function love.draw()
    board.draw(inert);
    tiles.drawTile(piece.type, piece.rotation, piece.x, piece.y, board);

end
