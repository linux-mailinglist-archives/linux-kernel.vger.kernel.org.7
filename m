Return-Path: <linux-kernel+bounces-733862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC49DB079F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC533A5DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E0221C19E;
	Wed, 16 Jul 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOjU5BiO"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9260249E5;
	Wed, 16 Jul 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680029; cv=none; b=VHmAZuLJqPAMD2L4iwrwZUkSdIHzwSuNaYbQOaCD2dB3wJ0qOv0DaX46xopLDQQRj6E0JTKVfGXrk7mxGZ8HYG42fYmSQ5G2QNg5XTGgJNY6Pn4rIihC+Qh5rQRR2wfwoIh/F9SETtePk+dryV/dhH2RbpO61v8IO9+73k+SSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680029; c=relaxed/simple;
	bh=dSUXBHlBb/oWnFxdydJ5t7D52qJvDSWnVooiknopvAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phXJAIwUrqsTsCRC4OpIK1vBYa08oOKfTGRwOX7nlcIdTkwTmxg884Hd4T/0SQApTI0wzCPyn8XUiIqGtX2CrQHE4mcSo2kImoqvi1rLMDTZtdcPwO3Kd9UAAzmvblJtogd+Ab3/GvEkrijU1f8GB1AQ1aLlNelbPygZouGGNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOjU5BiO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e29616cc4fso352083585a.0;
        Wed, 16 Jul 2025 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752680026; x=1753284826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHnbFfh1u32VDfmzatgR36A7Ry3U/16eay9Mf7feuDE=;
        b=EOjU5BiOCMhWjZtOy4qRDJsuS+Idr5HVTVCTOAIlHshl+ZYQN8GzvCyyduTHiJxsh2
         42ZZ3epze81ZgduU+RyUk/68arm8CJyYUoach19okswZBltqa9rALaZYL/FFHPJOtz/h
         GtaGZIkSZhHE7gu1uOFf7abYaHWV/hRO4H/V0U3e5RzdF8ZN+s9+v4yaqQd0wRb+51H+
         33o/BNRfyVspNUROZqqwy0egWzlDXt8IsqCsRnUBh2Vjrcf5sxGu+TfOIrVbQxsaEwSk
         RWwLavbiOsNbNMHMwUa+OqPujeXp2qvhp9CpPbuhG20rkO9raOaAcjLjLStYmqSnDPKo
         6jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680026; x=1753284826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHnbFfh1u32VDfmzatgR36A7Ry3U/16eay9Mf7feuDE=;
        b=VhIMJP+yrIhc9WV4qSpvqIKQAs7kwOcoyJfiDiAZn98g65RWMbb8CBuXQlBqGuiqXC
         JF8VPphgys3F9hIPVzHmFpcDJN6SCW6sz2BpXWUbWDctwyKn/R2TwbnUQnkQ7AbThUlc
         S3rSRH9cBsOPDHq2Z85nVTiABChulH0L7V22C572LFwJxJPlLs8HF6bBXbUyK3S6iA4g
         sbtD1Y8tgZZ0sooh5Q3xo1P6Cnuc0NqOj/TcXs/WgWf5VtddlWaEHmTRAK3DGyXLygfJ
         jOnVqZvho8Rt3iqDjKMSSjMFAwxI8y+h+LZj0lWx3BQPOdR6vRJvEyzO/2soYWFzwJB/
         tR6w==
X-Forwarded-Encrypted: i=1; AJvYcCW1f0WbAkt0BpamcgebmuWch8C05Ps+hfhCdkES4P02HNGJW6AqSx1TG1hofTWD6IjeXxNbFGB+XKjxNsX1//c=@vger.kernel.org, AJvYcCXf9Xkb39aWWOqQrBwYt0XLJ8UP0EpEpcSCFK/h82lw8T3HWqzg4Epu+Nw++bbSeHtM7sT8Q5AiJlBK1pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfcsmej/1oCmbUqm53FHyWAKWNuOMl0W7/Jd44PIM0nRl+t0R
	zVZLJaRAH5JJGAnVOS76iiS5UBMOyv/0GldSongAgq9H2GkkAv6Ds3qv4qq3ZA==
