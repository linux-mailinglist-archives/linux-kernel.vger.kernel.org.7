Return-Path: <linux-kernel+bounces-856870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D543BE54D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8665B358CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF222DCBF8;
	Thu, 16 Oct 2025 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgvTzd7s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAB28E571
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644763; cv=none; b=WYamww3o5N8p16W1Jd8/VcEYLEQfXeJjt9XwMPzfbRRjG4P2HaBiYmjQehlFb2jA7aOKl69Q7blRQxcCD4e4rmyRT7B48R35FBGgrSDDhOn+dHkY7kKN8Aht65rsZXPl56EmhBQh/ywgyt0bEcMbCE++x+DLlIxmROT3kyhn86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644763; c=relaxed/simple;
	bh=v1r09RRdmTv/sSONEGyqY8jOMIMx43ysI3jRXlTrtyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdW5sHwdMhnbFlMuTiTe0TnGqhe6kqBQ7nhQEYf44GtbttzOApkW1ksLRekS6S4DF04yOdaGbba6E2EncSPG/MJtRZJW82PnY296CGFdsyZ1Z+NsPsWbEjLmB2/EypW6h5L7oUHi6A0c3guvk0T4M6YTAqQlH2R/H2YFfrubVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgvTzd7s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760644760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCEsiDPDh/jDT8gp9z2JilzYSPmMLg770WqiOFzsIos=;
	b=fgvTzd7sZ8Z8HCGFOI+xnaky7AmYcsV6hf71/YeF2xfu0h91a3f4dXMkO7bv/iAGhd8laO
	/R1HYrR2N34GcDd3QKXX3Qd18r0eEX+haWCgrdzYYBq3gd0aUfal56m+/R1iaylzOsRlQf
	7W5ysVBu4rPMxVRnm20u6Ymyd7Vpll0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-Y_ECjIluMReSOiA7u55KQQ-1; Thu,
 16 Oct 2025 15:59:17 -0400
X-MC-Unique: Y_ECjIluMReSOiA7u55KQQ-1
X-Mimecast-MFC-AGG-ID: Y_ECjIluMReSOiA7u55KQQ_1760644753
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B5CC1800365;
	Thu, 16 Oct 2025 19:59:13 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.65.154])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1DBE1800446;
	Thu, 16 Oct 2025 19:59:09 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: tglx@linutronix.de
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	cmirabil@redhat.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dramforever@live.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	lzampier@redhat.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	samuel.holland@sifive.com,
	zhangxincheng@ultrarisc.com
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
Date: Thu, 16 Oct 2025 15:58:57 -0400
Message-ID: <20251016195902.338629-1-cmirabil@redhat.com>
In-Reply-To: <87h5vy20o9.ffs@tglx>
References: <87h5vy20o9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Thomas -

On Thu, Oct 16, 2025 at 07:53:26PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 16 2025 at 12:52, Charles Mirabile wrote:
> > On Thu, Oct 16, 2025 at 12:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> >>         bit = ffs(pending) - 1;
> >> >>         handler->enabled_clear[group] |= BIT(bit);
> >> >>         for (int i = 0; i < nr_irq_groups; i++)
> >> >>                 writel_relaxed(handler->enabled_clear[i], enable + i * sizeof(u32));
> >> >>         handler->enabled_clear[group] = 0;
> >> >>
> >> >> No?
> >> >
> >> > Sure that would also work, but why are we using ffs (slow) only to
> >> > shift the result back to make a new mask when (x & -x) is faster and
> >> > skips the intermediate step delivering immediately the mask of the
> >> > lowest bit.
> >>
> >> Because I did not spend time thinking about it.
> >
> > Sorry, did you mean "because I had not considered the original
> > approach carefully enough" or "because this other approach, while
> > slower, is more self evidently correct."
> 
> I did not think about x & -x :)
> 
> >> It's a pointer in struct plic_handler (or whatever it's named) and you
> >> can allocate it when the quirk is required. The pointer is definitely
> >> not a burden for anyone else.
> >
> > This I still don't understand how this is particuarly helpful. Since
> > we are doing mmio, this is going to be an explicit loop and not a
> > memcpy. The code is branchless in either case (set equal for the check
> > of i against j negate and and with mask before loading into the mmio).
> 
> Fair enough. I did not think in RISC ASM :)

What do you think about the attached patch (it should be not corrupt :^)
I think I adressed your concerns, and I ran it through clang-format too.

I folded everything into one diff for ease of review, but when we send it
officially there will be a separate patch for the caching refactor.

Best - Charlie
---
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cbd7697bc148..f8f3384ecaab 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -49,6 +49,8 @@
 #define CONTEXT_ENABLE_BASE		0x2000
 #define     CONTEXT_ENABLE_SIZE		0x80
 
