Return-Path: <linux-kernel+bounces-847190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAF4BCA360
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB1564EA7A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBEB225A5B;
	Thu,  9 Oct 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr9DVMtX"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1BD223DD4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028063; cv=none; b=s6vW1fyf3L9G48UJnHyjsRplRlzzgF0TjV92I3tn7Ne8uHMH5EGS1pbOjbNwS5gnkkGqX7wIWaCpCqgChuQthxb/zpZzGiLmqSYbB1fS3qb4521LOLcXMoYdf1SolDYYMfXawXkpvB5fFQg7U01Wd+peQMMxM0xBvLeGep/KWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028063; c=relaxed/simple;
	bh=N0XZnJZoSG+AyMpHWEeT3UptHpjumJYot0RUpOXd7Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXLs3Gb8A1jaBAImTBspve+JQmuEljLApS5PJC9jEa02R4GlGgKogykFP7pb9LzDRHBn/5tPFKTCV45AiArPrZlun2KgR6HIiXgu6WayXWjHdJr5kwSx4MWTbEvIsk3yva5wooRQjjA+PUaZ9xg2f3Dt5KKMqXvhr0dvvaTpgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr9DVMtX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d6051afbfso12644157b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760028060; x=1760632860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEYS4ZG7BzvAgxNTt2hNL73MyYfFtHwZYP++pTe5XoE=;
        b=Qr9DVMtXkfGidX9j0CsQuskN5P08J+XcXoUysoilq0WJ7TNgTLfqiimPNI2eMfL/V7
         W0EdgdD3zUZKPk/cB3z8YqPbpfMjZvnTChpET7UALUoggFggeP0qWrP+fNyq8cH0edop
         6fYMmoF9Te+YbSNia+C0XuzuG6n7KF4t2ZdZWkCGaxzGi79RB9cZsHVx5Soer4xoDZ9X
         VHzee/tPF+klhuRdBoWZ9CxDbcb0V+TwOldFYkJT/49BO6i1gaCp3mWN2yCrBcdUmKmf
         x63MxeMdO8PHT/T3QIGrhSazGQ2DZh3Td4gjUd592A3smI5fAhszJEshpgwcSDnfkNA2
         WPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028060; x=1760632860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEYS4ZG7BzvAgxNTt2hNL73MyYfFtHwZYP++pTe5XoE=;
        b=GQT72YjxopOVNgVzNoNFP8N4PZg3+Kg2wv6dLz0bz2jlK7sonRdfet+HbC99HPF7l4
         9c0RdX11qbvZkYxZhzPeC2j5upquULigNgUfAdILjCsuUmFdkfW4dHyrxMsH20kk/L2B
         QXm9kMXL90JAcF97IVIfMQly8GBM9WgZPnUpume4OcyR7/zXpBGkPw5RFxBgs/gCG00d
         sv7c82fvuUa9XxBuIiCXYSIVJysWaqNcBRB0fADM8Q3u1VPAs756c7y7/LU+3W0whFe1
         lkxB9CKCSk+8Db9KLkf4COTsOwMkr/sj8qJPnp2g63QUG1uQ+9LPCEbcyYpHiDb3wWIS
         ijDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVctG5MbNZMSslleQpOWqtUZepCodfSafbg/Q2rr/uMKXcZV6y9BW75ruwin2Ec0cWZE/WNqyer3et3Yng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jiWKncFyKz7TXDBjj/USgwHSeGLLspdF+qT7P4yHJN+SxWaH
	5lAndFsA5jtxdoHvsY3C9GV0pqTRGkq3oLSoPUam6rd6BQtYFUcqwUsE
X-Gm-Gg: ASbGncvps6cKqt1/qzCUL5cjGjeUfTP1jW8xJTpVokv7x+det157nUkQtjgR6hWwTLZ
	VtjD+Ps0aaSfjFOkjsl9LixL0jF2gv61LibqDjtoritlr4VhXJFP+fIZavyCFcI4cxRQx26crBt
	OJIAp8CGW6kkkeYsmba5lOQAc72sX3frGx0qdcEaXkkpuGxQYVh/nc+0c+ARX+FFB6j6pKYa/Qa
	H3/4NVM76zRmz3JpnX4Ryi4WPdBgKLIpERsFtM8bAedoXIC4PVfs7oZAPVp1fe7ygPCXnlZDoW6
	MBtVJokDg7eF4WD5JNFCfAQXVc6Lw/KmgsNeE57jWw2poi6iaCSplhVQSK/3GOJLNRlCQ3i3zM5
	GttQPJ+dR0LiDWWazAs3LB97mR+5BId8D9+yOnz4c+zyVso1uS+BJE+yRMHtaoHs0rqxWmo1JOE
	MMCtg=
