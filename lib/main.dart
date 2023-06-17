import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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

    world = World();
    await add(world);
    cameraComponent = CameraComponent(world: world);
    await add(cameraComponent);
    world.add(SpriteThing());
  }
}

class SpriteThing extends PositionComponent with HasGameRef<MainApp> {

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(100, 100);
    position = Vector2(game.cameraComponent.viewfinder.anchor.x,
        game.cameraComponent.viewfinder.anchor.y);
    anchor = Anchor.center;
  }
}
