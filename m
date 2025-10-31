Return-Path: <linux-kernel+bounces-880183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC45C25119
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73365189C949
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1F230CD99;
	Fri, 31 Oct 2025 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2usZh1l"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B01C5F1B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914723; cv=none; b=fj7ujHslp8h8z7UxMyv60jICNgza7diOSR5WeIk/OOplEYQbRC8SQjC7BW3WeVgyi+UrvzQFYxkfGZ/FBRlTQbZhziTk76QrgQ6UNocn96MOMZ1excGybqIaC+rOLHRaYje6B4+Yp2tyxLY5spY5gj7RT1YWkcaAKZ2SpNAVDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914723; c=relaxed/simple;
	bh=w0yfdSTm6gp3caPgxHc/5REqzvFvqbJrg1PSnC6Rs4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hr3aTYezoGU7Dh6i+S09yzAyjn/6OQxlhVEFS+y0/ge2K2wfCPEjqd4PQmH40Y04zZskayV5/unyu7nFPH9ci5q4g7N4wg0RuRBLZeIMK9gAyNpnidoCKIJwz+aq6+yk5s4AUEhTThKfgPdJttMbDFCZy/zpQNbJszAaEGSKbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f2usZh1l; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4711b95226dso27866975e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761914718; x=1762519518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=660/GUyr8+xiyQEE/ln7pRyZWtVdpwNeVJPsoSzCzFA=;
        b=f2usZh1lmyVN0DQCO6OnKiKTqtM1YR3MrQN1JzWAsw87CxmVdMeKCTTWg+4flgbU3z
         DdIvidj6+mBLUHLZYBCqc2Sr3kkDZRueEexAO34yud0q0fYdDFzOet/4q2XLo6ttrh2P
         RpKfLwx0W1jaZjwubFBXoTolqJp0nHpsKK53BHqUIrozg15Wmc2z9jZnTbq4ieMWhFsR
         CV9PBX8DHjoEofULhOZ35vWT/UgxJidUuVCpWvNTDXiHumCbtmnBrEbq/WOr0FZAI0fd
         z3mXgfeApdpUVb0vdOULYxLSnA3KvzyaNFroGo5n87jFpoFQOm++Uzb6+X2j5QV8HAOR
         HGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914718; x=1762519518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=660/GUyr8+xiyQEE/ln7pRyZWtVdpwNeVJPsoSzCzFA=;
        b=OeiSZkbmrAPUD3lugX+SL2SFZTHXLiAr1BzyrE+WfLz8AZhK7k8iiNhXUuju4EmxjF
         QFZZjjy+ZkUFeDi9QuD+8E9wOExP85PNw3ZlYCSYLnAbmeo/Qo6g86mFgn2UUJAXFBFN
         9eQwk17CtfJWq/swX8rkZXuxlyw+yrbEp97YGL0JmCaXTOOKYeSwyPSKRT+f17KF13zY
         hroW1UV+G2dPmZMv9qKnEinWngpGit70OuPS11z73DWUgIJmg/O1wZjjQtnyKBzitwDV
         l5jxl53wvITO2cFlyB8EKjrIIB+R4Z0CwwpspAolIHPz6ta12XAJmssFbr++oymyWzE2
         D9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCViPzKnGEbiwLlceR+c2lubePQreVi3J7v5yOC98v+c9xtwYGzJp+uNo4UGGMqdncs1bIgiooqTXtyHR+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytnPMUQvIUB+p3nkTkYd4KJKPYR3+2imWlq0dWS37yMc3URyiO
	RyShIkhGigkiHb3ezBozx8TthcSaz3oq2Ce/BkmjXM4Za7KD5lZElxe6wb09ckXGphb5gW0r3bS
	YJ/17
X-Gm-Gg: ASbGncvI1W/kEUBaiW2Hf+AdXOH/mZRrM1BTvbufS6JXAnsLR/lSXVN4RofztcO0GhQ
	INyPWJYVZ2yreqBucwHaMAUuqr22U17f1M9kc2Cz8chGV+9aa8d8sNIiC6MwP3DPM3QhXGDunwK
	Ajjjtbs1HvP/H7qQ4sOImFvuxr3I6wIkuHFwC7JDtbWNYeiPX95w9dHQR9cX/bZ6Df7/N5nOfts
	1cZXzmf9169uaZwbxpE7iVYZfY8jh8Bm08sOmOT4cBn5KgKMuuskMbmzrQhv3OAMNWwpFcGpuKI
	8dUYjvDTJJV9NwD6B3QGvA6QdnoUgO4Lxz+OramWYdDbhFdbUAZKLpOuxYCDGfB9NtNZlihNh+p
	HOf/F6WU8VLAO1/IzGemWw2YZbINGqJig9CXonOGEsYgISJr6mbHyQ9cDoSW4yjCGk24FgAVLBv
	ehkaIwAU3SasIuJhNCUpJDzYr3myAGkjVZGAJqUHRF2rx+4w9g0YghxpiIkFerbD4=
X-Google-Smtp-Source: AGHT+IH0gyK0WWDUF75+dz03qe3+Zyttu7Zg0jZFhbcGhaDg57ZydmfAmUHKy/Cjxcmg2bJ8GmNwBw==
X-Received: by 2002:a05:600c:1f0e:b0:46e:4704:b01e with SMTP id 5b1f17b1804b1-477305a24bcmr36164165e9.8.1761914718273;
        Fri, 31 Oct 2025 05:45:18 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff7fdbsm31077535e9.16.2025.10.31.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:45:17 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:45:10 +0000
