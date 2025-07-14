Return-Path: <linux-kernel+bounces-730335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F305B04349
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEC2176C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926125EF87;
	Mon, 14 Jul 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap8pjAbl"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C4259C84;
	Mon, 14 Jul 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506064; cv=none; b=k5mEvIc23yBh60F7Ht7hc/QbSXiRMNwyOJ+l+x8HHuEP2K5C5Y+gL/AdYYUtKLpbhuxbB059vN+fPNUAjVMKbhp+xaNPdg1bHdQqAA1ZD8ZP16jvt+58FjSfvli0esobMrI9dQ1PggY1pW71PRBStAyKj0taVU3fQT4AsNjCo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506064; c=relaxed/simple;
	bh=bNA+Vw2JxlzycwGOS5vCv7StcjApy7+aocVwxhSM6RY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kChBLQ1jSN/MGt98wweSbeYporNl9HXQHUyuPFsLESYM5NyOTWZxFj1GWC1T2IgL9foesyBDafWaZVXbyFPANqn6PN8/kit5Hbsc8C5XHx0yK8jUSSrh8gdRrQxSzal9eML2MPILI7xPJXNhJd3OV1Ztiz7N66AdlaWslY7+8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap8pjAbl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so2918887f8f.0;
        Mon, 14 Jul 2025 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752506061; x=1753110861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IwAkpj3u5SIj9r6ALm0AsPoMzzkkW8yohb+3OrBJPY=;
        b=ap8pjAblFjH3Ubwq2XYJOoaajZUg867+wDO6hzEjJGoawaCzlw+pp1yMAeil/lSM9k
         k9C6j2+2ibzqepyrqmm95kQWstgdi9TExxZdNso86qZx+C+g3wVthB6DxrIKXNlnExuk
         x1VH+Ul/K76HxmFu/qqxWTKwqCjg0imA/gS+WjVJDURfFTT/f1DSNVcVgq726ldpF18j
         RNZDFb+ZICjmORx665SOPjoPgUPjfB0jOuBawkjcSj118WRmE3gHun3Q3faRD3RTCCrs
         QjtEy1BgiGxaoySXIAx3+kiwBJCvymdzbqcZiLrDT5LEJe2KZYcBQeVI+JII/1hOWADD
         KNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506061; x=1753110861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IwAkpj3u5SIj9r6ALm0AsPoMzzkkW8yohb+3OrBJPY=;
        b=E2geat6miBaQ8HNlUy+gwmgdCuiZDBgtMumvR1uI+2DNpRiIAoJNtqpKur0Rp3gBGF
         HQ3TcgHHP4ngRB4P4MbzhFijy+C8EyDnihE479sQYOBJkqJU5jUytufxB682VZ6iIWkY
         Gj0iKj93fVrhMDc12+6pcbrgOXL3ZSi0NoTNBuaZlUNdbRe+kkpwQf5isNyen5ns6RrN
         cWq9IZNybp2ujLBh1NJjaSVIOA/Y9DUBojYIDBVVxIApNmZbucL/LzAgKUwbZ3vGOIHD
         JXtInZL4fnEy5nrhlrSQTBMdPGpPjsjp05otqepiuVprkeEzyD62YAec4pyhpFoDQni8
         paoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxCzqq3jCbgw+DfLuT434YknHmo/1oHE4HLxvF4Q5fwnGfWDQTZEFLSupzMf7+35hishjjVM0EJc0P@vger.kernel.org, AJvYcCVkYfzfvHoa2WtYuFM0WnWfy0xcA6Krr9qBNL++Ja1FMDmcXYXek3kaC5hWlVI+XJq4xin4L+hYeOwKyqVz@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmNgoHE9rwIR60VU5vB2r/xBOQTzLbsouX76n6d3EO4rQIjrf
	cJzMsaY8fha/qi1/XR/0QVNcMDcfwZk6ICtIkVXKRRJzZILcYZtwc+rG
X-Gm-Gg: ASbGncsBK0CJ4/HmnMvtTRbUfbNGcWFIcPw0yjsoif+PiXAVEgOK2lIE84XLRQDl87o
	u2tSxxAVpFNHCemgDNsdTm828VMPsawV3/IZq67bq71Vw0TGPWyAG6YUONSTP0p04C7OID4j1zr
	hvRzst++5oDKfVrhL+8mf7NuAkay55Pok/ZteI8CbgH2PkWm4b+YUWcU+CEFB95bPHvVQGLqRWB
	PEPypPrxWkLvDlrv7SPlDR+RZueALZI5c2rXp/rOvewGuymntWOaoYfocFNyBzruRdYYu9Gw+ga
	nPq3MMW2R4GVb4lvZNcidg0cf3Y+1D7mPPPFvMJTTTQM3jJYbqdGbc46pBXqnApA5nKNCZZGAWL
	wPfdWi9AKfaNoeQn3Wi0+uMyGP2zf9kshz0ZgL+F9BVK1hHRNlwq6H4hfzTr7g/CBWl5OctujDL
	WWVFi4A/TjWO3J
X-Google-Smtp-Source: AGHT+IFjuvW9ez9GPecW/30EfrD4uF8071VqI6MJtbXRlpmCdQrC3iHMuCAqYg5JiO/uCEzM22mMOQ==
X-Received: by 2002:a5d:5c0e:0:b0:3a5:7895:7f6b with SMTP id ffacd0b85a97d-3b5f1c72366mr11697431f8f.7.1752506060755;
        Mon, 14 Jul 2025 08:14:20 -0700 (PDT)
Received: from localhost.localdomain (host-212-171-170-230.retail.telecomitalia.it. [212.171.170.230])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26f3asm12872427f8f.98.2025.07.14.08.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:14:20 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvmem: airoha: Add support for SMC eFUSE
Date: Mon, 14 Jul 2025 17:13:47 +0200
Message-ID: <20250714151349.28368-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714151349.28368-1-ansuelsmth@gmail.com>
References: <20250714151349.28368-1-ansuelsmth@gmail.com>
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
index 8671b7c974b9..5c44576d7457 100644
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
 config NVMEM_APPLE_EFUSES
 	tristate "Apple eFuse support"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 5b77bbb6488b..77c0264f7d39 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -10,6 +10,8 @@ nvmem_layouts-y			:= layouts.o
 obj-y				+= layouts/
 
 # Devices
+obj-$(CONFIG_NVMEM_AIROHA_SMC_EFUSES)	+= nvmem-airoha-smc-efuses.o
+nvmem-airoha-smc-efuses-y 		:= airoha-smc-efuses.o
 obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 			:= apple-efuses.o
 obj-$(CONFIG_NVMEM_BCM_OCOTP)		+= nvmem-bcm-ocotp.o
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
2.48.1


