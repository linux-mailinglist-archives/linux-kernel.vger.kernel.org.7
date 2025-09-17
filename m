Return-Path: <linux-kernel+bounces-820117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E4EB7C7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC207B3152
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D42F546D;
	Wed, 17 Sep 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOzp4bCO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873682E7F0E;
	Wed, 17 Sep 2025 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093302; cv=none; b=pqIaoSVpmkD+zWcrATsEZNh9Z0FybfYevwkj1qY6x6L2/+tB6WI5VFd/9ReWCpdk+FGqNnHm37KWxbogslxfth2pLat63CY8aPQM4yjoPHjMKICFjMXqzFmlfA3Hdd9v0tVVGlozNi7fXEyFRWMnw8/qr679OGsCVyfL2daVBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093302; c=relaxed/simple;
	bh=Sd9OX7cLVBw3ifGFhl2zDm5dTNzLv+EJ603kV1lQF6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3CNJ602SKw63B4DL0OiUVS/zNXQTLvYDw/ZdzbNpap8dR6y2K7B68DZtiGm8f0zhGlJqjgDRl8dXek+YT5CWAmtNe4rbunVU2eaSHdW4ERDHmu51ig/yHRdpYNbE0uJR0m8RvbwPtMSUHOMoRR9ZbVel372NeFiw6vgJRVASl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOzp4bCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5E3C4CEFC;
	Wed, 17 Sep 2025 07:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758093302;
	bh=Sd9OX7cLVBw3ifGFhl2zDm5dTNzLv+EJ603kV1lQF6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JOzp4bCODK1LOa1CeTz/28NtDBh5+qqOEO22zPpaEY0Kj9FqR68fU2Fkx7BEH9Nwn
	 DlXKMGx1WNEonEtcEEaVc1DnZj+CNW96GB1KiJBF4UO6YDuYt/bqRirsrIYfCQozlW
	 npUl4GjvmiOg1MOoBCgKlnKBJrzhwPrjib2PQXoUKg5eCB0PU7qwhCClgcRPe6pP7E
	 SjAUIQvB73xVcN79StBv59g6mOxwUxW3tLagVt2d8rh0+4Jdi48y4zeo3kq4XBERoo
	 DKBZ/QVLcY86WuAmSrk7BMMvRg9Zzf0R3IYx270LRM3/UpCLewUoTbOB/SOqPW5iL+
	 dDuVa/SSvon3A==
From: Andreas Kemnade <akemnade@kernel.org>
Date: Wed, 17 Sep 2025 09:14:30 +0200
Subject: [PATCH v3 2/3] regulator: sy7636a: add gpios and input regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sy7636-rsrc-v3-2-331237d507a2@kernel.org>
References: <20250917-sy7636-rsrc-v3-0-331237d507a2@kernel.org>
In-Reply-To: <20250917-sy7636-rsrc-v3-0-331237d507a2@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <akemnade@kernel.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=Sd9OX7cLVBw3ifGFhl2zDm5dTNzLv+EJ603kV1lQF6U=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDBmn4l+etTI412eSuHGTT5H/cuflrlwTT3bdSxCcIPvi2
 /kV78Kud5SyMIhxMciKKbL8slZw+6TyLDd4aoQ9zBxWJpAhDFycAjCR5jCGv+IfpolPcv2Ynaqx
 hTEx5qnBRabLlUr/kvSXJ0q6M++2PcfI8PNg82x37cpLr2c2ul13CJ8bOF+t+831+sUzJrfK9q1
 dzgwA
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Initialize input regulator and gpios to proper values to have things
basically working as well as in the case when these things are
hardwired.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
---
 drivers/regulator/sy7636a-regulator.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index 27e3d939b7bb9..551647bc10520 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/sy7636a.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regmap.h>
@@ -19,6 +20,8 @@
 struct sy7636a_data {
 	struct regmap *regmap;
 	struct gpio_desc *pgood_gpio;
+	struct gpio_desc *en_gpio;
+	struct gpio_desc *vcom_en_gpio;
 };
 
 static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
@@ -98,6 +101,30 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 	data->regmap = regmap;
 	data->pgood_gpio = gdp;
 
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vin");
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to get vin regulator\n");
+
+	data->en_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(data->en_gpio))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(data->en_gpio),
+				     "failed to get en gpio\n");
+
+	/* Let VCOM just follow the default power on sequence */
+	data->vcom_en_gpio = devm_gpiod_get_optional(&pdev->dev,
+						     "vcom-en", GPIOD_OUT_LOW);
+	if (IS_ERR(data->vcom_en_gpio))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(data->vcom_en_gpio),
+				     "failed to get vcom-en gpio\n");
+
+	/* if chip was not enabled, give it time to wake up */
+	if (data->en_gpio)
+		usleep_range(2500, 4000);
+
 	platform_set_drvdata(pdev, data);
 
 	ret = regmap_write(regmap, SY7636A_REG_POWER_ON_DELAY_TIME, 0x0);

-- 
2.47.3


