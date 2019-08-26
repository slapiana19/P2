public class IllnessFeedController {
    
    public String SelectedIllnessName{
        get;
        set{
            System.debug('Selected Illness Name is:' + value);
            SelectedIllnessName = value;
            SelectedIllness = [SELECT Id, Name FROM Illness__c WHERE Name=: this.SelectedIllnessName LIMIT 1]; //set actual selected illness based on name
        }
        
    }
    
    public PageReference enterFeed(){
        return Page.IllnessFeedPage;
    }
    
    public PageReference exitFeed(){
        return Page.IllnessFeed;
    }
    
    public List<Illness__c> Illnesses{
        get{
            return [SELECT Name FROM Illness__c];
        }
        set;
    }
    
    public List<SelectOption> IllnessNames{
        get{
            List<SelectOption> IllnessNames = new List<SelectOption>(); 
            
            for(Illness__c Illness : this.Illnesses){ //copy names from list of illnesses into new list
                IllnessNames.add(new SelectOption(Illness.Name, Illness.Name));
            }
            System.debug('Here is the list:'+IllnessNames);
            return IllnessNames;
        }
        set;
    }
    
    public Illness__c SelectedIllness{
        get;
        set{
            System.debug('Selected Illness is:' + value);
            SelectedIllness = [SELECT Id, Name FROM Illness__c WHERE Name=: this.SelectedIllnessName LIMIT 1];
        }
        
    }
    

}