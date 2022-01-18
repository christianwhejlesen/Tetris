--GAME OBJECT

Game = {}
    local bgColor = { 222/255, 222/255, 222/255, 100/100 };
    local timer = 0;
    local tickCount = 0.5;
    local score = 0;
    local scoreBoard = { bgcolor = { 30/255, 30/255, 30/255, 70/100 },
                fgcolor = { 225/255, 225/255, 225/255, 100/100 },
                fontSize = 22,
                width = 80,
                height = 30,
                rc = 7
                };

    local infoBoard = { fgcolor = { 94/255, 209/255, 71/255, 100/100 },
                bgcolor = { 222/255, 214/255, 69/255, 100/100 },
                fontSize = 50,
                width = love.graphics.getWidth(),
                height = 100,
                posY = (love.graphics.getHeight() / 2)
                };


    function Game.getbgColor()
        return bgColor;
    end

    function Game.init( in_bgColor)
        bgColor = in_bgColor or bgColor;
        score = 0;
    end

    function Game.tick( dt )
        timer = timer + dt;
        if timer >= tickCount then
            timer = 0;
        end
        return timer == 0;
    end

    function Game.getScore()
        return score;
    end

    function Game.updateScore(updateScore)
        score = score + updateScore;
    end

    function Game.drawScore( brdVars )
        local offsetX = (love.graphics.getWidth() / 2) - (scoreBoard.width / 2);
        local offsetY = brdVars.offsetY + (brdVars.height * brdVars.blockSize) + 20;
        love.graphics.setColor( scoreBoard.bgcolor );
        love.graphics.rectangle( 'fill', offsetX, offsetY, scoreBoard.width, scoreBoard.height, scoreBoard.rc, scoreBoard.rc, scoreBoard.rc);
      
        love.graphics.setColor( scoreBoard.fgcolor );
        love.graphics.setFont( love.graphics.newFont(scoreBoard.fontSize) );
        love.graphics.printf( score, offsetX, offsetY + ((scoreBoard.height - scoreBoard.fontSize - 2) / 2), scoreBoard.width, 'center' )
      

    end

    function Game.drawGameOver()
        love.graphics.setColor( infoBoard.bgcolor );
        love.graphics.rectangle( 'fill', 0, infoBoard.posY - (infoBoard.height / 2), infoBoard.width, infoBoard.height);
      
        love.graphics.setColor( infoBoard.fgcolor );
        love.graphics.setFont( love.graphics.newFont(infoBoard.fontSize) );
        love.graphics.printf( "Game Over!", 0, ((infoBoard.posY - (infoBoard.fontSize / 2) - 2)), infoBoard.width, 'center' )
      
    end

return Game;