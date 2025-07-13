Return-Path: <linux-kernel+bounces-729027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ACAB030BD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E5417E48E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D724277CBC;
	Sun, 13 Jul 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a95OQqgM"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0F24293C
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752403998; cv=none; b=Ngx8k7O8FZSGe6ZLDbk7QxumiPuG6vQXFVOhzH7PK8nkM3m8lBojB+IlQjUaMeJULMWE0rBEne684W/q8LRUZxOW2f9kTrPpsDoscp71u4E9Z+tSHJUwjuO5XiJPZ48m2morHt8y04E6EkLOrI537yWV6KJTOv8sNyjP5a9Jvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752403998; c=relaxed/simple;
	bh=sI5oW9xMB+k7I1FGqAwsz4p49FA8VjHAMy21xMpJM0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJyMUCYu++nP/4BhsR5bhv+a6bKf2nPWCeCfuPApUudm1cv30EDn+hQnT/TzQ+yv5rHObCbkKCjNWCz/pkjQsUqxQAITUYVrK5UR+Aptho1t3fwXoh1MOCJFu2dqAdvRDoHH7Zb0CP8CpcJu4cUt2j319e/rkTLXKU402IJgV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a95OQqgM; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-886b2fdba07so1303863241.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752403995; x=1753008795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBCD89cIb4CZSAkeZzQ7C+33RF/FMrBf5lJ2sJv84Cg=;
        b=a95OQqgML/jxv738caPWkxZsf/MJNtyL1Xc3RPT2dMPh6NYIpkg6wyxooyHGzwxfJX
         aGaoc0dyZb9gtULMRdwSxXjxFXfwWdHCX1g+RgXupaXrP7fbwP9P9u3vO13h6EFd1gmg
         xijgJoQtYLg8x28g9wmdHICYFC5GHFzAlK47YhARuxb8MczVNJ4Mx/ENUePvKGtX+4MK
         PLrGgcDTOGyKgp1LY5POAqQhX9TD8i6E10mju0qXa9npeIRZyg7SY97qkhRaj7rfiExj
         kbNsNuL1h46ZQzlX9i8K+E1kvpm+/c2k8oN45nDIW1KB+g+QMKbI5ZdEYkTyh1lBI+jE
         GwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752403995; x=1753008795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBCD89cIb4CZSAkeZzQ7C+33RF/FMrBf5lJ2sJv84Cg=;
        b=q8O14ddu1BJ/nFE20irbz2mkxS2kGy5qPWbQi/Fm/MhLLabdJ26Tbvo/HdldXLzQ3O
         kR0klJEQ7PJCUuMGfz7azw6C++QgXAgzTnz9Z0HuGzNWo9A/8UFp7tsWoHbgpF6nCXqW
         yosryoV7RIr6VNSMj9T7OG1KMRSZBoyqwSDvb03TcMFLBjE2SPfoS5ZPrnRQBS2Z5dDT
         n8vIcs+r76y1xxZ1+jYg0ulqzL0iwK9Ck1dGDOtZ41zFRCpGsax0VWaqWw07YOjOOKHJ
         K45DgWn52Nf2ZUbGIe6uH6xFoIaiG4T7r/81JAR1TUiVesAJX5YN/hlXLqdn495KsLAm
         40Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXzHFP7pavTGCd6pg7nI8pCOCTbvPnUf5Wi8+ieRIuG7QzvhBYue1AOyjOk4a18pKi9wnZr2m3MHrzKbB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysdeSlqH3lNh5di091keHb1GoSAn0VjR+haGKq22XaDfyY38oT
	U37dG05yM87kN/mC6OuvFkG+XJUgAfeo0zXwagIr+Xzjev2wFU+uMeOKnieKtxt/WteJIao/MI/
	pejhc6RFgvkFlPxIdq15LfEJeV2zA7B0=
X-Gm-Gg: ASbGncu1jm+v3QprONltusoBANr+odx7GKtjrIg3J4jSbkiSE/H3kY5ak9UP1ZWR0k9
	1h8gqzTMyb38PGfaz1/6KnI2G0QIFgnrYVPfoXG7B8vnxpMfEcNDPdFZgg9CQF5CZ3UVAE7FB+t
	5eMX+3csB95foOFKnz7wILXuBe8xx3Lv/UudkA7SGTmGbVLvNYV3YRkS7J9feXs8A1Ao3BP7CMg
	xEzqn8rQw==
