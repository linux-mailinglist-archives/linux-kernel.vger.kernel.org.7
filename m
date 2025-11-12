Return-Path: <linux-kernel+bounces-897748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D93FEC537B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65649354679
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D313E33C538;
	Wed, 12 Nov 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N7KjYCqs"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CDD24E4A1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965156; cv=none; b=R2qrvl5Mgc58VX4c/n1i8hbEvA8lxPrG4Y2LddI6aOcn2jOmAlItsGFEsG+ptBL7tcHgAb9675eXpTVCF1VmXb0N+yIHMH1/8HZ4hES4mJrIkFrEc6XtSqRC7QKTmU0mOGOOsmFI6hlbyFk0BRAP1rK1LE2B1sKdWs39dBWm9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965156; c=relaxed/simple;
	bh=eGCCxOqbBm6Jly0TcaepFPdDTUT8uH/jBlS6bx+ZGOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Crau3s8XWLAWBIS3IGuXYrIDi/Xaf7fUX9N5szFEgbD+/GwHUIMZz7BZPbgwKEqyF+bugosIJbnLyFHTWcnP2zFFSUuJVsJ013PRd1wMf8glUJLFNxkzyMMznBXRm+ZOVCbqQr/R5VS1mtP4mYO/tOUQO99ILkXrcR+hvlJfXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N7KjYCqs; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762965141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHDwCxqBHRsF8+YQINTwrK2Wm0+gA9njAFM2wxpLMvg=;
	b=N7KjYCqsPuxcunWyZJcY+hUvg09Pt6HTHQJonMNNDs5fkyEcMNIKNp783i5TD/hlsFTsYj
	0HbTdy1E/xh+QmrksW/DDEHXLqtL+59smsYSAJtU/TLqRkhJhGZLOQpKUOEY3Gqwdu2Lrl
	p238vkowc/fSQU9wehfMa/I9NcjNKzs=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v6 1/2] perf: Refactor get_perf_callchain
Date: Thu, 13 Nov 2025 00:31:47 +0800
Message-ID: <20251112163148.100949-2-chen.dylane@linux.dev>
In-Reply-To: <20251112163148.100949-1-chen.dylane@linux.dev>
References: <20251112163148.100949-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From BPF stack map, we want to ensure that the callchain buffer
will not be overwritten by other preemptive tasks. Peter
suggested provide more flexible stack-sampling APIs, which
can be used in BPF, and we can still use the perf callchain
entry with the help of these APIs. The next patch will modify
the BPF part.

In the future, these APIs will also make it convenient for us to
add stack-sampling kfuncs in the eBPF subsystem, just as Andrii and
Alexei discussed earlier.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/perf_event.h |  9 +++++
 kernel/events/callchain.c  | 73 ++++++++++++++++++++++++--------------
 2 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b9..edd3058e4d8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
 	u32				nr;
 	short				contexts;
 	bool				contexts_maxed;
+	bool				add_mark;
 };
 
 typedef unsigned long (*perf_copy_f)(void *dst, const void *src,
@@ -1718,6 +1719,14 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
+
+extern void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
+				      struct perf_callchain_entry *entry,
+				      u32 max_stack, bool add_mark);
+
+extern void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
+extern void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
+
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 808c0d7a31f..dfb7cdbd470 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -216,13 +216,54 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 #endif
 }
 
+void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
+			       struct perf_callchain_entry *entry,
+			       u32 max_stack, bool add_mark)
+
+{
+	ctx->entry		= entry;
+	ctx->max_stack		= max_stack;
+	ctx->nr			= entry->nr = 0;
+	ctx->contexts		= 0;
+	ctx->contexts_maxed	= false;
+	ctx->add_mark		= add_mark;
+}
+
+void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return;
+
+	if (ctx->add_mark)
+		perf_callchain_store_context(ctx, PERF_CONTEXT_KERNEL);
+	perf_callchain_kernel(ctx, regs);
+}
+
+void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs)
+{
+	int start_entry_idx;
+
+	if (!user_mode(regs)) {
+		if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+			return;
+		regs = task_pt_regs(current);
+	}
+
+	if (ctx->add_mark)
+		perf_callchain_store_context(ctx, PERF_CONTEXT_USER);
+
+	start_entry_idx = ctx->entry->nr;
+	perf_callchain_user(ctx, regs);
+	fixup_uretprobe_trampoline_entries(ctx->entry, start_entry_idx);
+}
+
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
-	int rctx, start_entry_idx;
+	int rctx;
 
 	/* crosstask is not supported for user stacks */
 	if (crosstask && user && !kernel)
@@ -232,34 +273,14 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (!entry)
 		return NULL;
 
-	ctx.entry		= entry;
-	ctx.max_stack		= max_stack;
-	ctx.nr			= entry->nr = 0;
-	ctx.contexts		= 0;
-	ctx.contexts_maxed	= false;
+	__init_perf_callchain_ctx(&ctx, entry, max_stack, add_mark);
 
-	if (kernel && !user_mode(regs)) {
-		if (add_mark)
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
-		perf_callchain_kernel(&ctx, regs);
-	}
-
-	if (user && !crosstask) {
-		if (!user_mode(regs)) {
-			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-				goto exit_put;
-			regs = task_pt_regs(current);
-		}
+	if (kernel)
+		__get_perf_callchain_kernel(&ctx, regs);
 
-		if (add_mark)
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
-
-		start_entry_idx = entry->nr;
-		perf_callchain_user(&ctx, regs);
-		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-	}
+	if (user && !crosstask)
+		__get_perf_callchain_user(&ctx, regs);
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.48.1


