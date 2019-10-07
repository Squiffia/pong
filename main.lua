io.stdout:setvbuf("no")



love.load=function()
  love.graphics.setDefaultFilter("nearest", "nearest")
  x=400
  y=1
  previousx=0
  previousy=0
  -- ball initial velocity
  i=300
  xv=-i
  yv=i

  -- paddle x-positions (2 on left, 1 on right)
  p_x_r=770
  p_x_l=30

  -- paddle y-positions
  p_y_l=300
  p_y_r=300

  -- finding the line segment between the ball's current and previous positions
  slope=0
  yintercept=0
  ylevel=0

  -- check to see if there is an intersection with a paddle
  pass=false
  pass2=false
  --font and score
  fontbig=love.graphics.newFont(50)
  scoreleft=0
  scoreright=0
  --controlls the sound fx
  ballnoise=love.audio.newSource("ball.wav")
  ballnoise2=love.audio.newSource("Pickup_Coin2.wav")
  ballnoise3=love.audio.newSource("Blip_Select21.wav")
  ballnoisestart=love.audio.newSource("Blip_Select19.wav")
  --title screen variables
  current_state = "title_screen"
  titlemage=love.graphics.newImage("poong.png")
  pressA=love.graphics.newImage("pongtitle.png")
  enlarge=0
  up=true
  
end



love.update=function(dt)
  if current_state == "title_screen" then
    if love.keyboard.isDown("a") then
      current_state="game"
      ballnoisestart:play()
    end
    if enlarge<=0 then
      up=true
    end
    if up==true then
      enlarge=enlarge+0.1
    end
    if enlarge>=5 then
      up=false
    end
    if up==false then
      enlarge=enlarge-0.1
    end
  elseif current_state == "game" then
    -- Updates the ball's position using its velocity

    x=x+xv*dt
    y=y+yv*dt

    -- Find the line segment between the ball's start and end positions
    slope=(y-previousy)/(x-previousx)
    yintercept=y-(slope*x)
    if xv<0 then

      ylevel=(slope*(p_x_l + 10))+yintercept


      if ylevel>=p_y_l-50 and ylevel<=p_y_l+50 then
        pass=true
      else
        pass=false
      end
    end

    if xv>0 then
      ylevel2=(slope*(p_x_r - 10))+yintercept
      if ylevel2>=p_y_r-50 and ylevel2<=p_y_r+50 then
        pass2=true
      else
        pass2=false
      end
    end

    if x<=p_x_l+10 and pass==true and xv < 0 then
      xv=-xv
      number=love.math.random(1, 3)
      if number==1 then
        ballnoise:play()
      end

      if number==2 then
        ballnoise2:play()
      end

      if number==3 then
        ballnoise3:play()
      end
    end

    if x>=p_x_r-10 and pass2==true and xv > 0 then
      xv=-xv
      number=love.math.random(1, 3)
      if number==1 then
        ballnoise:play()
      end
      if number==2 then
        ballnoise2:play()
      end

      if number==3 then
        ballnoise3:play()
      end
    end

    if y<=0 and yv<0 then
      yv=-yv
    end

    if y>=600 and yv>0 then
      yv=-yv 
    end









    if p_y_l>=50 then
      if love.keyboard.isDown("w") then
        p_y_l=p_y_l-dt*800
      end
    end
    if p_y_l<=550 then
      if love.keyboard.isDown("s") then
        p_y_l=p_y_l+dt*800
      end
    end

    if p_y_r>=50 then
      if love.keyboard.isDown("up") then
        p_y_r=p_y_r-dt*800
      end
    end

    if p_y_r<=550 then
      if love.keyboard.isDown("down") then
        p_y_r=p_y_r+dt*800
      end
    end 

    previousy=y
    previousx=x
    if x<0 then

      scoreright=scoreright+1
      x=400
      y=1
      previousx=0
      previousy=0
      yv=i
      xv=i

    end
    if x>800 then

      scoreleft=scoreleft+1
      x=400
      y=1
      previousx=0
      previousy=0
      yv=i
      xv=-i

    end
  end
end

love.draw=function()
  if current_state == "title_screen" then
    love.graphics.draw(titlemage, 240, 100, 0, 5, 5)
    love.graphics.draw(pressA, 400, 400, 0, enlarge, enlarge, 40, 6)
  elseif current_state == "game" then
    love.graphics.setFont(fontbig)
    love.graphics.print(scoreleft,140, 10)
    love.graphics.print(scoreright, 600, 10)
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill",x , y, 5)
    love.graphics.rectangle( "fill", p_x_r - 10, p_y_r - 50, 20, 100)
    love.graphics.rectangle("fill", p_x_l - 10, p_y_l - 50, 20, 100)
  end
end



--[[
    love.graphics.line(0, yintercept, 800, 800 * slope + yintercept)
    ylevel2=(slope*(p_x_r - 10))+yintercept
    love.graphics.print(ylevel2, 0, 0)
    love.graphics.print(p_y_r, 0, 200)
    if ylevel2>=p_y_r-50 and ylevel2<=p_y_r+50 then
      love.graphics.print("in", 0, 400)
    end
    love.graphics.print(ylevel2, 0, 0)
    ]]
