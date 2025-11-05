Return-Path: <linux-kernel+bounces-886860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EBBC36AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2B24501230
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319B324B09;
	Wed,  5 Nov 2025 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOFjUCwX"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB650303A32
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358990; cv=none; b=fX0Z0mLPah7PBsBz6ul2FI72bUug9tJRzoe2tL5ISljXd3B5rrC7+Mi9wlCv4YlJ328tNnz2EExNssSBEIWc/tv7uTsYzK0riaPk5Q+tyucNuC1IJAqn706toLtov+YfRw8pZjE2o6hZ9U6OosPhHUJ0OZvjI/KTHDrApzC/5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358990; c=relaxed/simple;
	bh=QMcBFIVhysiDwfVypM194suTaK7RnPDTjd6DwYRaffA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AamZr3qT4nQOzSkFyNV5YM8I6XtlWtDrpiKxVcNEDS9BqnJBnaaCexvAYKUPLJ7DVFmLXtNnrnNAFWzwtuI2ESExzXJiv42/Z861B1OC2ncYBLAy7OxGwnFXBWyLanDE0GfGB80gWj0pyMIZ2NIdwYGbPYGMQZ8NbYK6L5pvxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOFjUCwX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29524abfba3so49885ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358988; x=1762963788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onKFYxz3qx1mgItW1GE5HTsCNQVbyGrPrKl8Wr6AIZk=;
        b=GOFjUCwXn+EmopcCsa8h9zcnsnEpl/6Dh7wZjwkbdZqU0CuHZbzJnmIHjCNKXXpBsK
         2ZP94u+rGHfUngCvS28fYAj+z6K3TkD//HTFjkPwfsEjJC9mnHJEzVwzpK2gA4TG9Flg
         DLCtcaPCdBJQqvm3Qq1JmHZgMY4rcpFaRExMgAbjXg8zCKRx38vPC+4mEUlnz4Mj1C7Z
         ny1ytqW3eLo+7yIeTSc7utjXuV7EDbkvI33ywZwNuC7uLUOoAfCuvx6RWwXHBfcThfPl
         AXKJt5zzrP0KuY8bQ9KfyPrY/xVf1QJiv+rgV+ugHSqjxgLAQfZqH2Iofq49u6iE/3Ry
         mpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358988; x=1762963788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onKFYxz3qx1mgItW1GE5HTsCNQVbyGrPrKl8Wr6AIZk=;
        b=sDibnVZv9sgiNcH+WMBi2VALVW5rHyr5+VyqoY43i2a3b93Z8H/vjdLixe7qlM7ovX
         KceZklPtUfnzFjCsq1UKDufXQMcda0aE0p2ztCXRBxUWWZDxyBE4NwuWinSmv0dMWtvn
         xxa/A6yueVAZ+RWgyTr36lRyOJtct/RdqLvO5Kfemi2URHhtrtbfoUf8Plt4dCNJp67X
         ODFLL0ll/p9uSCUn+7Cgi+JBpMfjEr9RpkcGUvjazho+rlMUgho9wG7aIF8eK5ysTloB
         eZawfAEpSqeO1UP0Iw8bJofgghxC9fTgohPnos7ffxq+nmz3Fc46wZU0G7PngXLylIIG
         Z95g==
X-Forwarded-Encrypted: i=1; AJvYcCUMOALhsF9HoaOWPVYoDmjlb4w6McZWepL/dASQ1Xgjiv7b6b8Wx/D0EdDyIu8sntyTxo1N/gl2jOGlyWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8JFl2O1ptfCpgfxV+f8Om6uIiXFlwMUEPcCJ0JznyCoAFYMX
	m+1zZKHTq19rQMohdEv9ovDMvI57U39/ai+GxZYRkkPn21gNkeRLy+yB
X-Gm-Gg: ASbGncv3JHU39QMZBbCCwPelFSvnUNoTCpAilS/zfTM932AmJnO3bopYyJzduqcMmF9
	ly0hlNslwiP+TbBClbN93uE/PrUuHGUGY5fexBxUeDwzZ7klnNi6ViDC/sIkFzzauF3rrKm0Xs9
	B2b+624Y6UCzCMS0nyIAIOkg4Pr1+N5m8LrTZpacoyKs75fKjtDQdnCJiRQKYrT97fy7ctPml5+
	WLqRu9qGDiEYSyiGG2bIhFPo6ZfplbUejvrMh4ijsrHOUomR4vWVgAEewped3oJcXsF88dPsFXu
	9t6t8U5pGYDYqduTrC1jttoXgKPJ8C1vKDSU/d93ZpkzmKP1oJfH/4HamxDDylGpOe07uOnQoc/
	T3N2ehgXSFd0+FxegO+vWzQWuNp/tFcqtiiAfGWKH84lJuYMGFpDggsYLAwVrCsIkUln086PSwm
	4kIQ==
X-Google-Smtp-Source: AGHT+IFWoDv0xrc92js3LrPGZwOO07MytOUirYTiZ8qgebRNd+iZk6XliDM2euyp4xDmvx2GbYt9Sg==
X-Received: by 2002:a17:903:240e:b0:295:3a79:e7e5 with SMTP id d9443c01a7336-2962ad88638mr48773485ad.34.1762358988099;
        Wed, 05 Nov 2025 08:09:48 -0800 (PST)
Received: from archlinux ([36.255.84.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a3a941sm64888105ad.57.2025.11.05.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:09:47 -0800 (PST)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: yongqin.liu@linaro.org
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	jstultz@google.com,
	kong.kongxinwei@hisilicon.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	sumit.semwal@linaro.org,
	tiantao6@hisilicon.com,
	tzimmermann@suse.de,
	xinliang.liu@linaro.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH RESEND] drm/hisilicon: kirin: Convert to drmm_mode_config_init() and drop manual cleanup
Date: Wed,  5 Nov 2025 21:39:31 +0530
Message-ID: <20251105160931.466664-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251022114438.1096382-1-madhurkumar004@gmail.com>
References: <20251022114438.1096382-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

switch mode_config initialization to drmm_mode_config_init() so that the
lifetime is tied to drm_device. Remove explicit drm_mode_config_cleanup()
from error and cleanup path since cleanup is now managed by DRM.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 1e1c87be1204..47f682097615 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -160,7 +160,10 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	int ret;
 
 	/* dev->mode_config initialization */
-	drm_mode_config_init(dev);
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
+	
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
 	dev->mode_config.max_width = driver_data->config_max_width;
@@ -170,8 +173,7 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	/* display controller init */
 	ret = kirin_drm_private_init(dev, driver_data);
 	if (ret)
-		goto err_mode_config_cleanup;
-
+		return ret;
 	/* bind and init sub drivers */
 	ret = component_bind_all(dev->dev, dev);
 	if (ret) {
@@ -198,8 +200,6 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	component_unbind_all(dev->dev, dev);
 err_private_cleanup:
 	kirin_drm_private_cleanup(dev);
-err_mode_config_cleanup:
-	drm_mode_config_cleanup(dev);
 	return ret;
 }
 
@@ -208,7 +208,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
 	drm_kms_helper_poll_fini(dev);
 	drm_atomic_helper_shutdown(dev);
 	kirin_drm_private_cleanup(dev);
-	drm_mode_config_cleanup(dev);
 
 	return 0;
 }
-- 
2.51.1.dirty


