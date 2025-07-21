Return-Path: <linux-kernel+bounces-739769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94230B0CAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F78E540647
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE7D2206BE;
	Mon, 21 Jul 2025 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQhgacvi"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892719CC28;
	Mon, 21 Jul 2025 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753123621; cv=none; b=q4ICTCWVdF5BwRiq0uhrgSbXXdKc4WVEl9Sxbzp5J10YG0mPpBWrdi/MWntkRemKP8xhJM2FOmpfG8/PQk1VBApcqYIXfXUdJHAKgcTQo6QxnESwgkaSXbN9zCX1wwDwOlgwFnH7936rDg8MJVxBJEmBOpMSxsusq/x2oIGa0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753123621; c=relaxed/simple;
	bh=A+zWb0Ocm77XdDuxt1gG4xR03s5X2hsyYXBCIVvtFOg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1Zue2v8+MY1ctWAYU3Jy8FNh7/dYIZCLVohKRtqFO49xuj9xP7q1q0dvRw73tneHctolbxh6nE6sl+MvktGZbfImOQvUnn78nFbVldilvBlSGwdwTXKB24zwpYxvgvVR5FISIm8LnafocWvuzGtetu7znVXsWfFDbEEv7SmCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQhgacvi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so3341677f8f.3;
        Mon, 21 Jul 2025 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753123618; x=1753728418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAKgV0IGhkXD4O93lIPJrR4Rs3xqvFKTOn7JcTVpDOk=;
        b=QQhgacvilBuDvr0ZfutWVazq6jRmEtScnwP7wd6q2MzyumFj/IHDny1GHzzVrNaIqC
         MPC9rwjf6Nm3smuWGjp79VyimukfWD/oecvvSLp130ai+OptO9Dd6R8NDIa6apnmJYK1
         uZ/8fkzxk0Z9puaVqX+Db7VHsZQX3au6hIpM43PHWov2nm4FBm19y9ZfJw2QddvrVWlk
         KYQlJ4asvEPPAL/syw8vygBjx4Y0T/ve3zrQwBUmkM+yhA3BMm5tdM2cgvy4qo+G87RH
         n18lv3laTXuqhmpTpJOKRlIR8nnmyzwAfzh0k+dqqL0TpSbprFNT5qVpICf4Y2N93CND
         hffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753123618; x=1753728418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAKgV0IGhkXD4O93lIPJrR4Rs3xqvFKTOn7JcTVpDOk=;
        b=UNDtKrZ8m3f3e3FzLN7NlCzqyq6qENkfqIIl3ezen1VaHQ4kBKZRS4b4LbJ9cUqNLf
         b5tbPoHdaL7HX4iPwiYw1VYx50TvL0chDQMSImTHfAeiWWxjZ+Dcro0QAWUdmc+TCpTv
         3MgEgNeDx/WTd1t7db45d4Ba+97s4M9UT/FT7GFCp5AP7UoSRZRXNDETzoROFlEvko50
         qbsR79xXwy4yV/sX/Yyeo68yq0v6H4RJ1XmscSclZoa11yGzqRpHwPjlcV2PzBgNNQsH
         YYQu4x/qJ2dUb40OvuYSOgdJtsFpTuxj/ymMaQjC71pLAVMknmIMZxm4VF1DhZMmqgno
         mUaw==
X-Forwarded-Encrypted: i=1; AJvYcCVIJrgIjzEq3MvCnZzricE48uepQwkCQfcZ7zxoUfuT8nqvBz/UGYTypxQfqqhVUZaGNkr8njseMpNz0Yrg@vger.kernel.org, AJvYcCWHvrVXfiqJZUYn3Y0K4daNzxb+pEAyvTmQXVR78xrqAskTmwLI3hYkeYwYGnlRqhkbMaDZ4yz1jEnC@vger.kernel.org
X-Gm-Message-State: AOJu0YxodAwP0EvxVzR67UCk7W2Eiyi2+d5hi+FFADqxR97F32dqVnZ4
	N5k06oHuwXosjpTcpW18O75B1o/aitjLVfX4rHeQ+IutZ84SiLlpHwDq
X-Gm-Gg: ASbGncvTTVNxGKVNagwFvcMzNTYPgY0YQQIJBgiOveyAWkha40v+01lugH9qm3/hseM
	EKuG3jfV6b8X0NeaqRdz9wC9AGmqTrF0wmGAGQcdSxjQvTZrqa7izRRhrI2W3sSjq8/+P36BrXh
	i8h6KuqKhOTdqYz2KKSeAlsZuEMCTGhrvrbWj7PZRaAF9oVupEU1QMUIQvjGSie8jXNChsuUZSD
	ssGsDKUO+hcbSjdsDEUci35aYWrdp2x5+HD1UUIf1CsMcqZ9bByUnFu9f6JUM5dQS96RjwHrKCa
	YYJ63eFlIsUJvFJJp+kWEFwdlZHdACnIpgcfrKyGPcXAXxz9jB9dbolpsz7q6mpy602Zz24Mu5n
	NqVz2CGVZfgxFmfoyOfWM7ag=
X-Google-Smtp-Source: AGHT+IG+oQ0J/zb94CemBBTBhYc6Vc1MH6BwHqesIs3JNU2EjzcKpsIip/B3tDfSgcggI5tV2LlC1w==
X-Received: by 2002:a05:6000:2a0f:b0:3b6:a799:4809 with SMTP id ffacd0b85a97d-3b6a799481fmr5216151f8f.31.1753123617836;
        Mon, 21 Jul 2025 11:46:57 -0700 (PDT)
Received: from Ansuel-XPS24 ([109.52.136.49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca48970sm11437043f8f.57.2025.07.21.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:46:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] nvmem: airoha: Add support for SMC eFUSE
Date: Mon, 21 Jul 2025 20:46:34 +0200
Message-ID: <20250721184640.2885-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250721184640.2885-1-ansuelsmth@gmail.com>
References: <20250721184640.2885-1-ansuelsmth@gmail.com>
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
2.50.0


