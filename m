Return-Path: <linux-kernel+bounces-792155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0890CB3C0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C641BA17B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2333437F;
	Fri, 29 Aug 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvJ7JhnV"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FA3314AF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485365; cv=none; b=bODOXyk6uf+anDTnd37tvrAVOSNHOh3bNqHVkyGmvZOxA2J+PzuGakLyvRDv81Ouucr+6BS0ghH7oPZf1ywb9rh39V5im+nz4r/8tGI7ksAm6wN4QRE27dK3Ps2qC1kJE36/6XAXGLLCCMCQ/R+D/R0eTjWH/9GcHc9S2ccVa2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485365; c=relaxed/simple;
	bh=g6DPg+9G+u+KXdS/aqqNtXMfZdZ9CvhJXM+Xcml6A98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSYsUkUFaj5wEQCgRxJbfnFhUuRfSQ86K3Iaigi2vPOlTLjR19auAEjU0CwpPEaWr0xNFLHLgXHtMlAZ42jjU//+AaZc5zoWbqXFYhIyO/Mri1XTLJtXsMmRniVANknbNGj/tYj2IyIjdCtbRx7W8o08HThrV6057xPHcW6UXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvJ7JhnV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso1964072a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756485362; x=1757090162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FrgUnL2QkeFAcmcHIflVwTc+GW/TBhLQty3c0DejXRk=;
        b=rvJ7JhnVfOXBfOmVeupb+q7bhXvkBFrpMD3DSK0LVigIRp4YqL5CGwi5W6Zg7eYsm6
         NjGtUb8HL/Ff0+9OX6rgYxYlwsFVphDqgfMU9lrwH1Ly6QMM4F4+FNIfVcjhPGudgLCs
         etxTGEWAyIVgdS22B8E/WWQb+efCTGaSEnYfmsXenlIRV8fonAR85oQLczfhUknOSww+
         z5gcvZDJ/qGlats1qkzjw3Rn7kFc7ryI6/+ZzwuQvSInS31f1/7p8AER3VpSgJw0C71r
         JQe+H4HMrLIodfbG2o/RlxMtTvebAlUw9R0ROBfMlffTVronFyYGhoM61wa4xGL2MXK/
         HXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485362; x=1757090162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrgUnL2QkeFAcmcHIflVwTc+GW/TBhLQty3c0DejXRk=;
        b=G9DfB3/ozvEmWFQOLVu+o//vd7C/ujHfNCHfAXtOdlGn1og+MdrbCm1UvGCh5Fb14i
         cEgtlL9BKSnZC3tOpRJiC3zsj7o4xH8jGrFNYZdjcEfqlU25OFGQ150mkYeJOtafP7cR
         R5UFtPNQKIV0W54ftcmK6HSYyfb6VPLLZmUh5VemmfK4loboBd4lcHgNvxhlydLHfd1C
         v/UtZJERBVDxvL+z6A10bSBq1nik89FMEgBC1xw3oBnSV0mr14FU/E8Y9Rd5hvYSYFNr
         eIEOztChIuF+l8hzooxY6/iaG6nguq+pCiY4qqzEr+wrTLix0QOyMH4dIIN8ejviAjX4
         7MHA==
X-Forwarded-Encrypted: i=1; AJvYcCVZytQrPJVVNBv4VzZrOdCjxmn4fLmjsL3PTSd79RUXcJ83yW2PXIzXanImpnlivkOIy0H1s9LkNZv4QU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaif+0IUdHgcy9FtzJWQ43GCnPEIns6zM1KktER2w221ihFpPu
	qlDZmrXP9xflfgZnGYua6oscJSW1Ub5al7lORkEtSM0B2Q1Y0oLK+CxvT9x0CqTx5XI=
X-Gm-Gg: ASbGnct8ucdr8qfDaeRTgCOB2FnxSFdzZAoGIiNyO058FggzYTbKBJ9ZBn7hWz03eEM
	9mxRJ3YQ0b00kZRvAmqFECG+cfXxA1ME+9V3HU5KRIJFwdokk6cUomIk6E3bxgjt9tTMpro0Ucf
	AjahKeBGmY+hnyfs11gIbWr2gGZ0q9NrSwp2RWGM3hcnGgwE9d8ly3jS7I3gM6BvvgCE3DkyIyi
	sHVXvUqxpmyX4ZtvRQC6S1WaPw8J+MmxyQYRGI7jhu9bjky6NRm1PfhImLYCuU5QHH7r0H1qNTj
	GhOexzzBaP8+DWrySrODKPyrorTaGwUd8l/xaEzHCeoBSoIysgkDRxb1kkOWqRI8DE45i794EvO
	IJkOi0few8DADumK9Bzp49dUH0OQcZeC+/ZwVFoOlewOs3Nwo0bFKUspWMSduPTV/GZ5aogbyvd
	l52eIY+e8bwBy84IV3ctykHEoVd7VBj9IUthw=
X-Google-Smtp-Source: AGHT+IEa10BPBKAnfR2ozvF0PJ5lZsMqEaKkULfql/YRzKK0it87d7VCRM15mB363K8S4++H9Sv2rA==
X-Received: by 2002:a17:902:ce02:b0:249:26a7:f5d9 with SMTP id d9443c01a7336-24926a80b8cmr22971255ad.41.1756485362100;
        Fri, 29 Aug 2025 09:36:02 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c8f8:92f5:116b:3068])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648d67dsm29530045ad.108.2025.08.29.09.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:36:01 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:35:59 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: andersson@kernel.org, ulf.hansson@linaro.org, rafael@kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH] rpmsg: core: Drop dev_pm_domain_detach() call
Message-ID: <aLHW7yBvEsAlYQoK@p14s>
References: <20250827101352.927542-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827101352.927542-1-claudiu.beznea.uj@bp.renesas.com>

On Wed, Aug 27, 2025 at 01:13:52PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Starting with commit f99508074e78 ("PM: domains: Detach on
> device_unbind_cleanup()"), there is no longer a need to call
> dev_pm_domain_detach() in the bus remove function. The
> device_unbind_cleanup() function now handles this to avoid
> invoking devres cleanup handlers while the PM domain is
> powered off, which could otherwise lead to failures as
> described in the above-mentioned commit.
> 
> Drop the explicit dev_pm_domain_detach() call and rely instead
> on the flags passed to dev_pm_domain_attach() to power off the
> domain.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/rpmsg/rpmsg_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>

Applied.

Thanks,
Mathieu
 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index bece5e635ee9..5d661681a9b6 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -479,7 +479,8 @@ static int rpmsg_dev_probe(struct device *dev)
>  	struct rpmsg_endpoint *ept = NULL;
>  	int err;
>  
> -	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
> +	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> +					PD_FLAG_DETACH_POWER_OFF);
>  	if (err)
>  		goto out;
>  
> @@ -538,8 +539,6 @@ static void rpmsg_dev_remove(struct device *dev)
>  	if (rpdrv->remove)
>  		rpdrv->remove(rpdev);
>  
> -	dev_pm_domain_detach(dev, true);
> -
>  	if (rpdev->ept)
>  		rpmsg_destroy_ept(rpdev->ept);
>  }
> -- 
> 2.43.0
> 