+#define PENDING_BASE                    0x1000
+
 /*
  * Each hart context has a set of control registers associated with it.  Right
  * now there's only two: a source priority threshold over which the hart will
@@ -63,6 +65,7 @@
 #define	PLIC_ENABLE_THRESHOLD		0
 
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
+#define PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM	1
 
 struct plic_priv {
 	struct fwnode_handle *fwnode;
@@ -94,15 +97,22 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type);
 
-static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
+static void __plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 {
-	u32 __iomem *reg = enable_base + (hwirq / 32) * sizeof(u32);
+	u32 __iomem *base = handler->enable_base;
 	u32 hwirq_mask = 1 << (hwirq % 32);
+	int group = hwirq / 32;
+	u32 value;
+
+	value = readl(base + group);
 
 	if (enable)
-		writel(readl(reg) | hwirq_mask, reg);
+		value |= hwirq_mask;
 	else
-		writel(readl(reg) & ~hwirq_mask, reg);
+		value &= ~hwirq_mask;
+
+	handler->enable_save[group] = value;
+	writel(value, base + group);
 }
 
 static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
@@ -110,7 +120,7 @@ static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&handler->enable_lock, flags);
-	__plic_toggle(handler->enable_base, hwirq, enable);
+	__plic_toggle(handler, hwirq, enable);
 	raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 }
 
@@ -247,33 +257,16 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
 
 static int plic_irq_suspend(void)
 {
-	unsigned int i, cpu;
-	unsigned long flags;
-	u32 __iomem *reg;
 	struct plic_priv *priv;
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
 	/* irq ID 0 is reserved */
-	for (i = 1; i < priv->nr_irqs; i++) {
+	for (unsigned int i = 1; i < priv->nr_irqs; i++) {
 		__assign_bit(i, priv->prio_save,
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
 
-	for_each_present_cpu(cpu) {
-		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
-
-		if (!handler->present)
-			continue;
-
-		raw_spin_lock_irqsave(&handler->enable_lock, flags);
-		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
-			reg = handler->enable_base + i * sizeof(u32);
-			handler->enable_save[i] = readl(reg);
-		}
-		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
-	}
-
 	return 0;
 }
 
@@ -398,6 +391,85 @@ static void plic_handle_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static bool cp100_isolate_pending_irq(int nr_irq_groups, u32 ie[],
+				      u32 __iomem *pending,
+				      u32 __iomem *enable)
+{
+	u32 pending_irqs = 0;
+	int i, j;
+
+	/* Look for first pending interrupt */
+	for (i = 0; !pending_irqs && i < nr_irq_groups; i++)
+		pending_irqs = ie[i] & readl_relaxed(pending + i);
+
+	if (!pending_irqs)
+		return false;
+
+	/* Isolate lowest set bit*/
+	pending_irqs &= -pending_irqs;
+
+	/* Disable all interrupts but the first pending one */
+	for (j = 0; j < nr_irq_groups; j++)
+		writel_relaxed(j == i ? pending_irqs : 0, enable + j);
+
+	return true;
+}
+
+static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
+					void __iomem *claim)
+{
+	int nr_irq_groups = DIV_ROUND_UP(handler->priv->nr_irqs, 32);
+	u32 __iomem *pending = handler->priv->regs + PENDING_BASE;
+	u32 __iomem *enable = handler->enable_base;
+	irq_hw_number_t hwirq = 0;
+	int i;
+
+	guard(raw_spinlock)(&handler->enable_lock);
+
+	/* Existing enable state is already cached in enable_save */
+	if (!cp100_isolate_pending_irq(nr_irq_groups, handler->enable_save, pending, enable))
+		return 0;
+
+	/*
+	 * Interrupts delievered to hardware still become pending, but only
+	 * interrupts that are both pending and enabled can be claimed.
+	 * Clearing enable bit for all interrupts but the first pending one
+	 * avoids hardware bug that occurs during read from claim register
+	 * with more than one eligible interrupt.
+	 */
+
+	hwirq = readl(claim);
+
+	/* Restore previous state */
+	for (i = 0; i < nr_irq_groups; i++)
+		writel_relaxed(handler->enable_save[i], enable + i);
+
+	return hwirq;
+}
+
+static void plic_handle_irq_cp100(struct irq_desc *desc)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
+	irq_hw_number_t hwirq;
+
+	WARN_ON_ONCE(!handler->present);
+
+	chained_irq_enter(chip, desc);
+
+	while ((hwirq = cp100_get_hwirq(handler, claim))) {
+		int err = generic_handle_domain_irq(handler->priv->irqdomain, hwirq);
+
+		if (unlikely(err)) {
+			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
+					    handler->priv->fwnode, hwirq);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
 static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
 {
 	/* priority must be > threshold to trigger an interrupt */
@@ -434,6 +506,8 @@ static const struct of_device_id plic_match[] = {
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
 	{ .compatible = "thead,c900-plic",
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{ .compatible = "ultrarisc,cp100-plic",
+	  .data = (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM) },
 	{}
 };
 
@@ -668,12 +742,17 @@ static int plic_probe(struct fwnode_handle *fwnode)
 		}
 
 		if (global_setup) {
+			void (*handler_fn)(struct irq_desc *) = plic_handle_irq;
+
+			if (test_bit(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM, &handler->priv->plic_quirks))
+				handler_fn = plic_handle_irq_cp100;
+
 			/* Find parent domain and register chained handler */
 			domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
 			if (domain)
 				plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
 			if (plic_parent_irq)
-				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
+				irq_set_chained_handler(plic_parent_irq, handler_fn);
 
 			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 					  "irqchip/sifive/plic:starting",
-- 
2.51.0


