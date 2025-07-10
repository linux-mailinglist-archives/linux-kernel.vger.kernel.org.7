Return-Path: <linux-kernel+bounces-726439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 700BCB00D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB94B43000
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9F330AAD8;
	Thu, 10 Jul 2025 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjqXjJf7"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8031280325
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179154; cv=none; b=iLK7LVEG7Zfyefbr9jDilG0ex+J4JU8LoWDEWop0vSX+juhdXfw6YYjw3wpb6K26TDFrbRyn+NO+fQrMz284VO97kEk4HyQXRaLcRps+qGJu79ut2BiD+BYy/xgiNAHwVUcqlRvtLs703JRpzAPto5rfPb+9q/keoHFPrPS5DCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179154; c=relaxed/simple;
	bh=4DBEBdTfWfkhLt8ag7FL9lGLt+srCnvLuSveHjPSawA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pBcco1rSG5SG4RsWwipHDzVmgSSVjcH1q2Nb2iQbh0XQBp/Z2GJgN2WYmRyyUsrj4J8s8mQu7sMarP74e15QfHcRk4FZL7M9q2du/r5MbDlyan0sSkzUWB4BUv7rqZeUdNcv6dmZNp9vguR+a89Qbxf+i0clgT8/ar4WNrBba+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OjqXjJf7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23692793178so12462685ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179152; x=1752783952; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsThzVLcGqNGlV+OXH+rg8cRsNmgOdp9nQeDnnzr9WU=;
        b=OjqXjJf7XnKN1OGm7oK0J3lxWYUFeO3xbdB3nVoc1GuLldieq+kmgZzUF91JG80FLJ
         B4OGubnHxI0cVXwCUaMJAHqh6augeAqwZCtT8BVAEd5sexPohYf7k+mhQgU5cZ7Yfpf1
         c5FVmuGismsBi9yemA3kiUSkXc1E8VPENbwOVfu/KkvhVlbDE5yXzlJNCS50MXjPw3cl
         FWxxEofjl+QNIGEBWaVuHHwdpwNfxRGpS61hbzkxd4NuXY3EC6xVjMP1RfSbBGtpfOCs
         1UXxFopV28q2vNH95OEV5EXSL63Pwgi5HMpfnmsGlZoGD5xBzrsMJJwHAD14xqmpJPkb
         bhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179152; x=1752783952;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsThzVLcGqNGlV+OXH+rg8cRsNmgOdp9nQeDnnzr9WU=;
        b=uNC53p3csi5vVogY73gmxt7fawWHQmcXXhn3aH79OfZp1SNz+t/8bQ2BHIhnpehnol
         LMd1d4k6DjpYN/VNlcz0dM7Bo5hWkgfluTlCU6GfOrfuADtKO8r2HOYJ0McPKrvaSAZK
         TGCGJVXFaEDGzw9DAw8oZqp2RNSygAt7h8HKwpt+bmxyEtC1v5ATftG2Ye9UIfCzmmor
         +U4ENciUS+fHuQRaV7tQYd/nSMPonmWtlWTzdP2N2Jj7lQ1RqMR7Dp/acUwMgmg7vBmw
         GpmFpE4SdZDkhJRJFgaAQ+eXBXr8NqecdARCTm2lkt74TBxD5JsAmbwr8Y4NK4FTkvNj
         GtLw==
X-Forwarded-Encrypted: i=1; AJvYcCUms0MNRM3ug3gWNBdN1oQrxvgv+6OMceb47ujFc9gImXdjhC0lSPTjesMohEprBA2Y9laZJ/IWjIqpgAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcwOcZvwFE1SSR53TV0NI3kNZxv0ROxiN3YWm9v3oqGa7rRVCE
	1DVWInMy/ICyYN8AvsbDh02czNkDnkqcvTO1H5lu+P0XG9LG9qirb2IfuWHieJDDYdIUEk+bzyK
	9fOReeM1Gig==
X-Google-Smtp-Source: AGHT+IHQYfc387XBZ145UOjWYS/BKtWtK0qdQBrGBn7LKYCQI4V+mSPnGrGhMcYtG1G8Mkq6gsWECrNCf8my
X-Received: from pjff3.prod.google.com ([2002:a17:90b:5623:b0:311:b3fb:9f74])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:24f:b0:235:f3df:bc26
 with SMTP id d9443c01a7336-23dede2ebc5mr7901375ad.3.1752179151997; Thu, 10
 Jul 2025 13:25:51 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:25:00 -0700
