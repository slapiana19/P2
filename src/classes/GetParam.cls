public class GetParam 
{

    public String name {
        get;
        set;
    }
    
    public Id doctorId {
        get;
        set;
    }
    
	public GetParam(ApexPages.StandardController stdController) {
        name = System.currentPagereference().getParameters().get('doctorName');
		doctorId = System.currentPagereference().getParameters().get('doctorId');
    }
}