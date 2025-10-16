Return-Path: <linux-kernel+bounces-856531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A78BCBE467C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C4ED359F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B7536CDFC;
	Thu, 16 Oct 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNAkV3su"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8D3570B9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630335; cv=none; b=TW2nJDmhOs2KHeR9HIJPHFIyPuEsSL+vOvbYf7tEp9WGKIhP2/1foTFgteMWVVzTselorMOoS4QCORVDATGTSNhsMomJKzkwCgkXGTWXoV4jZjoCUSMVHqeRnij3gj5/tJQ0ikOjfG09yTz2/aJ1JSiDdpqMCj5+vmHln+ZgMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630335; c=relaxed/simple;
	bh=nBudP7+99iBkFh3qe0ZdmQhnQbG9lraMj3SNNZddgS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NdtXtktdxZ+e1hnOCuBdZWa55a08sEMJNSur89Ubr701eMCH1BI49qmuGYZckRFf+Q039uqV/bhpX59dWuoG8pg2OvruHyvANH7lwItkrITFCGcLDXrSdO2YhmDIhc/nymA6gGU6Bzf088+uSE8Reoz88wpMfr+3nAH/GD7kLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GNAkV3su; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b50645ecfbbso184311766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630329; x=1761235129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sx/VxWL+zXIwDerOXQo/SlWkRBTA5eJCirxOIqSzME=;
        b=GNAkV3suTsDAN6ToKuVGw0fGPLQvnp18+ciT1jVT8f6FHuG8v9AUPgyMdO03ZfoF+X
         b5FFsOxSdh50k8VkA3JmZF7Ur9/aODklKIt4zTsdHfb/B6c52WAI1zlxAHLnGt8Uq+P3
         A2TP6YAtud+t6Nf6PlB+YgZ6G1lWiMa3hiN1OpHneSSnfe4XQoRU4s58owiVx5CRf7kK
         250IGDobAQfoF6RorYl8zku/qE+K2k9gE1KzQLhyIN+RlDYc8S5BauisCFWUMd3/rpy1
         jrtg9zqLIa1Hw0RyOht8nANbBAgZ7A7Pm3hbf+AO96gJmlK4gdWZfxCofNZBW1eoFmpw
         sx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630329; x=1761235129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sx/VxWL+zXIwDerOXQo/SlWkRBTA5eJCirxOIqSzME=;
        b=WSDTgMxr9xh1UgKWCUWh3v5UK3Ah4h0YofprwcpL6/UXB2kCh+wdp/9B94ckQHs23q
         sIMfL17bqrdOtaYFRZDwdId49BALeQ99zhZ8Hz6v9hFyNgRw7+28x6dSukf/0EbjYpoi
         qLApr8A7HVSKZHE5HKhKMD7XpocDG1xN7qv92sWWccGFXnpZJE72KhU09B2UTGh50RBD
         VTgOlcbCSkHqfEkg5uBz68NJKs7moaz7gpLfb5tAUdsCl+uxlYZPsczlHQbSSdCwrxce
         aaD7g7ucde9xFCFc9ouUyfyeYRWldrTNXq/MLEqGH+Lw35W6rgaPCc2uGEDLf7wwDXbG
         uUOA==
X-Forwarded-Encrypted: i=1; AJvYcCVtNQARqxQic21APFI/VLV78IHn6o8OfGGStF4stNr/jjd2oUgNGegOMBjGhf0bgRrMmJbN0sK9rTrbz/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKy6esl2kLoIo4pJska4JVe3fRK9BBGDR5owN5RJ+RWjfbPjJ
	UOpX8PeyQSSZTHnlxyFOCgMN2XVzUyqJpYdnbHCkvyFW7g4cwniXGmX8V9luGtfKnSc=
X-Gm-Gg: ASbGncs7NhXZsax2julW18HZKEoLem/iOEay6aJ9mVhPp27PTwtWoqsJRlkN2Z0sm8o
	DNt3HJmSQ9/c60LEu3iYke7QF/y13+tFrUcWXo5w1kXSIxgcaGE8DTYkup0i3XUJf9UXaPCDDi8
	S3dXT021yG6/Xk4nvwtjJBATpNDBqQxkF6dOxuP9BHH7483D8v47qI14zqqh/tZ/D9k2mZC6Rg2
	CQCDihJNDggAhbkYA7bv56S/CVSC/IMfDsdf5+4/Cvwr1eWOTjomfklwkc+xOmGOmOf9Qt9tq56
	WYyu1jw/NAB+RqJgO+/YaPsf63qHKliv3ZbzC+UMfAKvDBcPDW/IVCTP4/L7pCO053fqbx+swY8
	qAphRzgZBEPi8J7JYZ5443KpSONdCJ7K3DGZ+wlbCgQDbK1n5ZTELFa1LBK/RGx38KVo9FiAXBi
	oT5zWi3KTL2AIUqW5AFvQgykyAdtwnOInHru6GTob4hjwX1UkZBs/jwdHm+tX7
X-Google-Smtp-Source: AGHT+IGK8Ey29vlNo00zlc+GOkFyC2bjHLvIDXKhESpfZnJ6rq6388SEUQEklyoTNIyqpHblnkTV0Q==
X-Received: by 2002:a17:907:2d88:b0:b40:33ec:51de with SMTP id a640c23a62f3a-b6472b60651mr49198966b.8.1760630325841;
        Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:38 +0100
Subject: [PATCH v3 05/10] pmdomain: samsung: convert to using regmap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-5-7b30797396e7@linaro.org>
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
regmap_config. It can not easily be made const at this stage, but a
follow-up patch allows us to make it const and the warning will go away
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
2.51.0.788.g6d19910ace-goog


