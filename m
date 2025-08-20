Return-Path: <linux-kernel+bounces-776845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3164CB2D205
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A58524E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ECB2147F9;
	Wed, 20 Aug 2025 02:39:49 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D671FFC46
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657589; cv=none; b=ZgJkDhmj/8wEGDNGG8UScdBBCMQNsQq7HUhfK5VarJNEzUyBMTdfKmAQsM6MHTp5KcDVhT5RHce36Hyqw1OvZM4fC3z2kp5gzDEPjwZ3nxAYIm7Pw7M6FSlQLEXb/LT/XLxfwT1GxJzv8WDbLizF+Ub4YByu+Sgc8bz9LE+FY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657589; c=relaxed/simple;
	bh=GuOwmwD8ZcZfR4Q5ezl3SsmSMqXl0ADPOaqErNpn4VY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ijTfeHPC+7im8H7uuiQppRtKhrK/jAiWCiLZiuoJwQJX+39CnjMyuFxwB4v/aTRt4B61+EPsf/uvg5m82uVZVGO3LGqur+WKFGjksPxdgSEEKYHw07xkkVqt+MjuqYNM27GZMUHW+ruVltJilC/xG1W7SVDF/v7Ss09arAT0mEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8AxztJnNaVoKrIAAA--.1332S3;
	Wed, 20 Aug 2025 10:39:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJCxM+RdNaVoKMhZAA--.12938S2;
	Wed, 20 Aug 2025 10:39:26 +0800 (CST)
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
Subject: [PATCH V2] LoongArch: time: Fix the issue of high cpu usage of vcpu threads in virtual machines
Date: Wed, 20 Aug 2025 10:15:51 +0800
Message-Id: <20250820021551.911917-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxM+RdNaVoKMhZAA--.12938S2
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

Clear the timer interrupt when the timer is turned off, Because before the
timer is turned off, there may be a timer interrupt that has been in the
pending state due to the interruption of the disabled, which also affects
the halt state of the offline vcpu.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
V1->V2:
1.Add the implementation of the function arch_timer_starting
2.Add more descriptions about clear timer interrupts in the commit message
3.Delete useless prints
4.Adjust the calling position of the function cpuhp_setup_state
5.Adjust the timer interrupt clear position

 arch/loongarch/kernel/time.c | 22 ++++++++++++++++++++++
 include/linux/cpuhotplug.h   |  1 +
 2 files changed, 23 insertions(+)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 367906b10f81..09b95f28bdcc 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/sched_clock.h>
 #include <linux/spinlock.h>
+#include <linux/cpu.h>
 
 #include <asm/cpu-features.h>
 #include <asm/loongarch.h>
@@ -102,6 +103,23 @@ static int constant_timer_next_event(unsigned long delta, struct clock_event_dev
 	return 0;
 }
 
+static int arch_timer_dying_cpu(unsigned int cpu)
+{
+	constant_set_state_shutdown(this_cpu_ptr(&constant_clockevent_device));
+
+	/* Clear Timer Interrupt */
+	write_csr_tintclear(CSR_TINTCLR_TI);
+
+	return 0;
+}
+
+static int arch_timer_starting(unsigned int cpu)
+{
+	set_csr_ecfg(ECFGF_TIMER);
+
+	return 0;
+}
+
 static unsigned long get_loops_per_jiffy(void)
 {
 	unsigned long lpj = (unsigned long)const_clock_freq;
@@ -172,6 +190,10 @@ int constant_clockevent_init(void)
 	lpj_fine = get_loops_per_jiffy();
 	pr_info("Constant clock event device register\n");
 
+	cpuhp_setup_state(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
+			  "clockevents/loongarch/timer:starting",
+			  arch_timer_starting, arch_timer_dying_cpu);
+
 	return 0;
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
-- 
2.39.1


