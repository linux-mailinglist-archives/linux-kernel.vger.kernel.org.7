Return-Path: <linux-kernel+bounces-751116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0F0B1656A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342FA1AA35DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC402DECD6;
	Wed, 30 Jul 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0HqWsEpp"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52132DECD4;
	Wed, 30 Jul 2025 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896192; cv=none; b=CSnsYMxeaoN1/gQHQq8Ng3buhqRR3QZxmoqas4u0yH0ZjaRNAGex4AkzQOMcOTYoIt5V+P9HnUywOoXUvjQlVwWWq2wwqVOfhGsuNIeyGu8N7iqMwpeXKWKaCKkpmi2AOnA/ab9vd4Lkg4jhaL9iiTp4U2Oj03HysJQJUmIXwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896192; c=relaxed/simple;
	bh=fcQatGkLQTr442eBCsTf6Sj7AxhZRDvUiMo1ybgpxVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTDWsMrXN2aaXYGprQMnq/dSjmk12Z4EhC9R/2Zjzzzjkih/b9mmM2AIDr11cphsEt4fUdUEP/s4Gonma5ec3WWqK9GIYUYHxPetI4gelwxtFY6vnB8dDU5TMeQEPhQjFj7oHupRm/p4IJvQkIUB1vzTQALVkZecSB+Lr1B9Uwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0HqWsEpp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=/EAN/+etvQisP+dIWJJSEsjYmf1s9wXpYrOfMl11APA=; b=0HqWsEppoOWpFOag26xBQkwC0h
	9cB6O7VI6uZs2lj+U7EPvtBBpWPci7cTokyzhOjmLlCMkX2NG/67FjDIhvqHHs3SarccmzNkGXObL
	DRtYwJp3P8VFWnRXkAnGioKPJegZ1HAdkt9q/c39Qj46dlNpHyc1I57N2+/cch+/1Zj9kLg6VnhKl
	0gmAUlollZkwIe6Tfii/j6FYeKeztKhp6mDntuG3CNMtnhpBz8Y6hTl8a8ojZiHLJIKuIm9Ielr/d
	TqAU7Cs5gLU5UmdFalY+5/GNTvCVdQmpP/++Yi9P/ryrkH1BenYBr2N+Eyp3Jy/cXh80mR8z900HG
	rJ1Q1clA==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uhAWC-0001Xq-Sj; Wed, 30 Jul 2025 19:23:08 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvmem: add driver for the eeprom in qnap-mcu controllers
Date: Wed, 30 Jul 2025 19:22:48 +0200
Message-ID: <20250730172248.1875122-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730172248.1875122-1-heiko@sntech.de>
References: <20250730172248.1875122-1-heiko@sntech.de>
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
---
 drivers/mfd/qnap-mcu.c          |   1 +
 drivers/nvmem/Kconfig           |   9 +++
 drivers/nvmem/Makefile          |   2 +
 drivers/nvmem/qnap-mcu-eeprom.c | 110 ++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 drivers/nvmem/qnap-mcu-eeprom.c

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 6ed020206e55..e942ead9e515 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -346,6 +346,7 @@ static const struct qnap_mcu_variant qnap_ts433_mcu = {
 };
 
 static struct mfd_cell qnap_mcu_cells[] = {
+	{ .name = "qnap-mcu-eeprom", },
 	{ .name = "qnap-mcu-input", },
 	{ .name = "qnap-mcu-leds", },
 	{ .name = "qnap-mcu-hwmon", }
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d370b2ad11e7..b3975488a5aa 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -265,6 +265,15 @@ config NVMEM_QCOM_SEC_QFPROM
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
index 2021d59688db..21b3ae1c57e8 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -54,6 +54,8 @@ obj-$(CONFIG_NVMEM_QCOM_QFPROM)		+= nvmem_qfprom.o
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


