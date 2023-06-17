import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final game = MainApp();
  runApp(GameWidget(
    game: game,
  ));
}

class MainApp extends FlameGame with SingleGameInstance {
  MainApp({super.camera, super.children});

  late final World world;
  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    images.loadAll(['black_padle.png', 'white_padle.png']);
    world = World();
    await add(world);
    cameraComponent = CameraComponent(world: world);
    await add(cameraComponent);
    world.add(BlackPaddle());
    world.add(WhitePaddle());
  }

  @override
  Color backgroundColor() => Colors.white54;
}

class BlackPaddle extends SpriteComponent with HasGameRef<MainApp>, ParentIsA<World> {

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(64, 64);
    position = Vector2(Get.width / 2, Get.height);
    anchor = Anchor.bottomCenter;
    sprite = Sprite(await game.images.load('black_padle.png'));
  }
}

class WhitePaddle extends SpriteComponent with HasGameRef<MainApp>, ParentIsA<World> {

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(64, 64);
    position = Vector2(Get.width / 2, 0);
    anchor = Anchor.bottomCenter;
    angle = pi;
    sprite = Sprite(await game.images.load('white_padle.png'));
  }
}
