Return-Path: <linux-kernel+bounces-783712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4C1B3318D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AAA3BAF52
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3511F3FE2;
	Sun, 24 Aug 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8ChUHnW"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1417A305
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756054829; cv=none; b=dXvssJUkK/6XizUV/r5WBxq/kHCJAL3WsgHVYONaKFAWHHljbptJwVOAKmMDxphPpnkuR0lTSmI1UQX73LwilG49Fw+0WyXHaQz7ITwivittpC4uarTJWMkzuKW0Xa8czxq2Xrq3wCNc1vKtsTSkYVtWCo9TPaj2ZQ/vgkFBCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756054829; c=relaxed/simple;
	bh=GKVaIdjj6FdamcQ7fMJg8GPhgKUuGxqbSrrQbxtnKVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GR0MAY8xV3Sdzb4vy+Q10LjDF37RDWAc6jn4e1s1sxxlMmezey1mpXo76yItuk51HsR/ls9/g5tNKYZ/kv/tOuqCSMYZVO374UQ8LACwqUgDMy5LEkWkkQ1sFVdesFDigbUslO5Jw87cHeq9uzAM89fum3CjDeuOJrHj2WX3U7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8ChUHnW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77031d4638bso1648234b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756054827; x=1756659627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmGleacCOfQU4OHkTtfI/0sWYR+WQk6W35qBemTqwCw=;
        b=X8ChUHnWgsAkCBnDcbqsMAXFgqkmhOlC0krh/QoTpuJkcv/7rUWB4UMEn09Jc8i0L0
         TXVgFI5kEHpPlErX1rhVB/Lox43/o6bHV9wPaixj2iLKY03JniEDGO66KiuhoR7FKjMb
         8PuUsK3DFLxbojOgbwSjf2z0DRNkjp+t6m44XGEWE1U/aeo+RZre/Vf5/QkrQklN4efY
         8jQ7AftR8J300v5i/FehN89xBSJq3J48s2UBcwSyOhgA3ltS++szpaSFinDw0+3lXMwZ
         +GvULg7a8a9hEwMoHUBme4lskEt2cSAYeYYbeojCPVRkvVMvOPdjGEE5ir9rbGYE9me1
         3F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756054827; x=1756659627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmGleacCOfQU4OHkTtfI/0sWYR+WQk6W35qBemTqwCw=;
        b=i7SEPwUoGsFIq9CZmVBd+q5KyR6APnDyvyFSW0a83Lk581mR+ZGuCtyW008mOy1PQh
         vzUTmlY2Smjzp95Jt6596Mi4YFjJTjzKJJWhaVWmtX0rsq/1cbYgkgTLzCDBqFGbhRp7
         tNoMKPDjXxjmubLwHD6sUvvET+R+LQzwswWB7DRDGVQPkY6DtAqeeZ4bvUp/LDiFm+IE
         vAETSaAZ91Cz1tJyNxLTiSk8wf9nEVQ2xMXhQYi2/WTDjcVlaz04YfRVpfw8H6CcZ6fE
         Wcehp956kvWbPL56tNzsdZ5GgEpQRd8T8fVZosd39BBXoAYoi89wF0RTTp3F7J5s2NjV
         Wj5g==
X-Gm-Message-State: AOJu0YwXxsx+YXFCMjMeMW5itEL19VRQyEERLgcjWbq45MUCouJ7bLWW
	No164XLgFM8Pa0fVnK+ORCV5mZUgnEkml/S75Hc8Ehl/0tOWslWylQXO
X-Gm-Gg: ASbGncu6RqEBqOkWPe07aexM7kEhZfO6nXHEksyzq/E8GiNg1wjdfYLRH16nLm9x3FT
	NOD68iWyjpuCYVDMxqcpK6t3+Drbe36N/HQ033YKsDI6FAPKdxh206jY3HrN2ua/IDq5JkV1h6M
	7u5KpalaAv2QaGnaJpjooBJtOjQrFcio1otpsigun9w3yvjdO1S48LfQSPrYaM96/kEbt2PHGW5
	50OLvTCPUcI/tChQpFK76C6Ib4+Lsx++fUU0uvmX95+UzPe83DyHp30NYg/mgh/WL/WdDLjlA+x
	gQ1745MVI08+TFvLPTpHwqPOO2GjsPhJtvUmUBox7BpS4+wLonCORxkiPcusNV2Jo6THz4c/rey
	GjgvQli6cvdRwtHnJij5oi+a2VQ==
X-Google-Smtp-Source: AGHT+IElqKVPYilmmzfYji1Bu0+XXz6AiqIHE4MkEAgx0v7b5N4DRbNroLA1jElG36TSbsTlvMf1Ow==
X-Received: by 2002:a05:6a00:6209:b0:748:31ed:ba8a with SMTP id d2e1a72fcca58-7702faaef8fmr9063892b3a.15.1756054826274;
        Sun, 24 Aug 2025 10:00:26 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:6225:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb47b9sm5163161b3a.3.2025.08.24.10.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 10:00:25 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Tianling Shen <cnsztl@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH v2] mtd: spinand: add support for FudanMicro FM25S01A
Date: Mon, 25 Aug 2025 01:00:13 +0800
Message-ID: <20250824170013.3328777-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Changes in v2:
- sort spinand-objs.

---
 drivers/mtd/nand/spi/Makefile |  2 +-
 drivers/mtd/nand/spi/core.c   |  1 +
 drivers/mtd/nand/spi/fmsh.c   | 74 +++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |  1 +
 4 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/fmsh.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 258da42451a4..6d3d203df048 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 spinand-objs := core.o otp.o
-spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
+spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
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
2.51.0


