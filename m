Return-Path: <linux-kernel+bounces-804135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B64FFB46A84
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821F81B27429
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB712C237C;
	Sat,  6 Sep 2025 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkkU5gVq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A62C1780;
	Sat,  6 Sep 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149807; cv=none; b=JjgV8PLUAoYUPPrm0wCYWG+1GQGbk+ow40VR2Jiqt+QeZhs1+tZWtU72J+hOEZqDE6y8SlHayPx/CiTT4aSxPF+AysemVt2wK0UwWJIxfNERQf3vK5vF+BVX60Hs8L0YOB/P2Fo53KiLQRCoO/p42k+HbOL6C+1AWeJ0c8Kge6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149807; c=relaxed/simple;
	bh=msEvFUeisbWsJc6bi1by+MeXaWzZWt4ywptS+2LY1cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TP6Yrq5qSoy5MwVd4VOfljGEErg7S7e8qRX1MYdeeVYp8wqC+rHfiH1t1+qRukQFBlCAwitkxPKcW9mqr7uQwh9ALDK0E6APXlCfxn8VEm/FTRFTyIiy3h9ylyl95QpdcDJo3MfVkz+PRXwLaPQ+XItsYGFCe/DtPgsyBohYON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkkU5gVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8212C4CEF9;
	Sat,  6 Sep 2025 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757149806;
	bh=msEvFUeisbWsJc6bi1by+MeXaWzZWt4ywptS+2LY1cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kkkU5gVqUfZJcXEKrsU0vjRRCs93ObZOOdvb/2Ir4sweO4xVcDHaK1+85a3Bi/F1p
	 HD0DCKCVdacG0LnIM6+pWq/HEuUFJ02yNpqdbXN/YfPZ9dB3a1RK0DhZDpeUAY1+mv
	 qrTyb8fnycaXtj70UNPpqRVaQQu+W4f7W+g64bdFO6AaR+j64tl5lAKw52i/djKgVl
	 EOMM/oJctUiG4PAKkxndQA4lYf6gvHKmbjyNg1kFUt4Yq6/QMQJ0c+nPqWlyge0OEv
	 8r+AdES5UDDCVpug/WIocnhY23vXngjbQbbS2oHpHrMlf4AakQtr610B8QmIyErYxN
	 8eqfesb7JoKZA==
From: Andreas Kemnade <akemnade@kernel.org>
Date: Sat, 06 Sep 2025 11:09:14 +0200
Subject: [PATCH 3/4] regulator: sy7636a: add gpios and input regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-sy7636-rsrc-v1-3-e2886a9763a7@kernel.org>
References: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
In-Reply-To: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <akemnade@kernel.org>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=msEvFUeisbWsJc6bi1by+MeXaWzZWt4ywptS+2LY1cc=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBm7fwUuqNWOnBQgvK/Jrv5Vprr5Mb7sDzIy3y69lQ6zt
 p36PuNrRykLgxgHg6yYIssvawW3TyrPcoOnRtjDzGFlAhnCwMUpABMRfMDw32399+sOxpUN+0IX
 Z6+3XSA/pUEuwz14pat2fg7X7Jzycwz/I240bth+Zet+t/0byvhjkp+IajZbXpRljlA5fSws9eI
 LHgA=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Initialize input regulator and gpios to proper values to have things
basically working as well as in the case when these things are
hardwired.

Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
---
 drivers/regulator/sy7636a-regulator.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index 27e3d939b7bb9..bd8739624c727 100644
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
@@ -98,6 +101,29 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 	data->regmap = regmap;
 	data->pgood_gpio = gdp;
 
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vin");
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to get vin regulator\n");
+
+	data->en_gpio = devm_gpiod_get_optional(&pdev->dev, "en",
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
+				     PTR_ERR(data->en_gpio),
+				     "failed to get en gpio\n");
+
+	if (data->en_gpio)
+		usleep_range(2500, 4000);
+
 	platform_set_drvdata(pdev, data);
 
 	ret = regmap_write(regmap, SY7636A_REG_POWER_ON_DELAY_TIME, 0x0);

-- 
2.39.5


