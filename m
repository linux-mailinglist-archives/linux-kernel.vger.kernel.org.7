Return-Path: <linux-kernel+bounces-593746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA464A7FD4B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 12:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090C542279F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D9267F6E;
	Tue,  8 Apr 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec8YIM7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC826B080;
	Tue,  8 Apr 2025 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109515; cv=none; b=ocUQYhWPaBTOhd3eIW7Y29tn3gknX9/spgdNwfsP+rCgEcZl+fY5c+PGBbUyxSPhWdv2VEZiTuOBW2vxEbyg5j8PYjjQ/rn+cKOFuy7/jaGH7zhhfLkrJU0KmYMPsSn9etHSmh4zTq0HYGIht6BXCY+4kFUvfR0Q901YI+p2egM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109515; c=relaxed/simple;
	bh=nJ8ExirTmfRpxgLbitQ00fQuZneCF/UWvT0+5dUuNfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vENAAuFXTCBzHnuMSEJxXm7VjL04pxTHvhG7ozRDy48YtRY+2/Pf7QkUGZnIvmLC55/epZE81X50UwXQxTsq5HRGJF7DTbXVCqSIvrlvL7HndmUMSjnFi8f1EmloPZmNwADB2IFEuO9x4a5wAouahuoMXq3w8rsBqN4XtbFOJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec8YIM7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12BDC4CEE7;
	Tue,  8 Apr 2025 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744109514;
	bh=nJ8ExirTmfRpxgLbitQ00fQuZneCF/UWvT0+5dUuNfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ec8YIM7uRax3tcIOQg7yxBAd1I377q0V4FSE+Iz6kfPqYhJw+vIG1lmjqNZqtvcMQ
	 vkbKWLApMguARbdzTlawwtdhTweTw0w9dAE0lt80Fw7D+yuFZ249OkXhnR5lqS962N
	 G6bJk9W+M9aUgpzlCZL15LPDrBMOGwSC+GtU7dPEvfQXFVVeFH2QIjsZctseebYR+3
	 IWp0Fzno5d3UrIm2kak4O4UznXxzJmvfXAPTTtVjZEaLIQDhd8ZTI0vqPSR+haipQ5
	 KLBJuefZF5IIutkO8RCFeAgFkEWz1xVuNJEw8UdxX4CDtCjWMCElHSDJeFNWsIUdxT
	 reTkt+fyrslNw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Tue, 08 Apr 2025 12:50:17 +0200
Subject: [PATCH 18/24] irqchip/gic-v5: Add GICv5 PPI support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-gicv5-host-v1-18-1f26db465f8d@kernel.org>
References: <20250408-gicv5-host-v1-0-1f26db465f8d@kernel.org>
In-Reply-To: <20250408-gicv5-host-v1-0-1f26db465f8d@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.14.2

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
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 MAINTAINERS                         |   2 +
 arch/arm64/include/asm/arch_gicv5.h |  38 +++
 drivers/irqchip/Kconfig             |   5 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-gic-v5.c        | 497 ++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v5.h        |  19 ++
 6 files changed, 562 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3ed84466da19906953b5396a5f4b50e878c376e..cdeceb6782355a4a18609135bf7f03249d8b0bb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1907,6 +1907,8 @@ M:	Marc Zyngier <maz@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml
