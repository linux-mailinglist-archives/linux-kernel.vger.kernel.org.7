Return-Path: <linux-kernel+bounces-730525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F9B045CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA961A67F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B24126B2C5;
	Mon, 14 Jul 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3sErmGF"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5D26A1B0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511478; cv=none; b=iBfbySAYIXsxyNfwScNwtxvcYmCeAOP7PhbULrcKxzEoexzS9Ly3VttEBkZR25nlSOoPT/roE2gOcTJeUYNnLjg8+6ML4ObLp5H+FDLVpuZaGEOMKjCSD//hkcbXOprf2niVNsqBnEOK2DoxS03DtUHsU0F5hNe0OzvwaAOVov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511478; c=relaxed/simple;
	bh=lZ01dakQXySbk0VIZsFU3Su8sp/K1sJY6ib0gDLkgqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NeF1+itiXNcNhH1H1sCOR0+y1xNIOt1zvPWKR1I2I8r+nQCwzOIYP1k3ir6FR7exlPD7Myqjz6DRAE8nUQH1yPxmwe3zeQg+/9mkykNd3itEUb6jNXpsebX8ZDJGhns/nxOwr9OBJqXRWJHYfTQ9VknLVKeCHOFdHhcHGHUO98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3sErmGF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2356ce55d33so68535785ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511474; x=1753116274; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJg6wNeRQI/rZafa9zX6BQIXCqaXSsDBkbUeXANnyAk=;
        b=v3sErmGFdLeWJyPz1vIQDwYs9TCSuMc9REHNi+YnQwgvBjeMbDP0dBUJJi7+r6XQZr
         87+pp4x1cFkVmk+nYtAHkFcqCmVn58MfCDenz8u93/vXw/KF6vmNyyghtAWRdtIGHY6E
         cjc4tZiaPm1OvOJj/9kMbmt7Ajf465yvsBZtKxk8S0f8nweK4B+dZekDL9K1X8cD87ms
         1Mr9GAPn5lWtAcrXZZ2SukrbcVvR8xVqA3FUqvil5dlnX+Jb8/RLAj9NDACy3ShQEW8v
         dqRCzp/C/pvVbHDU/wqDYdIQn+GCZS79Rhxv66rEAZPCj1vpn4suXCOqit9A6jZoDIEU
         OV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511474; x=1753116274;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJg6wNeRQI/rZafa9zX6BQIXCqaXSsDBkbUeXANnyAk=;
        b=GfSLmjAP0HrAIXLO5ptxkfEnKcZqcURW2TAMBTclZpFW8vVxLPZvu5+S/otDrfD9fO
         IlD3T412SOqsLwlsdNowUbcQNb2hWcHXRBc0/6z2TXixmhzYMQgd8Ze3tJ0YBU0iifba
         qgfKr2wTyjYP6+s763zxSvjkV52h5pojvvaMxX3KzfWi8GU0o2syEFnBjKzlmXfQlBw5
         nKvnSztlo+E+9L2WR2/wD3XZudlinCwSy7YNc+Zu5oFz1CHzc92BvF8OdGE1vwc48uTO
         VyXEuLOBhDOp3TeVXwVDqJ+QHJ9B4DNwwf93N42pMN85c3y87jMB6sZgh2PCxzN+yEC5
         p6lw==
X-Forwarded-Encrypted: i=1; AJvYcCVhRYtL9b79kfzGz8hw+PhHAxbVwJu0y309z//n0fQUgV50RBPrMv11SYs4qP4y9zFqV0LhKsU1NVbCNzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+gHlwUmhMIfkgAiUEbNRb2omlvJfjuDKJcQaOEhrCwUvaAmKH
	56+qQy6HimlsdGRHy365D1OnByYWnXtYkNvwq7qbLIBkdqb+EiuJU2sGF3Js3AnpinFwjgNv5Ze
	/9NRb8Ae+PQ==
X-Google-Smtp-Source: AGHT+IG8oAS5KN7fgBmiqFluRYmtWvPQuf0d4/jS33kvuJfhJfi5wzN6zrt9xta9WRSrBM9jPp4mH8bYp4zk
X-Received: from plgb7.prod.google.com ([2002:a17:902:d507:b0:23d:d2e9:8861])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:8b8b:b0:238:f2a:8893
 with SMTP id d9443c01a7336-23dede984b9mr128192045ad.42.1752511474611; Mon, 14
 Jul 2025 09:44:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:43:59 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-12-irogers@google.com>
Subject: [PATCH v7 11/16] perf ilist: Add new python ilist command
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The perf ilist command is a textual app [1] similar to perf list. In
the top-left pane a tree of PMUs is displayed. Selecting a PMU expands
the events within it. Selecting an event displays the `perf list`
style event information in the top-right pane.