X-Google-Smtp-Source: AGHT+IGO7fzgCHnwtGBmpzdI+Lcp5NPSPAdYCBcUxfRl+K7iQ4kZHrV/G3oN1woaoOc37bNJWuTdROoBl9F1t8N4pfs=
X-Received: by 2002:a05:6102:50a6:b0:4e7:866c:5ccd with SMTP id
 ada2fe7eead31-4f64255fbccmr5899555137.8.1752403994954; Sun, 13 Jul 2025
 03:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710033706.71042-1-ryncsn@gmail.com> <20250710033706.71042-6-ryncsn@gmail.com>
In-Reply-To: <20250710033706.71042-6-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 13 Jul 2025 18:53:02 +0800
X-Gm-Features: Ac12FXz0wqlbK5Di05MUapxY7irnMFjMcMYO7_YxInCzB3TK7RmQggn9FxCtF8k
Message-ID: <CAGsJ_4zhRJdC7MH+3d9KfD1n3t4HiF8-OdWrKXUO7SH_H=1ZUQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] mm/shmem, swap: never use swap cache and readahead
 for SWP_SYNCHRONOUS_IO
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Matthew Wilcox <willy@infradead.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 11:37=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> For SWP_SYNCHRONOUS_IO devices, if a cache bypassing THP swapin failed
> due to reasons like memory pressure, partially conflicting swap cache
> or ZSWAP enabled, shmem will fallback to cached order 0 swapin.
>
> Right now the swap cache still has a non-trivial overhead, and readahead
> is not helpful for SWP_SYNCHRONOUS_IO devices, so we should always skip
> the readahead and swap cache even if the swapin falls back to order 0.
>
> So handle the fallback logic without falling back to the cached read.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/shmem.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 97db1097f7de..847e6f128485 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1982,6 +1982,7 @@ static struct folio *shmem_swap_alloc_folio(struct =
inode *inode,
>         struct shmem_inode_info *info =3D SHMEM_I(inode);
>         int nr_pages =3D 1 << order;
>         struct folio *new;
> +       gfp_t alloc_gfp;
>         void *shadow;
>
>         /*
> @@ -1989,6 +1990,7 @@ static struct folio *shmem_swap_alloc_folio(struct =
inode *inode,
>          * limit chance of success with further cpuset and node constrain=
ts.
>          */
>         gfp &=3D ~GFP_CONSTRAINT_MASK;
> +       alloc_gfp =3D gfp;
>         if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>                 if (WARN_ON_ONCE(order))
>                         return ERR_PTR(-EINVAL);
> @@ -2003,19 +2005,22 @@ static struct folio *shmem_swap_alloc_folio(struc=
t inode *inode,
>                 if ((vma && unlikely(userfaultfd_armed(vma))) ||
>                      !zswap_never_enabled() ||
>                      non_swapcache_batch(entry, nr_pages) !=3D nr_pages)
> -                       return ERR_PTR(-EINVAL);
> +                       goto fallback;
>
> -               gfp =3D limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
> +               alloc_gfp =3D limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
> +       }
> +retry:
> +       new =3D shmem_alloc_folio(alloc_gfp, order, info, index);
> +       if (!new) {
> +               new =3D ERR_PTR(-ENOMEM);
> +               goto fallback;
>         }
> -
> -       new =3D shmem_alloc_folio(gfp, order, info, index);
> -       if (!new)
> -               return ERR_PTR(-ENOMEM);
>
>         if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
> -                                          gfp, entry)) {
> +                                          alloc_gfp, entry)) {
>                 folio_put(new);
> -               return ERR_PTR(-ENOMEM);
> +               new =3D ERR_PTR(-ENOMEM);
> +               goto fallback;
>         }
>
>         /*
> @@ -2030,7 +2035,9 @@ static struct folio *shmem_swap_alloc_folio(struct =
inode *inode,
>          */
>         if (swapcache_prepare(entry, nr_pages)) {
>                 folio_put(new);
> -               return ERR_PTR(-EEXIST);
> +               new =3D ERR_PTR(-EEXIST);
> +               /* Try smaller folio to avoid cache conflict */
> +               goto fallback;
>         }
>
>         __folio_set_locked(new);
> @@ -2044,6 +2051,15 @@ static struct folio *shmem_swap_alloc_folio(struct=
 inode *inode,
>         folio_add_lru(new);
>         swap_read_folio(new, NULL);
>         return new;
> +fallback:
> +       /* Order 0 swapin failed, nothing to fallback to, abort */
> +       if (!order)
> +               return new;


Feels a bit odd to me. Would it be possible to handle this earlier,
like:

    if (!order)
        return ERR_PTR(-ENOMEM);
    goto fallback;

or:

    if (order)
        goto fallback;
    return ERR_PTR(-ENOMEM);

Not strongly opinionated here=E2=80=94totally up to you.

Thanks
Barry

