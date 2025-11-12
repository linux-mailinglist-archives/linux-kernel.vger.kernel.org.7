Return-Path: <linux-kernel+bounces-897600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E932C53317
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0135351FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14A340280;
	Wed, 12 Nov 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoqNmsBJ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95533B979
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962092; cv=none; b=PdSLp5GRVLTOUspaW1Joiu1c4fZEMRwPiEAQBkuL9MMidfKLHorPQtM3F9TqcjZmk/yt5TXCUW/eL0aBh03kRpp3R5l+vBfHhCXhOa5Wx2W6ph1FqAcbG5l7+6bEBrHoFiJUwNf60TbUtY8dAlDfd7+UxXGS4NneVtl1VH8S5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962092; c=relaxed/simple;
	bh=jj3vTLvr3WCiPV6i5aH1MKkIW9M01IOgqR9TLzyysKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7dP+aAtDT8zyYKlfzeXNGAt8iotnDv9UtTlMHhkbiDjSLvEn4NGlQdqJIiBJ2EvZUX672lP6SA1Or4usq+yXCacF2as3vS92Iuv30BWgJcJXEWWwV4LhUQTOQaMsV+ft76aQTXHCzUdFFc4xMu+KGcLyqSmW8sX2jQLg5RCDlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoqNmsBJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7272012d30so163802666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962089; x=1763566889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj6ZfkS77Hkj1ggagRTkBVhoyJmLo5G2pZsYVl8EfqA=;
        b=GoqNmsBJs9BHAEJbu7WiriBsFJtr/knbD18xQE8CV6JOcATJj8JmtxlFjbrtbe2chT
         LKT3E0OIP1X0TK+bekdvYQ9z51nd0Z07KVKf2/DblfZwAMIzdP/t5tZ4LI1q29HrXgMI
         fEtvCtH7I1vubc3QBmREpM9FRCWiiO8xGBnC+3fJIGWkDV2H6/MuPwnBIj8YPcYuiQXB
         MFDTrLUDLdW1+yDnz/fx8WEvhIpMuuTnhU4Uxf6GNsYAWXoj3nfWjPHsr1yJX5s5/ejD
         /IcN3L7j8MRTYcft++0pFfqu7TOckTlPD0gB3aH2HPMAz5otQclnOPX8vrvvNgCWurKB
         thdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962089; x=1763566889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bj6ZfkS77Hkj1ggagRTkBVhoyJmLo5G2pZsYVl8EfqA=;
        b=ZNep1o9UF21Do+j9AYrmYeTlP2uDW0buIfCw/hiYj+dvbicjse2UsvggBIILAgD1UE
         hE3DJH8CZsEGLq9QaLE1u52cU+Q1MmNEj7+LGoPhI5Je4VOxpevy75EwJENhwSEhjJrA
         SKDAQ3j3olfwTiyN+Mj0US4jLwntGc8VEquMzVCDslvWZE1y86cL9i39YZHDLXImV3XS
         MIQ7nyR2PlZ5nb+KQSjoyu9fyVoyfOJT19NH8fvYZZKM7rk4z4qhQhizUOI2gu8RSaSM
         rTBNgk69J5e3dK/vdEPG41LgnYbIyw0N4h/cjvxlF1biTnAlKIOPe2so21h4jvKaM4Qq
         ya2w==
X-Forwarded-Encrypted: i=1; AJvYcCXwhd/0j4Z2P3CpTbYkLlZszdE2RCfPW9Woygr0udVWeijgGR3wjNoKP/MIdDG4mjbskX+3efrKjZSq2XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGZE8xmzKe0QlyP7EWwXiRU5Z8IJ8QbkxsMz3S5MW9+TPJzvK
	KLvbmavMz7MQzC0LU4Sl6+69+DfBunczLx//DBH0BwKiYdM0C2P9doBO
