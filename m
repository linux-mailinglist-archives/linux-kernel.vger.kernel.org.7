Return-Path: <linux-kernel+bounces-817363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2692B5813A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D32188B86F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA289226D1E;
	Mon, 15 Sep 2025 15:46:21 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7FB1FC0ED
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951181; cv=none; b=LDcSz+WXUmAqzi7Wdu4IYj6rG7BW8KknA/rqe+Iw+WZca9t9Lh1ZSm/8zcsbrqEwd1OgeORcCuiSora28IIAkHl94NnnKUirhWprUgWh4GWwIl98JasrBrEN8N0ymKFBOgBCcXi1usREupZa+ow1k0/6DcMb6C4A295WcYtCYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951181; c=relaxed/simple;
	bh=7CJQb+UqWHXjmT9iSdrQT97xSsaodGppHzBdXh6S5N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqqF3W8gQRTAzQjpOi8XvPqHIu1FEyvU3z8EzD4km5WE05iU3xpzzBSMUwWUEfOWhRkSrRHxnVTFv8VTB2gPpBLZk2gyhgbwV3jzNtUUmH9Cucpu42AKiF6+B8OO5uaihFii9u8KlT3TkrkZZw/F6b/GZNrLObOoMOmDDjqevkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62f330eeb86so2241361a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757951177; x=1758555977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pEQlALxontB4QhfAaF8Ih1uMHxCqgvkFKMauXWX2/k=;
        b=Ree9R5thZ5Ew4hVY6s+/QdBA/se0L8jpv/5FPAvCmjSKx/syZMHK7G//r/3J51rwE8
         xzrZqjvxpqMkbPHUGyHporn8y39MgCxNjYaC/9N78sx5mySPA0igR5tLK+UHFBDXZn8E
         pCHa1tKqo95waLlwjsG2B7G3wJ/xxNNEN4U4QVrzsGGLhIyU16N2E63fvpdLseBzN4K0
         jxE3ldYxE0HL9nwNKLvVcKsuSe2X+L4MKRWWWcCqlvbyyehJITxdd/Owje00qEGY9yi0
         F5EESVHL8MJB7NO3JeesfA/W0sZvTriLqmsmuGrGvLm7h1C5yrlX3ARJSB6w1C3rXXM7
         jdAw==
X-Forwarded-Encrypted: i=1; AJvYcCXVfvbps+l1/Jyb85zdJj/FZ701QuuI1TCy6b++g7CjNrsOZozftwKyCMP4nvKPGVekyMVORtoCaOHgdMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznxEBAdMc1Dlp7LRgpzgNa+EjC5y8FDgIeSE9MboLgYWY3PMRW
	EDeApJBc7nbX161VN+ERxGA+/XjMwXvvFiD/nKZcR7Ae6bB17j71fIPO
X-Gm-Gg: ASbGncuGsoQkIQ6JmvwPNzn9QHY574zYj78YFxP6LJQBH/fPVyAaZG6ECSv8bHbwbmm
	v+4w3peIeEKqFa5iX1CoKAlC4LeWQR+aDcJwDCw+T0CW3GfXG+LKkSfLNxbP1NWfbkf4PYXMXAD
	jMVg9KzQNRu6qo3UOW61Y3hmZBiY5c2X991hoxOX3mLhIe0+uF6vzhC9NEre67EuHlPwfLimPAo
	MGdfGeG+gDbb731o5WKu7g0OX842+aUWox8weFFdgPskCCsoFen4Rg2DghO5NpOpmEZQ6987Q9n
	dJby8uAE5OAb2h6pBRkSBVC20hR6VQr1a+1y2kPwneKPm4v16yy2o96x8uwBAH8vXoHplgV0vpI
	GsgNc0SJqUeGG1ckVq5e9SOM=
X-Google-Smtp-Source: AGHT+IFjjpr/YD9RphjmQZq9Icp8exZXPr9/QGWCTTNj0JCqrZTyFNuu4T34Nwr84VBFrnUAZiBuPA==
X-Received: by 2002:a17:907:1b1d:b0:b04:a780:4673 with SMTP id a640c23a62f3a-b07c38292a0mr1262958266b.31.1757951176450;
        Mon, 15 Sep 2025 08:46:16 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f416db508sm2207420a12.32.2025.09.15.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:46:16 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:46:13 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <i6qgd5wcdl5gkwfc6cru2hnokcsawdd4yzez2i6klu54uxwx23@jl44kdpph3t3>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <20250912121852.2666874-2-john.ogness@linutronix.de>
 <74htjoj66srvussqvivbhlkdkj6lkm6ox4jdv2sedb4yzccdmr@sgzbd44mivfs>
 <84348n9510.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84348n9510.fsf@jogness.linutronix.de>

On Mon, Sep 15, 2025 at 04:20:35PM +0206, John Ogness wrote:
> On 2025-09-15, Breno Leitao <leitao@debian.org> wrote:
> > On Fri, Sep 12, 2025 at 02:24:52PM +0206, John Ogness wrote:
> >> @@ -1606,6 +1610,13 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
> >>  		if (!console_is_usable(con, flags, true))
> >>  			continue;
> >>  
> >> +		/*
> >> +		 * It is only allowed to use unsafe ->write_atomic() from
> >> +		 * nbcon_atomic_flush_unsafe().
> >> +		 */
> >> +		if ((flags & CON_NBCON_ATOMIC_UNSAFE) && !allow_unsafe_takeover)
> >> +			continue;
> >
> > What will happen with the "message" in this case? is it lost?
> >
> > Let me clarify I understand the patch. The .write_atomic callback are
> > called in two cases:
> >
> > 	1) Inside IRQ/NMI and scheduling context
> > 	2) During panics.
> >
> > In both cases, they go throught __nbcon_atomic_flush_pending_con(),
> > right?
> 
> @allow_unsafe_takeover is only true at the very end of panic. In all
> other cases, the ->write_atomic() callback is ignored as if it wasn't
> implemented. That means it will rely on the deferred printing kthread to
> handle it.
> 
> > Let's say that netconsole implements CON_NBCON_ATOMIC_UNSAFE. What will
> > happen with printks() inside IRQs (when the system is NOT panicking).
> > Are they coming through __nbcon_atomic_flush_pending() and will be
> > skipped?
> >
> > Also, are these messages even deferred for later flush?
> 
> When the system is not panicing, CON_NBCON_ATOMIC_UNSAFE has the effect
> of acting as if you never implemented ->write_atomic(). So yes, only
> ->write_thread() will handle everything in a deferred context. If the
> system never panics, your ->write_atomic() will never be called.

If there is a printk() inside an IRQ and the host is not panicking, then
the message will be deferred to the kthread, which will print through
->write_thread.

So, from a user/netconsole perspective, assuming the no panic
(allow_unsafe_takeover=false) all the messages will be transmitted
(always from a thread context), even if the printk() happens on an IRQ.
So, no message will be lost.

Is my understanding right?

Thanks,
--breno

