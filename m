Return-Path: <linux-kernel+bounces-770076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAD4B27689
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AB6586612
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BED2BDC0F;
	Fri, 15 Aug 2025 03:06:55 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BBB29B77E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227214; cv=none; b=QLe8O3GNqVecS02yDpDnooi2e1UeIqCm3jBLJ8hnUE2Gb+kQds9iev96/jTQcnb1ZQ4gs2GvZwfsdQMyVNdy4h7V8hpGCcQG4Ok/cFRBsZIYDvPpd0ll9FhYmjjTLSBzejLZa2YFuctyHdStJO6Ledl+sAS+erDGq8z/f/knoms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227214; c=relaxed/simple;
	bh=++haSybjnT9CEwRd3E3c2X/q9QTN1aQs7FrTNNkFIxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZ3jnsreF7JPPkco83UATopS75vW2K2ccwVYQFLFgrbUdaC9WjtyMSN1fE8s9oThFOpQcFcvQo74I0r7Rw95ISb5fjux3G7BijPQ0McWNaMtSQMB8cLwFvOVcL7DWuIno1yMmul2A7w82oIU/lnQNyo8WCWgtAdUx0yElorDhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c36Q44PGsz2gL5D;
	Fri, 15 Aug 2025 11:03:56 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 1972D1A016C;
	Fri, 15 Aug 2025 11:06:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 11:06:44 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<mbenes@suse.cz>, <broonie@kernel.org>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <chenl311@chinatelecom.cn>, <liaochang1@huawei.com>,
	<kristina.martsenko@arm.com>, <leitao@debian.org>, <ardb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v8 2/8] arm64: entry: Refactor the entry and exit for exceptions from EL1
Date: Fri, 15 Aug 2025 11:06:27 +0800
Message-ID: <20250815030633.448613-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815030633.448613-1-ruanjinjie@huawei.com>
References: <20250815030633.448613-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)

The generic entry code uses irqentry_state_t to track lockdep and RCU
state across exception entry and return. For historical reasons, arm64
embeds similar fields within its pt_regs structure.

In preparation for moving arm64 over to the generic entry code, pull
these fields out of arm64's pt_regs, and use a separate structure,
matching the style of the generic entry code.

No functional changes.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/ptrace.h  |   4 -
 arch/arm64/kernel/entry-common.c | 163 ++++++++++++++++++++-----------
 2 files changed, 106 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 8b915d4a9d4b..65b053a24d82 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -169,10 +169,6 @@ struct pt_regs {
 
 	u64 sdei_ttbr1;
 	struct frame_record_meta stackframe;
-
-	/* Only valid for some EL1 exceptions. */
-	u64 lockdep_hardirqs;
-	u64 exit_rcu;
 };
 
 /* For correct stack alignment, pt_regs has to be a multiple of 16 bytes. */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 8e798f46ad28..93c95fc51cc0 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -29,6 +29,13 @@
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
 
+typedef struct irqentry_state {
+	union {
+		bool	exit_rcu;
+		bool	lockdep;
+	};
+} arm64_irqentry_state_t;
+
 /*
  * Handle IRQ/context state management when entering from kernel mode.
  * Before this function is called it is not safe to call regular kernel code,
@@ -37,29 +44,37 @@
  * This is intended to match the logic in irqentry_enter(), handling the kernel
  * mode transitions only.
  */
-static __always_inline void __enter_from_kernel_mode(struct pt_regs *regs)
+static __always_inline arm64_irqentry_state_t __enter_from_kernel_mode(struct pt_regs *regs)
 {
-	regs->exit_rcu = false;
+	arm64_irqentry_state_t state = {
+		.exit_rcu = false,
+	};
 
 	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		ct_irq_enter();
 		trace_hardirqs_off_finish();
 
-		regs->exit_rcu = true;
-		return;
+		state.exit_rcu = true;
+		return state;
 	}
 
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	rcu_irq_enter_check_tick();
 	trace_hardirqs_off_finish();
+
+	return state;
 }
 
