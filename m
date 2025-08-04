Return-Path: <linux-kernel+bounces-754645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578CBB19A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79397177783
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8C221555;
	Mon,  4 Aug 2025 03:03:58 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D336F218EB1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276637; cv=none; b=Bc66l5qvMDNBPvlJ03HpuDPnKOB0b63wmuhpIZKO+IvUn9vnrfkCEPbI5q12b5s7+omLM+bYqlYv+ltkf6DECsjmmVWFoE/uTKY/wuATZAmSEpCbZFz7Qno+XP0bmwCcG3tlGXNIVXVOVEzyYXIdGwaCSa7DPAzy82HytFM1JWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276637; c=relaxed/simple;
	bh=ciQbTMFqjB1Hn6VebsPjnP4j2LGqFhB9KPP2JZpm5j4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVu/1Hq+iq1rlpHuH/AkZHA9lgXNBzADTA4vAYNtxbtPgUBAjZiLANi7X5boflJIa/rwUhhrnhiVDEVREVlJgOeZdt4hNO2NUGdkomVITSkhZRXO1PuiOhlcxFluW+wQRROKMQEGsFfqI+Uy653uLdJZoMoARk2gp7gVUNiZtrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4bwLsn1NV6zYkxhP;
	Mon,  4 Aug 2025 11:01:01 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Aug
 2025 11:03:46 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Aug
 2025 11:03:45 +0800
From: <zhongjinji@honor.com>
To: <linux-mm@kvack.org>
CC: <akpm@linux-foundation.org>, <mhocko@suse.com>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <npache@redhat.com>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <dvhart@infradead.org>, <dave@stgolabs.net>,
	<andrealmeid@igalia.com>, <liulu.liu@honor.com>, <feng.han@honor.com>
Subject: [PATCH v3 2/2] mm/oom_kill: Only delay OOM reaper for processes using robust futex
Date: Mon, 4 Aug 2025 11:03:41 +0800
Message-ID: <20250804030341.18619-2-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250804030341.18619-1-zhongjinji@honor.com>
References: <20250804030341.18619-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a018.hihonor.com
 (10.68.17.250)

From: zhongjinji <zhongjinji@honor.com>

After merging the patch
https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u,
the OOM reaper runs less frequently because many processes exit within 2 seconds.

However, when a process is killed, timely handling by the OOM reaper allows
its memory to be freed faster.

Since relatively few processes use robust futex, delaying the OOM reaper for
all processes is undesirable, as many killed processes cannot release memory
more quickly.

This patch modifies the behavior so that only processes using robust futex
are delayed by the OOM reaper, allowing the OOM reaper to handle more
processes in a timely manner.

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/oom_kill.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..c558ac93ae7d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -30,6 +30,7 @@
 #include <linux/syscalls.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/futex.h>
 #include <linux/cpuset.h>
 #include <linux/export.h>
 #include <linux/notifier.h>
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
@@ -871,11 +872,12 @@ static inline bool __task_will_free_mem(struct task_struct *task)
  * Caller has to make sure that task->mm is stable (hold task_lock or
  * it operates on the current).
  */
-static bool task_will_free_mem(struct task_struct *task)
+static bool task_will_free_mem(struct task_struct *task, bool *delay_reap)
 {
 	struct mm_struct *mm = task->mm;
 	struct task_struct *p;
 	bool ret = true;
+	bool has_robust = !delay_reap;
 
 	/*
 	 * Skip tasks without mm because it might have passed its exit_mm and
@@ -888,6 +890,15 @@ static bool task_will_free_mem(struct task_struct *task)
 	if (!__task_will_free_mem(task))
 		return false;
 
+	/*
+	 * Check if a process is using robust futexes. If so, delay its handling by the
+	 * OOM reaper. The reason is that if the owner of a robust futex lock is killed
+	 * while waiters are still alive, the OOM reaper might free the robust futex
+	 * resources before futex_cleanup runs, causing the waiters to wait indefinitely.
+	 */
+	if (!has_robust)
+		has_robust = check_robust_futex_rcu(task);
+
 	/*
 	 * This task has already been drained by the oom reaper so there are
 	 * only small chances it will free some more
@@ -912,8 +923,12 @@ static bool task_will_free_mem(struct task_struct *task)
 		ret = __task_will_free_mem(p);
 		if (!ret)
 			break;
+		if (!has_robust)
+			has_robust = check_robust_futex(p);
 	}
 	rcu_read_unlock();
+	if (delay_reap)
+		*delay_reap = has_robust;
 
 	return ret;
 }
@@ -923,6 +938,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	struct task_struct *p;
 	struct mm_struct *mm;
 	bool can_oom_reap = true;
+	bool delay_reap;
 
 	p = find_lock_task_mm(victim);
 	if (!p) {
@@ -950,6 +966,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	 * reserves from the user space under its control.
 	 */
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
+	delay_reap = check_robust_futex_rcu(victim);
 	mark_oom_victim(victim);
 	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
 		message, task_pid_nr(victim), victim->comm, K(mm->total_vm),
@@ -990,11 +1007,13 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
+		if (!delay_reap)
+			delay_reap = check_robust_futex(p);
 	}
 	rcu_read_unlock();
 
 	if (can_oom_reap)
-		queue_oom_reaper(victim);
+		queue_oom_reaper(victim, delay_reap);
 
 	mmdrop(mm);
 	put_task_struct(victim);
@@ -1020,6 +1039,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	struct mem_cgroup *oom_group;
 	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
 					      DEFAULT_RATELIMIT_BURST);
+	bool delay_reap = false;
 
 	/*
 	 * If the task is already exiting, don't alarm the sysadmin or kill
@@ -1027,9 +1047,9 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 * so it can die quickly
 	 */
 	task_lock(victim);
-	if (task_will_free_mem(victim)) {
+	if (task_will_free_mem(victim, &delay_reap)) {
 		mark_oom_victim(victim);
-		queue_oom_reaper(victim);
+		queue_oom_reaper(victim, delay_reap);
 		task_unlock(victim);
 		put_task_struct(victim);
 		return;
@@ -1112,6 +1132,7 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 bool out_of_memory(struct oom_control *oc)
 {
 	unsigned long freed = 0;
+	bool delay_reap = false;
 
 	if (oom_killer_disabled)
 		return false;
@@ -1128,9 +1149,9 @@ bool out_of_memory(struct oom_control *oc)
 	 * select it.  The goal is to allow it to allocate so that it may
 	 * quickly exit and free its memory.
 	 */
-	if (task_will_free_mem(current)) {
+	if (task_will_free_mem(current, &delay_reap)) {
 		mark_oom_victim(current);
-		queue_oom_reaper(current);
+		queue_oom_reaper(current, delay_reap);
 		return true;
 	}
 
@@ -1231,7 +1252,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	mm = p->mm;
 	mmgrab(mm);
 
-	if (task_will_free_mem(p))
+	if (task_will_free_mem(p, NULL))
 		reap = true;
 	else {
 		/* Error only if the work has not been done already */
-- 
2.17.1


