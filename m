Return-Path: <linux-kernel+bounces-814502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE3B554D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E71D1CC31D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C4231D737;
	Fri, 12 Sep 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlnTmPrC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAF531B126
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695365; cv=none; b=E522SbWqbtSXiLUFYhLN4kZ6heuVc068hjKgYs+6coREJoAF3BtEl2I7etOzn7MszzePMZo4E3lDuK0Xg05JpwXw+vRxS1Ku2VIhGOwtrw7ERr/0mIyWdL8y/FurtdyCkb2GEqdY+xdYxqhQZkGuEyCOEEtjtibmZ9EgK5cYsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695365; c=relaxed/simple;
	bh=tzsN7qKm6dUmRDagLQir/qm3kiDTLaHsDU+/1R/XgkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=faHVkcyij/s9ZPXp68KZRY8r7lwJkEUCFnlcVqStEAdQ87sR3MrBkhknW6ww/qbniI5W+SjkMu7I+S+c4gZ7AVcxCOPZ1P/xgMBaxDbZIPnhQqMEANMDlRCYHqJsvikI1DzM5MV6tYFSTMdgl40Ug29Do/G8IEeWss9gZZEI5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlnTmPrC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so19948835e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757695362; x=1758300162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoeciE1g87M9Qxg6df56vLYD1QTe3IoOL1+JcFYtWuk=;
        b=dlnTmPrCmZgpYzUwfna9MgeYFNSaYhRelcrXb8jLe4JeUUoYbjG+u4xEVX5MQ7GArW
         dorxuWQPBI/ZoLHr9Vj5snOfrmZTGTgq2cZycR5LoG6HsChAGhguCuAYtEwic7qYIXaF
         lX6h4Q088zAHYTxDZ3gSbWh3xZihtQ+3NfKX288hacx8TWqaAifEbtHAA+ChU9XdqHbP
         U4HZ04EQPsCTvZICuAj31YdstbEBIz2iGgRRzJi+pQNf6+3y5XJ1FwDrWGrO+XsrYnfT
         unyKxJKLKBemhAT8a+iKbyWwwqfGDjzEYRF4u3kW0/Q2mFuVUK5hndyA9PX1iqDfh77W
         UX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757695362; x=1758300162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoeciE1g87M9Qxg6df56vLYD1QTe3IoOL1+JcFYtWuk=;
        b=uwa37K3Bo7Gr08IMocI9+PyI7g5/iRq6ON0mt3+/jPaZH/z5WoDuUyDgN973oInOgW
         hONmYWD/eEHWR28I2YbWYngT5bzjM+ebiAS9TM1ukL1jsTQdijCOasz94rxsqbqhIdTc
         IA+4mLZdgQCZMrJT8kwhoW3vfw0q5lFTxa7cNNJcpnDvogoOZArsu+e5dMGCdpvlGrtH
         zJFZs0BXUXJ1BCZXTSwMNfX4sr/p6wZ6GgVlnK2COYpx+CHDyjWKkUyijjQuWJ/FOPmi
         4fx+Q2qKWX4BGjpD6/3zpU42i003Mmdxl6WjrxeroNDoNanxlaStakqOXJS7vGqTlj0E
         eYwg==
X-Forwarded-Encrypted: i=1; AJvYcCVoJefSlDtMHgII68MSD66T8zF3JDfrWR+lTuLz/i8T2a/tpxeOH9RY0MZ2WmPG7Men793APNQAgvmBmow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzYtxMDY21PJsG8rWwkBVpgnsntSKkq521fXPAvT4jro5yfTO1
	uPmIrMqdZBEGiZBVnla/bWZrFx3+5PBm1RkbEuS763rDKd6mYhaQRqD0
