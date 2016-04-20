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

function Util.sortKeys(t, compareFunc)
	local keys = {}

	for key in pairs(t) do
		table.insert(keys, key)
	end

	table.sort(keys, function(a, b)
		return compareFunc(t[a], t[b])
	end)

	return keys
end

return Util
