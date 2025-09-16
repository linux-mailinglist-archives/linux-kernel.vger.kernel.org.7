Return-Path: <linux-kernel+bounces-818455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370A4B591F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE2A1BC5BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35E298CA4;
	Tue, 16 Sep 2025 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk+ZZzly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7D273D81;
	Tue, 16 Sep 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014342; cv=none; b=ZYQQRZfPS2z4wH7Dcjzgh7EUOSpu8/JFbRSHhsMVgXzMUVWQeDcLRKwby1jTj+cGJk0Jg4fOqmmoriTxNpajBS3K5vviYizEdF8sCZ83pFpqJWiROmj9nyETe5McMvfW1EtNRHgGx/PjY+xeH52rBL4kZwMyqwPousOf0Zbtxfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014342; c=relaxed/simple;
	bh=qB2g+ZKw2xWUvs4kudjzzew1W4c1a8eYuOTpRkQDpds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJBZUBiGPdhYhF+9JjAKxl7Hi6JP6FwIHtya7aO/1nklBEqUXUA+WjaVDMEV2s1mZABHMLOeLP8yo4/rqKPk7cxF8k4T2tIF5+AXrd3wtFyV4C9bqhjZJBg2BOylxHp0KgVmRuXDw+CE8aDw03HdlB9OF5TWCCSRTUnTlMdOOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk+ZZzly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68820C4CEEB;
	Tue, 16 Sep 2025 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758014342;
	bh=qB2g+ZKw2xWUvs4kudjzzew1W4c1a8eYuOTpRkQDpds=;
	h=From:To:Cc:Subject:Date:From;
	b=Hk+ZZzlyxx3MGy8TLfOdkdC2u/ZQjIH5cGi7IH5AnKnDRtVqNnUeM84pRQPzJBujj
	 VcOB3EKTNUAl74KNtprTUCeEkaBLLv5mxbgOOSJLh9QFzDCtHPrWZ7RvmV+XYrL9II
	 LyZ0u1aliYpEr0TyAFAl7YiLaJ4SFHsNnhohg6l9RDHWx4tuZDgUZdXRRm2WBi+VA8
	 johVPGHutqMY4WsNWQL7V+KqBBWMbPx2vs8gP5B4i+yAUeDCq/d1LW+1vfFWKOaAzm
	 onjhGqRExD0Pe3Tab/o+c1OtCUI40hnEAMif/xNUPFnBhODNnK1jtXmcXJveLdY3qi
	 k8BOG99C9SZAw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH] of/irq: Add msi-parent check to of_msi_xlate()
Date: Tue, 16 Sep 2025 11:18:58 +0200
Message-ID: <20250916091858.257868-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some legacy platforms the MSI controller for a PCI host
bridge is identified by an msi-parent property whose phandle
points at an MSI controller node with no #msi-cells property,
that implicitly means #msi-cells == 0.

For such platforms, mapping a device ID and retrieving the
MSI controller node becomes simply a matter of checking
whether in the device hierarchy there is an msi-parent property
pointing at an MSI controller node with such characteristics.

Add a helper function to of_msi_xlate() to check the msi-parent
property in addition to msi-map and retrieve the MSI controller
node (with a 1:1 ID deviceID-IN<->deviceID-OUT mapping) to
provide support for deviceID mapping and MSI controller node
retrieval for such platforms.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index e7c12abd10ab..d0e2dfd0ee28 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -670,6 +670,35 @@ void __init of_irq_init(const struct of_device_id *matches)
 	}
 }
 
+static int of_check_msi_parent(struct device_node *dev_node, struct device_node **msi_node)
+{
+	struct of_phandle_args msi_spec;
+	int ret;
+
+	/*
+	 * An msi-parent phandle with a missing or == 0 #msi-cells
+	 * property identifies a 1:1 ID translation mapping.
+	 *
+	 * Set the msi controller node if the firmware matches this
+	 * condition.
+	 */
+	ret = of_parse_phandle_with_optional_args(dev_node, "msi-parent", "#msi-cells",
+						  0, &msi_spec);
+	if (!ret) {
+		if ((*msi_node && *msi_node != msi_spec.np) || msi_spec.args_count != 0)
+			ret = -EINVAL;
+
+		if (!ret) {
+			/* Return with a node reference held */
+			*msi_node = msi_spec.np;
+			return 0;
+		}
+		of_node_put(msi_spec.np);
+	}
+
+	return ret;
+}
+
 /**
  * of_msi_xlate - map a MSI ID and find relevant MSI controller node
  * @dev: device for which the mapping is to be done.
@@ -677,7 +706,7 @@ void __init of_irq_init(const struct of_device_id *matches)
  * @id_in: Device ID.
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
- * property. If found, apply the mapping to @id_in.
+ * or "msi-parent" property. If found, apply the mapping to @id_in.
  * If @msi_np points to a non-NULL device node pointer, only entries targeting
  * that node will be matched; if it points to a NULL value, it will receive the
  * device node of the first matching target phandle, with a reference held.
@@ -691,12 +720,15 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 
 	/*
 	 * Walk up the device parent links looking for one with a
-	 * "msi-map" property.
+	 * "msi-map" or an "msi-parent" property.
 	 */
-	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
+	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
 		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
 				"msi-map-mask", msi_np, &id_out))
 			break;
+		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
+			break;
+	}
 	return id_out;
 }
 
-- 
2.48.0


