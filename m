Return-Path: <linux-kernel+bounces-806015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE05B490C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06A9176565
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0526D30C621;
	Mon,  8 Sep 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GhCxc0GY"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61A1E260A;
	Mon,  8 Sep 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340605; cv=none; b=jFTwzIWMLVnkf9dcR3XKwZC2H20PMv93rFFsz0oOd4nQdir8fnFnIXn+nPrxjiu+94osbZuiL153kt1aRVsn1IykWZX6XyE5OCzSlgXxeIXB9qGXvImgLgDB/8ZRUbVArQlimJnLrqMMlBIR404N6oMviNK/1bEURFbgyKQ6XGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340605; c=relaxed/simple;
	bh=X06+KYf7g5G3DpMRgGYFx2n380X1Eq8wDc0QXAPf2Lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCBsgj+g5CDrzW5P2gdzDK47WDUS7S2DuN9GDY4mOR03AhizS9IKG2xbif66uoUZfzeNQlE33cg5cQCHHuOAcAF65sgNaqol8s7wmXv81G0V34JwqsNm5GUY6oVupD7ynOGFgT/A8dVj2FXaJ+884SKJTCEzFEDBNOe9E6a15/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GhCxc0GY; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588E9vfc066816;
	Mon, 8 Sep 2025 09:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757340597;
	bh=dNtpkaHyN6srN/vq/VvKfgni3NKEArpz7XSJccCF30M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GhCxc0GYPCJy+T2P7G3Q3CiKTBbsDogobcAuu2SOEbNCDci9C9YMJRfcQyaqrdhbW
	 rPou7ngHqPqzONe6Y/sVW8jkVDiraaztflg2do/0ZP6TRWgN/64I/CMECxxGj2Tpzy
	 Cun+liYD8LEfskzLQeRJY1POBGJZBaasW8C78yN8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588E9vbm3009109
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:09:57 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:09:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:09:57 -0500
Received: from pratham-Workstation-PC (pratham-workstation-pc.dhcp.ti.com [10.24.69.191])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588E9tqD1013827;
	Mon, 8 Sep 2025 09:09:56 -0500
From: T Pratham <t-pratham@ti.com>
To: T Pratham <t-pratham@ti.com>, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
        Kavitha Malarvizhi <k-malarvizhi@ti.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] crypto: ti: Add support for AES-XTS in DTHEv2 driver
Date: Mon, 8 Sep 2025 19:28:13 +0530
Message-ID: <20250908140928.2801062-2-t-pratham@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908140928.2801062-1-t-pratham@ti.com>
References: <20250908140928.2801062-1-t-pratham@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add support for XTS mode of operation for AES algorithm in the AES
Engine of the DTHEv2 hardware cryptographic engine.

Signed-off-by: T Pratham <t-pratham@ti.com>
---
 drivers/crypto/ti/Kconfig         |  1 +
 drivers/crypto/ti/dthev2-aes.c    | 73 ++++++++++++++++++++++++++++++-
 drivers/crypto/ti/dthev2-common.h |  8 +++-
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ti/Kconfig b/drivers/crypto/ti/Kconfig
index 38d22cab05a9..bdb7f652e093 100644
--- a/drivers/crypto/ti/Kconfig
+++ b/drivers/crypto/ti/Kconfig
@@ -6,6 +6,7 @@ config CRYPTO_DEV_TI_DTHEV2
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ECB
 	select CRYPTO_CBC
+	select CRYPTO_XTS
 	help
 	  This enables support for the TI DTHE V2 hw cryptography engine
 	  which can be found on TI K3 SOCs. Selecting this enables use
diff --git a/drivers/crypto/ti/dthev2-aes.c b/drivers/crypto/ti/dthev2-aes.c
index 0431a36d8c4a..21e7e5b8d6da 100644
--- a/drivers/crypto/ti/dthev2-aes.c
+++ b/drivers/crypto/ti/dthev2-aes.c
@@ -25,6 +25,7 @@
 
 // AES Engine
 #define DTHE_P_AES_BASE		0x7000
+
 #define DTHE_P_AES_KEY1_0	0x0038
 #define DTHE_P_AES_KEY1_1	0x003C
 #define DTHE_P_AES_KEY1_2	0x0030
@@ -33,6 +34,16 @@
 #define DTHE_P_AES_KEY1_5	0x002C
 #define DTHE_P_AES_KEY1_6	0x0020
 #define DTHE_P_AES_KEY1_7	0x0024
+
+#define DTHE_P_AES_KEY2_0	0x0018
+#define DTHE_P_AES_KEY2_1	0x001C
+#define DTHE_P_AES_KEY2_2	0x0010
+#define DTHE_P_AES_KEY2_3	0x0014
+#define DTHE_P_AES_KEY2_4	0x0008
+#define DTHE_P_AES_KEY2_5	0x000C
+#define DTHE_P_AES_KEY2_6	0x0000
+#define DTHE_P_AES_KEY2_7	0x0004
+
 #define DTHE_P_AES_IV_IN_0	0x0040
 #define DTHE_P_AES_IV_IN_1	0x0044
 #define DTHE_P_AES_IV_IN_2	0x0048
@@ -52,6 +63,7 @@
 enum aes_ctrl_mode_masks {
 	AES_CTRL_ECB_MASK = 0x00,
 	AES_CTRL_CBC_MASK = BIT(5),
+	AES_CTRL_XTS_MASK = BIT(12) | BIT(11),
 };
 
 #define DTHE_AES_CTRL_MODE_CLEAR_MASK		~GENMASK(28, 5)
