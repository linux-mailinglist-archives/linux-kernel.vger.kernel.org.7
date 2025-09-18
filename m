Return-Path: <linux-kernel+bounces-822961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805B9B85312
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C201B561F75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B36310635;
	Thu, 18 Sep 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPCuqER9"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E35311C3E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204529; cv=none; b=dcG5zxjlROP1FYNeYQcSIMAYgpB4lCCDkq0SfCVMuwtk+4FREHm+WXsAPl2DdA3pI/Xw6m3T2wYcUnVaYWRbkQMoailRL6hCjEdnLSwwRF+stb6n2OCvYNrlnFrErdOOv+sgoqd4/SKosa/uvajNXCaNKqcbUUNmjuKrq1XdjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204529; c=relaxed/simple;
	bh=zxgm65Ph9VIZRAyGnN6KsdPjRkrjVybw7A9LFz16nCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAHrUrAxsMXTa1xBsrhZjACM/e747ML8BM1hTFsKKfscbsvyyhJV9HYI4peySliHQqbx42Vem8tJecGZfvm22yv0FXWNOctEBKC8INSJVxnLPgHT+GkVr0nnafoHrJ7aUfWwBwOPkkJRBD11cej/eH/kR/khyviTjS+mbhWo3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPCuqER9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-261682fdfceso23112385ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758204527; x=1758809327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3jtPOVR/Qh9IZ/OmR2ja7xClQUBdSd//rUxpdfZTIk=;
        b=BPCuqER91GuOG3Y79ZUsap3PZgfO8FC2RLO22uDXseED285PZAF7DBYLaByiB3W6ZC
         rlNB3UaYlwWYA/KtnGGftBJR+yODJo6LJpf5Hntsn1YOIzFkX4VSoSWVDrcpTluYVK98
         Bp6FgxAQmdse/GhAjs2wey7EobRi2ciYTjCoGJ1IBOZG4/2j+6fobYIuUtbsKshFYFGs
         6pOq+JfSDRSlfg8aqnnYVAwkthYluREPaFYpy2Pc2BRdgvd4vgG1Ussz1g8dGLGgG+hv
         Du9ZSu/WkoLWAjGHmKyGfFNal7y+v0piSN1S4gS3l7eftpjopFvuvqIYgP/4Yo45VVP3
         x+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204527; x=1758809327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3jtPOVR/Qh9IZ/OmR2ja7xClQUBdSd//rUxpdfZTIk=;
        b=fv6wdSpjHy+1CkL7QjrgXgHQQv6EtwMVpWhiK8GKlL/abiB2Nqsa+GzqfxEpUKRUc5
         Pbds4c+ZxL1FhwIwHQU0yDzDurHIoMZcvYZ44zBDZZiqZ1E/qPFuFlBLesaY8lz+MjG+
         EEBIkPQrr19HA4a1xUGM6GjBgyOTMxh+3da9PWDHx95osQD/0WXVSW4uJVzsLnloDJLV
         dnZ+kCD5O1040Imj/m5pczVQF8xxU0f++1UXUa6gaWB3wSUdWoxXR0uKKSM6PXjQv+hy
         DppOTINFv9kngDkXkBQOowJcVfrMKGTGjVd6fssdN+3cH+BOSr3lvk8pbobC/MTda3Xj
         sWSA==
X-Forwarded-Encrypted: i=1; AJvYcCUHjHyjb0IUSk2p3I3cYViNUHOk6zXmw/0PmbR5aoQ9IlZ9jngF2iSEcO25rZiQHBu6yiQzJDmx2vqfLEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwySdCp7/peOul3p5/Yk131joYos8NJ2IWI5tMd1kw55GUuhbn9
	8fY6pkuti3mqGvb87RuVEj9dkEjL17fLNwck/wrRbfKswftxcn/+oJBW
X-Gm-Gg: ASbGncvd8lA6O7ENdtVD16xs7EKmiCWiYjKldurbR/dgJetSwtRnRrUyVNlTdc/zyaF
	iDpE1kt5erJ0aIjFfq4fSn7AYjnsNYbpoL58nl4+0ErHE/eno5CE1W/4Prx2kXB1hHVOxU434Km
	c7fsUVcGhw+ljTY+pkh4LgoqY7epxmeY5A+Ag+tvZBKi6bTNXDvNwfwy3JOGsxIpGUZrLfEbdtz
	/QJhDYShm4oAZaB+qyfCHVTctN9S7zXSEXmzT5nJ8Vir3r/XKVMjb/opEv+a67ikpDxwlb+pKWf
	fNtiIsPi2MdCcVg+FKX6RTlMa47wtDRzIFmr4Ac7wuc4E616R8fVUmJJ6VRblYVLd0uGcxPHWeR
	aTEtSExp0h+9TgDGaH2NdIYIX/+ftdrxGsTynsIKhHg==
X-Google-Smtp-Source: AGHT+IHL4igJxg5AwA7L1D1p01uU/62u44PEnlUK/eOY3G/4bPrg+RD9PUmGGbiLH93nITnKJ0zvSg==
X-Received: by 2002:a17:903:1212:b0:267:d7f8:405b with SMTP id d9443c01a7336-2697c6afddamr56831825ad.0.1758204525753;
        Thu, 18 Sep 2025 07:08:45 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:70da:6ea2:4e14:821e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm27037455ad.90.2025.09.18.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:08:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8365: Add check for devm_kcalloc() in mt8365_afe_suspend()
Date: Thu, 18 Sep 2025 22:07:58 +0800
Message-ID: <20250918140758.3583830-1-lgs201920130244@gmail.com>
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
main clock via the existing error path to keep clock state balanced.

Fixes: e1991d102bc2 ("ASoC: mediatek: mt8365: Add the AFE driver support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
index 10793bbe9275..9f398d1249ce 100644
--- a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
@@ -1971,22 +1971,26 @@ static int mt8365_afe_suspend(struct device *dev)
 {
 	struct mtk_base_afe *afe = dev_get_drvdata(dev);
 	struct regmap *regmap = afe->regmap;
-	int i;
+	int i, ret = 0;
 
 	mt8365_afe_enable_main_clk(afe);
 
-	if (!afe->reg_back_up)
-		afe->reg_back_up =
-			devm_kcalloc(dev, afe->reg_back_up_list_num,
-				     sizeof(unsigned int), GFP_KERNEL);
+	if (!afe->reg_back_up) {
+		afe->reg_back_up = devm_kcalloc(dev, afe->reg_back_up_list_num,
+						sizeof(unsigned int), GFP_KERNEL);
+		if (!afe->reg_back_up) {
+			ret = -ENOMEM;
+			goto out_disable_clk;
+		}
+	}
 
 	for (i = 0; i < afe->reg_back_up_list_num; i++)
 		regmap_read(regmap, afe->reg_back_up_list[i],
 			    &afe->reg_back_up[i]);
-
+out_disable_clk:
 	mt8365_afe_disable_main_clk(afe);
 
-	return 0;
+	return ret;
 }
 
 static int mt8365_afe_resume(struct device *dev)
-- 
2.43.0


