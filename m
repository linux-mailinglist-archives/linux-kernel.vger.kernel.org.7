Return-Path: <linux-kernel+bounces-854295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E409BDE042
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923CC19C3CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB31531D759;
	Wed, 15 Oct 2025 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYtwL/TV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74F3074A2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524329; cv=none; b=Y6dDaKwZLvfmLRQ3oZBCYoD9US2LmpKCu10VQinQuRsezDVPtr0g/Oe8udxhO1cLF6HRo8r0dTl7gHpdrwK+Tl/3duAzwI/VsEIXy7U/Rk8f8f2gxfA/jgYrHELyxHM60U/8U4eRc97TSW5En/+GBBA9rWAqpiaPJ7gy8o/oRHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524329; c=relaxed/simple;
	bh=XnVyysyLvP1k2Hag45q9Dzv50TEW/Txkjea2iOLo95Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/rCNeuSqABDFgHJ9KLlFcMKL94iT+t3BM9jChOplSVmJiTQSEqZyzzoNI2N2guGt8QL2+203WIKcfYFtju2DrREdNegAn7ExWAAcIctsWnykyCYIuxmON1EG/H1e+ahZH8dJ3wa906kRepwzCq0i/zHsZgvJU+vHnYBQ77rKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYtwL/TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB22C19424
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760524328;
	bh=XnVyysyLvP1k2Hag45q9Dzv50TEW/Txkjea2iOLo95Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iYtwL/TVDy0Rt8BW4eYIJkeWkxsE6tN9UdHbo4XWzOIJfn7qlnDcPsuB9grO5h2zP
	 XgE9oByHqWkceakqlv0Eq9J2IPV1Tn6DPDMuxDn6LBWutVbD8s9L+fV9hcg6GlV5le
	 ulSOANxTNGkZG4i7mNynvxFe8znEV7i9i68qICBi1cPARcSm/L7sYWxsSLtcY26gdH
	 PvGYQ0JJpLdJ0uGLwjMHbtzZpuLmYD1zquyUfkvlCulOTAn9T3O+6OyMk/059Ppj1g
	 tvHHlvabgZSTKtLDEzI2H4dZiNALyvXDPvcjzz7+rkoSzu2mKuW4lEnedCQom+BcW2
	 2DCpkW2J3hG7w==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so11165096a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:32:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4j9myVjDrMlrHzVqzI0WDyZuPdQKbhfKsX3gI0m6n6a9sS/12tpzNyw1xj8yi3GYy970Ch8Fp3bOSHdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0N8BxaJ3ysDgHRn8M08aD8c9QOo5w6jfeQoABqj2qdh48BKfb
	gOtBi0hlYayr8Cmj2/54s2zt2GjKTCXLBUIsxfL8S6xwLdyU/jI1QhwmczNIEo6y99JhxUGcNiC
	EDOpZaq6LTG4FakCH72xokaoL+Snjd1s=
X-Google-Smtp-Source: AGHT+IGoA/d5yhGrNUYlE45ck1RVZwOONyMj9xEP0O9ihtkTRuTRU0iB18owFQ5wHS2pOSIJrR8N9/DmGQJKXoFsmag=
X-Received: by 2002:a05:6402:254f:b0:637:e4d1:aeff with SMTP id
 4fb4d7f45d1cf-639d5c3ebc3mr28694096a12.19.1760524327124; Wed, 15 Oct 2025
 03:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015022037.14535-2-xry111@xry111.site> <CANiq72mvZy+X2ko_sxVCn-2cnsR29boAzPDrYn=S-Tp0xSvvHw@mail.gmail.com>
In-Reply-To: <CANiq72mvZy+X2ko_sxVCn-2cnsR29boAzPDrYn=S-Tp0xSvvHw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 15 Oct 2025 18:31:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H55FMdfPwXbJKT0UkmJ_6KT=o4FQwuWb3iJwYQwj13cBw@mail.gmail.com>
X-Gm-Features: AS18NWAnFzjUGbY0swZ8OT6uicP-yLzslkwfwIMvtdyG7-njmiNtH6w-d27pTVQ
Message-ID: <CAAhV-H55FMdfPwXbJKT0UkmJ_6KT=o4FQwuWb3iJwYQwj13cBw@mail.gmail.com>
Subject: Re: [PATCH] rust: Add -fno-isolate-erroneous-paths-dereference to bindgen_skip_c_flags
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, "open list:RUST" <rust-for-linux@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:20=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Oct 15, 2025 at 4:21=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >
> > It's used to work around an objtool issue since commit abb2a5572264
> > ("LoongArch: Add cflag -fno-isolate-erroneous-paths-dereference"), but
> > it's then passed to bindgen and cause an error because Clang does not
> > have this option.
> >
> > Fixes: abb2a5572264 ("LoongArch: Add cflag -fno-isolate-erroneous-paths=
-dereference")
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
>
> Seems OK -- if you are taking it through LoongArch:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
Queued, thanks.

Huacai
>
> Thanks!
>
> Cheers,
> Miguel

