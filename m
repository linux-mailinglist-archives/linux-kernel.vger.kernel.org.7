Return-Path: <linux-kernel+bounces-760055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20F1B1E606
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF313B60BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D232737E2;
	Fri,  8 Aug 2025 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2plU9F1"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C2271461
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647029; cv=none; b=W5ydFSyWCvwLRbUwvePl3h9HqVJoIvDc3ohuVlv/x03ciK0QLrkhUjhF5pdjHFaiYq9DKd6a75l8t+TxUwcfFeFs8PCy1i3GGHYP6gu1n22DhgkixjkOVSmGjHQQBUBHOvGdePS9unROgkg0rQifWDlhzLFjzl3phGm7cuUvK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647029; c=relaxed/simple;
	bh=C1r3EKrTI4TM+yz3sBubMp/hyIBwBzrkqdbuygd1ius=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N42Ky6nolfH6qQxVHwJYdLPEUtLokXWuysSytWxWr+LFjgVntMsk6KOK6TwO3n8rDZ4R1MdHU4HHT4KNBluGuqQy3l0KinGBQ0+zhLzTBgoU2zBJT32Xn0OYH75Ij8R1JATvryTvSBhUQraW3gSQ052sZxBwEy8jAdtJdUnD+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2plU9F1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76b8d289f73so1934134b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754647028; x=1755251828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vmKjWW1myNVQEZSQomIGtvbv8eIPEiLrdMSovGeNIY=;
        b=U2plU9F1VaevfzYWjDN2pNYQISv8PH76QaL7j4/3knIPc0kGI+1L+SRAqh+Q1rcd9H
         GCGRHIIXT0qQqSGrRTMmZiAMpvB0cvvdNVoIBPrErtknZ109bFZXLmd9BxnkTr/9H7PD
         i1kQcT1kEB5BXwi1VkzSgZ5p8zp3r+LpHAFcQ2BVUyJPXonb1Ch30WXPYssL+D91x4jW
         yMl0Q3cl0tqXpk+SaljuDFVww+LDmRxU+X4DhA6+cVL5LdUd3DwYrXQ+33PO79uNvez8
         Z+YmnOiMrkIecnNhEmg1h9e2dqOL7/+EINMyy2Zh6865HJV843hBK4q50zdr1ambZi/m
         Y+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754647028; x=1755251828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vmKjWW1myNVQEZSQomIGtvbv8eIPEiLrdMSovGeNIY=;
        b=i/ZKSXA96gqWr8Jt+KZO65ypz7ZBBWQNxwwtnu/P1C1J1euEVt7wTslIjgmpUWFmAX
         z7s47yIXQYp3QnK1b1x5n2vnJJq8cWU7zncoO5KgN7BLVgp3UUj8jOnFCg/AK07luMLK
         ShJoqRP7zWM5HzU2no/VY1EAcehYuJyVKvUgPUKe6leMN3SoElgGdL103NfgIiwmBELD
         MNTaCCjD+uh9Oq1auKG1AiSnTTYx0L11K3pCLmDV1Vzdz57eydCIqAxTaQ/CFSPWhEA3
         N2vaYdGnte0SHrlrLtvEQ7JC1kmTi1VLyMn3Apc/6epG8VtwckGOsOM+t9wbaBw4FDKu
         1Wkg==
X-Forwarded-Encrypted: i=1; AJvYcCUZA1JVeCi5CxVuGmWNhN3SWmLONEP/aq7+Wf5hkZqFcVB8LK/HrhyUHWI55oDQM0++jo9l8trTp2Eqz9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHooy2CyYn9AWW3NOZDj2Q2+J+B4wY3bhOgjFy1K/uxid8Cz/t
	YPIXhVQHrXQLn3KwMvNAfCAiBKiVz9FkNCjukcnJaGM968vtk5qojItz
