Return-Path: <linux-kernel+bounces-856534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D78BE46B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB3E5E0CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453D393DEF;
	Thu, 16 Oct 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFtD4zJB"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D437369970
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630338; cv=none; b=Y621Bb0Wc4/Jm1HPEF5GvvJlwsxKOHg0GCdlStNIX1Op8ZfesYpNVsc8b4U8dcgOLUpkwDLBylsPHThs7ve3thWDt/JjDbs6pt0P4UhtHEvgTLRwVHIZJq37Vo6rkBteYBUJJHLy/uqpsT5Quoif3he2tMHMmHZAs8N13s1hcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630338; c=relaxed/simple;
	bh=/ffMxuodyntRU0TJwCLIfgdiy8tvJ3D6CLikLFYkO/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjxsZ6ktDJZ0qoJAP2t7uIZL1Xe7Z+NazY1+YZsMHwkNnX3k6cp5Q4SzYYg06VSk1vd+lon8oAPy1lKYzQc02GnMuNCUFKDbpxa/4RPJ2MDX77Smj6kbT7USn4ouzXNiA5tuivyY8fh8kvjJwUniEcFhJxBaXgO7KVxIbzV98C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFtD4zJB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b40f11a1027so171479266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630332; x=1761235132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DqQ6MoGys1zapyNUJpLRuxdOB+fSzbQVKEkSbvrKC4=;
        b=iFtD4zJBDE4EjW+2cTWPAgc02LwhOH+o7DOSuK2VA0Xggja7MlzamKSyHLdTYKpzOO
         aP2Bn9LyadytRRPJuF4A4V4H0ZGWvBejqumysnUmiS2HzzlCHmK+sESOT6Vnp3rXu1Uz
         IZcjFY488xnl1pnlk0l8catogL2GurjI54+npd4BGqA5KFiNNDLSCpeZzSFPFXm5GSPB
         AkdXjmpWl1POriJb7nVQXJbHL7Tg/+HSqaTdjhyV8hJ6MFZRIJKFph+wrMByzWTGTAQa
         hqeraFg3D29mwI14enlQwRaD0BU2phbKKTSfvfzqPv3M9NPtzcJLVPz6bkbmvCgl2e18
         w/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630332; x=1761235132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DqQ6MoGys1zapyNUJpLRuxdOB+fSzbQVKEkSbvrKC4=;
        b=Ilx23h8rVJIQtWiQnlrBRNFfErDZOF3GJT6Wk3GGad0R7qee+w/jbJGlz0M8F1xRq3
         C02We1WKtnBXD1IWpBQalAIePlJ1WwaOytcPSezwkd5nWMXM3D7dyQKvTTJvQOq68xc5
         ecv1y9SePCfCrUAtdIHsk4ObBqxrZYthMixFn8AtniYe2AD1Mtk3p4+3aaHGBLJvIbYz
         s1RfIPUcotPy9/ytZEUtcoV0M8/E/tEl9pA1t67Gn7ACk9YCbgkish6/0nTzIEDYIWBX
         bDBMYCGS4vvwicjTPXHv4rhNv0+jQrmr/d8LJt53+l0yWulJeUnOs6+c9DEjqpm3Bda5
         S5rA==
X-Forwarded-Encrypted: i=1; AJvYcCXIjBI1oOVbGfrpV/RHaS/tFNYtgGD40mcPs9kJ4+rDxI20nJgAY7DpcDU4ccGpXPN5StYgOos+P6mzcG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNhQkPjOOAAjB6Tra2zyLmSduaBJSolYN7es+wNLMqfOBRst1
	upjvRacHiDjGwOwjHwucwTB+WI45Bb3amZnh0XEAwBBFjtdnUKhz57IqAAuD26nm0r0=
X-Gm-Gg: ASbGncvsnJuvNvIn16H6DYMuqnEjDCtOJEREzwEOfQWgMNxk47CVxPG7UVCQ0QCUt17
	ST1eaCBNInBGyumnMp6SecamLQFFmoc5e9XFWghzXedvKbr5LwpNLAG2/EWs8HBWthlxNXKk9zb
	0dysiNFsnwYJAXZ8KoZ2wfV51JLWMmobRwQzxs67kt8mEAs3oBNWxLsS7PDlGVUpGBW6l5z4tWd
	wmdhOQnlw/ncb0S+WYY0MxbpN2XcbWKGnX+kLEkHe76msv+LI+WsoXF9g4006u5JzQQiSgwY9wS
	OLDujsGr/ff2zLWgc5/F2e8k2dhhY9zq93PID2g+Zi7azn+IyU9efSYhUq5omnjz/eVUbyr/3IM
	WY+0XvNp4Sme5R2RXyeaidjpYPYe0uxRO/mTwIcV7PZ7C+CF5ljH0GCV/asFgNXBBRBPtEqHswh
	Cdx/kZ5mqoNQ/YVWZfX1vvVyZkCWSnmJKnpMZRlcEimTXgaASqGcZA647CW0d8p3x2Rn3EgMv92
	jdkntFr5g==
