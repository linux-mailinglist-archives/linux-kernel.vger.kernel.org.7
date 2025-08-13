Return-Path: <linux-kernel+bounces-766354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB020B2457C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192B5682106
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68CC2EFDA5;
	Wed, 13 Aug 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DK3Nh7KA"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB32BEC39
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077539; cv=none; b=DRRnl5RXaLm4Pfoz5XC0oVuI7cy9QMikQKDwaGgDJpKQhy/lRvp/bK3e5OECXJ8S8u3+W2Dr4cVG3XxH2Som+hQWrVjRBUU20Qpsguuckxz7h/OSo6J5DTbnDVX7/kgm36d5bBcjNsW8f5XbcbOGYdAJ51cKOxpOVB7I7GloD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077539; c=relaxed/simple;
	bh=7SU3+Vd7N+k54gBXVj+MIPuqRLDqlAJi49rkww+kS7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c45TU6LImueI2FvamTn8FX4A+68A++v1gm3u0301+sMaFWRg1NYA8T6BMZy+0JBLq9nELI9X5+HVfx7oyOsRPN1NS6MCn3LjRkgeGtkjPlz6pPQLQ14xr/mS6N7W7n6DtEGhLaz1JA1/3b+93J4U1OAQNt3CXI7kGnL704rEy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DK3Nh7KA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso38296685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755077536; x=1755682336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz1d7edJo/Q+HsJ1HH001Yh+poWlDoP3asDYz4tNc04=;
        b=DK3Nh7KAnj8xsfCvynps5h293HD8HFHkk7CogjtpuxUByHzUkTIisuSmUu+ownueie
         nqxF25qfOrXb9doir8fbiraCk1Tx96/7AfV92DXsJmYl7ejrK5QP3PMTy2Lx4zhh6Mf8
         lUnEdUV/Q6lxvtfPNV8kzB5PkhW/Bda97SXNmQbQjjJkKnd+Ma9PULrH5xS4KbcALsXE
         wCWBNsbazeoli2qwM4z8iqYJn8blyQGFNSNcW9F7kE+Q9WgYSwIjD00fTC4UqO7A9VET
         G08yJJPjkCff8OpD8r5UKGgMdlenvcjqWPCy2t0R9RVA367c3gzWhO6XEO70FeBjZT6m
         YpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755077536; x=1755682336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yz1d7edJo/Q+HsJ1HH001Yh+poWlDoP3asDYz4tNc04=;
        b=ZFAx02hdQFAKpQ7XCRjN0kESmgkuCpKoT0vMBuvx5NuQJqag2iJncDlVJBefRVmf8U
         ay0fxCwruOy1UEr24JG/DXN8O+A8BkvjZoWY4DyC/Cx2Nes9l+tpgmXkpALhEKtTl+AF
         KRkj0azGSnGMYKPvjtv74rVWRHtXfnsfFsLw2fKoKt9GJAVEotVXPh9lTy1oHw1U6TLV
         i1tsMNC2UgeaecIOfSnycXeF3z0QIGjtSLeNx7MNULWcSK7Hjmrz9o+1T6/0WRsyv4iN
         otOucPm/Je27jy2Zqr1Jtsd0Lkes6K4caPArA2ZB2TagVczGy17ExS8zsZV9g+lb6303
         QFdw==
X-Forwarded-Encrypted: i=1; AJvYcCVRkvw3RBL4ZZWjxDukejYhT6Jrc4OBIkLSznoX0zOjlxUrLYq5YJRaAXk9BK2kgIP0rw7GZZZIsqlxyOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qJ9vpokjiJ7ok+H1JV5X2XUY/zv89Tt+e8oezPfxULj2wqXf
	u4QrwWkhIj6LNrZ9PbnIFbpph/WjUW7HdSAn4zw+MXH0AgdVmnirQ8dpI9VASgMiqcu/vdI4Q2O
	SU4ymEGg+zdCCbfT7baBPOoLZgQ7bnbe1FmcVnLca
X-Gm-Gg: ASbGncsNExXne2af2I5fhXpylW8emgw6l9gfyrwhQ3jr3NCcQ/ipUnNcDDBRSXgYweY
	9f5frSr6fRtKCrQjOUANqHg7CcVJtxlh8fcaFNE6zymlRZGsXS1ps2WfQ5k2pBX7GS6WroQkGsI
	W8aiROr2uAsHD31V5mgQO4o3awDOUe2XYEFGyUDWNr31OQseZCMr9DcxMpRKulu135n9JmLVoTj
	5X0d0NL17r6CCcu1hS8+QtBPc+VNNh91sZePN7T3TplzE0G