X-Gm-Gg: ASbGncvv76gO1S+AIA3Qi+u7YW9Yqxchbs8LFsGsZKPvep6FQM3gNeW8A4ZbgJcQjal
	Q+81HfQXDJHJXXi+5HTHOPFkllxPYz91Jd9jWTwoLRCnsIRjVZRYo9dO1D5UncSWNICYwphIKuO
	B6FXuDoM6zXBDBJXwu2s3lzq/OB8zcThMbu2XOKSXIXoyaWNV0JZgLwb7BBf4QZ7cu7UPiqYUQS
	VzKOrio7OR8OUPBErZNJFrvVztfToBU1fNnCmxFxNmJ30vsp9qDLRJi2ZYOaAlkojymnYupxFQp
	DbF2DUuXojOpUs6kJ3iHmvqQuy9QNNoh2SamSQ33Owk0XhHERsn3p4zI65IwRa3XfbcUqFJui6X
	sg9fO1H+A3Vef3uD/Ucq4U4j14RebW6YIwJHoIrzPjafuLvzejby5msorkM8AgIBx2m4zgP+rT2
	Y=
X-Google-Smtp-Source: AGHT+IHuJSFr0dqtOsT5NPWoHGSkNkCmgSeBnBH2v+uNiFiipuyD5CsBrYBuPM84MejkBy847xlygg==
X-Received: by 2002:a05:600c:55c6:b0:45d:e0d8:a0aa with SMTP id 5b1f17b1804b1-45f211fa411mr30126825e9.17.1757695362172;
        Fri, 12 Sep 2025 09:42:42 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.138.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm7086696f8f.30.2025.09.12.09.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:42:41 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 12 Sep 2025 18:42:09 +0200
Subject: [PATCH 1/5] drm/solomon: Move calls to drm_gem_fb_end_cpu*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-improve-ssd130x-v1-1-bc9389ed299e@gmail.com>
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
In-Reply-To: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

Calls to drm_gem_fb_end_cpu*() should be between the calls to
drm_dev*(), and not hidden inside some other function. This way the
critical section code is visible at a glance, keeping it short and
improving maintainability.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index dd2006d51c7a2fc8501904565da806aa47333ad6..297593c7fd20a5a5da81f1e1fcfda9092b19cf90 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1016,15 +1016,9 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb,
 
 	dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
 
-	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
-	if (ret)
-		return ret;
-
 	iosys_map_set_vaddr(&dst, buf);
 	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
 
-	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
-
 	ssd130x_update_rect(ssd130x, rect, buf, data_array);
 
 	return ret;
@@ -1048,15 +1042,9 @@ static int ssd132x_fb_blit_rect(struct drm_framebuffer *fb,
 
 	dst_pitch = drm_rect_width(rect);
 
-	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
-	if (ret)
-		return ret;
-
 	iosys_map_set_vaddr(&dst, buf);
 	drm_fb_xrgb8888_to_gray8(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
 
-	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
-
 	ssd132x_update_rect(ssd130x, rect, buf, data_array);
 
 	return ret;
@@ -1078,15 +1066,9 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 
 	dst_pitch = drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
 
-	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
-	if (ret)
-		return ret;
-
 	iosys_map_set_vaddr(&dst, data_array);
 	drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
 
-	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
-
 	ssd133x_update_rect(ssd130x, rect, data_array, dst_pitch);
 
 	return ret;
@@ -1232,6 +1214,9 @@ static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
+		return;
+
 	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		dst_clip = plane_state->dst;
@@ -1245,6 +1230,8 @@ static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
 				     &shadow_plane_state->fmtcnv_state);
 	}
 
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
 	drm_dev_exit(idx);
 }
 
@@ -1267,6 +1254,9 @@ static void ssd132x_primary_plane_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
+		return;
+
 	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		dst_clip = plane_state->dst;
@@ -1280,6 +1270,8 @@ static void ssd132x_primary_plane_atomic_update(struct drm_plane *plane,
 				     &shadow_plane_state->fmtcnv_state);
 	}
 
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
 	drm_dev_exit(idx);
 }
 
@@ -1301,6 +1293,9 @@ static void ssd133x_primary_plane_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
+		return;
+
 	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		dst_clip = plane_state->dst;
@@ -1313,6 +1308,8 @@ static void ssd133x_primary_plane_atomic_update(struct drm_plane *plane,
 				     &shadow_plane_state->fmtcnv_state);
 	}
 
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
 	drm_dev_exit(idx);
 }
 

-- 
2.51.0


