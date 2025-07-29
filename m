Return-Path: <linux-kernel+bounces-749551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF6B14FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710D37AB7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA6287249;
	Tue, 29 Jul 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k+YvA+co"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D12882B8;
	Tue, 29 Jul 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801191; cv=none; b=SlHvrMlNMXGy9ETGDUA66vJz3V/zRFS1ZdKNsvm6HrwtLUUbI9vTx/GzQRQY4wFZty+PMxKnuFSOWvTjoTRjuqjvsfA62ms80jKoE9ePff7M6J5Shd7wFNxao6t8fYQeQb6X9vXdJ3iM5Z1indF6KiJGPjcGlu9T6yVAZOW7GVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801191; c=relaxed/simple;
	bh=NvAofT5zbEiIg42/fo5kKEV+hVJkFwbLzEa1TzVctGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGq9jvC5puClxm6aLiss/ehIK0d6kZKS3WyQKpYbloJ9JkQ28NIKaLVleF42I4+qqqpGG7D+iD2zkYtQzu1ysPftkZceRCTHMSCCypaBWM69JDmSuZUXU5QFT9/EEspmx1BZy0Bif71HZaRSGpM/wCGCIbel6l+zPLCGRZXjGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k+YvA+co; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56TExRgG2988219;
	Tue, 29 Jul 2025 09:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753801167;
	bh=Nr6k0opRMmNIsTVpjRSCji0D/6qwAjqm6iJkhWySxFE=;
	h=From:To:CC:Subject:Date;
	b=k+YvA+coNPbxmIz5T/gZvIAcZINBtL5VtwDufNsomMTg5b8HgEgGcDXESs+KR1AuK
	 LKkwmRCn/fhny0MErNgTXE7jZ9T0z39RoH6Hl+FvQwm4F+whCSTY7VfCk1Cr7xT1Z3
	 kCSOg8OprOdce8GEbpy3vJEfBRulTm9u+HUJhot0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56TExQKF2526231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 29 Jul 2025 09:59:26 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 29
 Jul 2025 09:59:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 29 Jul 2025 09:59:25 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56TExDiX3600953;
	Tue, 29 Jul 2025 09:59:15 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
        <13916275206@139.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <baojun.xu@ti.com>
Subject: [PATCH v2] ALSA: hda: Fix the wrong register was used for DVC of TAS2770
Date: Tue, 29 Jul 2025 22:58:49 +0800
Message-ID: <20250729145849.55057-1-baojun.xu@ti.com>
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
v2
 - Correct number from -1000 to -10000 for DVC.
---
 include/sound/tas2770-tlv.h                    | 4 ++--
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/tas2770-tlv.h b/include/sound/tas2770-tlv.h
index c0bd495b4a07..c7380925417a 100644
--- a/include/sound/tas2770-tlv.h
+++ b/include/sound/tas2770-tlv.h
@@ -14,10 +14,10 @@
 #ifndef __TAS2770_TLV_H__
 #define __TAS2770_TLV_H__
 
-#define TAS2770_DVC_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x17)
+#define TAS2770_DVC_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x05)
 #define TAS2770_AMP_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x03)
 
-static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2770_dvc_tlv, 1650, 50, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2770_dvc_tlv, -10000, 50, 0);
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


