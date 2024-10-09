public class ListDemo {
    public void listMethod(){
        List<String> strList = new List<String>();
        List<String> strList2 = new List<String>();
        Set<String> strSet = new Set<String>();
        
        strList.add('India');
        strList.add('USA');
        strList.add(1, 'Israel');
        
        strSet.add('Japan');
        strList2.addAll(strSet);
        
        system.debug('strList =>' +strList);
        strList2.add('Australia');
        strList2.addAll(strList);
        system.debug('strList2 =>'+ strList2);
        strList2.clear();
        system.debug('strList2 => ' +strList2);
    }
}