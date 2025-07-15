Return-Path: <linux-kernel+bounces-732022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B0B0610E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFEF50785A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69229C32F;
	Tue, 15 Jul 2025 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGhZkNsn"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C5029AB09;
	Tue, 15 Jul 2025 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588662; cv=none; b=SMAS3U/jg5AgfnoL8ok/BqmhRyY4bo+nLWPCQpXt96n4j5fOafx3JrvIxhbv+ua82m/Ipy2dMov/qjERsKmKOS1/Pmb0XxLakgXYLLLnMLoQTZYivn63T8fx2E2//W6YwtytXl2hqPTdyaqskozNbF8Q3vcZesSinl9GfllQqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588662; c=relaxed/simple;
	bh=7K1Qw7usBJEX1YBJoJ+7B/yQ5PXqa58bxpdgZWzDUic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWT1ipWlbiX2WErYsAvuZCIsTtKqsIgCCtFbI4Z8LPJFRGoJ/qGxn3xR8qtY+zwghXTkL1Dgdc3FLoErVmRutcG4YrDx/DNugaHNFTX2sGpUvon9ruzuyerDOhV+Uyvug5FPMyVuyZFuFbTg3gBifMKeFcJdTTFl8ffxrnTOtB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGhZkNsn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fd0a91ae98so35383066d6.1;
        Tue, 15 Jul 2025 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752588660; x=1753193460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNZvbkqhFe7+R5IRsiZs1kxLolypY/wQ9f39IZDObm0=;
        b=ZGhZkNsnXMazpPEOASOwISn4KjM3ZTTieFtrtxlKO9A0W6wzFNz3UKxl6H8MWA6MsW
         aJJLxj9+ktOaQEziWczHGHV/62fO9rbwQZ+45YbX0zCuyNQVXeZ3z/mmTddHMBcS8JaV
         zLFnC24UVq0sy5wQXstmlU+dUZ+t8zJABy5WisB/OI71VM5R51WxXq6kctDrwKtKiBhD
         eB2t9BBWQoKkt7PmmkayMMc4enb4vuKNl4VSUBYNdUN0Jkr5/KcwPVFs8L//txIZ86Qw
         5cxfIVUqDu/RzeK140tYhUqgBVkRg2GdQfjO8ncwD4FMjYc25JqGNTB5JrlOQujJzTJL
         uLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588660; x=1753193460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNZvbkqhFe7+R5IRsiZs1kxLolypY/wQ9f39IZDObm0=;
        b=moIH5CPjcPv4p/9S95rs4wKqv0kSiPuUSSAY4K1sANkt4UJprw+L3yvooX23vAERjO
         CSp5qQZ5HOUY87GUEorBWkDxldLWyCkEwCoOIBrM7z+idyW0UwFTqsB40apEVbe74AYE
         rOi/LeHPmTo4T215uI5TGirGu8zG/jSH8Bdws1i7Crb/2bsAxJfu2/O7+XiGHBi9tgGZ
         za0P+7QiZJq02rtzlvbnGLeZDJezPSR3HCIORgA/590rsEZ0bD7zUgJBN2/ZmjZ242xd
         lrMH1GdllcSCAZ65CX6fawFiglRht1PM0qg4ek5DQj5tIfCv9DL/wKy/R5CP/bYbETq+
         XhFg==
X-Forwarded-Encrypted: i=1; AJvYcCV3agsZ7KEaddn9LaNRO6W7JnXzQRIoNPZYjVzTS1KzL2saVsDvtd9M6pm8kXea92a/+O+WCU5QP4XtUIo=@vger.kernel.org, AJvYcCXCYPdBXVoAnqyMWrHX5ljPDt77ENRinDJjhtRHxipU0RHF8QC9aKWpP4fnW5Z/o4fRIJuA4Bk9+sQOLv1S44o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLvgu43jhxt6ulLQ6VcsyqOwTF7Wr9lsXYg9CoQ/bHH2hMtxek
	kDxUWFpVm7sxtdBaZHCgH98Yw3wPTUsFo0kj2+j47quEruZopK4hAbr1
