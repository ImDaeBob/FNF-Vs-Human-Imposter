local beating = false;

function onCreate()
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
	
	makeLuaSprite('Name','Blackout', -500, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)
	
end

function onBeatHit()
	if curBeat % 1 == 0 then
		if beating == true then
	        triggerEvent('Add Camera Zoom', 0.03, 0.03)
		end
	end
end

function onStepHit()
   if curStep == 1 then
		doTweenX('NameTweenX', 'Name', 0, 2, 'CircInOut');
		runTimer('nameout', 5);
   end
   if curStep == 528 or curStep == 832 or curStep == 1343 or curStep == 1712 then
   flash()
   end
   if curStep == 528 or curStep == 800 or curStep == 1056 or curStep == 1343 then
   beating = false;
   end
   if curStep == 271 or curStep == 832 or curStep == 1215 or curStep == 1712 then
   beating = true;
   end
   if curStep == 560 or curStep == 832 or curStep == 1215 or curStep == 1520 then
   cuton()
   end
   if curStep == 1 or curStep == 1087 or curStep == 1343 then
   cutoff()
   end
   if curStep == 1520 then
   triggerEvent('Camera Follow Pos',-200,1000)
   setProperty('camHUD.visible', false);
   end
   if curStep == 1647 then
   setProperty('flash.alpha', 1);
   end
   if curStep == 1712 then
   setProperty('flash.alpha', 0);
   setProperty('camHUD.visible', true);
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