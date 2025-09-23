Return-Path: <linux-kernel+bounces-828913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CCAB95D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C61E19C37E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09573233F3;
	Tue, 23 Sep 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFlHeD9s"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED86322743
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630100; cv=none; b=EosQ5MlJKAFq9lswUji/IrSngHze9H7jqcSK4LGD76T2M2NApZobhvre0r9VE3zQ1t2G1xJl/FC26ECHRWMhUesl4Q5IbPhvz+WAk9J52raUWSl+CJzUYNdeXyA4i1aOfjyckfpfOuNO5RpSDi9/u9PI0m4HxT+ru0JXALuiNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630100; c=relaxed/simple;
	bh=I8GuBaDzrJZRaJxRrd2X6l20qcN5D3CSi3HMt27iunE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SUnOFagwz3uXsMOUyL4zQDAQgdyYzxuu0IptFg6y55xQpCYqapD1FNhCIgiNl7cT9Kj+LYvCvz1K1lEfw4HHursAV6qpe+vvI1qB+kJblvb/89Lqv+MprGTMkEaa5zjfftRbcWBX4n8NPK6WGrrq8qLd0NazkPRZK3NK6v1zGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFlHeD9s; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f1f29a551so3055425b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758630098; x=1759234898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31NDFIT1J77T6WgOgaD6KtRWo1pajt4U43lgn0M+eTk=;
        b=LFlHeD9sYg2qxIu+A3BtJOYz9QskXndoAgNZ5UQK88u/wKDhlZMcg8HKLBH8R96RwH
         d2OM+oxBQb9HDZwv2aeFb6hhix1+IeZC8qzdsR6oI7JHrdLr4J0tTR8bS/H7I+yhHWCO
         JZQVWUK+gptQ7vWtteB0SyGTE3a4DIQ2y+/Y7npuB6ClOhRntqvMzMZpsx0OemENMRHV
         o24gBqV3umrGZCOD+Q9XdQyc+P3yvntDljpu96XbyBTRDAxKotul9nIi01ZiH6ETMkoF
         WaIylbECZkSwKmyYcHOaVjM+s8RJ/y1D4ipEF4ybW56U0QdObN8VQJSgvKCdziUjdyXB
         HcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758630098; x=1759234898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31NDFIT1J77T6WgOgaD6KtRWo1pajt4U43lgn0M+eTk=;
        b=mbH34xBBMJn/9V8a9wt36qj1NFTyE/7zRMHNlnhHd167yr6OHwq2oM+OWHCA7q8N78
         OhUcQwwteuyzQvy/3cFfhRofOTdMmyU2bqd+Qvv365NHCN/AKrm015HF2oqTeZcgBxvO
         D4mGRWC3/zcaaeKjj9Lnvh0/FYw0joBujySaMcb7OloC8a/ALcXLP0YEFcFrsMorP/w4
         QGALRERCrWq2gspxlhIfVPa3AavedR5F8weT+Wdkkp8yYzuu3XLlPWCEfBwwp2wYYMaR
         17EFiIFVLQ/Xyh9YfxXM1sPlk8kKTE8gmjDQe4K3kiJrCi8oYpwxIuo3/nBbUvufuUgu
         mMhg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/t0feQk/z3/UyZP3Lp3WP6vPAzaezc0tOA7AgrM9iUf8l8FA3K/Y6666KWEoVEyhlQZl0zbJ8O0NPZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/eqYZOPCqVDMqHWJbnisA+rIZ6JBm6ejeWPGXExTyIjYqGIO
	kw+xiJ1MM+Qe4quwmVfqRIoX7lrbZOc/Kxh+JGbiLpLnntcs+2JBPb7d
X-Gm-Gg: ASbGncvWTkPGL6jP/+NONbs/qdyT+I8fRNr557tLVlDCJnYzwjQd1mVnxiL5trHZWzK
	MaCW4VJ9JSs22C/wehVT6K0wGArDXci6aSMArYDrmyees14ms/jjgbnLb07EurqUE7E9DQ+6fLP
	wnXw3vP/DyAvRyPRcYqnPaAFBMh75yx+PJB/V3rSIUhcuBww8AoGqijFKlu/IY7p4lkcI4wYy3D
	GW2D4Hdbx1gc84+uMukm0w5rPE7gl/t7f6f5t6EZnVI1SZeoQqnAdtujwaboW6/KUayg7opb68u
	euIvqdNQz+EKjyDDR8pG/Ida60BJXoeWW+Ks+Cmrp/ALYdM9boM81X6Zker9++bmDLgJDEJWHhs
	hLUYPMF7AYVdsUaI=
X-Google-Smtp-Source: AGHT+IGapQYbJxxDclXfWf1hQJL8kcsiV3WYPv+6b0/vrntM1EgcdnY/IVTVQnQOpFXNKfmNw7kNBw==
X-Received: by 2002:a05:6a00:1706:b0:776:1de4:aee6 with SMTP id d2e1a72fcca58-77f53a2a233mr2209045b3a.16.1758630098030;
        Tue, 23 Sep 2025 05:21:38 -0700 (PDT)
Received: from lgs.. ([172.81.120.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4fd7223esm2786939b3a.103.2025.09.23.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:21:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3] ASoC: mediatek: mt8365: Add check for devm_kcalloc() in mt8365_afe_suspend()
Date: Tue, 23 Sep 2025 20:21:21 +0800
Message-ID: <20250923122121.1855051-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kcalloc() may fail. mt8365_afe_suspend() uses afe->reg_back_up
unconditionally after allocation and writes afe->reg_back_up[i], which
can lead to a NULL pointer dereference under low-memory conditions.

Add a NULL check and bail out with -ENOMEM, making sure to disable the
main clock before returning to keep clock state balanced.

Fixes: e1991d102bc2 ("ASoC: mediatek: mt8365: Add the AFE driver support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
changelog:
v3:
- Move the Signed-off-by line above the '---' separator.
- Restore the original spacing/indentation in the devm_kcalloc() continuation line.
- No functional changes.

v2:
- Return -ENOMEM directly on allocation failure without goto/label.
- Disable the main clock before returning to keep clock state balanced.
---
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
index 10793bbe9275..570fb10c306d 100644
--- a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
@@ -1975,11 +1975,15 @@ static int mt8365_afe_suspend(struct device *dev)
 
 	mt8365_afe_enable_main_clk(afe);
 
-	if (!afe->reg_back_up)
+	if (!afe->reg_back_up) {
 		afe->reg_back_up =
 			devm_kcalloc(dev, afe->reg_back_up_list_num,
 				     sizeof(unsigned int), GFP_KERNEL);
-
+		if (!afe->reg_back_up) {
+			mt8365_afe_disable_main_clk(afe);
+			return -ENOMEM;
+		}
+	}
 	for (i = 0; i < afe->reg_back_up_list_num; i++)
 		regmap_read(regmap, afe->reg_back_up_list[i],
 			    &afe->reg_back_up[i]);
-- 
2.43.0


