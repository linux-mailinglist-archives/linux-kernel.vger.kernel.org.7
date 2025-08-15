Return-Path: <linux-kernel+bounces-770080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B87FFB27688
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BFA67AE18B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA112BE7BC;
	Fri, 15 Aug 2025 03:06:56 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9693291C2D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227215; cv=none; b=r1iJILvNqwxGniMDEKN6C+bOHkMARXL3epB+Q+dfaUZi2siyD5pBCXhQwcjil2Fm3/2AJCWcdvUBPyyA73rQ4lOtgCSkRQNB+wSUK1FM0gk7n+LKK7vvAz//j09DDsHDEBWxpfdPBQPXV/ZjfM6LiLEShU6GVC9ZAEI0z7SCTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227215; c=relaxed/simple;
	bh=I1dM53mpj3OHWsBTRgxxnisXRxuEdjbIlITZORyLXIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OR//B0NXdHhMSaoNAQrTEy9/eGwzsnqIqxkDjZVXVzO/HQkqNn9t+rts/jD+9oyhO7VjvyWcCCFGZ8ez66i4jIiYdJ5ycROFTnJpKNUTKf1UpfG45PIkNtsip7vUqhC1sT2A78SYc4+/rDcFTfxhR+KTbdrD17lncPUBVa4HZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c36TQ3hG2zvX5h;
	Fri, 15 Aug 2025 11:06:50 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id EA1BB1402D0;
	Fri, 15 Aug 2025 11:06:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 11:06:50 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<mbenes@suse.cz>, <broonie@kernel.org>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <chenl311@chinatelecom.cn>, <liaochang1@huawei.com>,
	<kristina.martsenko@arm.com>, <leitao@debian.org>, <ardb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v8 7/8] arm64: entry: Move arm64_preempt_schedule_irq() into __exit_to_kernel_mode()
Date: Fri, 15 Aug 2025 11:06:32 +0800
Message-ID: <20250815030633.448613-8-ruanjinjie@huawei.com>
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

The arm64 entry code only preempts a kernel context upon a return from
a regular IRQ exception. The generic entry code may preempt a kernel
context for any exception return where irqentry_exit() is used, and so
may preempt other exceptions such as faults.

In preparation for moving arm64 over to the generic entry code, align
arm64 with the generic behaviour by calling
arm64_preempt_schedule_irq() from exit_to_kernel_mode(). To make this
possible, arm64_preempt_schedule_irq()
and dynamic/raw_irqentry_exit_cond_resched() are moved earlier in
the file, with no changes.

As Mark pointed out, this change will have the following 2 key impact:

- " We'll preempt even without taking a "real" interrupt. That
    shouldn't result in preemption that wasn't possible before,
    but it does change the probability of preempting at certain points,
    and might have a performance impact, so probably warrants a
    benchmark."

- " We will not preempt when taking interrupts from a region of kernel
    code where IRQs are enabled but RCU is not watching, matching the
    behaviour of the generic entry code.

    This has the potential to introduce livelock if we can ever have a
    screaming interrupt in such a region, so we'll need to go figure out
    whether that's actually a problem.

    Having this as a separate patch will make it easier to test/bisect
    for that specifically."

Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/entry-common.c | 96 ++++++++++++++++----------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 64066c643f97..f52067d17baf 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -77,6 +77,51 @@ static noinstr arm64_irqentry_state_t enter_from_kernel_mode(struct pt_regs *reg
 	return state;
 }
 
+static inline bool arm64_preempt_schedule_irq(void)
+{
+	/*
+	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
+	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
+	 * using gic_arch_enable_irqs() for normal IRQs. If anything is set in
+	 * DAIF we must have handled an NMI, so skip preemption.
+	 */
+	if (system_uses_irq_prio_masking() && read_sysreg(daif))
+		return false;
+
+	/*
+	 * Preempting a task from an IRQ means we leave copies of PSTATE
+	 * on the stack. cpufeature's enable calls may modify PSTATE, but
+	 * resuming one of these preempted tasks would undo those changes.
+	 *
+	 * Only allow a task to be preempted once cpufeatures have been
+	 * enabled.
+	 */
+	if (!system_capabilities_finalized())
+		return false;
+
+	return true;
+}
+
+#ifdef CONFIG_PREEMPTION
+void raw_irqentry_exit_cond_resched(void)
+{
+	if (!preempt_count()) {
+		if (need_resched() && arm64_preempt_schedule_irq())
+			preempt_schedule_irq();
+	}
+}
+#endif
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_irqentry_exit_cond_resched(void)
+{
+	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+		return;
+	raw_irqentry_exit_cond_resched();
+}
+#endif
+
 /*
  * Handle IRQ/context state management when exiting to kernel mode.
  * After this function returns it is not safe to call regular kernel code,
@@ -99,6 +144,9 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs,
 			return;
 		}
 
+		if (IS_ENABLED(CONFIG_PREEMPTION))
+			irqentry_exit_cond_resched();
+
 		trace_hardirqs_on();
 	} else {
 		if (state.exit_rcu)
@@ -286,31 +334,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs,
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-static inline bool arm64_preempt_schedule_irq(void)
-{
-	/*
-	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
-	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
-	 * using gic_arch_enable_irqs() for normal IRQs. If anything is set in
-	 * DAIF we must have handled an NMI, so skip preemption.
-	 */
-	if (system_uses_irq_prio_masking() && read_sysreg(daif))
-		return false;
-
-	/*
-	 * Preempting a task from an IRQ means we leave copies of PSTATE
-	 * on the stack. cpufeature's enable calls may modify PSTATE, but
-	 * resuming one of these preempted tasks would undo those changes.
-	 *
-	 * Only allow a task to be preempted once cpufeatures have been
-	 * enabled.
-	 */
-	if (!system_capabilities_finalized())
-		return false;
-
-	return true;
-}
-
 static void do_interrupt_handler(struct pt_regs *regs,
 				 void (*handler)(struct pt_regs *))
 {
@@ -671,26 +694,6 @@ static __always_inline void __el1_pnmi(struct pt_regs *regs,
 	arm64_exit_nmi(regs, state);
 }
 
-#ifdef CONFIG_PREEMPTION
-void raw_irqentry_exit_cond_resched(void)
-{
-	if (!preempt_count()) {
-		if (need_resched() && arm64_preempt_schedule_irq())
-			preempt_schedule_irq();
-	}
-}
-#endif
-
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-void dynamic_irqentry_exit_cond_resched(void)
-{
-	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
-		return;
-	raw_irqentry_exit_cond_resched();
-}
-#endif
-
 static __always_inline void __el1_irq(struct pt_regs *regs,
 				      void (*handler)(struct pt_regs *))
 {
@@ -702,9 +705,6 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		irqentry_exit_cond_resched();
-
 	exit_to_kernel_mode(regs, state);
 }
 static void noinstr el1_interrupt(struct pt_regs *regs,
-- 
2.34.1


