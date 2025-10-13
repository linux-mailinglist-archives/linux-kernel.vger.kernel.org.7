Return-Path: <linux-kernel+bounces-850893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E30EBBD4C15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19F155445EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3222E3161B7;
	Mon, 13 Oct 2025 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LpRPygyb"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E9315D45
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369262; cv=none; b=i5zdPAzIGOzrnFpR3U1aCOzAiuYEdgPera00v+F9eMac5VZXFOjBAuRfmhUaDX9h6hOtOMC1RFMkb3Ps0bMQ3jMJ46T7II2kXiYnF+yYfCV1USZjwir2bVRmg3LAJwd9siGv5j38OTHacEwpnd3NQlF/gLTCDNwXiQbbVmtkjqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369262; c=relaxed/simple;
	bh=alqdxedJgeYj1wn0ZySSzbk0DMMeB2aajugXvPD0ByA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIlaG6SbhRR39zVCvxJDLs53qWunbHKURijsyApUHDcji4lvMDB7l04QqGLBYMmRP0otl5cvd//hVw2D/0mc60OxB62tb7+hb2GIngOb2t2EXXCeCw4y/QEQwGzdpRG6RnXOxNKtg7lcWK/tlv4OGAaaErbrjIJNJp23hghpecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LpRPygyb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8D4954E41063;
	Mon, 13 Oct 2025 15:27:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63DD96067B;
	Mon, 13 Oct 2025 15:27:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E01E102F2276;
	Mon, 13 Oct 2025 17:27:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760369258; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=r96sXOEC4rYLXQboYpIADkZyx6AoA9ZadC4lzwMyVM0=;
	b=LpRPygyby4iH5RmBNLNx9qCSCoYJtrOVFnKvgbVuGy+vYmakHp6XA21fvytBrAiCVhDED3
	QEd3ZhMbnvWWL0e5tI2/0/JQcLBOYBGIQLQ4HbZQrbLx5rdZVY0p46xL1tt4V8/kwE0YxY
	16bFgQ/gm7YOPlliN9AOT3VTJBx5hlG9ar1aObjukn1Ob67AiLZl8gFrnIusb4p0mpVkzH
	JryYYVlGMSMKH6eIP8gAHELWLRtEXEB43sDLUNTsG4YmhhoKv2jiX+qVGr9p8RtmFEil5M
	TgqwR4NKKa47jEUnHuiBjzYGGknOkztE8zXUO/SBkPxFcMLC3J2QM71+hisF1Q==
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
Subject: [PATCH v2 06/15] mtd: rawnand: sunxi: add has_ecc_block_512 capability
Date: Mon, 13 Oct 2025 17:26:36 +0200
Message-ID: <20251013152645.1119308-7-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013152645.1119308-1-richard.genoud@bootlin.com>
References: <20251013152645.1119308-1-richard.genoud@bootlin.com>
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
index 4cfb5d3e9c06..70c940840dda 100644
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

