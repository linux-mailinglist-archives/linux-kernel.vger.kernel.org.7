Return-Path: <linux-kernel+bounces-732272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E1B06461
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17B3189F35F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2525B2FD;
	Tue, 15 Jul 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFRpG7+F"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2619F464;
	Tue, 15 Jul 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597078; cv=none; b=XVu/+q679aWWrDbaWHRvyewtcY8eMZap9Dqrqp64pVbLOAHyIB0CbM14H/0+TXT3pcR2/XsBC8kJT46dsxeRbAoNEfV4vnNQyepULlXcH9wMcQvxRPySv95JDcMhkgPl9Qs0NYYBkYE4q39wYL90wBHazgbQGkPSQJAMuUo2Yc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597078; c=relaxed/simple;
	bh=jDLGSX0b2V2uvv2A9CQs5kVddLHGzu7Ta+fRAuNs3+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsyRthJUHjIgypqA/HyyVykHTewPUFemvG/S4cewRsA/WJe16DWMKXkr9zgOjQnywHsTbVjltP3c9loiqmAjjueYWw5+nlwNv0l+qLuSv05AyPtIax/MBOm7yUuK60VViOKZnPbfcEH4wIPY9PD1rmKE4tQlhFCZLLVZ1ghHqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFRpG7+F; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab7082b3f7so24748831cf.3;
        Tue, 15 Jul 2025 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752597076; x=1753201876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mjhxjbj7iS8ZyBEjzsqSgbZseWbedQ/eZ617a3fR4vs=;
        b=lFRpG7+FldV1S1QmPn+c0EYbYJ4eCuw9QQPeuRfBB3M0itAWGWkx7R/wowHH8sXcxc
         IlDROLTs/yN0zJaecrwttsCzQbASOfvQCj4T5bg1cqQmmOn9xbKJCuG7AEGHUQ2vhYg5
         V6nAsIZH3ja2xuJOUDIz2a444rogqwTQKSXpEgtmhQkZ/UzqujUbbzkmH82zgy1Xkn9e
         VP+gWpXRtNsDEkpwyHBEiNhdXglaGCqvTG3rxCTuv0adqciqDK3/isf4f1gOiwgZc6gm
         pQI3YyIG/Aul9VwPiIpV65jFYdppb5mPcRHn5DxCedoRabb3OHoHJwsirtBZTI8sNNL6
         AfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597076; x=1753201876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mjhxjbj7iS8ZyBEjzsqSgbZseWbedQ/eZ617a3fR4vs=;
        b=llE9BnNXtvdSopGnHD60vHxPYOCRt6CEZP0MdE9wH1pIIZCG4I9n9S6fmaXltoF2JE
         azzjUfIDpRGjh9TZ2lJ/iFxpIH0I0Myud3ks4BmHsCuilffCySHeTSVt5qO2D3X0n8Dq
         +of1wh7U4ZToWPLYlLtIMJEdj5bWaeFpjMOPPjZHtOHtscEn3CsDeP3v2ENF1tBFbaf6
         GdpnOKlMwQVWAuHx0ODCAhc09aCVgqPrpiS2F7dv03VHDJkxVMP8iS70fgKOEch2mEUr
         VaeJZ6WCVaI1PWIFoj85Juglq2ddMWFHKhP1IV/SQSaDwsYLJAQ0KsUY7qpaxueY1AkI
         Mo+w==
X-Forwarded-Encrypted: i=1; AJvYcCW8UzWOrDu/HWO08pucfA+tNhbLkJg+wwIlzrGMdxUjs6wqGJ/H+Zjv925Af+MyfGhdq2ZmuFb8K1IB3W5stgo=@vger.kernel.org, AJvYcCWQ+qfhwYVKFsuigcnexatZMUXLGUD0Ve7oqPGXV5t0O1i/VhaOebovEK/dU9SEP6yblg9bSCwxSk9Py9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuFN1fKdThCNs089Gj5qNy0VgJxTffXiENGF05IIXCoDEVqJps
	vd1M3joQ2Lhbt1eE+3d/cTRlToFpEiysDJ4BMCIDHyG854hiJWo3G+HX
