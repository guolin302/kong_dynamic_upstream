local Errors = require "kong.dao.errors"

local function validate_prefix(schema, plugin_t, dao, is_update)
    if not (string.sub(plugin_t.prefix,0,1) == '/') then
        return false, Errors.schema "prefix 以 / 开头"
    end
    return true
end

return {
    no_consumer = true,
    fields = {
        prefix = {
            type = "string",
            default = "/orchsym",
        }
    },
    self_check = validate_prefix
}
