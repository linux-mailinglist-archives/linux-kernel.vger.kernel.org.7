Return-Path: <linux-kernel+bounces-724700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99157AFF603
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A587BAF92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B5D153598;
	Thu, 10 Jul 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NphsR6qn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BB85C5E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107696; cv=none; b=dWkD98QSjprJvi2/jTdjo6haUPsCkC/vI2gVD4+J1zFBIhcHiVQVFvjcxZDoJrkKWcl1+p5JggRZveru3ycLKIiuW8JHT7tQFTDhUVhW7EQIXK8PFt2YX/DlSW9oGZWcgnUQgaUjpVz4pgun8l2EYzgTyTT6p9+xrk1NEF5ZTrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107696; c=relaxed/simple;
	bh=+9pg9Dd6aGe5iyXDhhHxg3GB3DTvajjJM8WZNONOvJs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=c430ZK7gPzmDFS8pnDZuikQBtWhLCuumit49Do6khUGP7AfkdXqt10vOkgTVkslVyyXjjgzqDdCSbVV1KE2+I8oXHthB2q8JVyFAeAHp5yM/IeChA89FKK7R+dg2tjYP5If1JYlsVchK9Zp+bxemqpPDZB3bPtXnoMw47YAWCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NphsR6qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1E2C4CEF1;
	Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107696;
	bh=+9pg9Dd6aGe5iyXDhhHxg3GB3DTvajjJM8WZNONOvJs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=NphsR6qnAQslgjNWODQD+wk5vvOekzVtOgBRGawmZwQR9Z9DgiJr0A/gTqUCH0PtE
	 PDVnvstAlsQaWcDG4H6WjZCcZ0/d5jA4//EemAf5JGPTgnYka/sbVS0iJ2LM60+aA6
	 7kiUv6DsQiv1blmlibZMFXWNk+MwhSD7Xcy8/Dom1WLMhd0pq/WRfu7U/bOUTF4Usn
	 QOXhFeKcsHp/GAFdm2g3smvDspNOJ4lRE8Z6Y6zUBIO/Xd6w8Gy40DwkTvUfhsqjTv
	 7g38ohnPGEXyY39rq6Avmdhe+xKSiDL0dsBcIW0wFyUgHzM16W/CVMtxNuuZmuI2lj
	 hvHWGg9HYt0cw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfFc-00000001Wgw-2ZGo;
	Wed, 09 Jul 2025 20:35:00 -0400
Message-ID: <20250710003500.468966480@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:34:40 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 3/9] verification/dot2k: Replace is_container() hack with subparsers
References: <20250710003437.191509804@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

dot2k is used for both generating deterministic automaton (DA) monitor and
generating container monitor.

Generating DA monitor and generating container requires different
parameters. This is implemented by peeking at sys.argv and check whether
"--container" is specified, and use that information to make some
parameters optional or required.

This works, but is quite hacky and ugly.

Replace this hack with Python's built-in subparsers.

The old commands:

  python3 dot2/dot2k -d wip.dot -t per_cpu
  python3 dot2/dot2k -n sched --container

are equivalent to the new commands:

  python3 dot2/dot2k monitor -d wip.dot -t per_cpu
  python3 dot2/dot2k container -n sched

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/23c4e3c6e10c39e86d8e6a289208dde407efc4a8.1751634289.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/dot2/dot2k    | 37 +++++++++++++++++---------------
 tools/verification/dot2/dot2k.py |  2 +-
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 767064f415e7..133fb17d9d47 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -13,30 +13,33 @@ if __name__ == '__main__':
     import argparse
     import sys
 
-    def is_container():
-        """Should work even before parsing the arguments"""
-        return "-c" in sys.argv or "--container" in sys.argv
-
     parser = argparse.ArgumentParser(description='transform .dot file into kernel rv monitor')
-    parser.add_argument('-d', "--dot", dest="dot_file", required=not is_container())
-    parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=not is_container(),
-                        help=f"Available options: {', '.join(dot2k.monitor_types.keys())}")
-    parser.add_argument('-n', "--model_name", dest="model_name", required=is_container())
     parser.add_argument("-D", "--description", dest="description", required=False)
     parser.add_argument("-a", "--auto_patch", dest="auto_patch",
                         action="store_true", required=False,
                         help="Patch the kernel in place")
-    parser.add_argument("-p", "--parent", dest="parent",
-                        required=False, help="Create a monitor nested to parent")
-    parser.add_argument("-c", "--container", dest="container",
-                        action="store_true", required=False,
-                        help="Create an empty monitor to be used as a container")
+
+    subparsers = parser.add_subparsers(dest="subcmd", required=True)
+
+    monitor_parser = subparsers.add_parser("monitor")
+    monitor_parser.add_argument('-n', "--model_name", dest="model_name")
+    monitor_parser.add_argument("-p", "--parent", dest="parent",
+                                required=False, help="Create a monitor nested to parent")
+    monitor_parser.add_argument('-d', "--dot", dest="dot_file")
+    monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type",
+                                help=f"Available options: {', '.join(dot2k.monitor_types.keys())}")
+
+    container_parser = subparsers.add_parser("container")
+    container_parser.add_argument('-n', "--model_name", dest="model_name", required=True)
+
     params = parser.parse_args()
 
-    if not is_container():
-        print("Opening and parsing the dot file %s" % params.dot_file)
     try:
-        monitor=dot2k(params.dot_file, params.monitor_type, vars(params))
+        if params.subcmd == "monitor":
+            print("Opening and parsing the dot file %s" % params.dot_file)
+            monitor = dot2k(params.dot_file, params.monitor_type, vars(params))
+        else:
+            monitor = dot2k(None, None, vars(params))
     except Exception as e:
         print('Error: '+ str(e))
         print("Sorry : :-(")
@@ -45,7 +48,7 @@ if __name__ == '__main__':
     print("Writing the monitor into the directory %s" % monitor.name)
     monitor.print_files()
     print("Almost done, checklist")
-    if not is_container():
+    if params.subcmd == "monitor":
         print("  - Edit the %s/%s.c to add the instrumentation" % (monitor.name, monitor.name))
         print(monitor.fill_tracepoint_tooltip())
     print(monitor.fill_makefile_tooltip())
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 0922754454b9..9ec99e297012 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -19,7 +19,7 @@ class dot2k(Dot2c):
     monitor_type = "per_cpu"
 
     def __init__(self, file_path, MonitorType, extra_params={}):
-        self.container = extra_params.get("container")
+        self.container = extra_params.get("subcmd") == "container"
         self.parent = extra_params.get("parent")
         self.__fill_rv_templates_dir()
 
-- 
2.47.2



