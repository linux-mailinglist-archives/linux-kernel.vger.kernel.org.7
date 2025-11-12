Return-Path: <linux-kernel+bounces-897598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9732CC538A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F7605028A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE6B34029E;
	Wed, 12 Nov 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJXpY/Sz"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7AE33A033
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962091; cv=none; b=Th2lbKbYkDovUKWyQLPz4x7tadcL8maMpiZ2g8kLybVZhyEu5INKxi5Hkce1ecmLsrD/IpMQwpxmrF1rGyedHHzQbZ5HtkPHjZ2aT+5+Pd16b7DkCvuyzntg/uPpA0zM13tf2COPOzordjg6bV7CuuF5AtbFlTm2WMtYU8cS7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962091; c=relaxed/simple;
	bh=In7dKHJWjfOxEtrVeI6kTSfrjwoLbH8IOv8sdxgIDL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J06AYqv5aOBr+YlffEUKFTPe6hElXaQcib7sEszzMOz6kXa1hiQdGtUZq5pr1wlwmvAJcH6fFelEZPBVNDDALJZj8iefkUzcfHCrj7zy+BaFfbEmCWyqD/K99qHARljTC6zXDJ9MYui5ljjrsZ8U7WZ6fyfNvEPnRmGVseKQWD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJXpY/Sz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso1506201a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962087; x=1763566887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqAC+UNeM+Yv6vfhs9gI86/DadbeV+G5Du2hkzLEz3I=;
        b=bJXpY/SzO/yjQwhlVEQ+6s+5Zu0tiAcxx68C8nt0Z/E97ksjQQFIGndZaVevtI6q+3
         W5IM0/xM99/IOzwq/DWfK+359Ny8m5krsq6Hl1pDT0iuT44Fv7G5Gcoti6sMv6X8qeu5
         A8iQTdpgVUmIQahAPcvad7JYGdTDCSCXVG4R3R8vfUidblfEnLVwOVfAlDOqo4aiCyhc
         NLCXtLdf0a1jjo8tz6qeNbPzyeZqTdCWT0fXj8uV+By4YnOhgVKMaeepQwMuOFVf7cv8
         5JRNHjs5PE1FZwXToIEnU3ZxJ2Y5doV5oLzaUQgkPcf0AjV3cza0bqOke9Ys7rgbDgbV
         5keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962087; x=1763566887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vqAC+UNeM+Yv6vfhs9gI86/DadbeV+G5Du2hkzLEz3I=;
        b=xEzY9VEJ/zqHToTcAf7gx+tiibnL/5C0IdacYhnC+UNsPPEvbMMmnm49GkFmu1EYrH
         5QUpzu1vzrc6dxSSoQw4EbjhgEZp/0z97jcELEBe0GvFoDRgugQEUMfosgK+PtxaGF5I
         /kchTCM8VdJNLDQ/CuaLrBg734IZJm+iLM/641lcVcxFVGLhDxRFjLD87+Z4EYewYSP6
         US/Ehgpuy6VP08cmad4Mp+K6YfMlpAx7qrBJ3tCaLydl0Hj2S4R9g1/us2a14NGBlOE4
         l2/Xj8dQ4D2g2Nddr1M3HR2w8dU6YgcmrOIo9ySGGNjC+G5TSdEu6BeZ7F4u94ux1196
         bv2w==
X-Forwarded-Encrypted: i=1; AJvYcCXqZKEUfzFTFXHBTS3bOCoAuPRFtONrj6wppfKHmwCqbFB7XhkKU2QvOJ2X5MXdSNNh1S1jyN6fBPOQRHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/pd4fUfg/RykFCnnA8WGXEan8vSF5vy5Cg7iLCl5lMe1+hgE
	6YZRPYsU5euQTUtnoaIzLotc1Aet5ipkU+d529DUG7GaqaP6hiVp1sF7
