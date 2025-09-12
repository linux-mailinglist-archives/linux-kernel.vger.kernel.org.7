Return-Path: <linux-kernel+bounces-814093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FF5B54F14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561CD1CC4A83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0490531353E;
	Fri, 12 Sep 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZgusYff"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EBD3112C1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682867; cv=none; b=pMNZ2Hzt/hTIuon+X5lQMn7P83TXul7mQeHRNbe/BrIsOv1FrxfIG5Y2niOzXqzxY4pLCpHUKOcqUozmNkpqcQA+La4lquE8rt75CG+UWZPSibYIMZ+xVkbIRL2cBBJ4IVAgdjChnBG+VzVyJyU7I+jREQYzhC7mVJoUysmPYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682867; c=relaxed/simple;
	bh=4jt0WH+ib9lMrNTRLeJ7mkZWBV7AKrfXxg/X9EzV/nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQEmfwk291+XKhs2Rrk8sMVHbHjHA9JiH8cdhZRoHrQ1XwFsxI4kWio6mhKgJrF+Ew+Ln/IoCyBC2REKR+S4KYQ5V4ST5pPYATieVocrUk3HMYQfPH1e39/poFgz9aX2gLvYqxCxNS0Tg+z3sO4gPNs+wOCItLFp2p/RmWW9Ra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZgusYff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D90CC4CEF7;
	Fri, 12 Sep 2025 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682866;
	bh=4jt0WH+ib9lMrNTRLeJ7mkZWBV7AKrfXxg/X9EzV/nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZgusYffgwKndLCNjm033DHZPfxGStzMCI1RSzh4XssDJMSpnL11eMGeoZBVO3XCT
	 2zyazLtQJAXCk5multFrJozbGP5lB9Aq4GCVNyN8dp4sNDx1djFMyUJUIPkj3fzGkp
	 Y8NYNOTl40Sz+JLnUD4WOxrVGr6EUCfnQ3yXYqJSZk0Po1xTjGWUEIzRVtft1pE3SA
	 a2cevqr41+O6v2+wQtyXnKTT8yAWxYgar8+k+sh4vUww0C0Tdf8f3Iv77wuT4bhWrJ
	 UvkGWCRAudn8ttRJQ2k935mDvKZDeuCjK1hoK1D3Hp0ZvV2pa0onYQIckN1Oo45JFD
	 lXVoOo1cQzLgw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 5/5] nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE
Date: Fri, 12 Sep 2025 14:14:15 +0100
Message-ID: <20250912131415.303407-6-srini@kernel.org>
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

From: Christian Marangi <ansuelsmth@gmail.com>

Add support for Airoha AN8855 Switch EFUSE. These EFUSE might be used
for calibration data for the internal switch PHYs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/Kconfig        | 11 ++++++
 drivers/nvmem/Makefile       |  2 ++
 drivers/nvmem/an8855-efuse.c | 68 ++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 drivers/nvmem/an8855-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index f3b8ffa77528..e0d88d3199c1 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -28,6 +28,17 @@ source "drivers/nvmem/layouts/Kconfig"
 
 # Devices
 
+config NVMEM_AN8855_EFUSE
+	tristate "Airoha AN8855 eFuse support"
+	depends on MFD_AIROHA_AN8855 || COMPILE_TEST
+	help
+	  Say y here to enable support for reading eFuses on Airoha AN8855
+	  Switch. These are e.g. used to store factory programmed
+	  calibration data required for the PHY.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called nvmem-an8855-efuse.
+
 config NVMEM_APPLE_EFUSES
 	tristate "Apple eFuse support"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 5634945f8196..70a4464dcb1e 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -10,6 +10,8 @@ nvmem_layouts-y			:= layouts.o
 obj-y				+= layouts/
 
 # Devices
+obj-$(CONFIG_NVMEM_AN8855_EFUSE)	+= nvmem-an8855-efuse.o
+nvmem-an8855-efuse-y 			:= an8855-efuse.o
 obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 			:= apple-efuses.o
 obj-$(CONFIG_NVMEM_APPLE_SPMI)		+= apple_nvmem_spmi.o
diff --git a/drivers/nvmem/an8855-efuse.c b/drivers/nvmem/an8855-efuse.c
new file mode 100644
index 000000000000..d1afde6f623f
--- /dev/null
+++ b/drivers/nvmem/an8855-efuse.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Airoha AN8855 Switch EFUSE Driver
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define AN8855_EFUSE_CELL		50
+
+#define AN8855_EFUSE_DATA0		0x1000a500
+#define   AN8855_EFUSE_R50O		GENMASK(30, 24)
+
+static int an8855_efuse_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	struct regmap *regmap = context;
+
+	return regmap_bulk_read(regmap, AN8855_EFUSE_DATA0 + offset,
+				val, bytes / sizeof(u32));
+}
+
+static int an8855_efuse_probe(struct platform_device *pdev)
+{
+	struct nvmem_config an8855_nvmem_config = {
+		.name = "an8855-efuse",
+		.size = AN8855_EFUSE_CELL * sizeof(u32),
+		.stride = sizeof(u32),
+		.word_size = sizeof(u32),
+		.reg_read = an8855_efuse_read,
+	};
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct regmap *regmap;
+
+	/* Assign NVMEM priv to MFD regmap */
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENOENT;
+
+	an8855_nvmem_config.priv = regmap;
+	an8855_nvmem_config.dev = dev;
+	nvmem = devm_nvmem_register(dev, &an8855_nvmem_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id an8855_efuse_of_match[] = {
+	{ .compatible = "airoha,an8855-efuse", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an8855_efuse_of_match);
+
+static struct platform_driver an8855_efuse_driver = {
+	.probe = an8855_efuse_probe,
+	.driver = {
+		.name = "an8855-efuse",
+		.of_match_table = an8855_efuse_of_match,
+	},
+};
+module_platform_driver(an8855_efuse_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for AN8855 Switch EFUSE");
+MODULE_LICENSE("GPL");
-- 
2.50.0


