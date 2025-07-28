Return-Path: <linux-kernel+bounces-748191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3135BB13DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7C33AA528
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654F26FA60;
	Mon, 28 Jul 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaJ/hOkh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073F26E706;
	Mon, 28 Jul 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714418; cv=none; b=MHnBSQLDwVBA2Aj9XJHn8+LMYlb6UjSA6qilqbABSgBO4LZIwlqPZdzCi59oI4CjNJiwGNt4WTeGdDJ+DDJ928BLCNh809FoWsujf+ytr30+vlCUO3Vvd6LCLinbfFJLOru7ENOY5k03tddK1UxiLLnb+xIJGNUwiiRAcorEETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714418; c=relaxed/simple;
	bh=ALt65RHbI2Hs6Q+MnK2zsyqhPcAMV5hvtT3x/Gpto9Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b7EGPqlVxrTs2RlXYXaJ31uXvakR9oJXSLqtXMJk2SUe8JjNg4F7kZvVDVewc2UZfWRBZPKcS/GHwKmphuYt8hS0aWNaTL1HwAyMev+5wflFjzI6cF+D9z6hCNe1aQAHa+oMlaCGW/yzyRn1PDrOVGo5dz+e7VCoOChDfJ2G5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaJ/hOkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7DAC4CEE7;
	Mon, 28 Jul 2025 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714416;
	bh=ALt65RHbI2Hs6Q+MnK2zsyqhPcAMV5hvtT3x/Gpto9Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=LaJ/hOkhhPaIbzRIT/NAk9Msm7vKxIkk5giHK/RYmpaxfG58TzG0S8N8seqBHjH2e
	 mbKygf3GawaF6BJyQXydFhUsTjyDyD86OV+b3+YlEYHo5vWwevOakrCmZAt+XBQVXz
	 rA1fYNSTY9MKvrEXc0SZOw1Um1K3jo13bDkjb4r3WqUZelaBa95k7wHqZjioXtYzA2
	 MxGEiFd/J2BhjMD+CNceqZALJ/SXVf55e6ihtrdz0N2bggGIPgo9QGU5T6JN5tMIdq
	 l+/vCQ79tP8IQK94bCnyG9sVeHIXiPwnjvjsFQqNS9tQN4ZQyz66luAOBRaa7wFOkR
	 UpbAPMt256lbA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 16:53:31 +0200
Message-Id: <DBNRVIEXN4ZR.1VG0GDN6BDXE8@kernel.org>
Cc: "Christian S. Lima" <christiansantoslima21@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] rust: transmute: add `as_bytes_mut` method to
 `AsBytes` trait
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
X-Mailer: aerc 0.20.1
References: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
 <20250728-as_bytes-v4-2-b9156af37e33@nvidia.com>
In-Reply-To: <20250728-as_bytes-v4-2-b9156af37e33@nvidia.com>

On Mon Jul 28, 2025 at 2:47 PM CEST, Alexandre Courbot wrote:
> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index d541c9960904d8c7f755351f22d06e4e8dbd546a..000fda2a78f8e6e8378bbe93c=
ddd8a5008db20cc 100644
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
> @@ -56,6 +56,19 @@ fn as_bytes(&self) -> &[u8] {
>          // SAFETY: `data` is non-null and valid for reads over `len * si=
zeof::<u8>()` bytes.
>          unsafe { core::slice::from_raw_parts(data, len) }
>      }
> +
> +    /// Returns `self` as a mutable slice of bytes.
> +    fn as_bytes_mut(&mut self) -> &mut [u8]
> +    where
> +        Self: FromBytes,
> +    {
> +        let data =3D core::ptr::from_mut(self).cast::<u8>();

Also add a `CAST` comment above this line:

    // CAST: `Self` implements both `AsBytes` and `FromBytes` thus making `=
Self` bi-directionally
    // transmutable to `[u8; size_of_val(self)]`.

On that note, `FromBytes` probably entails `Sized`, or does someone have
a use-case in mind? (because then we could replace the
`size_of_val(self)` above with `size_of::<Self>()` which I think makes
it simpler to understand)

> +        let len =3D size_of_val(self);
> +
> +        // SAFETY: `data` is non-null and valid for read and writes over=
 `len * sizeof::<u8>()`

s/over/of/

> +        // bytes. Since `Self` implements `FromBytes` it can be represen=
ted by any value.

Don't need the second sentence due to the `CAST` comment above.

---
Cheers,
Benno

> +        unsafe { core::slice::from_raw_parts_mut(data, len) }
> +    }
>  }
> =20
>  macro_rules! impl_asbytes {


