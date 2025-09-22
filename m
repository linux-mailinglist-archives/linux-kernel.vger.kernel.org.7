Return-Path: <linux-kernel+bounces-827375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF91B91934
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642131683E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4901922FB;
	Mon, 22 Sep 2025 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c87RPluG"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447919AD8B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549979; cv=none; b=g21AOWtPSwpuvChH/nKf3tMv0hvRtY5LyOi3CMfucVvxM8GRlsONBCRIRalZ26tu8DY5DhuuBVeBkFL/OSvrEK5NSi+vkc/5odAs48ArNiNrpYXAVm+2twRJ0qTOxSQ3TfCfD1Bj4DNy/9YDTt+1luoyp/4i16DDnIugvJT0ki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549979; c=relaxed/simple;
	bh=NSzxPZcHqME+hAtkJ0C72qogZnh9d1CTCSrgMBNyWpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NODjIl6Usmvn9lwPh/S9hLoCiOggr01fSyJdpMLenv/YJ9MCZS3XSEFJKCGVe+KzjgiZmoCFKXOdDEYOGsbYVu4fVFHkPMvYx5XLJZM9O2zz6DgsDaFrxJMB3jfyC6V4H5wy2vlW+8PuQBrltR/hRU2Ttbf4VG4YZj9XNsASfXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c87RPluG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso3624614b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758549976; x=1759154776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q65R4wtI7rKWrIB8Hpru/7LhZExxGYM5TnlXns4ne/U=;
        b=c87RPluGLTEG4UqAFiiXTRysBebOLFXX8T6DeDpuUDsgRfSC+PyTVWh9UIwtr9rKa/
         v3PmFehxTh8wY3+MPNuGTZ3o9RSdjwBK9hcqqwwnqCM27CQ9+tQLTVneHkAcUN6y2r5a
         k9mDgQXBuEk17Nt36U66AFrCOCYvaU7RP6tfpdQ4pNNB3Pc5sBL9jF0mmFAR6lFYvrmU
         sL7MBpnBo777nQ7MmSkNCNqjF9GIS49ww4ht/6br2t1i6whdHv+30x+UtH5hDTmTe4lL
         HBqIr1+jgZVXcXI21YmnrTtV/Hy5I4RCC9708jAPBimYt7Jeq+jcJBKgyZnQ403yDHxp
         0QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758549976; x=1759154776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q65R4wtI7rKWrIB8Hpru/7LhZExxGYM5TnlXns4ne/U=;
        b=wcIuuKl0vocBzvGFLJj7osfr5C69DbJwHLL5Y3LYbRiQbENHsKCukh1L2kxPXsxB9k
         gnJpIrWkD4Yy727F4R5Yo4Wnm1jMizAU7EmKAvXIJzP/lUKkd8GuIlPnIdai5DzS1IH3
         KxNH5j8sKnHYyDn4zKKdQ1/dXB1lH55Rq0PpZ1mZP1iI72cF7r5bo1MHSOHptmjASZH2
         J+3WAa6nA4yx8tPOqnqMiT6kp2nGsvdS76ojrV7X/ZQiWhKjIRqEEijdgj7fkrgVqOf9
         k/Y5t6d7+LAHQnOR94lZYKSsiejkL9ip9Xz11W33N0Jl/JTQeFz6wsRQD3co2yh4HLSV
         IR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3wz19bDLUaOyo7FQ00jdQ1T7zerNr3JGWfB6icDb64+9CTF/5pHqTZaI89PKyhDNPx1ovW0Bvrqqs9tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWwFTy/j3PCueu1CUCUzDJuZktuMKkDjUuUFN4ZOphtRpCIla
	L2MSbEhuDc3/tocig9z9Tibfwh3BUCok7aGf8FFnD2lHtOKjC5aEgqh8
X-Gm-Gg: ASbGncsnyf6F9HoS5HOhTwMgeup0hAvqYNN/POtpTe9VgMTYwoYkI8b4Ao2mwDrkMpV
	QRSgWyJBxcuX1T5114O0lQZLPiyQ7iFdt8H9LMn7X7new8/ql02AS1of1DBk7LTdlZ8Y+fTiX0a
	Qx4yaJ4iGKCsng0znXHozL7YPziGybUcoseZUxCpO8gRWFSjSGdvYN2MtEu8J5Ra0zsZ1mDdJLb
	8YH2M9Y6UpvDTg6PtRnt+xx2DjJtcgNmC02jSHn9fcY9Krhyff0hAtuahb+yBS5M6AWg5mJsRLn
	ZJpowraUJUD0+FfKxNuBJbeU4LC1OqUB+XiBSVRwEvE68tjETnbvGFBbChNtiHicnJtXzYpJKvE
	OpAyr18xF1XFwaMxXm6XmNA0b
X-Google-Smtp-Source: AGHT+IGut+RghUbyFn2F4fwYbZuwj/DFVn5Cf89eveAp7C+mVNUJEdBY4DbdKoQyXojSDqZ4ufxz5w==
X-Received: by 2002:a05:6a00:c85:b0:77f:472b:bc73 with SMTP id d2e1a72fcca58-77f472bbe3amr1851305b3a.6.1758549975348;
        Mon, 22 Sep 2025 07:06:15 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:3333:9fe1:c4de:4cb8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f188dd4a8sm7177799b3a.39.2025.09.22.07.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:06:14 -0700 (PDT)
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
Date: Mon, 22 Sep 2025 22:05:55 +0800
Message-ID: <20250922140555.1776903-1-lgs201920130244@gmail.com>
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
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
index 10793bbe9275..eaeb14e1fce9 100644
--- a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
@@ -1979,6 +1979,10 @@ static int mt8365_afe_suspend(struct device *dev)
 		afe->reg_back_up =
 			devm_kcalloc(dev, afe->reg_back_up_list_num,
 				     sizeof(unsigned int), GFP_KERNEL);
+		if (!afe->reg_back_up) {
+			mt8365_afe_disable_main_clk(afe);
+			return -ENOMEM;
+		}
 
 	for (i = 0; i < afe->reg_back_up_list_num; i++)
 		regmap_read(regmap, afe->reg_back_up_list[i],
-- 
2.43.0


