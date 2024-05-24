package org.example;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import org.bson.Document;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class Main {
    public static void main(String[] args) {
        try {
            MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
            MongoDatabase db = mongoClient.getDatabase("NewsDb");
            cleaningFile(db, "src/main/resources/reut2-009.sgm");
            cleaningFile(db, "src/main/resources/reut2-014.sgm");

            mongoClient.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void cleaningFile(MongoDatabase db, String sgmFilename) throws IOException {
        String fileData = new String(Files.readAllBytes(Paths.get(sgmFilename)));

        String[] newsArticles = fileData.split("<REUTERS");

        for (String newsArticle : newsArticles) {
            if (!newsArticle.trim().isEmpty()) {
                String title = retrieveContent(newsArticle, "TITLE");
                String body = retrieveContent(newsArticle, "BODY");
                if (!title.isEmpty() && !body.isEmpty()) {
                    String dateTimeString = retrieveContent(newsArticle, "DATE");
                    String[] dateTime = dateTimeString.split(" ");
                    String date = dateTime[0];
                    String time = dateTime[1];
                    String place = retrieveContent(newsArticle, "PLACES");
                    Document document = new Document("title", title)
                            .append("body", body)
                            .append("date", date)
                            .append("time", time)
                            .append("place", place);
                    MongoCollection<Document> collection = db.getCollection("news");
                    collection.insertOne(document);
                }
            }
        }
    }

    private static String retrieveContent(String newsArticle, String htmlTag) {
        String startTag, endTag;
        int startPoint, endPoint;
        if (htmlTag.equals("PLACES")){
            startTag = "<PLACES>";
            endTag = "</PLACES>";
            String dStartTag = "<D>";
            String dEndTag = "</D>";

            startPoint = newsArticle.indexOf(startTag);
            if (startPoint == -1) {
                return "";
            }
            startPoint += startTag.length();
            int endIndex = newsArticle.indexOf(endTag, startPoint);
            if (endIndex == -1) {
                return "";
            }
            String placesContent = newsArticle.substring(startPoint, endIndex);
            StringBuilder places = new StringBuilder();
            int dStartPoint = placesContent.indexOf(dStartTag);
            while (dStartPoint != -1) {
                dStartPoint += dStartTag.length();
                int dEndIndex = placesContent.indexOf(dEndTag, dStartPoint);
                if (dEndIndex == -1) {
                    break;
                }
                String place = placesContent.substring(dStartPoint, dEndIndex).trim();
                places.append(place).append(", ");
                dStartPoint = placesContent.indexOf(dStartTag, dEndIndex);
            }
            if (places.length() > 0) {
                places.setLength(places.length() - 2);
            }
            return places.toString();
        }
        else {
            startTag = "<" + htmlTag + ">";
            endTag = "</" + htmlTag + ">";
        }
        startPoint = newsArticle.indexOf(startTag);
        if (startPoint == -1) {
            return "";
        }
        startPoint += startTag.length();
        endPoint = newsArticle.indexOf(endTag, startPoint);
        if (endPoint == -1) {
            return "";
        }
        return newsArticle.substring(startPoint, endPoint).trim();
    }
}
