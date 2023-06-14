local xx = 0; --750
local yy = 1000; --750
local xx2 = 0; --1500
local yy2 = 950; --750
local ofs = 10;
local followchars = true;
local damage = false;
local beating = true;
local beat_skip = 0;
local noloop = false;
local looptime = 100;
local dadZoom = 0.85; --1.2
local bfZoom = 0.75; --0.9



function onCreate()
	--background boi
	
	makeLuaSprite('bg','BG/lovestruck/pain', -11000, 200)
	makeLuaSprite('bg2','BG/lovestruck/pain', -23000, 200)

	addLuaSprite('bg')
	addLuaSprite('bg2')
	
	doTweenX('Stage1TweenX', 'bg', 1000, looptime, 'linear');
	doTweenX('Stage2TweenX', 'bg2', -11000, looptime, 'linear');
	
	
	
end

function onStepHit()
    if curStep == 320 then
	dadZoom = 0.95;
    bfZoom = 0.85;
	end
	if cutStep == 848 then
	dadZoom = 0.85;
    bfZoom = 0.75;
	end
end

function onBeatHit()
    if curBeat % 2 == 0 then
	    setCharacterY('dad', 715);
	    setCharacterY('boyfriend', 715);
	    doTweenY('pinkYtween', 'dad', 700, 1, 'linear');
	    doTweenY('yellowYtween', 'boyfriend', 700, 1, 'linear');
	end
end

function opponentNoteHit()
	
    health = getProperty('health')
    if damage == true then
        if getProperty('health') > 0.4 then
            setProperty('health', health- 0.02);
		end
    end
end

function onTweenCompleted(tag)
    if tag == 'Stage1TweenX' then
	    if noloop == false then
    	setProperty('bg.x', -11000);
  	    setProperty('bg2.x', -23000);
 	    doTweenX('Stage1TweenX', 'bg', 1000, looptime, 'linear');
	    doTweenX('Stage2TweenX', 'bg2', -11000, looptime, 'linear');
        end
end
end

function onUpdate(elapsed)
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',dadZoom)
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
		setProperty('defaultCamZoom',bfZoom)

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
