Return-Path: <linux-kernel+bounces-867714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE53C03581
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB2C1A014BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B505C264A8D;
	Thu, 23 Oct 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ir9sVXwa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608DD142E83
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250662; cv=none; b=PdgBMGaYBR2tzzj3ZjJVM/FwrjyYethwO9ED27B0+fI9NdWdXDmzp0ghX4svz2rNudkLRCyruiWLuI9HK5W+fRE91FFAAnfSe3DiyhKKhLbi5SjsTW/uQBIz7yxFYOPo/zyDwcUlgRk5s/6QVFUB/TWiMCNg8FKar4QOhQjnKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250662; c=relaxed/simple;
	bh=1fyib0gfkn91bUXd587VUurecASVm6R2t3RGKOVNru0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXfUn5AYN9nHDLZdcpmIxUEOwyQkZjoWHPtEymoagm4GvrBxtA1fuQOeVw2qUysa3cZOCVi44SIfhGWphMFLzYsYrNVt0euqrz3BNLZz3LzfXC78zcehqRj80DcYmV2xxWlVkJQF1NKKuqwDkwN3+L75DDb4lKDkCJIIEUxZL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ir9sVXwa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761250657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkzVhL/+U7KTZ+Wu2Xt5iRP9SLK+it5gBEjbIIA64Vk=;
	b=ir9sVXwa8w5RJlweNDQeUEoA8PSyyYzSM4SM7RIGEZ0N9JTsbP2ckcqpFwe1raaBPRQHp1
	Xd0tnFSKRvJIHe7/AF3Yhsn9Xi2yiEkB69FZUPpwxnwFDa7x6WMmaWr31XR+UWHecjb1+d
	udv78838GnWu+m5ooJIa4TPludv0F9w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-OivIpowCNXGLOp68BpIWyw-1; Thu,
 23 Oct 2025 16:17:33 -0400
X-MC-Unique: OivIpowCNXGLOp68BpIWyw-1
X-Mimecast-MFC-AGG-ID: OivIpowCNXGLOp68BpIWyw_1761250651
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8652195608E;
	Thu, 23 Oct 2025 20:17:29 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.64.45])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA49F30002D7;
	Thu, 23 Oct 2025 20:17:25 +0000 (UTC)
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
	samuel.holland@sifive.com
Subject: Re: [PATCH v6 0/4] Add UltraRISC DP1000 PLIC support
Date: Thu, 23 Oct 2025 16:17:19 -0400
Message-ID: <20251023201721.549563-1-cmirabil@redhat.com>
In-Reply-To: <87zf9hwh5j.ffs@tglx>
References: <87zf9hwh5j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Thomas—

On Thu, Oct 23, 2025 at 09:29:44PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 23 2025 at 15:00, Lucas Zampieri wrote:
> > This series adds support for the PLIC implementation in the UltraRISC
> > DP1000 SoC. The UR-CP100 cores used in the DP1000 have a hardware bug in
> > their PLIC claim register where reading it while multiple interrupts are
> > pending can return the wrong interrupt ID. The workaround temporarily
> > disables all interrupts except the first pending one before reading the
> > claim register, then restores the previous state.
> >
> > The driver matches on "ultrarisc,cp100-plic" (CPU core compatible), allowing
> > the quirk to apply to all SoCs using UR-CP100 cores (currently DP1000,
> > potentially future SoCs).
> >
> > Charles Mirabile (3):
> >   dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
> >   irqchip/plic: enable optimization of interrupt enable state
> 
>     That one never showed up. Neither in my inbox nor on lore

Looks like the CC list was missing somehow from that patch—I didn't notice because I got it in my inbox because of my Signed-off-by.

The indexing on the patches was slightly wrong anyways, so we will resend tomorrow. Sorry for the noise.

I have attached it here in case you want to take a look.

> 
-- >8 --
From: Charles Mirabile <cmirabil@redhat.com>
Subject: [PATCH v6 3/4] irqchip/plic: enable optimization of interrupt enable state

Optimize the PLIC driver by maintaining the interrupt enable state in
the handler's enable_save array during normal operation rather than only
during suspend/resume. This eliminates the need to read enable registers
during suspend and makes the enable state immediately available for
other optimizations.

Modify __plic_toggle() to take a handler pointer instead of enable_base,
allowing it to update both the hardware registers and the cached
enable_save state atomically within the existing enable_lock protection.

Remove the suspend-time enable register reading since enable_save now
always reflects the current state.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>

---
 drivers/irqchip/irq-sifive-plic.c | 36 +++++++++++--------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cbd7697bc1481..d518a8b468742 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -94,15 +94,22 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
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
@@ -110,7 +117,7 @@ static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&handler->enable_lock, flags);
-	__plic_toggle(handler->enable_base, hwirq, enable);
+	__plic_toggle(handler, hwirq, enable);
 	raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 }
 
@@ -247,33 +254,16 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
 
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

--
2.51.0



