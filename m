Return-Path: <linux-kernel+bounces-798764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC6AB422AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DAF48707B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B17311C13;
	Wed,  3 Sep 2025 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+RAaZ/c"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF230E856
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907810; cv=none; b=tKW9iSg+w69pUCt5YaqRD+XNwXizXBR9VB5j7cAN7w1G3vBG1q9A28Ywv8vz6mXchLXLpr+CAVG9tYurpfRbd+xxaO/GdChwh5zdTASfUFFxzIYDgOrQDQmVK7Y0LztaxDcrTKe1Z5mG31hvCkSqMQFtvYo1H31E79Pbv3+oFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907810; c=relaxed/simple;
	bh=KqqXaXmMUQsdCpJZVRGT6WfJSbl5ckiI5/av635g9bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwylI03FRhAWi7YtUmDAr5vpiluynkngLCO1KvTZD4IjHd/ATbkiDXLz5TkcrtMA0ezV19WEFJIH8s5ebkp2fO0zi5LslMciTctbJEcsnk42ZC8hLDlB8jlZwesKJO3cm1LyoTuhrHlgYKV9Vc7XzEJJiu3Lq732CpBGucjV9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I+RAaZ/c; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso4480805e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756907806; x=1757512606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DhFOFHz0h/WoJvYuWdsxmXTZqYVyhlXjR9PRjd8hmc=;
        b=I+RAaZ/cGJ2RWCoNICBRenP263SZfaEyJf8gj8oPzu+iCUoAHGhM40Kl+MqfqvVFMI
         hRCjGBMGx+2b5Ob+a0RoqXDsb2NEaTp79mOm6Y6Qoq6t/hzhV4Mt3qxUuuAtSKnLaxP3
         3n84jfB0XHmZpkj5RtdrenGJub7BLOBS5m9Mo0TPcVUhblimfpDoQs8cvoNrMJrttoIt
         98ID8iK36s+yczcTrQBvkbUOihyN35tstCsHo93+myQEQvvI6kd/8B20QH1UlpWLraHA
         n2yAnVtdWtX4K+nZD00SvaTJGnVu6XZ+EKCUhTsDNPeweqJWxkqR5+msQyNcf7Lbx284
         gXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907806; x=1757512606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DhFOFHz0h/WoJvYuWdsxmXTZqYVyhlXjR9PRjd8hmc=;
        b=kr9Sbj2Sk6VgvMS+sCdK3yntZmpGcO6mLhaq1Bh5riukcdZ054PuV5HTw6e2eyR2Gn
         4AER+4ycFClhusj7CxbEslDgsrStlUbWjD8Kc5q8F6ZQf+u7gAFi9lJeIBnyaJiWDS5k
         9gpsroAVTWjAFMaij2Kejxrynvh0bjhZKOKpuU1TqrYmko9OEqo2N49tyF01b0ES8EAe
         qBs4lcyI1hkScNT8KOlriEBDI07SogsNfpjmBXEePM7wRJJ8XBsrXxqCKLx8Jeh/imJy
         uQnvEhuxlP93hSuwmAx3ru05sS5nLRZYKGVRF0py8loBjDAf0WOGDSlSCfJrtGrqYBsj
         NxgA==
X-Gm-Message-State: AOJu0YxTanBwohWopekexaFmQUBI/TuL7/SEKBdbsaBvgxAM15sJ/YA4
	Cah3bKnBHXzgUcc0Q65bCUCxX0LP8jWd7xtXqr657O5mR+9C0taLeScY4+LXmPNLc18=
X-Gm-Gg: ASbGncv4WOSmu+yHWgP8ApO0OnrHBPSVhyhPK7Jno99uVy6DIvkbdmIPJFp1F0Ulm76
	hQTfr9dGE/PnqtcHLZddPXtR7yioEZgYcIdmu/zbpt3r+CcUzITfalaASMZl9sKzbqI1vVGRv3x
	WltNxj0kkxhCC87f8mOWbmSFUSYtNh1LtMxUNsccJmu0Scb7hbuVHrtVrtkjQtsV2LY2TPZzQb9
	2ZUYEfvi+gi6yh7Nj0TSwgQlaa7y/uMfQQ3iPsMz7Ag9D9nFC1D08eDlsk2jlDvehlfk7dBP/oR
	TZA5ceC44WLuaEfnk/OMg8S9cxiYTh3HXiQUH8t7x/kC0WJLA4I2MrXfJ6m8ZtZHo8TP0hOy77W
	TLun6vg+L39d6bKhJRikICeDF/mIhd6snlCAan8QGnuMUVF5HKKTRgI01OQ5zyb4wU63maVjt1w
	PBHQ==