X-Google-Smtp-Source: AGHT+IFj4eeSkV4YCEm6XMyz0NGDwY1SK1orCsey4/K9VCwcmampRVZs860kHi+1N8EEFxllSFaXv3TdJ9X2E2BozSk=
X-Received: by 2002:a05:600c:3507:b0:458:affe:a5c1 with SMTP id
 5b1f17b1804b1-45a165a2d68mr19346975e9.5.1755077535541; Wed, 13 Aug 2025
 02:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
 <20250811-align-min-allocator-v2-1-3386cc94f4fc@google.com>
 <DC0N2SBVHIS7.2P91EJSTIT1FM@kernel.org> <aJxESG0l4-kyUHXg@google.com> <DC16OLU29VX3.16T0QDJF7Q18P@kernel.org>
In-Reply-To: <DC16OLU29VX3.16T0QDJF7Q18P@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Aug 2025 11:32:03 +0200
X-Gm-Features: Ac12FXzv1OKpnnMnkVcOWodh0QqpLsx6V00O4CPKH5Fp0qCDXM23kP48mbFno2o
Message-ID: <CAH5fLgj0kjGBwZFHjErsa7MCV1fz4xTWwrZAcFzHHnkbvS=OMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: alloc: specify the minimum alignment of each allocator
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Tamir Duberstein <tamird@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:14=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Wed Aug 13, 2025 at 9:52 AM CEST, Alice Ryhl wrote:
> > On Tue, Aug 12, 2025 at 07:52:35PM +0200, Danilo Krummrich wrote:
> >> On Mon Aug 11, 2025 at 2:31 PM CEST, Alice Ryhl wrote:
> >> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allo=
cator.rs
> >> > index aa2dfa9dca4c309e5a9eafc7da6a8a9bd7b54b11..25fc9f9ae3b4e471a08d=
77130b374bd1397f7384 100644
> >> > --- a/rust/kernel/alloc/allocator.rs
> >> > +++ b/rust/kernel/alloc/allocator.rs
> >> > @@ -17,6 +17,8 @@
> >> >  use crate::bindings;
> >> >  use crate::pr_warn;
> >> >
> >> > +const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINAL=
IGN as usize;
> >>
> >> I think this needs the following diff:
> >>
> >> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_=
helper.h
> >> index 84d60635e8a9..4ad9add117ea 100644
> >> --- a/rust/bindings/bindings_helper.h
> >> +++ b/rust/bindings/bindings_helper.h
> >> @@ -84,6 +84,7 @@
> >>
> >>  /* `bindgen` gets confused at certain things. */
> >>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINAL=
IGN;
> >> +const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN =3D ARCH_KMALLOC=
_MINALIGN;
> >>  const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
> >>  const gfp_t RUST_CONST_HELPER_GFP_ATOMIC =3D GFP_ATOMIC;
> >>  const gfp_t RUST_CONST_HELPER_GFP_KERNEL =3D GFP_KERNEL;
> >> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/alloca=
tor.rs
> >> index 25fc9f9ae3b4..5003907f0240 100644
> >> --- a/rust/kernel/alloc/allocator.rs
> >> +++ b/rust/kernel/alloc/allocator.rs
> >> @@ -17,7 +17,7 @@
> >>  use crate::bindings;
> >>  use crate::pr_warn;
> >>
> >> -const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALIG=
N as usize;
> >> +const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALIG=
N;
> >>
> >>  /// The contiguous kernel allocator.
> >>  ///
> >>
> >>
> >> No need to resend I can fix it up when applying the patch.
> >
> > Hmm. Maybe that depends on the configuration? The constant was generate=
d
> > for me. Either way, happy with the suggested change.
>
> That is a bit odd, I'd like to understand this before merging.
>
> All of the definitions in the kernel are defines that shouldn't be picked=
 up by
> bindgen.

It is possible for bindgen to pick up a #define in some cases. The
main case where bindgen fails is when the macro is defined in terms of
a function-like macro. This is why we see so many failures with _IO*
macros.

>  Are you sure you do not have additional local changes?

Yes.

Alice

