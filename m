Return-Path: <linux-kernel+bounces-860594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10704BF07B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524FA18937E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F122F8BC3;
	Mon, 20 Oct 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xob6Lfmk"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA52F7445
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955238; cv=none; b=bYsxsss7g68CUk0ZpWgyXmbv64otDfIZiPXgC3/KlDeQ1JAo8Nb8M7ZxKBkYPtfFwJ3dZAKADXl/hSUAbcWlMzVo1DguWfA/BcpN4VULZj/PVGa7hqwhhB9AEW82VfGU5Fl5zN2oWzP6lJ5xaqyXmg2kyCs4/5/MfDxcIT57Y/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955238; c=relaxed/simple;
	bh=sKdPTZKVDf9izgHjArzrMu00cTpmD5hXprgFF+zlBd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYwup0ZFKCqHpfie8T4CXngwozFiiZfl0IM4AknJuJS1C3UaidN3i/qGFOofX0I8IguRK4OdKut6BwWINdG0et02C8HlNJk3Bknv/fBkoeS0XXGEcBzbVswyRSTLgIc0D2ErnxS0R65KdprSrlYivxU+8JacvQgy3WcNdj3qsHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xob6Lfmk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 79D431A154B;
	Mon, 20 Oct 2025 10:13:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F586606D5;
	Mon, 20 Oct 2025 10:13:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0A33102F0848;
	Mon, 20 Oct 2025 12:13:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760955233; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WVNi494X9+FHAVQizYRHT85ozYcDOUl/u6KHDtPy1K4=;
	b=Xob6LfmkEnoUjVj+hfPxFoXxUsffTqAa6eshmbcjTVmoEYZZXoh+/2KnSp5o24WWudlIOk
	URMh/f9vVxEWhHAiVu5h2MtP14wSjKgZ2W/4eUfPG6X4kpUQQycIe9YiQ5CEAjjiNgmSLR
	1nw94UELD5dS4ZjlFc8W77Yc3i/o8dcv+eU99j7yiZt3jc+UoVg93rvik1dl3HISYxp6Rb
	3KNBloUQjgxDeN5HlRPvInVZcfb0ABfKW3RsvNziPYfidXMQcWCXeK513h9xKuUvjMdBkP
	Eet9+xyQk8IlUR42L52WBO/ZYRkvxpql5wGKA/liX+ZtsYcDB0tFOG2Wkapn8g==
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
Subject: [PATCH v3 04/15] mtd: rawnand: sunxi: introduce reg_user_data in sunxi_nfc_caps
Date: Mon, 20 Oct 2025 12:13:00 +0200
Message-ID: <20251020101311.256819-5-richard.genoud@bootlin.com>
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

The H6/H616 USER_DATA register is not at the same offset as the
A10/A23 one, so move its offset into sunxi_nfc_caps

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 0285e4d0ca7f..8f5d8df19e33 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -48,7 +48,8 @@
 #define NFC_REG_DEBUG		0x003C
 #define NFC_REG_A10_ECC_ERR_CNT	0x0040
 #define NFC_REG_ECC_ERR_CNT(nfc, x)	((nfc->caps->reg_ecc_err_cnt + (x)) & ~0x3)
-#define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
+#define NFC_REG_A10_USER_DATA	0x0050
+#define NFC_REG_USER_DATA(nfc, x)	(nfc->caps->reg_user_data + ((x) * 4))
 #define NFC_REG_SPARE_AREA	0x00A0
 #define NFC_REG_PAT_ID		0x00A4
 #define NFC_REG_MDMA_ADDR	0x00C0
@@ -214,6 +215,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  *			through MBUS on A23/A33 needs extra configuration.
  * @reg_io_data:	I/O data register
  * @reg_ecc_err_cnt:	ECC error counter register
+ * @reg_user_data:	User data register
  * @dma_maxburst:	DMA maxburst
  * @ecc_strengths:	Available ECC strengths array
  * @nstrengths:		Size of @ecc_strengths
@@ -222,6 +224,7 @@ struct sunxi_nfc_caps {
 	bool has_mdma;
 	unsigned int reg_io_data;
 	unsigned int reg_ecc_err_cnt;
+	unsigned int reg_user_data;
 	unsigned int dma_maxburst;
 	const u8 *ecc_strengths;
 	unsigned int nstrengths;
@@ -723,8 +726,8 @@ static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struct nand_chip *nand, u8 *oob,
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 
-	sunxi_nfc_user_data_to_buf(readl(nfc->regs + NFC_REG_USER_DATA(step)),
-				   oob);
+	sunxi_nfc_user_data_to_buf(readl(nfc->regs +
+					 NFC_REG_USER_DATA(nfc, step)), oob);
 
 	/* De-randomize the Bad Block Marker. */
 	if (bbm && (nand->options & NAND_NEED_SCRAMBLING))
@@ -746,7 +749,7 @@ static void sunxi_nfc_hw_ecc_set_prot_oob_bytes(struct nand_chip *nand,
 	}
 
 	writel(sunxi_nfc_buf_to_user_data(oob),
-	       nfc->regs + NFC_REG_USER_DATA(step));
+	       nfc->regs + NFC_REG_USER_DATA(nfc, step));
 }
 
 static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
@@ -2181,6 +2184,7 @@ static const u8 sunxi_ecc_strengths_a10[] = {
 static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_io_data = NFC_REG_A10_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
+	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.dma_maxburst = 4,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
@@ -2190,6 +2194,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.has_mdma = true,
 	.reg_io_data = NFC_REG_A23_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
+	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.dma_maxburst = 8,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),

