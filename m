Return-Path: <linux-kernel+bounces-890746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01502C40D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C59218860D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DF333031E;
	Fri,  7 Nov 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+qcIQht"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5332F745
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532020; cv=none; b=vGkR8pVA4BjArNhI5pBRmJYv/d0xccoXvSTI08PSw190cUUawflUhdtq6ryf7c4IzqRai8fgmE1r2XHegYUfPgP+3nqbB7/nqi1rxdcJQsrax6DramB4NmCBC5YQzReMmAeauKb9loyoxQ4PxSLcEbsEdxvdJU1xH2Cc7mCpsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532020; c=relaxed/simple;
	bh=hrrLzMnZuUkom8I9qzvbne/uAV8TzA4LfzM4RMkjwr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov6NorJoicRJTY5+yj19kTsBmtQek37XbNDjm4NtTvwPq2J3EvVQ3J9vh2GGZhn+ozi6KZjCT/WLm/d7TOai6bHQSWLTcOUOI3b83Bwa141WKg6aCggu1IqZ6Vag3IjjhbfmchKe9f9ECRVv2Sy1b1JMnciUlXhgcL7077DAcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+qcIQht; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47721743fd0so4649755e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762532017; x=1763136817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+2QowXYpWUDNBNFW/v/Du0vqKDWkaTMrOXjle7suXI=;
        b=m+qcIQhtWZ3B4d6IWHIaKaK+sbDFkgcfMoFnlZT+wZnbZWLo4P8f8AAYo3JrDY2I5s
         yW4ZyOsiPsvSSpIgXkOpwSz3hSP0D0ilTk7ZAg4j1znIjtpLF7cV1TMIiBP72Y5cBVUD
         fQRrA9xXvoGDTtUoS9mqsJNztEGGk+uNhguwF1WurpQjEupW2m6jGmVn/ExRw3xP1KDS
         mZTddyK0R4cq5FHAQBe0zYacuIAURyA5SvxlFHIEckpPkeeI9+IcA+HnNGaI92Xs04eM
         1PUbR3kqM9Q7xAkjU3nJ9MXVbhqZWazGvMa4oeYzkW7EIiGisazklx7SL9geCNUmcjd6
         zOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532017; x=1763136817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O+2QowXYpWUDNBNFW/v/Du0vqKDWkaTMrOXjle7suXI=;
        b=BrtuBEqE4YCHplBYMf8cPUtS5qQncBBjvL96H1iMB049vMgUwZmgyGrIuARTsBnh3W
         SqFObn0PtRRozOeqpNUYLRh9DzZOzCTgLhxltpmr68Pvo0f9GLuEAR4m/WSHnvizXWi0
         YnVCD7tjqfYhQZ6DH6bQ8bFIKmhYk9o16UIGK9UmxFaeiOzLT0vybluJPXQJOYRD+rzT
         8j/AIxRhs5EpFYsmSbsFfV2howfhRM/wDLBwi/uQ4lg8wG5BM5vMRvVYtZ+OJ2wjW3Pw
         7Ur0v5OMeVAy+VEeIEcqyxOL0yRf9DjG05GtqawWcNxTGIH19+qfPOIGRQ33Swf6C5PS
         BG7g==
X-Forwarded-Encrypted: i=1; AJvYcCWI17ZG8QFJ5k8DzfGeSsJJ4gpnXIha93UWXojMFt5uETrrNQhjKcs7uB2Jaj7BEDfhE/7j2EzoKPhkDQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydBCpfWXC6kPG6ZiiAJhD4qJW5bHrFwGR10Mb68z+8S4YNphDO
	K14GlTo0U4jE/2fkSo3z2Ftgw5Bakz8/oqV2V8+5yD8oN1bE2pfXSzLK
X-Gm-Gg: ASbGncsRMGo6w7ptK9vSYgYHFr2k5NUP+ToiTZ9G6ba7R9IsykSzbpwkcXzGlmYbhg/
	lViPdQPJ9HkMEJ3r8HcF9PyF4Gimq0gR6Frkjwyv9F4UWnHqtzAPOsEAHmSzad+ZwpNXzTHZOuM
	qAaC+iHne2HDEXj/5spexUdv8iW48rcIWkWzR9Cfi+ZLFTlOYyl5ADt0oZJPGbawDFY0A1ztbni
	cbjtW40T8i/sq6ESbt6Nr2d3XSFMduUxa50ANRdcezjtHbEM6C4efkk/ACpPNiFOMAIGegrFHLD
	B51zT1aGNdsglkARcRu5JagZFB+i1Vt/+b6DbX3cQHn1vlFgvt9dvcuhur3HRbtBzfBYZB60GNI
	xp/mGiamv8juQ09PM58QdEaXzyrpDydiMKd7VvOnt25qCFdbkbtRAxzzn6nd0Dqg0lUJYAL/S+a
	VqyktfJ//LKYfhq5PqFFgaGwr57HEk6g==
X-Google-Smtp-Source: AGHT+IFf54WC2Uf++sWgay3sGNYG9nzxh5bQFeAeRu/9OkjQp9eqwqxV99cKveK7+HnvOOQH779Igw==
X-Received: by 2002:a05:600c:524f:b0:477:54b3:3478 with SMTP id 5b1f17b1804b1-4776bc86518mr28366765e9.8.1762532016729;
        Fri, 07 Nov 2025 08:13:36 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4776bd087b1sm66665955e9.16.2025.11.07.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:13:36 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] nvmem: airoha: Add support for SMC eFUSE
