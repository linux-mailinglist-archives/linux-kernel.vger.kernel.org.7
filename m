Return-Path: <linux-kernel+bounces-860595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F01A0BF07C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29771895DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE92F656C;
	Mon, 20 Oct 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W+Kl66iQ"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C212F83AB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955239; cv=none; b=njcGI4XJw5lGkLcKoePTFdtxLdW/WgPDnOFmR+j9wd3b1mg3erMZ2gOZQ+9NVi6Ltmr/i0FNVCoPM/acDfchQsmuqDEsiq19k+q2+Wsb2rZwdGRhKz1OHj5udjmzeCibYd9VylWrp1ooyKq9ATsa9TkLv8RL2S/j5xW8DQm6SpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955239; c=relaxed/simple;
	bh=Bj2bDkawb+eM4LEf6zTBVOXbBamk4BEp7t4QkbWGVF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IywjT0EZaHp+f0yYQhfJvciImhdIgFrZNp/hudx7xeHFP33YtQ6WzcshJKKqd2fjsWpyYhVnUBBrhe8/LLnW5W2k9FzkJl9VUcENwSMUB3dUIYxpd6qf0rbv7OmJAQLSwRqzX8IQPt9PAAl9xn8izwNd7LHfI2cZdF6yDxMrUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W+Kl66iQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0DF911A1547;
	Mon, 20 Oct 2025 10:13:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D7F75606D5;
	Mon, 20 Oct 2025 10:13:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86764102F23A7;
	Mon, 20 Oct 2025 12:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760955235; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=tFIp35uHTqcsmvS0r9Kp5zCwmOEmNlNll/p8ijKVjUE=;
	b=W+Kl66iQqVGEN7WxNHCc2JaAb5If5Xkk8Letk+JE6GRJmuclBuAP7YnDmlbA7IgqXStQ2w
	B7IT40qxCMrt8h0Y1MdCdNAEfORD52oLCMapRtbxLOflePfHtR2gsH1cn2ch37Ij2yXSYV
	Nk3VS1QBS9D1odgv065dHm9sFyrxgz0bNVSPhofVZ6yHF9OZJgOGNmfIbbPhCz8F0XCqyt
	nyS2zKKCdoW6mS8Xgjrmlr6NxLPie3GjjzcoK+3jpIsh+mZIfbXa18QnUAjbFhf1RbsY74
	t3KYBVSO0ivHoT5P+HiFKAkzOAK8THxD9S49epeOH0MdRT8C84St4+PpAJkiyg==
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
Subject: [PATCH v3 05/15] mtd: rawnand: sunxi: rework pattern found registers
Date: Mon, 20 Oct 2025 12:13:01 +0200
Message-ID: <20251020101311.256819-6-richard.genoud@bootlin.com>
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

On H6/H616, the register ECC_PAT_FOUND is at its own address, and not
part of ECC status register.
So, introduce the pattern found register offset in sunxi_nfc_caps, along
with its mask.

Also, introduce a non compile-time field_get() because FIELD_GET() and
u32_get_bits() don't work with non compile-time constant.
https://lore.kernel.org/lkml/cover.1739540679.git.geert+renesas@glider.be/

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 36 ++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 8f5d8df19e33..4cfb5d3e9c06 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -29,6 +29,9 @@
 #include <linux/iopoll.h>
 #include <linux/reset.h>
 
+/* non compile-time field get */
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+
 #define NFC_REG_CTL		0x0000
 #define NFC_REG_ST		0x0004
 #define NFC_REG_INT		0x0008
@@ -150,7 +153,13 @@
 /* define bit use in NFC_ECC_ST */
 #define NFC_ECC_ERR(x)		BIT(x)
 #define NFC_ECC_ERR_MSK		GENMASK(15, 0)
-#define NFC_ECC_PAT_FOUND(x)	BIT(x + 16)
+
+/*
+ * define bit use in NFC_REG_PAT_FOUND
+ * For A10/A23, NFC_REG_PAT_FOUND == NFC_ECC_ST register
+ */
+#define NFC_ECC_PAT_FOUND_MSK(nfc) (nfc->caps->pat_found_mask)
+
 #define NFC_ECC_ERR_CNT(b, x)	(((x) >> (((b) % 4) * 8)) & 0xff)
 
 #define NFC_DEFAULT_TIMEOUT_MS	1000
@@ -216,6 +225,8 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @reg_io_data:	I/O data register
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
+ * @reg_pat_found:	Data Pattern Status Register
+ * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @dma_maxburst:	DMA maxburst
  * @ecc_strengths:	Available ECC strengths array
  * @nstrengths:		Size of @ecc_strengths
@@ -225,6 +236,8 @@ struct sunxi_nfc_caps {
 	unsigned int reg_io_data;
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
+	unsigned int reg_pat_found;
+	unsigned int pat_found_mask;
 	unsigned int dma_maxburst;
 	const u8 *ecc_strengths;
 	unsigned int nstrengths;
@@ -766,7 +779,8 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand_chip *nand,
 }
 
 static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
-				    int step, u32 status, bool *erased)
+				    int step, u32 status, u32 pattern_found,
+				    bool *erased)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
@@ -777,7 +791,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 	if (status & NFC_ECC_ERR(step))
 		return -EBADMSG;
 
-	if (status & NFC_ECC_PAT_FOUND(step)) {
+	if (pattern_found & BIT(step)) {
 		u8 pattern;
 
 		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID) & 0x1))) {
@@ -811,6 +825,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
 	int raw_mode = 0;
+	u32 pattern_found;
 	bool erased;
 	int ret;
 
@@ -838,8 +853,12 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
 
 	*cur_off = oob_off + ecc->bytes + 4;
 
+	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
+	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
+
 	ret = sunxi_nfc_hw_ecc_correct(nand, data, oob_required ? oob : NULL, 0,
 				       readl(nfc->regs + NFC_REG_ECC_ST),
+				       pattern_found,
 				       &erased);
 	if (erased)
 		return 1;
@@ -920,7 +939,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 	unsigned int max_bitflips = 0;
 	int ret, i, raw_mode = 0;
 	struct scatterlist sg;
-	u32 status, wait;
+	u32 status, pattern_found, wait;
 
 	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 	if (ret)
@@ -961,6 +980,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 		return ret;
 
 	status = readl(nfc->regs + NFC_REG_ECC_ST);
+	pattern_found = readl(nfc->regs + nfc->caps->reg_pat_found);
+	pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
 
 	for (i = 0; i < nchunks; i++) {
 		int data_off = i * ecc->size;
@@ -971,7 +992,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 
 		ret = sunxi_nfc_hw_ecc_correct(nand, randomized ? data : NULL,
 					       oob_required ? oob : NULL,
-					       i, status, &erased);
+					       i, status, pattern_found,
+					       &erased);
 
 		/* ECC errors are handled in the second loop. */
 		if (ret < 0)
@@ -2185,6 +2207,8 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_io_data = NFC_REG_A10_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
+	.reg_pat_found = NFC_REG_ECC_ST,
+	.pat_found_mask = GENMASK(31, 16),
 	.dma_maxburst = 4,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
@@ -2195,6 +2219,8 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.reg_io_data = NFC_REG_A23_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
+	.reg_pat_found = NFC_REG_ECC_ST,
+	.pat_found_mask = GENMASK(31, 16),
 	.dma_maxburst = 8,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),

