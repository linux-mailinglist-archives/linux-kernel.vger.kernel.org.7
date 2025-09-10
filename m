Return-Path: <linux-kernel+bounces-809340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6AB50C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B071C6240E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148C626738C;
	Wed, 10 Sep 2025 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRNX4WEQ"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB3263F52;
	Wed, 10 Sep 2025 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473568; cv=none; b=qRst665e4xlThtvWx2bNXAyxbukh/JkrkNlFStEc0XvqjcHSU2yzzoWWxSynha2SWKEE1PGkByW5V6XUhb5MD4gkgd1MTMz5GeQHtDUZug5YfLAYzeuW7Sr5Kn/5y8BzwqdDSaqvSBy1HCux2vgS3uoPxkVXAPPln1ep7K32kSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473568; c=relaxed/simple;
	bh=ClKHMj7+eQj549knrXAT6PHut2TRrIvc0PmKzpsj0aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bp64rpBipcNRdZ967dnrjTtz12nybBTfAgtiwNMUc381Me3CqEuu68JvXSNS8wwZH/32rvRfR0rvYOMBXfglifmkWuH7jrzqPb1r825+T7jPKemb/mh4wRXmnRw7tOGaoG6z943rBZ7qdCNlTw0WteLJs/mkOL7VTxf9uNTYzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRNX4WEQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32b590d819aso5473231a91.3;
        Tue, 09 Sep 2025 20:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757473566; x=1758078366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTD4jfZ+v4XVtMAIsHdMuiuSYceyzDlRY16CdCXeB+w=;
        b=JRNX4WEQ8szeXeZsV8ytUZluIe46CTi4qR1vgYMKolY+NibjNO1QI+Zl6QobGJz9vc
         l9zMsTYDX8FOMhUaL+/hxSl1jZ/re3rPVGKbhOnExtyPZo9qYPeZwFTggsk/CONUYBJ1
         khxRduD9N1/TWhgWW5x4txuL+B3pQu4XU6juaOxd8eOVDRh8OgSSLMZ1V4O8xaUNHE45
         orO0A/UA4HfTGsqG5xkrhcWk+ezZmcIqam/3ZZbRlvHE29lMG5S2/XIjiRb05F6+k/py
         VGg3pQyC4zZbVu3gIZ4WKDHRr2xpzAE3O9hr0MXlvdNra7eS609BHbLFuwLWLuIRzEMo
         NYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757473566; x=1758078366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTD4jfZ+v4XVtMAIsHdMuiuSYceyzDlRY16CdCXeB+w=;
        b=HIpZ5CKOgypv/GxGJP9nDxQlF6KVo14lup4yAsF/EUWTJG7ODnC28bOby5uv2PA7CJ
         My9IR9UiFvK3Qb5UmrUQ9sQr2qWtm2WxB5jYV/thSt5OSMPPMSMX4uQNJlI7IbvjQXNM
         DxKpkKY3kFVtyIgjLzTfzAHQHKLf8TAkKQ/SwvKiFdga2ahcq5bHwQ9TXDehgvNrg98U
         wTFNEUqCQxbg9V05/AE3rq92NvXhWtJrdKJdJb560GoTKNjUz9YMNm4KKTUkzKgbqYrY
         nQKlrXIMu2O8USnCFcs/jfdZP0gkqFmCe/x6qa+0VoM5kAYzER4FUXGTtkj6pK+eoHRl
         owSg==
X-Forwarded-Encrypted: i=1; AJvYcCWnpyAjKIgRQ5Abxa3h/VBgjq5K+53gOYvD3UBxjSUYQzSK9DZcoBXUDbdZwefYI2ubJcnCQmyiRv1S@vger.kernel.org, AJvYcCWwyC33mSV/uk45/aFKerKjQ8wWw3etmgX6rAx1Au6U0EDqKw1GkoyaBXswUxQXQFh/OS7UHz5MeeTimhg9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2d+2haQGb5IU3cR07SZOsMuexCXiKrKoeoFYlwos8u2j/Qot
	Qz+xU54X0MsrcbrB4n7a59acDT2zbcqhbrX7L2L/TB+U2Jq5s0BJG4af
