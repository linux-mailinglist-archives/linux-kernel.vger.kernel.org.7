Return-Path: <linux-kernel+bounces-770075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EAAB27686
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7D85654C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624E2BDC0C;
	Fri, 15 Aug 2025 03:06:53 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7026AF3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227212; cv=none; b=scPHu/mOHs0dHQFwPcXgnwsRZPjPOzPs8XH5XB0sYU7HEctFfZhd3NshVWZ8Kfss13xYQPQ1rtzAPkfHaFIb7EQC/+6m5xCtnz3s9sO9EBci8vEVRDBepoB8Y7GNr9vzbno/8Rzj6LG9XsuBxGE7Z9pnUDQNEG6avMCZKOB4sig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227212; c=relaxed/simple;
	bh=d+Y/t8/rwu86V9ylNmbJ4Dwd0tvmivGPRAgFJBoGb90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8PZY9D2LXXXfejbgsPBkf9xRh8XFdZo5T/oKBM8l2gkGnLdvXw2CM0YnTU/JbfNPeRtAjuiDoa8OZB9gyt0/mkzw9o7XZQV6EB/pdaV7dXAKXdtJwODNAB1kuLQh5dKU7qwHS2cKpYC8FTKLMm6GVTewNFdufJ9Bix4Q+9NJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c36QG3WRSz2Dc0p;
	Fri, 15 Aug 2025 11:04:06 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B7EE14011F;
	Fri, 15 Aug 2025 11:06:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 11:06:47 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<mbenes@suse.cz>, <broonie@kernel.org>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <chenl311@chinatelecom.cn>, <liaochang1@huawei.com>,
	<kristina.martsenko@arm.com>, <leitao@debian.org>, <ardb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v8 4/8] arm64: entry: Use preempt_count() and need_resched() helper
Date: Fri, 15 Aug 2025 11:06:29 +0800
Message-ID: <20250815030633.448613-5-ruanjinjie@huawei.com>
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

The generic entry code uses preempt_count() and need_resched() helpers to
check if it should do preempt_schedule_irq(). Currently, arm64 use its own
check logic, that is "READ_ONCE(current_thread_info()->preempt_count == 0",
which is equivalent to "preempt_count() == 0 && need_resched()".

In preparation for moving arm64 over to the generic entry code, use
these helpers to replace arm64's own code and move it ahead.

No functional changes.

Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/entry-common.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index dd7903f371ad..1ba1d40fa6a7 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -299,14 +299,6 @@ static inline bool arm64_preempt_schedule_irq(void)
 	if (!need_irq_preemption())
 		return false;
 
-	/*
-	 * Note: thread_info::preempt_count includes both thread_info::count
-	 * and thread_info::need_resched, and is not equivalent to
-	 * preempt_count().
-	 */
-	if (READ_ONCE(current_thread_info()->preempt_count) != 0)
-		return false;
-
 	/*
 	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
 	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
@@ -701,8 +693,10 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	if (arm64_preempt_schedule_irq())
-		preempt_schedule_irq();
+	if (!preempt_count() && need_resched()) {
+		if (arm64_preempt_schedule_irq())
+			preempt_schedule_irq();
+	}
 
 	exit_to_kernel_mode(regs, state);
 }
-- 
2.34.1


