Return-Path: <linux-kernel+bounces-864673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B38BFB50A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7A6C507CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87EBDF59;
	Wed, 22 Oct 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh3qP5IN"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF231D742
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127679; cv=none; b=e59gAovdycCXhqOB59KfyAG5PzPnn7QaNy/Wrx6co3ubdMxEwpqSCc/bBHVQHTTgJgSRxH8F4qBzLahyrk8jkIYx7yvluRsaeQBXjvNi4HDU2mz3XR+W05tUn12WgAyith00P0OPrpIC+7CnBzrQqrKp6nnK67qAp83pxY2CrqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127679; c=relaxed/simple;
	bh=fLuO8IxKB26gg7ELkbxj90c+H+nFUPtNyWO7nnhkCfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mx5mxH7rIBhRCJAPMZRtNfoGOHVteq530SpVDexVYc/4ZlUy/B4w7bhMEtUGWrGUzlbGQG4Trs7bd9bnqFiffZMKbZuzcy+bLrW4lPipLdgBxFSWj/QwXOSMut5pcoebk64hwVp37BbDsVquu3bFUDNHNnP9K41jmLfTfx/4Ksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh3qP5IN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290aaff555eso65523585ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761127677; x=1761732477; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhhPNj408J9IsKyB0ngF4mWpHs2Tqp+ApiMYzTxgWxQ=;
        b=Nh3qP5IN1xAK1nvWF0BMMyXYfBZwHl/LEQOkivZrmKXYkzKlq4TxyUDej15aP+V93m
         C7xpRTpTcYAL8F1QYIbKFPJWi56LwM8xw1fl7iJSdIhMeFQhcosLQFJabDH/tuTRyscY
         FuplSrP8WZtjbwyHb77tdtg3cGqA89RAZsPWR4nVV8F/uIoJg+jVbvTkmaxMgoKZ03kU
         tUXnZD5rCROdGOoKgX/xTZi2yXmhZAjaSw9qw/XpGXN6DvkRte4ao3LQclStmhRkopZY
         I19MpjXf2BUV0UzhYj+Pr0pTmIhje5KPwmLvl+2uurZBCeLauzzDsDTeAnxmZKt9hR2M
         D1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127677; x=1761732477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhhPNj408J9IsKyB0ngF4mWpHs2Tqp+ApiMYzTxgWxQ=;
        b=fWeTa2CBs74DCqYhoK3m0iYFPRE3Mx25rHp3sW+U8PJzVDt8qwCtmpm1v+SzmjP4R8
         lM8jkPLNwwfKFDBOcF1Y4IdZCwCCOGXKukWTmw8lP3MCMOnK7okHY2hdJi3zd984kqkE
         9B0zEP+Z9q5EGGKJCHFU2Phybm3rOJJ5HOs6nw7vdey6zZUkF5jMZ+AWpkNB+z2wChqm
         HIob7G2dD2qxjHcWjNBqdkGEciAxHhTh8plsUz0HM4ScZePyyetCLGOSRVlqp1UAjAFd
         de15tRn3nW7XntDzX05TWG2OaypW9jZgANiV9Vd4YEKBuqijHHGgnJnYbb5NQ7epzuJF
         YKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLIoPLDjYUN5bzFvc8s6SFAPT97cWqIJ/cOHI9V0P0oIE9hHixxRv8rpgmWALpKqIKD8Wcv/wpLdSsaF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMOmjZuVnEvkvetX94AOzUX4uvpXghyAG0xDx4TNCDy3IefRP
	wb8LZXcl4tqAqS4IqAhHy367Gw1rKAQGPSkMul5uYhshrmQNzOpwLana
X-Gm-Gg: ASbGncvA+X8T3Z5RZoHsbUcJFovjsi6K/SxBpV1hY4SSsjMZRqGQj38cNr5ZrSFl8yk
	dUk+h6ASNkE232eN+9QT0yZCCB4rcsUD8+O635nHzqwbtby+vpmdTAECVLM2bugTF68//m5yVrs
	FaZ42slPkDuFUc7ZOSyasCHNgpCwu/4yJ1EN+/3Wjy5x9BkSokbYF1CAUL+77nrnA4Ntu3ghr6i
	9XwhrP+y/2JG4CE3yEx/ovX8Z8ZNQocLMKjWxG3rtCp7dtNkpv/5uLMrUp9FwU4ri+fmq+hqygq
	fy/9lQftXkGq/o76BYzxUwLD7SC+JVe/0X35HFyPQYsKZLCehuBh+3uQheXbxKeLzRBoQejab3E
	61VI8dVPSTPSNtgZn2wb2wQlokKuCi3OfLw0GI0st9Ui/bGLVHCAwwT/LpgOEUaQA5pa6eRbpSQ
	VSADBefr6Sjk56pWZUQrpx9uFEpujBF1koJupGN+q2kGN045WbWl7+WH5FAQn4gpy7Gx7YJCZD8
	54tdBw=
