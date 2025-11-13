Return-Path: <linux-kernel+bounces-898899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA83C56496
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C14684EC902
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE2E331207;
	Thu, 13 Nov 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai/napDP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FF219A89
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022358; cv=none; b=WCVvl/+CVRuC4Abj7IwT9fYQp+YZyrgR27ETxk1K/YPnTkKksEFhnoS1jZNbIBTmxaAYAIIZREracEKccNJjT+YBLnfWIj9X3cYEKSo1Y/pxnmEgRejsoeGugQtNmYKs9A67ihIaySflbw0UgWmQuMLNBaZ7x74tNpFUpxHY3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022358; c=relaxed/simple;
	bh=5W64rERvM797Sy01ObHAwKZTUgA4Qee/2MIM1vkyitk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eH4eBTeCv7PTYWqnP/J0wgL+Kv8rEKJrG4M5GdkPgqWsZbhE9U1A/J66zvh2WYHkTDVC27wwhvqFsZvFoRSVBaxaZVOxJzHyJIirj7LXZi+gs1whFgY83yJ0bAdzOPuTgfiY2rZcvGhUlJZ09B59XlE7FoMjk0W05+JPKE1iyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai/napDP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47774d3536dso4235065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022355; x=1763627155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhM4Gc7RWgkJaI5gk8mnwRyBs4NmyN/cj+R9nOFaiuU=;
        b=ai/napDP4DS8gf7Tw5va/kPU8/VRtrX3q4NGBNAyZc1UYCeofmieB4zrOGh6J5DjOU
         /54FG7hIthNI/UbMzy0CjjCNjH026PbtXyyWab2kJgrb0yREQK2BwH0+tzWuHIJ+qIlt
         Bsk5XxxS4ixW5DCKLqyWW7SgInFoPsRed9cCtQ73ErgFm1l8WEW/Ec8L2I5Wcfik/Vtk
         ZEg1/918zJf7lEughUsPCjjTEkEvffB4wTmNVHI1gJARAAxw6SikpKmH9G7kliR+0AfS
         wcQw74FUi6Cfin/upnL5V0ml9ZE+C+vSWVU2QU2LrX8hvpqLfep4GbSHczQ1vxgG0Vwt
         3R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022355; x=1763627155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xhM4Gc7RWgkJaI5gk8mnwRyBs4NmyN/cj+R9nOFaiuU=;
        b=VRmo1KY/2n6r1E+JB2ImlUP+Y2gfz+w+0aPi/3gw0PTE4Ozrhdywe6G7xGCNhLhoPV
         UDdzhQR7sWTzBn/tNg0wjjc7tCNpYFQrFblis+UofAzRTFbmynuyjPUZGy3RyleELjfS
         v/CHvZa7/0molt8hO3hhECdYaHflWhqXlNVPrmjSoyMr6Qv7kfhY/bHEx2f19xEXdUkc
         9uqmoqJSmiZsUDHPCp6HB6E1ClVrZE/Z0ad+otIhrkndV8fN4yJlX9pAvqbtMdPczx1Z
         Wu0mGknI6cQV5HVjG1J3DCg40+DFqXrOe7ucs7FEc/MjTBHfNmL+xU09KNTiE/Z+Ptbf
         0eXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEyTknA3Sro7+e+rXcFZKx66XYeWxDv+E+iOtQv6DHxKEGoYrrvxZlwy1GxcgwCtGDUlOkSYny3W+c6rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjFICOkmpMq4kRmhTUtYFqzm22m+i3Ld56mAzKtzsIUTVT72mf
	VzMk+MCRJb3spIoY6FJb17hyfd4i0s/p+lolomuLg2b+ws3Ez+0S5NAI
X-Gm-Gg: ASbGncv3hqSXK4CPS+Hw12qfVRXIQbLNPVMmO/FFpcGPxo0YhihivXZ6ZDhVka+5sP4
	c/iZ5Ep9qbA2KLdA+m0BUavRV1s8TFTmYHGIZsVnkA4FZerFf0pLrWXjYbVeu1ygxQ1osZMX37w
	AhkXyuT32k1eL8DGp+qbaRVEkBwSStQTvG33UCA67rq9mGcb6Zv2unUNp4TVoeP2rmvd2KA6aEY
	MOcmCHcMgZkE/cXvbDQluKV63MnOChugrlMj1xEBwItAKKcrNZ/Mco2npRvEY2zO5niZOBziYo9
	MG6P/jPPseVXjyeuqt4NNlC800ekmWnHtSE1fYFhhSkhkppZsFnw63aCENj4tgP+BnRX042rOgP
	w+Qmte+ETR4JXfukcagg4nSLwRE0fXEbnF/024Sgh4eM+NnN+Z3rA4tGasDxhHKeuUtqDXXkfJZ
	nEveBR6wXEELhKSIObe0OUqASVMMpHYZvzhHKv5cGezE7E5uSqIJicPNpYdClD