X-Google-Smtp-Source: AGHT+IEyhCiL5ktj6QTvi8D22BxRnvNrT0TFR8jIAtkM1Xw+jjOyOz5Fh9eZ2GFeGHUXa5FnjJ21NQ==
X-Received: by 2002:a05:600c:4f8f:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45b85550704mr128247375e9.4.1756907805637;
        Wed, 03 Sep 2025 06:56:45 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87632365sm197257135e9.16.2025.09.03.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:56:45 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 03 Sep 2025 13:56:40 +0000
Subject: [PATCH v3 3/5] clk: samsung: add Exynos ACPM clock driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-acpm-clk-v3-3-65ecd42d88c7@linaro.org>
References: <20250903-acpm-clk-v3-0-65ecd42d88c7@linaro.org>
In-Reply-To: <20250903-acpm-clk-v3-0-65ecd42d88c7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756907802; l=7939;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=KqqXaXmMUQsdCpJZVRGT6WfJSbl5ckiI5/av635g9bs=;
 b=9vLkq71OeAOD3a5unJd3JpZ9FJbTx9oYJdRYUIZOTH3T3hJqpbbEK3FjNnU3NHKBBIK/QLrtM
 Rfj6Crt3udhCPC91VIy257mL7F5KRwj8tOrkizZRa86OzTnk2YJs4JT
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the Exynos ACPM clock driver. It provides support for clocks that
are controlled by firmware that implements the ACPM interface.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/Kconfig    |  10 ++
 drivers/clk/samsung/Makefile   |   1 +
 drivers/clk/samsung/clk-acpm.c | 203 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index 76a494e95027af26272e30876a87ac293bd56dfa..70a8b82a0136b4d0213d8ff95e029c52436e5c7f 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -95,6 +95,16 @@ config EXYNOS_CLKOUT
 	  status of the certains clocks from SoC, but it could also be tied to
 	  other devices as an input clock.
 
+config EXYNOS_ACPM_CLK
+	tristate "Clock driver controlled via ACPM interface"
+	depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOCOL)
+	help
+	  This driver provides support for clocks that are controlled by
+	  firmware that implements the ACPM interface.
+
+	  This driver uses the ACPM interface to interact with the firmware
+	  providing all the clock controlls.
+
 config TESLA_FSD_COMMON_CLK
 	bool "Tesla FSD clock controller support" if COMPILE_TEST
 	depends on COMMON_CLK_SAMSUNG
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index b77fe288e4bb484c68d1ff497acc0b83d132ea03..04b63436b12f6f5169575d74f54b105e97bbb052 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos990.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynosautov9.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynosautov920.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-gs101.o
+obj-$(CONFIG_EXYNOS_ACPM_CLK)		+= clk-acpm.o
 obj-$(CONFIG_S3C64XX_COMMON_CLK)	+= clk-s3c64xx.o
 obj-$(CONFIG_S5PV210_COMMON_CLK)	+= clk-s5pv210.o clk-s5pv210-audss.o
 obj-$(CONFIG_TESLA_FSD_COMMON_CLK)	+= clk-fsd.o
