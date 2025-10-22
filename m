Return-Path: <linux-kernel+bounces-864672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3EDBFB4FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7CC19C1610
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B181531B832;
	Wed, 22 Oct 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud24wTdG"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67631AF21
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127674; cv=none; b=NfnhxlAFN8sXyDOi21e9lBUFPOIUsSIEYzCoxD7rE7Z3RQC6bUQYueXakdYHgC9EWhVo1sDjUXbh/OZjudPDOcYDYwylFGJgyGYV+B5FECjLo6D3HCTnAc7t8a9SmLEji8FtReBEn0eSqN9DFXF4qoMPw6CaadwHNzopf53jxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127674; c=relaxed/simple;
	bh=BOiQy4dkt6OnjJhuvrMGCPaSRKLELL+BS8cMn1Du9Sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4ikWjA3GXDE1aayNQVZWxjbxhqpsdYSfCBYLR1POiHnG/A22pupDyUQdwguG22tjbsYLu570vvag4BaYi5ey+wBxoPZ5bwmBzZo12xadDz1KfckyjierNq9DRVP7TzpfJiwXiSu4nUeS8HNPVO7ECeUiFQeVeMAWO2vJFIe5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud24wTdG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2909448641eso9109505ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761127673; x=1761732473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Rin+olPBDSpDNBx3ZCCvnc8fn5rgxCNRJAfPjBnGKs=;
        b=Ud24wTdGO04JHq6JYscQAEsXcJ/pXN8jJtsbrIr37ZtMlloSs/LA6gTLdG6Wg9+eD0
         U5xdT3MotQ+PScuOe0MyA4nfebE5kRqSF05OzQ8rupO68bpZqsKDOV6dGIRg9m5HTfGx
         3UoVv6bYT33KPJeWBEAfIwKfCM1k/8Ie96V9YTV8wJWff9JvYY8gSBtP+jyXn+h0uxo4
         HtywXnh0i/T2f/HUbDbtDi46L4MmR09vyiNara7I8ZTHrh4SoPkwQoHkbsc9KyLwk+fb
         ubxjfTjT5k1HJpDBCubZSvEZB26f9JXh28b9dMfoqu1MLgTBFre7HeFbjuDlA1Lr416H
         JGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127673; x=1761732473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Rin+olPBDSpDNBx3ZCCvnc8fn5rgxCNRJAfPjBnGKs=;
        b=acQsxZLDgSN7v2fPOZGdDPtYCw5fYhrzhz9d1VnANpglbiWzo/yK0+IjyI+K2ZkMhX
         sWOhYqKmolCfX4H4ZmxegxjGAiFTWtvINaJoAm5ZLiEIg42n56Cczrhb7JUcdgtc/lj0
         6H2pTyItQmQsDSPQ7YmNjcHM2dwcxb9UGew/91ili+IP1DwVUJrlA7qjw30tRBbf9KRH
         5cKyo6o/lMyXE3F7um7AbFc0MPtY9NeX8jqpO+Ph+wJ577xxlsxiYXuI7LNGrlZMbmo+
         27VDiMRyF8jFKMh4bVeOngNFM/XYoeGh5BLtBHMn2SjyVXGH8gkxL6GlcqIN8CjhGYcB
         xp+w==
X-Forwarded-Encrypted: i=1; AJvYcCWP6Y01n4lfdLUFZ2GOfa/GGebNmKGe5/VMbHig64qYB7iPxlc/lsZtczwNybPx2H+0I5kMA6NSyxwVNd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4DmmR1fVzQJO3D45Nm+wMKiOZhrBPMBoLZrsV5QedYmOf7eS
	FYQX6FyCkWkGINWBeeYD0agYn1UMWfhfsa/8Ej4zfPN5uSnDIid/JBAW
X-Gm-Gg: ASbGncvAdG8G8RcnQm89kiKOeOzToiIsGlUYmDWjAkF29fAWREQHdytmQCcPyPK29md
	Fd3Z8OAeoesO02J+2sPtzi7AChWOlN1nbH5ClyRL4yFEGRBxlYN8kJJM2dbLyUdj+sFaTdMZ27j
	HcjX2R7iJoZTm7TGzl42O8iaDLAl1n4hvkSRC9SlIUF2HCWMRmXGO9JDqsOGMQGO6Q9qg5bkCQq
	LUEariA3WJcd2EKOz9OISjAbdWYSL4xuOWq/J4ErlE8IrhMLOTxovgeyHdFPCM3dqbPHaAYEaXu
	zIgA2FhNkVOg+yT2c/owMTL6xY9+Z3Uim4vc5POullIuz84M8I1DxsqERCrZdPRphSLkqmIdwon
	6DhM6zSM7YNlUTQxpX8qcRfBte3JLBuOOHT90P5g2gfx9oRT2/O4y024lPe5n3ad/G/VluhdVWq
	GpFnISS0QvwFwtn7Y+6g/FSnTXzbP/FOcQDYdNied36aSh6X6WFoSoGhs/GahZA8MEjo4xA+kOm
	2XtcyA=
