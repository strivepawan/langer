// Card(
//   child: StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance.collection('langer_posts').snapshots(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const CircularProgressIndicator();
//       }
//       if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');
//       }

//       final posts = snapshot.data!.docs;

//       return ListView.separated(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: posts.length,
//         separatorBuilder: (BuildContext context, int index) => const Divider(
//           thickness: 1.0, // Adjust divider thickness for preference
//           color: Colors.grey[300], // Customize divider color
//         ),
//         itemBuilder: (context, index) {
//           final post = posts[index];
//           final data = post.data();
//           final Map<String, dynamic> postData = data as Map<String, dynamic>;
//           final imageUrl = postData.containsKey('imageUrl') ? postData['imageUrl'] : null;

//           return Container( // Use Container for styling flexibility
//             padding: const EdgeInsets.all(16.0), // Adjust padding as needed
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Reorder user data display:
//                 Row( // First row with user information
//                   children: [
//                     Expanded( // Ensures remaining space is filled by text
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             postData['userName'] ?? '',
//                             style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), // Customize text style
//                           ),
//                           const SizedBox(height: 8.0), // Spacing between user name and location
//                           Text(postData['location'] ?? ''),
//                           const SizedBox(height: 4.0), // Adjust spacing between location and device time
//                           Text(postData['deviceTime'] ?? ''),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 16.0), // Spacing between text and image
//                     IconButton( // Navigation button (optional location)
//                       icon: const Icon(Icons.navigation),
//                       onPressed: () {
//                         // Handle navigation to the location
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16.0), // Spacing between user data and image
//                 SizedBox( // Optional for image alignment
//                   width: 100.0, // Adjust image width as needed
//                   height: 100.0, // Adjust image height as needed
//                   child: imageUrl != null
//                     ? Image.network(
//                         imageUrl,
//                         fit: BoxFit.cover,
//                       )
//                     : Image.asset(
//                         'assets/images/upload.jpg',
//                         fit: BoxFit.cover,
//                       ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   ),
// ),
