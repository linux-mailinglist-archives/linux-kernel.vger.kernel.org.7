Return-Path: <linux-kernel+bounces-851383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1A3BD6526
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8AB18A40EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F00D26E706;
	Mon, 13 Oct 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHAyMNla"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628425A63D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389418; cv=none; b=szR2rUFqh2SXF1De4o0OkYQcRwzF9gg4Zk8Pn3EmSEec/c/2zQLdofzjJAwnoa2Xyq7PKk4tFt42CARzMVI4KjlvXesblccsS5pSeMGrivnu6n081N83EbMTmN6u0H1jb6dA4AbfAJsLLWblPLRF+ONwnGEI0C9T5t4NG7orVAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389418; c=relaxed/simple;
	bh=Y7mh2qPp6SzQ7DUcQcoBRQY0l4bihE8X4F8ZWmAk48U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ex1f8tIt5DOPnMcsX2QHsPdojHTfNJrcCBoQpzEKGaOAtJj2UO/cjvflg/3Gyfusc6/I3MJMGBMJPfyjRi/vZ2EJ7h8V2LcDYyVZmnnR+D0YDDEcN5WwVmA+SbqMOyoZNOsl3KR/m05SUanNWqQbLuDX1vM55BSijNY4+vEizJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHAyMNla; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760389415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3hHUglpb4HrBk8ZJl5EP6S3/ReBmZLynJKTWiihJ0E=;
	b=DHAyMNla1JtltZNCpDbdsEyYCX4Q3CfvQdoqhANKi0PYfz+0jsIDaBreDYu49ikhBK4pz4
	pOo7/n5jJyBQkhm2BNiuvDcy2yCjGfvGZR29ZMVYtjuXTh4/RQgUndERVISwJLMZN4a56H
	c7yvTbVitZlvbSH8TaPwgupAnsS4bzE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-a809Im8BMqa-7r6Z4o_WkA-1; Mon,
 13 Oct 2025 17:03:31 -0400
X-MC-Unique: a809Im8BMqa-7r6Z4o_WkA-1
X-Mimecast-MFC-AGG-ID: a809Im8BMqa-7r6Z4o_WkA_1760389410
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B6351800452;
	Mon, 13 Oct 2025 21:03:29 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.65.154])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B28C1800447;
	Mon, 13 Oct 2025 21:03:26 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: samuel.holland@sifive.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	cmirabil@redhat.com,
	dramforever@live.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	lzampier@redhat.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	tglx@linutronix.de,
	zhangxincheng@ultrarisc.com
Subject: Re: [PATCH v2 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
Date: Mon, 13 Oct 2025 17:03:18 -0400
Message-ID: <20251013210318.3879203-1-cmirabil@redhat.com>
In-Reply-To: <1ecbd61e-6b3f-42e8-86cd-e1c589a45262@sifive.com>
References: <1ecbd61e-6b3f-42e8-86cd-e1c589a45262@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Samuel - 

On Mon, Oct 13, 2025 at 02:00:29PM -0500, Samuel Holland wrote:
> Hi Lucas,
> 
> On 2025-10-13 6:15 AM, Lucas Zampieri wrote:
> > From: Charles Mirabile <cmirabil@redhat.com>
> > 
> > Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
> > work around a known hardware bug with IRQ claiming.
> > 
> > When claiming an interrupt on the DP1000 PLIC all other interrupts must be
> > disabled before the claim register is accessed to prevent incorrect
> > handling of the interrupt.
> > 
> > When the PLIC_QUIRK_CLAIM_REGISTER is present, during plic_handle_irq
> > the enable state of all interrupts is saved and then all interrupts
> > except for the first pending one are disabled before reading the claim
> > register. The interrupts are then restored before further processing of
> > the claimed interrupt continues.
> 
> Since the workaround requires scanning the pending bits for each interrupt
> anyway, it would be simpler and more efficient to ignore the claim register
> entirely. Call generic_handle_domain_irq() for each interrupt that is (enabled
> AND pending), then clear the pending bit. Then you would not need to save and
> restore the enable registers.
> 
> > The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
> > SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
> > This has no impact on other platforms.
> > 
> > Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> > Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> > Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> > Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 83 ++++++++++++++++++++++++++++++-
> >  1 file changed, 82 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index 9c4af7d58846..a7b51a925e96 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -49,6 +49,8 @@
> >  #define CONTEXT_ENABLE_BASE		0x2000
> >  #define     CONTEXT_ENABLE_SIZE		0x80
> > 
> > +#define PENDING_BASE                    0x1000
> > +
> >  /*
> >   * Each hart context has a set of control registers associated with it.  Right
> >   * now there's only two: a source priority threshold over which the hart will
> > @@ -63,6 +65,7 @@
> >  #define	PLIC_ENABLE_THRESHOLD		0
> > 
> >  #define PLIC_QUIRK_EDGE_INTERRUPT	0
> > +#define PLIC_QUIRK_CLAIM_REGISTER	1
> > 
> >  struct plic_priv {
> >  	struct fwnode_handle *fwnode;
> > @@ -367,6 +370,82 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
> >  	.free		= irq_domain_free_irqs_top,
> >  };
> > 
> > +static bool dp1000_isolate_pending_irq(int nr_irq_groups, u32 ie[],
> > +				       void __iomem *pending,
> > +				       void __iomem *enable)
> > +{
> > +	u32 pending_irqs = 0;
> > +	int i, j;
> > +
> > +	/* Look for first pending interrupt */
> > +	for (i = 0; i < nr_irq_groups; i++) {
> > +		pending_irqs = ie[i] & readl(pending + i * sizeof(u32));
> > +		if (pending_irqs)
> > +			break;
> > +	}
> > +
> > +	if (!pending_irqs)
> > +		return false;
> > +
> > +	/* Disable all interrupts but the first pending one */
> > +	for (j = 0; j < nr_irq_groups; j++) {
> > +		u32 new_mask = 0;
> > +
> > +		if (j == i)
> > +			/* Extract mask with lowest set bit */
> > +			new_mask = (pending_irqs & -pending_irqs);
> > +
> > +		writel(new_mask, enable + j * sizeof(u32));
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static irq_hw_number_t dp1000_get_hwirq(struct plic_handler *handler,
> > +					void __iomem *claim)
> > +{
> > +	void __iomem *enable = handler->enable_base;
> > +	void __iomem *pending = handler->priv->regs + PENDING_BASE;
> > +	int nr_irqs = handler->priv->nr_irqs;
> > +	int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
> > +	int i;
> > +	u32 ie[32] = { 0 };
> > +	irq_hw_number_t hwirq = 0;
> > +
> > +	raw_spin_lock(&handler->enable_lock);
> > +
> > +	/* Save current interrupt enable state */
> > +	for (i = 0; i < nr_irq_groups; i++)
> > +		ie[i] = readl(enable + i * sizeof(u32));
> > +
> > +	if (!dp1000_isolate_pending_irq(nr_irq_groups, ie, pending, enable))
> > +		goto out;
> > +
> > +	hwirq = readl(claim);
> > +
> > +	/* Restore previous state */
> > +	for (i = 0; i < nr_irq_groups; i++)
> > +		writel(ie[i], enable + i * sizeof(u32));
> > +out:
> > +	raw_spin_unlock(&handler->enable_lock);
> > +	return hwirq;
> > +}
> > +
> > +static irq_hw_number_t plic_get_hwirq(struct plic_handler *handler,
> > +				      void __iomem *claim)
> > +{
> > +	/*
> > +	 * Due to a hardware bug in the implementation of the claim register
> > +	 * in the UltraRISC DP1000 platform, other interrupts must be disabled
> > +	 * before reading the claim register and restored afterwards.
> > +	 */
> > +
> > +	if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
> > +		return dp1000_get_hwirq(handler, claim);
> > +
> > +	return readl(claim);
> > +}
> > +
> >  /*
> >   * Handling an interrupt is a two-step process: first you claim the interrupt
> >   * by reading the claim register, then you complete the interrupt by writing
> > @@ -384,7 +463,7 @@ static void plic_handle_irq(struct irq_desc *desc)
> > 
> >  	chained_irq_enter(chip, desc);
> > 
> > -	while ((hwirq = readl(claim))) {
> > +	while ((hwirq = plic_get_hwirq(handler, claim))) {
> 
> This is the hot path for interrupt handling. Instead of checking for the quirk
> on every interrupt, please create a new function that you conditionally pass to
> irq_set_chained_handler(), so the quirk check only happens once at boot.
> 
> Regards,
> Samuel
> 
> >  		int err = generic_handle_domain_irq(handler->priv->irqdomain,
> >  						    hwirq);
> >  		if (unlikely(err)) {
> > @@ -432,6 +511,8 @@ static const struct of_device_id plic_match[] = {
> >  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> >  	{ .compatible = "thead,c900-plic",
> >  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> > +	{ .compatible = "ultrarisc,cp100-plic",
> > +	  .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
> >  	{}
> >  };
> > 
> > --
> > 2.51.0
> > 
> 

Is something like this closer to what you had in mind? I tried it on the
dp1000 and it doesn't work. Obviously it is concievable that I messed up
the logic here, but it also might be the case that reading the claim
register is integral to the proper functioning of the pending bits.

I can confirm that a more minimal change that just moves the quirk check
out of the hot path is fine. Would that be acceptable even if it is not
the most efficient? (in essense take the hunk with new functions from
the original patch but revert the change to `plic_handle_irq` and then add
the hunk that changes probe from this proposed patch and then create
the `plic_handle_irq_dp1000` function as a copy of `plic_handle_irq` where
`dp1000_get_hwirq` is in the loop instead of `readl(claim)`).

Best - Charlie

---
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9c4af7d58846..fcf520ed33fd 100644
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
+#define PLIC_QUIRK_CLAIM_REGISTER	1
 
 struct plic_priv {
 	struct fwnode_handle *fwnode;
@@ -367,6 +370,53 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
 	.free		= irq_domain_free_irqs_top,
 };
 
+static int dp1000_find_pending_irq(struct plic_handler *handler, void __iomem *pending)
+{
+	void __iomem *enable = handler->enable_base;
+	int nr_irqs = handler->priv->nr_irqs;
+	int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
+	u32 pending_irqs = 0;
+	int i;
+
+	raw_spin_lock(&handler->enable_lock);
+	for (i = 0; i < nr_irq_groups; i++) {
+		u32 enable_mask = readl(enable + i * sizeof(u32));
+		u32 pending_mask = readl(pending + i * sizeof(u32));
+		if ((pending_irqs = enable_mask & pending_mask))
+			break;
+	}
+	raw_spin_unlock(&handler->enable_lock);
+
+	if (!pending_irqs)
+		return 0;
+
+	return 32 * i + __ffs(pending_irqs);
+}
+
+static void plic_handle_irq_dp1000(struct irq_desc *desc)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	void __iomem *pending = handler->priv->regs + PENDING_BASE;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	irq_hw_number_t hwirq;
+
+	WARN_ON_ONCE(!handler->present);
+
+	chained_irq_enter(chip, desc);
+
+	while ((hwirq = dp1000_find_pending_irq(handler, pending))) {
+		int err = generic_handle_domain_irq(handler->priv->irqdomain,
+						    hwirq);
+		__plic_toggle(pending, hwirq, 0);
+		if (unlikely(err)) {
+			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
+					    handler->priv->fwnode, hwirq);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
 /*
  * Handling an interrupt is a two-step process: first you claim the interrupt
  * by reading the claim register, then you complete the interrupt by writing
@@ -432,6 +482,8 @@ static const struct of_device_id plic_match[] = {
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
 	{ .compatible = "thead,c900-plic",
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{ .compatible = "ultrarisc,dp1000-plic",
+	  .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
 	{}
 };
 
@@ -666,12 +718,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
 		}
 
 		if (global_setup) {
+			void (*handler_fn)(struct irq_desc *) = plic_handle_irq;
+			if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
+				handler_fn = plic_handle_irq_dp1000;
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
2.43.0



