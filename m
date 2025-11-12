Return-Path: <linux-kernel+bounces-897597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C21C53870
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30D5C541428
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEEF340A44;
	Wed, 12 Nov 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiB7AZDp"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D233ADA0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962091; cv=none; b=E9DFEok2Ih5RLV9z1zb11n6D3KFiXxwzgiECcHvHhbiHjuIbLYvIXkSakjzIG8enYAgASsIjIfhpRIJsLFCiYEn42KyhmCoHeKR/51AR02Z72E0ea+RjHfF1uwsezgnkjgCZodhT2lsx52bl8fLcQKcj7yAxtdUEH1IFMx0eHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962091; c=relaxed/simple;
	bh=CRIWp0n5HwRdlkmssRO+ntsNrIka6hpB8QMW7u3mkwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoXeqPIst6kYPfMrtWAEfQzK3M00OgMJ9v9p6XPsNcHiCFfBNckQzNdt0EzE5mprblQxjtaeyn0xu3ms3PNxAaT3XnysknS2KvSbsfPMIG5I/G6ydWJb2iVNfwoXZ36DgToNopG2LR4rqHKRsFgf7wURFWVrUYLrZ+gHiJrXkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiB7AZDp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b403bb7843eso214869266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962087; x=1763566887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq3AgUTPzY+a4pOL3uaAaWkPNx0akFqHFeupvGebgG4=;
        b=MiB7AZDpz3iz5OGP653WkZmtYMl9BYDhrwCxdS6oiwevvUknTaz6LAGwQYn8Nmu5pT
         DuuUvJc462kKcrxbOCjS0AVZ6zpOgl1JZ3PKbYJ0O1P4kbVsaXH9A1ByLMaCtw19UAiP
         Eie9I6te1ejtPTfe67VV0F7q1L1+qJc2+nsOOfJCOGKa+2FhWvOshyBrCZXhRg4mm3ND
         mtP6OWB+gmio05ifLgCQmz5I+K16LAxRFVBTOqpm2ivo8oVJXFzJqIhuknZFkoCdjk45
         jgVTzzXEL5o5+isjfmIaV3epwM2xM82TPRPZImML+IlOEFAr+WN7si0vEvWrSLazDLRS
         KDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962087; x=1763566887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gq3AgUTPzY+a4pOL3uaAaWkPNx0akFqHFeupvGebgG4=;
        b=hw17yEgMK3Vk/qWjdThLM2yc2cKHTwNWNp8alSUcV2OxTDphyKjgT3B9nt0WLMl4OB
         /lJ/00gLxiniE/+5AwI+6sbpUuczMdc1FGouba6JyePsI/nZLKzlK6Z9i2Sd7C9whc52
         9sQWV/lolZcVsF146Kb/oVMkZoiFJ4/cicNEvuYfyfdXUXt5eVtcPodV7OVySHPCBk/g
         A0xWG5lfE9SKXPcOE72bNd7xeqO4eHl+cltNvayiqnqZgcH5acxW8WV2VIChe5Q54sSj
         HbcIn9HQqwB+DZLHbHLVXOfWe+3MMtADQpQ2NU+PLzTcIf5l2v/bzJlLk6qtkucO5Gld
         jYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX70RrM87PoQyUDR+h5qvW1nsQS20/Gf/u+aynO6BiICO84zwdVCvmxy0kcBweuAaH3Du5z4KdHzC/fudg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JWBVkakccqNsSdfbb+/4Bk412Q3P+uTb23aXL66K3ApJt6ua
	Y/JOqF46Tmadq7bdzl9UCHxYwoJn/4BjHDT/ab35GXiB2x3HYcBTmzeo
X-Gm-Gg: ASbGncvBv6j+aaWb5BE3M5aJy7akgwLXuGDF0lP7iPCDwZSobHedj8FFZAmo002i5Lt
	eU9nmdn1JiUb3qB5MgAryWMkaJJQxC9Ncdnh7DEcjxi3JeUeZY6QBCSx56RtN90gPQcV1HmGPOm
	d4oOaQcxfzQxTJRtNCHPENoqb9RoXMMpCGV71ANta/2lCoq6XhKFxhNTjrehbdRNsFfQHd4/6ig
	Klm6QqcQFCEpTXpW23pyw+NKbL/FXs6FeKBS4LUq9EMQKnBOGOBLkcmO+Uqe0bZwh6VY2J9fEyz
	XLyh0MNnfyV2XNOuZIrrw4yx1M59BgxGcb8gYnfzoZpzr7O6SL96KzT7gSl/6jUrm42IBtsipUt
	FZkvJ9HnmFxjRwdfyXIIsZuhzJ708URJ48/u4XU8lWy0HKUDseFoUPfyrgo1GFXIjKI4wZpwFso
	9asscjf4Leg3Galx3tor2S08oKNaEDdDOD91o1RvAW95Xfnzslit6T20cJN0FtCv1S/wUuHwevY
	xfUTQ==
X-Google-Smtp-Source: AGHT+IH+xX5hJrZOC7Qu2lNDzak2vwnr1s8A5ixFZilatjPXkva5IprmaQlq2uvPjZRQHXlOLziFqg==
X-Received: by 2002:a17:907:3f0b:b0:b73:2df0:9fa9 with SMTP id a640c23a62f3a-b7331aec6fcmr309681866b.59.1762962087420;
        Wed, 12 Nov 2025 07:41:27 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d456sm1670023566b.39.2025.11.12.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:41:27 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 3/7] ASoC: renesas: rz-ssi: Use dev variable in probe()
Date: Wed, 12 Nov 2025 15:41:04 +0000
Message-ID: <20251112154115.1048298-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112154115.1048298-1-biju.das.jz@bp.renesas.com>
References: <20251112154115.1048298-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace '&pdev->dev'->dev in probe(), this makes few error paths shorter.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/renesas/rz-ssi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 039bec32cb5e..c7d5576c8283 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -1123,19 +1123,16 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	audio_clk = devm_clk_get(dev, "audio_clk1");
 	if (IS_ERR(audio_clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(audio_clk),
-				     "no audio clk1");
+		return dev_err_probe(dev, PTR_ERR(audio_clk), "no audio clk1");
 
 	ssi->audio_clk_1 = clk_get_rate(audio_clk);
 	audio_clk = devm_clk_get(dev, "audio_clk2");
 	if (IS_ERR(audio_clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(audio_clk),
-				     "no audio clk2");
+		return dev_err_probe(dev, PTR_ERR(audio_clk), "no audio clk2");
 
 	ssi->audio_clk_2 = clk_get_rate(audio_clk);
 	if (!(ssi->audio_clk_1 || ssi->audio_clk_2))
-		return dev_err_probe(&pdev->dev, -EINVAL,
-				     "no audio clk1 or audio clk2");
+		return dev_err_probe(dev, -EINVAL, "no audio clk1 or audio clk2");
 
 	ssi->audio_mck = ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi->audio_clk_2;
 
-- 
2.43.0


