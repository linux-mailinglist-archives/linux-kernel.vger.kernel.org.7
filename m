Return-Path: <linux-kernel+bounces-814090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A7B54F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD931894491
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5E30FC19;
	Fri, 12 Sep 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEo4wIyd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DB30EF6F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682862; cv=none; b=AHpvme6V32spXueyS5XGJO2S//IzsLSiub3o8mAnsITGTQWF89q0NlzL27GG2YnhD/4xW0MO+PLK+xNeY9TJ9TTtAFhJKfqO+S8xEL6M4O1t+a/45kPThNr/46m3gEi+JSvOBsMMbV5n+iBA7V81ziqkX6gX7Q8NWOHr9mX1ZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682862; c=relaxed/simple;
	bh=dtE14Fa4wJ/Kt4AIRcRYWLc08n/p9dqAZ4JSBaWkMjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=At6k89QpJuk1/UQfeqSnIKP/4uHQfi5hvKoUHXSfHPEvJR29lVy8FRG+K69fU4Cxl4aYPJPqSfp87MRaL4yook+xALZVy+AqqZKFZx0C1AdC/8VPi1vSx9RgfUXJiv3Bnn0j3ydIQhtu7zG9K0YdisqAN4uuov5VKa2jEgpvFAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEo4wIyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675E8C4CEF9;
	Fri, 12 Sep 2025 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682862;
	bh=dtE14Fa4wJ/Kt4AIRcRYWLc08n/p9dqAZ4JSBaWkMjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEo4wIydRzv6eaGFG3LrIurIEihRq6u0haUjxC/+EEekRSOUZciJSZ5drdVXfNXgy
	 MHqS0S7rrFBFeU0LZeF8SzdodMnhGEvDaQ3OBaCm2is7/x6aUySlphM4cTNJPlzvIw
	 pwlxhautlaiqMYPDYCSbiivS9KABTEyC0/ynLKVcGWnnrzjbHx351rFI/U+UGF3Lpm
	 ldvKJqX1lXHS+Mht4sOwVV4HiqzbEEP1dePGofMjvFAe8HWAorCn42uKsslSR6C+NL
	 5jEKgL3PAbE/e6u5yTDA8s2W0fPn7Xvke6pIFR1vVSOPbTIn60BAzh1NoTRYSzaqYS
	 aTzbl/vIZBmFQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ciprian Costea <ciprianmarian.costea@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/5] nvmem: s32g-ocotp: Add driver for S32G OCOTP
Date: Fri, 12 Sep 2025 14:14:12 +0100
Message-ID: <20250912131415.303407-3-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912131415.303407-1-srini@kernel.org>
References: <20250912131415.303407-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ciprian Costea <ciprianmarian.costea@nxp.com>

Provide access to the On Chip One-Time Programmable Controller (OCOTP)
pages on the NXP S32G platform.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/Kconfig            |  10 ++++
 drivers/nvmem/Makefile           |   2 +
 drivers/nvmem/s32g-ocotp-nvmem.c | 100 +++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index edd811444ce5..f3b8ffa77528 100644
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
index 2021d59688db..5634945f8196 100644
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
2.50.0


