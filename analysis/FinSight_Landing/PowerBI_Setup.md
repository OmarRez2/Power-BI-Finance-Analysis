# FinSight Landing Page — Power BI setup

The provided HTML and CSS create the visual design. Power BI native buttons perform page navigation.

1. Save a **copy** of `FINANACE ANALYSIS PROJECT.pbip` for the training version. Create a new page named `Start` and set the canvas to 16:9, ideally 1920 × 1080. Set page display to Fit to page.
2. Add the **HTML Content** custom visual, expand it to cover the canvas, and turn off its container title, border, shadow, and background. If it does not fill the page, remove its inner padding.
3. Create a measure named `FinSight Landing HTML` using `FinSight_Landing_Measure.dax` and put it in the HTML Content visual's **Values** field.
4. In the HTML Content format pane, open **Stylesheet**, paste the full contents of `landing.css` into its CSS definition. The CSS contains scoped classes, so it won't modify other report visuals. If using HTML Content (lite), check its CSS sanitizer; unsupported rules can be stripped.
5. Insert → Buttons → Blank **twice**. Place both ABOVE the HTML Content visual using View → Selection pane / Bring to front. Make their fill, border, text, and icon 100% transparent in Default, Hover, and Pressed states. The visual shows the button artwork underneath; native buttons handle the clicks.
6. Align Button 1 exactly on the gold `Open Overview` area. In Format button → Action: On → Type: **Page navigation** → Destination: **Overview  Analysis**. Align Button 2 on the outlined `Explore Transactions` area with Destination: **Transactions**. Use the exact page names shown by Power BI's destination dropdown; spacing in the saved model may be normalized.
7. Verify by Ctrl+clicking each button in Power BI Desktop edit mode. In reading mode, a normal click should navigate. Check again after publishing if the report will be shared.

Use the browser preview for visual review only. The clickable layer on the Power BI page is the native Button, so the HTML itself deliberately has no pretend JavaScript navigation.

Power BI button positions depend on the visual's final pixel rectangle and Display view. At a 1920 × 1080 canvas, initial overlay estimates are: gold X≈87, Y≈535, W≈295, H≈73; outline X≈406, Y≈535, W≈345, H≈73. Adjust visually once the HTML Content visual fills the canvas. The CTA artwork is responsive; final overlay must be verified on the saved page.

CSS animations: gold and blue chart lines draw on load; the graphic cards rise in gently; floating labels move by a few pixels. CSS-only, with reduced-motion support. Power BI/HTML Content versions may sanitize or skip some animation rules; check in Desktop and Service.

Sources:
- https://learn.microsoft.com/en-us/power-bi/create-reports/desktop-buttons
- https://html-content.com/docs/limitations
- https://html-content.com/docs/properties-stylesheet