X-Google-Smtp-Source: AGHT+IEUiygtgTqcwUWRzcMEa52HUa99Ij9lNtSOVruV1mseZ8SjR/ReWp+fLosN/bNvr0EnD8Nfhw==
X-Received: by 2002:a17:902:e5c3:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-2935e03624bmr12703345ad.11.1761127672529;
        Wed, 22 Oct 2025 03:07:52 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdd10sm133774585ad.83.2025.10.22.03.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:07:52 -0700 (PDT)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Wed, 22 Oct 2025 19:07:21 +0900
Subject: [PATCH 2/3] mtd: spi-nor: sfdp: introduce smpt_map_id fixup hook
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-s25fs-s-smpt-fixup-v1-2-ce26d4084b2d@infineon.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761127659; l=3033;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=BOiQy4dkt6OnjJhuvrMGCPaSRKLELL+BS8cMn1Du9Sg=;
 b=Xv6/MqkpU/YGPwnfT1w6kk7uH7YbY+SaOmwrijqqxPSaYsfx0aw+bu55VD2QXPyeW5K9SbIvL
 7L78EonnLmFD0zAWJeTxbcH9Sg8Qdb6d30Uj46pghfMDe4gR79e0+gr
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

Some chips have inconsistency in SMPT that derives wrong map ID and
fails to detect correct sector map. Introduce smpt_map_id() into
struct spi_nor_fixups. That is called after map ID detection by SMPT
and chip specific implementation can correct map ID.

Co-developed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/core.h |  3 +++
 drivers/mtd/spi-nor/sfdp.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 5ad46d95d09cc9d527f71579a71eed210e726f68..16b382d4f04f207aa26190ed8bdf2d19885f7315 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -411,6 +411,8 @@ struct spi_nor_flash_parameter {
  * @post_bfpt: called after the BFPT table has been parsed
  * @smpt_read_dummy: called during SMPT table is being parsed. Used to fix the
  *                   number of dummy cycles in read register ops.
+ * @smpt_map_id: called after map ID in SMPT table has been determined for the
+ *               case the map ID is wrong and needs to be fixed.
  * @post_sfdp: called after SFDP has been parsed (is also called for SPI NORs
  *             that do not support RDSFDP). Typically used to tweak various
  *             parameters that could not be extracted by other means (i.e.
@@ -429,6 +431,7 @@ struct spi_nor_fixups {
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt);
 	void (*smpt_read_dummy)(const struct spi_nor *nor, u8 *read_dummy);
+	void (*smpt_map_id)(const struct spi_nor *nor, u8 *map_id);
 	int (*post_sfdp)(struct spi_nor *nor);
 	int (*late_init)(struct spi_nor *nor);
 };
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 9a47dcaca06ae2ad85ac8503658083b1d56d8b96..a8324c2da0acf2953a4a62e2a9f7ed31fcd8b4f2 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -730,6 +730,16 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
 	return read_dummy;
 }
 
+static void spi_nor_smpt_map_id_fixups(const struct spi_nor *nor, u8 *map_id)
+{
+	if (nor->manufacturer && nor->manufacturer->fixups &&
+	    nor->manufacturer->fixups->smpt_map_id)
+		nor->manufacturer->fixups->smpt_map_id(nor, map_id);
+
+	if (nor->info->fixups && nor->info->fixups->smpt_map_id)
+		nor->info->fixups->smpt_map_id(nor, map_id);
+}
+
 /**
  * spi_nor_get_map_in_use() - get the configuration map in use
  * @nor:	pointer to a 'struct spi_nor'
@@ -783,6 +793,8 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
 		map_id = map_id << 1 | !!(*buf & read_data_mask);
 	}
 
+	spi_nor_smpt_map_id_fixups(nor, &map_id);
+
 	/*
 	 * If command descriptors are provided, they always precede map
 	 * descriptors in the table. There is no need to start the iteration

-- 
2.34.1


