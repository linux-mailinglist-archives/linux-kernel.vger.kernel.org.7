Return-Path: <linux-kernel+bounces-779739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A478DB2F805
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560F43AA7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79AF2E091D;
	Thu, 21 Aug 2025 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKm3RU9d"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF817993
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779438; cv=none; b=apql+D8h94KOASE9DdGqu+N4ZPptN+OQiAu7HtUSadOxkWRjVhQogscmUVOpggtRAv6RMtce0oRVbge7IS7nkK8coqjt0B25S2SMUztFHmHwdi+TsmjgchkzUkMRx++4eKEAP+rFO++cCf0UW//Jg+REjDYkJDnkExDlAnO2qOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779438; c=relaxed/simple;
	bh=1Zs0xoFLNF/NAdBxulvALY6NhTUH+VNltZfx4Sa1MQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ogmnzt4s0Qc7ChWWQztNwYY8A94XxIqRSxMskjhXR5qIOTWGIbeoLlc1HuuR6GIwjwEb4MeY7zyuLO9N/0d6v6Q9lRFZZkDZtRcsld8HaGG1imZOuzEWs59a1bnpwLyi6x8wANlkkheOqXfJglB+qMnoUG530BH2DDoawiS2iGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rKm3RU9d; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9edf504e6so640930f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755779435; x=1756384235; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bt/Zd5DPOzcwiv9QP5TYavZsENkthIU6GtnKmDspSLI=;
        b=rKm3RU9dZmrbjWJQBBFR0gBxG7FBMh+7gyrJHD3cxT2IuVT4D79s1YWGJ8fb64/d2W
         7ZxWvuYDSOMejEGkqTPFxCeFrtj6TsG0cmWUeLcuxauP5BdcyW2EAjuRD4ppBUUhferK
         uASHKS+H2bvEHY+zkv3W54hN5bZYh9NoLogACMVaEz1idxPFMS26/taw1NvvL5YsZ9vY
         a1/1ApC6IT8C8voZ0y8Jtv9Gcu54flx2ihX4WLXucHQa9oKcWb0TGp+ltUMGq+TG1meS
         qpH3ci71wdt8oTCTQ73NkK9+MX8c8MsoOw5YC95YTEThqQPZSOGmPaqhWac6pMRUfJCV
         0iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779435; x=1756384235;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt/Zd5DPOzcwiv9QP5TYavZsENkthIU6GtnKmDspSLI=;
        b=Qeh0aIi1mFspXA2+KW/yvbOJYj9KKncs+hv1UUDeiylThHKXBKyzDzKstcAebtSCuU
         1w8WBGErAZIXRE+sWT4yiXJdTRAQN8AqXQMcJL+JKNK0PYRL++vuFge1Uf9J6LSMKsyZ
         BXRqODvCO5y+M+uN+ehIISC3Kq4jATW7w99arWzLICiHtlT6YdLBKQBmiJsHnFh+qVix
         VxaK5IX9LR9Z/9LZqoZfROK9/pQChU5x7OdNIdHdSOJEnwfNtD+7G3QhkTWW64ivhJob
         yrToKUVQvxAxVEEf7q81xe369+0f08BTtBSsTvAf/z7IBiJsGFutkD7vA35gWNfqOn38
         47Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXDCyXVdXvICyJ2BNyHw+z1e7xK2MM3zjVOj06C0anV24YKLknJOvQtVPbiqUtwfSL0+nSeKix6bK2Mip8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtrpJr3msURXdo2HI/xcnygoZPkFJMRMiNhQsDbWIVEFK+8SLT
	0kyVA37K80PbnmQCdIDRehl54C/zVFbZ0H2AcwHk2OfuSvzc1w8xAJLwAKcbSM4dUPk=
X-Gm-Gg: ASbGncvc0eRGVipK6txHujJv7+znCFRgyLfhWrS0HEnkbICqpu3XAenfFsh9cZU2Ikx
	EFASWiffuiEEM1TDFFW7DgoFntkK3MzY/YvrZjMlvNBx3UMlVjVGXxcoBFNQJsaEWqTIm6ro3nx
	4lZgHfGruF/CrNvTysu+rcxQMMkRfM6CA6lwZ6DyWFtPmKQU1WFQci+TwddjqDUCEAUlRNX0tZQ
	o77bO6pa0xs37n/BsEUgTAxUNaiOMEe5NycuO0anWU1arcUhjqxh2kM8K9QaGzDhpu4XTcecVaN
	LxEpDtw6aRux9+4Xt5UbdDT17byO+PAIFQQK+Y+oNXvXcsD39rq/HGA0xYarpQdfcklYtmJvWhv
	IMRcYqc+xhf5r8AjWPC1dDAJ3mw4=
X-Google-Smtp-Source: AGHT+IHczsI0rrLUONRdJrdFfmVYfViMf6wrSC9S1N+ePao3CEYpjrXgB6Zm5NwMz2CppJHb6eEdYQ==
X-Received: by 2002:a5d:5f4b:0:b0:3a0:b84d:60cc with SMTP id ffacd0b85a97d-3c494fc6fcemr1981289f8f.2.1755779434797;
        Thu, 21 Aug 2025 05:30:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4db6855bsm26892795e9.17.2025.08.21.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:30:34 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:30:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joseph Guo <qijian.guo@nxp.com>
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
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm: bridge: waveshare-dsi: Fix NULL vs IS_ERR() check
 in probe()
Message-ID: <aKcRZo7BkfH1fD2c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_drm_bridge_alloc() function returns error pointers, it never
returns NULL.  Fix the checking to match.

Fixes: dbdea37add13 ("drm: bridge: Add waveshare DSI2DPI unit driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/bridge/waveshare-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/waveshare-dsi.c b/drivers/gpu/drm/bridge/waveshare-dsi.c
index 01c70e7d3d3b..43f4e7412d72 100644
--- a/drivers/gpu/drm/bridge/waveshare-dsi.c
+++ b/drivers/gpu/drm/bridge/waveshare-dsi.c
@@ -147,8 +147,8 @@ static int ws_bridge_probe(struct i2c_client *i2c)
 	int ret;
 
 	ws = devm_drm_bridge_alloc(dev, struct ws_bridge, bridge, &ws_bridge_bridge_funcs);
-	if (!ws)
-		return -ENOMEM;
+	if (IS_ERR(ws))
+		return PTR_ERR(ws);
 
 	ws->dev = dev;
 
-- 
2.47.2


