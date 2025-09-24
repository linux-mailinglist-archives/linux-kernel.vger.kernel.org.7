Return-Path: <linux-kernel+bounces-830785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50742B9A834
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8B33B021B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62630F7FF;
	Wed, 24 Sep 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOzD6xNE"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034630C0E7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726678; cv=none; b=CnZZkGS7AF38laUY4ilon4OaXuzJ9UBwH6QRy6bWEzi25feTQhWlaSD6z1VtDfekko1qLW9n+FXm/g1ml8ge7lskTf+WHckNzohHtfvp43N7nClAdGe5dBIz7kq9GCwMg6C/mvPQnz1H7HvXUEVsIAiiWGdYsDuEGLSc+sZ30rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726678; c=relaxed/simple;
	bh=e2jx1V466jjGKARmm/dU4b1YzbHC1f08MXs2aVd2r1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZoEBtfAGulJOensKci49kJAN7PPsgwkkllYXKo1Y0y0qZou1gZZ0WobiznN5wYn7jBKOd4DJHMFklqfpTlsV0NnId0v/rVhLx2HTsXybT1lU7JVd3EDzsaOZ8Hs64kVkjlGZS6djgE7AJoG2np3uzFGJPwjtniGlCBeS9eOM458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IOzD6xNE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso896f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758726673; x=1759331473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqKoqJqnWWMnr7jTc4UigIkEkfLH5uHDDwBPpFeTCuo=;
        b=IOzD6xNEH/eXjcDc1FSpWGCuAchHbYg00MRBuJuc9k+W8/QOFZlXULyLdleSwFE1x5
         P9W4tcZq8e0bZc24Fcm4JQ/XBF7LJNgSgtlXonDYle9eODL0IzwWFy2IgLVlyBX3id1V
         RE5/rWej3etqcqIByNgzE2j37MfXRRLdQA1isewOB9VWdyiXqe5b3zTM3XyKvSbbtkE5
         SFd+kcFP2bNdrExxK3zzHgAlMJcnPAsCE0ASB0NUqFIBeXqqBeHomnD1P5GlKfNOjcTq
         AEEWiMBKBcK92DpuQttohzYFAb+T1pwfL1g12//GVe053J+CVVC3yQfBxHEpsp45WUNp
         c2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726673; x=1759331473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqKoqJqnWWMnr7jTc4UigIkEkfLH5uHDDwBPpFeTCuo=;
        b=PNO8BipN7rxBHjHki9WMQuhQ1emDvU/3VvUowKfzA/vw154CVio+VrNKCHBPP3YesV
         bd3ZOhFownWG/KxGZAjmg9q3vkyCux7soy2d/R4hThVIWEIaagdN8JjEbff5e+Q0MHdu
         dfds+5C466+bgvzdkYoPqmcVP2yPcI2rUYhyLiN0I0CWg8Ug4sk5IoTCHr+BQBOeeIH2
         In1IPJc85Jd2uluH/hUmAODXPbYup4k9sCFYtCUC7/NDBwlXuCXf3y0mNkE1/FZEGAYN
         0Tth/F60K1T7xZqgEzPhlcQ6BnSEO+run0EATgG7F5YigBLcbajxlyvZ2vHtEdruCpNY
         Jp+w==
X-Gm-Message-State: AOJu0YzOfRB3OFunHxzbHvSX3yuVCBrt9XdPrtTmTDN3RZ+cwsGmw94t
	nNq58V769xbsk4Idofgiq/Xt0FSynofW8WxjXxaKUsJo0XTOsUE+nLfGZgiYyNIFqR0=
X-Gm-Gg: ASbGncuDzIpDO1W7DBXVVnUjFMWWntCcXmqJmCkHr6ZlYTgCr3FOcqu1cQN5VikPgp5
	jecpruYW/l/fS24spBVU5MmYppIUoSxZb1mD8LPy8aD9zVDlEkLLt5EZXg1pjBI+/WmeV5AwoIH
	RnQeO4KeUhg339hTbRJp7yGky5VJPwaFvQZKPEpMvWYeh2wQ/yl0y+n/BOnYQROZ8LsQgfApT78
	N+KlOSNBBObehvg3v6HkvZHgb8Az8SaXzwnj/N5apqyKiwZ5JXdRiTsOUi+lsGGMQBi5uFuhPy8
	g1hXsxtC5U9u7H8t43uZuFTLAv0orU1FurBu+mkdw1xZgjGaXhkNnb4H2gBdf6+OgVRD1Z2Wpi/
	nGxb+5yys94K19XDNtEAZE/E3Bn+DlGMerpKVpHTaRPdW932YetKuF1A4EAm3Iw8uc5jm2lmpAs
	Q=
X-Google-Smtp-Source: AGHT+IH7gySba4rPv58PFyZ4MI4BEcH3KuKa0ghWBz1rG8QMo5/Nn8yZaTg6s0xDsIbyFH3+Tb3hnw==
X-Received: by 2002:a05:6000:4210:b0:3f9:fd59:7a67 with SMTP id ffacd0b85a97d-40e49208b7dmr272038f8f.50.1758726672993;
        Wed, 24 Sep 2025 08:11:12 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a7c8531sm36045145e9.0.2025.09.24.08.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:11:12 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 24 Sep 2025 15:11:03 +0000
