Return-Path: <linux-kernel+bounces-893341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF276C471DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF4C3BA261
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9731282E;
	Mon, 10 Nov 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0y28qIWe"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F830F7F7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783990; cv=none; b=toBvPPCU6utP7CtAATH693walplFH88+W/jrBFx4nIWdEDXg3ciFvjLMfG1MZXMfBKxfFfA01NNOpzn+DPIFiWu8k3//NcPLXb7VfRQnq8XRTFBbHjPkE8FUrQLXSIAcbDAHYMK/ydZc09Zt9sd2CnXU+9VVzSmPv6KmcdqBX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783990; c=relaxed/simple;
	bh=gydaMykgl28bOlVrMMqlUHuRkgVIgUMmfBcimtoFJ+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/k1/qAm3OKWr0OgWqRwCaonX6IBoUm1XXuguGeLjCG0z6Pz+opIGFjK8xhhcB6D9W5ZuIPhIhy9j4HHP5FU94vHGS85U3I5Rot+mmfqIRx59XZKr4f8SRsRwAvuVE/wd3JaE0U1nXWxl8dbpTlgVTZ/G148CRWWsL9dOoExgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0y28qIWe; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-656b7f02b56so1522559eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762783987; x=1763388787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9Tz3xZNmCEgsWElQVOlO7V5YKmuSlEmAD6OBg5hRHY=;
        b=0y28qIWenb07DK8F7cTL+XuZlyuwIC7YAwzvMtKuAQxwxHFht7eN2cmybfU8b/ygC0
         avRgNfzEH+LqPSr1DumnSP46hbMHvjfrY4I9qjZAFVoUiYhuUDNUs0KK0aelAxMJt86L
         wLU/msQrUwS7/FuZZdt7t+N3Q/81sYCCB07e+NT6YFCA4TNVYUrdJJwA99sgOjFy0IvQ
         fHdpHBlDjJQI6ClCp2qO+VATbcPj/SvpF7Qy9bbtXcc5FKSw9s+NRkj2vTGkEj079MWz
         ZxpV2aVlWvsLze/ncejSSp91VhkPUc7jjAJGzs/OR4ek4EYAd4C0MGUXAr0cNGPdbxeP
         n4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762783987; x=1763388787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9Tz3xZNmCEgsWElQVOlO7V5YKmuSlEmAD6OBg5hRHY=;
        b=gUwvubRZvBDrX+EeU40AH5ShzRfk8okC5TM1WOftYsIp9+x7el/j4Bs7qePpC7HPoo
         DKvtSkoTrl1RCoGKWnYkqyBOIjLJGcAAiQVactHBGdz6UW+UlBGAm2R0tPr6db19Uf8m
         325GDag18t+d0hgc/F5Uft2rAd93Ni3k3P+uKRWvRhWEBJQyNOPOjh0/Qia9UOYlIOaQ
         QZPqDHkfKf7Hs+eF5uUrm/o+OCIKJ1B96NbYthBv814sU8c88P5QirBSIzsvQm4wR7ui
         p4HjAXjQTmsLfQTpsRgfUZSHOmDestbWrMCPSBEb8f49WusBM4s+V/oi5/5rAXeOMw0O
         ZdUA==
X-Forwarded-Encrypted: i=1; AJvYcCUUhGyQ0ntj2ZPJ+kMHvGwgdugUg6rBBwznt4pHl/GAtk6DNSgl54U0O6RmDOcomAL66PtieSmLvp1aYtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeizgbsi/zaqPFJBe5WLaV7jgCSOGQ/tEUS+MXdwDQ1lweAHXt
	yCN+/wR1s73PJO3Ba6qWn6k/1lGS5krN+sIyFzSJ/SkA7QyLizmdbVTOYvNFxufCpjgugYwBBy1
	rrAipWpKrehj+Ltumr/JXjP52xza7416BMuHAFWSh
