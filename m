Return-Path: <linux-kernel+bounces-743197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC5BB0FBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E411C81BED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBCD233739;
	Wed, 23 Jul 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qM7nUZk9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13A22A1D4;
	Wed, 23 Jul 2025 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303282; cv=none; b=MA0dVmy912QH/bqfIK/Q7+xUqL23nsiI8ePv9SnCbOcB8KnFobF+29EUg56gk7y7CK0oH6PxYaiRRZVur+9yDzQMZjAV6hpQuIMJoVGO8kzODpguE8d/5hcJQ8J4OK0vcl09S9mKwYP5HtDmLYQ4D4/3mJif2ACjfFP/GEnnvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303282; c=relaxed/simple;
	bh=jA45vF5Lp0rLmLRa/Yl9ngbausMkIJiAT+08WzTKMao=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QhsK0e2v6orkVo7pyR6IJ6ZvdnmvADICpu/XOviWW8TVD3vJEmVxuGUzepxJKFJPf3AhuF1DP9MmkV9cZhl3J4cidgKk1x+4rLq03KTHUm10im28tkv+jHRwhb4l0/9a3ssMMsMUZogmJ5UmGP6oou41CMo7mwDDZpqad2W5J1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qM7nUZk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46881C4CEE7;
	Wed, 23 Jul 2025 20:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753303282;
	bh=jA45vF5Lp0rLmLRa/Yl9ngbausMkIJiAT+08WzTKMao=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qM7nUZk9Hjk/QGbxBEHp+XXQvh3BPYMwkIpEcd7MLN8x0QQnsqV2rYMy+uYt5H+pi
	 3B1EFBWqO0TGE32362BYrdfAfb4z/td+b3vuMPxKhioxQPzldyIY8JRrL9up4Jzc2F
	 0vvlw+/8Gu/1zpIaRIqpo5VuDy5vWaVr75/UOMXWTFx7UCY6bXk6Arazq+3A8D+dMu
	 gIDp8cY6tayzFBjXsX6hb5qhbnz4YMbKQwFOBos5n427VXaihsGRNGnjmvaEN5bBb+
	 xcBulznNyMkPrhY5URZ6nBVjjg1ix2wJoJKtjggHbikBXRHpYsjGpzq4E7qmMOU/bN
	 9uboPoHkU+wDw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 22:41:18 +0200
Message-Id: <DBJQ52JWDGY0.37W393KWBWX6G@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: sync: refactor static_lock_class!() macro
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-1-85fa506b8ca4@google.com>
 <DBJIDFSMYASO.3VRN4ZZEUI8EX@kernel.org>
 <CAH5fLgjWFa8TjTL+rfv7Zd+OQqhkKqWvyTkGf60pMUyQ=c4sXg@mail.gmail.com>
 <aIELxq_iVMfjszkh@tardis-2.local> <DBJOYRYFZJ5I.26IFPSP138T23@kernel.org>
 <aIFBEUdGU0r05wC6@tardis-2.local>
In-Reply-To: <aIFBEUdGU0r05wC6@tardis-2.local>

On Wed Jul 23, 2025 at 10:07 PM CEST, Boqun Feng wrote:
> On Wed, Jul 23, 2025 at 09:46:03PM +0200, Benno Lossin wrote:
>> On Wed Jul 23, 2025 at 6:20 PM CEST, Boqun Feng wrote:
>> > On Wed, Jul 23, 2025 at 05:01:39PM +0200, Alice Ryhl wrote:
>> >> On Wed, Jul 23, 2025 at 4:36=E2=80=AFPM Benno Lossin <lossin@kernel.o=
rg> wrote:
>> >> > On Wed Jul 23, 2025 at 1:49 PM CEST, Alice Ryhl wrote:
>> >> > >  impl LockClassKey {
>> >> > > +    /// Initializes a statically allocated lock class key.
>> >> > > +    ///
>> >> > > +    /// This is usually used indirectly through the [`static_loc=
k_class!`] macro.
>> >> > > +    ///
>> >> > > +    /// # Safety
>> >> > > +    ///
>> >> > > +    /// The destructor must never run on the returned `LockClass=
Key`.
>> >> >
>> >> > I don't know how lockdep works, but Boqun mentioned in the other th=
read
>> >> > that it uses the address of static keys. But AFAIK there is no mech=
anism
>> >> > to differentiate them, so does lockdep just check the address and i=
f it
>> >
>> > In lockdep, we use `static_obj()` to tell whether it's a static obj or=
 a
>> > dynamic allocated one.
>>=20
>> So the code below will go in the non-static code path. Why doesn't it
>> need to be initialized/registered? (but other cases need it?)
>>=20
>
> Becasue all the dynamic lock class keys are put in a hash list (using an
> intrusive single linked list), so you have to register it before use and
> unregister after use.

Gotcha.

>> >> > is in a static segment it uses different behavior?
>> >> >
>> >> > Because from the safety requirements on this function, I could just=
 do
>> >> > this:
>> >> >
>> >> >     // SAFETY: we leak the box below, so the destructor never runs.
>> >> >     let class =3D KBox::new(unsafe { LockClassKey::new_static() });
>> >> >     let class =3D Pin::static_ref(KBox::leak(class));
>> >> >     let lock =3D SpinLock::new(42, c_str!("test"), class);
>> >
>> > This will trigger a runtime error because `class` is not static, but
>> > technically, it won't trigger UB, at least lockdep should be able to
>> > handle this case.
>>=20
>> Could you go into more details? What is the "technically it won't
>> trigger UB" part about?
>>=20
>
> If a dynamic key is not registered, lockdep will simply just skip the
> initialization of locks, report an error and disable itself entirely. So
> it won't cause UB.

So the code above would trigger lockdep to disable itself?

And how does it detect that the class isn't registered? By checking for
the address in the hash list? Otherwise it would be UB, right? Could
there be a hash collision that induces UB?

---
Cheers,
Benno

