Return-Path: <linux-kernel+bounces-803431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F09B45FB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAF61885EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F39F313266;
	Fri,  5 Sep 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Baift23J"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79831D73D;
	Fri,  5 Sep 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092316; cv=none; b=XTabSubPqmgH74Ku3umq2xYlB9izBWMVU9GGMnOYFcPX5EcArw9Eshuonf2sNDXjk+fGh3ZdLXOnroGFztdSQUu9KRyJ0YfQBMyiZQhUyIuHiC46eHU6OCRGx8/p8UXYNQVG1YX5ztR7mpMpfMrsaBGti710fOg24sFoNMEEpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092316; c=relaxed/simple;
	bh=g99F8/S09ryVFGiemjkXxFrv/elNT0gGl8vU/s9Oy90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+LQeJ5ZKLhGH1YzHYk1yKMxWYdssNk9xYtjktIvHNw/EfQX/I5QUfrYGnMzdnyzmIGEag/Copj50YhxCddmsIJIsiuAB6N1nPfYvxUdEG1e6eG+4s3hYng0TIa/Ld813Aya1WBHIqmldBULUuTxW6rmX6Q+vtZw8DnE1UAhfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Baift23J; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b5f6ae99c3so164491cf.1;
        Fri, 05 Sep 2025 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757092314; x=1757697114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5ekuWU5RbwtQiw31LCbZWWmruopatpE+jVwBSdU8tw=;
        b=Baift23JeC96MpxmhnG4XcjAuQeAKenLjgX4g418wDznv6kSwfZ++8zKogtj/xkTKD
         orwbtBJg6HRo2PAxqEhVi+RGgA2nQHdbOcqLJS1R+Z79Q0PQMn3HZ7lOM8ctopMuc87c
         sic9Gh50Nodn1SdyDZe8alk5CjQ8hvdVYwo2UxttpPTEwAhVJKjSErrMmbUvknTzTf7O
         qBH/HLclZpt4oSdXVu4Ohd34bBYmVIEAsPHye75jHZnKfamEYb+X6ecJAJm/exbfx6iE
         Pv08PtfSXL6WcTdEjIayBiBHjqPkJSw0Q4ArSop8jBsKDosHTtjuQP4wbJIi5iY79okL
         nVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092314; x=1757697114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5ekuWU5RbwtQiw31LCbZWWmruopatpE+jVwBSdU8tw=;
        b=PlRbAB/FTT0+XiRm87vGYVJqJCx5eCOjrq3WLbEMiKz3BoxblN0rwGx/q0uFoE3Sd8
         PJc20vD+hVGqPzwk4TlXJBQm5pYxE6Njf4ovIugAPwKE4nGdm5l6EcB+1P/GYTMsGOA1
         LY0uKGcxliBkHb9JIEal+4rlZ2DWPBhMJuRHLaq1XcFAHJjQd0nr+CRtfyzCzBsNt9l0
         Ly0xZ/qminPedOgiF4MF1qlg9/dF+QPfLWrpEKdyRbcFn6qCtgttV8sCZmKxtnfi3Ch1
         syukbosD9cRqeUOqMcp/bPJemPGANLqHfW+NnzbtZBqSETz1QPT0htYLQBxLEkeeDdcF
         OoYA==
X-Forwarded-Encrypted: i=1; AJvYcCVxuWJB0FYmVSLbHUTyLWxa/BDkqM6/t6d2F8S02zenKxbmYinwQGVYox+1E/oCGHFBZ7bowy49G1OSS3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oQqwHg67rixBbTxk9ZcEI/uzPezgS1k8Dwa/ICb9+IQ9J1nk
	5/QsbYwLQj5XqRLi6QII9YbskVv1keCG/C0F43dH5HnzZAJ99e1ILOyv
X-Gm-Gg: ASbGnct9jhnGO0c2x35v8tGW78nDcXvfw++vbYu0Kdlu1ZlVZFec6WL95hk+L7nihLY
	D0pfdZAv8a0hBo87Cpe/qDrDL/REPB6ZEGBh6Y8kgQAUJWJPObU0AMY6VAh5BWW9zSQ2/rRy4ZB
	j7yKbZK8wpZhZwGS1vUMI26OsCbfkb+HqGupbd2SR1uAGwCTyq/xx3yVc66IlwU7LOEpcYD78jz
	oyClLFqEmAiEI3nBHHsgcVkLbBbJPHQRxtk3GvcxZzXPpUn573Yjnqrg4hRAvtbh+RnwJ2Hyvgy
	xTZNTAQ+pQv5FkfpkdtEYhx9M/vfm+CYJSK9CX+/SqT/w2fjyqhEKuVAFTjzUkZMt169SYyawKw
	6hgWKW846Jj4OtOXwJqpsPliFup51EFk+/Il58ddfnkkgjce4/Uua8uzACDOhqwBZ2RePqXCl5K
	70TvOz8GIGP/iiC1OtMd8tJ1lnG2C7GZ6qyw==
