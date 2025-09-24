Return-Path: <linux-kernel+bounces-830834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40A5B9AAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E978816B535
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877D3126B8;
	Wed, 24 Sep 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KItbkweM"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E36311C07
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727938; cv=none; b=KsFek7Qa0rY1zv0vampkW1udw9fXEmn0xSG5TRg93qamVEcDrwb90XCayW84thIry69VgSxqVT0HyQ20zagzl/nkcRrLvk2jUA1uiegybDhQ+LDqdqmIe5O4/iEI6lBTn8VMZXOIue+suBGrMZGRhDM0XnnFDZthYGgN9+/+dyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727938; c=relaxed/simple;
	bh=lXkqiFRoO59/Ufx7OxqzsjNwUUA6MMMGcCPsezc9mAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW7Pco3D261ejwjVsyIdBacnMY4+fuw13qGlNTd1TI27iSTXxNrnSA7BQ1AkNaM0L8QhN9O7d/IdgZ5XugiOuAAP904bplB2yOXL/JV3MVX+VcHBN2e3q6MQF/CbwQ7rPwjPzWdibIQouz7Dg/bROpsg6u92BmqvSydV24/d1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KItbkweM; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so11735609a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758727934; x=1759332734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0I65Cdfmrr8vZUIQrq2WUvttPueHtjZMKXuWscVZDM=;
        b=KItbkweMfMgmPpwvkGWGyBTf/HexmpuHsK+QPFAOqFBcO8TBMW4GPrZ2K3dS5ughAk
         s607mThzM5INgfL/4gDh2P6SKmHvha7+JTnZC9vIRDlzeh47W2f9O5cVZSh72jlKKY++
         yHT2ZU7fUeWd2d7z8H0z1UDNCJ98B/o3kQcg3v5BGAzfXfkm55GfhJlmIHIfXVI2+Y3J
         aVaTczESvTder1+kL4UNJDubOTKD9rAoJIciysqBn9XA4OIgthRb934NhBydjN0VJSDF
         pBZQqrUuuUvGK4qNV/Ve8tDQ+doGWs8qvryxEIz7K0TjW/9F5Cvn+e1B2kwEzkXV93ev
         R+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727934; x=1759332734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0I65Cdfmrr8vZUIQrq2WUvttPueHtjZMKXuWscVZDM=;
        b=fPh1sv+77fCoI0wMjkRy9WcjBYe/v+qBMpY7zXtf45P/bm8gDnIsos9UdAwKU1jlPT
         8VVQxuNIPqEgv2YsdzK5j7v+ppSOGxUnUwoa54wuSNpQP+Bu3GhVGFuCXlU/MDLKOJaW
         eTByhGGgxBM0Q/uiKzdiS3C6DQ0K1/FmIJqtNg6ttsAzh0kj/kIQmtCsKz1kPC0mu4YV
         UevFasLooRXdvk6v5TV/3BVTv5XAX87L0eAEE+Afb/d/ZS1BjBUWY4xgFGfnmzCO6M8t
         VsA+1AfO8p4bwTJwZVFbuF3OXE5FBA+cTMqRjtsqwtMslLcPRz6GpwX4Z1ifuIY4QFDS
         mkBg==
X-Forwarded-Encrypted: i=1; AJvYcCVd2DExILxQT1EC9rod6U4ox/hfI6NnAKfTCfC8hLaFkTJAEzl8ISJ+krJWkkt2DStK1oIT+oGQPOpRFzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZGrqum0I1f3XHr4PLNIEML+36pZzMVq1Pg7iuuSro5doy3P/
	cRNvVqvpJt7KrVZWlr1neR3VwWpNwZwfHUEPsqkcb2Jn24jfRXdVqpXRqjsLrIDqoeY=
X-Gm-Gg: ASbGncvS51mLgYKz97tlI9dyW2QfXKGBx1ngo774NNMCvuDdOYHW9mr4iGzU6Ud1i3h
	niyi7UqfstOJ143enuG7BaP3epojXsKlKzMM9sja4DhYh80OPyUeowwdp8bF0NDPA8rr9rTXM3G
	G+LfeqGxzGpulgFOEn2kdlgsosO9HzRBq9dqmTiLyEyFerAil03KalyIkx6dnq9Pxug27FLuQCd
	dTkN0Zag0kmfOTKoUeECG6ayTbIcezXQ1Ad0MT3J5K80oFYFLnanpztSJqlwQsV3EJg+5apXCIb
	m2XFhHvURlWcGxvC4UuL4GyoY2rysnqfODkeP+2ZIMaZ0cxel4IM+1p+PPdoUXtIGde71fxFZxX
	wgrbOR8mTfY6hWzSTsxUL5qRbnA==
X-Google-Smtp-Source: AGHT+IEpn8Hn2X8eRiAhhuk5c3P2Whqu7kOKOowHkUsxQ8AlS3TiHZmNBrhAKSKtCijMma9Ejf27AA==
X-Received: by 2002:a05:6402:354b:b0:634:505c:fc9a with SMTP id 4fb4d7f45d1cf-63467786e4amr6322787a12.10.1758727934318;
        Wed, 24 Sep 2025 08:32:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d06a15sm13439978a12.1.2025.09.24.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:32:13 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:32:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [RFC 0/1] serial: 8250: nbcon_atomic_flush_pending() might
 trigger watchdog warnigns
