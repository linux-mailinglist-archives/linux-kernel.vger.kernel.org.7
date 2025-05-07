Return-Path: <linux-kernel+bounces-637743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E6AADCB2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 12:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71179A39DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE82165EA;
	Wed,  7 May 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G08ooDU5"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B002153C4
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746614615; cv=none; b=JRj+kKdv84yeaJ/OnemiXI77JrMNYYF7WyqLsHL5Z10kaeobeSba0Mtcm5m8urgKa/sKOVzBz4quS5jsOJPIITtXlVAhdKhJfwYh14KMjADHqWfSWOoy5C2YxYMYU5w0Tu4oJMJJxtpfAHXcCBQVmpQFcLC+GAyxCLucjaPujTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746614615; c=relaxed/simple;
	bh=tW2E658I3M6uqqha9+slKauAhawjMd6b6ubXyPWOciQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btC8RzSnwgQeV1KVYF5mOPGFJgVI/LMbswXBvydcyClkxHp6uf/OWaITA4AMXpmajMldB4Q1gRRGi4UX4aTgzcteh+wF91sTEXUOP8kz7EVJHZRWaNWXUst1Yjt04uuMPLhy1HTWs4MuGiFWPvEADS2s0cmhbvvfEiAJJFGA7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G08ooDU5; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746614604; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4vWtkGh0fb3l4BwRAliZH3bthkTUpQ9fw5yBkTW9YV8=;
	b=G08ooDU5EyEP42LITK3pgcu89P2e3NzgtNeSCmj+QUicLWq0NdBtHKnBNLYoEQ7SE3vZgIEUhCXoOYTtjbT0kH82x/QGlb8jG27JP4w9/ZUODnoXnjIKsb57LcKZA6cRf0ZEpt54ey+x+GjSHEUhcr/JLvhi02kGtmVeAB9XwFM=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WZpoLJg_1746614603 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 May 2025 18:43:23 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <ioworker0@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH RFC 1/3] kernel/panic: generalize panic_print's function to show sys info
Date: Wed,  7 May 2025 18:43:20 +0800
Message-Id: <20250507104322.30700-2-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250507104322.30700-1-feng.tang@linux.alibaba.com>
References: <20250507104322.30700-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panic_print was introduced to help debugging kernel panic by dumping
different kinds of system information like tasks' call stack, memory,
ftrace buffer etc. Acutually this function could help debugging cases
like task-hung, soft/hard lockup too, where user may need the snapshot
of system info at that time.

Extract sys_show_info() function out to be used by other kernel parts
for debugging.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 include/linux/panic.h | 12 ++++++++++++
 kernel/panic.c        | 44 +++++++++++++++++++++----------------------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 2494d51707ef..a6b538936a67 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -16,6 +16,18 @@ extern void oops_enter(void);
 extern void oops_exit(void);
 extern bool oops_may_print(void);
 
+/* Currently SYS_PRINT_ALL_PRINTK_MSG is only used for panic case */
+#define SYS_PRINT_TASK_INFO		0x00000001
+#define SYS_PRINT_MEM_INFO		0x00000002
+#define SYS_PRINT_TIMER_INFO		0x00000004
+#define SYS_PRINT_LOCK_INFO		0x00000008
+#define SYS_PRINT_FTRACE_INFO		0x00000010
+#define SYS_PRINT_ALL_PRINTK_MSG	0x00000020
+#define SYS_PRINT_ALL_CPU_BT		0x00000040
+#define SYS_PRINT_BLOCKED_TASKS		0x00000080
+
+extern void sys_show_info(unsigned long info_mask);
+
 extern bool panic_triggering_all_cpu_backtrace;
 extern int panic_timeout;
 extern unsigned long panic_print;
diff --git a/kernel/panic.c b/kernel/panic.c
index a3889f38153d..4fd9499f6505 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -69,14 +69,6 @@ bool panic_triggering_all_cpu_backtrace;
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
 
-#define PANIC_PRINT_TASK_INFO		0x00000001
-#define PANIC_PRINT_MEM_INFO		0x00000002
-#define PANIC_PRINT_TIMER_INFO		0x00000004
-#define PANIC_PRINT_LOCK_INFO		0x00000008
-#define PANIC_PRINT_FTRACE_INFO		0x00000010
-#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
-#define PANIC_PRINT_ALL_CPU_BT		0x00000040
-#define PANIC_PRINT_BLOCKED_TASKS	0x00000080
 unsigned long panic_print;
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
@@ -208,31 +200,39 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 }
 EXPORT_SYMBOL(nmi_panic);
 
-static void panic_print_sys_info(bool console_flush)
+void sys_show_info(unsigned long info_mask)
 {
-	if (console_flush) {
-		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
-			console_flush_on_panic(CONSOLE_REPLAY_ALL);
-		return;
-	}
-
-	if (panic_print & PANIC_PRINT_TASK_INFO)
+	if (info_mask & SYS_PRINT_TASK_INFO)
 		show_state();
 
-	if (panic_print & PANIC_PRINT_MEM_INFO)
+	if (info_mask & SYS_PRINT_MEM_INFO)
 		show_mem();
 
-	if (panic_print & PANIC_PRINT_TIMER_INFO)
+	if (info_mask & SYS_PRINT_TIMER_INFO)
 		sysrq_timer_list_show();
 
-	if (panic_print & PANIC_PRINT_LOCK_INFO)
+	if (info_mask & SYS_PRINT_LOCK_INFO)
 		debug_show_all_locks();
 
-	if (panic_print & PANIC_PRINT_FTRACE_INFO)
+	if (info_mask & SYS_PRINT_FTRACE_INFO)
 		ftrace_dump(DUMP_ALL);
 
-	if (panic_print & PANIC_PRINT_BLOCKED_TASKS)
+	if (info_mask & SYS_PRINT_BLOCKED_TASKS)
 		show_state_filter(TASK_UNINTERRUPTIBLE);
+
+	if (info_mask & SYS_PRINT_ALL_CPU_BT)
+		trigger_all_cpu_backtrace();
+}
+
+static void panic_print_sys_info(bool console_flush)
+{
+	if (console_flush) {
+		if (panic_print & SYS_PRINT_ALL_PRINTK_MSG)
+			console_flush_on_panic(CONSOLE_REPLAY_ALL);
+		return;
+	}
+
+	sys_show_info(panic_print);
 }
 
 void check_panic_on_warn(const char *origin)
@@ -255,7 +255,7 @@ void check_panic_on_warn(const char *origin)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
+	if (panic_print & SYS_PRINT_ALL_CPU_BT) {
 		/* Temporary allow non-panic CPUs to write their backtraces. */
 		panic_triggering_all_cpu_backtrace = true;
 		trigger_all_cpu_backtrace();
-- 
2.39.5 (Apple Git-154)


