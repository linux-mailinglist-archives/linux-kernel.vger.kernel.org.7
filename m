Return-Path: <linux-kernel+bounces-732695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A3B06AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E45E16FFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410871465A5;
	Wed, 16 Jul 2025 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzQHO2zb"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D382B9BA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626802; cv=none; b=Yi5lUpiSVRqIw2XlLXkADl74eh0Sl+SXi+tMKNjT0glH+G2RwV2cQOAxHjHueqwWAE+uJwWNuCsk/7fsyw6o//anQjJsQKwkG9WMxtDdwsXXwcO1IB3NvZuP8zJ9BF8azJh32CHHLNXo5suROyGVtgCTKqpDVMWex9Os4ZHdmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626802; c=relaxed/simple;
	bh=A84GfCjcITi8AiOzIpygW57B+h5ZDq5fbeJel7bZmD8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=OnmIuJwOmOZahlrCxPHAPggTkxjn+0p7MJynBFjKAs8RU6VU8lV1bVyzaQ8VlCXCzOQxGauiZ89qtypf3F4aD7pRF5MBlprpIjO1tszFKeau7fMmdQ+Npth7338ajJBKkN2Wtx6skhRFUIHye9nAwrb4iC9ZfvyBZgxb8jdHw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BzQHO2zb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235089528a0so3286025ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752626800; x=1753231600; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FSiMDXfM4cpD5u4hTNtqX5LKR2sTa7aLbN2a0UDDlHE=;
        b=BzQHO2zbORHhpo9tuxW4Wm18yAcXWkLz26wsBc7shtSIuIaJjU/9iSWF6b+1ppnE1Y
         6kAnaTJ2apPvo8s1TWO4I4XRiW4kK6A1bO9EQqgkiU3KwZ3xF2hIsx1iSvBQAIHf7C95
         5an8fld60OMnTJvZT+NRR/bHZo7gDBw2DkrUZdqOaLgZcsuGQMcBWEJTbzgwzO6akmWq
         iPln1xwGz6m3ZoO6zBbdSqivKidxH10TT6znd/k4yuNZOx5yfHa+7Vc9jnfAeUlzL+Ll
         KVusTwukniMxYY0D+sr9CbVipZ7y+cYode+feacLsGtfB3QlrGDikT34tdsn50bgOLR3
         99AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752626800; x=1753231600;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSiMDXfM4cpD5u4hTNtqX5LKR2sTa7aLbN2a0UDDlHE=;
        b=gAsMy0Ai48MyPlYror6Sv74aJG1vHmuI5N7syarIMds1CrFYm/dejWM1DslggkOk36
         zExoIPKBqkNC/kNfMWwHHYMdrukquUxtFh9Lchu37DHTYXnWFNQk2vkyGgbcK5Jkdsv7
         Ft3cF/PDoKkGX82XB6QjVAL/gSNqcCCGHxCzlqUJbJ4Lzs0hsrCqIRGX+pmJgz4ynPE4
         nCJxujO+jIvKv8kjGzsFykPVm0frg1J5D3/2tc8xaO9I7XWaUhWdznJ0knjmCjZugjuF
         BQ7y/5UpT7gyskYBBlJHcCEGAej42agAb0mSvj3YLbGcaWAmJnokb64OZR4q9kVwNDDz
         dcEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+7xnh5jyh2kWMY4w6FKEdZAytJIKRhFY72Bz/G8GlB8CnN3gvwLgvkwoENLAuwGjAkfsoUCQkZTnbULg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbyfL5WYg6Hi11zv5e7YwChMaRQ6OVLH9+VREcF9Ep1+P67gBC
	G1QDL8aRGjSWP5O6CxdjVXX9DRKw4/+7oRwEekXvjtq69zbE2rTGg0ef6NkHyS/ONByKHdGFiZy
	Uq6FkISrJjQ==
