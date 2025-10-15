Return-Path: <linux-kernel+bounces-853895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA167BDCD7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0004A350DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED6A3115B5;
	Wed, 15 Oct 2025 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sNXX1el/"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445A280014
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512424; cv=none; b=Tz2MGMsw00odbsijZ7RIeqnS3Bfw739ClnJE3Rx7BFDxYH+TfnpWMxegdoNjs3r3qZjUR7SPGCpDxkOhtt/87lruQFzIVEzH+0luIsIHA9yCK/+s86NhfGNhzIEsHnDLnYH29ex4mswncPZoUn8y15mfVv82uDGXMQBr5gEfPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512424; c=relaxed/simple;
	bh=erfzgnlcL8vkijZeTOcRH1XhAxVuKuzL2IS74NNgh0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XTQ6zKu7ou1geQsmc6zZNKwH15TrlHSrIynPn3cDwUcXHjmFK/RpwBf7yFRB/Q8KF7dZQBce5wTfcKmeI/m2Pr/tD1/hkT22cxyxoyWvOJkfSxot4JuBbQgtAzqK7+bU4/VJ2Gkcr64WM5s4/zDgVlWhlbY9GeN6aHeWP/kdfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sNXX1el/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760512419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q5W3plTml2LrXx/+V26o+pAQSf6UvRi+HJfSZMFUt2w=;
	b=sNXX1el/j7XakQCK55yUWvZmBso+twy+0FuXrccV5J2VIhAypNGnPMphlDPr7nfOLds3QC
	qnbmD0eeDAxZw1VsK7kqREenh/3tCfSI5a9vKVcpccWLolSEqdF+kXXxIahqM8PoeZm5Ya
	Qr+oRQMfk1F9EgHh6rBY6gXhjW1GOac=
From: Ben Collins <ben.collins@linux.dev>
Date: Wed, 15 Oct 2025 03:13:35 -0400
Subject: [PATCH] fsl_msi: Translate bitmap to hwirq on fsl,mpic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-fsl_msi_bitmap_translate-v1-1-c438208b7f80@linux.dev>
X-B4-Tracking: v=1; b=H4sIAJ5J72gC/x3MTQqAIBBA4avErBNU+qOrRIjWWANl4UgE0d2Tl
 t/ivQcYIyFDXzwQ8SKmI2SosoBptWFBQXM2aKlrJVUtPG9mZzKO0m5Pk6INvNmEQraNcr6aO/Q
 acn5G9HT/62F83w8gX/uhagAAAA==
X-Change-ID: 20251015-fsl_msi_bitmap_translate-0761bf4d8ef2
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ben Collins <bcollins@kernel.org>
X-Migadu-Flow: FLOW_OUT

On PPC_32 QorIQ, the hwirq bitmap is done with the cascade being the most
significant bits and the srs on the cascade being the least. This has the
effect of filling up one cascade before the next.

Since each cascade has 32 srs and is tied to a single CPU and interrupt,
this means no load balancing of MSIs.

Rework this case to translate between the bitmap and hwirq so that MSIs
are allocated across the cascades round-robin to achieve load balancing.

Also, to avoid holes in the bitmap, allocate it for exactly what the
hardware supports.

Tested on P4080 (which had the problem) and T4240 (which did not, but
also no regressions).

Signed-off-by: Ben Collins <bcollins@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org
---
Rework fsl,mpic bitmap translation on PPC_32 so that IRQs cascade across
CPUs properly.

v2:
- Slight fuzz fixes since patch is 6 months old.
---
 arch/powerpc/sysdev/fsl_msi.c | 70 ++++++++++++++++++++++++++++++++++++-------
 arch/powerpc/sysdev/fsl_msi.h |  7 +++--
 2 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 2a007bfb038d0167edc7e6143d22ca5b76989947..b07eef18dec3c1f7623527c96b3abf5a589bd443 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -29,17 +29,63 @@
 #include "fsl_pci.h"
 
 #define MSIIR_OFFSET_MASK	0xfffff
+
 #define MSIIR_IBS_SHIFT		0
 #define MSIIR_SRS_SHIFT		5
+#define MSIIR_SRS_MASK		0x7
+
 #define MSIIR1_IBS_SHIFT	4
 #define MSIIR1_SRS_SHIFT	0
-#define MSI_SRS_MASK		0xf
+#define MSIIR1_SRS_MASK		0xf
+
 #define MSI_IBS_MASK		0x1f
 
