Return-Path: <linux-kernel+bounces-847976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5770BCC30F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1034223CC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E17288510;
	Fri, 10 Oct 2025 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tg/jynav"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A663283FFA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085722; cv=none; b=NXOF7DOdGBFCjp/TNJJ71Vgf03dbLEhXg6MbE4d1mW2ybCnvFf7kE02qMDE30yEeFS/qSPAHzoK3a/vbK/s1iGIv+6QUWWZWg7VfQh2GpJgT6muv/qJVbHl8r2UmGtWjBDAzWvQandda0+5/RvMBJDWE3wt5dpHfv9y4KssQz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085722; c=relaxed/simple;
	bh=kcHjhcAS5qX/rhgd6u++hDtF8dDx/2buhJDdkmVfWo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHTiWZpqj2WRn7JvX3hX+sUsA/PXcKtN6GDgKKU+5ntYWO5W1842XzDxo5pTD+UjSbaFfGSpZzQj/1TBKUeceCY6LuAc2pCBjTuXFra1XZncYUc1CEjoFsQWDsMvuGXAcQ/5DJR1h6ukDtWCQji+h2nzk5xHZuwKIb/VHjJesuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tg/jynav; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A6B511A1285;
	Fri, 10 Oct 2025 08:41:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D32860667;
	Fri, 10 Oct 2025 08:41:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 73A52102F220B;
	Fri, 10 Oct 2025 10:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760085718; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=zrFppuVA4Tx0AXaKZV03Ob6lPPggHgdPbLxorTpS1EI=;
	b=tg/jynavBKvnWr887Qh4TPjrYBuOq9cxIE7UmUNIbWruIpJu0/MR30tXD5D8cFygaYJGtz
	Rjr0ux0r6sXvmGLC77uJVOCvPHgDg7TtY0zUEkOaxA+ByKkBaFofBwp4nOKKHgmmBZMUfd
	8g2ZmUUffiNgnGm+yJd4eUxROXcUfWqhcjf/DtPAsAcLRbIFSanI6qWvRmthZpLFyCFdZc
	llsxWcAh7CyDxLj80s0wNPEDdluxwlGLaEDXZ78SkoDQdFSvqxgCeBkswE3O+LcZ4FWStN
	4hYuwJJeAkkOmolRN2KmO2vuz0SjaGWy3jzfZs/W5RjdeYWX5Gs55lH8z8BJ9A==
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
Subject: [PATCH 12/15] mtd: nand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
Date: Fri, 10 Oct 2025 10:40:39 +0200
Message-ID: <20251010084042.341224-13-richard.genoud@bootlin.com>
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

The H6/H616 spare area register is not at the same offset as the
A10/A23 one, so move its offset into sunxi_nfc_caps.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 8921e66e0c6d..80aafa4e1844 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -54,7 +54,8 @@
 #define NFC_REG_ECC_ERR_CNT(nfc, x)	((nfc->caps->reg_ecc_err_cnt + (x)) & ~0x3)
 #define NFC_REG_A10_USER_DATA	0x0050
 #define NFC_REG_USER_DATA(nfc, x)	(nfc->caps->reg_user_data + ((x) * 4))
-#define NFC_REG_SPARE_AREA	0x00A0
+#define NFC_REG_SPARE_AREA(nfc) (nfc->caps->reg_spare_area)
+#define NFC_REG_A10_SPARE_AREA	0x00A0
 #define NFC_REG_PAT_ID(nfc) (nfc->caps->reg_pat_id)
 #define NFC_REG_A10_PAT_ID	0x00A4
 #define NFC_REG_MDMA_ADDR	0x00C0
@@ -228,6 +229,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @reg_io_data:	I/O data register
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
+ * @reg_spare_area:	Spare Area Register
  * @reg_pat_id:		Pattern ID Register
  * @reg_pat_found:	Data Pattern Status Register
  * @random_en_mask:	RANDOM_EN mask in NFC_ECC_CTL register
@@ -244,6 +246,7 @@ struct sunxi_nfc_caps {
 	unsigned int reg_io_data;
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
+	unsigned int reg_spare_area;
 	unsigned int reg_pat_id;
 	unsigned int reg_pat_found;
 	unsigned int random_en_mask;
@@ -466,7 +469,7 @@ static void sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 	if (sel->rb >= 0)
 		ctl |= NFC_RB_SEL(sel->rb);
 
-	writel(mtd->writesize, nfc->regs + NFC_REG_SPARE_AREA);
+	writel(mtd->writesize, nfc->regs + NFC_REG_SPARE_AREA(nfc));
 
 	if (nfc->clk_rate != sunxi_nand->clk_rate) {
 		clk_set_rate(nfc->mod_clk, sunxi_nand->clk_rate);
@@ -2226,6 +2229,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_io_data = NFC_REG_A10_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
+	.reg_spare_area = NFC_REG_A10_SPARE_AREA,
 	.reg_pat_id = NFC_REG_A10_PAT_ID,
 	.reg_pat_found = NFC_REG_ECC_ST,
 	.random_en_mask = BIT(9),
@@ -2243,6 +2247,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.reg_io_data = NFC_REG_A23_IO_DATA,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
+	.reg_spare_area = NFC_REG_A10_SPARE_AREA,
 	.reg_pat_id = NFC_REG_A10_PAT_ID,
 	.reg_pat_found = NFC_REG_ECC_ST,
 	.random_en_mask = BIT(9),
-- 
2.47.3