X-Gm-Gg: ASbGnctDVvCtpfy0J/hTXvdvE029ZPmhq/O5WffVU8Q1Ys0UKj17vj/+3rp0jGsQ2O7
	BaPWtAubBtdHLeH5lAUOCeLxitaA0ZRavjXzhX1eV58xx7w/ug/r40nYKH2aHz7tvRt2jaunp5d
	KgDK0eMeVOSawYnqKeCElTm5JMxk/rkKu3nHrtLjuCgJ8He4tWGq5SN+hC/unML4fOhQkcBuOXR
	Ya6FMbrflCBikXC8QUNwaJwV4fOBDC96jJQ6W+IQF3KBGhzQoIFJxvwQT5IyhbHA24rBISbdm7Y
	cfO57Lf0nKbBsiwfEWJSgSgk+Tvem3flvIHEHumcqO2BgP1oMPIuDtQ4RnxLTmegDZJLWTpdQAx
	lmwc1WVrDPtsqk3CyF4fRk2L7g4ibE9gnsrqEXQ9uTYCmzeTthl/628B2dEx7gXYdEJWO6Q8oVJ
	e8nUb0GMVyw80ytIi2ZbmIfH1bZ0oMLE5YBicu8kojJozGZeolwDKwxrd+Mn7eQGSKNmp3EQeMO
	nuvyWIKmNiLsB0J
X-Google-Smtp-Source: AGHT+IGQIG5IrOJDrZArdz6BGwNr4MHfKQAdEicjI7rp98rPdh1zbdlEJ7bGm3OfdRkb+f6C5SQ3tw==
X-Received: by 2002:a17:906:d554:b0:b4f:e12e:aa24 with SMTP id a640c23a62f3a-b7331993fc8mr373774466b.22.1762962086629;
        Wed, 12 Nov 2025 07:41:26 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d456sm1670023566b.39.2025.11.12.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:41:26 -0800 (PST)
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
	stable@kernel.org
Subject: [PATCH 2/7] ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width
Date: Wed, 12 Nov 2025 15:41:03 +0000
Message-ID: <20251112154115.1048298-3-biju.das.jz@bp.renesas.com>
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

The strm->sample_width is not filled during rz_ssi_dai_hw_params(). This
wrong value is used for caching sample_width in struct hw_params_cache.
Fix this issue by replacing 'strm->sample_width'->'params_width(params)'
in rz_ssi_dai_hw_params(). After this drop the variable sample_width
from struct rz_ssi_stream as it is unused.

Cc: stable@kernel.org
Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/renesas/rz-ssi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index f21b332b3656..039bec32cb5e 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 
 /* REGISTER OFFSET */
@@ -87,7 +88,6 @@ struct rz_ssi_stream {
 	int dma_buffer_pos;	/* The address for the next DMA descriptor */
 	int completed_dma_buf_pos; /* The address of the last completed DMA descriptor. */
 	int period_counter;	/* for keeping track of periods transferred */
-	int sample_width;
 	int buffer_pos;		/* current frame position in the buffer */
 	int running;		/* 0=stopped, 1=running */
 
@@ -217,10 +217,7 @@ static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
 static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
 			       struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
 	rz_ssi_set_substream(strm, substream);
-	strm->sample_width = samples_to_bytes(runtime, 1);
 	strm->dma_buffer_pos = 0;
 	strm->completed_dma_buf_pos = 0;
 	strm->period_counter = 0;
@@ -982,9 +979,9 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
-	struct rz_ssi_stream *strm = rz_ssi_stream_get(ssi, substream);
 	unsigned int sample_bits = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
+	unsigned int sample_width = params_width(params);
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
 	int ret;
@@ -1003,16 +1000,14 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture)) {
-		if (rz_ssi_is_valid_hw_params(ssi, rate, channels,
-					      strm->sample_width, sample_bits))
+		if (rz_ssi_is_valid_hw_params(ssi, rate, channels, sample_width, sample_bits))
 			return 0;
 
 		dev_err(ssi->dev, "Full duplex needs same HW params\n");
 		return -EINVAL;
 	}
 
-	rz_ssi_cache_hw_params(ssi, rate, channels, strm->sample_width,
-			       sample_bits);
+	rz_ssi_cache_hw_params(ssi, rate, channels, sample_width, sample_bits);
 
 	ret = rz_ssi_swreset(ssi);
 	if (ret)
-- 
2.43.0


