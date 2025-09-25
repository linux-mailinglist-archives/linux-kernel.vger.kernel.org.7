Return-Path: <linux-kernel+bounces-831657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5B2B9D420
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33357A6C35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9012E6CA6;
	Thu, 25 Sep 2025 02:57:55 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045722E610B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758769074; cv=none; b=mTbqJK6WU7DVnJYgFp9VbUV5lQoUvYjN9L8u4mFKRcjrpgGKArW54KjK9yBZgPy9wFdXE6uJmfBt+CGP8QaPQyls/CW0FLRnQ9+RljCvS6FRyrLOFVTbSDZ4SKDGnlNjUsSeaPQsHnRKhhNLR1khfN6GxEIfC4hKwKjYdpxyy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758769074; c=relaxed/simple;
	bh=6kI/lS5rmytjtr3jluFARwVstPHJPlePhth6xsfFXc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iCAubybNSoemMZFmy1mPU2kwuHkF30qQC1hc/MV3QqyBj11MCrZNPhCxheML4DYaA9tdFz+pAUNgbJKN6YL2N6KU6zFhaWVoxk4YJhEDRHx8wKXK2kmEk0/8ktnauJeTDe4XzuAPdyuuu3cJyYhq8dY4K+1t48FFxl7dUXfd4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cXJMS5NVSz27j4X;
	Thu, 25 Sep 2025 10:59:00 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 2200218005F;
	Thu, 25 Sep 2025 10:57:49 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.108.232) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 10:57:48 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <rmk+kernel@armlinux.org.uk>, <linux@armlinux.org.uk>, <rppt@kernel.org>,
	<vbabka@suse.cz>, <pfalcato@suse.de>, <brauner@kernel.org>,
	<lorenzo.stoakes@oracle.com>, <kuninori.morimoto.gx@renesas.com>,
	<tony@atomide.com>, <arnd@arndb.de>, <bigeasy@linutronix.de>,
	<akpm@linux-foundation.org>, <punitagrawal@gmail.com>, <rjw@rjwysocki.net>,
	<marc.zyngier@arm.com>
CC: <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <xieyuanbin1@huawei.com>
Subject: [PATCH v2 1/2] ARM: spectre-v2: Fix potential missing mitigations
Date: Thu, 25 Sep 2025 10:57:43 +0800
Message-ID: <20250925025744.6807-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

For the latest kernel, with arm's multi_v7_defconfig, and set
CONFIG_PREEMPT=y, CONFIG_DEBUG_PREEMPT=y, CONFIG_ARM_LPAE=y,
if a user program try to accesses any valid kernel address, for example:
```c
static void han(int x)
{
	while (1);
}

int main(void)
{
	signal(SIGSEGV, han);
	/* 0xc0331fd4 is just a kernel address in kernel .text section */
	__asm__ volatile (""::"r"(*(int *)(uintptr_t)0xc0331fd4):"memory");
	while (1);
	return 0;
}
```
, the following WARN will be triggered:

[    1.089103] BUG: using smp_processor_id() in preemptible [00000000] code: init/1
[    1.093367] caller is __do_user_fault+0x20/0x6c
[    1.094355] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.14.3 #7
[    1.094585] Hardware name: Generic DT based system
[    1.094706] Call trace:
[    1.095211]  unwind_backtrace from show_stack+0x10/0x14
[    1.095329]  show_stack from dump_stack_lvl+0x50/0x5c
[    1.095352]  dump_stack_lvl from check_preemption_disabled+0x104/0x108
[    1.095448]  check_preemption_disabled from __do_user_fault+0x20/0x6c
[    1.095459]  __do_user_fault from do_page_fault+0x334/0x3dc
[    1.095505]  do_page_fault from do_DataAbort+0x30/0xa8
[    1.095528]  do_DataAbort from __dabt_usr+0x54/0x60
[    1.095570] Exception stack(0xf0825fb0 to 0xf0825ff8)

This WARN indicates that the current CPU is not stable, which means that
current can be migrated to other CPUs.
Therefore, in some scenarios, mitigation measures may be missed, such as:
1. Thread A attacks on cpu0 and triggers do_page_fault
2. Thread A migrates to cpu1 before bp_hardening
3. Thread A do bp_hardening on cpu1
4. Thread A migrates to cpu0
5. Thread A ret_to_user on cpu0

Assuming that all of the context_stwitch() mentioned above does not
trigger switch_mm(), therefore all of the context_stwitch() does not
trigger mitigation. Thread A successfully bypassed the mitigation on cpu0.

Over the past six years, there have been continuous reports of this bug:
2025.4.24 https://lore.kernel.org/all/20250424100437.27477-1-xieyuanbin1@huawei.com/
2022.6.22 https://lore.kernel.org/all/795c9463-452e-bf64-1cc0-c318ccecb1da@I-love.SAKURA.ne.jp/
2021.3.25 https://lore.kernel.org/all/20210325095049.6948-1-liu.xiang@zlingsmart.com/
2021.3.12 https://lore.kernel.org/all/20210312041246.15113-1-qiang.zhang@windriver.com/
2021.3.11 https://lore.kernel.org/all/0000000000007604cb05bd3e6968@google.com/
2019.5.27 https://lore.kernel.org/all/1558949979-129251-1-git-send-email-gaoyongliang@huawei.com/
2019.3.19 https://lore.kernel.org/all/20190319203239.gl46fxnfz6gzeeic@linutronix.de/

To fix it, we must check whether mitigation are needed before enabling
interrupt(with PREEMPT) or before calling mm_read_lock()(without PREEMPT).

Fixes: f5fe12b1eaee ("ARM: spectre-v2: harden user aborts in kernel space")

Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 arch/arm/mm/fault.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2bc828a1940c..e4dc7c2cfe75 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -265,20 +265,27 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int sig, code;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 	vm_flags_t vm_flags = VM_ACCESS_FLAGS;
 
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	if (unlikely(addr > TASK_SIZE) && user_mode(regs)) {
+		fault = 0;
+		code = SEGV_MAPERR;
+		goto bad_area;
+	}
+#endif
 
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))
 		local_irq_enable();
 
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
 	 */
 	if (faulthandler_disabled() || !mm)
-- 
2.48.1


