Return-Path: <linux-kernel+bounces-788314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47995B382BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9657B9047
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5935209B;
	Wed, 27 Aug 2025 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7fV+XS1"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8F34F47E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298544; cv=none; b=XXuJqEdck+uc3rFtxOPEar3Jq+lkJOkG5cH201cIaNfBnjFy36nGs4JyiGWSvJJn4s/TK6nEcQWbx0MBypLWrVbuoTs9+c0YXjxF1dUNvH2sq8AzgBhyD9+ENgkywmEV3Wp3MSupbYaPE12fPMJZNWv8yr/CcBdKiIx59BoVHBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298544; c=relaxed/simple;
	bh=GciBv6TscMWoUL5NOWHvgdZWg70tQo2b5jzt+et6cck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCrfpJiHkw5ghMV9uzouwTBjTg3G+tkX36dfvEA4eN/Gw75PY9taDmZcAO3Nc/t+4I/xFrvbgm41bVJdUvSn8OsJRbLyOWgU8eVhToFWRiHKtjQnwwKJ/vGAAXV/46lhsvPh1Z2MuYTuKob8nwdvt/pqR6T87/ALkjK8pybNn3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f7fV+XS1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c79f0a5c5fso2974982f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756298539; x=1756903339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cfSXL73LYNoY9rCDtAr6B+DOeIwLOhBdUm0HxsWgPY=;
        b=f7fV+XS1qOMMYmKM/w3Zv33LRHaUetSxAEK/bMdgNpikDVKGmqoPv7ti8cmOQk6pYj
         QSXWlCAPy6LkS4MwmLXCUjyxWXCFgZbtSDGY4D+P0q5hXYUqzKkOJIFD/kCBoKMDudTc
         6UP3zhh0HtKKBA2dWDGDnZcdY7/bl7YgyLNjcj5Vh4T0G0iIDHRR/8kaxJcPRMGqueu4
         Fdv/0NhVMp2IvQXkL9pUhBZijMoS4T+IzbHLJ75oq491EfHkOU0bbf8F0PDFBbeVrXRr
         VE0o6ZXtCa/5rAnHqNmjI1Ia1IncDskBRCjAW+5IXgX3bBKmy/1Gj/NjXEpb3IhgS7Yn
         yMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756298539; x=1756903339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cfSXL73LYNoY9rCDtAr6B+DOeIwLOhBdUm0HxsWgPY=;
        b=ArfJGlVlb4bsTU08TO5jlGWMjGPtltMTYNRf0Zn2vYmdahrMUJOFW8VM4/U2XgwPP6
         ApSsrNlVNh8m5Nh1JmGSYA0w4boTEMkP3qPf+qLfk9Fc556rHG2vcGpYW3X774WM2qaX
         BpWwcL6gR4pUjqm49ylCwYQmFxJFfTPgp2fzGCOGNf3Oc599MSAr3CY5E2HvSCGQq9h1
         NjMDVYjiLL7qRt7DJCZnciTNj24a+vuGy5kpjWwY9LLcQR/nHAh/vUZqWG8XJLfDCCV2
         mE928s/4PbByNsTltsTDadp3D5ja04kOu4Ybag8wPRjWgsZJYYNQlujEFhiECn5g6uGV
         +vpg==
X-Gm-Message-State: AOJu0YwCaa0eG8UCXc+aekIef7PENFHxS4RWTR+frhMSNjDPud6W4qJh
	MCZ44L64AL28Yu/m75HLXQNthvfqxyYEK5XCtE0Tn2cvCRDI2pBZKJbv+6evKtR0tbk=
