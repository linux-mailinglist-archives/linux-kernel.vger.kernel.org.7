Return-Path: <linux-kernel+bounces-733159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C06B07101
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC3F189D294
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EEC2EFD8E;
	Wed, 16 Jul 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Spnsy4Gf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAF28DF1F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656265; cv=none; b=Ushl65XJ8iAL2DMyMMuvHHYP0w0K4fKr536RCT6+aH48pP52voPVy/g9A8EyEHyHtAPoLgYJdXSivOvlm/awp8I8X+Nh7L/LAsnNtMarWheB3/NRX6FZzgRPnLnn95LcmNXR7Y5kshqGlAK64mviE0Qc7sOvr/995JB/OuecQG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656265; c=relaxed/simple;
	bh=bSZvmxVaLzzIexlJjfqAQuaa2x0fZVD8/09A4vIGlmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmb173CKaO4SWXjLsRqXrVwbI6WcQxQawwdvvjSsJbVeRjatnZebw6PQLlm6HXTTwjtUl6BgliXA/Q2Do8jFKtvhwSxu3IY3B35Lw9BMa4ZbqNmfbBfjKDOMDSxGbQErIIYO8WSAbVMvAj1Z5n7IRULOKF7WF9yhMtEmrFZ1o30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Spnsy4Gf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752656261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T0pk9pyfgDC9oxEgYm8PZjm4tzUcUb0Zdw4AkU7+zzw=;
	b=Spnsy4Gf5lnx1Npj9BwWo57PwsYBTaM9tZ6KE17Q9DfEwigdOFIuLmUtfVCDqs+wHkt6tp
	BDLVLqUfCYmC8m/reU+1Sr3tp8ZTdeYlFiHfr7gPoWDlu4lF1q/9VJqbOTj+mH9hGQkTsX
	kEuOSzQraOVbSzcRj4vwRW+BDXxEW+E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-3HrLIbkGPtmCnCGABpYR3Q-1; Wed, 16 Jul 2025 04:57:38 -0400
X-MC-Unique: 3HrLIbkGPtmCnCGABpYR3Q-1
X-Mimecast-MFC-AGG-ID: 3HrLIbkGPtmCnCGABpYR3Q_1752656257
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so33435645e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656257; x=1753261057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0pk9pyfgDC9oxEgYm8PZjm4tzUcUb0Zdw4AkU7+zzw=;
        b=dNPhN432Q6YPiRxjsBUbNBdqEl1YFhtYln2YLLcN7Cm8aW88C2MbQ0oHfYExXQNJ0S
         v5/kGGtWcuKkJMmplg3v2Ff4TT1lYJse0AyTYnP12QmtiNUj9ISfGJ/qaf3rbCnDD6Nf
         2XG/ty7Sm+90N07xJAqB0lx7+HEV0HusqrKVhE4BdrcN1VShPBaKSDoRKvJ1H8ED3wQZ
         HHa9U1czOrXX4G/KGjC9hgpXN+MQClodaB7mStcoDKA5OBOEuhBUHA5wTQ2SZJ5wGjNt
         KZ5uH3t7r8hfgjC0KeyOfrzrJGC7tZrPQyhr5WfWBlb0lxH/+p1tR3lPnBHzd6KdX41B
         cqgw==
X-Forwarded-Encrypted: i=1; AJvYcCWPuxAJx3FTefy3UIKWNgzhjXPnuJELtT8UHal6v7ZVnnBF3VcsA1nUmepUUAzOnU3W6oVtgCrM99mbOM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6KSdLPqemjgtAEviduFsoQb8keILlOYRhDZzqGRhfhc9qo4y
	gcm2Xsd2v6CnrUhMJ2b9oYQcsxy2z8UIZATB4q71B68cWE8A7ruFAA124D9dECF3Xw616MBn+jC
	EavizeEhnSMxAxBS2T2VwbBq0B544JSqkcmD/mAe1ZQjiEA4F9N/5jbnY5vdq2KwGtw==
X-Gm-Gg: ASbGnct2U0LqeOR1T4K4+PtQ4/zfyq1QPAxLYsjIlbSnDJ152qzV9kIbb6WhOpD2sAC
	VOjAwXOskFVAyv1aUeGgCc+CO6xVppKXP9mjicby8ji9K4F0AidVbdAmTUHMCg30XoS5xb9bHi3
	izq7c7rqut2uUzyFv6+3FcbonD9VcaCsJXgNGUJzJorXEyUZ4gFgI60O6V/irZedDjuZfc3UQQx
	u9CQFrptdVlTaLetIANHlOQ/j+IAE2V2oFLzGdz9UFNmMCaazFgouHpxtKjRlP89si32bnZbFX3
	QGBIOxkEP/IoXkwkZP9igYR55FwILUTZ
X-Received: by 2002:a05:600c:4586:b0:456:2142:7fa6 with SMTP id 5b1f17b1804b1-4562e03df81mr20025045e9.12.1752656256767;
        Wed, 16 Jul 2025 01:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPMQ1MbDi1mPyamg5hDacuZGeQ/q7zkCeqn5pVA9BWS/Ht5qJqtjeEvWW81loE7yxAUxIfwA==
X-Received: by 2002:a05:600c:4586:b0:456:2142:7fa6 with SMTP id 5b1f17b1804b1-4562e03df81mr20024795e9.12.1752656256365;
        Wed, 16 Jul 2025 01:57:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802afasm14522575e9.12.2025.07.16.01.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:57:35 -0700 (PDT)
Date: Wed, 16 Jul 2025 04:57:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] vhost:  Use ERR_CAST inlined function instead of
 ERR_PTR(PTR_ERR(...))
Message-ID: <20250716045617-mutt-send-email-mst@kernel.org>
References: <1a8499a5da53e4f72cf21aca044ae4b26db8b2ad.1749020055.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8499a5da53e4f72cf21aca044ae4b26db8b2ad.1749020055.git.xiaopei01@kylinos.cn>

On Wed, Jun 04, 2025 at 02:55:48PM +0800, Pei Xiao wrote:
> cocci warning:
> ./kernel/vhost_task.c:148:9-16: WARNING: ERR_CAST can be used with tsk
> 
> Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...)).
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  kernel/vhost_task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 2f844c279a3e..8c4a82c0bdbe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
>   * @arg: data to be passed to fn and handled_kill
>   * @name: the thread's name
>   *
> - * This returns a specialized task for use by the vhost layer or ERR_PTR() on
> + * This returns a specialized task for use by the vhost layer or ERR_CAST() on

ERR_PTR is the type so it's appropriate here, I think.


>   * failure. The returned task is inactive, and the caller must fire it up
>   * through vhost_task_start().
>   */
> @@ -145,7 +145,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
>  	tsk = copy_process(NULL, 0, NUMA_NO_NODE, &args);
>  	if (IS_ERR(tsk)) {
>  		kfree(vtsk);
> -		return ERR_PTR(PTR_ERR(tsk));
> +		return ERR_CAST(tsk);
>  	}
>  
>  	vtsk->task = tsk;
> -- 
> 2.25.1


