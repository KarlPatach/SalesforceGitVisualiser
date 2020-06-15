public with sharing class ApiUtils {
    public static String apiUrlToGithub(String rawString){
        if (rawString == null) return null;
        return rawString.replaceFirst('api.github.com/repos','github.com');
    }

}
