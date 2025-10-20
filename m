Return-Path: <linux-kernel+bounces-860599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5760BBF0796
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DC504F1B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427012F658D;
	Mon, 20 Oct 2025 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vOoGI1qw"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E712FB619
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955246; cv=none; b=ChJJxiAKymxp2eQgtTeU/t/yVAfTXSATex4ySc+WsyR1HJNkELiK7a5IAdZ3haCpC3d2GlrQMoIr2Qex+QM64De1JkiHuFCg4ZEGSulteQoa5TjbbHnQkWFpKx7D91mA5nkDV3CWtmj0CJr1a3+5/FdOEqjSpzebeOzuPrJDhB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955246; c=relaxed/simple;
	bh=QyBTlu0fjJBUYPzb88kv3Rt5dUWVEWEhPD5eAWj5Qc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=em/VhoD2IzGgoMbJDQIzSHhY75rb65SGWnpPfV25k4VkBcb0ahhvw3emQsJR2ym6X1MJ1JmWEoWY4Rf4+sMkcoH7EcUvIw4LGBr5G5ay3wk9mzmE0NnhU2wT/zSFL/9bWHsUAF2+onopigeGLZqK8htWeg6MXRxoODTCyMNlMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vOoGI1qw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 444101A1542;
	Mon, 20 Oct 2025 10:14:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A7F2606D5;
	Mon, 20 Oct 2025 10:14:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFB4E102F23BB;
	Mon, 20 Oct 2025 12:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760955242; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RRPaMbfJAZI7RCNqN6ObTFqj0JMSPmSj/5WzMmnBcMY=;
	b=vOoGI1qw7DlFId+6s4UIXGc8HxyTrsHYuV+RFf09g+/FQJWRrRh7G9peN4Vl0fMHBR52bt
	bfAYo8SdagcwSN3yYknuv9a8nneVVLjFnetXoaesAIhT3+cXS+RuZr2LdYLvbXDg3MMoc9
	+tKEOv5iLN55QQxB4Xhdv9TQx0BfuzaMso9qFBq6u0VrM/c1Uc6Vqy/WgzYm8ffEt1VvYZ
	Mah0BCuBi94fxM48rmVZKAKYa9nnch7xXYUNdBgmR73uddi5ampY10RQUXdhlMwanpJEcH
	MPE0mSlxbIluXNb6vXOqn7JlDVVeozVm7jVXKhWtm4PEZVuZHKkGXm91Bj8xbQ==
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
Subject: [PATCH v3 09/15] mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
Date: Mon, 20 Oct 2025 12:13:05 +0200
Message-ID: <20251020101311.256819-10-richard.genoud@bootlin.com>
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

The H6/H616 pattern ID register is not at the same offset as the
A10/A23 one, so move its offset into sunxi_nfc_caps.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 3ccb7ea7cf17..e8c08f0139d2 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -55,7 +55,8 @@
 #define NFC_REG_A10_USER_DATA	0x0050
 #define NFC_REG_USER_DATA(nfc, x)	(nfc->caps->reg_user_data + ((x) * 4))
 #define NFC_REG_SPARE_AREA	0x00A0
-#define NFC_REG_PAT_ID		0x00A4
+#define NFC_REG_PAT_ID(nfc) (nfc->caps->reg_pat_id)
+#define NFC_REG_A10_PAT_ID	0x00A4
 #define NFC_REG_MDMA_ADDR	0x00C0
 #define NFC_REG_MDMA_CNT	0x00C4
 #define NFC_RAM0_BASE		0x0400
@@ -227,6 +228,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @reg_io_data:	I/O data register
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
+ * @reg_pat_id:		Pattern ID Register
  * @reg_pat_found:	Data Pattern Status Register
  * @random_en_mask:	RANDOM_EN mask in NFC_ECC_CTL register
  * @random_dir_mask:	RANDOM_DIRECTION mask in NFC_ECC_CTL register
@@ -242,6 +244,7 @@ struct sunxi_nfc_caps {
 	unsigned int reg_io_data;
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
+	unsigned int reg_pat_id;
 	unsigned int reg_pat_found;
 	unsigned int random_en_mask;
 	unsigned int random_dir_mask;
@@ -803,7 +806,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 	if (pattern_found & BIT(step)) {
 		u8 pattern;
 
-		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID) & 0x1))) {
+		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & 0x1))) {
 			pattern = 0x0;
 		} else {
 			pattern = 0xff;
@@ -2223,6 +2226,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_io_data = NFC_REG_A10_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
+	.reg_pat_id = NFC_REG_A10_PAT_ID,
 	.reg_pat_found = NFC_REG_ECC_ST,
 	.random_en_mask = BIT(9),
 	.random_dir_mask = BIT(10),
@@ -2239,6 +2243,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.reg_io_data = NFC_REG_A23_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
+	.reg_pat_id = NFC_REG_A10_PAT_ID,
 	.reg_pat_found = NFC_REG_ECC_ST,
 	.random_en_mask = BIT(9),
 	.random_dir_mask = BIT(10),

