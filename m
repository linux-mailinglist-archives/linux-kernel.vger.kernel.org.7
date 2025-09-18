Return-Path: <linux-kernel+bounces-774991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4421BB2BA08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0730752441F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3422773F0;
	Tue, 19 Aug 2025 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DBRQuwFk"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F628489B;
	Tue, 19 Aug 2025 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586777; cv=none; b=Rh/Zyqz7OVu8ZPsvfXxgjhhhQlgBxnM9cwsDvPBYmnaL32NblHnsPqiKV+7peYszppNTGwjUDsEiaA25fuuQQx39FTK1KHHo03YTGXQP/sCci05neLm/LioNk6lCQHH74nzQanjbTo1n7SDITiVSrKMIFveStFhOvEoTUad8+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586777; c=relaxed/simple;
	bh=mYwR22NZ6EFtwhhY86L5QNWyJBAkbLbwC4tXgDgeDqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l68ny9p/db+sBrSFR1c/ORuW0HqRqzZJXvkrfxBvx6Qa3b/QIL9VH7TfiA54UyDj3lFAjmpLi3PbspQKFPsx0vuYeKP2gyNzxZKRH/NbYnFTXQ+HzvzKzP8WHBluDq3bex3o4WkUgi4M/pzLWAVBzVdAImUZ52BO7sJjrTl8FUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DBRQuwFk; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57J6xOnF2894955;
	Tue, 19 Aug 2025 01:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755586764;
	bh=T3YQ2N9KiPCxx2eeLog5G5bdet1o6wsJLtdVcgpmUkc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DBRQuwFkDMUamACmaW1bxhZxUi/0K2DyjTy0ZcHfCn12chVHMN3PJkklSXjrbL+c/
	 xwvuohyF+bbJTb4RzbPqLU2IivOnJT9AhUoIka5feloiVXOUGr6O5ymAi88m7OQri0
	 pM8GzRPZCvWc8acBeYQ5mPi5X3jv1QiL2+kfR404=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57J6xO8F401352
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 01:59:24 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 01:59:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 01:59:24 -0500
Received: from pratham-Workstation-PC (pratham-workstation-pc.dhcp.ti.com [10.24.69.191])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57J6xMkS2303327;
	Tue, 19 Aug 2025 01:59:23 -0500
From: T Pratham <t-pratham@ti.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller"
	<davem@davemloft.net>
CC: T Pratham <t-pratham@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, Kamlesh Gurudasani <kamlesh@ti.com>,
        Manorit
 Chawdhry <m-chawdhry@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth
 Bajjuri <praneeth@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
        Kavitha
 Malarvizhi <k-malarvizhi@ti.com>
Subject: [PATCH v6 2/2] crypto: ti: Add driver for DTHE V2 AES Engine (ECB, CBC)
Date: Tue, 19 Aug 2025 11:42:45 +0530
Message-ID: <20250819065844.3337101-3-t-pratham@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819065844.3337101-1-t-pratham@ti.com>
References: <20250819065844.3337101-1-t-pratham@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add support for ECB and CBC modes in the AES Engine of the DTHE V2
hardware cryptography engine.

Signed-off-by: T Pratham <t-pratham@ti.com>
---
 MAINTAINERS                       |   1 +
 drivers/crypto/Kconfig            |   1 +
 drivers/crypto/Makefile           |   1 +
 drivers/crypto/ti/Kconfig         |  14 +
 drivers/crypto/ti/Makefile        |   3 +
 drivers/crypto/ti/dthev2-aes.c    | 411 ++++++++++++++++++++++++++++++
 drivers/crypto/ti/dthev2-common.c | 220 ++++++++++++++++
 drivers/crypto/ti/dthev2-common.h | 101 ++++++++
 8 files changed, 752 insertions(+)
 create mode 100644 drivers/crypto/ti/Kconfig
 create mode 100644 drivers/crypto/ti/Makefile
 create mode 100644 drivers/crypto/ti/dthev2-aes.c
 create mode 100644 drivers/crypto/ti/dthev2-common.c
 create mode 100644 drivers/crypto/ti/dthev2-common.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5bb8ad7653..ca728cc24169 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25174,6 +25174,7 @@ M:	T Pratham <t-pratham@ti.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/crypto/ti,am62l-dthev2.yaml
