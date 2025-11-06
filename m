Return-Path: <linux-kernel+bounces-889388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA71C3D725
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33C4134F63C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E639A303A37;
	Thu,  6 Nov 2025 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWL6kyW9"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDEE3019C7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462994; cv=none; b=bkZ8g3zXBbpK7xYtuOxyc9EoaoNmiSHaDlRGYEyZvpsZ1ZH3Xt0c4u3IQ4s0g8H8L4QecXk3ytfouGlIYPSzMj8YI/m4vKHD+/s4coc93UU768ewwkdyKcJtNJVzSflRIHEKR9BimxU8r4f4P2ODKFYwcFxPqQ9a9JtdxWMSre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462994; c=relaxed/simple;
	bh=crTOSqui6aH+Dc7+GWDBgIDHtOkvyOhOJeOaRa+09GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcFCqjGxxbaTgs1x3ObrHptH0y3rCbK7SsR69b38d1HkXmQprOUJA3T0EVmswIcmO7Agx9fFI+a0PJ8c1JFQ7moh7cPQ+NLoZ+aBHIK47fqbr4meiHXI1F/lIyAnRJP6Muq8HIRsbt/3AJWJP+1fnRPZSPN+l+2MInj0jAAPQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWL6kyW9; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-88e51cf965dso6682685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762462991; x=1763067791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHypUXf5gm7cuOtbaXRtiwOqxniqg61cHX+ypA+ba/A=;
        b=eWL6kyW9RitatK6nzYqiChg36eS1HjFDRH8YNRO1w4766PSz9g/ULTm7GhX7D7WCPm
         oBwzdrciWkPOPhv+jUoLtHUeETpV9meRabwtvSO6uzLBfnAPWVxknoo3bBmQ+PjEP5FN
         s8kOjfU8wr3s/XHIK23zmDOLTvnixI8ifVoydyavEM4h14n/0UDcAlx/me7xwe6yeaE3
         cKm6pU6z5fzFg33lwXKSOCG0cp+OdqQqLwOTHgIrae/2B0eeRjsfMjjcrd4PsAIMqclS
         GB3fT4O1vnIIEXHDZgLDIZV/0TNQZOAounI4OKjAl9J0ZjkhuDLYNBkZEoWVAHN9J/wD
         szpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462991; x=1763067791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHypUXf5gm7cuOtbaXRtiwOqxniqg61cHX+ypA+ba/A=;
        b=ox4L+EvFSvil9FBJ7mf2pwuZZbsOOnfI8zjDRYZ1HVaPFtXvWDLP1Kx8Dq/oLdOGcP
         tSQ7uJzt9Ms1ejqW1asvhOD5gZa6rYXO2V0vt2qQPN9BMi9SdLy0F7H24AGjjxJtO/O8
         1JRUMPk7EDWZySEwUfgQ/xHwbA0IHFhqzxvZxd5QMOK+n1YzBC8522KjSVGnsWFvzEKg
         Xtei7mI08sgxoyHSmD6QuHWr+42FiOg4fPMoof3xbUZKqD7HeQ42wwVvLQvNwMtE3mhN
         n7sRER7cFFFBhV7E/OtdhYsAadbZlqWP3aQdIacAJZEwMHUgiKnd/7ZTXqfPmP7i/rOz
         5bHg==
X-Forwarded-Encrypted: i=1; AJvYcCUG4UvbkeuaPWPzcQIX+4O4/YCZVATfJkyp6ZHK8TGxq4NmoJ2JNdjcvJ1rQ68LMNYbciZ80GatJF3eBXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNuTbH0eVQmgvV740qGat0ISlG/jfM7bbvTcbTZFoUHfRHIPu
	++v4PCHNNMS5fWFPiQ9bMeblxjOaq4+Y67w/6UZUjXf/nsULUbnLDU0WsB81LgJHN4IN/W8YHYn
	s55tn6M1eimUuzzEMto8wm+7Y50P1WwI=
X-Gm-Gg: ASbGnct08GO7vdCfn5H+IQtEgtWMjOpfz7EOTs3A/3z8Na5ilOz0bct/kZcgI8MVQ84
	eHS+DFZpStgVChClQEYMeZBchx9syZYDKWRmS+nzJ2zIeKWSJF20c4QDqZdF+couh+4lsnTYD2x
	tMH7NXRiHNURjXANOvfvBBdZRgjPreHPJiKsw2VAtCwevhA0VW7+SaIMQeWirQ5oNZfAU+xPbUS
	aMY+VfMdzbuqw6BgC37VBqE5yTZeh+2D3Ldm9ZPxLToGS7LLie/FWK5yG5Y7QGgxl1OgBP+bp1x
	os7diCTWQ3bETIaE
