Return-Path: <linux-kernel+bounces-577934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC74A728B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 03:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3331189BABE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 02:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349C0151990;
	Thu, 27 Mar 2025 02:17:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD161422AB;
	Thu, 27 Mar 2025 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743041835; cv=none; b=tBk0fC9D88bMyQrdzCkrwQ2u8GBf+Z+aOWZwyVRfOX4ebGUYO8HDonudKNSke/y/Kyicw4dRMJ8jralZf+Zq7G/aFKwt84Zo2PLAOs1oJCQQFxkzkjQx2sO2znKChcwXRXPe8Ui72fFl4GhIeqpaTIyCcMaEr0GI3JIOnq9W1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743041835; c=relaxed/simple;
	bh=QeXaSjfGEpMCIKtq7wlwyf7366ZMSXXiymiA6heASgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuTOh43JlMq4OQs1J95yECUQn8ZaNfqRxpp4D/94Lv098PcJNZiFpvA8URfbNV40ukjXA9vwbt7aWBjQzi35HSnhW6keC6I3rzYytJ+NHbePbkIzOzidfyjZ215ZhB68HumnnEAepTIg3Qmmv4DttDuxjkQZIf+48KmfsXcGfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8AxWXEmteRnxLynAA--.19176S3;
	Thu, 27 Mar 2025 10:17:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMAxj8UcteRnpXFiAA--.32467S3;
	Thu, 27 Mar 2025 10:17:03 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: lee@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-crypto@vger.kernel.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Yinggang Gu <guyinggang@loongson.cn>
Subject: [PATCH v6 1/6] mfd: Add support for Loongson Security Module
Date: Thu, 27 Mar 2025 10:18:04 +0800
Message-ID: <20250327021809.29954-2-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250327021809.29954-1-zhaoqunqin@loongson.cn>
References: <20250327021809.29954-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxj8UcteRnpXFiAA--.32467S3
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3Zr17Jw1xtF4rXrW8Kw4xKrX_yoW8Gr1DKo
	WxZFs3Zw18Jr1xArW09r1rtrWfZr9Y9a4Yyw13Z397u3WUJFn8KFW0gw13Wr1fuF4Fyr15
	u343tr4xuF43Crn5l-sFpf9Il3svdjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYW7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4eMKDUUUU

This driver supports Loongson Security Module, which provides the control
for it's hardware encryption acceleration child devices.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
---
v6: Replace all "ls6000se" with "loongson"
v5: Registered "ls6000se-rng" device.
v3-v4: None

v2: Removed "ls6000se-sdf" device, added "ls6000se-tpm" device.
    Passed dmamem size to SE firmware in se_init_hw() function.

 drivers/mfd/Kconfig             |  10 +
 drivers/mfd/Makefile            |   2 +
 drivers/mfd/loongson-se.c       | 374 ++++++++++++++++++++++++++++++++
 include/linux/mfd/loongson-se.h |  75 +++++++
 4 files changed, 461 insertions(+)
 create mode 100644 drivers/mfd/loongson-se.c
 create mode 100644 include/linux/mfd/loongson-se.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 22b936310..a31ccb1b0 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2422,5 +2422,15 @@ config MFD_UPBOARD_FPGA
 	  To compile this driver as a module, choose M here: the module will be
 	  called upboard-fpga.
 
+config MFD_LOONGSON_SE
+	tristate "Loongson Security Module Interface"
+	depends on LOONGARCH && ACPI
+	select MFD_CORE
+	help
+	  The Loongson security module provides the control for hardware
+	  encryption acceleration devices. Each device uses at least one
+	  channel to interact with security module, and each channel may
+	  have its own buffer provided by security module.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 948cbdf42..fc50601ca 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -290,3 +290,5 @@ obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
 
 obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
