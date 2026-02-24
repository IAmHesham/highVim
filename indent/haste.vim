if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

setlocal indentexpr=GetHasteIndent()
setlocal indentkeys=o,O,},),],<CR>

function! GetHasteIndent() abort
	let lnum = v:lnum

	" First line → no indent
	if lnum == 1
		return 0
	endif

	let prev = prevnonblank(lnum - 1)
	if prev == 0
		return 0
	endif

	let prevline = getline(prev)
	let curline  = getline(lnum)

	let indent = indent(prev)

	" Increase indent after opening braces
	if prevline =~ '{\s*$'
		let indent += &shiftwidth
	endif

	" Decrease indent for closing braces
	if curline =~ '^\s*}'
		let indent -= &shiftwidth
	endif

	" Parentheses alignment (soft)
	if prevline =~ '(\s*$'
		let indent += &shiftwidth
	endif

	if curline =~ '^\s*)'
		let indent -= &shiftwidth
	endif

	return max([indent, 0])
endfunction
