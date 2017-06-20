# sobole

Minimalistic `zsh` theme inspired by the old-fashioned hobbies. Works well on a light background.


## Showcase

![sobole.zsh-theme](https://raw.githubusercontent.com/sobolevn/sobole-zsh-theme/master/showcases/showcase.gif)

There are multiple examples provided in the [showcases directory](/showcases).


## Installation

### antigen

If you're using [`antigen`](https://github.com/zsh-users/antigen), you can test these themes in a running `zsh` with `antigen theme sobolevn/sobole-zsh-theme`.

### zgen

If you're using `zgen`, add them to your `init.zsh` with `zgen load sobolevn/sobole-zsh-theme`.

### Manual

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


## Fonts

You can choose any font that prints unicode symbols. In the examples `Menlo Regular` is used.

You can install it with: `brew cask install font-menlo-for-powerline`. Or download it [here](https://github.com/hbin/top-programming-fonts/blob/master/Menlo-Regular.ttf).

And then configure your terminal's `font` setting.


## References

This theme borrows some setup from [`avit`](https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/avit.zsh-theme) and [`obraun`](https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/obraun.zsh-theme) themes.


## License

[WTFPL](https://en.wikipedia.org/wiki/WTFPL): do the fuck you want.
If you had sold it, let me know just for fun.
