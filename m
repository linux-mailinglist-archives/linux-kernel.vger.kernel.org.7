Return-Path: <linux-kernel+bounces-770954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8185B280E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0735B637C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD3301490;
	Fri, 15 Aug 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAcXOuqO"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836BC1B5EB5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265907; cv=none; b=lF+GGIbtPtGpnLL0723n24YtrK9x0dioVYCPW6k2U5Jv8M5Mp4gI9+yjds5XpFJd6sttEts2nuUE6o2P4w/IyVkKj/XK5lTZxoIUa1S7gVKW74+jdJQ1ni5h+ymcOk/MHG6m/Rbj4b0VWZGbHgcjmjv+4p7T7pNoTJb5iiONX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265907; c=relaxed/simple;
	bh=py+vR187Mqp8I13kFA3nYONIl/30zwbVxkeEOKXSt8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bm8iizgbeaGD2i0TdecWGXsBSc6SBemt7UYPWFruftVKEj3fKOynyj0u45kNCJfvSZAh4Gak6xAFQ0WPq5y9KPqBMDfp5qtDyfpgYa23lba0nfuqy9vlhFmBl5jUIcadwDONSL+Ef3A0UZDq+ickaBvGI8y/OfgE2442JA2nQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAcXOuqO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9edf0e4efso1184704f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755265904; x=1755870704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=093IlVQTdAFvs60Lglv1mh61RWoRsNADFmPT6VwOqcw=;
        b=HAcXOuqOXn9qZ8CdlcIxvcb6NrliQ29xlXjO7356A6nxuDw9zUAahslqc1yZIq+mHi
         S+r5yxS8rdY/B0fiRkBOcpYkIaRwT/R+Yyg1ZNg4YGAa+v5WLJh6+EXyl8X7UpwDw6SC
         Fv8O7WdHMjdvCTHrrN5FXXpnHSZrl56QHRtDvmC2iD5Sm8gPFLnhHjxHDli6oEBVmKBz
         WESG84K7LAsnDV3DAj4tF+Be6mdH3mwdOMamVP30t2rcUxpqiSdfsQ7sYBVCGxq9SJlu
         PWU/szR3SGiDiOZ/9kOw6Or3lsS6UP1+FIBPI/HBxFIW05KA2Q0ruJ4QiNtxS3Lfn4Yc
         kD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755265904; x=1755870704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=093IlVQTdAFvs60Lglv1mh61RWoRsNADFmPT6VwOqcw=;
        b=jE0FrBtpafBV0vZf5cY2OS0pCpjGZNm6Tkqu2veKwXfeMTRNzOGZYOja+TgatOItHj
         J+c4grY4mUDV9F9CTUinCvwldih+mTHSXkJpA0TQK1I5bnj4M4VtS+sHBKHE5QwJmC5Q
         9KRtyI5k6S1OMP+YF5wTwo2k0Toj7FxwHtWsDpkvpx+W58DtOvDsR7j2OJfpermoxRx7
         uNOYkhetSL+5PM1JaTZ1Ek/sUzPPvleI7j2uNujB71eeZb/wUlAPhbh1LHNewVRdIjrj
         4m/4dCyE8/LUkZGi5JnKtn9QeagUf2gJIw+s0XaZrFwueHVSAZMFs/37jT1KqzmJsy9Q
         op1g==
X-Forwarded-Encrypted: i=1; AJvYcCUEylvl0p9qMVFRqz/nywrjf/707HESx8mbldQjfFswF+SkIU/62GcPsuD2Ld5aodSHaVgybIqoe3ffwrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICuIkX46N7XxCyMpQiOWoekK1UC7/sqXuwLXsM2Qw9+1k3af/
	EdjjDw1r5pOo9Cp0j2W1mm+BfLwWqVyESDBdl1cEhVdk8QixSVgcpMJ6J1f6kDMkWi5o4wJWrx9
	UmMQ6HfXnM2gPWInepBlWeyGa03NWRNvVgsyxjgIE
X-Gm-Gg: ASbGnct02GaJ138n1K/HnRRlAZL5ET/FOZxmLkdawuHDEezO3X6rgAANP342KDdoSrh
	zFYpyEp1WPtfrWi45efOw/sRPI4hFHnrCb9VEI8KRqmTztsnVm+iUXG4lzxsWa8/2n3L8G9a890
	wahcuJUrAY+OmrN4tbA6uYcocOd1VFuWeMdQXs0Rg1cDCjfTcXqtzYGolwFLRDTBsuEsyQJ8sez
	0Y4QbsHAtZBa1BQwDmGkre/kxAJQf8r7C/tE33CtveEasCxdyzhS/w=
X-Google-Smtp-Source: AGHT+IFv6jZ3CYzc8+DB8tcb3iOZ0eSeAMRULpcmDGXTdj1HKyqd8QladLBnI4IfXS+FlzQLbMsVXltn+AO6gJPqM/U=
X-Received: by 2002:a05:6000:2481:b0:3b5:f93a:bcc with SMTP id
 ffacd0b85a97d-3bb68a17993mr1756183f8f.35.1755265903498; Fri, 15 Aug 2025
 06:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716091158.812860-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250716091158.812860-1-shankari.ak0208@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 15 Aug 2025 15:51:31 +0200
X-Gm-Features: Ac12FXzFwpjZfyVT_iQ3XLEvKiGOnwXqbtcp9YGn_MuwLv_LAEO4d7-XhWxUDaA
Message-ID: <CAH5fLgiUfZG4e0k6ajkkKo+iaidWHu4dTRfBbgm4Y_CQPGLHpg@mail.gmail.com>
Subject: Re: [PATCH 3/7] rust: mm: update ARef and AlwaysRefCounted imports
 from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 11:16=E2=80=AFAM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Update call sites in the mm subsystem to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Andrew, would you be able to pick up this patch? Thanks!

Acked-by: Alice Ryhl <aliceryhl@google.com>

> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbgN4i=
=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintena=
nce.
>
> The original moving patch is here:
> https://lore.kernel.org/rust-for-linux/20250625111133.698481-1-shankari.a=
k0208@gmail.com/
>
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  rust/kernel/mm.rs             | 3 ++-
>  rust/kernel/mm/mmput_async.rs | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 43f525c0d16c..4764d7b68f2a 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -13,7 +13,8 @@
>
>  use crate::{
>      bindings,
> -    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> +    sync::aref::{ARef, AlwaysRefCounted},
> +    types::{NotThreadSafe, Opaque},
>  };
>  use core::{ops::Deref, ptr::NonNull};
>
> diff --git a/rust/kernel/mm/mmput_async.rs b/rust/kernel/mm/mmput_async.r=
s
> index 9289e05f7a67..b8d2f051225c 100644
> --- a/rust/kernel/mm/mmput_async.rs
> +++ b/rust/kernel/mm/mmput_async.rs
> @@ -10,7 +10,7 @@
>  use crate::{
>      bindings,
>      mm::MmWithUser,
> -    types::{ARef, AlwaysRefCounted},
> +    sync::aref::{ARef, AlwaysRefCounted},
>  };
>  use core::{ops::Deref, ptr::NonNull};
>
> --
> 2.34.1
>

