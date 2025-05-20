Return-Path: <linux-kernel+bounces-656438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5490ABE637
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 23:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC543BEE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEEF25E814;
	Tue, 20 May 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xo5GqoIT"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2648CFC
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777107; cv=none; b=Y7Nnrky2scK63j2xwhXupkzAAe92nLyAjRGFf3HkVqmvADBPEdYwBU10pdUoPxa/CcPMkztb09fq/9CvIF2JhHxnHxmXdLHeqtreuByYH/lKsAX3wc3QJgS+5NIc8xrqABBrp+7DsDddGIwR4REd0uv78qE16ANwb/VvpH/U3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777107; c=relaxed/simple;
	bh=ZABqbdKiWmmnzGlAZSWO0oIriHo8zTyTbXvHbhsuIds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhs4u9HPES+YQRzLzHk/BgjR9Bd5xiBNJT8sd+j0mECUTV+BX3wHqXVUpfpDXH+nqh0g2oF9I9ledpco/ScICHkoRWZZ1SDOggo9EuxXBojY2gOvU+S41lA2MRPXS3BeQUEtVjc221aH/RLMXwC3GTCkW6eu3pi4rAoORgR/5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xo5GqoIT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-442f5b3c710so49137135e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747777103; x=1748381903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/Sy6ZOk+qgtIvbSNAMb8vUpIImargweBidTSa6IbSY=;
        b=xo5GqoIT+ejoaljhthSCg2/4oWzBRTcs11gvpS8JSSVHFLdlKKmmcnEpGI2YZnpFnx
         J38/Ywhf4yc58jWAo4fHJ1ETThdSE1nPkX3SE9rH6nrKQEd+Ng/H3zS1ryWPmVnCflus
         vKq181NkeDLnlv1iHlUgk84GB96OpSYquLRyNbzPMdTRH19EcZS97Ksty9xB39XY62JR
         BBbVFvJM2pVfy8ol5N40NDAXRb1td5xf4ShqLl6H3Q+V6qWFuFOYArVEXXsFy93iRaGn
         TjhKF2qkh5k4R5O1mACNLb+J+x4A93AINW1jrieJdgyR/PYbZNiBIdfJXhXv5mRwC9o4
         QZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747777103; x=1748381903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/Sy6ZOk+qgtIvbSNAMb8vUpIImargweBidTSa6IbSY=;
        b=Oqn7rFkDGSGJW4PWUqJMGbVc71yxcsg8z4EMHVd/mEl9aM913069UAmu384VTXzpXt
         XQX8WMMqGJ2vHIL/Lj1hP3iZC5nhQMdtzjpBUa/sguLV7a/TTi3fDkOcL4xcKlbq04ZR
         h0aT5zL6mIvLl0/dD6wBEGoRrqbM3o5RNpwhPN3uKJVVzW5JTsNJsyzS4LiVtGCfUSx/
         uM466Y6S2svqQIaf4S/Jt6jF5N7lg9fV+uaz30oOEIxTiuavgeTjGTmhBcYrCvjk/JyJ
         pQHp87tx4dtnOaaNJWHGXHRAuOL1jUmjVgzH0hB4xMIug0OjpEB+m+YH4RbBJx1FxkZG
         Vo6A==
X-Forwarded-Encrypted: i=1; AJvYcCVdNmix8fav+w2Vd9KMXxRPgNGywxVXMoEyVXlvgyFgHmZaCM5JuxPYzFNhu78cjfvI5x7L0SYP4yyFq2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzogpX0mAXYBzVvF7o9S34jQ5h1si58CSBdTWW3ZcChgpK3T3N2
	CVCRUZgxCrcjVw0DWRIIjFeR6iLxO9IhvpGh4CEtfLJ8vQAAT1diwjl3j1rqS1eXqwv9lgoiVIc
	rWFHJC8yiKDTg8TDwAJA3CtrsO1vWA72HAurVL7+2
