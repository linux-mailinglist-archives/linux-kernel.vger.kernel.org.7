Return-Path: <linux-kernel+bounces-773736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA77B2A8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C268238F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96C335BC6;
	Mon, 18 Aug 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy6s7zfy"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A4335BCB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525192; cv=none; b=mHHHhwqhcq9YuiE1BowrrfMaO/Qvi5jyreAEExWF3LCN0zC9NTf24KY2c9ktvaKXvoaPl2hpx6iiUy+xewSXJyAz8ZuIccmYwWAELKmKl8pTcOHkjvaSH3CRaxrRFWl+At0kILn9k2Tgjof4CG5R5Ph7wZDt+Sopr/lmULU2vlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525192; c=relaxed/simple;
	bh=RMGPVPOt1tsq9iN6V+lrcwWxmxqcpZke9gexpq5KEUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=epSn5ebIEZ2nEaMTTscFwXPGvsZQXtKtSqwYcA62aorKcaaMBRGPt88MJ0BYgGw3nhhhB3JB4mqeJf0IN1KyfpLrew5/Nb2wF7xPhsaWt6CL+eCJ5RdBxhpsxRrobmYx9dJSnOP73RIW5HvEIDxwzoz1mi1SpVelvWCPWdk86C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hy6s7zfy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b471754bf05so3668362a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755525190; x=1756129990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JIC+sfaRRNCZ/PpzLr3hvBF4vD7BYR+5HNnrMt71ufA=;
        b=hy6s7zfyNutvAFUi1uqR43IIeIhWJIf+uO9DNY0RihFkxNcj3rqB7JkjpB2vsP152v
         eXWv3pcjUsQDnB4WPt/nv8LSzZHThgyxIrmnoJ5+a7xWxD7UW6FM+VofoUuFNHGayxHF
         EVkbEW1i1F48YW8nNzgciiwWlKjoS55cDOc7cayNEu3RosVFMQClfqKC02jpA3AAhwSv
         Msw9hJSPJXoDMLn9NR1xgCUqr6gM9kkpNC0U5qyIiY9y8OMnati4nNbdxkn4Nv7cPaze
         nWbRhizN1xvX0QyO1ZybcnvuujdQd21yVVgT5hFr7h6keCUM4zHK4V6FPzipjUSoUfZO
         15dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525190; x=1756129990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIC+sfaRRNCZ/PpzLr3hvBF4vD7BYR+5HNnrMt71ufA=;
        b=dKM5QWedp9YfjirV/81gwf8q/Gf280cWWU0JwPpxa0+D2PeU4bSXkFQBdl6AYlkEnW
         WML40zL+Tv5G7dm8z/VnRpgLnuCIIqzXyAfsErM73V2ygDQapaS8putPwhy6xqzubBo4
         +umx7H2wLqw0gQuGAE9n7g2VYmsT9AOobJTloyM1LvwPg9OeAcosSD8TBZI6I/HElEpH
         6tA72S7y6yD5FKf/1uP8jUyiKTsq5sZC6LW2Fk6BLnLkAVaDfYX8vMus8/x8G4VNfktU
         V728O8hODol31Gl8A1Mq4/IzSS9z7d5tIOgmWpNC/M4annOTkIpQEhv6ZbSB/c2KTrpS
         tDIg==
X-Forwarded-Encrypted: i=1; AJvYcCXU5rwBlnGDxAh3kXKWdx0HPs+rEq5UDBmPuFOdsC4ptWufQeBJg9KxEXcI6HO8JSF9BpTNz+91vmkVgeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySgs+h84i0sEhhrO6U7sAhoikT3N3ivtjFDl8RFieI7y+/eTlY
	iesKYNNUcC1eudpsKBiCgY3LQnfQOUy5z07XKLSXCQKZvEUEH2QZzYUm
X-Gm-Gg: ASbGncslBcAdNZqLHREMthQpFbh0vAEU3m/xnAF0eYqkeqwMUzhU9Gxxmz+dFk+qGUG
	HRjyCCQgku1tNilKffYfTbD+3kDamTAy/FJ8ymy2auxRSwd5zIiE9z4JKzB+Hde68Y7SUuZeNYk
	+Lih4/ItOvWp8GTI72YVD8rabeIZofmRpWjuw8UPQAaCSUHFy2oUsLBwX8EsXirxP9lCiEMOjqK
	ZhQZE3HosBjllm81fvaYakQ6Ly2xgz3cEr6C2konhaSWcnxJ6Ez8i/AQIcaCSc53/a4ASEvIX2T
	oYivVJvXisGuNUKhkVYCTAksFrMgpqfEDZw0LWpG+bPB4yExSnUpdAsXwQeAR7PIEvjtRft/VT3
	A82fN1ils7GUNFp45kl/s5Er4f2LDdh09AH6IMD6qJuo=
X-Google-Smtp-Source: AGHT+IGlRJIJIBd9MAB6Pmkf/xGaP961Qd1aFVSWvH/Du8+QIpyF1GcpdFSu0rClgL/I4HixbjWGbg==
X-Received: by 2002:a17:903:2f0e:b0:244:99aa:54a1 with SMTP id d9443c01a7336-24499aa5b7bmr12035205ad.7.1755525190074;
        Mon, 18 Aug 2025 06:53:10 -0700 (PDT)
