import 'package:flutter/material.dart';

void main() => runApp(const GlassLoginApp());

class GlassLoginApp extends StatelessWidget {
  const GlassLoginApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login',
        home: const GlassLoginPage(),
      );
}

// ─── Colours ──────────────────────────────────────────────────
const _bg1        = Color(0xFF1A0533);
const _bg2        = Color(0xFF2D0D5C);
const _bg3        = Color(0xFF4A1070);
const _accent1    = Color(0xFF8B3FC8);
const _accent2    = Color(0xFFB06FE8);
const _glassWhite = Color(0x22FFFFFF);
const _glassBorder= Color(0x44FFFFFF);
const _inputBg    = Color(0x18FFFFFF);
const _inputBorder= Color(0x55FFFFFF);
const _hintColor  = Color(0xAAFFFFFF);
const _textWhite  = Color(0xFFFFFFFF);
const _textSoft   = Color(0xCCFFFFFF);
const _textDim    = Color(0x88FFFFFF);

// ─── Glass Login Page ─────────────────────────────────────────
class GlassLoginPage extends StatefulWidget {
  const GlassLoginPage({super.key});
  @override
  State<GlassLoginPage> createState() => _GlassLoginPageState();
}

class _GlassLoginPageState extends State<GlassLoginPage>
    with TickerProviderStateMixin {
  bool _obscure = true;

  // ── Entry animations ────────────────────────────────────────
  late final AnimationController _entryAc = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200))
    ..forward();

  late final Animation<double> _bgAnim    = _ease(_entryAc, 0.00, 0.40);
  late final Animation<double> _cardAnim  = _ease(_entryAc, 0.20, 0.65);
  late final Animation<double> _titleAnim = _ease(_entryAc, 0.38, 0.72);
  late final Animation<double> _f1Anim    = _ease(_entryAc, 0.48, 0.80);
  late final Animation<double> _f2Anim    = _ease(_entryAc, 0.56, 0.86);
  late final Animation<double> _socAnim   = _ease(_entryAc, 0.62, 0.90);
  late final Animation<double> _btnAnim   = _ease(_entryAc, 0.68, 0.94);
  late final Animation<double> _linkAnim  = _ease(_entryAc, 0.76, 1.00);

  static Animation<double> _ease(AnimationController ac, double b, double e) =>
      CurvedAnimation(parent: ac, curve: Interval(b, e, curve: Curves.easeOut));

  @override
  void dispose() { _entryAc.dispose(); super.dispose(); }

  // ─── Builder helpers ──────────────────────────────────────────

  Widget _buildBackground() => AnimatedBuilder(
        animation: _bgAnim,
        builder: (_, __) => Opacity(
          opacity: _bgAnim.value.clamp(0.0, 1.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.3, -0.4),
                radius: 1.5,
                colors: [_bg3, _bg2, _bg1],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),
        ),
      );

  Widget _buildGlowOrbs() => Stack(children: [
        Positioned(
          top: -80, right: -60,
          child: _GlowOrb(color: _accent1.withOpacity(0.35), size: 280),
        ),
        Positioned(
          bottom: 60, left: -80,
          child: _GlowOrb(color: _accent2.withOpacity(0.22), size: 320),
        ),
        Positioned(
          top: 200, left: 80,
          child: _GlowOrb(color: const Color(0xFF3A10A0).withOpacity(0.20), size: 180),
        ),
      ]);

  Widget _buildWelcomeTitle() => _Fade(
        animation: _titleAnim,
        offsetY: 12,
        child: Column(children: [
          const Text(
            'Welcome',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w200,
              color: _textWhite,
              letterSpacing: 6,
            ),
          ),
        ]),
      );

  Widget _buildUsernameField() => _Fade(
        animation: _f1Anim,
        offsetY: 14,
        child: _GlassField(
          hint: 'Username',
          icon: Icons.person_outline_rounded,
          obscure: false,
        ),
      );

  Widget _buildPasswordField() => _Fade(
        animation: _f2Anim,
        offsetY: 14,
        child: _GlassField(
          hint: 'Password',
          icon: Icons.lock_outline_rounded,
          obscure: _obscure,
          suffixIcon: GestureDetector(
            onTap: () => setState(() => _obscure = !_obscure),
            child: Icon(
              _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: _hintColor,
              size: 18,
            ),
          ),
        ),
      );

  Widget _buildSocialButtons() => _Fade(
        animation: _socAnim,
        offsetY: 12,
        child: Row(children: [
          Expanded(child: _SocialButton(
            icon: _FacebookIcon(),
            label: 'Facebook',
          )),
          const SizedBox(width: 12),
          Expanded(child: _SocialButton(
            icon: _GoogleIcon(),
            label: 'Google',
          )),
        ]),
      );

  Widget _buildLoginButton() => _Fade(
        animation: _btnAnim,
        offsetY: 10,
        child: const _LoginButton(),
      );

  Widget _buildTextLinks() => _Fade(
        animation: _linkAnim,
        offsetY: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _UnderlineTextButton(label: 'Forgot password?'),
            Container(width: 1, height: 12, color: _textDim),
            _UnderlineTextButton(label: 'Sign Up'),
          ],
        ),
      );

  Widget _buildCard() => _Fade(
        animation: _cardAnim,
        offsetY: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: _GlassContainer(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 36, 28, 32),
              child: Column(mainAxisSize: MainAxisSize.min,children: [
                _buildWelcomeTitle(),
                const SizedBox(height: 62),
                _buildUsernameField(),
                const SizedBox(height: 14),
                _buildPasswordField(),
                const SizedBox(height: 48),
                _buildSocialButtons(),
                const SizedBox(height: 14),
                _buildLoginButton(),
                const SizedBox(height: 48),
                _buildTextLinks()
              ],),
            ),
          ),
        ),
      );

  // ── Main build ────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(fit: StackFit.expand, children: [
          _buildBackground(),
          _buildGlowOrbs(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: _buildCard(),
            ),
          )
        ]),
      );
}

