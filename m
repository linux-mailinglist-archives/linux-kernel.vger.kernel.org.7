Return-Path: <linux-kernel+bounces-756488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E49B1B508
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5383BF89C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BAD274FEB;
	Tue,  5 Aug 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU+lLa4Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290E3218E91;
	Tue,  5 Aug 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400903; cv=none; b=DwU0eNPPQyxYcbhCAmChCGWEycsjDb3Wx5N0Eg67SBaLqfiSfcuYs84e2YPd5ewlSOBJuar19U6RBx6HD3WrxStDw+kBunk4zhoPgUl+6Qc81TSHW+xDfkqwp4SinfPepI/qReaVqR3sUQ3BfoO+eXpgZmPY0nOgQL0pTyi1Ozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400903; c=relaxed/simple;
	bh=/0ZE234TeSw9xjJpsbQakcX1dsGmzNxtfI+WMMXz2Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4OCQvm9+iWJxXC/u84NcczE5tdmxd/M6Lx+E1AIqhnksbBXQwvrL/9floZhsh3aUwAo9wAJFdqh6ovyre/Kw/bPDaw9eD36e3VU7TB+bXHVmWai09P5TQJQDKY7X0U+W/oDE7tihhbnHPGMXQkNOm7zxdbjMVFhul+jnI54Hvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU+lLa4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C45BC4CEF7;
	Tue,  5 Aug 2025 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754400901;
	bh=/0ZE234TeSw9xjJpsbQakcX1dsGmzNxtfI+WMMXz2Kk=;
	h=From:To:Cc:Subject:Date:From;
	b=lU+lLa4Zrpe/uj+pWg2ZxX89B5r4JrzaxePFTDj8FhpjrDcq3CfN5sbou/RNgS0pJ
	 7jLrGu10EEKOou8IK+saOPLUuu5vIp2E0ynNnoM7IYXL9hDm1YeYhUVhm31lisHfdt
	 dtZwexUTb4hGIdQVru11j6aIKVCoyrpCtMwZfqymeBHOpKmnZeJHWL3AJYlCFjMkjR
	 4jZLhZzJmCbSKAILgJRPQ+atWOY4PJ2kWNDpFhKdVDPc+2lvF47AVAqD2NWlTF13lM
	 KDyU8JmdoRgMv8lmA6UUd/rDY8Pu/X38IYSDL/87TpfGbBtd53uMVnhuDtF0QF0HnB
	 Vc/PzUijScXxg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH] of/irq: Convert of_msi_map_id() callers to of_msi_xlate()
Date: Tue,  5 Aug 2025 15:34:43 +0200
Message-ID: <20250805133443.936955-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of the of_msi_xlate() function, the OF layer
provides an API to map a device ID and retrieve the MSI controller
node the ID is mapped to with a single call.

of_msi_map_id() is currently used to map a deviceID to a specific
MSI controller node; of_msi_xlate() can be used for that purpose
too, there is no need to keep the two functions.

Convert of_msi_map_id() to of_msi_xlate() calls and update the
of_msi_xlate() documentation to describe how the struct device_node
pointer passed in should be set-up to either provide the MSI controller
node target or receive its pointer upon mapping completion.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
As suggested by RobH:

https://lore.kernel.org/lkml/20250627213241.GA168190-robh@kernel.org/

 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c |  2 +-
 drivers/of/irq.c                            | 25 +++++----------------
 drivers/pci/msi/irqdomain.c                 |  2 +-
 include/linux/of_irq.h                      |  6 -----
 4 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 11549d85f23b..b5785472765a 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -30,7 +30,7 @@ static u32 fsl_mc_msi_domain_get_msi_id(struct irq_domain *domain,
 	u32 out_id;
 
 	of_node = irq_domain_get_of_node(domain);
-	out_id = of_node ? of_msi_map_id(&mc_dev->dev, of_node, mc_dev->icid) :
+	out_id = of_node ? of_msi_xlate(&mc_dev->dev, &of_node, mc_dev->icid) :
 			iort_msi_map_id(&mc_dev->dev, mc_dev->icid);
 
 	return out_id;
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 74aaea61de13..e7c12abd10ab 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -673,13 +673,14 @@ void __init of_irq_init(const struct of_device_id *matches)
 /**
  * of_msi_xlate - map a MSI ID and find relevant MSI controller node
  * @dev: device for which the mapping is to be done.
- * @msi_np: Pointer to store the MSI controller node
+ * @msi_np: Pointer to target MSI controller node
  * @id_in: Device ID.
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
- * property. If found, apply the mapping to @id_in. @msi_np pointed
- * value must be NULL on entry, if an MSI controller is found @msi_np is
- * initialized to the MSI controller node with a reference held.
+ * property. If found, apply the mapping to @id_in.
+ * If @msi_np points to a non-NULL device node pointer, only entries targeting
+ * that node will be matched; if it points to a NULL value, it will receive the
+ * device node of the first matching target phandle, with a reference held.
  *
  * Returns: The mapped MSI id.
  */
@@ -699,22 +700,6 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 	return id_out;
 }
 
-/**
- * of_msi_map_id - Map a MSI ID for a device.
- * @dev: device for which the mapping is to be done.
- * @msi_np: device node of the expected msi controller.
- * @id_in: unmapped MSI ID for the device.
- *
- * Walk up the device hierarchy looking for devices with a "msi-map"
- * property.  If found, apply the mapping to @id_in.
- *
- * Return: The mapped MSI ID.
- */
-u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
-{
-	return of_msi_xlate(dev, &msi_np, id_in);
-}
-
 /**
  * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
  * @dev: device for which the mapping is to be done.
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 0938ef7ebabf..555c61b1fc36 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -422,7 +422,7 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
 	of_node = irq_domain_get_of_node(domain);
-	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
+	rid = of_node ? of_msi_xlate(&pdev->dev, &of_node, rid) :
 			iort_msi_map_id(&pdev->dev, rid);
 
 	return rid;
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index a480063c9cb1..1db8543dfc8a 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -55,7 +55,6 @@ extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
 							u32 bus_token);
 extern void of_msi_configure(struct device *dev, const struct device_node *np);
 extern u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in);
-u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
 #else
 static inline void of_irq_init(const struct of_device_id *matches)
 {
@@ -105,11 +104,6 @@ static inline u32 of_msi_xlate(struct device *dev, struct device_node **msi_np,
 {
 	return id_in;
 }
-static inline u32 of_msi_map_id(struct device *dev,
-				 struct device_node *msi_np, u32 id_in)
-{
-	return id_in;
-}
 #endif
 
 #if defined(CONFIG_OF_IRQ) || defined(CONFIG_SPARC)
-- 
2.48.0


