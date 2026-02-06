# arabic-levels-app

تطبيق Flutter تعليمي لتعلّم الحروف العربية مع الحركات — نسخة بداية (MVP).

محتويات:
- كود Flutter بسيط (عرض قائمة مستويات وواجهة لكل مستوى)
- assets/levels.json (قائمة المستويات التي زودتني بها)
- سكريبت لإنشاء ملفات placeholder للصور/الصوت assets/create_assets_and_zip.sh
- GitHub Actions لبناء APK و AAB (Android) وإخراجها كـ artifacts
- LICENSE (MIT)

كيفية الاستخدام المحلي:
1. فكّ أو انسخ الملفات إلى مجلد المشروع.
2. ثبت Flutter SDK ثم شغّل:
   flutter pub get
   flutter run

لرفع المشروع إلى GitHub (خطوات مقترحة موجودة أدناه).