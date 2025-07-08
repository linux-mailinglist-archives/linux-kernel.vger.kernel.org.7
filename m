Return-Path: <linux-kernel+bounces-722179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E478AFD64F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EF816E6CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184EA2E6D0D;
	Tue,  8 Jul 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hr0DosaA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Go1PA1/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E421ADC9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998825; cv=none; b=bG1HCIloIUFdM73T4gA2xd1ODz8oi8Rmua/vVpfUMwLlmOKaA4fzBYErdLRMjPBZJjTuPZuiZrR29dlKmd2S2PmaQCx31IiF6tdl2m4Ss4IDNkMxkyIcSfcjjz/YxbBIX59eBmCdVFiUdyW+Vaj9b98sSVp8TyxKORyti7K9aKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998825; c=relaxed/simple;
	bh=MCYbyCr2lge2s4NUemND55jxvcmt3mCbqFwNSuTOvy0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o4tiGRwndBUml5so7+/gWJ6DN7R1Tm9i3rGM9v2oCyVjxp15jKooQqpVc1tEcSY4sa/dEJ5R3baNihkfznvIXSD1P3MxkiiObu8NyjAbFla580JBMMqLUoInb/xzg5VpOVtDogfEs1Jqa4pJVvd+9ILLr1XWZBIuNF7Tlu6JDuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hr0DosaA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Go1PA1/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998821;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FSNnqqeqXkB++eQgYtyhsNCIW1bhY6Le0rmajb37f8=;
	b=hr0DosaASpAHyftF2zsVBER3KNBRZeaOpQJXtgTtT+UIURWKYETMTBLOpyb975alEVozAQ
	UmnFHdfeJO01OhtD63FEnBbiapijxsBFKRWASiFiuAYdHvuC6kYIvxANBLN539gQCuFDy1
	JiVU/TVvcAFHXQfU9ebVvw9X18xlVEG+bPK/uInpssPLt29duyh0evllfOQMAWZEdkKjBQ
	9keNDZL78jsLXuXmuF7UKhloDDM3RmP7JTSLmDuL+fIjywKLhQ4UoKg1gkaVcjf9tvtVfX
	nluuRwotMzrIm2FUwGK4ZHIfaPJprEfpta+KkL8GU0J0hdQYK6tsujIPSz0nOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998821;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FSNnqqeqXkB++eQgYtyhsNCIW1bhY6Le0rmajb37f8=;
	b=+Go1PA1/38tXdkbu+Dj5RzYLBYUbxLHBn8ebTQuYnyelhzK6qxMEqFJqsKJGjarhVh479K
	+47WQ6pwqVtNeiCQ==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v5: Add GICv5 IWB support
Cc: Sascha Bischoff <sascha.bischoff@arm.com>,
 Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20250703-gicv5-host-v7-29-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-29-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199881984.406.13527570499046619953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     695949d8b16f11f2f172d8d0c7ccc1ae09ed6cb7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/695949d8b16f11f2f172d8d0c7ccc1ae09ed6cb7
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:19 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:52 +01:00

irqchip/gic-v5: Add GICv5 IWB support

The GICv5 architecture implements the Interrupt Wire Bridge (IWB) in
order to support wired interrupts that cannot be connected directly
to an IRS and instead uses the ITS to translate a wire event into
an IRQ signal.

Add the wired-to-MSI IWB driver to manage IWB wired interrupts.

An IWB is connected to an ITS and it has its own deviceID for all
interrupt wires that it manages; the IWB input wire number must be
exposed to the ITS as an eventID with a 1:1 mapping.

This eventID is not programmable and therefore requires a new
msi_alloc_info_t flag to make sure the ITS driver does not allocate
an eventid for the wire but rather it uses the msi_alloc_info_t.hwirq
number to gather the ITS eventID.

Co-developed-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Co-developed-by: Timothy Hayes <timothy.hayes@arm.com>
Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-29-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Makefile           |   3 +-
 drivers/irqchip/irq-gic-v5-its.c   |  40 +++-
 drivers/irqchip/irq-gic-v5-iwb.c   | 284 ++++++++++++++++++++++++++++-
 include/asm-generic/msi.h          |   1 +-
 include/linux/irqchip/arm-gic-v5.h |  17 ++-
 5 files changed, 335 insertions(+), 10 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-v5-iwb.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5459f66..e83dad9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -37,7 +37,8 @@ obj-$(CONFIG_ARM_GIC_ITS_PARENT)	+= irq-gic-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
