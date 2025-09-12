Return-Path: <linux-kernel+bounces-814503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C554B554D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F0E1CC522C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737E731E0E2;
	Fri, 12 Sep 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iijwAOaf"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1359131C56B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695366; cv=none; b=nLrrVWJ5aVyUnPxrqwOJIyGV0z8qD+2dOryyixvjYANPgkHiGyJ5GB5YU+1tK5JjXc5xptsLjqxW7fPWkiypV5f9aynZeSOpi7KhGcj3nMOAqE+3C9XPPb/XhZEEek4DPOXv9F2TNOBljUQKyTWyMT//ZCFX+Y/GO6KT7lryCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695366; c=relaxed/simple;
	bh=x1o4rMIoDFPnj228i4/i+X3VOW0Hk0iMVCOnI2xopbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0E1fTFiK3vKoHsandzql5+jR9L5wsbma8EAiviRC5LaP/q5yMHmGB68Kr/8BY29DYHIE20bfIaR+S8EupEcI1WprISX8Vn5LcQzUUZTyzHfQePjjmtgL7INQAtB+UpMHVf8upw+5/2+oBb9bozqV5vew6oYAPSPcXy7VnG7IMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iijwAOaf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e75fb6b2e2so2260207f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757695363; x=1758300163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2gnDI76Cg2pQY4d+7l+CRi3OFLEEk/WHj+p8hJRcSw=;
        b=iijwAOaflrxRf+Sc6zvrp2bTS6Dn8+7q2b+pXlFSXEHvLWu0rxhklzVaZ16QT7fmFN
         +WYdjgfkB38lpq+ii06Z9oOyuHHtZuZ+snlamgIWt7puNI3ZLGqN0YpwNeSRofyVTloD
         ep38UHS3kWAqMOG6K8dcygeF8xEk82a+BabNyfLlY9IzHhkKpPhNSB4PxhUYkWqy5nd8
         iynSVImTihg3onG4XBssBtGo6UsS1w9bWtF+Ing7A1z9NSyd5OxgghcentkIib3KOZwO
         j3I7fT2go4zICXGOy4z4q+uL1tRHfdhGR9dAP6mMggm3V76Njo0CimlJ/K7iibOXmm4J
         DFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757695363; x=1758300163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2gnDI76Cg2pQY4d+7l+CRi3OFLEEk/WHj+p8hJRcSw=;
        b=GdbVRUblDFg10HwjC9YFOyfiS6/ZQTCuQCXgN9tRgoyRnrhks108Syj2E+Z8RmcfGu
         TQrKH1Fi7Ype1w7Y90kO+TNOmQdCnDTUPT6yIKtDh9Abx56Hp+BsuBicl6diGCo9xmOR
         2Hben6TZV3zHiC9bLd6EGU08TSxyS4t6G3LXl8BJ6kSt9ExD0o6FT0ZPgS/dAh2EDd8O
         IVCyZH2h6BCqQpI7BWXsglmpp3pYs3DHSB3h980oFf0WAcAlr9mQMxYjCod082CPGHpp
         ox5Rkdp3qSzDaGJNAzVHQ2s/dyd9eXFdmnwGJhr12vkM8GXjYllr2thvlJvIamsf97/V
         Zj3g==
X-Forwarded-Encrypted: i=1; AJvYcCXvtoTbgIwgQiNxlTcP9jhN7vct96AQGUgtD3ubo88ioZ40mRYeX5sUgGPXUotIPrNP7QL+70thHne3rmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnzreAP/tBE+9OSofpSE/bC+0714RMc4iH1Ngh+OkVo5Y4iNU
	T5IBccIDkQbnocd2YhBeQ7zQCo3ATHLUxva70sDos54gZb5kTzCTHrju
