
import 'package:quiver/collection.dart';
import 'package:tuple/tuple.dart';

import 'package:mood_map/utilities/database.dart';
import 'package:mood_map/utilities/utilities.dart';

import 'package:mood_map/common/category.dart';
import 'package:mood_map/common/specific.dart';
import 'package:mood_map/common/emotion.dart';
import 'package:mood_map/common/emotion_rating.dart';
import 'package:mood_map/common/reminder_settings.dart';

import 'package:mood_map/common/sleep_rating.dart';
import 'package:mood_map/common/exercise_rating.dart';

class FirstTimeDataUploader {

  static List<String> _categories = [ "Work", "Home", "School", "Relationships" ];

  static List<String> _specifics = [ "My Boss ", "Work Tasks", "Coworkers", "My Mom", "My Dad", "My Friends", "My friends", "Homework", "Classmates", "Teachers"];

  static List<String> _emotions = [ "Happiness", "Anger", "Sadness", "Rage", "Doubtful", "Joyful", "Anxious", "Loneliness", "Depression", "Delight", "Frustrated",
                             "Resentful", "Pitiful", "Small", "Elation", "Victorious", "Controlled", "Fast", "Friendly", "Unintelligent", "Capable", "Weak",
                             "Bullied", "Uncool", "Thankful", "Out of Control", "Useless", "Busy", "Helpless", "Jealous"];

  static Multimap<String, String> _categoriesToSpecifics = new Multimap<String, String>();

  static Set<Tuple3<String, String, String>> _contextualizedEmotions = new Set<Tuple3<String, String,String>>();

  static Future<void> uploadUserCreationData() async {

    await _initializeEmotions();
    await _initializeCategorySpecificsMap();
    await _initializeCategories();
    await _initializeSpecifics();
    await _initializeContextualizedEmotionsSet();
    await _initializeContextualizedEmotions();
    await _initializeDefaultReminderData();
  }

  static Future<void> _initializeCategorySpecificsMap() async {

    _categoriesToSpecifics.add("Work", "My Boss");
    _categoriesToSpecifics.add("Work", "Work Tasks");
    _categoriesToSpecifics.add("Work", "Coworkers");
    _categoriesToSpecifics.add("Home", "My Mom");
    _categoriesToSpecifics.add("Home", "My Dad");
    _categoriesToSpecifics.add("Home", "My Children");
    _categoriesToSpecifics.add("Home", "My Friends");
    _categoriesToSpecifics.add("School", "Homework");
    _categoriesToSpecifics.add("School", "Classmates");
    _categoriesToSpecifics.add("School", "Teachers");
    _categoriesToSpecifics.add("Relationships", "My Parents");
    _categoriesToSpecifics.add("Relationships", "My Ex");
    _categoriesToSpecifics.add("Relationships", "My Children");
    _categoriesToSpecifics.add("Relationships", "My Boyfriend");
    _categoriesToSpecifics.add("Relationships", "My Girlfriend");
    _categoriesToSpecifics.add("Relationships", "My Friends");

  }

  static Future<void> _initializeEmotions() async {

    for(String emotion in _emotions) {

      var ref = Database.emotionsPushReference();

      Emotion emotionData = new Emotion("General", "General", emotion);

      ref.set(emotionData.toJson());
    }

  }

  static Future<void> _initializeCategories() async {

    for(String key in _categoriesToSpecifics.keys) {

      var ref = Database.categoriesPushReference();

      String categoryName = key;

      CategoryItem item = new CategoryItem(categoryName);

      ref.set(item.toJson());

    }

  }

  static Future<void> _initializeSpecifics() async {

    _categoriesToSpecifics.forEachKey((String key, Iterable<String> values) {

      String categoriesName = key;

      Iterable<String> specifics = values;

      for(String specific in specifics) {

        var ref = Database.specificsPushReference();

        SpecificsItem item = new SpecificsItem(categoriesName, specific);

        ref.set(item.toJson());

      }

    });

  }

