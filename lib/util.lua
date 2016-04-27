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

--adapted from: http://lua-users.org/wiki/TableSerialization
function Util:tablePrint (tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    local sb = {}
    for key, value in pairs (tt) do
      table.insert(sb, string.rep (" ", indent)) -- indent it
      if type (value) == "table" and not done [value] then
        done [value] = true
        table.insert(sb, "{\n");
        table.insert(sb, self:tablePrint (value, indent + 2, done))
        table.insert(sb, string.rep (" ", indent)) -- indent it
        table.insert(sb, "}\n");
      elseif "number" == type(key) then
        table.insert(sb, string.format("\"%s\"\n", tostring(value)))
      else
        table.insert(sb, string.format(
            "%s = \"%s\"\n", tostring (key), tostring(value)))
       end
    end
    return table.concat(sb)
  else
    return tt .. "\n"
  end
end

-- adapted from: http://lua-users.org/wiki/TableSerialization
function Util:toString( tbl )
	if  "nil" == type( tbl ) then
		return tostring(nil)
	elseif "table" == type( tbl ) then
		return self:tablePrint(tbl)
	elseif "string" == type( tbl ) then
		return tbl
	else
		return tostring(tbl)
	end
end


return Util
