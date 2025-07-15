Return-Path: <linux-kernel+bounces-731740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F15EB058E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593327B7447
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A62DAFBB;
	Tue, 15 Jul 2025 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzOVpspQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF262DA753;
	Tue, 15 Jul 2025 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579072; cv=none; b=ETSYUFELpWlkFCaR7Y/ucL0CmVxjj3K7PeqBj1LtxRD8Q/kbQiHMzQTx0zZJsWY77+MQI6ntH8BIiCbwnLUYHFqdJD1BInCcmYJ8N5Fkz4C3IukvpDVTJdVnpHtUGJEZz4eKG8u21AuO8iDMexuVHaz0SRv9PCmXAK8n15Jopyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579072; c=relaxed/simple;
	bh=qTB8vzTixTpm3wEfYNlb54btZpsBf8r9fBjMKLDVrWc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gb+yBlKvkw0pXldiByxy32XUUzoiQtf2ohNmjsp+N6w7NXW6nE1LU7HPSQwgUsc6jG3JyPV+hjL1Qsg7U1zAdWDCcweyCD2zo2cQSrqr2X/bD3WkflT1vfv/6LGLoWtNt2YuiTszTsrOhjoViT7RGbcfFWXRgo+yVVtvkPUeuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzOVpspQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CB7C4CEE3;
	Tue, 15 Jul 2025 11:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752579071;
	bh=qTB8vzTixTpm3wEfYNlb54btZpsBf8r9fBjMKLDVrWc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PzOVpspQqciglPtD7dzDo2/PwrO0glyWo2YflyoOSrzXK3b+H0V8gu5N4uUE0GeK9
	 bS00ebjJsg9bs+SlBBZBt/d5vgKYt3V4Rq6eLYl79c+ic1IHDiXWQZ2jq768Zn9QgD
	 Ayt+vfbCpyYRb5n8b9e3mxUe/g/WrmrchCrQULgA2WHGzNo8Fb8U8zT0+vP9IwlNEN
	 neYOZTsxHrsLiml56Tfbhj6PPLFRYET2v7tH7S7in0kH5Ur04eBCRTl6Qxc7tamPUS
	 Bu/F2CM1NIoR23Zz9p3TEIPQhtxyFfsW8zMr03FK4qX0kZrefEE0kM6VqVSx27Mex9
	 wlY2ERxyeOryQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 13:31:06 +0200
Message-Id: <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
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
To: "Mitchell Levy" <levymitchell0@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
 <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
 <68762e19.170a0220.33e203.a0b7@mx.google.com>
In-Reply-To: <68762e19.170a0220.33e203.a0b7@mx.google.com>

On Tue Jul 15, 2025 at 12:31 PM CEST, Mitchell Levy wrote:
> On Sun, Jul 13, 2025 at 11:30:31AM +0200, Benno Lossin wrote:
>> On Sat Jul 12, 2025 at 11:31 PM CEST, Mitchell Levy wrote:
>> > Add a short exercise for Rust's per-CPU variable API, modelled after
>> > lib/percpu_test.c
>> >
>> > Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
>> > ---
>> >  lib/Kconfig.debug       |   9 ++++
>> >  lib/Makefile            |   1 +
>> >  lib/percpu_test_rust.rs | 120 +++++++++++++++++++++++++++++++++++++++=
+++++++++
>>=20
>> I don't know if this is the correct place, the code looks much more like
>> a sample, so why not place it there instead?
>
> I don't feel particularly strongly either way --- I defaulted to `lib/`
> since that's where the `percpu_test.c` I was working off of is located.
> Happy to change for v3

Since we don't have Rust stuff in lib/ yet (and that the code looks much
more like the samples we already have) I think putting it in
samples/rust is better.