+F:	arch/arm64/include/asm/arch_gicv5.h
+F:	drivers/irqchip/irq-gic-v5*.[ch]
 
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
diff --git a/arch/arm64/include/asm/arch_gicv5.h b/arch/arm64/include/asm/arch_gicv5.h
new file mode 100644
index 0000000000000000000000000000000000000000..e86cda5e5b3295c4f9c784d92adad1c6df6dbc34
--- /dev/null
+++ b/arch/arm64/include/asm/arch_gicv5.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+#ifndef __ASM_ARCH_GICV5_H
+#define __ASM_ARCH_GICV5_H
+
+#include <asm/sysreg.h>
+
+#ifndef __ASSEMBLY__
+
+#define GICV5_OP_GIC_CDDI		sys_insn(1, 0, 12, 2, 0)
+#define GICV5_OP_GIC_CDEOI		sys_insn(1, 0, 12, 1, 7)
+#define GICV5_OP_GICR_CDIA		sys_insn(1, 0, 12, 3, 0)
+
+#define gicr_insn(insn)			read_sysreg_s(insn)
+#define gic_insn(v, insn)		write_sysreg_s(v, insn)
+
+#define GSB_ACK				__emit_inst(0xd5000000 | sys_insn(1, 0, 12, 0, 1) | 31)
+
+#define gsb_ack()			asm volatile(GSB_ACK : : : "memory")
+
+/* Shift and mask definitions for GIC CDDI */
+#define GICV5_GIC_CDDI_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDDI_TYPE(r)		FIELD_GET(GICV5_GIC_CDDI_TYPE_MASK, r)
+#define GICV5_GIC_CDDI_ID_MASK		GENMASK_ULL(23, 0)
+#define GICV5_GIC_CDDI_ID(r)		FIELD_GET(GICV5_GIC_CDDI_ID_MASK, r)
+
+/* Shift and mask definitions for GICR CDIA */
+#define GICV5_GIC_CDIA_VALID_MASK	BIT_ULL(32)
+#define GICV5_GIC_CDIA_VALID(r)		FIELD_GET(GICV5_GIC_CDIA_VALID_MASK, r)
+#define GICV5_GIC_CDIA_TYPE_MASK	GENMASK_ULL(31, 29)
+#define GICV5_GIC_CDIA_TYPE(r)		FIELD_GET(GICV5_GIC_CDIA_TYPE_MASK, r)
+#define GICV5_GIC_CDIA_ID_MASK		GENMASK_ULL(23, 0)
+#define GICV5_GIC_CDIA_ID(r)		FIELD_GET(GICV5_GIC_CDIA_ID_MASK, r)
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_ARCH_GICV5_H */
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index cec05e443083b8982b3e72f4212d808a22883914..160a4761d5d85f6dbf36f3142fd619c114733e36 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -54,6 +54,11 @@ config ARM_GIC_V3_ITS_FSL_MC
 	depends on FSL_MC_BUS
 	default ARM_GIC_V3_ITS
 
+config ARM_GIC_V5
+	bool
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
+
 config ARM_NVIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 365bcea9a61ff89e2cb41034125b3fc8cd494d81..3f8225bba5f0f9ce5dbb629b6d4782eacf85da44 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
