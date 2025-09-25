Return-Path: <linux-kernel+bounces-831863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DE9B9DBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7334A7736
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200D2E8B95;
	Thu, 25 Sep 2025 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vB67XJ4u"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C262E6CB6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783095; cv=none; b=iC+CiS+rf/pFbHrM5pRY6KjODpgdlGn3EsfgjRYlrAVAZOwX5Jdoy0kySlR4vYcxZlJn2/KaHyaF6SFSIFDd9G8ohkYPi0vntSlbNZofUZM1ClJIhQWQtxgP+z2S2oyqPCoL3X428i5nUdXItJiEXKJ2EJYaNbR3YchcPsdoCps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783095; c=relaxed/simple;
	bh=NSqxoegjOQFW6yp782UrcnZZWCicWGaiYJFgtCGtUuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H97w6gN4/iEVd7VczQ8WAEdqvEunTqeDarBqc0aRDwdV0JBIuoOKPs8njNdQqemRwraGr35yhEsnM4hDg6Gnjr1MCXNJoapP3685zpIDVDI2uR4/U4bapa6AGhI9oa/bQnEMZFxuTWTJl5VWH2QDXKsxB009P/SZ8HUee0iR1V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vB67XJ4u; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so1134268a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758783091; x=1759387891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VaKrha5Sjvod9ZnLzt7kVvC90hBDHE0UcXwFSsoXVM=;
        b=vB67XJ4u4bstLC6oSAb8efw319lzzEyjj+aYD1dQIsImpUkHYCDVviKlYiPNpvsggN
         Hi/Ca9ClrbLyFdrGaH/ivHLP+PRlS4yFOYNGduycVvvuIDclr82MJ6apRe6KtoXPMK/W
         CXh/n2IejeYz7AixDe/+hf1N7q0XBcc4O/I23uCXA0Zy9xeBtiDmX0JsH3KaOAvhqpAC
         qK1ah/uSIcfm/uieMjmbUzDO6WOUeaBq17fXN3VjxnXB1ySMgzb4de5TMNgqW3JCcYsq
         TAtbUzYNRPtldBpMDo0Fk7C7zYZhuBS6Z4S6SoXbD+xkbA93QhTNuh1y2b+kUL/w1VcA
         C4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783091; x=1759387891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VaKrha5Sjvod9ZnLzt7kVvC90hBDHE0UcXwFSsoXVM=;
        b=QxeSF9B3O4LaubWe3jnt19RbMTem4cNL9OnDbuDdbHhtyUDkI6Q1o+6iOaFmlND+Xu
         NzTmprjkLHBptxWcI/ORHpE7n3WJ99+HcR2fm/XmtDgw0DLETCcN48AW4SsqSZ+nHlTJ
         yy1Jk4w/VYG9OuVSf9aOy9D/aseeWKVOh5TmocadmKm52ZgP30tDu+qwQmOO8hbffRrN
         YfnJnfdqgJlZQ9zI8zW/NaQ3EKQzmghcwaVBTcg0msIzzP4v2J09ReeYQ/zCF96zHdMW
         g/rEDZ1ku4SBZrzFCF4I3lOLMFa6CvDf0CXmauFtIA4rojTRc+tlXuHsJ/88gorKCFQy
         Bq5A==
X-Forwarded-Encrypted: i=1; AJvYcCXpMIGALASmvAwV7nxB54B8z13dQNCGlww5cqX4OCMz2i9wtBdswFlDcitPdDeKyuKKvvEhZ75YgzUSgtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7cx2/P/oqCn3PeRRMwI9WJw8XKVY+SdoeJXZjlhfZtDz4ZQb7
	JZ3+5mqLp738iNzqEKQC36WqYbSg42b8jAMjWppa7Z/vlw6tDa2ZBwvIHXa2uRlnYdA=
X-Gm-Gg: ASbGncs0ECSKfJGG934cehiu24ZqvWTgLpoa6Ok8Vjm0yhkeT7fooEiDi2qjJnjQg5C
	NPZfPrs2f5R8hCXiNhvKke2EaPwRWTBXR1eiVBwuzO4Of2wynIffIT2dhaVNhYUL0PkzQ9Nlfwc
	ArvCqZLz11LMVqeZBS7Ts7zcRMXhpSt26Il6E5ckn6cZBizpnW2rc5qXmms4WMrv+7gV6M/1LEs
	N2f97EXJjQmowV6Twn9m0tjcUZOLrwzx7NwSb/pT9K2Ku6xHUpYURoUmrS2XkccbDPEoUA/bGgQ
	moujPu05kyGa0L+867fbTpmJESs+++D6UvBubtV4oPO4ZEF5F/M6gd89URixNqODvrx5gJAQTwW
	LvGb4ocKawMT2Wwhpmql/CQ==
X-Google-Smtp-Source: AGHT+IGGfQ8eA5qoYaBx6N30tlw71g0bFTIZMRs/lzQfK9Y0ST7ZgWV3GMVKow4yUGkj2uKHY4Qx0Q==
X-Received: by 2002:a17:907:7283:b0:b31:5c9e:7ad3 with SMTP id a640c23a62f3a-b34b8da5a4fmr250151766b.29.1758783090705;
        Wed, 24 Sep 2025 23:51:30 -0700 (PDT)
Received: from linaro.org ([86.121.170.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d11a0sm102629866b.17.2025.09.24.23.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:51:29 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:51:28 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: Fix adjusted mode clock check for 3d
 merge
Message-ID: <krinjfouhgak2fvrv4runtv4kbocvfjpwxq6y53no3ajo3ykih@ooucnj5peu7j>
References: <20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com>

On 25-09-23 16:03:50, Jessica Zhang wrote:
> Since 3D merge allows for larger modes to be supported across 2 layer
> mixers, filter modes based on adjusted mode clock / 2 when 3d merge is
> supported.
> 
> Reported-by: Abel Vesa <abel.vesa@linaro.org>
> Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

