Return-Path: <linux-kernel+bounces-682370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868BCAD5F21
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 21:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DD3189CCC9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 19:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F55622069F;
	Wed, 11 Jun 2025 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRtR+Fe3"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534C21CA14
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670604; cv=none; b=NUNFJoqe0gNnZHTkW/iz102tTtINGLXtlzDAz9gonbAWjSZiasm8lmmlO5j1/OO5qx2k1KmnPzouFxa055382BWjWWDRMTNLAcYzXEGbSXbIK7PqvAJ+WM0wkmlUaydu8ReSL7cHzAIkpAj9ekKJwPTPZ9IROa8O7bl72wXp2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670604; c=relaxed/simple;
	bh=FRd5Pca7J/f+Rrh/WDUQUYH4N+OoqdWEDRYIieG9g68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpML9bwgIt3aUku2iyOMR6QJvAT5vI+GmoMoNMsJDC2AF51afV3YFsp5F4v2pNh8RfnLschXM2YmpPBOzyBJUWl0+8pP8picScqV3zdngGPDtrm9pkqlgdp+O+UYTfurXKFQqD0vgkz9X8n8UGfJfP6+r3LNXy9rk3ls4PfQW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRtR+Fe3; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2da73158006so115676fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749670602; x=1750275402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRd5Pca7J/f+Rrh/WDUQUYH4N+OoqdWEDRYIieG9g68=;
        b=ZRtR+Fe3HGuSlgGH3VtaS0jW/rbxnNvNLADsIE+zLfegoHWEeWNzu5rsYk6AXahF6K
         w15Z5kQ0Y/zsWKpsZEPGrhpaA9pn8E4onu/zGzCqrWcfZT4iKjdKqwAeZKqiW5Mq3g+J
         TuEDpW3Ur8y+6HKULNvWz86R61qY1IqMwF45vh0eS3oyOG6fFFkKHY+lgHYZoCjudPJV
         v9oRTUgZ11zn6hmXiKU1oOBsr90CkN8A5z3wUvOqp+pD4y4cpNXMDQq8GfmQmHoFm5el
         gWeUfOIOmeDC2LWYfYBWxGMgfhN4hFm2YE8PYUCL0CHSy5AgLJAp3EUC81BJQ3vN5eZz
         B9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749670602; x=1750275402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRd5Pca7J/f+Rrh/WDUQUYH4N+OoqdWEDRYIieG9g68=;
        b=POpxlILWieknwaBJt/cb6abi02wZpWyCLy38iwR9Tx9b09daJi/t2vpBAnu1IQHByl
         tPu6BK0Nxs98hq85Oow0GblBdGdF8Nm0mXmJw8iXoZCOgAd1GvWJkm/4zE/+TyfaHPrU
         ZSKgfH+eSSrJuW1qAAy5F1+wG2kQ+COHD0lzv0hec6bEbxdic6tjkoX+1cOPhuftcplK
         XEyEIEZcYm0MA69bNSgWjCfIATE6XNm81YybXSNMz4Obg3UW+wH3NI6NnXsPiCX/wtQn
         g/wH4aKZTDoI4H0l89oq5eB3UgxptrPomY0EchbD651eMbbuSUZWDg7oFz3YTJicA3Zt
         6vTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjt527M4tefh0XAF3hlsbtnp1kS+v8BCsyVAaEsfVWSbZ65UrputK8+ZonOI/iJ7FLOiiVIVEiDY9uBsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEV/tkrj23DuHC6E2YCmEpuSVax6E91tyJiEDRGu4UHwt6G93E
	eNOmA3y6XjY19WPbQbbQqD5IWBE+uStHTgWHY1YmNDbFjQVrkbmX4hAxxfp4S7D0CD9rinvrTlg
	AI+WPv+q/do3xeLuKySBaaH5MBeGYOsvWVJphhXwW
X-Gm-Gg: ASbGnctD7Pn1+bSF8/eRuLzt89QiIEzHIBxSkf92tU4ANasUfA6kUW+aimrJGfCFfBe
	mis+uPUaNCmNA1PN3Q2CzfLi0fSBP5mI3tNTwwOzxWVIrpGovY3eCfI9CTFq5pKNdiRmBDlYCmy
	TEU3wEl8psfR74RTVw7LG/nD8G/FzXKPkuD6FQMZyPO6tKNig3X//xQUqgTuyeCHj9vOtiJ1aoe
	w==
X-Google-Smtp-Source: AGHT+IHhX/J0KgTBqTFodOiUoIOZLLvskczxvrkU8jA+rrpxEq+8GIz7VrHt1fqC3oToKkknmx1PVZC1oRVO50e0z3g=
X-Received: by 2002:a05:6871:2b0c:b0:2cc:3523:9cd5 with SMTP id
 586e51a60fabf-2eab6fa5f8amr84101fac.17.1749670602224; Wed, 11 Jun 2025
 12:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602133653.1606388-1-bqe@google.com> <20250602133653.1606388-5-bqe@google.com>
 <aD2118mMOs8CZyGa@yury> <CANiq72k7wnHsd6jrckkZtRpwbTPE+5ikbCw=_RexuRvwBSp-Rg@mail.gmail.com>
In-Reply-To: <CANiq72k7wnHsd6jrckkZtRpwbTPE+5ikbCw=_RexuRvwBSp-Rg@mail.gmail.com>
From: Burak Emir <bqe@google.com>
Date: Wed, 11 Jun 2025 21:36:30 +0200
X-Gm-Features: AX0GCFuGeRjnvrLzoxm0k2luQ-ZeSCWV_imHjgZMV5WADOuB2TB360to4jKqdKA
Message-ID: <CACQBu=X69A+XxMd5iqT3DgYpQ4Xx_z3GVouuyd3atUiKZKkw2g@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] rust: add find_bit_benchmark_rust module.
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks all for the review & comments.

On Mon, Jun 2, 2025 at 4:44=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jun 2, 2025 at 4:32=E2=80=AFPM Yury Norov <yury.norov@gmail.com> =
wrote:
> >
> > > +const BITMAP_LEN: usize =3D 4096 * 8 * 10;
> > > +// Reciprocal of the fraction of bits that are set in sparse bitmap.
> > > +const SPARSENESS: usize =3D 500;
> >
> > Is there any simple mechanism to keep C and rust sizes synced? (If no,
> > not a big deal to redefine them.)
>
> One may pick them from C (possibly with a `RUST_HELPER_*` if needed).
> If they are non-trivial macros, then using an `enum` instead of a
> `#define` on the C side is also an alternative.

I'd prefer not to move these to a header file and define RUST_HELPER and su=
ch.
I'd prefer if test & benchmark code was somewhat contained (although I
agree it would be nice to keep the two definitions in sync).

> > What is the name policy for rust? Maybe a more human-readable name
> > would work better here?
>
> Up to the maintainers, and generally the same as for C. In the global
> Rust samples and things like that we have `rust` in the name since
> they are Rust samples after all, but there is no need to say `rust` or
> `module` in actual modules etc. unless there is a reason for it.
>
> I hope that helps!

I renamed the module struct to `Benchmark` now and made the "name" the
same as the file name.
So the _rust suffix is there because the rust file really corresponds
to the C file.
In this particular case, I think it does help to see how it relates to
the C file.

Cheers,
- Burak

