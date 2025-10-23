Return-Path: <linux-kernel+bounces-867487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E73C02C45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264E01AA049C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C6234A770;
	Thu, 23 Oct 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYjoycFg"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3533DEF3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241232; cv=none; b=FPAQHX/UAkOJ/lT4cA9D2jlT1Du9K5Lsltv2PJui6dmxJU7/XALkcFkRs2WeQtOeB62jE7aXqRlfghGQNICkJo54U0lFiJIMXuTnIexWAciuP9klGCBCTpKMfn+P2RIAbUw3W9HWaqgrCkvUFAslyo3zRO6pgWL26fCVDr2FHRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241232; c=relaxed/simple;
	bh=TTK6h6ml7y/22TB+D+/QTwGdPNuUZy3BGLD3gRDdYAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPF8rZ289vfZ2tTxfK4eE4Kq9l+NjBbT2IGh3dSod5nSdAkCNs38dBVnhlGiVCVrx+yUpwkEqxosrJZnAvrjxDnWogxNGl7mPubg7QmOS8qttPkp2L+b59eVfjwuQuurOsHNlrkvP74fqKs03qx72ODbfsuEMjMsZOBy/vRHH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYjoycFg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b403bb7843eso227676966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241228; x=1761846028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smzdmE7oqDk8LuIhXOJODpEUrtL1Td6tLH8AoLayyPw=;
        b=eYjoycFgUCk9GaDxqbRzoUj4IiltGk2u55V0kLa6PmdSHsBkiJJabBLYfDsp9VZrOq
         0RmTBwNI7ijbhKKLAkd9+cAMhWaIgCVgmrTIkDBiiz2NndQxhn+/cSzIZXZe5c3AJPmS
         uJ43YpR/1emzqFLJCeHzWleD5tEXIHhrSGy3h60K1GnEGmqIwufjNUBe8bE+ME4C4sPy
         v8n0FvYa/WCYG/yCSbvwfuy/31wtcEZB5JAOOMhO0I1FDRSCrEjzyUcSeW9Sf8tHUAUo
         naG85qzW4sXNmDCa4TjHcLx0/RsjDd7TshEIePFtpEG0Kw8OkPJgNPKuy1LmSnhpL8dk
         wWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241228; x=1761846028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smzdmE7oqDk8LuIhXOJODpEUrtL1Td6tLH8AoLayyPw=;
        b=pGhPw5zGLdWXBuW20eUHSz62DIJdvMF463NVfEvZsQAP6Y1UQh3WtyG/1KOTb28qTm
         9FPj1RMl1PbtTWZyxR/m90ZaXyK8s8DTUZ0+C6HjD6IhH9K1a2h5xd6ONAagv2FDuqxu
         ac729EGQTm19A8Rtvyew6yPYUQ/8+hWNFae73/sSrR/qflcgimRGbdQL32BWEEccqx53
         iJzs3ZTT2h2IHSXo4uRGD55n571BPWj2lcyc/9wgy8vojQDJhQiHBG01+m28pMARRciv
         HkYJUctq9MKakZGV0fXJmo+kk12rd7KQgKspS2jgNFFN/bKxeC0ZfPParmiF5jLPIc2z
         O6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJvi4jNzorWCiC4JwxXMfpJp41E3rEDPf2VqPF8GiiHNeclTfGu+HpYO8PSNEtEpdKOF1OvL2qmvKkrMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhpv74+//Qz/FQorfvzjnJMwHOzypsbDurHXbTfFI/1Z5p83Cn
	zQ1a4097eihqqv7gEya85+xb7t3gfYNDDPp0DkVyIbo4wXrwr8MhelT2bCH+gLKwW0YJ41KImgh
	QiLcdFfjqIahyGdRev0jp2tU/x/L831Q=
X-Gm-Gg: ASbGnctzbBSYDb/hQqPQSKQb0BwoshgDESanwMPVqUymZ7SOFQrxLJUTmfz1lFOkvs1
	dGrdMm+LseP5NSh5i1DQbbKpkL3ZrAv8nr7bacmeRPO33jKzlWUDrRCI0V6zFVwskyKQWBfq1fH
	xV8xPd3fb0vBTY0ALmpBaRN1g+MgY7AI1JRHvf58q14X8MZg8LhwBr+TV3uzaTzBMDcxSWN2NLN
	1opm3E/Jeps5POzJr0ybkMEhCyk3hT/Gs25OnEbJ32qUZkpWh/75mHrsgwhEYuDqwaeWhG/VQ==
X-Google-Smtp-Source: AGHT+IHow1VR8JQAE5q6qgDSicvmCI1LUGpLgKgoz/cgPgRgNpbdkUQD3/ZXHjoZ0VycRm0yeeZH7AQnSl5smGqMZo0=
X-Received: by 2002:a17:907:3f87:b0:b3c:3c8e:1896 with SMTP id
 a640c23a62f3a-b6473b52634mr2763877966b.42.1761241228124; Thu, 23 Oct 2025
 10:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023030521.473097-1-ziy@nvidia.com>
