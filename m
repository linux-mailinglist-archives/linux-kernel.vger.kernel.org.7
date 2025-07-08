Return-Path: <linux-kernel+bounces-722188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38EAFD659
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DCA1C24F12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666232E92B1;
	Tue,  8 Jul 2025 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oTnI4l/N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kHZYBGfB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88562E7160
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998834; cv=none; b=pfjR+tUG2rxfw6qxX7Zcz5C6D80SbHy/A+CFAvYKzJAnxDXCK47KaiGcvQAei42yrHjb8JzfqOihHYgwkvZ9lXrSiOpuVTWSlcaQXvrwwJv1MavWdtv7538VTq2P6U7/ho1G5ZoPYALJCWMdw440mAFP669JLbweXu/4Bv8BoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998834; c=relaxed/simple;
	bh=9QOjjCZyvJwbDd1HMnATp2+azMsvcnYIAioItMuQvZU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ljOOWLkiw+yNL974mu3wXjeo2LZjru+oXmfckhuN8RpA99F4PiBLAOqhL7mK1cjxOC0cl98EeCfx3YH6QKwn9w4UdNuAdMBfy6mx4lm19ToD3GbJqVEmEzHSi+NljHI+vKNdLci3CxbDyUno+FrpIMOVdyuQVWNHJyHZC1vPmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oTnI4l/N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kHZYBGfB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jSy0uyOubo1fFcv9gFEU8/BucbjCav9fk37UidE50c=;
	b=oTnI4l/N6+Ud5itBPkY2CYJgIBCzG4IhjZ3Wk3UTzilswUTADC1CO+KeBKYdN2k5ENYJiA
	pOGsxgCELbYKob73qXaD0leGYWt4nfYu5CGlvHbqZxYB0dzsSW/WxnELBD2KSZEp3FM+hL
	JMUPfof6l8QQxv2NpwOIQQ5Wdb0U28nbNpG79GsQYHN8aID5ZUg5VGiaOQDF39zzgLSau2
	ehBKE9A2OeT9IuopDgivsdK3NBDiYyQEdv+LkqWWN2JY2i/QYw9UWys0XFYDCr3Yw5hL2F
	0sUIvjo1r4taGFD5E7YEUcUoC5PviUUuTIafVZKG5On29+0ujVSnSGr+nanC+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jSy0uyOubo1fFcv9gFEU8/BucbjCav9fk37UidE50c=;
	b=kHZYBGfBUvTS+807mjgrStU23GoOlfLBaNk+Ey2GRHgB/f5IptRKWQHTSVP4rqLzYpIfY3
	wkvk6zgA37K/MADQ==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v5: Add GICv5 PPI support
Cc: Sascha Bischoff <sascha.bischoff@arm.com>,
 Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <20250703-gicv5-host-v7-20-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-20-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199882843.406.15202027377723169878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     7ec80fb3f025825e860b433685fb801d6de34bf3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/7ec80fb3f025825e860b433685fb801d6de34bf3
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:10 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

irqchip/gic-v5: Add GICv5 PPI support

The GICv5 CPU interface implements support for PE-Private Peripheral
Interrupts (PPI), that are handled (enabled/prioritized/delivered)
entirely within the CPU interface hardware.

To enable PPI interrupts, implement the baseline GICv5 host kernel
driver infrastructure required to handle interrupts on a GICv5 system.

Add the exception handling code path and definitions for GICv5
instructions.

Add GICv5 PPI handling code as a specific IRQ domain to:

- Set-up PPI priority
- Manage PPI configuration and state
- Manage IRQ flow handler
- IRQs allocation/free
- Hook-up a PPI specific IRQchip to provide the relevant methods

PPI IRQ priority is chosen as the minimum allowed priority by the
system design (after probing the number of priority bits implemented
by the CPU interface).

Co-developed-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Co-developed-by: Timothy Hayes <timothy.hayes@arm.com>
Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-20-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 MAINTAINERS                        |   2 +-
 arch/arm64/include/asm/sysreg.h    |  19 +-
 drivers/irqchip/Kconfig            |   5 +-
 drivers/irqchip/Makefile           |   1 +-
 drivers/irqchip/irq-gic-v5.c       | 464 ++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v5.h |  19 +-
 6 files changed, 510 insertions(+)
 create mode 100644 drivers/irqchip/irq-gic-v5.c
 create mode 100644 include/linux/irqchip/arm-gic-v5.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c545209..b120298 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1970,6 +1970,8 @@ M:	Marc Zyngier <maz@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5*.yaml
