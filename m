Return-Path: <linux-kernel+bounces-834372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250C4BA48FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2A43860F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8823B628;
	Fri, 26 Sep 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpT6sfMG"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F22036E9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903050; cv=none; b=ogA3hFtvQxBncfmneWh/O2Q+svXliX8luWnCPO5upaf1QmA+xbD0f4jApm9glJLI8sdU5NoGmW7R06w/ctCVUF1CrhGH+SKOZscIWO7cc2WuUq/BoMw0/B9Y9W8YNUgRL8W1MvlYU6E4I3u+TaCNqovdxF7d2YmlDfvCiRc4Rgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903050; c=relaxed/simple;
	bh=V7kexhXSChwKrummz/CzaqELcFXuUj4bgGCNqOOCO1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaJkk0v5NDgpxjxYYw/EeCk++MUXLQFlHT5dWm3O+a/x05rTLoX0HKU3I/zv6psR/XY9HPzlzMgXw5sLV2zAQTtdXWrU4kPF+FfnOsIcAtNFyrcxDAaYsZyv6XwfuG0ySC/v5c/bVMFtt+T2DnX576S0xLyx2+iEi/WznFIRNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpT6sfMG; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7f7835f4478so15014246d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903047; x=1759507847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iS2jH8joxnDE0/hOPwBCvRREi5onrG6qq8QmOEtOYZk=;
        b=LpT6sfMGymqEEZDXmKxEyTzdCAWAAdGOHrNyRjf22CNV6pfCaAB/BfV1IAQ9c9y9Lq
         CgoOikgUWYYnfnh7WO6DzQhrwtE3grKQvinxG4t0Z/bN7tRl/FTLcUYFrXM8xprf9Xe7
         iYuoqG9OoqHPp/mVUKCZpqzst596DZt8oTJLoDD9qN9qjuzj246h4NEgzi92iGco46s8
         xdksy+gFbeo1sLt0UcnZ+PCunKR2Fo5cdVBBH8z6CCbtu8N21fXCDcIu8j/e1stoLeB8
         9sdRcyfyTiWa5rLPZ/GeSAtF2kxYatnuOtTcWBIg6kwMW3IRfJv0miZlrnSN5tgRceYu
         kF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903047; x=1759507847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iS2jH8joxnDE0/hOPwBCvRREi5onrG6qq8QmOEtOYZk=;
        b=mJWC8RkcUiX1mGuL47wmZ9fAO77CfYfHoovc5vwy1+ZCegqNyFLSMC8+T3ZsmdLtIJ
         kvH3xfxvU0KrVmVVpRLimqotg4cd8bus7+KeeosNiUJ1+PL7V8oUcDLR6EF2pvw10gFO
         fbhANH8r1sMBN/hZXpndJI9ALFbDYGmOZke/S/v0GPfsu9Ujg5xomJUbh0ToosffzdEi
         //Mn13KsRF9gGBW8Dk31YKv8cE6m1I+L6mS2vHc35MP8T/3A9wJo2AFT6d1G/sYCoJXh
         KkfN/gNaV1slldE6tO630vU1z3DH+DpA186OQsTrgHl/JVOvwoomfo570M2FE/cTlOye
         C5ew==
X-Forwarded-Encrypted: i=1; AJvYcCX8s+FAI7XetFU8ZrJiiBgamaghL7m/JNsHUhPjIj15myQYW0kcXSkIeXI4au+dY0t5GlYaIeKn07wBg0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+X17u/nfVlcEqxMjWNIjczOrzQgQvQ1jr6IfXqL2yBX+uH33
	7SYmtZcgTBeVQsA8uZ2fDLfJzuQi94XcVmojanpk5LcRqpp/0iGynI9N
X-Gm-Gg: ASbGncu74a+/wNtop7PKXL0wJCmFmwx6FoCwOqYucu2lZRNzOjKO97egcSv0A7lvkLw
	jyilwpXPttVuIjWwwR7YWeNU8ComBehXKDkD+i2pamqD1nszptIBzeEvrQSG1IBeDFZVP4mXEyU
	tKXsdq6VCesOEsBqD7XHlEC5q97qQ1qij0E3+krnQT66bilniqjg9KIwagAnQRNb7ou07pogLTQ
	pAoNcFy2xz3dlfLoAgZuvWJB2O5qgFR4V5D6OSaUKZapf3AL92iB8viVwJm3gOEBsxpK1/f6Tgj
	YJDNi3lQa59K8k/XovXPPRF2iStFuBQsr3Qks/+4nirtRztGwqoSZDDK0I2wbilks/Ay+Vigkx7
	9dSToE1ytDHgtYmI9PrOvTfcTFzekGt3bu8RrDejMVM0hYasVvKBzeQhzNYO9KGEM4HmeaEHojy
	GD2xV+xzXADyIsxlPM5jN6rSM=
X-Google-Smtp-Source: AGHT+IEJzR6PCrUgJkNWH9fQSw/nY/s4Zu4U9QY66TsXFNh3e/NVRbzSY9nlbLgfJ09gjwgG9YTkEw==
X-Received: by 2002:ad4:5fc7:0:b0:78e:7a30:4d62 with SMTP id 6a1803df08f44-7fc28075665mr116691516d6.4.1758903047160;
        Fri, 26 Sep 2025 09:10:47 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8013cdf424asm28671636d6.26.2025.09.26.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:10:46 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id CABA3F4006A;
	Fri, 26 Sep 2025 12:10:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 26 Sep 2025 12:10:45 -0400
