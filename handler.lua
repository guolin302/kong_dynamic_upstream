local BasePlugin = require "kong.plugins.base_plugin"
local log = require "kong.cmd.utils.log"

local DynamicHandler = BasePlugin:extend()

function DynamicHandler:new()
    DynamicHandler.super.new(self, "dynamic")
end


function DynamicHandler:access(config)
    require 'pl.pretty'.dump(config)
    DynamicHandler.super.access(self)
    log("DynamicHandler access")

    --截取前缀
    --
    --
    --local match_t = singletons.router.select(req_method, req_uri, req_host, ngx)
    --if not match_t then
    --    --执行父api代理
    --    return nil
    --end
     -- 替换service为对应路由


    local prefix = config.prefix

    if not string.find(ngx.var.upstream_uri, prefix .. "/") then
        local url_args = ngx.req.get_uri_args()
        ngx.var.upstream_uri = prefix .. ngx.var.upstream_uri
        ngx.req.set_uri_args(url_args)
    end

    ngx.log(ngx.ERR,"_______",dump(ngx.var.upstream_uri))

    args = ngx.req.get_query_args()
end

--DynamicHandler.PRIORITY = 100
DynamicHandler.VERSION = "v0.3.2"
return DynamicHandler
