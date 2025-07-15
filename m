Return-Path: <linux-kernel+bounces-732342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E613B06557
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678191727BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006E2874F7;
	Tue, 15 Jul 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAoCSJhR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E59285C9D;
	Tue, 15 Jul 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601447; cv=none; b=etnQ3KF+HVxJoAe+n3AHsdlnCHoBoQczbvOLtSTiD4LRBIBJIuUaj2a+CKSok9fy83K+8hejkSXSxekSyA2R7PlC43UmS0NK265NXpEuoo0Kqu0LWoOaK1eiCP+xa5zrcxPqUPjWj2+lMr09Auk0LdOcrAG8T6SY4lhmIjiu+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601447; c=relaxed/simple;
	bh=6sfqcOH8puA+a1sDQFn8QveHcgBcHzTz4Z3BgnTRXEE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=aAiXuiyHJy56frypraLiNnnKl3QtdyJye8uqKnjWqEwrjX3cQKR/duw+kRdwHDuOULcedsBz9K97JftlqJ8XsXPOx4PCnt1tAg/kHSqvx9tUYvG5utA3FZ5yB/SrkVJf61cVfP7CipaSA6AhoF2HFtBMxdk+qJt/OefTzRC4Phw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAoCSJhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1F0C4CEE3;
	Tue, 15 Jul 2025 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752601446;
	bh=6sfqcOH8puA+a1sDQFn8QveHcgBcHzTz4Z3BgnTRXEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAoCSJhRYNhfcNTb74YcPzf+cYSmlo6gS/utgiFRBuTL0zNQXGhaF3/ReLuqe6lQo
	 SE+SXaAP2LKFrAUXvYg6vJ8WNMmdY1lB5j95XvrCjXqQ3F2ca0eaCM1pbFrIAVR8RG
	 8axgAML+kcWNuGUs871wQSiWxfCs+pC5uep/+e5dbnPydjDYvzT0EVjD6qkc+3j/Wr
	 76JJA1aTKIy0UVYH9xkK40SrR+OSjErkUaHIu9rCMUCBqCpkfykHxE87DdSklzc1mg
	 tn0pj2DusVlES8ADGV5eZgDtwmx9toMcX7TV1B3w/K0AVdw/rZwPujDQwv5ESqzIRr
	 aWhWTpEdcQsng==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 19:44:01 +0200
Message-Id: <DBCTCZ5HUZOF.2DJX63Q0VWWFN@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
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
X-Mailer: aerc 0.20.1
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
 <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
 <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org> <aHZhcNCayTOQhvYh@Mac.home>
 <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org> <aHaCUFNUd_mErL7S@Mac.home>
In-Reply-To: <aHaCUFNUd_mErL7S@Mac.home>

