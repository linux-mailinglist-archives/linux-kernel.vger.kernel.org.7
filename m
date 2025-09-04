Return-Path: <linux-kernel+bounces-800763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A967B43BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55231750A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0380E2FB606;
	Thu,  4 Sep 2025 12:35:50 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A0C72604
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989349; cv=none; b=WTVZNodWvSCd3m0fXjNOaIZeQQFWHck5cIWs2/nwOvvbmx1C62SeeaWQCPWnfAYfbZT9k0Y71sCnNt2O9KspuxQA9vWW/wj5apEI0oZfVAcWADcdumaTz9CzRzaOdmsDdHuFLjXgkSNBatgs1MxN09DVF/Ei35Ma+EMdsTT4O7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989349; c=relaxed/simple;
	bh=ZpXhtcpnnTVTp1+RkIQZU+2oQ5gFMy0AyWPe/HMm3Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZA9YD0aPBfNyNXGcdH+Pyv8rSL/iqBpcx46S+Pbo2OA9GXcCTwfX7WhIwL53iYDy9b5gZFxNpA3X6LSkbxZd8SvEoTaM3uxS0u2VFaOhOvYoH4GHZxCfFUgwbv/E+v0PBKM3Yl17NcjLUZbmbpSIbGl5s/TutDprfEHj0ESIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.89])
	by gateway (Coremail) with SMTP id _____8DxP9OTh7loX6kGAA--.13700S3;
	Thu, 04 Sep 2025 20:35:31 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.89])
	by front1 (Coremail) with SMTP id qMiowJAxE+SJh7lot_99AA--.5542S3;
	Thu, 04 Sep 2025 20:35:29 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Lee Jones <lee@kernel.org>,
	Corey Minyard <minyard@acm.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	wangyao@lemote.com,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH v11 1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
Date: Thu,  4 Sep 2025 20:35:05 +0800
Message-ID: <0dc1fd53020ce2562453961ffed2cd9eb8f359e1.1756987761.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756987761.git.zhoubinbin@loongson.cn>
References: <cover.1756987761.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+SJh7lot_99AA--.5542S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw1DWF1rZr1rXw1DKF1rGrX_yoWfWF1xp3
	WxAay5CF1DJF47G39xAr1UuFsxua9Yv3y5Xa9rJwnI9a13Ca4UXw48tFyavrWDJFyvgry2
	qr9xJr4UC3ZxJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

The Loongson-2K Board Management Controller provides an PCIe interface
to the host to access the feature implemented in the BMC.

The BMC is assembled on a server similar to the server machine with
Loongson-3 CPU. It supports multiple sub-devices like DRM and IPMI.

Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Acked-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS                 |   6 ++
 drivers/mfd/Kconfig         |  13 +++
 drivers/mfd/Makefile        |   2 +
 drivers/mfd/ls2k-bmc-core.c | 189 ++++++++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+)
 create mode 100644 drivers/mfd/ls2k-bmc-core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 51823e99ecdb..bff129a41bb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14417,6 +14417,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
 F:	drivers/thermal/loongson2_thermal.c
 
+LOONGSON-2K Board Management Controller (BMC) DRIVER
+M:	Binbin Zhou <zhoubinbin@loongson.cn>
+M:	Chong Qiao <qiaochong@loongson.cn>
+S:	Maintained
+F:	drivers/mfd/ls2k-bmc-core.c
+
 LOONGSON EDAC DRIVER
 M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
 L:	linux-edac@vger.kernel.org
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 04f8bea1dccf..a79822e50f4a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2454,6 +2454,19 @@ config MFD_LOONGSON_SE
 	  commands to the engine and must first send them to the controller,
 	  which will forward them to the corresponding engine.
 
