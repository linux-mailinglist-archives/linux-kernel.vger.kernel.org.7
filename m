Return-Path: <linux-kernel+bounces-840343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F7EBB428B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F619C2D40
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63416311977;
	Thu,  2 Oct 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0kCrbU1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D738DF9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759415188; cv=none; b=ps/F84JgN7PkrObr3aSN5eMI+SULkNNSi9c6ZJD8xjAuBeDhuuuar4OwaysW4LlkWyBq9jY9x17WwJRVFcL11DjsGUMx8cjxtOpv1nXoHIZXYWvu7N1Ymux7SI19wDmtalTXiJgNF0vT11sM5km2UHFsPf9qkn7BL4zIEYKmk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759415188; c=relaxed/simple;
	bh=tdnS9lgQYlwrtsEK+qr6t6EPQjUdb0vyVSQ+6x9NeZY=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=cKxVgfy4zShT6H89+yeS9N0RLCxJtiDWskd9vxWuoGZyz7uT4BW0SHYU/HCxJeRRMnz0ij4RzweNJH73FAfVNO91BdKTkuHAD6vHEUy2ESWy5JCfBYlDH2KyxKWfxuKU14Mhce09iA9gN6WFIRB1W1P524G1at5T9PiJpZompPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0kCrbU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9EDC4CEF4;
	Thu,  2 Oct 2025 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759415188;
	bh=tdnS9lgQYlwrtsEK+qr6t6EPQjUdb0vyVSQ+6x9NeZY=;
	h=Date:From:To:Cc:Subject:From;
	b=C0kCrbU1yfBiuGeFVBFqhmfUCktQUzzl1THX0YLEolOBhINtgbJCCfkliQX7Sl6Jk
	 RSbukC3/ir+NnE4LUV+dK//g0ZdZyL1AiXKIX2jGB6e/vuE4PEaN290Nw+s62HlSSk
	 kJBT9KOpLh6MZ2gCZcb3NRT1SGVpYpl3M8BreUyOpI55m1nd3OOW27aTflF5fGY1+A
	 8PpYiGzXHdoC1gZKtSwPNrywE+FHeHodJjZ8u/EJ21pKozunNhzEoRnwn396bDQIVr
	 WZ7DlwjaOEaMsNp6p3O1Q5g+4rEezA8y8tvtCot1517lli9IXug68EIbc51gjbsaUN
	 PWcjCMEWys4yw==
Date: Thu, 2 Oct 2025 23:26:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yuan Chen <chenyuan@kylinos.cn>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.17
Message-Id: <20251002232624.0cab764496b996a63a4cea4c@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Probes fixes for v6.17

- tracing: Fix race condition in kprobe initialization causing NULL
  pointer dereference. This happens on weak memory model, which
  does not correctly manage the flags access with appropriate
  memory barriers. Use RELEASE-ACQUIRE to fix it.


Please pull the latest probes-fixes-v6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.17

Tag SHA1: 2149c55ea9e9bfeb93079f4ce53cb34afbf4d59a
Head SHA1: 9cf9aa7b0acfde7545c1a1d912576e9bab28dc6f


Yuan Chen (1):
      tracing: Fix race condition in kprobe initialization causing NULL pointer dereference

----
 kernel/trace/trace_fprobe.c | 10 ++++++----
 kernel/trace/trace_kprobe.c | 11 +++++++----
 kernel/trace/trace_probe.h  |  9 +++++++--
 kernel/trace/trace_uprobe.c | 12 ++++++++----
 4 files changed, 28 insertions(+), 14 deletions(-)
