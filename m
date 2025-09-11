Return-Path: <linux-kernel+bounces-812128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE5B53353
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785BC1C261FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCAE326D49;
	Thu, 11 Sep 2025 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXyEsJH6"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B4324B16
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596259; cv=none; b=rngDIt0quRyYriYHDn4KAgNLR3X8F2Ixrk67kTzHj3ZtBmBdg4Oq1n5G1bRd6RGQM9IcyK/M4LfHzKAVZ9DYh2PNY0UB6R0uDn5nEM2NaXp2JcDw4vTZ92TNY+/YHYUTOaXfQTFFYLpL9X1AF0dWXdC5+Y70CaisXJFBDfp40jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596259; c=relaxed/simple;
	bh=y11RZU91qqT+9OqY84wNPfLsXkcQjITVyypPfQ+m9DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU1gOiG1gLVUYqQJJC4mvvywVS8qbajSoMWpYkNB4Dnv12F6jdfWUXnNB8lb4yJbowBxb1jJwdU4MWPbkRK1AbMFdI/2cagDMDdtjutJu7pXOxtxzppgJFvDCMY8t3ibD48iCWwKiz6isXyiUmbnslAHbzDujUhYWdI6HtrpkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cXyEsJH6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61d3d622a2bso2724358a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757596253; x=1758201053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fICK12mWNRBHNb8epgyR7UU//hrM63BrRhLGMx3EInI=;
        b=cXyEsJH6eOo+DwJcAdCVR3iNKEDybDke2yNhMqHc/SYkvd5i17dTpI1QLiRO8ELn+I
         gRzniKjTHPXk6iIHDrSfOXVAzVRSIrfD5PsriMAgEQhu8rr/SzVW+AEQnOWSOit4aEhN
         CFAH+RJhC/BKA+evUapFmdi00piVXMrbolOO0wDCSrzrD44V77kmE2Nk0tXedFrqdNRZ
         bOghWiURj7cATmIGFVUfMk7Qe+yQH1f848nWlx0p+NFNv7GHuvaRHT5nbHBJi0RjGKNh
         ZHT3c9hpyIfDu9JOl+YCvAwenM8IQmAsl3Z/qqEih5hAPrrZXrupDuvY0/Q4rZHmdfk6
         NLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596253; x=1758201053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fICK12mWNRBHNb8epgyR7UU//hrM63BrRhLGMx3EInI=;
        b=AWGAq7Uxa6CSxw8WIkHwA6OtpIZq/ULtQQLRtNAQ0ZLPVrOWY4TDavTb14MdkNiEMU
         jvznfjV48YKS2UlJ/N8szqExH9WcIgaLIT29ljRcuFSOqIpI+5dTlpNuaVQlAm0vknFS
         D6kL41EqVpX1qgYVjLdN9vwmGPEKw6MIVKlw/cI5la9v9LkL49gInC+mywHPK6GvcWOC
         liPQDm6TzftoNwTgBO48UHjme9Kfc02gndOyg8nsmx9l/itv9i5Oy+X/3Kev87COpVbQ
         wE6fRwlwUVHzVphkQqirAUE+Pen5wPlBcGdjb8FGm48qTvuVwlDUn1nePunTS1OmYCyB
         GCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE9529xq6xS/JCPsiSDh7xdAMZI2p7HrtJBwVC/uL1jkSahHEDVoeS7YpTRFWe9y/vQC5OEFC7g1yMc1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIq7o3VbJBy7xMiQuy+ztryFLV1i+g875A6y1QWOQTadunOge
	ighcNZ7B+cs+Atsb26PwPsFnCZYWIvQUUnYcmQkelwp4DrkZIv2iy2vAYj8UhCkDkVw=
X-Gm-Gg: ASbGnct7yFEWNXa8GEYfl0DwtR0DAkrU82cI1pZYuApPBKNuQTqS0CCgP3wYLeEx/UH
	bMW8nHALmxvH8XAHqLQJ4h8X9PFmRQnID+fo8wsTbbiyE73N7KnJZjnlalGeOaYJgkTy6CpoEKD
	9ky7z0D7ckbT1zB/P3Hp8vzUoI++dcoGbzxk/NPBdspPhOSN5wfS2oiOxVm3lncz2krfhKsajBh
	mxsf7GOy4tPvBEER5YkGMPMfZArCZ0Pd/4xOwl5Km0Fir5KVUYAhPeQfhNfLDJcCQ9+250CFElq
	kKscpUEBu+DOTF4nArK+rzOGNL70lPJnXV6Ku6sUQDL+JxUdE/JM7ytAJJ+tjXQEge/xl9LyJAv
	ho2j+K7+WB3SRtaaBf+mb/w==
X-Google-Smtp-Source: AGHT+IH66fznEUgFxllILMqdvheHS0RsLBD6Wse+F7QEzo8HkwTr8xnUsQ0CB7hpJuztOUV/n+dF7g==
X-Received: by 2002:a17:907:7205:b0:b04:3e43:eca2 with SMTP id a640c23a62f3a-b07a633d68emr423207366b.13.1757596252775;
        Thu, 11 Sep 2025 06:10:52 -0700 (PDT)
Received: from linaro.org ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da250sm132121066b.9.2025.09.11.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:10:52 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:10:50 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] drm/msm: Add display support for Glymur platform
Message-ID: <kasmte3rxr3ukz2eqbwlzbpeam2qq2qimzdqta5dl5xsthnokc@smvts77lhirb>
References: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
 <xjtg6emrb7svloz2fkaotfbj4m2wzmddxdsdnjk5wkbmocqzmd@l656suk46pkd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xjtg6emrb7svloz2fkaotfbj4m2wzmddxdsdnjk5wkbmocqzmd@l656suk46pkd>

On 25-09-11 16:02:40, Dmitry Baryshkov wrote:
> On Thu, Sep 11, 2025 at 03:28:47PM +0300, Abel Vesa wrote:
> > The Glymur MDSS is based on the one found in SM8750, with 2 minor number
> > version bump. Differences are mostly in the DPU IP blocks numbers and
> > their base offsets.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Abel Vesa (6):
> >       dt-bindings: display: msm: Document the Glymur Mobile Display SubSystem
> >       dt-bindings: display: msm: Document the Glymur Display Processing Unit
> >       dt-bindings: display: msm: Document the Glymur DiplayPort controller
> >       drm/msm/mdss: Add Glymur device configuration
> >       drm/msm/dpu: Add support for Glymur
> >       drm/msm/dp: Add support for Glymur
> > 
> 
> This will not work without the UBWC config for this paltform. Please
> include it into the next submission.

Ofcourse it won't work, but wouldn't the UBWC be merged though a different tree?
I thought I should send it separately because of that.

I'll add it to this patchset in the next version.

Thanks.