When an event is selected it is opened and the counters on each CPU
the event is for are periodically read. The bottom of the screen
contains a scrollable set of sparklines showing the events in total
and on each CPU. Scrolling below the sparklines shows the same data as
raw counts. The sparklines are small graphs where the height of the
bar is in relation to maximum of the other counts in the graph.

By default the counts are read with an interval of 0.1 seconds (10
times per second). A -I/--interval command line option allows the
interval to be changed. The oldest read counts are dropped when the
counts fill the line causing the sparkline to move from right to left.

A search box can be pulled up with the 's' key. 'n' and 'p' iterate
through the search results. As some PMUs have hundreds of events a 'c'
key will collapse the events in the current PMU to make navigating the
PMUs easier.

[1] https://textual.textualize.io/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/ilist.py | 392 +++++++++++++++++++++++++++++++++++++
 1 file changed, 392 insertions(+)
 create mode 100755 tools/perf/python/ilist.py

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
new file mode 100755
index 000000000000..b21f4c93247e
--- /dev/null
+++ b/tools/perf/python/ilist.py
@@ -0,0 +1,392 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+"""Interactive perf list."""
+
+import argparse
+from typing import Any, Dict, Tuple
+import perf
+from textual import on
+from textual.app import App, ComposeResult
+from textual.binding import Binding
+from textual.containers import Horizontal, HorizontalGroup, Vertical, VerticalScroll
+from textual.command import SearchIcon
+from textual.screen import ModalScreen
+from textual.widgets import Button, Footer, Header, Input, Label, Sparkline, Static, Tree
+from textual.widgets.tree import TreeNode
+
+class ErrorScreen(ModalScreen[bool]):
+    """Pop up dialog for errors."""
+
+    CSS="""
+    ErrorScreen {
+        align: center middle;
+    }
+    """
+    def __init__(self, error: str):
+        self.error = error
+        super().__init__()
+
+    def compose(self) -> ComposeResult:
+        yield Button(f"Error: {self.error}", variant="primary", id="error")
+
+    def on_button_pressed(self, event: Button.Pressed) -> None:
+        self.dismiss(True)
+
+
+class SearchScreen(ModalScreen[str]):
+    """Pop up dialog for search."""
+
+    CSS="""
+    SearchScreen Horizontal {
+        align: center middle;
+        margin-top: 1;
+    }
+    SearchScreen Input {
+        width: 1fr;
+    }
+    """
+    def compose(self) -> ComposeResult:
+        yield Horizontal(SearchIcon(), Input(placeholder="Event name"))
+
+    def on_input_submitted(self, event: Input.Submitted) -> None:
+        """Handle the user pressing Enter in the input field."""
+        self.dismiss(event.value)
+
+
+class Counter(HorizontalGroup):
+    """Two labels for a CPU and its counter value."""
+
+    CSS="""
+    Label {
+        gutter: 1;
+    }
+    """
+
+    def __init__(self, cpu: int) -> None:
+        self.cpu = cpu
+        super().__init__()
+
+    def compose(self) -> ComposeResult:
+        label = f"cpu{self.cpu}" if self.cpu >= 0 else "total"
+        yield Label(label + " ")
+        yield Label("0", id=f"counter_{label}")
+
+
+class CounterSparkline(HorizontalGroup):
+    """A Sparkline for a performance counter."""
+
+    def __init__(self, cpu: int) -> None:
+        self.cpu = cpu
+        super().__init__()
+
+    def compose(self) -> ComposeResult:
+        label = f"cpu{self.cpu}" if self.cpu >= 0 else "total"
+        yield Label(label)
+        yield Sparkline([], summary_function=max, id=f"sparkline_{label}")
+
+
+class IListApp(App):
+    TITLE = "Interactive Perf List"
+
+    BINDINGS = [
+        Binding(key="s", action="search", description="Search",
+                tooltip="Search events and PMUs"),
+        Binding(key="n", action="next", description="Next",
+                tooltip="Next search result or item"),
+        Binding(key="p", action="prev", description="Previous",
+                tooltip="Previous search result or item"),
+        Binding(key="c", action="collapse", description="Collapse",
+                tooltip="Collapse the current PMU"),
+        Binding(key="^q", action="quit", description="Quit",
+                tooltip="Quit the app"),
+    ]
+
+    CSS = """
+        /* Make the 'total' sparkline a different color. */
+        #sparkline_total > .sparkline--min-color {
+            color: $accent;
+        }
+        #sparkline_total > .sparkline--max-color {
+            color: $accent 30%;
+        }
+        /*
+         * Make the active_search initially not displayed with the text in
+         * the middle of the line.
+         */
+        #active_search {
+            display: none;
+            width: 100%;
+            text-align: center;
+        }
+    """
+
+    def __init__(self, interval: float) -> None:
+        self.interval = interval
+        self.evlist = None
+        self.search_results: list[TreeNode[str]] = []
+        self.cur_search_result: TreeNode[str] | None = None
+        super().__init__()
+
+
+
+    def expand_and_select(self, node: TreeNode[Any]) -> None:
+        """Expand select a node in the tree."""
+        if node.parent:
+            node.parent.expand()
+            if node.parent.parent:
+                node.parent.parent.expand()
+        node.expand()
+        node.tree.select_node(node)
+        node.tree.scroll_to_node(node)
+
+
+    def set_searched_tree_node(self, previous: bool) -> None:
+        """Set the cur_search_result node to either the next or previous."""
+        l = len(self.search_results)
+
+        if l < 1:
+            tree: Tree[str] = self.query_one("#pmus", Tree)
+            if previous:
+                tree.action_cursor_up()
+            else:
+                tree.action_cursor_down()
+            return
+
+        if self.cur_search_result:
+            idx = self.search_results.index(self.cur_search_result)
+            if previous:
+                idx = idx - 1 if idx > 0 else l - 1
+            else:
+                idx = idx + 1 if idx < l - 1 else 0
+        else:
+            idx = l - 1 if previous else 0
+
+        node = self.search_results[idx]
+        if node == self.cur_search_result:
+            return
+
+        self.cur_search_result = node
+        self.expand_and_select(node)
+
+    def action_search(self) -> None:
+        """Search was chosen."""
+        def set_initial_focus(event: str | None) -> None:
+            """Sets the focus after the SearchScreen is dismissed."""
+
+            search_label = self.query_one("#active_search", Label)
+            search_label.display = True if event else False
+            if not event:
+                return
+            event = event.lower()
+            search_label.update(f'Searching for events matching "{event}"')
+
+            tree: Tree[str] = self.query_one("#pmus", Tree)
+            def find_search_results(event: str, node: TreeNode[str], \
+                                    cursor_seen: bool = False, \
+                                    match_after_cursor: TreeNode[str] | None = None) \
+                    -> Tuple[bool, TreeNode[str] | None]:
+                """Find nodes that match the search remembering the one after the cursor."""
+                if not cursor_seen and node == tree.cursor_node:
+                    cursor_seen = True
+                if node.data and event in node.data:
+                    if cursor_seen and not match_after_cursor:
+                        match_after_cursor = node
+                    self.search_results.append(node)
+
+                if node.children:
+                    for child in node.children:
+                        (cursor_seen, match_after_cursor) = \
+                            find_search_results(event, child, cursor_seen, match_after_cursor)
+                return (cursor_seen, match_after_cursor)
+
+            self.search_results.clear()
+            (_ , self.cur_search_result) = find_search_results(event, tree.root)
+            if len(self.search_results) < 1:
+                self.push_screen(ErrorScreen(f"Failed to find pmu/event {event}"))
+                search_label.display = False
+            elif self.cur_search_result:
+                self.expand_and_select(self.cur_search_result)
+            else:
+                self.set_searched_tree_node(previous=False)
+
+        self.push_screen(SearchScreen(), set_initial_focus)
+
+
+    def action_next(self) -> None:
+        """Next was chosen."""
+        self.set_searched_tree_node(previous=False)
+
+
+    def action_prev(self) -> None:
+        """Previous was chosen."""
+        self.set_searched_tree_node(previous=True)
+
+
+    def action_collapse(self) -> None:
+        """Collapse the potentially large number of events under a PMU."""
+        tree: Tree[str] = self.query_one("#pmus", Tree)
+        node = tree.cursor_node
+        if node and node.parent and node.parent.parent:
+            node.parent.collapse_all()
+            node.tree.scroll_to_node(node.parent)
+
+
+    def update_counts(self) -> None:
+        """Called every interval to update counts."""
+        if not self.evlist:
+            return
+
+        def update_count(cpu: int, count: int):
+            # Update the raw count display.
+            counter: Label = self.query(f"#counter_cpu{cpu}" if cpu >= 0 else "#counter_total")
+            if not counter:
+                return
+            counter = counter.first(Label)
+            counter.update(str(count))
+
+            # Update the sparkline.
+            line: Sparkline = self.query(f"#sparkline_cpu{cpu}" if cpu >= 0 else "#sparkline_total")
+            if not line:
+                return
+            line = line.first(Sparkline)
+            # If there are more events than the width, remove the front event.
+            if len(line.data) > line.size.width:
+                line.data.pop(0)
+            line.data.append(count)
+            line.mutate_reactive(Sparkline.data)
+
+        # Update the total and each CPU counts, assume there's just 1 evsel.
+        total = 0
+        self.evlist.disable()
+        for evsel in self.evlist:
+            for cpu in evsel.cpus():
+                aggr = 0
+                for thread in evsel.threads():
+                    counts = evsel.read(cpu, thread)
+                    aggr += counts.val
+                update_count(cpu, aggr)
+                total += aggr
+        update_count(-1, total)
+        self.evlist.enable()
+
+
+    def on_mount(self) -> None:
+        """When App starts set up periodic event updating."""
+        self.update_counts()
+        self.set_interval(self.interval, self.update_counts)
+
+
+    def set_pmu_and_event(self, pmu: str, event: str) -> None:
+        """Updates the event/description and starts the counters."""
+        # Remove previous event information.
+        if self.evlist:
+            self.evlist.disable()
+            self.evlist.close()
+            lines = self.query(CounterSparkline)
+            for line in lines:
+                line.remove()
+            lines = self.query(Counter)
+            for line in lines:
+                line.remove()
+
+        def pmu_event_description(pmu: str, event: str) -> str:
+            """Find and format event description for {pmu}/{event}/."""
+            def get_info(info: Dict[str, str], key: str):
+                return (info[key] + "\n") if key in info else ""
+
+            for p in perf.pmus():
+                if p.name() != pmu:
+                    continue
+                for info in p.events():
+                    if "name" not in info or info["name"] != event:
+                        continue
+
+                    desc = get_info(info, "topic")
+                    desc += get_info(info, "event_type_desc")
+                    desc += get_info(info, "desc")
+                    desc += get_info(info, "long_desc")
+                    desc += get_info(info, "encoding_desc")
+                    return desc
+            return "description"
+
+        # Parse event, update event text and description.
+        full_name = event if event.startswith(pmu) or ':' in event else f"{pmu}/{event}/"
+        self.query_one("#event_name", Label).update(full_name)
+        self.query_one("#event_description", Static).update(pmu_event_description(pmu, event))
+
+        # Open the event.
+        try:
+            self.evlist = perf.parse_events(full_name)
+            if self.evlist:
+                self.evlist.open()
+                self.evlist.enable()
+        except:
+            self.evlist = None
+
+        if not self.evlist:
+            self.push_screen(ErrorScreen(f"Failed to open {full_name}"))
+            return
+
+        # Add spark lines for all the CPUs. Note, must be done after
+        # open so that the evlist CPUs have been computed by propagate
+        # maps.
+        lines = self.query_one("#lines")
+        line = CounterSparkline(cpu=-1)
+        lines.mount(line)
+        for cpu in self.evlist.all_cpus():
+            line = CounterSparkline(cpu)
+            lines.mount(line)
+        line = Counter(cpu=-1)
+        lines.mount(line)
+        for cpu in self.evlist.all_cpus():
+            line = Counter(cpu)
+            lines.mount(line)
+
+
+    def compose(self) -> ComposeResult:
+        """Draws the app."""
+        def pmu_event_tree() -> Tree:
+            """Create tree of PMUs with events under."""
+            tree: Tree[str] = Tree("PMUs", id="pmus")
+            tree.root.expand()
+            for pmu in perf.pmus():
+                pmu_name = pmu.name().lower()
+                pmu_node = tree.root.add(pmu_name, data=pmu_name)
+                try:
+                    for event in sorted(pmu.events(), key=lambda x: x["name"]):
+                        if "name" in event:
+                            e = event["name"].lower()
+                            if "alias" in event:
+                                pmu_node.add_leaf(f'{e} ({event["alias"]})', data=e)
+                            else:
+                                pmu_node.add_leaf(e, data=e)
+                except:
+                    # Reading events may fail with EPERM, ignore.
+                    pass
+            return tree
+
+        yield Header(id="header")
+        yield Horizontal(Vertical(pmu_event_tree(), id="events"),
+                         Vertical(Label("event name", id="event_name"),
+                                  Static("description", markup=False, id="event_description"),
+                                  ))
+        yield Label(id="active_search")
+        yield VerticalScroll(id="lines")
+        yield Footer(id="footer")
+
+
+    @on(Tree.NodeSelected)
+    def on_tree_node_selected(self, event: Tree.NodeSelected[str]) -> None:
+        """Called when a tree node is selected, selecting the event."""
+        if event.node.parent and event.node.parent.parent:
+            assert event.node.parent.data is not None
+            assert event.node.data is not None
+            self.set_pmu_and_event(event.node.parent.data, event.node.data)
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument('-I', '--interval', help="Counter update interval in seconds", default=0.1)
+    args = ap.parse_args()
+    app = IListApp(float(args.interval))
+    app.run()
-- 
2.50.0.727.gbf7dc18ff4-goog


