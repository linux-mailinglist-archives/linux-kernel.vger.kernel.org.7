Return-Path: <linux-kernel+bounces-808611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B7B50243
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E257B07D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F2352071;
	Tue,  9 Sep 2025 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QumAJarR"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9526F467
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434557; cv=none; b=PSyj2twQLJC0+19p6g8WWKGOozARLievg/NJPr8DK6ny1JYdL4mBkH9+Y07qom1O9nPus4n6Su4IHJnlISjyv8VCMUxSeQ9jRbFf4qtytMT82/ds3IVzfoU509+FUDkgvgPd+HVXQfj6BGZkGp0q9kAUh5+4bAy6LnEJT+IpNNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434557; c=relaxed/simple;
	bh=7Z15smc22BjF1dnNwqHWT4Q61K0HQySupMCHoRvenSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwrgGK/2vFizrFuoaDowES76OcdbR+WpwgIr1vAvMxKkltL8c1D8cjcj5xz5aRNcqSPZ1BLYZPV9pjaU2svtWkqcyDwQrMhwDV+/zKUVc8LjGhsiTG3/BPEMscGwE9x6TucnNBYjrz1xFOgonrUcELwJRBNUNRHHbYc2s6cjXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QumAJarR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso3848807a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757434555; x=1758039355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEiPxhZen3QXZAobK2Ga2iD+ttNiESa3yuRWHgPHltc=;
        b=QumAJarR8dIk5rsyPI2UA8v8Ta0X33RgJemxZI935DH2hEdiU2AxZHhFhwit8BPZ69
         WUUXmWLrQDrV1+mvlHyxIjf0+fEpt/OUgcD9/y5Wjj8TSXRd1g6uR+f27EkZdN07wueL
         488e/Gywvp1n1sEDUJ/ffbWiAYwxsaKOXf2qbMbzH/78Uzylm03j4bbQcGx2DBycga/d
         ex3A+j65nGUebJcQqWzcUOfCnuELk/bFr8rz9IUv4Y9qpivXboSxxoikg6Nil6f7XpPP
         kXoBwQK3n9PQgEojdcweoufKFqKcGHr5WpwD1Sp0zBMa6NhwnwlWxZZQNvibnyBWqKyI
         yRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757434555; x=1758039355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEiPxhZen3QXZAobK2Ga2iD+ttNiESa3yuRWHgPHltc=;
        b=lFrqEAc2AB6UYPFuOzCMJ7dreYQstaCQKF/1afssPTPw7TTGIUaS1QynBYr7UGTSQI
         KIf0xsOxu7RR5adURtQ5fD0bjrsRIKJezx5i3tpYKxFxw9iE0FLhbMMonh2WorJulNVt
         b2II4tgYm3M2Jl265zRlb6KEiq5GYvsb92O4otDF3VEOzHHzArYRBLV8rZcNhglCIhJV
         hEj+gSrnxuEccX3vx16b3yRPX9cuURUbZevstmwctT55i1nGzpA9Sdygl2z4ESjYRtJ7
         pfrjTUv2cThc28a7BF0PknhzOZVRJICvDbzCLj/wlv7rXrvB0kN7cCM6q3CNu51pFYzX
         Xstg==
X-Forwarded-Encrypted: i=1; AJvYcCW6FgBY17c/+pE1V8sflt9+qN3Rqcvm01rB2XNaixtn3HuuY72F7jtiwby+mkRrOBhMWUM7opVCR63plOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkT+CJ6huEJuMGWpEUUYTiFLsFAwkczp+/RHfCBQzAYc8wyYX
	NFbVIh1DWp54XsqBLwf4iy0kO7R5qZd09UvPvYu3CsyDUeDt0HoZOPaZ+qipU2QyXfk=