+F:	drivers/irqchip/irq-gic-v5*.[ch]
+F:	include/linux/irqchip/arm-gic-v5.h
 
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9b5fc63..36b82d7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1082,6 +1082,25 @@
 
 #define GCS_CAP(x)	((((unsigned long)x) & GCS_CAP_ADDR_MASK) | \
 					       GCS_CAP_VALID_TOKEN)
+/*
+ * Definitions for GICv5 instructions
+ */
+#define GICV5_OP_GIC_CDDI		sys_insn(1, 0, 12, 2, 0)
+#define GICV5_OP_GIC_CDEOI		sys_insn(1, 0, 12, 1, 7)
+#define GICV5_OP_GICR_CDIA		sys_insn(1, 0, 12, 3, 0)
+
+/* Definitions for GIC CDDI */
+#define GICV5_GIC_CDDI_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDDI_ID_MASK		GENMASK_ULL(23, 0)
+
+/* Definitions for GICR CDIA */
+#define GICV5_GIC_CDIA_VALID_MASK	BIT_ULL(32)
+#define GICV5_GICR_CDIA_VALID(r)	FIELD_GET(GICV5_GIC_CDIA_VALID_MASK, r)
+#define GICV5_GIC_CDIA_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDIA_ID_MASK		GENMASK_ULL(23, 0)
+
+#define gicr_insn(insn)			read_sysreg_s(GICV5_OP_GICR_##insn)
+#define gic_insn(v, insn)		write_sysreg_s(v, GICV5_OP_GIC_##insn)
 
 #define ARM64_FEATURE_FIELD_BITS	4
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0d196e4..3e4fb08 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -54,6 +54,11 @@ config ARM_GIC_V3_ITS_FSL_MC
 	depends on FSL_MC_BUS
 	default ARM_GIC_V3_ITS
 
+config ARM_GIC_V5
+	bool
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+
 config ARM_NVIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 23ca495..3d75659 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
