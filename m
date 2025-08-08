Return-Path: <linux-kernel+bounces-760056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3B8B1E607
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D69581003
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFFD273807;
	Fri,  8 Aug 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL6wxaE0"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D9B2727ED
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647030; cv=none; b=eAyOQ+JJ5qhvOVlZfciZB+1baq0nii1Bkh4DBZgRFb0JqigbwOopv3ZNjWwZ1ttucUhSEbczWuvsvZgR5CMC+t3yrFP4FGJV97ujj2NrdHFFUQWHf0GTqAG8EEgDMyOrw7CLj2ies/A0v95SXlmah67iye/QchX0Y9UFIc/zsag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647030; c=relaxed/simple;
	bh=eeG6d04011rqqI+2wtjwbj8MuDRIjUrk7KtPBw6w7dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z52Qedy70hiIaFpITvmjsmrKK3s4jDdFuHoPnaYL+biA1DOCc81WxH4xb3o4cYTR0nL+YIgiJERCn4zop/4O4hoMovpALS3IHPBAK9CAPh+1R3QCXrnnL1Og/VzVDdLBX5EWOhwSQgufGKJWrNl/bC5oNu0l20kxL+4KcyOl31M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL6wxaE0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso2324658a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754647028; x=1755251828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OVTgABZH1eW9cOhxAzGHFpTTStHmIxA1l5/HnxfnLs=;
        b=JL6wxaE0kMP7Fy/zPUDl8QIdxV2bPCM3aOWC9m9UMda+CH9J3H5Rn3RBxcmjPDT6Jv
         uPfXN06LSLWCrG3nHm0GF8JYZMB7Pn+5K+XI0DZYT6wgtkyYWuVqkHAsZUNnC668Lf0u
         wLrzZzt3QGFE+xer7R5bFbJYXyfCXvPi4P9Dsn4OqD9fyMP9po1vKRPSu7gHV8bhWHKH
         C2SB2lnwlsAbnRpm2l8bDr2P2uJIshYCVjdVzMmAAmBmp9OkuFyJdn+PZ4M2znrEo4lj
         EIR2RBwukAceS6aoIOa2RQIeUlTzCq/RVG+/TbQwa2YwSNHyCxq40JF9uq2uV2q9KgbF
         1kPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754647028; x=1755251828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OVTgABZH1eW9cOhxAzGHFpTTStHmIxA1l5/HnxfnLs=;
        b=LcaPYG/Xa5JXR3ZILC7XhKJhh/Ev5PuqCkBG0ubpzM036BKfiHZaFGb1906t5ALP0N
         o2lM18QOEFdVoC9aWUCa8EA5gTieIC7Qe7fpAu79g/LqYaZrktsbY2jwinQ8TRF3W/48
         Drn+9FGfmDEcYh/S6XvANgQmudjLqnJqYtYDMc8NQZ3LJclQEVaMQ7pTO9g+lmjgUcU9
         Do60XDxmJK2208QRrGopTpTKLdO81z5dJE2BZIR1PdQQnuCSeYka8qMijw8vsi1rwsEc
         oCEiJMfHqaSWd56H39FS9yL3hXmVwnsOEaLQJPJIiGdjv4pOepJNKwkAjPq20Nq01Zb4
         1ihw==
X-Forwarded-Encrypted: i=1; AJvYcCXTt0cL7aoQ11RfmDvrP7pTWDfrYAmEtc6YFAMMbIqISYKD6iSrwB7y+b4pHgF/Iu/UQC6ZkiUNHqSxrYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6LY+XqBfDzFK2j8w5VgkPGiiR5/Hn5T6AugFnmhhUJByi/TN
	DLCoiZuf6Q6OPtqeO6UG67SgQBJWkzMFvZYjIIkPJ/dLzfw0nsjnon4l
X-Gm-Gg: ASbGncvP+N7++bJVVO84jdbzHD7c+i9hmQUpmpncfBqsC93iLp8pku/AOj2Nw+4Upaq
	8BRV3eLpnUy9L8Pg4BDJ/irm46QAZUm7PvLwwkpOh5LLWU8vxz/4bSVBPJ/Ywt8R0Nk4TuteNVr
	h8Rb0NF18lGz/0JQZkKKsx+mbMLaOqMaZvkOyDPeVI1rjS3FfRPZZqj+1j2HTlO30uELe5PgCt/
	7MsH8OacypjdVI0C6aqz+qd6TV7wkpEQTmD9e97Q+jPt0xheUYNFzFR2tfbCrwKnvNLMOSbjXeI
	so0Mqp7AAYcde9EGjlXUVr+HG5YE1BaIsY6l0SmY8ODdHJpGO6Tu96c93Uku6NpIUd9wClxgMho
	9WZAWFWdUZhX/89eiBfl+Pf65rv3kAnTs6DFXBq48KeojJLPmc1A=
