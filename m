Return-Path: <linux-kernel+bounces-828197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886A7B9428C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47397440BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB00A2580E2;
	Tue, 23 Sep 2025 03:54:08 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E638720C47C;
	Tue, 23 Sep 2025 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599648; cv=none; b=rxHEFXcpx+HQEQfgxfGr/nZ7yvkeeCG9g/DS5BbSROSs+CMjLDdTMlxb6AoQhjK8CxR9De2YqNzWYHDfBW1CuOtNlJpc4O4RKbkLEVLgnAJoHwx2LbIYEjb+V89bgj763QQOgF8RLF34JwYwFIfC4j5b0NSSPFEfAl1RKF+RZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599648; c=relaxed/simple;
	bh=Zg3FPoSHnAv2PObrg/i19fiiMx4nTL23ooT1KVwjkss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GyvVcmrgkwtavki/i3+MOS5KGofkzlgo9ouOYFro8gFrXBJK2xb0OAkzI/YbKfWX0dlb7SZiRxHBiYTRprenaomzm7KcXsedUE/h57wZMJFPa4VkZaysQIkcIzPlZ6NZP1P9fn1qYzAG5SM3vGetWwkrnduSWdaqlmQiTRgfGHY=
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
Subject: [PATCH][RFC] hung_task: Support to panic when the maximum number of hung task warnings is reached
Date: Tue, 23 Sep 2025 11:37:40 +0800
Message-ID: <20250923033740.2696-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc12.internal.baidu.com (172.31.3.22) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Currently the hung task detector can either panic immediately or continue
operation when hung tasks are detected. However, there are scenarios
where we want a more balanced approach:

- We don't want the system to panic immediately when a few hung tasks
  are detected, as the system may be able to recover
- And we also don't want the system to stall indefinitely with multiple
  hung tasks

This commit introduces a new mode (value 2) for the hung task panic behavior.
When set to 2, the system will panic only after the maximum number of hung
task warnings (hung_task_warnings) has been reached.

This provides a middle ground between immediate panic and potentially
infinite stall, allowing for automated vmcore generation after a reasonable
number of hung task incidents.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 ++++++++-------
 Documentation/admin-guide/sysctl/kernel.rst     |  1 +
 kernel/hung_task.c                              |  5 +++--
 lib/Kconfig.debug                               |  4 ++--
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5a7a83c..f2a9876 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1993,13 +1993,14 @@
 
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
-			Format: 0 | 1
-
-			A value of 1 instructs the kernel to panic when a
-			hung task is detected. The default value is controlled
-			by the CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time
-			option. The value selected by this boot parameter can
-			be changed later by the kernel.hung_task_panic sysctl.
+			Format: 0 | 1 | 2
+
+			A value of 1 instructs the kernel to panic when a hung task is detected.
+			A value of 2 instructs the kernel to panic when hung_task_warnings is
+			decreased to 0.  The default value is controlled by the
+			CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time option. The value selected
+			by this boot parameter can be changed later by the kernel.hung_task_panic
+			sysctl.
 
 	hvc_iucv=	[S390]	Number of z/VM IUCV hypervisor console (HVC)
 				terminal devices. Valid values: 0..8
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b49eab..6f77241 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -403,6 +403,7 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 = =================================================
 0 Continue operation. This is the default behavior.
 1 Panic immediately.
+2 Panic when hung_task_warnings is decreased to 0.
 = =================================================
 
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a12..b052ec7 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -219,7 +219,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 
 	trace_sched_process_hang(t);
 
-	if (sysctl_hung_task_panic) {
+	if ((sysctl_hung_task_panic == 1) ||
+		(!sysctl_hung_task_warnings && sysctl_hung_task_panic == 2)) {
 		console_verbose();
 		hung_task_show_lock = true;
 		hung_task_call_panic = true;
@@ -385,7 +386,7 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= SYSCTL_TWO,
 	},
 	{
 		.procname	= "hung_task_check_count",
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dc0e0c6..e7cf166 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1264,10 +1264,10 @@ config DEFAULT_HUNG_TASK_TIMEOUT
 	  Keeping the default should be fine in most cases.
 
 config BOOTPARAM_HUNG_TASK_PANIC
-	bool "Panic (Reboot) On Hung Tasks"
+	int "Panic (Reboot) On Hung Tasks"
 	depends on DETECT_HUNG_TASK
 	help
-	  Say Y here to enable the kernel to panic on "hung tasks",
+	  Say 1|2 here to enable the kernel to panic on "hung tasks",
 	  which are bugs that cause the kernel to leave a task stuck
 	  in uninterruptible "D" state.
 
-- 
2.9.4