X-Gm-Gg: ASbGncsWrvuc3ByafvxmXbphmdvKmYIr0jl8ftqdCP9KW1vJlFs3C/ZgY9eE88ULsgy
	5Tl/wpJitkzhQQuIUV0JX9KO2/mEX/LWZ8ykWnzZ6sqAyULOi0vHO1hPskcfuQvIOOgFDp89Uqx
	R2QysdYRpVku9VtHLErlkBZI978lF9za/8DQvh8wAyZ4iwqElyU1pqMwRimDzGvpdsAf+txO9+/
	RLYjv0WYYWtSEnQ3VsVoJfXORryTXx9KoKXh5oiXXmyfmvWyPYsfsqynQYFeBWvsH+WO8l/sA9S
	3DUcJmEm+Gj0ZN5vTD5YpIcgRdGY2R56Tq+MVdFX6EIzhgZAEEzM3qKXleqHm0FxbyZCAxALBBM
	/0SlaZtt89kWN3UZ16hDioyyWbOv5sCq4anJbnSJFnsLMwDaRf0vfY3bpAO1HUrmtHfMBey/sDd
	8WFNITDbnqbCLD
X-Google-Smtp-Source: AGHT+IGKcT812uvfhN6lx3CaHfEFlXJDMWfENRiBLEgYlLqzk0l/AjvFrC+4wp7erxyiJHyRaZV26g==
X-Received: by 2002:a05:622a:1449:b0:4ab:7cf5:877b with SMTP id d75a77b69052e-4ab909b6fc6mr2180011cf.4.1752597075580;
        Tue, 15 Jul 2025 09:31:15 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab7f75fcb5sm11048021cf.27.2025.07.15.09.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:31:15 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 906D5F40066;
	Tue, 15 Jul 2025 12:31:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 15 Jul 2025 12:31:14 -0400
X-ME-Sender: <xms:UoJ2aCaQcw2ax92T85cZ77gvTI5JEvXqkwCBNuTOcGqThMLtysS8sw>
    <xme:UoJ2aG4goCf_JDlyv2SD6gxWD-UE80fUzrgqZSoHTaIDdkNZ48QexSOROM99IrrJ8
    0HKMXJCakDeKqCN4g>
X-ME-Received: <xmr:UoJ2aKl7XigJ7cUs8_2HtBZ3Zlv3wEDCcZpXj_K-GzyA_38M0y-pWiI2OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepvdegueegtdejkeehueekheeffeeiffeilefgteetlefhheegkeejtdeiveejheef
    necuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgpdhruhhsthdqlhgrnhhgrdhorh
    hgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgr
    ihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhgvvhihmhhithgthhgvlhhltdesghhmrghilhdrtghomhdprhgtphhtth
    hopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihn
    ohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvg
    htpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhr
    tghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhs
    sehumhhitghhrdgvughu
X-ME-Proxy: <xmx:UoJ2aMEv4K0W62Dm7gil-eCIolQ9HtbE2lUgE6Glj0RN0xj9i7E60g>
    <xmx:UoJ2aOFWcHTL8GznCBU-06EpHJehnirnSWkExMCfQ2miv3HgtCOdaA>
    <xmx:UoJ2aE1D7gEjX29azT4PUshXsSS8IVir2fujR8xqMiqb-JqQTmAmKw>
    <xmx:UoJ2aAdtABY---wOhLSQB32m0XuaAaU-G47QjBP4Yfqmf0dbETmaEg>
    <xmx:UoJ2aGJ1TfB0wAVFVwZpqMqOmzxjuoD-51GigahrAlgLLXxSR8W_dpb0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 12:31:13 -0400 (EDT)
Date: Tue, 15 Jul 2025 09:31:12 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Mitchell Levy <levymitchell0@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/5] rust: percpu: add a rust per-CPU variable test
Message-ID: <aHaCUFNUd_mErL7S@Mac.home>
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
 <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
 <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org>
 <aHZhcNCayTOQhvYh@Mac.home>
 <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org>

