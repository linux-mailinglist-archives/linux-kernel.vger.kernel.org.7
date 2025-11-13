Return-Path: <linux-kernel+bounces-899215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F29C571D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E83C34A516
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B7D33B949;
	Thu, 13 Nov 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NimiYNc1"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914233892C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032249; cv=none; b=oqXkhd3bh3gKyKBiFeYrJt4/hr1LCn5+xwQwX+xWVvYoNY7LyGwWlB7jEpZvnMuJN+BTua5PGV29oRZF+CO8Ejnvbpsfvwp4iX7KfUEtIBQX/fzzMtvgRRQxkIQkHASn47lHrKLD2S3IUr94n6HVrl8IORZS7hkf8jgMk6Hejes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032249; c=relaxed/simple;
	bh=so546Z28Y0ozfRF4Kux5DxMbZgVLjZKYR340NOkaPTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1JevUQqddwgH5HGRq/+gNeryY/5yJr78dGD81A8S7GxhhVHwLdDP8Hbw863WC3VLPx7Q9KZ1s0UPWnrbB6jmhhCLz4SGsg9RD/+JKzr8gfTM7UBIrl6i9eRpcCgwuYQ9nqX/lCUeCP0sbVJeKLJ0z8D3pr8CEEgHoNtT481Bbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NimiYNc1; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763032244; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lAttCcXeOxPRYUKvCBkOyAH/Ei+jFUOesij4DVKlHXA=;
	b=NimiYNc1QLAaoLG4hyzt20gP/6j7zyrTqHbYvKPaERqpkBul5wyrbc0sTRtMSS82Id42EJnFj5DUyNByOrBFqYCDKiDObsQ5/UGZhRbDPvQHO+UAe6FoTDNYJi9bUu5GPR+iTGmXv0EIB7Dcw9MaBF8MBBiqBmEmmCpBZnlWq1w=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WsJMVsJ_1763032242 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Nov 2025 19:10:42 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Lance Yang <ioworker0@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2 4/4] sys_info: add a default kernel sys_info mask
Date: Thu, 13 Nov 2025 19:10:39 +0800
Message-Id: <20251113111039.22701-5-feng.tang@linux.alibaba.com>
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

Which serves as a global default sys_info mask. When users want the
same system information for many error cases (panic, hung, lockup ...),
they can chose to set this global knob only once, while not setting up
each individual sys_info knobs.

This just adds a 'lazy' option, and doesn't change existing kernel
behavior as the mask is 0 by default.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  9 ++++++
 lib/sys_info.c                              | 31 ++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 176520283f1a..239da22c4e28 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -521,6 +521,15 @@ default), only processes with the CAP_SYS_ADMIN capability may create
 io_uring instances.
 
 
+kernel_sys_info
+===============
+A comma separated list of extra system information to be dumped when
+soft/hard lockup is detected, for example, "tasks,mem,timers,locks,...".
+Refer 'panic_sys_info' section below for more details.
+
+It serves as the default kernel control knob, which will take effect
+when a kernel module calls sys_info() with parameter==0.
+
 kexec_load_disabled
 ===================
 
diff --git a/lib/sys_info.c b/lib/sys_info.c
index 323624093e54..f32a06ec9ed4 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -24,6 +24,13 @@ static const char * const si_names[] = {
 	[ilog2(SYS_INFO_BLOCKED_TASKS)]		= "blocked_tasks",
 };
 
+/*
+ * Default kernel sys_info mask.
+ * If a kernel module calls sys_info() with "parameter == 0", then
+ * this mask will be used.
+ */
+static unsigned long kernel_si_mask;
+
 /* Expecting string like "xxx_sys_info=tasks,mem,timers,locks,ftrace,..." */
 unsigned long sys_info_parse_param(char *str)
 {
@@ -110,9 +117,26 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 	else
 		return sys_info_read_handler(&table, buffer, lenp, ppos, ro_table->data);
 }
+
+static const struct ctl_table sys_info_sysctls[] = {
+	{
+		.procname	= "kernel_sys_info",
+		.data		= &kernel_si_mask,
+		.maxlen         = sizeof(kernel_si_mask),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sys_info_handler,
+	},
+};
+
+static int __init sys_info_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sys_info_sysctls);
+	return 0;
+}
+subsys_initcall(sys_info_sysctl_init);
 #endif
 
-void sys_info(unsigned long si_mask)
+static void __sys_info(unsigned long si_mask)
 {
 	if (si_mask & SYS_INFO_TASKS)
 		show_state();
@@ -135,3 +159,8 @@ void sys_info(unsigned long si_mask)
 	if (si_mask & SYS_INFO_BLOCKED_TASKS)
 		show_state_filter(TASK_UNINTERRUPTIBLE);
 }
+
+void sys_info(unsigned long si_mask)
+{
+	__sys_info(si_mask ? : kernel_si_mask);
+}
-- 
2.43.5


