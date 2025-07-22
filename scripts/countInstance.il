;---------------------------------------------------------------------------
;
; Copyleft by yiyaowen (L) July, 2025
; Also see: https://github.com/yiyaowen/SKILL-Toolkit
;
;---------------------------------------------------------------------------
;
; - Examples:
;   countInstance("nmos2v" "SRAMLib" "MEM_8x8")
;
;---------------------------------------------------------------------------
procedure(_getInstNameInfo(instName)
    a1 = nil
    a2 = nil
    b1 = nil
    b2 = nil
    for(i 1 length(instName)
        case(substring(instName i 1)
        ("<" (a1 = i+1))
        (":" (a2 = i) (b1 = i+1))
        (">" (b2 = i))
        )
    )
    if(a1 && a2 && b1 && b2
    then
        baseName = substring(instName 1 a1-2)
        c1 = evalstring(substring(instName a1 a2-a1))
        c2 = evalstring(substring(instName b1 b2-b1))
        list(baseName c1 c2)
    else
        list(instName nil nil)
    )
)
procedure(_getInstCountRecurse(cv cellName)
    instCount = 0
    foreach(inst cv->instances
        subInstMulti = 1
        info = _getInstNameInfo(inst->name)
        when(car(info) != inst->name
            subInstMulti = abs(nthelem(2 info)-nthelem(3 info))+1
        )
        if(inst->cellName == cellName
        then
            instCount += subInstMulti
        else
            when(member("schematic" dbAllCellViews(ddGetObj(inst->libName) inst->cellName))
                when(cv2 = dbOpenCellViewByType(inst->libName inst->cellName "schematic" nil "r")
                    instCount += subInstMulti * _getInstCountRecurse(cv2 cellName)
                    ; Not clear why dbClose can crash here. Add an errset to ignore it.
                    errset(dbClose(cv2)) ; *Error* dbClose: Invalid cellView - db:0x6db84a1a
                )
            )
        )
    )
    instCount
)
procedure(countInstance(name @optional (libName nil) (topName nil))
    cv = nil
    if(topName && libName
    then
        cv = dbOpenCellViewByType(libName topName "schematic" nil "r")
    else
        cv = deGetCellView(hiGetCurrentWindow())
    )
    when(cv
        instCount = _getInstCountRecurse(cv name)
        printf("Total (%d) %s found", instCount, name)
        when(topName && libName errset(dbClose(cv)))
    )
)