X-Gm-Gg: ASbGncsILuSfteiDuK2TaB4Q+YzDcsT3/bnI3hdBu0LaMMiqcYt84OQ8YcLk3pS2fNz
	ByH5kDBrqMyKwMnMEkrnMH7HMpru3popU9eH2V9n9mtzh/sKrWar3a3R9GAiuSgDFuVRzn5a446
	RqOZD2hiAX/N70+zE5EWBqWtsjxOtjQt5GFhi+DG/TiuItZ+8GTSVd5mTVSFVzOtQFzGe7yOCKL
	/Yj9bpWpAj+YKp/O+wX1WGhRu//8EC7v3poIeOKKoVUzJQ6uwsdCgLk1C99aa1Y6olimS6maL0J
	/Osv0udqlB2Z98/xtlqtqzYlM3g8GCVklrq2hftI3W7YW/kMWP+NDsT5vpt3xpJuQcT/rCY5slR
	8JMDlaAE+1Yp1YbzHN+jI3bavi6nzEYvjGnwVDc7qVKtH/n8Q00K/BA4DcTPbwZhTf44vaCsP2i
	aajg8+qjHQtl+YvULYSUHbPMyOvlIiA5M7OejPKJDVb+d1fgZCUN3Oo7Y=
X-Google-Smtp-Source: AGHT+IH28usqYyuiorxIFP4IsRvkvrFAv/8CQm1Kx2W+C4unMcjMCStN7qDcg/tOWpZ0Mdpz4/RywA==
X-Received: by 2002:a17:90b:1dcb:b0:329:ed5b:ecdb with SMTP id 98e67ed59e1d1-32d43fb5b92mr18030127a91.18.1757473565788;
        Tue, 09 Sep 2025 20:06:05 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb5f3deesm672029a91.14.2025.09.09.20.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:06:05 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 570A8802C7;
	Wed, 10 Sep 2025 11:10:38 +0800 (CST)
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
Subject: [PATCH v2 2/3] mtd: spi-nand: Add support for randomizer
Date: Wed, 10 Sep 2025 11:03:00 +0800
Message-Id: <20250910030301.1368372-3-linchengming884@gmail.com>
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

Introduce randomizer initialization for SPI-NAND devices.

According to JESD22-A117E, there is no single data pattern that represents
a universal worst-case across all failure mechanisms. Different mechanisms
may stress programmed cells, erased cells, or cells influenced by adjacent
states, and thus specific patterns such as fully programmed, checkerboard,
or mostly erased are each only worst-case for certain desings or processes.

Given that no fixed pattern can cover all cases, the use of a randomized
data pattern is considered a practical mitigation strategy. A randomizer
distributes stress more evenly across the device by scrambling incoming
data before storage and restoring it on read. This helps reduce
pattern-dependent degradation and can therefore improve flash reliability.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/core.c | 24 ++++++++++++++++++++++++
 include/linux/mtd/spinand.h |  7 +++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index ea47028d0..770304403 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -854,6 +854,25 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
 	}
 }
 
+static int spinand_randomizer_init(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct device_node *dn = nanddev_get_of_node(nand);
+	int ret, rand_dt;
+
+	rand_dt = of_property_read_bool(dn, "enable-randomizer-otp");
+	if (!rand_dt)
+		return 0;
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
@@ -1367,6 +1386,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->user_otp = &table[i].user_otp;
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
+		spinand->set_randomizer = table[i].set_randomizer;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
@@ -1544,6 +1564,10 @@ static int spinand_init(struct spinand_device *spinand)
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
index 927c10d78..66ea8eed4 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -500,6 +500,7 @@ struct spinand_user_otp {
  * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: enable/disable read retry for data recovery
+ * @set_randomizer: enable randomizer
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -521,6 +522,7 @@ struct spinand_info {
 	int (*configure_chip)(struct spinand_device *spinand);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	int (*set_randomizer)(struct spinand_device *spinand);
 	struct spinand_fact_otp fact_otp;
 	struct spinand_user_otp user_otp;
 	unsigned int read_retries;
@@ -579,6 +581,9 @@ struct spinand_info {
 	.read_retries = __read_retries,					\
 	.set_read_retry = __set_read_retry
 
+#define SPINAND_RANDOMIZER(__set_randomizer)				\
+	.set_randomizer = __set_randomizer
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -634,6 +639,7 @@ struct spinand_dirmap {
  * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: Enable/disable the read retry feature
+ * @set_randomizer: Enable the randomizer feature
  */
 struct spinand_device {
 	struct nand_device base;
@@ -667,6 +673,7 @@ struct spinand_device {
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	int (*set_randomizer)(struct spinand_device *spinand);
 
 	const struct spinand_fact_otp *fact_otp;
 	const struct spinand_user_otp *user_otp;
-- 
2.25.1


