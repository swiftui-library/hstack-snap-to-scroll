# SnapToScroll

Drop-in container view for horizontal snapping. 

## Getting Started

Using `SnapToScroll` is straightforward. There's only two requirements:

1. Replace `HStack` with `HStackSnap`
2. Add `GeometryReaderOverlay` to your view.

An example:

```swift

HStackSnap(leadingOffset: 16) {

    ForEach(modelArray) { viewModel in

        myView(viewModel: viewModel)
            .frame(maxWidth: 250)
            .overlay(GeometryReaderOverlay(id: viewModel.id))
        }
    }
}
                    
```
For more examples, see `SnapToScrollDemo/ContentView.swift`.

## Options

`HStackSnap` comes with two customizable properties:

- `leadingOffset`: The leading padding you'd like each element to snap to.
- `coordinateSpace`: Option to set custom name for the coordinate space, in the case you're using multiple `HStackSnap`s of various sizes.

## Limitations

1. If your child views are designed to take up all available horizontal space, they'll expand beyond the visible view. Prevent this with `.frame(maxWidth: x)`
2. `HStackSnap` is currently designed to work with static content.
3. At the moment, `HStackSnap` offers snapping to the leading edge only. If you'd like to offer a PR that adds support for `.center` and / or `.trailing`, I'd love to look it over!

## How it Works

