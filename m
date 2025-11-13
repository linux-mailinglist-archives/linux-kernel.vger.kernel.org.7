Return-Path: <linux-kernel+bounces-899214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295FC571C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5BF3AC3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A226533971D;
	Thu, 13 Nov 2025 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yL6ligVU"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD0F2DF71D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032247; cv=none; b=RBLJsfDKFxhhpfl57tUubBOhQvRdMsfGMG3Xy0Ylu+63vvl8tTXo/zVKA0QkigtDVY4iwaH2arSbVyf/4hOBGLfcxOcF8I9SMj9Mw4B4WDdNA3BhN6FM7OY/uP/105m7d84mSAP+0cQEZ7+l6cRbtAIsvIHNhd1BNjpRhllRoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032247; c=relaxed/simple;
	bh=ALYktRUmPHbBLsf4i7lMGjOniAp4TIarw1EYIGinXUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IiWWLpryUkJ7t9DBdVwkQPyzKZjTcrWC/A2F8aJvkXIesjD4wmj+Bmz+WTA9hcCLyvb5KT/IoPZ3s113ZpJOAF8qLjo6pO6yw1kZQtQK1dRdc5L3skwSlQhrlJ6OVp+MTLjxm+NUs1XxgeqRf0vJhw+3gbwXt0VruMlHqjFxe3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yL6ligVU; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763032241; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rA9HZsy23Auw6ME2gNLW/s+kToiYN9UwDKgAvL8Hzms=;
	b=yL6ligVUdQZeFoDRaBTDcJjx2Tj2peQcBN7/fcUp9/xfEgO0JSrTDM8iOjjWLSws7rG8fwActX20B1SMoRquo7tMjaRd7yCd8vMN3kZ1e50yw6gvm7V3EUGzFT43Hw0gUzslAH/U2EtTM1AIt4/7HvQQu5fJxxW4jP/XGm6UcwA=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WsJMszq_1763032240 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Nov 2025 19:10:41 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Lance Yang <ioworker0@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2 2/4] hung_task: Add hung_task_sys_info sysctl to dump sys info on task-hung
Date: Thu, 13 Nov 2025 19:10:37 +0800
Message-Id: <20251113111039.22701-3-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251113111039.22701-1-feng.tang@linux.alibaba.com>
References: <20251113111039.22701-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When task-hung happens, developers may need different kinds of system
information (call-stacks, memory info, locks, etc.) to help debugging.

Add 'hung_task_sys_info' sysctl knob to take human readable string like
"tasks,mem,timers,locks,ftrace,...", and when task-hung happens, all
requested information will be dumped. (refer kernel/sys_info.c for more
details).

Meanwhile, the newly introduced sys_info() call is used to unify some
existing info-dumping knobs.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  5 ++
 kernel/hung_task.c                          | 62 +++++++++++++--------
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index a397eeccaea7..45b4408dad31 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -422,6 +422,11 @@ the system boot.
 
 This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
+hung_task_sys_info
+==================
+A comma separated list of extra system information to be dumped when
+hung task is detected, for example, "tasks,mem,timers,locks,...".
+Refer 'panic_sys_info' section below for more details.
 
 hung_task_timeout_secs
 ======================
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 5ac0e66a1361..5b3a7785d3a2 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -24,6 +24,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/hung_task.h>
 #include <linux/rwsem.h>
+#include <linux/sys_info.h>
 
 #include <trace/events/sched.h>
 
@@ -59,12 +60,17 @@ static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
 static int __read_mostly sysctl_hung_task_warnings = 10;
 
 static int __read_mostly did_panic;
-static bool hung_task_show_lock;
 static bool hung_task_call_panic;
-static bool hung_task_show_all_bt;
 
 static struct task_struct *watchdog_task;
 
+/*
+ * A bitmask to control what kinds of system info to be printed when
+ * a hung task is detected, it could be task, memory, lock etc. Refer
+ * include/linux/sys_info.h for detailed bit definition.
+ */
+static unsigned long hung_task_si_mask;
+
 #ifdef CONFIG_SMP
 /*
  * Should we dump all CPUs backtraces in a hung task event?
@@ -217,11 +223,8 @@ static inline void debug_show_blocker(struct task_struct *task, unsigned long ti
 }
 #endif
 
-static void check_hung_task(struct task_struct *t, unsigned long timeout,
-		unsigned long prev_detect_count)
+static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
-	unsigned long total_hung_task;
-
 	if (!task_is_hung(t, timeout))
 		return;
 
@@ -231,20 +234,13 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout,
 	 */
 	sysctl_hung_task_detect_count++;
 
-	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
 	trace_sched_process_hang(t);
 
-	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
-		console_verbose();
-		hung_task_show_lock = true;
-		hung_task_call_panic = true;
-	}
-
 	/*
 	 * Ok, the task did not get scheduled for more than 2 minutes,
 	 * complain:
 	 */
-	if (sysctl_hung_task_warnings || hung_task_call_panic) {
+	if (sysctl_hung_task_warnings) {
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
@@ -259,10 +255,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout,
 			" disables this message.\n");
 		sched_show_task(t);
 		debug_show_blocker(t, timeout);
-		hung_task_show_lock = true;
 
-		if (sysctl_hung_task_all_cpu_backtrace)
-			hung_task_show_all_bt = true;
 		if (!sysctl_hung_task_warnings)
 			pr_info("Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings\n");
 	}
@@ -302,8 +295,11 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 {
 	int max_count = sysctl_hung_task_check_count;
 	unsigned long last_break = jiffies;
+	unsigned long total_hung_task;
 	struct task_struct *g, *t;
 	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
+	int need_warning = sysctl_hung_task_warnings;
+	unsigned long si_mask = hung_task_si_mask;
 
 	/*
 	 * If the system crashed already then all bets are off,
@@ -312,7 +308,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	if (test_taint(TAINT_DIE) || did_panic)
 		return;
 
-	hung_task_show_lock = false;
+
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
 
@@ -324,18 +320,29 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			last_break = jiffies;
 		}
 
-		check_hung_task(t, timeout, prev_detect_count);
+		check_hung_task(t, timeout);
 	}
  unlock:
 	rcu_read_unlock();
-	if (hung_task_show_lock)
-		debug_show_all_locks();
 
-	if (hung_task_show_all_bt) {
-		hung_task_show_all_bt = false;
-		trigger_all_cpu_backtrace();
+	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
+	if (!total_hung_task)
+		return;
+
+	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
+		console_verbose();
+		hung_task_call_panic = true;
+	}
+
+	if (need_warning || hung_task_call_panic) {
+		si_mask |= SYS_INFO_LOCKS;
+
+		if (sysctl_hung_task_all_cpu_backtrace)
+			si_mask |= SYS_INFO_ALL_BT;
 	}
 
+	sys_info(si_mask);
+
 	if (hung_task_call_panic)
 		panic("hung_task: blocked tasks");
 }
@@ -434,6 +441,13 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
+	{
+		.procname	= "hung_task_sys_info",
+		.data		= &hung_task_si_mask,
+		.maxlen         = sizeof(hung_task_si_mask),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sys_info_handler,
+	},
 };
 
 static void __init hung_task_sysctl_init(void)
-- 
2.43.5


