Return-Path: <linux-kernel+bounces-847064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AC0BC9C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27139353B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DFE1DED4C;
	Thu,  9 Oct 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xnf+tP3/"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD341FF60A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023517; cv=none; b=blGkzB/aKacir9Ofz938k4SRQhFaU5nuHI/vhk2a6FpUiuo19QhiXXBTIYivVGSnZF8D0JkESjOASkMLe09Qj7IQFmtIClD7QBjWP0Snlc7kLUNKMhFA0gwKXtOQXmz7UGyA2S6krHVwJ38zQPLNSu8lIzKWkI5XtQZjem01HkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023517; c=relaxed/simple;
	bh=2ZJZLMl7zXjFcsdeUrNL+qecigOdDpc1M2N0TGNsV+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgH+4+j8CKMPclQHE4zxBFvbZcx6RHL6rfFqI0y1EUQAotHh46yFgIeqaa5Gy3+7FH5nrgnk2JOP4pObrveK8+Lnl46KpRN4M+8310NDLrCEdbLuwOswMhL1YIp57v+IXsgAqdUNB+dKIOH3o2lvTQdsm4ELBIdK1y6+/6wBvFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xnf+tP3/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3d80891c6cso335801866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023510; x=1760628310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVAeMZOZRjoK+GVtbAGxhgZ6PYOesgGPyy7xYiTvQkk=;
        b=Xnf+tP3/FqO3/8VmwayGTD/Qpnf90+qOeDdccac/LGFX+zb5E6dbQu58a4rC1EIRwx
         8A3wYpaGNMVyH56NQ5kToIv1WTBwBTmue10r7HPXIKnlKRIKJ4hEGRTwmHycnvDYmp76
         eok7bgE6S4qURL4gYwd7OLFQoFVbDE81UjjKEfhmAoVOsZqIzqoiMjnL+s+Mkeqqh8KC
         W8+gGuhnVRrBIQpFYJnQaTiRt313nzkmfAcx/HPd0HcA/DPebm4nJnnkJ6pC+lw5gC+g
         Ox7TZj/xO7TRqU+1UIWixtTgQ2+Ll0JSL1j6GojdmiHQtrdP1LlMphupnj9aYrOKP7n+
         DsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023510; x=1760628310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVAeMZOZRjoK+GVtbAGxhgZ6PYOesgGPyy7xYiTvQkk=;
        b=uly1e2erznoErpoV27zx2DKCVQqP+S8P3QnxjZ9V+UI4iDZ8DO77CjsGiy5tDAAY0/
         yYZEzHQDrMXX9il63Hx6TW/grMPnxpTVF+ITYkdYUFtr31/8/qYfsWu+hrG9gRY370z9
         o7CxJwdQgBP2n/75lzUHS5kz7TTljPu2RyDx2234ej4JwsTeFFWJPLrGZONVl91NFBaU
         yT32YObcaQcGS1i98HNDy+m4bp+0f0EhYgCk8UteeAAgIxmWTHXFyMBEEjS4yQ/xBm9A
         wngDfVfYOSpiPK/fc9nf0hZCdHIhGQfnArc6tFetAfjFA9ev4kyBFrZ3QLJ0szluDNIp
         IgPw==
X-Forwarded-Encrypted: i=1; AJvYcCX7JkoiFKZWBs9smIXj7rdGpx9Bb3Kv2Rk3Jvz1IZNoCg2YpZ3Cc7KJF3JX0g0Jcg09bEzVfzjS6SABHzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLBG5qa2s+zmvQC778lHMT4ClHB5BMV9c89zQZpK/L2Jjk2eN
	WqWIbSVBkJOai/1xWcsAp9VZL6y/1HSHQ4nGzezkLyjn6rObNpTi+cjhpcP+/NrSPPc=
X-Gm-Gg: ASbGncvNdj7LfdUvyWb1YyYC8VblSXtvZCTWWyt6FpMzAld9yy3MJ2B18QCETi9Xlh2
	CDRlzBDLZHL4Idpg60oTbkYoNEPVqDOYqiXhZl0rd15tcxVTO9ye+fMMe1l3f6j/XCzM1nTbaXl
	6S2n7odGGpIFYahR94TK+WM6AAiS+97WN4nayKMTw84cBgQJBsMwNTdD/Mzbzjjm5MP8HfUKxm+
	K4mzDVAdJGdFY15aj9137Hx4+Ejtbd2Rhx1qt3ceqewFQeIfMN7C2sQYCqXvPBuPCUc4wOZ49vn
	9luOp3WkOvqP5Du8YYAezgIcGnFc+2PZHLpO1wovHVs1lVxfC7FblWjbfXmL3Qs8/mAXdL0zxy/
	dyVGVWOcA99wZMnnhoBSw6sH+Rzx5o4vu2/wzeUwk3hycABP4YWXB/SyxlzI2WmvS2B3wqUzYL+
	U8my9zob3ASUx25AHjor6u8pVK/fDQPkcG1XrJhdo9
X-Google-Smtp-Source: AGHT+IHQigChCGbyX9QcN71UtfHBK/a2r2hCK545ETZ555mAVRYH/JS8za+ESngSjBgkhY0CJel3UQ==
X-Received: by 2002:a17:907:8991:b0:b33:821f:156e with SMTP id a640c23a62f3a-b4f4116a352mr1495403166b.12.1760023510322;
        Thu, 09 Oct 2025 08:25:10 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:09 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:11 +0100
Subject: [PATCH v2 09/10] pmdomain: samsung: add support for
 google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-9-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
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
2.51.0.710.ga91ca5db03-goog


