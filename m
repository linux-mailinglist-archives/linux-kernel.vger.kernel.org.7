Return-Path: <linux-kernel+bounces-835218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13BBBA685A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295E7189254F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3FC28725E;
	Sun, 28 Sep 2025 05:32:45 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22A54F81;
	Sun, 28 Sep 2025 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759037565; cv=none; b=KGqJ8KAAoA9fDPeC/H4w3o6onASoAFqbyveA4h98x8QmYFcyknd5QFF6dlih1ZBjEjMQPnuopaiCTpDSFGYqA4KqrsT8Gfg+hi5bb9jnsvcBy56JeGsA5LaKtykZ57BcHyvar6ge7kBdfpJEN/sCbRaXoNBKCYoNHtGTW9/KwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759037565; c=relaxed/simple;
	bh=zn+xJVFHmE2tsVST8G931IHahiiL3v9HuvIdrFjbG+U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bmdd+QmOq/1z30lad3XI8KUZwpBUVwIMHePg77nCgETE6Fs/Lw1kW8kS3oorMNRp3Yi1rs0gNLtZfvIFTX/4OaBbhrklLn/Ty9GGXL68pb7eDFPluOVrC7AquDQha78GpuocwaHzXgb83243kiza1rr6MLKu3qx0tKwWYpByMXM=
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
Subject: [PATCH][v2] hung_task: Panic after fixed number of hung tasks
Date: Sun, 28 Sep 2025 13:31:37 +0800
Message-ID: <20250928053137.3412-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc6.internal.baidu.com (172.31.50.50) To
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

Acked-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: change documentation as Lance suggested

 Documentation/admin-guide/sysctl/kernel.rst |  8 ++++++++
 kernel/hung_task.c                          | 14 +++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b49eab..98b47a7 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -405,6 +405,14 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 1 Panic immediately.
 = =================================================
 
+hung_task_count_to_panic
+=====================
+
+When set to a non-zero value, a kernel panic will be triggered if the
+number of detected hung tasks reaches this value.
+
+Note that setting hung_task_panic=1 will still cause an immediate panic
+on the first hung task.
 
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


