set ts=4
set expandtab
set tabstop=4
set shiftwidth=4

map <F5> :call CompileAndRun()<CR>

func ShowCompile()
    exec "silent !echo ~~~~~~~~~~~~"
    exec "silent !echo Compiling..."
    exec "silent !echo ~~~~~~~~~~~~"
endfunc

func ShowRun()
    exec "silent !echo "
    exec "silent !echo ~~~~~~~~~~~~"
    exec "silent !echo Running....."
    exec "silent !echo ~~~~~~~~~~~~"
endfunc

func CompileAndRun()
    exec "w"
    let b:ext = expand('%:e')
    let b:name = expand('%:r')
    if b:ext == "go"
        exec "!go run %"
    elseif b:ext == "py"
        exec "!chmod +x %"
        exec "!./%"
    elseif b:ext == "sh"
        exec "!sh %"
    elseif b:ext == "c"
        call ShowCompile()
        exec "silent !gcc -lm -std=c99 -o auto_run.out %"
        call ShowRun()
        exec "!./auto_run.out"
        exec "silent !rm auto_run.out"
    elseif b:ext == "cpp"
        call ShowCompile()
        exec "silent !g++ -std=c++11 -o auto_run.out %"
        call ShowRun()
        exec "!./auto_run.out"
        exec "silent !rm auto_run.out"
    elseif b:ext == "ml"
        call ShowCompile()
        exec "silent !ocamlbuild -I +camlp4 %:r.native"
        call ShowRun()
        exec "!./%:r.native"
        exec "silent !rm %:r.native && rm -r _build"
    endif
endfunc

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
