Return-Path: <linux-kernel+bounces-875310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 255F6C18A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1197A4ED84A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0530E0FB;
	Wed, 29 Oct 2025 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDQCTVCm"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1012AD3D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722303; cv=none; b=ZXeNscQTIy6tBGtKCGfQqhTDfqaddniA7b0dcYdgVp/Y9Wu40XXkm1P5zmgChWJdi3qcl6FpWLuX+qAA+M5z1zKQuA4NxzpPQ3Q3HUbO8KPLocnFRQfJEtGOENLIpq2WzdoDpVvwy+OOlxh0BFXTYxFFleqPpc5jUA5ffYRFxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722303; c=relaxed/simple;
	bh=ecmgWyt/r3NhyI7KAZNK27WV0ALYJNBfyBVF8Ko8M+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z9+Uqgc8REsDpAuzFqhRrdvDcwWSi7O80XFlpqJbuftUKO9Od+Gfl5h7LUuve/z+pOLoz1lDFGHTRwHLE5KExuD4vSAXQXgpCeVqC1ha3vic7etcoT2H5jd2nQRX2eR+v5yuugA4UmbHPVVqyQnDGE0upUhmSR+e3E+NyPLjgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDQCTVCm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-780fc3b181aso4365179b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761722301; x=1762327101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yKR2JIltJZH3d6vVv5ttIX5RgDXhzdjyF6WPgCyyT+Q=;
        b=MDQCTVCmZeJ+qqaZ3RDqhw0rJGyAPPzPOsQXY+GTWdKptbSIQnSNaAcqvagcs91cA5
         S3kqfgIyz9hgulz0BoDJ2R6wYWkaXzQNam7P2v4EPqxmeNs0C/NDMP419yrNM3uiX3Oj
         v2A9KC+iPw7lbUwh9ZP40im5OTS9/GLjSz6WDsVJOSSIVFuvD2e4u6bR5Ukf0MeAuhgF
         n7Ta0Hoj4SVLN9KPPUKPb9asuHUmdfosWCzpQ1p0CmHaaGgPLQA3LNHUyiiNe/9o1KJH
         qdtodEORxdJGsge8V0zEdf2ug+1D+OjI6z1IPCu7m8WeJ8XquQ67a0AvP9VZHYJh3Bcz
         kLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722301; x=1762327101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKR2JIltJZH3d6vVv5ttIX5RgDXhzdjyF6WPgCyyT+Q=;
        b=SnWsYp5CrLjhIO5fCIoSJDnZweiPC0Jq1OOthWZBSB8rSiEUxqcvg0kRUE3u+8xefT
         RiIk+wW1KqIaM9KqnQJrYK7Rd5cpOJVdtFgr+g9K+DvcjHzGVlRCsPkt2VSaI4Wbmv1e
         9PtglkHLpSNKWEhmDwNEO8Ff+gGPTvJ/t8SLho5YhKDwcUk+TYJO6FPtRsDxdlYB3CyV
         DOkHEcTx7YBGNHlfroY/3HY3J8PDmJGYGdNV41RWYLCNtZLSKj41Ga0fV1vZZX0XGnbO
         hNwrZ1EbElfSCzn5e51SWYYOGSDAgyAsBGZLyPxUbhfUleWh8aCd3L4ehXg1fDxWqPUF
         DVUA==
X-Forwarded-Encrypted: i=1; AJvYcCX3w6g+fYUp9Z4xG0Pt3+Mexcjrce6CLVhnC1yQezbmfTIkA/YyI9VZD7AoxUhBXQt9lIi+y7Pi5HwLzXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOkhPl0PS3OQBiEeibNSRunrcLQ39k1J1R49vMDMm8wYiYKVZ6
	qaQ3c7IzzO2eyZeF/AMimbpz2NxztsCKxWyyQiXUSczqdXElIPPUl6ws
