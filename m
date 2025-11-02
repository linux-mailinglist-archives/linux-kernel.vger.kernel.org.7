Return-Path: <linux-kernel+bounces-881892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD0C2928F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6319E188D8AD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BAA2C0F66;
	Sun,  2 Nov 2025 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="z2z5EMKf"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B052673BA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101618; cv=none; b=bGWWpKIJSAa9gbbaBG+0Sw6et94ee+9lyDgJBWJDMqbeV0kR/XM37xlsTBuXBXZy68LzIDmxDY0fbeatnk6wK3YsJ9CodttXTndH8ygmOFnijn1vnKYvosjYvcgcmD2u76XhN0B6kNtj6Si9/AEvUKD3HhbclWsmxWCIgZnCIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101618; c=relaxed/simple;
	bh=POtEYhJgeAkV5rLs+DnmX2QZSf274NNiplmY3Q+gaf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWSRqDaQNeM0TfYZS6rnvNhB+k7Yp+KwEvN+Z2rQTgkkkD+CQ4a67jQvEIW7zuafZs1EUwJYv5mrELVt/tlSjrgDzQlt1MXr41/N7XLaQxix0r1XtqOd9mTlAwlUAY4OXsJTvOYsjolPkfvhyDZugyupGJ0unlv5JsO6SMwTGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=z2z5EMKf; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=dg1qN/XjhdzQqyoI2H1Gp1MZtWfUSesepE+UK+cO1vk=; b=z2z5EMKf7cgUXDCfgnHLuFpP8i
	3/D9E0t4kEcin7Kw19t+KefVcjl2BwS4OaOj/sYyb18JTFWeqJi2yNHwng+Po2N3lc5u36457+pPt
	u5eXuft72eS/5yhpbAaotvg73hXcz6cKrVEbWqGLfgY2nqm7pV5UI0RRRb0WmJxpWzqn31TW/8wqK
	imCeOWJUAtLK4uxWgrnnukx3B1UVy0e3x1jG8X87xY7NZoXjw259T+RhD8Jk5qUblkK10jIBhVMQd
	ZZ1E3m7Cga65n/Nu7512ThV0vYYTbNMp/DFzlso9nfCV6cpqaXKiWN+XOK1Nd6nvC4l1s0q8GQoT6
	QUZ7l2mA==;
Received: from i53875ba9.versanet.de ([83.135.91.169] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vFb7f-0003Q7-NE; Sun, 02 Nov 2025 17:40:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] nvmem: Add driver for the eeprom in qnap-mcu controllers
Date: Sun,  2 Nov 2025 17:39:54 +0100
Message-ID: <20251102163955.294427-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251102163955.294427-1-heiko@sntech.de>
References: <20251102163955.294427-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qnap-mcu also has an eeprom connected to it, that contains some
specific product-information like the mac addresses for the network
interfaces.

Add a nvmem driver for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/Kconfig           |   9 +++
 drivers/nvmem/Makefile          |   2 +
 drivers/nvmem/qnap-mcu-eeprom.c | 110 ++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/nvmem/qnap-mcu-eeprom.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index e0d88d3199c1..bf47a982cf62 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -285,6 +285,15 @@ config NVMEM_QCOM_SEC_QFPROM
           This driver can also be built as a module. If so, the module will be called
           nvmem_sec_qfprom.
 
+config NVMEM_QNAP_MCU_EEPROM
+	tristate "QNAP MCU EEPROM Support"
+	depends on MFD_QNAP_MCU
+	help
+	  Say y here to enable support for accessing the EEPROM attached to
+	  QNAP MCU devices. This EEPROM contains additional runtime device
+	  information, like MAC addresses for ethernet devices that do not
+	  contain their own mac storage.
+
 config NVMEM_RAVE_SP_EEPROM
 	tristate "Rave SP EEPROM Support"
 	depends on RAVE_SP_CORE
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 70a4464dcb1e..7252b8ec88d4 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -56,6 +56,8 @@ obj-$(CONFIG_NVMEM_QCOM_QFPROM)		+= nvmem_qfprom.o
 nvmem_qfprom-y				:= qfprom.o
 obj-$(CONFIG_NVMEM_QCOM_SEC_QFPROM)	+= nvmem_sec_qfprom.o
 nvmem_sec_qfprom-y			:= sec-qfprom.o
