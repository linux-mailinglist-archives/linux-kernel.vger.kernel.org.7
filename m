Return-Path: <linux-kernel+bounces-885328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC74C3292E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDE318C1BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDEF348474;
	Tue,  4 Nov 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T60ewGmB"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33034846B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279842; cv=none; b=rAGH1pKVKJ+PhBBkxCrG3uQQ4TOdhK+OfuD3z7ceyAuuIdLeTXn7NWc+eGOxsw1C74/JSbKaOLjAlcgf6PLEx8khc7/mchHrB0268CgV8R13aHmCQFj2y7ECSZXh9z1l5gkG5VsLYnuBqS1KEaD+JyfmLlN5ARxXeiGWHNEw6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279842; c=relaxed/simple;
	bh=tn52gI++VV08p/JOXLBb4YMr7yaoLYJuCkLmlVFTHEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cS2kVDXAc95J9NCDcybINwoKgDFROF4wk9zhpG3DhM3h9RgkSEkbcprqi+W4J0UU3GFyq7UI2HyNt2WBzgSXmD+Kf5J/fj7014maxAPnhArVgeLfJCYPqdox2Jguf0wRICPVsBlU+E/3ZbssG5A5Bbr9xFJGlXnVKK6F7KZDlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T60ewGmB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47754b9b050so8945225e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279838; x=1762884638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdGrKH1QE0kG7REtfLe4gBCoW5I7PDPHN1PH2jaotk0=;
        b=T60ewGmBPXgnKDhDxR8qh4upYX1Z1BqYibR7mMjwABgIZIdiVjjdffyz8VE69GqPam
         NIT3bykJLTl519CgW67Pwk7MYOOWiE46vNgZn5GJAAgeCw/n/5MBe8qAZwJZxN4YJyx8
         wnXlqLGiqdXxbp1FOEBcaLpTFBC2e5z1tFBhr5bZYVxVw8pIN/kxAFAhhkYksCHZ3MUN
         OClnHRPFZ8/LlZw53+GTUKGK85eJUHgiwEYnoLZ3oChfrqgtJsjyj+V7Bf46pJBwX3IL
         y7k9rw5GmTGNGsfnCKfw+U8qv8yCV66tyxmo/AB4TeDgxr2XRQeToRTGGTiJ8V639ilq
         iRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279838; x=1762884638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdGrKH1QE0kG7REtfLe4gBCoW5I7PDPHN1PH2jaotk0=;
        b=FBuaf4Hx8tYDhNDuuEp84O+nkZW5cgWmjsHQXlgDK6yaZ9sFG85aSgkQ9oAKBp/3a+
         zDe+xOljyTB/eF/IeJOyHEFECOqVVdbddIeZjPg6xFaHW9HmxyitOPJ6tCM2Vf6BNvbt
         GwvnDU9bhHGm3pr0jG2cGthgyHjZ7Qtun8jdzL1spOQtoAs+/diRff8qANeS/PFxve6C
         8B+47V5b8om2ToW3bCFeZ/4Cq8zMeNCyWu9XLslNwUzFn3IYzudJ3/qa840AjgjIQgYB
         +6PHV0PEJ52UlV04Ia35hwqcy3jW10M6p7ZLXEtJNszHl83b8ym2iRdE59GoYLJEvDvP
         W9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU35TX0X30FmTXnoXqWGncbcXzDdsGuMra/XkAppzdpNlluTQtF4VbUmxWaj28pb0qJBsgxhzhwD0B/FRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsoVInJnA6+ea4myrUAtK6rlpYzvtZxtHScb13TzoUTL8VXD1
	Pcj1sVgbuXh3F8vgf6fiKMM2vxpsN8wffbhcaP8j0jSsxGXKtliB15uk
X-Gm-Gg: ASbGnct3HDEJwvihk1dv2ouJhnGp324ccwY0BWpCYwL0TLEUA6upmhhDVUKcANOt00N
	6u4dLmZlgWAjSokpcKI3wWV1LXyuv6L9YPjVEornClEWa8nIoCdmUO1YsaDu99YUM4aSDdHzTg6
	7iP0nkW1YDlhQneYmvZwY+vwv6yt0Xh8HYjiLQRWM/fkVqRcg2qlB+VVb32PHc8hx7v+K4JNOMu
	zf0R2LToOWNoi7ZPXRrqvqJ3tyqnPuZgtQGxtgK/3Kclkntn3h9Ew/q61NBAKxjj7YQqFP5Nwvi
	jnWrYZbCkYcoJ4Q0IxKCabHNRN6OdJIaDGbPpHAcqaORCQNQ5GyooNmi7wafog+NZ261ltIEx1Y
	uKqa3UgXyWfZy1X0odm+MKrChNnQ36whUHh/45t/sj72CZMvOuyyhuYlhuR9do49yjwEduThs93
	RTHuSV3etPf+vwYHtW1w==
X-Google-Smtp-Source: AGHT+IE6YV6xR2I6/+NCWHLkg0DglaeA9v7PSL0SkiyT31i7Bh4LMca9EcGx6brDtSF2nS0sWtPQUg==
X-Received: by 2002:a05:600c:620d:b0:475:f16b:bcbf with SMTP id 5b1f17b1804b1-4775cdc148dmr2023655e9.14.1762279838428;
        Tue, 04 Nov 2025 10:10:38 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:38 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v2 29/30] drm/sun4i: vi_scaler: Find mixer from crtc
Date: Tue,  4 Nov 2025 19:09:41 +0100
Message-ID: <20251104180942.61538-30-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104180942.61538-1-jernej.skrabec@gmail.com>
References: <20251104180942.61538-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With "floating" planes in DE33, mixer can't be stored in layer structure
anymore. Find mixer using currently bound crtc.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index afe38ea03beb..4534998af825 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -13,6 +13,7 @@
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_probe_helper.h>
 
+#include "sun4i_crtc.h"
 #include "sun8i_csc.h"
 #include "sun8i_mixer.h"
 #include "sun8i_vi_layer.h"
@@ -62,8 +63,9 @@ static void sun8i_vi_layer_update_coord(struct sun8i_layer *layer,
 					struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
+	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(state->crtc);
+	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(scrtc->engine);
 	const struct drm_format_info *format = state->fb->format;
-	struct sun8i_mixer *mixer = layer->mixer;
 	u32 src_w, src_h, dst_w, dst_h;
 	u32 outsize, insize;
 	u32 hphase, vphase;
-- 
2.51.2


