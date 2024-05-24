package org.example;

import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.sql.SparkSession;
import scala.Tuple2;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class UniqueWordsCount {

    private static final Set<String> stopWordsSet = new HashSet<>(Arrays.asList(
            "into", "is", "it", "no", "not", "of", "a", "an", "and", "are", "as", "they",
            "their", "then", "there", "these", "on", "or", "such", "that", "the", "to",
             "was", "will", "with", "at", "be", "but", "by", "for", "if", "in", "this"
            ));

    public static void main(String[] args) {

        String file = "/home/kenilpatel121200/reut2-009.sgm";

        try {
            SparkSession spark = SparkSession.builder().appName("WordCountApp").getOrCreate();
            JavaSparkContext context = new JavaSparkContext(spark.sparkContext());

            Path filePath1 = Paths.get(file);
            StringBuilder sb = new StringBuilder();
            Files.lines(filePath1, StandardCharsets.UTF_8).forEach(
                    line -> sb.append(line).append("\n"));
            String input_string = sb.toString();

            String cleanedText = cleanseText(input_string);

            JavaRDD<String> lines = context.parallelize(Arrays.asList(cleanedText.split(" ")));

            JavaPairRDD<String, Integer> wordCounts = lines
                    .flatMapToPair(line -> Arrays.asList(line.split(" ")).stream()
                            .map(word -> new Tuple2<>(word, 1))
                            .iterator())
                    .reduceByKey(Integer::sum);

            JavaPairRDD<String, Integer> singleCountWords = wordCounts.filter(pair -> pair._2() == 1);
            List<Tuple2<String, Integer>> singleCountResults = singleCountWords.collect();

            writeUniqueWordsToFile(singleCountResults, "/home/kenilpatel121200/uniqueWords.txt");
            long totalUniqueWords = singleCountResults.size();
            System.out.println(" Total no. of Unique Words are " + totalUniqueWords);

            Tuple2<String, Integer> highestFrequencyWord = wordCounts.reduce((t1, t2) -> t1._2() > t2._2() ? t1 : t2);
            Tuple2<String, Integer> lowestFrequencyWord = wordCounts.reduce((t1, t2) -> t1._2() < t2._2() ? t1 : t2);

            System.out.println("Highest Frequency Word is " + highestFrequencyWord._1() + " with the frequency of "
                    + highestFrequencyWord._2());
            System.out.println("Lowest Frequency Word is " + lowestFrequencyWord._1() + " with the frequency of "
                    + lowestFrequencyWord._2());

            context.stop();
            spark.stop();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void writeUniqueWordsToFile(List<Tuple2<String, Integer>> singleCountResults, String outputFilePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFilePath))) {
            for (Tuple2<String, Integer> tuple : singleCountResults) {
                writer.write(tuple._1() + "\n"); // Writing each unique word to a new line in the file
            }
            System.out.println("Unique words written to file: " + outputFilePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    private static String cleanseText(String text) {
        text = text.replaceAll("<.*?>", "");
        text = text.replaceAll("[^a-zA-Z\\s]", "");
        text = text.replaceAll("\\b\\w\\b", "");
        text = text.replaceAll("\\s+", " ");
        text = text.toLowerCase();
        text = removeStopWords(text);
        return text.trim();
    }

    private static String removeStopWords(String text) {
        String[] words = text.split("\\s+");

        words = Arrays.stream(words)
                .filter(word -> !stopWordsSet.contains(word.toLowerCase()))
                .toArray(String[]::new);

        return String.join(" ", words);
    }

}