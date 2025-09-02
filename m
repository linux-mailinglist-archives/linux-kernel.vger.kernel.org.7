Return-Path: <linux-kernel+bounces-796022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF3B3FB02
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C277A913A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50332ED853;
	Tue,  2 Sep 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1XFddZR"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF327AC2E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806479; cv=none; b=CPGOFCcLmwm1K474y55eSzwO81j1GfEBGvriD22mvVEY0sjDrXL8Xoe+45JLGohL5F8aIy+JvI8tOaQadGWXncaS4fN159LtMGW4xoURb+EhzeNLCWTdJw87ZAcIIF5/HAOirqg8FcOnkv06n90Eho2XWOIyFony0hV47eva6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806479; c=relaxed/simple;
	bh=LpF0I0/Jc9hvOyVmaGfM0tcGifeduVMOBdmu+MwLQUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZU3ZCurSI9TjHhGsM+6t6cTvuYiHkxkghEknrPkH+bTJoT1PK5cyGTor9VM/5lGkn/1+/dKTUGvRqYxosH4ONV1MkOmMUEqc9KJt8kseYSCK4iK8cSSBAiAiGqJCZRRmMYC6PzBmWdAmmWottiKRczzSgjYXadYnc/otYXDAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w1XFddZR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so275310f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756806475; x=1757411275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/8knJNiSWo06IzZroNvpu9/OUleLJhwofC/xL/YFq8=;
        b=w1XFddZRm20NRzKHfhCCa1CEiJpatIVt6cvkcE+sY3B0rJxLRT0HeeTroPAe86s4kg
         BZaCFcZGNlxVgrg27izs92rrNKSyApFI0ddyxM4h+8yvUh8rDPqiiGwGNiY+/q9KlXOv
         9cIt4PP9JCL0TfzHHFdS5SylXUVE7GKCK46WG30+ZV+TTU0yMtys81w4XycPun1UDs4h
         AMhMtzh92Q+d1phPum7jR61ub/t3bjbD0r7RqsXcAL1JU1K41ZS9TSrieHyyoLGe0lsj
         X7Nxz0jCJMjKpL1riJsz4KFdoOXwkyH11/AP9vX2fYHn8gOxZsASMDmPqiIbyWc9sZER
         aOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806475; x=1757411275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/8knJNiSWo06IzZroNvpu9/OUleLJhwofC/xL/YFq8=;
        b=TSOnmToNpVnINtgEyUK77oQiul9b64i2+wnqAJ3TBjB4LVW5SiRf5SpOPvIAkPb199
         pSIiYfQGbwCEwACsMagmZO86Uoo6KXR32NzqJ/S5gzVGtw9yaRtwVMeTgRGJxMrJR5wg
         Xpzo8sZ3sBufwlI/toHTBPSWCv94kgT2hsfGFx3ON4m2wrXa5otAghouEMLlF+kFnHPa
         5vDYdosNdOWwET+/rkbgJugPaiOv1kF5dTA20pdIoChj2sACC53H3fBULl3EysOuh7B0
         cIB47YhG/yUucCz/E2m6sp+bp2VHxEa2W3ZL6l3ahJxsREBfI+5/c8OyMe9Li1x7dvME
         1c+g==
X-Gm-Message-State: AOJu0YzY4CISZiM0I1ew9CSYqOL1g0IexbbV+BvyIlETghYpHSctYOy3
	dYlDPVK9a8OPkYCgXbOM/lZbaJ1J8ipk9b9xpVVVZkk8ozRuKX+F48EbTir1Jza+aMA=
X-Gm-Gg: ASbGncu65Wk8RWwHouG40qf+e+UeSqnR49J9+mlywc6vnOgbWTVFze8vDG81yM0lRrd
	zM1XcZqgNt8Hz7Ujgw0xhB/ENVDVLbkxYRullSx+dp7fq4iHwhcTCRxTRWe3ltP387XqZ9XA0zh
	hLufdsiornNoFscYBcmGsNq6/On0+WiNAuSMRr8E+Y/w/SB1/9GyQf43m8IGszAe2Jyoa4DwzQU
	i7YhOBtvJEtj8zUME0goQXZTNLYc7eygXURZTCAdT3nEF6HhWopZWRdrnPYnMqxNEjI3ni6TZ8Q
	JXMsvWrWJGA+30ZHNPF06S8iqKVFcOKHeyJeE66meF2HMq9VNMoCHLBRfCzsomVpMc5ucZgCFEQ
	+qbSx1weFjspbrVqYv2AbcFS3azs=
X-Google-Smtp-Source: AGHT+IGcwg9+LX0vjWMkro3ubGDf4kfBgR3qsQ7Aqwk8vKUj6Rs/FvX0FhHMG1Q+i222d7yJ6eCBwQ==
X-Received: by 2002:a05:6000:18ab:b0:3d6:a2d1:8ea4 with SMTP id ffacd0b85a97d-3d6a2d192c0mr4237375f8f.18.1756806475393;
        Tue, 02 Sep 2025 02:47:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d3a7492001sm13589602f8f.42.2025.09.02.02.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:47:54 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:47:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-kernel@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>,
	linaro-s32@linaro.org
Subject: [PATCH v3 2/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP
Message-ID: <d0e0fac8ed13d321ae9bb996fc8309fd729d7e2a.1756800543.git.dan.carpenter@linaro.org>
References: <cover.1756800543.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756800543.git.dan.carpenter@linaro.org>

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
v3: Use dev_err_probe()
v2: Add S-o-b tags for Ghennadi and Larisa.

    Use keepouts instead of the s32g_map[] table.  This allows a bunch
    of code to be deleted.

    Version 1 only let one word (S32G_OCOTP_WORD_SIZE or 4) to be read
    at a time, but now the driver allows larger reads.  Set the
    .word_size in s32g_ocotp_nvmem_config to be 4 instead.

    Krzysztof asked for some changes in the probe() function but that
    code was deleted instead.
---
 drivers/nvmem/Kconfig            |  10 ++++
 drivers/nvmem/Makefile           |   2 +
 drivers/nvmem/s32g-ocotp-nvmem.c | 100 +++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
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
index 000000000000..119871ab3a94
--- /dev/null
+++ b/drivers/nvmem/s32g-ocotp-nvmem.c
@@ -0,0 +1,100 @@
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
+	if (IS_ERR(s32g_data->base))
+		return dev_err_probe(dev, PTR_ERR(s32g_data->base),
+				     "Cannot map OCOTP device.\n");
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


