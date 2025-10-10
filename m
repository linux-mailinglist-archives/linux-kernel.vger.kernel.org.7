Return-Path: <linux-kernel+bounces-847972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D3BCC2EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E76B34B976
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C6F28150A;
	Fri, 10 Oct 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1QLjYHaX"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161B27F4C7
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085712; cv=none; b=jg917gASBLXBxm8ocMUnPHJonQWJF1s/MFrpdFsUqMeL9+47o4ujhMAHs42zJe+Vqa5L99daeEhnowvmYaWyrMZ5lfHOIEXJ+xRWsOYTaXV803Zk2y/BMkBet0t3rTGLVKeYBBbNwimGTWU7bDGWZS1h5zLpJGW1+qGNS2Nh4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085712; c=relaxed/simple;
	bh=0AbNnOo4M+NHEvhdStfE8vWrf7XpyOL/iMHm//HtuD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XENkK80CBMJgkMWw+uXiYh/g0VV6g9af9etlusTX9yjq5f+PO/rx6OhAtOllQY2idY79Q6XuGDLhoC17Sw4QWtlyxbtLGBIIW9LAqG+pQWxEjHLDfb7rpkxJB6Lupq2a4FGGtxeo3HQzx3GSTfWe4glPH5wXswlj9MUrpXywap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1QLjYHaX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 26729C08CCA;
	Fri, 10 Oct 2025 08:41:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C296560667;
	Fri, 10 Oct 2025 08:41:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8957E102F21F6;
	Fri, 10 Oct 2025 10:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760085708; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9zF3woeq5c0FzokyfhWbeyMnFFFrF+2MtT34xOty4uM=;
	b=1QLjYHaXbTQMeAJ1TjLK/9J6y3RtJkoTC0AvdN9nDL/1XlhwY0y/ocj5V7aFCDhtGr2Lxc
	ihHImlbT5bhZ0PrDbTg0LLBQF2t1ggtcd9gruEvVIi1Ry7JxfXKKRuqd+4WuORXSs0mCWp
	pG8vKQ9rhY01wmF1wkXMGm9nUP7tmZugdAtSzqUS0mczuiLBZTIK1hnaT4HFbpkE4ppbph
	XscHovJnMDuw8kdlgICl6U4loGqwr4y8d9iedLyXdg0av5aEiLlbKydVhqGlTwqti0yi3m
	82i1GRRO2Eu9ukWfQS7OevbXBGRJ7T7INBitGWyC8TDHQRPDcdW7du/AXCv78w==
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
Subject: [PATCH 08/15] mtd: nand: sunxi: add has_ecc_block_512 capability
Date: Fri, 10 Oct 2025 10:40:35 +0200
Message-ID: <20251010084042.341224-9-richard.genoud@bootlin.com>
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

The H6/H616 controller can't handle 512 bytes ecc block size.
Let it be a capability.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 8c0430fbbb38..672e934444ca 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -222,6 +222,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  *
  * @has_mdma:		Use mbus dma mode, otherwise general dma
  *			through MBUS on A23/A33 needs extra configuration.
+ * @has_ecc_block_512:	If the ECC can handle 512B or only 1024B chuncks
  * @reg_io_data:	I/O data register
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
@@ -233,6 +234,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  */
 struct sunxi_nfc_caps {
 	bool has_mdma;
+	bool has_ecc_block_512;
 	unsigned int reg_io_data;
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
@@ -1748,8 +1750,14 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	sunxi_nand->ecc.ecc_ctl = NFC_ECC_MODE(i) | NFC_ECC_EXCEPTION |
 				  NFC_ECC_PIPELINE | NFC_ECC_EN;
 
-	if (ecc->size == 512)
-		sunxi_nand->ecc.ecc_ctl |= NFC_ECC_BLOCK_512;
+	if (ecc->size == 512) {
+		if (nfc->caps->has_ecc_block_512) {
+			sunxi_nand->ecc.ecc_ctl |= NFC_ECC_BLOCK_512;
+		} else {
+			dev_err(nfc->dev, "512B ECC block not supported\n");
+			return -EOPNOTSUPP;
+		}
+	}
 
 	return 0;
 }
@@ -2204,6 +2212,7 @@ static const u8 sunxi_ecc_strengths_a10[] = {
 };
 
 static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
+	.has_ecc_block_512 = true,
 	.reg_io_data = NFC_REG_A10_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
@@ -2216,6 +2225,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 
 static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.has_mdma = true,
+	.has_ecc_block_512 = true,
 	.reg_io_data = NFC_REG_A23_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
-- 
2.47.3


