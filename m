Return-Path: <linux-kernel+bounces-761444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC97B1FA24
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B71C1895BE7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D5C258CDA;
	Sun, 10 Aug 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcE1+2nv"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4205680
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833148; cv=none; b=nYejcaso34nBTuJbBK1AGcdx09sZ3/i0a+ZVZ1+NphqlTve1iRrTDvXURcqFX6+44cWnldjxs0XYMR/kuRnvOLBeEt942F61hV7vJIB4rKx1+s+z0UQkiFWX+xdtQOyYdvTkAE3OXB8uLSGIlb+mXEqb62AXm8HX9cIYzSbalAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833148; c=relaxed/simple;
	bh=6/Zd5tNyUFBPJBdLEdpaqv9X25GxYiZLX6mT0Kah7G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UzwVgs8/1HjVn6y2LosZX9ioW4zcYYVfoWqKO4Qiq5+TXys/n1EhqncL7sZrMmLqe0wUw8I1mRl9+4gISIMHC5pgVW5TQrB2hnS1iqhbhS7wDU9o0ltQfXQrUyDz3QDj8NZFaYL3iZxPrEtG9eIuRUW+f/mWtQQ27npV9FK3WPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcE1+2nv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4233978326so1945750a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754833145; x=1755437945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yoshnGQPZvUUhsSurL6kAbf6xWu8EGMASlS/IDx1kw0=;
        b=XcE1+2nv8VFZKC8zkNaZw9pUXxrOruIWieO9mrp7ihx9rVqAMU97TRe9yq4x06Y0NR
         A4Vr8FhRPepnfSCb4I+UNUTh6sqDD/QrPoUMBAwj5N5AGVRkTo1+044Qu3Ql0wPeRW5r
         tAQDZby/H4FCxtf17i8qd4zY+pf7caANhDLOPjpv04Mlda5WasoGG5+1Nk0eUdTwf1xe
         ZYebIOk45soe/VC+woUQ9+DP2EG0eIZqkCsdIvBKSQmdDLEEq4bs5PyMb8lsOZKGX+c6
         nqA/g1MniMwZTaw6q6PdMDwFUTcfrAajA/iFPgizWprxQHskyjdOtwIZQfVbwvciwKxl
         d+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754833145; x=1755437945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoshnGQPZvUUhsSurL6kAbf6xWu8EGMASlS/IDx1kw0=;
        b=aZ3DdFDdBYOOvNkw9wHTWbgsNuXs6L/ivCt/ZBOJE5jHNGeJUXwDcC2797JiKeCfNi
         ZDGhLlMsEyeBtZMTkq2h1jcH+RNQZr4r7sHw3XHGA4RERn7g0UJ9xd8V7BNXjZaV5VUx
         CNbs25P1KmXB5958G5v4fY3tsgESP1/qtTpQX3Ud0/JjJegjulwvUSWpq9NgeTd0gbsm
         yLWCqesww1GHzoQKQuI6EfaXmz8DeOUq5rv+ngVicQ6MNDhN4BMgTbeS3tJmesWDHt6N
         R+tnmb/CQa8sNALO78xky1o2X93xvFfMj4x0assU9yjLIJCP6iOQN4h6Ux+hFRj4IZMm
         Y9DA==
X-Gm-Message-State: AOJu0YzAIKZxXpXHgGOwfPnf4FAtSqRSYcgw0204gwABBJs8pVx8Brh1
	Ev0JqUo/5OmYxKmjN7M9c7hi+r491WdAXEW+OX3pd27N9NiTZViTLQtl
X-Gm-Gg: ASbGncsxUFAduVx34jVEJR2p43UOTU+LBQD80UusfNffqcuGghxbvzTKNgdKwqSDswy
	Y/aYLp7jTOMYNBIkBoHeLGq83agJEq5FhZeuC58fI9vrKvt8UHqfiaOIE+qPBGglTjqZnqNrXKi
	LwmHZBokIO6mu6UAfJoiOQB7rH6mEk+dbapRW2gAqFHrPSDc1TdslOtsFhA0L4jHiASDD/IgbRD
	ggTylAyuv7V77bQu/fr5fTqRzGNz0/vM/TpzbxIeWq55oxO7Mbt+oR7BEgNvwYXK39GBGoQFj4j
	uc1gyGmIYMHO0QXAHZ8D6P8omxUfAiGQTOXWSFAD9lkiF1yxxkG6Yuzk3h5sKySQ9wKTYe8mV96
	5X0Q9C/F8/on9ExvAQNUHwzfobw==
X-Google-Smtp-Source: AGHT+IEJiOcqd3f+iw2pD2y2xG4uE9Z7LUa7e0HgFMcWgFkFuTJ5hxWFqi58BPIb9xglcRf2wEO9uA==
X-Received: by 2002:a17:903:3b87:b0:235:c9a7:d5f5 with SMTP id d9443c01a7336-242c2039f7fmr113424935ad.13.1754833144742;
        Sun, 10 Aug 2025 06:39:04 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:40cb:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a48esm252223925ad.114.2025.08.10.06.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 06:39:04 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Tianling Shen <cnsztl@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spinand: add support for FudanMicro FM25S01A
Date: Sun, 10 Aug 2025 21:38:52 +0800
Message-ID: <20250810133852.52389-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for FudanMicro FM25S01A SPI NAND.
Datasheet: http://eng.fmsh.com/nvm/FM25S01A_ds_eng.pdf

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 drivers/mtd/nand/spi/Makefile |  2 +-
 drivers/mtd/nand/spi/core.c   |  1 +
 drivers/mtd/nand/spi/fmsh.c   | 74 +++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |  1 +
 4 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/fmsh.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 258da42451a4..e288742ea8f0 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o otp.o
+spinand-objs := core.o fmsh.o otp.o
 spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
 spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b0898990b2a5..ea47028d021a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1184,6 +1184,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&alliancememory_spinand_manufacturer,
 	&ato_spinand_manufacturer,
 	&esmt_c8_spinand_manufacturer,
+	&fmsh_spinand_manufacturer,
 	&foresee_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
new file mode 100644
index 000000000000..8b2097bfc771
--- /dev/null
+++ b/drivers/mtd/nand/spi/fmsh.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2021 Rockchip Electronics Co., Ltd.
+ *
+ * Author: Dingqiang Lin <jon.lin@rock-chips.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_FMSH		0xA1
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
+
+static int fm25s01a_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int fm25s01a_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fm25s01a_ooblayout = {
+	.ecc = fm25s01a_ooblayout_ecc,
+	.free = fm25s01a_ooblayout_free,
+};
+
+static const struct spinand_info fmsh_spinand_table[] = {
+	SPINAND_INFO("FM25S01A",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops fmsh_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer fmsh_spinand_manufacturer = {
+	.id = SPINAND_MFR_FMSH,
+	.name = "Fudan Micro",
+	.chips = fmsh_spinand_table,
+	.nchips = ARRAY_SIZE(fmsh_spinand_table),
+	.ops = &fmsh_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 27a45bdab7ec..927c10d78769 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -355,6 +355,7 @@ struct spinand_manufacturer {
 extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
 extern const struct spinand_manufacturer ato_spinand_manufacturer;
 extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
+extern const struct spinand_manufacturer fmsh_spinand_manufacturer;
 extern const struct spinand_manufacturer foresee_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
-- 
2.50.1