X-Gm-Gg: ASbGnctjzlDqZimBuxkL9LtWmImXEls+MyEF0Sa3/tdJYGyh7X+pk+sXJsOpPjN4ndY
	9jPrkv588NUuuPVRIgHkuFAOFyZl0dpDM1O8f+pxZQBIqZCDO5JXBCEjUSOlHTsDa+E36j22AF1
	BxiLUdY3/NSKfAW3drOVBFDFfRToPttGuXJqctdvQD3jugrXiH9SCxGh7nCgSrmeSyrUE+t7iNV
	g3v0nK6ZRynlmDzw1Rldejx1Y8YKptQXqjgUyc0UyTAEz3orCYMKZjAsezsgnozktmVz02gXIwD
	GD/BtxCsDT4CkhwFFr0s64/2RQU51IP4SzTRQpZhQLru7Ok5tQlf1txxBQlSZQjucJEEvqGR8rd
	fwime1fDlphF2hudZUU746meupvNCagfMYqp7glG2JDtYIPMAYyc+dUT3lbsJTWYJZmVk5vOQZL
	mC0Q==
X-Google-Smtp-Source: AGHT+IFlHa5emvmCKQfoDDkPRlNGe/uXhHgcv977YZ2vSKl+w8mC+U+AGdr8d85CmNa+TjSLH+q9Nw==
X-Received: by 2002:a05:6000:288a:b0:3a4:fea6:d49f with SMTP id ffacd0b85a97d-3c5dcc0dec3mr14394157f8f.49.1756298538987;
        Wed, 27 Aug 2025 05:42:18 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cbab3ead0dsm6439420f8f.29.2025.08.27.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:42:18 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 27 Aug 2025 12:42:14 +0000
Subject: [PATCH v2 4/5] firmware: exynos-acpm: register ACPM clocks dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-acpm-clk-v2-4-de5c86b49b64@linaro.org>
References: <20250827-acpm-clk-v2-0-de5c86b49b64@linaro.org>
In-Reply-To: <20250827-acpm-clk-v2-0-de5c86b49b64@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756298535; l=5210;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=GciBv6TscMWoUL5NOWHvgdZWg70tQo2b5jzt+et6cck=;
 b=GS+9vzYJP6T4ggVpRCRv6J4WvF9fBE/H6F09fimItPewcc/1VJ9tRuthqg3yPNy+9zXnUVBvU
 ukecEb66+HWAfBZ7JoAEuzjmTBSm7Uw9ybIAmdsFdHdZYdNJKT/66XL
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Register by hand a platform device for the ACPM clocks.
The ACPM clocks are not modeled as a DT child of ACPM because:
1/ they don't have their own resources.
2/ they are not a block that can be reused. The clock identifying
   data is reduced (clock ID, clock name and mailbox channel ID)
   and may differ from a SoC to another.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 64 +++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 9fa0335ccf5db32892fdf09e8d4b0a885a8f8fb5..86a220a845d2934aa28e9bb8996cf914f65cdae6 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -24,10 +24,13 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/clk-acpm.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include <dt-bindings/clock/google,gs101.h>
+
 #include "exynos-acpm.h"
 #include "exynos-acpm-dvfs.h"
 #include "exynos-acpm-pmic.h"
