Return-Path: <linux-kernel+bounces-834992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82635BA5FCC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F691189EDA3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B402DF717;
	Sat, 27 Sep 2025 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbANXfHC"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9D2D2483
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758979993; cv=none; b=MkNvnirggsBM3ixSwydECRptN3yOvibQh0Ezp/sQiMNFYBjnpxNoaf6j+F64YwPKRQZqBasC+5e8Ro4B59vYJ5ay0MGNmkfPlqmigquUHhZ07fVhVs4qOocL2xpBiBEgsWmddoGbsaLOCUtHqHuEfhlze1+gdzyfVd1MQwlIGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758979993; c=relaxed/simple;
	bh=U7jLK9g7Yw/WoRuxeBbXjiHDDRSKGS09wBhJ1bF0+CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RigYil0HvlRjQ/bP1k698vZ3xbHI4AAH2yDA9QhXfqsZQDl05JMj1NTxXRQT4zwgTi49I8dWsOkAndir7gwe8BP54a/JfxA1Ty4HP6iwkGC3gb9yvu16GAlgVke6seKBQwN8byKgZOkuTzrBwXu6C2U8o+2iSptsa5SIoOun5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbANXfHC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-795773ac2a2so26338796d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758979990; x=1759584790; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jAJz2iZlVqH7fub6DPlrBF+dlNC7fGvqpAeWouU/7VM=;
        b=XbANXfHCYtp/6ReFA9vBwIt8ZNSmmDx2v2XsHx/108IKnPpD5hjBR5vtitZncM03GY
         mTxdKhgsksVGQxVCoj4VlXx6KJRI0OEZmDRb0l110uwNB6S9OrqhMixwwySVfVXZ1lGv
         68C8VMjoii81n++RjWT8miWwtfTtAbMKOtBUfU0rlypFonfJSgw1PGPDmy9KfkaXaif+
         3kdmlwyucaSKQw/EE5maLTkpJr7qetLApVwfc5cVV6sh8KkxgJ9//14yGHlkt+SRFHp0
         o2r1lEfOMqKWRo4qqobl9m+p8JpKrtIqS0FMfRgASuXNZeEFdarV+6NDKzxs2X7OrZd4
         RYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758979990; x=1759584790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAJz2iZlVqH7fub6DPlrBF+dlNC7fGvqpAeWouU/7VM=;
        b=PMHxc7yGg+x8q6QG2UVjiQLxP7qLq6JQ64Y9fHRig0rHJU+rtTjtO74yh6YAfdYmQ3
         uR/DxEYSL9mOpYXRc6ky473tLBD5+Q2RrZn4H6qun1nhwtFpqE6ZIO8ZUWm9xgsRSShj
         0/zaI/10dFTA78WiU0tJfNTaWlETI0TY/YvjW8ZSx8kcdkxJq+P9Jr29+LwSjMa7ssTu
         DNMo55ZK71FQ9cHeFTZO01v2KOPF7BcIeVYxpVEbIjqcJFjmiRXf+JtFrbioYE2O76+n
         ZPF8Aml7FQJmFE+mGBrRguGQEplxMiBOxmws0REs7pucjidfscHhbz/Par9jMi33VsxM
         UKCw==
X-Forwarded-Encrypted: i=1; AJvYcCU23p6yyjTnXz4rzBswetQ7CTJyrHPVVu6KiybW9KxN8tNhXAl8egOog/V0w3J4WpySWJwu39zOkqdOjwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynfYIMfvNOBa/uXPhljVX82fNlrYNzf0/dI8dzC7eRDf6DkJB7
	PofqQGin0JItA5BL1FRtXnwKAfyX023KkzDge17h8PjzRfCpBA92+7qf
X-Gm-Gg: ASbGncut4z24rPCluItEkimjvml6WfkW+LYOZcSv+CL03IKIr8WLFnJjhkne9L+Zsa2
	nNrDxJhNUyXZuEifspGTjHAlQ9mIjMxIyVJD7nkKjh8gcPbytnKCif3b8b5h3GrM/p0nYrZMyo4
	yN+PunChv7pzoVMoyuc01uCOipyWrKdMSZm5RDXCTELy0WuS2Lcmedd/URBPt7jATzdG6PXRW9a
	i5dbXsMvnkifC8vlqv5vg6T2dyusmO59a5dio3GBexOPbHkUgiykoRvqwP5XVkqj5FbZ+HKJF5w
	2WRMVf/aJIOIHB/CtzFqyleM0ZtY83J5D6SAsSWq63604fKl5NIPjtZ6/NJwTocbzReiPFhg/cK
	gcchrqq1Z/ThUeCoZjx9DHh5nIcVrxMRrR0UWogdVs16RK+0nm/Fxe+v3mD/MllaYPuJeAdc8mH
	IoSzE91Ew1SQmXRr4LTZXl5yRJCrO3faafyQ==