X-Gm-Gg: ASbGnctbQd/6otqir85UlRy9mAJrJ63Jareb7jiOyc5/nVC9Pl+wxXQftmEcf2WBmwz
	bbV1ENmQAN+s+LrBtHDDwPi2vxk9Soi+46PcYQE9Ra90QJDQcgRgBbMMzzDzPf9KXEpcBH4qeRQ
	Sb2HJfHTMvbyaJXFc40orta+U93hUD/ypIg7JEJzZUPW7J+WqWtzo4/re1aFZN2H9JccZmva4FS
	bcOs0npDp0hJSHaY3S49wg4r8KslmUqvH/1qd8IDoGsTm56RFEH3y+K5azfDzw6Q1zBTlrB0uy4
	OX0+ZAyG6r9CjQYlJXMFpU91ALfi9hvfL6zTdN/Cc99/NiWXrjG34xnbgI9W8wrQE5Vd++lxcgP
	046YjbG3Z00MD5h4PUjdAkdIxxIcZubC/Wg9py2ymeqGZ6SE4L3tTwdfaQ27Fq1XsonpHPzT7Zt
	Dq5oTpAOErZFnqBoclf/+0v24gT9RClkMaiJ88hoij9Hx+05PWeCHl9mrAN5t6V+egbZf3ifu1m
	gtDyw==
X-Google-Smtp-Source: AGHT+IGkJu4gFSEW3zfxLURJ8AyVV5KilcDzFNMu+vkSrN7cqdVzG32uksgUmJAcnsaH+ofD5sZrMw==
X-Received: by 2002:a17:907:8687:b0:b70:ee00:a465 with SMTP id a640c23a62f3a-b7331abf76dmr399894066b.53.1762962088563;
        Wed, 12 Nov 2025 07:41:28 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d456sm1670023566b.39.2025.11.12.07.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:41:28 -0800 (PST)
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
Subject: [PATCH 5/7] ASoC: renesas: rz-ssi: Move DMA configuration
Date: Wed, 12 Nov 2025 15:41:06 +0000
Message-ID: <20251112154115.1048298-6-biju.das.jz@bp.renesas.com>
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

Move DMA configuration from rz_ssi_dma_request() to rz_ssi_dai_trigger()
for supporting sample widths higher than 16.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/renesas/rz-ssi.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 5dc510cf66e1..839934e4b76a 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -778,14 +778,6 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
 	if (!rz_ssi_is_dma_enabled(ssi))
 		goto no_dma;
 
-	if (ssi->playback.dma_ch &&
-	    (rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch, true) < 0))
-		goto no_dma;
-
-	if (ssi->capture.dma_ch &&
-	    (rz_ssi_dma_slave_config(ssi, ssi->capture.dma_ch, false) < 0))
-		goto no_dma;
-
 	return 0;
 
 no_dma:
@@ -833,24 +825,27 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (cmd == SNDRV_PCM_TRIGGER_START)
 			rz_ssi_stream_init(strm, substream);
 
-		if (ssi->dma_rt) {
-			bool is_playback;
+		if (rz_ssi_is_dma_enabled(ssi)) {
+			bool is_playback = rz_ssi_stream_is_play(substream);
+
+			if (ssi->dma_rt)
+				ret = rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
+							      is_playback);
+			else
+				ret = rz_ssi_dma_slave_config(ssi, strm->dma_ch,
+							      is_playback);
 
-			is_playback = rz_ssi_stream_is_play(substream);
-			ret = rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
-						      is_playback);
 			/* Fallback to pio */
 			if (ret < 0) {
 				ssi->playback.transfer = rz_ssi_pio_send;
 				ssi->capture.transfer = rz_ssi_pio_recv;
 				rz_ssi_release_dma_channels(ssi);
+			} else {
+				/* For DMA, queue up multiple DMA descriptors */
+				num_transfer = 4;
 			}
 		}
 
-		/* For DMA, queue up multiple DMA descriptors */
-		if (rz_ssi_is_dma_enabled(ssi))
-			num_transfer = 4;
-
 		for (i = 0; i < num_transfer; i++) {
 			ret = strm->transfer(ssi, strm);
 			if (ret)
-- 
2.43.0


