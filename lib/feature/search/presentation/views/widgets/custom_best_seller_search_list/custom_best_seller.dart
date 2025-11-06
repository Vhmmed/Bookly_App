import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/resources/assets.dart';
import '../../../../../home/data/model/book_model/book_model.dart'; // أضف هذا الاستيراد
import '../../../../../home/presentation/views/widgets/book_rating/book_rating.dart';

class CustomBestSeller extends StatelessWidget {
  const CustomBestSeller({
    super.key,
    required this.bookModel, // أضف هذا
  });

  final BookModel bookModel; // أضف هذا

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          '/bookDetailsScreen',
          extra: bookModel, // أهم سطر - مرر الـ bookModel هنا
        );
      },
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(bookModel.volumeInfo.imageLinks?.thumbnail ?? testImage), // استخدم صورة الكتاب
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      bookModel.volumeInfo.title ?? "No Title", // استخدم عنوان الكتاب
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    bookModel.volumeInfo.authors?.join(', ') ?? "Unknown Author", // استخدم المؤلفين
                    style: const TextStyle(
                      fontFamily: 'Poppins', // صحح الخط
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        "19.99 €",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const Spacer(),
                      BookRating(
                        ratingNum: bookModel.volumeInfo.averageRating?.toDouble() ?? 0, // استخدم التقييم الفعلي
                        ratingCount: bookModel.volumeInfo.ratingsCount ?? 0, // استخدم عدد التقييمات
                        bookModel: bookModel, // مرر الـ bookModel
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}