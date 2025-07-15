Return-Path: <linux-kernel+bounces-732557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353DB0689C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14B74E2214
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155DA2C1592;
	Tue, 15 Jul 2025 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko6TwIqQ"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA61C4A24;
	Tue, 15 Jul 2025 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615255; cv=none; b=k8kMGVs0Z4CaiEeC09bYcaUOVJZrJUsxV1kQqxn3aZInU4+JxRVOMQiQz2g0M0RN7hWa/SPrp7iFM33auseV/ou/Lks2FthkyjIpDOrhiRhqdzckBLYWAVvlzu+emMBqan/O3eeHiRAYI+XS0ORh2ubMzn8xekrQ2fBeLSSECT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615255; c=relaxed/simple;
	bh=hmXUYBeUQghRJdWc0R8kOHOgRYR9D6qDDCSe9h0qh/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGtCwE5O9/vuKmVEodIbly70XsveAHbvP9MW8OPLSspelcCi/XxIoM1nGhh3bnjLD/xsjlRW02epHMTC6qCM7/baN026U3D0iora7MdzgiH8mRUy97RUIzHTOFYHmfIyoWD9wPaZrYWvsx0f/BwozZnsFwJY+UyOi1XllptJu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko6TwIqQ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d5d1feca18so615166485a.2;
        Tue, 15 Jul 2025 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752615252; x=1753220052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uF1fdpy8mFKFOKUM4AMZPjAjVNIzorDz52lRWvMF5DY=;
        b=ko6TwIqQV/UDj4gP+2l22DSF4HEokG5rzxqCkDMOGRzf6qc8ar5SvIunotbXEz0+oz
         1J1KV+pyIBBmBtIq3vFztjXclRoV1ONBGA1bTRQGQJmhbAWOzepQ3lbff4KwToo8c/nB
         6agIrSkTEygqm899s8eeeFiTCuhth3qeQQy/JFNuLWjP7dct/wmI6MmgK5qURALm8r3C
         xHZBlVlPrijqxnYL6nDLXyF2sTxAzbMlIBG51kPF6RCrZmpJ7H/7Rq4ouSKerZzt+2Fc
         wveuOCDAxP4LEZLy02yRobm6LsW3JUylwWwETY2c0lkwfX+raD/HQWc/K9K2FTSuiUsi
         Q3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752615252; x=1753220052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uF1fdpy8mFKFOKUM4AMZPjAjVNIzorDz52lRWvMF5DY=;
        b=P8abDNE8F+0DA37u47zimrsPtuc9ml2xa0u+1IUwNbi5Ufg0gKMbCPJLBtw//NEd0d
         vICW/ZXrDpqUr2Z6hEWpX4XQeISkFxpctzcmikaqDX/YiE/52rlLCh0kNXR599n3ey6X
         fLXjBUqTxEp4KrB8TBwgAQZm2FkFbL7TkBG+h8BnB9+Fxe1EnSPw1VP5KoHJZwP+I385
         3eC17YaH/pfZaq2c7Pjmh5A2fHAL5lF3vmdD3WIit2Le0kUn2rlEQytRVAcl3Rncv46o
         GTKk8wUXlGtnmHgeribacaZkro4ptTKwRI8uHutpTUfOgzUERYkkQxZRse2SahSbbr2m
         fmSA==
X-Forwarded-Encrypted: i=1; AJvYcCWOVJsk+JP68IMFgS8HvuYsJUIXKeMfJ88p2ZVuPaljg+0m7PBJKyiGu+BmEzeU+Ipb6eH7/lzh7IylICU=@vger.kernel.org, AJvYcCXwsOT2qAGrZQAxiaD5KXjm75RqpFLn2/sPlCcABdG021R8ji/EGU1/opiVE6p5Afv7nlB4/6q4ISrTGFSVQGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvXm5CRsCMBdZFK2x80Lh2wTBBcjS+XU08tOYpTsEToe7VQVtp
	wKX9p2cFGA7SYanatXGHVbdAYJJhBwgnnxN7BGfvaBAP24o3N3uNaYKx
