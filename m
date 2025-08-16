Return-Path: <linux-kernel+bounces-771805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7617B28BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3749D1CE2BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94223372C;
	Sat, 16 Aug 2025 08:08:23 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759201EA7CF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755331702; cv=none; b=PH/tPmfLv6HgZ9D01eBogZTxvCiGtuopnLgd6b8MZbaHSZCiWaOxSfzDhV5ndzkaC7a2r58ts3Or4i6YNBkycc/j+0M67ZqFy98v5qfnMp6vQvuFf/yvSbqmZbe1esgCWzKi2Bu8xlhKflOMKm1ma7bwT/MZNI8gva29SRM4adI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755331702; c=relaxed/simple;
	bh=LQn4oqAwPtjfAUyws81EXqkJ3iNViZErcjv6OQPpbxU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jAsnZq/kOety4779pGkYRZZz8HQzCddL79Vsrp9vYXDRc9W0IWKGwYzcdyO3d33lKxVnF7vgQSENY9jEuN6p0rcP2dqtxZjA8SwnsdqXJbd/PFp4K4qtdu2dvqF2GMempBBdoR0z1P/qd5OwDQB0YSBMy53WFXEBeW5bdyAqYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c3s1j3PZxzPtFV;
	Sat, 16 Aug 2025 16:03:53 +0800 (CST)
Received: from dggpemf100018.china.huawei.com (unknown [7.185.36.183])
	by mail.maildlp.com (Postfix) with ESMTPS id A4755180B63;
	Sat, 16 Aug 2025 16:08:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf100018.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 16 Aug
 2025 16:08:13 +0800
From: Yipeng Zou <zouyipeng@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<rafael.j.wysocki@intel.com>, <zouyipeng@huawei.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] x86/smp: ignore stale reboot IPI in crash kernel
Date: Sat, 16 Aug 2025 16:08:54 +0800
Message-ID: <20250816080854.928605-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf100018.china.huawei.com (7.185.36.183)

Recently, A issue has been reported that CPU hang in x86 VM.

The CPU halted during Kdump likely due to IPI issues when one CPU was
rebooting and another was in Kdump:

CPU0			  CPU2
========================  ======================
reboot			  Panic
machine shutdown	  Kdump
...			  machine_crash_shutdown
local_irq_disable	  local_irq_disable
stop other cpus		  ...
...			  nmi_shootdown_cpus
send_IPIs(REBOOT)  ---->  [IPI pending]
Halt,NMI context   <----  send_IPIs(NMI)
			  ...
			  second kernel start
			  ...
			  local irq enable
			  Halt, IPI context

In simple terms, when the Kdump jump to the second kernel, the IPI that
was pending in the first kernel remains and is responded to by the
second kernel.

For a detailed, please refer to:

[1] https://lore.kernel.org/all/20250604083319.144500-1-zouyipeng@huawei.com/

This scenario can be detected when stopping_cpu contains the bootup value.

Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 arch/x86/kernel/smp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index b014e6d229f9..66144f686436 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -136,6 +136,28 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
 	apic_eoi();
+
+	/*
+	 * Handle the case where a reboot IPI is stale in the IRR. This
+	 * happens when:
+	 *
+	 *   a CPU crashes with interrupts disabled before handling the
+	 *   reboot IPI and jumps into a crash kernel. The reboot IPI
+	 *   vector is kept set in the APIC IRR across the APIC soft
+	 *   disabled phase and as there is no way to clear a pending IRR
+	 *   bit, it is delivered to the crash kernel immediately when
+	 *   interrupts are enabled.
+	 *
+	 * As the reboot IPI can only be sent after acquiring @stopping_cpu
+	 * by storing the CPU number, this case can be detected when
+	 * @stopping_cpu contains the bootup value -1. Just return and
+	 * ignore it.
+	 */
+	if (atomic_read(&stopping_cpu) == -1) {
+		pr_info("Ignoring stale reboot IPI\n");
+		return;
+	}
+
 	cpu_emergency_disable_virtualization();
 	stop_this_cpu(NULL);
 }
-- 
2.34.1


