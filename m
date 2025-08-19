Return-Path: <linux-kernel+bounces-775785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B3CB2C513
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE62EA21D12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009133EB0F;
	Tue, 19 Aug 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OthIoQoU"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E72AE66;
	Tue, 19 Aug 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608913; cv=none; b=MqEK3h0aXDnLgKONeLjIOjhtDHJ/Sqs3VfKhLozdSPruMQu3zILTOXMN5belwa6W8SlJ4oQOmTFre0c3OlyNb6bTVd6C3sIylc1BIZYW7XQAr8Kg9RKpTWvMNIxRSuqxsScTPE9FPd08O15OxF3MJ/EU0oSu2SfknIrWBSOpJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608913; c=relaxed/simple;
	bh=8zUPQxsJ00o23KO+Mia4uw1VdDmxrpvNbCcQ7zUwIBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuOaRGzLRhB9RqPJiWBgFmRO6lrJnTwKzqOvL4pGFRS7QJxANsTn1+fELECrsEIuiGBpJDoCkzb8K4LePF6Ql1fXzgzAOW0PkG0K8qOc/8snY7wwyv/wNHRsyYAnkiLwsS0rftAxRx6DZucufGa3/mH/Zy3zwkcJMUHCNUzxxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OthIoQoU; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JD8Bul014890;
	Tue, 19 Aug 2025 08:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755608891;
	bh=5H4GVxhV5ns4CJy71IjFHJfll6xwTub0lOZHwjCYtrU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OthIoQoUhpmPtoA7Z2PBcxlz3ktM4Vx6LOIxTLdtVFpLPCEsJNIF4CADrJE3sh8m2
	 Q7OTTFDBTIQwK0OhPpWxE3F7GPVRSwBHPJNSdDyGoXUHAluyFFzDf8+dAq7QfKlc48
	 Ab1kze8KBzQpcAAOszYfY6WlNoKMhRSMQ+fpJdwY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JD8Bb0421275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 08:08:11 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 08:08:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 08:08:10 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JD8Aqc2747730;
	Tue, 19 Aug 2025 08:08:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie
	<airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>, <afd@ti.com>,
        <tomi.valkeinen@ideasonboard.com>, <devarsht@ti.com>,
        <dmitry.baryshkov@oss.qualcomm.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 2/5] drm/bridge: it66121: Drop ftrace like dev_dbg() prints
Date: Tue, 19 Aug 2025 08:08:04 -0500
Message-ID: <20250819130807.3322536-3-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250819130807.3322536-1-nm@ti.com>
References: <20250819130807.3322536-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Drop the ftrace like dev_dbg() that checkpatch --strict complains about:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+	dev_dbg(dev, "%s\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+	dev_dbg(dev, "%s\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+	dev_dbg(dev, "%s\n", __func__);

Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in V4:
* Picked Reviewed-by Tags

V3: https://lore.kernel.org/all/20250815034105.1276548-3-nm@ti.com/

 drivers/gpu/drm/bridge/ite-it66121.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index aa7b1dcc5d70..9b8ed2fae2f4 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1384,8 +1384,6 @@ static int it66121_audio_startup(struct device *dev, void *data)
 	int ret;
 	struct it66121_ctx *ctx = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	mutex_lock(&ctx->lock);
 	ret = it661221_audio_output_enable(ctx, true);
 	if (ret)
@@ -1401,8 +1399,6 @@ static void it66121_audio_shutdown(struct device *dev, void *data)
 	int ret;
 	struct it66121_ctx *ctx = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	mutex_lock(&ctx->lock);
 	ret = it661221_audio_output_enable(ctx, false);
 	if (ret)
@@ -1479,8 +1475,6 @@ static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
 		.no_capture_mute = 1,
 	};
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	if (!of_property_present(dev->of_node, "#sound-dai-cells")) {
 		dev_info(dev, "No \"#sound-dai-cells\", no audio\n");
 		return 0;
-- 
2.47.0


