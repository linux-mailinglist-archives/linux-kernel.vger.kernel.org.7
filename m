Return-Path: <linux-kernel+bounces-645930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E071EAB5598
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A334A0DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B028E56C;
	Tue, 13 May 2025 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xlSXEzJ6"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52F1EB18C
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141665; cv=none; b=uVfv7180iE4+lfgXu/ivIVMcbI0j1jzuBgvt+gLyZSgew6yxsmF6Omk4LAl/WIHx8sHguncDzzdczdbx+Va0uYGlaq3HzyaxFdktMilDVKZpFrs8pqWL2AcXjDXqE83iuPi+H8XbOm7YoNf5Fp0nmrlPLeLExP2TklQaq2dBlDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141665; c=relaxed/simple;
	bh=Ybd4RyZ6Q9fP4KYnLHNO3QXakG7hkLzF4BM8ja5Q1TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GmX/UnyMAJJ7fcx1a0eg5zqAPULInDQQcu90uGg1UQMQRfHx9SZU3iKfmbHuDDfLebNCD7wXPzWZaXjc/evoIwQDu/C14r9rfkvsp+s2KVeOZhtzMzVCWwm5is43RCDFJL+U3qR9SAlxueJzYhUCOttBMM1NXInE7Da+pGdL0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xlSXEzJ6; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747141660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3sqdFiuw9KK4ySpL6GH6pVXMgrHBiQKjZIPht/9Z5G4=;
	b=xlSXEzJ6ZKsq2An0162pwbTbTAj0Empjhjy5YH/LTn2NuO2l6iwumJaJHmKd5Bw+XB7hoG
	VEsdRT0f9wNbSR4+fX0h9pdvShfMsXbiqSaMgW9Jp2DIOLshjjInjlfV7BP3HKnRVs3Ipk
	9l0UjkMD39AZ8lTDK+P8aqNjGk8zdoE=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2] params: Add support for static keys
Date: Tue, 13 May 2025 09:07:32 -0400
Message-ID: <20250513130734.370280-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Static keys can now be a module parameter, e.g.

module_param_named(foo, foo.key, static_key_t, 0644)

bcachefs is now using this.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/jump_label.h  |  2 ++
 include/linux/moduleparam.h |  7 +++++++
 kernel/params.c             | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index fdb79dd1ebd8..0fc9b71db56f 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -107,6 +107,8 @@ struct static_key {
 #endif	/* CONFIG_JUMP_LABEL */
 };
 
+typedef struct static_key static_key_t;
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_JUMP_LABEL
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index bfb85fd13e1f..11e8d5c57435 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -122,6 +122,7 @@ struct kparam_array
  *	charp: a character pointer
  *	bool: a bool, values 0/1, y/n, Y/N.
  *	invbool: the above, only sense-reversed (N = true).
+ *	static_key_t: same as bool, but updates a 'struct static_key'
  */
 #define module_param(name, type, perm)				\
 	module_param_named(name, name, type, perm)
@@ -488,6 +489,12 @@ extern int param_set_bint(const char *val, const struct kernel_param *kp);
 #define param_get_bint param_get_int
 #define param_check_bint param_check_int
 
+/* A static key, which can only be set like a bool */
+extern const struct kernel_param_ops param_ops_static_key_t;
+extern int param_set_static_key_t(const char *val, const struct kernel_param *kp);
+extern int param_get_static_key_t(char *buffer, const struct kernel_param *kp);
+#define param_check_static_key_t(name, p) __param_check(name, p, struct static_key)
+
 /**
  * module_param_array - a parameter which is an array of some type
  * @name: the name of the array variable
diff --git a/kernel/params.c b/kernel/params.c
index 2509f216c9f3..dd10ed125826 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -14,6 +14,7 @@
 #include <linux/overflow.h>
 #include <linux/security.h>
 #include <linux/slab.h>
+#include <linux/static_key.h>
 #include <linux/string.h>
 
 #ifdef CONFIG_SYSFS
@@ -412,6 +413,40 @@ const struct kernel_param_ops param_ops_bint = {
 };
 EXPORT_SYMBOL(param_ops_bint);
 
+int param_set_static_key_t(const char *val, const struct kernel_param *kp)
+{
+	/* Match bool exactly, by re-using it. */
+	struct kernel_param boolkp = *kp;
+	bool v;
+	int ret;
+
+	boolkp.arg = &v;
+
+	ret = param_set_bool(val, &boolkp);
+	if (ret)
+		return ret;
+	if (v)
+		static_key_enable(kp->arg);
+	else
+		static_key_disable(kp->arg);
+	return 0;
+}
+EXPORT_SYMBOL(param_set_static_key_t);
+
+int param_get_static_key_t(char *buffer, const struct kernel_param *kp)
+{
+	struct static_key *key = kp->arg;
+	return sprintf(buffer, "%c\n", static_key_enabled(key) ? 'Y' : 'N');
+}
+EXPORT_SYMBOL(param_get_static_key_t);
+
+const struct kernel_param_ops param_ops_static_key_t = {
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
+	.set = param_set_static_key_t,
+	.get = param_get_static_key_t,
+};
+EXPORT_SYMBOL(param_ops_static_key_t);
+
 /* We break the rule and mangle the string. */
 static int param_array(struct module *mod,
 		       const char *name,
-- 
2.49.0


