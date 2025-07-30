Return-Path: <linux-kernel+bounces-750564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BADB15E14
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1D018A3C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797A28003A;
	Wed, 30 Jul 2025 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="o0PEetvg"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FB1F8725;
	Wed, 30 Jul 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871109; cv=none; b=HAn6nVB71DL38pFmRrpWF8fPhrCCqdAGkM4PAj5FBf8FaAjum5QRm0HUqrPie/M1A3RkqTTWrzBm08zNcxdR12nHWB8jtll4CmNdzXi1UleAv+Vit77YGxLgP7sm+7iumsLFJHlO/yToxaR8mCg/dE0AmlfAnBuLxeWWfB944E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871109; c=relaxed/simple;
	bh=dQ4UGGq1PKXZBezaixT0KhIN5aCNimml/7A4rt/yP14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRjXXIsQxku2gyDUyphfuFPbp96mP0QV8QSS6iNL//ujvVkQL3BaGgC9xxFF5oIFeaE45XR35rbsQlGLrraqeq65n3vU+W9b+4epHQ29gh3/8ZlCBwAyNChLKKTJGROugycIRP4v3nCS3mYzYymjTDb0ir1plcl6TbBsIz1vvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=o0PEetvg; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2d88:0:640:6173:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 58196811B4;
	Wed, 30 Jul 2025 13:25:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wOXme1bLvW20-lp603KDK;
	Wed, 30 Jul 2025 13:25:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753871102;
	bh=/X8waQHjR87xGwlgmA1Yc5M6IgxaidwtGSogxh7QaFE=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=o0PEetvgebK7IVNVaI4nLXSIS1E6zf3bt4MwZyhAacgGUsNuW3xm8FdeExuXBoPq/
	 whWe8rag4scgDsz9FM2Aesbv0aper2iQFMw0fCHKkLKih2bKxOaE1x/2cCJF44lM2B
	 KXDUGjML55KWQxH+lcjKAd7SDI/f1Atoz7l8hzmE=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 30 Jul 2025 13:24:57 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: "Benno Lossin" <lossin@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <peterz@infradead.org>,
 <mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
 <felipe_life@live.com>, <daniel@sedlak.dev>, <bjorn3_gh@protonmail.com>,
 "Lyude" <thatslyude@gmail.com>
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
Message-ID: <20250730132457.20a13d71@nimda.home>
In-Reply-To: <DBOPIJHY9NZ7.2CU5XP7UY7ES3@kernel.org>
References: <20250621184454.8354-1-work@onurozkan.dev>
	<20250724165351.509cff53@nimda.home>
	<DBOPIJHY9NZ7.2CU5XP7UY7ES3@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 19:15:12 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

> > - The second note is about how EDEADLK is handled. On the C side, it
> > looks like some code paths may not release all the previously locked
> > mutexes or have a special/custom logic when locking returns EDEADLK
> > (see [3]). So, handling EDEADLK automatically (pointed
> > in [1]) can be quite useful for most cases, but that could also be a
> > limitation in certain scenarios.
> >
> >  I was thinking we could provide an alternative version of each
> > `lock*` function that accepts a closure which is called on the
> > EDEADLK error. This way, we can support both auto-release locks and
> > custom logic for handling EDEADLK scenarios.
> >
> >  Something like this (just a dummy code for demonstration):
> >
> >     ctx.lock_and_handle_edeadlk(|active_locks| {
> >         // user-defined handling here
> >     });
> 
> But this function wouldn't be locking any additional locks, right?
> 
> I think the closure makes sense to give as a way to allow custom code.
> But we definitely should try to get the common use-cases closure-free
> (except of course they run completely custom code to their specific
> use-case).
> 
> We can also try to invent a custom return type that is used instead of
> `Result`. So for example:
> 
>     let a: WwMutex<'_, A>;
>     let b: WwMutex<'_, B>;
>     let ctx: WwAcquireCtx<'_>;
> 
>     ctx.enter()             // EnteredContext<'_, ()>
>         .lock(a)            // LockAttempt<'_, A, ()>
>         .or_err(a)?         // EnteredContext<'_, (A,)>
>         .lock(b)            // LockAttempt<'_, B, (A,)>
>         .or_lock_slow(a, b) // Result<EnteredContext<'_, (A, B,)>>
>         ?.finish()          // (WwMutexGuard<'_, A>, WwMutexGuard<'_,
> B>)
> 
> But no idea if this is actually useful...

That wouldn't work if the user wants to lock `a` and `b` in separate
calls, right? If user wants to lock `a` right away and lock `b` later
under certain conditions (still in the same context as `a`), then to
automatically release `a`, we have to keep the locked mutexes in some
dynamic list inside `EnteredContext` so we can access all the locked
mutexes when we want to unlock them on EDEADLK.

> 
> 
> What I think would be a good way forward would be to convert some
> existing C uses of `WwMutex` to the intended Rust API and see how it
> looks. Best to cover several different kinds of uses.

Good idea. I will try find sometime to do that during next week.


Regards,
Onur

