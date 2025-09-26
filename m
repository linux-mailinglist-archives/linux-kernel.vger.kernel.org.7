Return-Path: <linux-kernel+bounces-834352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A65C4BA4837
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D1A385106
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8B2227E82;
	Fri, 26 Sep 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HebRmOgf"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA9223DF9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902120; cv=none; b=T29emzMHqW3fBghPcitjRNGLfxMCdX+uaTH0a7Qa/dOlT/2lVgXbJxIxRL6ciDfJj0hMv+W6+DOhjaR9i2+DgZRnjrEVc6N00kFRIKqxc9yE0ar9VvOhsXnsN3ppUNF/FHQpGoP0rST+mYUew41y3K4fTQ6Ai2GEj0YD++pilIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902120; c=relaxed/simple;
	bh=W30LPLMCaJ7Q8gg5CZFNnRA+jVmc9RpOMF06JDxOsGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMu+ooO+0vwe7kGRO9S7+iK8R3KDnN2FuiNDbC3bzxvnvxf2V0ZLQVMW5rdYoisKFtRVk/hq++A0Zck/Sr59wpHSSvbrBVokM514VvYekGWRgejR7aP2wtXDgpwjCnGQ3iAhl88RyjMHYtzbvgZ+zla83tG3FsMb9TTjxM7ubWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HebRmOgf; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-826311c1774so263035285a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758902117; x=1759506917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwVLQWq4agLcIPwtqxORw7RAekhV3aBIRal6E0wDwPU=;
        b=HebRmOgfBf2Tw9rzJfO5PFoHmtuX4ZjaCC6LpE3sZVoa7AJAuzDQb0An183+hATd7L
         K1bgXitzdSFDcJ8T6x2zQ2tJT0jwYVErYcQO+AaP/kPjk9yx0UI/omszqts9kcqJQxQn
         AeLvdCx2dJcwIAwbZKKmAKr5f3ggeSk+SMGoVmGghvc9XjkDFWrkgE9TR+ZHkDFBaY/W
         vMVulu0yS8Oi+mF2qeEKie/HlcEQkkSed8hB0vfRHdcbcDyp3lQaAKgdE/tRz8Ko1zJI
         6jXM1S0NsyvxyXvMqN78imr25NUFpjSvsVjqOyhuZBvx8XVBUhX2qkdo9unTATiQQm5W
         sWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758902117; x=1759506917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwVLQWq4agLcIPwtqxORw7RAekhV3aBIRal6E0wDwPU=;
        b=oX4Jf1ItMseQ1FFe47jVVElxI4benzziLvcWX0NViHNUq5GvehexTA9a/cHFP+YPce
         fhZJq5PHyRf4i7BgH5r8f6CyabPq152UbxtkRQMiaMvnDFYvh7Bxkx4IX1jp+LZTMFlP
         U3LS7Y6eqXdSYwcnRTjiuGeVBs0ngDcHMJHuvsFIDVTAW2K03NgIwibPIs7JPk31ArBW
         jIlWASiu0/FtkuintCWT6ZryPVlY4k3Oa8u7CgW7Ij1JvkC/gdUUQ34PDpyfDtYOJk0E
         p+99QhzyHF9O6QHJFX9AfNWmm+YvXqMRhusKzSqJVF35uCePu5GG53CNvgEnKIPuoMbN
         KJMg==
X-Forwarded-Encrypted: i=1; AJvYcCXChn+AddvolDLtTHtlzLWI5oRdxVUttWUPo43lq9M/OJD3VgvJo1H18Kfl5ixTaMSZGf3meUGNHF5hFak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2eu1XNqgi/PuPnA6zm1ymWQZ8hWko5QDRknOjkv/nA7v/ljFA
	huSl2BHMU0EvyOvTBaKQqgUlimUWgMFFz5olCFGFpE5iTsV2qT3ykXzt
