Return-Path: <linux-kernel+bounces-787034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D9CB370A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385041BA1CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B534431A562;
	Tue, 26 Aug 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afRfUhKj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEFC1F2380
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226298; cv=none; b=a8k97Ccb6YaW3eF82msaWa+fdYE3OH5KqKmhutu35ch5haHQJ6bKf0vYZev472AFyx3wYSaCkn7fC7FzPKUQYGiEulsbE6+1n+VkTCnJ8IwesBwfSIlr27i+LlLF678UjV6Aama/hUUp5/sp0HRN46K6kjyicvJ87UKzIgnCmlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226298; c=relaxed/simple;
	bh=wxrulihyydhTUV6yyBurHEcCGK2MeauHn+ZrD9mgnCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULnvsf+asgszLPZgbqaBODgmn6YsUlb3Y2eedlKWjX4oI0C+EhjI0/vDPcSZO9iXikXmCysHUthzG3NQi2l6JhaZjHF1t40KVcAnA43DfPRk3ZmwpPdyexIQH5v3JqPEuKanSbPyOPMbSsND+Fkyu9wHes0bR8AIVevksR7VjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afRfUhKj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so31388855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756226294; x=1756831094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NPEGwXr4uWuU2uzEezmwVYuz3i0ZHeSNjyWHFwWaB2w=;
        b=afRfUhKjN0DCPr1Kp02i6qJnhCnHN+JTOpfpNzmsR2FncW6Kt+I3moAhUzhFwxoCoT
         6ldMzA967Q+BWbNHqePyTUZtYTlqbDyxM7ylRV9ao4koIaLqVIqlj6JBrZNPkWzSq1ai
         DhQLmx18mEt2KQQkzWDqwNlFpgKwE0esWvMHBDeKjViOWHFzaPDbo2TIjkEhkP8LkUxX
         0h8pSb4+RnlbyDGUF5VsEleHmsRWxZXn4ADEmbf4r72BWOKO+bqqJyPtvoPIYUaoYj6+
         z3T4Y70YagOOr4b0l3e+Q8Hs/LDq8tzteq/FyVsl3hdRk+qzPIEuH7IF6G+SI6aMysjh
         U9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226294; x=1756831094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPEGwXr4uWuU2uzEezmwVYuz3i0ZHeSNjyWHFwWaB2w=;
        b=tyuiHnfzjBq2of4IhaZXUu0uO8jVr1PQgdURI23hxQjBmNn68HXS1yILQg+UYr2zDb
         4UnZbUAG6Yofy2SuJyy2CElkSHVBQljWILORBnRxvG1715Z6lVzLIWoOwJQmbtY+l24Q
         GW+sjwld+nJJJ8VEbomnu0jwEg6tky8aBl/NYtPFhkToBBg4hGwN8IuMHEk4XB67/qLn
         Y6tJe1dbIkt1c6QEjYOyNcjtn/ZZZtTa8v/ZzfdSlXhLrq8XwZZrgRQ+kjgbOQA9vVgT
         bPzQU96j61OaE64SbeD6SPUIxIqUEMKSf2os3rdkL0nhCD922jhYrDrGKmne/LE+wNoE
         Pcew==
X-Forwarded-Encrypted: i=1; AJvYcCUw+O5AL9HKXPqKKcQk28squOhbIj1KOVu0URYX4m+0Ys6zp7LeWXiGK4bEUG7C6ozYU00RZywNWYUGdFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1FaFK5cVhjQJIMYOBehxCEnPzzvgX7urFOSuvSoJQBsJOdTbH
	rmipdEfj1DXy3L4CcILRa0eXmUzmICsEIf+BO8DXEzI4DYWb6KGOTaypz4azTpHgMWY=
X-Gm-Gg: ASbGncuLPbGlW/UboOOapvpX8PyEQMiav4K95KtdaQENoH2D2jAMC/fuoQcamgZhFL9
	5OW2muCw+6KB7rh77rsy1K3kzJP2dMllr8olvL6WQ1/fbhP8AT8QJsXFupel59uzzHwl2IF/W37
	6JNl+f18vtpbV3iVHizgLhyods0lt9Eg4wam4K6cN32kOz5b0UN9iFNblVECGXaaLb4i9epJmC0
	2WtmNsnRGaUChnhru4SiLfe1y055T0GZZevPVvJkL7wR2uF7qdjjq2byHG+kjtSWkIdCAnzUaEn
	IyE/T32ge5J8/MzxOuow9WYx2uhkY+nbkc0LcPzJP8Oqm36mo9R1HSwq+yQBjdiGEIYnR69DN+4
	48Xowub4zJrdTP6Qy3lketxOQwwI=
X-Google-Smtp-Source: AGHT+IFWUO3IiYr6OfpNyyHJBmsLSY9s7iCVd7td/t55EhcnRhQSFH4lK/QJaG/2+bfEsUiq8nFZKQ==
X-Received: by 2002:a05:600c:45cd:b0:458:c045:ee99 with SMTP id 5b1f17b1804b1-45b517d4562mr129733895e9.28.1756226294320;
        Tue, 26 Aug 2025 09:38:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6c53aeadsm42375e9.20.2025.08.26.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:38:14 -0700 (PDT)
Date: Tue, 26 Aug 2025 19:38:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: NXP S32 Linux Team <s32@nxp.com>, linaro-s32@linaro.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 2/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP
Message-ID: <dce51c4706ca4961a2ade23756aab750803b12ec.1756219848.git.dan.carpenter@linaro.org>
References: <cover.1756219848.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756219848.git.dan.carpenter@linaro.org>

