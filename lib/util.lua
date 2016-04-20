local Util = {}

function Util.toast(title, text)
	hs.notify.new({
    title=title,
    informativeText=text
  }):send():release()
end

function Util.alert(text)
	hs.alert(text);
end

return Util
