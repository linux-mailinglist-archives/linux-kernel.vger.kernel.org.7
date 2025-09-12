Return-Path: <linux-kernel+bounces-814506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489AB554DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F377DAC2973
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501C631D39B;
	Fri, 12 Sep 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GERmBQTV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB253203BF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695370; cv=none; b=jsYrhMkImtEd3aUQWIKFMCMp/r2GFmDV7aDRdLrjMbY6QCSEQHJIMctv9Fom6Aj+5hedUlRJdOritiaGncgbw0poSCG4jQgNl3uenILNU00DFJTecx6Zhlmcna5ZqOWyh3panvcCTHoeblNHQjepUa8vDLxZneW/AkYsnC78VBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695370; c=relaxed/simple;
	bh=Fei2JLl73dmjplKfRszReY+sa+vv7AHK9iZ2Xfstrwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O90hoaah2LqU5dFSTOLse3rWberE6NpqvMh+IDuBgPeNH0sPP+PuYcEs3dK40NH6ah6mTltLeVQTyfyB8mdRejTQiVUjrCbfRGg2Y/aBMU6lK1RHcp7ynV8VqgM/6PjmS4xcp/FEhX7Na9N78IVszUNo83I+WNN0v34qm1pcT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GERmBQTV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso18352995e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757695365; x=1758300165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFENQRkaHWGLQP/LJzCU4+3J7bwp0+IQHEZ8jQOM3aY=;
        b=GERmBQTVwWZOFLqoB2UkqUCe5IWkUod5HkW/lfEXJt8Oy7HLzpkoEEMutiE/bM12gM
         GeDXBxQpYca/BqJB91bznPNGSZuRdfsYZlG5FfCANLRURZpXrs+lVsDaC38gAv16at/P
         8Ex+SojjRBoORlNuNkGvAFMuXH6W2rdtl2bMlh54vK4zn18xbXwiNEZR4k7xNFuK8u9G
         Z88y/TwdPg4M9w5UbGhIDySxEA3wRGnR0ZIm0je0pn8zWmwhUZBki/eLvtlC5s6KsW86
         esEqlx9GD/Bl1qGbaeX1K5RCVOXqEy/fujnR9B2qEtGKkMR4xfeICHnOryeEpHNvkDe1
         EPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757695365; x=1758300165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFENQRkaHWGLQP/LJzCU4+3J7bwp0+IQHEZ8jQOM3aY=;
        b=wR5LbUsTUm9vuxpFvDxK6FLClyruKZBetVuZ+oh5kIam4WXJdmvdBrfdoxhPez6odU
         DiqJBAhx+dkcJUA2l8Tnmn15PDJbctFNlxH1mFT/E0HjP7NOisocC9cZmixw/GrF33HA
         ccfv+9ILRCzohlC6lcPOYXuUvbdqUBa/LVOgMr9gjcCtM7rjMROIghw14tBIfGxaY+LB
         r4e1tDXuCrZALYneDujuLr41g8Gv+H0ZEndc6hM6lZAn71VXpxxjwNgc238VHTKNELtg
         Z6Ls32Z3uKXugdp/QpKvf3iijQJOF2xuq9Dh99H4d6ob2Z0JGeyPu8cltpzO14Qnx2JI
         QRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHY5cqwM+E3LOCZwT35nu6c0cbmlAFAyVmifczJ+/KYvaDOyaMq+ECNuoXHMxgNW8Sd7uus2ukDFCHExo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykdo18Qf8tcvwkSkjB5CrYXneAv/jBeJwwdLMds6Z0AiQwAONV
	KUDpzDEMbFG88NunUrMrjCvhwwrtN0h/eLH8UTqA+fXY+Zv3gFnpb8Zd
X-Gm-Gg: ASbGncts4EkHvgfYVQZ4Z9YuAd7AbLOXzbjDey0SrE/Xa4IH3MSd5J9jkOhBeC+sRIh
	Ya3KkatovE7tGBVTfsaMujsgF23mAy0rhD4FC52UBZsW7d27LDKJXiIJ290018AQd2PPS2EFbgf
	uZufCmHEheZEULotfn9GjP4JyHxIE7I/G6k8xfjQBWIU4KagdZibjkHmxQRKwKqQG6JaPnxstbT
	62nD7R8iFCxBa0qvnyMcpdBpvLbV6jO5iih3r1k6c/ow7OhHinuAgNktq47yqwvBN0pHJED5AVn
	Eam36WklPxRjJFrj8dnA0pxUhgnNJokrmhhZiX/wdAW+dJXjmm2y40UBIf20Q5kS7hEHM2dRxQD
	2J26O5y/YkSylAEpbP04U5IQYWx/TMAPQtxQmFXu70lZ3KpM/sh8vb0RR7T4G3owa0aPRLuefH6
	M=
X-Google-Smtp-Source: AGHT+IFUXlWlMsI+O3HCeBbRHHVgWy9WXZNhNJzCqjRktFunB1HznFupXLMqa6IWJ2R3netjj8TKLA==
X-Received: by 2002:a05:6000:2389:b0:3e7:6268:71fd with SMTP id ffacd0b85a97d-3e765a4c887mr3756492f8f.52.1757695365250;
        Fri, 12 Sep 2025 09:42:45 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.138.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm7086696f8f.30.2025.09.12.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:42:44 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 12 Sep 2025 18:42:12 +0200
Subject: [PATCH 4/5] drm/solomon: Simplify get_modes() using DRM helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-improve-ssd130x-v1-4-bc9389ed299e@gmail.com>
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
In-Reply-To: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
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

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 2058d188159c3eae28de1614b9fffb06ac5551be..7bdccb5140195a45d8ffd01e139dd4eb2e3cc327 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1729,20 +1729,8 @@ static const struct drm_encoder_funcs ssd130x_encoder_funcs = {
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


