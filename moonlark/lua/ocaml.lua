--[[

Edit deps attrib of ocaml_module rule with struct = "foo.ml"

Predication:

   node.type == Call_Expr
   let rulename = node.subnodes[type == ID]
       rulename.s == "ocaml_module"
   let attrs = node.subnodes.Arg_List
   for each arg_named in attrs
       match @attr pred

ocaml_module( # Call_Sfx ::= ( Arg_List )
   # Arg_List ::= list of Arg_Named or ID or STRING etc. comma-separated
    name = "simple",
    struct = "simple.ml",
)


--]]

function ocaml_ed(node)
   predicates = {
      type = moonlark.TOK.Call_Expr  -- matches TID of call_expr
      prefix = "ocaml_" -- regex
      @ = {struct = "foobar.ml"}  -- attrib predicate
   }
    if (node.type != type) return
    -- match prefix against ID subnode
    -- match each @ pred against call sfx arg list
end

-- make a node editor for use with ast_walk.rules
ocaml_ed = rule_editor(
    type = moonlark.TOK.Call_Expr  -- matches TID of call_expr
    prefix = "ocaml_" -- regex
    @struct = "foobar.ml"  -- attrib predicate
    handler = function(node) end
)