Received: from Fantast-WT.localdomain ([120.229.37.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb075b2sm82013075ad.59.2025.08.18.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:53:09 -0700 (PDT)
From: Teng Wu <gigadevice2025@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	teng.wu@gigadevice.com,
	Teng Wu <gigadevice2025@gmail.com>
Subject: [PATCH] mtd: spinand: gigadevice: Add continuous read support
Date: Mon, 18 Aug 2025 21:52:27 +0800
Message-ID: <20250818135227.2114-1-gigadevice2025@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GD5F1GM9 supports a high-speed Continuous Read (CR) mode which allows
the entire memory array to be read out by a single read command
without re-issuing the 13h “Page Read to Cache” command for every page.

Datasheet summary
Feature register B0[3] (NR bit)
1 = Normal Read (default)
0 = Continuous Read (CR)

ECC status register 7Ch
Normal read: bits [3:0] → ECC status of last page
Continuous read: bits [7:4] → accumulated max bit-flips over the
whole sequential read operation.

Datasheet:
https://github.com/WT-886/DATASHEET/blob/main/GD5F1GM9-v1.0.pdf

Signed-off-by: Teng Wu <gigadevice2025@gmail.com>
---
 drivers/mtd/nand/spi/gigadevice.c | 107 +++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 93e40431dbe2..72ad36c9a126 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -4,6 +4,7 @@
  *	Chuanhong Guo <gch981213@gmail.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/mtd/spinand.h>
@@ -23,6 +24,18 @@
 #define GD5FXGQ4UXFXXG_STATUS_ECC_1_3_BITFLIPS	(1 << 4)
 #define GD5FXGQ4UXFXXG_STATUS_ECC_UNCOR_ERROR	(7 << 4)
 
+/* Feature bit definitions */
+#define GD_FEATURE_NR	BIT(3)	/* Normal Read(1=normal,0=continuous) */
+#define GD_FEATURE_CRDC	BIT(2)	/* Continuous Read Dummy */
+
+/* ECC status extraction helpers */
+#define GD_ECCSR_LAST_PAGE(eccsr)	FIELD_GET(GENMASK(3, 0), eccsr)
+#define GD_ECCSR_ACCUMULATED(eccsr)	FIELD_GET(GENMASK(7, 4), eccsr)
+
+struct gigadevice_priv {
+	bool continuous_read;
+};
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
@@ -63,6 +76,74 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
+static int gd5fxgm9_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
+{
+	struct gigadevice_priv *priv = spinand->priv;
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x7c, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_DUMMY(1, 1),
+					SPI_MEM_OP_DATA_IN(1, eccsr, 1));
+	int ret;
+
+	ret = spi_mem_exec_op(spinand->spimem, &op);
+	if (ret)
+		return ret;
+
+	if (priv->continuous_read)
+		*eccsr = GD_ECCSR_ACCUMULATED(*eccsr);
+	else
+		*eccsr = GD_ECCSR_LAST_PAGE(*eccsr);
+
+	return 0;
+}
+
+static int gd5fxgm9_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	u8 eccsr;
+	int ret;
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case GD5FXGQ4XA_STATUS_ECC_1_7_BITFLIPS:
+		ret = gd5fxgm9_get_eccsr(spinand, spinand->scratchbuf);
+		if (ret)
+			return nanddev_get_ecc_conf(nand)->strength;
+
+		eccsr = *spinand->scratchbuf;
+		if (WARN_ON(!eccsr || eccsr > nanddev_get_ecc_conf(nand)->strength))
+			return nanddev_get_ecc_conf(nand)->strength;
+
+		return eccsr;
+
+	case GD5FXGQ4XA_STATUS_ECC_8_BITFLIPS:
+		return 8;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int gd5fxgm9_set_continuous_read(struct spinand_device *spinand, bool enable)
+{
+	struct gigadevice_priv *priv = spinand->priv;
+	int ret;
+
+	ret = spinand_upd_cfg(spinand, GD_FEATURE_NR,
+				enable ? 0 : GD_FEATURE_NR);
+	if (ret)
+		return ret;
+
+	priv->continuous_read = enable;
+
+	return 0;
+}
+
 static int gd5fxgq4xa_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -542,7 +623,8 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
-				     gd5fxgq4uexxg_ecc_get_status)),
+				     gd5fxgm9_ecc_get_status),
+			SPINAND_CONT_READ(gd5fxgm9_set_continuous_read)),
 	SPINAND_INFO("GD5F1GM9RExxG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x81, 0x01),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -552,10 +634,31 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
-				     gd5fxgq4uexxg_ecc_get_status)),
+				     gd5fxgm9_ecc_get_status),
+			SPINAND_CONT_READ(gd5fxgm9_set_continuous_read)),
 };
 
+static int gd5fxgm9_spinand_init(struct spinand_device *spinand)
+{
+	struct gigadevice_priv *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spinand->priv =  priv;
+
+	return 0;
+}
+
+static void gd5fxgm9_spinand_cleanup(struct spinand_device *spinand)
+{
+	kfree(spinand->priv);
+}
+
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
+	.init = gd5fxgm9_spinand_init,
+	.cleanup = gd5fxgm9_spinand_cleanup,
 };
 
 const struct spinand_manufacturer gigadevice_spinand_manufacturer = {
-- 
2.43.0


