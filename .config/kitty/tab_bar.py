from datetime import datetime
from time import monotonic

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title

SETTLE = 0.1  # titles living shorter than this never paint (kills ls flicker)
_shown = {}
_pending = {}
_timer = None


def _redraw(timer_id):
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()


def _stable(tab: TabBarData) -> TabBarData:
    if tab.tab_id < 0:
        return tab
    now = monotonic()
    cur = tab.title
    shown = _shown.setdefault(tab.tab_id, cur)
    if cur == shown:
        _pending.pop(tab.tab_id, None)
        return tab
    started, val = _pending.get(tab.tab_id, (now, cur))
    if val != cur:
        started, val = now, cur
    _pending[tab.tab_id] = (started, val)
    if now - started >= SETTLE:
        _shown[tab.tab_id] = cur
        _pending.pop(tab.tab_id, None)
        return tab
    return tab._replace(title=shown)


def draw_tab(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data) -> int:
    global _timer
    if _timer is None:
        _timer = add_timer(_redraw, 0.1, True)
    draw_title(draw_data, screen, _stable(tab), index)
    end = screen.cursor.x
    if is_last and not extra_data.for_layout:
        clock = datetime.now().strftime(" %H:%M ")
        screen.draw(" " * max(0, screen.columns - screen.cursor.x - len(clock)))
        screen.draw(clock)
    return end