diff --git a/drivers/clk/samsung/clk-acpm.c b/drivers/clk/samsung/clk-acpm.c
new file mode 100644
index 0000000000000000000000000000000000000000..fe24471c41fcaab43b62b552949c26520b98c1e3
--- /dev/null
+++ b/drivers/clk/samsung/clk-acpm.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Samsung Exynos ACPM protocol based clock driver.
+ *
+ * Copyright 2025 Linaro Ltd.
+ */
+
+#include <dt-bindings/clock/google,gs101-acpm.h>
+#include <linux/array_size.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/firmware/samsung/exynos-acpm-protocol.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+enum acpm_clk_dev_type {
+	GS101_ACPM_CLK_ID,
+};
+
+struct acpm_clk {
+	u32 id;
+	struct clk_hw hw;
+	unsigned int mbox_chan_id;
+	const struct acpm_handle *handle;
+};
+
+struct acpm_clk_variant {
+	unsigned int id;
+	const char *name;
+};
+
+struct acpm_clk_driver_data {
+	const struct acpm_clk_variant *clks;
+	unsigned int nr_clks;
+	unsigned int mbox_chan_id;
+};
+
+#define to_acpm_clk(clk) container_of(clk, struct acpm_clk, hw)
+
+#define ACPM_CLK(_id, cname)					\
+	{							\
+		.id		= _id,				\
+		.name		= cname,			\
+	}
+
+static const struct acpm_clk_variant gs101_acpm_clks[] = {
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_MIF, "mif"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_INT, "int"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_CPUCL0, "cpucl0"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_CPUCL1, "cpucl1"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_CPUCL2, "cpucl2"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_G3D, "g3d"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_G3DL2, "g3dl2"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_TPU, "tpu"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_INTCAM, "intcam"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_TNR, "tnr"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_CAM, "cam"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_MFC, "mfc"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_DISP, "disp"),
+	ACPM_CLK(GS101_CLK_ACPM_DVFS_BO, "b0"),
+};
+
+static const struct acpm_clk_driver_data acpm_clk_gs101  = {
+	.clks = gs101_acpm_clks,
+	.nr_clks = ARRAY_SIZE(gs101_acpm_clks),
+	.mbox_chan_id = 0,
+};
+
+static unsigned long acpm_clk_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct acpm_clk *clk = to_acpm_clk(hw);
+
+	return clk->handle->ops.dvfs_ops.get_rate(clk->handle,
+					clk->mbox_chan_id, clk->id, 0);
+}
+
+static int acpm_clk_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
+{
+	/*
+	 * We can't figure out what rate it will be, so just return the
+	 * rate back to the caller. acpm_clk_recalc_rate() will be called
+	 * after the rate is set and we'll know what rate the clock is
+	 * running at then.
+	 */
+	return 0;
+}
+
+static int acpm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct acpm_clk *clk = to_acpm_clk(hw);
+
+	return clk->handle->ops.dvfs_ops.set_rate(clk->handle,
+					clk->mbox_chan_id, clk->id, rate);
+}
+
+static const struct clk_ops acpm_clk_ops = {
+	.recalc_rate = acpm_clk_recalc_rate,
+	.determine_rate = acpm_clk_determine_rate,
+	.set_rate = acpm_clk_set_rate,
+};
+
+static int acpm_clk_ops_init(struct device *dev, struct acpm_clk *aclk,
+			     const char *name)
+{
+	struct clk_init_data init = {};
+
+	init.name = name;
+	init.ops = &acpm_clk_ops;
+	aclk->hw.init = &init;
+
+	return devm_clk_hw_register(dev, &aclk->hw);
+}
+
+static int acpm_clk_probe(struct platform_device *pdev)
+{
+	enum acpm_clk_dev_type type = platform_get_device_id(pdev)->driver_data;
+	const struct acpm_clk_driver_data *drv_data;
+	const struct acpm_handle *acpm_handle;
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **hws;
+	struct device *dev = &pdev->dev;
+	struct acpm_clk *aclks;
+	unsigned int mbox_chan_id;
+	int i, err, count;
+
+	switch (type) {
+	case GS101_ACPM_CLK_ID:
+		drv_data = &acpm_clk_gs101;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Invalid device type\n");
+	}
+
+	acpm_handle = devm_acpm_get_by_node(dev, dev->parent->of_node);
+	if (IS_ERR(acpm_handle))
+		return dev_err_probe(dev, PTR_ERR(acpm_handle),
+				     "Failed to get acpm handle.\n");
+
+	count = drv_data->nr_clks;
+	mbox_chan_id = drv_data->mbox_chan_id;
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, count),
+				GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = count;
+	hws = clk_data->hws;
+
+	aclks = devm_kcalloc(dev, count, sizeof(*aclks), GFP_KERNEL);
+	if (!aclks)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		const struct acpm_clk_variant *variant = &drv_data->clks[i];
+		unsigned int id = variant->id;
+		struct acpm_clk *aclk;
+
+		if (id >= count)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid ACPM clock ID.\n");
+
+		aclk = &aclks[id];
+		aclk->id = id;
+		aclk->handle = acpm_handle;
+		aclk->mbox_chan_id = mbox_chan_id;
+
+		hws[id] = &aclk->hw;
+
+		err = acpm_clk_ops_init(dev, aclk, variant->name);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "Failed to register clock.\n");
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   clk_data);
+}
+
+static const struct platform_device_id acpm_clk_id[] = {
+	{ "gs101-acpm-clk", GS101_ACPM_CLK_ID },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, acpm_clk_id);
+
+static struct platform_driver acpm_clk_driver = {
+	.driver	= {
+		.name = "acpm-clocks",
+	},
+	.probe = acpm_clk_probe,
+	.id_table = acpm_clk_id,
+};
+module_platform_driver(acpm_clk_driver);
+
+MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@linaro.org>");
+MODULE_DESCRIPTION("Samsung Exynos ACPM clock driver");
+MODULE_LICENSE("GPL");

-- 
2.51.0.338.gd7d06c2dae-goog


