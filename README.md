# raylib-apl
A comprehensive library for creating cross-platform graphical applications using the Dyalog APL programming language. Built on the powerful [raylib](https://github.com/raysan5/raylib) C library, raylib-apl brings modern graphics programming to APL.

## Features
<img align="right" style="width:240px" src="https://github.com/user-attachments/assets/bf969426-7741-4eda-aa03-5c90ee6f87de">

- **Cross-platform**: Windows, Linux, and macOS* support
- **Input handling**: Keyboard, Mouse, Controller, and Touchscreen
- **Rich graphics**: 2D, 3D, Sound, Text, Vector graphics, Images/Textures, and shaders
- **Font support**: TTF, OTF, Image fonts, and AngelCode fonts
- **Texture formats**: Multiple formats including compressed (DXT, ETC, ASTC)
- **3D capabilities**: 3D Shapes, Models, Billboards, Heightmaps, and more
- **Materials system**: Classic maps and PBR (Physically Based Rendering) maps
- **Animation**: Skeletal bone animation (IQM, M3D, glTF)
- **Shaders**: Model shaders and postprocessing shaders
- **Math module**: Vector, Matrix, and Quaternion operations via raymath
- **Audio**: Loading and streaming (WAV, QOA, OGG, MP3, FLAC, XM, MOD)
- **VR support**: Stereo rendering with configurable HMD parameters

## Development Disclaimer
raylib-apl is in active development and should be considered experimental. Breaking changes may occur without notice. If you encounter code 999 errors, this likely indicates a segfault - please report these as bugs.

The library includes four modules:
- **raylib**: Core graphics library (stable)
- **raygui**: GUI library (limited testing)
- **physac**: 2D physics library (limited testing)
- **rlgl**: Low-level graphics (limited testing)

### Platform-Specific Notes
- **Windows & Linux**: Full support with all features
- ***macOS**: Supported, but requires `ENABLE_CEF=0` when starting Dyalog due to an unavoidable conflict with HtmlRenderer. On macOS, you cannot run both raylib-apl and HtmlRenderer in the same application/process.

## Quick Start

### Installation Methods

> **⚠️ macOS Users**: Start Dyalog with `ENABLE_CEF=0` to avoid HtmlRenderer conflicts. This can be done in the RIDE environment variables, or via command line:
> ```bash
> ENABLE_CEF=0 dyalog
> ```

#### Option 1: Tatin Package Manager (Recommended)
[Tatin](https://tatin.dev/) is Dyalog APL's package manager that makes installing and managing APL packages simple and reliable. When using Tatin, it is recommended to use [Cider](https://github.com/aplteam/Cider), which uses Link to load your project files, but does a whole lot more than just that.

For more information on Tatin usage, see [tatin.dev](https://tatin.dev/).

1. **Install Tatin** (if not already installed):
   ```apl
   ]Activate tatin
   ```
   Then restart Dyalog, update Tatin, and restart again:
   ```apl
   ]UpdateTatin
   ```

2. **Install raylib-apl**:
   ```apl
   ]Tatin.InstallPackages raylibapl
   ```

3. **Use in your code**:
   ```apl
   ⍝ Load the package
   rl ← raylibapl.raylib
   
   ⍝ Initialize (Tatin handles the path automatically)
   rl.Init raylibapl.TatinVars.HOME,'/link'
   
   ⍝ Create your first window
   rl.InitWindow 800 600 'My raylib-apl App'
   rl.CloseWindow⍬
   ```

#### Option 2: Manual Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/Brian-ED/raylib-apl.git
   cd raylib-apl
   ```

2. **Download dependencies**:
   ```bash
   dyalogscript install-raylib.apls
   ```
   Or manually download [temp-c-raylib](https://github.com/Brian-ED/temp-c-raylib/releases/) to the `raylib-apl/lib/` folder.

3. **Import manually**:
   ```apl
   rlDir ← '../raylib-apl/link/',⍨⊃1⎕NPARTS''
   rl ← 0⎕Fix rlDir,'raylib.apln'
   rl.Init rlDir
   ```

#### Alternative: Using Link
For development and experimentation, you can use Dyalog's Link system with the cloned repository:

```apl
]cd /path/to/raylib-apl/link
]link.create # .
raylib.Init ''

⍝ Now you can use raylib functions directly
raylib.InitWindow 800 800 'Hello World!'
:While ~raylib.WindowShouldClose⍬
    raylib.BeginDrawing⍬
        raylib.ClearBackground raylib.color.gray
    raylib.EndDrawing⍬
:EndWhile
raylib.CloseWindow⍬
```

### Creating Script Files
For standalone scripts, use the `.apls` extension and add this shebang line at the top:
```apl
#!cd $dir && /usr/bin/dyalogscript $fileName
```
Always run `.apls` files from their containing directory.

## Programming with raylib-apl

### Understanding the Architecture
raylib-apl is a direct, low-level interface to the raylib C library, providing approximately 200 functions that either return values or modify the application state. The library uses a **scope-based architecture** where certain functions create contexts that enable additional functionality.

### Core Concepts: Scopes and Contexts

#### The Window Context
Every raylib-apl application begins by creating a window context:

```apl
rl.InitWindow 800 600 'My Application'
⍝ Window context is now active
⍝ Many raylib functions are now available
rl.CloseWindow⍬
⍝ Window context is now closed
```

Within the window context, you can use functions like:
- `SetWindowIcon` - Set the window icon
- `GetScreenWidth` - Get the current screen width
- `GetMonitorCount` - Get the number of available monitors
- `LoadShader` - Load graphics shaders
- `GetMouseRay` - Get a ray from the mouse position

#### The Drawing Context
Most rendering must occur within a drawing context, which is nested inside the window context:

```apl
rl.BeginDrawing⍬
⍝ Drawing context is active
⍝ Can now use drawing functions
rl.ClearBackground rl.color.black
rl.DrawText 'Hello, World!' 10 10 20 rl.color.white
rl.EndDrawing⍬
⍝ Drawing context is closed and frame is presented
```

**Important**: `EndDrawing` automatically handles frame timing, limiting your application to the monitor's refresh rate (typically 60 FPS). If your frame logic takes longer than 1/60th of a second, `EndDrawing` won't add additional delay.

### Your First Application
Here's a complete raylib-apl application that demonstrates the standard structure:

```apl
⍝ Initialize the library (using Tatin)
rl ← raylibapl.raylib
rl.Init raylibapl.TatinVars.HOME,'/link'

⍝ Create a window
rl.InitWindow 800 600 'My First raylib-apl App'

⍝ Main application loop
:While ~rl.WindowShouldClose⍬
    rl.BeginDrawing⍬
        rl.ClearBackground rl.color.darkblue
        rl.DrawText 'Hello, raylib-apl!' 10 10 20 rl.color.white
    rl.EndDrawing⍬
:EndWhile

⍝ Clean up
rl.CloseWindow⍬
```

### Exploring Further
- **Examples**: Check out the [examples directory](https://github.com/Brian-ED/raylib-apl/tree/master/examples) for practical demonstrations
- **API Reference**: Examine the [raylib.apln file](https://github.com/Brian-ED/raylib-apl/blob/master/link/raylib.apln) for available functions and constants
- **Constants**: Use values like `raylib.KeyboardKey.KEY_SLASH` with functions like `rl.IsKeyPressed` to check for specific key presses

### Common Patterns
Most raylib-apl applications follow this pattern:
1. Initialize the library
2. Create a window
3. Load resources (textures, sounds, etc.)
4. Enter the main loop:
   - Process input
   - Update game state
   - Draw the frame
5. Clean up resources
6. Close the window

## Advanced Usage

### Using dyalogscript
All raylib-apl examples are designed to work with [dyalogscript](https://help.dyalog.com/19.0/#UserGuide/Installation%20and%20Configuration/Shell%20Scripts.htm?Highlight=dyalogscript) for easy execution. Simply add this shebang line at the top of your `.apls` files:

```apl
#!cd $dir && /usr/bin/dyalogscript $fileName
```

### Multiple Library Support
raylib-apl provides access to four distinct libraries:

| Library | Description | Status |
|---------|-------------|---------|
| **raylib** | Core graphics and windowing | ✅ Stable |
| **raygui** | Immediate-mode GUI system | ⚠️ Limited testing |
| **physac** | 2D physics simulation | ⚠️ Limited testing |
| **rlgl** | Low-level graphics wrapper | ⚠️ Limited testing |

### Development and Parsing
The library includes pre-parsed bindings, but if you need to regenerate them:

1. Install [CBQN](https://github.com/dzaima/CBQN)
2. Run: `bqn raylib-apl/parse-raylib-apl/parseAll.bqn`

This parsing system converts the raylib C headers into APL-compatible function definitions.

## Contributing and Support

### Reporting Issues
If you encounter problems:
- **Code 999 errors**: Usually indicate segfaults - please report with details
- **General issues**: Use the GitHub issue tracker
- **Questions**: Check existing examples and documentation first

### Community
- **Examples**: Browse the [examples directory](https://github.com/Brian-ED/raylib-apl/tree/master/examples) for inspiration
- **raylib Documentation**: The [official raylib cheatsheet](https://www.raylib.com/cheatsheet/cheatsheet.html) applies to raylib-apl functions
- **APL Resources**: Visit [Dyalog's website](https://www.dyalog.com/) for APL learning materials

## Credits and Acknowledgments

### Dyalog Limited
raylib-apl is financially supported by [Dyalog Limited](https://www.dyalog.com/). Development began in July 2024 when Brian was hired as an intern to work on this project alongside [Asher](https://github.com/asherbhs). The project continues to receive funding and support from [the Dyalog team](https://www.dyalog.com/meet-team-dyalog.htm).

### raylib Community
This project builds upon the excellent [raylib C library](https://github.com/raysan5/raylib/) created by raysan5. We're grateful to the entire raylib community for their foundational work.

### Technical Contributors
- **Marshall Lochbaum**: The parsing system uses [json.bqn](https://github.com/mlochbaum/bqn-libs/blob/master/json.bqn) and is built with the BQN programming language
- **temp-c-raylib**: The C bindings are provided by the [temp-c-raylib](https://github.com/Brian-ED/temp-c-raylib/) project

---

## License
This project is licensed under the terms specified in the [LICENSE](LICENSE) file.

*Ready to start building amazing graphics applications with APL? Check out the [examples](https://github.com/Brian-ED/raylib-apl/tree/master/examples) and dive in!*