Subject: [PATCH 2/5] nvmem: add Samsung Exynos OTP support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-otp-v1-2-2a54f6c4e7b6@linaro.org>
References: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
In-Reply-To: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: semen.protsenko@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761914716; l=5190;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=w0yfdSTm6gp3caPgxHc/5REqzvFvqbJrg1PSnC6Rs4g=;
 b=YcYEgJptfXhF94yOa4/Ab0f9sCdd4QntT5HeUNYAN73i4zFNGC6vPbnjwfZ9a76WL82ms///n
 VwtDhW+9XjTBzgLFrKzjVbzbdb/axrnQvjUKPYf9zol9IGWEShWS2Mz
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add support for the Samsung Exynos OTP controller. On the Google GS101
SoC, this controller provides 32 Kbit of OTP memory space that can be
read/program/lock using a specific sequence of register accesses.

The OTP controller register space is of interest as well because it
contains dedicated registers for the Product ID and the Chip ID (apart
other things like TMU or ASV info). Register the OTP controller
register space as a nvmem device so that other drivers can access its
contents using nvmem cells.

Support for the OTP memory space can follow and be modeled as a
dedicated nvmem device.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/nvmem/Kconfig      | 10 +++++
 drivers/nvmem/Makefile     |  2 +
 drivers/nvmem/exynos-otp.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index e0d88d3199c11a3b71cc274b2114e9554ac486fc..f973e009737f2fbdc8511e50f1aa9e6003286065 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -84,6 +84,16 @@ config NVMEM_BRCM_NVRAM
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
 
+config NVMEM_EXYNOS_OTP
+	tristate "Samsung Exynos OTP support"
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	help
+	  This driver provides support for the OTP controller found on some
+	  Samsung Exynos SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called exynos-otp.
+
 config NVMEM_IMX_IIM
 	tristate "i.MX IC Identification Module support"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 70a4464dcb1e25cf9116280a32f4a0f4f9941a75..920a536fc359a5a7d8f3aabba6a712e85c277ee7 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -20,6 +20,8 @@ obj-$(CONFIG_NVMEM_BCM_OCOTP)		+= nvmem-bcm-ocotp.o
 nvmem-bcm-ocotp-y			:= bcm-ocotp.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)		+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y			:= brcm_nvram.o
+obj-$(CONFIG_NVMEM_EXYNOS_OTP)		+= nvmem-exynos-otp.o
+nvmem-exynos-otp-y			:= exynos-otp.o
 obj-$(CONFIG_NVMEM_IMX_IIM)		+= nvmem-imx-iim.o
 nvmem-imx-iim-y				:= imx-iim.o
 obj-$(CONFIG_NVMEM_IMX_OCOTP)		+= nvmem-imx-ocotp.o
diff --git a/drivers/nvmem/exynos-otp.c b/drivers/nvmem/exynos-otp.c
new file mode 100644
index 0000000000000000000000000000000000000000..3bff9421e6f2b80a8f20533b490a289687d117e8
--- /dev/null
+++ b/drivers/nvmem/exynos-otp.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Linaro Ltd.
+ *
+ * Samsung Exynos OTP driver.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mod_devicetable.h>
+
+struct exynos_otp {
+	struct clk *pclk;
+	struct regmap *regmap;
+};
+
+static int exynos_otp_read(void *context, unsigned int offset, void *val,
+			   size_t bytes)
+{
+	struct exynos_otp *eotp = context;
+
+	return regmap_bulk_read(eotp->regmap, offset, val, bytes / 4);
+}
+
+static struct nvmem_config exynos_otp_nvmem_config = {
+	.name = "exynos-otp-reg",
+	.add_legacy_fixed_of_cells = true,
+	.reg_read = exynos_otp_read,
+	.word_size = 4,
+	.stride = 4,
+};
+
+static int exynos_otp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct exynos_otp *eotp;
+	struct resource *res;
+	void __iomem *base;
+
+	eotp = devm_kzalloc(dev, sizeof(*eotp), GFP_KERNEL);
+	if (!eotp)
+		return -ENOMEM;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	const struct regmap_config reg_config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.use_relaxed_mmio = true,
+		.max_register = (resource_size(res) - reg_config.reg_stride),
+	};
+
+	eotp->regmap = devm_regmap_init_mmio(dev, base, &reg_config);
+	if (IS_ERR(eotp->regmap))
+		return PTR_ERR(eotp->regmap);
+
+	eotp->pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(eotp->pclk))
+		return dev_err_probe(dev, PTR_ERR(eotp->pclk),
+				     "Could not get pclk\n");
+
+	exynos_otp_nvmem_config.size = resource_size(res);
+	exynos_otp_nvmem_config.dev = dev;
+	exynos_otp_nvmem_config.priv = eotp;
+
+	nvmem = devm_nvmem_register(dev, &exynos_otp_nvmem_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id exynos_otp_dt_ids[] = {
+	{ .compatible = "google,gs101-otp" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, exynos_otp_dt_ids);
+
+static struct platform_driver exynos_otp_driver = {
+	.probe	= exynos_otp_probe,
+	.driver = {
+		.name	= "exynos-otp",
+		.of_match_table = exynos_otp_dt_ids,
+	},
+};
+module_platform_driver(exynos_otp_driver);
+
+MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@linaro.org>");
+MODULE_DESCRIPTION("Samsung Exynos OTP driver");
+MODULE_LICENSE("GPL");

-- 
2.51.1.930.gacf6e81ea2-goog