X-Gm-Gg: ASbGncvHrRZXPoxoHMwH7Cc4j1ZLztXtdc+g/JJIoimirJTf/fbGunUlqxi/l2kvGht
	wQFcQpMtscQ9ui8Tpw+3V0sLLMKcRnifajrs5pHz+snRd9A1SDE4jBHRxQXtWRQvqTEhkDdxPT8
	P+QKLbtT0Ptd/FvNShrSJGryINKqF6+qQcIkAYsNPA5kQQ8L3gZBrz6af8J8/Rc6+gCZwtBMJP
X-Google-Smtp-Source: AGHT+IErMGXfeKIjz7HBCzUAqwHrDroWqu3x8H2fU/cgs6C4aXU+99g3n4nmkNbfqvSk52OalYdiUl7YD88bwqzJO3c=
X-Received: by 2002:a5d:660e:0:b0:3a1:fcd6:1e6b with SMTP id
 ffacd0b85a97d-3a35c84bd41mr12599582f8f.57.1747777103266; Tue, 20 May 2025
 14:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520192307.259142-1-lossin@kernel.org> <20250520192307.259142-2-lossin@kernel.org>
In-Reply-To: <20250520192307.259142-2-lossin@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 20 May 2025 14:38:10 -0700
X-Gm-Features: AX0GCFsHbGr1aGiaMhkwHWMncUHV9az0-cq8JM42pX1WEqxipLmNJLPMgXLtHH0
Message-ID: <CAH5fLghdQEsBCfLVy2nUBvY6=5QTeaFyqtHHSjPDaX-1BKP=6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: derive `Zeroable` for all structs & unions
 generated by bindgen where possible
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:23=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>
> Using the `--with-derive-custom-{struct,union}` option of bindgen, add
> `#[derive(MaybeZeroable)]` to every struct & union. This makes those
> types implement `Zeroable` if all their fields implement it.

I think this is a great idea.

> Sadly bindgen doesn't add custom derives to the `__BindgenBitfieldUnit`
> struct. So manually implement `Zeroable` for that.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
>
> This came from a discussion at [1]. The relevant parts for pin-init
> already got merged into rust-next for v6.16, so we only need to enable
> them for bindgen.
>
> I'm not sure on the impact of build times and rust-analyzer. We're
> adding a derive macro to every struct and union emitted by bindgen.
> Building using my test-config took 28.6s before and 29.1s after this
> change, but those are only two runs.
>
> Maybe we have to reevaluate this when more C code is scanned by bindgen.
>
> [1]: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/top=
ic/Zeroable.20trait.20for.20C.20structs/with/509711564
>
> ---
>  rust/bindgen_parameters | 4 ++++
>  rust/bindings/lib.rs    | 9 +++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index 0f96af8b9a7f..fa4c61ba028f 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -34,3 +34,7 @@
>  # We use const helpers to aid bindgen, to avoid conflicts when constants=
 are
>  # recognized, block generation of the non-helper constants.
>  --blocklist-item ARCH_SLAB_MINALIGN
> +
> +# Structs should implement Zeroable when all of their fields do.
> +--with-derive-custom-struct .*=3Dpin_init::MaybeZeroable
> +--with-derive-custom-union .*=3Dpin_init::MaybeZeroable

Maybe add an import in bindings/lib.rs and use it directly? Seems a
bit nicer to read without the prefix.

> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index a08eb5518cac..38615c5b090d 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -33,6 +33,15 @@ mod bindings_raw {
>      type __kernel_ssize_t =3D isize;
>      type __kernel_ptrdiff_t =3D isize;
>
> +    // `bindgen` doesn't automatically do this, see
> +    // <https://github.com/rust-lang/rust-bindgen/issues/3196>
> +    //
> +    // SAFETY: `__BindgenBitfieldUnit<Storage>` is a newtype around `Sto=
rage`.
> +    unsafe impl<Storage> pin_init::Zeroable for __BindgenBitfieldUnit<St=
orage> where
> +        Storage: pin_init::Zeroable
> +    {
> +    }
> +
>      // Use glob import here to expose all helpers.
>      // Symbols defined within the module will take precedence to the glo=
b import.
>      pub use super::bindings_helper::*;
> --
> 2.49.0
>

