Return-Path: <linux-kernel+bounces-749416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875EFB14DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D526F18A2072
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3401D26AE4;
	Tue, 29 Jul 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X5wory8M"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B73224FA;
	Tue, 29 Jul 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794040; cv=none; b=lLRmSB7F4E0H2oUbTrOn3Uuq9p/skUnWzG9I5781VktCSymTlowTOfWeEKXi62oLyI0u/pSoFURuG7eqksMZsjKRMAsG3Gn97qNODMz72VZrvW/I1855kFJGKzElErp3uBT9CAytpvUuIkdI86DbkVMSEHdhLVSDnp8rIkvBtZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794040; c=relaxed/simple;
	bh=cphQ01oXi2gDkQyo0GXS1R2C6OmqmjfzGSY01/UYKQI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ffo+GfZCRZReFfjrWlmjin5oHxkjyDyX/v5tNs1d+jXP7etuYeL0Fq0qnQe8JYDuc96pOHRfNr0KxiXWLe7Tmiq5cOW07YAU8W/8cE4QCNYlHOdw8FMVq3/B9Fip8lFTDSmsLqwWjsdcr33t/EVocbBLyMjIYatRDXV/JUk6JUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X5wory8M; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56TD0LpF2967271;
	Tue, 29 Jul 2025 08:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753794021;
	bh=QqAobOTYQe6WECehT+kMwZtUBsShs9456vNKAow6d+s=;
	h=From:To:CC:Subject:Date;
	b=X5wory8MKkZNlFH5Qz6P0+XNppoYf2fOx4mw5r+FuHwwKXUdgtMptafmZELaooWwY
	 ZHfDLKjIto0L8UJI6JGjyZX2PRy2JFhdCUO1snsAmWkEJWEOjIMup8ShTJ/lFwXaFj
	 VMQtLsB8apo2Lgdkso71YNC6ABhwP8K1joi7ctpE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56TD0KxX2461250
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 29 Jul 2025 08:00:21 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 29
 Jul 2025 08:00:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 29 Jul 2025 08:00:20 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56TD0D7t3745895;
	Tue, 29 Jul 2025 08:00:14 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
        <13916275206@139.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <baojun.xu@ti.com>
Subject: [PATCH v1] ALSA: hda: Fix the wrong register was used for DVC of TAS2770
Date: Tue, 29 Jul 2025 20:59:38 +0800
Message-ID: <20250729125938.54696-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The wrong register was used for digital volume control of TAS2770,
The definition was changed, and usage was also updated.

Fixes: ab29b3460c5c ("ALSA: hda: Add TAS2770 support")

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 include/sound/tas2770-tlv.h                    | 4 ++--
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/tas2770-tlv.h b/include/sound/tas2770-tlv.h
index c0bd495b4a07..5518b34abdde 100644
--- a/include/sound/tas2770-tlv.h
+++ b/include/sound/tas2770-tlv.h
@@ -14,10 +14,10 @@
 #ifndef __TAS2770_TLV_H__
 #define __TAS2770_TLV_H__
 
-#define TAS2770_DVC_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x17)
+#define TAS2770_DVC_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x05)
 #define TAS2770_AMP_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x03)
 
-static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2770_dvc_tlv, 1650, 50, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2770_dvc_tlv, -1000, 50, 0);
 static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2770_amp_tlv, 1100, 50, 0);
 
 #endif
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index a0b132681804..45ac5e41bd4f 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -260,7 +260,7 @@ static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 		0, 0, 20, 0, tas2781_amp_getvol,
 		tas2781_amp_putvol, tas2770_amp_tlv),
 	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Digital Volume", TAS2770_DVC_LEVEL,
-		0, 0, 31, 0, tas2781_amp_getvol,
+		0, 0, 200, 1, tas2781_amp_getvol,
 		tas2781_amp_putvol, tas2770_dvc_tlv),
 };
 
-- 
2.43.0