In-Reply-To: <20250710202500.1959672-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710202500.1959672-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710202500.1959672-23-irogers@google.com>
Subject: [PATCH v5 14/14] perf ilist: Add support for metrics
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

Change tree nodes to having a value of either Metric or PmuEvent,
these values have the ability to match searches, be parsed to create
evlists and to give a value per CPU and per thread to display.  Use
perf.metrics to generate a tree of metrics. Most metrics are placed
under their metric group, if the metric group name ends with '_group'
then the metric group is placed next to the associated metric.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/ilist.py | 207 +++++++++++++++++++++++++++----------
 1 file changed, 153 insertions(+), 54 deletions(-)

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
index 3e2fae1db738..0d46b44d2961 100755
--- a/tools/perf/python/ilist.py
+++ b/tools/perf/python/ilist.py
@@ -2,8 +2,11 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 """Interactive perf list."""
 
+from abc import ABC, abstractmethod
 import argparse
-from typing import Any, Dict, Tuple
+from dataclasses import dataclass
+from typing import Any, Dict, Optional, Tuple
+import math
 import perf
 from textual import on
 from textual.app import App, ComposeResult
@@ -14,6 +17,103 @@ from textual.screen import ModalScreen
 from textual.widgets import Button, Footer, Header, Input, Label, Sparkline, Static, Tree
 from textual.widgets.tree import TreeNode
 
+def get_info(info: Dict[str, str], key: str):
+    return (info[key] + "\n") if key in info else ""
+
+class TreeValue(ABC):
+    """Abstraction for the data of value in the tree."""
+
+    @abstractmethod
+    def name(self) -> str:
+        pass
+
+    @abstractmethod
+    def description(self) -> str:
+        pass
+
+    @abstractmethod
+    def matches(self, query: str) -> bool:
+        pass
+
+    @abstractmethod
+    def parse(self) -> perf.evlist:
+        pass
+
+    @abstractmethod
+    def value(self, evlist: perf.evlist, evsel: perf.evsel, cpu: int, thread: int) -> float:
+        pass
+
+
+@dataclass
+class Metric(TreeValue):
+    """A metric in the tree."""
+    metric_name: str
+
+    def name(self) -> str:
+        return self.metric_name
+
+    def description(self) -> str:
+        """Find and format metric description."""
+        for metric in perf.metrics():
+            if metric["MetricName"] != self.metric_name:
+                continue
+            desc = get_info(metric, "BriefDescription")
+            desc += get_info(metric, "PublicDescription")
+            desc += get_info(metric, "MetricExpr")
+            desc += get_info(metric, "MetricThreshold")
+            return desc
+        return "description"
+
+    def matches(self, query: str) -> bool:
+        return query in self.metric_name
+
+    def parse(self) -> perf.evlist:
+        return perf.parse_metrics(self.metric_name)
+
+    def value(self, evlist: perf.evlist, evsel: perf.evsel, cpu: int, thread: int) -> float:
+        val = evlist.compute_metric(self.metric_name, cpu, thread)
+        return 0 if math.isnan(val) else val
+
+
+@dataclass
+class PmuEvent(TreeValue):
+    """A PMU and event within the tree."""
+    pmu: str
+    event: str
+
+    def name(self) -> str:
+        if self.event.startswith(self.pmu) or ':' in self.event:
+            return self.event
+        else:
+            return f"{self.pmu}/{self.event}/"
+
+    def description(self) -> str:
+        """Find and format event description for {pmu}/{event}/."""
+        for p in perf.pmus():
+            if p.name() != self.pmu:
+                continue
+            for info in p.events():
+                if "name" not in info or info["name"] != self.event:
+                    continue
+
+                desc = get_info(info, "topic")
+                desc += get_info(info, "event_type_desc")
+                desc += get_info(info, "desc")
+                desc += get_info(info, "long_desc")
+                desc += get_info(info, "encoding_desc")
+                return desc
+        return "description"
+
+    def matches(self, query: str) -> bool:
+        return query in self.pmu or query in self.event
+
+    def parse(self) -> perf.evlist:
+        return perf.parse_events(self.name())
+
+    def value(self, evlist: perf.evlist, evsel: perf.evsel, cpu: int, thread: int) -> float:
+        return evsel.read(cpu, thread).val
+
+
 class ErrorScreen(ModalScreen[bool]):
     """Pop up dialog for errors."""
 
