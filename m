Return-Path: <linux-kernel+bounces-762221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F85DB203A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2414D3A73A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4CE2DECC6;
	Mon, 11 Aug 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3XB9AeJD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IybW2EPV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7F2DECB4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904546; cv=none; b=XbAerv6BULkR/8PkwRPPmO5SDAXQmQwEj2A7iU48/e9MFnP8zx2sYO6IE/ONesRwH5dlV/zy/CDkGjYK4DywS0knud105puw1AOI8trTLCj/JtQOoXTB50K7DW/ZNl4y+sqBb3Oz+5wT74ui6rN6vdkN3m0UuNsoHm7s5WucExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904546; c=relaxed/simple;
	bh=+DMUlfZTqat/D8Q3RR/QCmuDSwOoNCiCCeVHNlXJ2ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDecMp5NE5Gn7d5CWrZUcE6YqjErFpSL+BFfJWeJZiFRHjCgaG+C4yOe27K2J6qSa6njfqB+9rW/LKJ0tk73r/HPkyxRww0HvRmg7Z4Wu1OuFjEnGLiWu3jvlfHOael5BEB4DimC5LOQa40GKx5zFXig4rlaolAhOQ2szjpQMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3XB9AeJD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IybW2EPV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754904542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJCRi2fFlTr6qmagXqPicSbakQzvmB8/AtT3di172VU=;
	b=3XB9AeJDdsI5ylKcOITy547DafomYbr1WYEdcLHp//aJC6eGEpU//8s1Lbiz3ONnPDo+EW
	WHoJJpytaxzgLPQPgiAkqLanprq2qsxvw4yN+hQLhADZmcHlqUR6C85c/fHflkgGgNeUm4
	De2USqmfd0kELjVu4jkbrGLx1Y312jOGRgrtVcOKky0RdvXxHhDiNpX3jhWxEnRLZvfZSb
	ztatEgjFcXtyEz2/uRA2v5ULdE3VZUqFxwGo3kAH+QvrKnGKZ+y3el4UUg0khuC2Dp0wv7
	jJ22iJuEVTvGZ16LbmCM0LZeev53eBehSODZj3z+cwwpe6Wi0rAwIwNv56991w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754904542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJCRi2fFlTr6qmagXqPicSbakQzvmB8/AtT3di172VU=;
	b=IybW2EPVxFx4/m4kQOtKhbsx1WN4+prnGa1EVtcx7aRJYRynYVT1hg+m9vdvCSuOFKJksE
	Ika4YU+TJoEndRCw==
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
Subject: [PATCH v2 2/3] powerpc/powernv/pci: Switch to use msi_create_parent_irq_domain()
Date: Mon, 11 Aug 2025 11:28:55 +0200
Message-Id: <a4c2c363ac7b94fffc79d5b92086135be4c57e06.1754903590.git.namcao@linutronix.de>
In-Reply-To: <cover.1754903590.git.namcao@linutronix.de>
References: <cover.1754903590.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move away from the legacy MSI domain setup, switch to use
msi_create_parent_irq_domain().

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2: no change
---
 arch/powerpc/platforms/powernv/Kconfig    |  1 +
 arch/powerpc/platforms/powernv/pci-ioda.c | 75 ++++++++++-------------
 2 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platform=
s/powernv/Kconfig
index 95d7ba73d43d..b5ad7c173ef0 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -9,6 +9,7 @@ config PPC_POWERNV
 	select PPC_P7_NAP
 	select FORCE_PCI
 	select PCI_MSI
+	select IRQ_MSI_LIB
 	select EPAPR_BOOT
 	select PPC_INDIRECT_PIO
 	select PPC_UDBG_16550
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index fb37098d4d58..c2a932c6e304 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/io.h>
 #include <linux/msi.h>
 #include <linux/iommu.h>
@@ -1713,30 +1714,33 @@ static void pnv_msi_shutdown(struct irq_data *d)
 		d->chip->irq_shutdown(d);
 }
=20
-static void pnv_msi_mask(struct irq_data *d)
+static bool pnv_init_dev_msi_info(struct device *dev, struct irq_domain *d=
omain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
 {
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
+	struct irq_chip *chip =3D info->chip;
=20
-static void pnv_msi_unmask(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
=20
-static struct irq_chip pnv_pci_msi_irq_chip =3D {
-	.name		=3D "PNV-PCI-MSI",
-	.irq_shutdown	=3D pnv_msi_shutdown,
-	.irq_mask	=3D pnv_msi_mask,
-	.irq_unmask	=3D pnv_msi_unmask,
-	.irq_eoi	=3D irq_chip_eoi_parent,
-};
+	chip->irq_shutdown =3D pnv_msi_shutdown;
+	return true;
+}
=20
-static struct msi_domain_info pnv_msi_domain_info =3D {
-	.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX),
-	.chip  =3D &pnv_pci_msi_irq_chip,
+#define PNV_PCI_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
+				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+#define PNV_PCI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK		| \
+				     MSI_FLAG_PCI_MSIX			| \
+				     MSI_FLAG_MULTI_PCI_MSI)
+
+static const struct msi_parent_ops pnv_msi_parent_ops =3D {
+	.required_flags		=3D PNV_PCI_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D PNV_PCI_MSI_FLAGS_SUPPORTED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
+	.prefix			=3D "PNV-",
+	.init_dev_msi_info	=3D pnv_init_dev_msi_info,
 };
=20
 static void pnv_msi_compose_msg(struct irq_data *d, struct msi_msg *msg)
@@ -1855,37 +1859,26 @@ static void pnv_irq_domain_free(struct irq_domain *=
domain, unsigned int virq,
 }
=20
 static const struct irq_domain_ops pnv_irq_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc  =3D pnv_irq_domain_alloc,
 	.free   =3D pnv_irq_domain_free,
 };
=20
 static int __init pnv_msi_allocate_domains(struct pci_controller *hose, un=
signed int count)
 {
-	struct pnv_phb *phb =3D hose->private_data;
 	struct irq_domain *parent =3D irq_get_default_domain();
-
-	hose->fwnode =3D irq_domain_alloc_named_id_fwnode("PNV-MSI", phb->opal_id=
);
-	if (!hose->fwnode)
-		return -ENOMEM;
-
-	hose->dev_domain =3D irq_domain_create_hierarchy(parent, 0, count,
-						       hose->fwnode,
-						       &pnv_irq_domain_ops, hose);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_fwnode_handle(hose->dn),
+		.ops		=3D &pnv_irq_domain_ops,
+		.host_data	=3D hose,
+		.size		=3D count,
+		.parent		=3D parent,
+	};
+
+	hose->dev_domain =3D msi_create_parent_irq_domain(&info, &pnv_msi_parent_=
ops);
 	if (!hose->dev_domain) {
-		pr_err("PCI: failed to create IRQ domain bridge %pOF (domain %d)\n",
-		       hose->dn, hose->global_number);
-		irq_domain_free_fwnode(hose->fwnode);
-		return -ENOMEM;
-	}
-
-	hose->msi_domain =3D pci_msi_create_irq_domain(of_fwnode_handle(hose->dn),
-						     &pnv_msi_domain_info,
-						     hose->dev_domain);
-	if (!hose->msi_domain) {
 		pr_err("PCI: failed to create MSI IRQ domain bridge %pOF (domain %d)\n",
 		       hose->dn, hose->global_number);
-		irq_domain_free_fwnode(hose->fwnode);
-		irq_domain_remove(hose->dev_domain);
 		return -ENOMEM;
 	}
=20
--=20
2.39.5