+
+obj-$(CONFIG_MFD_LOONGSON_SE)	+= loongson-se.o
diff --git a/drivers/mfd/loongson-se.c b/drivers/mfd/loongson-se.c
new file mode 100644
index 000000000..bf16f7df8
--- /dev/null
+++ b/drivers/mfd/loongson-se.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2025 Loongson Technology Corporation Limited */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/loongson-se.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+/*
+ * The Loongson Security Module provides the control for hardware
+ * encryption acceleration child devices. The SE framework is
+ * shown as follows:
+ *
+ *                   +------------+
+ *                   |    CPU     |
+ *                   +------------+
+ *			^	^
+ *	            DMA |	| IRQ
+ *			v	v
+ *        +-----------------------------------+
+ *        |     Loongson Security Module      |
+ *        +-----------------------------------+
+ *             ^                ^
+ *    channel1 |       channel2 |
+ *             v                v
+ *        +-----------+    +----------+
+ *        | sub-dev1  |    | sub-dev2 |  ..... Max sub-dev31
+ *        +-----------+    +----------+
+ *
+ * The CPU cannot directly communicate with SE's sub devices,
+ * but sends commands to SE, which processes the commands and
+ * sends them to the corresponding sub devices.
+ */
+
+struct loongson_se {
+	void __iomem *base;
+	u32 version;
+	spinlock_t dev_lock;
+	struct completion cmd_completion;
+
+	/* dma memory */
+	void *mem_base;
+	int mem_map_pages;
+	unsigned long *mem_map;
+
+	/* channel */
+	struct mutex ch_init_lock;
+	struct lsse_ch chs[SE_CH_MAX];
+};
+
+union se_request {
+	u32 info[8];
+	struct se_cmd {
+		u32 cmd;
+		u32 info[7];
+	} req;
+	struct se_res {
+		u32 cmd;
+		u32 cmd_ret;
+		u32 info[6];
+	} res;
+};
+
+static inline u32 se_readl(struct loongson_se *se, u32 off)
+{
+	return readl(se->base + off);
+}
+
+static inline void se_writel(struct loongson_se *se, u32 val, u32 off)
+{
+	writel(val, se->base + off);
+}
+
+static void se_enable_int_locked(struct loongson_se *se, u32 int_bit)
+{
+	u32 tmp;
+
+	tmp = se_readl(se, SE_S2LINT_EN);
+	tmp |= int_bit;
+	se_writel(se, tmp, SE_S2LINT_EN);
+}
+
+static void se_disable_int(struct loongson_se *se, u32 int_bit)
+{
+	unsigned long flag;
+	u32 tmp;
+
+	spin_lock_irqsave(&se->dev_lock, flag);
+
+	tmp = se_readl(se, SE_S2LINT_EN);
+	tmp &= ~(int_bit);
+	se_writel(se, tmp, SE_S2LINT_EN);
+
+	spin_unlock_irqrestore(&se->dev_lock, flag);
+}
+
+static int se_poll(struct loongson_se *se, u32 int_bit)
+{
+	u32 status;
+	int err;
+
+	spin_lock_irq(&se->dev_lock);
+
+	se_enable_int_locked(se, int_bit);
+	se_writel(se, int_bit, SE_L2SINT_SET);
+	err = readl_relaxed_poll_timeout_atomic(se->base + SE_L2SINT_STAT, status,
+						!(status & int_bit), 1, 10000);
+
+	spin_unlock_irq(&se->dev_lock);
+
+	return err;
+}
+
+static int se_send_requeset(struct loongson_se *se, union se_request *req)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(req->info); i++)
+		se_writel(se, req->info[i], SE_DATA_S + i * 4);
+
+	return se_poll(se, SE_INT_SETUP);
+}
+
+/*
+ * Called by SE's child device driver.
+ * Send a request to the corresponding device.
+ */
+int se_send_ch_requeset(struct lsse_ch *ch)
+{
+	return se_poll(ch->se, ch->int_bit);
+}
+EXPORT_SYMBOL_GPL(se_send_ch_requeset);
+
+static int se_get_res(struct loongson_se *se, u32 cmd, union se_request *res)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(res->info); i++)
+		res->info[i] = se_readl(se, SE_DATA_L + i * 4);
+
+	if (res->res.cmd != cmd)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int se_send_genl_cmd(struct loongson_se *se, union se_request *req)
+{
+	int err;
+
+	err = se_send_requeset(se, req);
+	if (err)
+		return err;
+
+	if (!wait_for_completion_timeout(&se->cmd_completion, HZ))
+		return -ETIME;
+
+	return se_get_res(se, req->req.cmd, req);
+}
+
+static int se_set_msg(struct lsse_ch *ch)
+{
+	struct loongson_se *se = ch->se;
+	union se_request req;
+
+	req.req.cmd = SE_CMD_SETMSG;
+	req.req.info[0] = ch->id;
+	req.req.info[1] = ch->smsg - se->mem_base;
+	req.req.info[2] = ch->msg_size;
+
+	return se_send_genl_cmd(se, &req);
+}
+
+static irqreturn_t se_irq(int irq, void *dev_id)
+{
+	struct loongson_se *se = (struct loongson_se *)dev_id;
+	struct lsse_ch *ch;
+	u32 int_status;
+	int id;
+
+	int_status = se_readl(se, SE_S2LINT_STAT);
+	se_disable_int(se, int_status);
+	if (int_status & SE_INT_SETUP) {
+		complete(&se->cmd_completion);
+		int_status &= ~SE_INT_SETUP;
+		se_writel(se, SE_INT_SETUP, SE_S2LINT_CL);
+	}
+
+	while (int_status) {
+		id = __ffs(int_status);
+
+		ch = &se->chs[id];
+		if (ch->complete)
+			ch->complete(ch);
+		int_status &= ~BIT(id);
+		se_writel(se, BIT(id), SE_S2LINT_CL);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int se_init_hw(struct loongson_se *se, dma_addr_t addr, int size)
+{
+	union se_request req;
+	int err;
+
+	/* Start engine */
+	req.req.cmd = SE_CMD_START;
+	err = se_send_genl_cmd(se, &req);
+	if (err)
+		return err;
+
+	/* Get Version */
+	req.req.cmd = SE_CMD_GETVER;
+	err = se_send_genl_cmd(se, &req);
+	if (err)
+		return err;
+	se->version = req.res.info[0];
+
+	/* Setup dma memory */
+	req.req.cmd = SE_CMD_SETBUF;
+	req.req.info[0] = addr & 0xffffffff;
+	req.req.info[1] = addr >> 32;
+	req.req.info[2] = size;
+
+	return se_send_genl_cmd(se, &req);
+}
+
+/*
+ * se_init_ch() - Init the channel used by child device.
+ *
+ * Allocate dma memory as agreed upon with SE on SE probe,
+ * and register the callback function when the data processing
+ * in this channel is completed.
+ */
+struct lsse_ch *se_init_ch(struct device *dev, int id, int data_size, int msg_size,
+			   void *priv, void (*complete)(struct lsse_ch *se_ch))
+{
+	struct loongson_se *se = dev_get_drvdata(dev);
+	struct lsse_ch *ch;
+	int data_first, data_nr;
+	int msg_first, msg_nr;
+
+	mutex_lock(&se->ch_init_lock);
+
+	ch = &se->chs[id];
+	ch->se = se;
+	ch->id = id;
+	ch->int_bit = BIT(id);
+
+	data_nr = round_up(data_size, PAGE_SIZE) / PAGE_SIZE;
+	data_first = bitmap_find_next_zero_area(se->mem_map, se->mem_map_pages,
+						0, data_nr, 0);
+	if (data_first >= se->mem_map_pages) {
+		ch = NULL;
+		goto out_unlock;
+	}
+
+	bitmap_set(se->mem_map, data_first, data_nr);
+	ch->off = data_first * PAGE_SIZE;
+	ch->data_buffer = se->mem_base + ch->off;
+	ch->data_size = data_size;
+
+	msg_nr = round_up(msg_size, PAGE_SIZE) / PAGE_SIZE;
+	msg_first = bitmap_find_next_zero_area(se->mem_map, se->mem_map_pages,
+					       0, msg_nr, 0);
+	if (msg_first >= se->mem_map_pages) {
+		ch = NULL;
+		goto out_unlock;
+	}
+
+	bitmap_set(se->mem_map, msg_first, msg_nr);
+	ch->smsg = se->mem_base + msg_first * PAGE_SIZE;
+	ch->rmsg = ch->smsg + msg_size / 2;
+	ch->msg_size = msg_size;
+	ch->complete = complete;
+	ch->priv = priv;
+	ch->version = se->version;
+
+	if (se_set_msg(ch))
+		ch = NULL;
+
+out_unlock:
+	mutex_unlock(&se->ch_init_lock);
+
+	return ch;
+}
+EXPORT_SYMBOL_GPL(se_init_ch);
+
+static const struct mfd_cell se_devs[] = {
+	{ .name = "loongson-rng" },
+	{ .name = "loongson-tpm" },
+};
+
+static int loongson_se_probe(struct platform_device *pdev)
+{
+	struct loongson_se *se;
+	struct device *dev = &pdev->dev;
+	int nr_irq, irq, err, size;
+	dma_addr_t paddr;
+
+	se = devm_kmalloc(dev, sizeof(*se), GFP_KERNEL);
+	if (!se)
+		return -ENOMEM;
+	dev_set_drvdata(dev, se);
+	init_completion(&se->cmd_completion);
+	spin_lock_init(&se->dev_lock);
+	mutex_init(&se->ch_init_lock);
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (device_property_read_u32(dev, "dmam_size", &size))
+		return -ENODEV;
+	size = roundup_pow_of_two(size);
+	se->mem_base = dmam_alloc_coherent(dev, size, &paddr, GFP_KERNEL);
+	if (!se->mem_base)
+		return -ENOMEM;
+	se->mem_map_pages = size / PAGE_SIZE;
+	se->mem_map = devm_bitmap_zalloc(dev, se->mem_map_pages, GFP_KERNEL);
+	if (!se->mem_map)
+		return -ENOMEM;
+
+	se->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(se->base))
+		return PTR_ERR(se->base);
+
+	nr_irq = platform_irq_count(pdev);
+	if (nr_irq <= 0)
+		return -ENODEV;
+	while (nr_irq) {
+		irq = platform_get_irq(pdev, --nr_irq);
+		/* Use the same interrupt handler address.
+		 * Determine which irq it is accroding
+		 * SE_S2LINT_STAT register.
+		 */
+		err = devm_request_irq(dev, irq, se_irq, 0, "loongson-se", se);
+		if (err)
+			dev_err(dev, "failed to request irq: %d\n", irq);
+	}
+
+	err = se_init_hw(se, paddr, size);
+	if (err)
+		return err;
+
+	return devm_mfd_add_devices(dev, 0, se_devs, ARRAY_SIZE(se_devs),
+				    NULL, 0, NULL);
+}
+
+static const struct acpi_device_id loongson_se_acpi_match[] = {
+	{"LOON0011", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, loongson_se_acpi_match);
+
+static struct platform_driver loongson_se_driver = {
+	.probe   = loongson_se_probe,
+	.driver  = {
+		.name  = "loongson-se",
+		.acpi_match_table = loongson_se_acpi_match,
+	},
+};
+module_platform_driver(loongson_se_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
+MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
+MODULE_DESCRIPTION("Loongson Security Module driver");
diff --git a/include/linux/mfd/loongson-se.h b/include/linux/mfd/loongson-se.h
new file mode 100644
index 000000000..f70e9f196
--- /dev/null
+++ b/include/linux/mfd/loongson-se.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2025 Loongson Technology Corporation Limited */
+
+#ifndef __LOONGSON_SE_H__
+#define __LOONGSON_SE_H__
+
+#define SE_DATA_S			0x0
+#define SE_DATA_L			0x20
+#define SE_S2LINT_STAT			0x88
+#define SE_S2LINT_EN			0x8c
+#define SE_S2LINT_SET			0x90
+#define SE_S2LINT_CL			0x94
+#define SE_L2SINT_STAT			0x98
+#define SE_L2SINT_EN			0x9c
+#define SE_L2SINT_SET			0xa0
+#define SE_L2SINT_CL			0xa4
+
+/* INT bit definition */
+#define SE_INT_SETUP			BIT(0)
+#define SE_INT_TPM			BIT(5)
+
+#define SE_CMD_START			0x0
+#define SE_CMD_STOP			0x1
+#define SE_CMD_GETVER			0x2
+#define SE_CMD_SETBUF			0x3
+#define SE_CMD_SETMSG			0x4
+
+#define SE_CMD_RNG			0x100
+#define SE_CMD_SM2_SIGN			0x200
+#define SE_CMD_SM2_VSIGN		0x201
+#define SE_CMD_SM3_DIGEST		0x300
+#define SE_CMD_SM3_UPDATE		0x301
+#define SE_CMD_SM3_FINISH		0x302
+#define SE_CMD_SM4_ECB_ENCRY		0x400
+#define SE_CMD_SM4_ECB_DECRY		0x401
+#define SE_CMD_SM4_CBC_ENCRY		0x402
+#define SE_CMD_SM4_CBC_DECRY		0x403
+#define SE_CMD_SM4_CTR			0x404
+#define SE_CMD_TPM			0x500
+#define SE_CMD_ZUC_INIT_READ		0x600
+#define SE_CMD_ZUC_READ			0x601
+#define SE_CMD_SDF			0x700
+
+#define SE_CH_MAX			32
+#define SE_CH_RNG			1
+#define SE_CH_SM2			2
+#define SE_CH_SM3			3
+#define SE_CH_SM4			4
+#define SE_CH_TPM			5
+#define SE_CH_ZUC			6
+#define SE_CH_SDF			7
+
+struct lsse_ch {
+	struct loongson_se *se;
+	void *priv;
+	u32 version;
+	u32 id;
+	u32 int_bit;
+
+	void *smsg;
+	void *rmsg;
+	int msg_size;
+
+	void *data_buffer;
+	int data_size;
+	u32 off;
+
+	void (*complete)(struct lsse_ch *se_ch);
+};
+
+struct lsse_ch *se_init_ch(struct device *dev, int id, int data_size, int msg_size,
+			   void *priv, void (*complete)(struct lsse_ch *se_ch));
+int se_send_ch_requeset(struct lsse_ch *ch);
+
+#endif
-- 
2.45.2


