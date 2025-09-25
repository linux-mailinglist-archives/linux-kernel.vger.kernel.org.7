Return-Path: <linux-kernel+bounces-833011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 417AEBA0FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEFF1BC6C21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7084313266;
	Thu, 25 Sep 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvz1hUqw"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E550313D47
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823867; cv=none; b=P1pwLOuep/rbgm98ZzGwrB7rYn4NEaE+D6IYpRODig0DGXtLMPdhc1yRHZ7U78wJjfd91MMaUYbSFAnacxSMI03CGmaiMz4E7c0O+iBq7tg3bYunP5Xzspu/coS7Pk4G2+rtjlQooqrSIRjlQ6e9J4UlnX9/rgKUQoweAjMos2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823867; c=relaxed/simple;
	bh=gRJlomY8XJgBO8KfTiMgLfgCx0LMIfAU3Q69N7VxGbc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSqHlHSj1RidX7aT2lBi8q+9HD5NUCzBFZj3kZ3xHZRE2SXIMEGdD0pvDikU2u22tftDGXwlurnuHTpxy9s/zpzwOyIt3s4khoQEYhmf5hjnasKXU9EfchS4kucAvgbKTBSsaTsYkvyJof4rwH+tfTZBgdE/d9UihBJ1a6lQBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vvz1hUqw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8593bcdd909so129606585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758823865; x=1759428665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:feedback-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbmL/lOVeBA4opARTfrAg3LXciWcnWLc1ZjFspAkmC0=;
        b=Vvz1hUqwIRs+pfz1BhrtDwIoSw2TVYexqvcsxOETqF2NI7mT22+kuRjVuz/HtDCjzW
         1UMElhpbYpaCVGNVJAaPsYLnyJpjMt6O/sdwZhhsHEiqJwJJVltROkTU9DUX1CuEwExs
         RrdCKGLZX8GjKieL9sBxkjB9/t+FK3TRbPSCYMcTKs4KluW+k55AxZbjZrC4t9koXyK7
         3tNV3fKU9AmOmUbYnjRYb+FONbiktLST5SdmzGxEYHzcIsp8ki29atoo2F2WEYsasCP/
         v3ccRd4SGrjGzq5e98bd9f86335jORidUuaNIhFfxvB0YHbcS4GiAsbzTSxh95WRz6a+
         kpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758823865; x=1759428665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbmL/lOVeBA4opARTfrAg3LXciWcnWLc1ZjFspAkmC0=;
        b=XmGpa5OOwwEFyuAU7HW8RKo7khrHEiiuC/Z5Evi+m6JhZ0RtDYFRvoa/re+QT6iyXs
         nnb/R0C2PIzUXMBtprTl5/LuJoYSJeAYP6Q9t0dvRORbdaQL0y5XlZcVcJQrjn8VvWs0
         PSxeVcWNYpMdLXtfIU6naCKDLKD+f+2rEnhPHCxiA1AbpyaHzvyokbAdbjuVd0mTj98e
         Gw2e4LIMOxYeUhxGpy5Sk20LJ+RRYNYTh6dP1/UI9JBwLp0q7Rr3VrGPj7jmTHH8ckh0
         qrHdtC+np1NDsBKA5o8zKhAUK3rzRrdJwGgMhhyHXUI1ArsPAVQaTBKHDze3TQ5Yt9Mj
         moDw==
X-Forwarded-Encrypted: i=1; AJvYcCWl2sxw8xrFc6cSla8dqj06MdRyRPAfVPCLZgUus5F6ZEWHbWW9d8THtdGMkhIrbQsFC+KLuiW1ualxhvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl9Ij6clnwPrDdmTbs0TRlYCJ3M1Tdty+pHo5TKkfVz57RYxuy
	kEJnvEMgOvjK5gwH5rjF1W9QCJqiJvQKoHnEjFWPq+ijgDfsP0HdSOIG
X-Gm-Gg: ASbGncsob5wW1ltt3qwzCj/kdxQalkXW8SpLHrnsZpRYUu0EBW+FWoRL4KWGRO0H3UE
	CqMXtCCS9Lc7TDzkFic/rgBhwec3nCcpOpQpXgHmRkdkTQtCViYJETtB0qK9zlPutS9jj6MMGcr
	VxGMf07lhlp+tiosma5+zvSynMbdta5xRjHS+UP+vIGhdmQcTbHOKBVfps1IGOXVzCN1wsQJIU4
	MhyDjAfG3hEITAO8hFxO0r+jmY4s3aAj30rbD3qbLBt5odXOMS39B/94SKQG8Vhgbndir3GU7rD
	ym19X1/ai9T2fpvQ2MGgrIB6frthuA4FoExIkc+JU95am0K1W6MTJjJ1oxc6nWbV6kgnPyenQRr
	Tl2HnXJvlnAUgPzok55abjRGDwGTc9kyUqCoM2S7uzGxDfo8OKS4bXuG2GVERf8+GkxihjQ4rOV
	/eI6eNu2RF1xmD
