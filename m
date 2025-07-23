Return-Path: <linux-kernel+bounces-743142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC08B0FB23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED427B6B75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49752230270;
	Wed, 23 Jul 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDnBuGXI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6F2288C6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300340; cv=none; b=CzuAolFrgGh/w4+DC0DVg4vRbecYuT0NvkLfdHHymRLwNWvz9GvicO+J2UYB03q19PETq7t2EQppzzPLk5mpXLXENgvmxml/DzbTjoRLLFgk2MEhb84RIe/AmXBLUGGsjORfExg+4XqFb9ypZ14f9aU/AKtsalbBT3mH04JU8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300340; c=relaxed/simple;
	bh=+VVrNamO4LQKyYzWYxTFODBaRW5VT/+rCG3dkqeM1Ts=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Cb8X2D7NFCDVSyPZGDbsnpv4m/meC9S4qxRqHn0JXZbWcDNIg9HDrnPtqQjqxyYl5J6Aj/LP7pJW7QqAE1qgbCqE2pJLYRtVBeuoKwpVA7V8kokfkqzrxgMGqJgJhyqymLNi+5LWT3w3wr/3kmOlUIiLA3OPXvChjxUNYl3hl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDnBuGXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E8AC4CEF4;
	Wed, 23 Jul 2025 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753300340;
	bh=+VVrNamO4LQKyYzWYxTFODBaRW5VT/+rCG3dkqeM1Ts=;
	h=Date:From:To:Cc:Subject:References:From;
	b=aDnBuGXI7qrEPZDxyeXNFKCfM604HkK/+q5AUk4WIbmy1vJKY9fjJYzODiqFYIGiw
	 5bD7GV+mdcKMHcQABtt8C5PFW1QQ8DFohzbeOkAP+3kCo0UrIl6hCQbcsQFHltxfry
	 1AKPAzRd/y3g0LE87xGq28cLbwCx8DKjqf0yHaTjYwwU6Tz4rtLduP4EAGFR5QOz7A
	 O9Ada+CLaQxLa+6v8HWE3VqMOFto87LB9RhHtrMWapJovYyWMnUJiXSDAbJrfbdBq+
	 /2U7DFrkbLoYhPAreCQB3G8vGoG03OCg/t5jlxWMGTNA94DA9qzydHi4JeZUiVMopT
	 vjTf7mNNQal+Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uefVm-00000000QuH-0by4;
	Wed, 23 Jul 2025 15:52:22 -0400
Message-ID: <20250723195221.999900536@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 15:52:09 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 1/3] fgraph: Keep track of when fgraph_ops are registered or not
References: <20250723195208.164959427@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add a warning if unregister_ftrace_graph() is called without ever
registering it, or if register_ftrace_graph() is called twice. This can
detect errors when they happen and not later when there's a side effect:

Link: https://lore.kernel.org/all/20250617120830.24fbdd62@gandalf.local.home/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/20250701194451.22e34724@gandalf.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c5b207992fb4..f4d200f0c610 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1325,6 +1325,10 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	int ret = 0;
 	int i = -1;
 
+	if (WARN_ONCE(gops->ops.flags & FTRACE_OPS_FL_GRAPH,
+		      "function graph ops registered again"))
+		return -EBUSY;
+
 	guard(mutex)(&ftrace_lock);
 
 	if (!fgraph_stack_cachep) {
@@ -1401,17 +1405,21 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
 
+	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
+		      "function graph ops unregistered without registering"))
+		return;
+
 	guard(mutex)(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
-		return;
+		goto out;
 
 	if (unlikely(gops->idx < 0 || gops->idx >= FGRAPH_ARRAY_SIZE ||
 		     fgraph_array[gops->idx] != gops))
-		return;
+		goto out;
 
 	if (fgraph_lru_release_index(gops->idx) < 0)
-		return;
+		goto out;
 
 	fgraph_array[gops->idx] = &fgraph_stub;
 
@@ -1434,4 +1442,6 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
 	gops->saved_func = NULL;
+ out:
+	gops->ops.flags &= ~FTRACE_OPS_FL_GRAPH;
 }
-- 
2.47.2



