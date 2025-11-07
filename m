Return-Path: <linux-kernel+bounces-890111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47692C3F3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C152C18825B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4792B26F29F;
	Fri,  7 Nov 2025 09:48:27 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D91DFD9A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508906; cv=none; b=hJGVcrKkQeYa0wAYtDUiiEnj1ikbq/rQoYsFErffrBAHIRbvc76pLAxI+nz0Zmn9q+8QlaIh7uozsduAxaYcykTHu6hElh7DoHoTFbP/lrK1pJDkrW14Ote0x9gjSs3NSelKwXI0XyocFTug3UcPpfT+k8iI7eMztfNpAvBlYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508906; c=relaxed/simple;
	bh=vCzSa6ltYMoZDydQYv0ilc4C+KkX3p8OkbQAVY3phhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fLWIF7frH7S4DD3NNp/sKOqm5eztdjgsXeM73FixNKtr5YxFX4HIEC/Qwako8VfSPCfJnOnVSP41EFthMzgYzqedqU0GN2i8fvdZX3tk7QxhMN8Ro1tZwJdrHTKrtBo/OYY3EqolapE7CXV9/EglQRSMz7DXWv/Z0RJgLuIjKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8DxudFiwA1pvUEgAA--.5392S3;
	Fri, 07 Nov 2025 17:48:18 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.45])
	by front1 (Coremail) with SMTP id qMiowJDxscJYwA1poLwqAQ--.1671S2;
	Fri, 07 Nov 2025 17:48:15 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Clarify 3 MSG interrupt features
Date: Fri,  7 Nov 2025 17:47:59 +0800
Message-ID: <20251107094759.3093531-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxscJYwA1poLwqAQ--.1671S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw48WF1fJr1ruw1kXryDCFX_yoWrtrWUpF
	WDAFWkWFW5KFs2ka4qqF1a9rnrWFZ7Cr429r1UC3yDJF1UX348XrykKasxZF98Xa1DXa4I
	9Fn5Cwn0va4DXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU4s2-UUUUU

LoongArch's MSG interrupt features are used across multiple subsystems.
Clarify these features to avoid misuse, existing users will be adjusted
if necessary.

MSGINT: Infrastructure, means the CPU core supports message interupts.
Indicated by CPUCFG1.MSGINT.

AVECINT: AVEC interrupt controller based on MSGINT, means the CPU chip
supports direct message interrupts. Indicated by IOCSR.FEATURES.DMSI.

REDIRECTINT: REDIRECT interrupt controller based on MSGINT and AVECINT,
means the CPU chip supports redirect message interrupts. Indicated by
IOCSR.FEATURES.RMSI.

For example:
Loongson-3A5000/3C5000 doesn't support MSGINT/AVECINT/REDIRECTINT;
Loongson-3A6000 supports MSGINT but doesn't support AVECINT/REDIRECTINT;
Loongson-3C6000 supports MSGINT/AVECINT/REDIRECTINT.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/cpu-features.h | 2 ++
 arch/loongarch/include/asm/cpu.h          | 6 +++++-
 arch/loongarch/include/asm/loongarch.h    | 1 +
 arch/loongarch/kernel/cpu-probe.c         | 4 ++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index fc83bb32f9f0..bd5f0457ad21 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -67,6 +67,8 @@
 #define cpu_has_hypervisor	cpu_opt(LOONGARCH_CPU_HYPERVISOR)
 #define cpu_has_ptw		cpu_opt(LOONGARCH_CPU_PTW)
 #define cpu_has_lspw		cpu_opt(LOONGARCH_CPU_LSPW)
+#define cpu_has_msgint		cpu_opt(LOONGARCH_CPU_MSGINT)
 #define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
+#define cpu_has_redirectint	cpu_opt(LOONGARCH_CPU_REDIRECTINT)
 
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index dfb982fe8701..d4cd4041bee7 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -101,7 +101,9 @@ enum cpu_type_enum {
 #define CPU_FEATURE_HYPERVISOR		26	/* CPU has hypervisor (running in VM) */
 #define CPU_FEATURE_PTW			27	/* CPU has hardware page table walker */
 #define CPU_FEATURE_LSPW		28	/* CPU has LSPW (lddir/ldpte instructions) */
-#define CPU_FEATURE_AVECINT		29	/* CPU has AVEC interrupt */
+#define CPU_FEATURE_MSGINT		29	/* CPU has MSG interrupt */
+#define CPU_FEATURE_AVECINT		30	/* CPU has AVEC interrupt */
+#define CPU_FEATURE_REDIRECTINT		31	/* CPU has interrupt remapping */
 
 #define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
 #define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
@@ -132,6 +134,8 @@ enum cpu_type_enum {
 #define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
 #define LOONGARCH_CPU_PTW		BIT_ULL(CPU_FEATURE_PTW)
 #define LOONGARCH_CPU_LSPW		BIT_ULL(CPU_FEATURE_LSPW)
+#define LOONGARCH_CPU_MSGINT		BIT_ULL(CPU_FEATURE_MSGINT)
 #define LOONGARCH_CPU_AVECINT		BIT_ULL(CPU_FEATURE_AVECINT)
+#define LOONGARCH_CPU_REDIRECTINT	BIT_ULL(CPU_FEATURE_REDIRECTINT)
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 09dfd7eb406e..5b36fa57015f 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1137,6 +1137,7 @@
 #define  IOCSRF_FLATMODE		BIT_ULL(10)
 #define  IOCSRF_VM			BIT_ULL(11)
 #define  IOCSRF_AVEC			BIT_ULL(15)
+#define  IOCSRF_REDIRECT		BIT_ULL(16)
 
 #define LOONGARCH_IOCSR_VENDOR		0x10
 
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index cbfce2872d71..6f943d1391ff 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -157,6 +157,8 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		c->options |= LOONGARCH_CPU_TLB;
 	if (config & CPUCFG1_IOCSR)
 		c->options |= LOONGARCH_CPU_IOCSR;
+	if (config & CPUCFG1_MSGINT)
+		c->options |= LOONGARCH_CPU_MSGINT;
 	if (config & CPUCFG1_UAL) {
 		c->options |= LOONGARCH_CPU_UAL;
 		elf_hwcap |= HWCAP_LOONGARCH_UAL;
@@ -331,6 +333,8 @@ static inline void cpu_probe_loongson(struct cpuinfo_loongarch *c, unsigned int
 		c->options |= LOONGARCH_CPU_EIODECODE;
 	if (config & IOCSRF_AVEC)
 		c->options |= LOONGARCH_CPU_AVECINT;
+	if (config & IOCSRF_REDIRECT)
+		c->options |= LOONGARCH_CPU_REDIRECTINT;
 	if (config & IOCSRF_VM)
 		c->options |= LOONGARCH_CPU_HYPERVISOR;
 }
-- 
2.47.3