+obj-$(CONFIG_ARM_GIC_V5)		+= irq-gic-v5.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
new file mode 100644
index 0000000..0bb9402
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024-2025 ARM Limited, All Rights Reserved.
+ */
+
+#define pr_fmt(fmt)	"GICv5: " fmt
+
+#include <linux/irqdomain.h>
+#include <linux/wordpart.h>
+
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic-v5.h>
+
+#include <asm/cpufeature.h>
+#include <asm/exception.h>
+
+static u8 pri_bits __ro_after_init = 5;
+
+#define GICV5_IRQ_PRI_MASK	0x1f
+#define GICV5_IRQ_PRI_MI	(GICV5_IRQ_PRI_MASK & GENMASK(4, 5 - pri_bits))
+
+#define PPI_NR	128
+
+static bool gicv5_cpuif_has_gcie(void)
+{
+	return this_cpu_has_cap(ARM64_HAS_GICV5_CPUIF);
+}
+
+struct gicv5_chip_data {
+	struct fwnode_handle	*fwnode;
+	struct irq_domain	*ppi_domain;
+};
+
+static struct gicv5_chip_data gicv5_global_data __read_mostly;
+
+static void gicv5_ppi_priority_init(void)
+{
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR0_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR1_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR2_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR3_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR4_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR5_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR6_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR7_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR8_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR9_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR10_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR11_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR12_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR13_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR14_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR15_EL1);
+
+	/*
+	 * Context syncronization required to make sure system register writes
+	 * effects are synchronised.
+	 */
+	isb();
+}
+
+static void gicv5_ppi_irq_mask(struct irq_data *d)
+{
+	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
+
+	if (d->hwirq < 64)
+		sysreg_clear_set_s(SYS_ICC_PPI_ENABLER0_EL1, hwirq_id_bit, 0);
+	else
+		sysreg_clear_set_s(SYS_ICC_PPI_ENABLER1_EL1, hwirq_id_bit, 0);
+
+	/*
+	 * We must ensure that the disable takes effect immediately to
+	 * guarantee that the lazy-disabled IRQ mechanism works.
+	 * A context synchronization event is required to guarantee it.
+	 * Reference: I_ZLTKB/R_YRGMH GICv5 specification - section 2.9.1.
+	 */
+	isb();
+}
+
+static void gicv5_ppi_irq_unmask(struct irq_data *d)
+{
+	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
+
+	if (d->hwirq < 64)
+		sysreg_clear_set_s(SYS_ICC_PPI_ENABLER0_EL1, 0, hwirq_id_bit);
+	else
+		sysreg_clear_set_s(SYS_ICC_PPI_ENABLER1_EL1, 0, hwirq_id_bit);
+	/*
+	 * We must ensure that the enable takes effect in finite time - a
+	 * context synchronization event is required to guarantee it, we
+	 * can not take for granted that would happen (eg a core going straight
+	 * into idle after enabling a PPI).
+	 * Reference: I_ZLTKB/R_YRGMH GICv5 specification - section 2.9.1.
+	 */
+	isb();
+}
+
+static void gicv5_hwirq_eoi(u32 hwirq_id, u8 hwirq_type)
+{
+	u64 cddi;
+
+	cddi = FIELD_PREP(GICV5_GIC_CDDI_ID_MASK, hwirq_id)	|
+	       FIELD_PREP(GICV5_GIC_CDDI_TYPE_MASK, hwirq_type);
+
+	gic_insn(cddi, CDDI);
+
+	gic_insn(0, CDEOI);
+}
+
+static void gicv5_ppi_irq_eoi(struct irq_data *d)
+{
+	gicv5_hwirq_eoi(d->hwirq, GICV5_HWIRQ_TYPE_PPI);
+}
+
+enum ppi_reg {
+	PPI_PENDING,
+	PPI_ACTIVE,
+	PPI_HM
+};
+
+static __always_inline u64 read_ppi_sysreg_s(unsigned int irq,
+					     const enum ppi_reg which)
+{
+	switch (which) {
+	case PPI_PENDING:
+		return irq < 64	? read_sysreg_s(SYS_ICC_PPI_SPENDR0_EL1) :
+				  read_sysreg_s(SYS_ICC_PPI_SPENDR1_EL1);
+	case PPI_ACTIVE:
+		return irq < 64	? read_sysreg_s(SYS_ICC_PPI_SACTIVER0_EL1) :
+				  read_sysreg_s(SYS_ICC_PPI_SACTIVER1_EL1);
+	case PPI_HM:
+		return irq < 64	? read_sysreg_s(SYS_ICC_PPI_HMR0_EL1) :
+				  read_sysreg_s(SYS_ICC_PPI_HMR1_EL1);
+	default:
+		BUILD_BUG_ON(1);
+	}
+}
+
+static __always_inline void write_ppi_sysreg_s(unsigned int irq, bool set,
+					       const enum ppi_reg which)
+{
+	u64 bit = BIT_ULL(irq % 64);
+
+	switch (which) {
+	case PPI_PENDING:
+		if (set) {
+			if (irq < 64)
+				write_sysreg_s(bit, SYS_ICC_PPI_SPENDR0_EL1);
+			else
+				write_sysreg_s(bit, SYS_ICC_PPI_SPENDR1_EL1);
+		} else {
+			if (irq < 64)
+				write_sysreg_s(bit, SYS_ICC_PPI_CPENDR0_EL1);
+			else
+				write_sysreg_s(bit, SYS_ICC_PPI_CPENDR1_EL1);
+		}
+		return;
+	case PPI_ACTIVE:
+		if (set) {
+			if (irq < 64)
+				write_sysreg_s(bit, SYS_ICC_PPI_SACTIVER0_EL1);
+			else
+				write_sysreg_s(bit, SYS_ICC_PPI_SACTIVER1_EL1);
+		} else {
+			if (irq < 64)
+				write_sysreg_s(bit, SYS_ICC_PPI_CACTIVER0_EL1);
+			else
+				write_sysreg_s(bit, SYS_ICC_PPI_CACTIVER1_EL1);
+		}
+		return;
+	default:
+		BUILD_BUG_ON(1);
+	}
+}
+
+static int gicv5_ppi_irq_get_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool *state)
+{
+	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
+
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		*state = !!(read_ppi_sysreg_s(d->hwirq, PPI_PENDING) & hwirq_id_bit);
+		return 0;
+	case IRQCHIP_STATE_ACTIVE:
+		*state = !!(read_ppi_sysreg_s(d->hwirq, PPI_ACTIVE) & hwirq_id_bit);
+		return 0;
+	default:
+		pr_debug("Unexpected PPI irqchip state\n");
+		return -EINVAL;
+	}
+}
+
+static int gicv5_ppi_irq_set_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool state)
+{
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		write_ppi_sysreg_s(d->hwirq, state, PPI_PENDING);
+		return 0;
+	case IRQCHIP_STATE_ACTIVE:
+		write_ppi_sysreg_s(d->hwirq, state, PPI_ACTIVE);
+		return 0;
+	default:
+		pr_debug("Unexpected PPI irqchip state\n");
+		return -EINVAL;
+	}
+}
+
+static bool gicv5_ppi_irq_is_level(irq_hw_number_t hwirq)
+{
+	u64 bit = BIT_ULL(hwirq % 64);
+
+	return !!(read_ppi_sysreg_s(hwirq, PPI_HM) & bit);
+}
+
+static const struct irq_chip gicv5_ppi_irq_chip = {
+	.name			= "GICv5-PPI",
+	.irq_mask		= gicv5_ppi_irq_mask,
+	.irq_unmask		= gicv5_ppi_irq_unmask,
+	.irq_eoi		= gicv5_ppi_irq_eoi,
+	.irq_get_irqchip_state	= gicv5_ppi_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= gicv5_ppi_irq_set_irqchip_state,
+	.flags			= IRQCHIP_SKIP_SET_WAKE	  |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int gicv5_irq_ppi_domain_translate(struct irq_domain *d,
+					  struct irq_fwspec *fwspec,
+					  irq_hw_number_t *hwirq,
+					  unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode))
+		return -EINVAL;
+
+	if (fwspec->param_count < 3)
+		return -EINVAL;
+
+	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_PPI)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[1];
+
+	/*
+	 * Handling mode is hardcoded for PPIs, set the type using
+	 * HW reported value.
+	 */
+	*type = gicv5_ppi_irq_is_level(*hwirq) ? IRQ_TYPE_LEVEL_LOW : IRQ_TYPE_EDGE_RISING;
+
+	return 0;
+}
+
+static int gicv5_irq_ppi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				      unsigned int nr_irqs, void *arg)
+{
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+	irq_hw_number_t hwirq;
+	int ret;
+
+	if (WARN_ON_ONCE(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = gicv5_irq_ppi_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		irq_set_status_flags(virq, IRQ_LEVEL);
+
+	irq_set_percpu_devid(virq);
+	irq_domain_set_info(domain, virq, hwirq, &gicv5_ppi_irq_chip, NULL,
+			    handle_percpu_devid_irq, NULL, NULL);
+
+	return 0;
+}
+
+static void gicv5_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	struct irq_data *d;
+
+	if (WARN_ON_ONCE(nr_irqs != 1))
+		return;
+
+	d = irq_domain_get_irq_data(domain, virq);
+
+	irq_set_handler(virq, NULL);
+	irq_domain_reset_irq_data(d);
+}
+
+static int gicv5_irq_ppi_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+				       enum irq_domain_bus_token bus_token)
+{
+	if (fwspec->fwnode != d->fwnode)
+		return 0;
+
+	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_PPI)
+		return 0;
+
+	return (d == gicv5_global_data.ppi_domain);
+}
+
+static const struct irq_domain_ops gicv5_irq_ppi_domain_ops = {
+	.translate	= gicv5_irq_ppi_domain_translate,
+	.alloc		= gicv5_irq_ppi_domain_alloc,
+	.free		= gicv5_irq_domain_free,
+	.select		= gicv5_irq_ppi_domain_select
+};
+
+static void handle_irq_per_domain(u32 hwirq)
+{
+	u8 hwirq_type = FIELD_GET(GICV5_HWIRQ_TYPE, hwirq);
+	u32 hwirq_id = FIELD_GET(GICV5_HWIRQ_ID, hwirq);
+	struct irq_domain *domain;
+
+	switch (hwirq_type) {
+	case GICV5_HWIRQ_TYPE_PPI:
+		domain = gicv5_global_data.ppi_domain;
+		break;
+	default:
+		pr_err_once("Unknown IRQ type, bail out\n");
+		return;
+	}
+
+	if (generic_handle_domain_irq(domain, hwirq_id)) {
+		pr_err_once("Could not handle, hwirq = 0x%x", hwirq_id);
+		gicv5_hwirq_eoi(hwirq_id, hwirq_type);
+	}
+}
+
+static void __exception_irq_entry gicv5_handle_irq(struct pt_regs *regs)
+{
+	bool valid;
+	u32 hwirq;
+	u64 ia;
+
+	ia = gicr_insn(CDIA);
+	valid = GICV5_GICR_CDIA_VALID(ia);
+
+	if (!valid)
+		return;
+
+	/*
+	 * Ensure that the CDIA instruction effects (ie IRQ activation) are
+	 * completed before handling the interrupt.
+	 */
+	gsb_ack();
+
+	/*
+	 * Ensure instruction ordering between an acknowledgment and subsequent
+	 * instructions in the IRQ handler using an ISB.
+	 */
+	isb();
+
+	hwirq = FIELD_GET(GICV5_HWIRQ_INTID, ia);
+
+	handle_irq_per_domain(hwirq);
+}
+
+static void gicv5_cpu_disable_interrupts(void)
+{
+	u64 cr0;
+
+	cr0 = FIELD_PREP(ICC_CR0_EL1_EN, 0);
+	write_sysreg_s(cr0, SYS_ICC_CR0_EL1);
+}
+
+static void gicv5_cpu_enable_interrupts(void)
+{
+	u64 cr0, pcr;
+
+	write_sysreg_s(0, SYS_ICC_PPI_ENABLER0_EL1);
+	write_sysreg_s(0, SYS_ICC_PPI_ENABLER1_EL1);
+
+	gicv5_ppi_priority_init();
+
+	pcr = FIELD_PREP(ICC_PCR_EL1_PRIORITY, GICV5_IRQ_PRI_MI);
+	write_sysreg_s(pcr, SYS_ICC_PCR_EL1);
+
+	cr0 = FIELD_PREP(ICC_CR0_EL1_EN, 1);
+	write_sysreg_s(cr0, SYS_ICC_CR0_EL1);
+}
+
+static int gicv5_starting_cpu(unsigned int cpu)
+{
+	if (WARN(!gicv5_cpuif_has_gcie(),
+		 "GICv5 system components present but CPU does not have FEAT_GCIE"))
+		return -ENODEV;
+
+	gicv5_cpu_enable_interrupts();
+
+	return 0;
+}
+
+static void __init gicv5_free_domains(void)
+{
+	if (gicv5_global_data.ppi_domain)
+		irq_domain_remove(gicv5_global_data.ppi_domain);
+
+	gicv5_global_data.ppi_domain = NULL;
+}
+
+static int __init gicv5_init_domains(struct fwnode_handle *handle)
+{
+	struct irq_domain *d;
+
+	d = irq_domain_create_linear(handle, PPI_NR, &gicv5_irq_ppi_domain_ops, NULL);
+	if (!d)
+		return -ENOMEM;
+
+	irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
+	gicv5_global_data.ppi_domain = d;
+	gicv5_global_data.fwnode = handle;
+
+	return 0;
+}
+
+static void gicv5_set_cpuif_pribits(void)
+{
+	u64 icc_idr0 = read_sysreg_s(SYS_ICC_IDR0_EL1);
+
+	switch (FIELD_GET(ICC_IDR0_EL1_PRI_BITS, icc_idr0)) {
+	case ICC_IDR0_EL1_PRI_BITS_4BITS:
+		pri_bits = 4;
+		break;
+	case ICC_IDR0_EL1_PRI_BITS_5BITS:
+		pri_bits = 5;
+		break;
+	default:
+		pr_err("Unexpected ICC_IDR0_EL1_PRI_BITS value, default to 4");
+		pri_bits = 4;
+		break;
+	}
+}
+
+static int __init gicv5_of_init(struct device_node *node, struct device_node *parent)
+{
+	int ret = gicv5_init_domains(of_fwnode_handle(node));
+	if (ret)
+		return ret;
+
+	gicv5_set_cpuif_pribits();
+
+	ret = gicv5_starting_cpu(smp_processor_id());
+	if (ret)
+		goto out_dom;
+
+	ret = set_handle_irq(gicv5_handle_irq);
+	if (ret)
+		goto out_int;
+
+	return 0;
+
+out_int:
+	gicv5_cpu_disable_interrupts();
+out_dom:
+	gicv5_free_domains();
+
+	return ret;
+}
+IRQCHIP_DECLARE(gic_v5, "arm,gic-v5", gicv5_of_init);
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-gic-v5.h
new file mode 100644
index 0000000..b08ec03
--- /dev/null
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 ARM Limited, All Rights Reserved.
+ */
+#ifndef __LINUX_IRQCHIP_ARM_GIC_V5_H
+#define __LINUX_IRQCHIP_ARM_GIC_V5_H
+
+#include <asm/sysreg.h>
+
+/*
+ * INTID handling
+ */
+#define GICV5_HWIRQ_ID			GENMASK(23, 0)
+#define GICV5_HWIRQ_TYPE		GENMASK(31, 29)
+#define GICV5_HWIRQ_INTID		GENMASK_ULL(31, 0)
+
+#define GICV5_HWIRQ_TYPE_PPI		UL(0x1)
+
+#endif

