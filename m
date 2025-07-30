Return-Path: <linux-kernel+bounces-750600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C509B15E84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2950563460
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304C72874FB;
	Wed, 30 Jul 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le7WExzy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2C1A83ED;
	Wed, 30 Jul 2025 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872924; cv=none; b=nejg78oo1WpTbcoA/cbm867ZP0GEvUxxXroXM067Kn3h+rKCS4rcz2BoLOgQACM5jq3ebdP1FkRzRy9MFruuoi+M4XIIrYTkTbhYgGykhhgr7rjZLaytIqfXg7ho1olRS51hxy1dX16aSMqe4bi76xndyGOiW15ISr90yqQwmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872924; c=relaxed/simple;
	bh=f46/FtSc5yFgABtkdDwRxVIJIxcwDr/wN6veGoVHsqQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=T+00M4Fjkjg+mFFu3OVwIJyEQ0nPPBV2dkwkzSHHy1r36D5y95T0UeS7gspnUpjGl590vWnZzdhPitS1nG9HOJoUkUPFec9PD3OF43eRlz5kqnEhOjG8w4ZjoVcKza6S6knFCjv1qzSMzGG7eGkmj8B/oPSUYAO08aT3rR8y0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le7WExzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA55C4CEE7;
	Wed, 30 Jul 2025 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753872924;
	bh=f46/FtSc5yFgABtkdDwRxVIJIxcwDr/wN6veGoVHsqQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=le7WExzyw4HMM/44Oqi9NsnWYWcKKuJliDpg6j2UDRwhP6Xxw8s2BBHaEBiT4T0y1
	 EmbFIJuy5LxJx2mM49o2EfUXUzlQsD/GYt+78IxFi7Y7DeuI+iFDPdSezSKGebMidB
	 i99kOsLysQRrHEpytqIWy9ylN5zq94SyvJZ3Fzzb0ugtzqRfXUjcG/RZoGJZrHsxFc
	 2JzZZ4seaQgcoVLaG0LRiYH90GE0Yxn88bOOkci1FssPNvLohbOjOOiGOKqcp+VGRZ
	 RA8zAWPpeHdWY5nnf7FeNrUqG/3XGR84m7PCSwSm2PEGBQGVmXmutCF834R0YPy+le
	 27ZmJKfLOlOPQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 12:55:18 +0200
Message-Id: <DBPC27REX4N1.3JA4SSHDYXAHJ@kernel.org>
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
From: "Benno Lossin" <lossin@kernel.org>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <peterz@infradead.org>,
 <mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
 <felipe_life@live.com>, <daniel@sedlak.dev>, <bjorn3_gh@protonmail.com>,
 "Lyude" <thatslyude@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250724165351.509cff53@nimda.home>
 <DBOPIJHY9NZ7.2CU5XP7UY7ES3@kernel.org>
 <20250730132457.20a13d71@nimda.home>
In-Reply-To: <20250730132457.20a13d71@nimda.home>

On Wed Jul 30, 2025 at 12:24 PM CEST, Onur =C3=96zkan wrote:
> On Tue, 29 Jul 2025 19:15:12 +0200
> "Benno Lossin" <lossin@kernel.org> wrote:
>
>> > - The second note is about how EDEADLK is handled. On the C side, it
>> > looks like some code paths may not release all the previously locked
>> > mutexes or have a special/custom logic when locking returns EDEADLK
>> > (see [3]). So, handling EDEADLK automatically (pointed
>> > in [1]) can be quite useful for most cases, but that could also be a
>> > limitation in certain scenarios.
>> >
>> >  I was thinking we could provide an alternative version of each
>> > `lock*` function that accepts a closure which is called on the
>> > EDEADLK error. This way, we can support both auto-release locks and
>> > custom logic for handling EDEADLK scenarios.
>> >
>> >  Something like this (just a dummy code for demonstration):
>> >
>> >     ctx.lock_and_handle_edeadlk(|active_locks| {
>> >         // user-defined handling here
>> >     });
>>=20
>> But this function wouldn't be locking any additional locks, right?
>>=20
>> I think the closure makes sense to give as a way to allow custom code.
>> But we definitely should try to get the common use-cases closure-free
>> (except of course they run completely custom code to their specific
>> use-case).
>>=20
>> We can also try to invent a custom return type that is used instead of
>> `Result`. So for example:
>>=20
>>     let a: WwMutex<'_, A>;
>>     let b: WwMutex<'_, B>;
>>     let ctx: WwAcquireCtx<'_>;
>>=20
>>     ctx.enter()             // EnteredContext<'_, ()>
>>         .lock(a)            // LockAttempt<'_, A, ()>
>>         .or_err(a)?         // EnteredContext<'_, (A,)>
>>         .lock(b)            // LockAttempt<'_, B, (A,)>
>>         .or_lock_slow(a, b) // Result<EnteredContext<'_, (A, B,)>>
>>         ?.finish()          // (WwMutexGuard<'_, A>, WwMutexGuard<'_,
>> B>)
>>=20
>> But no idea if this is actually useful...
>
> That wouldn't work if the user wants to lock `a` and `b` in separate
> calls, right? If user wants to lock `a` right away and lock `b` later
> under certain conditions (still in the same context as `a`), then to
> automatically release `a`, we have to keep the locked mutexes in some
> dynamic list inside `EnteredContext` so we can access all the locked
> mutexes when we want to unlock them on EDEADLK.

Not sure I understand, you can write:

    let a: WwMutex<'_, A>;
    let b: WwMutex<'_, B>;
    let ctx: WwAcquireCtx<'_>;

    let lock_ctx =3D ctx.enter()
        .lock(a)
        .or_err(a)?;
    if !cond() {
        return ...;
    }
    lock_ctx.lock(b)
        .or_lock_slow(a, b)?
        .finish()

>> What I think would be a good way forward would be to convert some
>> existing C uses of `WwMutex` to the intended Rust API and see how it
>> looks. Best to cover several different kinds of uses.
>
> Good idea. I will try find sometime to do that during next week.

Thanks!

---
Cheers,
Benno

