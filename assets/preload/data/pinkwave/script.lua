local heartbeat = false;

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
	
	makeLuaSprite('Name','pinkwave', -500, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)
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

function onBeatHit()
    if curBeat % 2 == 0 then
	    if heartbeat == true then
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
   if curStep == 520 then
   flash()
   end
   if curStep == 136 or curStep == 520 or curStep == 776 or curStep == 1032 or curStep == 1288 then
   beating()
   cuton()
   end
   if curStep == 264 or curStep == 648 or curStep == 904 or curStep == 1160 or curStep == 1473 then
   beatingoff()
   cutoff()
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