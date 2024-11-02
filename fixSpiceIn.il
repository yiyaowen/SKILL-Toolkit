; Copyleft by yiyaowen (L) October, 2024
; Also see: https://github.com/yiyaowen/SKILL-Toolkit
;
; - Params:
;   -----------
;   | libName |
;   -----------
;   Specifies the library you want to fix.
;
; - Examples:
;   fixSpiceIn("UMC28_BOAC_2A_1031")
;
procedure(fixSpiceIn(libName)
    cells = ddGetObj(libName)~>cells
    foreach(cell cells
        when(cv = dbOpenCellViewByType(libName cell~>name "schematic" "" "a")
            insts = cv->instances
            foreach(inst insts
                when(
                    inst->cellName == "P_1P8" ||
                    inst->cellName == "N_1P8" ||
                    inst->cellName == "P_SVT" ||
                    inst->cellName == "N_SVT"
                    ; you can customize your mapping rules below
                    inst->m = evalstring(strcat(artMakeString(inst->M) ""))
                    inst->l = evalstring(strcat(artMakeString(inst->L) "u"))
                    inst->w = evalstring(strcat(artMakeString(inst->W) "u"))
                    inst->fw = evalstring(strcat(artMakeString(inst->W) "u"))
                )
            )
            schCheck(cv)
            dbSave(cv)
            dbClose(cv)
        )
    )
)
