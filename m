Return-Path: <linux-kernel+bounces-847978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 042DEBCC31B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99C224F7ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26A288C12;
	Fri, 10 Oct 2025 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tkd4UNkK"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B828C5D5
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085728; cv=none; b=cpRNxGuowmIG+xgaZ6EK8RKRvPfwxoQNlaOthjE+N9+afWAob5YIfVuvTJhW4PeJEeidro+kZ+DX4l6PCNnxzOErRfGoZFJaUt+s/w7XY1Yiy2n8Yyhj2n/CtH8lzhqZtAa5xNDEpIfHhe0OcCtZ7eBVVepKJnMgznwZja2leR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085728; c=relaxed/simple;
	bh=cEQn29jCxybp0mc+vVYJ7BrpJTmfe1Rgs0CG30Yzy9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okLpIyzKjg5LivAR4+l1LvWcUtbssIYKn5yikhSt4emlcpHIjJshsaATNdJ2+SGjAjli1gKTxacp93020sPSc0LxLFVUw2ZGCPpeWQUGnCoysxE89mQigv2IutePg4NhQkn4wJ5m9+pOlRqJjfGGGsy3OxCjQkAqp/qqooo73Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tkd4UNkK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 23F524E40FCD;
	Fri, 10 Oct 2025 08:42:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDA4860667;
	Fri, 10 Oct 2025 08:42:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52819102F2207;
	Fri, 10 Oct 2025 10:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760085723; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=rRUQJ34yBDEQRJECh1MeBCDCN7q5t1MV6jZLuQSFP2g=;
	b=Tkd4UNkK3WjiPjOrsD0l9gsyO2oU43kzmJwd3LHFb5HHG3HmadoK0OTbXbe2yvNPk2hcTy
	JGpakH+FT1KoYPYtrpn7V3jmk/e5jMCjRWtz53dAoAhKaX/ZEthzuHEheFrjo+g8rAPXv9
	+8ucUMMklbhZtdNIMZ2nmmMa3b1Zu3wuuGWIqNUxc+JxmxwuEYupIcBV+66dIpidQo/liK
	Rij+nA4++61e7BDEGN+3ppJ5wRH76YzwdLw4ak8BzoQafHvuGbLEPK+gUjE1EagJ5Wg7nX
	U4/T5VQHAsuxGBvS/j9/S/nNmPrceAyLBJGp3aYDeh5zMzED/DoXHg3jdyE/kQ==
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
Subject: [PATCH 14/15] mtd: nand: sunxi: introduce sram_size in sunxi_nfc_caps
Date: Fri, 10 Oct 2025 10:40:41 +0200
Message-ID: <20251010084042.341224-15-richard.genoud@bootlin.com>
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

The H6/H616 the SRAM is bigger than the A10/A23 one, so move its size
into sunxi_nfc_caps.

No functional change

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 3912878e7645..e81d74c6633a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -167,8 +167,6 @@
 
 #define NFC_DEFAULT_TIMEOUT_MS	1000
 
-#define NFC_SRAM_SIZE		1024
-
 #define NFC_MAX_CS		7
 
 /**
@@ -240,6 +238,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @dma_maxburst:	DMA maxburst
  * @ecc_strengths:	Available ECC strengths array
  * @nstrengths:		Size of @ecc_strengths
+ * @sram_size:		Size of the NAND controller SRAM
  */
 struct sunxi_nfc_caps {
 	bool has_mdma;
@@ -258,6 +257,7 @@ struct sunxi_nfc_caps {
 	unsigned int dma_maxburst;
 	const u8 *ecc_strengths;
 	unsigned int nstrengths;
+	int sram_size;
 };
 
 /**
@@ -495,7 +495,7 @@ static void sunxi_nfc_read_buf(struct nand_chip *nand, uint8_t *buf, int len)
 	while (len > offs) {
 		bool poll = false;
 
-		cnt = min(len - offs, NFC_SRAM_SIZE);
+		cnt = min(len - offs, nfc->caps->sram_size);
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 		if (ret)
@@ -533,7 +533,7 @@ static void sunxi_nfc_write_buf(struct nand_chip *nand, const uint8_t *buf,
 	while (len > offs) {
 		bool poll = false;
 
-		cnt = min(len - offs, NFC_SRAM_SIZE);
+		cnt = min(len - offs, nfc->caps->sram_size);
 
 		ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
 		if (ret)
@@ -1861,7 +1861,7 @@ static int sunxi_nfc_exec_subop(struct nand_chip *nand,
 		case NAND_OP_DATA_OUT_INSTR:
 			start = nand_subop_get_data_start_off(subop, i);
 			remaining = nand_subop_get_data_len(subop, i);
-			cnt = min_t(u32, remaining, NFC_SRAM_SIZE);
+			cnt = min_t(u32, remaining, nfc->caps->sram_size);
 			cmd |= NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD;
 
 			if (instr->type == NAND_OP_DATA_OUT_INSTR) {
@@ -2242,6 +2242,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.dma_maxburst = 4,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
+	.sram_size = 1024,
 };
 
 static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
@@ -2261,6 +2262,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.dma_maxburst = 8,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
+	.sram_size = 1024,
 };
 
 static const struct of_device_id sunxi_nfc_ids[] = {
-- 
2.47.3


