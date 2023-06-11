local xx = -100; --750
local yy = 930; --750
local xx2 = 200; --1500
local yy2 = 930; --750
local ofs = 15;
local followchars = true;
local heartbeat = false;

function onCreatePost()
    triggerEvent('Camera Follow Pos',xx,yy)
end

function onCreate()
    makeLuaSprite('red','redbg', -600, -400)
	makeLuaSprite('flash','Flash', 0, 0)
	makeLuaSprite('flashwhite','flashwhite', 0, 0)
    makeLuaSprite('pinky','Mira/vignette', 0, 0)
	makeLuaSprite('pinky2','Mira/vignette2', 0, 0)
	makeLuaSprite('csdown','cutscene1', 0, 0)
	makeLuaSprite('csup','cutscene2', 0, 0)
	
	makeAnimatedLuaSprite('SCheart','Mira/hearts', 0, -100)
	addAnimationByPrefix('SCheart','loop','Symbol',24,true)
    objectPlayAnimation('SCheart','loop',true);
	
	addLuaSprite('pinky')
	addLuaSprite('pinky2')
	addLuaSprite('SCheart')
	
	addLuaSprite('flash')
	addLuaSprite('flashwhite')
	addLuaSprite('red')
	
	addLuaSprite('csup')
	addLuaSprite('csdown')
	
	setBlendMode('pinky', 'add')
	setBlendMode('pinky2', 'add')
	
	setObjectCamera('pinky', 'other');
	setObjectCamera('pinky2', 'other');
	setObjectCamera('SCheart', 'other');
	
	setProperty('pinky.alpha', 0);
	setProperty('pinky2.alpha', 0);
	setProperty('SCheart.alpha', 0);
	
	setProperty('red.alpha', 0);
	setProperty('flash.alpha', 0);
	setObjectCamera('flash', 'other');
	setProperty('flashwhite.alpha', 0);
	setObjectCamera('flashwhite', 'other');
	setProperty('csup.alpha', 1);
	setObjectCamera('csup', 'other');
	setProperty('csdown.alpha', 1);
	setObjectCamera('csdown', 'other');
	
	makeLuaSprite('Name','pinku', -500, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)
end

function onUpdate()
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
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
			end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
end

function onBeatHit()
    if curBeat % 2 == 0 then
	    if heartbeat == true then
		 triggerEvent('Add Camera Zoom', 0.02, 0.02)
	     setProperty('pinky.alpha', 0.75);
	     setProperty('pinky2.alpha', 0.75);
		 doTweenAlpha('pinky', 'pinky', 0.25, 1, 'linear');
		 doTweenAlpha('pinky2', 'pinky2', 0.25, 1, 'linear');
		 end
	end
end

function onStepHit()
   if curStep == 1 then
   cutoff()
		doTweenX('NameTweenX', 'Name', 0, 2, 'CircInOut');
		runTimer('nameout', 5);
   end
   if curStep == 512 then
   flash()
   end
   if curStep == 256 or curStep == 9999 then
   beating()
   end
   if curStep == 256 or curStep == 640 or curStep == 1280 then
   cuton()
   end
   if curStep == 1280 or curStep == 9999 then
   beatingoff()
   end
   if curStep == 512 or curStep == 768 then
   cutoff()
   end
   if curStep == 191 or curStep == 256 or curStep == 640 then
   xx = 0;
   xx2 = 0;
   triggerEvent('Camera Follow Pos',xx,yy)
   end
   if curStep == 251 or curStep == 527 or curStep == 768 then
   xx = -100;
   xx2 = 200;
   triggerEvent('Camera Follow Pos',xx,yy)
   end
   if curStep == 1312 then
   setProperty('camHUD.visible', false);
   doTweenAlpha('endfade', 'flash', 1, 5, 'linear');
   end
end

function flash()
    setProperty('flashwhite.alpha', 1);
	doTweenAlpha('flashdown', 'flashwhite', 0, 0.5, 'linear');
end

function flashdark()
    setProperty('flash.alpha', 1);
	doTweenAlpha('flashdowndark', 'flash', 0, 1.5, 'linear');
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

function beating()
    heartbeat = true;
    setProperty('pinky.alpha', 0.75);
	setProperty('pinky2.alpha', 0.75);
	doTweenAlpha('SCheart start', 'SCheart', 1, 1, 'linear');
end

function beatingoff()
    heartbeat = false;
	doTweenAlpha('pinky end', 'pinky', 0, 1, 'linear');
	doTweenAlpha('pinky2 end', 'pinky2', 0, 1, 'linear');
	doTweenAlpha('SCheart end', 'SCheart', 0, 1, 'linear');
end