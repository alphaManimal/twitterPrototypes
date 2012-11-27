//Build an ArrayList to hold all of the words that we get from the imported tweets
//some stuff
ArrayList<String> words = new ArrayList();
int xPos = 0;

void setup() {
  //Set the size of the stage, and the background to black.
  size(1550,100);
  background(0);
  smooth();

  //Credentials
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("8SfwAd49CQ5YGGShvrO9Yg");
  cb.setOAuthConsumerSecret("lsX9VIKnWui5oXuY4FAxoYdb8yFFmSWcvxbpe2b4I");
  cb.setOAuthAccessToken("39902369-SK80VJJybF1dw97z0d7DWjPGJ8KRB4h0c1zUT5qoP");
  cb.setOAuthAccessTokenSecret("yo2AsfS47vesvfj5vNLC3IAlxs16VqDNY0guncxrkc");

  //Make the twitter object and prepare the query
  Twitter twitter = new TwitterFactory(cb.build()).getInstance();
  Query query = new Query("#OWS");
  query.setCount(100);

  //Try making the query request.
  try {
    QueryResult result = twitter.search(query);
    ArrayList tweets = (ArrayList) result.getTweets();

    for (int i = 0; i < tweets.size(); i++) {
      Status t = (Status) tweets.get(i);
      
      User u = t.getUser();
      String user = u.getName();
      
      String msg = t.getText();
      
      Date d = t.getCreatedAt();
      
      
      println("Tweet by " + user + " at " + d + ": " + msg);

      //Break the tweet into words
      String[] input = msg.split(" ");
      for (int j = 0;  j < input.length; j++) {
       //Put each word into the words ArrayList
       words.add(input[j]);
      }
    };
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  };
}



void draw() {
  //Draw a faint black rectangle over what is currently on the stage so it fades over time.
  background(0);
  fill(0,1);
  rect(0,0,width,height);

  //Draw a word from the list of words that we've built
  int i = (frameCount % words.size());
  String word = words.get(i);
  
  xPos = (xPos + (20*word.length())) % (width-20);
  
  //Put it somewhere random on the stage, with a random size and colour
  fill(255,random(50,150));
  textSize(20);
  text(word, xPos , (height/2)+20);
  delay(300);
}
