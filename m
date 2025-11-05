Return-Path: <linux-kernel+bounces-885943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06034C3457B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF5D465E06
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C22D4803;
	Wed,  5 Nov 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3FhMSDi"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62F25C6F1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328933; cv=none; b=lxTgvAWKu8B6hh0hTvZYu/3tYQMzoV/Cn7u7ZorQcnfn5/El1HSSU7vHnjtxVXoIg6WGqJHrHV3nwDTg61rT4mWL9RUuFX50xZDMajPv2votskc12jwAnna9cZd6XBLXVHsBYO8lTc1q3W6OrNaCTytkJKFW1ZuN1YgovfOV3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328933; c=relaxed/simple;
	bh=Y6gCu8pPNvoaaRlxS0r2zcF5cZ7AtnTriNRfIAsny+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqG0x3YdbpbB+UjpGDpZUtWsjwLaGv6H35PintbtUCTtamPRTEuzJPDHeZPUZblVrmVeo4Mls8IS2BXGgzu6/KwABpMIwjeKjJ5PXQtoygXymAFmUAw2rLcQJyum8+4z41Rfd7hdpwf/pEBeM3j449TFgDWaox5vOa83D8s3p3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3FhMSDi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2951a817541so72721255ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762328931; x=1762933731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2dXDMbS4ZadtFN+PyoUE4mGeEjAPz+823eSljV2/WM=;
        b=X3FhMSDi2d1CP2vIZBOtdFqWaL/q68LHol9uLdgUYgRGysU8AubzrXB9clU/Imdtne
         RxOEIjCQTPIusxdgYwKLR+YIU/7g5Wk02lB9JbzCo0g8wAn4/espCf1rqHMW6BYN0b/q
         xjJv90i1vhSeR68dGIkNtyVGRmklHSa5xGS00hbjldlqhJ3iJyUEYOLW6VkfRm7KNMUx
         /SyzTMq6nV4ovRCe8mRLdR0e8gZe0tXAv8HENrv+voONvg2ikGL4J7NoRPcHo1fN/LtJ
         NOT7Ho5T55JezjkaUAkY6x8T8V9p0080dxKCrIimdgZ6WMOAyLK6/9TIxoz0fBFiKCfZ
         Xelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762328931; x=1762933731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2dXDMbS4ZadtFN+PyoUE4mGeEjAPz+823eSljV2/WM=;
        b=q9P0uzeIdX96m38ZCxbgI3M8qr8GbLCoucBP6ztP/dcyhPJm58XMRztQmov2O4Zvyh
         +smeI5scaOevEZ82POiCNKtLLurvn4e3SEnTFe2pmNnqyB0TeNxdm13E3KTN1K050u95
         bPrHMHT1bb8otvLglaeUu32szpe6LX4eokz5Uyt3wAfq7IkzSkJTpVxJW/4ZZQ+sKt2K
         Qfc6oTBkViPwZ1KHokuOTs+skWChNxUVaqGtPGwaupfcD0Dv6NGYEymZ9xbtbsvb+flC
         RfA26t7KoN5YfeUG5EGv1G7R9uDIJvzbgc/YqXgc0Kp49R2asjD6S78OA7F31b/PjtUo
         ASsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNNfagcaostVIrGZaw+ZdCldkBRMxLf6BfPUGCMW0XmkJs+TQIBAJuHIIMzTmZRMB7El45FE742eAuv68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmavZzOVBQdOn6Qqwo9Y/1xcH2rml9qu2an3XhQ0kbEQPNaJlC
	e5O9ivB2HxtRgi7sxZ5XlRT7jzLGIKMLH7T0c6LXO28/U8j6fqSf+GJ6
X-Gm-Gg: ASbGnctdqeS5WHr5PdzoX1OnEb0djtmjjty06xznPXxxVDZYbYoWdN9N4o1SYJJikCV
	igajxDRsIyBPatZBVkWYCUDaQaIqWrQ/aWUaKqALEOA/lKPWF7nOmyrpHxEGuyXK5IGgLfufETZ
	6Ce728MhviHaHSifIicNh4p4c6rluByflquPFXsHkYdnUxhXP+uZ7dxLrKmmOJC3UIxSt+Tate8
	FM9/Q0a+bkkC6HFEk6WapMD4OxG1q31QLpYKzy+kIzfp3qZCQKTEbEZ+s2M9uUV+DkYrzLcLNT/
	7ZRgto8+NMyXb5ZN14OViU6Bko2fvMRC89IxzAzQhw/PW74fhqMIF5/cyxZ2OQqvYmAGJF8cKpD
	5qDxTvXcGgRReQTFhbxM9mXPc16PsK8wRZRExXXFbrkNTG5pVAEOwp0gfebSbzchBpCYyjzEFIt
	B4dIFOkzTcpHamtOI4KSZXkjzAOfxTcZs4F3ChSlVoVq1M/yUINEXTBMaQsF0YV5Lvngu+
X-Google-Smtp-Source: AGHT+IGwjhbHCrSIYYxs5ggXUedTi5MyxYZDYcPG0zxnBQaAx/ghpOMWz8w4ztpv3bw1eLJhcf344w==
X-Received: by 2002:a17:902:d505:b0:290:c0ed:de42 with SMTP id d9443c01a7336-2962ada2117mr36675415ad.36.1762328931245;
        Tue, 04 Nov 2025 23:48:51 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d74csm52174625ad.76.2025.11.04.23.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:48:50 -0800 (PST)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Wed, 05 Nov 2025 16:47:58 +0900
Subject: [PATCH v2 1/3] mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup
 hook
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-s25fs-s-smpt-fixup-v2-1-c0fbd0f05ce7@infineon.com>
References: <20251105-s25fs-s-smpt-fixup-v2-0-c0fbd0f05ce7@infineon.com>
In-Reply-To: <20251105-s25fs-s-smpt-fixup-v2-0-c0fbd0f05ce7@infineon.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, tkuw584924@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762328922; l=3552;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=Y6gCu8pPNvoaaRlxS0r2zcF5cZ7AtnTriNRfIAsny+8=;
 b=qm9kpfsjYgh2IDEtyLHT7wJAwnQk/1ZlXlG16ZoG+XF99c3jgO1rzmonmxivaARRWCziFjouU
 25dlgimw7u9CumWOY3/nTkb308qOvavwoP3UoGiHKGl95jBKq3iYUZG
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

SMPT contains config detection info that describes opcode, address, and
dummy cycles to read sector map config. The dummy cycles parameter can
be SMPT_CMD_READ_DUMMY_IS_VARIABLE and in that case nor->read_dummy
(initialized as 0) is used. In Infineon flash chips, Read Any Register
command with variable dummy cycle is defined in SMPT. S25Hx/S28Hx flash
has 0 dummy cycle by default to read volatile regiters and
nor->read_dummy can work. S25FS-S flash has 8 dummy cycles so we need a
hook that can fix dummy cycles with actually used value.

Inroduce smpt_read_dummy() in struct spi_nor_fixups. It is called when
the dummy cycle field in SMPT config detection is 'varialble'.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # S25FS512S
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


