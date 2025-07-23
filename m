Return-Path: <linux-kernel+bounces-742306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AFEB0EFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2688D1890069
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7E328C5A1;
	Wed, 23 Jul 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="0/GAdPYh"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F028A407
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266356; cv=none; b=gwHpd9f8MssE08HGWvwWYHN0Ak5n4Gmc6BTAZTj4abtUl137gg3C6hwUrJpawE4oc4vkpyxsJlpvDSGoswaw6RA6EoQqjOtulBev61PhTkygzLaD4YhlsLC5AIxvdr9RKWSsTNZz9b+HToaye105WRoHFdi8deOpG0gBsWjzKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266356; c=relaxed/simple;
	bh=VVjb6DUrAuickZ0G9yw7njNk5OG9V6OqIV0LVoFQeRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrtzqxSvaEZtVc61M6SzPzKVYb+MlBEfxsyn74Ktxn2H2V5NHF6EA+eh+ttfpKubIqSBcq+ny3TPhKeNn8ZPXrWnjAWt63CJtV7s5f1IWhXHLvWdCTqbvFde5NHXW8xeKHOOUlA6IUYc+2CXDuvqHWRZRfF2CvLT9xndJI1XTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=0/GAdPYh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0dad3a179so1050275166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1753266351; x=1753871151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ga6K4SG1euhWTtbAS3BVYAi++JrAr1J3Z67aIAYOeBw=;
        b=0/GAdPYhOG1SFsyVKTbvnlBQBb/W0Tynp3T3qsI4s0sruMzqXhLWqBNQvuM6Tcdi6t
         YkR7vetJ4r37Dfme6dfgVZ5GEJVX3G3v0GxGxuajNlu1AaT9t0q60piJsN0eJvp0u9O2
         1igUgPmcH7taPEmM/4qjnmyXzHakKYr6d3qCfQ7n2s4/Xu9aCwPpL1NUsp8RDlvCR+5g
         FoQ61xcJC1PX6ShY2SUJDc316IcVj2mTKR6PeekoIT370LHZbigji0UAq4kEl6XS+ZL6
         P/KDuhuwTAkGG/PBeO9I/S4RgRujDXjiXuAVLhDp86hXlJrr5HwGA7J6I6wtMCX2P3j4
         Yn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266351; x=1753871151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ga6K4SG1euhWTtbAS3BVYAi++JrAr1J3Z67aIAYOeBw=;
        b=VpXL6Q8uwWCzLSbyReqsRE+bEJh/3+sVtFuzw3iy0RlWhD3hH5oUkzhJdxYXSRg2SH
         utDOO2mf9ECEQEGA82A9yw7ehz0RTc0LfuAPVx+X88d5PR3zLcaZyUjlDwglB3BxO+6d
         fWCwd3Hmx6vvvCXNE9OyVDq7diySyeGXXbGK2ul/2ix1K3O36cEg8EaIXddFMTHpdFPi
         riEi0ji0iuW1Dco3BVtW89mKMxNY6KawN7kaku2cYqurUY+DBIn5MOZOyjeVYvUlEv8H
         WHIzc5jHWn3nz1qOZwaG0iKeuu1h6xKjK7R9Jb2waSXOLDg9vw/2zPCFAwAXCOna5Epw
         NE1A==
X-Forwarded-Encrypted: i=1; AJvYcCVx9bJdvAqyys5TCPwxUyEvtQy6rJj8KsV1Odg2gpUITlzk2XCrHaWpJSw1tf/MxfSz4XgH2XRXW5nKads=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRVNVdhHvcqOSX+UOcQYa39fqaX8EzvkTVGd6U4Clrax6i7zNo
	nLbdtR8Ve/QDCPsVvRWVQ+6Wq1+9cIcgs0Eax7Vo3O7TH4/RdUtbE7zUvvMQ3Lrmoww=
