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
local width = 10;
local height = 18;
local cellSize = 20;

--INITIALIZATION
math.randomseed(os.time());

--FUNCTIONS

--LOVE FUNCTIONS
function love.keyreleased( key )
    if key == 'escape' then
        love.event.quit();
    end
    if not gameOver then
        if key == 'up' then
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
    else
        if key == 'space' then
            love.load();
            gameOver = false;
        end
    end

end

function love.load()
    local offsetx = (love.graphics.getWidth() / 2) - ((width * cellSize) / 2);
    game.init();
    inert = board.init(width, height, cellSize, 1, 2, offsetx, 50, nil);
    pieceStructures = tiles.init();
    love.graphics.setBackgroundColor(game.getbgColor());
    piece = tiles.newPiece();
end

function love.update( dt )
    if not gameOver then
        game.updateScore( board.checkComplete() );
        if game.tick(dt) then
            if tiles.canTileMove(piece.type, piece.rotation, piece.x, piece.y + 1, board) then
                piece.y = piece.y + 1;
            else
                board.addToInert(piece, pieceStructures);
                piece = tiles.newPiece();
                if not tiles.canTileMove(piece.type, piece.rotation, piece.x, piece.y + 1, board) then
                    gameOver = true;
                end
            end
        end
    end
end

function love.draw()
    local boardVars = board.getVars();
    board.draw(inert);
    game.drawScore(boardVars);
    tiles.drawNextTile(boardVars);
    tiles.drawTile(piece.type, piece.rotation, piece.x, piece.y, board);
    if gameOver then
        game.drawGameOver();
    end
end