-#define msi_hwirq(msi, msir_index, intr_index) \
-		((msir_index) << (msi)->srs_shift | \
+#define MSI_MPIC_SIZE		0x10
+#define MSI_IPIC_SIZE		0x04
+
+#define msi_to_hwirq(msi, msir_index, intr_index) \
+		(((msir_index) << (msi)->srs_shift) | \
 		 ((intr_index) << (msi)->ibs_shift))
 
+static inline int msi_to_bit(struct fsl_msi *msi, int msir_index, int intr_index)
+{
+	if (!msi->srs_shift)
+		return msi_to_hwirq(msi, msir_index, intr_index);
+
+	return msir_index | (intr_index << hweight32(msi->srs_mask));
+}
+
+static inline int bit_to_hwirq(struct fsl_msi *msi, int bit)
+{
+	int hwirq;
+
+	if (!msi->srs_shift)
+		return bit;
+
+	hwirq  = (bit & msi->srs_mask) << msi->srs_shift;
+	hwirq |=  bit >> hweight32(msi->srs_mask);
+
+	return hwirq;
+}
+
+static inline int hwirq_to_bit(struct fsl_msi *msi, int hwirq)
+{
+	int bit;
+
+	if (!msi->srs_shift)
+		return hwirq;
+
+	bit  = (hwirq >> msi->srs_shift) & msi->srs_mask;
+	bit |= (hwirq & MSI_IBS_MASK) << msi->srs_shift;
+
+	return bit;
+}
+
+#define hwirq_to_srs(msi, hwirq) \
+		(((hwirq) >> (msi)->srs_shift) & (msi)->srs_mask)
+#define hwirq_to_ibs(msi, hwirq) \
+		(((hwirq) >> (msi)->ibs_shift) & MSI_IBS_MASK)
+
 static LIST_HEAD(msi_head);
 
 struct fsl_msi_feature {
@@ -72,7 +118,7 @@ static void fsl_msi_print_chip(struct irq_data *irqd, struct seq_file *p)
 	irq_hw_number_t hwirq = irqd_to_hwirq(irqd);
 	int cascade_virq, srs;
 
-	srs = (hwirq >> msi_data->srs_shift) & MSI_SRS_MASK;
+	srs = hwirq_to_srs(msi_data, hwirq);
 	cascade_virq = msi_data->cascade_array[srs]->virq;
 
 	seq_printf(p, "fsl-msi-%d", cascade_virq);
@@ -107,8 +153,9 @@ static const struct irq_domain_ops fsl_msi_host_ops = {
 static int fsl_msi_init_allocator(struct fsl_msi *msi_data)
 {
 	int rc, hwirq;
+	int num_irqs = msi_data->nr_msi_regs * IRQS_PER_MSI_REG;
 
-	rc = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS_MAX,
+	rc = msi_bitmap_alloc(&msi_data->bitmap, num_irqs,
 			      irq_domain_get_of_node(msi_data->irqhost));
 	if (rc)
 		return rc;
@@ -117,7 +164,7 @@ static int fsl_msi_init_allocator(struct fsl_msi *msi_data)
 	 * Reserve all the hwirqs
 	 * The available hwirqs will be released in fsl_msi_setup_hwirq()
 	 */
-	for (hwirq = 0; hwirq < NR_MSI_IRQS_MAX; hwirq++)
+	for (hwirq = 0; hwirq < num_irqs; hwirq++)
 		msi_bitmap_reserve_hwirq(&msi_data->bitmap, hwirq);
 
 	return 0;
@@ -172,7 +219,7 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 		msg->data = hwirq;
 
 	pr_debug("%s: allocated srs: %d, ibs: %d\n", __func__,
-		 (hwirq >> msi_data->srs_shift) & MSI_SRS_MASK,
+		 hwirq_to_srs(msi_data, hwirq),
 		 (hwirq >> msi_data->ibs_shift) & MSI_IBS_MASK);
 }
 
@@ -308,8 +355,8 @@ static irqreturn_t fsl_msi_cascade(int irq, void *data)
 		intr_index = ffs(msir_value) - 1;
 
 		err = generic_handle_domain_irq(msi_data->irqhost,
-				msi_hwirq(msi_data, msir_index,
-					  intr_index + have_shift));
+				msi_to_hwirq(msi_data, msir_index,
+					     intr_index + have_shift));
 		if (!err)
 			ret = IRQ_HANDLED;
 
@@ -384,7 +431,7 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 	/* Release the hwirqs corresponding to this MSI register */
 	for (i = 0; i < IRQS_PER_MSI_REG; i++)
 		msi_bitmap_free_hwirqs(&msi->bitmap,
-				       msi_hwirq(msi, offset, i), 1);
+				       msi_to_hwirq(msi, offset, i), 1);
 
 	return 0;
 }
@@ -412,7 +459,8 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	}
 	platform_set_drvdata(dev, msi);
 
-	msi->irqhost = irq_domain_create_linear(dev_fwnode(&dev->dev), NR_MSI_IRQS_MAX,
+	msi->irqhost = irq_domain_create_linear(dev_fwnode(&dev->dev),
+						msi->nr_msi_regs * IRQS_PER_MSI_REG,
 						&fsl_msi_host_ops, msi);
 	if (msi->irqhost == NULL) {
 		dev_err(&dev->dev, "No memory for MSI irqhost\n");
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index e2a1bfc7c23777f72f51486ee02284d92d56e1e2..0515030af9acb965c0b5db68d5655004777f4344 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -15,7 +15,6 @@
 #define NR_MSI_REG_MSIIR1	16 /* MSIIR1 can index 16 MSI registers */
 #define NR_MSI_REG_MAX		NR_MSI_REG_MSIIR1
 #define IRQS_PER_MSI_REG	32
-#define NR_MSI_IRQS_MAX	(NR_MSI_REG_MAX * IRQS_PER_MSI_REG)
 
 #define FSL_PIC_IP_MASK   0x0000000F
 #define FSL_PIC_IP_MPIC   0x00000001
@@ -32,11 +31,13 @@ struct fsl_msi {
 	unsigned long cascade_irq;
 
 	u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
-	u32 ibs_shift; /* Shift of interrupt bit select */
-	u32 srs_shift; /* Shift of the shared interrupt register select */
+	u32 ibs_shift;    /* Shift of interrupt bit select */
+	u32 srs_mask;     /* Mask of the shared interrupt register select */
+	u32 srs_shift;    /* Shift for shared interrupt register select */
 	void __iomem *msi_regs;
 	u32 feature;
 	struct fsl_msi_cascade_data *cascade_array[NR_MSI_REG_MAX];
+	u32 nr_msi_regs;
 
 	struct msi_bitmap bitmap;
 

---
base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
change-id: 20251015-fsl_msi_bitmap_translate-0761bf4d8ef2

Best regards,
-- 
Ben Collins <ben.collins@linux.dev>


