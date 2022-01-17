--LuTris

--REQUIRE SECTION
local game = require("obj.game");
local board = require("obj.board");
local tiles = require("obj.tiles")
--VARIABLES
local gameOver = false;
-- local boardWidth = 10;
-- local boardHeight = 18;
-- local cellSize = 20;

--INITIALIZATION
game.init();
board.init(nil, nil, nil, 1, 2, nil);
--FUNCTIONS

--LOVE FUNCTIONS
function love.keyreleased( key )
    if key == 'escape' then
        love.event.quit();
    end
end

function love.load()
    love.graphics.setBackgroundColor(game.getbgColor());
end

function love.update( dt )

end

function love.draw()
    board.draw();
end
