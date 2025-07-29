Return-Path: <linux-kernel+bounces-749576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D3B15038
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173ED3B4C40
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A84293C59;
	Tue, 29 Jul 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gm/UWWf2"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4DB293C4C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803276; cv=none; b=cZLHrMijQPCRj6jsE+SssyyPmQmbFYQzrRHUv80K+nX+5zM5eyO0EdCZNt2a7W2TQYWhLaWuF7kvo2BMGaEDXrnKaBXCzyWBgHGCUKUMbfPWGE3GeI0ynM9N3X8CYsqST67VTsmwtMM08ZrCxEZiqZ5qM3SSwXvPxdap64SOcNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803276; c=relaxed/simple;
	bh=i5h0os/YtNwZTZidzFNsIxF45bH5oA2E+VUtDTiVQnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRsoTugE8fKAhuxN066Lp1+ODHs3x33zO8PS9QV0rkZyBRPUIXr9a6SOaxRC63MqAWbKotCrWFF2Zg+Sqs/pUu9+V3kwvea0Bwjy1ZhgEpKojAX/5u9Gk1JaSJ0apmwaOfZXSKHyyq+6ejhqM0545UusrXU/HCMBojIn1yCeTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gm/UWWf2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2403ceef461so17500185ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753803274; x=1754408074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMoqKFLALEq+ZmPG9wCyqAsQPACRG2hPVvh+rmUE0OA=;
        b=Gm/UWWf2IRaDM1h5HLY13taz1WRy6vjT3b6QiDStPs9e+ceR2c+mV+FUvwPU1Bcf3N
         BdxC7YeuFmxe0gVrhusU1UqUiH89LiTLcRI0qWR9lQIwN0e9zMe52bzDn+blQ3GL1pcP
         BCaVvvAnuy8HJrdaR78BWALZcIABmqJmu4kCyyFLpCOCuWK+0kvIVNlDsKIcAQ22ffXe
         vGh/QPX8xhkRzeV865xNWr+U5RDKJhB0FwoIM55QPXidin5cGr1rMIKj3IF+buP5kqNH
         ItzRISFhOKXYBcMGxVlTiz1IQewavWwMP9zdCSRBXKcy07KTnBuAH4whI/sKkdQ0eRVT
         wWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753803274; x=1754408074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMoqKFLALEq+ZmPG9wCyqAsQPACRG2hPVvh+rmUE0OA=;
        b=W/LQVOo1OaHJWxo9FXJN0eVRJTKvec85JspUthjj/8APOBUgh1501RKDFWyQuEccD0
         aBhMZnHg3oBDSyoICLY8B+HE7N8BnbcQMLj7fsCKoW7IJ1q+KC8QKlnVQVUMCBlEt+PW
         DB105uPxxjZIFeoyuECLaYF1wQJ+UKr+lDkFAVlhhi7qnEXb/AnwP5tT1EgenauOALVs
         G2wNRWPqkHePOkCD0olsl9qexYuSyxxTeyZ4aFeOs0WfxxXFXXj6oP4jclCX5CbyRUVO
         qPnPep63EvSy6ziDhtvdulDDd6M4LzukVY+Cf6/pW+OtN4QIHdoABDGED8Ch0bVnIdtH
         T2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXtiCXZWB6aC78HRwxfUIxiOeLsTJSfMt+jCGylv7Mm2OHTDudJdlhKrWzYM4VASUF83agYg5E2YnXRJZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR9We4QQskvnz2zUogGS1W7Y1Y71SKIjusAfDxWfbRm1JzEFKg
	fYRh0I7dYhBSV77x2GyFgKG0Azpkhd6rhX342fCqYrmtU2C0XaKs9CdpucufbLsK7hs=
X-Gm-Gg: ASbGncsiMQ7dMM+veHk9KKAQe0i5876v88TR28Zvf5Q8UMrBDPGBwdRe8F1/NCNL5R7
	bqXqygaqPV2uCMGvSkLnatUROO+Tvir4yFVAHtl5XSmtpf1VyISrndCFf+nqi5CimRIcYp7f+cW
	uMWMejV/nhIVnvkP+rA48khlTbb58O+fZbsqs1xymZv+fbcOWyvqGYthLXe6t01nHepwMA9dLKA
	pzMJHf36j4WO6WNUGLCu+WV1xybYHmo2p5CuyZsgprLkA5H9hODsFtaMqP/va+U2qVn7lSKO4mL
	pMx/klhvVJfeMTFADXtPwuxLJrGBc2IDvrc2OSrdZAGIyUHTE5b8mPEyi4GDYjoBUwMfeF/Dvee
	Y3pmWM1/k/t+dCWEq4fRfRLsZug==
