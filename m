Return-Path: <linux-kernel+bounces-746343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35712B125A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40791CC7D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465C262FD8;
	Fri, 25 Jul 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTWQ7p00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6EB25D8F0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475660; cv=none; b=Kjmgop3LYkJ356JqhY6+XI0+3VrsHKG5oTa7QADXybERxLojYT1zqpRiH4EGBRXTagGMmYGKBJAR9tGrbDdfIaFouOQxOo3MnlHijkKS393q7sesgzsn4dIPZiE44+uj/Mti6EoUZntcZALmXthv+u6pXbQ7h7c5y3Kfctft890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475660; c=relaxed/simple;
	bh=dV9ILFIh/3u1oAiaH6inUJD2barGO5qcmaWu31d+lZc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b1Aue/UsOt605e4uIc8lOXMMmDpOBKN7lQtbNu6lpYfkhz+3G37DzZkQM2sX4GXax90pBkFfUjf2ut4trzWDZ45YEqA+xflfr2TET+KsQMamUVNzk8xxPiluhGhmr5zXaP9wYE99pwmfiT8T86aX5uCw53h6WuHGyf69ilhi1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTWQ7p00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71127C4CEE7;
	Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475660;
	bh=dV9ILFIh/3u1oAiaH6inUJD2barGO5qcmaWu31d+lZc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=JTWQ7p00G3TTz7F+9okT4l1BDb/e50AUS+YuIIbpmelyYlU+82JS1vSSM3RhomTjJ
	 y3rf0m5kZScaerSt/4xnSIMmxAK1qJBCDaRcKDoiD/h/8YduXKZVtzadfit3LHbIYB
	 oKMBcENy4a1n5ukM+WykzQ9RRD7L/LE8wVTn+UIAYERcPacEIkcSDcy6kTByQxoCWg
	 uW/tTFLHz35Sf9HD0UMeVxUaA1HLGFP6hErox1hxUpsLTCAFs5Pm+nmIkRlJchxJBv
	 /+s7zcD4DGV5q+MMep8T7m6janxiZ0bhY4dBYkN1P0qq0W2du3AArF9nchyYbZRlgw
	 dDCqTRQg+EHoA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7a-00000001QjL-2WXa;
	Fri, 25 Jul 2025 16:34:26 -0400
Message-ID: <20250725203426.457432560@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:12 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nam Cao <namcao@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 15/25] verification/rvgen: Do not generate unused variables
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

ltl2k generates all variable definition in both ltl_start() and
ltl_possible_next_states(). However, these two functions may not use all
the variables, causing "unused variable" compiler warning.

Change the script to only generate used variables.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/636b2b2d99a9bd46a9f77a078d44ebd7ffc7508c.1752850449.git.namcao@linutronix.de
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rvgen/rvgen/ltl2k.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index 59da351792ec..b075f98d50c4 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -106,20 +106,25 @@ class ltl2k(generator.Monitor):
         ])
         return buf
 
-    def _fill_atom_values(self):
+    def _fill_atom_values(self, required_values):
         buf = []
         for node in self.ltl:
-            if node.op.is_temporal():
+            if str(node) not in required_values:
                 continue
 
             if isinstance(node.op, ltl2ba.AndOp):
                 buf.append("\tbool %s = %s && %s;" % (node, node.op.left, node.op.right))
+                required_values |= {str(node.op.left), str(node.op.right)}
             elif isinstance(node.op, ltl2ba.OrOp):
                 buf.append("\tbool %s = %s || %s;" % (node, node.op.left, node.op.right))
+                required_values |= {str(node.op.left), str(node.op.right)}
             elif isinstance(node.op, ltl2ba.NotOp):
                 buf.append("\tbool %s = !%s;" % (node, node.op.child))
+                required_values.add(str(node.op.child))
 
         for atom in self.atoms:
+            if atom.lower() not in required_values:
+                continue
             buf.append("\tbool %s = test_bit(LTL_%s, mon->atoms);" % (atom.lower(), atom))
 
         buf.reverse()
@@ -135,7 +140,13 @@ class ltl2k(generator.Monitor):
             "ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsigned long *next)",
             "{"
         ]
-        buf.extend(self._fill_atom_values())
+
+        required_values = set()
+        for node in self.ba:
+            for o in sorted(node.outgoing):
+                required_values |= o.labels
+
+        buf.extend(self._fill_atom_values(required_values))
         buf.extend([
             "",
             "\tswitch (state) {"
@@ -166,7 +177,13 @@ class ltl2k(generator.Monitor):
             "static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)",
             "{"
         ]
-        buf.extend(self._fill_atom_values())
+
+        required_values = set()
+        for node in self.ba:
+            if node.init:
+                required_values |= node.labels
+
+        buf.extend(self._fill_atom_values(required_values))
         buf.append("")
 
         for node in self.ba:
-- 
2.47.2



