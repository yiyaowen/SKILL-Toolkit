;---------------------------------------------------------------------------
;
; Copyleft by yiyaowen (L) October, 2024
; Also see: https://github.com/yiyaowen/SKILL-Toolkit
;
;---------------------------------------------------------------------------
;
; fixSpiceIn.il
;
;---------------------------------------------------------------------------
;
; - Examples:
;   fixSpiceIn("tsmc18aio6mt")
;
;---------------------------------------------------------------------------
procedure(fixSpiceIn(libName)
    foreach(cell ddGetObj(libName)->cells
        when(cv = dbOpenCellViewByType(libName cell->name "schematic" nil "a")
            foreach(inst cv->instances
                ;-----------------------------------------------------------
                ; Customize your mapping rules BELOW
                ;-----------------------------------------------------------
                when(inst->cellName == "nmos2v"
                    ; adding the missing unit "u" for these parameters
                    inst->l = evalstring(strcat(artMakeString(inst->L) "u"))
                    inst->w = evalstring(strcat(artMakeString(inst->W) "u"))
                )
                ;-----------------------------------------------------------
                ; Customize your mapping rules ABOVE
                ;-----------------------------------------------------------
            )
            schCheck(cv)
            dbSave(cv)
            dbClose(cv)
        )
    )
)
