Return-Path: <linux-kernel+bounces-860598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94C6BF07BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF9D3A811E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C822FB96D;
	Mon, 20 Oct 2025 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FPONONTu"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8F2FAC1E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955245; cv=none; b=MieMlsXsXWOf/bgo3nqSB0qFH2bImkCVhrezoo3IbKacAdr2m18SGKGIRlMtwK5UvhIPuf6avkTmyYzaSHelTRHv+oEbxPCnkIuCwvaM9UlujA3KmX0cQ8MMuVALvdGQ0aKiki41DfBmZa2kTh6cScp3b7zFu61Nzj2pRP6CofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955245; c=relaxed/simple;
	bh=8RyYfMa0gCTCjCsj5gpn/gbj5bBb2rdSiCdY8PgxtDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NagjrDOVFB+JMWrppzKfRDjcrOcSrBpbeij51J0FjOuEGcxom43TwwDV3F1c4eJnt4eCtHHEumpGtvB3Ndj3yCXuORT3QDXYIuHuyUd/Z/Q71/jEZSMHxdpBYDUXObWRqy9lcZ/r42uXkxDXIJ9Apsalq1DOATYM+jOkFO3r1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FPONONTu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 07304C0AFE3;
	Mon, 20 Oct 2025 10:13:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8CD3A606D5;
	Mon, 20 Oct 2025 10:14:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 045D3102F23BA;
	Mon, 20 Oct 2025 12:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760955240; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=O08ZQU7nzCm/CtBp+vh3SNifDt7t1M3uvSj4nDW/Pxk=;
	b=FPONONTu17DwjtFqnXc2CrtRVoFYP3Z81o35ENOszAxPICHAYiYlmpSFlBqtMJJTxAADye
	LjORyswaTFoo3p4deGa0ec0V0qtrz0fNgEvpmCjwOHUhq0QX85bI+YdfUUR8jkPMiY0u0F
	ilj70weAte5mxiRn+N8+vQUZF6AZXIqT0gLh6NJl60h134joxd0XLm1DybV4ceZWzA623R
	jDddQn4sRbQuFQdUyVG3rK5G0EU5scwMMQV++vLxUrFyCBWHOc4/i3slBwr74gALWja+nf
	gCHJy0OQkRQyZTb+nsZ1FYy+NFRRrhR7GAry/a3fOVLVoZee8FVSHXMAllxZjg==
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
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 08/15] mtd: rawnand: sunxi: introduce random en/dir in sunxi_nfc_caps
Date: Mon, 20 Oct 2025 12:13:04 +0200
Message-ID: <20251020101311.256819-9-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020101311.256819-1-richard.genoud@bootlin.com>
References: <20251020101311.256819-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The H6/H616 RANDOM EN/DIRECTION masks are different from A10/A23.
So move the masks into sunxi_nfc_caps.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 4118307cac15..3ccb7ea7cf17 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -144,8 +144,8 @@
 #define NFC_ECC_EXCEPTION	BIT(4)
 #define NFC_ECC_BLOCK_SIZE_MSK	BIT(5)
 #define NFC_ECC_BLOCK_512	BIT(5)
-#define NFC_RANDOM_EN		BIT(9)
-#define NFC_RANDOM_DIRECTION	BIT(10)
+#define NFC_RANDOM_EN(nfc)	(nfc->caps->random_en_mask)
+#define NFC_RANDOM_DIRECTION(nfc) (nfc->caps->random_dir_mask)
 #define NFC_ECC_MODE_MSK(nfc)	(nfc->caps->ecc_mode_mask)
 #define NFC_ECC_MODE(nfc, x)	field_prep(NFC_ECC_MODE_MSK(nfc), (x))
 #define NFC_RANDOM_SEED_MSK	GENMASK(30, 16)
@@ -228,6 +228,8 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
  * @reg_pat_found:	Data Pattern Status Register
+ * @random_en_mask:	RANDOM_EN mask in NFC_ECC_CTL register
+ * @random_dir_mask:	RANDOM_DIRECTION mask in NFC_ECC_CTL register
  * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @dma_maxburst:	DMA maxburst
@@ -241,6 +243,8 @@ struct sunxi_nfc_caps {
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
 	unsigned int reg_pat_found;
+	unsigned int random_en_mask;
+	unsigned int random_dir_mask;
 	unsigned int ecc_mode_mask;
 	unsigned int pat_found_mask;
 	unsigned int dma_maxburst;
@@ -669,7 +673,7 @@ static void sunxi_nfc_randomizer_enable(struct nand_chip *nand)
 	if (!(nand->options & NAND_NEED_SCRAMBLING))
 		return;
 
-	writel(readl(nfc->regs + NFC_REG_ECC_CTL) | NFC_RANDOM_EN,
+	writel(readl(nfc->regs + NFC_REG_ECC_CTL) | NFC_RANDOM_EN(nfc),
 	       nfc->regs + NFC_REG_ECC_CTL);
 }
 
@@ -680,7 +684,7 @@ static void sunxi_nfc_randomizer_disable(struct nand_chip *nand)
 	if (!(nand->options & NAND_NEED_SCRAMBLING))
 		return;
 
-	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_RANDOM_EN,
+	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_RANDOM_EN(nfc),
 	       nfc->regs + NFC_REG_ECC_CTL);
 }
 
@@ -2220,6 +2224,8 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.reg_pat_found = NFC_REG_ECC_ST,
+	.random_en_mask = BIT(9),
+	.random_dir_mask = BIT(10),
 	.ecc_mode_mask = GENMASK(15, 12),
 	.pat_found_mask = GENMASK(31, 16),
 	.dma_maxburst = 4,
@@ -2234,6 +2240,8 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.reg_pat_found = NFC_REG_ECC_ST,
+	.random_en_mask = BIT(9),
+	.random_dir_mask = BIT(10),
 	.ecc_mode_mask = GENMASK(15, 12),
 	.pat_found_mask = GENMASK(31, 16),
 	.dma_maxburst = 8,

