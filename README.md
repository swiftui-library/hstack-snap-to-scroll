# SnapToScroll

Drop-in SwiftUI-based container view for horizontal snapping. 

To see the rest of the SwiftUI Library, visit [our website](https://swiftuilibrary.com). 

https://user-images.githubusercontent.com/8763719/131696736-0474ae54-35ad-4579-ab1e-366ae101949b.mp4

## Getting Started

Using `SnapToScroll` is straightforward. There's just three steps.

1. Import `SnapToScroll`
2. Replace `HStack` with `HStackSnap`
3. Add `.snapAlignmentHelper` to your view.

An example:

```swift
import SnapToScroll                               // Step 1
...

HStackSnap(alignment: .center(32)) {              // Step 2

    ForEach(myModels) { viewModel in

        MyView(
            selectedIndex: $selectedIndex,
            viewModel: viewModel
         )
         .snapAlignmentHelper(id: viewModel.id)   // Step 3
     }
}                  
```
For more examples, see `SnapToScrollDemo/ContentView.swift`.

## Configuration

`HStackSnap` comes with two customizable properties:

- `alignment`: The way you'd like your elements to be arranged. 
    - `leading(CGFloat)`: Aligns your child views to the leading edge of `HStackSnap`. This configuration supports elements of various sizes, so long as they don't take up all available horizontal space (which would extend beyond the screen). Use the value to set the size of the left offset.
    - `center(CGFloat)`: Automatically aligns your child view to the center of the screen, using the offset value you've provided. This is accomplished with inside of the `.snapAlignmentHelper` which sets the frame width based on the available space. Note that setting your own width elsewhere may produce unexpected layouts.
- `coordinateSpace`: Option to set custom name for the coordinate space, in the case you're using multiple `HStackSnap`s of various sizes. If you use this, set the same value in `.snapAlignmentHelper`.

`.snapAlignmentHelper` comes with two options as well:

- `id`: Required. A unique ID for the element. 
- `coordinateSpace`: Same as above.

## Limitations

- `HStackSnap` is currently designed to work with static content. 

## How it Works

At render, `HStackSnap` reads the frame data of each child element and calculates the `scrollOffset` each element should use. Then, on `DragGesture.onEnded`, the nearest snap location is calculated, and the scroll offset is set to this point.

Read through `HStackSnap.swift` and `Views/HStackSnapCore.swift` for more details.

## Credits

Thanks to pixeltrue for the [illustrations](https://www.pixeltrue.com/scenic-illustrations#download) used in example 2.
