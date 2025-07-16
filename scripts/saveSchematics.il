; Saves all matched schematics in your workspace by name.
; For example, use it after renumbering instances in your workspace
; to make sure the changed schematics are saved properly before exiting.
; In addition, it is also useful when you want to check whether there
; are any extract-warnings/errors of specific schematics in you workspace.
;
; Copyleft by yiyaowen (L) October, 2024
; Also see: https://github.com/yiyaowen/SKILL-Toolkit
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
;   This could be the external libraries in your workspace,
;   such as the PDK libraries (SMIC, TSMC, UMC etc.).
;   In addition, most of the system libraries of Cadence
;   have already been excepted by default (see the code below).
;
; - Notes:
;   #. When @libNames is specified, @exceptLibNames will be ignored.
;
; - Examples:
;   1. saveSchematics ; saves all schematics
;   2. saveSchematics(?libNames '("Workspace"))
;   3. saveSchematics(?exceptLibNames '("umc28hpc"))
;   4. saveSchematics(?names '("schematic" "schematic_raw"))
;
procedure(saveSchematics(@key (names '("schematic")) (libNames '()) (exceptLibNames '()))
    targetLibNames = libNames
    if(length(targetLibNames) == 0
    then
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
        cells = ddGetObj(libName)->cells
        foreach(cell cells
            foreach(name names
                if(openCell = car(errset(
                    dbOpenCellViewByType(libName cell->name name nil "a")))
                then
                    if(schCheck(openCell) != '(0 0)
                    then
                        ; you can find underlines in your CIW (if have),
                        ; which mean there are errors in the related schematics
                        printf("===========================")
                        printf("===========================\n")
                    )
                    if(dbSave(openCell) == nil
                    then
                        printf("%s: dbSave failed\n" cell->name)
                    )
                    dbClose(openCell)
                )
            )
        )
    )
)
