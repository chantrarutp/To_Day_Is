import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _language = 'en'; // Default language is English
  Locale _locale = Locale('en'); // Locale for the app

  Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      // Menu screen translations
      'favorites': 'Favorites',
      'show_more': 'Show More',
      'show_less': 'Show Less',
      'yes_no': 'Yes/No',
      'dice': 'Dice',
      'number': 'Number',
      'Mysterybox': 'Mysterybox',
      'letter': 'Letter',
      'quote': 'Quote',
      'color': 'Color',

      // Settings screen translations
      'title': 'Settings',
      'theme': 'Theme',
      'language': 'Language',
      'save': 'Save',
      'dark mode': 'Dark mode',

      //letter menu
      'letter_randomizer': 'Letter Randomizer',
      'randomize_letter': 'To Day is...',

      //quote menu
      'quote_1': 'Believe in yourself!',
      'quote_2': 'You are stronger than you think.',
      'quote_3': 'Keep going, you are doing great!',
      'quote_4': 'Success is not far away.',
      'quote_5': 'Stay positive, work hard, make it happen.',
      'quote_6': 'Collaboration will be the key.',
      'quote_7': 'Every day is a new beginning.',
      'quote_8': 'You have the ability to do amazing things.',
      'quote_9': 'Believe in yourself and in who you are.',
      'quote_10': 'Tough roads often lead to beautiful destinations.',
      'quote_11':
          'Success is not the end, failure is not the end: the courage to keep moving forward is what matters.',
      'quote_12': 'Don’t stop until you’re proud of yourself.',
      'quote_13': 'The best is yet to come.',
      'quote_14': 'Challenges are what make life interesting.',
      'quote_15': 'You have the power to change your story.',
      'quote_16': 'Take a deep breath and keep moving forward.',
      'quote_17': 'Believe you can, and that’s halfway to success.',
      'quote_18': 'It’s never too late to be what you might have been.',
      'quote_19': 'Progress is progress, no matter how small.',
      'quote_20': 'Mistakes are proof that you are trying.',
      'quote_21': 'You are enough just as you are.',
      'quote_22': 'Great things never come from comfort zones.',
      'quote_23': 'You are your only limit.',
      'quote_24': 'The only way to do great work is to love what you do.',
      'quote_25': 'Don’t wait for opportunity, create it.',
      'quote_26': 'Keep your head up and your heart open.',
      'quote_27': 'Storms don’t last forever.',
      'quote_28':
          'Small steps in the right direction could turn out to be the biggest steps of your life.',
      'quote_29': 'Dream big, take action to make it happen.',
      'quote_30':
          'The harder you work for something, the better you’ll feel when you succeed.',
      'quote_31':
          'Success is not how high you’ve climbed, but how you make a positive impact on the world.',
      'quote_32':
          'A small positive thought in the morning can change your whole day.',
      'quote_33': 'Rise above the storm and you will find the sunshine.',
      'quote_34': 'You are more powerful than you know.',
      'quote_35': 'Be a warrior, not a worrier.',
      'quote_36': 'Your potential is endless.',
      'quote_37': 'Focus on the good.',
      'quote_38': 'Life may be tough, but so are you.',
      'quote_39': 'Good things are coming.',
      'quote_40':
          'Every day may not be good, but there is something good in every day.',
      'quote_41': 'You’ve got this.',
      'quote_42': 'Don’t give up, great things take time.',
      'quote_43': 'Be brave, take risks.',
      'quote_44':
          'You are braver than you believe, stronger than you seem, and smarter than you think.',
      'quote_45':
          'Failure is not the opposite of success; it’s part of success.',
      'quote_46': 'Sometimes you win, sometimes you learn.',
      'quote_47': 'Your dreams don’t have an expiration date.',
      'quote_48': 'Be the energy you want to attract.',
      'quote_49': 'The best view comes after the hardest climb.',
      'quote_50': 'Start where you are, use what you have, do what you can.',
      'quote_51': 'You are capable of more than you know.',
      'quote_52': 'Doubt kills more dreams than failure ever will.',

      //dice
      'dice_title': 'Dice',
      'number_of_dice': 'Number of dice:',
      'dice_results': 'Dice Results:',
      'sum': 'Sum:',

      //color
      'red': 'Red',
      'orange': 'Orange',
      'yellow': 'Yellow',
      'green': 'Green',
      'blue': 'Blue',
      'purple': 'Purple',

      //yesno
      'randomizing': 'Randomizing...',
      'press_the_button': 'Press the Button!',
      'you_got': 'You got:',

      //num
      'from_label': 'From:', // Added translation key
      'to_label': 'To:', // Added translation key
      'randomizing': 'Randomizing...', // Added translation key
      'you_got': 'You got:', // Added translation key
      'please_ensure_from_less_than_to':
          'Please ensure "From" is less than "To"', // Added translation key
    },
    'th': {
      // Menu screen translations
      'favorites': 'ชื่นชอบ',
      'show_more': 'แสดงเพิ่มขึ้น',
      'show_less': 'แสดงน้อยลง',
      'yes_no': 'ใช่/ไม่ใช่',
      'dice': 'ลูกเต๋า',
      'number': 'หมายเลข',
      'Mysterybox': 'กล่องสุ่ม',
      'letter': 'สุ่มตัวอักษร',
      'quote': 'คำคม',
      'color': 'สี',

      // Settings screen translations
      'title': 'การตั้งค่า',
      'theme': 'ธีม',
      'language': 'ภาษา',
      'save': 'บันทึก',
      'dark mode': 'โหมดกลางคืน',

      //letter menu
      'letter_randomizer': 'สุ่มตัวอักษร',
      'randomize_letter': 'To Day is...',

      //quote menu
      'quote_1': 'เชื่อมั่นในตัวเอง!',
      'quote_2': 'คุณแข็งแกร่งกว่าที่คุณคิด',
      'quote_3': 'ทำต่อไป คุณทำได้ดีมาก!',
      'quote_4': 'ความสำเร็จไม่ได้อยู่ไกล',
      'quote_5': 'คิดบวก ทำงานหนัก ทำให้มันเกิดขึ้น',
      'quote_6': 'การทำงานร่วมกันจะเป็นกุญแจสำคัญ',
      'quote_7': 'ทุกวันคือการเริ่มต้นใหม่',
      'quote_8': 'คุณมีความสามารถที่จะทำสิ่งที่น่าทึ่ง',
      'quote_9': 'เชื่อมั่นในตัวเองและในสิ่งที่คุณเป็น',
      'quote_10': 'ถนนที่ยากลำบากมักนำไปสู่จุดหมายที่สวยงาม',
      'quote_11':
          'ความสำเร็จไม่ใช่จุดจบ ความล้มเหลวไม่ใช่จุดจบ: ความกล้าที่จะเดินหน้าต่อคือสิ่งสำคัญ',
      'quote_12': 'อย่าหยุดจนกว่าคุณจะภูมิใจในตัวเอง',
      'quote_13': 'สิ่งที่ดีที่สุดยังรออยู่ข้างหน้า',
      'quote_14': 'ความท้าทายคือสิ่งที่ทำให้ชีวิตน่าสนใจ',
      'quote_15': 'คุณมีพลังในการเปลี่ยนแปลงเรื่องราวของตัวเอง',
      'quote_16': 'หายใจลึก ๆ แล้วก้าวต่อไปข้างหน้า',
      'quote_17': 'เชื่อว่าคุณทำได้ และนั่นคือครึ่งทางของความสำเร็จ',
      'quote_18': 'ไม่มีคำว่าสายเกินไปที่จะเป็นสิ่งที่คุณอาจจะเป็น',
      'quote_19': 'ความก้าวหน้าคือความก้าวหน้า ไม่ว่าจะเล็กแค่ไหนก็ตาม',
      'quote_20': 'ความผิดพลาดคือหลักฐานว่าคุณกำลังพยายาม',
      'quote_21': 'คุณเพียงพอแล้วในแบบที่คุณเป็น',
      'quote_22': 'สิ่งที่ยิ่งใหญ่ไม่เคยเกิดขึ้นจากความสะดวกสบาย',
      'quote_23': 'ขีดจำกัดของคุณมีเพียงตัวคุณเอง',
      'quote_24': 'วิธีเดียวที่จะทำงานที่ยอดเยี่ยมได้คือการรักสิ่งที่คุณทำ',
      'quote_25': 'อย่ารอโอกาส จงสร้างมันขึ้นมา',
      'quote_26': 'ยกหัวให้สูง และเปิดใจรับสิ่งใหม่',
      'quote_27': 'พายุไม่ได้คงอยู่ตลอดไป',
      'quote_28':
          'ก้าวเล็ก ๆ ในทิศทางที่ถูกต้อง อาจเป็นก้าวที่ใหญ่ที่สุดในชีวิตของคุณ',
      'quote_29': 'ฝันให้ใหญ่ ลงมือทำให้สำเร็จ',
      'quote_30':
          'ยิ่งคุณทำงานหนักเพื่อบางสิ่ง คุณก็จะรู้สึกดีเมื่อคุณประสบความสำเร็จ',
      'quote_31':
          'ความสำเร็จไม่ใช่ว่าคุณปีนสูงแค่ไหน แต่คุณสร้างผลกระทบเชิงบวกต่อโลกได้อย่างไร',
      'quote_32': 'ความคิดบวกเล็ก ๆ ในตอนเช้าสามารถเปลี่ยนวันทั้งวันของคุณได้',
      'quote_33': 'ก้าวข้ามพายุ แล้วคุณจะพบกับแสงแดด',
      'quote_34': 'คุณทรงพลังมากกว่าที่คุณรู้',
      'quote_35': 'จงเป็นนักรบ ไม่ใช่นักวิตกกังวล',
      'quote_36': 'ศักยภาพของคุณไม่มีที่สิ้นสุด',
      'quote_37': 'โฟกัสที่สิ่งดี ๆ',
      'quote_38': 'ชีวิตอาจยากลำบาก แต่คุณก็แข็งแกร่งเช่นกัน',
      'quote_39': 'สิ่งดี ๆ กำลังจะเกิดขึ้น',
      'quote_40': 'ทุกวันอาจไม่ดี แต่มีสิ่งดีในทุกวัน',
      'quote_41': 'คุณทำได้',
      'quote_42': 'อย่ายอมแพ้ สิ่งที่ยิ่งใหญ่ต้องใช้เวลา',
      'quote_43': 'จงกล้าหาญและรับความเสี่ยง',
      'quote_44':
          'คุณกล้าหาญกว่าที่คุณเชื่อ แข็งแกร่งกว่าที่คุณดู และฉลาดกว่าที่คุณคิด',
      'quote_45':
          'ความล้มเหลวไม่ใช่สิ่งตรงข้ามของความสำเร็จ แต่มันคือส่วนหนึ่งของความสำเร็จ',
      'quote_46': 'บางครั้งคุณชนะ บางครั้งคุณได้เรียนรู้',
      'quote_47': 'ความฝันของคุณไม่มีวันหมดอายุ',
      'quote_48': 'จงเป็นพลังที่คุณต้องการจะดึงดูด',
      'quote_49': 'ทิวทัศน์ที่ดีที่สุดมาหลังจากการปีนที่ยากที่สุด',
      'quote_50': 'เริ่มต้นจากที่ที่คุณอยู่ ใช้สิ่งที่คุณมี ทำสิ่งที่คุณทำได้',
      'quote_51': 'คุณมีความสามารถมากกว่าที่คุณรู้',
      'quote_52': 'ความสงสัยฆ่าความฝันมากกว่าความล้มเหลว',

      //dice menu
      'dice_title': 'ลูกเต๋า',
      'number_of_dice': 'จำนวนลูกเต๋า:',
      'dice_results': 'ผลลัพธ์ลูกเต๋า:',
      'sum': 'ผลรวม:',

      //color menu
      'red': 'แดง',
      'orange': 'ส้ม',
      'yellow': 'เหลือง',
      'green': 'เขียว',
      'blue': 'น้ำเงิน',
      'purple': 'ม่วง',

      //yesno
      'randomizing': 'กำลังสุ่ม...',
      'press_the_button': 'กดปุ่ม!',
      'you_got': 'ผลลัพธ์ของคุณ:',

      //num
      'from_label': 'จาก:', // Thai translation for "From:"
      'to_label': 'ถึง:', // Thai translation for "To:"
      'randomizing': 'กำลังสุ่ม...', // Thai translation for "Randomizing..."
      'you_got': 'ผลลัพธ์ของคุณ:', // Thai translation for "You got:"
      'please_ensure_from_less_than_to':
          'กรุณาตรวจสอบให้แน่ใจว่า "จาก" จำนวนที่น้อยกว่า "ถึง"', // Thai translation for the key
    },
  };

  String get language => _language;

  Locale get locale => _locale;

  void switchLanguage(String language) {
    _language = language;
    _locale = Locale(language); // Update locale based on language
    notifyListeners(); // Notify all listeners to update UI
  }

  void toggleLanguage() {
    if (_language == 'en') {
      switchLanguage('th');
    } else {
      switchLanguage('en');
    }
  }

  String? getTranslation(String key) {
    return _localizedStrings[_language]?[key];
  }
}
