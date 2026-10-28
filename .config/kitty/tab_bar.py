from kitty.tab_bar import draw_title


def draw_tab(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data) -> int:
    if len(getattr(draw_data, "title", "")) > 23:
        draw_data.title = draw_data.title[:20] + "..."
    draw_title(draw_data, screen, tab, index)
    return screen.cursor.x