On Tue, Jul 15, 2025 at 05:55:13PM +0200, Benno Lossin wrote:
> On Tue Jul 15, 2025 at 4:10 PM CEST, Boqun Feng wrote:
> > On Tue, Jul 15, 2025 at 01:31:06PM +0200, Benno Lossin wrote:
> > [...]
> >> >> > +impl kernel::Module for PerCpuTestModule {
> >> >> > +    fn init(_module: &'static ThisModule) -> Result<Self, Error> {
> >> >> > +        pr_info!("rust percpu test start\n");
> >> >> > +
> >> >> > +        let mut native: i64 = 0;
> >> >> > +        // SAFETY: PERCPU is properly defined
> >> >> > +        let mut pcpu: StaticPerCpu<i64> = unsafe { unsafe_get_per_cpu!(PERCPU) };
> >> >> 
> >> >> I don't understand why we need unsafe here, can't we just create
> >> >> something specially in the `define_per_cpu` macro that is then confirmed
> >> >> by the `get_per_cpu!` macro and thus it can be safe?
> >> >
> >> > As is, something like
> >> >     define_per_cpu!(PERCPU: i32 = 0);
> >> >
> >> >     fn func() {
> >> >         let mut pcpu: StaticPerCpu<i64> = unsafe { unsafe_get_per_cpu!(PERCPU) };
> >> >     }
> >> > will compile, but any usage of `pcpu` will be UB. This is because
> >> > `unsafe_get_per_cpu!` is just blindly casting pointers and, as far as I
> >> > know, the compiler does not do any checking of pointer casts. If you
> >> > have thoughts/ideas on how to get around this problem, I'd certainly
> >> > *like* to provide a safe API here :)
> >> 
> >> I haven't taken a look at your implementation, but you do have the type
> >> declared in `define_per_cpu!`, so it's a bit of a mystery to me why you
> >> can't get that out in `unsafe_get_per_cpu!`...
> >> 
> >> Maybe in a few weeks I'll be able to take a closer look.
> >> 
> >> >> > +        // SAFETY: We only have one PerCpu that points at PERCPU
> >> >> > +        unsafe { pcpu.get(CpuGuard::new()) }.with(|val: &mut i64| {
> >> >> 
> >> >> Hmm I also don't like the unsafe part here...
> >> >> 
> >> >> Can't we use the same API that `thread_local!` in the standard library
> >
> > First of all, `thread_local!` has to be implemented by some sys-specific
> > unsafe mechanism, right? For example on unix, I think it's using
> > pthread_key_t:
> >
> > 	https://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_key_create.html
> >
> > what we are implementing (or wrapping) is the very basic unsafe
> > mechanism for percpu here. Surely we can explore the design for a safe
> > API, but the unsafe mechanism is probably necessary to look into at
> > first.
> 
> But this is intended to be used by drivers, right? If so, then we should

Not necessarily only for drivers, we can also use it for implementing
other safe abstraction (e.g. hazard pointers, percpu counters etc)

> do our usual due diligence and work out a safe abstraction. Only fall
> back to unsafe if it isn't possible.
> 

All I'm saying is instead of figuring out a safe abstraction at first,
we should probably focus on identifying how to implement it and which
part is really unsafe and the safety requirement for that.

> I'm not familiar with percpu, but from the name I assumed that it's
> "just a variable for each cpu" so similar to `thread_local!`, but it's
> bound to the specific cpu instead of the thread.
> 
> That in my mind should be rather easy to support in Rust at least with
> the thread_local-style API. You just need to ensure that no reference
> can escape the cpu, so we can make it `!Send` & `!Sync` + rely on klint

Not really, in kernel, we have plenty of use cases that we read the
other CPU's percpu variables. For example, each CPU keeps it's own
counter and we sum them other in another CPU.

If we would like to model it conceptually, it's more like an array
that's index by CpuId to me.

> to detect context switches.
> 
> >> >> has:
> >> >> 
> >> >>     https://doc.rust-lang.org/std/macro.thread_local.html
> >> >> 
> >> >> So in this example you would store a `Cell<i64>` instead.
> >> >> 
> >> >> I'm not familiar with per CPU variables, but if you're usually storing
> >> >> `Copy` types, then this is much better wrt not having unsafe code
> >> >> everywhere.
> >> >> 
> >> >> If one also often stores `!Copy` types, then we might be able to get
> >> >> away with `RefCell`, but that's a small runtime overhead -- which is
> >> >> probably bad given that per cpu variables are most likely used for
> >> >> performance reasons? In that case the user might just need to store
> >> >> `UnsafeCell` and use unsafe regardless. (or we invent something
> >
> > This sounds reasonable to me.
> >
> >> >> specifically for that case, eg tokens that are statically known to be
> >> >> unique etc)
> >> >
> >> > I'm open to including a specialization for `T: Copy` in a similar vein
> >> > to what I have here for numeric types. Off the top of my head, that
> >> > shouldn't require any user-facing `unsafe`. But yes, I believe there is
> >> > a significant amount of interest in having `!Copy` per-CPU variables.
> >> > (At least, I'm interested in having them around for experimenting with
> >> > using Rust for HV drivers.)
> >> 
> >> What kinds of types would you like to store? Allocations? Just integers
> >> in bigger structs? Mutexes?
> >> 
> >
> > In the VMBus driver, there is a percpu work_struct.
> 
> Do you have a link? Or better yet a Rust struct description of what you
> think it will look like :)
> 

Not Rust code yet, but here is the corresponding C code:

	https://github.com/Rust-for-Linux/linux/blob/rust-next/drivers/hv/vmbus_drv.c#L1396

But please note that we are not solely developing the abstraction for
this usage, but more for generally understand how to wrap percpu
functionality similar to the usage in C.

> >> > I would definitely like to avoid *requiring* the use of `RefCell` since,
> >> > as you mention, it does have a runtime overhead. Per-CPU variables can
> >> > be used for "logical" reasons rather than just as a performance
> >> > optimization, so there might be some cases where paying the runtime
> >> > overhead is ok. But that's certainly not true in all cases. That said,
> >> > perhaps there could be a safely obtainable token type that only passes a
> >> > `&T` (rather than a `&mut T`) to its closure, and then if a user doesn't
> >> > mind the runtime overhead, they can choose `T` to be a `RefCell`.
> >> > Thoughts?
> >> 
> >> So I think using an API similar to `thread_local!` will allow us to have
> >> multiple other APIs that slot into that. `Cell<T>` for `T: Copy`,
> >> `RefCell<T>` for cases where you don't care about the runtime overhead,
> >> plain `T` for cases where you only need `&T`. For the case where you
> >> need `&mut T`, we could have something like a `TokenCell<T>` that gives
> >> out a token that you need to mutably borrow in order to get `&mut T`.
> >> Finally for anything else that is too restricted by this, users can also
> >> use `UnsafeCell<T>` although that requires `unsafe`.
> >> 
> >> I think the advantage of this is that the common cases are all safe and
> >> very idiomatic. In the current design, you *always* have to use unsafe.
> >> 
> >
> > I agree, but like I said, we need to figure out the unsafe interface
> > that C already uses and build API upon it. I think focusing on the
> > unsafe mechanism may be the way to start: you cannot implement something
> > that cannot be implemented, and we don't have the magic pthread_key here
> > ;-)
> 
> Sure we can do some experimentation, but I don't think we should put
> unsafe abstractions upstream that we intend to replace with a safe
> abstraction later. Otherwise people are going to depend on it and it's

I doubt we can replace the unsafe abstraction with a safe one, if users
really care the performance then they would really need to use some
unsafe API to build their safe abstraction.

> going to be a mess. Do the experimenting out of tree and learn there.

I disagree, Rust as a language its own should be able to do what C does
including being able to implement the percpu functionality same as C,
there is nothing wrong with a set of Rust primitives in the kernel that
provides fundamental percpu functionality the other core facilities can
rely on. The better part is that it will have all the safety requirement
documented well.

Regards,
Boqun

> 
> ---
> Cheers,
> Benno

