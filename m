Return-Path: <linux-kernel+bounces-827412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31146B91B09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB713AF776
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B7C238C0D;
	Mon, 22 Sep 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+6J3Ylk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567F1F8AC8;
	Mon, 22 Sep 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551176; cv=none; b=d6dh7p7tddpseGQis1QTd4U9l+uCODQnkE9vpx2WnXeaUWT+j5EzFo4+IjHVBP31TDXvLu2eLA4MCy7KKxNEj9q/rF/DcupkDdIOuGL/63PlACTkAjul98XjHpPK0IGgmIGGorMAj6Lp/Tbd7tqO80r/H3GAu6HIpeP8vthJ8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551176; c=relaxed/simple;
	bh=CEK8yHPxJKhWjl3RH+TVpm29Wny+6IBKlzfazln71jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MCj6prvJptoNRmn+Lmm3GhRce3Vz49hPED9LpN9gK34qI/PolHyheQgyS1k0Kff+4ml3GtXRunUJyZIYir1y89j4fpIK8Feu2NQvGZErhCdkXkBVreyYorESi8zgZBfLsP8CrbntT74I1mPlqdprM/8beiMcW5szT8rJFF5+MoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+6J3Ylk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFC1C4CEF0;
	Mon, 22 Sep 2025 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758551176;
	bh=CEK8yHPxJKhWjl3RH+TVpm29Wny+6IBKlzfazln71jo=;
	h=From:To:Cc:Subject:Date:From;
	b=n+6J3YlkzS+dsKSUT5df0ZjUzucjalYcUGdQcyRUwxogpDUpe+d7y7RjK6MQCMNNB
	 nwUgfy4ceEHu/0znn+stF8hwdhzHL3e3MXSUnHwq4Dv1h9jz0+Dq8G2R+5Z5+ZO1CN
	 0P4cpIqGlRbttm/xNQK0AIUT89fC7Qo6q06CfBTQk7enmhONfPKq14A1WmPgKXYNC5
	 p7HTBnd4+KMvUdPG4WN78zOXUzrzeNeLasVDPAqLfuFUdR5LQd6cITHaeILLsIYUEn
	 lO+RjtVNYV6MJZWh87KxH5Uxk/E4vKe87ohb5Im1wW+Ot1TSvRD14PbxUms4bge3y0
	 LWoXby9vxGUkg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/gic-v5: Add PCI bus msi-parent property handling
Date: Mon, 22 Sep 2025 16:26:10 +0200
Message-ID: <20250922142610.80200-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some legacy platforms the MSI controller for a PCI host bridge is
identified by an msi-parent property whose phandle points at an MSI
controller node with no #msi-cells property, that implicitly
means #msi-cells == 0.

For such platforms, mapping a device ID and retrieving the MSI controller
node becomes simply a matter of checking whether in the device hierarchy
there is an msi-parent property pointing at an MSI controller node with
such characteristics.

Add a helper function to its_v5_pci_msi_prepare() to check the msi-parent
property in addition to msi-map and retrieve the MSI controller node (with
a 1:1 ID deviceID-IN<->deviceID-OUT mapping) to provide support for
deviceID mapping and MSI controller node retrieval for such platforms.

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
Follow-up to [1] in that it is a fix and too risky to fix generic OF code at
this stage of development since it might affect other platforms.

Apply a fix to GIC ITS v5 MSI parent code - follow-up will clean up
the msi-parent parsing in the kernel tree.

[1] https://lore.kernel.org/lkml/20250916091858.257868-1-lpieralisi@kernel.org/

 drivers/irqchip/irq-gic-its-msi-parent.c | 34 ++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index eb1473f1448a..198fb4e9a22d 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -101,6 +101,33 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
 }
 
+static int its_v5_get_msi_parent(struct device *dev, struct device_node **msi_np)
+{
+	struct of_phandle_args out_msi;
+	struct device *parent_dev;
+	int ret;
+
+	/*
+	 * Walk up the device parent links looking for one with a
+	 *  "msi-parent" property.
+	 */
+	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
+		ret = of_parse_phandle_with_optional_args(parent_dev->of_node, "msi-parent",
+							  "#msi-cells",
+							  0, &out_msi);
+		if (!ret) {
+			if (!out_msi.args_count) {
+				/* Return with a node reference held */
+				*msi_np = out_msi.np;
+				return 0;
+			}
+			of_node_put(out_msi.np);
+		}
+	}
+
+	return -ENODEV;
+}
+
 static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 				  int nvec, msi_alloc_info_t *info)
 {
@@ -117,8 +144,11 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	pdev = to_pci_dev(dev);
 
 	rid = pci_msi_map_rid_ctlr_node(pdev, &msi_node);
-	if (!msi_node)
-		return -ENODEV;
+	if (!msi_node) {
+		ret = its_v5_get_msi_parent(&pdev->dev, &msi_node);
+		if (ret)
+			return ret;
+	}
 
 	ret = its_translate_frame_address(msi_node, &pa);
 	if (ret)
-- 
2.48.0


