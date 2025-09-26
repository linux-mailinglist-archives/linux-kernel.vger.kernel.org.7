Return-Path: <linux-kernel+bounces-833651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E7EBA28F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D6E1C24490
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3727C872;
	Fri, 26 Sep 2025 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2yuv8wA"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045E27CB04
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758868981; cv=none; b=tovIOo65Nqd1uWk9B8euZ5eedWBVSYbUKt5mR1uJpntkTrUfvvmu8ha8JJ2czfBEg9wR59FP1yBeKdKOUR5ZuY7BER4JYwvvZmIF+us2qG9pdc+cM5lyIE87DxnPYU/LYgS2o3q7iX6jvAhOsR2ZsfwuZn4iY0NSjC6qSOQF1sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758868981; c=relaxed/simple;
	bh=a2iqlMlXKulAVhFK87LDpoqYm2gEJ7HHVf64+tU+tC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYzaxJVOMTSYOEyShm0Q4SGgJwxfVRopTeTp03iDvDApqsIhhqsXkN/SmshuRPzwMwiATCVGXynmIksR8qzM4GqGhS86vNqBkvqZ5FlcvIGE/DhIY6vE03gAOkRQdKK9i/5M5TOxRfN/Oq+68AYMl58Gnc6EpH68PTeQordbMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2yuv8wA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e30ef74b0so12408395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758868978; x=1759473778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hPWagNOQmEjTvnm5Z1LNkDjaoDSty3o7kgmSw7FvY0=;
        b=y2yuv8wAhanxw8nc576nze2PTG3YMJ157vT58IewakguxRSNEGATKXsdTaGgxr9W0N
         zkcUdaYbrRc/Ax9AhsoXjWxawxChPzZ7d8Zv7IZYNm7/jmwp8lhnexnl7sNsJDRuL0TN
         7edx+QJlQv4CaYQkIbvzl8yGUAmaFde0SXgkPKHMU+lzo8SS67F7UkiVG9Wg6OrAtdJt
         MFkQkY1pS7QsNapX7BI6CvDui3D30t3KwMWK6MeRLtu5rOz+u5esv76t4eY0ijzVAe53
         rAtXjNXZoTz5EKovuVnIS5VZMa5FetDhUKTNZYve8l9ikTHLhboofHvtlOJ3GfQzizdd
         1HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758868978; x=1759473778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hPWagNOQmEjTvnm5Z1LNkDjaoDSty3o7kgmSw7FvY0=;
        b=UECxGXuduyApT49gBK1sA4wdoVFMha7i6b4i7isjk1Z01uxBljQyGReAd0yH1CFA0q
         Qj7+qD0kFqp+bRpYmTLc6ap8HNYCi5BD6ohDxUAFOkYYlOlJLE9KUGPP7OUODOjp/7sf
         5BnOd4F6Mmp9ClPG99cxTwdjP3ugCoIOJxNJYOV5adlfxvJ4CtOate34+OdisAIYrWdE
         7eVpEFNpqjeQiA7pcrLO4z0RTA4sHXRF5yh8m6DX4SQfKQV/Ql5eTp/1kowgppGbZN0f
         fEd8a5DbJQ5bMudOkhI9W7/DIQ1r4Kf4h5Suo0xeJHt/EU4GIXk/aN/aelY4Ufq0GWBi
         nSTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE96mYUgZUX7AkTnGpesIspqIILTGFvk+3nbQOgBo6VQIw6AT0kpyQbN5t8BTUfXDFZh+CSQglD/B8Bqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlxpAqfYxcDbuBb011MJC0XgrNfEu1LoY0df1TDuEchLif/NC+
	43PL09sDSqNkz7ehdgjaNdiNdpV7hQ7vywxJvOSrJU+Xju01RlwjfWV7C5bTtSY6+2Y=
X-Gm-Gg: ASbGncsji8NMDL+68P73+pc5AoVHwthixEiyWX6Drm9//KdKe/MhIPfimLzxPbMzrVa
	R0XLdxReqtQxrpMHzzSzBlL4XtQAf29rOL8VP4SawXPrsNfJkUhY11XnlNeLfT1nO51tPyntHxZ
	2QLQL1a6AZNPMOpSfumY13F5GNUl8jWE4a6Cf6uOq4Hsofs9OsNzMqRElklDE9BYg2ITUdcj/kC
	yxy8trPH8KJKO2FnQ+epnHhfKdxCsNXZJv36jgAbk7fZzdc+jXRZlzgxHyzVcdBLyOlVTyp4jU9
	7A22NRuMJwLJvZ95WO31sPpNrkb/lrbSXNJzy/Jcb7jPXmwIMeDL1ppEAFJ2u/2IA/ZDBVmWGDI
	tMH+1ledfWtK4K5yd1CWjI+tjCw4tXRlZ
X-Google-Smtp-Source: AGHT+IE4RNDa+SBbyedMcpjrMBUEZfbXwj+HO0zplrjXyPKT4StsRppVNBzD/YjIofvWgF+YJsMPMg==
X-Received: by 2002:a05:600c:5297:b0:465:a51d:ab with SMTP id 5b1f17b1804b1-46e329bbf5amr63328455e9.15.1758868977931;
        Thu, 25 Sep 2025 23:42:57 -0700 (PDT)
Received: from linaro.org ([86.121.170.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e332070e5sm30629935e9.8.2025.09.25.23.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:42:57 -0700 (PDT)
Date: Fri, 26 Sep 2025 09:42:55 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: Fix adjusted mode clock check for 3d
 merge
Message-ID: <co66vf57i4od7bpd4gwv5ztonjecvpp4nzkrvjjuwkwvp3xkar@3zatxwnwpzp5>
References: <20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com>
 <krinjfouhgak2fvrv4runtv4kbocvfjpwxq6y53no3ajo3ykih@ooucnj5peu7j>
 <g7kqqed625hlz7yq5uwxyimfupxryr2et5jxsrmgw7jk5x5zg7@zdrgqf63n4w5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g7kqqed625hlz7yq5uwxyimfupxryr2et5jxsrmgw7jk5x5zg7@zdrgqf63n4w5>

On 25-09-26 01:22:07, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 09:51:28AM +0300, Abel Vesa wrote:
> > On 25-09-23 16:03:50, Jessica Zhang wrote:
> > > Since 3D merge allows for larger modes to be supported across 2 layer
> > > mixers, filter modes based on adjusted mode clock / 2 when 3d merge is
> > > supported.
> > > 
> > > Reported-by: Abel Vesa <abel.vesa@linaro.org>
> > > Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")
> > > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > 
> > Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> 
> Is it also a T-B? ;-)

It will be, by the end of the day. 

