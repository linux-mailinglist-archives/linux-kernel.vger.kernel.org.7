Return-Path: <linux-kernel+bounces-858373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F52BEA6F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42B9835E6B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB5F27510E;
	Fri, 17 Oct 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNRv9T6t"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B596B189F20
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717021; cv=none; b=aMQP3h6KpKfGP5eSt/Lknr3a00nkXYLM6eXmycL/m19iVKVLxd1gsvTiGUXuOQ6DxmSyWSC8OdQ3/egB4epnBEa0ang1R7lqgv4HR3v6ffEjOR5ClW3zuUJIgJY6OOCFGuKoTxZpVrvKWJF+v0HmFFbYZZThBcyUBYZA032GLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717021; c=relaxed/simple;
	bh=CLm1Ok7Ui49vhD4HdpEzRFDDqGHRFmOOUE86aJ808sg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T/cL+/u7Kzn7Y4JxGDZjhFDxdToTcZqgHVFHyvtz2+bg67F+4bpp/m2yRMhiNHxREVIjMUUGYwbjxI/1JRw9Igu50G21MlVjEJDOwBhBUjJX2SIbW93IS+YEHGYzESN3sFYFE36I2gh8hCLzHD25WZgvyQ2oR+y4+FmodIEwVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yNRv9T6t; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4711825a02bso9356675e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760717018; x=1761321818; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ppRljhpZ7sAECJRgv3z2Edioee6aFFS5l0XZiKbfH4=;
        b=yNRv9T6tnIL2uaaGKBbfig2R+icZw55Mkd8nAaA2LjTCocf/91KqtnlkSWE6xXZ2Qg
         82EnWQWrMmSkrWOTSmVzgCE4SLC5QwwplgN+chrhNuVa6gj7OO9qc80F2+1duSsR+cvZ
         3Qqy+Mr++GUJAKaD2skd5MGylZ3eE5vDq6Cv4YOqIdWYs+bDd/rMoGjTCIPsEUN/wrck
         xcIY3Wm2gHYvn14+KPkNXrPZ6bf6T6TX6GgkM+VD215lD4oFhVhGcvsX2/ngKQv0LNlT
         Yb4lZjR7FKzhMwF7lIXV2ENq6A7G1nu2G24lxB1D9cdHnJojn++FohvpcjfzsRPUC/rs
         rfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717018; x=1761321818;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ppRljhpZ7sAECJRgv3z2Edioee6aFFS5l0XZiKbfH4=;
        b=uIygI9Jcu4g8SMkNl1fl1nQqaTy+rvqXNHKzapgAgMUPgiWRu73f9VkxUhFRFB/WtY
         veqg0dds6cCaqLWlBSqjsVED65A5JmAs7iulENaKdlZGTvUKihgf59dTl4ENgg1uL5e4
         kktdcB9qBpDFaJwN5YL0XPt3YvDrQZ/hhBPDRGKZKdsDyYN0zufeBZU2aMhxe3Asypnh
         lyrFaG3Lt8lclFaa77ojgzZV3/tKmeNF6032u4kje1EUzVru/v1Xm57oGreAw6JtczMv
         WcoiAWQQxrYCE9JuBjhH1Mh6TL4lfw8eHM7CGQ6PC3OwK5wtEt4z673i64MYRISFoj8g
         KLMw==
X-Forwarded-Encrypted: i=1; AJvYcCUwENwPwa5u9GLh8JTAmz4V0ILZCSWQIZ41svq4fES7jZ8mRyA2HoEDRcya/wPfz+s9sFiPYB8WcxtXY7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzZsZwTkbeL5+t6u3naskIFH+1SymZV4RRYfMBLaPLCvvU4TCX
	QmQ2esVYdTvuTv72XkLeAM0azl7D15fYXsAwdQEMUDZozgzsbFoLGc1ucSsKtXhESxPBQkfswFW
	QpBEj
X-Gm-Gg: ASbGncu+y2UELEsRiwBF4Zr4KaSNtslHf8CCe+TbeU5bb2aU0YtBHa1r1Lm/AbHbjMV
	eC6Ob50qCM1XDdp29uyV3/6//Xq9cBJyg06ChFK5Wzg9YIbIy4Ek4ntb2HIqf5hyoaA2xGZZwZR
	9OHCvO2kWfS2VPGqW/gVJxKVgoHv47EIkciqJ/RGI1634qibpXW9XY3NOEOO8KjnIcORQTvlkq5
	ss4Ik2sSRL+ud9u7MYO14h2KCyptzOtY56sUNe9g7SLLkvsidyFm+Q8skIZlG9Nz3y/aseJx8ub
	BucS+yn7jDngreer39mTJciWIDTgUVw/gv/u4zAyrQeCMs5zFJcNBhSlNB+RmCPGGT7eaX9hVR2
	S4LNrbtcpvhtv98a//0kUWiwHrlLNBPx41PrGb9a8Ly9fKafciZgBQtSPnlyGKdHR0Ov2JLmR2m
	xY3O87dnjInsHU7B7MeJ68UgsxfcA=
X-Google-Smtp-Source: AGHT+IEvEE+Kq6kgGCQVfufhYDGLF1UwGNj+vy55Ir4PUIuACrWwdwcv4BS7vhmELR8Tp9IGWl6shQ==
X-Received: by 2002:a05:600c:5296:b0:46e:1b89:77f1 with SMTP id 5b1f17b1804b1-47117879898mr31462585e9.9.1760717017876;
        Fri, 17 Oct 2025 09:03:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4270665efdcsm5017211f8f.29.2025.10.17.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:03:37 -0700 (PDT)
Date: Fri, 17 Oct 2025 19:03:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/sysfb: Fix a NULL vs IS_ERR() bug
Message-ID: <aPJo1W5Dl4rmGX_P@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The drm_atomic_get_crtc_state() function never returns NULL, it returns
error pointers.  Update the error checking to match.

Fixes: cb71de092553 ("drm/sysfb: Lookup blit function during atomic check")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index 8517c490e815..d2c4d8f3d4d0 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -259,7 +259,7 @@ int drm_sysfb_plane_helper_begin_fb_access(struct drm_plane *plane,
 	ret = -EINVAL;
 
 	crtc_state = drm_atomic_get_crtc_state(plane_state->state, plane_state->crtc);
-	if (drm_WARN_ON_ONCE(dev, !crtc_state))
+	if (drm_WARN_ON_ONCE(dev, IS_ERR(crtc_state)))
 		goto err_drm_gem_end_shadow_fb_access;
 	sysfb_crtc_state = to_drm_sysfb_crtc_state(crtc_state);
 
-- 
2.51.0


