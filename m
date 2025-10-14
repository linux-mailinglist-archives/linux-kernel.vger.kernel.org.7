Return-Path: <linux-kernel+bounces-852302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91110BD8A25
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09DA04FAD85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7422FCBED;
	Tue, 14 Oct 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ttdc/aAp"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E348F2EBDC8
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436140; cv=none; b=EMIhWXsNRy3WxcoYoHrK6ZS4h+N5g68EsGBy8/mJdg2Fq5GldTeBWpE6VuYQPxeeG9+9f79Zm+xc4HQisqgmjvJjYXYdoemEVRRxn5eNBxpsY+gEbQ5g/ipKi1vmem/AmJYRKVOktOrXS9pXKgzhceSHeMSL+4umqqXOGP/KyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436140; c=relaxed/simple;
	bh=/BfyvLc3alET4VUbm8IcEp9DdnDvoMNBCmAfIzP2ToM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeVvnNwsL16Tt0In+avrxcR38ASN6roO1fLJnhWdQTGOnwNINsCQLKqVexSebqAvmia47rji+HfjqlNNGhgX4iprcpWO/xoRjVm82dcDQUtCqeRTl5Q/pGioKkb35P2FPHEKrCGlOb9VGm7CsMLVllQ0djo+j0d7dixRqxN8TEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ttdc/aAp; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760436126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx3Mu1f9RcQnyEwI6I+qDuteJEIdnrA8Zyt1Wu+roas=;
	b=Ttdc/aApuXS/Ecc5RLs3pEQFQ5mIR2JdOhsnjhK2jySu6usKcezCqS6ZzpMEQDZ8qnBgEC
	OIRzmoXKz24GLHcANj5//2qSYXGYwhpxdaQC1LRi9gHOWL8MLNAnfUnFqWlfkLRzAGvli5
	FqRhxZrQVUY3RZI+vtS9UNkGvXr5P6Q=
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
	kan.liang@linux.intel.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [RFC PATCH bpf-next v2 1/2] perf: Use extern perf_callchain_entry for get_perf_callchain
Date: Tue, 14 Oct 2025 18:01:27 +0800
Message-ID: <20251014100128.2721104-2-chen.dylane@linux.dev>
In-Reply-To: <20251014100128.2721104-1-chen.dylane@linux.dev>
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From bpf stack map, we want to use our own buffers to avoid unnecessary
copy, so let us pass it directly. BPF will use this in the next patch.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/perf_event.h |  4 ++--
 kernel/bpf/stackmap.c      |  4 ++--
 kernel/events/callchain.c  | 13 +++++++++----
 kernel/events/core.c       |  2 +-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b9..b144da7d803 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1719,8 +1719,8 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+get_perf_callchain(struct pt_regs *regs, struct perf_callchain_entry *external_entry,
+		   bool kernel, bool user, u32 max_stack, bool crosstask, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 4d53cdd1374..94e46b7f340 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -314,7 +314,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
+	trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
 				   false, false);
 
 	if (unlikely(!trace))
@@ -451,7 +451,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, kernel, user, max_depth,
+		trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
 					   crosstask, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 808c0d7a31f..851e8f9d026 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -217,8 +217,8 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 }
 
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+get_perf_callchain(struct pt_regs *regs, struct perf_callchain_entry *external_entry,
+		   bool kernel, bool user, u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -228,7 +228,11 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (crosstask && user && !kernel)
 		return NULL;
 
-	entry = get_callchain_entry(&rctx);
+	if (external_entry)
+		entry = external_entry;
+	else
+		entry = get_callchain_entry(&rctx);
+
 	if (!entry)
 		return NULL;
 
@@ -260,7 +264,8 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	}
 
 exit_put:
-	put_callchain_entry(rctx);
+	if (!external_entry)
+		put_callchain_entry(rctx);
 
 	return entry;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7541f6f85fc..5d8e146003a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8217,7 +8217,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user,
+	callchain = get_perf_callchain(regs, NULL, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
 }
-- 
2.48.1


