Return-Path: <linux-kernel+bounces-885322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EABC32919
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7081818C284B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4180346FDE;
	Tue,  4 Nov 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMWUPJtG"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58893469EE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279835; cv=none; b=YRpTQmabMhx2m5D0/84m4fDSlPSDsUymryr8Q+NO6aJBm5mlVIxac5EoGCUclXkKSAWbJ1yRcuQ1v5Dv4g9ZnZDeHRJR98hnJbEaci6w3jEUkUpYO6Vj6vV0GBA8dteyxmlcWs/uZHDGo/cA4WGqPoxMlrlyCx9c4lMj6mksIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279835; c=relaxed/simple;
	bh=KowVKeJ70bqoIp+99jXhG6SP3UVn0OWkvuzyT/VB0wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfAflqrZerDsBmYGob3yOfDtNo7RE84KdMbPC1JMm6V8vn8Sb3ijqXku6UV7FKHrPCwwIlTQUIg+s9BztQLPIMFOPpIGTxChGt98htpjSASJMa8W4J9eRMY10Fphnr7HDOO/FTNBcPYmfSeqIqk5eyDowDyNIV92EvyL+/QtMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMWUPJtG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47117f92e32so47880385e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279831; x=1762884631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJ4iKgm80T4FXqrGlRaNuAcAySKRsjOyr7WXu8sKn/8=;
        b=KMWUPJtGciPNCShVBxdoTfrIGoRRCbUsQ9fpDYxvABQu/SXl/5SI6QBLx94zak7qxl
         UQPhPV5bHvKLQPhPNctl1rN+OvqMbYBQFtEV4y3GTUt6m3id67JYt/grjwJ/xNrj2SYz
         ZA+tsrVlQCSnOAVozqiuKrqF9HwE1D3JWIF837w6WMnqFer30j/GGRJJXJkk7aekXENF
         GHBMIda0Nd9zhtLZZcA7J+G3FQFPt/qPabE7n6PrSllwsGykniCt4RA+zJec+BZMTkNa
         a7+KQ1Haj69D7iiH+CNGjUK4scz3M9Rnv5axqj0poya742dPFKFUAtbGkBK+9TwQ6TyS
         DgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279831; x=1762884631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJ4iKgm80T4FXqrGlRaNuAcAySKRsjOyr7WXu8sKn/8=;
        b=wKSTiUvooOcYr+6nbt8ZX3O5/I5y5wtOtBJ9iulu6DVcl2pweeFdPEGWy88H6qVUXp
         7WEsYEtTVcpdOQKLd99Jg5eEghs4hE5ixeZ7m+C3WnzdFRN+ktHs03d/KGwQBcqNvZZC
         55hHIK4PXKtkxdbtRM1XYQCIQoFRAyiyn5AJM7ERoXtIHNKwxHgTeEq1GPwv3vbvHjhp
         NhIvoizrF0kESEpqS0ziPbQKXUfrSsc8jD4o+6TkFGnU4dJNOw7GZatR1qz5e1rT1xWd
         S5H8s//BVLfhYSfTudn8npND94MS3wnob8A3xBhgUJNMlJR0AXhDoUwQE4pzfM4P3T/E
         ztOg==
X-Forwarded-Encrypted: i=1; AJvYcCXIY0+0aq5kb00n76g6aXfcH4kbfgpw43k13Of9bmbjZMfGDU72x53NWCkHk423k1Gb0KMaQCZMt2gPYWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyGX1Ja09fyz/mwljJEeDDnOyzo53MUYJyiWMtx+9R1nLkKky
	ngajX3s4gKsgsVG//4JFClxkM/pKNn43uJX5MHfb9qnqQ7nxPVgBvVS9
X-Gm-Gg: ASbGncujefOwHs0oTEwALbm4VyV1zcSRcyDfjZCM7alzSL2wtA9Eg00P4ZFJhyvGthY
	qiGZBRY5b46RyjjYMDmRr/Uxi7TNP8gt7zXqoSlMuF11JOMg9R23RkxEemwlK6je7kNtcl45Jo9
	aOxV1+apNOLdU4tfN+vB3P1Q8f0Rfx2+Ebkm5rh9TBSx9kxJVwuh3HGFHwxnB581oyeMktnNP1V
	yi5J6A3XhL6RkdkpwVpatNKIUGcEQAPBs9MY2WWLSBD5/XIV/SRq5A4yQgtFUav0g+7PvsZTdxB
	SLn3GCTc1w2YvytcbBFQ2Ry9RXvoRsbLAVeRxTQgcIuBXPi0scxZStecYFVBtdKcaF6cflccU1P
	vMoOh0Ag73hwuYh0CAIhhaN8w2woOALYg/jjm6vFBcT3hk819RmqWDGSYQdawN5s/4CG6vNI4km
	/2ObFgtuayUghWV95nO39gwkTF5T0y
X-Google-Smtp-Source: AGHT+IHkpIC3aSMOHY0XvNH+UoXWk3HEri1Jf6ytHO5K5mDJ0+pJHIyqN7z61F+ww/rx9c/Kck19GA==
X-Received: by 2002:a05:600d:8381:b0:46e:376c:b1f0 with SMTP id 5b1f17b1804b1-4775ce9bc74mr1190495e9.7.1762279830853;
        Tue, 04 Nov 2025 10:10:30 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:30 -0800 (PST)
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
Subject: [PATCH v2 23/30] drm/sun4i: vi_scaler: Update DE33 base calculation
Date: Tue,  4 Nov 2025 19:09:35 +0100
Message-ID: <20251104180942.61538-24-jernej.skrabec@gmail.com>
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

Now that channel base calculation is straightforward, let's update VI
scaler base calculation to be simpler. At the same time, also introduce
macro to avoid magic numbers.

Note, reason why current magic value and new macro value isn't the same
is because sun8i_channel_base() already introduces offset to channel
registers. Previous value is just the difference to VI scaler registers.
However, new code calculates scaler base from channel base. This is also
easier to understand when looking into BSP driver. Macro value can be
easily found whereas old diff value was not.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 3 ++-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
index 0e308feb492a..fe0bb1de6f08 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
@@ -836,7 +836,8 @@ static const u32 bicubic4coefftab32[480] = {
 static u32 sun8i_vi_scaler_base(struct sun8i_mixer *mixer, int channel)
 {
 	if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
-		return sun8i_channel_base(mixer, channel) + 0x3000;
+		return DE33_VI_SCALER_UNIT_BASE +
+		       DE33_CH_SIZE * channel;
 	else if (mixer->cfg->de_type == SUN8I_MIXER_DE3)
 		return DE3_VI_SCALER_UNIT_BASE +
 		       DE3_VI_SCALER_UNIT_SIZE * channel;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
index 73eecc4d1b1d..245fe2f431c3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
@@ -18,6 +18,8 @@
 #define DE3_VI_SCALER_UNIT_BASE 0x20000
 #define DE3_VI_SCALER_UNIT_SIZE 0x08000
 
+#define DE33_VI_SCALER_UNIT_BASE 0x4000
+
 /* this two macros assumes 16 fractional bits which is standard in DRM */
 #define SUN8I_VI_SCALER_SCALE_MIN		1
 #define SUN8I_VI_SCALER_SCALE_MAX		((1UL << 20) - 1)
-- 
2.51.2


