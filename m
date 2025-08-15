Return-Path: <linux-kernel+bounces-770912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825B4B28054
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC60B002AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8E302751;
	Fri, 15 Aug 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c41K4WL6"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7412E3019AD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262980; cv=none; b=FmL8C56TkftaFxXP4pSdhgcWzl59g2WReJDsBa+GF/3d8KBlHlU3CNDh1Ib7NiMYaQLzLRzfU5v51UcBL1n9eJFOnXid6D5xFY6OmyTt8DKF/g4xVwF2xPP4KInS2J0QKxWssdRZtfpBUhnNNOemMkblB8aNTjndoU1WiSNaKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262980; c=relaxed/simple;
	bh=jDb9FgrMbMfU3cHd8caNO0vv5lDQaBufAYQiEm5Z2FM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GsbKAMs33wdNQb4UcmnOP7RO/CAkRBozb9aP7BGf7B7nTRDDxh3Kgj4K0AJuXTIOHJM121B3XEPfg6Ya81qSMaaqTYMQW6WXSLZFuvOujiLIxYABJ+eeuhDnAhBkqopSHlg28kb/5AJNLR/HcUQQmq7gAk3xHKpw2CVb5bl20Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c41K4WL6; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57FD2G4W2609143;
	Fri, 15 Aug 2025 08:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755262936;
	bh=HgBlHfXGHDiceiNCO89QbL/mneqiPpwACe0hpnsw8Uk=;
	h=From:To:CC:Subject:Date;
	b=c41K4WL6TYEkI7+/iZTI7zIIqTLrF246OeCSxnme2Eu/9Nipn5SX86BnGOfj9CZfg
	 /MmuAZ+SDZCU5AhJRIvBuJGhB++rc6t6op4zRRi9oCjP2Z/QYTeIygia9IXynPP0JQ
	 JKN/KJezTb+vaXThm9xEUTIOON7KWWFJF5kaDLVo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57FD2GbV2601559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 15 Aug 2025 08:02:16 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 15
 Aug 2025 08:02:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 15 Aug 2025 08:02:15 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.79])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57FD2BtH1325636;
	Fri, 15 Aug 2025 08:02:11 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>, <jesse-ji@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Add name prefix tas2781 for tas2781's dvc_tlv and amp_vol_tlv
Date: Fri, 15 Aug 2025 21:02:07 +0800
Message-ID: <20250815130207.1558-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

With some new devices adding into the driver, dvc_tlv and amp_vol_tlv will
cause confusion for customers on which devices they support.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 include/sound/tas2781-tlv.h                    | 6 +++---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c | 6 ++++--
 sound/soc/codecs/tas2781-i2c.c                 | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/sound/tas2781-tlv.h b/include/sound/tas2781-tlv.h
index ef9b9f19d212..273224df9282 100644
--- a/include/sound/tas2781-tlv.h
+++ b/include/sound/tas2781-tlv.h
@@ -2,7 +2,7 @@
 //
 // ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
 //
-// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
+// Copyright (C) 2022 - 2025 Texas Instruments Incorporated
 // https://www.ti.com
 //
 // The TAS2781 driver implements a flexible and configurable
@@ -15,7 +15,7 @@
 #ifndef __TAS2781_TLV_H__
 #define __TAS2781_TLV_H__
 
-static const __maybe_unused DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 50, 0);
-static const __maybe_unused DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2781_dvc_tlv, -10000, 50, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2781_amp_tlv, 1100, 50, 0);
 
 #endif
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 3471b9ab52cb..318f8c58ae61 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -269,7 +269,7 @@ static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 static const struct snd_kcontrol_new tas2781_snd_controls[] = {
 	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2781_AMP_LEVEL,
 		1, 0, 20, 0, tas2781_amp_getvol,
-		tas2781_amp_putvol, amp_vol_tlv),
+		tas2781_amp_putvol, tas2781_amp_tlv),
 	ACARD_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
 		tas2781_force_fwload_get, tas2781_force_fwload_put),
 };
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
index 09a5d0f131b2..b9a55672bf15 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -494,9 +494,11 @@ static int tas2781_force_fwload_put(struct snd_kcontrol *kcontrol,
 
 static struct snd_kcontrol_new tas2781_snd_ctls[] = {
 	ACARD_SINGLE_RANGE_EXT_TLV(NULL, TAS2781_AMP_LEVEL, 1, 0, 20, 0,
-		tas2781_amp_getvol, tas2781_amp_putvol, amp_vol_tlv),
+		tas2781_amp_getvol, tas2781_amp_putvol,
+		tas2781_amp_tlv),
 	ACARD_SINGLE_RANGE_EXT_TLV(NULL, TAS2781_DVC_LVL, 0, 0, 200, 1,
-		tas2781_digital_getvol, tas2781_digital_putvol, dvc_tlv),
+		tas2781_digital_getvol, tas2781_digital_putvol,
+		tas2781_dvc_tlv),
 	ACARD_SINGLE_BOOL_EXT(NULL, 0, tas2781_force_fwload_get,
 		tas2781_force_fwload_put),
 };
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index e4ca43e006db..ea3cdb8553de 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -910,10 +910,10 @@ static const struct snd_kcontrol_new tasdevice_cali_controls[] = {
 static const struct snd_kcontrol_new tas2781_snd_controls[] = {
 	SOC_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2781_AMP_LEVEL,
 		1, 0, 20, 0, tas2781_amp_getvol,
-		tas2781_amp_putvol, amp_vol_tlv),
+		tas2781_amp_putvol, tas2781_amp_tlv),
 	SOC_SINGLE_RANGE_EXT_TLV("Speaker Digital Volume", TAS2781_DVC_LVL,
 		0, 0, 200, 1, tas2781_digital_getvol,
-		tas2781_digital_putvol, dvc_tlv),
+		tas2781_digital_putvol, tas2781_dvc_tlv),
 };
 
 static const struct snd_kcontrol_new tas2781_cali_controls[] = {
-- 
2.43.0


