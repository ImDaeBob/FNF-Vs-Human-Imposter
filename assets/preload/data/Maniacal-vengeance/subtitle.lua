
function onCreate()
	--background boi

	makeLuaText('SubWhite', ' ', 0, 0, 535)
	setTextSize('SubWhite', 46)
	setObjectCamera('SubWhite', 'other');
	addLuaText('SubWhite', true)
	setTextAlignment('SubWhite', 'SubWhite.center')
	setTextColor('SubWhite', 'ffffff')
	
end

function onStepHit()
    if curStep == 2048 or curStep == 3328 or curStep == 3968 then
	setTextString('SubWhite', ' ')
	end
	if curStep == 2022 then
	setTextString('SubWhite', '"It′s too late Dillaw."')
	setTextColor('SubWhite', 'FFB4F6')
	end
	if curStep == 3072 then
	setTextString('SubWhite', '"With a wicked smile and cunning eyes,"')
	setTextColor('SubWhite', 'FFB4F6')
	end
	if curStep == 3136 then
	setTextString('SubWhite', '"I′ll spin my web of deceit and lies."')
	setTextColor('SubWhite', 'FFB4F6')
	end
	if curStep == 3200 then
	setTextString('SubWhite', '"My heart is cold, my soul is black,"')
	setTextColor('SubWhite', 'FFB4F6')
	end
	if curStep == 3264 then
	setTextString('SubWhite', '"And I′ll stop at nothing to get what I lack"')
	setTextColor('SubWhite', 'FFB4F6')
	end
	if curStep == 3840 then
	setTextString('SubWhite', '"Oh my god..."')
	setTextColor('SubWhite', 'FFC733')
	end
	if curStep == 3888 then
	setTextString('SubWhite', '"Wh..."')
	setTextColor('SubWhite', 'FFC733')
	end
	if curStep == 3899 then
	setTextString('SubWhite', '"What the FUCK is wrong with you?!"')
	setTextColor('SubWhite', 'FFC733')
	end
end