X-Gm-Gg: ASbGncvxMfH1JV3EZ4GcJdY8y1/1AbDwo+6AeQf2Dv7r7auGOYPWo1MYx1cKTbNlL5H
	6oxZghh2YZdeEM/dt20QONfWTf15JcZtSTq1Hw7ezaOiXeJm7O0e6gMFBwLNt6ZpuV0pVoUuhzH
	0X5kU3ZUbs5f9J4tje8up5hNnmqhwD0jpOxX+cYp/1Ffs4Y8f/H8959x/dhvh6N41+H0+rVRIeP
	pmCbfGm2BRpPvrnxTVOGoKd0J8dg1r5ESjUemJD/PKItEy16/1q9mJW0q42lSUo3zIpk1snl/EN
	VpOlaVwGHJ6Qs+lTRzaHnA+cRLPdoTRxpuySoDqIK5ayM9Ne997dh53PkObF0wOzCpKaPSIqiiZ
	7Mr4iP84fHZuCsgcuY1S3oXN9O217Y2Ps7EhPDISxqd2u+Rpz0esf0wrRGVIdrwbU43bfY0fUTf
	pLB/IJqYHrT/xZSMsTXM60Ow==
X-Google-Smtp-Source: AGHT+IGsSohj8ZyfRUklbkOshcfGyTov32rF3rhJPbt86LKk5fmrvTuOuT8071qzdtGvIsEZK/0xXw==
X-Received: by 2002:a05:6a20:3ca6:b0:342:44f3:d1bc with SMTP id adf61e73a8af0-34653146b2amr2346432637.35.1761722301330;
        Wed, 29 Oct 2025 00:18:21 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41407a0fasm13910908b3a.54.2025.10.29.00.18.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 00:18:20 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shuming Fan <shumingf@realtek.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: sdw_utils: fix device reference leak in is_sdca_endpoint_present()
Date: Wed, 29 Oct 2025 15:17:58 +0800
Message-Id: <20251029071804.8425-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bus_find_device_by_name() function returns a device pointer with an
incremented reference count, but the original code was missing put_device()
calls in some return paths, leading to reference count leaks.

Fix this by ensuring put_device() is called before function exit after
  bus_find_device_by_name() succeeds

This follows the same pattern used elsewhere in the kernel where
bus_find_device_by_name() is properly paired with put_device().

Found via static analysis and code review.

Fixes: 4f8ef33dd44a ("ASoC: soc_sdw_utils: skip the endpoint that doesn't present")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index 270c66b90228..ea594f84f11a 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -1278,7 +1278,7 @@ static int is_sdca_endpoint_present(struct device *dev,
 	struct sdw_slave *slave;
 	struct device *sdw_dev;
 	const char *sdw_codec_name;
-	int i;
+	int ret, i;
 
 	dlc = kzalloc(sizeof(*dlc), GFP_KERNEL);
 	if (!dlc)
@@ -1308,13 +1308,16 @@ static int is_sdca_endpoint_present(struct device *dev,
 	}
 
 	slave = dev_to_sdw_dev(sdw_dev);
-	if (!slave)
-		return -EINVAL;
+	if (!slave) {
+		ret = -EINVAL;
+		goto put_device;
+	}
 
 	/* Make sure BIOS provides SDCA properties */
 	if (!slave->sdca_data.interface_revision) {
 		dev_warn(&slave->dev, "SDCA properties not found in the BIOS\n");
-		return 1;
+		ret = 1;
+		goto put_device;
 	}
 
 	for (i = 0; i < slave->sdca_data.num_functions; i++) {
@@ -1323,7 +1326,8 @@ static int is_sdca_endpoint_present(struct device *dev,
 		if (dai_type == dai_info->dai_type) {
 			dev_dbg(&slave->dev, "DAI type %d sdca function %s found\n",
 				dai_type, slave->sdca_data.function[i].name);
-			return 1;
+			ret = 1;
+			goto put_device;
 		}
 	}
 
@@ -1331,7 +1335,11 @@ static int is_sdca_endpoint_present(struct device *dev,
 		"SDCA device function for DAI type %d not supported, skip endpoint\n",
 		dai_info->dai_type);
 
-	return 0;
+	ret = 0;
+
+put_device:
+	put_device(sdw_dev);
+	return ret;
 }
 
 int asoc_sdw_parse_sdw_endpoints(struct snd_soc_card *card,
-- 
2.39.5 (Apple Git-154)


