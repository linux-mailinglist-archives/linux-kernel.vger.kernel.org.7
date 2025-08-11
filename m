Return-Path: <linux-kernel+bounces-762223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 219DAB203AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F93D17BA21
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1332E173F;
	Mon, 11 Aug 2025 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/9xn9Xx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gsu9AzgU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DDD2DECAF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904547; cv=none; b=SABcMSO28tRz0Ki6mKqq3Enxj4Tip5D2OKWscb1oJRk0FaEUa6kLG9tT3bQlriGBoyKdVuvtwGnINf/hilmjP4zm9xF7I/sMK8Wz/clgG+8wxXgxoXIuGU54LH9KCCP/pESJUW1aNyzHaTxBvEt8qWVKaE4yMkGofAr6C3mCA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904547; c=relaxed/simple;
	bh=iJcFQqDy8eP+MH0TvrUbe54T7dAWoywRDid7QR7ob8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M45A6qWFM2wUSgGi6gtiTdAD9htQMCIOrHZWKRmM4c+Dg4uHVnvpkHYH+BrRlYUv8Zh3rVUVcU3KrQreXafXiXjaTu4QaIbEgXLwCkpBmG+6szETo0xhehuIiomzo4ib2Bk68Ec5JKZRaVs6XNr2jEIV14ayXJSOW0FKJCUrNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2/9xn9Xx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gsu9AzgU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754904542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8zWEyROxdIAiNmIXoB2YUo/KaB4rPfzDkAgJIDKX4M=;
	b=2/9xn9XxPMEPfoN0FaV24ZGYdGjco6YLZ6cwaWE7EPNJiYR1zl9cxuyARqLuKd4VJSmdNc
	oM9bYL7IvrCb4VaYjp1BrGC6WXSypNBpnHwv6WKzRLlsttYOXSOJwepDkgnWuOtrYA1krD
	oNK54ARyoWlvOF7ESCruxdvCg6RSovfjKo6N1FFzCNhrPfdW8f3rWdKNnWIC/6YQQWO3Oc
	aWoNNg/dK93vA3qoXcZQno3nlGEzZbvG1cR+YJzt2+cLx3KCJUue/YPQc+HbPkCOCaRS2i
	OVqO72Xq4zB61z5Dm2G8cdU7Pu1rFecwR0QU60IfVcqTMXRY6UuNBIjTL5e2IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754904542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8zWEyROxdIAiNmIXoB2YUo/KaB4rPfzDkAgJIDKX4M=;
	b=Gsu9AzgUbR19sMTYfhR2et+Iukanoz7NWS9pZv/g6Ore5nPmlJsTgaWUQcWaVc22/NfE3a
	DvWAehiBmSp4OjAw==
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Gautam Menghani <gautam@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 1/3] powerpc/xive: Untangle xive from child interrupt controller drivers
Date: Mon, 11 Aug 2025 11:28:54 +0200
Message-Id: <83968073022a4cc211dcbd0faccd20ec05e58c3e.1754903590.git.namcao@linutronix.de>
In-Reply-To: <cover.1754903590.git.namcao@linutronix.de>
References: <cover.1754903590.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

xive-specific data is stored in handler_data. This creates a mess, as xive
has to rely on child interrupt controller drivers to clean up this data, as
was done by 9a014f45688 ("powerpc/pseries/pci: Add a msi_free() handler to
clear XIVE data").

Instead, store xive-specific data in chip_data and untangle the child
drivers.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2: no change
---
 arch/powerpc/include/asm/xive.h           |  1 -
 arch/powerpc/platforms/powernv/pci-ioda.c | 21 +-------
 arch/powerpc/platforms/pseries/msi.c      | 18 +------
 arch/powerpc/sysdev/xive/common.c         | 63 +++++++++++------------
 4 files changed, 33 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xiv=
e.h
index 92930b0b5d0e..efb0f5effcc6 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -111,7 +111,6 @@ void xive_native_free_vp_block(u32 vp_base);
 int xive_native_populate_irq_data(u32 hw_irq,
 				  struct xive_irq_data *data);
 void xive_cleanup_irq_data(struct xive_irq_data *xd);
-void xive_irq_free_data(unsigned int virq);
 void xive_native_free_irq(u32 irq);
 int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq);
=20
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index d8ccf2c9b98a..fb37098d4d58 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -37,7 +37,6 @@
 #include <asm/firmware.h>
 #include <asm/pnv-pci.h>
 #include <asm/mmzone.h>
