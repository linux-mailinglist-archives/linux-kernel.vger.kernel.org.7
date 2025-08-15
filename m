Return-Path: <linux-kernel+bounces-770358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA6B279F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7175AC690E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57FB2D12E6;
	Fri, 15 Aug 2025 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SToGooAh"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE7277006
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242082; cv=none; b=fvSE+KckHuMgiUKDTSyyhEkk+V+bQOSorAZ/mNX5qVorCq5z5+huInvRTVuoQXSWaD7BuvTkVoZCqheo7ccjT25BfJq4EhNHfEmsmyVRdBT7/dpTzomDvLzJ99wn8mPn0pm+/BpNmTWc69uJQhv1cxysFFEXYoufJ7YRNPpFjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242082; c=relaxed/simple;
	bh=yMhwXvExAIXrUvjYDN3RRM4DD/FBUqu36oMO9HQFcC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G3Nm9cRtmf1bvE40ikFUBBQg06f9uBJAj3PrrPBRjhfD2AKqcdhEZHHFJmVwYDQ4HfTyJ3zupFFajCW7EOIeeGxyIcx1tjYWl6HF9R7Z44hgGlXExuxgm1hBLitkVIst2h2gpMiP4KIQEThUtvsKJnmGEUj4lsaxIYF2ngBy/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SToGooAh; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755242071; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+LJumeGJsa/l6c8YckmCr4Rkg4kV6Qdze8K+ER3yj7k=;
	b=SToGooAh//lLODbUdMCNMUvN1OA/NO5WZxEac+x1bPx2NuIyq6OPXkN8gRBqPnznFchrVEaEJGXLsVLUl9lIGmnkzG5PpGGW8/7V62CgLDWmQHPa++muAwXux5fVTIEkoL0Yl7Jsx8MqiVncgrcEpErlaeTpl+LvHtS0E2157Z0=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wlo5rKZ_1755242070 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 15:14:31 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Cc: paulmck@kernel.org,
	john.ogness@linutronix.de,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH 3/3] panic: add note that 'panic_print' parameter is deprecated
Date: Fri, 15 Aug 2025 15:14:28 +0800
Message-Id: <20250815071428.98041-4-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
References: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
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
---
 include/linux/moduleparam.h | 14 ++++++++++++++
 kernel/panic.c              | 19 ++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 3a25122d83e2..381c3779244c 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -199,6 +199,7 @@ struct kparam_array
 #define core_param_cb(name, ops, arg, perm)		\
 	__level_param_cb(name, ops, arg, perm, 1)
 
+
 /**
  * postcore_param_cb - general callback for a module/cmdline parameter
  *                     to be evaluated before postcore initcall level
@@ -349,6 +350,19 @@ static inline void kernel_param_unlock(struct module *mod)
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
2.43.5