+obj-$(CONFIG_NVMEM_QNAP_MCU_EEPROM)	+= nvmem-qnap-mcu-eeprom.o
+nvmem-qnap-mcu-eeprom-y			:= qnap-mcu-eeprom.o
 obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
 obj-$(CONFIG_NVMEM_RCAR_EFUSE)		+= nvmem-rcar-efuse.o
diff --git a/drivers/nvmem/qnap-mcu-eeprom.c b/drivers/nvmem/qnap-mcu-eeprom.c
new file mode 100644
index 000000000000..fea1e7b91764
--- /dev/null
+++ b/drivers/nvmem/qnap-mcu-eeprom.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ee1004 - driver for DDR4 SPD EEPROMs
+ *
+ * Copyright (C) 2017-2019 Jean Delvare
+ *
+ * Based on the at24 driver:
+ * Copyright (C) 2005-2007 David Brownell
+ * Copyright (C) 2008 Wolfram Sang, Pengutronix
+ */
+
+#include <linux/mfd/qnap-mcu.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+
+/* Determined by trial and error until read anomalies appeared */
+#define QNAP_MCU_EEPROM_SIZE		256
+#define QNAP_MCU_EEPROM_BLOCK_SIZE	32
+
+static int qnap_mcu_eeprom_read_block(struct qnap_mcu *mcu, unsigned int offset,
+				      void *val, size_t bytes)
+{
+	const u8 cmd[] = { 0xf7, 0xa1, offset, bytes };
+	u8 *reply;
+	int ret = 0;
+
+	reply = kzalloc(bytes + sizeof(cmd), GFP_KERNEL);
+	if (!reply)
+		return -ENOMEM;
+
+	ret = qnap_mcu_exec(mcu, cmd, sizeof(cmd), reply, bytes + sizeof(cmd));
+	if (ret)
+		goto out;
+
+	/* First bytes must mirror the sent command */
+	if (memcmp(cmd, reply, sizeof(cmd))) {
+		ret = -EIO;
+		goto out;
+	}
+
+	memcpy(val, reply + sizeof(cmd), bytes);
+
+out:
+	kfree(reply);
+	return ret;
+}
+
+static int qnap_mcu_eeprom_read(void *priv, unsigned int offset, void *val, size_t bytes)
+{
+	struct qnap_mcu *mcu = priv;
+	int pos = 0, ret;
+	u8 *buf = val;
+
+	if (unlikely(!bytes))
+		return 0;
+
+	while (bytes > 0) {
+		size_t to_read = (bytes > QNAP_MCU_EEPROM_BLOCK_SIZE) ?
+						QNAP_MCU_EEPROM_BLOCK_SIZE : bytes;
+
+		ret = qnap_mcu_eeprom_read_block(mcu, offset + pos, &buf[pos], to_read);
+		if (ret < 0)
+			return ret;
+
+		pos += to_read;
+		bytes -= to_read;
+	}
+
+	return 0;
+}
+
+static int qnap_mcu_eeprom_probe(struct platform_device *pdev)
+{
+	struct qnap_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
+	struct nvmem_config nvcfg = {};
+	struct nvmem_device *ndev;
+
+	nvcfg.dev = &pdev->dev;
+	nvcfg.of_node = pdev->dev.parent->of_node;
+	nvcfg.name = dev_name(&pdev->dev);
+	nvcfg.id = NVMEM_DEVID_NONE;
+	nvcfg.owner = THIS_MODULE;
+	nvcfg.type = NVMEM_TYPE_EEPROM;
+	nvcfg.read_only = true;
+	nvcfg.root_only = false;
+	nvcfg.reg_read = qnap_mcu_eeprom_read;
+	nvcfg.size = QNAP_MCU_EEPROM_SIZE,
+	nvcfg.word_size = 1,
+	nvcfg.stride = 1,
+	nvcfg.priv = mcu,
+
+	ndev = devm_nvmem_register(&pdev->dev, &nvcfg);
+	if (IS_ERR(ndev))
+		return PTR_ERR(ndev);
+
+	return 0;
+}
+
+static struct platform_driver qnap_mcu_eeprom_driver = {
+	.probe = qnap_mcu_eeprom_probe,
+	.driver = {
+		.name = "qnap-mcu-eeprom",
+	},
+};
+module_platform_driver(qnap_mcu_eeprom_driver);
+
+MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
+MODULE_DESCRIPTION("QNAP MCU EEPROM driver");
+MODULE_LICENSE("GPL");
-- 
2.47.2


