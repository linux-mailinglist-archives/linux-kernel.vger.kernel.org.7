Return-Path: <linux-kernel+bounces-838340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFD4BAEFED
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF5D1C64D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14295274B2B;
	Wed,  1 Oct 2025 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qMjJjwoG"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0026FDBD;
	Wed,  1 Oct 2025 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285299; cv=none; b=Yp+ABkDqr1LH7fO7imvfF+OEExBet4m5Fohw4yDNAgUHNp3Z8fJIossXWVeFA0SBbvclWwenngEZvo2GkVt0SumCQMWL47R/w05Z1bYlevRqv+sluuy3JpxjhsOWzLxrA/QGOQpd1fj9rcqyajCvW05tiPMtLQEdZInOmZEhox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285299; c=relaxed/simple;
	bh=fZaZAdvPl0yb7zpoAvFy/dp72tuQ8r4auzANPY708gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qd53Mdoft68lqwwCU5L7YBgrIrScq6oKhpRtnHENFOynYz98e2wJytB0hbDOv/ZHDA2gx7wjpZ3xneVx3+3/rk74OV7kfgvjkRpRGxj3XT960mW6iAMU4dKggTOYQZ8fZxL5xoQgWdxAgyXPcUPbyMbuWdiBth6TAoPOF8H1Ngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qMjJjwoG; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=wDG9Yxqq2/UHCDeFsDxFRUOXb5Q6m5kBSAmuY8HdKKI=;
	b=qMjJjwoG4mFBKHp0dP4/lE+mPTz0eYCRc8kQtA1SlgSzRR8z0OT8Su0HVEZHEe
	yIMNw6BuqkGnMMu84tcktrObOrdRcyq8x/hMdiJLZMijXVoiUc5OhRMDhwERYEv7
	77uSYyJSYG2JuWrCmBcdhOuYiv39TJfjv/BYLcCcQpKtg=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAnb1zrj9xoVMVzBQ--.24663S2;
	Wed, 01 Oct 2025 10:20:28 +0800 (CST)
From: chenyuan_fl@163.com
To: mhiramat@kernel.org
Cc: bigeasy@linutronix.de,
	chenyuan@kylinos.cn,
	chenyuan_fl@163.com,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	peterz@infradead.org,
	rostedt@goodmis.org
Subject: [PATCH v4] tracing: Fix race condition in kprobe initialization causing NULL pointer dereference
Date: Wed,  1 Oct 2025 03:20:25 +0100
Message-Id: <20251001022025.44626-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251001003707.3eaf9ad062d5cad96f49b9ba@kernel.org>
References: <20251001003707.3eaf9ad062d5cad96f49b9ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnb1zrj9xoVMVzBQ--.24663S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3ZF4UCr17Zw1kAr4DJFyrWFg_yoWDCF1rpa
	nrKan8Ka1kJF4jq3ySvr1rG3WSy34fAFWUJry5G3y3XF1DJw1jvFyIqFWDZ3W3Ja90qFya
	y3WIvrWYyFW7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piwZ2fUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiRBLYvWjb9IN8iAABsC

From: Yuan Chen <chenyuan@kylinos.cn>

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
1310: 	return 0;

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

v1->v2: Fix race analysis (per Masami) - kprobe arms in class->reg().
v2->v3: Adopt RELEASE/ACQUIRE semantics per Peter/John's suggestions,
        aligning with Steven's clarification on barrier purposes.
v3->v4: Introduce load_flag() (Masami) and optimize barrier usage in
        checks/clear (Peter).

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/trace/trace_fprobe.c | 10 ++++++----
 kernel/trace/trace_kprobe.c | 11 +++++++----
 kernel/trace/trace_probe.h  |  9 +++++++--
 kernel/trace/trace_uprobe.c | 12 ++++++++----
 4 files changed, 28 insertions(+), 14 deletions(-)

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
index ccae62d4fb91..b1b793b8f191 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1813,14 +1813,15 @@ static int kprobe_register(struct trace_event_call *event,
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
@@ -1832,6 +1833,7 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	struct kretprobe *rp = get_kretprobe(ri);
 	struct trace_kprobe *tk;
+	unsigned int flags;
 
 	/*
 	 * There is a small chance that get_kretprobe(ri) returns NULL when
@@ -1844,10 +1846,11 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
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
2.39.5


