Return-Path: <linux-kernel+bounces-773735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81216B2A80C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14955867CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8A335BDE;
	Mon, 18 Aug 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGHfynXo"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30358335BA3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525145; cv=none; b=j4Qi+Ns9Ys9B6fborPmePrTPc1Ikg8hzex+riTwAwXZCvupGuNVxdCCaJzKr5HWmNXckl0tTPmRoBiKGmbvNlysNanL/9RVpAQsUdY7o8fUXTzarmcHJCnsoWnzfFWclZgKqdFfMKI4I0kpcUSrZyNEQ/DM5nc7cBznusZO5o0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525145; c=relaxed/simple;
	bh=RMGPVPOt1tsq9iN6V+lrcwWxmxqcpZke9gexpq5KEUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y6dHkvnHKbu8CoPJDYUrm9pUMptJrY4aRDNQ4+P9mErrRJGEojvloDmkzhotYEojYEDwQBkS3OZ6TbXqnPjdWN+mIG66Pnqr+Y7BWTRzhCaueakf5k1niwjPyNy90PILqcVFAyZAbJOLzjHBVu3DjBBjtSYyGtFcK8lC+cwKqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGHfynXo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b472fd93b4aso2391508a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755525143; x=1756129943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JIC+sfaRRNCZ/PpzLr3hvBF4vD7BYR+5HNnrMt71ufA=;
        b=GGHfynXoj/l9vHnfFzFk76IHz/yt+WLgU20unTA85dlUo98zOYXu/60wHPCSxd9cC0
         H//DZ4MxOcuwhzQhTXBxBCfdRq6dotqmjFEZI7da944XhYkxKPmjmx5sGVF6C3R81/ZX
         wIBN53n+UO2wCra3sn2YeaBV2Ypl1NeePLYTWUm5BGvD+Se7EDOsofA4AZDvJGxvAxhN
         q2ouePDgvl6qwjvA9AiM2rS/yq/KbzEONf0ALThsu8XM+Xoc7HM8MqnU3gov3ffAbk7J
         0f8nOcM4AIi4ZTZaPzQebBM/D4CeZAwOQLzgXw3Z3+6Sb2xDMpkn0Y9hqxXVa40lmHHh
         wq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525143; x=1756129943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIC+sfaRRNCZ/PpzLr3hvBF4vD7BYR+5HNnrMt71ufA=;
        b=bKpOu1closUKoHSkVtBVwhbcP9dPEQqYQXhX2c8YkBrnz3riv97M3bacjXnRa1qJet
         v9hYbddBa5fvRfcUk2LAZ9y4ELozJ/kj+oVxom18l+bx0abe0ZPmqZAazMNzdDCPtjei
         Xe7PAfjg4K6YSYPDCMcL5q/C/ROfuvDBA0Wq7PS0cn/A3wj7WQdJOCcAMbZiU2+NspiF
         ckloPz2g98CsvYUoNTTbNg52P/t0OTpBfnykXrdJ2EQcje6Ce6vCfUzwkV5fD4WrA1KM
         Vumll+/pCj6c9BhnBPLXg7GBDmIO4NMGioLMThp8VJQQclr2NpoVKVbVOCHVEU/Ex2l0
         VHIA==
X-Forwarded-Encrypted: i=1; AJvYcCU7oYjxMsTkM1iMdkQKzwDIRKlfVeMOicpUAx6DltJLdK6iLnh5wO5ZLOUJvv671gp1BsJkOqayRX1HYlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKnP++CrbFUZLxNY3fb2i0NVqtY1i6/Twgt4K8sEGyKmv0ZUjD
	/Sg1LnC/zNw7LX32rGtBj+1x0k1qyH4WB4K9JcSvO0fAgZ3O7ihCWY/x
X-Gm-Gg: ASbGncuLgB0HxRu12dYvst+dNjtg080vrBof7Tyaxh0yHXaZt+FsmI1m9UlM5bvU/Nk
	Btl7hX/p3O0Z0+PiKwdxS3qENIG2gXgiKwmnF+OuhssIxncbI7j2/uAinWNStA9jJlA5NFq828K
	AxlVFZywMtcA/wVVG87/7Bc4RLrEq9/Q0mDaL0Qny/1TICvGQU1fb1gvUSmjvGlFpQj/poDoN4m
	hKTwnKWI0+ZBd1vcz22WYK0e/p753iceiX7BAD4uwKMZwjey5KdcC76WGo9InIlF2g8TbcftitN
	4dIk6zVjR+VVlhH6uVmPIt7bxlxljwV6tGurQAqBDnmFD6A0b1JeFTgM3VQzUxIdqSNoM6KkT46
	5pGSlG75jQKRSBhF6KcCn7TwhNxcZsFHi0+F3oSxF5D0=
X-Google-Smtp-Source: AGHT+IGgUrKNSua0EDsMH8SxXxNcd6RWSqv8OZx8Xxbo5zF6jRJky+tITPWEVzuGEdbYWfg2E6WWhg==
X-Received: by 2002:a17:903:4b4c:b0:242:a0b0:3c30 with SMTP id d9443c01a7336-2446d8edf38mr153112465ad.43.1755525143226;
        Mon, 18 Aug 2025 06:52:23 -0700 (PDT)
Received: from Fantast-WT.localdomain ([120.229.37.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53b22fsm81848505ad.112.2025.08.18.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:52:22 -0700 (PDT)
From: Teng Wu <gigadevice2025@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	teng.wu@gigadevice.com,
	Teng Wu <gigadevice2025@gmail.com>
Subject: [PATCH] mtd: spinand: gigadevice: Add continuous read support
Date: Mon, 18 Aug 2025 21:51:41 +0800
Message-ID: <20250818135141.2096-1-gigadevice2025@gmail.com>
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


