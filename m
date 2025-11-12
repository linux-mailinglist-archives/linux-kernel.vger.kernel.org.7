Return-Path: <linux-kernel+bounces-898146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9891C5472D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CA6434786B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1398129BD94;
	Wed, 12 Nov 2025 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kiKfJG0j"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060E290F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979254; cv=none; b=fgb6CAKlPzrCOLqvTa90kqbQVHHnhV0hBeQIWlBSqQJuvTIL5za44BZBTTKuIyJCjYm7ssA44/YDwrTCX3r/M+1Vw8amtibBHq+55R2EBAo2y+4BiyYsYVu9ZyUgIb0518rg1CmyfA3NleZkCKXbl29d/EJPSdhlpIJCHyWTPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979254; c=relaxed/simple;
	bh=vDF0V59+opJU82rvCEcXGEPDytZF5PxmcytEyC8GKRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6+V+YEh5VF4Ts2+nu7qQUiU0PbZepZ7YA+A7pjNWCZkJ4ewpa3bjIxipmoK+hhgG76FJxmbne5AEQRKiYMsdBbplwWXN32vTDSklkFqKdT3D1GAdtKPFWo4ifUUcjTW2+8krHFZ/jsS+ff0BVgEj4aiaw5V4Ne7v9rln2ggGKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kiKfJG0j; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762979247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x8WpSp01W/cwktYERtzSFYCKAsNU/FDHtNSM0E6K0rM=;
	b=kiKfJG0j3Tmow6x1pxwLpDluk80F8vPNPCyDHID1AJuq6eSdrhBcclDEYuu2Ab/G/wToEk
	1mBOLm/GnYbZEJ2qOPCVypi4SNPbc5vnil/XCjQturlHB3KET5yTaoNK/Ltz1OexbJmbNv
	mK9qNxGl/Sv49o9Gr4UDecw6KMw+XRc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: Intel: atom: Replace strcpy() with strscpy()
Date: Wed, 12 Nov 2025 21:26:25 +0100
Message-ID: <20251112202630.6277-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use the safer strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Combine both patches and update the patch title
- Link to v1: https://lore.kernel.org/lkml/20251111224706.87508-2-thorsten.blum@linux.dev/
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 sound/soc/intel/atom/sst/sst_acpi.c      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 38116c758717..799d4f0881e3 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -142,7 +142,7 @@ static int sst_slot_enum_info(struct snd_kcontrol *kcontrol,
 
 	if (uinfo->value.enumerated.item > e->max - 1)
 		uinfo->value.enumerated.item = e->max - 1;
-	strcpy(uinfo->value.enumerated.name,
+	strscpy(uinfo->value.enumerated.name,
 		e->texts[uinfo->value.enumerated.item]);
 
 	return 0;
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 257180630475..73624e1b138a 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
@@ -356,7 +357,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 
 	/* Fill sst platform data */
 	ctx->pdata = pdata;
-	strcpy(ctx->firmware_name, mach->fw_filename);
+	strscpy(ctx->firmware_name, mach->fw_filename);
 
 	ret = sst_platform_get_resources(ctx);
 	if (ret)
-- 
2.51.1


