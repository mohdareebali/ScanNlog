import 'dart:async';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({super.key, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();
  int _secondsRemaining = 60;
  late Timer _timer;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _secondsRemaining = 60;
    canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void resendOtp() {
    // TODO: Call backend to resend OTP to widget.email
    startTimer();
  }

  void verifyOtp() {
    String otp = otpController.text.trim();
    // TODO: Verify OTP using backend
    print("Verifying OTP $otp for ${widget.email}");
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Enter the OTP sent to ${widget.email}"),
            const SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "OTP",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyOtp,
              child: const Text("Verify"),
            ),
            const SizedBox(height: 20),
            if (_secondsRemaining > 0)
              Text("Resend OTP in $_secondsRemaining seconds")
            else if (canResend)
              TextButton(
                onPressed: resendOtp,
                child: const Text("Resend OTP"),
              ),
          ],
        ),
      ),
    );
  }
}