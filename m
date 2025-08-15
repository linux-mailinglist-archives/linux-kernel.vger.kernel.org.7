Return-Path: <linux-kernel+bounces-770060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E94AB27653
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987635C5D50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C22299A87;
	Fri, 15 Aug 2025 02:50:08 +0000 (UTC)
Received: from smtp134-80.sina.com.cn (smtp134-80.sina.com.cn [180.149.134.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778631EEA55
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755226208; cv=none; b=dB0kvl6rnlEDI39wnRHqKE/u0rMXbctuoh95KAcpRpLxJMUZs6004djldj+cd+xi5G/kl2aaTWaT7mvpxrXd6efUpV7AK7S81h6scpqmIHVHVQcQIwzkLSHNjnXUKbgpoPVRVyyfSWBwma47JZpkl4FXhbxzoEHu1rh1Ptm/ZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755226208; c=relaxed/simple;
	bh=LwoIxOCfy/iaw7m1jetuLA51dM1+acdUyb+kd+8b0Ak=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iq/wV1bFKHOOUmgVJOQoCPg5EWBB/UOPaowgBnwgZXaOZ3uLzTaY7xnwwwwK+RjY9wGMBhL8qnWrUGr1T3MT7xECQ+ubggPAXLtadN5mXp3Yb9BxOtOpITVqCV6ZiqjtHiZXJ2Ig2cQBASXUnvmBJFmOFATm+Xsx9iuQHGlNAYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com; spf=pass smtp.mailfrom=everest-semi.com; arc=none smtp.client-ip=180.149.134.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everest-semi.com
Received: from unknown (HELO zy-virtual-machine.localdomain)([180.154.41.66])
	by sina.net (10.185.250.29) with ESMTP
	id 689E9FC200002612; Fri, 15 Aug 2025 10:47:31 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 684AF250B7FF4E45A279C04335CA1F52
X-SMAIL-UIID: 684AF250B7FF4E45A279C04335CA1F52-20250815-104731
From: Zhang Yi <zhangyi@everest-semi.com>
To: broonie@kernel.org,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH] ASoC: codecs: ES9389: Modify the standby configuration
Date: Fri, 15 Aug 2025 10:47:29 +0800
Message-Id: <20250815024729.3051-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Modify the standby configuration

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8389.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8389.c b/sound/soc/codecs/es8389.c
index ba1763f36f17..6e4c75d288ef 100755
--- a/sound/soc/codecs/es8389.c
+++ b/sound/soc/codecs/es8389.c
@@ -636,7 +636,7 @@ static int es8389_set_bias_level(struct snd_soc_component *component,
 		regmap_write(es8389->regmap, ES8389_ANA_CTL1, 0x59);
 		regmap_write(es8389->regmap, ES8389_ADC_EN, 0x00);
 		regmap_write(es8389->regmap, ES8389_CLK_OFF1, 0x00);
-		regmap_write(es8389->regmap, ES8389_RESET, 0x7E);
+		regmap_write(es8389->regmap, ES8389_RESET, 0x3E);
 		regmap_update_bits(es8389->regmap, ES8389_DAC_INV, 0x80, 0x80);
 		usleep_range(8000, 8500);
 		regmap_update_bits(es8389->regmap, ES8389_DAC_INV, 0x80, 0x00);
-- 
2.17.1


