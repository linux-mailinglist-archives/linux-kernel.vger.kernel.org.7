Return-Path: <linux-kernel+bounces-725717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8C4B002DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995565639B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8236827055C;
	Thu, 10 Jul 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="ztDwt/WQ"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229061D540
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152719; cv=none; b=SWjmb47pBBrO9r310LbTFXcsxhfVaTeQASoIRnbjvv/B1qxYZbMabZBdUr4/Px6GpSVWXMVso9lxk1zJ4DZKcrkb53IoaKAH2qzJGBpxmTv3JiofSKkop4t2Bqdm8lMpkCnd/YALvAImhp3DKsCrhIcXY2UHGmlFG+62R/T2oRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152719; c=relaxed/simple;
	bh=iXh0eZ0BMWERGUEE72+TGzn9FYBgxC6wJt6YJVPEZlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWLi+D1mT8nzHFuB5nEDP7km/+BTNERTro7d6D7j/gnpFDnhYwz1ALUrCVAmvA43I0NPZ03H4KGvF3aHaagc1Vj1tbML+dU1CLNfc7609P7zjzD5NMCxa2ivHTOq+IAAySPDhan0l8Bl3Z0q5C5aPcxlm1f/sh5kX+CtglZ8pM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=ztDwt/WQ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40ad1f7c23bso569038b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1752152717; x=1752757517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfL7rv/TBn1ODKWf0HFqJjPlTMTSbxnh7pmA5WaWrbA=;
        b=ztDwt/WQ+Mx74+SpZB81eVtm905lMmmsMOYzF+LcGe/s9wWjJPUhqJ3ESO50pePg5/
         rmhOgxhnHpHodUN/5Kxd4La2hiI/kKq5yk58bsfM7clVqkaucs16FR+rieFZOK4xbUR1
         DuuRkV0KjQMHWgy2VI8cqeUS3mnmfJZzXepEI4QoingrswMJMExMDvPM2sJlW1kNQ0j4
         SryhFbkCo9vfItWbKgyRNbRqpOL+zRXeKbEFGNwUyHLqrGPKnyGiEu8YFREA6svGIhpD
         7YoXJMa6PHTqaJbzblj3Dqj4NN1av7MfSxldKnWvvmCgO/FueOWaisyrnOrGV1Ty0PVW
         hsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752152717; x=1752757517;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfL7rv/TBn1ODKWf0HFqJjPlTMTSbxnh7pmA5WaWrbA=;
        b=Y9dx9HZ65p32dsEGbusr9M6SUAER7qg6B7MVcmrwawnL3cQ1cBgkQZeWHep5SJLngm
         0nPW3hhEoomLz2KPRVXHWo1JF59VcWl25Xa3VCbXo1vHLf9Y3P5jVCjwdiSYTl7fKMKG
         /pw+xM29l1IcAgG2yaP0itVurkdVwlEZle9RLXM6tlpRkgC4xND8vUejtR95WPCgsvnB
         m9oPfnYWIfsnrnntHxQrOPMvheqfBo6qepXgMrEH0faQorL9gSYNuYcDBH1n60PK5hFa
         Cg5/e75MtRb6VuOjDpcov2UWnjSd8oAvvNAu0gIME40D368v+M0tM8jtr3Ww8VU109kY
         H/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUD9shGktDNPcxHqJ7fSj6jsReN0Vb08nts+h8Nypeyai7ChTGLRygQWtHwEYUXE2G/nkCIZjfYi5HJfcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHFV0BonjnsCK3YjS75sQLLjD84SSsTJHoLvis1v1NKDho9o2y
	MkpP3rMQFhIlRxgjp2KRtEEs0voi0WQAK+K1y8epWILmai8PBlpyvoxZmrfffV4boY4=
X-Gm-Gg: ASbGncuQc/ELZkMYLnp8vBZiORNkdtMh7d8tysukvW3g6innKadrxFElqjeDclyQ14w
	81sNW8HuC/2qIgn/8C2u6nLgFNb/jPH4tploJ+IIawBiWBNqjcjq47e70V/LJGXTrkFx1SumD4m
	Mle7M7XuNq179dtuKANFxN10EXlGO1BsbuLk6HTO1fzyb1QgqSjrWfuRiGqYbTGDZvQvcPROSPn
	EHu88yHxEmEc9ijmwMmL5syKNu2wFx57bPcQ4C4+eFuKEKbQ9m7mg5tAL1XSwEFYWpcLF7U+K+e
	veJBYjJI+NsjnJg0/YMTv5rQvrrbAGJ9+izSF5ru8YVRz8NIq1FRe6Vg9cnSiH7qZg==
X-Google-Smtp-Source: AGHT+IH4hXRkZjglmlT7hSDhFdsQbESQ0W2qXubwY+npmOLdfdMtfKgbpg4MnTMzaFamttvKUUJhaA==
X-Received: by 2002:a05:6808:3a0d:b0:403:3fb7:3870 with SMTP id 5614622812f47-413f3f682d8mr1735574b6e.10.1752152716830;
        Thu, 10 Jul 2025 06:05:16 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:ec53:8290:86a1:aa7c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4141c1ac53asm197206b6e.39.2025.07.10.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 06:05:12 -0700 (PDT)
Date: Thu, 10 Jul 2025 08:05:06 -0500
From: Corey Minyard <corey@minyard.net>
To: Breno Leitao <leitao@debian.org>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] ipmi: Use dev_warn_ratelimited() for incorrect message
 warnings
Message-ID: <aG-6gtCvsowPbH8v@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250710-ipmi_ratelimit-v1-1-6d417015ebe9@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-ipmi_ratelimit-v1-1-6d417015ebe9@debian.org>

On Thu, Jul 10, 2025 at 05:57:26AM -0700, Breno Leitao wrote:
> During BMC firmware upgrades on live systems, the ipmi_msghandler
> generates excessive "BMC returned incorrect response" warnings
> while the BMC is temporarily offline. This can flood system logs
> in large deployments.

So the BMC is returning bogus messages during an upgrade?  That
sounds like a bug in the BMC, it should either work or be
quiescent.  Returning incorrect data can result in bad things
happening.

But, as many thing IPMI, we have to accommodate bad designs.
This change is probably a good idea, anyway.

Queued for next merge window.

Thanks,

-corey

> 
> Replace dev_warn() with dev_warn_ratelimited() to throttle these
> warnings and prevent log spam during BMC maintenance operations.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 064944ae9fdc3..8e9050f99e9ef 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -4607,10 +4607,10 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
>  		 * The NetFN and Command in the response is not even
>  		 * marginally correct.
>  		 */
> -		dev_warn(intf->si_dev,
> -			 "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
> -			 (msg->data[0] >> 2) | 1, msg->data[1],
> -			 msg->rsp[0] >> 2, msg->rsp[1]);
> +		dev_warn_ratelimited(intf->si_dev,
> +				     "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
> +				     (msg->data[0] >> 2) | 1, msg->data[1],
> +				     msg->rsp[0] >> 2, msg->rsp[1]);
>  
>  		goto return_unspecified;
>  	}
> 
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20250710-ipmi_ratelimit-7e1af5170c57
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

