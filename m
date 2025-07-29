Return-Path: <linux-kernel+bounces-749711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A8AB151F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339087AFFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC912989A2;
	Tue, 29 Jul 2025 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWkAaDv8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054240855;
	Tue, 29 Jul 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809322; cv=none; b=cNlcqPcHyaAp6Pb8oT6Y64LWeEqEsPEtG4nQZWjd1+8e6fKzJK8CVLPaDic/Vgm+Niyp9agzIl6nxFh2GQBVchM0yRyaCFa60hkt5ma8IRqqOGmBwPKvsdYv0S1UBD5dUVh+V8Qs/qvpaxC6OpDUZ6MdX2oHdoNfcU8dtrMVOqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809322; c=relaxed/simple;
	bh=L3yWx4eIiQDDCgO+iiALtwlgnG78iDzbDvkegULmXnw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZcXgIy7hU7Pd3WaK55gYyXFzcDd9ZyoUbTUHiewl6TBRrO0Sp/3020iJ/cCfggWdxVby3KXUlKaiHgLb+QlyPKweyLA/Y0jRA0jDsDBivVG58PrnzfTngXpfjzNLmJHsLgLd/nABvAzGfgwG25uXTW16jO/+0LN2xvWQiIxo6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWkAaDv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8177DC4CEF4;
	Tue, 29 Jul 2025 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753809321;
	bh=L3yWx4eIiQDDCgO+iiALtwlgnG78iDzbDvkegULmXnw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kWkAaDv8OuHqQvAyIykqhE3jcdDS22MnNR5z/k6oN2KETfRCTJZiEo5DNHQFAq1Qq
	 EB/TNfB1CA6EI4bL5hY6QemFcyHC3tEsTtDGxgjtgJWxNUk57/zSBdxhcIxS+vEPpS
	 zXZ5+eF9UdIoohXHoul1uazn3zR/4B8dTBemOhkH77cDT4MKyZrP6Eo5KY7hZ9xoL9
	 j56vFV5P84Bjlsr3BrjaaFSUdB6GXBeHwnj8hMMXBLS/HqjBIPNtI9YTYi2pSTU3Uz
	 7WbK14TlV3wRYJJXVJx7eMbacM+ZdGlEhfnCH6ue0gan0+tWBZe5XWbZGe44lFJoxZ
	 wMAfaolc9laNg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 19:15:12 +0200
Message-Id: <DBOPIJHY9NZ7.2CU5XP7UY7ES3@kernel.org>
Cc: <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <peterz@infradead.org>,
 <mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
 <felipe_life@live.com>, <daniel@sedlak.dev>, <bjorn3_gh@protonmail.com>,
 "Lyude" <thatslyude@gmail.com>
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
From: "Benno Lossin" <lossin@kernel.org>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250724165351.509cff53@nimda.home>
In-Reply-To: <20250724165351.509cff53@nimda.home>

On Thu Jul 24, 2025 at 3:53 PM CEST, Onur =C3=96zkan wrote:
> Hi again,
>
> Just finished going over the C-side use of `ww_mutex` today and I
> wanted to share some notes and thoughts based on that.

Thanks!

> To get the full context, you might want to take a look at this thread
> [1].
>
> - The first note I took is that we shouldn't allow locking without
> `WwAcquireCtx` (which is currently possible in v5). As explained in
> ww_mutex documentation [2], this basically turns it into a regular
> mutex and you don't get benefits of `ww_mutex`.
>
>  From what I have seen on the C side, there is no real use-case for
>  this. It doesn't make much sense to use `ww_mutex` just for
>  single-locking scenarios. Unless a specific use-case comes up, I think
>  we shouldn't support using it that way. I am planning to move the
>  `lock*` functions under `impl WwAcquireCtx` (as we discussed in [1]),
>  which will make `WwAcquireCtx` required by design and also simplify
>  the implementation a lot.

Sounds good to me. Although [2] states that:

    * Functions to only acquire a single w/w mutex, which results in the ex=
act same
      semantics as a normal mutex. This is done by calling ww_mutex_lock wi=
th a NULL
      context.
   =20
      Again this is not strictly required. But often you only want to acqui=
re a
      single lock in which case it's pointless to set up an acquire context=
 (and so
      better to avoid grabbing a deadlock avoidance ticket).

So maybe it is needed? Would need some use-cases to determine this.

> - The second note is about how EDEADLK is handled. On the C side, it
> looks like some code paths may not release all the previously locked
> mutexes or have a special/custom logic when locking returns EDEADLK
> (see [3]). So, handling EDEADLK automatically (pointed
> in [1]) can be quite useful for most cases, but that could also be a
> limitation in certain scenarios.
>
>  I was thinking we could provide an alternative version of each `lock*`
>  function that accepts a closure which is called on the EDEADLK error.
>  This way, we can support both auto-release locks and custom logic for
>  handling EDEADLK scenarios.
>
>  Something like this (just a dummy code for demonstration):
>
>     ctx.lock_and_handle_edeadlk(|active_locks| {
>         // user-defined handling here
>     });

But this function wouldn't be locking any additional locks, right?

I think the closure makes sense to give as a way to allow custom code.
But we definitely should try to get the common use-cases closure-free
(except of course they run completely custom code to their specific
use-case).

We can also try to invent a custom return type that is used instead of
`Result`. So for example:

    let a: WwMutex<'_, A>;
    let b: WwMutex<'_, B>;
    let ctx: WwAcquireCtx<'_>;

    ctx.enter()             // EnteredContext<'_, ()>
        .lock(a)            // LockAttempt<'_, A, ()>
        .or_err(a)?         // EnteredContext<'_, (A,)>
        .lock(b)            // LockAttempt<'_, B, (A,)>
        .or_lock_slow(a, b) // Result<EnteredContext<'_, (A, B,)>>
        ?.finish()          // (WwMutexGuard<'_, A>, WwMutexGuard<'_, B>)

But no idea if this is actually useful...



What I think would be a good way forward would be to convert some
existing C uses of `WwMutex` to the intended Rust API and see how it
looks. Best to cover several different kinds of uses.

I quickly checked [2] and saw use-case with a dynamic number of locks
(all stored in a linked list). This isn't supported by the
`EnteredContext<'_, ()>` & tuple extenstion idea I had, so we need
something new for handling lists, graphs and other datastructures.

The example with the list also is a bit problematic from a guard point
of view, since we need a dynamic number of guards, which means we would
need to allocate...

[2]: https://www.kernel.org/doc/Documentation/locking/ww-mutex-design.txt

---
Cheers,
Benno

