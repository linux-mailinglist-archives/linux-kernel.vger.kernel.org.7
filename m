Return-Path: <linux-kernel+bounces-806807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1998B49C09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880BE4E7F4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2CD312819;
	Mon,  8 Sep 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmAsXvai";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="usuPGSij"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CA3101D9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367126; cv=none; b=BRX81rra0bKZ/042Zxtxuo5YXOgXQv01b7XJgoOBbv0KNx4aLGT2S4vEaArDD1oZpkJ07CQPsh5W7HW3yyjNgRn9a4gRV/QT6uk1VIWalnIlMvMJLx3wMaTA0P2ReRqbemLyy2mKvaXnKFTTcREChYNE7VnQrJAcdZlU+b8it0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367126; c=relaxed/simple;
	bh=MgrLu8885YykjI9T+zoAugV4jP2T9LfTNVif86nyMpQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=h0oj9EQ5dBlkSoErCyfu2n4ozzfsmcRbnJlBMnoogsaMsBpZl0UwK2lZi/4wmwCKGTpwnj/OFHgIIDjwTC6Fe2vCRWqVT+hl8wB04Oc+kMtJXrmwOBagV/DVnLoWqAWJJNu6wZI9MwD8unQevQTSAmP5NZ7rakHIBdpnZixDjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmAsXvai; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=usuPGSij; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.416885718@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ELIY36Vd7T3xHlN9AvBbx8OgIkFV2rxtaqgthmf+YiE=;
	b=xmAsXvai11nGj00i8PkP0olwcc0fcW6VigRR+Cgyz/ygR8QqGyxjLCIUxPnPlhASlwKlvp
	3ZYRjeE6FK703PLbBT0TpNJR9MB/IjRJSIc0ETF2zbk8EZ1FT0h8rrh6wAwuX84L4xHNdq
	P+hCIubcgOowkpwc5a4S0/xQN1UZ1xSBA7eH40vNyCxDSkXWH3nFdldj7ZcuXmyTpCCLuk
	RDBUBY8rVzLQQV6VVyzsvAwQ2Zi3y8r9ATixemjitoYMeqAjjshk2oQpUtFAJP7q1h19uB
	p2ZBjkjIyRawxs0JyDQljl6825MSbmu6yjVOjsgDvpMBVNO9+N+8e8tmhsdO3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ELIY36Vd7T3xHlN9AvBbx8OgIkFV2rxtaqgthmf+YiE=;
	b=usuPGSijV1PE+qCnuyEwSGVOjyTZmzb1ErUAXu5V5cvk21csH7FSl9nUqGHyWJdkMT3fyA
	A+rcj1YeqQJ/UWCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V4 18/36] rseq: Provide static branch for runtime debugging
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:02 +0200 (CEST)

Config based debug is rarely turned on and is not available easily when
things go wrong.

Provide a static branch to allow permanent integration of debug mechanisms
along with the usual toggles in Kconfig, command line and debugfs.

Requested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
V3: Fix __setup() return value - Michael
---
 Documentation/admin-guide/kernel-parameters.txt |    4 +
 include/linux/rseq_entry.h                      |    3 
 init/Kconfig                                    |   14 ++++
 kernel/rseq.c                                   |   73 ++++++++++++++++++++++--
 4 files changed, 90 insertions(+), 4 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6443,6 +6443,10 @@
 			Memory area to be used by remote processor image,
 			managed by CMA.
 
+	rseq_debug=	[KNL] Enable or disable restartable sequence
+			debug mode. Defaults to CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE.
+			Format: <bool>
+
 	rt_group_sched=	[KNL] Enable or disable SCHED_RR/FIFO group scheduling
 			when CONFIG_RT_GROUP_SCHED=y. Defaults to
 			!CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED.
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -34,6 +34,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
 #endif /* !CONFIG_RSEQ_STATS */
 
 #ifdef CONFIG_RSEQ
+#include <linux/jump_label.h>
 #include <linux/rseq.h>
 
 #include <linux/tracepoint-defs.h>
@@ -64,6 +65,8 @@ static inline void rseq_trace_ip_fixup(u
 				       unsigned long offset, unsigned long abort_ip) { }
 #endif /* !CONFIG_TRACEPOINT */
 
+DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
+
 static __always_inline void rseq_note_user_irq_entry(void)
 {
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1895,10 +1895,24 @@ config RSEQ_STATS
 
 	  If unsure, say N.
 
+config RSEQ_DEBUG_DEFAULT_ENABLE
+	default n
+	bool "Enable restartable sequences debug mode by default" if EXPERT
+	depends on RSEQ
+	help
+	  This enables the static branch for debug mode of restartable
+	  sequences.
+
+	  This also can be controlled on the kernel command line via the
+	  command line parameter "rseq_debug=0/1" and through debugfs.
+
+	  If unsure, say N.
+
 config DEBUG_RSEQ
 	default n
 	bool "Enable debugging of rseq() system call" if EXPERT
 	depends on RSEQ && DEBUG_KERNEL
+	select RSEQ_DEBUG_DEFAULT_ENABLE
 	help
 	  Enable extra debugging checks for the rseq system call.
 
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -95,6 +95,27 @@
 				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
 
+DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
+
+static inline void rseq_control_debug(bool on)
+{
+	if (on)
+		static_branch_enable(&rseq_debug_enabled);
+	else
+		static_branch_disable(&rseq_debug_enabled);
+}
+
+static int __init rseq_setup_debug(char *str)
+{
+	bool on;
+
+	if (kstrtobool(str, &on))
+		return -EINVAL;
+	rseq_control_debug(on);
+	return 1;
+}
+__setup("rseq_debug=", rseq_setup_debug);
+
 #ifdef CONFIG_TRACEPOINTS
 /*
  * Out of line, so the actual update functions can be in a header to be
@@ -112,10 +133,11 @@ void __rseq_trace_ip_fixup(unsigned long
 }
 #endif /* CONFIG_TRACEPOINTS */
 
+#ifdef CONFIG_DEBUG_FS
 #ifdef CONFIG_RSEQ_STATS
 DEFINE_PER_CPU(struct rseq_stats, rseq_stats);
 
-static int rseq_debug_show(struct seq_file *m, void *p)
+static int rseq_stats_show(struct seq_file *m, void *p)
 {
 	struct rseq_stats stats = { };
 	unsigned int cpu;
@@ -140,14 +162,56 @@ static int rseq_debug_show(struct seq_fi
 	return 0;
 }
 
+static int rseq_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rseq_stats_show, inode->i_private);
+}
+
+static const struct file_operations stat_ops = {
+	.open		= rseq_stats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init rseq_stats_init(struct dentry *root_dir)
+{
+	debugfs_create_file("stats", 0444, root_dir, NULL, &stat_ops);
+	return 0;
+}
+#else
+static inline void rseq_stats_init(struct dentry *root_dir) { }
+#endif /* CONFIG_RSEQ_STATS */
+
+static int rseq_debug_show(struct seq_file *m, void *p)
+{
+	bool on = static_branch_unlikely(&rseq_debug_enabled);
+
+	seq_printf(m, "%d\n", on);
+	return 0;
+}
+
+static ssize_t rseq_debug_write(struct file *file, const char __user *ubuf,
+			    size_t count, loff_t *ppos)
+{
+	bool on;
+
+	if (kstrtobool_from_user(ubuf, count, &on))
+		return -EINVAL;
+
+	rseq_control_debug(on);
+	return count;
+}
+
 static int rseq_debug_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, rseq_debug_show, inode->i_private);
 }
 
-static const struct file_operations dfs_ops = {
+static const struct file_operations debug_ops = {
 	.open		= rseq_debug_open,
 	.read		= seq_read,
+	.write		= rseq_debug_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -156,11 +220,12 @@ static int __init rseq_debugfs_init(void
 {
 	struct dentry *root_dir = debugfs_create_dir("rseq", NULL);
 
-	debugfs_create_file("stats", 0444, root_dir, NULL, &dfs_ops);
+	debugfs_create_file("debug", 0644, root_dir, NULL, &debug_ops);
+	rseq_stats_init(root_dir);
 	return 0;
 }
 __initcall(rseq_debugfs_init);
-#endif /* CONFIG_RSEQ_STATS */
+#endif /* CONFIG_DEBUG_FS */
 
 #ifdef CONFIG_DEBUG_RSEQ
 static struct rseq *rseq_kernel_fields(struct task_struct *t)


