Return-Path: <linux-kernel+bounces-764444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445BB22317
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2C4562E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D02E8DFB;
	Tue, 12 Aug 2025 09:24:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188582DECD8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990656; cv=none; b=maEs6j/tddWb75FJfbqd22nvvsZhd+u2bvRxvsmYKgmghlOtEcqbRC68BcpQL0QbFVtDZxR3fCQtstBNePKejCHLjSDyTIfNRb/EKASSgTiMnhZg2824tLoojEBrDirt6XkqHt72sk3bRIUVKotlIsijDUuy5ZioJD7bS7kQnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990656; c=relaxed/simple;
	bh=pMcJcJQiqvVQnGWVRLmOTi3/M2sHc3xPufUCjYhTSvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pXLQ6RCFWMPz6v6AXaR0wnH8R2isksDwev6WXaKl/dcGR6KwgaPF15TOHxE7ScoRzATt2DgBOluvTF7KvGSaGV1UoX5veRAy44Fm2nW037vHJvtFaOH5cMlXjoegfVj2g8n+/XbuVe9MucNrSRq7olWel52HvHxpqCBWAFzXesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8Bxjaw2CJtoe+c+AQ--.20310S3;
	Tue, 12 Aug 2025 17:24:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJCxM+Q1CJtoZE1GAA--.2639S2;
	Tue, 12 Aug 2025 17:24:05 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Song Gao <gaosong@loongson.cn>,
	Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: time: Fix the issue of high cpu usage of vcpu threads in virtual machines
Date: Tue, 12 Aug 2025 17:00:56 +0800
Message-Id: <20250812090056.771379-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxM+Q1CJtoZE1GAA--.2639S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

When the cpu is offline, the timer under loongarch is not correctly closed,
resulting in an excessively high cpu usage rate of the offline vcpu thread
in the virtual machine.

To correctly close the timer, we have made the following modifications:

Register the cpu hotplug timer start event for loongarch.This event will
be called to close the timer when the cpu is offline.

Clear the timer interrupt when the timer is turned off

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
 arch/loongarch/kernel/time.c | 20 ++++++++++++++++++++
 include/linux/cpuhotplug.h   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 367906b10f81..4daa11512eba 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/sched_clock.h>
 #include <linux/spinlock.h>
+#include <linux/cpu.h>
 
 #include <asm/cpu-features.h>
 #include <asm/loongarch.h>
@@ -86,6 +87,9 @@ static int constant_set_state_shutdown(struct clock_event_device *evt)
 	timer_config &= ~CSR_TCFG_EN;
 	csr_write64(timer_config, LOONGARCH_CSR_TCFG);
 
+	/* Clear Timer Interrupt */
+	write_csr_tintclear(CSR_TINTCLR_TI);
+
 	raw_spin_unlock(&state_lock);
 
 	return 0;
@@ -208,8 +212,17 @@ int __init constant_clocksource_init(void)
 	return res;
 }
 
+static int arch_timer_dying_cpu(unsigned int cpu)
+{
+	constant_set_state_shutdown(NULL);
+
+	return 0;
+}
+
 void __init time_init(void)
 {
+	int err;
+
 	if (!cpu_has_cpucfg)
 		const_clock_freq = cpu_clock_freq;
 	else
@@ -220,4 +233,11 @@ void __init time_init(void)
 	constant_clockevent_init();
 	constant_clocksource_init();
 	pv_time_init();
+
+	err = cpuhp_setup_state_nocalls(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
+					"loongarch/timer:starting",
+					NULL, arch_timer_dying_cpu);
+	if (err)
+		pr_info("cpu hotplug event register failed");
+
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index edfa61d80702..6606c1546afc 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -159,6 +159,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_PERF_RISCV_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
+	CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
 	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_EVTSTRM_STARTING,

base-commit: 53e760d8949895390e256e723e7ee46618310361
-- 
2.39.1


