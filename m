Return-Path: <linux-kernel+bounces-732218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69AB06395
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893047B5D87
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D0218589;
	Tue, 15 Jul 2025 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAgAN9Q7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690F1531E8;
	Tue, 15 Jul 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594921; cv=none; b=nhZwdjkdoQfOXs47LFhBua0xEXkJnWmAeXhZPiTZ1kE8tJku32hevE9nFU0c8YDVENGoM5pCzany+bBoDgX8jg4X/okZ2JJZnsTe1ZALWl4etd/mfPbBP9uiZDerCkw7n5Yqbhm5Fgs3eD2mVdWPcAheyr9dTo5JmJvp0MktIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594921; c=relaxed/simple;
	bh=lM5npeo5SVpxom38WImUYkut32bVHi3FnoTSjwhrrIo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cLmXMRJEEhOBJxJaaiDr6NKzAkbued09N+5TDyJet8/hYWbxYQVJy3B5PnK+ANqQF7sssW12GKMLZLXIDZe7gg6xqRjtKzGktDTBmTSmVv4QPB85cW6AoulOuzODW0Zu/vHBnGMZr6v6YFYYZLtTy7p+ihPKr7GKMdpHg/OWevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAgAN9Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBA5C4CEE3;
	Tue, 15 Jul 2025 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752594918;
	bh=lM5npeo5SVpxom38WImUYkut32bVHi3FnoTSjwhrrIo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NAgAN9Q7wevmKgtEDKjHWtJnopUlZdW+nC4ywK6db4c/JpCOOHAfv4++Lkkkfv8NL
	 VbFaJp5BhaxwEIv+pTU6pQ8StQgSa/HprpOzMYpt5W1Gz+i4THEGrsLwVagW10OFjC
	 HKw4MyjMb6/EMQQKWIdW5EgCSyyqfsRYCPdbhf1b5bx9PeyLl397FXJPKj+WdoppRS
	 Fd446Pxb3I/mvoWawUB26gG226rVTR8n3t0JhAQI8Dhl2nOKsB1dznrhqGIXxDmeRv
	 IPq8U4ULsUMZW7wxxpPzBjb0ryPn6OnlAvogPg/T7PqC1FdGCjjjCDvsTBi3eSHNb6
	 LyGpSyxsLGaaA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 17:55:13 +0200
Message-Id: <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org>
Cc: "Mitchell Levy" <levymitchell0@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Dennis Zhou"
 <dennis@kernel.org>, "Tejun Heo" <tj@kernel.org>, "Christoph Lameter"
 <cl@linux.com>, "Danilo Krummrich" <dakr@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/5] rust: percpu: add a rust per-CPU variable test
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
 <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
 <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org> <aHZhcNCayTOQhvYh@Mac.home>
In-Reply-To: <aHZhcNCayTOQhvYh@Mac.home>

