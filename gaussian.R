library(ggplot2)
library(grid)

theme_nothing <- function(base_size = 12, base_family = "Helvetica")
{
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(
      rect             = element_blank(),
      line             = element_blank(),
      text             = element_blank(),
      axis.ticks.margin = unit(0, "lines")
    )
}

x <- seq(-5, 5, 0.01)
y <- exp(-x^2)
df <- data.frame(x=x, y=y)
ggplot(df, aes(x, y)) + geom_line(colour="red") + theme_nothing()
ggsave("images/pulse.png", width=20, height=20, units="mm", bg = "transparent")