X-Google-Smtp-Source: AGHT+IGH5UGkTv252dC01JpSDkaJcJ8KfFAosg2KR2cHgR/gkXTKN8Ezxd2HpK6jf4Aw75VWq5kbPQ==
X-Received: by 2002:a05:6214:1301:b0:79a:5e61:b6e7 with SMTP id 6a1803df08f44-7fc2bc2f235mr148121586d6.17.1758979990313;
        Sat, 27 Sep 2025 06:33:10 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11fc7e33sm41268141cf.51.2025.09.27.06.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 06:33:09 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E0E02F40066;
	Sat, 27 Sep 2025 09:33:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 27 Sep 2025 09:33:08 -0400
X-ME-Sender: <xms:lOfXaK-F5kwgMw7tlcjOR660qWhqCLrWrAZEe7epHUwd9o-JfImhfQ>
    <xme:lOfXaJeKeS3Xn5-Akgf5PnQayfL0UCcRj32akuvmHJrsFVIOi6RoXygEImaCEDIDs
    FodizH3rP8OG9AiW8mo21ldnIliy9zWjHGum-JJePd4NLv7IVo7>
X-ME-Received: <xmr:lOfXaEmj95r0yOYn4h5v7ABWtbr87idcTFHf5aZzJcHSW2oJnmLCcIBGTulB3ceINcf1FxPwdVPDxPn2_NQAntzVNQpHx5Dc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekrodttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtvefhfeetveeiueethefhhedvieelveeuffetudevueevueekveduheehieff
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
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
X-ME-Proxy: <xmx:lOfXaOgQUiKGJ76g8NZ3aKhHZKRXR7xf4qy4eWoMhRhJJcbnDuEnNg>
    <xmx:lOfXaGolzL_423YlYH3OllI9b70btOBalabRJPBlP9aNbpqsYXS1rA>
    <xmx:lOfXaBR23bkhC3zmGaCIYkInVEKP6yWKxQEt16HtkdLcLxC61_QuUw>
    <xmx:lOfXaBmk8fFkFier3uut9Rv3MypIL-z6K2i5_I21X4JLUoAXwJIKSA>
    <xmx:lOfXaPzq6u9J9Oep9xQ1JEINrLFC0m-OW4emMKoTX6g68CsOPyX8PaPg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 09:33:08 -0400 (EDT)
Date: Sat, 27 Sep 2025 06:33:06 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: phasta@kernel.org
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
Message-ID: <aNfnkhXnnxqdfPYz@tardis.local>
References: <20250918123100.124738-2-phasta@kernel.org>
 <aNa7BDpKS2KA__4M@tardis.local>
 <2aa5150d913fcd4d321db52bc6bad1770f68e778.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aa5150d913fcd4d321db52bc6bad1770f68e778.camel@mailbox.org>

On Sat, Sep 27, 2025 at 11:01:38AM +0200, Philipp Stanner wrote:
[..]
> > > ---
> > >  rust/bindings/bindings_helper.h |   1 +
> > >  rust/helpers/dma_fence.c        |  23 ++
> > >  rust/helpers/helpers.c          |   1 +
> > >  rust/helpers/spinlock.c         |   5 +
> > >  rust/kernel/sync.rs             |   2 +
> > >  rust/kernel/sync/dma_fence.rs   | 388 ++++++++++++++++++++++++++++++++
> > 
> > I missed this part, and I don't think kernel::sync is where dma_fence
> > should be, as kernel::sync is mostly for the basic synchronization
> > between threads/irqs. dma_fence is probably better to be grouped with
> > dma-buf and other dma related primitives. Maybe in kernel::dma? Like:
> > 
> > rust/kernel/dma.rs
> > rust/kernel/dma/dma_buf.rs
> > rust/kernel/dma/dma_fence.rs
> > 
> > Thoughts? Miguel, Greg, Danilo and Lyude, any idea or suggestion?
> 
> @Christian König's opinion would be valuable, too.
> 
> I'm not super convinced of that because dma_fence has not really much
> to do with DMA. They're not very different from completions and are a
> mechanism to synchronize consumers and producers.
> 
> Actually, before f54d1867005c3 they were just called "fence" and then
> renamed to "dma_fence" because someone wanted that name.
> 

Well, dma-fence.c lives in drivers/dma-buf/, and IIUC it will only be
built in CONFIG_DMA_SHARED_BUFFER is selected. They are enough evidences
to show that dma_fence is not considered as a general fence. Of course,
the implementation of dma_fence may not be tied to any DMA
functionality, but before we make it a general fence in Rust, we need to
at least change it in C as well.

Regards,
Boqun

> 
> Anyways, I don't have strong objections and mostly care about having
> them available somewhere.
> 
> P.
> 
> > 
> > Regards,
> > Boqun
> > 
> > >  6 files changed, 420 insertions(+)
> > >  create mode 100644 rust/helpers/dma_fence.c
> > >  create mode 100644 rust/kernel/sync/dma_fence.rs
> > > 
> > [...]
> 

