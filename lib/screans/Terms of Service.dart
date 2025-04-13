import 'package:flutter/material.dart';

// ignore: camel_case_types
class Terms_of_service extends StatelessWidget {
  const Terms_of_service({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        'شروط الخدمة',
          ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'شروط الخدمة الخاصة بنا:',
                  style: Theme.of(context).textTheme.titleLarge,
              ),
              const SectionHeader(
                title: '1. قبول الشروط',
                content:
                    'باستخدامك لهذا التطبيق، فإنك توافق على الالتزام بالشروط والأحكام المذكورة هنا.إذا كنت لا توافق، يرجى الامتناع عن استخدام التطبيق. ',
                    
              ),
              const SectionHeader(
                title: '2. وصف الخدمة',
                content: 'يسهل التطبيق معاملات العقارات (البيع/الشراء) وحجز الاستشارات مع وكلاء معتمدين.',
                bullets: [
                  'نقدم معلومات مفصلة عن العقارات (الصور، الأسعار، المواقع، إلخ)،على الرغم من أن البيانات قد تختلف قليلاً عن الواقع.',
                  
                  
                ],
              ),
              const SectionHeader(
                title: '3. المسؤوليات القانونية',
                bullets: [
                  'التطبيق غير مسؤول عن أي أخطاء في تفاصيل العقارات المقدمة من المعلنين أو الوكلاء.',
                  
                ],
              ),
              const SectionHeader(
                title: '4. الإلغاءات والاسترداد',
                content: 'نشارك البيانات مع:',
                bullets: [
                  'يجب أن تتم مطابقة طلبات الإلغاء أو الاسترداد مع السياسة المذكورة أثناء الدفع.',
                  
                ],
                note: 'نحن لا نبيع بياناتك للمعلنين.',
              ),
              const SectionHeader(
                title: '5. التحديثات والدعم الفني',
                bullets: [
                  'يجب أن تتم مطابقة طلبات الإلغاء أو الاسترداد مع السياسة المذكورة أثناء الدفع.',
                  'لن يتم إصدار استرداد للأموال في حالة انتهاك هذه الشروط.',
                  
                ],
              ),
              const SectionHeader(
                title: '6. حقوقك',
                bullets: [
                  'الوصول/تعديل بياناتك',
                  'طلب الحذف',
                  'الانسحاب من التسويق',
                ],
              ),
              const SectionHeader(
                title: '7. الكوكيز والتتبع',
                content:
                    'نستخدم ملفات تعريف الارتباط وأدوات التحليل. يمكنك تعطيل هذه الميزات من إعدادات جهازك.',
              ),
              const SectionHeader(
                title: '8. خصوصية الأطفال',
                content:
                    'غير مخصص للمستخدمين تحت 18 عامًا. نحن لا نجمع بيانات القصّر عن علم.',
              ),
              const SectionHeader(
                title: '9. تحديثات السياسة',
                content: 'سيتم إعلامك بالتغييرات عبر تنبيهات داخل التطبيق أو البريد الإلكتروني.',
              ),
              const SectionHeader(
                title: '10. اتصل بنا',
                content: 'للأسئلة أو الطلبات: privacy@realestateapp.com',
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('رفض',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('موافق',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? content;
  final List<String>? bullets;
  final String? note;

  const SectionHeader({
    super.key,
    required this.title,
    this.content,
    this.bullets,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                )),
        const SizedBox(height: 8),
        if (content != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(content!, 
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  height: 1.5,
                  fontSize: 16
                ),
                textAlign: TextAlign.justify,
            ),
          ),
        if (bullets != null)
          ...bullets!.map((bullet) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.brightness_1, 
                          size: 8, 
                          color: Colors.blue[800]),
                    ),
                    Expanded(
                        child: Text(bullet,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontSize: 16),
                            textAlign: TextAlign.justify)),
                  ],
                ),
              )),
        if (note != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(note!,
                style: TextStyle(
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                )),
          ),
        const Divider(height: 40),
      ],
    );
  }
}