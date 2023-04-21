local xx = -100; --750
local yy = 930; --750
local xx2 = 200; --1500
local yy2 = 930; --750
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;
local damage = false;
local beating = true;
local beat_skip = 0;

function onCreatePost()
    triggerEvent('Camera Follow Pos',xx,yy)
	setProperty('gf.visible', false);
end

function onCreate()
	--background boi
	
	makeLuaSprite('floor','Mira/pretender/ground', -1500, -100)
	makeLuaSprite('sky','Mira/pretender/bg sky', -1650, -200)
	makeLuaSprite('what is this','Mira/what is this', -300, 0)
	makeLuaSprite('front pot','Mira/front pot', -1300, 1250)
	setScrollFactor('front pot', 0.9, 0.9);
	makeLuaSprite('lmao','Mira/pretender/knocked over plant 2', -1050, 950)
	
	makeAnimatedLuaSprite('vines','Mira/vines', -1200, -600)
	addAnimationByPrefix('vines','loop','green',24,true)
    objectPlayAnimation('vines','loop',true);
	setScrollFactor('vines', 0.9, 0.9);
	
	makeLuaSprite('coral','Mira/pretender/tomatodead', 500, 700)
	
	makeAnimatedLuaSprite('flowerguy','deadflowerguy', -1100, 1000)
	addAnimationByPrefix('flowerguy','loop','flowerguy dead',24,false)
    objectPlayAnimation('flowerguy','loop',false);
	setScrollFactor('flowerguy', 0.9, 0.9);
	scaleObject('flowerguy',1.12, 1.12);
	
	makeAnimatedLuaSprite('black','black-sitting', -175, 650)
	addAnimationByPrefix('black','loop','bgblack',20,true)
    objectPlayAnimation('black','loop',true);
	
    addLuaSprite('sky')
	addLuaSprite('floor')
	addLuaSprite('coral')
	addLuaSprite('what is this')
	addLuaSprite('lmao')
	addLuaSprite('black')
	
	
	addLuaSprite('flowerguy', true)
	addLuaSprite('righthandman', true)
	addLuaSprite('front pot', true)
	addLuaSprite('vines', true)
	
	makeLuaSprite('darkSC','Mira/pretender/lightingpretender', -1200, -100)
	addLuaSprite('darkSC')
	setObjectCamera('darkSC', 'hud');
	

	
	
end

function onBeatHit()
    if curBeat % 2 == 0 then
		 playAnim('flowerguy','loop', true);
	end
	if curBeat % 4 == 0 then
		if beating == true then
	        triggerEvent('Add Camera Zoom', 0.02, 0.02)
		end
	end
end



function onUpdate()
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
        if getProperty('health') > 0.4 then
            setProperty('health', health- 0.02);
		end
    end
end