X-Google-Smtp-Source: AGHT+IELnH/qBYxpQFwcEvQaoHlixPN9il9DoABwK4opJVKV9lTR4BrdWk00FQljbcVHQAJhcwqsKQ==
X-Received: by 2002:ad4:5fca:0:b0:70d:eaf5:baf5 with SMTP id 6a1803df08f44-70fac90abaemr337980426d6.54.1757092313757;
        Fri, 05 Sep 2025 10:11:53 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-73524aa8465sm4729826d6.65.2025.09.05.10.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:11:53 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id EA551F40066;
	Fri,  5 Sep 2025 13:11:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 05 Sep 2025 13:11:52 -0400
X-ME-Sender: <xms:2Bm7aBc9oR0OYeYGUVCIU86GwG7feYaOCOdA3co1GpLLFNzigHoIgA>
    <xme:2Bm7aJS3p1YgcWNHrnH5J0MmSUDu6a2kYnR5I5K1Tnd4PBGmEVSMPmgTAMPIKyT0F
    vIqxGBdDZljZ8jDlA>
X-ME-Received: <xmr:2Bm7aPdtcjb9GyD8o2B1-yrW8IWRsy3ZhGVJaa5pTjvnT1hBxRlN7eKhctMPwDrhWh8QXyfiUlwslXwMlNKO8jhHt2si74_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelgeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehvihhtrghlhidrfihoohhlsehkohhnshhulhhkohdrshgvpdhrtghpthhtoheprh
    hushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhl
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthht
    ohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplh
    hoshhsihhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2Bm7aCufJgmTiewwmU5Tg--b9ClI86Z3fZ2qdfnghhGFKH6WaOH4Cw>
    <xmx:2Bm7aLJa3DvwSJ5j-Ztpj7wVy-7BsnU2Ntig_b2Zh7KGXoYKcLgsJw>
    <xmx:2Bm7aGbX3TX4v6mHVVV_q-CrQTl6pRL8LlwozTPFfD2QoJQ9CtX1Ag>
    <xmx:2Bm7aOmhgnX-AyT85SxZJSoDmTkhbEPN7XNA1jJu-smyW1LftNhctg>
    <xmx:2Bm7aEXOTNYfLlANcBNeNolWBISngu-6-RP9Z6q0lyiqYFuuqRbpa0gw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 13:11:52 -0400 (EDT)
Date: Fri, 5 Sep 2025 10:11:51 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH] rust: rbtree: add immutable cursor
Message-ID: <aLsZ1wk8RADj7P7_@tardis-2.local>
References: <20250904142552.2790602-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904142552.2790602-1-vitaly.wool@konsulko.se>

On Thu, Sep 04, 2025 at 04:25:52PM +0200, Vitaly Wool wrote:
[...]
> +
> +    /// Returns a cursor over the tree nodes based on the given key.
> +    ///
> +    /// If the given key exists, the cursor starts there.
> +    /// Otherwise it starts with the first larger key in sort order.
> +    /// If there is no larger key, it returns [`None`].
> +    pub fn cursor_lower_bound(&self, key: &K) -> Option<Cursor<'_, K, V>>

I think you can make a helper function that returns a
`Option<NonNull<..>>` and `cursor_lower_bound()` and
`cursor_lower_bound_mut()` could share the searching logic in the helper
function.

> +    where
> +        K: Ord,
> +    {
> +        let mut node = self.root.rb_node;
> +        let mut best_match: Option<NonNull<Node<K, V>>> = None;
> +        while !node.is_null() {
> +            // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in
> +            // `self` point to the links field of `Node<K, V>` objects.
> +            let this = unsafe { container_of!(node, Node<K, V>, links) };
> +            // SAFETY: `this` is a non-null node so it is valid by the type invariants.
> +            let this_key = unsafe { &(*this).key };
> +            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
> +            let left_child = unsafe { (*node).rb_left };
> +            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
> +            let right_child = unsafe { (*node).rb_right };
> +            match key.cmp(this_key) {
> +                Ordering::Equal => {
> +                    best_match = NonNull::new(this);
> +                    break;
> +                }
> +                Ordering::Greater => {
> +                    node = right_child;
> +                }
> +                Ordering::Less => {
> +                    let is_better_match = match best_match {
> +                        None => true,
> +                        Some(best) => {
> +                            // SAFETY: `best` is a non-null node so it is valid by the type
> +                            // invariants.
> +                            let best_key = unsafe { &(*best.as_ptr()).key };
> +                            best_key > this_key
> +                        }
> +                    };
> +                    if is_better_match {
> +                        best_match = NonNull::new(this);
> +                    }
> +                    node = left_child;
> +                }
> +            };
> +        }
> +
> +        let best = best_match?;
> +
> +        // SAFETY: `best` is a non-null node so it is valid by the type invariants.
> +        let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };
> +
> +        NonNull::new(links).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
> +            Cursor {
> +                current,
> +                _tree: PhantomData,
> +            }
> +        })
> +    }
>  }
>  
[...]

