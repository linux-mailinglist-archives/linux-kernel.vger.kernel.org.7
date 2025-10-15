Return-Path: <linux-kernel+bounces-853980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A29BDD34B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C633935355C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB12A3148D0;
	Wed, 15 Oct 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dscn2Apa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060B2BDC23
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514728; cv=none; b=U1Uuahu5MEFCPwcMeZuze2NqgXSrJCLxD6dWXrkczQKIJ1LZJCw+X42EMFPPcO8wJowsilBLedAzenl58oZNwEVSRZGOGHJKPFVgaxlvgI/RGiu6o8pAF8MvT+9pZYQ8MlplJv4stAb2MMEINcivfla+Wl9IC/W3yPNcuxvvWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514728; c=relaxed/simple;
	bh=Hk8FceSWL5r86KoiYChN7BiB6tlnUBYhdKKUtKnsBf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxD9PuNg5hxMSePHL31bWfu8A3W5nPUTKVFcAaxAd7VZl3DnC7mcteS+mwBBHi0W0vOOJqhcRfT0VOFOZCZEMft0XGjCpV85FozKmtwbfxo/SwuLu1vgYY5P9pvcV2rf0z0zY33nyG3+9Heo+83ie6ftJC1L/ttghdo+huncr28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dscn2Apa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907F1C4CEFE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760514727;
	bh=Hk8FceSWL5r86KoiYChN7BiB6tlnUBYhdKKUtKnsBf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dscn2ApaBkuh8EDk+NNw0Ct2slio/sqp/Dra1L+qTikaYBzhvDstLjLWZXHXJ2tT0
	 6uiCCAmA9ZqQo5LA69iR5c7Bq0PxD/SR+MzxAHIhcXUIrOKiiEwhX7ixX8fnhzZjS7
	 D5awNVe0jKY+x6aAkrmgY49xOIGSo+4iCUgSBK/DItRVgNez4EXDhkGEcTOk2OasgF
	 5EKA46AgxJlk6B6gVFDEsFZpyu/4kzSHmPkpZHA5wbidVffvwRl/WK9rQAteKLOg4n
	 7lLU93sKVh3SySgrtvME+3A6aJogBZpES+xuSfvxxz0iPCljqsAqeBVFpn+Rt+XQ1Q
	 Te8I85OgVol0w==
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso41324975e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:52:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXH77HlYKDkn1QrKjyuYrhJHnJ3V/Lr/MBDODzldNW8aTP8Lt6SBU2a8NUxWyOxZoyQqzkY7PLf6Gec3V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz/cod5Y5Qc6uL2FUEC+GJClJgYk67fksQBeNF0jsMkBvoG//n
	gZOJh9ZtAv/9w3+jW3KjPIzFS8DAj/mhK6qEMznTrjfp+BgfzcIdqsdUMF+I9ehFYWFPs8Jt/SM
	STIheeBZQvnP4dvwalYkQLsGA07/XCUw=
X-Google-Smtp-Source: AGHT+IEFaI3DZoRnbvDOhvRmHl+9oaMsWgpyEGx60mmVrJHDRbgxKRmZRxoBncYFiUSnm0OF0Il58OANJPKeCxbOxCQ=
X-Received: by 2002:a05:600c:154a:b0:46f:b327:f20d with SMTP id
 5b1f17b1804b1-46fb327f2aamr130646295e9.26.1760514726025; Wed, 15 Oct 2025
 00:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015064759.2993842-1-rppt@kernel.org>
In-Reply-To: <20251015064759.2993842-1-rppt@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 15 Oct 2025 15:51:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTgG2DhqLC2B6URsNusjzcwCaxi-k=MUZTc1FTEHbaf+g@mail.gmail.com>
X-Gm-Features: AS18NWC3MAeshMbUqk61Elrq_2rSWAMD4mfkq-zOY9A84heCjfIMCusAIOWNVzY
Message-ID: <CAJF2gTTgG2DhqLC2B6URsNusjzcwCaxi-k=MUZTc1FTEHbaf+g@mail.gmail.com>
Subject: Re: [PATCH] csky/mm: fix build errors cause by folio flags changes
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fixup. If you want to go through your tree, please add the t=
ag:
Acked-by: Guo Ren <guoren@kernel.org>

On Wed, Oct 15, 2025 at 2:48=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Kernel compilation on csky fails because csky was not updated during
> conversion of folio flags to memdesc_flags_t:
>
> arch/csky/abiv2/inc/abi/cacheflush.h: In function 'flush_dcache_folio':
> arch/csky/abiv2/inc/abi/cacheflush.h:23:39: error: passing argument 2 of =
'const_test_bit' from incompatible pointer type [-Werror=3Dincompatible-poi=
nter-types]
>    23 |         if (test_bit(PG_dcache_clean, &folio->flags))
>       |                                       ^~~~~~~~~~~~~
>       |                                       |
>       |                                       memdesc_flags_t *
> include/linux/bitops.h:47:24: note: in definition of macro 'bitop'
>    47 |          const##op(nr, addr) : op(nr, addr))
>       |                        ^~~~
> arch/csky/abiv2/inc/abi/cacheflush.h:23:13: note: in expansion of macro '=
test_bit'
>    23 |         if (test_bit(PG_dcache_clean, &folio->flags))
>       |             ^~~~~~~~
>
> Update references of folio->flags in arch/csky.
>
> Fixes: 53fbef56e07d ("mm: introduce memdesc_flags_t")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/csky/abiv2/cacheflush.c         | 2 +-
>  arch/csky/abiv2/inc/abi/cacheflush.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
> index 876028b1083f..064b0f0f95ca 100644
> --- a/arch/csky/abiv2/cacheflush.c
> +++ b/arch/csky/abiv2/cacheflush.c
> @@ -21,7 +21,7 @@ void update_mmu_cache_range(struct vm_fault *vmf, struc=
t vm_area_struct *vma,
>
>         folio =3D page_folio(pfn_to_page(pfn));
>
> -       if (test_and_set_bit(PG_dcache_clean, &folio->flags))
> +       if (test_and_set_bit(PG_dcache_clean, &folio->flags.f))
>                 return;
>
>         icache_inv_range(address, address + nr*PAGE_SIZE);
> diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/a=
bi/cacheflush.h
> index 6513ac5d2578..da51a0f02391 100644
> --- a/arch/csky/abiv2/inc/abi/cacheflush.h
> +++ b/arch/csky/abiv2/inc/abi/cacheflush.h
> @@ -20,8 +20,8 @@
>
>  static inline void flush_dcache_folio(struct folio *folio)
>  {
> -       if (test_bit(PG_dcache_clean, &folio->flags))
> -               clear_bit(PG_dcache_clean, &folio->flags);
> +       if (test_bit(PG_dcache_clean, &folio->flags.f))
> +               clear_bit(PG_dcache_clean, &folio->flags.f);
>  }
>  #define flush_dcache_folio flush_dcache_folio
>
>
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> --
> 2.50.1
>


--=20
Best Regards
 Guo Ren

