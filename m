Return-Path: <linux-kernel+bounces-750195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DCFB15875
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5993A18A19BE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA01E5B90;
	Wed, 30 Jul 2025 05:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ohQY84eD"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A57462;
	Wed, 30 Jul 2025 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753853606; cv=none; b=UwiZjpb8KTFxFN484YoJjfG+CJByf1F2Ts9eqxityOTA0qRwfuNaMeflVsv2NQyOtMWUa5irU/en3XmkqSyhTvzLXEgMeOMwcTCajc1I3ZRGPimX54vRlciIX/aD3LKwsDXGoeIPfYRhUK6zgCUtbioAh05AOASys+DaYQVHbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753853606; c=relaxed/simple;
	bh=FhJYgVdy7uv+pIWPhCaLWgy9qxucMXMybPT+uOiNyDQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SYqbPrr1pYfprdNKQ/8cSCfmtlc9LW2gQbGPOqZuJqH7rF+mzYMd3zv50btBHQpWB6i6ugW/Uh9kE7PILO71n2fa2TI7xD7in/QbTp/8L/fBhaAhYvciiX49NIuu/c6fk2c0KNMaPBBLq1VrV/++TLCZ2vMy76eAqh+VeUgkNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ohQY84eD; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56U5X3892691312;
	Wed, 30 Jul 2025 00:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753853583;
	bh=jqs9ri/KCcvlHLen5ccn4YkIZlSKH8zl84oJtQdNKqk=;
	h=From:To:CC:Subject:Date;
	b=ohQY84eD1DstEFx8OEonZc8AXlpvx94K8hhenMrrcGVDdHznp+Ve0hEH4M0KOhVyG
	 +I8mIkeB5qulWmu44ZmaYzVhyfXeOgvx6JzSl3c5vL49RtSHjcL27aKYMc16Y1QjEN
	 90m4SQtOqx6YL5rDdtmp/X/ZHldjodNFhTZYi/kg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56U5X2GI3265370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 30 Jul 2025 00:33:02 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 00:33:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 00:33:02 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56U5WwHI418872;
	Wed, 30 Jul 2025 00:32:59 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
        <13916275206@139.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <baojun.xu@ti.com>
Subject: [PATCH v1] ASoC: tas2781: Normalize the volume kcontrol name
Date: Wed, 30 Jul 2025 13:32:36 +0800
Message-ID: <20250730053236.57643-1-baojun.xu@ti.com>
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

As more devices become supported, add "tas2781" as a suffix before the
TLV name, correct the DVC step, and normalize the volume kcontrol name.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 include/sound/tas2781-tlv.h                    | 6 ++++--
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 4 ++--
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c | 5 +++--
 sound/soc/codecs/tas2781-i2c.c                 | 8 ++++----
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/sound/tas2781-tlv.h b/include/sound/tas2781-tlv.h
index d87263e43fdb..38b8f828a353 100644
--- a/include/sound/tas2781-tlv.h
+++ b/include/sound/tas2781-tlv.h
@@ -15,7 +15,9 @@
 #ifndef __TAS2781_TLV_H__
 #define __TAS2781_TLV_H__
 
-static const __maybe_unused DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
-static const __maybe_unused DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2781_dvc_tlv,
+	-10000, 50, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2781_amp_tlv,
+	1100, 50, 0);
 
 #endif
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index a0b132681804..6ec93b27aa7f 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -265,9 +265,9 @@ static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 };
 
 static const struct snd_kcontrol_new tas2781_snd_controls[] = {
-	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
+	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2781_AMP_LEVEL,
 		1, 0, 20, 0, tas2781_amp_getvol,
-		tas2781_amp_putvol, amp_vol_tlv),
+		tas2781_amp_putvol, tas2781_amp_tlv),
 	ACARD_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
 		tas2781_force_fwload_get, tas2781_force_fwload_put),
 };
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
index 09a5d0f131b2..b4664a696bad 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -494,9 +494,10 @@ static int tas2781_force_fwload_put(struct snd_kcontrol *kcontrol,
 
 static struct snd_kcontrol_new tas2781_snd_ctls[] = {
 	ACARD_SINGLE_RANGE_EXT_TLV(NULL, TAS2781_AMP_LEVEL, 1, 0, 20, 0,
-		tas2781_amp_getvol, tas2781_amp_putvol, amp_vol_tlv),
+		tas2781_amp_getvol, tas2781_amp_putvol, tas2781_amp_tlv),
 	ACARD_SINGLE_RANGE_EXT_TLV(NULL, TAS2781_DVC_LVL, 0, 0, 200, 1,
-		tas2781_digital_getvol, tas2781_digital_putvol, dvc_tlv),
+		tas2781_digital_getvol, tas2781_digital_putvol,
+		tas2781_dvc_tlv),
 	ACARD_SINGLE_BOOL_EXT(NULL, 0, tas2781_force_fwload_get,
 		tas2781_force_fwload_put),
 };
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 9f4d965a1335..a51f20cd869a 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -908,12 +908,12 @@ static const struct snd_kcontrol_new tasdevice_cali_controls[] = {
 };
 
 static const struct snd_kcontrol_new tas2781_snd_controls[] = {
-	SOC_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
+	SOC_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2781_AMP_LEVEL,
 		1, 0, 20, 0, tas2781_amp_getvol,
-		tas2781_amp_putvol, amp_vol_tlv),
-	SOC_SINGLE_RANGE_EXT_TLV("Speaker Digital Gain", TAS2781_DVC_LVL,
+		tas2781_amp_putvol, tas2781_amp_tlv),
+	SOC_SINGLE_RANGE_EXT_TLV("Speaker Digital Volume", TAS2781_DVC_LVL,
 		0, 0, 200, 1, tas2781_digital_getvol,
-		tas2781_digital_putvol, dvc_tlv),
+		tas2781_digital_putvol, tas2781_dvc_tlv),
 };
 
 static const struct snd_kcontrol_new tas2781_cali_controls[] = {
-- 
2.43.0


