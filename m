Return-Path: <linux-kernel+bounces-899216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40518C571E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBF5B34C536
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29FD33BBC8;
	Thu, 13 Nov 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SG4z82Cc"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259C33B6D7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032252; cv=none; b=EOpZP9n5QeVuFstkPxyqXW+DH8QmnsAMrkdgr8bNonK/HNOTkNh6r6LODsWZ55iQ5WZ/C/17phJ46RIElAwkfFEvrEOkzA6fhNRBrEq43yL6D8a0/b5+bToIg6R8XehgRs/UC2di/l7doGkqPCjp+TEp7FuRm6itRL2Kd9iEBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032252; c=relaxed/simple;
	bh=IQ0dmN8tB9hARsGwXeLWbxM8TPEDkBTC5esb4ZDfriQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NOHlkNXV0Pldt/pKJAA15+m9xR+xIvfKHn7yCQaKxxmPoKEj0NaheUb/MOfvieixrB3Ei1R8z04WXLpfcN4BrYR9KF3cU8RSNjABdiegTrFRS+cBWIoTyEcmTTCjsurcSd6os6pHfc7yRWOQELTFHoLba6UdpZBraxjwC7J5ubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SG4z82Cc; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763032242; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VHv94C4sdpaA5LbmH2N7hKRmkpD5b1808wwb54YTPH4=;
	b=SG4z82CcAkeBlZ09bXO49/CCg359O3gclZv9f60erMwvsxrw69ObnrZM/OLeUpNH0hu5pzuLXCCd6+qKyEQobA/eJYCHtQm7Sd4S3/wLi8QIr21nvwzxP1Z+PYMAQcny3VjTwhSC0H2Pj6hXYGZgmq1K0xUQdXh3X2RPRshzF2A=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WsJMt-0_1763032241 cluster:ay36)
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
Subject: [PATCH v2 3/4] watchdog: add sys_info sysctls to dump sys info on system lockup
Date: Thu, 13 Nov 2025 19:10:38 +0800
Message-Id: <20251113111039.22701-4-feng.tang@linux.alibaba.com>
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

When soft/hard lockup happens, developers may need different kinds of
system information (call-stacks, memory info, locks, etc.) to help
debugging.

Add 'softlockup_sys_info'  and 'hardlockup_sys_info' sysctl knobs to
take human readable string like "tasks,mem,timers,locks,ftrace,...",
and when system lockup happens, all requested information will be
printed out. (refer kernel/sys_info.c for more details).

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  5 +++
 kernel/watchdog.c                           | 44 +++++++++++++++++++--
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 45b4408dad31..176520283f1a 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -582,6 +582,11 @@ if leaking kernel pointer values to unprivileged users is a concern.
 When ``kptr_restrict`` is set to 2, kernel pointers printed using
 %pK will be replaced with 0s regardless of privileges.
 
+softlockup_sys_info & hardlockup_sys_info
+=========================================
+A comma separated list of extra system information to be dumped when
+soft/hard lockup is detected, for example, "tasks,mem,timers,locks,...".
+Refer 'panic_sys_info' section below for more details.
 
 modprobe
 ========
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 659f5844393c..bbd11562e4c4 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -25,6 +25,7 @@
 #include <linux/stop_machine.h>
 #include <linux/sysctl.h>
 #include <linux/tick.h>
+#include <linux/sys_info.h>
 
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
@@ -65,6 +66,13 @@ int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
 unsigned int __read_mostly hardlockup_panic =
 			IS_ENABLED(CONFIG_BOOTPARAM_HARDLOCKUP_PANIC);
 
+/*
+ * bitmasks to control what kinds of system info to be printed when
+ * hard lockup is detected, it could be task, memory, lock etc.
+ * Refer include/linux/sys_info.h for detailed bit definition.
+ */
+static unsigned long hardlockup_si_mask;
+
 #ifdef CONFIG_SYSFS
 
 static unsigned int hardlockup_count;
@@ -178,11 +186,15 @@ static void watchdog_hardlockup_kick(void)
 
 void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 {
+	int hardlockup_all_cpu_backtrace;
+
 	if (per_cpu(watchdog_hardlockup_touched, cpu)) {
 		per_cpu(watchdog_hardlockup_touched, cpu) = false;
 		return;
 	}
 
+	hardlockup_all_cpu_backtrace = (hardlockup_si_mask & SYS_INFO_ALL_BT) ?
+					1 : sysctl_hardlockup_all_cpu_backtrace;
 	/*
 	 * Check for a hardlockup by making sure the CPU's timer
 	 * interrupt is incrementing. The timer interrupt should have
@@ -205,7 +217,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		 * Prevent multiple hard-lockup reports if one cpu is already
 		 * engaged in dumping all cpu back traces.
 		 */
-		if (sysctl_hardlockup_all_cpu_backtrace) {
+		if (hardlockup_all_cpu_backtrace) {
 			if (test_and_set_bit_lock(0, &hard_lockup_nmi_warn))
 				return;
 		}
@@ -234,12 +246,13 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 			trigger_single_cpu_backtrace(cpu);
 		}
 
-		if (sysctl_hardlockup_all_cpu_backtrace) {
+		if (hardlockup_all_cpu_backtrace) {
 			trigger_allbutcpu_cpu_backtrace(cpu);
 			if (!hardlockup_panic)
 				clear_bit_unlock(0, &hard_lockup_nmi_warn);
 		}
 
+		sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
@@ -330,6 +343,13 @@ static void lockup_detector_update_enable(void)
 int __read_mostly sysctl_softlockup_all_cpu_backtrace;
 #endif
 
+/*
+ * bitmasks to control what kinds of system info to be printed when
+ * soft lockup is detected, it could be task, memory, lock etc.
+ * Refer include/linux/sys_info.h for detailed bit definition.
+ */
+static unsigned long softlockup_si_mask;
+
 static struct cpumask watchdog_allowed_mask __read_mostly;
 
 /* Global variables, exported for sysctl */
@@ -746,7 +766,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	unsigned long touch_ts, period_ts, now;
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
-	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
+	int softlockup_all_cpu_backtrace;
 	unsigned long flags;
 
 	if (!watchdog_enabled)
@@ -758,6 +778,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	if (panic_in_progress())
 		return HRTIMER_NORESTART;
 
+	softlockup_all_cpu_backtrace = (softlockup_si_mask & SYS_INFO_ALL_BT) ?
+					1 : sysctl_softlockup_all_cpu_backtrace;
+
 	watchdog_hardlockup_kick();
 
 	/* kick the softlockup detector */
@@ -846,6 +869,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		}
 
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
+		sys_info(softlockup_si_mask & ~SYS_INFO_ALL_BT);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
 	}
@@ -1197,6 +1221,13 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "softlockup_sys_info",
+		.data		= &softlockup_si_mask,
+		.maxlen         = sizeof(softlockup_si_mask),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sys_info_handler,
+	},
 #ifdef CONFIG_SMP
 	{
 		.procname	= "softlockup_all_cpu_backtrace",
@@ -1219,6 +1250,13 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "hardlockup_sys_info",
+		.data		= &hardlockup_si_mask,
+		.maxlen         = sizeof(hardlockup_si_mask),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sys_info_handler,
+	},
 #ifdef CONFIG_SMP
 	{
 		.procname	= "hardlockup_all_cpu_backtrace",
-- 
2.43.5