X-Google-Smtp-Source: AGHT+IEF6W6svjYvXsGYjS+AFcEKE7bp6remMWA7QdS0E7B02dPJ2qQaHz7h732U9sbkoWlRpx4v0Zot4buhHXWJ/o0=
X-Received: by 2002:a05:620a:31a9:b0:890:ea32:2508 with SMTP id
 af79cd13be357-8b245358052mr131886885a.70.1762462991082; Thu, 06 Nov 2025
 13:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com> <20251029-swap-table-p2-v1-16-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-16-3d43f3b6ec32@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Nov 2025 05:02:59 +0800
X-Gm-Features: AWmQ_bmLUPQCpCueKwY0y58_af-PX7oXEsnJr2BWnItkloq8GETycyLToqDjuVA
Message-ID: <CAGsJ_4zW92dnCk6qUF9fKe+=b0dORLrBjuQC5mjq_nbTK4aT4g@mail.gmail.com>
Subject: Re: [PATCH 16/19] mm, swap: check swap table directly for checking cache
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:00=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Instead of looking at the swap map, check swap table directly to tell
> if a swap slot is cached. Prepares for the removal of SWAP_HAS_CACHE.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap.h        | 11 ++++++++---
>  mm/swap_state.c  | 16 ++++++++++++++++
>  mm/swapfile.c    | 55 +++++++++++++++++++++++++++++---------------------=
-----
>  mm/userfaultfd.c | 10 +++-------
>  4 files changed, 56 insertions(+), 36 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index 03694ffa662f..73f07bcea5f0 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -275,6 +275,7 @@ void __swapcache_clear_cached(struct swap_info_struct=
 *si,
>   *   swap entries in the page table, similar to locking swap cache folio=
.
>   * - See the comment of get_swap_device() for more complex usage.
>   */
> +bool swap_cache_check_folio(swp_entry_t entry);
>  struct folio *swap_cache_get_folio(swp_entry_t entry);
>  void *swap_cache_get_shadow(swp_entry_t entry);
>  void swap_cache_del_folio(struct folio *folio);
> @@ -335,8 +336,6 @@ static inline int swap_zeromap_batch(swp_entry_t entr=
y, int max_nr,
>
>  static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
>  {
> -       struct swap_info_struct *si =3D __swap_entry_to_info(entry);
> -       pgoff_t offset =3D swp_offset(entry);
>         int i;
>
>         /*
> @@ -345,8 +344,9 @@ static inline int non_swapcache_batch(swp_entry_t ent=
ry, int max_nr)
>          * be in conflict with the folio in swap cache.
>          */
>         for (i =3D 0; i < max_nr; i++) {
> -               if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
> +               if (swap_cache_check_folio(entry))
>                         return i;
> +               entry.val++;
>         }
>
>         return i;
> @@ -449,6 +449,11 @@ static inline int swap_writeout(struct folio *folio,
>         return 0;
>  }
>
> +static inline bool swap_cache_check_folio(swp_entry_t entry)
> +{
> +       return false;
> +}
> +
>  static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
>  {
>         return NULL;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 85d9f99c384f..41d4fa056203 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -103,6 +103,22 @@ struct folio *swap_cache_get_folio(swp_entry_t entry=
)
>         return NULL;
>  }
>
> +/**
> + * swap_cache_check_folio - Check if a swap slot has cache.
> + * @entry: swap entry indicating the slot.
> + *
> + * Context: Caller must ensure @entry is valid and protect the swap
> + * device with reference count or locks.
> + */
> +bool swap_cache_check_folio(swp_entry_t entry)
> +{
> +       unsigned long swp_tb;
> +
> +       swp_tb =3D swap_table_get(__swap_entry_to_cluster(entry),
> +                               swp_cluster_offset(entry));
> +       return swp_tb_is_folio(swp_tb);
> +}
> +

The name swap_cache_check_folio() sounds a bit odd to me =E2=80=94 what we=
=E2=80=99re
actually doing is checking whether the swapcache contains (or is)
a folio, i.e., whether there=E2=80=99s a folio hit in the swapcache.
The word "check" could misleadingly suggest verifying the folio=E2=80=99s h=
ealth
or validity instead.

what about swap_cache_has_folio() or simply:

struct folio *__swap_cache_get_folio(swp_entry_t entry);

This would return the folio without taking the lock, or NULL if not found?

Thanks
Barry