X-Google-Smtp-Source: AGHT+IERW0Jkpu6iHZi02K60bdWT88CcoXfpHjLAzQFOMyGMZ+LYLQwDV4fHXEaIISA1euoseJmK3f6ddsP4
X-Received: from pjxx3.prod.google.com ([2002:a17:90b:58c3:b0:313:2d44:397b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18a:b0:234:9fe1:8fc6
 with SMTP id d9443c01a7336-23e1a4c6791mr84890435ad.18.1752626800112; Tue, 15
 Jul 2025 17:46:40 -0700 (PDT)
Date: Tue, 15 Jul 2025 17:46:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716004635.31161-1-irogers@google.com>
Subject: [PATCH v1] perf flamegraph: Fix minor pylint/type hint issues
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch to assuming python3. Fix minor pylint issues on line length,
repeated compares, not using f-strings and variable case. Add type
hints and check with mypy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/scripts/python/flamegraph.py | 61 +++++++++++++------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index e49ff242b779..ad735990c5be 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -18,7 +18,6 @@
 # pylint: disable=missing-class-docstring
 # pylint: disable=missing-function-docstring
 
-from __future__ import print_function
 import argparse
 import hashlib
 import io
@@ -26,9 +25,10 @@ import json
 import os
 import subprocess
 import sys
+from typing import Dict, Optional, Union
 import urllib.request
 
-minimal_html = """<head>
+MINIMAL_HTML = """<head>
   <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
 </head>
 <body>
@@ -50,20 +50,20 @@ minimal_html = """<head>
 
 # pylint: disable=too-few-public-methods
 class Node:
-    def __init__(self, name, libtype):
+    def __init__(self, name: str, libtype: str):
         self.name = name
         # "root" | "kernel" | ""
         # "" indicates user space
         self.libtype = libtype
-        self.value = 0
-        self.children = []
+        self.value: int = 0
+        self.children: list[Node] = []
 
-    def to_json(self):
+    def to_json(self) -> Dict[str, Union[str, int, list[Dict]]]:
         return {
             "n": self.name,
             "l": self.libtype,
             "v": self.value,
-            "c": self.children
+            "c": [x.to_json() for x in self.children]
         }
 
 
@@ -73,7 +73,7 @@ class FlameGraphCLI:
         self.stack = Node("all", "root")
 
     @staticmethod
-    def get_libtype_from_dso(dso):
+    def get_libtype_from_dso(dso: Optional[str]) -> str:
         """
         when kernel-debuginfo is installed,
         dso points to /usr/lib/debug/lib/modules/*/vmlinux
@@ -84,7 +84,7 @@ class FlameGraphCLI:
         return ""
 
     @staticmethod
-    def find_or_create_node(node, name, libtype):
+    def find_or_create_node(node: Node, name: str, libtype: str) -> Node:
         for child in node.children:
             if child.name == name:
                 return child
@@ -93,7 +93,7 @@ class FlameGraphCLI:
         node.children.append(child)
         return child
 
-    def process_event(self, event):
+    def process_event(self, event) -> None:
         # ignore events where the event name does not match
         # the one specified by the user
         if self.args.event_name and event.get("ev_name") != self.args.event_name:
@@ -106,7 +106,7 @@ class FlameGraphCLI:
             comm = event["comm"]
             libtype = "kernel"
         else:
-            comm = "{} ({})".format(event["comm"], pid)
+            comm = f"{event['comm']} ({pid})"
             libtype = ""
         node = self.find_or_create_node(self.stack, comm, libtype)
 
@@ -121,7 +121,7 @@ class FlameGraphCLI:
             node = self.find_or_create_node(node, name, libtype)
         node.value += 1
 
-    def get_report_header(self):
+    def get_report_header(self) -> str:
         if self.args.input == "-":
             # when this script is invoked with "perf script flamegraph",
             # no perf.data is created and we cannot read the header of it
@@ -131,7 +131,8 @@ class FlameGraphCLI:
             # if the file name other than perf.data is given,
             # we read the header of that file
             if self.args.input:
-                output = subprocess.check_output(["perf", "report", "--header-only", "-i", self.args.input])
+                output = subprocess.check_output(["perf", "report", "--header-only",
+                                                  "-i", self.args.input])
             else:
                 output = subprocess.check_output(["perf", "report", "--header-only"])
 
@@ -140,10 +141,10 @@ class FlameGraphCLI:
                 result += "\nFocused event: " + self.args.event_name
             return result
         except Exception as err:  # pylint: disable=broad-except
-            print("Error reading report header: {}".format(err), file=sys.stderr)
+            print(f"Error reading report header: {err}", file=sys.stderr)
             return ""
 
-    def trace_end(self):
+    def trace_end(self) -> None:
         stacks_json = json.dumps(self.stack, default=lambda x: x.to_json())
 
         if self.args.format == "html":
@@ -167,7 +168,8 @@ graph template (--template PATH) or use another output format (--format
 FORMAT).""",
                               file=sys.stderr)
                         if self.args.input == "-":
-                            print("""Not attempting to download Flame Graph template as script command line
+                            print(
+"""Not attempting to download Flame Graph template as script command line
 input is disabled due to using live mode. If you want to download the
 template retry without live mode. For example, use 'perf record -a -g
 -F 99 sleep 60' and 'perf script report flamegraph'. Alternatively,
@@ -176,37 +178,40 @@ https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-b
 and place it at:
 /usr/share/d3-flame-graph/d3-flamegraph-base.html""",
                                   file=sys.stderr)
-                            quit()
+                            sys.exit(1)
                         s = None
-                        while s != "y" and s != "n":
-                            s = input("Do you wish to download a template from cdn.jsdelivr.net? (this warning can be suppressed with --allow-download) [yn] ").lower()
+                        while s not in ["y", "n"]:
+                            s = input("Do you wish to download a template from cdn.jsdelivr.net?" +
+                                      "(this warning can be suppressed with --allow-download) [yn] "
+                                      ).lower()
                         if s == "n":
-                            quit()
-                    template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
+                            sys.exit(1)
+                    template = ("https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/"
+                                "d3-flamegraph-base.html")
                     template_md5sum = "143e0d06ba69b8370b9848dcd6ae3f36"
 
             try:
-                with urllib.request.urlopen(template) as template:
+                with urllib.request.urlopen(template) as url_template:
                     output_str = "".join([
-                        l.decode("utf-8") for l in template.readlines()
+                        l.decode("utf-8") for l in url_template.readlines()
                     ])
             except Exception as err:
                 print(f"Error reading template {template}: {err}\n"
                       "a minimal flame graph will be generated", file=sys.stderr)
-                output_str = minimal_html
+                output_str = MINIMAL_HTML
                 template_md5sum = None
 
             if template_md5sum:
                 download_md5sum = hashlib.md5(output_str.encode("utf-8")).hexdigest()
                 if download_md5sum != template_md5sum:
                     s = None
-                    while s != "y" and s != "n":
+                    while s not in ["y", "n"]:
                         s = input(f"""Unexpected template md5sum.
 {download_md5sum} != {template_md5sum}, for:
 {output_str}
 continue?[yn] """).lower()
                     if s == "n":
-                        quit()
+                        sys.exit(1)
 
             output_str = output_str.replace("/** @options_json **/", options_json)
             output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
@@ -220,12 +225,12 @@ continue?[yn] """).lower()
             with io.open(sys.stdout.fileno(), "w", encoding="utf-8", closefd=False) as out:
                 out.write(output_str)
         else:
-            print("dumping data to {}".format(output_fn))
+            print(f"dumping data to {output_fn}")
             try:
                 with io.open(output_fn, "w", encoding="utf-8") as out:
                     out.write(output_str)
             except IOError as err:
-                print("Error writing output file: {}".format(err), file=sys.stderr)
+                print(f"Error writing output file: {err}", file=sys.stderr)
                 sys.exit(1)
 
 
-- 
2.50.0.727.gbf7dc18ff4-goog


