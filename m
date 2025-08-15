Return-Path: <linux-kernel+bounces-770077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE777B2767A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEF474E5A17
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFCA2BE02F;
	Fri, 15 Aug 2025 03:06:55 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC72BD5B0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227215; cv=none; b=R5OgHefdIZjp1MjEoR2tyjDPX66bCZ3V6F9dZdBOY/x3Op1TF8HmWB/ZFs/Rsc+Lwp3A7DCwkM86gxw1ZSIyGnOHotWJDIAktuJoGeSlhBcnxRND9ZXvzvVpk+DpBlEuxohgYIrCGP3y1kUHBOs+3b2Ig7aQptasUdmcoP+v50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227215; c=relaxed/simple;
	bh=IImRNevVOJwbHuukaimEp58wNHcGJcFeRWa4hGJ0tZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mwf3tI/bew5twKGlYd2ZJFf+V1xntmOKaxFf4vdaC7TvQdVfkFHuu7t2+gNdAyyl9aFbr5i6N695wyxofOf9mQlybfpWggppNifljEgF23z4Zqgk5qt89cjbWfKZ/gS2ivXcRY0tMy1Xvf6ti/hDBeKnRs7zJb9XfNY4xmGMUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c36NP1Z3Kz2CgB4;
	Fri, 15 Aug 2025 11:02:29 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B54814011F;
	Fri, 15 Aug 2025 11:06:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 11:06:48 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<mbenes@suse.cz>, <broonie@kernel.org>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <chenl311@chinatelecom.cn>, <liaochang1@huawei.com>,
	<kristina.martsenko@arm.com>, <leitao@debian.org>, <ardb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v8 5/8] entry: Add arch_irqentry_exit_need_resched() for arm64
Date: Fri, 15 Aug 2025 11:06:30 +0800
Message-ID: <20250815030633.448613-6-ruanjinjie@huawei.com>
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

Compared to the generic entry code, ARM64 does additional checks
when deciding to reschedule on return from interrupt. So introduce
arch_irqentry_exit_need_resched() in the need_resched()
condition of the generic raw_irqentry_exit_cond_resched(), with
a NOP default. This will allow ARM64 to implement the architecture
specific version for switching over to the generic entry code.

Suggested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/entry/common.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 408d28b5179d..f62e1d1b2063 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -143,6 +143,20 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return ret;
 }
 
+/**
+ * arch_irqentry_exit_need_resched - Architecture specific need resched function
+ *
+ * Invoked from raw_irqentry_exit_cond_resched() to check if resched is needed.
+ * Defaults return true.
+ *
+ * The main purpose is to permit arch to avoid preemption of a task from an IRQ.
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
@@ -150,7 +164,7 @@ void raw_irqentry_exit_cond_resched(void)
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