X-Google-Smtp-Source: AGHT+IE4I8ejY06OQV5+iuuha8UY69T0yHmq+uCkeg2u0Wguug06p8yYPejnOQd8b6WXnlG7VNxZFg==
X-Received: by 2002:a05:690c:4d43:b0:76c:e8b7:a625 with SMTP id 00721157ae682-780e1476fbdmr110455167b3.21.1760028059826;
        Thu, 09 Oct 2025 09:40:59 -0700 (PDT)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81e4d6dbsm74906357b3.59.2025.10.09.09.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:40:59 -0700 (PDT)
Date: Thu, 9 Oct 2025 12:40:58 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Jesung Yang <y.j3ms.n@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feong@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/3] gpu: nova-core: use BoundedInt
Message-ID: <aOflmmHe8O6Nx9Hp@yury>
References: <20251009-bounded_ints-v2-0-ff3d7fee3ffd@nvidia.com>
 <20251009-bounded_ints-v2-3-ff3d7fee3ffd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-bounded_ints-v2-3-ff3d7fee3ffd@nvidia.com>

Hi Alexandre,

On Thu, Oct 09, 2025 at 09:37:10PM +0900, Alexandre Courbot wrote:
> Use BoundedInt with the register!() macro and adapt the nova-core code
> accordingly. This makes it impossible to trim values when setting a
> register field, because either the value of the field has been inferred
> at compile-time to fit within the bounds of the field, or the user has
> been forced to check at runtime that it does indeed fit.

In C23 we've got _BitInt(), which works like:

        unsigned _BitInt(2) a = 5; // compile-time error

Can you consider a similar name and syntax in rust?

> The use of BoundedInt actually simplifies register fields definitions,
> as they don't need an intermediate storage type (the "as ..." part of
> fields definitions). Instead, the internal storage type for each field
> is now the bounded integer of its width in bits, which can optionally be
> converted to another type that implements `From`` or `TryFrom`` for that
> bounded integer type.
> 
> This means that something like
> 
>   register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
>       3:3     status_valid as bool,
>       31:8    addr as u32,
>   });
> 
> Now becomes
> 
>   register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
>       3:3     status_valid => bool,
>       31:8    addr,
>   });

That looks nicer, really. But now that you don't make user to provide
a representation type, how would one distinguish signed and unsigned
fields? Assuming that BoundedInt is intended to become a generic type,
people may want to use it as a storage for counters and other
non-bitfield type of things. Maybe:

   register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
       s 3:0     cnt,
         7:4     flags, // implies unsigned - ?
       u 31:8    addr,
   });
 
> (here `status_valid` is infallibly converted to a bool for convenience
> and to remain compatible with the previous semantics)
> 
> The field setter/getters are also simplified. If a field has no target
> type, then its setter expects any type that implements `Into` to the
> field's bounded integer type. Due to the many `From` implementations for
> primitive types, this means that most calls can be left unchanged. If
> the caller passes a value that is potentially larger than the field's
> capacity, it must use the `try_` variant of the setter, which returns an
> error if the value cannot be converted at runtime.
> 
> For fields that use `=>` to convert to another type, both setter and
> getter are always infallible.
> 
> For fields that use `?=>` to fallibly convert to another type, only the
> getter needs to be fallible as the setter always provide valid values by
> design.

Can you share a couple examples? Not sure I understand this part,
especially how setters may not be fallible, and getters may fail.
 
> Outside of the register macro, the biggest changes occur in `falcon.rs`,
> which defines many enums for fields - their conversion implementations
> need to be changed from the original primitive type of the field to the
> new corresponding bounded int type. Hopefully the TryFrom/Into derive
> macros [1] can take care of implementing these, but it will need to be
> adapted to support bounded integers... :/
> 
> But overall, I am rather happy at how simple it was to convert the whole
> of nova-core to this.
> 
> Note: This RFC uses nova-core's register!() macro for practical
> purposes, but the hope is to move this patch on top of the bitfield
> macro after it is split out [2].
> 
> [1] https://lore.kernel.org/rust-for-linux/cover.1755235180.git.y.j3ms.n@gmail.com/
> [2] https://lore.kernel.org/rust-for-linux/20251003154748.1687160-1-joelagnelf@nvidia.com/
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

...

>          regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
> -            .set_base((dma_start >> 40) as u16)
> +            .try_set_base(dma_start >> 40)?
>              .write(bar, &E::ID);

Does it mean that something like the following syntax is possible?

        regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
            .try_set_base1(base1 >> 40)?        // fail here
            .try_set_base2(base2 >> 40)?        // skip
            .write(bar, &E::ID) else { pr_err!(); return -EINVAL };

This is my main concern: Rust is advertised a as runtime-safe language
(at lease safer than C), but current design isn't safe against one of
the most common errors: type overflow.

If your syntax above allows to handle errors in .try_set() path this way
or another, I think the rest is manageable. 

As a side note: it's a huge pain in C to grep for functions that
defined by using a macro. Here you do a similar thing. One can't
easily grep the 'try_set_base' implementation, and would have to
make a not so pleasant detour to the low-level internals. Maybe
switch it to:
        
        regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
            .try_set(base, dma_start >> 40)?
            .write(bar, &E::ID);

Thanks,
Yury

