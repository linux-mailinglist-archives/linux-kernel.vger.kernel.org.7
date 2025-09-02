Return-Path: <linux-kernel+bounces-795632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D46EB3F598
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0ABC204F48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A22E6112;
	Tue,  2 Sep 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIef9fJt"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8AF2DF137
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794839; cv=none; b=hUWpv+qCN+A2ys4rIgKb93VsPSVNN3L6qJyEfPmUwBZsH3BVN0rzYK4yhRpzH6+/GyNgzt+Yyw+1muOF3zl5uOKAERjTYbANnd4A+zRZxpW1ioMAB5USu+Aufa7WJKQ02fO8v3jltqh0e5hAVDAVvXS2GLK1p6MjXMZHAQd8Ywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794839; c=relaxed/simple;
	bh=++wXYqYgn9MXRhgojQOCRcAmHUnAXz4lTJ8R4B11SPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OBhEG9+cPhWekgdOxPUPhwWUVLXsJ/cY+rgJD2xQuXWR42JrJyzfErzyGzntsL/JqiEAl1qgNV33SqE/jzfcEfp+Ztynho9MOjjctAaJqbdK8GyGCMDxNWFoDKDjRFLoZ7WLEMgM8cVaqCH8GDv72pX6ZsqMrtnoGa0FJ1BXflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nIef9fJt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so107850f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756794836; x=1757399636; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ympzDmmI8MhfVPuR62lP77gCJMNp5uNIli2mbJ4bZQ=;
        b=nIef9fJtOuIpNPltP6uf812Mjqtg7avdF+Lgt57i8VoaxmokIaGoec3dznT+LLR3Vb
         E4VgGDzbxwobGW6fmBYK6Q0WdHSYq4e46MHxI8WZwc9rC+Oj432uJyjifctHjhj2JpdN
         KyKaR1587TLpeNgywIxm+11FwehteK9M87Jm/Su3jfnOjjTyKruDtJ9r+hS/lZlTrX1k
         QeRYwPCDrKZ/5eRG1aHnkY0GtSHXScXSJ1/Y8CKA/QeRyUV1pF7G4fzz7o+0UOYD/6Xu
         23A2sTlvUQ+bU0tQDY6PRBwKgRYR5o952issE/7wQKqUdu7f012eFyRE1TeeKZn3SN2M
         XUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794836; x=1757399636;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ympzDmmI8MhfVPuR62lP77gCJMNp5uNIli2mbJ4bZQ=;
        b=GTx8B7Ldf4FlpBTcZGvJsPmyMM4OahC8GDVwsOpvhxuoe++CM+xGzdkF/BjaneDA/y
         WI9Qj9HLT2F7pWVgH760rgvClW4KoIGaOMYlQtUpRT6govnk7Jv+iCeVRvg6B+zBqFbx
         Cu9OkOIHmb/KBozysTK9h+GziQA9yBN3SvZZaWvyg6WQBsIuFqV/fkOnToRkC1NymPrg
         tQAv4YPGL+L5DjQrcSWBkH2XI7XR13MStyJ0GdetofcRhj3DJeq8iNaPm0peiq+lzcOs
         Lq3sELvlNMVBgxevdPlU04fDHwffi5frq+HEFY9Kmzdhph3P3uTA3C8NqpXYvSME4/Z1
         x8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCU8WlodD0Pvo0cHiV9mGCmsvHIfCxTTCcVkXYJkFLFWGFNNFEhAqXrYSLBDI9Yg03dZGp3WDopJFSELR9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTyM+DYrkv+gTA+uGT4Dd60gmKfYlB98DejI1emMPYQI+GUq9
	Mel921MNpNOTQbQ48hL++nh8GG3uqxdqwquvNseiMPqtN3KbJiPxEg+qZ7MX6v/gJXw=
X-Gm-Gg: ASbGncsGKGQLqmyKPuzTkHTPGyM/Qi0Fem5VKsSpbCD0y4JUZ350rwA30HLW7EpmNRW
	nNmoSH1tlS61CIpMnZRRZXmeE3CWAiSyXlp5r+BQaa8X0ttmtKHywan2XkwmdeExYCefplnFv3a
	EKkDRr6GbYL5NgqI+l0wVJUWnlhDnngwQa0KD6mTkM3Z+JzgGVNexoFllvBoQjZDzv0mDiGF8cc
	5hjVXlOzHqrTdGeDlGiO3Ed8JfkA10OzIxSRWL1ONgeK1BPnQsWJjo6Pougwiw8x26tY7a6fWOL
	49eprXhdah2tkcDiiycDjd/Y7onB6N4vZSN+AYR/bvsQ1VKH0AJRvmNtRmnEeqPlvmsLPwkO7xw
	KswAUFQqqcTyZp2lzfaxDo5pna9zy/4e8aeDEDk3it6THbkmZ
X-Google-Smtp-Source: AGHT+IGczOOV8MWINPPIkYniAwwdymVO48SZpByPT7RWy59E5cu+BCfrp0a+JKywzdS+lIUS1DG3Dw==
X-Received: by 2002:a05:6000:2112:b0:3d2:6129:5505 with SMTP id ffacd0b85a97d-3d261295a85mr6792091f8f.36.1756794836310;
        Mon, 01 Sep 2025 23:33:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d26f22f5bdsm13043671f8f.37.2025.09.01.23.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:33:55 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:33:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Yan <andy.yan@rock-chips.com>
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
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/bridge: synopsys: Return correct variable in
 dw_dp_bind()
Message-ID: <aLaP0JVagRyL0f_O@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a copy and paste bug here so we accidentally return "ret"
which is zero instead of "dp->irq" which is an error code.  Return
the correct variable.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 33be4eae2b20..22e8b08ecb74 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2077,7 +2077,7 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 
 	dp->irq = platform_get_irq(pdev, 0);
 	if (dp->irq < 0)
-		return ERR_PTR(ret);
+		return ERR_PTR(dp->irq);
 
 	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
 					IRQF_ONESHOT, dev_name(dev), dp);
-- 
2.47.2


