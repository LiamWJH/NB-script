local lexer = {}

function lexer.tokenize(code)
    local tokens = {}
    local i, n = 1, #code

    while i <= n do
        local c = code:sub(i, i)
        
        if c:match("%s") then
            i = i + 1

        elseif c == "(" or c == ")" then
            tokens[#tokens + 1] = c
            i = i + 1

        elseif c == '"' or c == "'" then
            local quote = c
            i = i + 1
            local buf = {}
            local finished = false

            while i <= n do
                local ch = code:sub(i, i)
                if ch == "\\" and i < n then
                    local nextch = code:sub(i + 1, i + 1)
                    buf[#buf + 1] = nextch
                    i = i + 2
                elseif ch == quote then
                    i = i + 1
                    finished = true
                    break
                else
                    buf[#buf + 1] = ch
                    i = i + 1
                end
            end

            local inner = table.concat(buf)
            if finished then
                tokens[#tokens + 1] = quote .. inner .. quote
            else
                tokens[#tokens + 1] = quote .. inner
            end

        else
            local j = i
            while j <= n do
                local ch = code:sub(j, j)
                if ch:match("%s") or ch == "(" or ch == ")" or ch == "'" or ch == '"' then
                    break
                end
                j = j + 1
            end
            tokens[#tokens + 1] = code:sub(i, j - 1)
            i = j
        end
    end

    return tokens
end

return lexer
