Return-Path: <linux-kernel+bounces-760082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815BDB1E643
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654727A7F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDD8274B5C;
	Fri,  8 Aug 2025 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P8RapCG2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD492741DC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648011; cv=none; b=MNBfnMU4r5aTnfYPfiVQ3v1V9FNfdPGDTvbmfNHAc7kxeiqJIfKfKQDEckpR9t7w6Eg/lmj5NZcy4aiqBM5SnSKejtJXj9mgKku9mOOavDhLgYjBoU6klZgGAHZtw/iR8jZyydjmbEdExbJjGvTSZNP7gL+7zNbRuBD3l0Lb3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648011; c=relaxed/simple;
	bh=8DVZ94uzcqoNX+9EdxOkXfy9Z7a63Lc/mZv8MzFgZ6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QazjvBWvQoWSy0t168TlliZit9KQAtUBrSDIq+0NNKbefPqoBLY2HfNaNRyqLcHAnrAvOPKeSwtuFU2E+Nd9PsI8BXxD3NWifkZbWuB9x7TA6IPdPbGNgOtph0y2ZrsmE8QvZSxwdN22q2J2D0wXlHchaNq54W30v9leujjvKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P8RapCG2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754648006;
	bh=8DVZ94uzcqoNX+9EdxOkXfy9Z7a63Lc/mZv8MzFgZ6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P8RapCG2/r8UQvhCXvIa1Imk5Dsgg/FG8F1eXWLO0GaUlLd6Jt0X7eSSna9uNmpST
	 cFOgWPyrwiecPf3iYNn6MRbNKRkJNvnKyzcyhIzrbNrP1xP+1t/cfSRKIfLYGrufF2
	 acqAAZscDgsoljB/pUguRH73L/vYmh/Hrs7L4xDaUnvi6L9uYq/Ii37VCXQVtqlV45
	 LIBbhWAM4wVN2EzRzWGmbxdb85AgkSsTbgz/tQtjXoZ49CjzmnumfKftZATIDk48DV
	 R1dzun12O9B0u7DyEZ0KkrzTwjAfeAK2Jv4LmyGJ11frrDRQdcXpNXx+lXrKgrLUfJ
	 lRgXaL5I9d4hQ==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 50D0217E1298;
	Fri,  8 Aug 2025 12:13:26 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 08 Aug 2025 12:12:15 +0200
Subject: [PATCH v10 05/10] drm/mediatek: mtk_hdmi_common: Make CEC support
 optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-mediatek-drm-hdmi-v2-v10-5-21ea82eec1f6@collabora.com>
References: <20250808-mediatek-drm-hdmi-v2-v10-0-21ea82eec1f6@collabora.com>
In-Reply-To: <20250808-mediatek-drm-hdmi-v2-v10-0-21ea82eec1f6@collabora.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754648002; l=2372;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=rXYgOuvY4xVEkhoV1yELheebNy9aj44v5phMhyfwfOk=;
 b=tAqo5e9EJRvOYDGl6xb1rbTZQ9T2ZgVBxc0PRLIydgM8xA1wMP6BNy9P8bMedMmQm2NQjNldM
 qoygPQNpPCaCNzPmMKFOT0P5KGrgHyxg4wOdveoj3gNQplmEYFIIrdB
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

In preparation for adding a new driver for HDMIv2, for which CEC
is not strictly required, change the of_get_compatible_child()
failure error to -ENOTSUPP to be able to differentiate between
error conditions in mtk_hdmi_dt_parse_pdata().

In that case, if -ENOTSUPP is returned, this driver will print
an informative message saying that CEC support is unavailable,
as the devicetree node for that was not found, but after that,
function mtk_hdmi_dt_parse_pdata() will not return error to
the caller.

This will not change functionality of the mtk_hdmi (v1) driver
as that is still checking whether CEC is present and, if not,
will fail probing with an error saying that CEC is required
by HDMIv1.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index f28e63716d7c2e2c6bdf5b28d24789bc926d2beb..989479fdfe40952762a1b63797bf602b520dcac5 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -253,12 +253,11 @@ static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struc
 	/* The CEC module handles HDMI hotplug detection */
 	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");
 	if (!cec_np)
-		return dev_err_probe(dev, -EINVAL, "Failed to find CEC node\n");
+		return dev_err_probe(dev, -ENOTSUPP, "Failed to find CEC node\n");
 
 	cec_pdev = of_find_device_by_node(cec_np);
 	if (!cec_pdev) {
-		dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
-			cec_np);
+		dev_err(hdmi->dev, "Waiting for CEC device %pOF\n", cec_np);
 		of_node_put(cec_np);
 		return -EPROBE_DEFER;
 	}
@@ -319,7 +318,9 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device
 		return dev_err_probe(dev, -EINVAL, "Failed to get ddc i2c adapter by node\n");
 
 	ret = mtk_hdmi_get_cec_dev(hdmi, dev, np);
-	if (ret)
+	if (ret == -ENOTSUPP)
+		dev_info(dev, "CEC support unavailable: node not found\n");
+	else if (ret)
 		return ret;
 
 	return 0;

-- 
2.50.1