On Tue Jul 15, 2025 at 4:10 PM CEST, Boqun Feng wrote:
> On Tue, Jul 15, 2025 at 01:31:06PM +0200, Benno Lossin wrote:
> [...]
>> >> > +impl kernel::Module for PerCpuTestModule {
>> >> > +    fn init(_module: &'static ThisModule) -> Result<Self, Error> {
>> >> > +        pr_info!("rust percpu test start\n");
>> >> > +
>> >> > +        let mut native: i64 =3D 0;
>> >> > +        // SAFETY: PERCPU is properly defined
>> >> > +        let mut pcpu: StaticPerCpu<i64> =3D unsafe { unsafe_get_pe=
r_cpu!(PERCPU) };
>> >>=20
>> >> I don't understand why we need unsafe here, can't we just create
>> >> something specially in the `define_per_cpu` macro that is then confir=
med
>> >> by the `get_per_cpu!` macro and thus it can be safe?
>> >
>> > As is, something like
>> >     define_per_cpu!(PERCPU: i32 =3D 0);
>> >
>> >     fn func() {
>> >         let mut pcpu: StaticPerCpu<i64> =3D unsafe { unsafe_get_per_cp=
u!(PERCPU) };
>> >     }
>> > will compile, but any usage of `pcpu` will be UB. This is because
>> > `unsafe_get_per_cpu!` is just blindly casting pointers and, as far as =
I
>> > know, the compiler does not do any checking of pointer casts. If you
>> > have thoughts/ideas on how to get around this problem, I'd certainly
>> > *like* to provide a safe API here :)
>>=20
>> I haven't taken a look at your implementation, but you do have the type
>> declared in `define_per_cpu!`, so it's a bit of a mystery to me why you
>> can't get that out in `unsafe_get_per_cpu!`...
>>=20
>> Maybe in a few weeks I'll be able to take a closer look.
>>=20
>> >> > +        // SAFETY: We only have one PerCpu that points at PERCPU
>> >> > +        unsafe { pcpu.get(CpuGuard::new()) }.with(|val: &mut i64| =
{
>> >>=20
>> >> Hmm I also don't like the unsafe part here...
>> >>=20
>> >> Can't we use the same API that `thread_local!` in the standard librar=
y
>
> First of all, `thread_local!` has to be implemented by some sys-specific
> unsafe mechanism, right? For example on unix, I think it's using
> pthread_key_t:
>
> 	https://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_key_cr=
eate.html
>
> what we are implementing (or wrapping) is the very basic unsafe
> mechanism for percpu here. Surely we can explore the design for a safe
> API, but the unsafe mechanism is probably necessary to look into at
> first.

But this is intended to be used by drivers, right? If so, then we should
do our usual due diligence and work out a safe abstraction. Only fall
back to unsafe if it isn't possible.

I'm not familiar with percpu, but from the name I assumed that it's
"just a variable for each cpu" so similar to `thread_local!`, but it's
bound to the specific cpu instead of the thread.

That in my mind should be rather easy to support in Rust at least with
the thread_local-style API. You just need to ensure that no reference
can escape the cpu, so we can make it `!Send` & `!Sync` + rely on klint
to detect context switches.

>> >> has:
>> >>=20
>> >>     https://doc.rust-lang.org/std/macro.thread_local.html
>> >>=20
>> >> So in this example you would store a `Cell<i64>` instead.
>> >>=20
>> >> I'm not familiar with per CPU variables, but if you're usually storin=
g
>> >> `Copy` types, then this is much better wrt not having unsafe code
>> >> everywhere.
>> >>=20
>> >> If one also often stores `!Copy` types, then we might be able to get
>> >> away with `RefCell`, but that's a small runtime overhead -- which is
>> >> probably bad given that per cpu variables are most likely used for
>> >> performance reasons? In that case the user might just need to store
>> >> `UnsafeCell` and use unsafe regardless. (or we invent something
>
> This sounds reasonable to me.
>
>> >> specifically for that case, eg tokens that are statically known to be
>> >> unique etc)
>> >
>> > I'm open to including a specialization for `T: Copy` in a similar vein
>> > to what I have here for numeric types. Off the top of my head, that
>> > shouldn't require any user-facing `unsafe`. But yes, I believe there i=
s
>> > a significant amount of interest in having `!Copy` per-CPU variables.
>> > (At least, I'm interested in having them around for experimenting with
>> > using Rust for HV drivers.)
>>=20
>> What kinds of types would you like to store? Allocations? Just integers
>> in bigger structs? Mutexes?
>>=20
>
> In the VMBus driver, there is a percpu work_struct.

Do you have a link? Or better yet a Rust struct description of what you
think it will look like :)

>> > I would definitely like to avoid *requiring* the use of `RefCell` sinc=
e,
>> > as you mention, it does have a runtime overhead. Per-CPU variables can
>> > be used for "logical" reasons rather than just as a performance
>> > optimization, so there might be some cases where paying the runtime
>> > overhead is ok. But that's certainly not true in all cases. That said,
>> > perhaps there could be a safely obtainable token type that only passes=
 a
>> > `&T` (rather than a `&mut T`) to its closure, and then if a user doesn=
't
>> > mind the runtime overhead, they can choose `T` to be a `RefCell`.
>> > Thoughts?
>>=20
>> So I think using an API similar to `thread_local!` will allow us to have
>> multiple other APIs that slot into that. `Cell<T>` for `T: Copy`,
>> `RefCell<T>` for cases where you don't care about the runtime overhead,
>> plain `T` for cases where you only need `&T`. For the case where you
>> need `&mut T`, we could have something like a `TokenCell<T>` that gives
>> out a token that you need to mutably borrow in order to get `&mut T`.
>> Finally for anything else that is too restricted by this, users can also
>> use `UnsafeCell<T>` although that requires `unsafe`.
>>=20
>> I think the advantage of this is that the common cases are all safe and
>> very idiomatic. In the current design, you *always* have to use unsafe.
>>=20
>
> I agree, but like I said, we need to figure out the unsafe interface
> that C already uses and build API upon it. I think focusing on the
> unsafe mechanism may be the way to start: you cannot implement something
> that cannot be implemented, and we don't have the magic pthread_key here
> ;-)

Sure we can do some experimentation, but I don't think we should put
unsafe abstractions upstream that we intend to replace with a safe
abstraction later. Otherwise people are going to depend on it and it's
going to be a mess. Do the experimenting out of tree and learn there.

---
Cheers,
Benno

