class OnboardingContent {
  String image;
  String title;
  String discription;

  OnboardingContent({required this.image, required this.title, required this.discription});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: 'Find Your Best Barber Shop Nearby',
    image: 'assets/svgs/mobile.svg',
    discription: "Easily search your best and favorite barber shops anywhere nearby "
  ),
  OnboardingContent(
    title: 'No Need to Do a Boring Queue, Just Stay Home!',
    image: 'assets/svgs/quiting.svg',
    discription: "Waiting for your turn comfortably at home and we will inform you for your turn "
  ),
  OnboardingContent(
    title: 'All you need for your barber needs',
    image: 'assets/svgs/barber.svg',
    discription: "Feel comfortable ordering and waiting for your turn with Barbar"
  ),
];