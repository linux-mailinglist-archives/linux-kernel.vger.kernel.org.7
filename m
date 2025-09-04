Return-Path: <linux-kernel+bounces-800766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E8EB43BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF1D5A314A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887B2FE59C;
	Thu,  4 Sep 2025 12:36:01 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A382FE565
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989361; cv=none; b=hY6RIk7ao75F/y0wG8tDjKIG6gFQBImf13+Sp2n/WVzdKgGCxfRM39ohAMYoKHUdAdchsfLcmnU+jA2ImjWVHRnr1MZB3UxzQz+m8H5Wb088MoBC2RT4rIEWJ2YzD1Gxil6yk2777DM4LwGWWcQwlT28302L42CnPpbUPmIJ/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989361; c=relaxed/simple;
	bh=ZE497jrBOu+ylyKSH/GdUw6J6fc00Ka8NMLMmKVTkDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcIu5/YIE2Lp2PNKPj2YYdC6oIbx+9EzsDfTNN/3EWpxGrPekexLAn0TRz3rotxjL2UUX42PSyrVR8sKmqSfWr0Pk6EU2bb2QE/YuyLZoSAKm9NxYI22BwvvtCNCreLYNWl1CuOK9vVa8kTh8gh1Cnu/IMiOCVxMNpXxID5hF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.89])
	by gateway (Coremail) with SMTP id _____8Bx37+ah7lodKkGAA--.12769S3;
	Thu, 04 Sep 2025 20:35:38 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.89])
	by front1 (Coremail) with SMTP id qMiowJAxE+SJh7lot_99AA--.5542S5;
	Thu, 04 Sep 2025 20:35:37 +0800 (CST)
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
Subject: [PATCH v11 3/3] ipmi: Add Loongson-2K BMC support
Date: Thu,  4 Sep 2025 20:35:07 +0800
Message-ID: <8f9ffb6f0405345af8f04193ce1510aacd075e72.1756987761.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxE+SJh7lot_99AA--.5542S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ar17WF17Gr17GFW5Gw18CrX_yoWfur47pa
	1aya43Cr48tF47K397ZryDWFyrCwnrWa4rKF47W34ruFWj934vgr1vya4fAry7tFyvq3y3
	JrZ8ArW3WF13JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_
	ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jfHUhUUUUU=

This patch adds Loongson-2K BMC IPMI support.

According to the existing design, we use software simulation to
implement the KCS interface registers: Stauts/Command/Data_Out/Data_In.

Also since both host side and BMC side read and write kcs status, fifo flag
is used to ensure data consistency.

The single KCS message block is as follows:

+-------------------------------------------------------------------------+
|FIFO flags| KCS register data | CMD data | KCS version | WR REQ | WR ACK |
+-------------------------------------------------------------------------+

Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Acked-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS                      |   1 +
 drivers/char/ipmi/Kconfig        |   7 ++
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmi_si.h      |   7 ++
 drivers/char/ipmi/ipmi_si_intf.c |   4 +
 drivers/char/ipmi/ipmi_si_ls2k.c | 189 +++++++++++++++++++++++++++++++
 6 files changed, 209 insertions(+)
 create mode 100644 drivers/char/ipmi/ipmi_si_ls2k.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bff129a41bb0..eba99be64035 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14421,6 +14421,7 @@ LOONGSON-2K Board Management Controller (BMC) DRIVER
 M:	Binbin Zhou <zhoubinbin@loongson.cn>
 M:	Chong Qiao <qiaochong@loongson.cn>
 S:	Maintained
+F:	drivers/char/ipmi/ipmi_si_ls2k.c
 F:	drivers/mfd/ls2k-bmc-core.c
 
 LOONGSON EDAC DRIVER
diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index f4adc6feb3b2..92bed266d07c 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -84,6 +84,13 @@ config IPMI_IPMB
 	  bus, and it also supports direct messaging on the bus using
 	  IPMB direct messages.  This module requires I2C support.
 
+config IPMI_LS2K
+	bool 'Loongson-2K IPMI interface'
+	depends on LOONGARCH
+	select MFD_LS2K_BMC_CORE
+	help
+	  Provides a driver for Loongson-2K IPMI interfaces.
+
 config IPMI_POWERNV
 	depends on PPC_POWERNV
 	tristate 'POWERNV (OPAL firmware) IPMI interface'
diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
index e0944547c9d0..4ea450a82242 100644
--- a/drivers/char/ipmi/Makefile
+++ b/drivers/char/ipmi/Makefile
@@ -8,6 +8,7 @@ ipmi_si-y := ipmi_si_intf.o ipmi_kcs_sm.o ipmi_smic_sm.o ipmi_bt_sm.o \
 	ipmi_si_mem_io.o
 ipmi_si-$(CONFIG_HAS_IOPORT) += ipmi_si_port_io.o
 ipmi_si-$(CONFIG_PCI) += ipmi_si_pci.o
