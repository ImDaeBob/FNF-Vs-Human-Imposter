local beating = false;
local red = false;

function onCreatePost()
    triggerEvent('Camera Follow Pos',xx,yy)
	setProperty('gf.alpha', 0);
end

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
	setProperty('flash.alpha', 1);
	setObjectCamera('flash', 'other');
	setProperty('flashwhite.alpha', 0);
	setObjectCamera('flashwhite', 'other');
	setProperty('csup.alpha', 1);
	setObjectCamera('csup', 'hud');
	setProperty('csdown.alpha', 1);
	setObjectCamera('csdown', 'hud');
	
	makeLuaSprite('Name','Lovestruck', -500, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)

    makeLuaSprite('intro1','BG/lovestruck/intro1', 0, 1080)
	addLuaSprite('intro1')
	setObjectCamera('intro1', 'other');
	
	makeLuaSprite('intro2','BG/lovestruck/intro2', 0, 1080)
	addLuaSprite('intro2')
	setObjectCamera('intro2', 'other');
	
	makeLuaSprite('intro3','BG/lovestruck/intro3', 0, 1080)
	addLuaSprite('intro3')
	setObjectCamera('intro3', 'other');
	
	makeLuaSprite('intro4','BG/lovestruck/intro4', 0, 1080)
	addLuaSprite('intro4')
	setObjectCamera('intro4', 'other');
	
end

function onBeatHit()
    if curBeat % 1 == 0 then
	playAnim('deadgf','loop', true);
	end
	if curBeat % 2 == 0 then
	  if beating == true then
	  triggerEvent('Add Camera Zoom', 0.02, 0.02)
	  end
	end
end

function onStepHit()
   if curStep == 1 then
   doTweenY('intro1start', 'intro1', 0, 2, 'CircInOut');
   end
   if curStep == 16 then
   doTweenY('intro1end', 'intro1', -1080, 2, 'CircInOut');
   doTweenY('intro2start', 'intro2', 0, 2, 'CircInOut');
   end
   if curStep == 32 then
   doTweenY('intro2end', 'intro2', -1080, 2, 'CircInOut');
   doTweenY('intro3start', 'intro3', 0, 2, 'CircInOut');
   end
   if curStep == 48 then
   doTweenY('intro3end', 'intro3', -1080, 2, 'CircInOut');
   doTweenY('intro4start', 'intro4', 0, 2, 'CircInOut');
   setProperty('camHUD.visible', true);
   end
   --cutscenes
   if curStep == 64 then
   setProperty('intro1.alpha', 0);
   setProperty('intro2.alpha', 0);
   setProperty('intro3.alpha', 0);
   setProperty('intro4.alpha', 0);
   setProperty('flash.alpha', 0);
   flash()
   end
   if curStep == 1392 then
   doTweenAlpha('outro', 'flash', 1, 5, 'linear');
   end
   if curStep == 9999 then
   setProperty('camHUD.visible', false);
   end
   if curStep == 9999 then
   setProperty('camHUD.visible', true);
   end
   if curStep == 64 then
		doTweenX('NameTweenX', 'Name', 0, 2, 'CircInOut');
		runTimer('nameout', 5);
   end
   if curStep == 9999 then
   flash()
   end
   if curStep == 9999 or curStep == 9999 then
   beating = false;
   end
   if curStep == 320 or curStep == 9999 then
   beating = true;
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