X-Gm-Gg: ASbGncs8JCyIYvRlvbzauXHfNsLBcQlxesVe/eo+uJjI4ctIzVSK1KAD30kYdYwr98h
	TQcIyr7qWfIPceAW3QmmtdYWNiJAKX/sLGXmILmImo+70WAxT6JAybKCuCcb0Rz2oTzJkJxnzlW
	7H8VZ01MRo1xsSDtqvSvLLq0Bw/aLA6Z4ogbHUg89vXaItYhByLRxU31MPThMNDWIWLbL0K55Li
	D9zXYeUEDkjkrPOFETMQ4N240cGf/um6o9Sk6bQ1hMOh1hF64ujebAWkYo4DMITlEmesc0GT4te
	OpRdsra7G1qR2f+7lfNicLP0Gyyh6jwWjqB12IGYYlG6CKv/lfrlx/cx5hgPYv1uiJlkbgJsW+B
	eDC48eRKoBtlp+lN1oPXysrk4WxJCd9G8gwpGBhE2KJ580uuWM9IL/KFKTlt6GT7G6730IVbaMP
	qyg9M2eA2TqCeWd4nI6ICGs/w=
X-Google-Smtp-Source: AGHT+IGeiOiepA2vFcMJ48bE0eEuJkG9TN0xGEwQm10FQLSEXbZRVSfoIEmG8VsbxriX5wa9TlQSyg==
X-Received: by 2002:a05:620a:25cf:b0:85a:a540:ba05 with SMTP id af79cd13be357-85adf5d2758mr948352585a.2.1758902117008;
        Fri, 26 Sep 2025 08:55:17 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c28c76f69sm304832285a.27.2025.09.26.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:55:16 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3940CF40068;
	Fri, 26 Sep 2025 11:55:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 26 Sep 2025 11:55:16 -0400
X-ME-Sender: <xms:ZLfWaEnNL9gRitVAolY3hzpXQJuAnbBx-QlRvuCJOT6VpMaEhy7dcA>
    <xme:ZLfWaPpoR0mVJlgFERiwyHIXgnHS7CePOs76YJzjEcOVbZxmzYaezOI-IKt2S4-T_
    1psYGvLZzYnjr6iMv3elGajwYBSgvSJso-4MtTn6H9iIuWIYf8_mA>
X-ME-Received: <xmr:ZLfWaOCHgbb61f4rhZoXHZ-YXQFXPY7CgHgZ4ruRMH23eOTF4tJ8YUWhpv1yQq4RARSbysZ9A-dEKkOCFCjlpT41JC7ZxwQj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhnghhosehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfi
    hilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehusg
    hiiihjrghksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZLfWaKFXaMpilW3JkHH4dvumiWVAHdll5aBQwHGZKd7ZIB_IQ_Xjug>
    <xmx:ZLfWaA2MHppUNkJdJLN3l9HUi1Y7VQq0DqK_uN4Q65qfYeLPzYm4Xw>
    <xmx:ZLfWaDMh0J3kY3OkAojOTQ2WGHTVmrUy4OmAyJWVMIIbLKxagzEDQw>
    <xmx:ZLfWaIYCD87BWL2qp0L6qh29FpEGFscG94TH160IRIKDF2Xc6Clyww>
    <xmx:ZLfWaJz1mhI7RgMnQpqToU5c1d8CesmDQjqXeK57wcQWTV0p1gVSlGmp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 11:55:15 -0400 (EDT)
Date: Fri, 26 Sep 2025 08:55:14 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gary Guo <gary@garyguo.net>
Subject: Re: [GIT PULL] locking changes for v6.18
Message-ID: <aNa3YrzdrcXM0bhM@tardis.local>
References: <aNanBZ9VbIO2CO9x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNanBZ9VbIO2CO9x@gmail.com>

On Fri, Sep 26, 2025 at 04:45:25PM +0200, Ingo Molnar wrote:
> Linus,
> 

