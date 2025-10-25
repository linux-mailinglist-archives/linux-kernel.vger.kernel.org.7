Return-Path: <linux-kernel+bounces-870049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B00C09D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3E458185D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E5030BBAB;
	Sat, 25 Oct 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfH+o0wb"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D363093C1
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410441; cv=none; b=AIS2cj1+a+UiJ8/OXmCXrts6XJbdOMWxyGwkCJMY+orLpG2jDDRDUwd1s1gCUcLX9e/cjPTc2dFZdrwUo1dCSImOqZWOZ06MITZXVJy9NKPrHs2GaBnGv2Lb1COSAVUEiYEdHahPV+G53MVdmGEK/DLqF80q2lRFpNjHTmSBRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410441; c=relaxed/simple;
	bh=r1ZSvL7GYSBh/Cee0SXgYuJ/pWOJXGQu2D5xFAme0AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JE+pcFrVl9llE4dRZs2FFLOp2T24pQBlpXRPzWDPrP7EDA1pgLkh3iKkkXR+bgu4FxkGjGFM/whGpzr19t1+6jsOmCUSNfJ7wtx2f3HmjlrvzBLTy69ENt7FslJVux8YJ5rQ/XiaE5C5IDlAzyPVbd/93Rlfj8dsTRrORDGeha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfH+o0wb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78ea15d3489so27625676d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410437; x=1762015237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxeCOI9icR7/UFiwtRNvJHOt4NesbHGx93HWxIm5tv4=;
        b=lfH+o0wbFcKnBcLqetfiVUhdNCb9XnBsKZwY96o9jLcYUsu493Ya44FsdUrZJ1e4+l
         bxVxm7ju/wDa57wp8hlaUJwWjKKSqAGX0ku0X4bRBgvzPWQ1PEe7Q1PWXSNUFtMw5y90
         ITtndAEnv7SKqIvSwpYPBK7WjDmq+9uWz9YaIfLPLmRr8VmG0pvRGJTBR4ZqX/Ey4gyJ
         KSe2BZmWUqlJS6Fa8RfxdzWg2EbVs6ZvzaQZklU5eNdXSq4oXuW3Iw9imMJe8ydwgGqE
         mmoDcAP/2gx2O7e3Tvyjfr+mAFwqCNCC79zE3tDMYt9piFsZLCeNUVAPEPcCbK9Ky1iQ
         rzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410437; x=1762015237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxeCOI9icR7/UFiwtRNvJHOt4NesbHGx93HWxIm5tv4=;
        b=QibPr679R2oqAPCMxYXCCojRQAXu9IwH74/z8SubDA36jHFSXl5sCaMBctuFtvQskL
         EWYK3MKcg88YGGJdDX54agScKALj4Tvx0TrukMvYEap+cB1I0eA9CXDkusOEFmtHAl67
         XAcNquKEJcOwLkTMsQ/q0R+ggWC0PWf3ZWZJns8qY3nHA7ISeQphQCKj3E6kLNcQoXSy
         P4BRNdfnP69rxz+32syQrqGt7iKFMoCOVLuVsn+3Yjd9YOgxElLwtm9rzXwfglAqiGNU
         PE5lNHoYJB4K9CdK631SIIeDSocCm+JazVa5RXFmgz2lq3iOAsdkP5QfAIfWNXv17S6m
         SIfA==
X-Forwarded-Encrypted: i=1; AJvYcCWvOimAIzz2LT2Vn1azmV/G2aDHK6fo08SCQ5lH6ZnGqV8YUuih8Oiqb/X6kMPWHRPNXjOEHRvlXYENwow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDSuikkadVzkEfYlql/pXe8nKT78I+NWR7p3hsWNzA0I3iNJt
	MDGbYfzZTK7u4bd7cKyxXIWJwXDMm8CaLei0zODbBzuixRkUIJddh6Gw