X-Gm-Gg: ASbGncs0IiFeX8BUmutx/AFX7iHXzvP4MtryqGcn/oNh0kI8rcVljPMDTschd+jyHia
	mJtIw4s1Qlqa+iOCuExSjREjL1seYBO+VKQhKFQtNr48XHR7LzZydUPn4x7jOMxXNOtKLHX/hf2
	G6Db3+JA/9t0ib04bwqmeNnzJD0L0gDBOyf+z+TD4x84G7Y+8rlS+Hth/LT+V4c8h5a/vJ+cNTg
	Kb39C8NDmDAui2mwE8CfGORjKKv54KLXY8HPWbzsjtZYZI/cP1o/bxrtNBLmrpl/xElMCgvjS4o
	aflHL4T1LiAGqy5BVgaUDjsF5cJ7KEM9jpPpnr1LvhCzHxaYSFXq6F6FdHbGpIDaiwErpqILEAG
	PGekKOhXbg6LnaIbSvio72jX5CRKRDI5a57dYc3eVsfOsR9lIhccLMXFtNJBNm0+G5IxFLKmVLP
	RonUHGMc241m12HSmB0W38be8=
X-Google-Smtp-Source: AGHT+IHlB/d7fN0BeQNV/gjZ1+bEF0VFfNvi38+Xuu5rHwPY0OQeFD83BZPuL5j7LqQXziSyrHsi5A==
X-Received: by 2002:a05:6214:dab:b0:6fa:c6ad:1618 with SMTP id 6a1803df08f44-704a429299cmr314498946d6.27.1752588659495;
        Tue, 15 Jul 2025 07:10:59 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d5bb30sm58184806d6.81.2025.07.15.07.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:10:58 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4B2E8F40068;
	Tue, 15 Jul 2025 10:10:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 15 Jul 2025 10:10:58 -0400
X-ME-Sender: <xms:cmF2aBEcs7ibraSkUQG4FyDpJC6H-WGZNeENbo52zVricw5fgpbgVA>
    <xme:cmF2aH3VB_C360Rt84znQ3UwTzH-5SFJtLMmod9ZtCT-G75ll47hFz_N-ql8GrC1J
    tg0MbB8eXnbM7TbNA>
X-ME-Received: <xmr:cmF2aAwNBpUmsZd2RZH_DCv7_2A3xXdEXKRePPUanxJ0LjY9Wc_WGV7DFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehhedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedtfeeiveeiffehtddtuedtjedufeehheekiedtvddtgeefffdvtdeigfevgeeg
    necuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgpdhruhhsthdqlhgrnhhgrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghvhihm
    ihhttghhvghllhdtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjh
    horhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhn
    uggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:cmF2aOgIHF_r6UFwNHak36oG6FXf_CL3DBSK5hQ3G7C29aPdgUUQzg>
    <xmx:cmF2aHzW-LGTPVra5tC4AezFx8CAagZqoH0E3v18GNt46In0PMlluA>
    <xmx:cmF2aEzaleT1Pahmps1VDIeqgjbUDDD9r0cWcm6N7gZO33uVWDDXLg>
    <xmx:cmF2aJrRGH5mI3kJcJga2rhxQ0t1N-2X4LQg5_-VGkanpwkO_AqFNw>
    <xmx:cmF2aPlZkF4NikrkOKJ_vprEqPibx-86HgXoKMh8SINmNMKWEz2Dcvy1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 10:10:57 -0400 (EDT)
Date: Tue, 15 Jul 2025 07:10:56 -0700
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
Message-ID: <aHZhcNCayTOQhvYh@Mac.home>
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
 <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
 <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org>