X-Gm-Gg: ASbGncte3iMIeQ/TXzExUOItYxFG7KxVvRDlbPaQisoPSXe8WzeIwOHZd8EkqjJw8xw
	viuOEQPqgYujHWDVpTA9uc7wB/1ykuDhhuh1TkQXi50Fq560w0rDlAFzQADNvZtVmd2bGOYxdIN
	ED/0Nck/pSSPB46T+tf26g3k/Q4qDNZ80x3nKDnCgYHND+UeE99pMLqE2+YV6RnZCsUGFLXjTOx
	kZ4MsefUKe8/Irkzrcg7n7SzvSp7PND6oLoDn9Dn73DXZ6FaZAnQZeWXPyT0W/EARcPoec8gTcF
	LZJzYhTNky+fmFciMt4Jv6h+ZAO4NZW0AHxKFD2tByXEVBn165KYOJxz4pKkHNvPGkbP33PNTbz
	zXpY4ZrUdvdQR8d+gxEsCWgN72n4eW4IUisA7i7O4gz1TGHC3OEavexI3KiKIrg1AqQKaHcyduo
	y5VVjn8ja4pWH6
X-Google-Smtp-Source: AGHT+IHLL9KhRPo7ww1I8MiIJ3kjrjsG2TfTOMqhCWadQ5DtVvg9UMNuGxcaBW6P62o7IIztNVMbCw==
X-Received: by 2002:a05:620a:268c:b0:7df:f84c:7dae with SMTP id af79cd13be357-7e342b6aef3mr377149385a.38.1752680026069;
        Wed, 16 Jul 2025 08:33:46 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e2e29468d8sm374600285a.108.2025.07.16.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:33:45 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0267CF40066;
	Wed, 16 Jul 2025 11:33:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 16 Jul 2025 11:33:45 -0400
X-ME-Sender: <xms:WMZ3aPKvAI7UUkoNehw38GqTrjMaSK1-db5tcF2Xijv_ZLU4JkS_SA>
    <xme:WMZ3aEryV-a2vOumiA7obUUGl8D9LpLsYPIr6X-h1lKa1kg_EVj6wpDOM6ikBTvTN
    dzzUmg8J5_CAmXXBw>
X-ME-Received: <xmr:WMZ3aFV-_sFJEKKP_aI8zftn0PuNcGHEdrXJ0WWjwF2BM0ODchEfLusSdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfegtdefveeljeeuueeltdevleehfeeludegteekhfehveeuleegkeelkedtjedt
    necuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgpdgsohhothhlihhnrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghvhihmihht
    tghhvghllhdtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorh
    hnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggs
    ohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:WMZ3aP3a93ftRqO_dkfvZ3OjcvGfw81mBQBpbtx1Bwmof7B9dJP3jA>
    <xmx:WMZ3aG0nrKfvygp0Q5RnexciafGF0LzAqVNbbIbUdczkWkOqjSq9dw>
    <xmx:WMZ3aOnW0zg234awIwBYumejWjtFnio9YUMIOBd4S52ivlFk3syelQ>
    <xmx:WMZ3aHNuLhQp-TR4GtjvWaEnbBIu8FX7liZi4CAQ2QXxe6cxjipETg>
    <xmx:WMZ3aF4Yu3Z5T6SDn8mQIzSmW_xqtXWS_UmAmCxeu0HphByOPdpJYYTb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:33:44 -0400 (EDT)
Date: Wed, 16 Jul 2025 08:33:43 -0700
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
Message-ID: <aHfGV3l4NCmYSRuv@Mac.home>
References: <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
 <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org>
 <aHZhcNCayTOQhvYh@Mac.home>
 <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org>
 <aHaCUFNUd_mErL7S@Mac.home>
 <DBCTCZ5HUZOF.2DJX63Q0VWWFN@kernel.org>
 <aHbJUfcsjHA92OlE@tardis-2.local>
 <DBDESSQOH6MB.2I4GNLPBP5ORJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBDESSQOH6MB.2I4GNLPBP5ORJ@kernel.org>

