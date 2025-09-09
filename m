Return-Path: <linux-kernel+bounces-808987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3EB5072B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C397B3F4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5D35FC20;
	Tue,  9 Sep 2025 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDJsVozv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B75340DA3;
	Tue,  9 Sep 2025 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450054; cv=none; b=B7nRhq+JxJ3CjP2vFffLfscFkVbKbjcsX7WdXoNuuHue/Vw3p4iy4n63/Vq10kpASXTeUin7jBXWjRgUhWCgXUhyGCOhNHfZnW5TQahEBYlgAplllkd81Rg0n05YM4/z4AfIyLLXnXRUbu4pgvt5+AEMko+FR9IVIeu1gsClqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450054; c=relaxed/simple;
	bh=76+8+D7pi06bGKU9um3GrMq4oi6bCmK0qMW+HC6+J8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JuUQhAlHYDbraump0RX8afx1Hs260pMEahGRGP7ASuwiAy1PCe1PHI/t/ja9vnwbfImLZFRbh3J5hV/Bpz/9ZMmjqCZEwz0gHwjQsed5r2ODQQlgECBz59c1vU9aC+0ky48+ceFwJ5/Fm6p+TyPmR15BVkUi0GfgZYRpfMROjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDJsVozv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A85C4CEF4;
	Tue,  9 Sep 2025 20:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757450054;
	bh=76+8+D7pi06bGKU9um3GrMq4oi6bCmK0qMW+HC6+J8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LDJsVozvEFFgKrIMZU6AfkGVSyvQMLiAistgt63IlJZri0e+FJnJE2wR9diGm/2PP
	 7t9moEgjqM/QzWnawuAuY+uJFPDfJpaFWkDizIXz+5F+vRlBc4oG1tFjjIBQbLSuxX
	 KuvGokd0EoGnYiV3721Xmf2zfvB2fUZLQVabyz+EnSj15SlEalLJSOtTZq94iavTjH
	 dyiNsuGhlR2WN3p4fPQ20iFwMT8AXdmpqB5WkcZeSXt8uINiLr+UmA89nVBuoRyjYP
	 SnZOXNjXUU/DrFtaRuxl4BoQYW+XCRBNo8nXEQleBBl5Q9gpNbbN02kGmN5FFl5O/A
	 Ike58XrZFL2Dg==
From: Andreas Kemnade <akemnade@kernel.org>
Date: Tue, 09 Sep 2025 22:33:03 +0200
Subject: [PATCH v2 2/3] regulator: sy7636a: add gpios and input regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-sy7636-rsrc-v2-2-cfd9f44fd259@kernel.org>
References: <20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org>
In-Reply-To: <20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=76+8+D7pi06bGKU9um3GrMq4oi6bCmK0qMW+HC6+J8E=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBkH+q3iZAOMuydkCGxm3dd1nfVIqMk0YZ8+GZO0B4yTs
 h06f6zvKGVhEONgkBVTZPllreD2SeVZbvDUCHuYOaxMIEMYuDgFYCJbxRn++2+7bBjfpNxg9DX/
 ccLzmFk6kqkOZaUJRQ51n5JO3Xy0i5Fhj8vZOX+YmE5m1gtkbzS/6Ovhbb434mrhh3e7U3Y5Pv3
 DAAA=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Initialize input regulator and gpios to proper values to have things
basically working as well as in the case when these things are
hardwired.

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
2.39.5


