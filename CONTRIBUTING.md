# Contributing to Liberation
  Thank you for considering contributing to Liberation. Every bit helps everyone ascend even further.

## Setup
  Clone the repository or download the .lua script<br/>
```
git clone https://github.com/NKillHere/Liberation
```
  Paste the file into your Counter-Strike: Global Offensive directory.
  Open with the editor of your choice.
## Submitting PRs
  1. Fork the repo and create a branch from `main`<br/>
  2. Write your code, I recommend keeping them focused with 1 small-ish topic at a time.<br/>
  3. Obviously, you are denied from directly copying code from scripts that you have not developed. This violates the license and would get your request instantly denied.<br/>
  4. Check your code for bugs and please do check for particularly obvious edge cases such as: "What if the player had toggled the down override whilst he had the right override already toggled on?"<br/>
  5. Explain in decent detail the changes done to implement what is in the title, what you changed and what it accomplishes.<br/>

## Code Style
  * Constants are in screaming snake case (`EXAMPLE_HERE`)
  * Functions are in pascal case (`ExampleHere`)
  * Menu elements are in camel case (`exampleHere`, `kindaLikethis` for 3+ words)
  * Variables and references are in snake case (`example_here`)
  It would be highly appreciated to commit with the style in mind. If not, it will need to be adjusted before being merged into `main`.
  
## What we're looking for
  * Code that fixes any bug that isn't flagged as `wontfix`
  * Code that implements any approved suggestions
  * Documentation improvements
  * New, useful features(I do recommend making an issue with the `enhancement` tag to check for compatibility first.) 
  
## AI usage
  Same rules as the Linux kernel. If something breaks, it's on you. 
  
## What we'll probably say no to:
  * New dependencies that clearly conflict with the license of the script
  * Features that are regarded as particularly useless or inefficient resource-wise, e.g. "Side watermark with catgirl picture (image rendering is resource-expensive and should be avoided.)"
  * Changes that break existing implementations(e.g. changing set variables or constants)  without strong justification.

## Suggestions
When filing a feature request, please include:
  * The use case with explanation. "I want X because Y" is more useful than "please add X".
  * Check that your suggestion was not made before. If it was, just react positively to it.
  * Use the 'enhancement' label
  * Describe it in the most detail you could, We are not Nostradamus, we cannot read your mind.

## Reporting issues  
When filing a bug report, please include:
  * If on the Debug version, link to the commit version of the version you are using. If not, the release version of the script. 
  * The feature of which is broken
  * Steps to recreate the bug, preferably
  * Screenshot or clip of the bug, if possible
  * Any further details not covered by the other points.

### How to get the commit version link:
  <img width="1857" height="957" alt="image" src="https://github.com/user-attachments/assets/f5478b68-e2a2-4674-a318-e2184c9558a2" />

## License
  By contributing, you acknowledge the fact that your contributions will be licensed under [version 3 of the GNU General Public License](https://github.com/NKillHere/Liberation/blob/main/LICENSE).
