Return-Path: <linux-kernel+bounces-748199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E5B13DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14DD3AA87F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886F2701BD;
	Mon, 28 Jul 2025 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQmUeLv4"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479A26F477;
	Mon, 28 Jul 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714755; cv=none; b=B1f0Nr9xqAIDXUGw9a/pQm60d23WTAp+0wA7OQrEULFGYWvSOu9i1s8lsdhCX/l1pOVqnMaHV+Nliejel8rfvm1mG+y3F0xYSxMxJ7kfzENP0WHZabusWk9OBS3EDtsvW2+NtWFjuvJHv0VHWa5bWwaXeUQNly1ex7Xvlq1VYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714755; c=relaxed/simple;
	bh=avOOm/XGSGlKBAkk2AukBt0QcjzdFQplikyO6nl7+k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJYNi/iXn3/Xg60HDNKtK569vOUKQYYPiKU5m1odtq2iA7+4ZuuwozKCeCyEgpUgVjoqMj0YFpuguJ1cBRZN5woCu0Vyoh8xAoRulI5B050/4+ZB623gu6lvAHi2OUgGpyvUWYdrhsnqS2q48+18jq1ll6m0mYHHzJ8airVgp5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQmUeLv4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab5953f5dcso43446571cf.0;
        Mon, 28 Jul 2025 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753714753; x=1754319553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW7CBe0k2NxOTfUN9V2nfPb73D8GQ6JvxvjA3Wk6pYo=;
        b=nQmUeLv4odZPxBDzCfaN/lq2O3w5AvTaNjQ8UavsK5Yux/1VHgLDROGGqpVrT2tgDU
         xPUWXX2KONWjg7Esi87H0/eT4pVeLX7D/10JDBp+hJ5tX5Bql6zMO2Not6CKn/G9Ic7i
         3v7GhC8hDKcCBSP3rPgDEiLuGc0r30w9319eQYL7fnrH8YNBJs6L/zfhrZ+Mu9t11GwT
         KfOGTJgDzIm/fkpH7cgXLipf2QAFViBD2rGpcZjVVCwg/RZF71gCeo/e54m22A+8QN+c
         6LdpkH6djUBxuMu3slsldpDQ7OcGEKKC333ODJD/FTs+v8OGQItMO8C9JXrdYzpzVkOq
         mXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753714753; x=1754319553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qW7CBe0k2NxOTfUN9V2nfPb73D8GQ6JvxvjA3Wk6pYo=;
        b=nHR/ovW+pZhwOQ4Btqk37i8p/zqETB8OjAuoFVGv0w1zAeHABILM+ai81v1uBmEquZ
         OnhB+8hJY7W4+qqbEQJm5I88vHcDWKy7f7INR+zKskogAJ7BNWDHLCKTPkr9yk5vAEGW
         VMjLUIRq3q9OfAWT38BFaT9VG08cbKsVLly295b5uVytwraZbUwWXWlKYNYSyD9AeqXD
         okyTtSQWNPEmHvkCZVcJv2aNfmyvMC2G5410DI29ecz7TnC9EQXLXYPBtIEvgSUuoZOG
         vN6gD08LBBk2wL2ea8i3Sc5xhLMZmJ7l10lN1FXjW6s1Q4cVgAnbh0R+nWVFra5BtKfy
         Rr/w==
X-Forwarded-Encrypted: i=1; AJvYcCXUNKVn3J9ENxAo5NRar/aKY37JqjfTgwF9/A5qGqTwZsEsCCqElPJKlHBlY8D4tgV2g5p1NxlyIOGx36w=@vger.kernel.org, AJvYcCXzPvKYQ8U8XDfzfGAsdOmm1acQkNYjKCSnR8/XQzumY7LY/NgHqDP0U4Zuf1FJLROPvTT7cd59svTwh4sgFD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4HIQiVwFLu299fB66XnFYA0gscUcr+A4/AIUAu+0rNE0D6DNc
	0BC1YXNMHcO4cB7ogaqy5DYNEkNSF54tDsl6RxuJ7sIPrLoJhydZpP+t
X-Gm-Gg: ASbGncuVSZdROZ+skc6XnfUptELo4UvzJ0gqrm0sGLgY4xVxenfz9YqzpwlVris4YWp
	cNagodB65DpVGF60GOogHhHMEqpzFpEPfx1Bv48Klkd2iy0gTgc+oe8CSRf/vhieBsSTGFso+mf
	hMxjWfsXd3VLL2yCbGwisWeGdq2vUKzQQk0l7gXEUTsj5FFgk7aMTTrKaRD8XhiIyb2qcXMkEp6
	q6iEL/DQWvksLBsnKafUMewHr6YCactLsRyVLY8YEXQuOpX6S5E9nEL1hJJCGO1EH5+vRaPkVlL
	pqLI1AkHGJFkIMdgMpdpzS4a+k5TX31Tr+pxEb2RbGFLfBe1vQHmVIKZ/ok4pWJTNcD/jE8lREs
	4Dhm6NfMjftbsKVTJG3LBs8tjX4pHGYQp1fFLolVm3qLwRD/2zPyFSh1OFuYbEpuMfqxEvmat6M
	h2gEu2XR4Ut83wALrFkoT74po=
