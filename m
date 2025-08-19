Return-Path: <linux-kernel+bounces-775299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E15FB2BD98
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F580684D89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9031AF01;
	Tue, 19 Aug 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0oQIC7t"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42731A06C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596313; cv=none; b=JGEsuW3ZN2UL//rll/4eGX5gz9VwMxGy5VdtQgAgXL8lC/TwlNjVdDKZKN31YE8FpwQxORbd+cKdFkkZaa2SY/mKtJGI9aKAXFa27dP5zOJnMcOe2nJtwhLMjarKvs4Ng9ZruaHLHWWBqELgQEh6xZpQtBbhW6wvDTCPDzG0rts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596313; c=relaxed/simple;
	bh=cr7dDOeFq2kJNvj9k8XgGLyCpYIUvYq5oqsrHpO80iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHOjsec3TL9w9p9Rn5z+5e6CnXrguSoLcPuchfXHxCQRGsaLxIsNoIT1mLzDJpSWRik+h1Zv9fCczIRnCQBofbemqr6yI03JyVuAThJSy8VjndIojZjyo3xnSIMNSdomvIQsXx8IqwbbG4zw98d5Nu3K5RfJW3UjEOYNM7n92To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q0oQIC7t; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so2517955f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596310; x=1756201110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz9qrbHKfImiU0wIEPpwysb9Rj1rHIdlAeMbcs31ric=;
        b=q0oQIC7tzXawjoPIW1K6vsfBLOonVbV+K3zOQ5kNpgyzfFOvcZ788TwXbQ3c9byuXD
         DrMVPjkzIFChP9dhTAlXi8RlMUmFSoN+ejeaNxDQhYYTrbKMro0GSsqkTk/5IrBuadTp
         MZIgPv3imA4F9oOwWVy/K8n7uRQGUL4de6CEpEY9aT2iWS2dgWaiJejkMkD9iD9KwRIN
         gBXg5z+84uvjLbJhlmwVOy/xQ52Fs2jEqF9/ltG4/eW6XzHi3NMW47u+nr+uaYOTUAGR
         8lczCNP8oC0N6qDUmUNEGcSMyL9qmy+l7hqBOVbkipC1JZbXc22X+2wu+by7Tro+SbNr
         exWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596310; x=1756201110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz9qrbHKfImiU0wIEPpwysb9Rj1rHIdlAeMbcs31ric=;
        b=WApfRuwmGtK05XvhytJ5x4FJrGo9C4hNIKmvsaJUsnUNJihxwdvPfIsquQHtzQqqCG
         NuLofdwJDspYYVTSV8QZD4R96vykpxWHgR4RGXHtEqWBEVRx5fxWWlRt+Wk7eeDLlyVG
         H6unIZrkF+/ramnl4bXv8tP+pJNipuvI68cJbktjg0PZRBJ5+HCy66h16+RCiteg6nWI
         /tFtAEXQWdN41Q8P4Ujc6ef0/jU0UggGbznOGHkikN8wA2OEWLAmY/JthDlCOcXn7KHU
         EY6JBhTxk3jsksAy50hQMVJEVuMjH7497MzILycrErtJiLhW9NMiCMdg6BUBN0kbypWU
         ouIw==
X-Forwarded-Encrypted: i=1; AJvYcCX2MAA3GNQNsmav8wE5oh0MCbjutMSVZJD1ez00+t8/p+cl6yXS/VNFbUijEsOGpJEUTCN7MS7989cnNak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzalw/Ec3ESNvV3hA04QT5tQALoX0N0DyThuaHDiWGH+1zwgVXb
	+Rl91ekDFiUohQgJYwIJ66lQhtY2BRCSQTylY8UfAjlGY9vqHwPVgQBzYhTjrGtj740=
X-Gm-Gg: ASbGncuPyNPLbM8t95z2SeMMuxc8zFfOD1loQCORP7QFaEKfPItHQ7qvmdsLigc5o4d
	DW4YQwykfnRp9Ca72w3Jp+Ru0Hg/rxGdQBam2kMZ0YxmS7bIt7f9Tf80JeC0AIcjqUK/CCNlVN3
	oAvZILiMOGuZUqFDhOjcP+CtkewDOXOHXVn4w2v94B/VCaZogukMwzCEPufEkHJ9wz7vRE0Htoo
	B8GIawzhChD4BTQ8NEqK8tihLrB1P4jKs1s96thBU4ZCVRP5YcwjTLWoWnU2b8CouFQu7WlwKlw
	17S+x2sW7YPzAOXP2LL6YH0vcn45qPUCLy/j6q+PC5T181/t+uN3tfB/z+RxJ/YfhRHMPZXO95q
	XV3sVEfQRuCcyrg9BUkDm/Y3KMRw=
X-Google-Smtp-Source: AGHT+IHlXFQlXQqNpNupwtpvRJnPuKsXYXg5yse55qc7nSnLb1u0RqJ4oB2cIQ0DRGelvNX7cDhImw==
X-Received: by 2002:a5d:64e8:0:b0:3b8:dabe:bd78 with SMTP id ffacd0b85a97d-3c0ed1f32ffmr1300950f8f.54.1755596309645;
        Tue, 19 Aug 2025 02:38:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077789c92sm2905553f8f.52.2025.08.19.02.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:38:29 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:38:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/plane: Fix IS_ERR() vs NULL checks in
 drm_plane_create_hotspot_properties()
Message-ID: <638f3e0c648c3f7c1e3b61dd180d10dc102f52dd.1755591666.git.dan.carpenter@linaro.org>
References: <cover.1755591666.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755591666.git.dan.carpenter@linaro.org>

The drm_property_create_signed_range() function returns NULL on error.  It
doesn't return error pointers.  Fix the check to match.

Fixes: 8f7179a1027d ("drm/atomic: Add support for mouse hotspots")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
---
This is a resend of a patch I sent a year ago.
https://lore.kernel.org/all/CABQX2QOoq3H=eHdM83_k5vgHiaMu9Zsto=H7S95QHxT-s16jEQ@mail.gmail.com/
---
 drivers/gpu/drm/drm_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index ad21fc855aea..beef2a06bc75 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -338,14 +338,14 @@ static int drm_plane_create_hotspot_properties(struct drm_plane *plane)
 
 	prop_x = drm_property_create_signed_range(plane->dev, 0, "HOTSPOT_X",
 						  INT_MIN, INT_MAX);
-	if (IS_ERR(prop_x))
-		return PTR_ERR(prop_x);
+	if (!prop_x)
+		return -ENOMEM;
 
 	prop_y = drm_property_create_signed_range(plane->dev, 0, "HOTSPOT_Y",
 						  INT_MIN, INT_MAX);
-	if (IS_ERR(prop_y)) {
+	if (!prop_y) {
 		drm_property_destroy(plane->dev, prop_x);
-		return PTR_ERR(prop_y);
+		return -ENOMEM;
 	}
 
 	drm_object_attach_property(&plane->base, prop_x, 0);
-- 
2.47.2


