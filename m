Return-Path: <linux-kernel+bounces-732617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4116B06991
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E076A189DEDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A826E70F;
	Tue, 15 Jul 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6uChJK/"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294212D322A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620353; cv=none; b=n4NYxXD3KA5nknu7YGNO1R8cOiNXtFPzDUFJel/tS24djGwK7/CQ3S9wqeaI7DkoTHk5u/5ptwxLyZdm+cpPliyfYTNdK4S6+VWH/F/smgIwHB0XYyXznK2vLCVMktehVFcc/lIKzhn3HpnH/29bO267MXzUiUHJz0EPjDAsuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620353; c=relaxed/simple;
	bh=ladniYXQzoOq1dlEinYXT4FdNPfN5teSP7HGcso+KCk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZVvmOWOnuZWdoyahznaoXWQkuIIl9gf0+OITklgJby/9hPWjyNwiZMnrpnKutTwDbaQ5RG0WcoQf7EgDdOjLTUwun6lt5lHRWkkD1lgRdCEebc00Vm7ZROFA1xsfZ85JHrReOc7M+fnG1bjbwjluQ/n8VbePo5FsNdFncR2pcvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y6uChJK/; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2f75f1c7206so1668637fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620350; x=1753225150; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0r+lpi8NsNWVA/Sm1KkgGo1zMZG7gsRbU/VLszDSOI=;
        b=Y6uChJK/xs2e3YRxYpjF40dYGYfePuE13HqN/2mqepk65Kgb0Q8pxrC/o7yCzfEHwD
         5jzWd7QhV3KiLfmMUEnNNn9KQxDR0faE3GR6HS1wob72x/NHJ2yoSQtEtHOxTxrGPn7O
         STOl1FkrrRDH+LY8xsQdqvUZzXXzWsWK7lED0znB5NzeFdOFKkVyWtKIQRKyYwtUCMc3
         SazUgLuJaCjV2oPG8W7+UWWnrGaBI3zHRC7GqnrJBMIm4L4diJMpQC29tVhWFdlO9SCY
         ARoltydklo2lh7DGjRiB2TaB+X/Ht/fxH8PvcLYxsQX+MA2KYEyIfJy4lIjsXdMvD6WS
         UkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620350; x=1753225150;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0r+lpi8NsNWVA/Sm1KkgGo1zMZG7gsRbU/VLszDSOI=;
        b=VH9ImwOL6O4AbUx/moCHPBSZXJW25YesHNDJyVoDTsEVDdKg0f6vdqmU5VZZG1GApg
         lzxHjYckTwgMxHFAwlwZn+7iL/aiN4cPDcy8mfpIGupqjrgoNQS4ZIgPrjNVeOMAnVmw
         R6La+96hYQ1tmrB7g+zyVfOv9D8BjaxA01KoD3TIpklfhHmdPRJTnPvDEpC5b7TQ4Jfm
         HT+5k3By1R+wqEVzXIyPmLYuVS6/DBvp2Jxy+YAUhRNBbc4iddYdeubOBR+PPWYYAYIV
         8xXkwEww6oOTCdCz/+xIAICBF3UoaZa6aCW2eNulZpbZ2GobaST/BKTxi1N1g8SUVaVr
         TPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVetNaqjzJLFPd+BOHWvHivbntovq1ELMtY6N3qZ3y++gtRgJNiPy7p0EFkh6xrvdkZ2Pv6e5Le0ky0A2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ktu65JFitAESqYEuAvhkPOMAAQCIA3amq5UpN2TLA7n+J3GA
	DA3mhdJGrvGiASi4n6JrTvWkY8ACDfZq1tL4zn2jW6UlWoa/fgR52KUiXdqDkgjQN7k=
X-Gm-Gg: ASbGnctaGBgdwYBf0qrHCrfO+u7nr7RWlxt/cGE78pLCxUu5CJ3I2caym6/uZGS88Vz
	MHiM2aDr6lh26tpkBAc++9JZF7rJ0rbX351JMAC8GxW8Lxa8d44p6l2Z8oocnA5r1mZstH3Slkj
	J85m54BhEIC8bvywBK3HDTM1iI6o/Q5kSFT4jXp/ApgJ875LVrHelcTAA9ainGWpNconYrfXmKo
	m3GQIBAdOdMiEBqbFd1yZQzhXjldru/TwfR58oKXYUI0KZ7pMsOgKz+gZMJOAbRBMZSvWcAt3C9
	ld/2R73zxfxhgyZ+8ZJvyW9tVxaiB2OBLfVNmAbDAuMmizazm4NhOjAhx/kxzWMJ+QXwdLPJ12X
	zR6khz2erWUu/qjHW8n+c5s4ME7MF
X-Google-Smtp-Source: AGHT+IHc/xJFBpogquGRvh2ovITPRrvj17Yzf/CgNYUFXPyrDzsqrw22DAEVZ/OJFSPIbJX0w4xOgg==
X-Received: by 2002:a05:6871:b12:b0:2ef:9aa7:becb with SMTP id 586e51a60fabf-2ffaf4dcd06mr1050952fac.18.1752620350028;
        Tue, 15 Jul 2025 15:59:10 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff8bc75ac3sm1100244fac.20.2025.07.15.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:59:08 -0700 (PDT)
Date: Tue, 15 Jul 2025 17:59:06 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/bridge: analogix_dp: Fix a NULL vs IS_ERR() bug
Message-ID: <d679e2f0-f449-41c4-83ed-c3e26e440a4a@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_drm_bridge_alloc() function returns error pointers on error.  It
never returns NULL.

Fixes: 48f05c3b4b70 ("drm/bridge: analogix_dp: Use devm_drm_bridge_alloc() API")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index ed35e567d117..4b9b444bd249 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1474,8 +1474,8 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 
 	dp = devm_drm_bridge_alloc(dev, struct analogix_dp_device, bridge,
 				   &analogix_dp_bridge_funcs);
-	if (!dp)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(dp))
+		return dp;
 
 	dp->dev = &pdev->dev;
 	dp->dpms_mode = DRM_MODE_DPMS_OFF;
-- 
2.47.2