X-Gm-Gg: ASbGncseIC6y1djMSLuajGQinwQg8njuwZp3QdtOngaQmVzfkvK21DSlncG4Yh0HgUG
	u3QnNpvOHYIKPeUteAeamfLkyhuPmk1OTEpqw6YfpmLYs7OdoOHaD13FbmKu8FM9ZBWYLk3dc9r
	v/mqzkpN2fzSMmwQ88baSlT1PhCUIStmY//8ogFYK5slfSfD9Al7QKkCyFlyjFCwKnYWyOdY3W9
	fLA5L3dYTyzx0R6Sl4tFgcqhpgtZQls7HUfDH+4zTUvygwgWFTXK3yuBLKRHSDPfgFiCPaLoOjw
	2BgGT8pBCE8oe/+XsNAc6/t4Prw+tf9y1NS45FjUwZGZcq7sirwL29hTL4/USY9aW39imo/nedE
	MxKfqR4CSRstlv/RPyqoEsCKJZEbppaizmruQf0md5sSS2ewr3srDjTLDI2g3mu7PgeZL3Dnuws
	ir24MpawThPGSX
X-Google-Smtp-Source: AGHT+IHyYZXhhEuifJ0c3cYQNpKDwiC8JPDhu4ErrCxN1+8gG6b28IWoO1mhbKzSZxg7zJiuQs+61g==
X-Received: by 2002:a05:620a:3916:b0:7db:52b9:2060 with SMTP id af79cd13be357-7e3435eb952mr83379185a.36.1752615252221;
        Tue, 15 Jul 2025 14:34:12 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e26996873esm306092985a.64.2025.07.15.14.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 14:34:11 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2F942F40066;
	Tue, 15 Jul 2025 17:34:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 15 Jul 2025 17:34:11 -0400
X-ME-Sender: <xms:U8l2aNgdMx9-bBmwSN724EqWKzHEqvS7o2W5hvHVhmJl98oa8fUv_A>
    <xme:U8l2aDhhlcvZxvtUwH8VCmtIBmdvGpfI59YraY-VvMv0hlfAIz5NdkNgbwHUhfb3K
    hYkiBR6e9yKUaHnPw>
X-ME-Received: <xmr:U8l2aKuNODYtUOCUD0_LUA1I7LOPJ_-zmP9e8euGIOzWhXQCiHIaXRkXp8nz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepffekudfhlefhvdetudehtedvkeffgfeuffehtdfhueefgfeileeghfetkedvlefh
    necuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgpdgsohhothhlihhnrdgtohhmpd
    hruhhsthdqlhgrnhhgrdhorhhgpdhgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghvhihmih
    httghhvghllhdtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhho
    rhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnug
    gsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:U8l2aJumv9VUQZcLkDS_J9MNGOjWNktbQYQSaKr_mW3s5pyWsL6NZw>
    <xmx:U8l2aLPNVdBDGrfa4dT90XclIhDrd1lPDI78Pxy4JHR1gyEWIJLJ6A>
    <xmx:U8l2aLeG-vBOIwpVkoFB8G4sxGDRtJYSAP-7wYhoMh4Qa-6cVjqSgg>
    <xmx:U8l2aCldgvR2N-9sWaXNgAs2KnvH_zJ9NL7p35VjFmaChJGHQv2fWw>
    <xmx:U8l2aNw_t0ZQezuVUZ5L0wiUuM4nakVEqDmxX0khRIXAlrZ77rRgPEQI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 17:34:10 -0400 (EDT)
Date: Tue, 15 Jul 2025 14:34:09 -0700
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
Message-ID: <aHbJUfcsjHA92OlE@tardis-2.local>
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
 <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
 <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org>
 <aHZhcNCayTOQhvYh@Mac.home>
 <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org>
 <aHaCUFNUd_mErL7S@Mac.home>
 <DBCTCZ5HUZOF.2DJX63Q0VWWFN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBCTCZ5HUZOF.2DJX63Q0VWWFN@kernel.org>

On Tue, Jul 15, 2025 at 07:44:01PM +0200, Benno Lossin wrote:
[...]
> >> >
> >> > First of all, `thread_local!` has to be implemented by some sys-specific
> >> > unsafe mechanism, right? For example on unix, I think it's using
> >> > pthread_key_t:
> >> >
> >> > 	https://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_key_create.html
> >> >
> >> > what we are implementing (or wrapping) is the very basic unsafe
> >> > mechanism for percpu here. Surely we can explore the design for a safe
> >> > API, but the unsafe mechanism is probably necessary to look into at
> >> > first.
> >> 
> >> But this is intended to be used by drivers, right? If so, then we should
> >
> > Not necessarily only for drivers, we can also use it for implementing
> > other safe abstraction (e.g. hazard pointers, percpu counters etc)
> 
> That's fair, but then it should be `pub(crate)`.
> 

Fine by me, but please see below.

