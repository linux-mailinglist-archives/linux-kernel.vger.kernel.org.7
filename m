Return-Path: <linux-kernel+bounces-873189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A7C1356B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A8A0508038
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A7B2C21EC;
	Tue, 28 Oct 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eym+dPNl"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4F1F4E34;
	Tue, 28 Oct 2025 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636971; cv=none; b=oWYMrfr6LMj0n9g3Byk9UjafhBXvYD3ysc92XR5P+v/+CPXFxyZUPWRAgAKaO8l0HBdpoYhuSsjhClob5OKysDG0NIosKGGFcZG/h4QRDEGa7EB2IV8e90QjgXoFQlgq2tWpaaQc9ykKMx7N4WW5rUrMFXgucIErQCg/j9je5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636971; c=relaxed/simple;
	bh=DaRXIJ/7X39HdIvMEe7DqEcRKRrB/YJqaKCw71E56G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZYXp7a/B0BpCZW+UlserHwlrsdSG/UdYNkyF9bJZPABtaBduSv8WlziWOhCN92doA9BCbxhcZfmFB+5BhtHIdkzd9+4veirGaaG2bx/zBNGpWuyoRhZ/kR6H5mhA3HS9LkUFl0xQV1EMQiHhLWlogqyyS3bZgvkY5JF95NrnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eym+dPNl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B4174C0BE9B;
	Tue, 28 Oct 2025 07:35:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EED5C606AB;
	Tue, 28 Oct 2025 07:36:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56C2D102F2511;
	Tue, 28 Oct 2025 08:36:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761636966; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=u3S0UfkjniUygC6M3bNMepbhcEH6bkQ5H1MIMTWuTtY=;
	b=eym+dPNld4TdDRGXchdpD/HlCEzNadlm892YSWWyd9eY4MLl4gVFuv9voGbOGnnvDqEezj
	CWZSRylSKCnSWGKo8bBzM9VXx+ZZHX/6nJmPwnz3NyzprK+i16BdOl9yeLc6ZBb4YDexOk
	nFHf6jFQa5cWRtz+RGsadFyvzj9CiV9Rt3BoEg6v1ScEydT736gqQst1nKpFUInKo1bQIT
	zElM65Jz1DptBTA0ewy/PrlEcexZ5xV3pJbclE3VhCw9EvlNS5WGPu0k7fr1r4P+Pw5t8a
	1Pml/PjmzFqhnxpkhGIxj8zBtAseZZ9vsWaQ0IyOPFTweNWd7C0V9tj2RVIWbg==
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
Subject: [PATCH v4 03/16] mtd: rawnand: sunxi: Replace hard coded value by a define
Date: Tue, 28 Oct 2025 08:34:56 +0100
Message-ID: <20251028073534.526992-4-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028073534.526992-1-richard.genoud@bootlin.com>
References: <20251028073534.526992-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The user data length (4) used all over the code hard coded.
And sometimes, it's not that trivial to know that it's the user data
length and not something else.
Moreover, for the H6/H616 this value is no more fixed by hardware, but
could be modified.

Using a define here makes the code more readable.

Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 63 ++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index cb12179b63a5..f24e8d2083f8 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -157,6 +157,17 @@
 
 #define NFC_MAX_CS		7
 
+/*
+ * On A10/A23, this is the size of the NDFC User Data Register, containing the
+ * mandatory user data bytes following the ECC for each ECC step.
+ * Thus, for each ECC step, we need the ECC bytes + USER_DATA_SZ.
+ * Those bits are currently unsused, and kept as default value 0xffffffff.
+ *
+ * On H6/H616, this size became configurable, from 0 bytes to 32, via the
+ * USER_DATA_LEN registers.
+ */
+#define USER_DATA_SZ 4
+
 /**
  * struct sunxi_nand_chip_sel - stores information related to NAND Chip Select
  *
@@ -729,7 +740,7 @@ static void sunxi_nfc_hw_ecc_set_prot_oob_bytes(struct nand_chip *nand,
 						bool bbm, int page)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-	u8 user_data[4];
+	u8 user_data[USER_DATA_SZ];
 
 	/* Randomize the Bad Block Marker. */
 	if (bbm && (nand->options & NAND_NEED_SCRAMBLING)) {
@@ -781,7 +792,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 			memset(data, pattern, ecc->size);
 
 		if (oob)
-			memset(oob, pattern, ecc->bytes + 4);
+			memset(oob, pattern, ecc->bytes + USER_DATA_SZ);
 
 		return 0;
 	}