X-Gm-Gg: ASbGncvos7utChj0SILz+G8vUV84IBzjiDSCd36ODVCHQGxkVjiUWiVvLRZVqDsNlPf
	/V615O7n28sHVNf45WPoP2Ktnz/2dZ1Gi1zduA7hp7ug74RTM+qKSS2Mw9OY0pfjOaxGtkHcNXb
	a7KIUafbpd+LhFrcquhva2ChRjDnKt+hSgY8tXtA+W9pfYthiRpAtGYxcHgvIlzZ2MH0osgzhOd
	5goOsI+u6ypLr8dJMA6/p0sHTSWxDg3uGGv1n+Mt+paeW9eQBLLBXa8Y+vD+NPP6jzIkLyTMnY0
	JCBNinfAksqgPPii0X0DqmjxJ+eaDgfEo7sTyAALrfA+UxfsRlHWFlZME6H0ERGRkHzCRAXpj9r
	UWthi1IQC/oOH1m/oj0aIBeK+sdHvo5YcBZQoSoIPFr1xPqFz06r6TJw78ZzDLbZT68ppk0cG0I
	HHEQd34u7gL8ZcyjNQIcwG2SDdXkOPoJUOeAY=
X-Google-Smtp-Source: AGHT+IH55jBXQuGrRFWB7QFDwp0aHH2LNHjhqhfqYbAFcay2HL31leHRvKu+CE2zXWHS10Yrl/LklQ==
X-Received: by 2002:a17:902:e884:b0:248:811e:f873 with SMTP id d9443c01a7336-25170f37b15mr169800035ad.36.1757434554322;
        Tue, 09 Sep 2025 09:15:54 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e31e:18ea:d6c1:d90e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27def96esm2062685ad.55.2025.09.09.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:15:53 -0700 (PDT)
Date: Tue, 9 Sep 2025 10:15:50 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] remoteproc: imx_rproc: Clean up after ops
 introduction
Message-ID: <aMBStih6Wi_isn2N@p14s>
References: <20250908-imx-rproc-cleanup-v1-0-e838cb14436c@nxp.com>
 <20250908-imx-rproc-cleanup-v1-6-e838cb14436c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-imx-rproc-cleanup-v1-6-e838cb14436c@nxp.com>

On Mon, Sep 08, 2025 at 09:07:39PM +0800, Peng Fan wrote:
> With the switch-case in imx_rproc_{start,stop}{} removed, simplify
> the code logic by removing 'goto'. The last switch-case in
> imx_rproc_detect_mode() are no longer needed and can be removed.
> 
> This cleanup improves code readability and aligns with the new ops-based
> design.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 5fa729f4286f6ac939357c32fef41d7d97e5f860..ed8395b097d07d02e5323550ff497819f9b95ad6 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -323,14 +323,11 @@ static int imx_rproc_start(struct rproc *rproc)
>  	if (ret)
>  		return ret;
>  
> -	if (dcfg->ops && dcfg->ops->start) {
> +	if (dcfg->ops && dcfg->ops->start)
>  		ret = dcfg->ops->start(rproc);
> -		goto start_ret;
> -	}
> -
> -	return -EOPNOTSUPP;
> +	else
> +		return -EOPNOTSUPP;


Here I would simply refactor this to:

        if (!dcfg->ops || !dcfg->ops_start)
                return -EONOTSUPP;

Otherwise this patchset is going in the right direction.

Thanks,
Mathieu

>  
> -start_ret:
>  	if (ret)
>  		dev_err(dev, "Failed to enable remote core!\n");
>  
> @@ -380,14 +377,11 @@ static int imx_rproc_stop(struct rproc *rproc)
>  	struct device *dev = priv->dev;
>  	int ret;
>  
> -	if (dcfg->ops && dcfg->ops->stop) {
> +	if (dcfg->ops && dcfg->ops->stop)
>  		ret = dcfg->ops->stop(rproc);
> -		goto stop_ret;
> -	}
> -
> -	return -EOPNOTSUPP;
> +	else
> +		return -EOPNOTSUPP;
>  
> -stop_ret:
>  	if (ret)
>  		dev_err(dev, "Failed to stop remote core\n");
>  	else
> @@ -1000,13 +994,8 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  	if (dcfg->ops && dcfg->ops->detect_mode)
>  		return dcfg->ops->detect_mode(priv->rproc);
>  
> -	switch (dcfg->method) {
> -	case IMX_RPROC_NONE:
> +	if (dcfg->method == IMX_RPROC_NONE)
>  		priv->rproc->state = RPROC_DETACHED;
> -		return 0;
> -	default:
> -		break;
> -	}
>  
>  	return 0;
>  }
> 
> -- 
> 2.37.1
> 

