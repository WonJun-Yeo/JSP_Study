function check(){
    with(document.msgwrite){
        if(subject.value.length == 0){
            alert("제목을 입력해 주세요!!");
            subject.focus();
            return false;
            }
        
        if(name.value.length == 0){
            alert("이름을 입력해 주세요!!");
            name.focus();
            return false;
            }
        
        if(password.value.length == 0){
            alert("비밀번호를 입력해 주세요!!");
            password.focus();
            return false;
            }
        
        if(content.value.length == 0){
            alert("내용을 입력해주세요!!");
            content.focus();
            return false;
            }
        
        document.msgwrite.submit();
    }
}