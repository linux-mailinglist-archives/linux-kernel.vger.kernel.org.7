Return-Path: <linux-kernel+bounces-616872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE483A9973D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 19:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264611B64F26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D828D82D;
	Wed, 23 Apr 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db/ZJCXj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF027990F;
	Wed, 23 Apr 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430930; cv=none; b=iQroFg6LGsoxSmu9tgFRT3KXeTjt7Q3xhkv5gXokIoKrMYAB4q0Ih1noxU4aMBGJ+Nmi1gIM2tg0SZaPejCzIwgQICFbIz53mjRMN7BzqM2pX7tTK/8M3tfpi7E8eBCP0UWhfeeGiNhUUGzr21pAeLwzOkBe7hvBoolVWf+sQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430930; c=relaxed/simple;
	bh=4LP5yesRqA8jPtdTSc+y65wvh0vzBZCYBvOX2bu7xdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ay0fCkaiUzSl2mRtLiVgay6lqoDPzzreNJJe04AAxgHv+fghXyqUcFt83FCxDBl6tG+THM7GQGOn/wIvp+E8cEbVDw/ooBbM+Bdjcz/oHBg03wClRlizn5bUnSIA5fIS3+fxb3Pkd7jDsHdmcjbyAfTlMv8rlZMuW72Cf0IJd0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db/ZJCXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11690C4CEEB;
	Wed, 23 Apr 2025 17:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745430930;
	bh=4LP5yesRqA8jPtdTSc+y65wvh0vzBZCYBvOX2bu7xdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=db/ZJCXjIqigEGUk28BcxxlpY7Y2Ur0DXLeJk8K6mHx8p4E4XSgUU6pa5WqaDMt0k
	 qhmiZUxDt+ULWFgs0fbwuulEuWzR7ZZlhJ37EcDJpjX48TYHqqoZgsr1TkoKnrOw6O
	 bal/VI9tgUE2ZBbLShzKcFqolYfroEsrYgO9Rap3DTt7upVALbGddcZMJD3XY31BRL
	 hI/wAqHl5XRhIKcxCtr8nTik6WD9sdnfoww4fKNqgx3QcSswBhEqy0d7Un21AGhcVM
	 fo1aXWobxxEH2uXhq4qPh9uGI0lBa0Z3luk6tUz6v7lhqiSh1ouKfXb5Z01CBKn5J9
	 YGym26MIwrGXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB6C369D8;
	Wed, 23 Apr 2025 17:55:30 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Wed, 23 Apr 2025 19:55:14 +0200
Subject: [PATCH v3 2/3] nvmem: Add apple-spmi-nvmem driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-spmi-nvmem-v3-2-2985aa722ddc@gmail.com>
References: <20250423-spmi-nvmem-v3-0-2985aa722ddc@gmail.com>
In-Reply-To: <20250423-spmi-nvmem-v3-0-2985aa722ddc@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745430928; l=4524;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=E0YgVY1kIyVeZiBL29ovgAQLgKsalQU9HAAOahuulyE=;
 b=Tw30Fla+GgRpLdqYeL9wnOiZbN1TCxK6IbF+3fR4dTb6FPo9nn33vTQQplSMNy7iXthYDT0TZ
 1GidhyhO98QDClW2fzV4wid0Y6gG9uVUPvR4soMhNW0KLz1EhJgTTwA
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Hector Martin <marcan@marcan.st>

Add a driver for a series of SPMI-attached PMICs present on Apple devices

Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Hector Martin <marcan@marcan.st>
Co-developed-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS                      |  1 +
 drivers/nvmem/Kconfig            | 13 +++++++++
 drivers/nvmem/Makefile           |  2 ++
 drivers/nvmem/apple-spmi-nvmem.c | 62 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f462545c54c55d4bdc22651e07a4c8e155e83016..c9f5ac1eb2458a0206ffe0767cc6ed129172e78f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2298,6 +2298,7 @@ F:	drivers/iommu/io-pgtable-dart.c
 F:	drivers/irqchip/irq-apple-aic.c
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
+F:	drivers/nvmem/apple-spmi-nvmem.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
 F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 8671b7c974b933e147154bb40b5d41b5730518d2..ae4afbd8293c64ea0a3a632c7172f5496545b12c 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -40,6 +40,19 @@ config NVMEM_APPLE_EFUSES
 	  This driver can also be built as a module. If so, the module will
 	  be called nvmem-apple-efuses.
 
+config NVMEM_APPLE_SPMI
+	tristate "Apple SPMI NVMEM"
+	depends on ARCH_APPLE || COMPILE_TEST
+	depends on SPMI
+	select REGMAP_SPMI
+	help
+	  Say y here to build a driver to expose NVMEM cells for a set of power
+	  and RTC-related settings on a SPMI-attached PMIC present on Apple
+	  devices, such as Apple Silicon Macs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called apple-nvmem-spmi.
+
 config NVMEM_BCM_OCOTP
 	tristate "Broadcom On-Chip OTP Controller support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 5b77bbb6488bf89bfb305750a1cbf4a6731a0a58..89a3c252c2c8dad9ed7bc6ac9841f63ff85c00d5 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -12,6 +12,8 @@ obj-y				+= layouts/
 # Devices
 obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 			:= apple-efuses.o
+obj-$(CONFIG_NVMEM_APPLE_SPMI)		+= apple_nvmem_spmi.o
+apple_nvmem_spmi-y			:= apple-spmi-nvmem.o
 obj-$(CONFIG_NVMEM_BCM_OCOTP)		+= nvmem-bcm-ocotp.o
 nvmem-bcm-ocotp-y			:= bcm-ocotp.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)		+= nvmem_brcm_nvram.o
diff --git a/drivers/nvmem/apple-spmi-nvmem.c b/drivers/nvmem/apple-spmi-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..88614005d5ce1dc2d1cafcb89ac66d8376ffcc96
--- /dev/null
+++ b/drivers/nvmem/apple-spmi-nvmem.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple SPMI NVMEM driver
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
+static const struct regmap_config apple_spmi_regmap_config = {
+	.reg_bits	= 16,
+	.val_bits	= 8,
+	.max_register	= 0xffff,
+};
+
+static int apple_spmi_nvmem_probe(struct spmi_device *sdev)
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
+	regmap = devm_regmap_init_spmi_ext(sdev, &apple_spmi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	nvmem_cfg.priv = regmap;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(&sdev->dev, &nvmem_cfg));
+}
+
+static const struct of_device_id apple_spmi_nvmem_id_table[] = {
+	{ .compatible = "apple,spmi-nvmem" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, apple_spmi_nvmem_id_table);
+
+static struct spmi_driver apple_spmi_nvmem_driver = {
+	.probe = apple_spmi_nvmem_probe,
+	.driver = {
+		.name = "apple-spmi-nvmem",
+		.of_match_table	= apple_spmi_nvmem_id_table,
+	},
+};
+
+module_spmi_driver(apple_spmi_nvmem_driver);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_DESCRIPTION("Apple SPMI NVMEM driver");

-- 
2.49.0