@@ -123,8 +223,9 @@ class IListApp(App):
     def __init__(self, interval: float) -> None:
         self.interval = interval
         self.evlist = None
-        self.search_results: list[TreeNode[str]] = []
-        self.cur_search_result: TreeNode[str] | None = None
+        self.selected: Optional[TreeValue] = None
+        self.search_results: list[TreeNode[TreeValue]] = []
+        self.cur_search_result: TreeNode[TreeValue] | None = None
         super().__init__()
 
 
@@ -180,15 +281,15 @@ class IListApp(App):
             event = event.lower()
             search_label.update(f'Searching for events matching "{event}"')
 
-            tree: Tree[str] = self.query_one("#pmus", Tree)
-            def find_search_results(event: str, node: TreeNode[str], \
+            tree: Tree[TreeValue] = self.query_one("#root", Tree)
+            def find_search_results(event: str, node: TreeNode[TreeValue], \
                                     cursor_seen: bool = False, \
-                                    match_after_cursor: TreeNode[str] | None = None) \
-                    -> Tuple[bool, TreeNode[str] | None]:
+                                    match_after_cursor: TreeNode[TreeValue] | None = None) \
+                    -> Tuple[bool, TreeNode[TreeValue] | None]:
                 """Find nodes that match the search remembering the one after the cursor."""
                 if not cursor_seen and node == tree.cursor_node:
                     cursor_seen = True
-                if node.data and event in node.data:
+                if node.data and node.data.matches(event):
                     if cursor_seen and not match_after_cursor:
                         match_after_cursor = node
                     self.search_results.append(node)
@@ -222,17 +323,17 @@ class IListApp(App):
 
 
     def action_collapse(self) -> None:
-        """Collapse the potentially large number of events under a PMU."""
-        tree: Tree[str] = self.query_one("#pmus", Tree)
+        """Collapse the part of the tree currently on."""
+        tree: Tree[str] = self.query_one("#root", Tree)
         node = tree.cursor_node
-        if node and node.parent and node.parent.parent:
+        if node and node.parent:
             node.parent.collapse_all()
             node.tree.scroll_to_node(node.parent)
 
 
     def update_counts(self) -> None:
         """Called every interval to update counts."""
-        if not self.evlist:
+        if not self.selected or not self.evlist:
             return
 
         def update_count(cpu: int, count: int):
@@ -261,8 +362,7 @@ class IListApp(App):
             for cpu in evsel.cpus():
                 aggr = 0
                 for thread in evsel.threads():
-                    counts = evsel.read(cpu, thread)
-                    aggr += counts.val
+                    aggr += self.selected.value(self.evlist, evsel, cpu, thread)
                 update_count(cpu, aggr)
                 total += aggr
         update_count(-1, total)
@@ -275,8 +375,10 @@ class IListApp(App):
         self.set_interval(self.interval, self.update_counts)
 
 
-    def set_pmu_and_event(self, pmu: str, event: str) -> None:
+    def set_selected(self, value: TreeValue) -> None:
         """Updates the event/description and starts the counters."""
+        self.selected = value
+
         # Remove previous event information.
         if self.evlist:
             self.evlist.disable()
@@ -288,34 +390,13 @@ class IListApp(App):
             for line in lines:
                 line.remove()
 
-        def pmu_event_description(pmu: str, event: str) -> str:
-            """Find and format event description for {pmu}/{event}/."""
-            def get_info(info: Dict[str, str], key: str):
-                return (info[key] + "\n") if key in info else ""
-
-            for p in perf.pmus():
-                if p.name() != pmu:
-                    continue
-                for info in p.events():
-                    if "name" not in info or info["name"] != event:
-                        continue
-
-                    desc = get_info(info, "topic")
-                    desc += get_info(info, "event_type_desc")
-                    desc += get_info(info, "desc")
-                    desc += get_info(info, "long_desc")
-                    desc += get_info(info, "encoding_desc")
-                    return desc
-            return "description"
-
-        # Parse event, update event text and description.
-        full_name = event if event.startswith(pmu) or ':' in event else f"{pmu}/{event}/"
-        self.query_one("#event_name", Label).update(full_name)
-        self.query_one("#event_description", Static).update(pmu_event_description(pmu, event))
+        # Update event/metric text and description.
+        self.query_one("#event_name", Label).update(value.name())
+        self.query_one("#event_description", Static).update(value.description())
 
         # Open the event.
         try:
