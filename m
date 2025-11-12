Return-Path: <linux-kernel+bounces-897596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49BAC53738
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB36563FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8213833DEFD;
	Wed, 12 Nov 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANKmPsFu"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25E339B36
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962089; cv=none; b=H2EWVs0esiZwOGoTsLLqr4gacv/PAmQt3U2u+e+ln/TQEZZUG4+H0dijgdUJHt4IKoeHIpdlDDDTrPx6203gMXOYSFXIlj6o6eaz3DtLrT17+Ze+AzI3D9wdUEBGQhgkJ+SP6y3m+C/cPiglS5PUXSkOIyFX+IBe9XAd9f0cMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962089; c=relaxed/simple;
	bh=UClL00HHRdjqVQ8rRDJyEJORa3/XwLjIF8+0EpknQq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zz4fxUiHyLpeyDs3fs9Ckv3kPz/pJmn4GfEClRTTqRQOqRG59rncAhjFFsl0/c0QPzgFPSyHAlYKis+0/UpNBYWr8THNRX0I+z5rXe/zhweEFa++cSdHJr2tTqZaL0rW/8dL76LhkMDqpqqRpE+7Cs9QAieG9fxtOol50lHSDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANKmPsFu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso144602666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962086; x=1763566886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk7u2O7gzBgbufSRxECeKhh27HRZUnQrOMyIaKWC7ws=;
        b=ANKmPsFuZKOjXrk+WZ+5vWzfBmnhMJJfAh+tvxjUpLvmOXtFlfGEjnvy+h3+a0j/ij
         WgkoeJ8sqQ6a/Uj/Nflrr6YcDe0teiDimCh11m1kkWgVzvp0WgLCeRCclKssbY6Q943w
         3jfIqw6cWbA6fSKBjvVb+djtKIIM/hOzg3NPGwltl7swWL2Cl4pkeDLQt9sMcmxooo/5
         M2MMZASc4X9hu5W+Ml+0l72v4d8m+FNL/GBq6A5vSpP57h8I2txlWqiA/grvmgh6WQ8n
         P+jKsJOhgbHhVLpAhHwsCcKNmdrhLsONq/E1+UbiWeFJb1R5OgygDAY7ztlZQTWlL9ku
         g79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962086; x=1763566886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yk7u2O7gzBgbufSRxECeKhh27HRZUnQrOMyIaKWC7ws=;
        b=N7HweidqFRzEsIeNQDtrzNd/G957V11WjZZqFsHCEUv5d51B8sOO+MUjbg3hOwT+Gn
         PxnibxLYii5VDfUtG3tRMlO75rzvKA6TSsgFpEo/MHuxucJTz4x+USZ5Xts07upotopB
         aS7N8PErDLLGqcC/VRtugvP9TSVVCyBjnVZQSZnEjNinYIqd6f/wixcU96BRYiSrdK4U
         6HzorrA3zp7oGkSZ8cWU8h34xIl2jmBglYEHsGh2VSP/hNq9nZ8b43ehemPmbMz+hitb
         YafKUADcpl5DwyiyViYDHZhrT3tb4wl92Wm9p+dg8dTWqaj4Ogumr7Ht1VkdZrYxWRZj
         Eeng==
X-Forwarded-Encrypted: i=1; AJvYcCWX3OKqRUzMivRVTxYu3Nz2vbbMPzsjC0Az6NuCEeFrxaG20Z2002ZYZxPMyOhccMvq1Tt/M6uQiZukvwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynAsGWbLYmTCt4qVvg/5P2U9/DQQZ70I+tarpKBS66nL5OX4E6
	2DWWmf66J+yg1oi+J61+poF2LYuyR8lj+n9PN8w9f1P5fmDZ9TDVI06U
X-Gm-Gg: ASbGncuPbvE69hfWzSkCwouyi/gFs/oPkgcQMUtcPGi7jq0FziJpQ0vJvi5JxaL3xmu
	GXlOMCd1OmsFRjJwz7/iVLiyJdn9T23/QJuJ4Drozprfe0qrBX6lyGk4QapDpzbAQNKAobTEHt/
	wy6r2oCK8KSiJXmbESiuuOIvhpogVsHyt/XwJJ7yEcKYQyZxxGlXkjvaSE8GSi1rRS+8pDXjhp7
	wgfKefAZS+Ik1uemQbmGaGeEcmi2+8k2HYIZkn1nG/zDFmpzZvcI8S4BW1A3+K9igje4/0n4Mom
	GQ7/Kt9PlkAoetvwd8PSHu02KuhvFH/yuecnDig6chRbI/f0hDWenvdcDmtgPtHgA/Y0hKPGCTo
	VAohTfCOISNB54p+o++CSXWt+NC7xlcbM6OTFa5+69jMT7OrfFcpXBQ7zQfCg+H6smFXaN8Xh3H
	kNxkoGFX3c2xlvpEeEujOwpT5lIGI4BSaGm4Uf6bjy8lHUVFVRvDHdn98egnKA8ms/NJ+uIsk9U
	A6nQg==
X-Google-Smtp-Source: AGHT+IGgr7VLLs1gOVhCQRtNcp9U6lNi8siXqNWSeqIbbBA6TNOKiWU+pVTILXw69C+/pi/ijkJrCw==
X-Received: by 2002:a17:907:9722:b0:b72:5380:f645 with SMTP id a640c23a62f3a-b7331970ab8mr397255366b.3.1762962085846;
        Wed, 12 Nov 2025 07:41:25 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d456sm1670023566b.39.2025.11.12.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:41:25 -0800 (PST)
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
	Biju Das <biju.das.au@gmail.com>,
	stable@kernel.org,
	Tony Tang <tony.tang.ks@renesas.com>
Subject: [PATCH 1/7] ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
Date: Wed, 12 Nov 2025 15:41:02 +0000
Message-ID: <20251112154115.1048298-2-biju.das.jz@bp.renesas.com>
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
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/renesas/rz-ssi.c | 59 +++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 81b883e8ac92..f21b332b3656 100644
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
@@ -332,16 +338,17 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
-	is_full_duplex = rz_ssi_is_stream_running(&ssi->playback) ||
-		rz_ssi_is_stream_running(&ssi->capture);
+	is_full_duplex = ssi->dup.tx_active && ssi->dup.rx_active;
 	ssicr = rz_ssi_reg_readl(ssi, SSICR);
 	ssifcr = rz_ssi_reg_readl(ssi, SSIFCR);
 	if (!is_full_duplex) {
 		ssifcr &= ~0xF;
 	} else {
-		rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
-		rz_ssi_set_idle(ssi);
-		ssifcr &= ~SSIFCR_FIFO_RST;
+		if (ssi->dup.one_stream_triggered) {
+			rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
+			rz_ssi_set_idle(ssi);
+			ssifcr &= ~SSIFCR_FIFO_RST;
+		}
 	}
 
 	/* FIFO interrupt thresholds */
@@ -374,12 +381,18 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
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
@@ -915,6 +928,30 @@ static int rz_ssi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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
@@ -985,6 +1022,8 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
+	.startup	= rz_ssi_startup,
+	.shutdown	= rz_ssi_shutdown,
 	.trigger	= rz_ssi_dai_trigger,
 	.set_fmt	= rz_ssi_dai_set_fmt,
 	.hw_params	= rz_ssi_dai_hw_params,
-- 
2.43.0