>> >  rust/helpers/percpu.c   |  11 +++++
>> >  4 files changed, 141 insertions(+)
>> > diff --git a/lib/percpu_test_rust.rs b/lib/percpu_test_rust.rs
>> > new file mode 100644
>> > index 000000000000..a9652e6ece08
>> > --- /dev/null
>> > +++ b/lib/percpu_test_rust.rs
>> > @@ -0,0 +1,120 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +//! A simple self test for the rust per-CPU API.
>> > +
>> > +use core::ffi::c_void;
>> > +
>> > +use kernel::{
>> > +    bindings::{on_each_cpu, smp_processor_id},
>> > +    define_per_cpu,
>> > +    percpu::{cpu_guard::*, *},
>> > +    pr_info,
>> > +    prelude::*,
>> > +    unsafe_get_per_cpu,
>> > +};
>> > +
>> > +module! {
>> > +    type: PerCpuTestModule,
>> > +    name: "percpu_test_rust",
>> > +    author: "Mitchell Levy",
>> > +    description: "Test code to exercise the Rust Per CPU variable API=
",
>> > +    license: "GPL v2",
>> > +}
>> > +
>> > +struct PerCpuTestModule;
>> > +
>> > +define_per_cpu!(PERCPU: i64 =3D 0);
>> > +define_per_cpu!(UPERCPU: u64 =3D 0);
>> > +
>> > +impl kernel::Module for PerCpuTestModule {
>> > +    fn init(_module: &'static ThisModule) -> Result<Self, Error> {
>> > +        pr_info!("rust percpu test start\n");
>> > +
>> > +        let mut native: i64 =3D 0;
>> > +        // SAFETY: PERCPU is properly defined
>> > +        let mut pcpu: StaticPerCpu<i64> =3D unsafe { unsafe_get_per_c=
pu!(PERCPU) };
>>=20
>> I don't understand why we need unsafe here, can't we just create
>> something specially in the `define_per_cpu` macro that is then confirmed
>> by the `get_per_cpu!` macro and thus it can be safe?
>
> As is, something like
>     define_per_cpu!(PERCPU: i32 =3D 0);
>
>     fn func() {
>         let mut pcpu: StaticPerCpu<i64> =3D unsafe { unsafe_get_per_cpu!(=
PERCPU) };
>     }
> will compile, but any usage of `pcpu` will be UB. This is because
> `unsafe_get_per_cpu!` is just blindly casting pointers and, as far as I
> know, the compiler does not do any checking of pointer casts. If you
> have thoughts/ideas on how to get around this problem, I'd certainly
> *like* to provide a safe API here :)

I haven't taken a look at your implementation, but you do have the type
declared in `define_per_cpu!`, so it's a bit of a mystery to me why you
can't get that out in `unsafe_get_per_cpu!`...

Maybe in a few weeks I'll be able to take a closer look.

>> > +        // SAFETY: We only have one PerCpu that points at PERCPU
>> > +        unsafe { pcpu.get(CpuGuard::new()) }.with(|val: &mut i64| {
>>=20
>> Hmm I also don't like the unsafe part here...
>>=20
>> Can't we use the same API that `thread_local!` in the standard library
>> has:
>>=20
>>     https://doc.rust-lang.org/std/macro.thread_local.html
>>=20
>> So in this example you would store a `Cell<i64>` instead.
>>=20
>> I'm not familiar with per CPU variables, but if you're usually storing
>> `Copy` types, then this is much better wrt not having unsafe code
>> everywhere.
>>=20
>> If one also often stores `!Copy` types, then we might be able to get
>> away with `RefCell`, but that's a small runtime overhead -- which is
>> probably bad given that per cpu variables are most likely used for
>> performance reasons? In that case the user might just need to store
>> `UnsafeCell` and use unsafe regardless. (or we invent something
>> specifically for that case, eg tokens that are statically known to be
>> unique etc)
>
> I'm open to including a specialization for `T: Copy` in a similar vein
> to what I have here for numeric types. Off the top of my head, that
> shouldn't require any user-facing `unsafe`. But yes, I believe there is
> a significant amount of interest in having `!Copy` per-CPU variables.
> (At least, I'm interested in having them around for experimenting with
> using Rust for HV drivers.)

What kinds of types would you like to store? Allocations? Just integers
in bigger structs? Mutexes?

> I would definitely like to avoid *requiring* the use of `RefCell` since,
> as you mention, it does have a runtime overhead. Per-CPU variables can
> be used for "logical" reasons rather than just as a performance
> optimization, so there might be some cases where paying the runtime
> overhead is ok. But that's certainly not true in all cases. That said,
> perhaps there could be a safely obtainable token type that only passes a
> `&T` (rather than a `&mut T`) to its closure, and then if a user doesn't
> mind the runtime overhead, they can choose `T` to be a `RefCell`.
> Thoughts?

So I think using an API similar to `thread_local!` will allow us to have
multiple other APIs that slot into that. `Cell<T>` for `T: Copy`,
`RefCell<T>` for cases where you don't care about the runtime overhead,
plain `T` for cases where you only need `&T`. For the case where you
need `&mut T`, we could have something like a `TokenCell<T>` that gives
out a token that you need to mutably borrow in order to get `&mut T`.
Finally for anything else that is too restricted by this, users can also
use `UnsafeCell<T>` although that requires `unsafe`.

I think the advantage of this is that the common cases are all safe and
very idiomatic. In the current design, you *always* have to use unsafe.

> For `UnsafeCell`, if a user of the API were to have something like a
> `PerCpu<UnsafeCell<T>>` that safely spits out a `&UnsafeCell<T>`, my
> understanding is that mutating the underlying `T` would require the
> exact same safety guarantees as what's here, except now it'd need a much
> bigger unsafe block and would have to do all of its manipulations via
> pointers. That seems like a pretty big ergonomics burden without a clear
> (to me) benefit.

It would require the same amount of unsafe & safety comments, but it
wouldn't be bigger comments, since you can just as well create `&mut T`
to the value.

---
Cheers,
Benno

