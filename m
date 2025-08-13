Return-Path: <linux-kernel+bounces-766460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 415A6B246C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845EE1886C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FFD2C15B5;
	Wed, 13 Aug 2025 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ELFBfiF2"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9092D46C8;
	Wed, 13 Aug 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079711; cv=none; b=s0dZHFZ/eQiHZpcc2sfOBqJxa9SNKLU9bpFJ2onk2a5PHTh1niJXFuF59ufmz7wX9KX77cAJESTAqlEu9OiFPdfj3ifGRc15WMJ9VhAy/72346WJRrkeBaQbtNzDWMWiwQFfthOD5aXRttJzdmf9NRyxaPn03hEyF2jMmvYIwnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079711; c=relaxed/simple;
	bh=UrCUu1lsCZ02PGLPtQTttqg5WHxulGBjpt8i7CfbHM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=udIOjL1b+MJxmdRpSJaIDzAF7jHbZsa25uOHW921XadbyDt/ezYvHznv9bMMqYBD5F9wRvMjyJzucP60iHhYQQQ719DQHO9JV8TToeMnFsxKvzKlSZpbXbPfQ3muooVI/DXMYWQAmbLTfJ4pQCqFoFrx2j4CSJ1qeULJpSS3Mrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ELFBfiF2; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DA8CNY1676905;
	Wed, 13 Aug 2025 05:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755079692;
	bh=kJoQ0U5iZkv2gZ3rcH8/lGiyZIxLnQJHkaYtl5MMBJs=;
	h=From:To:CC:Subject:Date;
	b=ELFBfiF2SldOoTEtUXDarEpfl1YnJnjhhTA4c1i7ldBfLZoRXggqco480ISAilzVv
	 P3xy658TYZloICfxeq0UNSWKZ0Dtay4awhESiodkzByQj8Dqh+kAAyV2BFSloEzwQu
	 moxw/DCqWRopPKieBjwVZ01q2O3zYximLlBSdnWg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DA8Cdm996491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 05:08:12 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 05:08:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 05:08:11 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DA87SF2144906;
	Wed, 13 Aug 2025 05:08:08 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] ASoC: tas2781: Normalize the volume kcontrol name
Date: Wed, 13 Aug 2025 18:07:08 +0800
Message-ID: <20250813100708.12197-1-baojun.xu@ti.com>
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

Change the name of the kcontrol from "Gain" to "Volume".

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/soc/codecs/tas2781-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index aa5f56615dad..e4ca43e006db 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -908,10 +908,10 @@ static const struct snd_kcontrol_new tasdevice_cali_controls[] = {
 };
 
 static const struct snd_kcontrol_new tas2781_snd_controls[] = {
-	SOC_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
+	SOC_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2781_AMP_LEVEL,
 		1, 0, 20, 0, tas2781_amp_getvol,
 		tas2781_amp_putvol, amp_vol_tlv),
-	SOC_SINGLE_RANGE_EXT_TLV("Speaker Digital Gain", TAS2781_DVC_LVL,
+	SOC_SINGLE_RANGE_EXT_TLV("Speaker Digital Volume", TAS2781_DVC_LVL,
 		0, 0, 200, 1, tas2781_digital_getvol,
 		tas2781_digital_putvol, dvc_tlv),
 };
-- 
2.43.0


