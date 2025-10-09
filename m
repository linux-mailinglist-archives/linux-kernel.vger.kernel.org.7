Return-Path: <linux-kernel+bounces-847059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F97BC9C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 750224F8CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7F22ED14E;
	Thu,  9 Oct 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u42Fu7Mi"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA61E1E04
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023513; cv=none; b=rbjm4HqJQMdCRa2NdaipGUnF0mxTaPy8UQsXOp7azt3MEeV/awXxz/Zce7uCAMW/SXrALONwBQvpJfZSexFetVzTSiWwmoGZ82UD5nD84gKT0Mn/1lmXeUi4ERWyN6mRPT6y4UvPMuFsJIU1Jm8pnu/bdkjmrWA1IurC0VFvNiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023513; c=relaxed/simple;
	bh=3FiSxcQQlSfwdcy42EspcUABD4qqt6ntMqcPQwZX/Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XD044ylsmo+xWorsCVDrUNGw4201CYA9/zj7GM89JZJ0dWtvuXBxSM51UtPwbuO+sSEwnvc4eA+relcrOVrznrNBW9kg4nHVMjE9mRxl+7vwMHRvNXVXwL4iu0jfkCpqFg1m2wOyV0AjGZUXKmdnGbn+yWS5vHWHQUwtHSl6T+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u42Fu7Mi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-639e34ffa69so1578184a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023508; x=1760628308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uQKQdQ1MYiF5juA60OL7pKbQX2emtwofvg1/NDrBMs=;
        b=u42Fu7MiXeXcwRP+fEqSGTt3m9u4bQL76/FGZOOOWPOFFM+StzXt+6Pa0yWpq01Aif
         +MKzIxQ1NXkTFgJEuHSomr8lghyTEXXoAajKUWGeVsRM+9OFRxkJSvbxexcDK9mT8dEC
         uaZp4N8KWCwVcFNDjvNNuizZ3KFf5VtLpJYZJfbFPRbKbjga+9s9ZS/ouY6w01zNHO2n
         EKq7NB8uoUuzYlo4hnm+q3PAw24eNF6qhapQLKSV5HEOxXVHI1L2UtHo0nl8czkMlYcF
         2oDMAaZVt7lyZUcpnPhWLbghB9jUIttxMCkODtJdEnsclPGb1JJpitsMuaw6UFW+8mb4
         yskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023508; x=1760628308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uQKQdQ1MYiF5juA60OL7pKbQX2emtwofvg1/NDrBMs=;
        b=F5Pk5rSUYFFSESBOgR7r7Sof+L2oQdmZ2XSdOhRMKV61NwSf2Ok24Rp4ZJc7CnekRB
         GdBBr/Qq2zm4XR87KP0lytPfZlCLyQTOdLv65my5n94ZCgpXo6I0LWve4xIgAOV0wi64
         EOrUog3v6HOkAt9EADPNrO5E0P+txeuCxHeT3IuM5K2MOUn5jTczkTJzmZuBwLfQKOZt
         24Rg7IYqJWtb/siGrIDCwm80dAN4mtPtZlT0Afq0FmwrVEdQ7V8T7cF+qU4LdGY62Mgk
         QA3i+1gw8wmorDA8kU/pUd7F8U+kQ62L+HZjbTylcIO+M3A7i6dieqZ5tboPWuCKs+vI
         JDSA==
X-Forwarded-Encrypted: i=1; AJvYcCUv2RsN4I1uHBVzkUDSWFSToeydxWo1w15RNg+ySSXFEuxJ8BWTGFXLYYUVYuDTsFg2hcQK5kGA3ztp++4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEv5fIF/8FiFqyShGGiOZjR5WMx04aHrWwmjXsWFLnt/sgFsmr
	YVIwisTTUGWzd7tTzWXVk9n/5Y8UN3qUFkwPj082iAQBxpV8EFzlRjjAaShsOAlMOQ8=
X-Gm-Gg: ASbGncvpM/NlH1KTLEU5E1RIxPOAcL4yp3Zy82tOwDosiQaODPw9oQIrgfgHrZD/5N4
	YkuQvIC2KQrPuxmhDk2jRhXBtAwbMDcT+Eh2ecsqerbGhIYSWjU1lwPs3k9qaIUbBCOMugdW328
	HdOG7ezPI8ncBuoyJ6LaHit8gl+FAjqG7moovAF3wnZXP+kuQZngQJg68MCYu/NuzQG/nQQcGKa
	UldbOfKczIaDUK//lC3+ZI97o3mIY+xSqyq7jLtCv/4Y0WaZt6PdjQiUjmM+v1etgH1EUGUFhAV
	iVDClIfQhDE+/ivEomE8nYNbQRwVbDzkBmJiamJW+sxsOUqfIR8GqpUp0y3UBozKq6RurZIC7FE
	VAeQWTrrlPcKLZtECu5Y7s2xZi2iR+9zaCr5JmABQR7WE26L7L3y5OZXKfZMMjmsLRKI9plH/Ck
	9shX8xDnAcw9BdvncUHYP3KbCxK29pFx0demWa594m