-            self.evlist = perf.parse_events(full_name)
+            self.evlist = value.parse()
             if self.evlist:
                 self.evlist.open()
                 self.evlist.enable()
@@ -323,7 +404,7 @@ class IListApp(App):
             self.evlist = None
 
         if not self.evlist:
-            self.push_screen(ErrorScreen(f"Failed to open {full_name}"))
+            self.push_screen(ErrorScreen(f"Failed to open {value.name()}"))
             return
 
         # Add spark lines for all the CPUs. Note, must be done after
@@ -344,24 +425,44 @@ class IListApp(App):
 
     def compose(self) -> ComposeResult:
         """Draws the app."""
-        def pmu_event_tree() -> Tree:
-            """Create tree of PMUs with events under."""
-            tree: Tree[str] = Tree("PMUs", id="pmus")
-            tree.root.expand()
+        def metric_event_tree() -> Tree:
+            """Create tree of PMUs and metricgroups with events or metrics under."""
+            tree: Tree[TreeValue] = Tree("Root", id="root")
+            pmus = tree.root.add("PMUs")
             for pmu in perf.pmus():
                 pmu_name = pmu.name().lower()
-                pmu_node = tree.root.add(pmu_name, data=pmu_name)
+                pmu_node = pmus.add(pmu_name)
                 for event in sorted(pmu.events(), key=lambda x: x["name"]):
                     if "name" in event:
                         e = event["name"].lower()
                         if "alias" in event:
-                            pmu_node.add_leaf(f'{e} ({event["alias"]})', data=e)
+                            pmu_node.add_leaf(f'{e} ({event["alias"]})', data=PmuEvent(pmu_name, e))
                         else:
-                            pmu_node.add_leaf(e, data=e)
+                            pmu_node.add_leaf(e, data=PmuEvent(pmu_name, e))
+            metrics = tree.root.add("Metrics")
+            groups = set()
+            for metric in perf.metrics():
+                groups.update(metric["MetricGroup"])
+
+            def add_metrics_to_tree(node: TreeNode[TreeValue], parent: str):
+                for metric in sorted(perf.metrics(), key=lambda x: x["MetricName"]):
+                    if parent in metric["MetricGroup"]:
+                        name = metric["MetricName"]
+                        node.add_leaf(name, data=Metric(name))
+                        child_group_name = f'{name}_group'
+                        if child_group_name in groups:
+                            add_metrics_to_tree(node.add(child_group_name), child_group_name)
+
+            for group in sorted(groups):
+                if group.endswith('_group'):
+                    continue
+                add_metrics_to_tree(metrics.add(group), group)
+
+            tree.root.expand()
             return tree
 
         yield Header(id="header")
-        yield Horizontal(Vertical(pmu_event_tree(), id="events"),
+        yield Horizontal(Vertical(metric_event_tree(), id="events"),
                          Vertical(Label("event name", id="event_name"),
                                   Static("description", markup=False, id="event_description"),
                                   ))
@@ -371,12 +472,10 @@ class IListApp(App):
 
 
     @on(Tree.NodeSelected)
-    def on_tree_node_selected(self, event: Tree.NodeSelected[str]) -> None:
+    def on_tree_node_selected(self, event: Tree.NodeSelected[TreeValue]) -> None:
         """Called when a tree node is selected, selecting the event."""
-        if event.node.parent and event.node.parent.parent:
-            assert event.node.parent.data is not None
-            assert event.node.data is not None
-            self.set_pmu_and_event(event.node.parent.data, event.node.data)
+        if event.node.data:
+            self.set_selected(event.node.data)
 
 
 if __name__ == "__main__":
-- 
2.50.0.727.gbf7dc18ff4-goog


