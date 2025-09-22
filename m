Return-Path: <linux-kernel+bounces-827565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21491B92181
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D31885E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537C30E852;
	Mon, 22 Sep 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b="v7TJKlbl"
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C3C30C36B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556623; cv=none; b=s6Bp6w2oqAuPFTuA1snm+47jyjrPPym/s87I9td+nJbeDOv2s7bOai40QBAUQRdVosNdjpNOfo9NdKgiIpajtqv/a1XvWnKdAiLgOwU30GVa3nB5IyNjnzdBYI1QVdw5R4aebgxq/oumDqxUs9Mh9OHnkqgc0ljYtBsVTwYu7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556623; c=relaxed/simple;
	bh=4E5/XL5Z3RUEl6uyZPvcgrzp7ZYaogZvwTMTchvU0vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibOqKgdvo5KP47z/Ntxb4uLc1Rj2onxFQmEWvNEYU9rs7/Orcjwc/jiuqRkhVPLaz/ugP3oU3JcfOgy7WDtnYQU2wvkAOVpgE2KFoGlVOwDYSuDjIJuVOhfskKVIoa+HkJ4L0kSSfhgzqZ3t0E4cXMaIXkKPcQCR94aeH6bDUqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be; spf=pass smtp.mailfrom=zanders.be; dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b=v7TJKlbl; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zanders.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zanders.be; s=202002;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=dnxsXnzMfxrD8+re7WIJCjdAfu5yHxyZgjdVmRrDzZc=;
	b=v7TJKlbltdvu2szaL1HTBkerW5GYUq4QQwOomP5I1nogRrIKfYa/umsJwY0V4w49rdCSkHTGjoGeA
	 0GLVvBjOys/0ffRiPdUfC40rh3urzecKaTrmsgvyyBOislJx8vYOo7v8jmV1x8VDnrF36FeGT1PJqG
	 K0BdA79jXZXjr60j+3Yb1s8m4lj5/r2zVKKT8nsTPwZZka8qjAp6AitkYpivzsxlm2aOfa5Lf1gKwx
	 6cmi0rVdbKy5c8KTKE9GcLlo25e0IrotXOkwqDb1SP7QxZEKzLG8675N2F9+QDp6G++MK27CBRkFNJ
	 Ci1JJOTxTu1dMXsPjjxMcuCZy7cpsCQ==
X-MSG-ID: c27314e0-97cc-11f0-9d69-00505681446f
From: Maarten Zanders <maarten@zanders.be>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: Maarten Zanders <maarten@zanders.be>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: spi-nor: macronix: use RDCR opcode 0x15
Date: Mon, 22 Sep 2025 17:56:33 +0200
Message-ID: <20250922155635.749975-3-maarten@zanders.be>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922155635.749975-1-maarten@zanders.be>
References: <20250922155635.749975-1-maarten@zanders.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Macronix devices use opcode 0x15 to read the configuration register (CR)
instead of the default 0x35. On parts such as the MX25L12833F, reading
the CR with 0x35 returns garbage values, which are then written back
when updating the status register (SR). This may unintentionally program
OTP bits (e.g. top/bottom block protection) and change other default
values.

Other Macronix parts avoid this issue because their SFDP data specifies
that CR is not read (BFPT_DWORD15_QER_SR2_BIT1_NO_RD), and the driver
assumes CR defaults to all zeroes which matches the hardware register.

Set the RDCR opcode to 0x15 for Macronix flashes to avoid corrupt CR
writes in cases where it is used.

Note that for affected parts, the block protection mechanism might
remain broken through the OTP bit: locking an upper block (which is the
only one supported by the driver) is now locking the lower block in HW.

Fixes: 10526d85e4c6 ("mtd: spi-nor: Move Macronix bits out of core.c")
Signed-off-by: Maarten Zanders <maarten@zanders.be>
---
 drivers/mtd/spi-nor/macronix.c | 1 +
 include/linux/mtd/spi-nor.h    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index e97f5cbd9aad..de3f3d963f86 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -322,6 +322,7 @@ static int macronix_nor_late_init(struct spi_nor *nor)
 	if (!nor->params->set_4byte_addr_mode)
 		nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
 	nor->params->set_octal_dtr = macronix_nor_set_octal_dtr;
+	nor->params->rdcr_opcode = SPINOR_OP_RDCR_MX;
 
 	return 0;
 }
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index cdcfe0fd2e7d..e35405b126c2 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -92,6 +92,9 @@
 #define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
 #define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
 
+/* Used for Macronix flashes only. */
+#define SPINOR_OP_RDCR_MX	0x15	/* Read configuration register */
+
 /* Used for GigaDevices and Winbond flashes. */
 #define SPINOR_OP_ESECR		0x44	/* Erase Security registers */
 #define SPINOR_OP_PSECR		0x42	/* Program Security registers */
-- 
2.51.0