In-Reply-To: <20251023030521.473097-1-ziy@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 23 Oct 2025 10:40:15 -0700
X-Gm-Features: AWmQ_bn3zq0uDKg6ko2JiMC7FRwDGgYYe7WpkCFUwmKJwPnSL1F1mC_HQ9WgH9I
Message-ID: <CAHbLzkqf37UpnFmQ_yZqZmWAa5X72JgFHsyUUBcyP6Pn9c3YyQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/huge_memory: preserve PG_has_hwpoisoned if a folio
 is split to >0 order
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com, 
	kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org, 
	nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:05=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> folio split clears PG_has_hwpoisoned, but the flag should be preserved in
> after-split folios containing pages with PG_hwpoisoned flag if the folio =
is
> split to >0 order folios. Scan all pages in a to-be-split folio to
> determine which after-split folios need the flag.
>
> An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
> avoid the scan and set it on all after-split folios, but resulting false
> positive has undesirable negative impact. To remove false positive, calle=
r
> of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() needs =
to
> do the scan. That might be causing a hassle for current and future caller=
s
> and more costly than doing the scan in the split code. More details are
> discussed in [1].
>
> This issue can be exposed via:
> 1. splitting a has_hwpoisoned folio to >0 order from debugfs interface;
> 2. truncating part of a has_hwpoisoned folio in
>    truncate_inode_partial_folio().
>
> And later accesses to a hwpoisoned page could be possible due to the
> missing has_hwpoisoned folio flag. This will lead to MCE errors.
>
> Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=3DcpRXrSrJ9V9=
Pm2DJexs985q4g@mail.gmail.com/ [1]
> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Thanks for fixing this. Reviewed-by: Yang Shi <yang@os.amperecomputing.com>

> ---
> From V3[1]:
>
> 1. Separated from the original series;
> 2. Added Fixes tag and cc'd stable;
> 3. Simplified page_range_has_hwpoisoned();
> 4. Renamed check_poisoned_pages to handle_hwpoison, made it const, and
>    shorten the statement;
> 5. Removed poisoned_new_folio variable and checked the condition
>    directly.
>
> [1] https://lore.kernel.org/all/20251022033531.389351-2-ziy@nvidia.com/
>
>  mm/huge_memory.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fc65ec3393d2..5215bb6aecfc 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3455,6 +3455,14 @@ bool can_split_folio(struct folio *folio, int call=
er_pins, int *pextra_pins)
>                                         caller_pins;
>  }
>
> +static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
> +{
> +       for (; nr_pages; page++, nr_pages--)
> +               if (PageHWPoison(page))
> +                       return true;
> +       return false;
> +}
> +
>  /*
>   * It splits @folio into @new_order folios and copies the @folio metadat=
a to
>   * all the resulting folios.
> @@ -3462,17 +3470,24 @@ bool can_split_folio(struct folio *folio, int cal=
ler_pins, int *pextra_pins)
>  static void __split_folio_to_order(struct folio *folio, int old_order,
>                 int new_order)
>  {
> +       /* Scan poisoned pages when split a poisoned folio to large folio=
s */
> +       const bool handle_hwpoison =3D folio_test_has_hwpoisoned(folio) &=
& new_order;
>         long new_nr_pages =3D 1 << new_order;
>         long nr_pages =3D 1 << old_order;
>         long i;
>
> +       folio_clear_has_hwpoisoned(folio);
> +
> +       /* Check first new_nr_pages since the loop below skips them */
> +       if (handle_hwpoison &&
> +           page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages)=
)
> +               folio_set_has_hwpoisoned(folio);
>         /*
>          * Skip the first new_nr_pages, since the new folio from them hav=
e all
>          * the flags from the original folio.
>          */
>         for (i =3D new_nr_pages; i < nr_pages; i +=3D new_nr_pages) {
>                 struct page *new_head =3D &folio->page + i;
> -
>                 /*
>                  * Careful: new_folio is not a "real" folio before we cle=
ared PageTail.
>                  * Don't pass it around before clear_compound_head().
> @@ -3514,6 +3529,10 @@ static void __split_folio_to_order(struct folio *f=
olio, int old_order,
>                                  (1L << PG_dirty) |
>                                  LRU_GEN_MASK | LRU_REFS_MASK));
>
> +               if (handle_hwpoison &&
> +                   page_range_has_hwpoisoned(new_head, new_nr_pages))
> +                       folio_set_has_hwpoisoned(new_folio);
> +
>                 new_folio->mapping =3D folio->mapping;
>                 new_folio->index =3D folio->index + i;
>
> @@ -3600,8 +3619,6 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
>         int start_order =3D uniform_split ? new_order : old_order - 1;
>         int split_order;
>
> -       folio_clear_has_hwpoisoned(folio);
> -
>         /*
>          * split to new_order one order at a time. For uniform split,
>          * folio is split to new_order directly.
> --
> 2.51.0
>