@@ -160,6 +163,7 @@ struct acpm_chan {
  * struct acpm_info - driver's private data.
  * @shmem:	pointer to the SRAM configuration data.
  * @sram_base:	base address of SRAM.
+ * @clk_pdev:	ACPM clocks platform device.
  * @chans:	pointer to the ACPM channel parameters retrieved from SRAM.
  * @dev:	pointer to the exynos-acpm device.
  * @handle:	instance of acpm_handle to send to clients.
@@ -168,6 +172,7 @@ struct acpm_chan {
 struct acpm_info {
 	struct acpm_shmem __iomem *shmem;
 	void __iomem *sram_base;
+	struct platform_device *clk_pdev;
 	struct acpm_chan *chans;
 	struct device *dev;
 	struct acpm_handle handle;
@@ -177,14 +182,39 @@ struct acpm_info {
 /**
  * struct acpm_match_data - of_device_id data.
  * @initdata_base:	offset in SRAM where the channels configuration resides.
+ * @acpm_clk_pdata:	ACPM clocks platform data.
  */
 struct acpm_match_data {
 	loff_t initdata_base;
+	const struct acpm_clk_platform_data *acpm_clk_pdata;
 };
 
 #define client_to_acpm_chan(c) container_of(c, struct acpm_chan, cl)
 #define handle_to_acpm_info(h) container_of(h, struct acpm_info, handle)
 
+#define ACPM_CLK(_id, cname)					\
+	{							\
+		.id		= _id,				\
+		.name		= cname,			\
+	}
+
+static const struct acpm_clk_variant gs101_acpm_clks[] = {
+	ACPM_CLK(CLK_ACPM_DVFS_MIF, "mif"),
+	ACPM_CLK(CLK_ACPM_DVFS_INT, "int"),
+	ACPM_CLK(CLK_ACPM_DVFS_CPUCL0, "cpucl0"),
+	ACPM_CLK(CLK_ACPM_DVFS_CPUCL1, "cpucl1"),
+	ACPM_CLK(CLK_ACPM_DVFS_CPUCL2, "cpucl2"),
+	ACPM_CLK(CLK_ACPM_DVFS_G3D, "g3d"),
+	ACPM_CLK(CLK_ACPM_DVFS_G3DL2, "g3dl2"),
+	ACPM_CLK(CLK_ACPM_DVFS_TPU, "tpu"),
+	ACPM_CLK(CLK_ACPM_DVFS_INTCAM, "intcam"),
+	ACPM_CLK(CLK_ACPM_DVFS_TNR, "tnr"),
+	ACPM_CLK(CLK_ACPM_DVFS_CAM, "cam"),
+	ACPM_CLK(CLK_ACPM_DVFS_MFC, "mfc"),
+	ACPM_CLK(CLK_ACPM_DVFS_DISP, "disp"),
+	ACPM_CLK(CLK_ACPM_DVFS_BO, "b0"),
+};
+
 /**
  * acpm_get_saved_rx() - get the response if it was already saved.
  * @achan:	ACPM channel info.
@@ -606,6 +636,7 @@ static void acpm_setup_ops(struct acpm_info *acpm)
 
 static int acpm_probe(struct platform_device *pdev)
 {
+	const struct acpm_clk_platform_data *acpm_clk_pdata;
 	const struct acpm_match_data *match_data;
 	struct device *dev = &pdev->dev;
 	struct device_node *shmem;
@@ -647,7 +678,30 @@ static int acpm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, acpm);
 
-	return devm_of_platform_populate(dev);
+	acpm_clk_pdata = match_data->acpm_clk_pdata;
+	acpm->clk_pdev = platform_device_register_data(dev, "acpm-clocks",
+						       PLATFORM_DEVID_NONE,
+						       acpm_clk_pdata,
+						       sizeof(*acpm_clk_pdata));
+	if (IS_ERR(acpm->clk_pdev))
+		return dev_err_probe(dev, PTR_ERR(acpm->clk_pdev),
+				     "Failed to register ACPM clocks device.\n");
+
+	ret = devm_of_platform_populate(dev);
+	if (ret) {
+		platform_device_unregister(acpm->clk_pdev);
+		return dev_err_probe(dev, ret,
+				     "Failed to populate platform devices.\n");
+	}
+
+	return 0;
+}
+
+static void acpm_remove(struct platform_device *pdev)
+{
+	struct acpm_info *acpm = platform_get_drvdata(pdev);
+
+	platform_device_unregister(acpm->clk_pdev);
 }
 
 /**
@@ -744,8 +798,15 @@ const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_acpm_get_by_node);
 
+static const struct acpm_clk_platform_data acpm_clk_gs101  = {
+	.clks = gs101_acpm_clks,
+	.nr_clks = ARRAY_SIZE(gs101_acpm_clks),
+	.mbox_chan_id = 0,
+};
+
 static const struct acpm_match_data acpm_gs101 = {
 	.initdata_base = ACPM_GS101_INITDATA_BASE,
+	.acpm_clk_pdata = &acpm_clk_gs101,
 };
 
 static const struct of_device_id acpm_match[] = {
@@ -759,6 +820,7 @@ MODULE_DEVICE_TABLE(of, acpm_match);
 
 static struct platform_driver acpm_driver = {
 	.probe	= acpm_probe,
+	.remove = acpm_remove,
 	.driver	= {
 		.name = "exynos-acpm-protocol",
 		.of_match_table	= acpm_match,

-- 
2.51.0.261.g7ce5a0a67e-goog