From: Ciprian Costea <ciprianmarian.costea@nxp.com>

Provide access to the On Chip One-Time Programmable Controller (OCOTP)
pages on the NXP S32G platform.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Add S-o-b tags for Ghennadi and Larisa.

    Use keepouts instead of the s32g_map[] table.  This allows a bunch
    of code to be deleted.

    Version 1 only let one word (S32G_OCOTP_WORD_SIZE or 4) to be read
    at a time, but now the driver allows larger reads.  Set the
    .word_size in s32g_ocotp_nvmem_config to be 4 instead.

    Krzysztof asked for some changes in the probe() function but that
    code was deleted instead.

 drivers/nvmem/Kconfig            |  10 +++
 drivers/nvmem/Makefile           |   2 +
 drivers/nvmem/s32g-ocotp-nvmem.c | 101 +++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0bdd86d74f62..55016f803492 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -240,6 +240,16 @@ config NVMEM_NINTENDO_OTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-nintendo-otp.
 
+config NVMEM_S32G_OCOTP
+	tristate "S32G SoC OCOTP support"
+	depends on ARCH_S32
+	help
+	  This is a driver for the 'OCOTP' peripheral available on S32G
+	  platforms.
+
+	  If you say Y here, you will get support for the One Time
+	  Programmable memory pages.
+
 config NVMEM_QCOM_QFPROM
 	tristate "QCOM QFPROM Support"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 84fef48b7ff6..e01bb4ad612a 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -79,6 +79,8 @@ obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
 nvmem_sunplus_ocotp-y			:= sunplus-ocotp.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)		+= nvmem_sunxi_sid.o
 nvmem_sunxi_sid-y			:= sunxi_sid.o
+obj-$(CONFIG_NVMEM_S32G_OCOTP)		+= nvmem-s32g-ocotp-nvmem.o
+nvmem-s32g-ocotp-nvmem-y		:= s32g-ocotp-nvmem.o
 obj-$(CONFIG_NVMEM_U_BOOT_ENV)		+= nvmem_u-boot-env.o
 nvmem_u-boot-env-y			:= u-boot-env.o
 obj-$(CONFIG_NVMEM_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
diff --git a/drivers/nvmem/s32g-ocotp-nvmem.c b/drivers/nvmem/s32g-ocotp-nvmem.c
new file mode 100644
index 000000000000..dce092c0fc52
--- /dev/null
+++ b/drivers/nvmem/s32g-ocotp-nvmem.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023-2025 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+struct s32g_ocotp_priv {
+	struct device *dev;
+	void __iomem *base;
+};
+
+static int s32g_ocotp_read(void *context, unsigned int offset,
+			    void *val, size_t bytes)
+{
+	struct s32g_ocotp_priv *s32g_data = context;
+	u32 *dst = val;
+
+	while (bytes >= sizeof(u32)) {
+		*dst++ = ioread32(s32g_data->base + offset);
+
+		bytes -= sizeof(u32);
+		offset += sizeof(u32);
+	}
+
+	return 0;
+}
+
+static struct nvmem_keepout s32g_keepouts[] = {
+	{ .start = 0,   .end = 520 },
+	{ .start = 540, .end = 564 },
+	{ .start = 596, .end = 664 },
+	{ .start = 668, .end = 676 },
+	{ .start = 684, .end = 732 },
+	{ .start = 744, .end = 864 },
+	{ .start = 908, .end = 924 },
+	{ .start = 928, .end = 936 },
+	{ .start = 948, .end = 964 },
+	{ .start = 968, .end = 976 },
+	{ .start = 984, .end = 1012 },
+};
+
+static struct nvmem_config s32g_ocotp_nvmem_config = {
+	.name = "s32g-ocotp",
+	.add_legacy_fixed_of_cells = true,
+	.read_only = true,
+	.word_size = 4,
+	.reg_read = s32g_ocotp_read,
+	.keepout = s32g_keepouts,
+	.nkeepout = ARRAY_SIZE(s32g_keepouts),
+};
+
+static const struct of_device_id ocotp_of_match[] = {
+	{ .compatible = "nxp,s32g2-ocotp" },
+	{ /* sentinel */ }
+};
+
+static int s32g_ocotp_probe(struct platform_device *pdev)
+{
+	struct s32g_ocotp_priv *s32g_data;
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct resource *res;
+
+	s32g_data = devm_kzalloc(dev, sizeof(*s32g_data), GFP_KERNEL);
+	if (!s32g_data)
+		return -ENOMEM;
+
+	s32g_data->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(s32g_data->base)) {
+		dev_err(dev, "Cannot map OCOTP device.\n");
+		return PTR_ERR(s32g_data->base);
+	}
+
+	s32g_data->dev = dev;
+	s32g_ocotp_nvmem_config.dev = dev;
+	s32g_ocotp_nvmem_config.priv = s32g_data;
+	s32g_ocotp_nvmem_config.size = resource_size(res);
+
+	nvmem = devm_nvmem_register(dev, &s32g_ocotp_nvmem_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static struct platform_driver s32g_ocotp_driver = {
+	.probe = s32g_ocotp_probe,
+	.driver = {
+		.name = "s32g-ocotp",
+		.of_match_table = ocotp_of_match,
+	},
+};
+module_platform_driver(s32g_ocotp_driver);
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("S32G OCOTP driver");
+MODULE_LICENSE("GPL");
-- 
2.47.2