X-Google-Smtp-Source: AGHT+IHQ4u8Q7QaxnbcTmiHnMGLELyzBn8pkY32qfCMHB+rNHNHO2LejsPVbJxF+ySJ7Pt/+BCn/6g==
X-Received: by 2002:a05:620a:1792:b0:82b:2bad:ba33 with SMTP id af79cd13be357-85adeb4db0bmr521702985a.2.1758823864667;
        Thu, 25 Sep 2025 11:11:04 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c288a0f7dsm150656185a.17.2025.09.25.11.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:11:04 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7B3F1F40067;
	Thu, 25 Sep 2025 14:11:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 25 Sep 2025 14:11:03 -0400
X-ME-Sender: <xms:t4XVaLQLQLOTuSIt8T0l98KGsmwgKR6YsR-sHVTeEPg7a9LskEnVPg>
    <xme:t4XVaOJK0yAo8fWjHvMaFD9w3J67qHPE_0NlLLXiDrpV9L93Aur3b0PTP3nIou2zq
    n5zEYecLbdx5uxvJkgOdk4T0h20W5rPHHLyZyDR0RwmzVfXpyCg0zs>
X-ME-Received: <xmr:t4XVaKGtTG-eqaEbtXpT3B2zaUU_n9zPwLom7qJ0uCvRGYOGOg28tNB1kecNKnrZVjbCKWVwa8Kf2BaSAi4w2_SkEiBJvoRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeiffdviedtteehffduudfggfegvdejjeeiffehledtgefhheeuheetheelgeehffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepug
    grkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesvghlihhjrghhshdrshhp
    rggtvgdprhgtphhtthhopehgihhtsegvlhhijhgrhhhsrdhsphgrtggvpdhrtghpthhtoh
    epohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhho
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
    dprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgt
    phhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:t4XVaDRKB_rJV7LRbNXEmMVJHx1ePhimymx69BNbC-HcCA4Cp1WeIA>
    <xmx:t4XVaLVZW5cawveE8GSq4O59KSo60xSBbBj6iBGeTMB692Gww_khmw>
    <xmx:t4XVaKgtPULtCuugXC9lcymHz2Cs2zld4jMfZhxeQi-Dsn1861atNA>
    <xmx:t4XVaMey4KPiqMAJQelWiRjjuc7kcYWMejJK4AUjsFSuX5ZmFWcv0w>
    <xmx:t4XVaNcgdS2Ah1x-yaAI0g2TSFQ3rVMGUR9QSgz9gV-9RIsI8zDQkTWX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 14:11:02 -0400 (EDT)
Date: Thu, 25 Sep 2025 11:11:01 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Danilo Krummrich <dakr@kernel.org>, Elijah <me@elijahs.space>,
	Elijah Wright <git@elijahs.space>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH] rust: slab: add basic slab module
Message-ID: <aNWFtUGlPeIojFEp@tardis.local>
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <73d7d53f-439b-44a9-98ca-0b1c8fbc1661@elijahs.space>
 <DD22FI7F2ZHT.32SL8PXFZZHV3@kernel.org>
 <bypo74mzotejpsjdqd55sxygq3wjffnnimpm3vhm2xr5bddmen@lt6sr77ys73g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bypo74mzotejpsjdqd55sxygq3wjffnnimpm3vhm2xr5bddmen@lt6sr77ys73g>

On Thu, Sep 25, 2025 at 02:02:55PM -0400, Liam R. Howlett wrote:
> * Danilo Krummrich <dakr@kernel.org> [250925 13:43]:
> > On Thu Sep 25, 2025 at 7:20 PM CEST, Elijah wrote:
> > 
> 
> ...
> 
> > 
> > > I was thinking of maybe creating something like KBox for kmem_cache but 
> > > I didn't want to touch allocator code yet, I figured I would just create 
> > > the groundwork for that to exist. rbtree.rs uses KBox now but I'm not 
> > > sure it should, at least if it's going to scale to many nodes
> > 
> > Ok, so you want to support kmemcache for rbtree nodes. Ideally, you should also
> > have a use-case for that, but given that we'll also need kmemcache in other
> > drivers (such as Nova) anyways, I think that's fine.
> 
> This seems different than what exists on the C side, at least to me.
> The rbtree is implemented by embedding the links to the prev/next into
> the struct which is using the tree.
> 
> The above sounds like the nodes of the rbtree are allocated on its own
> and not part of another allocation on the rust side?
> 

For current in-tree API, yes, because we have to start with something
simple and the user (binder I believe?) doesn't require
external-allocated nodes.

Regards,
Boqun

> That is, the kmemcache would allocate the struct that contains the
> rbtree linkage (or nodes, I guess), but not the nodes alone.
> 
> Thanks,
> Liam

