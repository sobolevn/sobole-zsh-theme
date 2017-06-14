# sobole

Minimalistic `zsh` theme inspired by the old-fashioned hobbies.


## Showcase

![sobole.zsh-theme](https://raw.githubusercontent.com/sobolevn/sobole-zsh-theme/master/showcases/showcase.gif)


## Installation

Just copy the [`sobole.zsh-theme`](/sobole.zsh-theme) to your `~/.oh-my-zsh/custom/themes/` folder.

This set of commands will probably do what you want:

```shell
git clone https://github.com/sobolevn/sobole-zsh-theme.git
ln -s $PWD/sobole-zsh-theme/sobole.zsh-theme ~/.oh-my-zsh/custom/themes/sobole.zsh-theme
```

Then set `ZSH_THEME="sobole"` inside your `.zshrc`.

Here's the [official docs](https://github.com/robbyrussell/oh-my-zsh/wiki/Customization#overriding-and-adding-themes) on how to do that.


## Features

`virtualenv`, `git`, `ls`, `grep`, pretty error codes, different users, different color modes


## Configuration

This theme supports several configuration options, which are provided as `env` variables:

`$DEFAULT_USER` - this options sets how the user is displayed. User is not displayed until it equals `$DEFAULT_USER`, but imagine you executed `sudo su - admin`, that's how it will look like:

![sobole.zsh-theme](https://raw.githubusercontent.com/sobolevn/sobole-zsh-theme/master/showcases/user-showcase.png)

`$DEFAULT_COLOR_MODE` - this setting sets the color mode: `white` or `dark`, currently #WIP


## References

This theme borrows some setup from [`avit`](https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/avit.zsh-theme) and [`obraun`](https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/obraun.zsh-theme) themes.


## License

[WTFPL](https://en.wikipedia.org/wiki/WTFPL): do the fuck you want.
If you had sold it, let me know just for fun.
