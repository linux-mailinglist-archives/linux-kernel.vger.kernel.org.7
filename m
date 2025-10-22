Return-Path: <linux-kernel+bounces-864671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AE1BFB4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5347402E80
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55326314B86;
	Wed, 22 Oct 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOHgV1Fk"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B631A54E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127670; cv=none; b=mtaR+JNPiHUeE5/GWLb7wF9sYUsEMe6XV7ws0tkywfaOrAoGXn0yQ66DZc0xVSWXAiwijX6YbN9t/F2BkK+ICr+49cwyeGU+oB+LCzH4LzpRwWbVu7JVDLVPjDidYScqGqixyYNmVhEJVxujYe1e524d9IkAIUsx+21YHZDg68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127670; c=relaxed/simple;
	bh=EE+lQvhBcq8YWD8yg0KXpLqUBc6P3VmAPuUl2lPwJ4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ej0rLfkh9FO9udCKGFu4C1KBLhyHug8kz+jTJwf3mhMde3ennJIYI5/f10OEyML9O9EluZfyfCyyw3uPyBxQnV5ll2uEQvs2o5yfWL+H0TJTeNN8e4C2k3SfGXxHk8ZD7TEGEyhIeXnOzzpeyD1TppfBAuy7PsHI5+mHLNkYA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOHgV1Fk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781251eec51so5259432b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761127668; x=1761732468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmV9fCMr++K8ts5w/0Bxy7I3jHnhgfz3UV/3J0ZHaWo=;
        b=IOHgV1FkS72yGC7e+e8w+EO9Gzck/RDccuYdqxV0EvgfPQf+3AZQzx5Eckfzo1kseV
         wSwxCwb1+CbHtEmWpTEubTc40Fnxy1ptWZom2u8qGHs/yimZn6zXaN/Lw8AA97psqfPM
         VcMNjl6mI2E8Y6AOCjYU4ptUSxGuX3l653qT8FL5Dvn37DJM51HunWr52m0TseB923al
         EajzhSqbxwNriXPncYgXaH9yCotzNvH9lbh7pBgT9TlmlPZ2Y49wHUrZ3G/vDziVqWQX
         +LnWhVo9EVFdtSF0sgG7Q1TiSrFqls+iJXdTKeYZbyRMdmmoyqAtb5TMzn3weqet62Qr
         9/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127668; x=1761732468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmV9fCMr++K8ts5w/0Bxy7I3jHnhgfz3UV/3J0ZHaWo=;
        b=ifqZhmImjAR1rtjaIX00IUqdtCVpKYA9g5Bu1T0pl/tbG61X+uPblw+qW7EoeHU7A2
         EPdIsJdwT/2xjNB6m1o//l4JjM2obRx/z7igRVgppWzfhrmoogU3jbGhoh81rKQRgdVE
         XiFmxmUjcLibNpUjIMWmGgpFfDkgfb2qftXBKC5uwC4uDQqWJIAacmPKsZd+L/VIcP3u
         RuM7/+sjPaOCrhiYxDoYkWGdSNBlyqL4XSGXVOMvJgKigKwFl0EMN/MpN5o48XeCu+H6
         CII2XQaEQjhToYJQO+IFFyogMCeWFl6KejuOYlIAFlC0iM5iKsPlGES0faITixUT6L7H
         5Oew==
X-Forwarded-Encrypted: i=1; AJvYcCVIYkErfHkAPNp+NIREIJkKeviRRGCaZV6ydLJsRjUBfaWif501UTZ5/wJs5SC+57K6FxE2QtjD8c6Wngo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzggkckdFfKtBwtQWZrDz7DMBx+zmD52m3hvSHZUJOLvmgfVnbO
	jXuZGB9weymHgZy6oeVXv0KX86tfsQDKY2Y9g+ArP0VEG48g2PkKgYOR
X-Gm-Gg: ASbGncuLQaaSfx9UgsdWMkts3EQQVPMIjujZLUDADNyYDX4ibtw4LfVZzOQ6mRJacFm
	D2suDwjz5RYlWU0SAHPgDXxOt0eZVJUnmK8UFmUPgqrbiRxIwGhBrslhcmirRjyXxB8KqXLc95K
	PMwDwdafhgiln+SWq6ZiUr4DvC3HvhA8V17XgQPa4hDuQWP4smQMEt2dikJWK9svik3LOT7Z8cK
	a4C5Lr6W7LoaXd92kDE0cD6QxmMF8z8Akt2IK7ua2G5kkfV1orpsIFouQGeP78bVBw9vpyJs7nV
	TH697IMZr1/MDIsZucbb7rtDRSxz0LDUaP+e501edpBeA3F/ReWaLGTofF+2PA3rg1XLqQ1Y65f
	n1DLL40N7VEMwsSaJqO+bhGbgA+e3/1H9885R57rojFa/zOawTsV6n8erVutfhZ+Plt01baZIxe
	xEMAoCjdc/iFDojLSOHtrYUC+pjHTeS24x9Lz2OuRSG/5WRFixpfkO/YL1myhjjMiQ0CysWcs38
	0awEtQ=
