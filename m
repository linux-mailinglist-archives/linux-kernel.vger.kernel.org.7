Return-Path: <linux-kernel+bounces-825608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FDBB8C4FF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025DF7C6E56
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D82E5B32;
	Sat, 20 Sep 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJaU/IDO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3E29D292
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361580; cv=none; b=ccc1EIDhwka0iP/thsPJschGphLfnA9xEDIjAN6otDdNKvshAVK4KKLeTb+ftMomDdpFnKw1xwo0x0IQSyyQXZmDrtoyiCW69wlYuNjt6sZY0etsBT62tlHQw2uqAPdDJxQRXVC0mbq3n0KZrch8qjflRwvuXprtZiIOYkLBUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361580; c=relaxed/simple;
	bh=AxuRJX/Di+TZNmkj501Vx1LAzGsvn8EvfAIujU+J1HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGCcdODgXEfNyqGdaoAZFRaHZZyhxpQnHL9+H9y9i4MYXTVDy8G5A5u8FDZRc8GHat257DrzPH0ZOiUcrTqCKr2qta1L/CcPaW7u5nPi0BhYc9a25vbAyeFZyzmEj6FhB3twK8mWsu6Lf8MD2KzuyLxVAHsi3LHv59ayAv3HHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJaU/IDO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46130fc5326so20135725e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758361577; x=1758966377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2BtO4h5fgPnqopTeGkX9M9uevJqHFHjmHEuvEhPITU=;
        b=VJaU/IDO2abaj2EkzXUQ7w6ioWiwKHIwC0Mf4UaH+BTWyzhOSU3WTEbfiwjXYKCafK
         YE5V+K/oiOc2X5h5u6+mZFh+zWROlggbmPavjJyAuKbGAZr0kggJoQqYKQ1suIWfOlHX
         u13d6Y5YUqMSOJizegE0DZBS+MmVIF76ZqSWd/NqR3Ph1x2IDX2dO6mKLUeSNoXnC57F
         MZyx5w1jJA2Jy3MdS2u8Aejl7h238aH7+3k2ikTJ8Z+TTrioyUibMZUI1AdzABIqmxUN
         yzTgtDcJAGHv+mWJMKWsotp+kYZpggHm2u737oDtv9M48d5AVL+2E16tly5AO6OFcQIw
         2EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758361577; x=1758966377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2BtO4h5fgPnqopTeGkX9M9uevJqHFHjmHEuvEhPITU=;
        b=mjqAz9pMWxFIx1RJ0WdFa9e1X/h2hQyEAErtIDONszZFfP/9L70sX93LjD11e4VlQX
         o5O+nZszb68WQnPwaqP4Kpiqn2hq0B6lqzKvts6I5vcg2Fhx+u2Bq+LePNEwOwInfy5D
         himBtmlpuzlWjhI7CRWqGZF40Lm5a4oKYfXpjlYjdQRITNLXv/UjlrJ4R40UvGlx3djj
         DBrhNmWXK4mLvRPO6XEEeOiXQuKMpAQ8Ya2+mLsw5XXV7+75Sa46HVhzhMy6FM95sCAo
         /JOpuSmYkdjfo66gaStqwXu9DWJlI/zt08msR0zRFm1tnt+oWzsxWfgoxt8lvQr4vcmo
         Pu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH8rxOvW4EnZ+lfbSHU3Rd9R+KF8yAC4d22A0Hp1xER3xqFZOg6eO8cMefHRJLbGprkSsEhyiZ2W51cbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJZa2Ak3ubEBT3jVVolhiaJPHkJPoRiapz3DSwDVVSzNaKEOD
	IaXh8HV/pekaHFq+15+Rih7b6MnBl/FkssQ6krEJrq2Fq0Q4yIYBxpdu
X-Gm-Gg: ASbGncviTSWJvOxswsxN7xVZgRWAiMmNSbrZ8wDyYSqP+hDlQXETbgnJXayin8bpw1D
	HSZnbBT2S+2fW/YUp5CYpl6a2wtp0pU/QSFyPCQk3CBisFxz7KS0e3HVrnffJ7wZfhUaDTrSRoh
	s9cy4Ey7BKp6wsnpyLuSg5uStnjdVrqznBa3OFJ6++2JKqFFIFi/XFSQSuIcYgPPMGOALW2Gcdt
	ViAoChN0E3FtxBfZuE3KyuN0nBbZl4Ex+VcJZlkFCfZaRUfBnq6QSnjrQWTUhqPuVl6uFyDg0qS
	grYjM1UoIkOqpg+OL48OS/uhzwtlfzIVRhITJtW7YntV9GUdJpggilWfrjr0CA2loczjKD08JYh
	1Bic3w34+r0bV0OsuIvmCOriOnYB/9Wnst9rLDq5VHXNAueDTMBcOxJfaWcVYM6u3
X-Google-Smtp-Source: AGHT+IFrr+GoJLZCI16/2tiEa+6av2fZixro4L1+EszOgL53IjeFy8N3GzS+hVuMn2/3gmqGADIWtw==
X-Received: by 2002:a05:600c:3556:b0:45b:9c93:d236 with SMTP id 5b1f17b1804b1-467ebbbff00mr46716175e9.27.1758361576761;
        Sat, 20 Sep 2025 02:46:16 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm163883615e9.23.2025.09.20.02.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:46:16 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Sat, 20 Sep 2025 11:45:43 +0200
Subject: [PATCH v2 3/5] drm/solomon: Simplify mode_valid() using DRM helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-improve-ssd130x-v2-3-77721e87ae08@gmail.com>
References: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
In-Reply-To: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

The ssd130x_crtc_mode_valid() function contains a manual implementation
to validate the display mode against the panel's single fixed resolution.

This pattern is common for simple displays, and the DRM core already
provides the drm_crtc_helper_mode_valid_fixed() helper for this exact
use case.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 5b0d5bbc7f9fabd8430226e88cdee9e22ac7ad96..6083fd9e9e5e4def670961dc46df7e4adef7462d 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1473,15 +1473,7 @@ static enum drm_mode_status ssd130x_crtc_mode_valid(struct drm_crtc *crtc,
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(crtc->dev);
 
-	if (mode->hdisplay != ssd130x->mode.hdisplay &&
-	    mode->vdisplay != ssd130x->mode.vdisplay)
-		return MODE_ONE_SIZE;
-	else if (mode->hdisplay != ssd130x->mode.hdisplay)
-		return MODE_ONE_WIDTH;
-	else if (mode->vdisplay != ssd130x->mode.vdisplay)
-		return MODE_ONE_HEIGHT;
-
-	return MODE_OK;
+	return drm_crtc_helper_mode_valid_fixed(crtc, mode, &ssd130x->mode);
 }
 
 static int ssd130x_crtc_atomic_check(struct drm_crtc *crtc,

-- 
2.51.0


