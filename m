Return-Path: <linux-kernel+bounces-814504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBABCB554D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E601CC20D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987C83203A1;
	Fri, 12 Sep 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ljn+XN/b"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D231D39B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695368; cv=none; b=LjaOJ6SgJyh6EHFCmpq4bXtCDhpL1IJmqJBCFem93SR4MY4bmKyoyWHoPbFxOAvAcwMNFhtgJEkqVfFfYgeODcSpRO+n8OOQ5yLAd0TFbY5EQZeRbx9OqT2NoCUZXFmheK4OlvetLmRXH3R0nu5GLTAUDyJ2rgLDVNfyKNFFi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695368; c=relaxed/simple;
	bh=fpI2rGosAyCwTrEIHYOyRLpy9n+YPNCBEImOehwdl8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiIYV1U4Tbnv/8HHD8CFDZUZOPkqtduLak8NTTl1HXaBnjlV447nr90C3vC4UHftW/QH1IK088E+8SCh2MsuTrOcfpjgimHbUKPc1m2toQ/2JC6ED69ZSj/65y+jwMRwuC7V6hLvHRPGOVOeOoxoUZflXoXWIEyGLs/0TdqUe2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ljn+XN/b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45cb659e858so15910785e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757695364; x=1758300164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqiZoJVgMOmFeDlGNdTZ/DvTlXJdgaRd3JdTxV/yzP0=;
        b=Ljn+XN/bHnxEwHqbabHvT+qDMajLC6QXB1WLv9W4O0ncgt1C1HmCR9oEz7R1xSYUtr
         x0H4o1WdToBo8DQvwkU/QKNCDVncUyKhm8RXOPbcSYSWngEbXIjbB4bLxKaafsA0B7jV
         Ju96A50LGtriPcIeWbVJWfvZR7ZzJzgnqVhxBqw0TyWH1qbDUWXtNlAo71IanXdaP5rx
         HNfruVkVkBVU6lYPW9HPmKdREMl9QIiXG5JdIPzAH/Yq2HUSnhDRM4PNcGKLKiULXGDM
         wSr025fDseq4bN7Euc34MTXj2fLwLoH4OBN654lB7eUoxBO6WwC1kUjcQvqKFrSyJPlt
         3SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757695364; x=1758300164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqiZoJVgMOmFeDlGNdTZ/DvTlXJdgaRd3JdTxV/yzP0=;
        b=B3cO2CiHcefKYPYSvCMoHwDtyZEYpG6ZwLIM6iMpH6aLSjVf/v/mNSR64LjAoMqtAI
         eTAXEThQA7yaHuGtHpXY12jtTL3ww9UqJRZePq8l/1EhwXPMx0khTKB4UETAYij01Xw8
         ZfGNHBrJWGfoLtm4HsSa+WBFO3PzuryJjNOU7f2jWkRD64cK1FKJaBgvSpCMwafkvWwu
         eBm+807/8vBaM1D7HOIHYFckvJ31kjqMyo0Awr6cT7hErp352/C18dowJNexb/rqeR4D
         8Q/hYjg7qKzpjeH4E4QfdqU0KhVLqLJTQyxWI+OvryxGNuJb91xv/CqrWhBCQU7uzmul
         pczw==
X-Forwarded-Encrypted: i=1; AJvYcCXPpDK3rjxXUAogplGBrYR1zelLfkuwcBWABW3R8qIbkKebnQy1kvGosptn3gcff0LrQFCQ/AKBhWZ7Ci0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsT4WnZ+vbUKTTHDoF3CqzPbizBWbqXQja+bRe/DhhoBG7G/Au
	oCvtphtH4OHaZWzGAOed/YyBuCRWwM77qoKcykIvhJPfCNHz4H4yfL9/
X-Gm-Gg: ASbGnctUL4UsTl7XwZu8l7hCUvC67gX3sLf+7JuYFt43J7i2AJpmWPI+SOB7lJjUIY1
	DLIwP57z4m9kEcvpVbklBierVK2tlCsSheHyybVi4ocHiHrFdFCM5z7F5/Be3Uw0zb39kmZCPLz
	z86weDEO3yzcoJTAwr8TUhwfYVm8REnwZ67snGrgZH4UbAYEMBgZMZBGyxx+MTeXTbkfjmehGEY
	o5zwz72EKtJc994oLhIkiH3YVlOt3KdrbzdSe84yaogYetP0jTf8uH0aOM74dpKBJ2ZraAf/k8Z
	p6eorok5pIoEhB/FhVR/SaTsI6osg/J+QUNmnwVafzwp8kar3QLx5seAzfABJR28o6EgttolXRu
	HXd5DEDnOeHiXeocJlkWVPzeYdzdKRV/jwmX1cQGg9vo/2kZhX4C75rOVHrk34TEuIUq+Kw/uak
	AHVBxOyZVzug==
X-Google-Smtp-Source: AGHT+IEXS2pOOoqyUGEyr9k2erY2e78Z3kuSD92aGvSLgW0w5dzdl2COsGyUAMxnuPKhgacOKyiX3A==
X-Received: by 2002:a05:600c:19c9:b0:45d:d291:5dc1 with SMTP id 5b1f17b1804b1-45f211da6aamr36954765e9.15.1757695364107;
        Fri, 12 Sep 2025 09:42:44 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.138.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm7086696f8f.30.2025.09.12.09.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:42:43 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 12 Sep 2025 18:42:11 +0200
Subject: [PATCH 3/5] drm/solomon: Simplify mode_valid() using DRM helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-improve-ssd130x-v1-3-bc9389ed299e@gmail.com>
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
In-Reply-To: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
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

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index c6939377ec4b5a42ce0f40d070ce60d544d8516d..2058d188159c3eae28de1614b9fffb06ac5551be 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1470,15 +1470,7 @@ static enum drm_mode_status ssd130x_crtc_mode_valid(struct drm_crtc *crtc,
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