X-Google-Smtp-Source: AGHT+IGmAyoOf1blTsx9zbXEb1T36PS8OzuPvHqvqIWm+8GwFN3zHx9eDgBeC1jDzo6A+Oib9IpRiQ==
X-Received: by 2002:a17:902:ce8c:b0:267:e3af:ae67 with SMTP id d9443c01a7336-290c9ca6b29mr317088695ad.14.1761127668205;
        Wed, 22 Oct 2025 03:07:48 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdd10sm133774585ad.83.2025.10.22.03.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:07:47 -0700 (PDT)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Wed, 22 Oct 2025 19:07:20 +0900
Subject: [PATCH 1/3] mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup
 hook
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-s25fs-s-smpt-fixup-v1-1-ce26d4084b2d@infineon.com>
References: <20251022-s25fs-s-smpt-fixup-v1-0-ce26d4084b2d@infineon.com>
In-Reply-To: <20251022-s25fs-s-smpt-fixup-v1-0-ce26d4084b2d@infineon.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, tkuw584924@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761127659; l=3092;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=EE+lQvhBcq8YWD8yg0KXpLqUBc6P3VmAPuUl2lPwJ4M=;
 b=fnudW1b5lbsiOhhodsmvx5JidPX2ZaZ/gj2RhsLV8gMTZhFjyYB5rlHvGy23RPN0gf3apC4r6
 8FuCpNV5RReAmciNr5pQDwPHfAGPIcbRnWBumBlSth29mu1NJPz9OZd
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

SMPT contains config detection info that descibes opcode, address, and
dummy cycles to read sector map config. The dummy cycles parameter can
be 'variable' and should be determined in device specific fixup hook.

Inroduce smpt_read_dummy() in struct spi_nor_fixups. It is called when
the dummy cycle field in SMPT config detection is 'varialble'.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/core.h |  3 +++
 drivers/mtd/spi-nor/sfdp.c | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index ceff412f7d65ab7b856795ca5c092cddbf598cd6..5ad46d95d09cc9d527f71579a71eed210e726f68 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -409,6 +409,8 @@ struct spi_nor_flash_parameter {
  *                flash parameters when information provided by the flash_info
  *                table is incomplete or wrong.
  * @post_bfpt: called after the BFPT table has been parsed
+ * @smpt_read_dummy: called during SMPT table is being parsed. Used to fix the
+ *                   number of dummy cycles in read register ops.
  * @post_sfdp: called after SFDP has been parsed (is also called for SPI NORs
  *             that do not support RDSFDP). Typically used to tweak various
  *             parameters that could not be extracted by other means (i.e.
@@ -426,6 +428,7 @@ struct spi_nor_fixups {
 	int (*post_bfpt)(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt);
+	void (*smpt_read_dummy)(const struct spi_nor *nor, u8 *read_dummy);
 	int (*post_sfdp)(struct spi_nor *nor);
 	int (*late_init)(struct spi_nor *nor);
 };
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 21727f9a4ac6926080a116e30830c9533122fdad..9a47dcaca06ae2ad85ac8503658083b1d56d8b96 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -699,6 +699,17 @@ static u8 spi_nor_smpt_addr_nbytes(const struct spi_nor *nor, const u32 settings
 	}
 }
 
+static void spi_nor_smpt_read_dummy_fixups(const struct spi_nor *nor,
+					   u8 *read_dummy)
+{
+	if (nor->manufacturer && nor->manufacturer->fixups &&
+	    nor->manufacturer->fixups->smpt_read_dummy)
+		nor->manufacturer->fixups->smpt_read_dummy(nor, read_dummy);
+
+	if (nor->info->fixups && nor->info->fixups->smpt_read_dummy)
+		nor->info->fixups->smpt_read_dummy(nor, read_dummy);
+}
+
 /**
  * spi_nor_smpt_read_dummy() - return the configuration detection command read
  *			       latency, in clock cycles.
@@ -711,8 +722,11 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
 {
 	u8 read_dummy = SMPT_CMD_READ_DUMMY(settings);
 
-	if (read_dummy == SMPT_CMD_READ_DUMMY_IS_VARIABLE)
-		return nor->read_dummy;
+	if (read_dummy == SMPT_CMD_READ_DUMMY_IS_VARIABLE) {
+		read_dummy = nor->read_dummy;
+		spi_nor_smpt_read_dummy_fixups(nor, &read_dummy);
+	}
+
 	return read_dummy;
 }
 

-- 
2.34.1


