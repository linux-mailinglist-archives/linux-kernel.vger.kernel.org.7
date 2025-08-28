Return-Path: <linux-kernel+bounces-789706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D0EB3996A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F5E1C26B81
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2EB30DD11;
	Thu, 28 Aug 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSyTYhid"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B7530C61B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376141; cv=none; b=jG3ZJSzjYchDjHMt2gUwzuMlWO0FnqcYw1T/sxmeMeAXL6//9mjZfuG1n34LtOYZB3iqhNuotYDDwwkqzbhR9idsRi6Y/HPITeiKLmGpBpXJX+grw6DQGF3ljdtfDzmFSLyhaW2+4lVzgmy1Wxf7AIY+052KgLZmZwkAS3xWoEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376141; c=relaxed/simple;
	bh=DUL2bJxMgqW72KZYcQEl8qxFnW9WLPKvK26PzfIBBY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oU6ign1460vi7aMMXflrT7FOb3pRjtd/SQlRRrJJCj754l9xdU93fbHhlO0Ysny3q327kqsCVOqavlQ+Cr1MpmWHl/RU0ZelF6pB16dGi02b0ouocN6RXPriXP80ZY8MgYOWoY8gpbUHw2BB92vfzdrrWEdab+0kX8kCQZNPwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tSyTYhid; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso6242535e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376138; x=1756980938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twA1DevhQnABtZ7AE3O2A15G4iJ3iu3xsP8XB6FKzM0=;
        b=tSyTYhidMOzscF1BAM66qYXkPc90dpsBNNjpTd5TC4ZG2BD44fnC5EXUVS/k/aGAd6
         6NXxjo/C4wxVeWZBfzkDlfiAWDZrvtLiv37zagEBfOUsrbWjenH4Zm3C+Ojr80BJLejE
         BWdCjvrAsyE24iDOCzkwDd4j9DqYIHH55lK3UHQBEtb5txa8xSfiFYEzB1o8StDOtBVT
         TL+OX9lOiMtDOkWPCntnUJBvd0UrHe083Um90CpFKPAgBuIzrtUUbAbWXAg3JmSh8eLV
         nqsXu2qwUAGWlkZxwS+c6STFNl8TENruNVGX8LUwdiQGljQKxj43rKgfrCS8lY39E3+Y
         SGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376138; x=1756980938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twA1DevhQnABtZ7AE3O2A15G4iJ3iu3xsP8XB6FKzM0=;
        b=rfZHlmAX/kCA0r8yvFoK80Yb+E96fWkxcl7aXms1j6JItDqe02ppfJJOq5GK2cDjI/
         O5oDr9PKEtHTjQAAU2NSKQc8uYl+Rx8FJR5HneZxwPVMJEXCsdQQbuAd+9GAq6/8CyfB
         iJ/Yu81NVgvkdX6aohnyJPoi6MND5HCw5H0rHOanSaKjkWFa3TDVq9n278oIGI+G2gJf
         8uPifmJ6uqOdTVVFIs6Z35J3GSG21WkvoF3+fEWJiFI0Nwa0fzdgjaQIUSL+gxXOdhU3
         8QFzdedj0Ca/BJ+83fAOkt++Zw5FrAA5yKmj4p4NHneIPB2jbhLzQnO483lCeEDdKXqo
         JNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOdFd10zqc9zRLDSL6hlWnH05Xwd6Czh6Zi9ibFa3T+r0iGWclubnzUpGSxd4kBxG/EvtCp6HNPoEeCEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxmmnNqJ0j60XSnno6ux+4RiQjqJ7HWnNXlJHXE2bIX4vwjhuU
	fQyZi/zwik8GGGur9BoZVR77lkNGx5aoAbuMu0RIH41NX4OmCJsLtRO3ZxkUge8ovWU=
X-Gm-Gg: ASbGnctnralYr13cWSONvp0SKdcE44vLnA2ms2Bmx1V8+Cx5ka3ujlCJMhYGs9+gMtR
	YHyMEhM/dDaphp93jSZinGMA2BL5Hrt7YgikhpzlTZPSSpzN+n7RcWBv+WazS9amOXqSWFREetq
	7mHQ8a4FOcR7ukrTsV7DnCRgUQ7sW2cW75YgpVHQYAczUh4jWDcdFyIriWc4XWnyuJ/sr2ktO5/
	eBKC62tsQbmBSQoExjk5RsVSYMPe4gBn85QmuEKc2EO/xL5AogMKOyrBFTrEA7+VQQVdbUmWGtj
	yD6HHL/gBjZ7xou2SkQlhaIAcXLYri3JzEprSJBY9zrKkbdigDFWBciJQjkn4J6+BCw0zyqbWWO
	SrJeGFKr1mjN/hemfKbmAYVPNn/BGwv882RPZZzEfbw==
X-Google-Smtp-Source: AGHT+IGnwrpzezgJXIVPIURZAHVNyOiUW87JNySJUaEe/V4TYWQ5vU2ILUn3A5NCE2JjHClrcg+0dA==
X-Received: by 2002:a05:600c:1389:b0:455:f59e:fd9b with SMTP id 5b1f17b1804b1-45b517c584cmr224745325e9.24.1756376137717;
        Thu, 28 Aug 2025 03:15:37 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:47 +0100
Subject: [PATCH v2 8/9] spi: spi-fsl-lpspi: Parameterize reading num-cs
 from hardware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-8-6262b9aa9be4@linaro.org>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
In-Reply-To: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

Add query_hw_for_num_cs in devtype to avoid directly checking compatible
string "fsl,imx93-spi".

No functionality change.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index ea25e8dab0a4..ce347cdbb009 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -87,6 +87,7 @@
 
 struct fsl_lpspi_devtype_data {
 	u8 prescale_max : 3; /* 0 == no limit */
+	bool query_hw_for_num_cs : 1;
 };
 
 struct lpspi_config {
@@ -137,6 +138,7 @@ struct fsl_lpspi_data {
  */
 static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
 	.prescale_max = 1,
+	.query_hw_for_num_cs = true,
 };
 
 static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
@@ -932,7 +934,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
 	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
 				 &num_cs)) {
-		if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx93-spi"))
+		if (devtype_data->query_hw_for_num_cs)
 			num_cs = ((temp >> 16) & 0xf);
 		else
 			num_cs = 1;

-- 
2.34.1