@@ -119,6 +131,22 @@ static int dthe_aes_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key, unsig
 	return dthe_aes_setkey(tfm, key, keylen);
 }
 
+static int dthe_aes_xts_setkey(struct crypto_skcipher *tfm, const u8 *key, unsigned int keylen)
+{
+	struct dthe_tfm_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	if (keylen != 2 * AES_KEYSIZE_128 &&
+	    keylen != 2 * AES_KEYSIZE_192 &&
+	    keylen != 2 * AES_KEYSIZE_256)
+		return -EINVAL;
+
+	ctx->aes_mode = DTHE_AES_XTS;
+	ctx->keylen = keylen / 2;
+	memcpy(ctx->key, key, keylen);
+
+	return 0;
+}
+
 static void dthe_aes_set_ctrl_key(struct dthe_tfm_ctx *ctx,
 				  struct dthe_aes_req_ctx *rctx,
 				  u32 *iv_in)
@@ -141,6 +169,24 @@ static void dthe_aes_set_ctrl_key(struct dthe_tfm_ctx *ctx,
 		writel_relaxed(ctx->key[7], aes_base_reg + DTHE_P_AES_KEY1_7);
 	}
 
+	if (ctx->aes_mode == DTHE_AES_XTS) {
+		size_t key2_offset = ctx->keylen / sizeof(u32);
+
+		writel_relaxed(ctx->key[key2_offset + 0], aes_base_reg + DTHE_P_AES_KEY2_0);
+		writel_relaxed(ctx->key[key2_offset + 1], aes_base_reg + DTHE_P_AES_KEY2_1);
+		writel_relaxed(ctx->key[key2_offset + 2], aes_base_reg + DTHE_P_AES_KEY2_2);
+		writel_relaxed(ctx->key[key2_offset + 3], aes_base_reg + DTHE_P_AES_KEY2_3);
+
+		if (ctx->keylen > AES_KEYSIZE_128) {
+			writel_relaxed(ctx->key[key2_offset + 4], aes_base_reg + DTHE_P_AES_KEY2_4);
+			writel_relaxed(ctx->key[key2_offset + 5], aes_base_reg + DTHE_P_AES_KEY2_5);
+		}
+		if (ctx->keylen == AES_KEYSIZE_256) {
+			writel_relaxed(ctx->key[key2_offset + 6], aes_base_reg + DTHE_P_AES_KEY2_6);
+			writel_relaxed(ctx->key[key2_offset + 7], aes_base_reg + DTHE_P_AES_KEY2_7);
+		}
+	}
+
 	if (rctx->enc)
 		ctrl_val |= DTHE_AES_CTRL_DIR_ENC;
 
@@ -160,6 +206,9 @@ static void dthe_aes_set_ctrl_key(struct dthe_tfm_ctx *ctx,
 	case DTHE_AES_CBC:
 		ctrl_val |= AES_CTRL_CBC_MASK;
 		break;
+	case DTHE_AES_XTS:
+		ctrl_val |= AES_CTRL_XTS_MASK;
+		break;
 	}
 
 	if (iv_in) {
@@ -397,7 +446,29 @@ static struct skcipher_engine_alg cipher_algs[] = {
 			.cra_module		= THIS_MODULE,
 		},
 		.op.do_one_request = dthe_aes_run,
-	} /* CBC AES */
+	}, /* CBC AES */
+	{
+		.base.init			= dthe_cipher_init_tfm,
+		.base.setkey			= dthe_aes_xts_setkey,
+		.base.encrypt			= dthe_aes_encrypt,
+		.base.decrypt			= dthe_aes_decrypt,
+		.base.min_keysize		= AES_MIN_KEY_SIZE * 2,
+		.base.max_keysize		= AES_MAX_KEY_SIZE * 2,
+		.base.ivsize			= AES_IV_SIZE,
+		.base.base = {
+			.cra_name		= "xts(aes)",
+			.cra_driver_name	= "xts-aes-dthev2",
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
+	}, /* XTS AES */
 };
 
 int dthe_register_aes_algs(void)
diff --git a/drivers/crypto/ti/dthev2-common.h b/drivers/crypto/ti/dthev2-common.h
index 68c94acda8aa..e2d901e70fcc 100644
--- a/drivers/crypto/ti/dthev2-common.h
+++ b/drivers/crypto/ti/dthev2-common.h
@@ -27,10 +27,16 @@
 
 #define DTHE_REG_SIZE		4
 #define DTHE_DMA_TIMEOUT_MS	2000
+/*
+ * Size of largest possible key (of all algorithms) to be stored in dthe_tfm_ctx
+ * This is currently the keysize of XTS-AES-256 which is 512 bits (64 bytes)
+ */
+#define DTHE_MAX_KEYSIZE	(AES_KEYSIZE_256 * 2)
 
 enum dthe_aes_mode {
 	DTHE_AES_ECB = 0,
 	DTHE_AES_CBC,
+	DTHE_AES_XTS,
 };
 
 /* Driver specific struct definitions */
@@ -77,7 +83,7 @@ struct dthe_list {
 struct dthe_tfm_ctx {
 	struct dthe_data *dev_data;
 	unsigned int keylen;
-	u32 key[AES_KEYSIZE_256 / sizeof(u32)];
+	u32 key[DTHE_MAX_KEYSIZE / sizeof(u32)];
 	enum dthe_aes_mode aes_mode;
 };
 
-- 
2.43.0