X-Google-Smtp-Source: AGHT+IF86VzSJ33CNq2rjUllDx7DljpJCBR4tB0Qcx4dUc6YIOF4/BKvWFr5W759vjy9BI2wMO56wA==
X-Received: by 2002:a05:600c:1e8f:b0:477:7d94:9cf0 with SMTP id 5b1f17b1804b1-4778bd7015dmr18283615e9.12.1763022354597;
        Thu, 13 Nov 2025 00:25:54 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb34295sm15214435e9.2.2025.11.13.00.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:25:54 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>,
	stable@kernel.org,
	Tony Tang <tony.tang.ks@renesas.com>
Subject: [PATCH v2 1/2] ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
Date: Thu, 13 Nov 2025 08:25:46 +0000
Message-ID: <20251113082551.99595-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113082551.99595-1-biju.das.jz@bp.renesas.com>
References: <20251113082551.99595-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The full duplex audio starts with half duplex mode and then switch to
full duplex mode (another FIFO reset) when both playback/capture
streams available leading to random audio left/right channel swap
issue. Fix this channel swap issue by detecting the full duplex
condition by populating struct dup variable in startup() callback
and synchronize starting both the play and capture at the same time
in rz_ssi_start().

Cc: stable@kernel.org
Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
Co-developed-by: Tony Tang <tony.tang.ks@renesas.com>
Signed-off-by: Tony Tang <tony.tang.ks@renesas.com>
Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Improved the code logic in rz_ssi_start() by using else if
 * Collected Rb tag from Morimoto-san
---
 sound/soc/renesas/rz-ssi.c | 53 ++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 81b883e8ac92..86a6b4eff210 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -133,6 +133,12 @@ struct rz_ssi_priv {
 	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
 	bool dma_rt;
 
+	struct {
+		bool tx_active;
+		bool rx_active;
+		bool one_stream_triggered;
+	} dup;
+
 	/* Full duplex communication support */
 	struct {
 		unsigned int rate;
@@ -332,13 +338,12 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
-	is_full_duplex = rz_ssi_is_stream_running(&ssi->playback) ||
-		rz_ssi_is_stream_running(&ssi->capture);
+	is_full_duplex = ssi->dup.tx_active && ssi->dup.rx_active;
 	ssicr = rz_ssi_reg_readl(ssi, SSICR);
 	ssifcr = rz_ssi_reg_readl(ssi, SSIFCR);
 	if (!is_full_duplex) {
 		ssifcr &= ~0xF;
-	} else {
+	} else if (ssi->dup.one_stream_triggered) {
 		rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 		rz_ssi_set_idle(ssi);
 		ssifcr &= ~SSIFCR_FIFO_RST;
@@ -374,12 +379,18 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 			      SSISR_RUIRQ), 0);
 
 	strm->running = 1;
-	if (is_full_duplex)
-		ssicr |= SSICR_TEN | SSICR_REN;
-	else
+	if (is_full_duplex) {
+		if (ssi->dup.one_stream_triggered) {
+			ssicr |= SSICR_TEN | SSICR_REN;
+			rz_ssi_reg_writel(ssi, SSICR, ssicr);
+			ssi->dup.one_stream_triggered = false;
+		} else {
+			ssi->dup.one_stream_triggered = true;
+		}
+	} else {
 		ssicr |= is_play ? SSICR_TEN : SSICR_REN;
-
-	rz_ssi_reg_writel(ssi, SSICR, ssicr);
+		rz_ssi_reg_writel(ssi, SSICR, ssicr);
+	}
 
 	return 0;
 }
@@ -915,6 +926,30 @@ static int rz_ssi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int rz_ssi_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ssi->dup.tx_active = true;
+	else
+		ssi->dup.rx_active = true;
+
+	return 0;
+}
+
+static void rz_ssi_shutdown(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ssi->dup.tx_active = false;
+	else
+		ssi->dup.rx_active = false;
+}
+
 static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi, unsigned int rate,
 				      unsigned int channels,
 				      unsigned int sample_width,
@@ -985,6 +1020,8 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
+	.startup	= rz_ssi_startup,
+	.shutdown	= rz_ssi_shutdown,
 	.trigger	= rz_ssi_dai_trigger,
 	.set_fmt	= rz_ssi_dai_set_fmt,
 	.hw_params	= rz_ssi_dai_hw_params,
-- 
2.43.0


