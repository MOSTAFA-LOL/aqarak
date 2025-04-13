import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الخصوصية'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: '1. المقدمة',
                content:
                    'مرحبًا بكم في [عقارك]، تطبيق جوال لشراء وبيع العقارات. باستخدامك للتطبيق، فإنك توافق على الممارسات الموضحة أدناه.',
              ),
              const SectionHeader(
                title: '2. البيانات التي نجمعها',
                content: 'نقوم بجمع الأنواع التالية من المعلومات:',
                bullets: [
                  'معلومات شخصية (الاسم، البريد الإلكتروني، رقم الهاتف، العنوان)',
                  'هوية حكومية (للمعاملات العقارية)',
                  'بيانات الاستخدام (سجل البحث، معلومات الجهاز)',
                  'بيانات الموقع (GPS أو الموقع التقريبي)',
                  'معلومات مالية (معالجة عبر بوابات آمنة)',
                ],
              ),
              const SectionHeader(
                title: '3. كيفية استخدام بياناتك',
                bullets: [
                  'تخصيص تجربتك',
                  'تسهيل المعاملات والحجوزات',
                  'تحسين أداء التطبيق',
                  'إرسال التحديثات والإشعارات القانونية',
                ],
              ),
              const SectionHeader(
                title: '4. مشاركة البيانات',
                content: 'نشارك البيانات مع:',
                bullets: [
                  'بوابات الدفع (Stripe، PayPal)',
                  'خدمات السحابة (Firebase)',
                  'أدوات التحليل (Google Analytics)',
                  'السلطات القانونية عند الاقتضاء',
                ],
                note: 'نحن لا نبيع بياناتك للمعلنين.',
              ),
              const SectionHeader(
                title: '5. أمان البيانات',
                bullets: [
                  'تشفير SSL/TLS',
                  'وصول مقيد إلى قواعد البيانات',
                  'مراجعات أمنية دورية',
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