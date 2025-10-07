Return-Path: <linux-kernel+bounces-844396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D4BC1CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C45F4F7152
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C462E283A;
	Tue,  7 Oct 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr9zrZX/"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40170191F91
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848647; cv=none; b=T+yrVqTpQZoJr8pX5UBjXb8qnG176hH/SIvj+GKUe7BAjj6EATXDQ6XEZoMoe6mxl/U9nOjduf6q4oJga3B24NMEbZWXIs/ZHBrvchNqx0CRRsACn+IXmmQMEwxV30KfLKqyrs64+tbKDAjXuoLIqVGNxXW7RVuAYkawvC44ZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848647; c=relaxed/simple;
	bh=EhsgpQb7Uel4d6/a0KV9NMjV4SgYUDmvyndiTen54ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iqdog9bABMdwwXgNKtx2It9wxrlFaI6pz8exM1xTMBTtUGJTRePi1XOOMzW5X/SPqNhGOb4P9dwOGRPdfm3/DRgpFjX0LD+2Cvo69+oCf0F3dpxl5G3V+GFWVfgS+UprDNoPDWG7/VMzIAFntGEaIUfvLEbo52aHsAcY8HB4ETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr9zrZX/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3322e63602eso8282690a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848645; x=1760453445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln5XXfvynWD5s08ekS6kiZ2giWwkOej2qpSY6KpsAO8=;
        b=mr9zrZX/RuB+Xte5HpEoKmM5Q20NeiCLlX7kju7HJpA6oFGjDSiP9Itw/pFA0pu15S
         Fi5c7IkLxo644eksmzgz/gi3dbbJ335w27lbRAII3I6Ay0A0gJ3Y82kELauFroWuYOft
         du91MRgdj/HMw75ZhRj4f7CJaYailVN9Cx37rCu2kjt7Y7q91sNTazXnMvhn7v1ryPYT
         N34TYgKOIajb5xcOVWaA7QV645/+wNmxTfvhyzQLLkDebCXRRfO8tXLjwRL3TC26gTRg
         /kPVlIMo9iAz/wBQIACbPjRGcboZ+z9SL446F2iFXErUazYQceWKJ5Tx4T1Tr1VO905d
         xdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848645; x=1760453445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ln5XXfvynWD5s08ekS6kiZ2giWwkOej2qpSY6KpsAO8=;
        b=dbl3CHCSvuVGLPVZlGFwJTvua3Y0udGY5vvdWc637aUEPTQFK3yNQ8XpIXeGBJdfky
         EqrUJgJH6h/2Hl3oJgUDCsqKfRvOL03brBraFhw5turK2kcu+kaNftWRlL1+gMvXPmRp
         s6kBqBqj61T02taiMQg7lCAGClvOy3wkkPhlk1ZRUa7725n6rjqdeWajGcsKmwNuw7mF
         UMC04ncX4hNIS2ztAKtYYDaodXtAfphnrVp6Xon5a8I6NBLh5CrUqrXgmhG4ESBYmLyb
         btpCwZr2U9/Xh1HN22Lfa+zyGYfgKNykuJ2ZfgIo/1JimjjIUTxGsQxdV9lqAcGr9FP1
         LmHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZAIyv8Fw/DYC8BlRsyNSku6RikC8wlyeEzsro57nME/QdOSQlbFaGhm9Kp9L6T7daLQH0zCSUpTdrMKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Q9DfM/RCXE93v/AgQwnAErFTdcJzFEvj+VvGxLJCaDUcXCt4
	fCJkLyDXjURMmyITpAwowybpNwJPT3exNbHHqII0tpt+2Q9UeJTF6zNCzPqGRjXE/mU=
