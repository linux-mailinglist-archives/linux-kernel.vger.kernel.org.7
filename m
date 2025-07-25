Return-Path: <linux-kernel+bounces-746349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB3B125A8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16755587C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D2F2690DB;
	Fri, 25 Jul 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHBu6pEe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1125FA0A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475661; cv=none; b=Q+G00jf7l3VGSmG1gAEKAhktrdRnGoQyVcvbc+tOhloUzZI4zwjCWevqKlc8mRuFw/Qisw0HDsLay11Oxls8+8DuCJlETIAlD39/5s9fgS0b9zEA5WPxAJIKwfsbZt+h+2jYqRdNQWDVKVtCt48MxxdzgNGOLT66ZRFZHufT9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475661; c=relaxed/simple;
	bh=aCHzKauITVbkU95T3gbGxEkQQvBBWjzWN4yhLLim4IU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UzqzIxgK9/VeS0l1pn69mAvLCkUyjxrwHewvOj7Si8bU05X1HDMMSEIyLeLrFzgUM9ChR8V1GPan+AGXIwI+rLb8FaNisCxwnC7UsLl58f4j8jIvkJPvnBKmxwTsm9ziI9awg4TGgeOJciOUblp2EmrBmkCTGd9AbV7k6ZNaCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHBu6pEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21247C4CEF6;
	Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475660;
	bh=aCHzKauITVbkU95T3gbGxEkQQvBBWjzWN4yhLLim4IU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=EHBu6pEeK38XLQwp/wMtOanXO6kTx/Ry4zGnTFHHg6H3nEVv2qoJMkEjnp9zowTfh
	 slJpYEF1BT/VElhkwvvrtp06fuxtboYUqGdT4NZRh5arTWO4s8DpIeQQdppjgrh242
	 CDYeUO12+56iEm/rIFSNQsDYKLTL//vn0lpUBXjZi2mD1PedX/e10AMdbW7/P1rrYx
	 RjUTy6UZLknPRkI/pdZRBxds4EBF40drxALk1s6uP5GVJ2J2V7UFHJhhuVKVc/7OER
	 A3XYOxG+HI+x70CCmRrPLUgbeSYNVtEJB87gyW7r2tyTX7OitAJ7jpSKmPBmy3f0Nl
	 V1PU2u4+h1dUw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7a-00000001QiL-17Mq;
	Fri, 25 Jul 2025 16:34:26 -0400
Message-ID: <20250725203426.115179584@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:10 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 John Ogness <john.ogness@linutronix.de>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nam Cao <namcao@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 13/25] verification/rvgen: Support the next operator
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

The 'next' operator is a unary operator. It is defined as: "next time, the
operand must be true".

Support this operator. For RV monitors, "next time" means the next
invocation of ltl_validate().

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de
Signed-off-by: Nam Cao <namcao@linutronix.de>
Tested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../trace/rv/linear_temporal_logic.rst        |  1 +
 tools/verification/rvgen/rvgen/ltl2ba.py      | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/trace/rv/linear_temporal_logic.rst b/Documentation/trace/rv/linear_temporal_logic.rst
index 57f107fcf6dd..9eee09d9cacf 100644
--- a/Documentation/trace/rv/linear_temporal_logic.rst
+++ b/Documentation/trace/rv/linear_temporal_logic.rst
@@ -41,6 +41,7 @@ Operands (opd):
 Unary Operators (unop):
     always
     eventually
+    next
     not
 
 Binary Operators (binop):
diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/rvgen/rvgen/ltl2ba.py
index d11840af7f5f..f14e6760ac3d 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -19,6 +19,7 @@ from ply.yacc import yacc
 # Unary Operators (unop):
 #       always
 #       eventually
+#       next
 #       not
 #
 # Binary Operators (binop):
@@ -35,6 +36,7 @@ tokens = (
    'UNTIL',
    'ALWAYS',
    'EVENTUALLY',
+   'NEXT',
    'VARIABLE',
    'LITERAL',
    'NOT',
@@ -48,6 +50,7 @@ t_OR = r'or'
 t_IMPLY = r'imply'
 t_UNTIL = r'until'
 t_ALWAYS = r'always'
+t_NEXT = r'next'
 t_EVENTUALLY = r'eventually'
 t_VARIABLE = r'[A-Z_0-9]+'
 t_LITERAL = r'true|false'
@@ -327,6 +330,26 @@ class AlwaysOp(UnaryOp):
         # ![]F == <>(!F)
         return EventuallyOp(self.child.negate()).normalize()
 
+class NextOp(UnaryOp):
+    def normalize(self):
+        return self
+
+    def _is_temporal(self):
+        return True
+
+    def negate(self):
+        # not (next A) == next (not A)
+        self.child = self.child.negate()
+        return self
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        tmp = GraphNode(node.incoming,
+                        node.new,
+                        node.old | {n},
+                        node.next | {n.op.child})
+        return tmp.expand(node_set)
+
 class NotOp(UnaryOp):
     def __str__(self):
         return "!" + str(self.child)
@@ -452,12 +475,15 @@ def p_unop(p):
     '''
     unop : ALWAYS ltl
          | EVENTUALLY ltl
+         | NEXT ltl
          | NOT ltl
     '''
     if p[1] == "always":
         op = AlwaysOp(p[2])
     elif p[1] == "eventually":
         op = EventuallyOp(p[2])
+    elif p[1] == "next":
+        op = NextOp(p[2])
     elif p[1] == "not":
         op = NotOp(p[2])
     else:
-- 
2.47.2