On Tue, Jul 15, 2025 at 01:31:06PM +0200, Benno Lossin wrote:
[...]
> >> > +impl kernel::Module for PerCpuTestModule {
> >> > +    fn init(_module: &'static ThisModule) -> Result<Self, Error> {
> >> > +        pr_info!("rust percpu test start\n");
> >> > +
> >> > +        let mut native: i64 = 0;
> >> > +        // SAFETY: PERCPU is properly defined
> >> > +        let mut pcpu: StaticPerCpu<i64> = unsafe { unsafe_get_per_cpu!(PERCPU) };
> >> 
> >> I don't understand why we need unsafe here, can't we just create
> >> something specially in the `define_per_cpu` macro that is then confirmed
> >> by the `get_per_cpu!` macro and thus it can be safe?
> >
> > As is, something like
> >     define_per_cpu!(PERCPU: i32 = 0);
> >
> >     fn func() {
> >         let mut pcpu: StaticPerCpu<i64> = unsafe { unsafe_get_per_cpu!(PERCPU) };
> >     }
> > will compile, but any usage of `pcpu` will be UB. This is because
> > `unsafe_get_per_cpu!` is just blindly casting pointers and, as far as I
> > know, the compiler does not do any checking of pointer casts. If you
> > have thoughts/ideas on how to get around this problem, I'd certainly
> > *like* to provide a safe API here :)
> 
> I haven't taken a look at your implementation, but you do have the type
> declared in `define_per_cpu!`, so it's a bit of a mystery to me why you
> can't get that out in `unsafe_get_per_cpu!`...
> 
> Maybe in a few weeks I'll be able to take a closer look.
> 
> >> > +        // SAFETY: We only have one PerCpu that points at PERCPU
> >> > +        unsafe { pcpu.get(CpuGuard::new()) }.with(|val: &mut i64| {
> >> 
> >> Hmm I also don't like the unsafe part here...
> >> 
> >> Can't we use the same API that `thread_local!` in the standard library

First of all, `thread_local!` has to be implemented by some sys-specific
unsafe mechanism, right? For example on unix, I think it's using
pthread_key_t:

	https://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_key_create.html

what we are implementing (or wrapping) is the very basic unsafe
mechanism for percpu here. Surely we can explore the design for a safe
API, but the unsafe mechanism is probably necessary to look into at
first.

> >> has:
> >> 
> >>     https://doc.rust-lang.org/std/macro.thread_local.html
> >> 
> >> So in this example you would store a `Cell<i64>` instead.
> >> 
> >> I'm not familiar with per CPU variables, but if you're usually storing
> >> `Copy` types, then this is much better wrt not having unsafe code
> >> everywhere.
> >> 
> >> If one also often stores `!Copy` types, then we might be able to get
> >> away with `RefCell`, but that's a small runtime overhead -- which is
> >> probably bad given that per cpu variables are most likely used for
> >> performance reasons? In that case the user might just need to store
> >> `UnsafeCell` and use unsafe regardless. (or we invent something

This sounds reasonable to me.

> >> specifically for that case, eg tokens that are statically known to be
> >> unique etc)
> >
> > I'm open to including a specialization for `T: Copy` in a similar vein
> > to what I have here for numeric types. Off the top of my head, that
> > shouldn't require any user-facing `unsafe`. But yes, I believe there is
> > a significant amount of interest in having `!Copy` per-CPU variables.
> > (At least, I'm interested in having them around for experimenting with
> > using Rust for HV drivers.)
> 
> What kinds of types would you like to store? Allocations? Just integers
> in bigger structs? Mutexes?
> 

In the VMBus driver, there is a percpu work_struct.

> > I would definitely like to avoid *requiring* the use of `RefCell` since,
> > as you mention, it does have a runtime overhead. Per-CPU variables can
> > be used for "logical" reasons rather than just as a performance
> > optimization, so there might be some cases where paying the runtime
> > overhead is ok. But that's certainly not true in all cases. That said,
> > perhaps there could be a safely obtainable token type that only passes a
> > `&T` (rather than a `&mut T`) to its closure, and then if a user doesn't
> > mind the runtime overhead, they can choose `T` to be a `RefCell`.
> > Thoughts?
> 
> So I think using an API similar to `thread_local!` will allow us to have
> multiple other APIs that slot into that. `Cell<T>` for `T: Copy`,
> `RefCell<T>` for cases where you don't care about the runtime overhead,
> plain `T` for cases where you only need `&T`. For the case where you
> need `&mut T`, we could have something like a `TokenCell<T>` that gives
> out a token that you need to mutably borrow in order to get `&mut T`.
> Finally for anything else that is too restricted by this, users can also
> use `UnsafeCell<T>` although that requires `unsafe`.
> 
> I think the advantage of this is that the common cases are all safe and
> very idiomatic. In the current design, you *always* have to use unsafe.
> 

I agree, but like I said, we need to figure out the unsafe interface
that C already uses and build API upon it. I think focusing on the
unsafe mechanism may be the way to start: you cannot implement something
that cannot be implemented, and we don't have the magic pthread_key here
;-)

Regards,
Boqun

> > For `UnsafeCell`, if a user of the API were to have something like a
> > `PerCpu<UnsafeCell<T>>` that safely spits out a `&UnsafeCell<T>`, my
> > understanding is that mutating the underlying `T` would require the
> > exact same safety guarantees as what's here, except now it'd need a much
> > bigger unsafe block and would have to do all of its manipulations via
> > pointers. That seems like a pretty big ergonomics burden without a clear
> > (to me) benefit.
> 
> It would require the same amount of unsafe & safety comments, but it
> wouldn't be bigger comments, since you can just as well create `&mut T`
> to the value.
> 
> ---
> Cheers,
> Benno