Hi Ingo,

The commits in the pull request look good to me, however I find the
description has some problems.

> Please pull the latest locking/core Git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2025-09-26
> 
>    # HEAD: 17d9f8eaa87d40a2ff66598875a43363e37a909b MAINTAINERS: update atomic infrastructure entry to include Rust
> 
> Locking updates for v6.16 mostly include Rust runtime enhancements:
> 

This should be v6.18, right?

>  - Add initial support for generic LKMM atomic variables in Rust. (Boqun Feng)
>  - Add the wrapper for `refcount_t` in Rust. (Gary Guo)
>  - Make `data` in `Lock` structurally pinned. (Daniel Almeida)

This part is not in the pull request. I had two pull requests to tip
tree this cycle:

* For atomics: https://lore.kernel.org/rust-for-linux/20250905044141.77868-1-boqun.feng@gmail.com/
* For locking: https://lore.kernel.org/rust-for-linux/20250919091241.32138-1-boqun.feng@gmail.com/

The second one contains the part you mentioned above, but it's never
been merged into tip tree, so it doesn't exist in tag
locking-core-2025-09-26.

Regards,
Boqun

>  - Add a new reviewer, Gary Guo.
> 
>  Thanks,
> 
> 	Ingo
> 
> ------------------>
> Boqun Feng (9):
>       rust: Introduce atomic API helpers
>       rust: sync: Add basic atomic operation mapping framework
>       rust: sync: atomic: Add ordering annotation types
>       rust: sync: atomic: Add generic atomics
>       rust: sync: atomic: Add atomic {cmp,}xchg operations
>       rust: sync: atomic: Add the framework of arithmetic operations
>       rust: sync: atomic: Add Atomic<u{32,64}>
>       rust: sync: atomic: Add Atomic<{usize,isize}>
>       rust: sync: Add memory barriers
> 
> Gary Guo (5):
>       rust: implement `kernel::sync::Refcount`
>       rust: make `Arc::into_unique_or_drop` associated function
>       rust: convert `Arc` to use `Refcount`
>       rust: block: convert `block::mq` to use `Refcount`
>       MAINTAINERS: update atomic infrastructure entry to include Rust
> 
> 
>  MAINTAINERS                               |    6 +-
>  rust/helpers/atomic.c                     | 1040 +++++++++++++++++++++++++++++
>  rust/helpers/barrier.c                    |   18 +
>  rust/helpers/helpers.c                    |    2 +
>  rust/helpers/refcount.c                   |   10 +
>  rust/kernel/block/mq/operations.rs        |    7 +-
>  rust/kernel/block/mq/request.rs           |   73 +-
>  rust/kernel/sync.rs                       |    4 +
>  rust/kernel/sync/arc.rs                   |   55 +-
>  rust/kernel/sync/atomic.rs                |  551 +++++++++++++++
>  rust/kernel/sync/atomic/internal.rs       |  265 ++++++++
>  rust/kernel/sync/atomic/ordering.rs       |  104 +++
>  rust/kernel/sync/atomic/predefine.rs      |  169 +++++
>  rust/kernel/sync/barrier.rs               |   61 ++
>  rust/kernel/sync/refcount.rs              |  113 ++++
>  scripts/atomic/gen-atomics.sh             |    1 +
>  scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
>  17 files changed, 2454 insertions(+), 92 deletions(-)
>  create mode 100644 rust/helpers/atomic.c
>  create mode 100644 rust/helpers/barrier.c
>  create mode 100644 rust/kernel/sync/atomic.rs
>  create mode 100644 rust/kernel/sync/atomic/internal.rs
>  create mode 100644 rust/kernel/sync/atomic/ordering.rs
>  create mode 100644 rust/kernel/sync/atomic/predefine.rs
>  create mode 100644 rust/kernel/sync/barrier.rs
>  create mode 100644 rust/kernel/sync/refcount.rs
>  create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh

