Return-Path: <linux-kernel+bounces-841478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EABB7745
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF113BBF98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C42BD5BB;
	Fri,  3 Oct 2025 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1E/4oUl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161229E11A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507546; cv=none; b=oPeuhw/LmUE11KC0Ovq0pzLrsccpS/D3OauQ7vLi226qB5Zk7wbyaL/jOgIit3nCxSt3pExY/bjGWSpZE1ODi0HvgO5md5enZKXI2UOOqggUDgAChT5IkdBy9BnDQ690FXDy6u8/vv579+OmaQB0ZNOMugtjYhVSmDp9gH0GYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507546; c=relaxed/simple;
	bh=CyoLDznRn2p8HKqvr83X+kbuXWFFK/LXspTU9qFcULA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWWgP39Cbsba1AoqhTmATSV8xKgVgkv7qgG1KyetLQmfd1KOIm1+eGfgpbVZVkDLFIxpWyUIBwHcTBKp4pQ0I9v0bNrBwVC8RYFWZP72In9mqOp7be7+UEIfr3m2wHm+fArxhA3w41VMsSxzP0XyFUw+XyVOKSsAHrGmQcRVfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1E/4oUl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759507543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHGW+D+vGYzhHNu1jkYUMa7q0ra1gNLOZtOuho9SWJ8=;
	b=W1E/4oUlg1k+kV0ejeDAw7hzTIkGM6Yeks/2X4PujaEgNVcdhkh6DGtUFYsPtceNXrzuco
	qhyMOtf1HSa+HxeYyJ1mobe0kfhuKVbb2Be33jkOfNufy4woQxWWq69um+eUzTSSE4RXgI
	lMrVX6D5vxanxl0wouavLTT+yOgH788=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-ygVw2LI9MFaMmwWfONZqvg-1; Fri,
 03 Oct 2025 12:05:39 -0400
X-MC-Unique: ygVw2LI9MFaMmwWfONZqvg-1
X-Mimecast-MFC-AGG-ID: ygVw2LI9MFaMmwWfONZqvg_1759507538
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1050C180029B;
	Fri,  3 Oct 2025 16:05:38 +0000 (UTC)
Received: from thinkpad-p1.localdomain.com (unknown [10.22.65.162])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73BF519560B1;
	Fri,  3 Oct 2025 16:05:35 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Jared Kangas <jkangas@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: dwc: Code cleanup
Date: Fri,  3 Oct 2025 12:04:20 -0400
Message-ID: <20251003160421.951448-3-rrendec@redhat.com>
In-Reply-To: <20251003160421.951448-1-rrendec@redhat.com>
References: <20251003160421.951448-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thomas Gleixner <tglx@linutronix.de>

Code cleanup with no functional changes. These changes were originally
made by Thomas Gleixner (see Link tag below) in a patch that was never
submitted as is. Other parts of that patch were eventually submitted as
commit 8e717112caf3 ("PCI: dwc: Switch to msi_create_parent_irq_domain()")
and the remaining parts are the code cleanup changes in this patch.

Summary of changes:
- Use guard()/scoped_guard() instead of open-coded lock/unlock.
- Return void in a few functions whose return value is never used.
- Simplify dw_handle_msi_irq() by using for_each_set_bit().

One notable deviation from the original patch is that I reverted back to
a simple 1 by 1 iteration over the controllers inside dw_handle_msi_irq.
The reason is that with the original changes, the IRQ offset was
calculated incorrectly.

This patch also prepares the ground for the next patch in the series,
which enables MSI affinity support, and was originally part of that same
series that Thomas Gleixner prepared.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
Co-developed-by: Radu Rendec <rrendec@redhat.com>
Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 98 ++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h  |  7 +-
 2 files changed, 34 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b5012..3ee6a464726ec 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -42,35 +42,25 @@ static const struct msi_parent_ops dw_pcie_msi_parent_ops = {
 };
 
 /* MSI int handler */
-irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
+void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 {
-	int i, pos;
-	unsigned long val;
-	u32 status, num_ctrls;
-	irqreturn_t ret = IRQ_NONE;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	unsigned int i, num_ctrls;
 
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 	for (i = 0; i < num_ctrls; i++) {
-		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
-					   (i * MSI_REG_CTRL_BLOCK_SIZE));
+		unsigned int reg_off = i * MSI_REG_CTRL_BLOCK_SIZE;
+		unsigned int irq_off = i * MAX_MSI_IRQS_PER_CTRL;
+		unsigned long status, pos;
+
+		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS + reg_off);
 		if (!status)
 			continue;
 
-		ret = IRQ_HANDLED;
-		val = status;
-		pos = 0;
-		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
-					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
-			generic_handle_domain_irq(pp->irq_domain,
-						  (i * MAX_MSI_IRQS_PER_CTRL) +
-						  pos);
-			pos++;
-		}
+		for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
+			generic_handle_domain_irq(pp->irq_domain, irq_off + pos);
 	}
-
-	return ret;
 }
 
 /* Chained MSI interrupt service routine */
@@ -91,13 +81,10 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u64 msi_target;
-
-	msi_target = (u64)pp->msi_data;
+	u64 msi_target = (u64)pp->msi_data;
 
 	msg->address_lo = lower_32_bits(msi_target);
 	msg->address_hi = upper_32_bits(msi_target);
-
 	msg->data = d->hwirq;
 
 	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
@@ -109,18 +96,14 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	unsigned int res, bit, ctrl;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
 
+	guard(raw_spinlock)(&pp->lock);
 	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 	pp->irq_mask[ctrl] |= BIT(bit);
 	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static void dw_pci_bottom_unmask(struct irq_data *d)
@@ -128,18 +111,14 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	unsigned int res, bit, ctrl;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
 
+	guard(raw_spinlock)(&pp->lock);
 	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 	pp->irq_mask[ctrl] &= ~BIT(bit);
 	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static void dw_pci_bottom_ack(struct irq_data *d)
@@ -156,54 +135,42 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 }
 
 static struct irq_chip dw_pci_msi_bottom_irq_chip = {
-	.name = "DWPCI-MSI",
-	.irq_ack = dw_pci_bottom_ack,
-	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
-	.irq_mask = dw_pci_bottom_mask,
-	.irq_unmask = dw_pci_bottom_unmask,
+	.name			= "DWPCI-MSI",
+	.irq_ack		= dw_pci_bottom_ack,
+	.irq_compose_msi_msg	= dw_pci_setup_msi_msg,
+	.irq_mask		= dw_pci_bottom_mask,
+	.irq_unmask		= dw_pci_bottom_unmask,
 };
 
-static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
-				    unsigned int virq, unsigned int nr_irqs,
-				    void *args)
+static int dw_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs, void *args)
 {
 	struct dw_pcie_rp *pp = domain->host_data;
-	unsigned long flags;
-	u32 i;
 	int bit;
 
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
-	bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
-				      order_base_2(nr_irqs));
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
+	scoped_guard (raw_spinlock_irq, &pp->lock) {
+		bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
+					      order_base_2(nr_irqs));
+	}
 
 	if (bit < 0)
 		return -ENOSPC;
 
-	for (i = 0; i < nr_irqs; i++)
-		irq_domain_set_info(domain, virq + i, bit + i,
-				    pp->msi_irq_chip,
-				    pp, handle_edge_irq,
-				    NULL, NULL);
-
+	for (unsigned int i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, bit + i, pp->msi_irq_chip,
+				    pp, handle_edge_irq, NULL, NULL);
+	}
 	return 0;
 }
 
-static void dw_pcie_irq_domain_free(struct irq_domain *domain,
-				    unsigned int virq, unsigned int nr_irqs)
+static void dw_pcie_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct dw_pcie_rp *pp = domain->host_data;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	bitmap_release_region(pp->msi_irq_in_use, d->hwirq,
-			      order_base_2(nr_irqs));
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
+	guard(raw_spinlock_irq)(&pp->lock);
+	bitmap_release_region(pp->msi_irq_in_use, d->hwirq, order_base_2(nr_irqs));
 }
 
 static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
@@ -236,8 +203,7 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 
 	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
 		if (pp->msi_irq[ctrl] > 0)
-			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
-							 NULL, NULL);
+			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
 	}
 
 	irq_domain_remove(pp->irq_domain);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcdd..226aac41836bc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -753,7 +753,7 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 #ifdef CONFIG_PCIE_DW_HOST
 int dw_pcie_suspend_noirq(struct dw_pcie *pci);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);
-irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
+void dw_handle_msi_irq(struct dw_pcie_rp *pp);
 void dw_pcie_msi_init(struct dw_pcie_rp *pp);
 int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_free_msi(struct dw_pcie_rp *pp);
@@ -774,10 +774,7 @@ static inline int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	return 0;
 }
 
-static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
-{
-	return IRQ_NONE;
-}
+static inline void dw_handle_msi_irq(struct dw_pcie_rp *pp) { }
 
 static inline void dw_pcie_msi_init(struct dw_pcie_rp *pp)
 { }
-- 
2.51.0


