Return-Path: <linux-kernel+bounces-766461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 839E0B246DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F981885392
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3444F212555;
	Wed, 13 Aug 2025 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oUHvL28J"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9571A9F97;
	Wed, 13 Aug 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079801; cv=none; b=IeyfNH8/hPR0/WQGDpf8DRwYm7Vy78BP1B62pv/tLu7xtr9YkFUZ9hLMFnVuq0k3RbV77FmtjW5CIpfMVRFUGQXvomcxtiY8VVhpRuwFxsnHdVsW0hTpweKrKKdPLjlT7cp5MyrT4AfpQnKuXTikktCzNEWD7axXrXZynr7rjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079801; c=relaxed/simple;
	bh=ida2CXCr2fFRDvW1t1sPtcOWlT9NS9aCbl0kJ8wWOBg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZxOvq8W//DO7Ay0ogNw5YvG0HkJw2vEkBIud2sZ++n6WBK9RFBxS0acIpCIBjNxNxKEAKR6KWOU7IJ09TF9OVseAfko9xG17c7jLCpZnt9B0VB9EYcA4lLz5HcRLwClZ61xVy9hT+paEEbv7rbVga7BbtyolgnJrOBfIz9dd4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oUHvL28J; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DA9Cxw1676987;
	Wed, 13 Aug 2025 05:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755079752;
	bh=qwJfbD6uTwKoAGtFS7NyqUcPD5IlHQBF9hptV0GBnZE=;
	h=From:To:CC:Subject:Date;
	b=oUHvL28J65CnxAE0NfzPqsqcT3YK9Q2gzo8RaIOH608g84ORnD1SGoa1CQDVb6bW7
	 ABTo6b8vFbfsxZ4f10eVK7JIzDZvbe/AAVhuzbrg7iOlybxPGTm0JUI+wckuWxfcX7
	 alQ1ErEXmsiX2MGKtkZ0xvgF9Sd2y0M5HeP7T3BE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DA9C6q317487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 05:09:12 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 05:09:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 05:09:11 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DA97ZN1839683;
	Wed, 13 Aug 2025 05:09:08 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
        <13916275206@139.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <baojun.xu@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Normalize the volume kcontrol name
Date: Wed, 13 Aug 2025 18:08:42 +0800
Message-ID: <20250813100842.12224-1-baojun.xu@ti.com>
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
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 92aae19cfc8f..e4bc3bc756b0 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -256,7 +256,7 @@ static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 };
 
 static const struct snd_kcontrol_new tas2781_snd_controls[] = {
-	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
+	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2781_AMP_LEVEL,
 		1, 0, 20, 0, tas2781_amp_getvol,
 		tas2781_amp_putvol, amp_vol_tlv),
 	ACARD_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
-- 
2.43.0


