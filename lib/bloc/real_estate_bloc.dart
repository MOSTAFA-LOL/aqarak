// import 'package:aqarak/bloc/realestatemodel.dart';
// import 'package:aqarak/newapi/api_service_for%20data.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'real_estate_event.dart';
// import 'real_estate_state.dart';
//  // Import your model

// class RealEstateBloc extends Bloc<RealEstateEvent, RealEstateState> {
//   final ApiService1 apiService;

//   RealEstateBloc(this.apiService) : super(RealEstateInitial()) {
//     on<FetchProperties>((event, emit) async {
//       emit(RealEstateLoading());
//       try {
//         final propertiesData = await apiService.fetchProperties();
//         final properties = propertiesData
//             .map((json) => RealEstateModel.fromJson(json))
//             .toList();
//         emit(RealEstateLoaded(properties));
//       } catch (e) {
//         emit(RealEstateError(e.toString()));
//       }
//     });
//   }
// }