-static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
+static noinstr arm64_irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
 {
-	__enter_from_kernel_mode(regs);
+	arm64_irqentry_state_t state;
+
+	state = __enter_from_kernel_mode(regs);
 	mte_check_tfsr_entry();
 	mte_disable_tco_entry(current);
+
+	return state;
 }
 
 /*
@@ -70,12 +85,13 @@ static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
  * This is intended to match the logic in irqentry_exit(), handling the kernel
  * mode transitions only, and with preemption handled elsewhere.
  */
-static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs)
+static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs,
+						  arm64_irqentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
 
 	if (!regs_irqs_disabled(regs)) {
-		if (regs->exit_rcu) {
+		if (state.exit_rcu) {
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare();
 			ct_irq_exit();
@@ -85,15 +101,16 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs)
 
 		trace_hardirqs_on();
 	} else {
-		if (regs->exit_rcu)
+		if (state.exit_rcu)
 			ct_irq_exit();
 	}
 }
 
-static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
+static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
+					arm64_irqentry_state_t state)
 {
 	mte_check_tfsr_exit();
-	__exit_to_kernel_mode(regs);
+	__exit_to_kernel_mode(regs, state);
 }
 
 /*
@@ -194,9 +211,11 @@ asmlinkage void noinstr asm_exit_to_user_mode(struct pt_regs *regs)
  * mode. Before this function is called it is not safe to call regular kernel
  * code, instrumentable code, or any code which may trigger an exception.
  */
-static void noinstr arm64_enter_nmi(struct pt_regs *regs)
+static noinstr arm64_irqentry_state_t arm64_enter_nmi(struct pt_regs *regs)
 {
-	regs->lockdep_hardirqs = lockdep_hardirqs_enabled();
+	arm64_irqentry_state_t state;
+
+	state.lockdep = lockdep_hardirqs_enabled();
 
 	__nmi_enter();
 	lockdep_hardirqs_off(CALLER_ADDR0);
@@ -205,6 +224,8 @@ static void noinstr arm64_enter_nmi(struct pt_regs *regs)
 
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
+
+	return state;
 }
 
 /*
@@ -212,19 +233,18 @@ static void noinstr arm64_enter_nmi(struct pt_regs *regs)
  * mode. After this function returns it is not safe to call regular kernel
  * code, instrumentable code, or any code which may trigger an exception.
  */
-static void noinstr arm64_exit_nmi(struct pt_regs *regs)
+static void noinstr arm64_exit_nmi(struct pt_regs *regs,
+				   arm64_irqentry_state_t state)
 {
-	bool restore = regs->lockdep_hardirqs;
-
 	ftrace_nmi_exit();
-	if (restore) {
+	if (state.lockdep) {
 		trace_hardirqs_on_prepare();
 		lockdep_hardirqs_on_prepare();
 	}
 
 	ct_nmi_exit();
 	lockdep_hardirq_exit();
-	if (restore)
+	if (state.lockdep)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 	__nmi_exit();
 }
@@ -234,14 +254,18 @@ static void noinstr arm64_exit_nmi(struct pt_regs *regs)
  * kernel mode. Before this function is called it is not safe to call regular
  * kernel code, instrumentable code, or any code which may trigger an exception.
  */
-static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs)
+static noinstr arm64_irqentry_state_t arm64_enter_el1_dbg(struct pt_regs *regs)
 {
-	regs->lockdep_hardirqs = lockdep_hardirqs_enabled();
+	arm64_irqentry_state_t state;
+
+	state.lockdep = lockdep_hardirqs_enabled();
 
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	ct_nmi_enter();
 
 	trace_hardirqs_off_finish();
+
+	return state;
 }
 
 /*
@@ -249,17 +273,16 @@ static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs)
  * kernel mode. After this function returns it is not safe to call regular
  * kernel code, instrumentable code, or any code which may trigger an exception.
  */
