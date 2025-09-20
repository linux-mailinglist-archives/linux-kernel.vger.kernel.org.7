Return-Path: <linux-kernel+bounces-825606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E3CB8C4F9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B30560654
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1762C237E;
	Sat, 20 Sep 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiMnKUaa"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291F1EF39F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361578; cv=none; b=gLFVTf44M/kGxQdvhao27f8vJz2PKJ4iSfZsW12X92fbmNjm8wUDfQgsPnfdNnZZjXbVtAYvuYs9ZoUBIVxMh0ltwq3WG1mBcI0NweDudNEWN5Cc2qrf+G/2o9jLitOSPo7Qm+soySy2Mge4/zZmKXd209EEn3GvDjJ1H2Xbh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361578; c=relaxed/simple;
	bh=OW+MnXa0R4m/3x+py76mGOwd781zEHIbSyD1URElK50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KyQBkH6BdNuxN94Ipvrtw2RumnJpVYj8Y+hQS4/Gue5z20fke4XO+ryfavHU827oStxYyMPaewGMN6D2+6nB0Pn9xHXqnmIaxGZbFG/QdAXzyHx25h7nzHjQQN5dtMKxwnKG4etUCCJ535BpWdlRJbc4wlToqTXQbx2kTT2vZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiMnKUaa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so19254895e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758361575; x=1758966375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXym3wsq/PuCHeEIYBZQWPcAIhSSAARk/vWWcaHNabQ=;
        b=ZiMnKUaahIZfUpdX5FvbfIbEgWZVPO1FN0GFLA0dNF+fm5/AkSM/dqCrivbWNF5M6r
         8533mcFN015kCrE1Y/gcygCfCwCQzb40U1kRf8zcwWCtpZnhbtaPAibvsIU6+/6klTZz
         F8mulNfOABlo21uAVcgl+eY/f7YyJnWy6o+WD43yWRp0dW/ABgZy2cjJ7tcxTiD8LEBB
         BXhVjtByt6I1e+vI8/X2Vwv7fY+Nd8vS2XwKlbg3ZBsA1FAwDMX5uCCUkyPEdX5lgY08
         TyWzF1gAEFCG4RQzhbkk88APmF0Xal2rZWD84WSuyyGsGJ2mBPkNsA0wOdjeYpu1LGJn
         t2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758361575; x=1758966375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXym3wsq/PuCHeEIYBZQWPcAIhSSAARk/vWWcaHNabQ=;
        b=g0SD5fUP0n1E+25TIl63g4+F6ofc2/jRE2CyXOXo0+Z7Cwfaj2Zx2zMwA/qQ1yTz7q
         CwHz+dmnaLqZ2AdFLNeaxr6tFvKSF3nuac88wIHVLpVH0D7rPRPM/fezSqAkeTJvG7k/
         8dqW5C25QTOT40NhD5La/N4NbrGhZeJcPpbybpD33ixb4RzJSWYf9VOX2juYVBF+eQUg
         i6YYpdflKFPImCZM56XK1eb9NDuVPKWZZy8u5NBU9eN0mGeDpFvuuSSQdgyAd8ig8w5U
         ze5Xu7WlguOcfrbtzQv1FvU8aqWT7xV4yemx3RIDuUjFappyJVSL0aqdf3DK+TlDFETf
         xUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp+i0qYP4L4Ktl0NgziUbxS5kdqaKgE0m7s0UpII7SpO1uNtmC4rnIgUBRKArlyIHYEzB8jXtHR7Mtcj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypRaK72yKZu+VVpS993ePyVgbQAzgBLmRlrurdlVAw6fdNfD0v
	+TGl4FUkmKuzrRATyTys6r5NX5UtrStxF6sd2D46FM2ElVw/m/bzmHp8
X-Gm-Gg: ASbGncuqalqxcIBnH8rez9f56QaAY5lWeQQ36DRgDV3WNqcsA6aqIgrxfJ4Dn6TSnoT
	krDX3yS9LLgEWybvyVRTnqeDrkPD3yyedOvdevwTkXf/ee8Y9gJIPdGU/FyXfgERBd+zLZYmFv9
	cToRf9RZ1QXYGW3m+Nqi7F5Th97YJlmtSC0LYpaSKWzdyYRYG9sla+pENr7KGqP86HbcFUQ90pS
	fZGh7bPbQEPH31h9Z2zX96oSMKUxminvN4MjFUfpdEplqNAXfcA6YtlX9JElQX40Vk5Nl0Tw0Cr
	dAIWVn4mqGSmF3//FcS6m53OoZuJpW/CP6BDBQH3qWVFcPYzxv3oERBBisgk9OOUVyUfMIQQDTy
	wMV6xVzMQujZ4F086HzFmRNqdr/7ZaJRD46w1Dt8VbsKOOdiViWt3KVdfLiwY1L8Sduc5PVT0KJ
	4=
X-Google-Smtp-Source: AGHT+IGJerg5bFIZpABIm0fuQUyqCHNKx7qMOFOYTZTKzKq9jBqbHCxsWXt3vY5pR3US6GOBn/QQ8w==
X-Received: by 2002:a05:600c:6305:b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-467e6b64cc2mr54816235e9.2.1758361574893;
        Sat, 20 Sep 2025 02:46:14 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm163883615e9.23.2025.09.20.02.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:46:14 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Sat, 20 Sep 2025 11:45:41 +0200
Subject: [PATCH v2 1/5] drm/solomon: Move calls to drm_gem_fb_end_cpu*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-improve-ssd130x-v2-1-77721e87ae08@gmail.com>
References: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
In-Reply-To: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
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

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index dd2006d51c7a2fc8501904565da806aa47333ad6..d98015d6d28505d028ee958831e3cefdb8a9c397 100644
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
+		goto out_drm_dev_exit;
+
 	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		dst_clip = plane_state->dst;
@@ -1245,6 +1230,9 @@ static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
 				     &shadow_plane_state->fmtcnv_state);
 	}
 
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
+out_drm_dev_exit:
 	drm_dev_exit(idx);
 }
 
@@ -1267,6 +1255,9 @@ static void ssd132x_primary_plane_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
+		goto out_drm_dev_exit;
+
 	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		dst_clip = plane_state->dst;
@@ -1280,6 +1271,9 @@ static void ssd132x_primary_plane_atomic_update(struct drm_plane *plane,
 				     &shadow_plane_state->fmtcnv_state);
 	}
 
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
+out_drm_dev_exit:
 	drm_dev_exit(idx);
 }
 
@@ -1301,6 +1295,9 @@ static void ssd133x_primary_plane_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
+		goto out_drm_dev_exit;
+
 	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		dst_clip = plane_state->dst;
@@ -1313,6 +1310,9 @@ static void ssd133x_primary_plane_atomic_update(struct drm_plane *plane,
 				     &shadow_plane_state->fmtcnv_state);
 	}
 
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
+out_drm_dev_exit:
 	drm_dev_exit(idx);
 }
 

-- 
2.51.0