X-Google-Smtp-Source: AGHT+IEilpceb4coQig3helhrha9AS+IXxGPugeVQS2rXS6X0hS+DBimd6oxeTtqbULIABK6rTnUYg==
X-Received: by 2002:a05:622a:19aa:b0:4ab:5888:38fb with SMTP id d75a77b69052e-4ae8f0b49c6mr162953791cf.32.1753714752741;
        Mon, 28 Jul 2025 07:59:12 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9969b169sm35100331cf.64.2025.07.28.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:59:12 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B798F40066;
	Mon, 28 Jul 2025 10:59:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 28 Jul 2025 10:59:11 -0400
X-ME-Sender: <xms:P5CHaH5n19zCNKEyZozQEHQtGxzFvwNvwuzAbLuWj25thyWXXgH22g>
    <xme:P5CHaIGC2Qq4aCPx8Q87BMZxNYU1FpJilw4j8Y4eOoFCTo5zdmYRYVGmgeEYxGYST
    JjaCfDCyAUf-T5rag>
X-ME-Received: <xmr:P5CHaCT1AHMRUqdBuTU-YrQvHKL7kZ4e05stP4T4TvaDK79ScPqX3LEqLFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrtghouhhrsg
    hothesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprggsughivghlrdhjrghnuhhlghhu
    vgesghhmrghilhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepuggrnhhivghlrdgrlhhmvghiuggrsegtohhllhgrsghorhgrrdgtohhm
    pdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtoh
    eprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:P5CHaCe-g-cOckmeqaHDZdcnu_6Dgiw1RI9QcKR9K4r7JA1WiAey0A>
    <xmx:P5CHaIjKZLs4fBBb7kqgNJC1JcNSa3dT9SXrLA60e_CGWUCAUivVqg>
    <xmx:P5CHaFIONrdNBA0VpnLCd-rwkTMqdluNBhBCQtRPLrEk-Fz5vKjF7A>
    <xmx:P5CHaNGDviu3nFXnKWEIhG0zJNJOAyOdLJRV9s1BJ1zMelYR06kCkw>
    <xmx:P5CHaD2CGVDqV8TLt4vUYhUGMTHYP9HTdjYUP7U3wxTDfkp_T1-Q17cp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 10:59:11 -0400 (EDT)
Date: Mon, 28 Jul 2025 07:59:10 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Christian S. Lima" <christiansantoslima21@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] rust: transmute: add `as_bytes_mut` method to
 `AsBytes` trait
Message-ID: <aIeQPrGSa2rwckiH@tardis-2.local>
References: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
 <20250728-as_bytes-v4-2-b9156af37e33@nvidia.com>
 <DBNRVIEXN4ZR.1VG0GDN6BDXE8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBNRVIEXN4ZR.1VG0GDN6BDXE8@kernel.org>

On Mon, Jul 28, 2025 at 04:53:31PM +0200, Benno Lossin wrote:
> On Mon Jul 28, 2025 at 2:47 PM CEST, Alexandre Courbot wrote:
> > diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> > index d541c9960904d8c7f755351f22d06e4e8dbd546a..000fda2a78f8e6e8378bbe93cddd8a5008db20cc 100644
> > --- a/rust/kernel/transmute.rs
> > +++ b/rust/kernel/transmute.rs
> > @@ -56,6 +56,19 @@ fn as_bytes(&self) -> &[u8] {
> >          // SAFETY: `data` is non-null and valid for reads over `len * sizeof::<u8>()` bytes.
> >          unsafe { core::slice::from_raw_parts(data, len) }
> >      }
> > +
> > +    /// Returns `self` as a mutable slice of bytes.
> > +    fn as_bytes_mut(&mut self) -> &mut [u8]
> > +    where
> > +        Self: FromBytes,
> > +    {
> > +        let data = core::ptr::from_mut(self).cast::<u8>();
> 
> Also add a `CAST` comment above this line:
> 
>     // CAST: `Self` implements both `AsBytes` and `FromBytes` thus making `Self` bi-directionally
>     // transmutable to `[u8; size_of_val(self)]`.
> 
> On that note, `FromBytes` probably entails `Sized`, or does someone have
> a use-case in mind? (because then we could replace the

Because if `T` is `FromBytes` then we want `[T]` is `FromBytes` too?
Also it would be weird if `[u8]` itself doesn't implement `FromBytes`.

Regards,
Boqun

> `size_of_val(self)` above with `size_of::<Self>()` which I think makes
> it simpler to understand)
> 
[...]