Subject: [PATCH v5 4/5] clk: samsung: add Exynos ACPM clock driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-acpm-clk-v5-4-4cca1fadd00d@linaro.org>
References: <20250924-acpm-clk-v5-0-4cca1fadd00d@linaro.org>
In-Reply-To: <20250924-acpm-clk-v5-0-4cca1fadd00d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758726668; l=7197;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=e2jx1V466jjGKARmm/dU4b1YzbHC1f08MXs2aVd2r1I=;
 b=Z7Ew6ncBDU5UNEVE+PrivNNyMqO+5Aeq3vTN9+1iRT9Q+OcBK1sMzfC54mvuB/2tFyfRY5m+l
 nfajzJ1kSUBC8NkKpiMfXdWEjTek7INoXj1hviVyp9MkcrEPv+A/el1
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the Exynos ACPM clock driver. It provides support for clocks that
are controlled by firmware that implements the ACPM interface.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org> # on gs101-oriole
---
 drivers/clk/samsung/Kconfig    |  10 +++
 drivers/clk/samsung/Makefile   |   1 +
 drivers/clk/samsung/clk-acpm.c | 185 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)

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
index ef464f434740f96623f9df62f94e2903e14e2226..f3657f2e1b98c6f431ab1f04c2d2a44fe317261b 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos990.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynosautov9.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynosautov920.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-gs101.o
+obj-$(CONFIG_EXYNOS_ACPM_CLK)		+= clk-acpm.o
 obj-$(CONFIG_S3C64XX_COMMON_CLK)	+= clk-s3c64xx.o
 obj-$(CONFIG_S5PV210_COMMON_CLK)	+= clk-s5pv210.o clk-s5pv210-audss.o
 obj-$(CONFIG_TESLA_FSD_COMMON_CLK)	+= clk-fsd.o
diff --git a/drivers/clk/samsung/clk-acpm.c b/drivers/clk/samsung/clk-acpm.c
new file mode 100644
index 0000000000000000000000000000000000000000..9e8354168a63b1427c2f3faf15e4e7955e924dc8
--- /dev/null
+++ b/drivers/clk/samsung/clk-acpm.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Samsung Exynos ACPM protocol based clock driver.
+ *
+ * Copyright 2025 Linaro Ltd.
+ */
+
+#include <linux/array_size.h>
+#include <linux/clk-provider.h>
+#include <linux/container_of.h>
+#include <linux/device/devres.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/firmware/samsung/exynos-acpm-protocol.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+struct acpm_clk {
+	u32 id;
+	struct clk_hw hw;
+	unsigned int mbox_chan_id;
+	const struct acpm_handle *handle;
+};
+
+struct acpm_clk_variant {
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
+#define ACPM_CLK(cname)					\
+	{						\
+		.name		= cname,		\
+	}
+
+static const struct acpm_clk_variant gs101_acpm_clks[] = {
+	ACPM_CLK("mif"),
+	ACPM_CLK("int"),
+	ACPM_CLK("cpucl0"),
+	ACPM_CLK("cpucl1"),
+	ACPM_CLK("cpucl2"),
+	ACPM_CLK("g3d"),
+	ACPM_CLK("g3dl2"),
+	ACPM_CLK("tpu"),
+	ACPM_CLK("intcam"),
+	ACPM_CLK("tnr"),
+	ACPM_CLK("cam"),
+	ACPM_CLK("mfc"),
+	ACPM_CLK("disp"),
+	ACPM_CLK("b0"),
+};
+
+static const struct acpm_clk_driver_data acpm_clk_gs101 = {
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
+static int acpm_clk_register(struct device *dev, struct acpm_clk *aclk,
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
+	const struct acpm_handle *acpm_handle;
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **hws;
+	struct device *dev = &pdev->dev;
+	struct acpm_clk *aclks;
+	unsigned int mbox_chan_id;
+	int i, err, count;
+
+	acpm_handle = devm_acpm_get_by_node(dev, dev->parent->of_node);
+	if (IS_ERR(acpm_handle))
+		return dev_err_probe(dev, PTR_ERR(acpm_handle),
+				     "Failed to get acpm handle\n");
+
+	count = acpm_clk_gs101.nr_clks;
+	mbox_chan_id = acpm_clk_gs101.mbox_chan_id;
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
+		struct acpm_clk *aclk = &aclks[i];
+
+		/*
+		 * The code assumes the clock IDs start from zero,
+		 * are sequential and do not have gaps.
+		 */
+		aclk->id = i;
+		aclk->handle = acpm_handle;
+		aclk->mbox_chan_id = mbox_chan_id;
+
+		hws[i] = &aclk->hw;
+
+		err = acpm_clk_register(dev, aclk,
+					acpm_clk_gs101.clks[i].name);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "Failed to register clock\n");
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   clk_data);
+}
+
+static const struct platform_device_id acpm_clk_id[] = {
+	{ "gs101-acpm-clk" },
+	{}
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
2.51.0.536.g15c5d4f767-goog


