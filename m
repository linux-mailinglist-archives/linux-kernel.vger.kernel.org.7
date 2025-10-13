Return-Path: <linux-kernel+bounces-850898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18603BD51DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EC8354358E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1100731770B;
	Mon, 13 Oct 2025 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZygzAa6Y"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351E3176E6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369278; cv=none; b=MgRmBiqkE9rS1z1Zo7qMPBhZYR1pDlRtgYdQTJTXuoG+okHD+Rrgj7Hb6CGvaYE2Zfv2bPtytwWpcPdwfOlhQicfgRsOCiIy6m4Hftf3PX2D1xS6X7km/NNrZMdPP/TiNwYJqRhf/bEeZhlh55ZRyx/Ih4lRQKoT47U0zhl7rLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369278; c=relaxed/simple;
	bh=vo2EsEgL5782s2PoyUx3Sbpe6Jv2LpXCh5yn2MGkOTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2aYwCEfsr3v5rrqkY0LoaP1S4GZOjHmuVYAodqheSupd3pdpWX+ic04/T062KURgPvqfxnjmFSG3JbpA84+mRSju7reUMYzNO23sSVLoWHNafP5CmNauqdL3Nk34FhKA2T/rXFKBKki+TJOCLQULvkBH7gtuDRFjOS8rsKVOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZygzAa6Y; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 37DE21A132A;
	Mon, 13 Oct 2025 15:27:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0CFC06067B;
	Mon, 13 Oct 2025 15:27:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D74CE102F2278;
	Mon, 13 Oct 2025 17:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760369274; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=FMTlrYQnhBYB/I9vVH4uQ6alkyuaVWds87Lxblu5MFA=;
	b=ZygzAa6YwmOcFmcZe/Fzf8CQzS1NfTYqfY9A90F6WSwQdPnY5OtYne/ZpD4RQCOOxNdfli
	Q1oV6hjRSiCAp1o4d7KQmNWhktWtO645KVRMXJhzrzHVNN6B1j/xehdX41LZFD7T7rhzj1
	hHwkTIHsExXAQUmluLaIjwBfYaWXPd2/QwIlh3l97n/MOH7do+s5q6d5eWCOSLX9d0Yqlh
	c1aAQerpV7yCm1g504kONDv8bgNC8sfMga8nRmTWNyBSQoYkpcFEaSRLzk/bDcafgFKunk
	fRtyH9VXm9l9ZZA/BINjTzEUpGPt2v5A0NCh/jdVqDWj+w0tT4LELw0aieN1gA==
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
Subject: [PATCH v2 11/15] mtd: rawnand: sunxi: introduce ecc_err_mask in sunxi_nfc_caps
Date: Mon, 13 Oct 2025 17:26:41 +0200
Message-ID: <20251013152645.1119308-12-richard.genoud@bootlin.com>
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

The H6/H616 error mask register is bigger than the A10/A23 one, so move
its mask into sunxi_nfc_caps.

No functional change

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index da7b8b81d39e..3de5642c05a8 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -155,7 +155,7 @@
 
 /* define bit use in NFC_ECC_ST */
 #define NFC_ECC_ERR(x)		BIT(x)
-#define NFC_ECC_ERR_MSK		GENMASK(15, 0)
+#define NFC_ECC_ERR_MSK(nfc)	(nfc->caps->ecc_err_mask)
 
 /*
  * define bit use in NFC_REG_PAT_FOUND
@@ -235,6 +235,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @random_en_mask:	RANDOM_EN mask in NFC_ECC_CTL register
  * @random_dir_mask:	RANDOM_DIRECTION mask in NFC_ECC_CTL register
  * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
+ * @ecc_err_mask:	NFC_ECC_ERR mask in NFC_ECC_ST register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @dma_maxburst:	DMA maxburst
  * @ecc_strengths:	Available ECC strengths array
@@ -252,6 +253,7 @@ struct sunxi_nfc_caps {
 	unsigned int random_en_mask;
 	unsigned int random_dir_mask;
 	unsigned int ecc_mode_mask;
+	unsigned int ecc_err_mask;
 	unsigned int pat_found_mask;
 	unsigned int dma_maxburst;
 	const u8 *ecc_strengths;
@@ -1030,7 +1032,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 		sunxi_nfc_hw_ecc_update_stats(nand, &max_bitflips, ret);
 	}
 
-	if (status & NFC_ECC_ERR_MSK) {
+	if (status & NFC_ECC_ERR_MSK(nfc)) {
 		for (i = 0; i < nchunks; i++) {
 			int data_off = i * ecc->size;
 			int oob_off = i * (ecc->bytes + 4);
@@ -2235,6 +2237,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.random_en_mask = BIT(9),
 	.random_dir_mask = BIT(10),
 	.ecc_mode_mask = GENMASK(15, 12),
+	.ecc_err_mask = GENMASK(15, 0),
 	.pat_found_mask = GENMASK(31, 16),
 	.dma_maxburst = 4,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
@@ -2253,6 +2256,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.random_en_mask = BIT(9),
 	.random_dir_mask = BIT(10),
 	.ecc_mode_mask = GENMASK(15, 12),
+	.ecc_err_mask = GENMASK(15, 0),
 	.pat_found_mask = GENMASK(31, 16),
 	.dma_maxburst = 8,
 	.ecc_strengths = sunxi_ecc_strengths_a10,