X-ME-Sender: <xms:BbvWaHVuXDP3iMjjPX1m7M90D-RNquoCqG1-esnmJoBZQAkpEpd3Tw>
    <xme:BbvWaPxByfBQ4KDba0u_gP05hEOPa2GwGVSFrFwj1ZDKwheQ9tzEHMjiMvO3m94Vo
    pw-fILu9wwFJpcKDTvrzb3_leAhSUzCccxhFghI2B1PHu1ckeOI>
X-ME-Received: <xmr:BbvWaGDlLAeh4zRnhHena0ITcMn-iqQroSYWAFMBj-lzXqd2AuLRdGK5ZpFtYnRPSMHgfmsK5w20xWICBdHyLygKoVFrB1a0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueffieeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepfeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehphhgrshhtrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtth
    hopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehl
    ohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:BbvWaN7gMW_uJOXoaGTJ9xSlmxs7n2SOoVL41AmneFiFZsrDOjL-tA>
    <xmx:BbvWaFknzs2z_PNwzZBGvsA40uAsb8YUJYaM6UCaDKjxqxRM7WbG3g>
    <xmx:BbvWaIc59-2Me0P7VNO45_KkiB0ShlA5xzw4G9hvwC7kfQ5kEfECMQ>
    <xmx:BbvWaG0UA8e0wvyM67dznKC7x3DNyCxCfifsnDms3P5cfKMviV4BKA>
    <xmx:BbvWaP4FRn_SWivUuOoKR9rfZR6a0P0Y3ZFVUjm5c2oZS7M15ACO598b>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 12:10:44 -0400 (EDT)
Date: Fri, 26 Sep 2025 09:10:44 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,	Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,	Waiman Long <longman@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,	Justin Stitt <justinstitt@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Lyude Paul <lyude@redhat.com>,	Mitchell Levy <levymitchell0@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] rust: sync: Add dma_fence abstractions
Message-ID: <aNa7BDpKS2KA__4M@tardis.local>
References: <20250918123100.124738-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918123100.124738-2-phasta@kernel.org>

On Thu, Sep 18, 2025 at 02:30:59PM +0200, Philipp Stanner wrote:
> dma_fence is a synchronization mechanism which is needed by virtually
> all GPU drivers.
> 
> A dma_fence offers many features, among which the most important ones
> are registering callbacks (for example to kick off a work item) which
> get executed once a fence gets signalled.
> 
> dma_fence has a number of callbacks. Only the two most basic ones
> (get_driver_name(), get_timeline_name() are abstracted since they are
> enough to enable the basic functionality.
> 
> Callbacks in Rust are registered by passing driver data which implements
> the Rust callback trait, whose function will be called by the C backend.
> 
> dma_fence's are always refcounted, so implement AlwaysRefcounted for
> them. Once a reference drops to zero, the C backend calls a release
> function, where we implement drop_in_place() to conveniently marry that
> C-cleanup mechanism with Rust's ownership concepts.
> 
> This patch provides basic functionality, but is still missing:
>   - An implementation of PinInit<T, Error> for all driver data.
>   - A clever implementation for working dma_fence_begin_signalling()
>     guards. See the corresponding TODO in the code.
>   - Additional useful helper functions such as dma_fence_is_signaled().
>     These _should_ be relatively trivial to implement, though.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> So. ¡Hola!
> 
> This is a highly WIP RFC. It's obviously at many places not yet
> conforming very well to Rust's standards.
> 
> Nevertheless, it has progressed enough that I want to request comments
> from the community.
> 
> There are a number of TODOs in the code to which I need input.
> 
> Notably, it seems (half-)illegal to use a shared static reference to an
> Atomic, which I currently use for the dma_fence unit test / docstring
> test. I'm willing to rework that if someone suggests how.
> (Still, shouldn't changing a global Atomic always be legal? It can race,
> of course. But that's kind of the point of an atomic)
> 
> What I want comments on the most is the design of the callbacks. I think
> it's a great opportunity to provide Rust drivers with rust-only
> callbacks, so that they don't have to bother about the C functions.
> 
> dma_fence wise, only the most basic callbacks currently get implemented.
> For Nova, AFAICS, we don't need much more than signalling fences and
> registering callbacks.
> 
> 
> Another, solvable, issue I'm having is designing the
> dma_fence_begin_signallin() abstractions. There are TODOs about that in
> the code. That should ideally be robust and not racy. So we might want
> some sort of synchronized (locked?) way for using that abstraction.
> 
> 
> Regarding the manually created spinlock of mine: I so far never need
> that spinlock anywhere in Rust and wasn't sure what's then the best way
> to pass a "raw" spinlock to C.
> 
> 
> So much from my side. Hope to hear from you.
> 
> (I've compiled and tested this with the unit test on the current -rc3)
> 
> Philipp
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/dma_fence.c        |  23 ++
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/spinlock.c         |   5 +
>  rust/kernel/sync.rs             |   2 +
>  rust/kernel/sync/dma_fence.rs   | 388 ++++++++++++++++++++++++++++++++

I missed this part, and I don't think kernel::sync is where dma_fence
should be, as kernel::sync is mostly for the basic synchronization
between threads/irqs. dma_fence is probably better to be grouped with
dma-buf and other dma related primitives. Maybe in kernel::dma? Like:

rust/kernel/dma.rs
rust/kernel/dma/dma_buf.rs
rust/kernel/dma/dma_fence.rs

Thoughts? Miguel, Greg, Danilo and Lyude, any idea or suggestion?

Regards,
Boqun

>  6 files changed, 420 insertions(+)
>  create mode 100644 rust/helpers/dma_fence.c
>  create mode 100644 rust/kernel/sync/dma_fence.rs
> 
[...]