-obj-$(CONFIG_ARM_GIC_V5)		+= irq-gic-v5.o irq-gic-v5-irs.o irq-gic-v5-its.o
+obj-$(CONFIG_ARM_GIC_V5)		+= irq-gic-v5.o irq-gic-v5-irs.o irq-gic-v5-its.o \
+					   irq-gic-v5-iwb.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 700df6d..340640f 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -880,19 +880,41 @@ static void gicv5_its_unmap_event(struct gicv5_its_dev *its_dev, u16 event_id)
 	gicv5_its_itt_cache_inv(its, its_dev->device_id, event_id);
 }
 
-static int gicv5_its_alloc_eventid(struct gicv5_its_dev *its_dev,
+static int gicv5_its_alloc_eventid(struct gicv5_its_dev *its_dev, msi_alloc_info_t *info,
 				   unsigned int nr_irqs, u32 *eventid)
 {
-	int ret;
+	int event_id_base;
+
+	if (!(info->flags & MSI_ALLOC_FLAGS_FIXED_MSG_DATA)) {
+		event_id_base = bitmap_find_free_region(its_dev->event_map,
+							its_dev->num_events,
+							get_count_order(nr_irqs));
+		if (event_id_base < 0)
+			return event_id_base;
+	} else {
+		/*
+		 * We want to have a fixed EventID mapped for hardcoded
+		 * message data allocations.
+		 */
+		if (WARN_ON_ONCE(nr_irqs != 1))
+			return -EINVAL;
 
-	ret = bitmap_find_free_region(its_dev->event_map,
-				      its_dev->num_events,
-				      get_count_order(nr_irqs));
+		event_id_base = info->hwirq;
 
-	if (ret < 0)
-		return ret;
+		if (event_id_base >= its_dev->num_events) {
+			pr_err("EventID ouside of ITT range; cannot allocate an ITT entry!\n");
+
+			return -EINVAL;
+		}
+
+		if (test_and_set_bit(event_id_base, its_dev->event_map)) {
+			pr_warn("Can't reserve event_id bitmap\n");
+			return -EINVAL;
+
+		}
+	}
 
-	*eventid = ret;
+	*eventid = event_id_base;
 
 	return 0;
 }
@@ -916,7 +938,7 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
 
 	its_dev = info->scratchpad[0].ptr;
 
-	ret = gicv5_its_alloc_eventid(its_dev, nr_irqs, &event_id_base);
+	ret = gicv5_its_alloc_eventid(its_dev, info, nr_irqs, &event_id_base);
 	if (ret)
 		return ret;
 
diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iwb.c
new file mode 100644
index 0000000..ed72fbd
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v5-iwb.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024-2025 ARM Limited, All Rights Reserved.
+ */
+#define pr_fmt(fmt)	"GICv5 IWB: " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic-v5.h>
+
+struct gicv5_iwb_chip_data {
+	void __iomem	*iwb_base;
+	u16		nr_regs;
+};
+
+static u32 iwb_readl_relaxed(struct gicv5_iwb_chip_data *iwb_node, const u32 reg_offset)
+{
+	return readl_relaxed(iwb_node->iwb_base + reg_offset);
+}
+
+static void iwb_writel_relaxed(struct gicv5_iwb_chip_data *iwb_node, const u32 val,
+			       const u32 reg_offset)
+{
+	writel_relaxed(val, iwb_node->iwb_base + reg_offset);
+}
+
+static int gicv5_iwb_wait_for_wenabler(struct gicv5_iwb_chip_data *iwb_node)
+{
+	return gicv5_wait_for_op_atomic(iwb_node->iwb_base, GICV5_IWB_WENABLE_STATUSR,
+					GICV5_IWB_WENABLE_STATUSR_IDLE, NULL);
+}
+
+static int __gicv5_iwb_set_wire_enable(struct gicv5_iwb_chip_data *iwb_node,
+				       u32 iwb_wire, bool enable)
+{
+	u32 n = iwb_wire / 32;
+	u8 i = iwb_wire % 32;
+	u32 val;
+
+	if (n >= iwb_node->nr_regs) {
+		pr_err("IWB_WENABLER<n> is invalid for n=%u\n", n);
+		return -EINVAL;
+	}
+
+	/*
+	 * Enable IWB wire/pin at this point
+	 * Note: This is not the same as enabling the interrupt
+	 */
+	val = iwb_readl_relaxed(iwb_node, GICV5_IWB_WENABLER + (4 * n));
+	if (enable)
+		val |= BIT(i);
+	else
+		val &= ~BIT(i);
+	iwb_writel_relaxed(iwb_node, val, GICV5_IWB_WENABLER + (4 * n));
+
+	return gicv5_iwb_wait_for_wenabler(iwb_node);
+}
+
+static int gicv5_iwb_enable_wire(struct gicv5_iwb_chip_data *iwb_node,
+				 u32 iwb_wire)
+{
+	return __gicv5_iwb_set_wire_enable(iwb_node, iwb_wire, true);
+}
+
+static int gicv5_iwb_disable_wire(struct gicv5_iwb_chip_data *iwb_node,
+				  u32 iwb_wire)
+{
+	return __gicv5_iwb_set_wire_enable(iwb_node, iwb_wire, false);
+}
+
+static void gicv5_iwb_irq_disable(struct irq_data *d)
+{
+	struct gicv5_iwb_chip_data *iwb_node = irq_data_get_irq_chip_data(d);
+
+	gicv5_iwb_disable_wire(iwb_node, d->hwirq);
+	irq_chip_disable_parent(d);
+}
+
+static void gicv5_iwb_irq_enable(struct irq_data *d)
+{
+	struct gicv5_iwb_chip_data *iwb_node = irq_data_get_irq_chip_data(d);
+
+	gicv5_iwb_enable_wire(iwb_node, d->hwirq);
+	irq_chip_enable_parent(d);
+}
+
+static int gicv5_iwb_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gicv5_iwb_chip_data *iwb_node = irq_data_get_irq_chip_data(d);
+	u32 iwb_wire, n, wtmr;
+	u8 i;
+
+	iwb_wire = d->hwirq;
+	i = iwb_wire % 32;
+	n = iwb_wire / 32;
+
+	if (n >= iwb_node->nr_regs) {
+		pr_err_once("reg %u out of range\n", n);
+		return -EINVAL;
+	}
+
+	wtmr = iwb_readl_relaxed(iwb_node, GICV5_IWB_WTMR + (4 * n));
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_LEVEL_LOW:
+		wtmr |= BIT(i);
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+		wtmr &= ~BIT(i);
+		break;
+	default:
+		pr_debug("unexpected wire trigger mode");
+		return -EINVAL;
+	}
+
+	iwb_writel_relaxed(iwb_node, wtmr, GICV5_IWB_WTMR + (4 * n));
+
+	return 0;
+}
+
+static void gicv5_iwb_domain_set_desc(msi_alloc_info_t *alloc_info, struct msi_desc *desc)
+{
+	alloc_info->desc = desc;
+	alloc_info->hwirq = (u32)desc->data.icookie.value;
+}
+
+static int gicv5_iwb_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+					  irq_hw_number_t *hwirq,
+					  unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode))
+		return -EINVAL;
+
+	if (fwspec->param_count < 2)
+		return -EINVAL;
+
+	/*
+	 * param[0] is be the wire
+	 * param[1] is the interrupt type
+	 */
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static void gicv5_iwb_write_msi_msg(struct irq_data *d, struct msi_msg *msg) {}
+
+static const struct msi_domain_template iwb_msi_template = {
+	.chip = {
+		.name			= "GICv5-IWB",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_enable		= gicv5_iwb_irq_enable,
+		.irq_disable		= gicv5_iwb_irq_disable,
+		.irq_eoi		= irq_chip_eoi_parent,
+		.irq_set_type		= gicv5_iwb_set_type,
+		.irq_write_msi_msg	= gicv5_iwb_write_msi_msg,
+		.irq_set_affinity	= irq_chip_set_affinity_parent,
+		.irq_get_irqchip_state	= irq_chip_get_parent_state,
+		.irq_set_irqchip_state	= irq_chip_set_parent_state,
+		.flags			= IRQCHIP_SET_TYPE_MASKED |
+					  IRQCHIP_SKIP_SET_WAKE |
+					  IRQCHIP_MASK_ON_SUSPEND,
+	},
+
+	.ops = {
+		.set_desc		= gicv5_iwb_domain_set_desc,
+		.msi_translate		= gicv5_iwb_irq_domain_translate,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			= MSI_FLAG_USE_DEV_FWNODE,
+	},
+
+	.alloc_info = {
+		.flags			= MSI_ALLOC_FLAGS_FIXED_MSG_DATA,
+	},
+};
+
+static bool gicv5_iwb_create_device_domain(struct device *dev, unsigned int size,
+				     struct gicv5_iwb_chip_data *iwb_node)
+{
+	if (WARN_ON_ONCE(!dev->msi.domain))
+		return false;
+
+	return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					    &iwb_msi_template, size,
+					    NULL, iwb_node);
+}
+
+static struct gicv5_iwb_chip_data *
+gicv5_iwb_init_bases(void __iomem *iwb_base, struct platform_device *pdev)
+{
+	u32 nr_wires, idr0, cr0;
+	unsigned int n;
+	int ret;
+
+	struct gicv5_iwb_chip_data *iwb_node __free(kfree) = kzalloc(sizeof(*iwb_node),
+								     GFP_KERNEL);
+	if (!iwb_node)
+		return ERR_PTR(-ENOMEM);
+
+	iwb_node->iwb_base = iwb_base;
+
+	idr0 = iwb_readl_relaxed(iwb_node, GICV5_IWB_IDR0);
+	nr_wires = (FIELD_GET(GICV5_IWB_IDR0_IW_RANGE, idr0) + 1) * 32;
+
+	cr0 = iwb_readl_relaxed(iwb_node, GICV5_IWB_CR0);
+	if (!FIELD_GET(GICV5_IWB_CR0_IWBEN, cr0)) {
+		dev_err(&pdev->dev, "IWB must be enabled in firmware\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	iwb_node->nr_regs = FIELD_GET(GICV5_IWB_IDR0_IW_RANGE, idr0) + 1;
+
+	for (n = 0; n < iwb_node->nr_regs; n++)
+		iwb_writel_relaxed(iwb_node, 0, GICV5_IWB_WENABLER + (sizeof(u32) * n));
+
+	ret = gicv5_iwb_wait_for_wenabler(iwb_node);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!gicv5_iwb_create_device_domain(&pdev->dev, nr_wires, iwb_node))
+		return ERR_PTR(-ENOMEM);
+
+	return_ptr(iwb_node);
+}
+
+static int gicv5_iwb_device_probe(struct platform_device *pdev)
+{
+	struct gicv5_iwb_chip_data *iwb_node;
+	void __iomem *iwb_base;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	iwb_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!iwb_base) {
+		dev_err(&pdev->dev, "failed to ioremap %pR\n", res);
+		return -ENOMEM;
+	}
+
+	iwb_node = gicv5_iwb_init_bases(iwb_base, pdev);
+	if (IS_ERR(iwb_node)) {
+		ret = PTR_ERR(iwb_node);
+		goto out_unmap;
+	}
+
+	return 0;
+
+out_unmap:
+	iounmap(iwb_base);
+	return ret;
+}
+
+static const struct of_device_id gicv5_iwb_of_match[] = {
+	{ .compatible = "arm,gic-v5-iwb" },
+	{ /* END */ }
+};
+MODULE_DEVICE_TABLE(of, gicv5_iwb_of_match);
+
+static struct platform_driver gicv5_iwb_platform_driver = {
+	.driver = {
+		.name			= "GICv5 IWB",
+		.of_match_table		= gicv5_iwb_of_match,
+		.suppress_bind_attrs	= true,
+	},
+	.probe				= gicv5_iwb_device_probe,
+};
+
+module_platform_driver(gicv5_iwb_platform_driver);
diff --git a/include/asm-generic/msi.h b/include/asm-generic/msi.h
index 124c734..92cca4b 100644
--- a/include/asm-generic/msi.h
+++ b/include/asm-generic/msi.h
@@ -33,6 +33,7 @@ typedef struct msi_alloc_info {
 
 /* Device generating MSIs is proxying for another device */
 #define MSI_ALLOC_FLAGS_PROXY_DEVICE	(1UL << 0)
+#define MSI_ALLOC_FLAGS_FIXED_MSG_DATA	(1UL << 1)
 
 #define GENERIC_MSI_DOMAIN_OPS		1
 
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-gic-v5.h
index 07b9525..68ddcdb 100644
--- a/include/linux/irqchip/arm-gic-v5.h
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -249,6 +249,23 @@
 #define GICV5_ITS_HWIRQ_EVENT_ID		GENMASK_ULL(63, 32)
 
 /*
+ * IWB registers
+ */
+#define GICV5_IWB_IDR0				0x0000
+#define GICV5_IWB_CR0				0x0080
+#define GICV5_IWB_WENABLE_STATUSR		0x00c0
+#define GICV5_IWB_WENABLER			0x2000
+#define GICV5_IWB_WTMR				0x4000
+
+#define GICV5_IWB_IDR0_INT_DOMS			GENMASK(14, 11)
+#define GICV5_IWB_IDR0_IW_RANGE			GENMASK(10, 0)
+
+#define GICV5_IWB_CR0_IDLE			BIT(1)
+#define GICV5_IWB_CR0_IWBEN			BIT(0)
+
+#define GICV5_IWB_WENABLE_STATUSR_IDLE		BIT(0)
+
+/*
  * Global Data structures and functions
  */
 struct gicv5_chip_data {

