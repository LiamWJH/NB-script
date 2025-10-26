local cli = require("cli")
local returncliargs = cli.returncliargs

cliargs = returncliargs()
for i, item in ipairs(cliargs) do
    print(item)
end
print("Detected command line args:"..table.concat(cliargs, ", "))

