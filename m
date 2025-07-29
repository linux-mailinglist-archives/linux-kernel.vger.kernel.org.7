Return-Path: <linux-kernel+bounces-748792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1CB1460C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D50C1AA2396
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EBA21CC4F;
	Tue, 29 Jul 2025 01:57:03 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E32C20D4F9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753754223; cv=none; b=KaUvT+6Z4hZDm34IlhDMvLEIarUKLcAKfQYQmtVZNJiXIb7PAojgwsDu+qPzma5w5vI6xREtrQy/FUceuuFYDV9lJvxMUPgPmpFse4giTCesgO+jhHV3mkSfFMYA2qTkz7Y97S6hvong5dV+njIp8aQB7AjPrXvMmKbr4KW0Iys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753754223; c=relaxed/simple;
	bh=S2dp6VqOie9sg3fYjhJ7ODDxMofcBytstkPUzG4BN3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W00JAo5YwgaAKQGjncOs0ZqoEq++vWrzEaXiTjmD1O6ODvKKAyXuFGzAc9u9yy9NavFyreHhB1B5tE91KjQJ2fZmx0cJ3BxR55TwiytsGWqOqqCO/zJyKjzqz2S/Y8DzP2cpMbIumZi9k7/wljJxZFu4K3N9U6Pgz6rGxRk+vpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4brdlk5yV2z27j6H;
	Tue, 29 Jul 2025 09:57:54 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B0251402C6;
	Tue, 29 Jul 2025 09:56:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Jul
 2025 09:56:52 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <mark.rutland@arm.com>, <puranjay@kernel.org>,
	<broonie@kernel.org>, <mbenes@suse.cz>, <ryan.roberts@arm.com>,
	<akpm@linux-foundation.org>, <chenl311@chinatelecom.cn>,
	<ada.coupriediaz@arm.com>, <anshuman.khandual@arm.com>,
	<kristina.martsenko@arm.com>, <liaochang1@huawei.com>, <ardb@kernel.org>,
	<leitao@debian.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v7 5/7] arm64: entry: Refactor preempt_schedule_irq() check code
Date: Tue, 29 Jul 2025 09:54:54 +0800
Message-ID: <20250729015456.3411143-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250729015456.3411143-1-ruanjinjie@huawei.com>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

ARM64 requires an additional check whether to reschedule on return
from interrupt. So add arch_irqentry_exit_need_resched() as the default
NOP implementation and hook it up into the need_resched() condition in
raw_irqentry_exit_cond_resched(). This allows ARM64 to implement
the architecture specific version for switching over to
the generic entry code.

To align the structure of the code with irqentry_exit_cond_resched()
from the generic entry code, hoist the need_irq_preemption()
and IS_ENABLED() check earlier. And different preemption check functions
are defined based on whether dynamic preemption is enabled.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/preempt.h |  4 ++++
 arch/arm64/kernel/entry-common.c | 35 ++++++++++++++++++--------------
 kernel/entry/common.c            | 16 ++++++++++++++-
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 0159b625cc7f..0f0ba250efe8 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -85,6 +85,7 @@ static inline bool should_resched(int preempt_offset)
 void preempt_schedule(void);
 void preempt_schedule_notrace(void);
 
+void raw_irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
 DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
@@ -92,11 +93,14 @@ void dynamic_preempt_schedule(void);
 #define __preempt_schedule()		dynamic_preempt_schedule()
 void dynamic_preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
+void dynamic_irqentry_exit_cond_resched(void);
+#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
 
 #else /* CONFIG_PREEMPT_DYNAMIC */
 
 #define __preempt_schedule()		preempt_schedule()
 #define __preempt_schedule_notrace()	preempt_schedule_notrace()
+#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 #endif /* CONFIG_PREEMPTION */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 7c2299c1ba79..4f92664fd46c 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -285,19 +285,8 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs,
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-#define need_irq_preemption() \
-	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
-#else
-#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
-#endif
-
 static inline bool arm64_preempt_schedule_irq(void)
 {
-	if (!need_irq_preemption())
-		return false;
-
 	/*
 	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
 	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
@@ -672,6 +661,24 @@ static __always_inline void __el1_pnmi(struct pt_regs *regs,
 	arm64_exit_nmi(regs, state);
 }
 
+void raw_irqentry_exit_cond_resched(void)
+{
+	if (!preempt_count()) {
+		if (need_resched() && arm64_preempt_schedule_irq())
+			preempt_schedule_irq();
+	}
+}
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
 static __always_inline void __el1_irq(struct pt_regs *regs,
 				      void (*handler)(struct pt_regs *))
 {
@@ -681,10 +688,8 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	if (!preempt_count() && need_resched()) {
-		if (arm64_preempt_schedule_irq())
-			preempt_schedule_irq();
-	}
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		irqentry_exit_cond_resched();
 
 	exit_to_kernel_mode(regs, state);
 }
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index b82032777310..4aa9656fa1b4 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -142,6 +142,20 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return ret;
 }
 
+/**
+ * arch_irqentry_exit_need_resched - Architecture specific need resched function
+ *
+ * Invoked from raw_irqentry_exit_cond_resched() to check if need resched.
+ * Defaults return true.
+ *
+ * The main purpose is to permit arch to skip preempt a task from an IRQ.
+ */
+static inline bool arch_irqentry_exit_need_resched(void);
+
+#ifndef arch_irqentry_exit_need_resched
+static inline bool arch_irqentry_exit_need_resched(void) { return true; }
+#endif
+
 void raw_irqentry_exit_cond_resched(void)
 {
 	if (!preempt_count()) {
@@ -149,7 +163,7 @@ void raw_irqentry_exit_cond_resched(void)
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
+		if (need_resched() && arch_irqentry_exit_need_resched())
 			preempt_schedule_irq();
 	}
 }
-- 
2.34.1


