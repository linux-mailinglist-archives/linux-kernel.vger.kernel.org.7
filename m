Return-Path: <linux-kernel+bounces-825607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B19B8C4FC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EBA16EBA5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466202D6418;
	Sat, 20 Sep 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz5tN2ZX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BD25F79A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361579; cv=none; b=KCLTKjgrAToqROSzcoE1KXQYp0t4tHDG29oxDpHuXe6h4xYy6zqV2o9kMsRZmxA/p23NNIZA/nb2XKS4xz1yR9q2xjMrpuYw9Q92kMJt3mftGZrHQXS+HvvbCSH4P3IMyB5eQmUZLWsgmb7dZk2XuGKNh0bOR4dl3p7xk2v+RLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361579; c=relaxed/simple;
	bh=up28z80lKrs93YrJSZlMaJn/k+m5tGNC6mfTd6IU87I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uC0OmOmGghnvXTmTyrHGJMVDxBZ5qOKuUBxOvDfxv0GyAOYkDFx6EsToEfGLC10Ok0vlPTyl3wTot20dHE3400bQ3LKwVByfq6O+4YYRdNf/uW/v3SfVajUfd+wGFZk9QGkP/4X9pAv/3TpfrEh3e7LaY01Tx/oj7xjEhxKwkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz5tN2ZX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso24751955e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758361576; x=1758966376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF+gSsJWISD2P8ooQs9pGaRj/4NF9wqu5vW0k9j9UCk=;
        b=lz5tN2ZXsy7UiOJMY8CO3JMiBWY5V+Wnn6r98OTqWpnpYh1UxYQr2OE6jnk744LQuv
         iXCvtd1gj88j1Blcwl0vka1TKVGDRljFNeOZFzqEe4ef4pPro8/bHfaJYj9Iy2NRnsZz
         uGzaD3AY/f9VsAZfnAvVMERLjtepKWr/P5enCDhtTfdTZaRiy+7Uk4Sn7g6qFi1QUSL8
         SFQUO8mQ36mCpdmGT79MVsVVKD1DZ8hAMfs+sGIBdCi4j8FGWhatUXkg0qU6BjdhVirQ
         QasE6hjORg+Z230qd2CoO1IpEGKNdRjml1uOeQth7d8wo4gKbqmUVXg7owUOt4ljDhFB
         PUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758361576; x=1758966376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF+gSsJWISD2P8ooQs9pGaRj/4NF9wqu5vW0k9j9UCk=;
        b=l9S0uUcmY/Yh/V9SuvP77k07PIyIcl8+X6fPb3f7tfnFLpN+WqYt3xYzFXlAfAJXY3
         kUfo+DqSz5WcIf5ZUnEwSR3EWIWNfVGsG8IR6ccfYJ30KSi//JcpPJZM8QuvJBKWKBdA
         u7d7WUmrdUwTxs9/ztJn/2lTPfhokPp3ggqQBYZUqvaq6YQKrFB7FHxXBZlqasvevIM+
         iPTFQxq6vs+cZh27UShiP6wyQIsQ8Ap7NOng31BQAsGdwM0jOzcW/oUJBGIkVvOItvmm
         vXbC3cDrUJWV/bI8k855x6Pe88VCnKV0Hj+iCDmWSUzMl1Rif/o++w8rpgz6e6PsPeP/
         z1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr7wGqKz7f4lO5COW/Mb5XtC3lJKwa154caH5ryhEFdEWSDDg5tHhk8L2mXmAo9B/4IOlGr9/kiDCw/BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNj1naUR1KfTqr3s0829kk+cZlcgAJrmKlIY4VLHnqcUxF2zWj
	xFcF1YEJJUp/VbHGCchyUhq6QoPOclOgkig8dGeNGtcQ35uoqn9anyZ3