X-Gm-Gg: ASbGncujkOIuYJiYO08M9al5CgX/dj34VbZGaZNzcmQJJht+xowCFosWhWRP9YeVgxi
	XRiAwnoyt6czd3rxBKbj0DHUXtHVwvxNoKASfHJQShgurLvz5azoO+1RYYMxkdhnmYk93+ucMl3
	KtpLySpR1+2Dv65BMceMMLClNq94zAtrK6pqlc8eaZPhMS2WrtHSnqykTmVk1uHPSxAVlq8ICJz
	vSKKVxaqv/JIJxxUGvz9eU5ye0vEEweUhkhyCSC8wDnBoHjd967B6ghe/m5i6x5fIFQ2eMegnMc
	fa0Xz+OoOUr5fTNGBXNZ6WprDYwktiWUfbwveFHWGULNPj11qNkloAwl9gnxAZnrlSMWBZpgI9s
	/C9md9aUFxgTCpzrH1Y7VdvVdomSAV1SnPcDUj2GOGzaVFRXiMxKSUjkEeF240/Jour1hAdUN
X-Google-Smtp-Source: AGHT+IGA1DGszT7xZjIANsU8O6rvui0sqJn95mFqcuxChrfDbaomUSTYNAUrPgKr6w9KBJpYTpgUWA==
X-Received: by 2002:a05:6214:808f:b0:87c:2275:4bf5 with SMTP id 6a1803df08f44-87c22754bfdmr400398756d6.28.1761410437167;
        Sat, 25 Oct 2025 09:40:37 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc4944a84sm16377846d6.36.2025.10.25.09.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:36 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 04/21] ALSA: rename BITS to R_BITS
Date: Sat, 25 Oct 2025 12:40:03 -0400
Message-ID: <20251025164023.308884-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding generic BITS() macro, rename the local one.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 sound/core/oss/rate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/oss/rate.c b/sound/core/oss/rate.c
index b56eeda5e30e..90a40221e4ce 100644
--- a/sound/core/oss/rate.c
+++ b/sound/core/oss/rate.c
@@ -25,8 +25,8 @@
 #include "pcm_plugin.h"
 
 #define SHIFT	11
-#define BITS	(1<<SHIFT)
-#define R_MASK	(BITS-1)
+#define R_BITS	(1<<SHIFT)
+#define R_MASK	(R_BITS-1)
 
 /*
  *  Basic rate conversion plugin
@@ -104,7 +104,7 @@ static void resample_expand(struct snd_pcm_plugin *plugin,
 					src += src_step;
 				}
 			}
-			val = S1 + ((S2 - S1) * (signed int)pos) / BITS;
+			val = S1 + ((S2 - S1) * (signed int)pos) / R_BITS;
 			if (val < -32768)
 				val = -32768;
 			else if (val > 32767)
@@ -162,7 +162,7 @@ static void resample_shrink(struct snd_pcm_plugin *plugin,
 			}
 			if (pos & ~R_MASK) {
 				pos &= R_MASK;
-				val = S1 + ((S2 - S1) * (signed int)pos) / BITS;
+				val = S1 + ((S2 - S1) * (signed int)pos) / R_BITS;
 				if (val < -32768)
 					val = -32768;
 				else if (val > 32767)
@@ -191,7 +191,7 @@ static snd_pcm_sframes_t rate_src_frames(struct snd_pcm_plugin *plugin, snd_pcm_
 		return 0;
 	data = (struct rate_priv *)plugin->extra_data;
 	if (plugin->src_format.rate < plugin->dst_format.rate) {
-		res = (((frames * data->pitch) + (BITS/2)) >> SHIFT);
+		res = (((frames * data->pitch) + (R_BITS/2)) >> SHIFT);
 	} else {
 		res = DIV_ROUND_CLOSEST(frames << SHIFT, data->pitch);
 	}
@@ -226,7 +226,7 @@ static snd_pcm_sframes_t rate_dst_frames(struct snd_pcm_plugin *plugin, snd_pcm_
 	if (plugin->src_format.rate < plugin->dst_format.rate) {
 		res = DIV_ROUND_CLOSEST(frames << SHIFT, data->pitch);
 	} else {
-		res = (((frames * data->pitch) + (BITS/2)) >> SHIFT);
+		res = (((frames * data->pitch) + (R_BITS/2)) >> SHIFT);
 	}
 	if (data->old_dst_frames > 0) {
 		snd_pcm_sframes_t frames1 = frames, res1 = data->old_src_frames;
-- 
2.43.0


