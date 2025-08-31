Return-Path: <linux-kernel+bounces-793439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3EB3D359
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A882F7A3622
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D697525D1F5;
	Sun, 31 Aug 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fsTmnzJN"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9D1684B4
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756644233; cv=none; b=RJ2QvuoEWfzaEFEzcRVqlNuUGZPB6+hXi9RmWlw37EhRGymYCi3Qm7u3+ylTRNdy59egw3UG757y5+ewjsQdCn7s7iB5Jdy9tadVbjJ4Jv93txE5Lb7oXSdXL/WHRFzOBaDt9wtS+jxGEXIJYgrW96HzXAPE+4hzcUSlSKr7oxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756644233; c=relaxed/simple;
	bh=iIAKHof11fAVYhzQAKE53fSrCBZGSQf+qWtF0xf2WjE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VTuSDtiD1jsuShNROwSUflv1RQmNLMYUqD3Qh8JZoEJkuH5F7UXkgw+VBzzBTM8o/J8Qv4kVwT1rKvlSe/UjXVHKcaAJ5vFHX18atWC7xK1OTzWsCZX0mnKODQW+Wt2C5aU/Dx0x+263g6OPJUdou20WO7a2+iKMZtV1jiahJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fsTmnzJN; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57VChMbH2569465;
	Sun, 31 Aug 2025 07:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756644202;
	bh=D8jZXZ3zxLtPtXA8pqoacFTvxgd1XyL1X0N76RV+LCA=;
	h=From:To:CC:Subject:Date;
	b=fsTmnzJNnenR/iZQaBIFL936KwNPO4e05Qkxb3q8XosSB8XxdNTxa9t3A3NqTSQUP
	 uV5GUIm1lgMIypocI9JgJjHo7EgsqDwqPMvSHrYJW7tcoAINWuk4+pNR0qaQqhFqU4
	 v98ruHKV/y7y41suQSNISfTDDcvX0vivBGemvSYE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57VChMKG1388187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 31 Aug 2025 07:43:22 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 31
 Aug 2025 07:43:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 31 Aug 2025 07:43:21 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.79])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57VChHpU665680;
	Sun, 31 Aug 2025 07:43:18 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Fix the order of TAS2563 calibrated-data
Date: Sun, 31 Aug 2025 20:43:13 +0800
Message-ID: <20250831124313.438-1-shenghao-ding@ti.com>
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

A bug reported by one of my customers that the order of TAS2563
calibrated-data is incorrect, the correct way is to move R0_Low_%d
and insert it between R0_%d and InvR0_%d.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index dbd71e173119..853ff5d87966 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -313,7 +313,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 {
 	efi_guid_t efi_guid = tasdev_fct_efi_guid[LENOVO];
 	char *vars[TASDEV_CALIB_N] = {
-		"R0_%d", "InvR0_%d", "R0_Low_%d", "Power_%d", "TLim_%d"
+		"R0_%d", "R0_Low_%d", "InvR0_%d", "Power_%d", "TLim_%d"
 	};
 	efi_char16_t efi_name[TAS2563_CAL_VAR_NAME_MAX];
 	unsigned long max_size = TAS2563_CAL_DATA_SIZE;
-- 
2.43.0


