Return-Path: <linux-kernel+bounces-845979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF242BC69EC
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 649C54E895D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AB26FA4E;
	Wed,  8 Oct 2025 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9kSZwg9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB911E9915
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957191; cv=none; b=Akb4Z3sa39s67Ow94SKvCZ79ajvQnwFuth/uDHDiXb+N3jzFSQwwyvNhovYt2Jg4DVi7YqnNqrnsk/0HnF16ya8YjrSrMh6sZYdGhQwhLNy8Pc+rKMGni/B18TPy9qK3trzVURfqHMb/d9Lazjecx2KZ2X6d2SeuxHEQ9EXuigg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957191; c=relaxed/simple;
	bh=eUqCLx3itxMEwtReJ0MfCq6If7yIzpbBzgg6uk08zrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtzT/laNjOm43DqKXxsw0HpU2TKiWa6l5Iazall1n+GLqyfC6HxtQjHGtlI94NpZtuaeq01TuL9kxNmFVfgfZdW11iJ8OKcb2xcW6n2GAS6Q+3FXoWoI4iitfJ0uK60XffpM9/FKvwToBWpB2R2DoR5C1G5DqAURQi7lMB8zWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9kSZwg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8686C19421
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759957190;
	bh=eUqCLx3itxMEwtReJ0MfCq6If7yIzpbBzgg6uk08zrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V9kSZwg9yQlkKFj2D52uI+fwafGD07n+yKH3NhTJFgoXSHRwu7GGLbezH9b1+VL1w
	 H+pDtxXRCCQNgCuurynceA81p550Im3P4qBqah5+4v5jDwH14kfR4/VrSZqSxwjZO6
	 l0f/Ii4mXyga+T9yP0tV0qnWvD6fE4b/zOoH+m4QXdEOOG5IkV4k/xNTQVRTSlsXRR
	 cqvvoPVvVNjSjDxcZI7XnnsPOfbwVq/atbhKUxdLbl9TiJZqZRGg7RdrszD0/VjHgE
	 wYspemEBm342MmNS+raj7p3B8keUdMoeQvdxCRRY14I0+jHu8o8p6saiEJDmgUb2OQ
	 1JvGsRZtmnW/g==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-77fac63ba26so3334087b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:59:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvezixlq8zTJfqi7wAh/EY3DWJtD1hx83jZvjTPYQKbT1NbDdHT53azxsy7L4IJh72WL1CVZFiQGd2IxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9axgKXw7HCXEj3nTMR9ZblNDS+4ClzuJOJBBqbRmVC9HMBdi
	SDZVOfDIDJ2Qwu3A8waRR5sNFEtzBGb39zwqSU6UTj8Ina5VNc6WEy4lpu9wKHZTyt33qZH2S1s
	I83mSBe6WBfoglSfpO5uCRmNw/8tOG5n2pz1yQLZgYg==
X-Google-Smtp-Source: AGHT+IENfMLmi+x/bpMSbJWEZ+uKHClAL8tDN6VRNwU0GfnLGeFCj2Ji7sf8qlTzCMA0o7poF6JRLsow7KuubJT8xOM=
X-Received: by 2002:a53:cec2:0:b0:62a:b545:54b6 with SMTP id
 956f58d0204a3-63ccb8f2f76mr3700146d50.35.1759957189849; Wed, 08 Oct 2025
 13:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-3-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-3-74860ef8ba74@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 8 Oct 2025 13:59:38 -0700
X-Gmail-Original-Message-ID: <CACePvbV=5A-=eqh8Fq+pmNSZ7fPq03SmUw8at-pN_N+8vFSpXQ@mail.gmail.com>
X-Gm-Features: AS18NWCbUb_oLy12b0rJSYPGGNJHkxb5YMYEOs8q-6mh6rFyluLkQuXK1GMBb1s
Message-ID: <CACePvbV=5A-=eqh8Fq+pmNSZ7fPq03SmUw8at-pN_N+8vFSpXQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm, swap: cleanup swap entry allocation parameter
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Mon, Oct 6, 2025 at 1:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> We no longer need this GFP parameter after commit 8578e0c00dcf ("mm, swap=
:
> use the swap table for the swap cache and switch API"). Before that
> commit the GFP parameter is already almost identical for all callers, so
> nothing changed by that commit. Swap table just moved the GFP to lower
> layer and make it more defined and changes depend on atomic or sleep
> allocation.
>
> Now this parameter is no longer used, just remove it. No behavior
> change.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h | 4 ++--
>  mm/shmem.c           | 2 +-
>  mm/swapfile.c        | 2 +-
>  mm/vmscan.c          | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index e818fbade1e2..a4b264817735 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -462,7 +462,7 @@ static inline long get_nr_swap_pages(void)
>  }
>
>  extern void si_swapinfo(struct sysinfo *);
> -int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask);
> +int folio_alloc_swap(struct folio *folio);
>  bool folio_free_swap(struct folio *folio);
>  void put_swap_folio(struct folio *folio, swp_entry_t entry);
>  extern swp_entry_t get_swap_page_of_type(int);
> @@ -560,7 +560,7 @@ static inline int swp_swapcount(swp_entry_t entry)
>         return 0;
>  }
>
> -static inline int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask)
> +static inline int folio_alloc_swap(struct folio *folio)
>  {
>         return -EINVAL;
>  }
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 45f51745ad88..63092cc0b141 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1617,7 +1617,7 @@ int shmem_writeout(struct folio *folio, struct swap=
_iocb **plug,
>                 folio_mark_uptodate(folio);
>         }
>
> -       if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GF=
P_NOWARN)) {
> +       if (!folio_alloc_swap(folio)) {
>                 bool first_swapped =3D shmem_recalc_inode(inode, 0, nr_pa=
ges);
>                 int error;
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 732e07c70ce9..534b21aeef5a 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1425,7 +1425,7 @@ static bool swap_sync_discard(void)
>   * Context: Caller needs to hold the folio lock.
>   * Return: Whether the folio was added to the swap cache.
>   */
> -int folio_alloc_swap(struct folio *folio, gfp_t gfp)
> +int folio_alloc_swap(struct folio *folio)
>  {
>         unsigned int order =3D folio_order(folio);
>         unsigned int size =3D 1 << order;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index aadbee50a851..c99f7d6d5dd9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1296,7 +1296,7 @@ static unsigned int shrink_folio_list(struct list_h=
ead *folio_list,
>                                             split_folio_to_list(folio, fo=
lio_list))
>                                                 goto activate_locked;
>                                 }
> -                               if (folio_alloc_swap(folio, __GFP_HIGH | =
__GFP_NOWARN)) {
> +                               if (folio_alloc_swap(folio)) {
>                                         int __maybe_unused order =3D foli=
o_order(folio);
>
>                                         if (!folio_test_large(folio))
> @@ -1312,7 +1312,7 @@ static unsigned int shrink_folio_list(struct list_h=
ead *folio_list,
>                                         }
>  #endif
>                                         count_mthp_stat(order, MTHP_STAT_=
SWPOUT_FALLBACK);
> -                                       if (folio_alloc_swap(folio, __GFP=
_HIGH | __GFP_NOWARN))
> +                                       if (folio_alloc_swap(folio))
>                                                 goto activate_locked_spli=
t;
>                                 }
>                                 /*
>
> --
> 2.51.0
>

