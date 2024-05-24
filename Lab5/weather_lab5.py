from pyspark.sql import SparkSession
from pyspark.sql.functions import col, expr


spark = SparkSession.builder.appName("FilterWeatherData") \
    .config("spark.hadoop.fs.hdfs.impl", "org.apache.hadoop.fs.LocalFileSystem") \
    .config("spark.hadoop.mapreduce.framework.name", "local") \
    .config("spark.sql.warehouse.dir", "file:/tmp") \
    .getOrCreate()



weather_data = spark.read.json("weather.json")


filtered_data = weather_data.select(
    col("lat"),
    col("lon"),
    col("timezone"),
    col("timezone_offset"),
    col("daily.dt").alias("dt"),
    col("daily.temp.day").alias("day_temp"),
    expr("daily.feels_like.day[0]").alias("day_feels_like"),
    expr("daily.weather[0].description").alias("description")
).filter(col("day_feels_like") < 15)


filtered_data.write.json("fall_weather.json")

print("Filtered data saved to fall_weather.json")
spark.stop()
