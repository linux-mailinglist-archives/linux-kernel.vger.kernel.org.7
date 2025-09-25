Return-Path: <linux-kernel+bounces-831770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E9B9D897
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBFD7AD902
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0492E8B71;
	Thu, 25 Sep 2025 06:07:56 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1056FC3;
	Thu, 25 Sep 2025 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780476; cv=none; b=QIjPjgLClhsi9zYeDDR0exQegH6amOlUGAxdc0Hb8IcGJ2CmnESUSe//DzxeudUON/JmVzW8M41KsB3+cWAJdJPrczusEZm7OERAAkDu7lA0U7W/y5hQLxBpnyDVY0zTo7sDXAcYqZ1BbVw1GcIZEgLQqgCjTleShGdpinXDM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780476; c=relaxed/simple;
	bh=z4ZiNnZcw1Qdr46uOzZTn7SWQKBk9df+MqGQZoOF+tA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bfgf+6eUoUqZvji+Ofj5hYzTakDhakLtw1mwCfTfrQ/lRJmib2tS+hoG0xBFAa4S0LkgkAS8ilWIMUAUhsGYZzO7WZyTacKFPDHzj1H8qiUPuLHQhLzk62ZHoHhy8y46xlajyscN2Ebsf80n+fzPXBtM3wNPJQwaqSp+bbTo+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <corbet@lwn.net>, <akpm@linux-foundation.org>, <lance.yang@linux.dev>,
	<mhiramat@kernel.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <mingo@kernel.org>,
	<dave.hansen@linux.intel.com>, <rostedt@goodmis.org>, <kees@kernel.org>,
	<arnd@arndb.de>, <lirongqing@baidu.com>, <feng.tang@linux.alibaba.com>,
	<pauld@redhat.com>, <joel.granados@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] hung_task: Panic after fixed number of hung tasks
Date: Thu, 25 Sep 2025 14:06:05 +0800
Message-ID: <20250925060605.2659-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc13.internal.baidu.com (172.31.51.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Currently, when hung_task_panic is enabled, kernel will panic immediately
upon detecting the first hung task. However, some hung tasks are transient
and the system can recover fully, while others are unrecoverable and
trigger consecutive hung task reports, and a panic is expected.

This commit adds a new sysctl parameter hung_task_count_to_panic to allows
specifying the number of consecutive hung tasks that must be detected
before triggering a kernel panic. This provides finer control for
environments where transient hangs maybe happen but persistent hangs should
still be fatal.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  6 ++++++
 kernel/hung_task.c                          | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b49eab..4240e7b 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -405,6 +405,12 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 1 Panic immediately.
 = =================================================
 
+hung_task_count_to_panic
+=====================
+
+When set to a non-zero value, after the number of consecutive hung task
+occur, the kernel will triggers a panic
+
 
 hung_task_check_count
 =====================
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a12..87a6421 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -83,6 +83,8 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
 static unsigned int __read_mostly sysctl_hung_task_panic =
 	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
 
+static unsigned int __read_mostly sysctl_hung_task_count_to_panic;
+
 static int
 hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
 {
@@ -219,7 +221,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 
 	trace_sched_process_hang(t);
 
-	if (sysctl_hung_task_panic) {
+	if (sysctl_hung_task_panic ||
+	    (sysctl_hung_task_count_to_panic &&
+	     (sysctl_hung_task_detect_count >= sysctl_hung_task_count_to_panic))) {
 		console_verbose();
 		hung_task_show_lock = true;
 		hung_task_call_panic = true;
@@ -388,6 +392,14 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 	{
+		.procname	= "hung_task_count_to_panic",
+		.data		= &sysctl_hung_task_count_to_panic,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+	{
 		.procname	= "hung_task_check_count",
 		.data		= &sysctl_hung_task_check_count,
 		.maxlen		= sizeof(int),
-- 
2.9.4