-#include <asm/xive.h>
=20
 #include "powernv.h"
 #include "pci.h"
@@ -1707,23 +1706,6 @@ static int __pnv_pci_ioda_msi_setup(struct pnv_phb *=
phb, struct pci_dev *dev,
 	return 0;
 }
=20
-/*
- * The msi_free() op is called before irq_domain_free_irqs_top() when
- * the handler data is still available. Use that to clear the XIVE
- * controller.
- */
-static void pnv_msi_ops_msi_free(struct irq_domain *domain,
-				 struct msi_domain_info *info,
-				 unsigned int irq)
-{
-	if (xive_enabled())
-		xive_irq_free_data(irq);
-}
-
-static struct msi_domain_ops pnv_pci_msi_domain_ops =3D {
-	.msi_free	=3D pnv_msi_ops_msi_free,
-};
-
 static void pnv_msi_shutdown(struct irq_data *d)
 {
 	d =3D d->parent_data;
@@ -1754,7 +1736,6 @@ static struct irq_chip pnv_pci_msi_irq_chip =3D {
 static struct msi_domain_info pnv_msi_domain_info =3D {
 	.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX),
-	.ops   =3D &pnv_pci_msi_domain_ops,
 	.chip  =3D &pnv_pci_msi_irq_chip,
 };
=20
@@ -1870,7 +1851,7 @@ static void pnv_irq_domain_free(struct irq_domain *do=
main, unsigned int virq,
 		 virq, d->hwirq, nr_irqs);
=20
 	msi_bitmap_free_hwirqs(&phb->msi_bmp, d->hwirq, nr_irqs);
-	/* XIVE domain is cleared through ->msi_free() */
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
=20
 static const struct irq_domain_ops pnv_irq_domain_ops =3D {
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/=
pseries/msi.c
index ee1c8c6898a3..10712477938e 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -15,7 +15,6 @@
 #include <asm/hw_irq.h>
 #include <asm/ppc-pci.h>
 #include <asm/machdep.h>
-#include <asm/xive.h>
=20
 #include "pseries.h"
=20
@@ -436,19 +435,6 @@ static int pseries_msi_ops_prepare(struct irq_domain *=
domain, struct device *dev
 	return rtas_prepare_msi_irqs(pdev, nvec, type, arg);
 }
=20
-/*
- * ->msi_free() is called before irq_domain_free_irqs_top() when the
- * handler data is still available. Use that to clear the XIVE
- * controller data.
- */
-static void pseries_msi_ops_msi_free(struct irq_domain *domain,
-				     struct msi_domain_info *info,
-				     unsigned int irq)
-{
-	if (xive_enabled())
-		xive_irq_free_data(irq);
-}
-
 /*
  * RTAS can not disable one MSI at a time. It's all or nothing. Do it
  * at the end after all IRQs have been freed.
@@ -463,7 +449,6 @@ static void pseries_msi_post_free(struct irq_domain *do=
main, struct device *dev)
=20
 static struct msi_domain_ops pseries_pci_msi_domain_ops =3D {
 	.msi_prepare	=3D pseries_msi_ops_prepare,
-	.msi_free	=3D pseries_msi_ops_msi_free,
 	.msi_post_free	=3D pseries_msi_post_free,
 };
=20
@@ -604,8 +589,7 @@ static void pseries_irq_domain_free(struct irq_domain *=
domain, unsigned int virq
 	struct pci_controller *phb =3D irq_data_get_irq_chip_data(d);
=20
 	pr_debug("%s bridge %pOF %d #%d\n", __func__, phb->dn, virq, nr_irqs);
-
-	/* XIVE domain data is cleared through ->msi_free() */
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
=20
 static const struct irq_domain_ops pseries_irq_domain_ops =3D {
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/c=
ommon.c
index f10592405024..625361a15424 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -317,7 +317,7 @@ int xmon_xive_get_irq_config(u32 hw_irq, struct irq_dat=
a *d)
 	if (d) {
 		char buffer[128];
=20
-		xive_irq_data_dump(irq_data_get_irq_handler_data(d),
+		xive_irq_data_dump(irq_data_get_irq_chip_data(d),
 				   buffer, sizeof(buffer));
 		xmon_printf("%s", buffer);
 	}
@@ -437,7 +437,7 @@ static void xive_do_source_eoi(struct xive_irq_data *xd)
 /* irq_chip eoi callback, called with irq descriptor lock held */
 static void xive_irq_eoi(struct irq_data *d)
 {
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(d);
 	struct xive_cpu *xc =3D __this_cpu_read(xive_cpu);
=20
 	DBG_VERBOSE("eoi_irq: irq=3D%d [0x%lx] pending=3D%02x\n",
@@ -595,7 +595,7 @@ static int xive_pick_irq_target(struct irq_data *d,
 				const struct cpumask *affinity)
 {
 	static unsigned int fuzz;
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(d);
 	cpumask_var_t mask;
 	int cpu =3D -1;
=20
@@ -628,7 +628,7 @@ static int xive_pick_irq_target(struct irq_data *d,
=20
 static unsigned int xive_irq_startup(struct irq_data *d)
 {
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(d);
 	unsigned int hw_irq =3D (unsigned int)irqd_to_hwirq(d);
 	int target, rc;
=20
@@ -673,7 +673,7 @@ static unsigned int xive_irq_startup(struct irq_data *d)
 /* called with irq descriptor lock held */
 static void xive_irq_shutdown(struct irq_data *d)
 {
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(d);
 	unsigned int hw_irq =3D (unsigned int)irqd_to_hwirq(d);
=20
 	pr_debug("%s: irq %d [0x%x] data @%p\n", __func__, d->irq, hw_irq, d);
@@ -698,7 +698,7 @@ static void xive_irq_shutdown(struct irq_data *d)
=20
 static void xive_irq_unmask(struct irq_data *d)
 {
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(d);
=20
 	pr_debug("%s: irq %d data @%p\n", __func__, d->irq, xd);
=20
@@ -707,7 +707,7 @@ static void xive_irq_unmask(struct irq_data *d)
=20
 static void xive_irq_mask(struct irq_data *d)
 {
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(d);
=20
 	pr_debug("%s: irq %d data @%p\n", __func__, d->irq, xd);
=20
@@ -718,7 +718,7 @@ static int xive_irq_set_affinity(struct irq_data *d,
 				 const struct cpumask *cpumask,
 				 bool force)
 {
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(d);
 	unsigned int hw_irq =3D (unsigned int)irqd_to_hwirq(d);
 	u32 target, old_target;
 	int rc =3D 0;
@@ -776,7 +776,7 @@ static int xive_irq_set_affinity(struct irq_data *d,
=20
 static int xive_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(d);
=20
 	/*
 	 * We only support these. This has really no effect other than setting
@@ -815,7 +815,7 @@ static int xive_irq_set_type(struct irq_data *d, unsign=
ed int flow_type)
=20
 static int xive_irq_retrigger(struct irq_data *d)
 {
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(d);
=20
 	/* This should be only for MSIs */
 	if (WARN_ON(xd->flags & XIVE_IRQ_FLAG_LSI))
@@ -837,7 +837,7 @@ static int xive_irq_retrigger(struct irq_data *d)
  */
 static int xive_irq_set_vcpu_affinity(struct irq_data *d, void *state)
 {
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(d);
 	unsigned int hw_irq =3D (unsigned int)irqd_to_hwirq(d);
 	int rc;
 	u8 pq;
@@ -951,7 +951,7 @@ static int xive_irq_set_vcpu_affinity(struct irq_data *=
d, void *state)
 static int xive_get_irqchip_state(struct irq_data *data,
 				  enum irqchip_irq_state which, bool *state)
 {
-	struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(data);
+	struct xive_irq_data *xd =3D irq_data_get_irq_chip_data(data);
 	u8 pq;
=20
 	switch (which) {
@@ -1011,21 +1011,20 @@ void xive_cleanup_irq_data(struct xive_irq_data *xd)
 }
 EXPORT_SYMBOL_GPL(xive_cleanup_irq_data);
=20
-static int xive_irq_alloc_data(unsigned int virq, irq_hw_number_t hw)
+static struct xive_irq_data *xive_irq_alloc_data(unsigned int virq, irq_hw=
_number_t hw)
 {
 	struct xive_irq_data *xd;
 	int rc;
=20
 	xd =3D kzalloc(sizeof(struct xive_irq_data), GFP_KERNEL);
 	if (!xd)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	rc =3D xive_ops->populate_irq_data(hw, xd);
 	if (rc) {
 		kfree(xd);
-		return rc;
+		return ERR_PTR(rc);
 	}
 	xd->target =3D XIVE_INVALID_TARGET;
-	irq_set_handler_data(virq, xd);
=20
 	/*
 	 * Turn OFF by default the interrupt being mapped. A side
@@ -1036,20 +1035,19 @@ static int xive_irq_alloc_data(unsigned int virq, i=
rq_hw_number_t hw)
 	 */
 	xive_esb_read(xd, XIVE_ESB_SET_PQ_01);
=20
-	return 0;
+	return xd;
 }
=20
-void xive_irq_free_data(unsigned int virq)
+static void xive_irq_free_data(unsigned int virq)
 {
-	struct xive_irq_data *xd =3D irq_get_handler_data(virq);
+	struct xive_irq_data *xd =3D irq_get_chip_data(virq);
=20
 	if (!xd)
 		return;
-	irq_set_handler_data(virq, NULL);
+	irq_set_chip_data(virq, NULL);
 	xive_cleanup_irq_data(xd);
 	kfree(xd);
 }
-EXPORT_SYMBOL_GPL(xive_irq_free_data);
=20
 #ifdef CONFIG_SMP
=20
@@ -1286,7 +1284,7 @@ void __init xive_smp_probe(void)
 static int xive_irq_domain_map(struct irq_domain *h, unsigned int virq,
 			       irq_hw_number_t hw)
 {
-	int rc;
+	struct xive_irq_data *xd;
=20
 	/*
 	 * Mark interrupts as edge sensitive by default so that resend
@@ -1294,11 +1292,12 @@ static int xive_irq_domain_map(struct irq_domain *h=
, unsigned int virq,
 	 */
 	irq_clear_status_flags(virq, IRQ_LEVEL);
=20
-	rc =3D xive_irq_alloc_data(virq, hw);
-	if (rc)
-		return rc;
+	xd =3D xive_irq_alloc_data(virq, hw);
+	if (IS_ERR(xd))
+		return PTR_ERR(xd);
=20
 	irq_set_chip_and_handler(virq, &xive_irq_chip, handle_fasteoi_irq);
+	irq_set_chip_data(virq, xd);
=20
 	return 0;
 }
@@ -1366,7 +1365,7 @@ static void xive_irq_domain_debug_show(struct seq_fil=
e *m, struct irq_domain *d,
 	seq_printf(m, "%*sXIVE:\n", ind, "");
 	ind++;
=20
-	xd =3D irq_data_get_irq_handler_data(irqd);
+	xd =3D irq_data_get_irq_chip_data(irqd);
 	if (!xd) {
 		seq_printf(m, "%*snot assigned\n", ind, "");
 		return;
@@ -1403,6 +1402,7 @@ static int xive_irq_domain_alloc(struct irq_domain *d=
omain, unsigned int virq,
 				 unsigned int nr_irqs, void *arg)
 {
 	struct irq_fwspec *fwspec =3D arg;
+	struct xive_irq_data *xd;
 	irq_hw_number_t hwirq;
 	unsigned int type =3D IRQ_TYPE_NONE;
 	int i, rc;
@@ -1423,12 +1423,11 @@ static int xive_irq_domain_alloc(struct irq_domain =
*domain, unsigned int virq,
 		irq_clear_status_flags(virq, IRQ_LEVEL);
=20
 		/* allocates and sets handler data */
-		rc =3D xive_irq_alloc_data(virq + i, hwirq + i);
-		if (rc)
-			return rc;
+		xd =3D xive_irq_alloc_data(virq + i, hwirq + i);
+		if (IS_ERR(xd))
+			return PTR_ERR(xd);
=20
-		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-					      &xive_irq_chip, domain->host_data);
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i, &xive_irq_chi=
p, xd);
 		irq_set_handler(virq + i, handle_fasteoi_irq);
 	}
=20
@@ -1764,7 +1763,7 @@ static void xive_debug_show_irq(struct seq_file *m, s=
truct irq_data *d)
 	seq_printf(m, "IRQ 0x%08x : target=3D0x%x prio=3D%02x lirq=3D0x%x ",
 		   hw_irq, target, prio, lirq);
=20
-	xive_irq_data_dump(irq_data_get_irq_handler_data(d), buffer, sizeof(buffe=
r));
+	xive_irq_data_dump(irq_data_get_irq_chip_data(d), buffer, sizeof(buffer));
 	seq_puts(m, buffer);
 	seq_puts(m, "\n");
 }
--=20
2.39.5


