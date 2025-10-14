Return-Path: <linux-kernel+bounces-852078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E15BD81E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF17C3E2B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8332A30F801;
	Tue, 14 Oct 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doLUHXZu"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5930F928
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429603; cv=none; b=PyhENbu2xwXRqAOhe9au8loaiNi2rvbWAF0+hyCh14cF9o3/ueRZGBFSXYrQw5Ow2ahd3b6UVz3JYhLw/pqD9nMh7ey8pZ6GFFvlgrd3SM6E+s1BhfTBqqsAkFPjfanb/LE6jEj+emG9rhawl+CH6+7+lsaiiZ+7EZx7+RaxjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429603; c=relaxed/simple;
	bh=Qjf5s9p3okVSF/8iwSV6tY3wMOMvdfYVeDRDYwN+sNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpfW1OqxxqRbYO/ItDgI2oiWcRi3OXsdRXI9MYrsGVJdUasHTlpjQkYUrwCDkXA6OnstcM4yK/ei8WpJ8zoUFwxaCgUHzrLqNcz7lfHada02Sgtp+hXR6oXimBE44mrdZzAcu4qicGujk6iziUNwXm0qZvKTwu7Kq3p3L8aKXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=doLUHXZu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e5980471eso26900415e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760429599; x=1761034399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=77ONa64qN0g6cheWy5Vrvof/4mmnbDRUL6LLOyJY7B4=;
        b=doLUHXZu3judS3oaLBhy4XJmeVmfP7nCAhSaUxdP+39fLYRcDGswKLkThmvppzErej
         uN06Zxw8Q5eXyBC4H7RqFFn3xXQCYvWZ3whC+WArZ9moN34cQFXMuqQnLPNkF/PUUbuZ
         gLEAOcaiSDfqMIBh1aZL8estrXdq6KgwmzHyuXgTzHolaNFLNj48VnDHX18Q/MzC06m4
         e3pshSCYSp/jmpvZJMmnfZeD/swnMmoENxRHBCPLcEQPv4yxol0wRbdLuhuVHHzIeDU9
         reloLlypAVss18H6wPSoAciB9+0UL7yiLl/HsXUMhCiGoN0EGuvYyDNjq7rWNQC1VEWK
         Ceuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429599; x=1761034399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77ONa64qN0g6cheWy5Vrvof/4mmnbDRUL6LLOyJY7B4=;
        b=ET+bhjPsXWqtznSPnFrt6yVH12ievI55fALRigOZKMdPKlqD0HAln+b0mxQxp+SQMg
         R8hw/8xA21kwQ0aPHwqThZAKg5w/Rq0VbgrjxXl4p/YbNtpt+AWUyMfjf3TKjqh05k0i
         rYX9CPx8F7/59jKaQHsnP5qM0vsdI/9V0I/LZuMczdOa4X4GI4OQv9CQ/4TxYHXAz+Ns
         bAWOfTMAwDvDrgh6B1WavtmrmxkJg0/hz0436NVuAeH+mJWkjGysLnR90GnayUQGWZcf
         xTbz7s/0U0R6xGiUkSnMK1d+wKljZ514EbPdJYz3Vdd2nVpxxOVwQoaKZZw1Au1EUpub
         AWTA==
X-Forwarded-Encrypted: i=1; AJvYcCU4XUvwHqRDZ8r7yvxCoAI86DRXB1wwPbUvNnAAy6QhmL7fYbh9O21q4LBBpoVr5WLEP7Gs6pf1H/nKAhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTOp9srsZyDSLx2yvf/RomY0tBn/so8YVgZ/vywdutS/vCT7W
	AztJmFhr5b45L4dgXzaNXIbZTiK111z//bwyuMLtKFFVUxHCCO0BHPGT+9m1F5aypk4=
X-Gm-Gg: ASbGncsWoi3qp9BBJdkcBKNV0jhwRXCTxtnSKj10PXneAMYEEoINV2VOuHSX5ee5I6y
	j/x/qCoY/YNr0KJrIdsNxD2Oo48HgS73XCqMctDO6ipt4PffJ/zvTeiMVWuq1dMbne5y3G9Uq6B
	kOIckfrIif+QnoKGoX32qcACZISyIdfCFZTa2KTjHEY5WfzJt0o1gU63C5dpYlSYGFNFgsC7VMl
	FpvOSjwLFzq3rhyt7aljQVsMFD8rlvfJwQCnIXjwQil415ZMwZmJPFdqZ8c1mTeVfo2k606WF+S
	Rc0/x6rgZvPJanqrNCh+ghihSUPzZFpNXMMG2ZK+sklLCy940yXB3N9BBLZ/xH7pkxaihD6CmbO
	4raNBPTRH3Kb4b1e6FbAOi50tCSuhDGjtpVdH2mhQdgB1/waiqAPxZyG54SNC1Q==
X-Google-Smtp-Source: AGHT+IFbab0I6IbunJxw9DMnNGmlNTMAcT5O1ylJxmLdoG5nQ5JswxZUKVkCCcAgGghuYeWd5vIj3w==
X-Received: by 2002:a05:600c:46d1:b0:46e:45fd:946e with SMTP id 5b1f17b1804b1-46fa9b078e2mr170662745e9.31.1760429599330;
        Tue, 14 Oct 2025 01:13:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb49c3eeasm225967545e9.14.2025.10.14.01.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:13:18 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:13:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: Andy Yan <andy.yan@rock-chips.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
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
Subject: Re: [PATCH next] drm/bridge: synopsys: Fix an error return in
 dw_dp_video_need_vsc_sdp()
Message-ID: <aO4GGyJLCZEwFYL4@stanley.mountain>
References: <aLaPyJrFsSFuqC1R@stanley.mountain>
 <5f9e8942.7fec.1990997b4de.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f9e8942.7fec.1990997b4de.Coremail.andyshrk@163.com>

On Tue, Sep 02, 2025 at 04:42:41PM +0800, Andy Yan wrote:
> 
> Hello Dan,
> 
> At 2025-09-02 14:33:44, "Dan Carpenter" <dan.carpenter@linaro.org> wrote:
> >This dw_dp_video_need_vsc_sdp() function is type bool so returning
> >-EINVAL means returning true.  Return false instead.
> >
> >Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
> >Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> 
> Reviewed-by: Andy Yan <andyshrk@163.com>
> 

Ping?

regards,
dan carpenter

> 
> >---
> > drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> >index 9bbfe8da3de0..33be4eae2b20 100644
> >--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> >+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> >@@ -1149,7 +1149,7 @@ static bool dw_dp_video_need_vsc_sdp(struct dw_dp *dp)
> > 
> > 	state = dw_dp_get_bridge_state(dp);
> > 	if (!state)
> >-		return -EINVAL;
> >+		return false;
> > 
> > 	if (!link->vsc_sdp_supported)
> > 		return false;
> >-- 
> >2.47.2

