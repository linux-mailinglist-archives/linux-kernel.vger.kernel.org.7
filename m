Return-Path: <linux-kernel+bounces-770074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62463B27676
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CEF7A7E92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22F529B8FE;
	Fri, 15 Aug 2025 03:06:51 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3C291C2D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227211; cv=none; b=OD2+0sdZpOs/fIKfICSxMuDor0VWZupoRUWPKdAu0cuwxFGx4wYCXT64g5co9Gyv8dharAxpsr8ULru4pZ969KuCAHUQqVzgqPErAQUNLt3PGgqLH7vl4x9od1vOegJIDhgtuyDVi1/1kDuePdDc5R7eAoRUf6tEtgCjGyd4yoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227211; c=relaxed/simple;
	bh=NlT78VCHUWVIJ1b3qqE0dT/Xg0HOyszNbX8UfBdO+Wc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoKuw6Uw5+X64j7RFWUFT19UGznjhcga7t6Vkj7O8HGfJjtqGiyDTylT11N+oSkqWGw9zAFHZT40Gtg4tferHYPgyJmRRRua5lNYer4o4QC/uFL+NS/bDI9JwTaXM4xruD/MKMdwkjvIU6KgDPgJEGQXx119JNGdTxDzlUW6j9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c36VY1xNyz2dMNB;
	Fri, 15 Aug 2025 11:07:49 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id DD9C81800B2;
	Fri, 15 Aug 2025 11:06:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 11:06:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<mbenes@suse.cz>, <broonie@kernel.org>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <chenl311@chinatelecom.cn>, <liaochang1@huawei.com>,
	<kristina.martsenko@arm.com>, <leitao@debian.org>, <ardb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v8 1/8] arm64: ptrace: Replace interrupts_enabled() with regs_irqs_disabled()
Date: Fri, 15 Aug 2025 11:06:26 +0800
Message-ID: <20250815030633.448613-2-ruanjinjie@huawei.com>
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

The generic entry code expects architecture code to provide
regs_irqs_disabled(regs) function, but arm64 does not have this and
provides interrupts_enabled(regs), which has the opposite polarity.

In preparation for moving arm64 over to the generic entry code,
relace arm64's interrupts_enabled() with regs_irqs_disabled() and
update its callers under arch/arm64.

For the moment, a definition of interrupts_enabled() is provided for
the GICv3 driver. Once arch/arm implement regs_irqs_disabled(), this
can be removed.

Delete the fast_interrupts_enabled() macro as it is unused and we
don't want any new users to show up.

No functional changes.

Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/daifflags.h  | 2 +-
 arch/arm64/include/asm/ptrace.h     | 9 +++++----
 arch/arm64/include/asm/xen/events.h | 2 +-
 arch/arm64/kernel/acpi.c            | 2 +-
 arch/arm64/kernel/debug-monitors.c  | 2 +-
 arch/arm64/kernel/entry-common.c    | 4 ++--
 arch/arm64/kernel/sdei.c            | 2 +-
 7 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index fbb5c99eb2f9..5fca48009043 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -128,7 +128,7 @@ static inline void local_daif_inherit(struct pt_regs *regs)
 {
 	unsigned long flags = regs->pstate & DAIF_MASK;
 
-	if (interrupts_enabled(regs))
+	if (!regs_irqs_disabled(regs))
 		trace_hardirqs_on();
 
 	if (system_uses_irq_prio_masking())
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 47ff8654c5ec..8b915d4a9d4b 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -214,11 +214,12 @@ static inline void forget_syscall(struct pt_regs *regs)
 		(regs)->pmr == GIC_PRIO_IRQON :				\
 		true)
 
-#define interrupts_enabled(regs)			\
-	(!((regs)->pstate & PSR_I_BIT) && irqs_priority_unmasked(regs))
+static __always_inline bool regs_irqs_disabled(const struct pt_regs *regs)
+{
+	return (regs->pstate & PSR_I_BIT) || !irqs_priority_unmasked(regs);
+}
 
-#define fast_interrupts_enabled(regs) \
-	(!((regs)->pstate & PSR_F_BIT))
+#define interrupts_enabled(regs)	(!regs_irqs_disabled(regs))
 
 static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {
diff --git a/arch/arm64/include/asm/xen/events.h b/arch/arm64/include/asm/xen/events.h
index 2788e95d0ff0..2977b5fe068d 100644
--- a/arch/arm64/include/asm/xen/events.h
+++ b/arch/arm64/include/asm/xen/events.h
@@ -14,7 +14,7 @@ enum ipi_vector {
 
 static inline int xen_irqs_disabled(struct pt_regs *regs)
 {
-	return !interrupts_enabled(regs);
+	return regs_irqs_disabled(regs);
 }
 
 #define xchg_xen_ulong(ptr, val) xchg((ptr), (val))
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 4d529ff7ba51..3fbce0a9a0fe 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -407,7 +407,7 @@ int apei_claim_sea(struct pt_regs *regs)
 	return_to_irqs_enabled = !irqs_disabled_flags(arch_local_save_flags());
 
 	if (regs)
-		return_to_irqs_enabled = interrupts_enabled(regs);
+		return_to_irqs_enabled = !regs_irqs_disabled(regs);
 
 	/*
 	 * SEA can interrupt SError, mask it and describe this as an NMI so
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 110d9ff54174..85fc162a6f9b 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -167,7 +167,7 @@ static void send_user_sigtrap(int si_code)
 	if (WARN_ON(!user_mode(regs)))
 		return;
 
-	if (interrupts_enabled(regs))
+	if (!regs_irqs_disabled(regs))
 		local_irq_enable();
 
 	arm64_force_sig_fault(SIGTRAP, si_code, instruction_pointer(regs),
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 2b0c5925502e..8e798f46ad28 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -74,7 +74,7 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs)
 {
 	lockdep_assert_irqs_disabled();
 
-	if (interrupts_enabled(regs)) {
+	if (!regs_irqs_disabled(regs)) {
 		if (regs->exit_rcu) {
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare();
@@ -662,7 +662,7 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
 {
 	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
 
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && regs_irqs_disabled(regs))
 		__el1_pnmi(regs, handler);
 	else
 		__el1_irq(regs, handler);
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 6f24a0251e18..95169f7b6531 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -243,7 +243,7 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	 * If we interrupted the kernel with interrupts masked, we always go
 	 * back to wherever we came from.
 	 */
-	if (mode == kernel_mode && !interrupts_enabled(regs))
+	if (mode == kernel_mode && regs_irqs_disabled(regs))
 		return SDEI_EV_HANDLED;
 
 	/*
-- 
2.34.1


