Return-Path: <linux-kernel+bounces-777176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0163CB2D640
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786EE4E1A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3C22D877F;
	Wed, 20 Aug 2025 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YhS77aw6"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C02D24BB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678120; cv=none; b=h98Mx2+xFlGepZ2kZ2do9DPjK1qQ984UgHgpt8XRnh/nQbW5fFShorMpR99ffVr/yn9yrqiGGaz4QtIYyC7uDrwMtYGn496zTrJtQR3tc0KCZbGCt+sa5PpSE31913vhMkJa+JoH9Sqrxhc/twevG/x1hmwOak2+qR1Uer7WWzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678120; c=relaxed/simple;
	bh=Pda3I2WFG024g6b4IPpFWGGG2uIsKDW6UG8gnWt9uxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E7jmR2HDa6rF4ghvq0sKbxkX8eWbhk5UpdxwKo9ITsRCdq96gti7ufR9X5pT3O1omRYtfPpKE/ZTJICgXRRDghP6Sk5mY6kILbFL3dokjtodqXJxZw2/MV2Ce6+RDsaXZBmty5BLiWBfIQrZXehwil+2CmMGcIZ0n8a0rg5GJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YhS77aw6; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K8LWkS3090726;
	Wed, 20 Aug 2025 03:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755678092;
	bh=z7OYf1f4KzQ6v0/hwgALS/TWgw68w/GKTaIrmC8wS1Y=;
	h=From:To:CC:Subject:Date;
	b=YhS77aw6NltAUEZ55Fjney8A7GQZneXcRLflqsRwxD4LEglBs5OYJqtteUA18YdFT
	 UzWo9WC9PZ/6EJPc1SDAr2KjG3WtRhgyNOOJS/XmkbWiLHRHMI+0sYyNc3ASK9K9cw
	 Snr/XmfmZmpiBnWdSutKNOTqVvWTbGtmopny66oQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K8LW9T1654525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 03:21:32 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 03:21:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 03:21:31 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.64.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K8LR8E213267;
	Wed, 20 Aug 2025 03:21:28 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>, <jesse-ji@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Enable init_profile_id for device initialization
Date: Wed, 20 Aug 2025 16:21:23 +0800
Message-ID: <20250820082123.1125-1-shenghao-ding@ti.com>
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

Optimize the time consumption of profile switching, init_profile saves
the common settings of different profiles, such as the dsp coefficients,
etc, which can greatly reduce the profile switching time comsumption and
remove the repetitive settings.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 318f8c58ae61..97c33fee9660 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -477,6 +477,12 @@ static void tasdevice_dspfw_init(void *context)
 	if (tas_priv->fmw->nr_configurations > 0)
 		tas_priv->cur_conf = 0;
 
+	/* Init common setting for different audio profiles */
+	if (tas_priv->rcabin.init_profile_id >= 0)
+		tasdevice_select_cfg_blk(tas_priv,
+			tas_priv->rcabin.init_profile_id,
+			TASDEVICE_BIN_BLK_PRE_POWER_UP);
+
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
@@ -779,6 +785,12 @@ static int tas2781_system_resume(struct device *dev)
 	tasdevice_reset(tas_hda->priv);
 	tasdevice_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
 
+	/* Init common setting for different audio profiles */
+	if (tas_hda->priv->rcabin.init_profile_id >= 0)
+		tasdevice_select_cfg_blk(tas_hda->priv,
+			tas_hda->priv->rcabin.init_profile_id,
+			TASDEVICE_BIN_BLK_PRE_POWER_UP);
+
 	if (tas_hda->priv->playback_started)
 		tasdevice_tuning_switch(tas_hda->priv, 0);
 
-- 
2.43.0