+ipmi_si-$(CONFIG_IPMI_LS2K) += ipmi_si_ls2k.o
 ipmi_si-$(CONFIG_PARISC) += ipmi_si_parisc.o
 
 obj-$(CONFIG_IPMI_HANDLER) += ipmi_msghandler.o
diff --git a/drivers/char/ipmi/ipmi_si.h b/drivers/char/ipmi/ipmi_si.h
index 508c3fd45877..687835b53da5 100644
--- a/drivers/char/ipmi/ipmi_si.h
+++ b/drivers/char/ipmi/ipmi_si.h
@@ -101,6 +101,13 @@ void ipmi_si_pci_shutdown(void);
 static inline void ipmi_si_pci_init(void) { }
 static inline void ipmi_si_pci_shutdown(void) { }
 #endif
+#ifdef CONFIG_IPMI_LS2K
+void ipmi_si_ls2k_init(void);
+void ipmi_si_ls2k_shutdown(void);
+#else
+static inline void ipmi_si_ls2k_init(void) { }
+static inline void ipmi_si_ls2k_shutdown(void) { }
+#endif
 #ifdef CONFIG_PARISC
 void ipmi_si_parisc_init(void);
 void ipmi_si_parisc_shutdown(void);
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 8b5524069c15..cc7033e7f550 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2120,6 +2120,8 @@ static int __init init_ipmi_si(void)
 
 	ipmi_si_pci_init();
 
+	ipmi_si_ls2k_init();
+
 	ipmi_si_parisc_init();
 
 	mutex_lock(&smi_infos_lock);
@@ -2331,6 +2333,8 @@ static void cleanup_ipmi_si(void)
 
 	ipmi_si_pci_shutdown();
 
+	ipmi_si_ls2k_shutdown();
+
 	ipmi_si_parisc_shutdown();
 
 	ipmi_si_platform_shutdown();
