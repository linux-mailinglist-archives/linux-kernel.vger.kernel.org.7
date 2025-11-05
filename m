Return-Path: <linux-kernel+bounces-885944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C9FC3459F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1362189F48B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA82C1780;
	Wed,  5 Nov 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP9fGYxi"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0D2D6E61
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328937; cv=none; b=Y/Jp4jRnrsThGHkHqZi9KVAYS7SVMrHQEwJMYXY0qhVW0xaColF6kjlQ2ZMkIfqwwR4/eXZISIFGuv0lqVTjqs0vr1MN3ebLXaJBgrbMGfA1QeLTgck3MJWMJA1XuR3lId0QotfRy+4QnhFlYSLYxW56HzycmeoALPBpRnEeE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328937; c=relaxed/simple;
	bh=nVurDGisbQbassAJC1QWOPaOxEMZSWrlBausbDp0Gps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NMuD/PYTwBoWc/0kUIsB8koGZCiEE4LACR1rg/DqRYgudGPX7Xmcl8ju4z2nahaIt0evOWuLv+a18OzobYk47Ubpio6+QRgJWrErVzbahOkQk6EGaHBvfzxdx2vC7HLyI9LgltZUAWEtkZqIeEjsEHanCeCurCF5WZcd7yKEPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP9fGYxi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2953ad5517dso50119765ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762328935; x=1762933735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHv4nBRWTZt8vdLPnNPAb7DtW2NOOoy9mz9SlCozYmE=;
        b=fP9fGYxiSP2UG0o6W/Pd5PdkVKgOIIQ9mHbclT3r7JunG2Ph49IlNnm6KJWzZvE5fV
         ePw5i/SdTLj5rmnE5lYME4mndULBMmG4vHM2CJ9tZ8xh/0wAaT1Cgf0a7NUn5hQaOs27
         Fjd4oytY7UDeW80T/8V+vShKXZdBZUmEb7GYL1BwTtENy8RWOc0vnJQM98WWvdFcoqtl
         qx1gZqp1KqPcFsDvodPWCq03G6RSy9RFGQSqlkKZj9yX5a35AtrRi742DY4oW2hM+nfr
         Byt5S4v1zSFIE1t/FOkkqhWU915SugaUZMz8N0GECjrXDB6F6XjnO46vOLPA169sCDA7
         S8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762328935; x=1762933735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHv4nBRWTZt8vdLPnNPAb7DtW2NOOoy9mz9SlCozYmE=;
        b=lvOrrYItLNrFEQ4NFZ4Lu/255LPGD/j8eyviWKRvepuF8XnTNl0Lp2PD5EAkvWr87m
         OtRHlcJx6q+bDqEurvcJyDOKTDtBpProSe8Bot7AKFZW/9XDpqULxhbUfxk5cPgAdqIi
         uUV4BHv7qu6QjMfRy6R0ES4O4ouaFvbz7J54LHJm8cd16AQVuoM7tDh/1a/naCIv4Peu
         m2qxcQO2G/UKbpTKqOA8JUUgVTdLeb8620gXNS/hfDXBqExIZYQIrDpxIzDEV5GoXA4A
         zUiFiVKNmoAYdJ3LpPvNJqo0+Ip2wEPaj1JHaCgwl0UIOuhAPgQF4LFgFQH0LX2qL4VJ
         k4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVtvdqTjlevPnDbOlOpGVOuQPbcyfAtQl+n7sk0sjayVXKl/PvZjzqlWr2lE/La3D1KjAz3kr2xOU/IDJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx049Zf4KUf54qIDFC6IXmyx7d/LHgrbCMnA/EIcBIil42+BIBO
	axYM+L2GCnU7c0K7zoc53TnBR0QFKVDfOB0CT9zJbZJYbpogluE6TMCk
X-Gm-Gg: ASbGncvp/OdBcJsMePl93vohTby3rIzRsapFDvwqWmC4OLLTr68rtoX8zCoOuiFOdD7
	i+DoHfnzVIzRBK38cF9OY5uDQw1XJpWmg4z4a1FDZOXVAz2Rdn5m4nnOI/nYqSMLXM9xZZd5VRD
	0TLswZVrfBPpfTAXLvEAbbGDtscbgog5/jhkzLrLH5E8Y2v7v5V9DPe/aDk0dg+/ipO7h9LyWgU
	LVBN1fHa3/uvTfy+mKRYQITgjxzgcD/oBAKf6w8zGan/iRmEQzEytT5F6NGwuOWDH+r1PmeWkoj
	t43jpGEOal53hNW4gm7SVMsXkxq0g9pjaLXAEIaDy/qNGu+D1Y62fzguDB5n/QjKJUNwKzGkzfE
	9p2C3B2VhjyVEdnbH9nEs2R2Dv49GZ9k21LOCUqhtdMkqkezkdFCBPXV3Zg4I+T2yQ2Aup/3K7b
	s+uKCfp1y5gPnELNyersMY4XuwZaAG/EP4QroSb41AyGwar4xIediREeFFnoA29rSK6RND
X-Google-Smtp-Source: AGHT+IElVyESUBfM59SFNCufOWVW00WwLiAjs5x1QKfHQ/x0q29nn57QGeqQMEk8D/eNZfrpYehqaQ==
X-Received: by 2002:a17:902:f550:b0:295:b7a3:323c with SMTP id d9443c01a7336-2962ae4c35bmr40142525ad.28.1762328935617;
        Tue, 04 Nov 2025 23:48:55 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d74csm52174625ad.76.2025.11.04.23.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:48:55 -0800 (PST)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Wed, 05 Nov 2025 16:47:59 +0900
Subject: [PATCH v2 2/3] mtd: spi-nor: sfdp: introduce smpt_map_id fixup
 hook
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-s25fs-s-smpt-fixup-v2-2-c0fbd0f05ce7@infineon.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762328922; l=3412;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=nVurDGisbQbassAJC1QWOPaOxEMZSWrlBausbDp0Gps=;
 b=U/A5PCXLDj1/YLoagxPCbAHte+oH8HOQeW3C0Momim8VXyrbo2zUdVGd+/RdqiiuwT3BlTbr7
 g9pgun+A6Q/D/DDJ2xjxAUfiOjfvHmCvpLX9ou/6JrDO9tMABhcQEjB
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

Certain chips have inconsistent Sector Map Parameter Table (SMPT) data,
which leads to the wrong map ID being identified, causing failures to
detect the correct sector map.

To fix this, introduce smpt_map_id() into the struct spi_nor_fixups.
This function will be called after the initial SMPT-based detection,
allowing chip-specific logic to correct the map ID.

Infineon S25FS512S needs this fixup as it has inconsistency between map
ID definition and configuration register value actually obtained.

Co-developed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # S25FS512S
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