X-Gm-Gg: ASbGncvWMDWCTYptfSzPc7fVcf3ixTTyqkOB9eBV79EKL6qRaQfJHm8Pt6BU5tSjiym
	22yFyB2g3TwL96KVRwIX605NH3AakXugDRBtWiwGch4aPuGn6v3xnRvbV0stnl/BRTiDQ0gtu0P
	RT21Df5H/vgRsQUKCabx/6BSYijIsBBhVGQeLGL6cnCtaMQmUgHNBbXIAFF/dgrqV+Hv8W25oOu
	PD2iKHa4lel8aGV/n76eaMLB3N+QHqRMKBQZW9A4KP/qIATm4Uf5zl7KUTXxVjx0lGw/hZ8eY7C
	RH1Faifsd3X+8La5/Xa9Or2KQ3QNZECXZ9XHZrhFF2wKRgS1MWleS/NBrzLh/rw4kabw/eCntQg
	hr/07ZX2xH4jRIRxhSu4kDjWVdWRdPhehT2LAdvqkn5j+4FqMJd41pTUftuOM5H0eUU88itNQii
	Y=
X-Google-Smtp-Source: AGHT+IE959gtwBhse6FsnHVMnHsBtmS240AL0UVQnNung5XxUIW4zcMVG/r4gPAUBC/WAXs7IQvx0g==
X-Received: by 2002:a05:6000:2584:b0:3e2:c41c:b2e2 with SMTP id ffacd0b85a97d-3e7659f3806mr4012838f8f.39.1757695363112;
        Fri, 12 Sep 2025 09:42:43 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.138.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm7086696f8f.30.2025.09.12.09.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:42:42 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 12 Sep 2025 18:42:10 +0200
Subject: [PATCH 2/5] drm/solomon: Use drm_WARN_ON_ONCE instead of WARN_ON
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-improve-ssd130x-v1-2-bc9389ed299e@gmail.com>
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
In-Reply-To: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
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

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 297593c7fd20a5a5da81f1e1fcfda9092b19cf90..c6939377ec4b5a42ce0f40d070ce60d544d8516d 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1390,7 +1390,7 @@ static void ssd130x_primary_plane_reset(struct drm_plane *plane)
 {
 	struct ssd130x_plane_state *ssd130x_state;
 
-	WARN_ON(plane->state);
+	drm_WARN_ON_ONCE(plane->dev, plane->state);
 
 	ssd130x_state = kzalloc(sizeof(*ssd130x_state), GFP_KERNEL);
 	if (!ssd130x_state)
@@ -1405,7 +1405,7 @@ static struct drm_plane_state *ssd130x_primary_plane_duplicate_state(struct drm_
 	struct ssd130x_plane_state *old_ssd130x_state;
 	struct ssd130x_plane_state *ssd130x_state;
 
-	if (WARN_ON(!plane->state))
+	if (drm_WARN_ON_ONCE(plane->dev, !plane->state))
 		return NULL;
 
 	old_ssd130x_state = to_ssd130x_plane_state(plane->state);
@@ -1555,7 +1555,7 @@ static void ssd130x_crtc_reset(struct drm_crtc *crtc)
 {
 	struct ssd130x_crtc_state *ssd130x_state;
 
-	WARN_ON(crtc->state);
+	drm_WARN_ON_ONCE(crtc->dev, crtc->state);
 
 	ssd130x_state = kzalloc(sizeof(*ssd130x_state), GFP_KERNEL);
 	if (!ssd130x_state)
@@ -1569,7 +1569,7 @@ static struct drm_crtc_state *ssd130x_crtc_duplicate_state(struct drm_crtc *crtc
 	struct ssd130x_crtc_state *old_ssd130x_state;
 	struct ssd130x_crtc_state *ssd130x_state;
 
-	if (WARN_ON(!crtc->state))
+	if (drm_WARN_ON_ONCE(crtc->dev, !crtc->state))
 		return NULL;
 
 	old_ssd130x_state = to_ssd130x_crtc_state(crtc->state);

-- 
2.51.0


