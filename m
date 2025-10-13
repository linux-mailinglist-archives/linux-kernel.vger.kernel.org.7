Return-Path: <linux-kernel+bounces-850890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF693BD48D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CD8A50681E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0A315D50;
	Mon, 13 Oct 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SUoSskjX"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8493315D35
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369255; cv=none; b=GxDQVZpCWYKe2lM1xyORAKEgOffSWNIIutQ/NktYIoeZ/T327VLOB41mIcSnVCaUNYzaUaB4pHvG3erRqnq7pvPlDnMVWQ72g4NPtOJKxiGs6fLLqjHkDxEJTRzt7WZRGoMEoNV7Q6t5EHe9VEUivBjI7G+H04jnRqyIoPb40wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369255; c=relaxed/simple;
	bh=zCdVIfT3/lJV5ewa+JtXbF/AwV1pJJ2zuoy9j7fYm4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPf9ysefB+l5cxwgwrJhZbKnSy2wXKoJI4buciLJf1fy4/Mw/5k9BgiYAn0n4SucER7C1HHLeKPQVwrctHM1g9/VlmmbLvcxQpU5QvGAjF4N8oWEaFDTykcWAq3aqFgywXbvP6V2pppup34BYmpfAeSZKCNaZFb2P2pKXsSMaXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SUoSskjX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 20D2A1A12FC;
	Mon, 13 Oct 2025 15:27:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E987B6067B;
	Mon, 13 Oct 2025 15:27:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD8BB102F226E;
	Mon, 13 Oct 2025 17:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760369250; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+2C6Y7QvX0FPwTw070QW7rXZAP/U111s0G+dQuIpjU4=;
	b=SUoSskjXqGjUJ44lWbsBZyewVY3yJhY1PWe6JpAVZ48Qe9fTjfuLBUOLF5Gm0mlGA3nDph
	77nQ4xzTAEdJ3IcI7D15nMVGtcb2VhRKlRZNPjpGLka7i/68HqR24sEzKaJSaWSgFhSG37
	wcsF/a8Kfdxvbt529MB2D3hFP1YmrPmJ+fnEicAetJgrVRIiMWVYlI1AJB6926TjsOeCst
	+HEb2LOicOWufqGIPcqwXpXWwm6McJQzEZjJ2dzpwQqLJiSCLzgWm12/bvqVTQ8hR782ln
	4cpHqxZ7jqoSQCo6eWe+9SbHO0oIcYL4k7Hkl1iJJW7/u9zkRn6MdrA6xlFNaw==
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
Subject: [PATCH v2 03/15] mtd: rawnand: sunxi: introduce reg_ecc_err_cnt in sunxi_nfc_caps
Date: Mon, 13 Oct 2025 17:26:33 +0200
Message-ID: <20251013152645.1119308-4-richard.genoud@bootlin.com>
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

The H6/H616 ECC_ERR_CNT register is not at the same offset as the
A10/A23 one, so move its offset into sunxi_nfc_caps

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index d3b17d54f04c..0285e4d0ca7f 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -46,7 +46,8 @@
 #define NFC_REG_ECC_CTL		0x0034
 #define NFC_REG_ECC_ST		0x0038
 #define NFC_REG_DEBUG		0x003C
-#define NFC_REG_ECC_ERR_CNT(x)	((0x0040 + (x)) & ~0x3)
+#define NFC_REG_A10_ECC_ERR_CNT	0x0040
+#define NFC_REG_ECC_ERR_CNT(nfc, x)	((nfc->caps->reg_ecc_err_cnt + (x)) & ~0x3)
 #define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
 #define NFC_REG_SPARE_AREA	0x00A0
 #define NFC_REG_PAT_ID		0x00A4
@@ -212,6 +213,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @has_mdma:		Use mbus dma mode, otherwise general dma
  *			through MBUS on A23/A33 needs extra configuration.
  * @reg_io_data:	I/O data register
+ * @reg_ecc_err_cnt:	ECC error counter register
  * @dma_maxburst:	DMA maxburst
  * @ecc_strengths:	Available ECC strengths array
  * @nstrengths:		Size of @ecc_strengths
@@ -219,6 +221,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
 struct sunxi_nfc_caps {
 	bool has_mdma;
 	unsigned int reg_io_data;
+	unsigned int reg_ecc_err_cnt;
 	unsigned int dma_maxburst;
 	const u8 *ecc_strengths;
 	unsigned int nstrengths;
@@ -790,7 +793,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 		return 0;
 	}
 
-	tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(step));
+	tmp = readl(nfc->regs + NFC_REG_ECC_ERR_CNT(nfc, step));
 
 	return NFC_ECC_ERR_CNT(step, tmp);
 }
@@ -2177,6 +2180,7 @@ static const u8 sunxi_ecc_strengths_a10[] = {
 
 static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_io_data = NFC_REG_A10_IO_DATA,
+	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.dma_maxburst = 4,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
@@ -2185,6 +2189,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.has_mdma = true,
 	.reg_io_data = NFC_REG_A23_IO_DATA,
+	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.dma_maxburst = 8,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),