On Tue Jul 15, 2025 at 6:31 PM CEST, Boqun Feng wrote:
> On Tue, Jul 15, 2025 at 05:55:13PM +0200, Benno Lossin wrote:
>> On Tue Jul 15, 2025 at 4:10 PM CEST, Boqun Feng wrote:
>> > On Tue, Jul 15, 2025 at 01:31:06PM +0200, Benno Lossin wrote:
>> > [...]
>> >> >> > +impl kernel::Module for PerCpuTestModule {
>> >> >> > +    fn init(_module: &'static ThisModule) -> Result<Self, Error=
> {
>> >> >> > +        pr_info!("rust percpu test start\n");
>> >> >> > +
>> >> >> > +        let mut native: i64 =3D 0;
>> >> >> > +        // SAFETY: PERCPU is properly defined
>> >> >> > +        let mut pcpu: StaticPerCpu<i64> =3D unsafe { unsafe_get=
_per_cpu!(PERCPU) };
>> >> >>=20
>> >> >> I don't understand why we need unsafe here, can't we just create
>> >> >> something specially in the `define_per_cpu` macro that is then con=
firmed
>> >> >> by the `get_per_cpu!` macro and thus it can be safe?
>> >> >
>> >> > As is, something like
>> >> >     define_per_cpu!(PERCPU: i32 =3D 0);
>> >> >
>> >> >     fn func() {
>> >> >         let mut pcpu: StaticPerCpu<i64> =3D unsafe { unsafe_get_per=
_cpu!(PERCPU) };
>> >> >     }
>> >> > will compile, but any usage of `pcpu` will be UB. This is because
>> >> > `unsafe_get_per_cpu!` is just blindly casting pointers and, as far =
as I
>> >> > know, the compiler does not do any checking of pointer casts. If yo=
u
>> >> > have thoughts/ideas on how to get around this problem, I'd certainl=
y
>> >> > *like* to provide a safe API here :)
>> >>=20
>> >> I haven't taken a look at your implementation, but you do have the ty=
pe
>> >> declared in `define_per_cpu!`, so it's a bit of a mystery to me why y=
ou
>> >> can't get that out in `unsafe_get_per_cpu!`...
>> >>=20
>> >> Maybe in a few weeks I'll be able to take a closer look.
>> >>=20
>> >> >> > +        // SAFETY: We only have one PerCpu that points at PERCP=
U
>> >> >> > +        unsafe { pcpu.get(CpuGuard::new()) }.with(|val: &mut i6=
4| {
>> >> >>=20
>> >> >> Hmm I also don't like the unsafe part here...
>> >> >>=20
>> >> >> Can't we use the same API that `thread_local!` in the standard lib=
rary
>> >
>> > First of all, `thread_local!` has to be implemented by some sys-specif=
ic
>> > unsafe mechanism, right? For example on unix, I think it's using
>> > pthread_key_t:
>> >
>> > 	https://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_key=
_create.html
>> >
>> > what we are implementing (or wrapping) is the very basic unsafe
>> > mechanism for percpu here. Surely we can explore the design for a safe
>> > API, but the unsafe mechanism is probably necessary to look into at
>> > first.
>>=20
>> But this is intended to be used by drivers, right? If so, then we should
>
> Not necessarily only for drivers, we can also use it for implementing
> other safe abstraction (e.g. hazard pointers, percpu counters etc)

That's fair, but then it should be `pub(crate)`.

>> do our usual due diligence and work out a safe abstraction. Only fall
>> back to unsafe if it isn't possible.
>>=20
>
> All I'm saying is instead of figuring out a safe abstraction at first,
> we should probably focus on identifying how to implement it and which
> part is really unsafe and the safety requirement for that.

Yeah. But then we should do that before merging :)

>> I'm not familiar with percpu, but from the name I assumed that it's
>> "just a variable for each cpu" so similar to `thread_local!`, but it's
>> bound to the specific cpu instead of the thread.
>>=20
>> That in my mind should be rather easy to support in Rust at least with
>> the thread_local-style API. You just need to ensure that no reference
>> can escape the cpu, so we can make it `!Send` & `!Sync` + rely on klint
>
> Not really, in kernel, we have plenty of use cases that we read the
> other CPU's percpu variables. For example, each CPU keeps it's own
> counter and we sum them other in another CPU.

But then you need some sort of synchronization?

> If we would like to model it conceptually, it's more like an array
> that's index by CpuId to me.

Gotcha, but this model is missing the access control/synchronization. So
I'm not so sure how useful it is.

(I think I asked this somewhere else, but the number of CPUs doesn't
change, right?)

>> to detect context switches.
>>=20
>> >> >> has:
>> >> >>=20
>> >> >>     https://doc.rust-lang.org/std/macro.thread_local.html
>> >> >>=20
>> >> >> So in this example you would store a `Cell<i64>` instead.
>> >> >>=20
>> >> >> I'm not familiar with per CPU variables, but if you're usually sto=
ring
>> >> >> `Copy` types, then this is much better wrt not having unsafe code
>> >> >> everywhere.
>> >> >>=20
>> >> >> If one also often stores `!Copy` types, then we might be able to g=
et
>> >> >> away with `RefCell`, but that's a small runtime overhead -- which =
is
>> >> >> probably bad given that per cpu variables are most likely used for
>> >> >> performance reasons? In that case the user might just need to stor=
e
>> >> >> `UnsafeCell` and use unsafe regardless. (or we invent something
>> >
>> > This sounds reasonable to me.
>> >
>> >> >> specifically for that case, eg tokens that are statically known to=
 be
>> >> >> unique etc)
>> >> >
>> >> > I'm open to including a specialization for `T: Copy` in a similar v=
ein
>> >> > to what I have here for numeric types. Off the top of my head, that
>> >> > shouldn't require any user-facing `unsafe`. But yes, I believe ther=
e is
>> >> > a significant amount of interest in having `!Copy` per-CPU variable=
s.
>> >> > (At least, I'm interested in having them around for experimenting w=
ith
>> >> > using Rust for HV drivers.)
>> >>=20
>> >> What kinds of types would you like to store? Allocations? Just intege=
rs
>> >> in bigger structs? Mutexes?
>> >>=20
>> >
>> > In the VMBus driver, there is a percpu work_struct.
>>=20
>> Do you have a link? Or better yet a Rust struct description of what you
>> think it will look like :)
>>=20
>
> Not Rust code yet, but here is the corresponding C code:
>
> 	https://github.com/Rust-for-Linux/linux/blob/rust-next/drivers/hv/vmbus_=
drv.c#L1396

Thanks!

> But please note that we are not solely developing the abstraction for
> this usage, but more for generally understand how to wrap percpu
> functionality similar to the usage in C.

Well, I have to start somewhere for looking at the use-cases :)

If you have more, just let me see. (probably won't have enough time to
look at them now, but maybe in a couple weeks)

>> >> > I would definitely like to avoid *requiring* the use of `RefCell` s=
ince,
>> >> > as you mention, it does have a runtime overhead. Per-CPU variables =
can
>> >> > be used for "logical" reasons rather than just as a performance
>> >> > optimization, so there might be some cases where paying the runtime
>> >> > overhead is ok. But that's certainly not true in all cases. That sa=
id,
>> >> > perhaps there could be a safely obtainable token type that only pas=
ses a
>> >> > `&T` (rather than a `&mut T`) to its closure, and then if a user do=
esn't
>> >> > mind the runtime overhead, they can choose `T` to be a `RefCell`.
>> >> > Thoughts?
>> >>=20
>> >> So I think using an API similar to `thread_local!` will allow us to h=
ave
>> >> multiple other APIs that slot into that. `Cell<T>` for `T: Copy`,
>> >> `RefCell<T>` for cases where you don't care about the runtime overhea=
d,
>> >> plain `T` for cases where you only need `&T`. For the case where you
>> >> need `&mut T`, we could have something like a `TokenCell<T>` that giv=
es
>> >> out a token that you need to mutably borrow in order to get `&mut T`.
>> >> Finally for anything else that is too restricted by this, users can a=
lso
>> >> use `UnsafeCell<T>` although that requires `unsafe`.
>> >>=20
>> >> I think the advantage of this is that the common cases are all safe a=
nd
>> >> very idiomatic. In the current design, you *always* have to use unsaf=
e.
>> >>=20
>> >
>> > I agree, but like I said, we need to figure out the unsafe interface
>> > that C already uses and build API upon it. I think focusing on the
>> > unsafe mechanism may be the way to start: you cannot implement somethi=
ng
>> > that cannot be implemented, and we don't have the magic pthread_key he=
re
>> > ;-)
>>=20
>> Sure we can do some experimentation, but I don't think we should put
>> unsafe abstractions upstream that we intend to replace with a safe
>> abstraction later. Otherwise people are going to depend on it and it's
>
> I doubt we can replace the unsafe abstraction with a safe one, if users
> really care the performance then they would really need to use some
> unsafe API to build their safe abstraction.

That sounds pretty pessimistic, why do you think that?

>> going to be a mess. Do the experimenting out of tree and learn there.
>
> I disagree, Rust as a language its own should be able to do what C does
> including being able to implement the percpu functionality same as C,
> there is nothing wrong with a set of Rust primitives in the kernel that
> provides fundamental percpu functionality the other core facilities can
> rely on. The better part is that it will have all the safety requirement
> documented well.

Sure, but we haven't even tried to make it safe, so I don't think we
should add them now in this state.

---
Cheers,
Benno

