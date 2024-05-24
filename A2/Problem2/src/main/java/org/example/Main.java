package org.example;

import java.io.*;
import java.util.*;
import java.util.regex.*;

public class Main {
    public static void main(String[] args) {
        String[] filenames = {"src/main/resources/reut2-009.sgm", "src/main/resources/reut2-014.sgm"};
        List<String> allTitles = retrieveTitles(filenames);
        List<Map<String, Integer>> titleWordList = createTitleWordList(allTitles);
        List<String> positiveWords = readFile("src/main/resources/positive_words.txt");
        List<String> negativeWords = readFile("src/main/resources/negative_words.txt");

        List<String> polarity = new ArrayList<>();
        List<List<String>> matchedWordsInTitle = new ArrayList<>();
        List<Integer> scores = new ArrayList<>();
        for (Map<String, Integer> titleWords : titleWordList) {
            List<String> matchedWords = new ArrayList<>();
            int score = calculateScore(titleWords, positiveWords, negativeWords, matchedWords);
            matchedWordsInTitle.add(matchedWords);
            scores.add(score);
            if (score > 0) {
                polarity.add("positive");
            } else if (score < 0) {
                polarity.add("negative");
            } else {
                polarity.add("neutral");
            }
        }

        saveResults(allTitles, matchedWordsInTitle, scores, polarity);
    }


    public static List<String> retrieveTitles(String[] fileNames) {
        List<String> allTitles = new ArrayList<>();

        for (String fileName : fileNames) {
            List<String> titles = new ArrayList<>();
            StringBuilder content = new StringBuilder();

            try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
                String line;
                while ((line = br.readLine()) != null) {
                    content.append(line);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            String fileContent = content.toString();

            Pattern pattern = Pattern.compile("<TITLE>(.*?)</TITLE>");
            Matcher matcher = pattern.matcher(fileContent);

            while (matcher.find()) {
                String title = matcher.group(1);
                String[] words = title.split("\\s+");
                StringBuilder cleanTitle = new StringBuilder();

                for (String word : words) {
                    if (!word.startsWith("&lt;")) {
                        cleanTitle.append(word).append(" ");
                    }
                }

                titles.add(cleanTitle.toString().trim().toLowerCase());
            }
            allTitles.addAll(titles);
        }

        return allTitles;
    }

    private static List<Map<String, Integer>> createTitleWordList(List<String> titles) {
        List<Map<String, Integer>> titleWordList = new ArrayList<>();

        for (String title : titles) {
            Map<String, Integer> wordsList = new HashMap<>();
            String[] words = title.split("\\s+");

            for (String word : words) {
                word = word.toLowerCase();
                wordsList.put(word, wordsList.getOrDefault(word, 0) + 1);
            }

            titleWordList.add(wordsList);
        }

        return titleWordList;
    }

    private static List<String> readFile(String fileName) {
        List<String> words = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
            String line;
            while ((line = br.readLine()) != null) {
                words.add(line.trim());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return words;
    }


    private static int calculateScore(Map<String, Integer> titleWords, List<String> positiveWords,
                                      List<String> negativeWords, List<String> matchedWords) {
        int score = 0;
        for (Map.Entry<String, Integer> entry : titleWords.entrySet()) {
            String word = entry.getKey();
            if (positiveWords.contains(word)) {
                matchedWords.add(word);
                score += entry.getValue();
            } else if (negativeWords.contains(word)) {
                matchedWords.add(word);
                score -= entry.getValue();
            }
        }
        return score;
    }

    private static void saveResults(List<String> allTitles, List<List<String>> matchedWordsInTitle,
                                       List<Integer> scores, List<String> polarity) {
        try (PrintWriter writer = new PrintWriter(new FileWriter("src/main/resources/output.txt"))) {
            writer.println("---------------------------------------------------------------------------------------" +
                    "----------------------------------------------------------------------------");
            writer.printf("| %-6s | %-100s | %-27s | %-5s | %-9s |%n", "News#", "Title Content", "Match Words", "Score", "Polarity");
            writer.println("---------------------------------------------------------------------------------------" +
                    "----------------------------------------------------------------------------");

            for (int i = 0; i < allTitles.size(); i++) {
                String title = allTitles.get(i);
                String formattedTitle = title.length() > 100 ? title.substring(0, 97) + "..." : title;
                List<String> matchedWordsSeparate = matchedWordsInTitle.get(i);
                String matchedWords = String.join(", ", matchedWordsSeparate);

                writer.printf("| %-6d | %-100s | %-27s | %-5d | %-9s |%n", (i + 1), formattedTitle.toUpperCase(), matchedWords,
                        scores.get(i), polarity.get(i));
            }
            writer.println("--------------------------------------------------------------------------------------" +
                    "-----------------------------------------------------------------------------");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}