Return-Path: <linux-kernel+bounces-774338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC492B2B13C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760706E0087
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08053451B7;
	Mon, 18 Aug 2025 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEBxBH46"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7BE3451A8;
	Mon, 18 Aug 2025 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543911; cv=none; b=P4lQCnoLV8v8+l150VIvDOGBIvig0cJyIeWFbyJI4i1GfRW4cAomwkXJgAMiFqRWEI6f3xNDyjTAYIUNQpG6XqqIez7umSjlSTV1YIXUqNKkMK1MFqcagXv06bG8S/iMmXkEvexaNPqUWYEfSWWvZhbKs61pqu6gmMHxD1rpiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543911; c=relaxed/simple;
	bh=GLzow7wb+XyLfKsy7X7VL2nIDWXr/yQ6AQZ85/hAmfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw48/gwVGre/Cqk3oBO4vL0zj6Lj2qPaAr5QEYRAiF1uBxWZbjFXPMezYA2R5eJXd+WNaO2HdaCAns7YReGusZSEfabs2xFoiU8TOsFDSwLZ4Kf3tJJBYptIxr6e7K8Lp/wjLlWM1xiX/T+D4A7bR8dDI3WV3l4YMc0fv4xySZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEBxBH46; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-50f85fc0b50so67066137.0;
        Mon, 18 Aug 2025 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755543908; x=1756148708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq6Zp3+Y18V6Wd6MTldZy3jkN51lHJSQ9xa9eV2y3so=;
        b=gEBxBH46tB6U1SB3n/FES7qn196Yt5/rAeTMVGotwxAukGR39lS2GcAfkHEeKW37z8
         D/nZ4kMxEZIkbW7BiZMMAix6y/sCX//TGfe+135tn4uEU9nFPgUBz0h3abvYmGv9Y29n
         xJhHIhDUvJWn66RIefdFIjtv/2k+5x9iQpGFJBzNGdEXxSMoYwNe26gWTq1qTeol1cZ3
         +XD1ifmXCjwycwfCBc/u1hUmPAY2v46euq/mUAhheWNx1QiXL9Y2snWS5yx8L5i8aWlX
         195FT96rbMsu/oSaK7WcB4Qjb7pA8HdqmtxLbrFkeRsJcpk4M6Fll1OW9D0wySBxIUzZ
         40Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543908; x=1756148708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq6Zp3+Y18V6Wd6MTldZy3jkN51lHJSQ9xa9eV2y3so=;
        b=XKDZQo92629t9cKWdjrAJqROmNiQBS98+ahSjmbPaIDEbIvqjkqJUHnwMMNiHp4Xet
         vV+aL89YAUO9n/aNMxH7JLIWB5iJoUuR5EZ8IHHzKlqyzurVw0NbGvIJ8g+hYHnO+08r
         N13baxH3yGM8IRvYf+z6HDSs3DC0orZm23bgqax4Z7kNJiLFDZxU3j0e2NGs8Ua8P3td
         T5KY3QV2tda0dRIpDBlK+xdrv9bdSMhGrh0CjNEuGtpFyXkoHH4zL6PVtKduvH811wih
         1y8u099Q9q09lLNyRhan2HGt1H26EcfHzCgsgpy0kmwpzNLo+KTQ2WVyFFqfoOKX4KHV
         Vrkw==
X-Forwarded-Encrypted: i=1; AJvYcCUy4Zpusma5fFeiqSG7cJwEeaFXuiXsxRojGTqBJhUPXP3QxqigO4M2HMnPtY1KfcamE75etBSiQvo/PTU=@vger.kernel.org, AJvYcCWSd/sG8jQuCpmkbN/8fK8HcrdV02eTP2v+kKnpSWDe0lRbOIRI+kmXHbo2NktY2kK5LD8cwKUnyXLcXjQNSw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGJHj16DgUavlDPQOLT/PKYN75yx7zOYxxLpveKFRZvM+sKUSw
	unzTpLrXv2bjLW4XKXRpol/sIXPEnd+vUZlNhdt6XS18+qc8ljEk9kPQxwo36Yl93FTZjBp8d8X
	cLRPgqRNIs5ej3/+KVI4C5x8ZnXmGzjY=
X-Gm-Gg: ASbGncseQHf33Xqr78rJrwS+ljNfgxoeKvo8IdbwB5XqnoS3PsKIWqExwRB+CLyuFts
	5G8Zi6uURdZu1O5/lfjec9B7ujKW4SSfW20uU05JIiPMpB8SVyzks62DleaDE0Ps5Eu+8N4BmCK
	az/i8sOrdoUkJqhJIPJDROwIPwiFfZ1S52mv4khRuNCEe3ImMaCWVyvWocYonm3c5sJvBtIU3M2
	+xOcXyV
X-Google-Smtp-Source: AGHT+IEPwGT6D7ofam2Jo/WcKpoyaXNY/0t0JwHzT6E77ceBqSAzyBcMWI2pDjK+/ebebK7AYHdWP5iUGfD5I6158Rs=
X-Received: by 2002:a05:6102:800f:b0:4fb:dcc2:e1a9 with SMTP id
 ada2fe7eead31-5126cb44ea3mr1390373137.4.1755543908124; Mon, 18 Aug 2025
 12:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
 <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com> <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
 <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com>
In-Reply-To: <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com>
From: Christian <christiansantoslima21@gmail.com>
Date: Mon, 18 Aug 2025 16:04:56 -0300
X-Gm-Features: Ac12FXwlg2S1vZFth67WUWi9b1a4B6MdA52NzyMRR7s09IYXYZeBevxdDnmelPE
Message-ID: <CABm2a9cyvsXd1OS+tvDoDDEfMgBOJeetBVQU0x3m5E1vV1CApw@mail.gmail.com>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alexandre.

On Mon, Aug 18, 2025 at 8:28=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> On Wed Aug 13, 2025 at 3:00 AM JST, Christian wrote:
> > Hi, Alexandre.
> >
> >> I mentioned it on v8 [1] and v7 [2], but the tests that break due to
> >> this change need to be updated by this patch as well. This includes:
> >>
> >> * The doctests in `rust/kernel/dma.rs`,
> >> * The `samples/rust/rust_dma.rs` sample,
> >> * The example for `FromBytes` introduced by this patch which uses `?` =
without
> >> defining a function.
> >
> > Sorry for my inattention, I'll fix this in the next version.
>
> Ah, as it turns out you might not need to.
>
> We discussed this patch a bit during the DRM sync, and the consensus was
> that it would probably be better to keep things a bit simpler for the
> first version. The `FromBytesSized` trait in particular was not very
> popular; a better long-term way to provide implementations for
> `FromBytes` would be to use a derive macro, but that's out of scope for
> now.
>
> Instead, we agreed that the following would make a good first version:
>
> - Make the `FromBytes` trait depend on `Sized`,
> - Provide default implementations for `from_bytes` and `from_bytes_mut`
>   directly in the `FromBytes` trait,
> - No implementation for slices for now,
> - Consequently, no user code will break due to the addition of the
>   methods, which is a big plus.
>
> The simpler version that would result from this covers all the immediate
> use-cases and would be easier to merge, which will give us some time to
> think about how to handle the non-sized use cases (probably via a derive
> macro).
>
> Do you think you could write the next version along these lines?

Yes, no problem.

> I feel like I misdirected you with the `FromBytesSized` trait, so please
> accept my apologies for that.

Don't worry, your guidance was really helpful during this time, no
need for excuses.

Thanks,
Christian