+F:	drivers/crypto/ti/
 
 TI DAVINCI MACHINE SUPPORT
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 04b4c43b6bae..f056ec58c96e 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -863,5 +863,6 @@ config CRYPTO_DEV_SA2UL
 source "drivers/crypto/aspeed/Kconfig"
 source "drivers/crypto/starfive/Kconfig"
 source "drivers/crypto/inside-secure/eip93/Kconfig"
+source "drivers/crypto/ti/Kconfig"
 
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 22eadcc8f4a2..c0e8d4acc37c 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -48,3 +48,4 @@ obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += intel/
 obj-y += starfive/
 obj-y += cavium/
+obj-$(CONFIG_ARCH_K3) += ti/
diff --git a/drivers/crypto/ti/Kconfig b/drivers/crypto/ti/Kconfig
new file mode 100644
index 000000000000..38d22cab05a9
--- /dev/null
+++ b/drivers/crypto/ti/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config CRYPTO_DEV_TI_DTHEV2
+	tristate "Support for TI DTHE V2 cryptography engine"
+	depends on CRYPTO && CRYPTO_HW && ARCH_K3
+	select CRYPTO_ENGINE
+	select CRYPTO_SKCIPHER
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	help
+	  This enables support for the TI DTHE V2 hw cryptography engine
+	  which can be found on TI K3 SOCs. Selecting this enables use
+	  of hardware offloading for cryptographic algorithms on
+	  these devices, providing enhanced resistance against side-channel
+	  attacks.
diff --git a/drivers/crypto/ti/Makefile b/drivers/crypto/ti/Makefile
new file mode 100644
index 000000000000..b883078f203d
--- /dev/null
+++ b/drivers/crypto/ti/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_CRYPTO_DEV_TI_DTHEV2) += dthev2.o
+dthev2-objs := dthev2-common.o dthev2-aes.o
diff --git a/drivers/crypto/ti/dthev2-aes.c b/drivers/crypto/ti/dthev2-aes.c
new file mode 100644
index 000000000000..0431a36d8c4a
--- /dev/null
+++ b/drivers/crypto/ti/dthev2-aes.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * K3 DTHE V2 crypto accelerator driver
+ *
+ * Copyright (C) Texas Instruments 2025 - https://www.ti.com
+ * Author: T Pratham <t-pratham@ti.com>
+ */
+
+#include <crypto/aead.h>
+#include <crypto/aes.h>
+#include <crypto/algapi.h>
+#include <crypto/engine.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
+
+#include "dthev2-common.h"
+
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/scatterlist.h>
+
+/* Registers */
+
+// AES Engine
+#define DTHE_P_AES_BASE		0x7000
+#define DTHE_P_AES_KEY1_0	0x0038
+#define DTHE_P_AES_KEY1_1	0x003C
+#define DTHE_P_AES_KEY1_2	0x0030
+#define DTHE_P_AES_KEY1_3	0x0034
+#define DTHE_P_AES_KEY1_4	0x0028
+#define DTHE_P_AES_KEY1_5	0x002C
+#define DTHE_P_AES_KEY1_6	0x0020
+#define DTHE_P_AES_KEY1_7	0x0024
+#define DTHE_P_AES_IV_IN_0	0x0040
+#define DTHE_P_AES_IV_IN_1	0x0044
+#define DTHE_P_AES_IV_IN_2	0x0048
+#define DTHE_P_AES_IV_IN_3	0x004C
+#define DTHE_P_AES_CTRL		0x0050
+#define DTHE_P_AES_C_LENGTH_0	0x0054
+#define DTHE_P_AES_C_LENGTH_1	0x0058
+#define DTHE_P_AES_AUTH_LENGTH	0x005C
+#define DTHE_P_AES_DATA_IN_OUT	0x0060
+
+#define DTHE_P_AES_SYSCONFIG	0x0084
+#define DTHE_P_AES_IRQSTATUS	0x008C
+#define DTHE_P_AES_IRQENABLE	0x0090
+
+/* Register write values and macros */
+
+enum aes_ctrl_mode_masks {
+	AES_CTRL_ECB_MASK = 0x00,
+	AES_CTRL_CBC_MASK = BIT(5),
+};
+
+#define DTHE_AES_CTRL_MODE_CLEAR_MASK		~GENMASK(28, 5)
+
+#define DTHE_AES_CTRL_DIR_ENC			BIT(2)
+
+#define DTHE_AES_CTRL_KEYSIZE_16B		BIT(3)
+#define DTHE_AES_CTRL_KEYSIZE_24B		BIT(4)
+#define DTHE_AES_CTRL_KEYSIZE_32B		(BIT(3) | BIT(4))
+
+#define DTHE_AES_CTRL_SAVE_CTX_SET		BIT(29)
+
+#define DTHE_AES_CTRL_OUTPUT_READY		BIT_MASK(0)
+#define DTHE_AES_CTRL_INPUT_READY		BIT_MASK(1)
+#define DTHE_AES_CTRL_SAVED_CTX_READY		BIT_MASK(30)
+#define DTHE_AES_CTRL_CTX_READY			BIT_MASK(31)
+
+#define DTHE_AES_SYSCONFIG_DMA_DATA_IN_OUT_EN	GENMASK(6, 5)
+#define DTHE_AES_IRQENABLE_EN_ALL		GENMASK(3, 0)
+
+/* Misc */
+#define AES_IV_SIZE				AES_BLOCK_SIZE
+#define AES_BLOCK_WORDS				(AES_BLOCK_SIZE / sizeof(u32))
+#define AES_IV_WORDS				AES_BLOCK_WORDS
+
+static int dthe_cipher_init_tfm(struct crypto_skcipher *tfm)
+{
+	struct dthe_tfm_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct dthe_data *dev_data = dthe_get_dev(ctx);
+
+	ctx->dev_data = dev_data;
+	ctx->keylen = 0;
+
+	return 0;
+}
+
+static int dthe_aes_setkey(struct crypto_skcipher *tfm, const u8 *key, unsigned int keylen)
+{
+	struct dthe_tfm_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 && keylen != AES_KEYSIZE_256)
+		return -EINVAL;
+
+	ctx->keylen = keylen;
+	memcpy(ctx->key, key, keylen);
+
+	return 0;
+}
+
+static int dthe_aes_ecb_setkey(struct crypto_skcipher *tfm, const u8 *key, unsigned int keylen)
+{
+	struct dthe_tfm_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	ctx->aes_mode = DTHE_AES_ECB;
+
+	return dthe_aes_setkey(tfm, key, keylen);
+}
+
+static int dthe_aes_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key, unsigned int keylen)
+{
+	struct dthe_tfm_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	ctx->aes_mode = DTHE_AES_CBC;
+
+	return dthe_aes_setkey(tfm, key, keylen);
+}
+
+static void dthe_aes_set_ctrl_key(struct dthe_tfm_ctx *ctx,
+				  struct dthe_aes_req_ctx *rctx,
+				  u32 *iv_in)
+{
+	struct dthe_data *dev_data = dthe_get_dev(ctx);
+	void __iomem *aes_base_reg = dev_data->regs + DTHE_P_AES_BASE;
+	u32 ctrl_val = 0;
+
+	writel_relaxed(ctx->key[0], aes_base_reg + DTHE_P_AES_KEY1_0);
+	writel_relaxed(ctx->key[1], aes_base_reg + DTHE_P_AES_KEY1_1);
+	writel_relaxed(ctx->key[2], aes_base_reg + DTHE_P_AES_KEY1_2);
+	writel_relaxed(ctx->key[3], aes_base_reg + DTHE_P_AES_KEY1_3);
+
+	if (ctx->keylen > AES_KEYSIZE_128) {
+		writel_relaxed(ctx->key[4], aes_base_reg + DTHE_P_AES_KEY1_4);
+		writel_relaxed(ctx->key[5], aes_base_reg + DTHE_P_AES_KEY1_5);
+	}
+	if (ctx->keylen == AES_KEYSIZE_256) {
+		writel_relaxed(ctx->key[6], aes_base_reg + DTHE_P_AES_KEY1_6);
+		writel_relaxed(ctx->key[7], aes_base_reg + DTHE_P_AES_KEY1_7);
+	}
+
+	if (rctx->enc)
+		ctrl_val |= DTHE_AES_CTRL_DIR_ENC;
+
+	if (ctx->keylen == AES_KEYSIZE_128)
+		ctrl_val |= DTHE_AES_CTRL_KEYSIZE_16B;
+	else if (ctx->keylen == AES_KEYSIZE_192)
+		ctrl_val |= DTHE_AES_CTRL_KEYSIZE_24B;
+	else
+		ctrl_val |= DTHE_AES_CTRL_KEYSIZE_32B;
+
+	// Write AES mode
+	ctrl_val &= DTHE_AES_CTRL_MODE_CLEAR_MASK;
+	switch (ctx->aes_mode) {
+	case DTHE_AES_ECB:
+		ctrl_val |= AES_CTRL_ECB_MASK;
+		break;
+	case DTHE_AES_CBC:
+		ctrl_val |= AES_CTRL_CBC_MASK;
+		break;
+	}
+
+	if (iv_in) {
+		ctrl_val |= DTHE_AES_CTRL_SAVE_CTX_SET;
+		for (int i = 0; i < AES_IV_WORDS; ++i)
+			writel_relaxed(iv_in[i],
+				       aes_base_reg + DTHE_P_AES_IV_IN_0 + (DTHE_REG_SIZE * i));
+	}
+
+	writel_relaxed(ctrl_val, aes_base_reg + DTHE_P_AES_CTRL);
+}
+
+static void dthe_aes_dma_in_callback(void *data)
+{
+	struct skcipher_request *req = (struct skcipher_request *)data;
+	struct dthe_aes_req_ctx *rctx = skcipher_request_ctx(req);
+
+	complete(&rctx->aes_compl);
+}
+
+static int dthe_aes_run(struct crypto_engine *engine, void *areq)
+{
+	struct skcipher_request *req = container_of(areq, struct skcipher_request, base);
+	struct dthe_tfm_ctx *ctx = crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct dthe_data *dev_data = dthe_get_dev(ctx);
+	struct dthe_aes_req_ctx *rctx = skcipher_request_ctx(req);
+
+	unsigned int len = req->cryptlen;
+	struct scatterlist *src = req->src;
+	struct scatterlist *dst = req->dst;
+
+	int src_nents = sg_nents_for_len(src, len);
+	int dst_nents;
+
+	int src_mapped_nents;
+	int dst_mapped_nents;
+
+	bool diff_dst;
+	enum dma_data_direction src_dir, dst_dir;
+
+	struct device *tx_dev, *rx_dev;
+	struct dma_async_tx_descriptor *desc_in, *desc_out;
+
+	int ret;
+
+	void __iomem *aes_base_reg = dev_data->regs + DTHE_P_AES_BASE;
+
+	u32 aes_irqenable_val = readl_relaxed(aes_base_reg + DTHE_P_AES_IRQENABLE);
+	u32 aes_sysconfig_val = readl_relaxed(aes_base_reg + DTHE_P_AES_SYSCONFIG);
+
+	aes_sysconfig_val |= DTHE_AES_SYSCONFIG_DMA_DATA_IN_OUT_EN;
+	writel_relaxed(aes_sysconfig_val, aes_base_reg + DTHE_P_AES_SYSCONFIG);
+
+	aes_irqenable_val |= DTHE_AES_IRQENABLE_EN_ALL;
+	writel_relaxed(aes_irqenable_val, aes_base_reg + DTHE_P_AES_IRQENABLE);
+
+	if (src == dst) {
+		diff_dst = false;
+		src_dir = DMA_BIDIRECTIONAL;
+		dst_dir = DMA_BIDIRECTIONAL;
+	} else {
+		diff_dst = true;
+		src_dir = DMA_TO_DEVICE;
+		dst_dir  = DMA_FROM_DEVICE;
+	}
+
+	tx_dev = dmaengine_get_dma_device(dev_data->dma_aes_tx);
+	rx_dev = dmaengine_get_dma_device(dev_data->dma_aes_rx);
+
+	src_mapped_nents = dma_map_sg(tx_dev, src, src_nents, src_dir);
+	if (src_mapped_nents == 0) {
+		ret = -EINVAL;
+		goto aes_err;
+	}
+
+	if (!diff_dst) {
+		dst_nents = src_nents;
+		dst_mapped_nents = src_mapped_nents;
+	} else {
+		dst_nents = sg_nents_for_len(dst, len);
+		dst_mapped_nents = dma_map_sg(rx_dev, dst, dst_nents, dst_dir);
+		if (dst_mapped_nents == 0) {
+			dma_unmap_sg(tx_dev, src, src_nents, src_dir);
+			ret = -EINVAL;
+			goto aes_err;
+		}
+	}
+
+	desc_in = dmaengine_prep_slave_sg(dev_data->dma_aes_rx, dst, dst_mapped_nents,
+					  DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_in) {
+		dev_err(dev_data->dev, "IN prep_slave_sg() failed\n");
+		ret = -EINVAL;
+		goto aes_prep_err;
+	}
+
+	desc_out = dmaengine_prep_slave_sg(dev_data->dma_aes_tx, src, src_mapped_nents,
+					   DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_out) {
+		dev_err(dev_data->dev, "OUT prep_slave_sg() failed\n");
+		ret = -EINVAL;
+		goto aes_prep_err;
+	}
+
+	desc_in->callback = dthe_aes_dma_in_callback;
+	desc_in->callback_param = req;
+
+	init_completion(&rctx->aes_compl);
+
+	if (ctx->aes_mode == DTHE_AES_ECB)
+		dthe_aes_set_ctrl_key(ctx, rctx, NULL);
+	else
+		dthe_aes_set_ctrl_key(ctx, rctx, (u32 *)req->iv);
+
+	writel_relaxed(lower_32_bits(req->cryptlen), aes_base_reg + DTHE_P_AES_C_LENGTH_0);
+	writel_relaxed(upper_32_bits(req->cryptlen), aes_base_reg + DTHE_P_AES_C_LENGTH_1);
+
+	dmaengine_submit(desc_in);
+	dmaengine_submit(desc_out);
+
+	dma_async_issue_pending(dev_data->dma_aes_rx);
+	dma_async_issue_pending(dev_data->dma_aes_tx);
+
+	// Need to do a timeout to ensure finalise gets called if DMA callback fails for any reason
+	ret = wait_for_completion_timeout(&rctx->aes_compl, msecs_to_jiffies(DTHE_DMA_TIMEOUT_MS));
+	if (!ret) {
+		ret = -ETIMEDOUT;
+		dmaengine_terminate_sync(dev_data->dma_aes_rx);
+		dmaengine_terminate_sync(dev_data->dma_aes_tx);
+
+		for (int i = 0; i < AES_BLOCK_WORDS; ++i)
+			readl_relaxed(aes_base_reg + DTHE_P_AES_DATA_IN_OUT + (DTHE_REG_SIZE * i));
+	} else {
+		ret = 0;
+	}
+
+	// For modes other than ECB, read IV_OUT
+	if (ctx->aes_mode != DTHE_AES_ECB) {
+		u32 *iv_out = (u32 *)req->iv;
+
+		for (int i = 0; i < AES_IV_WORDS; ++i)
+			iv_out[i] = readl_relaxed(aes_base_reg +
+						  DTHE_P_AES_IV_IN_0 +
+						  (DTHE_REG_SIZE * i));
+	}
+
+aes_prep_err:
+	dma_unmap_sg(tx_dev, src, src_nents, src_dir);
+	if (dst_dir != DMA_BIDIRECTIONAL)
+		dma_unmap_sg(rx_dev, dst, dst_nents, dst_dir);
+
+aes_err:
+	local_bh_disable();
+	crypto_finalize_skcipher_request(dev_data->engine, req, ret);
+	local_bh_enable();
+	return ret;
+}
+
+static int dthe_aes_crypt(struct skcipher_request *req)
+{
+	struct dthe_tfm_ctx *ctx = crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct dthe_data *dev_data = dthe_get_dev(ctx);
+	struct crypto_engine *engine;
+
+	/*
+	 * If data is not a multiple of AES_BLOCK_SIZE, need to return -EINVAL
+	 * If data length input is zero, no need to do any operation.
+	 */
+	if (req->cryptlen % AES_BLOCK_SIZE)
+		return -EINVAL;
+
+	if (req->cryptlen == 0)
+		return 0;
+
+	engine = dev_data->engine;
+	return crypto_transfer_skcipher_request_to_engine(engine, req);
+}
+
+static int dthe_aes_encrypt(struct skcipher_request *req)
+{
+	struct dthe_aes_req_ctx *rctx = skcipher_request_ctx(req);
+
+	rctx->enc = 1;
+	return dthe_aes_crypt(req);
+}
+
+static int dthe_aes_decrypt(struct skcipher_request *req)
+{
+	struct dthe_aes_req_ctx *rctx = skcipher_request_ctx(req);
+
+	rctx->enc = 0;
+	return dthe_aes_crypt(req);
+}
+
+static struct skcipher_engine_alg cipher_algs[] = {
+	{
+		.base.init			= dthe_cipher_init_tfm,
+		.base.setkey			= dthe_aes_ecb_setkey,
+		.base.encrypt			= dthe_aes_encrypt,
+		.base.decrypt			= dthe_aes_decrypt,
+		.base.min_keysize		= AES_MIN_KEY_SIZE,
+		.base.max_keysize		= AES_MAX_KEY_SIZE,
+		.base.base = {
+			.cra_name		= "ecb(aes)",
+			.cra_driver_name	= "ecb-aes-dthev2",
+			.cra_priority		= 299,
+			.cra_flags		= CRYPTO_ALG_TYPE_SKCIPHER |
+						  CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_alignmask		= AES_BLOCK_SIZE - 1,
+			.cra_blocksize		= AES_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct dthe_tfm_ctx),
+			.cra_reqsize		= sizeof(struct dthe_aes_req_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.op.do_one_request = dthe_aes_run,
+	}, /* ECB AES */
+	{
+		.base.init			= dthe_cipher_init_tfm,
+		.base.setkey			= dthe_aes_cbc_setkey,
+		.base.encrypt			= dthe_aes_encrypt,
+		.base.decrypt			= dthe_aes_decrypt,
+		.base.min_keysize		= AES_MIN_KEY_SIZE,
+		.base.max_keysize		= AES_MAX_KEY_SIZE,
+		.base.ivsize			= AES_IV_SIZE,
+		.base.base = {
+			.cra_name		= "cbc(aes)",
+			.cra_driver_name	= "cbc-aes-dthev2",
+			.cra_priority		= 299,
+			.cra_flags		= CRYPTO_ALG_TYPE_SKCIPHER |
+						  CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_alignmask		= AES_BLOCK_SIZE - 1,
+			.cra_blocksize		= AES_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct dthe_tfm_ctx),
+			.cra_reqsize		= sizeof(struct dthe_aes_req_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.op.do_one_request = dthe_aes_run,
+	} /* CBC AES */
+};
+
+int dthe_register_aes_algs(void)
+{
+	return crypto_engine_register_skciphers(cipher_algs, ARRAY_SIZE(cipher_algs));
+}
+
+void dthe_unregister_aes_algs(void)
+{
+	crypto_engine_unregister_skciphers(cipher_algs, ARRAY_SIZE(cipher_algs));
+}
diff --git a/drivers/crypto/ti/dthev2-common.c b/drivers/crypto/ti/dthev2-common.c
new file mode 100644
index 000000000000..4d5b59d3ef1f
--- /dev/null
+++ b/drivers/crypto/ti/dthev2-common.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * K3 DTHE V2 crypto accelerator driver
+ *
+ * Copyright (C) Texas Instruments 2025 - https://www.ti.com
+ * Author: T Pratham <t-pratham@ti.com>
+ */
+
+#include <crypto/aes.h>
+#include <crypto/algapi.h>
+#include <crypto/engine.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
+
+#include "dthev2-common.h"
+
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+
+#define DRIVER_NAME	"dthev2"
+
+static struct dthe_list dthe_dev_list = {
+	.dev_list = LIST_HEAD_INIT(dthe_dev_list.dev_list),
+	.lock = __SPIN_LOCK_UNLOCKED(dthe_dev_list.lock),
+};
+
+struct dthe_data *dthe_get_dev(struct dthe_tfm_ctx *ctx)
+{
+	struct dthe_data *dev_data;
+
+	if (ctx->dev_data)
+		return ctx->dev_data;
+
+	spin_lock_bh(&dthe_dev_list.lock);
+	dev_data = list_first_entry(&dthe_dev_list.dev_list, struct dthe_data, list);
+	if (dev_data)
+		list_move_tail(&dev_data->list, &dthe_dev_list.dev_list);
+	spin_unlock_bh(&dthe_dev_list.lock);
+
+	return dev_data;
+}
+
+static int dthe_dma_init(struct dthe_data *dev_data)
+{
+	int ret;
+	struct dma_slave_config cfg;
+
+	dev_data->dma_aes_rx = NULL;
+	dev_data->dma_aes_tx = NULL;
+	dev_data->dma_sha_tx = NULL;
+
+	dev_data->dma_aes_rx = dma_request_chan(dev_data->dev, "rx");
+	if (IS_ERR(dev_data->dma_aes_rx)) {
+		return dev_err_probe(dev_data->dev, PTR_ERR(dev_data->dma_aes_rx),
+				     "Unable to request rx DMA channel\n");
+	}
+
+	dev_data->dma_aes_tx = dma_request_chan(dev_data->dev, "tx1");
+	if (IS_ERR(dev_data->dma_aes_tx)) {
+		ret = dev_err_probe(dev_data->dev, PTR_ERR(dev_data->dma_aes_tx),
+				    "Unable to request tx1 DMA channel\n");
+		goto err_dma_aes_tx;
+	}
+
+	dev_data->dma_sha_tx = dma_request_chan(dev_data->dev, "tx2");
+	if (IS_ERR(dev_data->dma_sha_tx)) {
+		ret = dev_err_probe(dev_data->dev, PTR_ERR(dev_data->dma_sha_tx),
+				    "Unable to request tx2 DMA channel\n");
+		goto err_dma_sha_tx;
+	}
+
+	memzero_explicit(&cfg, sizeof(cfg));
+
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.src_maxburst = 4;
+
+	ret = dmaengine_slave_config(dev_data->dma_aes_rx, &cfg);
+	if (ret) {
+		dev_err(dev_data->dev, "Can't configure IN dmaengine slave: %d\n", ret);
+		goto err_dma_config;
+	}
+
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_maxburst = 4;
+
+	ret = dmaengine_slave_config(dev_data->dma_aes_tx, &cfg);
+	if (ret) {
+		dev_err(dev_data->dev, "Can't configure OUT dmaengine slave: %d\n", ret);
+		goto err_dma_config;
+	}
+
+	return 0;
+
+err_dma_config:
+	dma_release_channel(dev_data->dma_sha_tx);
+err_dma_sha_tx:
+	dma_release_channel(dev_data->dma_aes_tx);
+err_dma_aes_tx:
+	dma_release_channel(dev_data->dma_aes_rx);
+
+	return ret;
+}
+
+static int dthe_register_algs(void)
+{
+	return dthe_register_aes_algs();
+}
+
+static void dthe_unregister_algs(void)
+{
+	dthe_unregister_aes_algs();
+}
+
+static int dthe_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dthe_data *dev_data;
+	int ret;
+
+	dev_data = devm_kzalloc(dev, sizeof(*dev_data), GFP_KERNEL);
+	if (!dev_data)
+		return -ENOMEM;
+
+	dev_data->dev = dev;
+	dev_data->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dev_data->regs))
+		return PTR_ERR(dev_data->regs);
+
+	platform_set_drvdata(pdev, dev_data);
+
+	spin_lock(&dthe_dev_list.lock);
+	list_add(&dev_data->list, &dthe_dev_list.dev_list);
+	spin_unlock(&dthe_dev_list.lock);
+
+	ret = dthe_dma_init(dev_data);
+	if (ret)
+		goto probe_dma_err;
+
+	dev_data->engine = crypto_engine_alloc_init(dev, 1);
+	if (!dev_data->engine) {
+		ret = -ENOMEM;
+		goto probe_engine_err;
+	}
+
+	ret = crypto_engine_start(dev_data->engine);
+	if (ret) {
+		dev_err(dev, "Failed to start crypto engine\n");
+		goto probe_engine_start_err;
+	}
+
+	ret = dthe_register_algs();
+	if (ret) {
+		dev_err(dev, "Failed to register algs\n");
+		goto probe_reg_err;
+	}
+
+	return 0;
+
+probe_reg_err:
+	crypto_engine_stop(dev_data->engine);
+probe_engine_start_err:
+	crypto_engine_exit(dev_data->engine);
+probe_engine_err:
+	dma_release_channel(dev_data->dma_aes_rx);
+	dma_release_channel(dev_data->dma_aes_tx);
+	dma_release_channel(dev_data->dma_sha_tx);
+probe_dma_err:
+	spin_lock(&dthe_dev_list.lock);
+	list_del(&dev_data->list);
+	spin_unlock(&dthe_dev_list.lock);
+
+	return ret;
+}
+
+static void dthe_remove(struct platform_device *pdev)
+{
+	struct dthe_data *dev_data = platform_get_drvdata(pdev);
+
+	spin_lock(&dthe_dev_list.lock);
+	list_del(&dev_data->list);
+	spin_unlock(&dthe_dev_list.lock);
+
+	dthe_unregister_algs();
+
+	crypto_engine_stop(dev_data->engine);
+	crypto_engine_exit(dev_data->engine);
+
+	dma_release_channel(dev_data->dma_aes_rx);
+	dma_release_channel(dev_data->dma_aes_tx);
+	dma_release_channel(dev_data->dma_sha_tx);
+}
+
+static const struct of_device_id dthe_of_match[] = {
+	{ .compatible = "ti,am62l-dthev2", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dthe_of_match);
+
+static struct platform_driver dthe_driver = {
+	.probe	= dthe_probe,
+	.remove	= dthe_remove,
+	.driver = {
+		.name		= DRIVER_NAME,
+		.of_match_table	= dthe_of_match,
+	},
+};
+
+module_platform_driver(dthe_driver);
+
+MODULE_AUTHOR("T Pratham <t-pratham@ti.com>");
+MODULE_DESCRIPTION("Texas Instruments DTHE V2 driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/ti/dthev2-common.h b/drivers/crypto/ti/dthev2-common.h
new file mode 100644
index 000000000000..68c94acda8aa
--- /dev/null
+++ b/drivers/crypto/ti/dthev2-common.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * K3 DTHE V2 crypto accelerator driver
+ *
+ * Copyright (C) Texas Instruments 2025 - https://www.ti.com
+ * Author: T Pratham <t-pratham@ti.com>
+ */
+
+#ifndef __TI_DTHEV2_H__
+#define __TI_DTHEV2_H__
+
+#include <crypto/aead.h>
+#include <crypto/aes.h>
+#include <crypto/algapi.h>
+#include <crypto/engine.h>
+#include <crypto/hash.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/skcipher.h>
+
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/scatterlist.h>
+
+#define DTHE_REG_SIZE		4
+#define DTHE_DMA_TIMEOUT_MS	2000
+
+enum dthe_aes_mode {
+	DTHE_AES_ECB = 0,
+	DTHE_AES_CBC,
+};
+
+/* Driver specific struct definitions */
+
+/**
+ * struct dthe_data - DTHE_V2 driver instance data
+ * @dev: Device pointer
+ * @regs: Base address of the register space
+ * @list: list node for dev
+ * @engine: Crypto engine instance
+ * @dma_aes_rx: AES Rx DMA Channel
+ * @dma_aes_tx: AES Tx DMA Channel
+ * @dma_sha_tx: SHA Tx DMA Channel
+ */
+struct dthe_data {
+	struct device *dev;
+	void __iomem *regs;
+	struct list_head list;
+	struct crypto_engine *engine;
+
+	struct dma_chan *dma_aes_rx;
+	struct dma_chan *dma_aes_tx;
+
+	struct dma_chan *dma_sha_tx;
+};
+
+/**
+ * struct dthe_list - device data list head
+ * @dev_list: linked list head
+ * @lock: Spinlock protecting accesses to the list
+ */
+struct dthe_list {
+	struct list_head dev_list;
+	spinlock_t lock;
+};
+
+/**
+ * struct dthe_tfm_ctx - Transform ctx struct containing ctx for all sub-components of DTHE V2
+ * @dev_data: Device data struct pointer
+ * @keylen: AES key length
+ * @key: AES key
+ * @aes_mode: AES mode
+ */
+struct dthe_tfm_ctx {
+	struct dthe_data *dev_data;
+	unsigned int keylen;
+	u32 key[AES_KEYSIZE_256 / sizeof(u32)];
+	enum dthe_aes_mode aes_mode;
+};
+
+/**
+ * struct dthe_aes_req_ctx - AES engine req ctx struct
+ * @enc: flag indicating encryption or decryption operation
+ * @aes_compl: Completion variable for use in manual completion in case of DMA callback failure
+ */
+struct dthe_aes_req_ctx {
+	int enc;
+	struct completion aes_compl;
+};
+
+/* Struct definitions end */
+
+struct dthe_data *dthe_get_dev(struct dthe_tfm_ctx *ctx);
+
+int dthe_register_aes_algs(void);
+void dthe_unregister_aes_algs(void);
+
+#endif
-- 
2.43.0