-static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
+static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs,
+				       arm64_irqentry_state_t state)
 {
-	bool restore = regs->lockdep_hardirqs;
-
-	if (restore) {
+	if (state.lockdep) {
 		trace_hardirqs_on_prepare();
 		lockdep_hardirqs_on_prepare();
 	}
 
 	ct_nmi_exit();
-	if (restore)
+	if (state.lockdep)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
@@ -475,73 +498,87 @@ UNHANDLED(el1t, 64, error)
 static void noinstr el1_abort(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long far = read_sysreg(far_el1);
+	arm64_irqentry_state_t state;
 
-	enter_from_kernel_mode(regs);
+	state = enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
 	do_mem_abort(far, esr, regs);
 	local_daif_mask();
-	exit_to_kernel_mode(regs);
+	exit_to_kernel_mode(regs, state);
 }
 
 static void noinstr el1_pc(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long far = read_sysreg(far_el1);
+	arm64_irqentry_state_t state;
 
-	enter_from_kernel_mode(regs);
+	state = enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
 	do_sp_pc_abort(far, esr, regs);
 	local_daif_mask();
-	exit_to_kernel_mode(regs);
+	exit_to_kernel_mode(regs, state);
 }
 
 static void noinstr el1_undef(struct pt_regs *regs, unsigned long esr)
 {
-	enter_from_kernel_mode(regs);
+	arm64_irqentry_state_t state;
+
+	state = enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
 	do_el1_undef(regs, esr);
 	local_daif_mask();
-	exit_to_kernel_mode(regs);
+	exit_to_kernel_mode(regs, state);
 }
 
 static void noinstr el1_bti(struct pt_regs *regs, unsigned long esr)
 {
-	enter_from_kernel_mode(regs);
+	arm64_irqentry_state_t state;
+
+	state = enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
 	do_el1_bti(regs, esr);
 	local_daif_mask();
-	exit_to_kernel_mode(regs);
+	exit_to_kernel_mode(regs, state);
 }
 
 static void noinstr el1_gcs(struct pt_regs *regs, unsigned long esr)
 {
-	enter_from_kernel_mode(regs);
+	arm64_irqentry_state_t state;
+
+	state = enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
 	do_el1_gcs(regs, esr);
 	local_daif_mask();
-	exit_to_kernel_mode(regs);
+	exit_to_kernel_mode(regs, state);
 }
 
 static void noinstr el1_mops(struct pt_regs *regs, unsigned long esr)
 {
-	enter_from_kernel_mode(regs);
+	arm64_irqentry_state_t state;
+
+	state = enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
 	do_el1_mops(regs, esr);
 	local_daif_mask();
-	exit_to_kernel_mode(regs);
+	exit_to_kernel_mode(regs, state);
 }
 
 static void noinstr el1_breakpt(struct pt_regs *regs, unsigned long esr)
 {
-	arm64_enter_el1_dbg(regs);
+	arm64_irqentry_state_t state;
+
+	state = arm64_enter_el1_dbg(regs);
 	debug_exception_enter(regs);
 	do_breakpoint(esr, regs);
 	debug_exception_exit(regs);
-	arm64_exit_el1_dbg(regs);
+	arm64_exit_el1_dbg(regs, state);
 }
 
 static void noinstr el1_softstp(struct pt_regs *regs, unsigned long esr)
 {
-	arm64_enter_el1_dbg(regs);
+	arm64_irqentry_state_t state;
+
+	state = arm64_enter_el1_dbg(regs);
 	if (!cortex_a76_erratum_1463225_debug_handler(regs)) {
 		debug_exception_enter(regs);
 		/*
@@ -554,37 +591,42 @@ static void noinstr el1_softstp(struct pt_regs *regs, unsigned long esr)
 			do_el1_softstep(esr, regs);
 		debug_exception_exit(regs);
 	}
-	arm64_exit_el1_dbg(regs);
+	arm64_exit_el1_dbg(regs, state);
 }
 
 static void noinstr el1_watchpt(struct pt_regs *regs, unsigned long esr)
 {
 	/* Watchpoints are the only debug exception to write FAR_EL1 */
 	unsigned long far = read_sysreg(far_el1);
+	arm64_irqentry_state_t state;
 
-	arm64_enter_el1_dbg(regs);
+	state = arm64_enter_el1_dbg(regs);
 	debug_exception_enter(regs);
 	do_watchpoint(far, esr, regs);
 	debug_exception_exit(regs);
-	arm64_exit_el1_dbg(regs);
+	arm64_exit_el1_dbg(regs, state);
 }
 
 static void noinstr el1_brk64(struct pt_regs *regs, unsigned long esr)
 {
-	arm64_enter_el1_dbg(regs);
+	arm64_irqentry_state_t state;
+
+	state = arm64_enter_el1_dbg(regs);
 	debug_exception_enter(regs);
 	do_el1_brk64(esr, regs);
 	debug_exception_exit(regs);
-	arm64_exit_el1_dbg(regs);
+	arm64_exit_el1_dbg(regs, state);
 }
 
 static void noinstr el1_fpac(struct pt_regs *regs, unsigned long esr)
 {
-	enter_from_kernel_mode(regs);
+	arm64_irqentry_state_t state;
+
+	state = enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
 	do_el1_fpac(regs, esr);
 	local_daif_mask();
-	exit_to_kernel_mode(regs);
+	exit_to_kernel_mode(regs, state);
 }
 
 asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
@@ -639,15 +681,19 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
 static __always_inline void __el1_pnmi(struct pt_regs *regs,
 				       void (*handler)(struct pt_regs *))
 {
-	arm64_enter_nmi(regs);
+	arm64_irqentry_state_t state;
+
+	state = arm64_enter_nmi(regs);
 	do_interrupt_handler(regs, handler);
-	arm64_exit_nmi(regs);
+	arm64_exit_nmi(regs, state);
 }
 
 static __always_inline void __el1_irq(struct pt_regs *regs,
 				      void (*handler)(struct pt_regs *))
 {
-	enter_from_kernel_mode(regs);
+	arm64_irqentry_state_t state;
+
+	state = enter_from_kernel_mode(regs);
 
 	irq_enter_rcu();
 	do_interrupt_handler(regs, handler);
@@ -655,7 +701,7 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 
 	arm64_preempt_schedule_irq();
 
-	exit_to_kernel_mode(regs);
+	exit_to_kernel_mode(regs, state);
 }
 static void noinstr el1_interrupt(struct pt_regs *regs,
 				  void (*handler)(struct pt_regs *))
@@ -681,11 +727,12 @@ asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
 asmlinkage void noinstr el1h_64_error_handler(struct pt_regs *regs)
 {
 	unsigned long esr = read_sysreg(esr_el1);
+	arm64_irqentry_state_t state;
 
 	local_daif_restore(DAIF_ERRCTX);
-	arm64_enter_nmi(regs);
+	state = arm64_enter_nmi(regs);
 	do_serror(regs, esr);
-	arm64_exit_nmi(regs);
+	arm64_exit_nmi(regs, state);
 }
 
 static void noinstr el0_da(struct pt_regs *regs, unsigned long esr)
@@ -997,12 +1044,13 @@ asmlinkage void noinstr el0t_64_fiq_handler(struct pt_regs *regs)
 static void noinstr __el0_error_handler_common(struct pt_regs *regs)
 {
 	unsigned long esr = read_sysreg(esr_el1);
+	arm64_irqentry_state_t state;
 
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_ERRCTX);
-	arm64_enter_nmi(regs);
+	state = arm64_enter_nmi(regs);
 	do_serror(regs, esr);
-	arm64_exit_nmi(regs);
+	arm64_exit_nmi(regs, state);
 	local_daif_restore(DAIF_PROCCTX);
 	exit_to_user_mode(regs);
 }
@@ -1122,6 +1170,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
+	arm64_irqentry_state_t state;
 	unsigned long ret;
 
 	/*
@@ -1146,9 +1195,9 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 	else if (cpu_has_pan())
 		set_pstate_pan(0);
 
-	arm64_enter_nmi(regs);
+	state = arm64_enter_nmi(regs);
 	ret = do_sdei_event(regs, arg);
-	arm64_exit_nmi(regs);
+	arm64_exit_nmi(regs, state);
 
 	return ret;
 }
-- 
2.34.1


