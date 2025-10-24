Return-Path: <linux-kernel+bounces-868772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB5C0614B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304393AB925
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A32BEC55;
	Fri, 24 Oct 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZcBTXsjv"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A322BEC2D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306346; cv=none; b=mN1RfY6VyYgdhBaykPoIS6/NEH6wG3+9RNbswZNkHIhn+5iuPK9EOKIHUcB+8hMvIv0eVogBNsxQI08Q5lcdq0ItDc40b3jkvFoXJR5b6u3em/Hy9Owl3ZgUgQy01hs3jjITYqkd9YJtDX6j/qYGWervDPtu+Tg1DmdA6ScryAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306346; c=relaxed/simple;
	bh=rFa+Cz+GYBrnewSJVtSiTThxCutK1NTjInlKdg3DPg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoQxsTTLvumkmP7PTcVckl5k43UgLt9v7H67DurieoTk63wdTrqDNQcJtwfaOeiceZMf7a5PIXSUyOr3VMF/jh9tY+n6EQYBatKPJ0KrGTQvdzSOE58Qb2YbqRirmAaLb5a2DEbLRZHtovoCTQz3EJaeDV7uXaHm0lgw1hVPWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ZcBTXsjv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so3024438a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1761306343; x=1761911143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6FBIeEJhtBk6yTaDfvQpJNMn8UelVMBFc+lFgE8CvU=;
        b=ZcBTXsjvpFYbVPQsQnHmfsUusOTLL0xS5chokphh2kF1EOSNA2ihXHJnK1xEUrWRvX
         I/DIGdJxtrONNpBE2USmGR/TvWVQdlrVBIg2csjyg/OjThv7OjZYurQAMtcxLES92dCT
         j38KbF1mybHcJvMUCwuuAfYFM/S/zJCr5FPsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761306343; x=1761911143;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6FBIeEJhtBk6yTaDfvQpJNMn8UelVMBFc+lFgE8CvU=;
        b=lcmLPnDrR+pzsHwxUjzxMJdHM4GQUgOAY0dDYPdamXPh4YIJrxtUmfqxVgLyNXiRAU
         wXvGK1oy0CDDaZbDGJH4WvfSI0J3ddFw4niHPHZg70Fpr4tIQjKMTXJfujO4gJZxxk0K
         q/wAOzi1iuNzHw7Bd95vnGXD72G9Dzxn+dTQHLdFOfKCgSQ9/falLohEzN7cGXaJXkkQ
         M8dYLbrUSNHGkGAx+I2jLuUyR+/I3NgAEtXTNIHHcKlHWOMqZG6GWcqcMJLOFCruKeTI
         xHtgoZHi2NeIGGsfrTZUW5tazrBNLwxAMRbyAe4sOW8BqTWIAl3nJzOFGIHiUARi4ENf
         xqvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLniqk0q5TsBTnQWYhlXqCPyrotaIXRKZZaU3B/As49ISfXzuuSFDhSmM6rMfWtEv9IhBpI3oOlhmTyv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpEMLl1Rwv+3efaAn4E3Spq+zYZu2AOdsJeezvOjPbwlz3EAG
	9x7SgH7QyuxieXiNS8j/hcZB35H6To2SjYUaSiPa2MMy2NLx7rTTqvl+Uz7XA9OpKyY=
X-Gm-Gg: ASbGncum/fnpn/DjkrhqBOHo3EyYbbAxPtrcEsxMkG1oSn+BwJQrC144IOQFgbCj6un
	5a0mxqM5qCyY2cv13Xu6rhacBTCmbEEJ5QI/CTwn65GWtoJWtfjKmP9PbBV1EuRT77WjHqbh7eH
	m0vz0dlQWxF7uPjqNl15Bi2F0jbdA78JJWRxAdnl+aRqrIlmzIXzmt5+zgl4lF8Jn4EsGRBGTZx
	8idW+ot3FpOaxcm1IenL8CmsHtEKDHATufStaNCkKATEAVYPuoEU8ONEgDp1v2Tk2hBwyynRzmi
	biJOP49snS1mGT10P2kXex/REO/wbOkJk6fQI7eveUBAYQpChRmLxz5w6KkfLTaBxm0U1CNrEr/
	D84ycCOwjxxRzHxTJP+E7DR/AMDUYoJb1ENJd8XR342qqD/ZnFd/pDvPK+/1vnwP2rA0PD1eey8
	GoqJCTY1j8rIM=
X-Google-Smtp-Source: AGHT+IE0zXk5rqoOLi9/G0nAmkXgAeq6s0+wLVcAYE6NdPO3i7wFpyzjRZtDYsvoj5daTeKJpRRC8A==
X-Received: by 2002:a17:907:3f21:b0:b57:78fa:db46 with SMTP id a640c23a62f3a-b6d6ffe193bmr218870166b.43.1761306343240;
        Fri, 24 Oct 2025 04:45:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f3349b3sm4138928a12.37.2025.10.24.04.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:45:42 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:45:41 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Philipp Stanner <phasta@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Maintain spsc_queue through drm_sched
Message-ID: <aPtm5UD4tfVBJzSh@phenom.ffwll.local>
Mail-Followup-To: Philipp Stanner <phasta@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251024081459.164634-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024081459.164634-2-phasta@kernel.org>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

On Fri, Oct 24, 2025 at 10:15:00AM +0200, Philipp Stanner wrote:
> Back in the day a specialized lockless queue was designed solely for the
> DRM GPU Scheduler: spsc_queue. This queue's only user is drm_sched, and
> there is no dedicated maintainer entry for the queue.
> 
> Add the spsc_queue header to the DRM GPU Scheduler MAINTAINERS' section.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5889df9de210..efafe2b3517c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8580,6 +8580,7 @@ S:	Supported
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:	drivers/gpu/drm/scheduler/
>  F:	include/drm/gpu_scheduler.h
> +F:	include/drm/spsc_queue.h
>  
>  DRM GPUVM
>  M:	Danilo Krummrich <dakr@kernel.org>
> -- 
> 2.49.0
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

