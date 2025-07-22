;---------------------------------------------------------------------------
;
; Copyleft by yiyaowen (L) October, 2024
; Also see: https://github.com/yiyaowen/SKILL-Toolkit
;
;---------------------------------------------------------------------------
;
; Saves all matched schematics in your workspace by name.
; For example, use it after renumbering instances in your workspace
; to make sure the changed schematics are saved properly before exiting.
; In addition, it is also useful when you want to check whether there
; are any extract-warnings/errors of specific schematics in you workspace.
;
;---------------------------------------------------------------------------
;
; - Params:
;   ---------
;   | names |
;   ---------
;   Specifies names of schematics to be saved.
;
;   ------------
;   | libNames |
;   ------------
;   Specifies libraries that you want to search.
;
;   ------------------
;   | exceptLibNames |
;   ------------------
;   Specifies libraries that you do not want to search.
;
; - Notes:
;   #. When @libNames is set, @exceptLibNames will be ignored, and vice versa.
;
; - Examples:
;   1. saveSchematics() ; saves all schematics
;   4. saveSchematics(?names '("schematic_tb"))
;   2. saveSchematics(?libNames '("Workspace"))
;   3. saveSchematics(?exceptLibNames '("tsmc18"))
;
;---------------------------------------------------------------------------
procedure(saveSchematics(@key (names '("schematic")) (libNames '()) (exceptLibNames '()))
    targetLibNames = libNames
    when(length(targetLibNames) == 0
        targetLibNames = ddGetLibList()~>name
        ; you can modifiy sysLibNames to change the default excepted
        sysLibNames = append(exceptLibNames
            '("cdsDefTechLib" "basic" "US_8ths" "analogLib" "functional"
              "rfLib" "rfExamples" "ahdlLib" "rfTlineLib" "connectLib"))
        foreach(libName sysLibNames
            ; remd(libName targetLibNames)
            ; there seems to be a bug of remd in IC618.64bit environment
            targetLibNames = remove(libName targetLibNames)
        )
    )
    foreach(libName targetLibNames
        foreach(cell ddGetObj(libName)->cells
            foreach(name names
                when(cv = dbOpenCellViewByType(libName cell->name name nil "a")
                    schCheck(cv)
                    dbSave(cv)
                    dbClose(cv)
                )
            )
        )
    )
)