// ─── Glass container ──────────────────────────────────────────
class _GlassContainer extends StatelessWidget {
  const _GlassContainer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: _glassWhite,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: _glassBorder, width: 1),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 48, offset: const Offset(0, 20)),
            BoxShadow(color: _accent1.withOpacity(0.08), blurRadius: 80, spreadRadius: -10),
          ],
        ),
        child: child,
      );
}

// ─── Glass input field ────────────────────────────────────────
class _GlassField extends StatefulWidget {
  const _GlassField({required this.hint, required this.icon, required this.obscure, this.suffixIcon});
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffixIcon;

  @override
  State<_GlassField> createState() => _GlassFieldState();
}

class _GlassFieldState extends State<_GlassField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _focused ? const Color(0x28FFFFFF) : _inputBg,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _focused ? _accent2.withOpacity(0.7) : _inputBorder,
            width: _focused ? 1.2 : 1,
          ),
        ),
        child: TextField(
          obscureText: widget.obscure,
          style: const TextStyle(color: _textWhite, fontSize: 14, fontWeight: FontWeight.w300, letterSpacing: 0.5),
          cursorColor: _accent2,
          onTap: () => setState(() => _focused = true),
          onTapOutside: (_) => setState(() => _focused = false),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: _hintColor, fontSize: 14, fontWeight: FontWeight.w300),
            prefixIcon: Icon(widget.icon, color: _focused ? _accent2 : _hintColor, size: 18),
            suffixIcon: widget.suffixIcon,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            isDense: true,
          ),
        ),
      );
}

// ─── Social button ────────────────────────────────────────────
class _SocialButton extends StatefulWidget {
  const _SocialButton({required this.icon, required this.label});
  final Widget icon;
  final String label;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()..scale(_pressed ? 0.96 : 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: _pressed ? const Color(0x30FFFFFF) : _inputBg,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: _inputBorder, width: 1),
          ),
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            widget.icon,
            const SizedBox(width: 8),
            Text(widget.label,
                style: const TextStyle(
                    color: _textSoft, fontSize: 13, fontWeight: FontWeight.w300, letterSpacing: 0.3)),
          ]),
        ),
      );
}

// ─── Login button ─────────────────────────────────────────────
class _LoginButton extends StatefulWidget {
  const _LoginButton();
  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;
  late final AnimationController _popAc = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 150));
  late final Animation<double> _pop = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.95), weight: 50),
    TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 50),
  ]).animate(CurvedAnimation(parent: _popAc, curve: Curves.easeInOut));

  @override
  void dispose() { _popAc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: _pop,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) { setState(() => _pressed = false); _popAc.forward(from: 0); },
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _pressed
                    ? [const Color(0xFF6A28A8), const Color(0xFF9040CC)]
                    : [_accent1, _accent2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: _accent1.withOpacity(_pressed ? 0.25 : 0.45),
                  blurRadius: _pressed ? 14 : 28,
                  offset: Offset(0, _pressed ? 4 : 8),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: _textWhite,
                  letterSpacing: 2.5,
                ),
              ),
            ),
          ),
        ),
      );
}

// ─── Underline text button (hover → smooth underline) ─────────
class _UnderlineTextButton extends StatefulWidget {
  const _UnderlineTextButton({required this.label});
  final String label;

  @override
  State<_UnderlineTextButton> createState() => _UnderlineTextButtonState();
}

class _UnderlineTextButtonState extends State<_UnderlineTextButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 320));
  late final Animation<double> _line =
      CurvedAnimation(parent: _ac, curve: Curves.easeOut);

  @override
  void dispose() { _ac.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => _ac.forward(),
        onExit: (_) => _ac.reverse(),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {},
          child: AnimatedBuilder(
            animation: _line,
            builder: (_, __) => CustomPaint(
              painter: _UnderlinePainter(progress: _line.value, color: _accent2),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color.lerp(_textDim, _accent2, _line.value),
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _UnderlinePainter extends CustomPainter {
  const _UnderlinePainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;
    final paint = Paint()
      ..color = color.withOpacity(progress)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width * progress, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _UnderlinePainter old) =>
      old.progress != progress;
}

// ─── Glow orb ─────────────────────────────────────────────────
class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color, blurRadius: size * 0.8, spreadRadius: size * 0.1)],
        ),
      );
}

