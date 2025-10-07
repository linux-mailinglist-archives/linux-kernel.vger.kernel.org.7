Return-Path: <linux-kernel+bounces-843942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5BBC0A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC293C6189
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE362D5C83;
	Tue,  7 Oct 2025 08:32:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A62D593D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825973; cv=none; b=XzdqdCYmHyMSprq9jmeSG33ty0Zgw32d8yytX5A+gG0RsgwIIJWcrJ9wpzZPGwoxY0XL5OlmmNfPZpsIMafykK7D2FqqsZwveCnnMYz4m+SE+HSfpbOfUF1JuhF6+g87z6UcUuclmdG5qWquoPCcxONxkB2C/X+AWBCWi1oIfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825973; c=relaxed/simple;
	bh=AVBfmsk8JAu4BzoU++vEPTxRzQ+o+Bv6YjgzmWEgqjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYT9aVxk3HFYOD9b6v8bihhjbTOcSWDemqFa1O3IlAeCBv2dSfK1vi6C3G1VhBCshlzvtARW4iqQdE1F/5nOctH7ix/c9a6v20IYqNafsp6K1eqnvxqf7tT0YzO/pFh1RHYkDywamyx8UFnKzSRMDX/H2+hCORqL3SCZf0hV/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=peter.mobile.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1v637o-0002Hb-R4; Tue, 07 Oct 2025 10:32:48 +0200
From: =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
Date: Tue, 07 Oct 2025 10:31:54 +0200
Subject: [PATCH 01/16] media: rockchip: rga: use clk_bulk api
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-spu-rga3-v1-1-36ad85570402@pengutronix.de>
References: <20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de>
In-Reply-To: <20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de>
To: Jacob Chen <jacob-chen@iotwrt.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.pueschel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Use the clk_bulk API to avoid code duplication for each of the three
clocks.

Signed-off-by: Sven Püschel <s.pueschel@pengutronix.de>
---
 drivers/media/platform/rockchip/rga/rga.c | 64 ++++---------------------------
 drivers/media/platform/rockchip/rga/rga.h |  5 +--
 2 files changed, 9 insertions(+), 60 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 776046de979aa0ded6734216bf179c32ae8fe5a9..6438119a6c7aeff1e89e7aa95dcd5d2921fefa08 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -702,48 +702,10 @@ static const struct video_device rga_videodev = {
 	.device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING,
 };
 
-static int rga_enable_clocks(struct rockchip_rga *rga)
-{
-	int ret;
-
-	ret = clk_prepare_enable(rga->sclk);
-	if (ret) {
-		dev_err(rga->dev, "Cannot enable rga sclk: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(rga->aclk);
-	if (ret) {
-		dev_err(rga->dev, "Cannot enable rga aclk: %d\n", ret);
-		goto err_disable_sclk;
-	}
-
-	ret = clk_prepare_enable(rga->hclk);
-	if (ret) {
-		dev_err(rga->dev, "Cannot enable rga hclk: %d\n", ret);
-		goto err_disable_aclk;
-	}
-
-	return 0;
-
-err_disable_aclk:
-	clk_disable_unprepare(rga->aclk);
-err_disable_sclk:
-	clk_disable_unprepare(rga->sclk);
-
-	return ret;
-}
-
-static void rga_disable_clocks(struct rockchip_rga *rga)
-{
-	clk_disable_unprepare(rga->sclk);
-	clk_disable_unprepare(rga->hclk);
-	clk_disable_unprepare(rga->aclk);
-}
-
 static int rga_parse_dt(struct rockchip_rga *rga)
 {
 	struct reset_control *core_rst, *axi_rst, *ahb_rst;
+	int ret;
 
 	core_rst = devm_reset_control_get(rga->dev, "core");
 	if (IS_ERR(core_rst)) {
@@ -775,22 +737,10 @@ static int rga_parse_dt(struct rockchip_rga *rga)
 	udelay(1);
 	reset_control_deassert(ahb_rst);
 
-	rga->sclk = devm_clk_get(rga->dev, "sclk");
-	if (IS_ERR(rga->sclk)) {
-		dev_err(rga->dev, "failed to get sclk clock\n");
-		return PTR_ERR(rga->sclk);
-	}
-
-	rga->aclk = devm_clk_get(rga->dev, "aclk");
-	if (IS_ERR(rga->aclk)) {
-		dev_err(rga->dev, "failed to get aclk clock\n");
-		return PTR_ERR(rga->aclk);
-	}
-
-	rga->hclk = devm_clk_get(rga->dev, "hclk");
-	if (IS_ERR(rga->hclk)) {
-		dev_err(rga->dev, "failed to get hclk clock\n");
-		return PTR_ERR(rga->hclk);
+	ret = devm_clk_bulk_get(rga->dev, ARRAY_SIZE(rga->clks), rga->clks);
+	if (ret) {
+		dev_err(rga->dev, "failed to get clocks\n");
+		return ret;
 	}
 
 	return 0;
@@ -939,7 +889,7 @@ static int __maybe_unused rga_runtime_suspend(struct device *dev)
 {
 	struct rockchip_rga *rga = dev_get_drvdata(dev);
 
-	rga_disable_clocks(rga);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(rga->clks), rga->clks);
 
 	return 0;
 }
@@ -948,7 +898,7 @@ static int __maybe_unused rga_runtime_resume(struct device *dev)
 {
 	struct rockchip_rga *rga = dev_get_drvdata(dev);
 
-	return rga_enable_clocks(rga);
+	return clk_bulk_prepare_enable(ARRAY_SIZE(rga->clks), rga->clks);
 }
 
 static const struct dev_pm_ops rga_pm = {
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index 72a28b120fabfdce39e7773358d0c9528019e882..a922fac0c01a3627f5149c78a1560341428a4fc1 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -6,6 +6,7 @@
 #ifndef __RGA_H__
 #define __RGA_H__
 
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-ctrls.h>
@@ -81,9 +82,7 @@ struct rockchip_rga {
 	struct device *dev;
 	struct regmap *grf;
 	void __iomem *regs;
-	struct clk *sclk;
-	struct clk *aclk;
-	struct clk *hclk;
+	struct clk_bulk_data clks[3];
 	struct rockchip_rga_version version;
 
 	/* vfd lock */

-- 
2.51.0


