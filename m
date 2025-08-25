Return-Path: <linux-kernel+bounces-783921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA6BB33434
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DDE1B227FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA623C8C5;
	Mon, 25 Aug 2025 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OjW7fCoG"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48823A994
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090635; cv=none; b=JYxEXWLnRj7jSnXHVTmueVQzWjtuvYzPmTPRDkI1cbVhp6C2nmjMdEwi40Jr0BFkbByYxHNsn4sVlrLyjcYJnXAiIMUrbIhynT4kK6/t6NozmV2bGjX7e9h+vsm2iCKAdYgDWfuH9uPQvTwVs7/1DVCq9M4oYWpuosgLcFzMcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090635; c=relaxed/simple;
	bh=XLv/LusOLW5sOpqiU7vxP4m9mYXRHcn/jRt2bvgYKHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4ZWaqNNaDwRKiuymCHPchSgY05cQ7z6loEgRPTKAfDJcFiU46DM3maBMVsCcK0fnMxfhp3VBfbAcdIQ5R+DL7YQlJyK2oW1BSPU7c7AmdKaq3Zi/TU090TxwqpDb8CQm60Yeg29KhZ3NFAwwuPT5j4QW3rMaVjKeYd/hSqm4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OjW7fCoG; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756090625; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qbg4wU7MeI3SPqJLbIfhWaVkJGVKqRVkvI2mSAMCJQ8=;
	b=OjW7fCoGGODaPw5C72OOKb30HuyLPoOYIIddxPLHBbNmvTK6JgeZmdXmaeHbWwGpTHnrDzbRXt1/4+VayVCWXjbIRax5VR9LqQtGHpvkanRjuSipAJ4cs7Bbo17gtF/fHjiuEv0MO16/9n8uF/dTAVCWMGx21uKNNhcdxMV8YW4=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WmPuXHH_1756090624 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 10:57:05 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Cc: Askar Safin <safinaskar@zohomail.com>,
	paulmck@kernel.org,
	john.ogness@linutronix.de,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2 3/4] panic: add note that 'panic_print' parameter is deprecated
Date: Mon, 25 Aug 2025 10:57:00 +0800
Message-Id: <20250825025701.81921-4-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825025701.81921-1-feng.tang@linux.alibaba.com>
References: <20250825025701.81921-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like for 'panic_print's systcl interface, add similar note for
setup of kernel cmdline parameter and parameter under /sys/module/kernel/.

Also add __core_param_cb() macro, which enables to add special get/set
operation for a kernel parameter.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/moduleparam.h | 13 +++++++++++++
 kernel/panic.c              | 19 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 3a25122d83e2..6907aedc4f74 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -349,6 +349,19 @@ static inline void kernel_param_unlock(struct module *mod)
 	__module_param_call("", name, &param_ops_##type, &var, perm,	\
 			    -1, KERNEL_PARAM_FL_UNSAFE)
 
+/**
+ * __core_param_cb - similar like core_param, with a set/get ops instead of type.
+ * @name: the name of the cmdline and sysfs parameter (often the same as var)
+ * @var: the variable
+ * @ops: the set & get operations for this parameter.
+ * @perm: visibility in sysfs
+ *
+ * Ideally this should be called 'core_param_cb', but the name has been
+ * used for module core parameter, so add the '__' prefix
+ */
+#define __core_param_cb(name, ops, arg, perm) \
+	__module_param_call("", name, ops, arg, perm, -1, 0)
+
 #endif /* !MODULE */
 
 /**
diff --git a/kernel/panic.c b/kernel/panic.c
index 72fcbb5a071b..12a10e17ab4a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -937,12 +937,29 @@ EXPORT_SYMBOL(__stack_chk_fail);
 #endif
 
 core_param(panic, panic_timeout, int, 0644);
-core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
 core_param(panic_console_replay, panic_console_replay, bool, 0644);
 
+static int panic_print_set(const char *val, const struct kernel_param *kp)
+{
+	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
+	return  param_set_ulong(val, kp);
+}
+
+static int panic_print_get(char *val, const struct kernel_param *kp)
+{
+	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
+	return  param_get_ulong(val, kp);
+}
+
+static const struct kernel_param_ops panic_print_ops = {
+	.set	= panic_print_set,
+	.get	= panic_print_get,
+};
+__core_param_cb(panic_print, &panic_print_ops, &panic_print, 0644);
+
 static int __init oops_setup(char *s)
 {
 	if (!s)
-- 
2.39.5 (Apple Git-154)


