Return-Path: <linux-kernel+bounces-847969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2FDBCC2E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8A51341896
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E96627B359;
	Fri, 10 Oct 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="z3vbzYLO"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CB727A906
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085705; cv=none; b=RXVh3ikKrVeaeH8BeZD1HqoD9zKgyK1z5jYxkE5osARXOKYHB9WWFvhVM+RbtdY7k7mpmIUkoItQEOYfXIbH47GAOKRfp7nciWOHyuewq7KhGZy/x+XR+EAVx5jZJhcty2ZOg/tAtj/WJIJ7YeIKykFrOxEnbCXApA2c9/j+ZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085705; c=relaxed/simple;
	bh=B3vnE1vUkgPsYrYz9u4srFxYa53prKjoUq0qcehEkYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwSuAxyT04Fv3NwEY6uiE0CKzNuDTzyul7pjJtORhmepoHGK/4+8hKkC5uQ9Ny7SGdSZK/GAPXrBCdvUpRXMB22ldMF/kd2+/yQGNmBLAsuT/A5om7vnainPiVrhbg8DgIZKdYrOi+O/3keqvM05uxaHGR+y6voVQwHjupoGddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=z3vbzYLO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D64AA4E40FCC;
	Fri, 10 Oct 2025 08:41:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A64FA60667;
	Fri, 10 Oct 2025 08:41:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C15FB102F2207;
	Fri, 10 Oct 2025 10:41:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760085701; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2eUtrmX2lFzBvooPhUwMtsD8tqiYbm1tikMSLEiK8r8=;
	b=z3vbzYLONLB4KTu0hnSElYAUxNvst69vE32Y1upv81SmM0jez+8uZgE+RXd5+YawIZX+Vl
	sRjRpK4bZlNZqkSdaPV3BfmMcIsmzTJTPoZV/yli/Oddhe7ExIAtYQaZstH9VUQz9DP7Cd
	5HPvoOrXjuUD/BB0XGSXOQ1aSb4B3AkDsmy7z+Ckif7K/G9s555x7vdhTdb1Ty1/tpg6GU
	khq4AcHRstyN6FeSBXazAVj+hxWkCRQd3nMoxEKYZbDHU64pOAkn/y/6yf1uMWDEyC17A7
	J+LEhXbDX3WZotr5alpAWu8cOjC/xOWP6oIOUDFllMyuUo2eGymUWwVHAoHQiQ==
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
Subject: [PATCH 05/15] mtd: nand: sunxi: introduce reg_ecc_err_cnt in sunxi_nfc_caps
Date: Fri, 10 Oct 2025 10:40:32 +0200
Message-ID: <20251010084042.341224-6-richard.genoud@bootlin.com>
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

The H6/H616 ECC_ERR_CNT register is not at the same offset as the
A10/A23 one, so move its offset into sunxi_nfc_caps

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 198dd40f9220..faaac71e7be3 100644
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
-- 
2.47.3