X-Google-Smtp-Source: AGHT+IHlEsBwMee/kywPI2/tvT1g4ScsliyDmtiDbB1WAnykD0Ma1gjgSCy2s0F1viosLS+e5Kxzqg==
X-Received: by 2002:a17:903:2ec7:b0:240:5c38:756b with SMTP id d9443c01a7336-2405c3879e4mr62619735ad.14.1753803273589;
        Tue, 29 Jul 2025 08:34:33 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8920:ecd3:44e1:110b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24052e03863sm32464055ad.41.2025.07.29.08.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 08:34:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 09:34:30 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, afd@ti.com, hnagalla@ti.com, jm@ti.com,
	jan.kiszka@siemens.com, christophe.jaillet@wanadoo.fr,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@nxp.com,
	arnaud.pouliquen@foss.st.com, tanmay.shah@amd.com
Subject: Re: [RFC PATCH] remoteproc: core: Do not process carveout and devmem
 rsc in attach mode
Message-ID: <aIjqBi3X4hWGsJLP@p14s>
References: <20250724133144.3776839-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724133144.3776839-1-b-padhi@ti.com>

Hi Beleswar,

On Thu, Jul 24, 2025 at 07:01:44PM +0530, Beleswar Padhi wrote:
> When attaching to a remote processor, it is implied that the rproc was
> booted by an external entity. Thus, it's carveout and devmem resources
> would already have been processed by the external entity during boot.
> 
> Re-allocating the carveouts in Linux (without proper flags) would zero
> out the memory regions used by the firmware and can lead to undefined
> behaviour. And there is no need to re-map the memory regions for devmem
> resources as well.
> 
> Therefore, do not process the carveout and devmem resources in attach
> mode by not appending them to the rproc->carveouts and rproc->mappings
> lists respectively.
> 

I think what you are proposing is logical.  Arnaud, Daniel, Iuliana and Tanmay -
please test this on your platforms.  I will also need another TB from someone at
TI.

Regards,
Mathieu

> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Testing:
> 1. Tested IPC with remoteprocs in attach mode in TI platforms.
> [However, TI K3 platforms do not use resource table for carveouts,
> all the memory regions are reserved statically in Device Tree.]
> 
>  drivers/remoteproc/remoteproc_core.c | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 825672100528..ef709a5fa73c 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -640,6 +640,20 @@ static int rproc_handle_devmem(struct rproc *rproc, void *ptr,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * When attaching to a remote processor, it is implied that the rproc
> +	 * was booted by an external entity. Thus, it's devmem resources would
> +	 * already have been mapped by the external entity during boot. There is
> +	 * no need to re-map the memory regions here.
> +	 *
> +	 * Skip adding the devmem rsc to the mapping list and return without
> +	 * complaining.
> +	 */
> +	if (rproc->state == RPROC_DETACHED) {
> +		dev_info(dev, "skipping devmem rsc in attach mode\n");
> +		return 0;
> +	}
> +
>  	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
>  	if (!mapping)
>  		return -ENOMEM;
> @@ -839,6 +853,22 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * When attaching to a remote processor, it is implied that the rproc
> +	 * was booted by an external entity. Thus, it's carveout resources would
> +	 * already have been allocated by the external entity during boot.
> +	 * Re-allocating the carveouts here (without proper flags) would zero
> +	 * out the memory regions used by the firmware and can lead to undefined
> +	 * behaviour.
> +	 *
> +	 * Skip adding the carveouts to the alloc list and return without
> +	 * complaining.
> +	 */
> +	if (rproc->state == RPROC_DETACHED) {
> +		dev_info(dev, "skipping carveout allocation in attach mode\n");
> +		return 0;
> +	}
> +
>  	dev_dbg(dev, "carveout rsc: name: %s, da 0x%x, pa 0x%x, len 0x%x, flags 0x%x\n",
>  		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
>  
> -- 
> 2.34.1
> 

