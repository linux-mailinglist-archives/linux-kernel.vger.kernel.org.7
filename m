Return-Path: <linux-kernel+bounces-761967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E69B20085
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4D83BE5CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36C2D97B7;
	Mon, 11 Aug 2025 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY77jigD"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806D2D94A5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898056; cv=none; b=hCq/hSk90MQFGsGuJfzU9KJqCXyQ+FYaxBPIjQ7aewGltIMVxfZljDpuIL08Odanwwd/hxvYNnsepPnd8mRWQ3ldbCxdrD0zrBfre2ZVwUVYJbC8g7HZbdRD/p1UwLh7owi9kYi0OT5X59OhH3Nbr0AqMdCj5uKStgYjSt1FRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898056; c=relaxed/simple;
	bh=/MvIsLTLsouaj7BuzGrMhvsKrpmdWGVpCDXaEI1Lqg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pG9zJbAVI2v5DGLc8COpfbH4iAZDTVKqCltHS9fa/iwzLLwzNVGEXpo67ML/q5tMxY1AEHkAdpjjVghcMRjCyIPRYQsBXeD5xbqeG4NbWQPoCLcqVHPY/QIPKZlGw059JyBgJGUqptfLHPzC1gM8krhkJC6lrXaJoymLyjpWbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY77jigD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so2434394f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754898053; x=1755502853; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ePuwivgJ8JPPoQeHPtBDqnWEaCRKjfjwhGiq9Y/F6l0=;
        b=fY77jigD1IUSdcBPchkBwmwdNfFPgQrJ5btVNTdJtQdPCLD66lMW4trrVIlZQDHKyq
         EAFZz3Qb7esqgs9XWAtIxVpeu+qCM9vuxTUJ9l8BSzzXCswrh77o96dljecG5rt6+Arr
         wEbaUvX/PqNHFghlV/Hsh3mL7M8mzAmf6mrIvijxMDLTEeBMBDek7E/sAqBk498Jp1+Q
         mkvvZDrdSAvfuwyYsPhNfasKarhvbDKHrIEk7e1H4otCbukjomkK1WuW5H/qqF8tYUFp
         OZUNlrh8beM58bCZrViENTJUpat5B2PJZ19y6DDfGIcF9pnvAPsLQzHT8MiZOl+CRQ1y
         Jfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754898053; x=1755502853;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePuwivgJ8JPPoQeHPtBDqnWEaCRKjfjwhGiq9Y/F6l0=;
        b=Y4+FwEgtEwLrjA+hrUguTwLR6uf+cLv7F9lB5bavcgaeiVGRO8Boa+DPZoh3/rWflp
         5cr6fL873z+9Wt43yDruzhCAE+FKlmOAoK1dGvhKdTRUjIE9sxLlo5T3dD03TwRWkHEb
         nIHf/IxzB30gEJAF7RSD1JmxUp2EaxEMEtq2FovhdL29P2sXCaA0prL8anlWo5xn+AWN
         Y5aG4EhKwC9g1EffX/LNnoTyQuwbIWCq9A3AuJ4nT1DYGRh0+a6ohkuOBlr+TvxSJgCa
         HCp7vw1xZc9zIounmNJ5gHq1LMXJhjoKkr6IVtoklwr2TOgGgOoIy6P2s3wjnzh7Wxgp
         5V5A==
X-Forwarded-Encrypted: i=1; AJvYcCWJeCkhgHHRTkoHprJmkoz7qi9tPenqbgLuROhoQwDIDAlSJCFI+mRh/pKF5vmb4JPYzItAVAm4ZCXESwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWSQTRgdt3UsEHEd9oCYbaB2jCNHzPUkQ65656JfR+JVQGZdP
	h40YVa6pgBzVXntgRhT+eON6fuO/HsKmiR2Z8zAL7IYXhjbZN0GoX9cL
X-Gm-Gg: ASbGncsKVngTERoTEZFCBgzLwcj2p6xxWSkOa2csJVW1C9NJZndxPre0MC3s63jwK0D
	HsAmvHf1ffYwZW66RGHtLaJeGK4sBE1a8IPcEcqwnTamh9j0y46+nnlEK4nQg3ynx/aDHcOevLg
	GxT82s8FJO8/myyZ4y2oawrU9UVZB47T9gkJFD6p8xUAK1y6CqVLUDIEEVHVqyXqWLvhyfV52+/
	qiDiiFb1Hs1T6eFSn6mSRvPrZuRVyWOc3PZDYNgn8Lpyp7EdyVg4+C8UGLZjnxq+9v1dFdDNAfm
	KzWxCPdjLUDNaDd8VqWLGNrMmIrdGX7U0dlQ9Wzh2EyyqGj5VmkdxmX4nVISzWAwosnSzMFFgR8
	ZYQruRTuT5/bz0T2F7PU45xXTGYEPQGcvUMdL8Iv+xmzH5Rlvgls=
X-Google-Smtp-Source: AGHT+IGHW6soSQokYYfZ1NuKLnkmHtvqgyJ6V1fhXaVhfGmx5+0IpuwlOprnqhm/EzfBt/uZyHcGtw==
X-Received: by 2002:adf:ef8d:0:b0:3b7:930a:bb0d with SMTP id ffacd0b85a97d-3b900b2d93fmr6903262f8f.20.1754898052701;
        Mon, 11 Aug 2025 00:40:52 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf970sm39380181f8f.25.2025.08.11.00.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:40:52 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 11 Aug 2025 09:40:40 +0200
