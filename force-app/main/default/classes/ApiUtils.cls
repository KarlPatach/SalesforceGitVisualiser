public with sharing class ApiUtils {
    public static String apiUrlToGitHub(String rawString){
        if (rawString == null) return null;
        return rawString.replaceFirst('api.github.com/repos','github.com');
    }

}