Message-ID: <aNQO-zl3k1l4ENfy@pathway.suse.cz>
References: <20250822142502.69917-1-pmladek@suse.com>
 <84qzwzbr90.fsf@jogness.linutronix.de>
 <aNFR45fL2L4PavNc@pathway.suse.cz>
 <84348eju8a.fsf@jogness.linutronix.de>
 <aNO7Qjv_iSUSifTv@pathway.suse.cz>
 <84348crpi3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84348crpi3.fsf@jogness.linutronix.de>

Added Andred Murray into Cc.

On Wed 2025-09-24 14:48:12, John Ogness wrote:
> On 2025-09-24, Petr Mladek <pmladek@suse.com> wrote:
> > I tried to implement some naive solution, see below. I think that
> > it can be described as the 2nd layer of ownership.
> >
> > It does not look that complicated. It might be because I used it only
> > in two paths which do the writing. And it is possible that it does
> > not work properly.
> 
> It is an interesting approach and is one that I tend to prefer.
> 
> > Then I got another idea. It might even easier.
> >
> > I think that it might actually be enough to block the kthread when
> > any CPU is in emergency context, for example, by using a global
> > atomit counter.
> 
> This is the quick idea that usually comes first. Basically introducing
> an emergency_in_progress() to keep the kthreads out. My problem with
> this is that it causes _all_ consoles to synchronize with each other,
> which we worked hard to get away from. Yes, I realize Linus rejected the
> "store the backtrace, then print it" implementation, which limits the
> effectiveness of parallel printing. Nevertheless, I would prefer to work
> towards returning to parallelization, rather than reducing it further.

Let me play the devil advocate for a while.

IMHO, keeping the kthreads running in parallel for a synchronous
emergency report opens a can of worms.

Yes, the kthreads might be fast enough when the emergency context
is busy with a slow console. But they might also cause repeated
takeovers for "every" message when a kthread starts emitting
each new message just to lose the ownership after few characters.

Honestly, blocking the kthreads during an emergency does not look
that bad to me.

> > I am not sure if you already started working on it. I rather share
> > my naive ideas early so that I do not duplicate the effort.
> > It is possible that you have been there.
> 
> Thanks. Yes, I tried various ideas like this. But your version does go
> about it differently. Although I am seeing the same problems. My
> comments below.
> 
> > +void nbcon_context_put_flush_prio(struct nbcon_write_context *wctxt)
> > +{
> > +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> > +	struct console *con = ctxt->console;
> > +	ret = 0;
> > +
> > +	if (!nbcon_context_try_acquire(ctxt, false))
> > +		return -EPERM;
> 
> This is my main concern. If a context has set the flush_prio to
> something higher, it _MUST_ set it back down later. This cannot be best
> effort. A failed acquire does not mean that a context with the same
> priority is the owner (for example, it could be a NORMAL context that is
> in an unsafe section). Remember that there are owners that are not
> printers.
> 
> So now we have a similar situation as nbcon_reacquire_nobuf(): we need
> to regain ownership so that we can undo something we setup. And that is
> the problem we are trying to solve in the first place. Maybe since this
> moves the problem from NORMAL to EMERGENCY, the busy-waiting is
> acceptable.
>
> As you mentioned, there is the problem that the flushing context could
> change hands multiple times before the flush_prio is restored. And there
> is also the recursive case where a WARN could happen within a WARN, or a
> WARN could happen and then in an NMI another WARN. All these cases
> probably mean that it needs to be a per-prio counter rather than simply
> a single prio so that each context can increment/decrement their prio.

Thanks a lot for showing all the problems.

It might be easier when we combine it with the first approach. I mean
to block only the console-specific kthread from
__nbcon_atomic_flush_pending_con(). By other words, block
the kthread from __nbcon_atomic_flush_pending_con() instead of
emergency_enter() and store the counter in struct console.


Summary:

We currently have the following solutions for the original
problem (hardlockup in nbcon_reacquire_nobuf()):


1. Touch the watchdog in nbcon_reacquire_nobuf()

   Pros:
	+ trivial

   Cons:
	+ Two CPUs might be blocked by slow serial consoles.


2. Yield nbcon console context ownership between each record
   and block all kthreads from emergency_enter/exit API

   Pros:
	+ Only one CPU is blocked by slow serial console
	+ Prevents repeated takeovers for "every" new message

   Cons:
	+ More complex than 1
	+ Completely give up on parallel console handling in emergency


3. Yield nbcon console context ownership between each record
   and block only one kthread from __nbcon_atomic_flush_pending_con()

   Pros:
	+ Only one CPU is blocked by slow serial console
	+ Parallel console handling still possible in emergency

   Cons:
	+ More complex than 1   (similar to 2)
	+ Possible repeated takeovers for "every" new emergency message


Well, releasing the console context ownership after each record
might solve also some other problems [*]

I am going to try implementing the 3rd solution and see how
complicated  it would be.

It would be possible to change it two 2nd easily just by
using a global counter and updating it in emergency_enter/exit API.


[*] Andrew Murray is trying to do similar thing with console_lock
    and the legacy_kthread, see
    https://lore.kernel.org/r/20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk

    He told me off-list that he saw similar problems also with nbcon_thread.
    I am not sure but it will likely be related to
    __nbcon_atomic_flush_pending_con() blocking a nbcon console context
    for too long.

Best Regards,
Petr

