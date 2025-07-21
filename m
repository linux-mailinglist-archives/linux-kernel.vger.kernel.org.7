Return-Path: <linux-kernel+bounces-739436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8C2B0C646
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602181AA50A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11AE2DA767;
	Mon, 21 Jul 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyvakcq4"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226C2DA74A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108057; cv=none; b=ccJNynBSnH9WcTvLVzS5k+X7Kg+poRpzGxDN27qzYjyQKTJc4tgX27/LijbpKAo6jGVuMweBbCNFQyt1YnBp9D+FVr7sNdL/wI1vWeVkArOE7GNi4oywYZQQPFfsajY3aBbN/tCvbxYEXtTByGeSEc2DYACljVPzKdTaUkausBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108057; c=relaxed/simple;
	bh=Pw4OpMcuQX9XWOainQFKsbHIOh7EGddXnRrP7zIaoh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfcNb9onyBmrJ2vRKgmpIFMXeOPyPnnvitZm7jinuovquJgO+ahPhb9YvEU9nijLCLOUFwt+tkW/telHZgupM2SiLrVNC7HZLeYpAO9wzyYiiYcjh0/V8jZiLUQwYwFGs/Q/hilJ7G22xFhOaG8010DnvmnBcZmMpk5cnQnqhKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyvakcq4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23636167b30so39593105ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753108052; x=1753712852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJQsfsyKJE8vX8PMcgdSBkHp7yFOlF6/q090Bvq2VXo=;
        b=Qyvakcq4/ruC6FFpROGLHdoKlv2I6Ov0ap/oYA74KB6tsFjhOaiB5GCm3W/aZkvQRx
         aw/DKtQAkscUDNtPHx1vuWUrr9jr0RnH4eXI9lRTk6eNmTzTuetxLKH/8sie/ZTlq4k6
         PeW3KtdcD5jcxYM7mmy0ifw7avAEWzKtcYEDFZK7/FuoF2OCkyQr7cGwbCiwIZhs+Ekn
         ngNhCidnY/zzSEqcr8WdIypPOYZHb6XXNyswbN0gQkilxCnQCib2/GO1a9jJnhacCTz+
         NiHkKBUjRrTXeLgQnTySkxp3EYK8IePakxKd8WESGuCTnamq0Z39QBQ5aYJrs7r4tcMA
         0Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108052; x=1753712852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJQsfsyKJE8vX8PMcgdSBkHp7yFOlF6/q090Bvq2VXo=;
        b=CfES63kM/KGC+xvSqxLg39i6+kfgVOltMfxEjBZHyv/ivZYARGSpIrmx95iOF01No2
         +RoO0M0PT8Bqh07UWX/Jd+9BUbPcuWO0brydoPjsxDNkfYjeGAE1e+GxSAymQFN00XaW
         NA0v714ZfQh9asFLlXl2Le2YbeTMW0qfBE8oAlV57+6bsZK5IWIWqlLFPHPcTU72Qoyh
         zJt6Qgl/XNVPT+xWaq29QDo14v8EurCADkD22h/vGtMe3qzX+iy1ZmZvnyhli+MXkOWV
         orpe8F48uOtVGawff8FMkhTkusBCo9cmWZcUwGEsqNr2VcFCoyGDM0V5ilL3dJY3/b8U
         2eNg==
X-Gm-Message-State: AOJu0YxyIszLYtGdenP1FIWvesZUiD2y+pOMQd7tz3A32uV3Azd45X5j
	QNM/iYtzsgx/N1KqjkU4hK9U1wIuaA0WC3MMKPmLSi+8gfAjAHet4landYD1lA==
X-Gm-Gg: ASbGncsVdiNWnEQ4vtRvpIVWrv2B1In/mPxZkMIPemU+W2W2CUZG/I9MRUuGL3iCfy2
	2H0LP4vGcTPJNf58cFV2D2nZvklTXumb54Svs0btGehxtIsxbdFKUiPYTns9WDzGghP69dbZRy8
	P5Z401DcsSLcUXiJF/C53WDYZVcQ4M26qkpM9nFiJ2U81z90XznRaUTLqB83d7kviTlLqu3mp7L
	4y66686MqSyTwe7buRX5RhgrY71455Na0fOpjGTMGqa7XvSfI3dMgjyVyHFVrbVhI76YBpqCOa4
	62L7zPUUgKQXuTRYjQDRVo5unij7nkEkx+Ev+ONJ1aRqlAWWpKm/TmMdVzGow/mUx6IljtspD6G
	vlSsCmFXPtdgpW90piUmtZA==