Date: Fri,  7 Nov 2025 17:13:22 +0100
Message-ID: <20251107161325.2309275-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107161325.2309275-1-ansuelsmth@gmail.com>
References: <20251107161325.2309275-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for SMC eFUSE on AN7581 SoC. The SoC have 2 set of 2048 bits of
eFUSE that are used to read calibration value for PCIe, Thermal, USB and
other specific info of the SoC like revision and HW device present.

eFuse value are taken by sending SMC command. ATF is responsible of
validaing the data and rejecting reading protected data (like Private
Key). In such case the SMC command will return non-zero value on a0
register.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/nvmem/Kconfig             |  13 ++++
 drivers/nvmem/Makefile            |   2 +
 drivers/nvmem/airoha-smc-efuses.c | 118 ++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/nvmem/airoha-smc-efuses.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index bf47a982cf62..c2de26977c95 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -28,6 +28,19 @@ source "drivers/nvmem/layouts/Kconfig"
 
 # Devices
 
+config NVMEM_AIROHA_SMC_EFUSES
+	tristate "Airoha SMC eFuse support"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on HAVE_ARM_SMCCC
+	default ARCH_AIROHA
+	help
+	  Say y here to enable support for reading eFuses on Airoha AN7581
+	  SoCs. These are e.g. used to store factory programmed
+	  calibration data required for the PCIe or the USB-C PHY or Thermal.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called nvmem-airoha-smc-efuses.
+
 config NVMEM_AN8855_EFUSE
 	tristate "Airoha AN8855 eFuse support"
 	depends on MFD_AIROHA_AN8855 || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 7252b8ec88d4..f6f2bc51dee1 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -10,6 +10,8 @@ nvmem_layouts-y			:= layouts.o
 obj-y				+= layouts/
 
 # Devices
+obj-$(CONFIG_NVMEM_AIROHA_SMC_EFUSES)	+= nvmem-airoha-smc-efuses.o
+nvmem-airoha-smc-efuses-y 		:= airoha-smc-efuses.o
 obj-$(CONFIG_NVMEM_AN8855_EFUSE)	+= nvmem-an8855-efuse.o
 nvmem-an8855-efuse-y 			:= an8855-efuse.o
 obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
diff --git a/drivers/nvmem/airoha-smc-efuses.c b/drivers/nvmem/airoha-smc-efuses.c
new file mode 100644
index 000000000000..bb279d149519
--- /dev/null
+++ b/drivers/nvmem/airoha-smc-efuses.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#define AIROHA_SMC_EFUSE_FID		0x82000001
+#define AIROHA_SMC_EFUSE_SUB_ID_READ	0x44414552
+
+#define AIROHA_EFUSE_CELLS		64
+
+struct airoha_efuse_bank_priv {
+	u8 bank_index;
+};
+
+static int airoha_efuse_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	struct regmap *regmap = context;
+
+	return regmap_bulk_read(regmap, offset,
+				val, bytes / sizeof(u32));
+}
+
+static int airoha_efuse_reg_read(void *context, unsigned int offset,
+				 unsigned int *val)
+{
+	struct airoha_efuse_bank_priv *priv = context;
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(AIROHA_SMC_EFUSE_FID,
+			     AIROHA_SMC_EFUSE_SUB_ID_READ,
+			     priv->bank_index, offset, 0, 0, 0, 0, &res);
+
+	/* check if SMC reported an error */
+	if (res.a0)
+		return -EIO;
+
+	*val = res.a1;
+	return 0;
+}
+
+static const struct regmap_config airoha_efuse_regmap_config = {
+	.reg_read = airoha_efuse_reg_read,
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int airoha_efuse_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	for_each_child_of_node_scoped(dev->of_node, child) {
+		struct nvmem_config airoha_nvmem_config = {
+			.name = "airoha-efuse",
+			.size = AIROHA_EFUSE_CELLS * sizeof(u32),
+			.stride = sizeof(u32),
+			.word_size = sizeof(u32),
+			.reg_read = airoha_efuse_read,
+		};
+		struct airoha_efuse_bank_priv *priv;
+		struct nvmem_device *nvmem;
+		struct regmap *regmap;
+		u32 bank;
+
+		ret = of_property_read_u32(child, "reg", &bank);
+		if (ret)
+			return ret;
+
+		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+		if (!priv)
+			return -ENOMEM;
+
+		priv->bank_index = bank;
+
+		regmap = devm_regmap_init(dev, NULL, priv,
+					  &airoha_efuse_regmap_config);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+
+		airoha_nvmem_config.priv = regmap;
+		airoha_nvmem_config.dev = dev;
+		airoha_nvmem_config.id = bank;
+		nvmem = devm_nvmem_register(dev, &airoha_nvmem_config);
+		if (IS_ERR(nvmem))
+			return PTR_ERR(nvmem);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id airoha_efuse_of_match[] = {
+	{ .compatible = "airoha,an7581-efuses", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, airoha_efuse_of_match);
+
+static struct platform_driver airoha_efuse_driver = {
+	.probe = airoha_efuse_probe,
+	.driver = {
+		.name = "airoha-efuse",
+		.of_match_table = airoha_efuse_of_match,
+	},
+};
+module_platform_driver(airoha_efuse_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for Airoha SMC eFUSEs");
+MODULE_LICENSE("GPL");
-- 
2.51.0


