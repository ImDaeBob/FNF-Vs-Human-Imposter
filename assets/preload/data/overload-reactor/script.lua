local beating = false;
local red = false;
local xx = -50; --200
local yy = 1350; --1350
local xx2 = 300; --1500
local yy2 = 1350; --750
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;


function onCreate()
    setProperty('camHUD.visible', false);
    makeLuaSprite('red','redbg', 0, 0)
	makeLuaSprite('flash','Flash', 0, 0)
	makeLuaSprite('flashwhite','flashwhite', 0, 0)
	makeLuaSprite('csdown','cutscene1', 0, 0)
	makeLuaSprite('csup','cutscene2', 0, 0)
    addLuaSprite('red')
	addLuaSprite('flash')
	addLuaSprite('flashwhite')
	
	
	addLuaSprite('csup')
	addLuaSprite('csdown')
	
	
	
	setProperty('red.alpha', 0);
	setObjectCamera('red', 'other');
	setProperty('flash.alpha', 0);
	setObjectCamera('flash', 'other');
	setProperty('flashwhite.alpha', 0);
	setObjectCamera('flashwhite', 'other');
	setProperty('csup.alpha', 1);
	setObjectCamera('csup', 'other');
	setProperty('csdown.alpha', 1);
	setObjectCamera('csdown', 'other');
	
	objectsOverlap('pinky', 'pinky2')
	
	makeLuaSprite('Name','overload-reactor', -500, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)

	
end

function onBeatHit()
	if curBeat % 2 == 0 then
	  if beating == true then
	  triggerEvent('Add Camera Zoom', 0.03, 0.03)
	  end
	end
	if curBeat % 8 == 0 then
	if red == true then
	  flashred()
	  end
	end
end

function onStepHit()
   if curStep == 3200 then
   setProperty('flash.alpha', 1);
   red = false;
   end
   if curStep == 256 then
   xx = -50
   yy = 1350
   end
   if curStep == 128 then
   xx = 150
   yy = 1200
   triggerEvent('Camera Follow Pos',xx,yy)
   red = true;
   end
   if curStep == 256 then
		doTweenX('NameTweenX', 'Name', 0, 2, 'CircInOut');
		runTimer('nameout', 5);
   end
   
   if curStep == 256 then
   flash()
   setProperty('camHUD.visible', true);
   beating = true;
   setObjectCamera('csup', 'hud');
   setObjectCamera('csdown', 'hud');
   end
   if curStep == 1680 or curStep == 1712 or curStep == 1744 or curStep == 1776 then
   flashred()
   triggerEvent('Add Camera Zoom', 0.03, 0.03)
   end
   if curStep == 256 or curStep == 512 or curStep == 1280 or curStep == 1792 or curStep == 2688 then
   flash()
   end
   if curStep == 9999 or curStep == 9999 then
   red = true;
   end
   if curStep == 9999 or curStep == 9999 then
   red = false;
   end
   if curStep == 512 or curStep == 1280 or curStep == 2432 then
   dueton()
   cuton()
   flash()
   end
   if curStep == 1568 then
   cuton()
   end
   if curStep == 1024 or curStep == 1536 or curStep == 9999 then
   duetoff()
   cutoff()
   end
   if curStep == 2432 then
   duetoff()
   end
   if curStep == 256 or curStep == 1792 then
   cutoff()
   end
   if curStep == 2853 then
   red = false
   end
end

function flash()
    setProperty('flashwhite.alpha', 1);
	doTweenAlpha('flashdown', 'flashwhite', 0, 0.5, 'linear');
end

function flashred()
    setProperty('red.alpha', 0.25);
	doTweenAlpha('flashdownred', 'red', 0, 0.5, 'linear');
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'nameout' then
	doTweenX('NameTweenX2', 'Name', -500, 2, 'CircInOut');
    end
end

function cuton()
    doTweenY('CSUPY', 'csup', 0, 1, 'CircInOut');
    doTweenY('SCDOWNY', 'csdown', 0, 1, 'CircInOut');
	setProperty('healthBar.alpha', tonumber(0))
    setProperty('iconP1.alpha', tonumber(0))
    setProperty('iconP2.alpha', tonumber(0))
end

function cutoff()
    doTweenY('CSUPYend', 'csup', -100, 1, 'CircInOut');
    doTweenY('SCDOWNYend', 'csdown', 100, 1, 'CircInOut');
	setProperty('healthBar.alpha', tonumber(1))
    setProperty('iconP1.alpha', tonumber(1))
    setProperty('iconP2.alpha', tonumber(1))
end

function dueton()
   xx = 150
   yy = 1200
   xx2 = 150
   yy2 = 1200
   triggerEvent('Camera Follow Pos',xx,yy)
end

function duetoff()
   xx = -50
   yy = 1350
   xx2 = 300
   yy2 = 1350
   if mustHitSection == false then
   triggerEvent('Camera Follow Pos',xx,yy)
   else
   triggerEvent('Camera Follow Pos',xx2,yy2)
   end
end

function onUpdate(elapsed)
    if followchars == true then
        if mustHitSection == false then

            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end