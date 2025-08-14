Return-Path: <linux-kernel+bounces-769026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF75B2693C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25749AA1E05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067011CDFAC;
	Thu, 14 Aug 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="Rt08Qyxk"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123651C4A0A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180718; cv=none; b=CAf4uMvwqqphrFx4s11kdTbggazPlxrs/2yCkToPeRFAahupuUrLfaYkDk1gK3zKwNL0dDLbucCeztx1bny9B9egfwc6iV0gBPTIunVhf1GSkOqFnoxOe9VPawB1S3Zxd5d2AUXbZrXZOhH45fIo/690PZWTXZn8F98v/fZSLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180718; c=relaxed/simple;
	bh=EbZzoJjr4Kk8JDzE0eXvjw9sGSzsd74uZr6Y9Z/YjM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogoo+fcUnhg3hyeSiCO83wBwoUgIaS1B/kwkIxDMN5dDup65BtDdkvkqm5xXHgaFA3/LPWNIs64odrb7+mi8pcQE2PXjMZF0DoLmT+91NAg/CefDdxiKq05H2yHgL30FtPE4l7U9maOR00v2CCV9jmuRkXZ7Wuve2quEnZ/7tyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=Rt08Qyxk; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=SbP+LrjMItEDvKeWro7z69XURleJAOwLaWagLV7cvLg=;
	b=Rt08QyxkbUgKzbEVzCJKnSRyr43rcH7SdnETOsF1osGZ3c1UANSADT/Kyqq/vGBbtd5NUkOBm
	nBEZsM6eDN1cCVEVZr8q+zU5QzTdWntPr6lzasN76QP+R4AaIS5/vNUsgFFG+wCNXoVkKo8o5qB
	vSMgbDdM0Yh8XZScMk2z6gc=
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c2mwn5GHpzYlnhn;
	Thu, 14 Aug 2025 21:55:53 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 21:56:00 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 21:55:59 +0800
From: <zhongjinji@honor.com>
To: <linux-mm@kvack.org>
CC: <akpm@linux-foundation.org>, <mhocko@suse.com>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <npache@redhat.com>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <dvhart@infradead.org>, <dave@stgolabs.net>,
	<andrealmeid@igalia.com>, <liam.howlett@oracle.com>, <liulu.liu@honor.com>,
	<feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v4 2/3] mm/oom_kill: Only delay OOM reaper for processes using robust futexes
Date: Thu, 14 Aug 2025 21:55:54 +0800
Message-ID: <20250814135555.17493-3-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250814135555.17493-1-zhongjinji@honor.com>
References: <20250814135555.17493-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

From: zhongjinji <zhongjinji@honor.com>

The OOM reaper can quickly reap a process's memory when the system encounters
OOM, helping the system recover. Without the OOM reaper, if a process frozen
by cgroup v1 is OOM killed, the victims' memory cannot be freed, and the
system stays in a poor state. Even if the process is not frozen by cgroup v1,
reaping victims' memory is still meaningful, because having one more process
working speeds up memory release.

When processes holding robust futexes are OOM killed but waiters on those
futexes remain alive, the robust futexes might be reaped before
futex_cleanup() runs. It would cause the waiters to block indefinitely.
To prevent this issue, the OOM reaper's work is delayed by 2 seconds [1].
The OOM reaper now rarely runs since many killed processes exit within 2
seconds.

Because robust futex users are few, it is unreasonable to delay OOM reap for
all victims. For processes that do not hold robust futexes, the OOM reaper
should not be delayed and for processes holding robust futexes, the OOM
reaper must still be delayed to prevent the waiters to block indefinitely [1].

Link: https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u [1]

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/oom_kill.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..7ae4001e47c1 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -39,6 +39,7 @@
 #include <linux/ptrace.h>
 #include <linux/freezer.h>
 #include <linux/ftrace.h>
+#include <linux/futex.h>
 #include <linux/ratelimit.h>
 #include <linux/kthread.h>
 #include <linux/init.h>
@@ -692,7 +693,7 @@ static void wake_oom_reaper(struct timer_list *timer)
  * before the exit path is able to wake the futex waiters.
  */
 #define OOM_REAPER_DELAY (2*HZ)
-static void queue_oom_reaper(struct task_struct *tsk)
+static void queue_oom_reaper(struct task_struct *tsk, bool delay)
 {
 	/* mm is already queued? */
 	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
@@ -700,7 +701,7 @@ static void queue_oom_reaper(struct task_struct *tsk)
 
 	get_task_struct(tsk);
 	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
-	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
+	tsk->oom_reaper_timer.expires = jiffies + (delay ? OOM_REAPER_DELAY : 0);
 	add_timer(&tsk->oom_reaper_timer);
 }
 
@@ -742,7 +743,7 @@ static int __init oom_init(void)
 }
 subsys_initcall(oom_init)
 #else
-static inline void queue_oom_reaper(struct task_struct *tsk)
+static inline void queue_oom_reaper(struct task_struct *tsk, bool delay)
 {
 }
 #endif /* CONFIG_MMU */
