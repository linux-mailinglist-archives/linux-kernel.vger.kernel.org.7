Return-Path: <linux-kernel+bounces-882314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EFAC2A295
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8A684EC0CD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04528DEE9;
	Mon,  3 Nov 2025 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J9TbzQkf"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9E238C2A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150877; cv=none; b=OD7LUeqtvQdAEDlsuE+Tf9t6rJ7b5Uuhwoem05NOMZlEdnwDys24YrwtlGqURDaqdK7qvU6y4Q4zG+PvOh3Rm2tbbM3w9OfRlHD7aPysuTjrziZ/Jzus9lyLh8dymqcOlTWKF16yHM62MiPIUY1um7dKP16OOJOnhHGX7RsF4ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150877; c=relaxed/simple;
	bh=NdHOhxDB5X511h77TiK0y3+SbRf+3iHy43ELTPyc6yU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dhgs2+LpfeZKXclMlkunDdnqgIRU1wiAo/p7eRigvNHmvYsWbrsz4JaXYArPO4W0MrPs4Q9g5mFyVieJ0dAznztieiqMQbAQf9rxQAaHqaBpdxVAQcmS3qjf1gswg2Tl5hLe6BN9STSuxdrccOYdntY9ySH3YqVds/CxsiBeTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=J9TbzQkf; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4795708ab87d11f0ae1e63ff8927bad3-20251103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6KEPQoelIaSRZixu2FcCj8GjygNUojPP6SBnzoaIaQY=;
	b=J9TbzQkf1RHiwoyYg21ABsKdPvvFSeDE8fysDSeEBh/wNpaZb0E8njL1q9N28N/m4RFHPNDKJYJ49yQ9FB9Dnf5y//6hgiFKO2UwXnT7aSoaR6U486oK4wphWeQ64lww3ablwnXiqqmA75Nvfyrbg3gXYnNb9xpg6808+w0zp6c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:718f3b56-4151-4777-9baf-526e0e519b72,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:31ee0fe0-3890-4bb9-a90e-2a6a4ecf6c66,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4795708ab87d11f0ae1e63ff8927bad3-20251103
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ot_zexin.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 282544113; Mon, 03 Nov 2025 14:21:05 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 3 Nov 2025 14:20:59 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 3 Nov 2025 14:20:58 +0800
From: Zexin Wang <ot_zexin.wang@mediatek.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Zexin Wang
	<ot_zexin.wang@mediatek.com>, Jack Hsu <jh.hsu@mediatek.com>
Subject: [PATCH] reset-controller: ti: introduce a new reset handler
Date: Mon, 3 Nov 2025 14:21:00 +0800
Message-ID: <20251103062103.32697-1-ot_zexin.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Introduce ti_syscon_reset() to integrate assert and deassert together.
If some modules need do serialized assert and deassert operations
to reset itself, reset_control_reset can be called for convenience.

Signed-off-by: Zexin Wang <ot_zexin.wang@mediatek.com>
---
 drivers/reset/reset-ti-syscon.c | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
index 23f86ddb8668..f37685e32b0a 100644
--- a/drivers/reset/reset-ti-syscon.c
+++ b/drivers/reset/reset-ti-syscon.c
@@ -7,6 +7,7 @@
  *	Suman Anna <afd@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -42,12 +43,14 @@ struct ti_syscon_reset_control {
  * @regmap: regmap handle containing the memory-mapped reset registers
  * @controls: array of reset controls
  * @nr_controls: number of controls in control array
+ * @reset_duration_us: time of controller assert reset
  */
 struct ti_syscon_reset_data {
 	struct reset_controller_dev rcdev;
 	struct regmap *regmap;
 	struct ti_syscon_reset_control *controls;
 	unsigned int nr_controls;
+	unsigned int reset_duration_us;
 };
 
 #define to_ti_syscon_reset_data(_rcdev)	\
@@ -150,9 +153,37 @@ static int ti_syscon_reset_status(struct reset_controller_dev *rcdev,
 		!(control->flags & STATUS_SET);
 }
 
+/**
+ * ti_syscon_reset() - perform a full reset cycle on a device
+ * @rcdev: reset controller entity
+ * @id: ID of the reset to be asserted and deasserted
+ *
+ * This function performs a full reset cycle by asserting and then
+ * deasserting the reset signal for a device. It ensures the device
+ * is properly reset and ready for operation.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int ti_syscon_reset(struct reset_controller_dev *rcdev,
+		   unsigned long id)
+{
+	struct ti_syscon_reset_data *data = to_ti_syscon_reset_data(rcdev);
+	int ret;
+
+	ret = ti_syscon_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	if (data->reset_duration_us)
+		usleep_range(data->reset_duration_us, data->reset_duration_us * 2);
+
+	return ti_syscon_reset_deassert(rcdev, id);
+}
+
 static const struct reset_control_ops ti_syscon_reset_ops = {
 	.assert		= ti_syscon_reset_assert,
 	.deassert	= ti_syscon_reset_deassert,
+	.reset		= ti_syscon_reset,
 	.status		= ti_syscon_reset_status,
 };
 
@@ -196,6 +227,9 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
 		controls[i].flags = be32_to_cpup(list++);
 	}
 
+	of_property_read_u32(pdev->dev.of_node, "reset-duration-us",
+			     &data->reset_duration_us);
+
 	data->rcdev.ops = &ti_syscon_reset_ops;
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.of_node = np;
-- 
2.45.2


