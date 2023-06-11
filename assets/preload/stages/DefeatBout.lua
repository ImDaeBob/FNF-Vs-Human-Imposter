local xx = 750; --750
local yy = 900; --750
local xx2 = 1300; --1500
local yy2 = 900; --750
local ofs = 30;
local followchars = true;
local del = 0;
local del2 = 0;
local damage = true;
local beating = false;
local beat_skip = 0;
local shake = true;
local runbfX = 1
local runbfY = 1
local noloop = false;
local bestpart = false;
local useless = false;

function onCreatePost()--this thing happens once the characters are spawned

    setProperty("gf.visible", false);
    setProperty('OppSplash', false);
end

function onCreate()
	--background boi
	makeLuaSprite('red','redbg', -800, -800)
	makeLuaSprite('flash','Flash', 0, 0)
	makeLuaSprite('darksc','DarkSC', 0, 0)
	makeLuaSprite('flashwhite','flashwhite', 0, 0)
	makeLuaSprite('scenema','cutscene', 0, 0)
	makeLuaSprite('defeat','defeat', -950, -100)
	makeLuaSprite('defeatglow','defeat-glow', -950, -100)
	makeLuaSprite('skulls','lol thing', -550, 400)
	setScrollFactor('skulls', 0.9, 0.9);
	scaleObject('skulls', 1.5, 1.3);
	makeLuaSprite('skulls2','deadBG', -550, 900)
	scaleObject('skulls2', 0.45, 0.45);
	makeLuaSprite('skulls3','deadFG', -1050, 900)
	setScrollFactor('skulls3', 0.6, 0.6);
	scaleObject('skulls3', 0.5, 0.5);
    makeLuaSprite('V2','V2soon', 0, 0)




	addLuaSprite('defeat')
	addLuaSprite('skulls')
	addLuaSprite('defeatglow', true)
	addLuaSprite('skulls2')
	addLuaSprite('skulls3', true)
	addLuaSprite('darksc')
	
	
	addLuaSprite('flash')
	addLuaSprite('flashwhite')
	addLuaSprite('scenema')
	addLuaSprite('red')

    addLuaSprite('V2')

	setProperty('defeat.alpha', 0.5);
	setProperty('skulls.alpha', 0);
	setProperty('skulls2.alpha', 0);
	setProperty('skulls3.alpha', 0);
	setProperty('red.alpha', 0);
	setProperty('flash.alpha', 1);
	setObjectCamera('flash', 'other');
	setProperty('flashwhite.alpha', 0);
	setObjectCamera('flashwhite', 'other');
	setProperty('scenema.alpha', 0);
	setObjectCamera('scenema', 'other');
	setProperty('darksc.alpha', 0.5);
	setObjectCamera('darksc', 'other');
	setProperty('defeatglow.alpha', 0);
	setProperty('V2.alpha', 0);
	setObjectCamera('V2', 'other');
	
	makeLuaSprite('flashbackred','BG/BD/flashback-red', -950, 300)
	addLuaSprite('flashbackred')
	setProperty('flashbackred.alpha', 0.5)
	
	makeLuaSprite('flashbackgreen','BG/BD/flashback-green', -950, 500)
	addLuaSprite('flashbackgreen')
	setProperty('flashbackgreen.alpha', 0)
	
	makeLuaSprite('flashbackgrey','BG/BD/flashback-grey', -550, 300)
	addLuaSprite('flashbackgrey')
	setProperty('flashbackgrey.alpha', 0)
	
	
	makeLuaSprite('Name','blackoutdefeat', -500, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)
	

	
	
end


