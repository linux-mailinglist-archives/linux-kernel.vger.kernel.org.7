Return-Path: <linux-kernel+bounces-795832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82EAB3F877
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E671A83556
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCCC2E719B;
	Tue,  2 Sep 2025 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPjWl4Hu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6126B942;
	Tue,  2 Sep 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801984; cv=none; b=rsX5ycK5szdBjsXA03lc277eX2onJaWHWMP85hRHnimwEU6HjgXX7g3Anj3odFkpwc0XGyZNVT3ktesBPdCYH4K8FvbWbPUbzO2AEiYbNJAr0lhtEdAL9sYTFaPy2P/pvsdM8IqPFlDl78pu1gyN9KvKIsH9CRuC2DHhO4B0lXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801984; c=relaxed/simple;
	bh=B0Fl8vj47u0ecAJz1JXn3stE8F+V6FoSjW5lbPHNnBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KO+4zTrkLClOxiHDX0XdAg18Qp/W3yynkU2/5KBxIi5FWgTiRVWDAW20OcJCcrSHVE1LKRtdMDvJxO72nH1r6ja09/hdhIT0rufVF9rnF0YKuEic9/B7ElMv1TYpua4147SeLtp2bbF4Rmfup96r8WTxP6cNTUrfYaMR9vgVVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPjWl4Hu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b84367affso26370885e9.3;
        Tue, 02 Sep 2025 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756801981; x=1757406781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lARVrcDNWMzVHBABZgXnN/vt4515FXELovAHVuLC0IE=;
        b=DPjWl4HuE6tHtsZwUrKHaNIjI30f3WUsL8eLSqi8srld+EIOiTEVV0XSdY6HLtEVvF
         tD9vFWC3Zl9CqTrRqbYoT0cstwDSpf3/tuaLENK0w1hEN5ogqBXpbqqXwwZA6Paf3Bdv
         c9tJVVHJsLsLpBrumHiMzfGrrY+BafT6osHzazoT5EcH6oI/ugn3vtz9xqN8D5/4w3qN
         ODYBAjsvl5MwDuRsEiF7CUMEJMjNFqx0+ODonpOBNLMIkqIl5+SnOe7+rrwlixAIdGUl
         78OujXfG9IdJlmVJmJGlcZjP2e73nUxQoDYXsrxstCS3FjzjPBzLyvUvC8EPeUjiQtcu
         /mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756801981; x=1757406781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lARVrcDNWMzVHBABZgXnN/vt4515FXELovAHVuLC0IE=;
        b=m08l0V+TBMTg09VmabYeDhPwoHoDJuZMC4S74GzKPFdUP932cwKtFM5CUgnApGalJq
         Jcr53qPE1iRlt++u87MtFwtYGVDtisstGC+d59f4QVcf8L2kzwjvOFD61ZRjddgQGP+G
         pjVbrr8xtkg2tgMA5LV0uFvXneY0tCdsElCH0xpsrSbtFmEW0zQ0YxM9BvTw5PYVP3bt
         U7yiGSteSBgW+tDBzblX+F3aNrTonVZKIsggFjPfyNoAWYy3J0dweaTPCHFboY2F3JNK
         JGuLn2Q5AZmRN+LGs5qb2XAqk/5Kp1025hdj05a/jI77Od/zkMiIx15DdiU68sYoTeLc
         IU1g==
X-Forwarded-Encrypted: i=1; AJvYcCV3E1yEDkEKfiicWOARWmp6HmihXXh3xeqKzoAUm+gFU+kNShBMzQDllbiOdiBN0gH9ydTJnDUd2CRS8UY=@vger.kernel.org, AJvYcCX2ROa3Ds51mbcPcQPnaPgn/yFj/2LEAoA5tyocKGbnVTLp14f9aJg6nI0HQNjkc7mZ7+0LCSM/oXkXJks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtjr1XBRVj7LCB9QGXm8I6lS8NDFujEvnv+9zWiPBaPOFWpfC2
	b1gwjfrFFF6igxrVwpw1qXMm2VPGWP3xuTqg+qhyX/ZDirZ4ANh5x5+w
X-Gm-Gg: ASbGncs1Gd2ZJ+Q9xr5uBW+MFOYmzPqxkv3t+wQ1O6SoJR0MQp/sR41SH8sFl0xsV6r
	VKW9zTNymMcjGkvB8TjauFqwIXnmT5ahjdoOizxp1kgHJimSMOZkvP8f5x3BBd3Uik3VuopBsfB
	sr7jnjBP3u3jfL62zb4xzQkn7KdwXbqne0i967WbapRpQwV7scyPRRpZYBjqXlEMcM5/pKjUQgc
	tw0g1m+aN4AKpswaryDAdlFpyctrpRxV2oLmKmD/hCqsrYFSh/XTMy51TBmBVvPHM7pIKie3fjV
	ClgoTK7h5uIaafxgMgs/KPz/YJJ4D67bB74WugJ3Eh/qG2u0ia/txdaaI+Zys6Xg4HLnNQxV1Ky
	FM0DUPUj1cvFs9el2bmbx
X-Google-Smtp-Source: AGHT+IGLLe+eOuKvhLSIqXjI0iH/E5Ia9hi1Fv7y0huL5PeDBqPu1gIF7clOX+O3F81I3nF3opjDnQ==
X-Received: by 2002:a05:600c:1c1f:b0:45b:89ac:b80c with SMTP id 5b1f17b1804b1-45b8d50b914mr44569235e9.18.1756801980813;
        Tue, 02 Sep 2025 01:33:00 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b8a980011sm58789295e9.0.2025.09.02.01.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:33:00 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: SOF: ipc4-topology: Fix a less than zero check on a u32
Date: Tue,  2 Sep 2025 09:32:13 +0100
Message-ID: <20250902083213.2620124-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the error check from the call to sof_ipc4_get_sample_type
is always false because a u32 variable out_ref_type is being used
to perform the less than zero check. Fix this by using the int
variable ret to perform the check.

Fixes: c04c2e829649 ("ASoC: SOF: ipc4-topology: Add support for 8-bit formats")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/sof/ipc4-topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index f5e62cd8fc0c..b6a732d0adb4 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2191,9 +2191,10 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 	case snd_soc_dapm_dai_in:
 		out_ref_rate = params_rate(fe_params);
 		out_ref_channels = params_channels(fe_params);
-		out_ref_type = sof_ipc4_get_sample_type(sdev, fe_params);
-		if (out_ref_type < 0)
-			return out_ref_type;
+		ret = sof_ipc4_get_sample_type(sdev, fe_params);
+		if (ret < 0)
+			return ret;
+		out_ref_type = (u32)ret;
 
 		if (!single_output_bitdepth) {
 			out_ref_valid_bits = sof_ipc4_get_valid_bits(sdev, fe_params);
-- 
2.51.0


