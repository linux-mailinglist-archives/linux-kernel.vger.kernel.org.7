Return-Path: <linux-kernel+bounces-807770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C78B4A8EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065303ACCDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149F2D3EFB;
	Tue,  9 Sep 2025 09:53:58 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA1B2C15A0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411637; cv=none; b=kOb30qn4VHkUgkjawOrkL9kfOQfUis7jMXmPJFbu7VIbBYfQ2zzLqL7/ypjOza6BX7aPLtg8x8cXAAvif0RBJFdY6fKG3uJ9306BB1TtbpqBZvSt9dr6wXPMYZu6dmBkhzIahPjD09sdlN5YTsInm+UO4e7BYWilhKn6jTp/4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411637; c=relaxed/simple;
	bh=jddvsvw7DK9PN8pRakOPEzf8iaNd0mlQfX3YALv7OyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYcFmZgXkzCG2qnvcpWHvnAVQ7cydULeqWB4fZE23E5epuqzjTH1pQUJgJJWTtuTpT5SiOEfPTqC3lI6ZHugnEcs4AC1LbyasRkWkf/6vFq9eFZBU9UYh2ClAcBdUQMracwQqCLC3CthkQiAOvjh5979vGlLcU5w58kGPrK6uW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.89])
	by gateway (Coremail) with SMTP id _____8AxztIy+b9op1IIAA--.17602S3;
	Tue, 09 Sep 2025 17:53:54 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.89])
	by front1 (Coremail) with SMTP id qMiowJAx_8Eu+b9oVfGJAA--.41496S2;
	Tue, 09 Sep 2025 17:53:53 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Allow specify SIMD width via kernel parameters
Date: Tue,  9 Sep 2025 17:53:39 +0800
Message-ID: <20250909095339.4083769-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx_8Eu+b9oVfGJAA--.41496S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4xGr4xWry5urW7Cw1fKrX_yoW8KF4UpF
	4qyw4fGr409Fnaga9xJr409r93XFs7C3y7ZFW7Gw4YyFn5ZryDXw1vy3sxXFnxW34fWw1f
	uFs5AF1Y9a1kt3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8EeHDUUUUU==

For power saving or debugging purpose, we usually want to limit the SIMD
(LSX/LASX) usage on a rich feature platform. So allow specify SIMD width
via kernel parameters "simd=".

Allowed values of "simd=" are any integers, and recommended values are:
0:		Disable all SIMD features;
128:		Enable at most 128bit SIMD features;
256:		Enable at most 256bit SIMD features;
-1(default):	Enable as many as possible SIMD features automatically.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/cpu-probe.c | 46 +++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index fedaa67cde41..cbfce2872d71 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -52,6 +52,48 @@ static inline void cpu_set_fpu_fcsr_mask(struct cpuinfo_loongarch *c)
 	c->fpu_mask = ~(fcsr0 ^ fcsr1) & ~mask;
 }
 
+/* simd = -1/0/128/256 */
+static unsigned int simd = -1U;
+
+static int __init cpu_setup_simd(char *str)
+{
+	get_option(&str, &simd);
+	pr_info("Set SIMD width = %u\n", simd);
+
+	return 0;
+}
+
+early_param("simd", cpu_setup_simd);
+
+static int __init cpu_final_simd(void)
+{
+	struct cpuinfo_loongarch *c = &cpu_data[0];
+
+	if (simd < 128) {
+		c->options &= ~LOONGARCH_CPU_LSX;
+		elf_hwcap &= ~HWCAP_LOONGARCH_LSX;
+	}
+
+	if (simd < 256) {
+		c->options &= ~LOONGARCH_CPU_LASX;
+		elf_hwcap &= ~HWCAP_LOONGARCH_LASX;
+	}
+
+	simd = 0;
+
+	if (c->options & LOONGARCH_CPU_LSX)
+		simd = 128;
+
+	if (c->options & LOONGARCH_CPU_LASX)
+		simd = 256;
+
+	pr_info("Final SIMD width = %u\n", simd);
+
+	return 0;
+}
+
+arch_initcall(cpu_final_simd);
+
 static inline void set_elf_platform(int cpu, const char *plat)
 {
 	if (cpu == 0)
@@ -134,13 +176,13 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		elf_hwcap |= HWCAP_LOONGARCH_FPU;
 	}
 #ifdef CONFIG_CPU_HAS_LSX
-	if (config & CPUCFG2_LSX) {
+	if ((config & CPUCFG2_LSX) && (simd >= 128)) {
 		c->options |= LOONGARCH_CPU_LSX;
 		elf_hwcap |= HWCAP_LOONGARCH_LSX;
 	}
 #endif
 #ifdef CONFIG_CPU_HAS_LASX
-	if (config & CPUCFG2_LASX) {
+	if ((config & CPUCFG2_LASX) && (simd >= 256)) {
 		c->options |= LOONGARCH_CPU_LASX;
 		elf_hwcap |= HWCAP_LOONGARCH_LASX;
 	}
-- 
2.47.3