function onBeatHit()
	if curBeat % 4 == 0 then
	    if bestpart == true then
	    setProperty('defeat.alpha', 1);
		doTweenAlpha('defeatflash', 'defeat', 0.5, 1, 'linear');
		setProperty('defeatglow.alpha', 0.5);
		doTweenAlpha('defeatglowflash', 'defeatglow', 0.2, 1, 'linear');
		end
		
		if beating == true then
	     triggerEvent('Add Camera Zoom', 0.025, 0.045)
		 triggerEvent('Screen Shake','0.01, 0.01','0.1, 0.01');
		end
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

    function onStepHit()
	    if curStep == 1 then
		flash()
		setProperty('flash.alpha', 0);
		end
		if curStep == 992 or curStep == 1504 then
		setProperty('flashbackred.alpha', 1)
		setProperty('flashbackgreen.alpha', 0)
		setProperty('flashbackgrey.alpha', 0)
		triggerEvent('Change Character', 0, 'bf');
		triggerEvent('Change Character', 1, 'Red');
		end
		if curStep == 128 or curStep == 1536 then
		setProperty('flashbackred.alpha', 0)
		setProperty('flashbackgrey.alpha', 0)
		setProperty('flashbackgreen.alpha', 1)
		triggerEvent('Change Character', 0, 'bf');
		triggerEvent('Change Character', 1, 'Green_Imposter');
		end
		if curStep == 992 then
		setProperty('flashbackred.alpha', 0)
		setProperty('flashbackgrey.alpha', 1)
		setProperty('flashbackgreen.alpha', 0)
		triggerEvent('Change Character', 0, 'BF_Paranoid');
		triggerEvent('Change Character', 1, 'Grey');
		end
		if curStep == 256 then
		setProperty('flashbackred.alpha', 0)
		setProperty('flashbackgreen.alpha', 0)
		setProperty('flashbackgrey.alpha', 0)
		triggerEvent('Change Character', 0, 'BF_Defeat_Scared');
		triggerEvent('Change Character', 1, 'Black');
		end
		if curStep == 1112 or curStep == 1632 then
		setProperty('flashbackred.alpha', 0)
		setProperty('flashbackgreen.alpha', 0)
		setProperty('flashbackgrey.alpha', 0)
		triggerEvent('Change Character', 0, 'BF_Defeat_Scared');
		triggerEvent('Change Character', 1, 'Black_Defeat');
		end
	    if curStep == 736 or curStep == 784 or curStep == 1824 or curStep == 1792 then
		flash()
		end
	    if curStep == 288 then
		bestpart = true;
        beating = true;
		flash()
		setProperty('skulls.alpha', 1);
		setProperty('skulls2.alpha', 1);
		setProperty('skulls3.alpha', 1);
		triggerEvent('Change Character', 0, 'BF_Defeat_Scared');
		triggerEvent('Change Character', 1, 'Black_Defeat');
		setProperty('scenema.alpha', 1);
		setProperty('camHUD.visible', false);
		end
		if curStep == 448 then
		flash()
		setProperty('scenema.alpha', 0);
		setProperty('camHUD.visible', true);
		end
		if curStep == 1376 then
		flashdark()
		setProperty('skulls.alpha', 0);
		setProperty('skulls2.alpha', 0);
		setProperty('skulls3.alpha', 0);
		shake = false;
		beating = false;
		triggerEvent('Change Character', 0, 'bf');
		triggerEvent('Change Character', 1, 'blackold');
		doTweenAlpha('scenemaoff', 'scenema', 0, 1, 'linear');
		setProperty('camHUD.visible', true);
		end
		if curStep == 1656 then
		flashdark()
		shake = true;
		beating = true;
		setCharacterX('dad', 150);
		setProperty('skulls.alpha', 1);
		setProperty('skulls2.alpha', 1);
		setProperty('skulls3.alpha', 1);
		triggerEvent('Change Character', 1, 'Black_Defeat');
		triggerEvent('Change Character', 0, 'BF_Defeat_Scared');
		end
		if curStep == 1792 then
		flash()
		setProperty('scenema.alpha', 1);
		 xx = 900; --750
         yy = 1000; --750
         xx2 = 900; --1500
         yy2 = 1000; --750
		 triggerEvent('Camera Follow Pos',xx,yy)
		end
		if curStep == 2048 then
		flash()
		setProperty('scenema.alpha', 1);
		 xx = 750; --750
         yy = 900; --750
         xx2 = 1300; --1500
         yy2 = 900; --750
		 triggerEvent('Camera Follow Pos',xx,yy)
		end
		if curStep == 2080 then
		setProperty('flash.alpha', 1);
		end
    end
	
	
function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'nameout' then
	doTweenX('NameTweenX2', 'Name', -500, 2, 'CircInOut');
    end
end

function onUpdate()
    if useless == false then
		for i = 0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end
	end
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
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


function opponentNoteHit()
    health = getProperty('health')
    if damage == true then
        if getProperty('health') > 0.02 then
            setProperty('health', health-0.01);
		end
    end
end