diff --git a/drivers/char/ipmi/ipmi_si_ls2k.c b/drivers/char/ipmi/ipmi_si_ls2k.c
new file mode 100644
index 000000000000..45442c257efd
--- /dev/null
+++ b/drivers/char/ipmi/ipmi_si_ls2k.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Loongson-2K BMC IPMI interface
+ *
+ * Copyright (C) 2024-2025 Loongson Technology Corporation Limited.
+ *
+ * Authors:
+ *	Chong Qiao <qiaochong@loongson.cn>
+ *	Binbin Zhou <zhoubinbin@loongson.cn>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include "ipmi_si.h"
+
+#define LS2K_KCS_FIFO_IBFH	0x0
+#define LS2K_KCS_FIFO_IBFT	0x1
+#define LS2K_KCS_FIFO_OBFH	0x2
+#define LS2K_KCS_FIFO_OBFT	0x3
+
+/* KCS registers */
+#define LS2K_KCS_REG_STS	0x4
+#define LS2K_KCS_REG_DATA_OUT	0x5
+#define LS2K_KCS_REG_DATA_IN	0x6
+#define LS2K_KCS_REG_CMD	0x8
+
+#define LS2K_KCS_CMD_DATA	0xa
+#define LS2K_KCS_VERSION	0xb
+#define LS2K_KCS_WR_REQ		0xc
+#define LS2K_KCS_WR_ACK		0x10
+
+#define LS2K_KCS_STS_OBF	BIT(0)
+#define LS2K_KCS_STS_IBF	BIT(1)
+#define LS2K_KCS_STS_SMS_ATN	BIT(2)
+#define LS2K_KCS_STS_CMD	BIT(3)
+
+#define LS2K_KCS_DATA_MASK	(LS2K_KCS_STS_OBF | LS2K_KCS_STS_IBF | LS2K_KCS_STS_CMD)
+
+static bool ls2k_registered;
+
+static unsigned char ls2k_mem_inb_v0(const struct si_sm_io *io, unsigned int offset)
+{
+	void __iomem *addr = io->addr;
+	int reg_offset;
+
+	if (offset & BIT(0)) {
+		reg_offset = LS2K_KCS_REG_STS;
+	} else {
+		writeb(readb(addr + LS2K_KCS_REG_STS) & ~LS2K_KCS_STS_OBF, addr + LS2K_KCS_REG_STS);
+		reg_offset = LS2K_KCS_REG_DATA_OUT;
+	}
+
+	return readb(addr + reg_offset);
+}
+
+static unsigned char ls2k_mem_inb_v1(const struct si_sm_io *io, unsigned int offset)
+{
+	void __iomem *addr = io->addr;
+	unsigned char inb = 0, cmd;
+	bool obf, ibf;
+
+	obf = readb(addr + LS2K_KCS_FIFO_OBFH) ^ readb(addr + LS2K_KCS_FIFO_OBFT);
+	ibf = readb(addr + LS2K_KCS_FIFO_IBFH) ^ readb(addr + LS2K_KCS_FIFO_IBFT);
+	cmd = readb(addr + LS2K_KCS_CMD_DATA);
+
+	if (offset & BIT(0)) {
+		inb = readb(addr + LS2K_KCS_REG_STS) & ~LS2K_KCS_DATA_MASK;
+		inb |= FIELD_PREP(LS2K_KCS_STS_OBF, obf)
+		    | FIELD_PREP(LS2K_KCS_STS_IBF, ibf)
+		    | FIELD_PREP(LS2K_KCS_STS_CMD, cmd);
+	} else {
+		inb = readb(addr + LS2K_KCS_REG_DATA_OUT);
+		writeb(readb(addr + LS2K_KCS_FIFO_OBFH), addr + LS2K_KCS_FIFO_OBFT);
+	}
+
+	return inb;
+}
+
+static void ls2k_mem_outb_v0(const struct si_sm_io *io, unsigned int offset,
+			     unsigned char val)
+{
+	void __iomem *addr = io->addr;
+	unsigned char sts = readb(addr + LS2K_KCS_REG_STS);
+	int reg_offset;
+
+	if (sts & LS2K_KCS_STS_IBF)
+		return;
+
+	if (offset & BIT(0)) {
+		reg_offset = LS2K_KCS_REG_CMD;
+		sts |= LS2K_KCS_STS_CMD;
+	} else {
+		reg_offset = LS2K_KCS_REG_DATA_IN;
+		sts &= ~LS2K_KCS_STS_CMD;
+	}
+
+	writew(val, addr + reg_offset);
+	writeb(sts | LS2K_KCS_STS_IBF, addr + LS2K_KCS_REG_STS);
+	writel(readl(addr + LS2K_KCS_WR_REQ) + 1, addr + LS2K_KCS_WR_REQ);
+}
+
+static void ls2k_mem_outb_v1(const struct si_sm_io *io, unsigned int offset,
+			     unsigned char val)
+{
+	void __iomem *addr = io->addr;
+	unsigned char ibfh, ibft;
+	int reg_offset;
+
+	ibfh = readb(addr + LS2K_KCS_FIFO_IBFH);
+	ibft = readb(addr + LS2K_KCS_FIFO_IBFT);
+
+	if (ibfh ^ ibft)
+		return;
+
+	reg_offset = (offset & BIT(0)) ? LS2K_KCS_REG_CMD : LS2K_KCS_REG_DATA_IN;
+	writew(val, addr + reg_offset);
+
+	writeb(offset & BIT(0), addr + LS2K_KCS_CMD_DATA);
+	writeb(!ibft, addr + LS2K_KCS_FIFO_IBFH);
+	writel(readl(addr + LS2K_KCS_WR_REQ) + 1, addr + LS2K_KCS_WR_REQ);
+}
+
+static void ls2k_mem_cleanup(struct si_sm_io *io)
+{
+	if (io->addr)
+		iounmap(io->addr);
+}
+
+static int ipmi_ls2k_mem_setup(struct si_sm_io *io)
+{
+	unsigned char version;
+
+	io->addr = ioremap(io->addr_data, io->regspacing);
+	if (!io->addr)
+		return -EIO;
+
+	version = readb(io->addr + LS2K_KCS_VERSION);
+
+	io->inputb = version ? ls2k_mem_inb_v1 : ls2k_mem_inb_v0;
+	io->outputb = version ? ls2k_mem_outb_v1 : ls2k_mem_outb_v0;
+	io->io_cleanup = ls2k_mem_cleanup;
+
+	return 0;
+}
+
+static int ipmi_ls2k_probe(struct platform_device *pdev)
+{
+	struct si_sm_io io;
+
+	memset(&io, 0, sizeof(io));
+
+	io.si_info	= &ipmi_kcs_si_info;
+	io.io_setup	= ipmi_ls2k_mem_setup;
+	io.addr_data	= pdev->resource[0].start;
+	io.regspacing	= resource_size(&pdev->resource[0]);
+	io.dev		= &pdev->dev;
+
+	dev_dbg(&pdev->dev, "addr 0x%lx, spacing %d.\n", io.addr_data, io.regspacing);
+
+	return ipmi_si_add_smi(&io);
+}
+
+static void ipmi_ls2k_remove(struct platform_device *pdev)
+{
+	ipmi_si_remove_by_dev(&pdev->dev);
+}
+
+struct platform_driver ipmi_ls2k_platform_driver = {
+	.driver = {
+		.name = "ls2k-ipmi-si",
+	},
+	.probe	= ipmi_ls2k_probe,
+	.remove	= ipmi_ls2k_remove,
+};
+
+void ipmi_si_ls2k_init(void)
+{
+	platform_driver_register(&ipmi_ls2k_platform_driver);
+	ls2k_registered = true;
+}
+
+void ipmi_si_ls2k_shutdown(void)
+{
+	if (ls2k_registered)
+		platform_driver_unregister(&ipmi_ls2k_platform_driver);
+}
-- 
2.47.3