X-Gm-Gg: ASbGncvaPTzwm7pxcYgpB6xg9rVMi2ppFw7wLKhW7+QLSiNT4OvM4WStIPyJ4YcF+Qb
	y8sRSGVyRlfklbd0icsLJgt4a5cpwZttXbeEnenGpnO6AbpnIPSC/Kf6Jw9ytI4CB5aF5bFqB5d
	bpBjaFEJLWLl1f5DoMr7Ofrc2RQBKrgVOXI4GEAcCx88q+2wiS2gwDIpkgI5UQSFpk/hhsHlPvE
	hhVyZi35DGzpUnTqk3eIKgGBZl+9rmRJaYYGCdvkQEbgOmwFhyQ7QBBUTM3rF52X+vH2IPhJsE4
	M7F1q+P0kuU2yFy7R+YGOpZLb6pxyl/Gdyleg1AD9HwmuorJc5SIE6NDAadw17GLhBCP52EVlwO
	Mc4qFExPa38MUCOLJ7aEafFDpL7T1AL++m1IOc4vaw/lnFNbWKVi64okKGpryEbHc
X-Google-Smtp-Source: AGHT+IFHvcyMmLMyYmMr2Bg5+hEdpv00oyYEqCLBaf7aaHMkS1cxofawkp9K/qG+XWC9dmcPTHSP4w==
X-Received: by 2002:a05:600c:3b0e:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-467eb231110mr54511735e9.29.1758361575846;
        Sat, 20 Sep 2025 02:46:15 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm163883615e9.23.2025.09.20.02.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:46:15 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Sat, 20 Sep 2025 11:45:42 +0200
Subject: [PATCH v2 2/5] drm/solomon: Use drm_WARN_ON_ONCE instead of
 WARN_ON
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-improve-ssd130x-v2-2-77721e87ae08@gmail.com>
References: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
In-Reply-To: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

To prevent log spam, convert all instances to the DRM-specific
drm_WARN_ON_ONCE() macro. This ensures that a warning is emitted only
the first time the condition is met for a given device instance, which
is the desired behavior within the graphics subsystem.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index d98015d6d28505d028ee958831e3cefdb8a9c397..5b0d5bbc7f9fabd8430226e88cdee9e22ac7ad96 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1393,7 +1393,7 @@ static void ssd130x_primary_plane_reset(struct drm_plane *plane)
 {
 	struct ssd130x_plane_state *ssd130x_state;
 
-	WARN_ON(plane->state);
+	drm_WARN_ON_ONCE(plane->dev, plane->state);
 
 	ssd130x_state = kzalloc(sizeof(*ssd130x_state), GFP_KERNEL);
 	if (!ssd130x_state)
@@ -1408,7 +1408,7 @@ static struct drm_plane_state *ssd130x_primary_plane_duplicate_state(struct drm_
 	struct ssd130x_plane_state *old_ssd130x_state;
 	struct ssd130x_plane_state *ssd130x_state;
 
-	if (WARN_ON(!plane->state))
+	if (drm_WARN_ON_ONCE(plane->dev, !plane->state))
 		return NULL;
 
 	old_ssd130x_state = to_ssd130x_plane_state(plane->state);
@@ -1558,7 +1558,7 @@ static void ssd130x_crtc_reset(struct drm_crtc *crtc)
 {
 	struct ssd130x_crtc_state *ssd130x_state;
 
-	WARN_ON(crtc->state);
+	drm_WARN_ON_ONCE(crtc->dev, crtc->state);
 
 	ssd130x_state = kzalloc(sizeof(*ssd130x_state), GFP_KERNEL);
 	if (!ssd130x_state)
@@ -1572,7 +1572,7 @@ static struct drm_crtc_state *ssd130x_crtc_duplicate_state(struct drm_crtc *crtc
 	struct ssd130x_crtc_state *old_ssd130x_state;
 	struct ssd130x_crtc_state *ssd130x_state;
 
-	if (WARN_ON(!crtc->state))
+	if (drm_WARN_ON_ONCE(crtc->dev, !crtc->state))
 		return NULL;
 
 	old_ssd130x_state = to_ssd130x_crtc_state(crtc->state);

-- 
2.51.0