Subject: [PATCH v2] mtd: nand: qpic-common: remove a bunch of unused
 defines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-qpic_common-unused-defines-v2-1-cfc5aea03a93@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHeemWgC/42NUQ7CIBBEr9Lst2sKSrV+eQ/TGIS13cRCBUs0D
 XcXewI/38zkzQKRAlOEU7VAoMSRvSsgNxWYQbuekG1hkLVUdSMbfE5srsaPo3c4uzmSRUt3dhR
 RNJJUq29klYUimEIp3qv80hUeOL58+KxfSfzSv7RJoEDaCdOSrA97czz3o+bHtqyhyzl/AZ4UP
 H3EAAAA
X-Change-ID: 20250626-qpic_common-unused-defines-162e59abed5d
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

A bunch of definitions in the 'nand-qpic-common.h' header became
unused after the conversion of the 'qcom_nandc' and 'spi-qpic-snand'
drivers to use the FIELD_PREP() macro, so remove those.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - rebase on v6.17-rc1
  - Link to v1: https://lore.kernel.org/r/20250626-qpic_common-unused-defines-v1-1-e31c9e2074c8@gmail.com
---
 include/linux/mtd/nand-qpic-common.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
index 4e694b1aabbd389b5d663399e8d1451862debb6d..e8201d1b7cf9d0f0a5a0e07bd600362b3f0f1f67 100644
--- a/include/linux/mtd/nand-qpic-common.h
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -71,14 +71,10 @@
 
 /* NAND_DEVn_CFG0 bits */
 #define	DISABLE_STATUS_AFTER_WRITE	BIT(4)
-#define	CW_PER_PAGE			6
 #define	CW_PER_PAGE_MASK		GENMASK(8, 6)
-#define	UD_SIZE_BYTES			9
 #define	UD_SIZE_BYTES_MASK		GENMASK(18, 9)
 #define	ECC_PARITY_SIZE_BYTES_RS	GENMASK(22, 19)
-#define	SPARE_SIZE_BYTES		23
 #define	SPARE_SIZE_BYTES_MASK		GENMASK(26, 23)
-#define	NUM_ADDR_CYCLES			27
 #define	NUM_ADDR_CYCLES_MASK		GENMASK(29, 27)
 #define	STATUS_BFR_READ			BIT(30)
 #define	SET_RD_MODE_AFTER_STATUS	BIT(31)
@@ -86,26 +82,20 @@
 /* NAND_DEVn_CFG0 bits */
 #define	DEV0_CFG1_ECC_DISABLE		BIT(0)
 #define	WIDE_FLASH			BIT(1)
-#define	NAND_RECOVERY_CYCLES		2
 #define	NAND_RECOVERY_CYCLES_MASK	GENMASK(4, 2)
 #define	CS_ACTIVE_BSY			BIT(5)
-#define	BAD_BLOCK_BYTE_NUM		6
 #define	BAD_BLOCK_BYTE_NUM_MASK		GENMASK(15, 6)
 #define	BAD_BLOCK_IN_SPARE_AREA		BIT(16)
-#define	WR_RD_BSY_GAP			17
 #define	WR_RD_BSY_GAP_MASK		GENMASK(22, 17)
 #define	ENABLE_BCH_ECC			BIT(27)
 
 /* NAND_DEV0_ECC_CFG bits */
 #define	ECC_CFG_ECC_DISABLE		BIT(0)
 #define	ECC_SW_RESET			BIT(1)
-#define	ECC_MODE			4
 #define	ECC_MODE_MASK			GENMASK(5, 4)
 #define	ECC_MODE_4BIT			0
 #define	ECC_MODE_8BIT			1
-#define	ECC_PARITY_SIZE_BYTES_BCH	8
 #define	ECC_PARITY_SIZE_BYTES_BCH_MASK	GENMASK(12, 8)
-#define	ECC_NUM_DATA_BYTES		16
 #define	ECC_NUM_DATA_BYTES_MASK		GENMASK(25, 16)
 #define	ECC_FORCE_CLK_OPEN		BIT(30)
 
@@ -120,7 +110,6 @@
 #define	SEQ_READ_START_VLD		BIT(4)
 
 /* NAND_EBI2_ECC_BUF_CFG bits */
-#define	NUM_STEPS			0
 #define	NUM_STEPS_MASK			GENMASK(9, 0)
 
 /* NAND_ERASED_CW_DETECT_CFG bits */
@@ -141,11 +130,8 @@
 #define	ERASED_CW			(CODEWORD_ALL_ERASED | CODEWORD_ERASED)
 
 /* NAND_READ_LOCATION_n bits */
-#define READ_LOCATION_OFFSET		0
 #define READ_LOCATION_OFFSET_MASK	GENMASK(9, 0)
-#define READ_LOCATION_SIZE		16
 #define READ_LOCATION_SIZE_MASK		GENMASK(25, 16)
-#define READ_LOCATION_LAST		31
 #define READ_LOCATION_LAST_MASK		BIT(31)
 
 /* Version Mask */

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250626-qpic_common-unused-defines-162e59abed5d

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


