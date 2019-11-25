# dsLab-mapReduce

### Start the Hadoop Cluster
- Start the Hadoop Distributed File System cluster in standalone mode
-

### Mapper
<details>
    <summary>Mapper Code</summary>

```
package ie.gmit.ds;  

import java.io.IOException;    
import java.util.StringTokenizer;    
import org.apache.hadoop.io.IntWritable;    
import org.apache.hadoop.io.LongWritable;    
import org.apache.hadoop.io.Text;    
import org.apache.hadoop.mapred.MapReduceBase;    
import org.apache.hadoop.mapred.Mapper;    
import org.apache.hadoop.mapred.OutputCollector;    
import org.apache.hadoop.mapred.Reporter;    
public class WC_Mapper extends MapReduceBase implements Mapper<LongWritable,Text,Text,IntWritable>{    
    private final static IntWritable one = new IntWritable(1);    
    private Text word = new Text();    
    public void map(LongWritable key, Text value,OutputCollector<Text,IntWritable> output, Reporter reporter) throws IOException{    
        String line = value.toString();    
        StringTokenizer  tokenizer = new StringTokenizer(line);    
        while (tokenizer.hasMoreTokens()){    
            word.set(tokenizer.nextToken());    
            output.collect(word, one);    
        }    
    }    
}  
```    

</details>

### Reducer

<details>
    <summary>Reducer Code</summary>

```   
package ie.gmit.ds;  

import java.io.IOException;    
import java.util.Iterator;    
import org.apache.hadoop.io.IntWritable;    
import org.apache.hadoop.io.Text;    
import org.apache.hadoop.mapred.MapReduceBase;    
import org.apache.hadoop.mapred.OutputCollector;    
import org.apache.hadoop.mapred.Reducer;    
import org.apache.hadoop.mapred.Reporter;    

public class WC_Reducer  extends MapReduceBase implements Reducer<Text,IntWritable,Text,IntWritable> {    
    public void reduce(Text key, Iterator<IntWritable> values,OutputCollector<Text,IntWritable> output, Reporter reporter) throws IOException {    
        int sum=0;    
        while (values.hasNext()) {    
            sum+=values.next().get();    
        }    
        output.collect(key,new IntWritable(sum));    
    }    
}
```

</details>


### Runner

<details>
    <summary>Job Runner Code</summary>

```
package ie.gmit.ds;  

import java.io.IOException;    
import org.apache.hadoop.fs.Path;    
import org.apache.hadoop.io.IntWritable;    
import org.apache.hadoop.io.Text;    
import org.apache.hadoop.mapred.FileInputFormat;    
import org.apache.hadoop.mapred.FileOutputFormat;    
import org.apache.hadoop.mapred.JobClient;    
import org.apache.hadoop.mapred.JobConf;    
import org.apache.hadoop.mapred.TextInputFormat;    
import org.apache.hadoop.mapred.TextOutputFormat;    

public class WC_Runner {    
    public static void main(String[] args) throws IOException{    
        JobConf conf = new JobConf(WC_Runner.class);    
        conf.setJobName("WordCount");    
        conf.setOutputKeyClass(Text.class);    
        conf.setOutputValueClass(IntWritable.class);            
        conf.setMapperClass(WC_Mapper.class);    
        conf.setCombinerClass(WC_Reducer.class);    
        conf.setReducerClass(WC_Reducer.class);         
        conf.setInputFormat(TextInputFormat.class);    
        conf.setOutputFormat(TextOutputFormat.class);           
        FileInputFormat.setInputPaths(conf,new Path(args[0]));    
        FileOutputFormat.setOutputPath(conf,new Path(args[1]));     
        JobClient.runJob(conf);    
    }    
}    
```

</details>

### Usage
Assuming HADOOP_HOME is the root of the installation and HADOOP_VERSION is the Hadoop version installed, compile WordCount.java and create a jar:

```
mkdir wordcount_classes
javac -classpath ${HADOOP_HOME}/hadoop-${HADOOP_VERSION}-core.jar -d wordcount_classes .
jar -cvf /usr/joe/wordcount.jar -C wordcount_classes/ .
````
