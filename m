Return-Path: <linux-kernel+bounces-825609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE5B8C505
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4949C7BCDB7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060DE2EB847;
	Sat, 20 Sep 2025 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLyMbSbD"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB6E2D29D1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361581; cv=none; b=UwT5rpr5Su0RmoEQGn82kW6B89FcthEDuzUlmobqXExSXy/9pkIJWt1M7zdxpHg5/peMdASv6IfPyoXvLGVllQgfPwX1c1EuahkLp9+yfJuYAh5b3i3Fhux/Afax2QiCVOa0OHBXJHlAIwD8mCvih8LuSIkW5IVNod8VXNWKZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361581; c=relaxed/simple;
	bh=+TZUUO1aqAKxm0AaROV+RBFrnjIM5ONcieqWCxfEcHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9OKukG3AyD8U9kw87mNPthsq9AMbuOFJVOttNrD5TMiRCn8d3RjQfxrNlPPDuXhIUuUlqTkISB0Poq6GoUTjWz5b1pTkxuJjK7Cvd05cVpcFmfnXFnqz7nXZTVYvBXyHxcTfSEPt+WX72GjEig0AynJxp2q0mSJLFeiGuAr87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLyMbSbD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so26196155e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758361578; x=1758966378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1k1X7wVhC2Ie0OtoDz9fs6zchWP2fAQ9NgE8oeXh0w=;
        b=jLyMbSbDqyj+AxQ2XrSTIa8gDzQYqpHMlxarF/6d8a7j6WG54IVbo83G7RCeWCgLl/
         ManB0M4MDfhNH6TWsy7fhRwgE1rMRmKf1JrwOArfm5W3XJdu8sxsRuswIT7bnkgTCGni
         kkXDJvNr4y4NGEzEsKzfTT8mEE5VoQbTKaroLacCUDjgzIDs1poA67qyNRdR+RqEvUQI
         h2L1KevKpe4q/6+idruaz+8OZwGHuBMLDA4jPYXfRSw7pf2/g1VjcH0cjLxvlGKpGXk1
         v3jBwG/S0gywY+hG3G36q69lKfoC0gL2+vOOsRRJ7BtwpGmNER0v1UkKkj6jfhH37zuY
         TDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758361578; x=1758966378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1k1X7wVhC2Ie0OtoDz9fs6zchWP2fAQ9NgE8oeXh0w=;
        b=Ink63TCeWYxMLY/qLceLDD701XURqhDOb2lAa7XrUIhjHRvBPf5hISMzTXo5/UQ+hd
         +L1Df+GLsnI+teaHlEBGU4+6F0lVAe497Mx3DVxcy8TP5fAS1G2fy3matkMMFnYZgI3t
         r+a7ZaJwMHXON4Yk21M7QIUR8djkv1a12eo3EyHDT32BiC19kMORlX8OEaZ5PJa2vQq1
         PJUODgiiEM8EC9thYbVBjrrVo5p4Uc7YMQfjhRFKo6llhDQil4hwhBoFn9oKI7YupesY
         EPBVRkGRVwV0zecsR2NHbumMNO24NYkeJPMGhAStiDqwx4wXdufmpTVD9/sLl9J8JUa2
         ax5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+6OBpFSsKcQu/IOnixnNL3dhAL+1N+MLvdyP6ec2O6ppxVCNEd+9mhe9e1+OplxAWzzRmAhbxCTCYUZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2KqVBTCFDsHzjuAGzG2HSmRyiBMa6peWGFZFs2tN5ZTHhvbn
	DTVi7lol9JoLliZJCGZOitQz7baBMOIeuLuk3NbTGNMRAxskKFhJU3h+
X-Gm-Gg: ASbGncugnZ00FEww+vDIs0Fm/8JQcyqj4Y8/CNFvXh8WklW4jSV2U3ikwAnM3NhZJ89
	9AK4mQ2r2ua5ogJjQ3kFvB1uxRBnO7TBpDWNTHeHG5juLckodZsOfJqSVG9/fK9Dwj9XTBb87u0
	2vP2Xns3AtCtYjgpVZK+nRpNUeIgw9cWvwLqFCvayT+bF4eRxhX7K6uOEeQoxm3fVAGMGK4FuwP
	7ucurG7BiMMElpnCoT321s8VJP6+mezlHVRDme/4im9rMZeJP9xTQAgAZngZrqTmnYGtW4Ep1ZB
	CW2yT4CoQL5wMTFFfe/Rd6ndUzO0mEHCAgPtYQ1jcxwdbitqUhPAjRwQeZmD4wDhSbXD4J2FaFt
	SzfDoEemxow1UP6yuo5O8V1W4nW98d8JoixgZvX/UvXDARnwLoplaH5FfejSeHxsP
X-Google-Smtp-Source: AGHT+IG+MahtWTblaZT5DEDOldTm+ldFui4wqvz2L1QckgRXFnWDqec2nqXs/VZsuZMCBAulm9eIVA==
X-Received: by 2002:a05:600c:3055:b0:468:9798:1acc with SMTP id 5b1f17b1804b1-4689798217dmr34817835e9.2.1758361577700;
        Sat, 20 Sep 2025 02:46:17 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm163883615e9.23.2025.09.20.02.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:46:17 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Sat, 20 Sep 2025 11:45:44 +0200
Subject: [PATCH v2 4/5] drm/solomon: Simplify get_modes() using DRM helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-improve-ssd130x-v2-4-77721e87ae08@gmail.com>
References: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
In-Reply-To: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

The ssd130x_connector_get_modes function contains a manual implementation
to manage modes.

This pattern is common for simple displays, and the DRM core already
provides the drm_connector_helper_get_modes_fixed() helper for this exact
use case.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 6083fd9e9e5e4def670961dc46df7e4adef7462d..50528a94cd3bcfa46517c6ffccf3f458e17cf816 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1732,20 +1732,8 @@ static const struct drm_encoder_funcs ssd130x_encoder_funcs = {
 static int ssd130x_connector_get_modes(struct drm_connector *connector)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(connector->dev);
-	struct drm_display_mode *mode;
-	struct device *dev = ssd130x->dev;
-
-	mode = drm_mode_duplicate(connector->dev, &ssd130x->mode);
-	if (!mode) {
-		dev_err(dev, "Failed to duplicated mode\n");
-		return 0;
-	}
-
-	drm_mode_probed_add(connector, mode);
-	drm_set_preferred_mode(connector, mode->hdisplay, mode->vdisplay);
 
-	/* There is only a single mode */
-	return 1;
+	return drm_connector_helper_get_modes_fixed(connector, &ssd130x->mode);
 }
 
 static const struct drm_connector_helper_funcs ssd130x_connector_helper_funcs = {

-- 
2.51.0


