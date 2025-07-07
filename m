Return-Path: <linux-kernel+bounces-720125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA180AFB768
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD4E1AA3E0C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9984715746E;
	Mon,  7 Jul 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/rLsM8n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDC881E;
	Mon,  7 Jul 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902276; cv=none; b=m2vCLu+XhgENgSJ2HiHlfInP9UV+5b6rBjK3vA9NAQFoEzbdmhiG4/C1G73tNNKL0jBAoEgHR/jF0v4C8ZXpnof4atCJQlyeFUPF62ev9dxR6S1agKBQfpL9AkPunuo36p4KK/l2VEhP0NtRM5XrZ4kTv3gwqv688d4lV4MZqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902276; c=relaxed/simple;
	bh=O2TjwfiPXObkuPcjCvRAD8xMf8sZ9AOTnhhKKSuQN34=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U89yLqPLoHwXzjxI4GDcOsigotT0M11M0EsQ3kZAMb8a8/g9u+3qV03HiJ5Szn4QXuUinLRracjA7XREK8rvrqpu0V+N8gxs2+M8neRFRXVVn0TxURu8PLOwWVdR4dZMCu2JartjhtbTDmPH3qA85oJsyb5Xj+3KuxcwDfxyXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/rLsM8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B02C4CEF1;
	Mon,  7 Jul 2025 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751902275;
	bh=O2TjwfiPXObkuPcjCvRAD8xMf8sZ9AOTnhhKKSuQN34=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=X/rLsM8nH7EKvl4qlWRM+6fK2wtiF+7Td45AouDH0S5l8xXipckWEUPue+nvBlFG7
	 RNFUUKEPh+dhwS5lO14nT6Cghww2nfBt4hGEpTj+QkQXOPiBAUpZFvLHcBrWpd1WOO
	 6y9Y07Kgs0DGqLENYD06G2kfy2FZfhrDAQfsXEZDqEmuFO7zSdG/5Z2yJEQHHeUb9k
	 jWQ6M4rWxp/CrVnfaPjvdorykiEYRep5MKcf3cEA6olLLyW7TNySSb9bTWdUJnlUrj
	 UucWXQGXvGKauSuSrAg5RTBlur9z7/9+E7bz4QA3It3LP2YlQtVaXojDsZ1CCHt5hD
	 0uArupmUwTjOA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 17:31:10 +0200
Message-Id: <DB5XIWGZ8U36.1VB58YBJFL7OT@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <gary@garyguo.net>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
 <longman@redhat.com>, <felipe_life@live.com>, <daniel@sedlak.dev>,
 <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v5 2/3] implement ww_mutex abstraction for the Rust tree
From: "Benno Lossin" <lossin@kernel.org>
To: "Onur" <work@onurozkan.dev>
X-Mailer: aerc 0.20.1
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250621184454.8354-3-work@onurozkan.dev>
 <DASY7BECFRCT.332X5ZHZMV2W@kernel.org> <aFlQ7K_mYYbrG8Cl@Mac.home>
 <DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org> <aFlpFQ4ivKw81d-y@Mac.home>
 <DAU0ELV91E2Q.35FZOII18W44J@kernel.org>
 <20250707163913.5ffc046d@nimda.home>
In-Reply-To: <20250707163913.5ffc046d@nimda.home>

On Mon Jul 7, 2025 at 3:39 PM CEST, Onur wrote:
> On Mon, 23 Jun 2025 17:14:37 +0200
> "Benno Lossin" <lossin@kernel.org> wrote:
>
>> > We also need to take into consideration that the user want to drop
>> > any lock in the sequence? E.g. the user acquires a, b and c, and
>> > then drop b, and then acquires d. Which I think is possible for
>> > ww_mutex.
>>=20
>> Hmm what about adding this to the above idea?:
>>=20
>>     impl<'a, Locks> WwActiveCtx<'a, Locks>
>>     where
>>         Locks: Tuple
>>     {
>>         fn custom<L2>(self, action: impl FnOnce(Locks) -> L2) ->
>> WwActiveCtx<'a, L2>; }
>>=20
>> Then you can do:
>>=20
>>     let (a, c, d) =3D ctx.begin()
>>         .lock(a)
>>         .lock(b)
>>         .lock(c)
>>         .custom(|(a, _, c)| (a, c))
>>         .lock(d)
>>         .finish();
>
>
> Instead of `begin` and `custom`, why not something like this:
>
> 	let (a, c, d) =3D ctx.init()
> 	    .lock(a)
>             .lock(b)
>             .lock(c)
>             .unlock(b)
>             .lock(d)
>             .finish();
>
> Instead of `begin`, `init` would be better naming to imply `fini` on the
> C side, and `unlock` instead of `custom` would make the intent clearer
> when dropping locks mid chain.

I don't think that this `unlock` operation will work. How would you
implement it?

> I guess `lock()` is going to use the slow path since it's infallible? It
> might be good to provide a `try_lock` that returns -DEADLOCK
> immediately without blocking when it can't acquire the lock.

I think `lock` would first try the fast path and if it fails, it would
unlock all locks taken before & then re-try the slow path. (if that is
how ww_mutex is usually used, if not, I'd need to see the most common
use-case)

---
Cheers,
Benno

