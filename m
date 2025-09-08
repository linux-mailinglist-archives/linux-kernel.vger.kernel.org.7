Return-Path: <linux-kernel+bounces-805905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE48B48F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A98163EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4A30C36F;
	Mon,  8 Sep 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NeyDu8hM"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793E30B520
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337187; cv=none; b=Vry3i3BHBuG5Ik113Owc749+8FnBKO3gCd5zgnNwT7fOU3fQ0df2ev1cy7amkje8NMehKFedWtQ0dhDtQsoQ5tenKxz67skFbN6evLbktMcoe65t0VzRVwzoYI39LRxT5hnibQX+Dhc5+xF1Afm0fmS9JHfBsZMRGSQggMYj9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337187; c=relaxed/simple;
	bh=zsTISx5UPB2MF9C+zHG1pBXN7EwBKTxj7oyZeiQZndI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHMlszkPtlLWIA2+p1o8VJkZ4mUiXHn3xNqDH3P8oqSrP56NlUY//jWHd+EMd5gAJMDVVxOs+NVECBAz++OKbw7k8WQvrgWrTlcoVgl2MSlVznUC745/gwZReznyXFA5SF13Y1J2tIsrRYGlMBx77Tn1jfomoDfrEQiX8iDva4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NeyDu8hM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dde353b47so7779565e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757337183; x=1757941983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nn4ZPBAE1p0WQez+p04HAUrpmNRFyGY7kFnsP9wLhQ4=;
        b=NeyDu8hMPzY2PwTLQ0d2F3vgR83XUh81rQQt5u+I5qCGWknVPtd9KOR7CtkEyJx1gt
         ly6fNYu3aFqKt7tU4ITbXOWgqwi8M1RHr0E3X9qwf1OSEmB+54+014MiT/H+682b0hcG
         s+3A5N7q9eRdvAWa9auoMXYlMHkjMMnefbF4g30ZObE2PswtyTLomQYztTcWVf94RCm9
         ZBMXjRHIszwyMOJoVAeAklZIQYBdwfEklMrwpBYqgKunH8MaJt8/v5nSd2i+eP93wGv9
         3RjpqIrvnoV1vANLps73vqCDCguUrDOhhp7phVYhEOEn2FUSjqu6Ugzdw992X+gbLqgX
         OZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337183; x=1757941983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nn4ZPBAE1p0WQez+p04HAUrpmNRFyGY7kFnsP9wLhQ4=;
        b=BlV/QujbuuvA5sryrWkL/kb6ekdN8DZGA8/X48CqeaIaM1HFwGL0hUBleu2FImRdnw
         XhCasaLtqcDDoRUvrNZudH7Rsi+rLbEr3Bu8wcft0+kbXWctfQul9d08hB+l4ZzVgdTN
         TgqRLFa9p3rnNS0dS6koMiKbHKv+vVyRguZvkvDTQqBdsMU1m7vSF+RtewEuDS8GBEeH
         KmLz36Lji3NGGW+1pR0jBS8vPIhCX2FM4bdKXa0unfCGq5FSvq4OzFOZjgEv9R7za3mr
         0z2OEaTyFw6p0mXpRi4NieCKrp/xIoXTCOcCG8Zwy3hnYRONJ5eJlo0/3LNLUFRIEHTW
         vMjQ==
X-Gm-Message-State: AOJu0YwCeNBh1OWEcl3owRXNQyfJUxQlikhKyXbA3JOVL+dd+c610ijw
	/pfDVmczuuzeyXSsgQZ7OcIjl6xg0xSn1bhlrmEA4fQXHzCc2Wyg8jUPpG5v7w8zXT8=
X-Gm-Gg: ASbGncuDil/al7pEezJ3INjv3RKctR/ODMgQ5036nBM+kR2VWLIQQXXgA+tRv+T17Bo
	Ukc9QNXLy04btjK47lQwztFdFsZFPxr3VWPDRxc8d1dn35CFKcwjzdq7m/8YnDlziJYp0r75iox
	A1MzZ8yGjH+8VwtK97GTvn4bJ6OeY2FD9yfuabbpNwOJT86mZN+kmzRRrUZRwmzP0wc0NDp4dMX
	T0TtoOVB8c/iNOYEl74F22SfUtCm1QLJyG3krJtLyG9L3Z89ngxTa6d2beu1WPbP4Y2glVHr1w7
	rGj8DfCQWzbsJy8Ac48+pI7Kjvu1So8kpaEIVH1E6gY43gEkxaGy8uHLIjMDzvIkWi5LCMBeV8C
	b8Op2SZwnO2ttasiQEl6pk+snsliak/ADtcDwmfSUZePupsLWQj9NSH44UIPLQqw7IM+WjrYSAm
	nzMgzoAUudo2ES7sdsQzysxkw=
X-Google-Smtp-Source: AGHT+IFG/nu92v+wDSAVp23lec/lDejCcvcTcEear99V05L3y7tvjn8NlMnCha7VWiPcoMj0sS7ZnQ==
X-Received: by 2002:a05:600c:46d0:b0:45d:d96e:6176 with SMTP id 5b1f17b1804b1-45ddded62d8mr64725115e9.25.1757337182856;
        Mon, 08 Sep 2025 06:13:02 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9dbfsm41650181f8f.43.2025.09.08.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:13:02 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 08 Sep 2025 13:12:45 +0000
Subject: [PATCH v4 4/5] clk: samsung: add Exynos ACPM clock driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-acpm-clk-v4-4-633350c0c0b1@linaro.org>
References: <20250908-acpm-clk-v4-0-633350c0c0b1@linaro.org>
In-Reply-To: <20250908-acpm-clk-v4-0-633350c0c0b1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757337178; l=7029;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=zsTISx5UPB2MF9C+zHG1pBXN7EwBKTxj7oyZeiQZndI=;
 b=zbluNhnpemXb2upjzba7C8KRFYiQ/Zq5DEYaQoCPHVt0hznA8jI0TJt8M6MjE8C9P5mwSqY+y
 Xv81evSTexqDqIGqCSJ6Kgk4GNdG+YC8HXM75OVGd1JvWoQUEM3AupW
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the Exynos ACPM clock driver. It provides support for clocks that
are controlled by firmware that implements the ACPM interface.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/Kconfig    |  10 +++
 drivers/clk/samsung/Makefile   |   1 +
 drivers/clk/samsung/clk-acpm.c | 184 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)

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
index 0000000000000000000000000000000000000000..8566495265ee3e06dbf370f9e424d5540f5c7457
--- /dev/null
+++ b/drivers/clk/samsung/clk-acpm.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Samsung Exynos ACPM protocol based clock driver.
+ *
+ * Copyright 2025 Linaro Ltd.
+ */
+
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
+				     "Failed to get acpm handle.\n");
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
+		err = acpm_clk_ops_init(dev, aclk,
+					acpm_clk_gs101.clks[i].name);
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
+	{ "gs101-acpm-clk" },
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
2.51.0.355.g5224444f11-goog


