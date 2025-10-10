Return-Path: <linux-kernel+bounces-847973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B718BBCC2FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 636D1345F03
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F3D27F4C7;
	Fri, 10 Oct 2025 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pN/JGOoG"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13F8262FC7;
	Fri, 10 Oct 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085715; cv=none; b=jfieXp+O5G8FdKkacQOZGonDoGxKeUn2Dlse1tDnn54/zTsxe+j3ARb47wwj/2GQW6lrH38MQyVxgKYTglKSjHSrC/uU6Iuyu9ovMS8LInQwKItnjVgwr5tw8WMkfiSdPE13iDCexrybIz4nSFbPIm7Wx1FOLYnvbvpIu33w6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085715; c=relaxed/simple;
	bh=PAmMLdlHlDf9kXLMlDlAAQe/uJWmeCwtDPMFN4M+z9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNiycHkhONOhqdbVfdccyCKZgHCvV6QrNifccPGCxxjh7OIM+jXAT355In7nB3yZefucPAG/1fXeFnfuvxmgydIKLR7SY9uT2gz8CdS6b2TcVppylNAt4bD/1tsDy9jSJeaswFaKO7jpI22fCW3nvZKSeY/gFUk456cpriLRCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pN/JGOoG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7C54B1A127C;
	Fri, 10 Oct 2025 08:41:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5248B60667;
	Fri, 10 Oct 2025 08:41:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24F7C102F2209;
	Fri, 10 Oct 2025 10:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760085711; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ug8DN5qqvBSPg1if81HDH0CRKRkJC4yZjqyuWWY99Hk=;
	b=pN/JGOoG8Xj9231BwoYRxSD7dXu6I5hfmzQyNq3309OvCX8kR2uULLJW2YTxv6+WdFoBOw
	ATpWuwab/y6iBx0/FJYrHpm0JkS8WHLQ34RdrDTFesEr2Z0yarh3Pe//iks5rGNxo26V1U
	HlNJ4JRkHLPgKlgCRMcbVTxCsZPs9Q6sqE9CCGdOepiE/OcTZB/o6/mL3DY+9dwS3k8viG
	Oh/JsFTjfJwxD27wmHxbvSCYdy2lHqCBJuMPkTV4zt/zlPW2uw0z5JSjA3UOpvA7xm8LWm
	TBsrzkIC9QAEN9LpwE4eL3LXY3M/fZWG0ZjFq1i6vNcwoSjYy82DpXBhyjdsxA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 09/15] mtd: nand: sunxi: introduce ecc_mode_mask in sunxi_nfc_caps
Date: Fri, 10 Oct 2025 10:40:36 +0200
Message-ID: <20251010084042.341224-10-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010084042.341224-1-richard.genoud@bootlin.com>
References: <20251010084042.341224-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The H6/H616 ECC_MODE field is not at the same offset, and has not the
same size.
So move the mask into sunxi_nfc_caps.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 672e934444ca..3c21f54e8e3f 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -29,8 +29,9 @@
 #include <linux/iopoll.h>
 #include <linux/reset.h>
 
-/* non compile-time field get */
+/* non compile-time field get/prep */
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
 
 #define NFC_REG_CTL		0x0000
 #define NFC_REG_ST		0x0004
@@ -145,8 +146,8 @@
 #define NFC_ECC_BLOCK_512	BIT(5)
 #define NFC_RANDOM_EN		BIT(9)
 #define NFC_RANDOM_DIRECTION	BIT(10)
-#define NFC_ECC_MODE_MSK	GENMASK(15, 12)
-#define NFC_ECC_MODE(x)		((x) << 12)
+#define NFC_ECC_MODE_MSK(nfc)	(nfc->caps->ecc_mode_mask)
+#define NFC_ECC_MODE(nfc, x)	field_prep(NFC_ECC_MODE_MSK(nfc), (x))
 #define NFC_RANDOM_SEED_MSK	GENMASK(30, 16)
 #define NFC_RANDOM_SEED(x)	((x) << 16)
 
@@ -227,6 +228,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
  * @reg_pat_found:	Data Pattern Status Register
+ * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @dma_maxburst:	DMA maxburst
  * @ecc_strengths:	Available ECC strengths array
@@ -239,6 +241,7 @@ struct sunxi_nfc_caps {
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
 	unsigned int reg_pat_found;
+	unsigned int ecc_mode_mask;
 	unsigned int pat_found_mask;
 	unsigned int dma_maxburst;
 	const u8 *ecc_strengths;
@@ -1747,7 +1750,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	ecc->read_oob_raw = nand_read_oob_std;
 	ecc->write_oob_raw = nand_write_oob_std;
 
-	sunxi_nand->ecc.ecc_ctl = NFC_ECC_MODE(i) | NFC_ECC_EXCEPTION |
+	sunxi_nand->ecc.ecc_ctl = NFC_ECC_MODE(nfc, i) | NFC_ECC_EXCEPTION |
 				  NFC_ECC_PIPELINE | NFC_ECC_EN;
 
 	if (ecc->size == 512) {
@@ -2217,6 +2220,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.reg_pat_found = NFC_REG_ECC_ST,
+	.ecc_mode_mask = GENMASK(15, 12),
 	.pat_found_mask = GENMASK(31, 16),
 	.dma_maxburst = 4,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
@@ -2230,6 +2234,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.reg_pat_found = NFC_REG_ECC_ST,
+	.ecc_mode_mask = GENMASK(15, 12),
 	.pat_found_mask = GENMASK(31, 16),
 	.dma_maxburst = 8,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
-- 
2.47.3