> >> do our usual due diligence and work out a safe abstraction. Only fall
> >> back to unsafe if it isn't possible.
> >> 
> >
> > All I'm saying is instead of figuring out a safe abstraction at first,
> > we should probably focus on identifying how to implement it and which
> > part is really unsafe and the safety requirement for that.
> 
> Yeah. But then we should do that before merging :)
> 

Well, who's talknig about merging? ;-) I thought we just began reviewing
here ;-)

> >> I'm not familiar with percpu, but from the name I assumed that it's
> >> "just a variable for each cpu" so similar to `thread_local!`, but it's
> >> bound to the specific cpu instead of the thread.
> >> 
> >> That in my mind should be rather easy to support in Rust at least with
> >> the thread_local-style API. You just need to ensure that no reference
> >> can escape the cpu, so we can make it `!Send` & `!Sync` + rely on klint
> >
> > Not really, in kernel, we have plenty of use cases that we read the
> > other CPU's percpu variables. For example, each CPU keeps it's own
> > counter and we sum them other in another CPU.
> 
> But then you need some sort of synchronization?
> 

Right, but the synchronization can exist either in the percpu operations
themselves or outside the percpu operations. Some cases, the data types
are small enough to fit in atomic data types, and operations are just
load/store/cmpxchg etc, then operations on the current cpu and remote
read will be naturally synchronized. Sometimes extra synchronization is
needed.

Keyword find all these cases are `per_cpu_ptr()`:

	https://elixir.bootlin.com/linux/v6.15.6/A/ident/per_cpu_ptr

> > If we would like to model it conceptually, it's more like an array
> > that's index by CpuId to me.
> 
> Gotcha, but this model is missing the access control/synchronization. So
> I'm not so sure how useful it is.
> 
> (I think I asked this somewhere else, but the number of CPUs doesn't
> change, right?)
> 

In terms of percpu variable, yes. A percpu variable is even available
for an offline CPU.

> >> to detect context switches.
> >> 
> >> >> >> has:
> >> >> >> 
> >> >> >>     https://doc.rust-lang.org/std/macro.thread_local.html
> >> >> >> 
> >> >> >> So in this example you would store a `Cell<i64>` instead.
> >> >> >> 
> >> >> >> I'm not familiar with per CPU variables, but if you're usually storing
> >> >> >> `Copy` types, then this is much better wrt not having unsafe code
> >> >> >> everywhere.
> >> >> >> 
> >> >> >> If one also often stores `!Copy` types, then we might be able to get
> >> >> >> away with `RefCell`, but that's a small runtime overhead -- which is
> >> >> >> probably bad given that per cpu variables are most likely used for
> >> >> >> performance reasons? In that case the user might just need to store
> >> >> >> `UnsafeCell` and use unsafe regardless. (or we invent something
> >> >
> >> > This sounds reasonable to me.
> >> >
> >> >> >> specifically for that case, eg tokens that are statically known to be
> >> >> >> unique etc)
> >> >> >
> >> >> > I'm open to including a specialization for `T: Copy` in a similar vein
> >> >> > to what I have here for numeric types. Off the top of my head, that
> >> >> > shouldn't require any user-facing `unsafe`. But yes, I believe there is
> >> >> > a significant amount of interest in having `!Copy` per-CPU variables.
> >> >> > (At least, I'm interested in having them around for experimenting with
> >> >> > using Rust for HV drivers.)
> >> >> 
> >> >> What kinds of types would you like to store? Allocations? Just integers
> >> >> in bigger structs? Mutexes?
> >> >> 
> >> >
> >> > In the VMBus driver, there is a percpu work_struct.
> >> 
> >> Do you have a link? Or better yet a Rust struct description of what you
> >> think it will look like :)
> >> 
> >
> > Not Rust code yet, but here is the corresponding C code:
> >
> > 	https://github.com/Rust-for-Linux/linux/blob/rust-next/drivers/hv/vmbus_drv.c#L1396
> 
> Thanks!
> 
> > But please note that we are not solely developing the abstraction for
> > this usage, but more for generally understand how to wrap percpu
> > functionality similar to the usage in C.
> 
> Well, I have to start somewhere for looking at the use-cases :)
> 
> If you have more, just let me see. (probably won't have enough time to
> look at them now, but maybe in a couple weeks)
> 

If you have time, feel free to take a look at hazard pointers;

https://lore.kernel.org/lkml/20240917143402.930114-1-boqun.feng@gmail.com/
https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/

You can also take a look at existing usage of percpu, e.g. SRCU uses to
track how many readers are active:

	https://elixir.bootlin.com/linux/v6.15.6/source/kernel/rcu/srcutree.c#L577

[...]

Regards,
Boqun