+obj-$(CONFIG_ARM_GIC_V5)		+= irq-gic-v5.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
new file mode 100644
index 0000000000000000000000000000000000000000..996e2c992ef33e5ec8d2680ad4026b725ca39b04
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024-2025 ARM Limited, All Rights Reserved.
+ */
+
+#define pr_fmt(fmt)	"GICv5: " fmt
+
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/wordpart.h>
+
+#include <asm/cpufeature.h>
+#include <asm/exception.h>
+
+#include "irq-gic-v5.h"
+
+static u8 pri_bits = 5;
+#define GICV5_IRQ_PRIORITY_MASK 0x1f
+#define GICV5_IRQ_PRIORITY_MI \
+		(GICV5_IRQ_PRIORITY_MASK & GENMASK(4, 5 - pri_bits))
+
+static bool gicv5_cpuif_has_gcie(void)
+{
+	return this_cpu_has_cap(ARM64_HAS_GCIE);
+}
+
+struct gicv5_chip_data {
+	struct fwnode_handle *fwnode;
+	struct irq_domain *ppi_domain;
+};
+
+static struct gicv5_chip_data gicv5_global_data __read_mostly;
+
+static void gicv5_ppi_priority_init(void)
+{
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR0_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR1_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR2_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR3_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR4_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR5_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR6_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR7_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR8_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR9_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR10_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR11_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR12_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR13_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR14_EL1);
+	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRIORITY_MI),
+				 SYS_ICC_PPI_PRIORITYR15_EL1);
+
+	/*
+	 * Context syncronization required to make sure system
+	 * register writes effects are synchronized
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
+	 * Ensure that the disable takes effect
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
+}
+
+static void gicv5_hwirq_eoi(u32 hwirq_id, u32 hwirq_type)
+{
+	u64 cddi = hwirq_id | FIELD_PREP(GICV5_GIC_CDDI_TYPE_MASK, hwirq_type);
+
+	gic_insn(cddi, GICV5_OP_GIC_CDDI);
+
+	gic_insn(0, GICV5_OP_GIC_CDEOI);
+}
+
+static void gicv5_ppi_irq_eoi(struct irq_data *d)
+{
+	gicv5_hwirq_eoi(d->hwirq, GICV5_HWIRQ_TYPE_PPI);
+}
+
+static int gicv5_ppi_set_type(struct irq_data *d, unsigned int type)
+{
+	/*
+	 * The PPI trigger mode is not configurable at runtime,
+	 * therefore this function simply confirms that the `type`
+	 * parameter matches what is present.
+	 */
+	u64 hmr;
+
+	if (d->hwirq < 64)
+		hmr = read_sysreg_s(SYS_ICC_PPI_HMR0_EL1);
+	else
+		hmr = read_sysreg_s(SYS_ICC_PPI_HMR1_EL1);
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_LEVEL_LOW:
+		if (((hmr >> (d->hwirq % 64)) & 0x1) != GICV5_PPI_HM_LEVEL)
+			return -EINVAL;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+		if (((hmr >> (d->hwirq % 64)) & 0x1) != GICV5_PPI_HM_EDGE)
+			return -EINVAL;
+		break;
+	default:
+		pr_debug("Unexpected PPI trigger mode");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gicv5_ppi_irq_get_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool *val)
+{
+	u64 pendr, activer, enabler, hwirq_id_bit = BIT_ULL(d->hwirq % 64);
+
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		if (d->hwirq < 64)
+			pendr = read_sysreg_s(SYS_ICC_PPI_SPENDR0_EL1);
+		else
+			pendr = read_sysreg_s(SYS_ICC_PPI_SPENDR1_EL1);
+
+		*val = !!(pendr & hwirq_id_bit);
+
+		return 0;
+	case IRQCHIP_STATE_ACTIVE:
+		if (d->hwirq < 64)
+			activer = read_sysreg_s(SYS_ICC_PPI_SACTIVER0_EL1);
+		else
+			activer = read_sysreg_s(SYS_ICC_PPI_SACTIVER1_EL1);
+
+		*val = !!(activer & hwirq_id_bit);
+
+		return 0;
+	case IRQCHIP_STATE_MASKED:
+		if (d->hwirq < 64)
+			enabler = read_sysreg_s(SYS_ICC_PPI_ENABLER0_EL1);
+		else
+			enabler = read_sysreg_s(SYS_ICC_PPI_ENABLER1_EL1);
+
+		*val = !(enabler & hwirq_id_bit);
+
+		return 0;
+	default:
+		pr_debug("Unexpected PPI irqchip state\n");
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int gicv5_ppi_irq_set_irqchip_state(struct irq_data *d,
+					   enum irqchip_irq_state which,
+					   bool val)
+{
+	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
+
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		if (val) {
+			if (d->hwirq < 64)
+				write_sysreg_s(hwirq_id_bit,
+					       SYS_ICC_PPI_SPENDR0_EL1);
+			else
+				write_sysreg_s(hwirq_id_bit,
+					       SYS_ICC_PPI_SPENDR1_EL1);
+
+		} else {
+			if (d->hwirq < 64)
+				write_sysreg_s(hwirq_id_bit,
+					       SYS_ICC_PPI_CPENDR0_EL1);
+			else
+				write_sysreg_s(hwirq_id_bit,
+					       SYS_ICC_PPI_CPENDR1_EL1);
+		}
+
+		return 0;
+	case IRQCHIP_STATE_ACTIVE:
+		if (val) {
+			if (d->hwirq < 64)
+				write_sysreg_s(hwirq_id_bit,
+					       SYS_ICC_PPI_SACTIVER0_EL1);
+			else
+				write_sysreg_s(hwirq_id_bit,
+					       SYS_ICC_PPI_SACTIVER1_EL1);
+		} else {
+			if (d->hwirq < 64)
+				write_sysreg_s(hwirq_id_bit,
+					       SYS_ICC_PPI_CACTIVER0_EL1);
+			else
+				write_sysreg_s(hwirq_id_bit,
+					       SYS_ICC_PPI_CACTIVER1_EL1);
+		}
+
+		return 0;
+	case IRQCHIP_STATE_MASKED:
+		if (val)
+			gicv5_ppi_irq_mask(d);
+		else
+			gicv5_ppi_irq_unmask(d);
+		return 0;
+	default:
+		pr_debug("Unexpected PPI irqchip state\n");
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static const struct irq_chip gicv5_ppi_irq_chip = {
+	.name			= "GICv5-PPI",
+	.irq_mask		= gicv5_ppi_irq_mask,
+	.irq_unmask		= gicv5_ppi_irq_unmask,
+	.irq_eoi		= gicv5_ppi_irq_eoi,
+	.irq_set_type		= gicv5_ppi_set_type,
+	.irq_get_irqchip_state	= gicv5_ppi_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= gicv5_ppi_irq_set_irqchip_state,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE	  |
+				  IRQCHIP_MASK_ON_SUSPEND
+};
+
+static int gicv5_irq_ppi_domain_translate(struct irq_domain *d,
+					  struct irq_fwspec *fwspec,
+					  irq_hw_number_t *hwirq,
+					  unsigned int *type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count < 3)
+			return -EINVAL;
+
+		if (fwspec->param[0] != GICV5_HWIRQ_TYPE_PPI)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int gicv5_irq_ppi_domain_alloc(struct irq_domain *domain,
+				      unsigned int virq, unsigned int nr_irqs,
+				      void *arg)
+{
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+	irq_hw_number_t hwirq;
+	int ret;
+
+	if (WARN_ON(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = gicv5_irq_ppi_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	irq_set_percpu_devid(virq);
+	irq_domain_set_info(domain, virq, hwirq, &gicv5_ppi_irq_chip, NULL,
+			    handle_percpu_devid_irq, NULL, NULL);
+
+	return 0;
+}
+
+static void gicv5_irq_ppi_domain_free(struct irq_domain *domain,
+				      unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d;
+
+	if (WARN_ON(nr_irqs != 1))
+		return;
+
+	d = irq_domain_get_irq_data(domain, virq);
+
+	irq_set_handler(virq, NULL);
+	irq_domain_reset_irq_data(d);
+}
+
+static int gicv5_irq_ppi_domain_select(struct irq_domain *d,
+				       struct irq_fwspec *fwspec,
+				       enum irq_domain_bus_token bus_token)
+{
+	/* Not for us */
+	if (fwspec->fwnode != d->fwnode)
+		return 0;
+
+	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_PPI) {
+		// only handle PPIs
+		return 0;
+	}
+
+	return (d == gicv5_global_data.ppi_domain);
+}
+
+static const struct irq_domain_ops gicv5_irq_ppi_domain_ops = {
+	.translate	= gicv5_irq_ppi_domain_translate,
+	.alloc		= gicv5_irq_ppi_domain_alloc,
+	.free		= gicv5_irq_ppi_domain_free,
+	.select		= gicv5_irq_ppi_domain_select
+};
+
+static inline void handle_irq_per_domain(u32 hwirq)
+{
+	u32 hwirq_id;
+	struct irq_domain *domain = NULL;
+	u8 hwirq_type = FIELD_GET(GICV5_HWIRQ_TYPE, hwirq);
+
+	hwirq_id = FIELD_GET(GICV5_HWIRQ_ID, hwirq);
+
+	if (hwirq_type == GICV5_HWIRQ_TYPE_PPI)
+		domain = gicv5_global_data.ppi_domain;
+
+	if (generic_handle_domain_irq(domain, hwirq_id)) {
+		pr_err("Could not handle, hwirq = 0x%x", hwirq_id);
+		gicv5_hwirq_eoi(hwirq_id, hwirq_type);
+	}
+}
+
+static asmlinkage void __exception_irq_entry
+gicv5_handle_irq(struct pt_regs *regs)
+{
+	u64 ia;
+	bool valid;
+	u32 hwirq;
+
+	ia = gicr_insn(GICV5_OP_GICR_CDIA);
+	valid = GICV5_GIC_CDIA_VALID(ia);
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
+/*
+ * Disable IRQs for the executing CPU
+ */
+static void gicv5_cpu_disable_interrupts(void)
+{
+	u64 cr0;
+
+	// Disable interrupts for the Interrupt Domain
+	cr0 = FIELD_PREP(ICC_CR0_EL1_EN, 0);
+	write_sysreg_s(cr0, SYS_ICC_CR0_EL1);
+}
+
+/*
+ * Enable IRQs for the executing CPU
+ */
+static void gicv5_cpu_enable_interrupts(void)
+{
+	u64 cr0, pcr;
+
+	write_sysreg_s(0, SYS_ICC_PPI_ENABLER0_EL1);
+	write_sysreg_s(0, SYS_ICC_PPI_ENABLER1_EL1);
+
+	gicv5_ppi_priority_init();
+
+	// Explicitly set the physical interrupt priority of the CPU
+	pcr = FIELD_PREP(ICC_PCR_EL1_PRIORITY, GICV5_IRQ_PRIORITY_MI);
+	write_sysreg_s(pcr, SYS_ICC_PCR_EL1);
+
+	// Enable interrupts for the Interrupt Domain
+	cr0 = FIELD_PREP(ICC_CR0_EL1_EN, 1);
+	write_sysreg_s(cr0, SYS_ICC_CR0_EL1);
+}
+
+static int gicv5_starting_cpu(unsigned int cpu)
+{
+	if (WARN(!gicv5_cpuif_has_gcie(),
+	    "GICv5 system components present but CPU does not have FEAT_GCIE"))
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
+}
+
+static int __init gicv5_init_domains(struct fwnode_handle *handle)
+{
+	gicv5_global_data.fwnode = handle;
+	gicv5_global_data.ppi_domain = irq_domain_create_linear(
+		handle, 128, &gicv5_irq_ppi_domain_ops, NULL);
+
+	if (WARN_ON(!gicv5_global_data.ppi_domain))
+		return -ENOMEM;
+	irq_domain_update_bus_token(gicv5_global_data.ppi_domain,
+				    DOMAIN_BUS_WIRED);
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
+static int __init gicv5_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	int ret;
+
+	ret = gicv5_init_domains(&node->fwnode);
+	if (ret)
+		return ret;
+
+	gicv5_set_cpuif_pribits();
+
+	ret = gicv5_starting_cpu(smp_processor_id());
+	if (ret) {
+		gicv5_free_domains();
+		return ret;
+	}
+
+	ret = set_handle_irq(gicv5_handle_irq);
+	if (ret) {
+		gicv5_free_domains();
+		gicv5_cpu_disable_interrupts();
+		return ret;
+	}
+
+	return 0;
+}
+IRQCHIP_DECLARE(gic_v5, "arm,gic-v5", gicv5_of_init);
diff --git a/drivers/irqchip/irq-gic-v5.h b/drivers/irqchip/irq-gic-v5.h
new file mode 100644
index 0000000000000000000000000000000000000000..d8b797cdea2f786646fd88d9c8f60d483380991c
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v5.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 ARM Limited, All Rights Reserved.
+ */
+#ifndef __LINUX_IRQCHIP_GIC_V5_H
+#define __LINUX_IRQCHIP_GIC_V5_H
+
+#include <asm/arch_gicv5.h>
+
+#define GICV5_HWIRQ_ID			GENMASK(23, 0)
+#define GICV5_HWIRQ_TYPE		GENMASK(31, 29)
+#define GICV5_HWIRQ_INTID		GENMASK_ULL(31, 0)
+
+#define GICV5_HWIRQ_TYPE_PPI		UL(0x1)
+
+#define GICV5_PPI_HM_EDGE		UL(0x0)
+#define GICV5_PPI_HM_LEVEL		UL(0x1)
+
+#endif

-- 
2.48.0


