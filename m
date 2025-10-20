Return-Path: <linux-kernel+bounces-860596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E1BF07A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E04D3AA07D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57B2F90E9;
	Mon, 20 Oct 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bC8koX7u"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B62F6181
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955241; cv=none; b=K/GXf37h65NwP6jwnJZlcHtfDBBSIeaM1lSHNTX2QYmWo3YbNdQzGoAWUGNS20H8ys5KBHgzWiLJC99CdDwo6cgGn/pOQPze65Yg6vTw/8sbnhta689PPPByaPJVJobAHzqDiGtGWZ79mls78RaanuOhHBda8N0aIyTVs8kpWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955241; c=relaxed/simple;
	bh=Hnn8d1L69nr+BGHmp/NTgtAHLAUobVrpHbjzBTnFZi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKZWbAIv6GOYfv/U+2Z6nQgwl2gNtoKnvzwY/NAcGSikhQVOYQQj4CYk/LtIJPhDKxIYhPGes+/SAOsij/Uso4zPvhpdWHXkgpLR6wR7SskK1pyPyHox/OrFo3M4S7L0dn+VeqqZhLcdJRH4zYk8FdJyDx+f2/hiIGniGOZ9VfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bC8koX7u; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 17F301A154C;
	Mon, 20 Oct 2025 10:13:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E1AEF606D5;
	Mon, 20 Oct 2025 10:13:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51488102F23B2;
	Mon, 20 Oct 2025 12:13:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760955236; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=HQ1IhgcFvXBkQ1TsRPeecT3KmPOkwdU0whK+wNY8jxI=;
	b=bC8koX7uJVqD67QaLxyhC/ytzw2wKkGKCOLexVp0xV5TULjmepqEmNRS+bb71IxFEb86yO
	SWInWPGqYQbhepePdNjH4FAH8osA0mJvyhKIVAyE5fvydq7XKBwN1Iq6KfDgD15GH3/GKe
	59UBRu5MahJm+SlBXYrFrNS+lAV12gy4X9wYQf7ePcebWqNvYMWlLzB7GSJPLV9+eElu8P
	t+NuMX+cQ01IAuBD4jR4okTPLEy/VfMjIiAgBRYS995BUf8G2EzJUbjEbeIbcwXZgI21zs
	DYTjJTQ0J/kG5eKeWpb4gLVwS+zFHV9O+9t7ho7mQ8SJ5oXTMJHkMNX30+vpVQ==
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
Subject: [PATCH v3 06/15] mtd: rawnand: sunxi: add has_ecc_block_512 capability
Date: Mon, 20 Oct 2025 12:13:02 +0200
Message-ID: <20251020101311.256819-7-richard.genoud@bootlin.com>
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

The H616 controller can't handle 512 bytes ECC block size. The
NFC_ECC_BLOCK_512 bit disappeared in H6, and NDFC_RANDOM_EN took its
place.

So, add has_ecc_block_512 capability to only set this bit on SoC having
it.

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

