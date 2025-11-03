Return-Path: <linux-kernel+bounces-883779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB9C2E66A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3553B899F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7472FF64B;
	Mon,  3 Nov 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xDnFextq"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452227FB34
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212598; cv=none; b=TSoutNOAVGvzkXypfaIKuRcmZMRHv9tdDP0h7eoJox9sJj6LmZclOHjfBOqOoSLtFop1A6V5rxK9NVIpybSWZxzLoakH2jejWmywYTYGFGgyF0cCjyJH5tQLtAOub8O7Lfzf/OU0w5Xw38xkFLC0dEFo4KA7RT4jy7lMvc8EPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212598; c=relaxed/simple;
	bh=vXGcGn58vWdXedDJLRaiFyhiM6JKzmGMNBIqv3t86wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv32FfgX1Lf7SNgoT54wIuah75PEdr4R3ipDmp2bfkY4y4Ul3XHssLtPiI/thRzMzKOOYZnaAx1aF0YS83FD/WqoLt6Nw7tQkmhIdjPqkxwv07iRzk21H+mrbBi2HMPOHbI+yUKqujYsa8wuWYcvItpbdq06aaMlJTyu4DeYbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xDnFextq; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=11i3Z5YPaobAbC+fYmMd/zEgSFa2BqMyQg1J80qqwww=; b=xDnFextqlA9oycxDGWTG084N73
	CDEDcpmEp4Jn0RLOfSp1AY8BEAOQyryJ26Qym5+AmM0nZsuohgwvkrRYtKrf3BYwwEiDi9BLsj7rt
	lRUFywZb3YoXjNuiLYQhMuyb+ur5Ae7oIw5BxiNXqlFyfyxMhK5GnLp8biGFwNOf6bTkbNckuHwE9
	Yv3fJs2wXWZqSlpdBmMUz1kTZAnO4cKXybiDQaW27cf/L8Y3ey3eiVPws8VbrQ7R35mOGU65GXsoD
	AjgR8VHzkPtiRPIVEbtE5RWTd01tz4Bmrr9KPdId4PNl///j5H+AxMSmJtLB4qzrPGo/ggzjhJZR+
	TgVFTccw==;
Received: from i53875a3a.versanet.de ([83.135.90.58] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vG3zh-0007mj-Cy; Tue, 04 Nov 2025 00:29:49 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] nvmem: Add driver for the eeprom in qnap-mcu controllers
Date: Tue,  4 Nov 2025 00:29:41 +0100
Message-ID: <20251103232942.410386-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251103232942.410386-1-heiko@sntech.de>
References: <20251103232942.410386-1-heiko@sntech.de>
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
 drivers/nvmem/qnap-mcu-eeprom.c | 111 ++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
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
index 000000000000..0b919895b3b2
--- /dev/null
+++ b/drivers/nvmem/qnap-mcu-eeprom.c
@@ -0,0 +1,111 @@
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
+#include <linux/slab.h>
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