@@ -826,7 +837,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
-	*cur_off = oob_off + ecc->bytes + 4;
+	*cur_off = oob_off + ecc->bytes + USER_DATA_SZ;
 
 	ret = sunxi_nfc_hw_ecc_correct(nand, data, oob_required ? oob : NULL, 0,
 				       readl(nfc->regs + NFC_REG_ECC_ST),
@@ -846,11 +857,11 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 			memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE,
 				      ecc->size);
 
-		nand_change_read_column_op(nand, oob_off, oob, ecc->bytes + 4,
-					   false);
+		nand_change_read_column_op(nand, oob_off, oob,
+					   ecc->bytes + USER_DATA_SZ, false);
 
-		ret = nand_check_erased_ecc_chunk(data,	ecc->size,
-						  oob, ecc->bytes + 4,
+		ret = nand_check_erased_ecc_chunk(data,	ecc->size, oob,
+						  ecc->bytes + USER_DATA_SZ,
 						  NULL, 0, ecc->strength);
 		if (ret >= 0)
 			raw_mode = 1;
@@ -860,7 +871,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 		if (oob_required) {
 			nand_change_read_column_op(nand, oob_off, NULL, 0,
 						   false);
-			sunxi_nfc_randomizer_read_buf(nand, oob, ecc->bytes + 4,
+			sunxi_nfc_randomizer_read_buf(nand, oob, ecc->bytes + USER_DATA_SZ,
 						      true, page);
 
 			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, 0,
@@ -954,7 +965,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 
 	for (i = 0; i < nchunks; i++) {
 		int data_off = i * ecc->size;
-		int oob_off = i * (ecc->bytes + 4);
+		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
 		u8 *data = buf + data_off;
 		u8 *oob = nand->oob_poi + oob_off;
 		bool erased;
@@ -971,7 +982,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 			/* TODO: use DMA to retrieve OOB */
 			nand_change_read_column_op(nand,
 						   mtd->writesize + oob_off,
-						   oob, ecc->bytes + 4, false);
+						   oob, ecc->bytes + USER_DATA_SZ, false);
 
 			sunxi_nfc_hw_ecc_get_prot_oob_bytes(nand, oob, i,
 							    !i, page);
@@ -986,7 +997,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 	if (status & NFC_ECC_ERR_MSK) {
 		for (i = 0; i < nchunks; i++) {
 			int data_off = i * ecc->size;
-			int oob_off = i * (ecc->bytes + 4);
+			int oob_off = i * (ecc->bytes + USER_DATA_SZ);
 			u8 *data = buf + data_off;
 			u8 *oob = nand->oob_poi + oob_off;
 
@@ -1006,10 +1017,10 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 			/* TODO: use DMA to retrieve OOB */
 			nand_change_read_column_op(nand,
 						   mtd->writesize + oob_off,
-						   oob, ecc->bytes + 4, false);
+						   oob, ecc->bytes + USER_DATA_SZ, false);
 
-			ret = nand_check_erased_ecc_chunk(data,	ecc->size,
-							  oob, ecc->bytes + 4,
+			ret = nand_check_erased_ecc_chunk(data,	ecc->size, oob,
+							  ecc->bytes + USER_DATA_SZ,
 							  NULL, 0,
 							  ecc->strength);
 			if (ret >= 0)
@@ -1062,7 +1073,7 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
 	if (ret)
 		return ret;
 
-	*cur_off = oob_off + ecc->bytes + 4;
+	*cur_off = oob_off + ecc->bytes + USER_DATA_SZ;
 
 	return 0;
 }
@@ -1073,7 +1084,7 @@ static void sunxi_nfc_hw_ecc_write_extra_oob(struct nand_chip *nand,
 {
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
-	int offset = ((ecc->bytes + 4) * ecc->steps);
+	int offset = ((ecc->bytes + USER_DATA_SZ) * ecc->steps);
 	int len = mtd->oobsize - offset;
 
 	if (len <= 0)
@@ -1106,7 +1117,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *nand, uint8_t *buf,
 
 	for (i = 0; i < ecc->steps; i++) {
 		int data_off = i * ecc->size;
-		int oob_off = i * (ecc->bytes + 4);
+		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
 		u8 *data = buf + data_off;
 		u8 *oob = nand->oob_poi + oob_off;
 
@@ -1165,7 +1176,7 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *nand,
 	for (i = data_offs / ecc->size;
 	     i < DIV_ROUND_UP(data_offs + readlen, ecc->size); i++) {
 		int data_off = i * ecc->size;
-		int oob_off = i * (ecc->bytes + 4);
+		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
 		u8 *data = bufpoi + data_off;
 		u8 *oob = nand->oob_poi + oob_off;
 
@@ -1219,7 +1230,7 @@ static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *nand,
 
 	for (i = 0; i < ecc->steps; i++) {
 		int data_off = i * ecc->size;
-		int oob_off = i * (ecc->bytes + 4);
+		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
 		const u8 *data = buf + data_off;
 		const u8 *oob = nand->oob_poi + oob_off;
 
@@ -1257,7 +1268,7 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *nand,
 	for (i = data_offs / ecc->size;
 	     i < DIV_ROUND_UP(data_offs + data_len, ecc->size); i++) {
 		int data_off = i * ecc->size;
-		int oob_off = i * (ecc->bytes + 4);
+		int oob_off = i * (ecc->bytes + USER_DATA_SZ);
 		const u8 *data = buf + data_off;
 		const u8 *oob = nand->oob_poi + oob_off;
 
@@ -1296,7 +1307,7 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
 		goto pio_fallback;
 
 	for (i = 0; i < ecc->steps; i++) {
-		const u8 *oob = nand->oob_poi + (i * (ecc->bytes + 4));
+		const u8 *oob = nand->oob_poi + (i * (ecc->bytes + USER_DATA_SZ));
 
 		sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, i, !i, page);
 	}
@@ -1566,7 +1577,7 @@ static int sunxi_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
 	if (section >= ecc->steps)
 		return -ERANGE;
 
-	oobregion->offset = section * (ecc->bytes + 4) + 4;
+	oobregion->offset = section * (ecc->bytes + USER_DATA_SZ) + 4;
 	oobregion->length = ecc->bytes;
 
 	return 0;
@@ -1600,10 +1611,10 @@ static int sunxi_nand_ooblayout_free(struct mtd_info *mtd, int section,
 	if (section == ecc->steps && ecc->engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST)
 		return -ERANGE;
 
-	oobregion->offset = section * (ecc->bytes + 4);
+	oobregion->offset = section * (ecc->bytes + USER_DATA_SZ);
 
 	if (section < ecc->steps)
-		oobregion->length = 4;
+		oobregion->length = USER_DATA_SZ;
 	else
 		oobregion->length = mtd->oobsize - oobregion->offset;
 
@@ -1637,7 +1648,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 		bytes = (mtd->oobsize - 2) / nsectors;
 
 		/* 4 non-ECC bytes are added before each ECC bytes section */
-		bytes -= 4;
+		bytes -= USER_DATA_SZ;
 
 		/* and bytes has to be even. */
 		if (bytes % 2)
@@ -1690,7 +1701,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 
 	nsectors = mtd->writesize / ecc->size;
 
-	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors))
+	if (mtd->oobsize < ((ecc->bytes + USER_DATA_SZ) * nsectors))
 		return -EINVAL;
 
 	ecc->read_oob = sunxi_nfc_hw_ecc_read_oob;
-- 
2.47.3


