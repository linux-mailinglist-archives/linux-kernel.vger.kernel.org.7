Return-Path: <linux-kernel+bounces-609824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91CAA92C20
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 22:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B993B16C676
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5720A5CB;
	Thu, 17 Apr 2025 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u61sfBLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FFD20408A;
	Thu, 17 Apr 2025 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920894; cv=none; b=NT1tBQbC6vvRJQovT9WzKFGhyE1IPWoCHwjR9zKedgCZCjcYCrF2miE2qZT0BUX1Uhyi5IsR+vjU7JMW3kZP0/Q6M9sBNumvV2msYadEYcEGgddgJUyihJN8bOqViQ7q2bzFjKgVDwA+pTBqUe8IBpRbwZe0aNNMOA/2B/E/Evg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920894; c=relaxed/simple;
	bh=VtNJxmhsI2s39FgW3VY4pSVvAt5jJYa2aFza7f+ewM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOluyp2v7cc6Pz9wp6Vwe+FlbUkyhEVKrpbi+KkyBuslITnkPCFF5SxZNx6lURurigUY0IHxuovWJWQYrXj/I7iX/IQvz6l+INb4PeiZ3vTB4dML5vIN8fMZboPxmNyp8duce3qM+vGFdhJI4cWwo/2zrd08dAuC86hmt922cnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u61sfBLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4627C4CEE7;
	Thu, 17 Apr 2025 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744920893;
	bh=VtNJxmhsI2s39FgW3VY4pSVvAt5jJYa2aFza7f+ewM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u61sfBLnkFbVfo//3Npl2efxEIChuX9BNhuGj/kF8i3KeN9nkqNbaP8ngKuY/YXZv
	 Ckzgm1M7k9GkEd33UtGT+bZ440U4YSnLzVBEn+nsxe0JV/vZg+lSN8g/cofZq0jJ1p
	 C8yRrXE06iKfBuSXLTkFZNnhfIm6NlvsWbChdCOk+nrq3TvFSYVDSw+2aDbQ/RWovm
	 gGZtlml5+yIVhE4y291bz1Gv8FgxEUaRrCGqDuaS2xc4d6Np0WRMmMRyDedCcvBCjQ
	 Nv2Rt6zm6nXW3JZT20sPUBDdcB7+Tzid8xDBahurXJHoR5/zw7nh6GHPuv/5RlD4vI
	 OwE8SdK5KZEeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBCDC369D0;
	Thu, 17 Apr 2025 20:14:53 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Thu, 17 Apr 2025 22:14:50 +0200
Subject: [PATCH v2 2/3] nvmem: Add spmi-nvmem driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-spmi-nvmem-v2-2-b88851e34afb@gmail.com>
References: <20250417-spmi-nvmem-v2-0-b88851e34afb@gmail.com>
In-Reply-To: <20250417-spmi-nvmem-v2-0-b88851e34afb@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744920892; l=4485;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=QxvKeCxMx0fhrb/mzZRj0aBarxG7UUKFK3NomXpfiRA=;
 b=T/XlRbf/iR6QeRjUc4OpBst1lMVqTc3/dcAAYKyRb3CFRagS9Kjvzn0fA67TcIbYgQTpI171o
 sxVCLUf2f/ODsbmtkXPcojhHWWqfgud+omcttBWrXAx3spi9TM3Oqhr
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Hector Martin <marcan@marcan.st>

This driver exposes a SPMI device as an NVMEM device.
It is intended to be used with e.g. PMUs/PMICs that are used to
hold power management configuration, such as used on Apple Silicon
Macs.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Co-developed-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS                |  1 +
 drivers/nvmem/Kconfig      | 13 ++++++++++
 drivers/nvmem/Makefile     |  2 ++
 drivers/nvmem/spmi-nvmem.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7b2d0df81b387ba5398957131971588dc7b89dc..63c12f901aed1f3e6de8227d6db34af1bd046fe6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2298,6 +2298,7 @@ F:	drivers/iommu/io-pgtable-dart.c
 F:	drivers/irqchip/irq-apple-aic.c
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
+F:	drivers/nvmem/spmi-nvmem.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
 F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 8671b7c974b933e147154bb40b5d41b5730518d2..c25c599fc79648e890ccc4e003224c9a218f393f 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -310,6 +310,19 @@ config NVMEM_SNVS_LPGPR
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-snvs-lpgpr.
 
+config NVMEM_SPMI
+	tristate "Generic SPMI NVMEM"
+	depends on SPMI
+	select REGMAP_SPMI
+	help
+	  Say y here to build a generic driver to expose a SPMI device
+	  as a NVMEM provider. This can be used for PMIC/PMU devices which
+	  are used to store power and RTC-related settings on certain
+	  platforms, such as Apple Silicon Macs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-spmi.
+
 config NVMEM_SPMI_SDAM
 	tristate "SPMI SDAM Support"
 	depends on SPMI
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 5b77bbb6488bf89bfb305750a1cbf4a6731a0a58..b639f4284184db026bb27b11e04d54b8f7ff166f 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -64,6 +64,8 @@ obj-$(CONFIG_NVMEM_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
 nvmem-sc27xx-efuse-y			:= sc27xx-efuse.o
 obj-$(CONFIG_NVMEM_SNVS_LPGPR)		+= nvmem_snvs_lpgpr.o
 nvmem_snvs_lpgpr-y			:= snvs_lpgpr.o
+obj-$(CONFIG_NVMEM_SPMI)		+= nvmem_spmi.o
+nvmem_spmi-y				:= spmi-nvmem.o
 obj-$(CONFIG_NVMEM_SPMI_SDAM)		+= nvmem_qcom-spmi-sdam.o
 nvmem_qcom-spmi-sdam-y			+= qcom-spmi-sdam.o
 obj-$(CONFIG_NVMEM_SPRD_EFUSE)		+= nvmem_sprd_efuse.o
diff --git a/drivers/nvmem/spmi-nvmem.c b/drivers/nvmem/spmi-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..fff6162cb22dd7ab45883f004f5b63ebae014698
--- /dev/null
+++ b/drivers/nvmem/spmi-nvmem.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Generic SPMI NVMEM driver
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/spmi.h>
+#include <linux/regmap.h>
+
+static const struct regmap_config spmi_regmap_config = {
+	.reg_bits	= 16,
+	.val_bits	= 8,
+	.max_register	= 0xffff,
+};
+
+static int spmi_nvmem_probe(struct spmi_device *sdev)
+{
+	struct regmap *regmap;
+	struct nvmem_config nvmem_cfg = {
+		.dev = &sdev->dev,
+		.name = "spmi_nvmem",
+		.id = NVMEM_DEVID_AUTO,
+		.word_size = 1,
+		.stride = 1,
+		.size = 0xffff,
+		.reg_read = (void *)regmap_bulk_read,
+		.reg_write = (void *)regmap_bulk_write,
+	};
+
+	regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	nvmem_cfg.priv = regmap;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(&sdev->dev, &nvmem_cfg));
+}
+
+static const struct of_device_id spmi_nvmem_id_table[] = {
+	{ .compatible = "spmi-nvmem" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, spmi_nvmem_id_table);
+
+static struct spmi_driver spmi_nvmem_driver = {
+	.probe = spmi_nvmem_probe,
+	.driver = {
+		.name = "spmi-nvmem",
+		.of_match_table	= spmi_nvmem_id_table,
+	},
+};
+
+module_spmi_driver(spmi_nvmem_driver);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_DESCRIPTION("SPMI NVMEM driver");

-- 
2.49.0