X-Google-Smtp-Source: AGHT+IGnZBRhQiVL3K77bERhMVDqgbMpxbRqX6c+qjhP8qmTDZBZaNH/mZYsCBi4KHpMR5tC0seqCQ==
X-Received: by 2002:a17:907:7290:b0:b45:a03f:d172 with SMTP id a640c23a62f3a-b50acc2f5bemr911916266b.57.1760023507942;
        Thu, 09 Oct 2025 08:25:07 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:07 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:07 +0100
Subject: [PATCH v2 05/10] pmdomain: samsung: convert to using regmap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-5-3f4a6db2af39@linaro.org>
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

On platforms such as Google gs101, direct mmio register access to the
PMU registers doesn't necessarily work and access must happen via a
(syscon) regmap created by the PMU driver instead.

In preparation for supporting such SoCs convert the existing mmio
accesses to using a regmap wrapper.

With this change in place, a follow-up patch can update the driver to
optionally acquire the PMU-created regmap without having to change the
rest of the code.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
There is one checkpatch warning, relating to the non-const
regmap_config. It can a) not be made const without resorting to having
two copies and copying, and b) will go away in a follow-up patch
anyway.
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 78 ++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index f53e1bd2479807988f969774b4b7b4c5739c1aba..383126245811cb8e4dbae3b99ced3f06d3093f35 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -9,15 +9,14 @@
 // conjunction with runtime-pm. Support for both device-tree and non-device-tree
 // based power domain support is included.
 
-#include <linux/io.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/pm_domain.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
@@ -28,7 +27,7 @@ struct exynos_pm_domain_config {
  * Exynos specific wrapper around the generic power domain
  */
 struct exynos_pm_domain {
-	void __iomem *base;
+	struct regmap *regmap;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
 };
@@ -36,31 +35,37 @@ struct exynos_pm_domain {
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct exynos_pm_domain *pd;
-	void __iomem *base;
 	u32 timeout, pwr;
-	char *op;
+	int err;
 
 	pd = container_of(domain, struct exynos_pm_domain, pd);
-	base = pd->base;
 
 	pwr = power_on ? pd->local_pwr_cfg : 0;
-	writel_relaxed(pwr, base);
+	err = regmap_write(pd->regmap, 0, pwr);
+	if (err)
+		return err;
 
 	/* Wait max 1ms */
 	timeout = 10;
-
-	while ((readl_relaxed(base + 0x4) & pd->local_pwr_cfg) != pwr) {
-		if (!timeout) {
-			op = (power_on) ? "enable" : "disable";
-			pr_err("Power domain %s %s failed\n", domain->name, op);
-			return -ETIMEDOUT;
+	while (timeout-- > 0) {
+		unsigned int val;
+
+		err = regmap_read(pd->regmap, 0x4, &val);
+		if (err || ((val & pd->local_pwr_cfg) != pwr)) {
+			cpu_relax();
+			usleep_range(80, 100);
+			continue;
 		}
-		timeout--;
-		cpu_relax();
-		usleep_range(80, 100);
+
+		return 0;
 	}
 
-	return 0;
+	if (!err)
+		err = -ETIMEDOUT;
+	pr_err("Power domain %s %sable failed: %d\n", domain->name,
+	       power_on ? "en" : "dis", err);
+
+	return err;
 }
 
 static int exynos_pd_power_on(struct generic_pm_domain *domain)
@@ -109,8 +114,18 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args child, parent;
 	struct exynos_pm_domain *pd;
+	struct resource *res;
+	void __iomem *base;
+	unsigned int val;
 	int on, ret;
 
+	struct regmap_config reg_config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.use_relaxed_mmio = true,
+	};
+
 	pm_domain_cfg = of_device_get_match_data(dev);
 	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 	if (!pd)
@@ -120,15 +135,36 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd->pd.name)
 		return -ENOMEM;
 
-	pd->base = of_iomap(np, 0);
-	if (!pd->base)
-		return -ENODEV;
+	/*
+	 * The resource typically points into the address space of the PMU.
+	 * Therefore, avoid using devm_platform_get_and_ioremap_resource() and
+	 * instead use platform_get_resource() and devm_ioremap() to avoid
+	 * conflicts due to address space overlap.
+	 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return dev_err_probe(dev, -ENXIO, "missing IO resources");
+
+	base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!base)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to ioremap PMU registers");
+
+	reg_config.max_register = resource_size(res) - reg_config.reg_stride;
+	pd->regmap = devm_regmap_init_mmio(dev, base, &reg_config);
+	if (IS_ERR(pd->regmap))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "failed to init regmap");
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
 	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
 
-	on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
+	ret = regmap_read(pd->regmap, 0x4, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read status");
+
+	on = val & pd->local_pwr_cfg;
 
 	pm_genpd_init(&pd->pd, NULL, !on);
 	ret = of_genpd_add_provider_simple(np, &pd->pd);

-- 
2.51.0.710.ga91ca5db03-goog