X-Google-Smtp-Source: AGHT+IGDJdzPEqI+NrI+BZKZRyH15rqS8CWsZNaelZV3fAi4K16ew+DBUD9XLeBVmI1G95AZ80Oh1Q==
X-Received: by 2002:a17:90b:5104:b0:31e:998f:7b75 with SMTP id 98e67ed59e1d1-321839e51c9mr3522987a91.9.1754647027985;
        Fri, 08 Aug 2025 02:57:07 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bacbb74sm17375439a12.42.2025.08.08.02.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:57:07 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 11509804B8;
	Fri,  8 Aug 2025 18:02:37 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 2/2] mtd: spi-nand: macronix: Add randomizer support
Date: Fri,  8 Aug 2025 17:55:03 +0800
Message-Id: <20250808095503.906244-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250808095503.906244-1-linchengming884@gmail.com>
References: <20250808095503.906244-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Enable randomizer function by specific flowchart to set the default value
of RANDEN to 1.

Randomizer introduces two new DT properties for child nodes to configure
the randomizer functionality and coverage options.
 - mxic,enable-randomizer-otp: Specify whether to activate the randomizer
                               feature.
 - mxic,randopt: Define the randomizer area per page.

The penalty of randomizer are subpage accesses prohibited and more time
period is needed in program operation and entering deep power-down mode.
i.e., tPROG 320us to 360us (randomizer enabled).

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 94 +++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index edf63b9996cf..5354b1894bb4 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -14,6 +14,10 @@
 #define MACRONIX_ECCSR_BF_LAST_PAGE(eccsr) FIELD_GET(GENMASK(3, 0), eccsr)
 #define MACRONIX_ECCSR_BF_ACCUMULATED_PAGES(eccsr) FIELD_GET(GENMASK(7, 4), eccsr)
 #define MACRONIX_CFG_CONT_READ         BIT(2)
+#define MACRONIX_CFG_ENPGM BIT(0)
+#define MACRONIX_CFG_RANDEN BIT(1)
+#define MACRONIX_CFG_RANDOPT BIT(2)
+#define MACRONIX_FEATURE_ADDR_RANDOMIZER 0x10
 #define MACRONIX_FEATURE_ADDR_READ_RETRY 0x70
 #define MACRONIX_NUM_READ_RETRY_MODES 5
 
@@ -155,6 +159,66 @@ static int macronix_set_read_retry(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
+static int macronix_set_randomizer(struct spinand_device *spinand)
+{
+	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_1S_1S_0_OP(0);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct device_node *dn = nanddev_get_of_node(nand);
+	int rand_dt, randopt, ret;
+	u8 cfg, status, check;
+
+	rand_dt = of_property_read_bool(dn, "mxic,enable-randomizer-otp");
+	if (!rand_dt)
+		return 0;
+
+	ret = spinand_read_reg_op(spinand, MACRONIX_FEATURE_ADDR_RANDOMIZER, &cfg);
+	if (ret)
+		return ret;
+	if (cfg)
+		return 0;
+
+	cfg = MACRONIX_CFG_ENPGM | MACRONIX_CFG_RANDEN;
+	randopt = of_property_read_bool(dn, "mxic,randopt");
+	if (randopt)
+		cfg |=  MACRONIX_CFG_RANDOPT;
+
+	ret = spinand_write_reg_op(spinand, MACRONIX_FEATURE_ADDR_RANDOMIZER, cfg);
+	if (ret)
+		return ret;
+
+	ret = spinand_write_enable_op(spinand);
+	if (ret)
+		return ret;
+
+	ret = spi_mem_exec_op(spinand->spimem, &exec_op);
+	if (ret)
+		return ret;
+
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
+	if (ret)
+		return ret;
+
+	if (status & STATUS_PROG_FAILED)
+		return -EIO;
+
+	ret = spinand_read_reg_op(spinand, MACRONIX_FEATURE_ADDR_RANDOMIZER, &check);
+	if (ret)
+		return ret;
+	if (check != cfg)
+		return -EIO;
+
+	cfg &= ~MACRONIX_CFG_ENPGM;
+	ret = spinand_write_reg_op(spinand, MACRONIX_FEATURE_ADDR_RANDOMIZER, cfg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct spinand_info macronix_spinand_table[] = {
 	SPINAND_INFO("MX35LF1GE4AB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x12),
@@ -213,7 +277,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+			 SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF2G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
@@ -225,7 +290,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+			 SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -236,7 +302,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+			 SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF4G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
@@ -248,7 +315,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+			 SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -259,7 +327,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+			 SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
@@ -305,7 +374,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+			 SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -317,7 +387,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+			 SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF4GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -355,7 +426,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+			 SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -367,7 +439,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+			 SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF2GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -413,7 +486,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+			 SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF1GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
-- 
2.25.1


