Return-Path: <linux-kernel+bounces-809341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC67B50C31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600C71C6245D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF1A26B098;
	Wed, 10 Sep 2025 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQnN8lvA"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8AC265298;
	Wed, 10 Sep 2025 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473569; cv=none; b=mUCgdcrW9fpel/U9uTsKftz7pCk0ZMxxS9SAJs56UHB24BFMCZrtn/2kfmQhqflizxjmt6LzyFkuY54dLHCQIXdqQL4Le32L3Fi12MyIkNXRSLIZnsEEgQUlCt6x5xbKAvmj89Lh6vNc6eXHFtKvw0coaGTnb98tU10uO495u7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473569; c=relaxed/simple;
	bh=eu5PJ687HqYgIi4QPsqNXeNaD1HG6MbkGt0mNUlLe/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2MEESkvzZiM9XDuw/Mm9yZR+PLIJkSz5rBwdmbXAJ9xhAM09ta9CuluqoYuR+c2W4/cb0HC3PoMbBV5G31OpE90u66Npdmn5KzWBNL0JSbMVcgdho6W8+1Th7zFzq3K2tK3/aHmGKEtzbk83Vgg3AuMyBhT+V8zdekEdu7fSjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQnN8lvA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso6655878b3a.0;
        Tue, 09 Sep 2025 20:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757473566; x=1758078366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jfsu13HN8biP/n/EW77zykxwoqDcdIlmZQ9zgwYNdFA=;
        b=PQnN8lvAG6TVkCa2Xg3rSNAQZWgq5rfuGTIIvmUuTGMYbACEe9B93+ViaEP+4zEw3M
         X0vBjri2MmSXcXr33HaLbL2Bqy38gdmyDb2pZYEt3Naffm3NZAfBHICAyZPKuhKFLHpa
         UrCedAkqdmf9kLqu1LBlLbSgpU/lTjjz9AqT4c7bOPvhWALNp6FvTHBRjgjnxaXWJCij
         W4VipxRTnQsd/HHlI2GGbLKUVPFHe4/61FbjQW4H+Kdo5Pq9gv3Q5IIQAEdBbyhX+LaI
         d5Jo2LIfDYYs6olkYrIVUJRv47AKH8+tScj7Fpozf3X0uOuao/8XOTnsAKNyPpGzuAB7
         eMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757473566; x=1758078366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jfsu13HN8biP/n/EW77zykxwoqDcdIlmZQ9zgwYNdFA=;
        b=FIg1r+7h0SHUt7Bp+NtqFE5bK/sBig9hDP8O8ZAb2OYifTJTSH3XRhe06QWrgHbWzw
         TyJSmbcbV2xz/EXr9jxAV5826iEOME5+J58wKSCcMiSKlS6IKOKtggzg9AK4Jz7bx9W0
         U0jm5kMXwb1EuVRSAf7GxDcfjxULbbcofssH06+XskoZ7CZYs1wWK7sItYAOQU3Bt5cB
         iu2LEd/U+0vReZoudEnLQw0cOAz0zQBze004782BTnBpJGwA+r7joOTiVhcUXJpWu6PE
         z5epx3E+4d7C9UXG6RG9aaZkboMFJZhFn6un5Pj5V4S23AoYJHbYCc11bIBetkxI1AEA
         LTJw==
X-Forwarded-Encrypted: i=1; AJvYcCU7+eToZbsD0l2DMeHfwNKlWl1jCBDCE6cQLHKojoW9GYqEFhmNeCCTP33L59EAhSf97nYYnroMaoj9NJVK@vger.kernel.org, AJvYcCWAfPP4ikpF46lLtZ3r4tjH+hqKyJgz549nVEsSuQVfKZoxbti3kxSLdJE3uTEU1zyMRNWWXecmiGPv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy145TCjhD0RFRaHW3yJt/W3/eBdanzNWxPT370uJLvajw9m26g
	v9PdVMOzUVbdb43/dalgLHoNMp8AsGUcKXlVjkTgdTpKT510x2qGCxLt
X-Gm-Gg: ASbGncublOoJRk04sfGDMalvxpQ5jvWwkHWJVtTUyFJMZ9lOQ28naE3oLkmEKALP5Qp
	pOyFwPPaGops/Ghf0QDiLmlfGP1wLdc7Ztav3QFyyDbnQiaiP2lLMnOmEhaJ3vAUMN0VrtZR0Tt
	OTv4Uop9K18/FhHJXGiCo7FwfPezer7EXrM7WJXNiLlp9xFh2+4LG3E81nSJE/MsaXlkpgqBa8Q
	UP2REBJvrsE1i3jvS/Wr2Xu4boimKKqQDBAy1XkZqXF4hCK53FQe6MXsWIYVr8zsLCtyGWsxY3s
	sQXrNcyDs51qJGW6XUJ5D00c/MYgsF6k0E9ZXqMYlzrZJsKmyO70BzgD1J3R1r/qXFiGVMAeF9N
	48NuZiavGIHSDOPVMSp/MTFjjG79bftdxAJLysyd3LhVn5YxxBtlF/8uDasVBxqjHciX3bWnX2/
	bKYwaVljiMUjpNlHrA+I2oyyOWvh0AZ1nh/w2LKbagmn99CHwPCByFeVg=
X-Google-Smtp-Source: AGHT+IH5S+qulOuahC60MPb/08HMw3Py358hrTsN36Vcd02nHOLBhopc+QqWl4qPf7wjy70VRA23tQ==
X-Received: by 2002:a05:6a21:7781:b0:253:6b75:babc with SMTP id adf61e73a8af0-2536b75bdf1mr17467774637.46.1757473566397;
        Tue, 09 Sep 2025 20:06:06 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a50c49csm1071459a12.15.2025.09.09.20.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:06:05 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 0EC6B804B6;
	Wed, 10 Sep 2025 11:10:39 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: tudor.ambarus@linaro.org,
	mmkurbanov@salutedevices.com,
	Takahiro.Kuwano@infineon.com,
	pratyush@kernel.org,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 3/3] mtd: spi-nand: macronix: Add randomizer support
Date: Wed, 10 Sep 2025 11:03:01 +0800
Message-Id: <20250910030301.1368372-4-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250910030301.1368372-1-linchengming884@gmail.com>
References: <20250910030301.1368372-1-linchengming884@gmail.com>
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

Randomizer introduces a new DT property "mxic,randopt" to define the
randomizer area per page.

The penalty of randomizer are subpage accesses prohibited and more time
period is needed in program operation and entering deep power-down mode.
i.e., tPROG 320us to 360us (randomizer enabled).

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 89 +++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index edf63b999..7450ee1d3 100644
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
 
@@ -155,6 +159,61 @@ static int macronix_set_read_retry(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->spimem, &op);
 }
 
+static int macronix_set_randomizer(struct spinand_device *spinand)
+{
+	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_1S_1S_0_OP(0);
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct device_node *dn = nanddev_get_of_node(nand);
+	int randopt, ret;
+	u8 cfg, status;
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
+		cfg |= MACRONIX_CFG_RANDOPT;
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
+	ret = spinand_read_reg_op(spinand, MACRONIX_FEATURE_ADDR_RANDOMIZER, &status);
+	if (ret)
+		return ret;
+	if (status != cfg)
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
@@ -213,7 +272,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF2G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
@@ -225,7 +285,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -236,7 +297,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF4G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
@@ -248,7 +310,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -259,7 +322,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
@@ -305,7 +369,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -317,7 +382,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF4GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -355,7 +421,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -367,7 +434,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF2GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -413,7 +481,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF1GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
-- 
2.25.1


