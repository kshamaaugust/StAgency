# stagency
Security Troops Agency

## Flutter setup on local:
	export PATH="$PATH:/Library/WebServer/Documents/flutter/flutter/bin"

## Open Simulator:
	open -a Simulator

## make your flutter folder:
	flutter create myApp

## To see all details:
	flutter doctor

## To run flutter app:
	flutter run

## after implement in yaml file:
	flutter pub get

## after import package in amy file:
	flutter packages upgrade

## Upgrade Flutter:
	flutter upgrade
	flutter pub upgrade

## For datetime, update in yaml:
	dependencies:
		datetime_picker_formfield: ^1.0.0

## For geolocator update in yaml file:
	dependencies:
		geolocator: ^5.1.3
	import 'package:geolocator/geolocator.dart';

## For using assets image, update in yaml:
	flutter:
		assets:
    		- assets/images/	

## modify .yaml file for using API:
	http: any
	shared_preferences: any
## And also import packages:
	import 'package:http/http.dart' as http;

## For Localstorage in flutter, update in yaml:
	localstorage: ^3.0.0
	flutter_secure_storage: ^3.3.3
## And also import packages:
	import 'package:flutter_secure_storage/flutter_secure_storage.dart';

## /var/www/apps/time/ForTimeStint/android/app/build.gradle :
	 minSdkVersion 18

## For upload image, update in yaml:
	dependencies:
		image_picker: ^0.6.6+5

## Import packages, for upload image: 
	import 'package:image_picker/image_picker.dart';
	import 'package:async/async.dart';
	import 'dart:io';
	import 'package:intl/intl.dart';
	import 'package:path/path.dart';
