Return-Path: <linux-kernel+bounces-748788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ECBB14606
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD6B543565
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E77202C43;
	Tue, 29 Jul 2025 01:56:55 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CD1F4CA4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753754215; cv=none; b=sKjlx4ujS1Rb6kptAtfTFWWpJ+E3VnSdZbN1Pa+vf6+Q4f3S/8pSytwd6q855yd9rMmVkKmv0Puf5525ilnBBqbsSCVt7tBOY8jg3nw5eOuiUlZez0Z3ztHLqvLvk/xFVaO+9MznGNDlj9fdq/SUxw7ASf9s9Gl7V3vIeOEUaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753754215; c=relaxed/simple;
	bh=OT/e09o3b79Pz8f3uvR5/FhH/3WjguZRk8uPBPth0bA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRUknA1E6L8UiqhHWJBAHzSLkkVx3kf+Ad871FYF4G/u/uUkt5zpCJ5o8l77Nxzr3ju41Fx5Nry3yXUQC75WjNBIfymBIDALi5iqEUXaigG3WhegyFqMOY+YLch2l2LVJz+pm1PraD0VlGzTLIsngWMwIg3+mwatC/cA7s/Gtjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4brdct5PLXz14M25;
	Tue, 29 Jul 2025 09:51:58 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 415C0180417;
	Tue, 29 Jul 2025 09:56:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Jul
 2025 09:56:50 +0800
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
Subject: [PATCH -next v7 3/7] arm64: entry: Rework arm64_preempt_schedule_irq()
Date: Tue, 29 Jul 2025 09:54:52 +0800
Message-ID: <20250729015456.3411143-4-ruanjinjie@huawei.com>
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

The generic entry code has the form:

| raw_irqentry_exit_cond_resched()
| {
| 	if (!preempt_count()) {
| 		...
| 		if (need_resched())
| 			preempt_schedule_irq();
| 	}
| }

In preparation for moving arm64 over to the generic entry code, align
the structure of the arm64 code with raw_irqentry_exit_cond_resched() from
the generic entry code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/entry-common.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 97e0741abde1..21a7d8bea814 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -293,10 +293,10 @@ DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 #define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
 #endif
 
-static void __sched arm64_preempt_schedule_irq(void)
+static inline bool arm64_preempt_schedule_irq(void)
 {
 	if (!need_irq_preemption())
-		return;
+		return false;
 
 	/*
 	 * Note: thread_info::preempt_count includes both thread_info::count
@@ -304,7 +304,7 @@ static void __sched arm64_preempt_schedule_irq(void)
 	 * preempt_count().
 	 */
 	if (READ_ONCE(current_thread_info()->preempt_count) != 0)
-		return;
+		return false;
 
 	/*
 	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
@@ -313,7 +313,7 @@ static void __sched arm64_preempt_schedule_irq(void)
 	 * DAIF we must have handled an NMI, so skip preemption.
 	 */
 	if (system_uses_irq_prio_masking() && read_sysreg(daif))
-		return;
+		return false;
 
 	/*
 	 * Preempting a task from an IRQ means we leave copies of PSTATE
@@ -323,8 +323,10 @@ static void __sched arm64_preempt_schedule_irq(void)
 	 * Only allow a task to be preempted once cpufeatures have been
 	 * enabled.
 	 */
-	if (system_capabilities_finalized())
-		preempt_schedule_irq();
+	if (!system_capabilities_finalized())
+		return false;
+
+	return true;
 }
 
 static void do_interrupt_handler(struct pt_regs *regs,
@@ -687,7 +689,8 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	arm64_preempt_schedule_irq();
+	if (arm64_preempt_schedule_irq())
+		preempt_schedule_irq();
 
 	exit_to_kernel_mode(regs, state);
 }
-- 
2.34.1


