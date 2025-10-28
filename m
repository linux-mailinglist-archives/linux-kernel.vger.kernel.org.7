Return-Path: <linux-kernel+bounces-873199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC916C135A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4497C56498B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048AD2DCF50;
	Tue, 28 Oct 2025 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rfsVXFd4"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1392DAFA1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636992; cv=none; b=QZKLODxWWn/HB4pXCi3CU4RUUmrQci+v9jdaqguoDwHlBjlpRiveyL9eiv2VxbUasvu7dRAvdQN2UZPgi6cb3+GMPZoavUTLVbRWsbPwz0G2J/7eEKaR09z6C0wtc+6L0fGVpMB2sHV184WnRSK8QkMFIre9tHRFoYgUbWeIAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636992; c=relaxed/simple;
	bh=QJ64sYKNruGXYNfbyxWJS1AocK29X2WeYdH+/tjhSag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQ9taRKkbqkz9ZB2vvA4L0j8fCCeyl20Dni1O9ZBHpXWwlPfeCb0VgII85dJmqT35fEEM8ZJg6H7oEpd93M/eVj17ago5kEx8HKn3ID2dqWrs+ivys1GXzMe6ikfx9G2C4jL1O1uXUuIRXDqsaP8ULphbrLwG6PjddNn+ejpb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rfsVXFd4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 479C51A16F4;
	Tue, 28 Oct 2025 07:36:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1C763606AB;
	Tue, 28 Oct 2025 07:36:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2BF00102F251A;
	Tue, 28 Oct 2025 08:36:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761636988; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GReBwZzRVKk7Epo3GYEv3pecUjJOBDXWn4hVS9Iwm34=;
	b=rfsVXFd45fk7gwJAPYCqgpHBX9wYQakW1PCykrYfTZHM4iuQTpXOFeH6aa+90nZMAx81nZ
	zH44HCdcceMvqvaWNtXCD7mDMFpF5FaPe4vOE0/LSrFzLi44hUTze+3SJHk/CqMmJm0UJ8
	iPdWqmDOtLtLE2R6VY0vQva3AhpOlQuLTTxEVFxq3F6hywS0yVyO6jPLcmzN283bVIubqe
	DGNCe72DOrX6bNvwjMsC1xSHJ9YeF32S8vXrNyUnFF+rrFuej297FBGJ+nG8tMvE0beeXQ
	AP1rg2oh7HfF4Q/wBPqBhBXDWVG8Py1+u0wjn3pgMuteZkr78xYhlRMW6UhGuA==
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
Subject: [PATCH v4 13/16] mtd: rawnand: sunxi: introduce ecc_err_mask in sunxi_nfc_caps
Date: Tue, 28 Oct 2025 08:35:06 +0100
Message-ID: <20251028073534.526992-14-richard.genoud@bootlin.com>
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

The H6/H616 error mask register is bigger than the A10/A23 one, so move
its mask into sunxi_nfc_caps.

No functional change

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index d2e5bcb76925..0a9ac75bb229 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -155,7 +155,7 @@
 
 /* define bit use in NFC_ECC_ST */
 #define NFC_ECC_ERR(x)		BIT(x)
-#define NFC_ECC_ERR_MSK		GENMASK(15, 0)
+#define NFC_ECC_ERR_MSK(nfc)	(nfc->caps->ecc_err_mask)
 
 /*
  * define bit use in NFC_REG_PAT_FOUND
@@ -246,6 +246,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @random_en_mask:	RANDOM_EN mask in NFC_ECC_CTL register
  * @random_dir_mask:	RANDOM_DIRECTION mask in NFC_ECC_CTL register
  * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
+ * @ecc_err_mask:	NFC_ECC_ERR mask in NFC_ECC_ST register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @dma_maxburst:	DMA maxburst
  * @ecc_strengths:	Available ECC strengths array
@@ -263,6 +264,7 @@ struct sunxi_nfc_caps {
 	unsigned int random_en_mask;
 	unsigned int random_dir_mask;
 	unsigned int ecc_mode_mask;
+	unsigned int ecc_err_mask;
 	unsigned int pat_found_mask;
 	unsigned int dma_maxburst;
 	const u8 *ecc_strengths;
@@ -1040,7 +1042,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
 		sunxi_nfc_hw_ecc_update_stats(nand, &max_bitflips, ret);
 	}
 
-	if (status & NFC_ECC_ERR_MSK) {
+	if (status & NFC_ECC_ERR_MSK(nfc)) {
 		for (i = 0; i < nchunks; i++) {
 			int data_off = i * ecc->size;
 			int oob_off = i * (ecc->bytes + USER_DATA_SZ);
@@ -2245,6 +2247,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.random_en_mask = BIT(9),
 	.random_dir_mask = BIT(10),
 	.ecc_mode_mask = GENMASK(15, 12),
+	.ecc_err_mask = GENMASK(15, 0),
 	.pat_found_mask = GENMASK(31, 16),
 	.dma_maxburst = 4,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
@@ -2263,6 +2266,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.random_en_mask = BIT(9),
 	.random_dir_mask = BIT(10),
 	.ecc_mode_mask = GENMASK(15, 12),
+	.ecc_err_mask = GENMASK(15, 0),
 	.pat_found_mask = GENMASK(31, 16),
 	.dma_maxburst = 8,
 	.ecc_strengths = sunxi_ecc_strengths_a10,
-- 
2.47.3


