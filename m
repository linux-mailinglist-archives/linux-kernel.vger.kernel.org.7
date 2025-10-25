Return-Path: <linux-kernel+bounces-870022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB919C09BFC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CDD4248E9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B3532548D;
	Sat, 25 Oct 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGIt3x7h"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E57324B2E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409754; cv=none; b=RNtVpaviK7bbufF2nKaPg+WPP8v1fs7z7Elhqd6FrM8fL13cwtsVWTRmeIJ7/xPgs79BEwFXFBpstNpUEmi6be1C+w7VthMDsuX1hk1PxzMSILXDQ5iXaWibcnH2pCVc4ofCUdmeU19ydAQzGdjbhL5Ib5YlkrSOPfaVarm5FWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409754; c=relaxed/simple;
	bh=r1ZSvL7GYSBh/Cee0SXgYuJ/pWOJXGQu2D5xFAme0AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OH8U4Ker5S0zx7Anh3a4Pfmv7VEcCkysu3D9+PmKqJ10HUelDMx5KaxqtL6+kim4cGq7JEE5hHHfODi0jd7hkrjtknJroWyM7BSJ7DzK+X0MmZW286qWjm9Jo1FPBwR0S952EHPm+qEo/NbefW5SA1ppjWfJ8/BtZ53IRhnUGiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGIt3x7h; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e8850b09eeso31811741cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761409751; x=1762014551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxeCOI9icR7/UFiwtRNvJHOt4NesbHGx93HWxIm5tv4=;
        b=CGIt3x7hQWmYFABG6jUfTFmtphR0f6nf6bDA5fcyMyUX0XToDHYKQdphpuOhaMgZh9
         62kNPNvK7LStwr9lmNBGJY1/+K3QtLYxaHyw6gPG7kUP8LOo2NQTu3Do9+mqlzMcztQ5
         FpiHgsu2oErrMzvo6Kggd0XCPkx02VxKQjjz6b8y2aTEjwjNEOpPpr2aBdxkviQk5467
         8LiPAezz8CxjQ3MKcFnVU4j28x8GvWbxLUJLUEROWpnJbzm0LKmg+QjzPlyQqdSP+1lS
         VMQX9ZeH4+Yb3Plqwg5kZP6oYSGwxgBqPnDWxb+8hKccUo8me3L1Fc6wzE6gq3MCeEET
         2oyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409751; x=1762014551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxeCOI9icR7/UFiwtRNvJHOt4NesbHGx93HWxIm5tv4=;
        b=GK44j0aj4/rC2ZU4jHbRgyT6YLguuLux+Xu1DIXT9hgdIBB+iQ6qYqwvNSlD8dLmzu
         bMIjNuztWZWw33AmqMp9OMplSh+dQJHp/H7DenmoVqppziq8aKv/XqY1gXRUVYiFWSud
         8NScZtdOshUtBWaUzR22z/Jp4aRkMmOdXavu+eFT9w3hwI7TsdA/UlTwZ+C+Nlh5D1I3
         tUb9knU0C5qUaMYNmheEXsmEothdJVzJ3sBenudfJn744rnSz7fCfV8SuBmZyD5O4klj
         +hj+rwlQFXOacMDszVqlStIKVm3FCwcC5n9vtg5GLObDrJdrL3jjInVoGLcd+l5r5uTG
         WFQw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ70WUBfBEmrfpodiw0G6CKWBWUgx5u7RY2m82iAwskITfIlyCwfJWbrV4tXqbUsxV5oqhoNxWf6FySnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoRopA7ecTlZREMPW/qbyJzvcslWIbHzXxQ0k3eyfrmmnovjO
	E4lg1OnPhNp0HyIieAvQAX/Kc6Co4HCIirnxnN4dkgn2Nb7dk25RypzV
X-Gm-Gg: ASbGncu2FtCCco6ldejo+xx/BakjTQeoBX+J3KJrrR9OmldFLOA9tdN3AOQrkEPt8JZ
	wB8Ue/MYOUaiXZ6u10PuFLkK/3HohC3bhMoIpNii4zvp74wWlImkjw6CPsJ/Kc1oMnZa68fKEHJ
	vq0y9QuAvObyN5K+B2vNEJ4hlWbxpKmh6IhbDgesDLlqfNoxtsB3QLmIV296jmBVDBjDvJo44fR
	mDin0FmTi75DGt45tpE2Bj0FfCoK6x4x8/83duJdpdHJ3cqsPzHL2SeL1kBGSmx0FbkW+CWqRIz
	ZDFMKF0Q18JxCOVcK28xzjOZYemJyd8GhPl4QT8Dfjw+pjx01yjbqkoEAE/z+u2hQ5QNox4YCzx
	Yx8p9t/Nk3ji4CPSam5BZbP7qm/zwvq67e0GSTQkzNiBrurFK+UvN2oT+zmWqMERWn1Y3dQEX
X-Google-Smtp-Source: AGHT+IHE/cxtBB92jOlmZMcoUVK7+rMqdx2Thi4RMGOFfo0VELRSYvXVDUaBSTA5+Nf8oaPoFuNrpA==
X-Received: by 2002:ac8:57c3:0:b0:4e8:a7d6:bc07 with SMTP id d75a77b69052e-4e8a7d6c0d8mr369172781cf.71.1761409751421;
        Sat, 25 Oct 2025 09:29:11 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba387fdb2sm14761791cf.37.2025.10.25.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:29:10 -0700 (PDT)
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
Date: Sat, 25 Oct 2025 12:28:40 -0400
Message-ID: <20251025162858.305236-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
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