X-Gm-Gg: ASbGncvLjP2VIYbeRm7VtqYCmOJVmzJp735DWTmzwqHY+M+ExXlS1LgwAabb6MX59/B
	2XO6sTf1G5+QQ8uGNyrw+w5O0Qg336MwgzBsRLna06fE++W8NoZNss08CzGehrfM/rhARFtDXek
	nFw0Id7j0wFw6O8b49wWjBlJk9ghXrzqrPNQrlBnI8KPklSn8LJMwFBeFkd8B84SywsFs+4s4Zu
	rXoCV6IFdzb+VEYDWIPwLiLQH0dP5RwY6QgSaE1JIgZBerUb9JtXSGohqjyhrm92QvwpqAlL9cS
	j+kuoUryayWPVR6nDUquTar1l/aF4voCH7s=
X-Google-Smtp-Source: AGHT+IEpdIa3St3Z0x5kamBV9u2B/8FOyvzzuXASe9/+bPwRBN8Tm4KEv15823q8N8X/BmQ7Fb6+a8zOGoj2/yiGiCA=
X-Received: by 2002:a05:6808:1a13:b0:44f:6dc9:f84f with SMTP id
 5614622812f47-4502934182cmr4705881b6e.29.1762783986573; Mon, 10 Nov 2025
 06:13:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com> <20251110-binder-bitmap-v4-3-5ed8a7fab1b9@google.com>
In-Reply-To: <20251110-binder-bitmap-v4-3-5ed8a7fab1b9@google.com>
From: Burak Emir <bqe@google.com>
Date: Mon, 10 Nov 2025 15:12:54 +0100
X-Gm-Features: AWmQ_bl6OCmsZ676vGaSNKW5J1glpz42ajwZbct4pX_ztA8bfSLu6YX1DC3NV_c
Message-ID: <CACQBu=Vg1H1eF7AXyJmUWmNuqif+cw-6hzyk63y=LC_H9jmoxA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] rust: bitmap: rename IdPool::new to with_capacity
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 2:06=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> We want to change ::new() to take no parameters and produce a pool that
> is as large as possible while also being inline because that is the
> constructor that Rust Binder actually needs.
>
> However, to avoid complications in examples, we still need the current
> constructor. So rename it to with_capacity(), which is the idiomatic
> Rust name for this kind constructor.
>
Reviewed-by: Burak Emir <bqe@google.com>

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/id_pool.rs | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index a41a3404213ca92d53b14c80101afff6ac8c416e..5942f678db015e902fa482eb6=
4c38512a468e449 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -28,7 +28,7 @@
>  /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
>  /// use kernel::id_pool::IdPool;
>  ///
> -/// let mut pool =3D IdPool::new(64, GFP_KERNEL)?;
> +/// let mut pool =3D IdPool::with_capacity(64, GFP_KERNEL)?;
>  /// for i in 0..64 {
>  ///     assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
>  /// }
> @@ -95,14 +95,14 @@ pub fn realloc(&self, flags: Flags) -> Result<PoolRes=
izer, AllocError> {
>  }
>
>  impl IdPool {
> -    /// Constructs a new [`IdPool`].
> +    /// Constructs a new [`IdPool`] with space for a specific number of =
bits.
>      ///
> -    /// A capacity below [`BITS_PER_LONG`] is adjusted to
> -    /// [`BITS_PER_LONG`].
> +    /// A capacity below [`NO_ALLOC_MAX_LEN`] is adjusted to
> +    /// [`NO_ALLOC_MAX_LEN`].
>      ///
> -    /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
> +    /// [`NO_ALLOC_MAX_LEN`]: BitmapVec::NO_ALLOC_MAX_LEN
>      #[inline]
> -    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError>=
 {
> +    pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, A=
llocError> {
>          let num_ids =3D core::cmp::max(num_ids, BITS_PER_LONG);
>          let map =3D BitmapVec::new(num_ids, flags)?;
>          Ok(Self { map })
> @@ -126,7 +126,7 @@ pub fn capacity(&self) -> usize {
>      /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
>      /// use kernel::id_pool::{ReallocRequest, IdPool};
>      ///
> -    /// let mut pool =3D IdPool::new(1024, GFP_KERNEL)?;
> +    /// let mut pool =3D IdPool::with_capacity(1024, GFP_KERNEL)?;
>      /// let alloc_request =3D pool.shrink_request().ok_or(AllocError)?;
>      /// let resizer =3D alloc_request.realloc(GFP_KERNEL)?;
>      /// pool.shrink(resizer);
>
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>