  static Future<void> _initializeContextualizedEmotions() async {

    for(Tuple3 context in _contextualizedEmotions) {

      var ref = Database.emotionsPushReference();

      Emotion contextualizedEmotion = new Emotion(context.item1, context.item2, context.item3);

      ref.set(contextualizedEmotion.toJson());

    }

  }

  static Future<void> _initializeDefaultReminderData() async {

    ReminderSettings settings = new ReminderSettings(
        true,
        "Daily",
        "10:00 AM",
        "8:00 PM",
        true,
        "9:00 AM",
        true,
        "7:00 PM",
        true,
        "8:00 PM");

    var ref = Database.reminderSettingsReference();

    ref.set(settings.toJson());

  }

  static Future<void> _initializeContextualizedEmotionsSet() async {

    _contextualizedEmotions.add(new Tuple3("Work", "My Boss", "Frustration"));
    _contextualizedEmotions.add(new Tuple3("Work", "My Boss", "Capable"));
    _contextualizedEmotions.add(new Tuple3("Work", "My Boss", "Weak"));
    _contextualizedEmotions.add(new Tuple3("Work", "My Boss", "Busy"));
    _contextualizedEmotions.add(new Tuple3("Work", "My Boss", "Small"));
    _contextualizedEmotions.add(new Tuple3("Work", "My Boss", "Happiness"));

    _contextualizedEmotions.add(new Tuple3("Work", "Work Tasks", "Frustration"));
    _contextualizedEmotions.add(new Tuple3("Work", "Work Tasks", "Capable"));
    _contextualizedEmotions.add(new Tuple3("Work", "Work Tasks", "Weak"));
    _contextualizedEmotions.add(new Tuple3("Work", "Work Tasks", "Busy"));
    _contextualizedEmotions.add(new Tuple3("Work", "Work Tasks", "Small"));
    _contextualizedEmotions.add(new Tuple3("Work", "Work Tasks", "Happiness"));

    _contextualizedEmotions.add(new Tuple3("Work", "Coworkers", "Frustration"));
    _contextualizedEmotions.add(new Tuple3("Work", "Coworkers", "Capable"));
    _contextualizedEmotions.add(new Tuple3("Work", "Coworkers", "Weak"));
    _contextualizedEmotions.add(new Tuple3("Work", "Coworkers", "Busy"));
    _contextualizedEmotions.add(new Tuple3("Work", "Coworkers", "Small"));
    _contextualizedEmotions.add(new Tuple3("Work", "Coworkers", "Happiness"));

    _contextualizedEmotions.add(new Tuple3("Home", "My Dad", "Anger"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Dad", "Happiness"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Dad", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Dad", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Dad", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Dad", "Controlled"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Dad", "Bullied"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Dad", "Frustrated"));

    _contextualizedEmotions.add(new Tuple3("Home", "My Mom", "Anger"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Mom", "Happiness"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Mom", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Mom", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Mom", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Mom", "Controlled"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Mom", "Bullied"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Mom", "Frustrated"));

    _contextualizedEmotions.add(new Tuple3("Home", "My Children", "Anger"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Children", "Happiness"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Children", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Children", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Children", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Children", "Controlled"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Children", "Bullied"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Children", "Frustrated"));

    _contextualizedEmotions.add(new Tuple3("Home", "My Friends", "Anger"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Friends", "Happiness"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Friends", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Friends", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Friends", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Friends", "Controlled"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Friends", "Bullied"));
    _contextualizedEmotions.add(new Tuple3("Home", "My Friends", "Frustrated"));

    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Anger"));
    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Frustration"));
    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Happy"));
    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Capable"));
    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Unintelligent"));
    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Anxious"));
    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Doubtful"));
    _contextualizedEmotions.add(new Tuple3("School", "Homework", "Busy"));

    _contextualizedEmotions.add(new Tuple3("School", "Classmates", "Anger"));
    _contextualizedEmotions.add(new Tuple3("School", "Classmates", "Frustration"));
    _contextualizedEmotions.add(new Tuple3("School", "Classmates", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("School", "Classmates", "Happy"));
    _contextualizedEmotions.add(new Tuple3("School", "Classmates", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("School", "Classmates", "Capable"));
    _contextualizedEmotions.add(new Tuple3("School", "Classmates", "Unintelligent"));
    _contextualizedEmotions.add(new Tuple3("School", "Classmates", "Anxious"));
    _contextualizedEmotions.add(new Tuple3("School", "Classmates", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("School", "Classmates", "Doubtful"));

    _contextualizedEmotions.add(new Tuple3("School", "Teachers", "Anger"));
    _contextualizedEmotions.add(new Tuple3("School", "Teachers", "Frustration"));
    _contextualizedEmotions.add(new Tuple3("School", "Teachers", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("School", "Teachers", "Happy"));
    _contextualizedEmotions.add(new Tuple3("School", "Teachers", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("School", "Teachers", "Capable"));
    _contextualizedEmotions.add(new Tuple3("School", "Teachers", "Unintelligent"));
    _contextualizedEmotions.add(new Tuple3("School", "Teachers", "Anxious"));
    _contextualizedEmotions.add(new Tuple3("School", "Teachers", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("School", "Teachers", "Bullied"));

    _contextualizedEmotions.add(new Tuple3("Relationships", "My Parents", "Anger"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Parents", "Happiness"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Parents", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Parents", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Parents", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Parents", "Controlled"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Parents", "Bullied"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Parents", "Frustrated"));

    _contextualizedEmotions.add(new Tuple3("Relationships", "My Ex", "Anger"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Ex", "Happiness"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Ex", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Ex", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Ex", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Ex", "Controlled"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Ex", "Bullied"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Ex", "Frustrated"));

    _contextualizedEmotions.add(new Tuple3("Relationships", "My Children", "Anger"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Children", "Happiness"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Children", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Children", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Children", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Children", "Controlled"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Children", "Bullied"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Children", "Frustrated"));

    _contextualizedEmotions.add(new Tuple3("Relationships", "My Boyfriend", "Anger"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Boyfriend", "Happiness"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Boyfriend", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Boyfriend", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Boyfriend", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Boyfriend", "Controlled"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Boyfriend", "Bullied"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Boyfriend", "Frustrated"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Boyfriend", "Jealous"));

    _contextualizedEmotions.add(new Tuple3("Relationships", "My Girlfriend", "Anger"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Girlfriend", "Happiness"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Girlfriend", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Girlfriend", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Girlfriend", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Girlfriend", "Controlled"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Girlfriend", "Bullied"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Girlfriend", "Frustrated"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Girlfriend", "Jealous"));

    _contextualizedEmotions.add(new Tuple3("Relationships", "My Friends", "Anger"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Friends", "Happiness"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Friends", "Joyful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Friends", "Helpless"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Friends", "Resentful"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Friends", "Controlled"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Friends", "Bullied"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Friends", "Frustrated"));
    _contextualizedEmotions.add(new Tuple3("Relationships", "My Friends", "Jealous"));

  }

  static void uploadRandomDevelopmentRatingData() {

    //Come up with 100 days in a row
    DateTime emotionDate = DateTime.now().subtract(new Duration(days: 100));
    List<DateTime> emotionDays = new List<DateTime>();
    for(int i = 0; i < 100; i++) {
      emotionDays.add(emotionDate);
      emotionDate = emotionDate.subtract(new Duration(days: 1));
    }

    //We want 100 random emotion ratings
    for(int i = 0; i < 100; i++) {

      var ref = Database.emotionRatingPushReference();

      //Select a category
      String category = _categories.elementAt(Utilities.randomIntInARange(0, _categories.length - 1));
      //Select a specific
      String specifics = _specifics.elementAt(Utilities.randomIntInARange(0, _specifics.length - 1));
      //Select an emotion
      String emotion = _emotions.elementAt(Utilities.randomIntInARange(0, _emotions.length - 1));
      //Select a rating
      String rating = Utilities.randomIntInARange(0, 10).toString();

      EmotionRating emotionRating = new EmotionRating("dont care about the key", category, specifics, emotion, rating, dateTime: emotionDays.elementAt(i));

      ref.set(emotionRating.toJson());

    }

    DateTime sleepTime = DateTime.now().subtract(new Duration(days: 30));

    int day = 0;

    //Sleep
    List<SleepRating> sleepRatings = new List<SleepRating>();
    sleepRatings.add(new SleepRating("10:00 PM", "10:30 PM", "10:00 AM", "10", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("11:00 PM", "11:20 PM", "10:20 AM", "3", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("12:00 AM", "1:30 AM", "9:00 AM", "2", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("9:00 PM", "10:45 PM", "11:00 AM", "5", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("8:00 PM", "10:00 PM", "8:20 AM", "6", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("7:00 PM", "8:30 PM", "9:30 AM", "7", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("8:01 PM", "9:00 PM", "11:20 AM", "2", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("8:40 PM", "10:20 PM", "7:00 AM", "8", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("11:30 PM", "11:40 PM", "7:40 AM", "8", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("10:20 PM", "10:50 PM", "8:00 AM", "3", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("7:45 PM", "9:00 PM", "8:30 AM", "7", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("10:30 PM", "11:00 PM", "9:04 AM", "5", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("10:00 PM", "11:30 PM", "10:20 AM", "9", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("9:00 PM", "11:20 PM", "7:30 AM", "8", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("9:04 PM", "10:34 PM", "8:30 AM", "3", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("8:30 PM", "10:00 PM", "8:00 AM", "2", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("11:00 PM", "12:00 AM", "8:05 AM", "1", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("11:40 PM", "12:00 AM", "10:50 AM", "8", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("10:40 PM", "11:40 PM", "11:20 AM", "6", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("8:30 PM", "10:20 PM", "6:00 AM", "6", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("9:05 PM", "10:00 PM", "6:30 AM", "7", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("10:20 PM", "11:00 PM", "7:30 AM", "8", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("7:00 PM", "8:00 PM", "6:00 AM", "4", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("9:27 PM", "10:00 PM", "8:30 AM", "3", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("11:45 PM", "11:50 PM", "10:30 AM", "10", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("11:00 PM", "12:00 AM", "11:00 AM", "7", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("12:00 AM", "2:00 aM", "7:00 AM", "8", date: sleepTime.add(new Duration(days: day++))));
    sleepRatings.add(new SleepRating("1:00 AM", "2:30 AM", "8:00 AM", "4", date: sleepTime.add(new Duration(days: day++))));

    for(var sleep in sleepRatings) {

      var ref = Database.sleepEntriesPushReference();

      ref.set(sleep.toJson());

    }

    DateTime exercistTime = DateTime.now().subtract(new Duration(days: 13));

    day = 0;
    
    //Exercise
    List<ExerciseRating> exerciseRatings = new List<ExerciseRating>();
    exerciseRatings.add(new ExerciseRating("Yes", "Weightlifting", "30", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("No", "Cardio", "10", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("Yes", "Cardio", "30", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("Yes", "Yoga", "30", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("Yes", "Yoga", "45", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("No", "Cardio", "30", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("No", "Cardio", "30", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("Yes", "Weightlifting", "60", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("No", "Cardio", "30", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("Yes", "Cardio", "20", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("No", "Cardio", "30s", date: sleepTime.add(new Duration(days: day++))));
    exerciseRatings.add(new ExerciseRating("Yes", "Weightlifting", "65", date: sleepTime.add(new Duration(days: day++))));

    for(var exercise in exerciseRatings) {

      var ref = Database.exerciseEntriesPushReference();

      ref.set(exercise.toJson());

    }

  }

}