X-Gm-Gg: ASbGnct2W1XphYoqUa8z7wyb04rQiu42nZ+9FoFvJjTqm/MP58fCJhaaZtvqHfZ4xte
	Ds+gkCoWFSjQgHbYdT9zixMDkBkF4+Up3ULa5fg59PFq7Rog3inYYJeAx8/FBwGnRHAGZQEV3UP
	blR6ZtR/JRuzuhdsTvCCxACDVeUQhdsQhBPhnEopxJ1h236ED43bZNwvrIUv410WyiwG9rVqvAz
	2SBu/AS5lblgpvBy/2UJA2c4wOfIEaFBfMZqp63KhOjQqY2bpLTb0q6gE+2qUiFpSU9QiCtXNOr
	yeu/qv3nOpU3LSJolcyBepim9Uwl+pF2oWjL7ED07xNimk8yoTFCLCyxpnxzxkfOYytBjQwzf1E
	OTIElhwXL5DoXmsVLnZaW5NdSva44xA8q/FKyhfseXIIWKNtJ5F9dLADj
X-Google-Smtp-Source: AGHT+IFxSlFjgGlX3SR7lGGDbtjjgA3/KdcOW6YRHUwFy2xGZWAKh00xM2XD3tfIzpmP6ms02kZyfw==
X-Received: by 2002:a17:902:f790:b0:240:71ad:a454 with SMTP id d9443c01a7336-242c1fd9671mr37529925ad.1.1754647027481;
        Fri, 08 Aug 2025 02:57:07 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef66efsm204467915ad.32.2025.08.08.02.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:57:07 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 38A28801D4;
	Fri,  8 Aug 2025 18:02:36 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 1/2] mtd: spi-nand: Add support for randomizer
Date: Fri,  8 Aug 2025 17:55:02 +0800
Message-Id: <20250808095503.906244-2-linchengming884@gmail.com>
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

Add randomizer operation support for user data scrambling.

For more high-reliability concern, if subpage write not available with
hardware ECC and then to enable randomizer is recommended by default.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/core.c | 18 ++++++++++++++++++
 include/linux/mtd/spinand.h |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b0898990b2a5..43ed5de282c5 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -854,6 +854,19 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
 	}
 }
 
+static int spinand_randomizer_init(struct spinand_device *spinand)
+{
+	int ret;
+
+	if (spinand->set_randomizer) {
+		ret = spinand->set_randomizer(spinand);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
 				  struct mtd_oob_ops *ops)
 {
@@ -1366,6 +1379,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->user_otp = &table[i].user_otp;
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
+		spinand->set_randomizer = table[i].set_randomizer;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
@@ -1543,6 +1557,10 @@ static int spinand_init(struct spinand_device *spinand)
 	 */
 	spinand_cont_read_init(spinand);
 
+	ret = spinand_randomizer_init(spinand);
+	if (ret)
+		goto err_cleanup_ecc_engine;
+
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 27a45bdab7ec..80a5c6ac6cc5 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -499,6 +499,7 @@ struct spinand_user_otp {
  * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: enable/disable read retry for data recovery
+ * @set_randomizer: enable randomizer
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -525,6 +526,7 @@ struct spinand_info {
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int read_retry);
+	int (*set_randomizer)(struct spinand_device *spinand);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -578,6 +580,9 @@ struct spinand_info {
 	.read_retries = __read_retries,					\
 	.set_read_retry = __set_read_retry
 
+#define SPINAND_RANDOMIZER(__set_randomizer)				\
+	.set_randomizer = __set_randomizer
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -633,6 +638,7 @@ struct spinand_dirmap {
  * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: Enable/disable the read retry feature
+ * @set_randomizer: Enable the randomizer feature
  */
 struct spinand_device {
 	struct nand_device base;
@@ -673,6 +679,7 @@ struct spinand_device {
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int retry_mode);
+	int (*set_randomizer)(struct spinand_device *spinand);
 };
 
 /**
-- 
2.25.1