// ─── Fade + slide helper ──────────────────────────────────────
class _Fade extends StatelessWidget {
  const _Fade({required this.animation, required this.child, this.offsetY = 16.0});
  final Animation<double> animation;
  final Widget child;
  final double offsetY;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (_, child) => Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, offsetY * (1 - animation.value.clamp(0.0, 1.0))),
            child: child,
          ),
        ),
      );
}

// ─── Google icon ──────────────────────────────────────────────
class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      SizedBox(width: 16, height: 16, child: CustomPaint(painter: _GooglePainter()));
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 48;
    final p = Paint()..isAntiAlias = true;
    p.color = const Color(0xFFEA4335);
    canvas.drawPath(Path()..moveTo(24*s,9.5*s)..cubicTo(27.54*s,9.5*s,30.71*s,10.72*s,33.21*s,13.1*s)..lineTo(40.06*s,6.25*s)..cubicTo(35.9*s,2.38*s,30.47*s,0,24*s,0)..cubicTo(14.62*s,0,6.51*s,5.38*s,2.56*s,13.22*s)..lineTo(10.54*s,19.41*s)..cubicTo(12.43*s,13.72*s,17.74*s,9.5*s,24*s,9.5*s)..close(), p);
    p.color = const Color(0xFF4285F4);
    canvas.drawPath(Path()..moveTo(46.98*s,24.55*s)..cubicTo(46.98*s,22.98*s,46.83*s,21.46*s,46.6*s,20*s)..lineTo(24*s,20*s)..lineTo(24*s,29.02*s)..lineTo(36.94*s,29.02*s)..cubicTo(36.36*s,31.98*s,34.68*s,34.5*s,32.16*s,36.2*s)..lineTo(39.89*s,42.2*s)..cubicTo(44.4*s,38.02*s,46.98*s,31.84*s,46.98*s,24.55*s)..close(), p);
    p.color = const Color(0xFFFBBC05);
    canvas.drawPath(Path()..moveTo(10.53*s,28.59*s)..cubicTo(10.05*s,27.14*s,9.77*s,25.6*s,9.77*s,24*s)..cubicTo(9.77*s,22.4*s,10.04*s,20.86*s,10.53*s,19.41*s)..lineTo(2.55*s,13.22*s)..cubicTo(0.92*s,16.46*s,0,20.12*s,0,24*s)..cubicTo(0,27.88*s,0.92*s,31.54*s,2.56*s,34.78*s)..lineTo(10.53*s,28.59*s)..close(), p);
    p.color = const Color(0xFF34A853);
    canvas.drawPath(Path()..moveTo(24*s,48*s)..cubicTo(30.48*s,48*s,35.93*s,45.87*s,39.89*s,42.19*s)..lineTo(32.16*s,36.19*s)..cubicTo(29.98*s,37.67*s,27.19*s,38.5*s,24*s,38.5*s)..cubicTo(17.74*s,38.5*s,12.43*s,34.28*s,10.53*s,28.59*s)..lineTo(2.55*s,34.78*s)..cubicTo(6.51*s,42.62*s,14.62*s,48*s,24*s,48*s)..close(), p);
  }
  @override bool shouldRepaint(covariant CustomPainter _) => false;
}

// ─── Facebook icon ────────────────────────────────────────────
class _FacebookIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      SizedBox(width: 16, height: 16, child: CustomPaint(painter: _FacebookPainter()));
}

class _FacebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24;
    canvas.drawCircle(Offset(12*s,12*s), 12*s, Paint()..color = const Color(0xFF1877F2)..isAntiAlias = true);
    canvas.drawPath(Path()..moveTo(16.67*s,15.28*s)..lineTo(17.2*s,12*s)..lineTo(14.06*s,12*s)..lineTo(14.06*s,9.75*s)..cubicTo(14.06*s,8.8*s,14.53*s,7.88*s,16.02*s,7.88*s)..lineTo(17.33*s,7.88*s)..lineTo(17.33*s,5.15*s)..cubicTo(17.33*s,5.15*s,16.15*s,4.94*s,15.01*s,4.94*s)..cubicTo(12.45*s,4.94*s,10.67*s,6.57*s,10.67*s,9.41*s)..lineTo(10.67*s,12*s)..lineTo(7.78*s,12*s)..lineTo(7.78*s,15.28*s)..lineTo(10.67*s,15.28*s)..lineTo(10.67*s,24*s)..cubicTo(11.24*s,24.09*s,11.62*s,24*s,12*s,24*s)..cubicTo(12.38*s,24*s,12.76*s,24.09*s,13.33*s,24*s)..lineTo(13.33*s,15.28*s)..close(),
      Paint()..color = Colors.white..isAntiAlias = true);
  }
  @override bool shouldRepaint(covariant CustomPainter _) => false;
}