---------------------------
commit 9cf9aa7b0acfde7545c1a1d912576e9bab28dc6f
Author: Yuan Chen <chenyuan@kylinos.cn>
Date:   Wed Oct 1 03:20:25 2025 +0100

    tracing: Fix race condition in kprobe initialization causing NULL pointer dereference
    
    There is a critical race condition in kprobe initialization that can lead to
    NULL pointer dereference and kernel crash.
    
    [1135630.084782] Unable to handle kernel paging request at virtual address 0000710a04630000
    ...
    [1135630.260314] pstate: 404003c9 (nZcv DAIF +PAN -UAO)
    [1135630.269239] pc : kprobe_perf_func+0x30/0x260
    [1135630.277643] lr : kprobe_dispatcher+0x44/0x60
    [1135630.286041] sp : ffffaeff4977fa40
    [1135630.293441] x29: ffffaeff4977fa40 x28: ffffaf015340e400
    [1135630.302837] x27: 0000000000000000 x26: 0000000000000000
    [1135630.312257] x25: ffffaf029ed108a8 x24: ffffaf015340e528
    [1135630.321705] x23: ffffaeff4977fc50 x22: ffffaeff4977fc50
    [1135630.331154] x21: 0000000000000000 x20: ffffaeff4977fc50
    [1135630.340586] x19: ffffaf015340e400 x18: 0000000000000000
    [1135630.349985] x17: 0000000000000000 x16: 0000000000000000
    [1135630.359285] x15: 0000000000000000 x14: 0000000000000000
    [1135630.368445] x13: 0000000000000000 x12: 0000000000000000
    [1135630.377473] x11: 0000000000000000 x10: 0000000000000000
    [1135630.386411] x9 : 0000000000000000 x8 : 0000000000000000
    [1135630.395252] x7 : 0000000000000000 x6 : 0000000000000000
    [1135630.403963] x5 : 0000000000000000 x4 : 0000000000000000
    [1135630.412545] x3 : 0000710a04630000 x2 : 0000000000000006
    [1135630.421021] x1 : ffffaeff4977fc50 x0 : 0000710a04630000
    [1135630.429410] Call trace:
    [1135630.434828]  kprobe_perf_func+0x30/0x260
    [1135630.441661]  kprobe_dispatcher+0x44/0x60
    [1135630.448396]  aggr_pre_handler+0x70/0xc8
    [1135630.454959]  kprobe_breakpoint_handler+0x140/0x1e0
    [1135630.462435]  brk_handler+0xbc/0xd8
    [1135630.468437]  do_debug_exception+0x84/0x138
    [1135630.475074]  el1_dbg+0x18/0x8c
    [1135630.480582]  security_file_permission+0x0/0xd0
    [1135630.487426]  vfs_write+0x70/0x1c0
    [1135630.493059]  ksys_write+0x5c/0xc8
    [1135630.498638]  __arm64_sys_write+0x24/0x30
    [1135630.504821]  el0_svc_common+0x78/0x130
    [1135630.510838]  el0_svc_handler+0x38/0x78
    [1135630.516834]  el0_svc+0x8/0x1b0
    
    kernel/trace/trace_kprobe.c: 1308
    0xffff3df8995039ec <kprobe_perf_func+0x2c>:     ldr     x21, [x24,#120]
    include/linux/compiler.h: 294
    0xffff3df8995039f0 <kprobe_perf_func+0x30>:     ldr     x1, [x21,x0]
    
    kernel/trace/trace_kprobe.c
    1308: head = this_cpu_ptr(call->perf_events);
    1309: if (hlist_empty(head))
    1310:   return 0;
    
    crash> struct trace_event_call -o
    struct trace_event_call {
      ...
      [120] struct hlist_head *perf_events;  //(call->perf_event)
      ...
    }
    
    crash> struct trace_event_call ffffaf015340e528
    struct trace_event_call {
      ...
      perf_events = 0xffff0ad5fa89f088, //this value is correct, but x21 = 0
      ...
    }
    
    Race Condition Analysis:
    
    The race occurs between kprobe activation and perf_events initialization:
    
      CPU0                                    CPU1
      ====                                    ====
      perf_kprobe_init
        perf_trace_event_init
          tp_event->perf_events = list;(1)
          tp_event->class->reg (2)← KPROBE ACTIVE
                                              Debug exception triggers
                                              ...
                                              kprobe_dispatcher
                                                kprobe_perf_func (tk->tp.flags & TP_FLAG_PROFILE)
                                                  head = this_cpu_ptr(call->perf_events)(3)
                                                  (perf_events is still NULL)
    
    Problem:
    1. CPU0 executes (1) assigning tp_event->perf_events = list
    2. CPU0 executes (2) enabling kprobe functionality via class->reg()
    3. CPU1 triggers and reaches kprobe_dispatcher
    4. CPU1 checks TP_FLAG_PROFILE - condition passes (step 2 completed)
    5. CPU1 calls kprobe_perf_func() and crashes at (3) because
       call->perf_events is still NULL
    
    CPU1 sees that kprobe functionality is enabled but does not see that
    perf_events has been assigned.
    
    Add pairing read and write memory barriers to guarantee that if CPU1
    sees that kprobe functionality is enabled, it must also see that
    perf_events has been assigned.
    
    Link: https://lore.kernel.org/all/20251001022025.44626-1-chenyuan_fl@163.com/
    
    Fixes: 50d780560785 ("tracing/kprobes: Add probe handler dispatcher to support perf and ftrace concurrent use")
    Cc: stable@vger.kernel.org
    Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index b36ade43d4b3..ad9d6347b5fa 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -522,13 +522,14 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+	unsigned int flags = trace_probe_load_flag(&tf->tp);
 	int ret = 0;
 
-	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
+	if (flags & TP_FLAG_TRACE)
 		fentry_trace_func(tf, entry_ip, fregs);
 
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		ret = fentry_perf_func(tf, entry_ip, fregs);
 #endif
 	return ret;
@@ -540,11 +541,12 @@ static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+	unsigned int flags = trace_probe_load_flag(&tf->tp);
 
-	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
+	if (flags & TP_FLAG_TRACE)
 		fexit_trace_func(tf, entry_ip, ret_ip, fregs, entry_data);
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		fexit_perf_func(tf, entry_ip, ret_ip, fregs, entry_data);
 #endif
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index fa60362a3f31..ee8171b19bee 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1815,14 +1815,15 @@ static int kprobe_register(struct trace_event_call *event,
 static int kprobe_dispatcher(struct kprobe *kp, struct pt_regs *regs)
 {
 	struct trace_kprobe *tk = container_of(kp, struct trace_kprobe, rp.kp);
+	unsigned int flags = trace_probe_load_flag(&tk->tp);
 	int ret = 0;
 
 	raw_cpu_inc(*tk->nhit);
 
-	if (trace_probe_test_flag(&tk->tp, TP_FLAG_TRACE))
+	if (flags & TP_FLAG_TRACE)
 		kprobe_trace_func(tk, regs);
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tk->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		ret = kprobe_perf_func(tk, regs);
 #endif
 	return ret;
@@ -1834,6 +1835,7 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	struct kretprobe *rp = get_kretprobe(ri);
 	struct trace_kprobe *tk;
+	unsigned int flags;
 
 	/*
 	 * There is a small chance that get_kretprobe(ri) returns NULL when
@@ -1846,10 +1848,11 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 	tk = container_of(rp, struct trace_kprobe, rp);
 	raw_cpu_inc(*tk->nhit);
 
-	if (trace_probe_test_flag(&tk->tp, TP_FLAG_TRACE))
+	flags = trace_probe_load_flag(&tk->tp);
+	if (flags & TP_FLAG_TRACE)
 		kretprobe_trace_func(tk, ri, regs);
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tk->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		kretprobe_perf_func(tk, ri, regs);
 #endif
 	return 0;	/* We don't tweak kernel, so just return 0 */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 842383fbc03b..08b5bda24da2 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -271,16 +271,21 @@ struct event_file_link {
 	struct list_head		list;
 };
 
+static inline unsigned int trace_probe_load_flag(struct trace_probe *tp)
+{
+	return smp_load_acquire(&tp->event->flags);
+}
+
 static inline bool trace_probe_test_flag(struct trace_probe *tp,
 					 unsigned int flag)
 {
-	return !!(tp->event->flags & flag);
+	return !!(trace_probe_load_flag(tp) & flag);
 }
 
 static inline void trace_probe_set_flag(struct trace_probe *tp,
 					unsigned int flag)
 {
-	tp->event->flags |= flag;
+	smp_store_release(&tp->event->flags, tp->event->flags | flag);
 }
 
 static inline void trace_probe_clear_flag(struct trace_probe *tp,
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8b0bcc0d8f41..430d09c49462 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1547,6 +1547,7 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb = NULL;
+	unsigned int flags;
 	int ret = 0;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
@@ -1561,11 +1562,12 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
+	flags = trace_probe_load_flag(&tu->tp);
+	if (flags & TP_FLAG_TRACE)
 		ret |= uprobe_trace_func(tu, regs, &ucb);
 
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		ret |= uprobe_perf_func(tu, regs, &ucb);
 #endif
 	uprobe_buffer_put(ucb);
@@ -1579,6 +1581,7 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb = NULL;
+	unsigned int flags;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
 
@@ -1590,11 +1593,12 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
+	flags = trace_probe_load_flag(&tu->tp);
+	if (flags & TP_FLAG_TRACE)
 		uretprobe_trace_func(tu, func, regs, &ucb);
 
 #ifdef CONFIG_PERF_EVENTS
-	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
+	if (flags & TP_FLAG_PROFILE)
 		uretprobe_perf_func(tu, func, regs, &ucb);
 #endif
 	uprobe_buffer_put(ucb);

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