X-Gm-Gg: ASbGncsoVkk5JxYpLKyBByuRHjuuMA/4rali1J+YzCFJ++40DLkqry15KTxlCXIxdFm
	fCGBUbCrH8fqoZOf9fPcLJd7+/G94pQcC9W5KZRdZ6d7IFmRk4sMtHp9JaSalhxymX+bI5IS7wB
	S+t6ck4HBZ8+IVWWQ9gyVV1zeVqRj0+ML//d0PJuv/5oiViqZKt3rqbaju9xOm6MPLG20hBlyHP
	owhLwgobQlqoM4Z2KnTcbjZrPXvJjmv/JO+jVhOvoorA2i/XB955bP2vIPiw+WsOo5GhVPr5UAH
	iO3habeCql1xBRXJwUZ09Ns3N7zEAFs/x58V6Ybi1LiozUyYtgPzsgpmzny4VyAPS38P6wIzbRo
	614Pv17Vv+wdG6OoQPvawz57L30f8VZRqbafheWQwCN93dEYfOoC34GjM5UFUwAkc6/hWUCmk
X-Google-Smtp-Source: AGHT+IFgA8S/Hviwv0i6ktwLJ7KmgfbSl1PoBilNAioJZc5RhrRBnJAaBleGNVS0uz9y2sjfTjLGhA==
X-Received: by 2002:a17:90b:3b81:b0:335:2824:aab4 with SMTP id 98e67ed59e1d1-339c27a1930mr22876015a91.24.1759848645287;
        Tue, 07 Oct 2025 07:50:45 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b63039f795fsm6399656a12.1.2025.10.07.07.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:50:45 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
Date: Tue,  7 Oct 2025 22:50:28 +0800
Message-ID: <20251007145028.1845-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In previous WM8978 codec driver versions, wm8978_set_dai_clkdiv
might not have been called for BCLK, leaving the bit clock
divider unconfigured. This could cause incorrect or unstable audio
clocks depending on sample rate and word length.

This patch adds a check in wm8978_hw_params: if the BCLK divider
has not been set via wm8978_set_dai_clkdiv, it is dynamically
calculated and configured at runtime.

This ensures that BCLK is always correctly set, whether the
machine driver configures it explicitly or not.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 sound/soc/codecs/wm8978.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 8c45ba6fc4c3..8dfce6ede8cd 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -99,6 +99,7 @@ struct wm8978_priv {
 	unsigned int f_mclk;
 	unsigned int f_256fs;
 	unsigned int f_opclk;
+	bool bclk_set;
 	int mclk_idx;
 	enum wm8978_sysclk_src sysclk;
 };
@@ -590,6 +591,7 @@ static int wm8978_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 	case WM8978_BCLKDIV:
 		if (div & ~0x1c)
 			return -EINVAL;
+		wm8978->bclk_set = true;
 		snd_soc_component_update_bits(component, WM8978_CLOCKING, 0x1c, div);
 		break;
 	default:
@@ -717,6 +719,11 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
+	unsigned int bclk, bclkdiv = 0, min_diff = UINT_MAX;
+	unsigned int target_bclk = params_rate(params) * params_width(params) * 2;
+	/* WM8978 supports divisors */
+	static const int bclk_divs[] = {1, 2, 4, 8, 16, 32};
+
 	struct snd_soc_component *component = dai->component;
 	struct wm8978_priv *wm8978 = snd_soc_component_get_drvdata(component);
 	/* Word length mask = 0x60 */
@@ -820,6 +827,23 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 	/* MCLK divisor mask = 0xe0 */
 	snd_soc_component_update_bits(component, WM8978_CLOCKING, 0xe0, best << 5);
 
+	if (!wm8978->bclk_set) {
+		for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
+			bclk = wm8978->f_256fs / bclk_divs[i];
+			if (abs(bclk - target_bclk) < min_diff) {
+				min_diff = abs(bclk - target_bclk);
+				bclkdiv = i;
+			}
+		}
+
+		dev_dbg(component->dev, "%s: fs=%u width=%u -> target BCLK=%u, using div #%u\n",
+			__func__, params_rate(params), params_width(params), target_bclk,
+			bclk_divs[bclkdiv]);
+
+		/* BCLKDIV divisor mask = 0x1c */
+		snd_soc_component_update_bits(component, WM8978_CLOCKING, 0x1c, bclkdiv << 2);
+	}
+
 	snd_soc_component_write(component, WM8978_AUDIO_INTERFACE, iface_ctl);
 	snd_soc_component_write(component, WM8978_ADDITIONAL_CONTROL, add_ctl);
 
-- 
2.47.1.windows.1


