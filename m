Return-Path: <linux-kernel+bounces-804134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961FB46A71
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBBB7C17C3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F03F2C0303;
	Sat,  6 Sep 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIqnrFE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE826C391;
	Sat,  6 Sep 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149804; cv=none; b=LLzbS2I+IXCF6w/10U2WOgifdtmZG37gHJcKeF2Jiai+Bf0TqzqpFnVgrh4MElL8dZ5CUR+q7fZe9o+luJNwaZuPpRS3EVbYDNRMQ78BmDqm+psD42yM7OUGe8DmrxdaeCQkBzGVRuqhUVBrzi1XP3U6xcsD0Q6zqThHeK1CB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149804; c=relaxed/simple;
	bh=pSNaD3syxyAkp0oDtLOoghbbuLA05KsJaZn/Ggv/oP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oMsnebIR9VHFfF8cvaC2OzX3MjxdzSuTxPDIeuThQSDpZDqxnYuDz/Yiq7yF52iLojKjVE4d8lWutuLbynihIAlitjrFYeXAD3hQwnzbDl7/fe0EOVjdSyXvP6HL3GpV7FSJlwdstvLLZl1HVaDtJT6EjV4TyuDHbm6JTdKaDnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIqnrFE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31934C4CEE7;
	Sat,  6 Sep 2025 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757149803;
	bh=pSNaD3syxyAkp0oDtLOoghbbuLA05KsJaZn/Ggv/oP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sIqnrFE+V5sSoLhGvf63EJsJQ4sFaV9HrAMbCzZufeFudIhg8FpopUUV55yCPxnAa
	 XI10q7gDIf2BmXGLaPlH5fy0nwBf8g540IgDQC5diMOh9TsGDhOwsvTt9df1vBr3kt
	 ZbJHelzGBH+P8zr0uVXeaj/ym+ZNk15TOb5EGLHv9H+wVC6W+zT6ZsvgyqDe6+kLLw
	 SUjJ291vQRNqTgGrN9QKKK2yNjTAO0QaHvlhXe2xDVdcxnO1pKWL6rXJMEfuWBHeGa
	 PIeRKooJITwMWhvZu1R+lZKzYobCrLXYon1OPNA1QEd8962N39wzvRxjik3wtLzBj2
	 7zOFxa+3w/Irw==
From: Andreas Kemnade <akemnade@kernel.org>
Date: Sat, 06 Sep 2025 11:09:13 +0200
Subject: [PATCH 2/4] regulator: sy7636a: fix lifecycle of power good gpio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-sy7636-rsrc-v1-2-e2886a9763a7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=pSNaD3syxyAkp0oDtLOoghbbuLA05KsJaZn/Ggv/oP4=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBm7fwWK56ua/g/9yiC7ZtoOJ/YFupcWsWl0fAz7sNnj5
 7QrOpNOdJSyMIhxMMiKKbL8slZw+6TyLDd4aoQ9zBxWJpAhDFycAjCR/eKMDH0tLwL0hcxZD6gy
 FfxW2rXypqL61DIBh4jYY1skLjD8tWT4H8e/5VKNO3P1myMFlqvyw4SSGmbdb42OnLJrUtXzg7y
 ZzAA=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Attach the power good gpio to the regulator device devres instead of the
parent device to fix problems if probe is run multiple times
(rmmod/insmod or some deferral).

Fixes: 8c485bedfb785 ("regulator: sy7636a: Initial commit")
Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
---
 drivers/regulator/sy7636a-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index d1e7ba1fb3e1a..27e3d939b7bb9 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -83,9 +83,11 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 	if (!regmap)
 		return -EPROBE_DEFER;
 
-	gdp = devm_gpiod_get(pdev->dev.parent, "epd-pwr-good", GPIOD_IN);
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
+
+	gdp = devm_gpiod_get(&pdev->dev, "epd-pwr-good", GPIOD_IN);
 	if (IS_ERR(gdp)) {
-		dev_err(pdev->dev.parent, "Power good GPIO fault %ld\n", PTR_ERR(gdp));
+		dev_err(&pdev->dev, "Power good GPIO fault %ld\n", PTR_ERR(gdp));
 		return PTR_ERR(gdp);
 	}
 
@@ -105,7 +107,6 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 	}
 
 	config.dev = &pdev->dev;
-	config.dev->of_node = pdev->dev.parent->of_node;
 	config.regmap = regmap;
 
 	rdev = devm_regulator_register(&pdev->dev, &desc, &config);

-- 
2.39.5


