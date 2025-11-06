Return-Path: <linux-kernel+bounces-887684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3023BC38DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7A93B3C60
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A121146C;
	Thu,  6 Nov 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VOCI/jIL"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5471757EA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396241; cv=none; b=fDbTto7GapV7gIBbgXibBVQTt34hykx1KsmD06Ek2zVGz7sn3VdKaxfNvHeRoNRTyd70p7rx3dUjiT3ufEe5NaLuCv7jcSOR4CylH9oiprDzGUhQX6Wtyz+nOEUGSALIZzn++dLaTYRAtKhLSlVBmQEIc5FsAVTR/5mQir91Koc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396241; c=relaxed/simple;
	bh=X2S55Lp2RJp/PN0J7+fxeHVpl5M6fOu6HJWEJFiExWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HNgc2/eI4Q65qW65rzHB93mKeYueQrOMY7qEvVcHwbmpChG1IefT4P9jwy8/lVWJi/btJsaZf+tY4ZJLH1xcjKGGYmGMF3IPtASChUq70plTfs2K0g/D9DZCPYfCojUWh6ITEpjQMUNveosnTO8XIzZSQo4aOhKISZ34wBz9NcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VOCI/jIL; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762396236; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=pX1HCCwUYPCV9eTsvId92R0ABA4d10Uwvm/lHQmQKuo=;
	b=VOCI/jILUKw2/AKzNlG3bwXK2B2J8ix59e0TrWl+z1DWEVv6yQxVBQRSoTgnWZqBJGtYxomlGv1TvpIwvNxd9uvhvT8ktg0kzq1mtZIzUfbYve4iAy9IwsmQARBIlwd40pFhC3MuaVTsDQiyfT+xKhnM0uibn2nKHarOYY9Hiu8=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WrnlZnE_1762396235 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 10:30:35 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Lance Yang <ioworker0@gmail.com>,
	paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH 3/3] watchdog: add lockup_sys_info sysctl to dump sys info on system lockup
Date: Thu,  6 Nov 2025 10:30:32 +0800
Message-Id: <20251106023032.25875-4-feng.tang@linux.alibaba.com>
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

When soft/hard lockup happens, developers may need different kinds of
system information (call-stacks, memory info, locks, etc.) to help debugging.

Add 'lockup_sys_info' sysctl knob to take human readable string like
"tasks,mem,timers,locks,ftrace,...", and when system lockup happens, all
requested information will be dumped. (refer kernel/sys_info.c for more
details).

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  5 +++++
 kernel/watchdog.c                           | 21 ++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 45b4408dad31..4e39e661d5ab 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -582,6 +582,11 @@ if leaking kernel pointer values to unprivileged users is a concern.
 When ``kptr_restrict`` is set to 2, kernel pointers printed using
 %pK will be replaced with 0s regardless of privileges.
 
+lockup_sys_info
+==================
+A comma separated list of extra system information to be dumped when
+soft/hard lockup is detected, for example, "tasks,mem,timers,locks,...".
+Refer 'panic_sys_info' section below for more details.
 
 modprobe
 ========
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 659f5844393c..18d8f2a32318 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -25,6 +25,7 @@
 #include <linux/stop_machine.h>
 #include <linux/sysctl.h>
 #include <linux/tick.h>
+#include <linux/sys_info.h>
 
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
@@ -53,6 +54,13 @@ static int __read_mostly watchdog_hardlockup_available;
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
+/*
+ * A bitmask to control what kinds of system info to be printed when
+ * system lockup is detected, it could be task, memory, lock etc. Refer
+ * include/linux/sys_info.h for detailed bit definition.
+ */
+static unsigned long lockup_si_mask;
+
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 
 # ifdef CONFIG_SMP
@@ -240,6 +248,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 				clear_bit_unlock(0, &hard_lockup_nmi_warn);
 		}
 
+		sys_info(lockup_si_mask);
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
@@ -746,9 +755,11 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	unsigned long touch_ts, period_ts, now;
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
-	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
+	int softlockup_all_cpu_backtrace;
 	unsigned long flags;
 
+	softlockup_all_cpu_backtrace = (lockup_si_mask & SYS_INFO_ALL_BT) ?
+					1 : sysctl_softlockup_all_cpu_backtrace;
 	if (!watchdog_enabled)
 		return HRTIMER_NORESTART;
 
@@ -846,6 +857,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		}
 
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
+		sys_info(lockup_si_mask & ~SYS_INFO_ALL_BT);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
 	}
@@ -1178,6 +1190,13 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_watchdog_cpumask,
 	},
+	{
+		.procname	= "lockup_sys_info",
+		.data		= &lockup_si_mask,
+		.maxlen         = sizeof(lockup_si_mask),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sys_info_handler,
+	},
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
 	{
 		.procname       = "soft_watchdog",
-- 
2.43.5