On Wed, Jul 16, 2025 at 12:32:04PM +0200, Benno Lossin wrote:
> On Tue Jul 15, 2025 at 11:34 PM CEST, Boqun Feng wrote:
> > On Tue, Jul 15, 2025 at 07:44:01PM +0200, Benno Lossin wrote:
> > [...]
> >> >> >
> >> >> > First of all, `thread_local!` has to be implemented by some sys-specific
> >> >> > unsafe mechanism, right? For example on unix, I think it's using
> >> >> > pthread_key_t:
> >> >> >
> >> >> > 	https://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_key_create.html
> >> >> >
> >> >> > what we are implementing (or wrapping) is the very basic unsafe
> >> >> > mechanism for percpu here. Surely we can explore the design for a safe
> >> >> > API, but the unsafe mechanism is probably necessary to look into at
> >> >> > first.
> >> >> 
> >> >> But this is intended to be used by drivers, right? If so, then we should
> >> >
> >> > Not necessarily only for drivers, we can also use it for implementing
> >> > other safe abstraction (e.g. hazard pointers, percpu counters etc)
> >> 
> >> That's fair, but then it should be `pub(crate)`.
> >> 
> >
> > Fine by me, but please see below.
> >
> >> >> do our usual due diligence and work out a safe abstraction. Only fall
> >> >> back to unsafe if it isn't possible.
> >> >> 
> >> >
> >> > All I'm saying is instead of figuring out a safe abstraction at first,
> >> > we should probably focus on identifying how to implement it and which
> >> > part is really unsafe and the safety requirement for that.
> >> 
> >> Yeah. But then we should do that before merging :)
> >> 
> >
> > Well, who's talknig about merging? ;-) I thought we just began reviewing
> > here ;-)
> 
> I understand [PATCH] emails as "I want to merge this" and [RFC PATCH] as

But it doesn't mean "merge as it is", right? I don't think either I or
Mitchell implied that, I'm surprised that you had to mention that, also
based on "I often mute those" below, making it "[PATCH]" seems to be a
practical way to get more attention if one wants to get some reviews.

> "I want to talk about merging this". It might be that I haven't seen the
> RFC patch series, because I often mute those.
> 

Well, then you cannot blame people to move from "RFC PATCH" to "PATCH"
stage for more reviews, right? And you cannot make rules about what the
difference between [PATCH] and [RFC PATCH] if you ignore one of them ;-)

> >> >> I'm not familiar with percpu, but from the name I assumed that it's
> >> >> "just a variable for each cpu" so similar to `thread_local!`, but it's
> >> >> bound to the specific cpu instead of the thread.
> >> >> 
> >> >> That in my mind should be rather easy to support in Rust at least with
> >> >> the thread_local-style API. You just need to ensure that no reference
> >> >> can escape the cpu, so we can make it `!Send` & `!Sync` + rely on klint
> >> >
> >> > Not really, in kernel, we have plenty of use cases that we read the
> >> > other CPU's percpu variables. For example, each CPU keeps it's own
> >> > counter and we sum them other in another CPU.
> >> 
> >> But then you need some sort of synchronization?
> >> 
> >
> > Right, but the synchronization can exist either in the percpu operations
> > themselves or outside the percpu operations. Some cases, the data types
> > are small enough to fit in atomic data types, and operations are just
> > load/store/cmpxchg etc, then operations on the current cpu and remote
> > read will be naturally synchronized. Sometimes extra synchronization is
> > needed.
> 
> Sure, so we probably want direct atomics support. What about "extra
> synchronization"? Is that using locks or RCU or what else?
> 

It's up to the users obviously, It could be some sort of locking or RCU,
it's case by case.

> > Keyword find all these cases are `per_cpu_ptr()`:
> >
> > 	https://elixir.bootlin.com/linux/v6.15.6/A/ident/per_cpu_ptr
> 
> Could you explain to me how to find them? I can either click on one of
> the files with horrible C preprocessor macros or the auto-completion in
> the search bar. But that one only shows 3 suggestions `_hyp_sym`,
> `_nvhe_sym` and `_to_phys` which doesn't really mean much to me.
> 

You need to find the usage of `per_cpu_ptr()`, which is a function that
gives you a pointer to a percpu variable on the other CPU, and then
that's usually the case where a "remote" read of percpu variable
happens.

Regards,
Boqun

> ---
> Cheers,
> Benno

