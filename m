Return-Path: <linux-kernel+bounces-887683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B0C38DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7483B3E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7331D9A5F;
	Thu,  6 Nov 2025 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xi7Ig5dk"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DB1156237
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396241; cv=none; b=a55BePLteMpWSpCd7vQDVfOsjrv7c3IiahfiI6Uz814eNK4WUEk8yw5CFWIXEnUztxLLGmWluzwg6U7yIr+kfqyoWD01Yu5Xtvf1PU8/A1LKCT6ypQFAwmWC2YQxUitBfR3TdNss5u4z89Psjw6F+L7Iw0cTGxAcJM/be4e0dlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396241; c=relaxed/simple;
	bh=rldANu1bM6kh4uMiSWZljVGOAAetSLGM4A/+GRqsFDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQApCDsgHh1henEoPLnF3tmBkXXDLKMCeP9v9GI8LPzMKSzx2g9y4lbWw7gIb6tIWm+IEERtIOZCvMF/QA54DCeXfxtzAq7x4lAn4i01g+82jFVooA92IxW3jUCBcT6rSH/ooilKAn1RQ8mpfq0VXzfLFA/1W5t1GNKPEjVEuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xi7Ig5dk; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762396235; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TvsBwblFDeW5X/bAx8943nICS2fulV+Z3Fcs8DxGh1E=;
	b=xi7Ig5dkmaF3Xl6iKg7gMdrz4V4F5G+YyJqfmlE1SgWp9wjQr9zHAmfezjJ/5ZSPaNz58+3blfVzctrFNoQhQr2nCb8abHYR5NQWGZwZJCpRS2agr/E0jn2RdiN5L2eI2Tnz5NDSB7FNO14AqZOUlZZJsUDCpvvEwQJTGhoykRk=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wrne7a-_1762396234 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 10:30:34 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Lance Yang <ioworker0@gmail.com>,
	paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH 2/3] hung_task: Add hung_task_sys_info sysctl to dump sys info on task-hung
Date: Thu,  6 Nov 2025 10:30:31 +0800
Message-Id: <20251106023032.25875-3-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
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

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  5 +++
 kernel/hung_task.c                          | 39 +++++++++++++++------
 2 files changed, 33 insertions(+), 11 deletions(-)

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
index 84b4b049faa5..102be5a8e75a 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -24,6 +24,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/hung_task.h>
 #include <linux/rwsem.h>
+#include <linux/sys_info.h>
 
 #include <trace/events/sched.h>
 
@@ -60,12 +61,23 @@ static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
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
+/*
+ * There are several sysctl knobs, and this serves as the runtime
+ * effective sys_info knob
+ */
+static unsigned long cur_si_mask;
+
 #ifdef CONFIG_SMP
 /*
  * Should we dump all CPUs backtraces in a hung task event?
@@ -235,9 +247,10 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout,
 	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
 	trace_sched_process_hang(t);
 
+	cur_si_mask = hung_task_si_mask;
 	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
 		console_verbose();
-		hung_task_show_lock = true;
+		cur_si_mask |= SYS_INFO_LOCKS;
 		hung_task_call_panic = true;
 	}
 
@@ -260,10 +273,10 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout,
 			" disables this message.\n");
 		sched_show_task(t);
 		debug_show_blocker(t, timeout);
-		hung_task_show_lock = true;
+		cur_si_mask |= SYS_INFO_LOCKS;
 
 		if (sysctl_hung_task_all_cpu_backtrace)
-			hung_task_show_all_bt = true;
+			cur_si_mask |= SYS_INFO_ALL_BT;
 		if (!sysctl_hung_task_warnings)
 			pr_info("Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings\n");
 	}
@@ -313,7 +326,6 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	if (test_taint(TAINT_DIE) || did_panic)
 		return;
 
-	hung_task_show_lock = false;
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
 
@@ -329,12 +341,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	}
  unlock:
 	rcu_read_unlock();
-	if (hung_task_show_lock)
-		debug_show_all_locks();
 
-	if (hung_task_show_all_bt) {
-		hung_task_show_all_bt = false;
-		trigger_all_cpu_backtrace();
+	if (unlikely(cur_si_mask)) {
+		sys_info(cur_si_mask);
+		cur_si_mask = 0;
 	}
 
 	if (hung_task_call_panic)
@@ -435,6 +445,13 @@ static const struct ctl_table hung_task_sysctls[] = {
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