X-Google-Smtp-Source: AGHT+IEWnidgy3bPxvdEDBdB8Qgitk+nUCtS3i3NQFxZdhHbaMlLbB1iaHOJ2Rajh8IkrNvJf3/8bA==
X-Received: by 2002:a17:902:e802:b0:234:d7b2:2ac5 with SMTP id d9443c01a7336-23e256c97d4mr266575465ad.21.1753108051974;
        Mon, 21 Jul 2025 07:27:31 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef976sm58405945ad.202.2025.07.21.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:27:31 -0700 (PDT)
Date: Mon, 21 Jul 2025 10:27:28 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] irq: simplify irq_im_handle_irq()
Message-ID: <aH5OUChoFx55WnVG@yury>
References: <20250719211818.402115-1-yury.norov@gmail.com>
 <87zfcxtz6t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfcxtz6t.ffs@tglx>

On Mon, Jul 21, 2025 at 04:07:22PM +0200, Thomas Gleixner wrote:
> Yury!
> 
> On Sat, Jul 19 2025 at 17:18, Yury Norov wrote:
> 
> 'irq:' is not the correct prefix here. See:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-submission-notes
> 
> Also irq_im_handle_irq() is not a known function name.
> 
> > From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> >
> > Hi Thomas,
> 
> Since when is a greeting part of the changelog?
> 
> > The function calls bitmap_empty() for potentially every bit in
> > work_ctx->pending, which makes a simple bitmap traverse O(N^2).
> > Fix it by switching to the dedicated for_each_set_bit().
> >
> > While there, fix using atomic clear_bit() in a context where atomicity
> > cannot be guaranteed.
> 
> Seriously? See below.
> 
> >  static void irq_sim_handle_irq(struct irq_work *work)
> >  {
> >  	struct irq_sim_work_ctx *work_ctx;
> > -	unsigned int offset = 0;
> > +	unsigned int offset;
> >  	int irqnum;
> >  
> >  	work_ctx = container_of(work, struct irq_sim_work_ctx, work);
> >  
> > -	while (!bitmap_empty(work_ctx->pending, work_ctx->irq_count)) {
> > -		offset = find_next_bit(work_ctx->pending,
> > -				       work_ctx->irq_count, offset);
> > -		clear_bit(offset, work_ctx->pending);
> > +	for_each_set_bit(offset, work_ctx->pending, work_ctx->irq_count) {
> > +		__clear_bit(offset, work_ctx->pending);
> 
> This is just wrong.
> 
> __clear_bit() can only be used when there is _NO_ concurrency
> possible. But this has concurrency:
> 
> irq_sim_set_irqchip_state()
> ...
>         assign_bit(hwirq, irq_ctx->work_ctx->pending, state);
> 
> That function can be executed on a different CPU concurrently while the
> other CPU walks the bitmap and tries to clear a bit. The function
> documentation of __clear_bit() has this documented very clearly:
> 
>  * Unlike clear_bit(), this function is non-atomic. If it is called on the same
>  * region of memory concurrently, the effect may be that only one operation                                                                                    * succeeds.
> 
> No?

find_next_bit() and for_each_bit() cannot be used in concurrent
environment, and having atomic clear_bit() is meaningless here.
Two concurrent processes, if running in parallel, may pick the
same offset, ending up executing the handle_simple_irq() twice.

So, the work_ctx->pending must be local or protected bitmap to make
this all working.

It simply doesn't matter how do you clean the offset - atomically
or not.

I have a series for atomic find_bit() API, not merged though. In
I described it in details there [1].

Or I miss something in the IRQ handling logic?

Thanks,
Yury

[1] https://lists.infradead.org/pipermail/ath10k/2024-June/015900.html