@@ -843,6 +844,16 @@ bool oom_killer_disable(signed long timeout)
 	return true;
 }
 
+/*
+ * If the owner thread of robust futexes is killed by OOM, the robust futexes might be freed
+ * by the OOM reaper before futex_cleanup() runs, which could cause the waiters to
+ * block indefinitely. So when the task hold robust futexes, delay oom reaper.
+ */
+static inline bool should_delay_oom_reap(struct task_struct *task)
+{
+	return process_has_robust_futex(task);
+}
+
 static inline bool __task_will_free_mem(struct task_struct *task)
 {
 	struct signal_struct *sig = task->signal;
@@ -865,17 +876,19 @@ static inline bool __task_will_free_mem(struct task_struct *task)
 }
 
 /*
- * Checks whether the given task is dying or exiting and likely to
- * release its address space. This means that all threads and processes
+ * Determine whether the given task should be reaped based on
+ * whether it is dying or exiting and likely to release its
+ * address space. This means that all threads and processes
  * sharing the same mm have to be killed or exiting.
  * Caller has to make sure that task->mm is stable (hold task_lock or
  * it operates on the current).
  */
-static bool task_will_free_mem(struct task_struct *task)
+static bool should_reap_task(struct task_struct *task, bool *delay_reap)
 {
 	struct mm_struct *mm = task->mm;
 	struct task_struct *p;
 	bool ret = true;
+	bool delay;
 
 	/*
 	 * Skip tasks without mm because it might have passed its exit_mm and
@@ -888,6 +901,8 @@ static bool task_will_free_mem(struct task_struct *task)
 	if (!__task_will_free_mem(task))
 		return false;
 
+	delay = should_delay_oom_reap(task);
+
 	/*
 	 * This task has already been drained by the oom reaper so there are
 	 * only small chances it will free some more
@@ -912,8 +927,11 @@ static bool task_will_free_mem(struct task_struct *task)
 		ret = __task_will_free_mem(p);
 		if (!ret)
 			break;
+		if (!delay)
+			delay = should_delay_oom_reap(p);
 	}
 	rcu_read_unlock();
+	*delay_reap = delay;
 
 	return ret;
 }
@@ -923,6 +941,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	struct task_struct *p;
 	struct mm_struct *mm;
 	bool can_oom_reap = true;
+	bool delay_reap;
 
 	p = find_lock_task_mm(victim);
 	if (!p) {
@@ -959,6 +978,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 		from_kuid(&init_user_ns, task_uid(victim)),
 		mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);
 	task_unlock(victim);
+	delay_reap = should_delay_oom_reap(victim);
 
 	/*
 	 * Kill all user processes sharing victim->mm in other thread groups, if
@@ -990,11 +1010,13 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
+		if (!delay_reap)
+			delay_reap = should_delay_oom_reap(p);
 	}
 	rcu_read_unlock();
 
 	if (can_oom_reap)
-		queue_oom_reaper(victim);
+		queue_oom_reaper(victim, delay_reap);
 
 	mmdrop(mm);
 	put_task_struct(victim);
@@ -1020,6 +1042,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	struct mem_cgroup *oom_group;
 	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
 					      DEFAULT_RATELIMIT_BURST);
+	bool delay_reap = false;
 
 	/*
 	 * If the task is already exiting, don't alarm the sysadmin or kill
@@ -1027,9 +1050,9 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 * so it can die quickly
 	 */
 	task_lock(victim);
-	if (task_will_free_mem(victim)) {
+	if (should_reap_task(victim, &delay_reap)) {
 		mark_oom_victim(victim);
-		queue_oom_reaper(victim);
+		queue_oom_reaper(victim, delay_reap);
 		task_unlock(victim);
 		put_task_struct(victim);
 		return;
@@ -1112,6 +1135,7 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 bool out_of_memory(struct oom_control *oc)
 {
 	unsigned long freed = 0;
+	bool delay_reap = false;
 
 	if (oom_killer_disabled)
 		return false;
@@ -1128,9 +1152,9 @@ bool out_of_memory(struct oom_control *oc)
 	 * select it.  The goal is to allow it to allocate so that it may
 	 * quickly exit and free its memory.
 	 */
-	if (task_will_free_mem(current)) {
+	if (should_reap_task(current, &delay_reap)) {
 		mark_oom_victim(current);
-		queue_oom_reaper(current);
+		queue_oom_reaper(current, delay_reap);
 		return true;
 	}
 
@@ -1209,6 +1233,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	struct task_struct *p;
 	unsigned int f_flags;
 	bool reap = false;
+	bool delay_reap = false;
 	long ret = 0;
 
 	if (flags)
@@ -1231,7 +1256,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	mm = p->mm;
 	mmgrab(mm);
 
-	if (task_will_free_mem(p))
+	if (should_reap_task(p, &delay_reap))
 		reap = true;
 	else {
 		/* Error only if the work has not been done already */
@@ -1240,7 +1265,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	}
 	task_unlock(p);
 
-	if (!reap)
+	if (!reap || delay_reap)
 		goto drop_mm;
 
 	if (mmap_read_lock_killable(mm)) {
-- 
2.17.1


