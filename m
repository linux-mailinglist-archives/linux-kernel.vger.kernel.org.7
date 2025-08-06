Return-Path: <linux-kernel+bounces-757681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06490B1C552
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3EA6241FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8728BA95;
	Wed,  6 Aug 2025 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OvJ0z8i+"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102D28A3EF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480744; cv=none; b=i+VYITV+R3VIqRqS9YmwuEIVwSD2Ku1n8rImAxBxEu5mh/evqv7dZS/kCa4avL/i9BY18/azyfJMJW1pFEWfq0+qLKGjRpkYvqF09k/MIVdUmXLxa2H6R4kI3f9xC5WlnCZTbkskRzfGD9OYX0dBbhOgurENAPg5A7RRWXHvthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480744; c=relaxed/simple;
	bh=BwF/YJpQUxxPDXEnj+T63E/nd73tgHkdKkgilFUSKzY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uvT51MIwTAiBQHSXOIOn9VFXB4zOcMwJQOPqa3OfUL0CVzYGJCG3eJi46N0QRo8doO1mIuSu9cIMkuewkHaUjRcV44LwGCETO9DVIpj6Cyr8S5cTRpjSZyVnm+MLjTlLWHa3Gkeq9mmZjG7CAf4aj7KaK0RjTf4c6DIya6OLuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OvJ0z8i+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so34354915e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 04:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754480740; x=1755085540; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DepA2B68/EdYA4QL8eVRTLevm19pdHVt7YsUtnKFMQ=;
        b=OvJ0z8i+V4iumD6/ciZSuunM/p2cKePK/Y1riG2Cbe6CWZMRzQ32PRG7Y3YyTtJ8l3
         2WraPthW3xiZSMio7raZ8/+OkNNeRCXXvKcY+IwN1t4b5mU4TQY5wdgU5kghQH+1gLTW
         QKigVNV7I9XZR7upIpZfcXKydf9cO0WnVkbXva7EkMaIZx4e2iovZ45HDfUPi243n0rN
         pN56mZDOcHzKc/jqDjjZ33NPF1E21zO2ZNuamE+8K2T2QaYulDBJJX6NqcANTmlliGxV
         eJtJFuYhPWbrZHCcyPwEWYrJ+I0S/wqVL2YSLtn6UMlVs2k2hM1ifn3CUmjyLuYAGe6d
         7Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754480740; x=1755085540;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DepA2B68/EdYA4QL8eVRTLevm19pdHVt7YsUtnKFMQ=;
        b=lY5TV9smTYriJpUUuAv3HG3FOKopTVDrkzCI262CI4hByw6Ueed6BgqO1ZhtCZS+fl
         Lzj46tIJZICpLRpaKTuu70gGN4D6LGEiI9zbh6HuEYtdKsTPmQDOLjMBGzYc1Xz8Myga
         Ezb6Lu9W1myVycl0en4Pg/kFMNtjd+OXQ02vBKY4AUgO1S41rNjWBJIfvTEQ62Y/f0/1
         D0cIjzR5e18grgnqdwx2inKgtR1A5UuN3lAwQUrwJuidnW5St20/XAr+kUpXh+57fhTj
         asAvDJCeSxQpiWFc33L3hZuQEAnMy8QZ3g2F0kHbziCNY32me8LFcqZbk7nwrDeo+un1
         1kKg==
X-Forwarded-Encrypted: i=1; AJvYcCU89XA0dt90gHM4bnrs9GVaGKvHA2+Z1Z+bWYmZBOF9aas5/gDdLoI9TAimAlRcQSM3ptUhSlgSHwzcvok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNe3SA6e7u4rqIjw/BSQTZioTvKVSCVVM70sEBpRrmjBTmDO6V
	Fv+L+0SmVZQNvXEckbNUPAHkxiWYh+T0Xxoe5Ce6+OVohwh5D9alIDnBj4jOXyZsUpU=
X-Gm-Gg: ASbGncu83JCKfUqUtzXabPDJ/FbyiXEnlXvMJGj2ceTNj7hxloc9l7t4XCV4u4JcDXP
	SMWCImCXtHfb2HoaQSePfX/ReVjJUCY7TMhCOAT8I4R6WFvg/4B9NsVCrwlqNeZVtu1DLHmT5zp
	VMD9zbNfll2AJZg1BE2uEcvOkigRk6GG0Kud1gNJaOToZ0KVqvORgWpt5QLA/j2jyFyrAHH41p8
	NRZym3Nh1SxELSi2Y5mz4XUse1byVFTtmDaeqxXipQS9/xRAzeaY9qYGDxLHxq+R1YgFK0/WFvK
	mi3wVPi/a5rDKvh1iUFtZqRSDL+wQ2NvKM736oe+XAkmFbOzHww/PfJdvmvvSp1onnV5jtUSBxt
	Oo9kGbWb6NJ1qum8SueR16hswPyppxZHYF1z7/w==
X-Google-Smtp-Source: AGHT+IEE3g4jSi9GsUDwto+AdTCsAW5WpR+TQz9Q8Z7q9dZe8YHCctfVsvsgs8q3UFKvnWq1hWll/Q==
X-Received: by 2002:a05:600c:1546:b0:458:a847:671e with SMTP id 5b1f17b1804b1-459e74a807cmr19125025e9.23.1754480739775;
        Wed, 06 Aug 2025 04:45:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4533e6sm23416702f8f.35.2025.08.06.04.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:45:39 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:45:36 +0300
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
Subject: [PATCH] drm/bridge: analogix_dp: Fix a NULL vs IS_ERR() check in
 probe()
Message-ID: <aJNAYCXKTaT1bjyL@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_drm_bridge_alloc() function doesn't return NULL pointers, it
returns error pointers.  Update the error checking to match.

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


