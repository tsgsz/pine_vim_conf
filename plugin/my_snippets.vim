" Pine's extension

if !exists("g:name")
  let g:name = 'Pine'
endif

if !exists("g:email")
  let g:email = 'tsgsz <cdtsgsz@baidu.com>'
endif

" Common templates
let g:template['_']['em'] = "        ".g:email.""

" C templates
let g:template['c']['df'] = "#define "
let g:template['c']['ic'] = "#include \"".g:rs."...".g:re."\""
let g:template['c']['ii'] = "#include <".g:rs."...".g:re.">"
let g:template['c']['it'] = "#include \"thirdparty/".g:rs."...".g:re."\""
let g:template['c']['ff'] = "#ifndef \<c-r>=GetFileName()\<cr>\<CR>#define \<c-r>=GetFileName()\<CR>".
            \repeat("\<cr>",1)."#endif  // \<c-r>=GetFileName()\<cr>".repeat("\<up>",3)

let g:template['c']['for'] = "for (".g:rs."...".g:re."; ".g:rs."...".g:re."; ".g:rs."...".g:re.") {\<cr>".
            \g:rs."...".g:re."\<cr>}\<cr>"
let g:template['c']['main'] = "int main(int argc, char \*argv\[\]) {\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['switch'] = "switch (".g:rs."...".g:re.") {\<cr>case ".g:rs."...".g:re." :\<cr>break;\<cr>case ".
            \g:rs."...".g:re." :\<cr>break;\<cr>default :\<cr>break;\<cr>}"
let g:template['c']['if'] = "if (".g:rs."...".g:re.") {\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['ifd'] = "#ifdef DEBUG\<cr>\tcout << __FILE__ << \":\" << __LINE__ << \":\" << ".g:rs."...".g:re." << endl;\<cr>#endif"
let g:template['c']['while'] = "while (".g:rs."...".g:re.") {\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['ife'] = "if (".g:rs."...".g:re.") {\<cr>".g:rs."...".g:re."\<cr>} else {\<cr>".g:rs."...".
            \g:re."\<cr>}"

let g:template['c']['re'] = "return ".g:rs."...".g:re.";"
let g:template['c']['ret'] = "return true;"
let g:template['c']['ref'] = "return false;"
let g:template['c']['td'] = "// TODO(".g:name."): ".g:rs."...".g:re.""

let g:template['c']['pr'] = "printf(\"".g:rs."...".g:re."\", ".g:rs."...".g:re.");"


" C++ templates
let g:template['cpp'] = g:template['c']
let g:template['cpp']['us'] = "using "
let g:template['cpp']['un'] = "using namespace ".g:rs."...".g:re.";"
let g:template['cpp']['nm'] = "namespace ".g:rs."...".g:re." {\n\n}  // namespace ".g:rs."...".g:re
let g:template['cpp']['kl'] = "namespace klnd {\n\n}  // namespace klnd"

let g:template['cpp']['cl'] = "class ".g:rs."...".g:re." {\<cr>".g:rs."...".g:re."\<cr>};"
let g:template['cpp']['st'] = "struct ".g:rs."...".g:re." {\<cr>".g:rs."...".g:re."\<cr>};"

let g:template['cpp']['cout'] = "std::cout << ".g:rs."...".g:re." << std::endl;"
let g:template['cpp']['err'] = "LOG(ERROR) << \"".g:rs."...".g:re."\";"
let g:template['cpp']['inf'] = "LOG(INFO) << \"".g:rs."...".g:re."\";"
let g:template['cpp']['fat'] = "LOG(FATAL) << \"".g:rs."...".g:re."\";"
let g:template['cpp']['war'] = "LOG(WARNING) << \"".g:rs."...".g:re."\";"

let g:template['cpp']['v1'] = "VLOG(10) << \"".g:rs."...".g:re."\";"
let g:template['cpp']['v2'] = "VLOG(20) << \"".g:rs."...".g:re."\";"
let g:template['cpp']['v3'] = "VLOG(30) << \"".g:rs."...".g:re."\";"
let g:template['cpp']['v4'] = "VLOG(40) << \"".g:rs."...".g:re."\";"

let g:template['cpp']['A'] = "ASSERT_"
let g:template['cpp']['AT'] = "ASSERT_TRUE("
let g:template['cpp']['AF'] = "ASSERT_FALSE("
let g:template['cpp']['AD'] = "ASSERT_DEATH("
let g:template['cpp']['AD'] = "ASSERT_DEATH(".g:rs."...".g:re.", \"\");"
let g:template['cpp']['E'] = "EXPECT_"
let g:template['cpp']['ET'] = "EXPECT_TRUE("
let g:template['cpp']['EF'] = "EXPECT_FALSE("
let g:template['cpp']['ED'] = "EXPECT_DEATH(".g:rs."...".g:re.", \"\");"
let g:template['cpp']['C'] = "CHECK"
let g:template['cpp']['CN'] = "CHECK_NOTNULL("
let g:template['cpp']['T'] = "TEST_F("
let g:template['cpp']['ut'] = "class ".g:rs."...".g:re."Test : public ::testing::Test {\<cr>protected:\<cr>virtual void SetUp() {\<cr>}\<cr>virtual void TearDown() {\<cr>}\<cr>};"
let g:template['cpp']['F'] = "FLAGS_"
let g:template['cpp']['i3'] = "#include \"thirdparty/".g:rs."...".g:re."\""


function! GET_UP_PATH(dirname)
    let dest_path = ""
    let dir = a:dirname
    let length=len(dir)
    if findfile("KLND_ROOT", dir) != ""
        return dest_path
    endif

    echo dest_path

    while length>0
        let rpos=strridx(dir, "/")
        let right_dir=strpart(dir, rpos+1, length)
        let dir=strpart(dir, 0, rpos)
        let length=len(dir)
        let dest_path = right_dir."/".dest_path
        if findfile("KLND_ROOT", dir) != ""
            break
        endif
    endwhile

    echo dest_path

    return  dest_path
endfunction

" [Get converted file name like PATH_FILE_ ]
function! GetFileName()
    let dirname=expand("%:p:h")
    let dirname=GET_UP_PATH(dirname)
"    echo dirname
    let _name=substitute(dirname,'/','_',"g")

    let filename=expand("%:t")
    let _name .= substitute(filename,'\.','_',"g")
    let _name .= "_"
    let _name=toupper(_name)

    return _name
endfunction