X-Google-Smtp-Source: AGHT+IF0dKQMctLSkd4qXSEnXRqPwvQ5TWac1/EzJdBKxCT0QRGMk7vNb6lFW2DDOrk55+uovWre8Q==
X-Received: by 2002:a17:902:f70b:b0:283:c950:a76f with SMTP id d9443c01a7336-290cc2f91d2mr263984515ad.43.1761127676820;
        Wed, 22 Oct 2025 03:07:56 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdd10sm133774585ad.83.2025.10.22.03.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:07:56 -0700 (PDT)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Wed, 22 Oct 2025 19:07:22 +0900
Subject: [PATCH 3/3] mtd: spi-nor: spansion: SMPT fixups for S25FS-S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-s25fs-s-smpt-fixup-v1-3-ce26d4084b2d@infineon.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761127659; l=3010;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=fLuO8IxKB26gg7ELkbxj90c+H+nFUPtNyWO7nnhkCfo=;
 b=bltMHTs5AspF5ecMV3QBvbvqMd8jNFEudmeFnUVLAxuuGrO/QAtbtyiK/3a7pP7nayGZtn3hr
 LMils1Ud7PUCyjP7O8WjupIXPM6w+lk8FcqePY079/f5M5jDtDdf6Fc
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

S25FS-S family supports SMPT that helps to detect sector layout settings
in configuration registers, but some of parameters in the table are
wrong or undetermined so the fixups below are required.

Read Any Register op is used to read configuration registers that
related to sector map. The op requires 8 cycles latency by default.
Implement smpt_read_dummy() to set correct dummy cycles.

Map ID is structured by combination of CR3NV[3], CR1NV[2], and CR3NV[1].
However, in S25FS512S, CR3NV[1] is RFU and always 0, while map IDs
defined in the table assume it is always 1. Implement smpt_map_id() to
fix map ID for S25FS512S. Other densities in S25FS-S family (256Mb and
128Mb) don't need this fix as CR3NV[1] in those chips is configurable
and map IDs are correctly defined in SMPT.

Co-developed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index a0296c871634678be509cb30d26e18debff3066d..89e85eba2c31a4d74dcbfeffdeff7139b6e0f6b1 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -785,8 +785,42 @@ s25fs_s_nor_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
+static void s25fs_s_nor_smpt_read_dummy(const struct spi_nor *nor,
+					u8 *read_dummy)
+{
+	/*
+	 * The configuration detection dwords in S25FS-S SMPT has 65h as
+	 * command instruction and 'variable' as configuration detection command
+	 * latency. Set 8 dummy cycles as it is factory default for 65h (read
+	 * any register) op.
+	 */
+	*read_dummy = 8;
+}
+
+static void s25fs_s_nor_smpt_map_id_dummy(const struct spi_nor *nor, u8 *map_id)
+{
+	/*
+	 * The S25FS512S chip datasheet rev.O Table 71 on page 153
+	 * JEDEC Sector Map Parameter Dword-6 Config. Detect-3 does
+	 * use CR3NV bit 1 to discern 64kiB/256kiB uniform sectors
+	 * device configuration, however according to section 7.5.5.1
+	 * Configuration Register 3 Non-volatile (CR3NV) page 61, the
+	 * CR3NV bit 1 is RFU Reserved for Future Use, and is set to
+	 * 0 on newly manufactured devices, which means 64kiB sectors.
+	 * Since the device does not support 64kiB uniform sectors in
+	 * any configuration, parsing SMPT table cannot find a valid
+	 * sector map entry and fails. Fix this up by setting SMPT
+	 * configuration index bit 0, which is populated exactly by
+	 * the CR3NV bit 1 being 1.
+	 */
+	if (nor->params->size == SZ_64M)
+		*map_id |= BIT(0);
+}
+
 static const struct spi_nor_fixups s25fs_s_nor_fixups = {
 	.post_bfpt = s25fs_s_nor_post_bfpt_fixups,
+	.smpt_read_dummy = s25fs_s_nor_smpt_read_dummy,
+	.smpt_map_id = s25fs_s_nor_smpt_map_id_dummy,
 };
 
 static const struct flash_info spansion_nor_parts[] = {

-- 
2.34.1