X-Gm-Gg: ASbGncvrh426iVqD0Tw7Zc3zTNZ5BELSKxXR+87keF5CVlDqNfWn2z9fPqm2SYxVDq5
	IZBhrZ9i+WFdncP6zR9wnL9FWM8COmQBnX4eFfd+oFHo8dEQvert+yZf5agjGSnjmwp0Cdg/2SA
	uR/SzPLyx8W2/uUpKaBxeBPqv7lF2Vc8C4E+JpYQ+JZdebVPUPSVrFOx01wcupEecY/2fOOIsY8
	wWFwdOegj2nNe34xsWApBBCht2tidkckadT7neQgwaJlBb/HEpWSpvf3se9gVVHtXN7k+S/Fs6q
	+X0zoNYdHgcVaYDh8Ktr3m9O07mbY6vZC/Z7gj9QbVuPkMjY+AFkU63vu79uTvl+ytVlMl+2OTg
	2SD4ET1Ru7OK0KvQ6rSbePUvcfFn+BB4D
X-Google-Smtp-Source: AGHT+IGIX5w14miEveZpwRaz+qEMxxSq+qAWW1H+PTbm9ok6gDczq0hGu6EbnXSMSPUh0wki0hGG/w==
X-Received: by 2002:a17:907:1c15:b0:ae0:da2d:1a53 with SMTP id a640c23a62f3a-af2f8d4d327mr227744266b.42.1753266350622;
        Wed, 23 Jul 2025 03:25:50 -0700 (PDT)
Received: from [10.0.5.28] (remote.cdn77.com. [95.168.203.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7dcf71sm1029261366b.64.2025.07.23.03.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:25:50 -0700 (PDT)
Message-ID: <9bae0d3c-7900-474a-a0af-d2f90ec65012@sedlak.dev>
Date: Wed, 23 Jul 2025 12:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: sync: extend module documentation of aref
To: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Shankari Anand <shankari.ak0208@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722121441.224439-1-lossin@kernel.org>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <20250722121441.224439-1-lossin@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Benno,

On 7/22/25 2:14 PM, Benno Lossin wrote:
> Commit 07dad44aa9a9 ("rust: kernel: move ARef and AlwaysRefCounted to
> sync::aref") moved `ARef` and `AlwaysRefCounted` into their own module.
> In that process only a short, single line description of the module was
> added. Extend the description by explaining what is meant by "internal
> reference counting", the two items in the trait & the difference to
> `Arc`.
> 
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
>   rust/kernel/sync/aref.rs | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index dbd77bb68617..1c212238c0e5 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -1,6 +1,21 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
>   //! Internal reference counting support.
> +//!
> +//! Many C types already have their own reference counting mechanism (e.g. by storing a
> +//! `refcount_t`). This module provides support for directly using their internal reference count
> +//! from Rust; instead of making users have to use an additional Rust-reference count in the form of
> +//! [`Arc`].
> +//!
> +//! The smart pointer [`ARef<T>`] acts similarly to [`Arc<T>`] in that it holds a refcount on the
> +//! underlying object, but this refcount is internal to the object. It essentially is a Rust
> +//! implementation of the `get_` and `put_` pattern used in C for reference counting.
> +//!
> +//! To make use of [`ARef<MyType>`], `MyType` needs to implement [`AlwaysRefCounted`]. It is a trait
> +//! for accessing the internal reference count of an object of the `MyType` type.
> +//!
> +//! [`Arc`]: crate::sync::Arc
> +//! [`Arc<T>`]: crate::sync::Arc

It got me curios. Why is it required to declare the doc reference for 
Arc and Arc<T>, but not ARef<MyType> and ARef<T>?

Is it because ARef is in file scope but not the Arc?

If so, you could just add

	use crate::sync::Arc;

in the file imports and you wouldn't have to duplicate the

	//! [`Arc`]: crate::sync::Arc
	//! [`Arc<T>`]: crate::sync::Arc

And even cleanup it a bit by simplifying

	[`Arc`](crate::sync::Arc) to [`Arc`]

in the AlwaysRefCounted trait.

Thanks!
Daniel