X-Google-Smtp-Source: AGHT+IGbtiixleiqyswoz3qLTql2jI01A11bbfMUkIlJUu938gTSGbLcf+e3VcOx41cjcQhTYXkCpw==
X-Received: by 2002:a17:907:3daa:b0:b5c:6a00:f8da with SMTP id a640c23a62f3a-b6472d5bbf5mr53175666b.1.1760630331578;
        Thu, 16 Oct 2025 08:58:51 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:51 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:42 +0100
Subject: [PATCH v3 09/10] pmdomain: samsung: add support for
 google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-9-7b30797396e7@linaro.org>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

On Google gs101, direct mmio register access to the PMU registers
doesn't work and access must happen via a (syscon) regmap created by
the PMU driver instead.

Try to obtain this regmap using the parent node in DT in case this PD
is a child of the PMU and fall back to the traditional direct mmio
regmap otherwise.

Additionally, the status is just one bit on gs101.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 65 +++++++++++++++++++---------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 15a1582aa92103a07335eb681600d9415369fefd..a7e55624728a62545eac049c9a51012a229f44c2 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/mfd/syscon.h>
 #include <linux/pm_domain.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
@@ -78,8 +79,15 @@ static const struct exynos_pm_domain_config exynos5433_cfg = {
 	.need_early_sync_state	= true,
 };
 
+static const struct exynos_pm_domain_config gs101_cfg = {
+	.local_pwr_cfg		= BIT(0),
+};
+
 static const struct of_device_id exynos_pm_domain_of_match[] = {
 	{
+		.compatible = "google,gs101-pd",
+		.data = &gs101_cfg,
+	}, {
 		.compatible = "samsung,exynos4210-pd",
 		.data = &exynos4210_cfg,
 	}, {
@@ -107,17 +115,9 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	struct of_phandle_args child, parent;
 	struct exynos_pm_domain *pd;
 	struct resource *res;
-	void __iomem *base;
 	unsigned int val;
 	int on, ret;
 
-	struct regmap_config reg_config = {
-		.reg_bits = 32,
-		.val_bits = 32,
-		.reg_stride = 4,
-		.use_relaxed_mmio = true,
-	};
-
 	pm_domain_cfg = of_device_get_match_data(dev);
 	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 	if (!pd)
@@ -128,25 +128,50 @@ static int exynos_pd_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/*
-	 * The resource typically points into the address space of the PMU.
+	 * The resource typically points into the address space of the PMU and
+	 * we have to consider two cases:
+	 *   1) some implementations require a custom syscon regmap
+	 *   2) this driver might map the same addresses as the PMU driver
 	 * Therefore, avoid using devm_platform_get_and_ioremap_resource() and
-	 * instead use platform_get_resource() and devm_ioremap() to avoid
+	 * instead use platform_get_resource() here, and below for case 1) use
+	 * syscon_node_to_regmap() while for case 2) use devm_ioremap() to avoid
 	 * conflicts due to address space overlap.
 	 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return dev_err_probe(dev, -ENXIO, "missing IO resources");
 
-	base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!base)
-		return dev_err_probe(dev, -ENOMEM,
-				     "failed to ioremap PMU registers");
-
-	reg_config.max_register = resource_size(res) - reg_config.reg_stride;
-	pd->regmap = devm_regmap_init_mmio(dev, base, &reg_config);
-	if (IS_ERR(pd->regmap))
-		return dev_err_probe(dev, PTR_ERR(base),
-				     "failed to init regmap");
+	if (dev->parent &&
+	    of_device_is_compatible(dev->parent->of_node, "syscon")) {
+		pd->regmap = syscon_node_to_regmap(dev->parent->of_node);
+		if (IS_ERR(pd->regmap))
+			return dev_err_probe(dev, PTR_ERR(pd->regmap),
+					     "failed to acquire PMU regmap");
+
+		pd->configuration_reg = res->start;
+		pd->status_reg = res->start;
+	} else {
+		void __iomem *base;
+
+		const struct regmap_config reg_config = {
+			.reg_bits = 32,
+			.val_bits = 32,
+			.reg_stride = 4,
+			.use_relaxed_mmio = true,
+			.max_register = (resource_size(res)
+					 - reg_config.reg_stride),
+		};
+
+		base = devm_ioremap(dev, res->start, resource_size(res));
+		if (!base)
+			return dev_err_probe(dev, -ENOMEM,
+					     "failed to ioremap PMU registers");
+
+		pd->regmap = devm_regmap_init_mmio(dev, base, &reg_config);
+		if (IS_ERR(pd->regmap))
+			return dev_err_probe(dev, PTR_ERR(base),
+					     "failed to init regmap");
+	}
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;

-- 
2.51.0.788.g6d19910ace-goog