+config MFD_LS2K_BMC_CORE
+	bool "Loongson-2K Board Management Controller Support"
+	depends on PCI && ACPI_GENERIC_GSI
+	select MFD_CORE
+	help
+	  Say yes here to add support for the Loongson-2K BMC which is a Board
+	  Management Controller connected to the PCIe bus. The device supports
+	  multiple sub-devices like display and IPMI. This driver provides common
+	  support for accessing the devices.
+
+	  The display is enabled by default in the driver, while the IPMI interface
+	  is enabled independently through the IPMI_LS2K option in the IPMI section.
+
 config MFD_QNAP_MCU
 	tristate "QNAP microcontroller unit core driver"
 	depends on SERIAL_DEV_BUS
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 73df7fc8b5ff..c93273dfd5ee 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -286,6 +286,8 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)   += intel-m10-bmc-core.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)    += intel-m10-bmc-spi.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
 
+obj-$(CONFIG_MFD_LS2K_BMC_CORE)		+= ls2k-bmc-core.o
+
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
 
diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
new file mode 100644
index 000000000000..39cc481d9ba1
--- /dev/null
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Loongson-2K Board Management Controller (BMC) Core Driver.
+ *
+ * Copyright (C) 2024-2025 Loongson Technology Corporation Limited.
+ *
+ * Authors:
+ *	Chong Qiao <qiaochong@loongson.cn>
+ *	Binbin Zhou <zhoubinbin@loongson.cn>
+ */
+
+#include <linux/aperture.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/platform_data/simplefb.h>
+#include <linux/platform_device.h>
+
+/* LS2K BMC resources */
+#define LS2K_DISPLAY_RES_START		(SZ_16M + SZ_2M)
+#define LS2K_IPMI_RES_SIZE		0x1C
+#define LS2K_IPMI0_RES_START		(SZ_16M + 0xF00000)
+#define LS2K_IPMI1_RES_START		(LS2K_IPMI0_RES_START + LS2K_IPMI_RES_SIZE)
+#define LS2K_IPMI2_RES_START		(LS2K_IPMI1_RES_START + LS2K_IPMI_RES_SIZE)
+#define LS2K_IPMI3_RES_START		(LS2K_IPMI2_RES_START + LS2K_IPMI_RES_SIZE)
+#define LS2K_IPMI4_RES_START		(LS2K_IPMI3_RES_START + LS2K_IPMI_RES_SIZE)
+
+enum {
+	LS2K_BMC_DISPLAY,
+	LS2K_BMC_IPMI0,
+	LS2K_BMC_IPMI1,
+	LS2K_BMC_IPMI2,
+	LS2K_BMC_IPMI3,
+	LS2K_BMC_IPMI4,
+};
+
+static struct resource ls2k_display_resources[] = {
+	DEFINE_RES_MEM_NAMED(LS2K_DISPLAY_RES_START, SZ_4M, "simpledrm-res"),
+};
+
+static struct resource ls2k_ipmi0_resources[] = {
+	DEFINE_RES_MEM_NAMED(LS2K_IPMI0_RES_START, LS2K_IPMI_RES_SIZE, "ipmi0-res"),
+};
+
+static struct resource ls2k_ipmi1_resources[] = {
+	DEFINE_RES_MEM_NAMED(LS2K_IPMI1_RES_START, LS2K_IPMI_RES_SIZE, "ipmi1-res"),
+};
+
+static struct resource ls2k_ipmi2_resources[] = {
+	DEFINE_RES_MEM_NAMED(LS2K_IPMI2_RES_START, LS2K_IPMI_RES_SIZE, "ipmi2-res"),
+};
+
+static struct resource ls2k_ipmi3_resources[] = {
+	DEFINE_RES_MEM_NAMED(LS2K_IPMI3_RES_START, LS2K_IPMI_RES_SIZE, "ipmi3-res"),
+};
+
+static struct resource ls2k_ipmi4_resources[] = {
+	DEFINE_RES_MEM_NAMED(LS2K_IPMI4_RES_START, LS2K_IPMI_RES_SIZE, "ipmi4-res"),
+};
+
+static struct mfd_cell ls2k_bmc_cells[] = {
+	[LS2K_BMC_DISPLAY] = {
+		.name = "simple-framebuffer",
+		.num_resources = ARRAY_SIZE(ls2k_display_resources),
+		.resources = ls2k_display_resources
+	},
+	[LS2K_BMC_IPMI0] = {
+		.name = "ls2k-ipmi-si",
+		.num_resources = ARRAY_SIZE(ls2k_ipmi0_resources),
+		.resources = ls2k_ipmi0_resources
+	},
+	[LS2K_BMC_IPMI1] = {
+		.name = "ls2k-ipmi-si",
+		.num_resources = ARRAY_SIZE(ls2k_ipmi1_resources),
+		.resources = ls2k_ipmi1_resources
+	},
+	[LS2K_BMC_IPMI2] = {
+		.name = "ls2k-ipmi-si",
+		.num_resources = ARRAY_SIZE(ls2k_ipmi2_resources),
+		.resources = ls2k_ipmi2_resources
+	},
+	[LS2K_BMC_IPMI3] = {
+		.name = "ls2k-ipmi-si",
+		.num_resources = ARRAY_SIZE(ls2k_ipmi3_resources),
+		.resources = ls2k_ipmi3_resources
+	},
+	[LS2K_BMC_IPMI4] = {
+		.name = "ls2k-ipmi-si",
+		.num_resources = ARRAY_SIZE(ls2k_ipmi4_resources),
+		.resources = ls2k_ipmi4_resources
+	},
+};
+
+/*
+ * Currently the Loongson-2K BMC hardware does not have an I2C interface to adapt to the
+ * resolution. We set the resolution by presetting "video=1280x1024-16@2M" to the BMC memory.
+ */
+static int ls2k_bmc_parse_mode(struct pci_dev *pdev, struct simplefb_platform_data *pd)
+{
+	char *mode;
+	int depth, ret;
+
+	/* The last 16M of PCI BAR0 is used to store the resolution string. */
+	mode = devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0) + SZ_16M, SZ_16M);
+	if (!mode)
+		return -ENOMEM;
+
+	/* The resolution field starts with the flag "video=". */
+	if (!strncmp(mode, "video=", 6))
+		mode = mode + 6;
+
+	ret = kstrtoint(strsep(&mode, "x"), 10, &pd->width);
+	if (ret)
+		return ret;
+
+	ret = kstrtoint(strsep(&mode, "-"), 10, &pd->height);
+	if (ret)
+		return ret;
+
+	ret = kstrtoint(strsep(&mode, "@"), 10, &depth);
+	if (ret)
+		return ret;
+
+	pd->stride = pd->width * depth / 8;
+	pd->format = depth == 32 ? "a8r8g8b8" : "r5g6b5";
+
+	return 0;
+}
+
+static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	struct simplefb_platform_data pd;
+	resource_size_t base;
+	int ret;
+
+	ret = pci_enable_device(dev);
+	if (ret)
+		return ret;
+
+	ret = ls2k_bmc_parse_mode(dev, &pd);
+	if (ret)
+		goto disable_pci;
+
+	ls2k_bmc_cells[LS2K_BMC_DISPLAY].platform_data = &pd;
+	ls2k_bmc_cells[LS2K_BMC_DISPLAY].pdata_size = sizeof(pd);
+	base = dev->resource[0].start + LS2K_DISPLAY_RES_START;
+
+	/* Remove conflicting efifb device */
+	ret = aperture_remove_conflicting_devices(base, SZ_4M, "simple-framebuffer");
+	if (ret) {
+		dev_err(&dev->dev, "Failed to removed firmware framebuffers: %d\n", ret);
+		goto disable_pci;
+	}
+
+	return devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
+				    ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_cells),
+				    &dev->resource[0], 0, NULL);
+
+disable_pci:
+	pci_disable_device(dev);
+	return ret;
+}
+
+static void ls2k_bmc_remove(struct pci_dev *dev)
+{
+	pci_disable_device(dev);
+}
+
+static struct pci_device_id ls2k_bmc_devices[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x1a05) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, ls2k_bmc_devices);
+
+static struct pci_driver ls2k_bmc_driver = {
+	.name = "ls2k-bmc",
+	.id_table = ls2k_bmc_devices,
+	.probe = ls2k_bmc_probe,
+	.remove = ls2k_bmc_remove,
+};
+module_pci_driver(ls2k_bmc_driver);
+
+MODULE_DESCRIPTION("Loongson-2K Board Management Controller (BMC) Core driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
+MODULE_LICENSE("GPL");
-- 
2.47.3


