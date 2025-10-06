Return-Path: <linux-kernel+bounces-843423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 225BCBBF269
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D62794EF0EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8CB25A2DA;
	Mon,  6 Oct 2025 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTicWYeR"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8531C3BFC
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781306; cv=none; b=SQSM+iO3lhaoxT1JMCMOfTcck2ho22EpfF4ZKUHcwUytqH82MDhUZSLGHnfbDf2O0uuz094Xi06TDL+2QEs+yNmRGNAoWv3Winnu8M9RoDdE5706rU7h2BLEpnYdli+lstMwLuxt8Otd2tIjHkDcRxomP3I5P/aDKeiNBf/Aznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781306; c=relaxed/simple;
	bh=F/n6E5oiRUGa7DfSxapTwt5y3LMIE876f/27q0Ae1J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBtiIEbSKveagiUB28Dd0Y3z5PONa9gILT9hpBHF/yNaYvHDioteyiGFjkTqh2lo6xSPDp54lMz80Xjmk4nYu9jm5Rsdb7MZ+wzmle7VFiAhnmPyZWM+QnTzxvIM0XrzC4hS/E+NES5/6WP9gs4WzmHZB3cCnKjJFFlnj7EPqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTicWYeR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b472842981fso724199866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759781303; x=1760386103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmmRVTJ6LWaGlBTe1WVKHlMgps6ILABVMan5EjARFG8=;
        b=FTicWYeRS6hNuCLoVrnsc0+bYcoA3MdbHMoyYLDU5sA3d24VN3rbkn2DJbVEuRnWL0
         6TbBjl+ChpwUUE+qIj1jG6Zs/kcdAzossulNhpNzZtoJKgH6IY5ezvyLDiToZuq6GqbU
         XDJKsuDM7Pm9o/BfkDlFsKWn/+gfJsvYz8Rxlbx0pdGoaQaRxIsasVlpJE5qqXyp2czV
         MV5M3CLo7RtRnBiMBXaGi0NGUrN4CIxsJFNEndgQpAyyXKMWHnUP537LrVJmMlkr/Dht
         LpRHewNiiZOMiCIreiYYMOv6htxuly3WcJg1WI7ec0j5Xkefc0dg2XDYb8aALLG72Y3z
         RuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781303; x=1760386103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmmRVTJ6LWaGlBTe1WVKHlMgps6ILABVMan5EjARFG8=;
        b=CLHc427BqV0SYo0ZESz/imVCNKsuwJhE+GVIMYRaC5EJSSqMD+8Um4idbOTXHl/q2D
         bdtj9TI4vrKy2tEWGxEYTm+R4gv49HsuOdmapSZHwKh/AiQ73Y5iozm9HQ9Q9YcTiN7A
         0vFRdq5ZpdapZJxVzozejYJ4fyW/Qgr+JgrjzPuX/eio8hOHdWsOIIwYyBlkWxPPMnkO
         xW4ZUbXCvBeRlPenaZ1pE1DykCLbMZgxZcaemlgEFbF2LtSP9UPzrLpZojA7rlgqaxNX
         PSyEo2488gZiRyX4TX22N7D3UWq+r6j1b1ohJqgrbMtDwGEitCyZNUsjmdKPq84K2RQp
         C8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5C6A01tlb/e9R5PSA8+S+TvbaWC+OKm5EJn3dluseo/aINFy4cO3RtXi6C5B0lFPx/t+zdG8PlbOogf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJf3IpPlrM8HznHOE0AFu+SsVJV6lWK60MCULj4EWSkvzyu0BA
	kA8bY6rMb8d4mBd7+shqRgYXeSfYI14oCVLCsnyJEbizGEotmwpPZSEsqGw6Kyh8YYhAe0rBkIZ
	qodRXd3AJ1/T+rjsNWbQUHBK2xKWx6F1FBbQ9VtE=
X-Gm-Gg: ASbGncszpGeq0aIVRCrZ/dUapmzFZ/ZUZrr7v6BKRBWh+a0nbkcNTLCHTpKOEgye8EP
	ZekbuJx23zAbn/cg5KnvPfYQsGXl4Azgd4KcaD+F+Q4yYgwTBfc/cF7Z8eV9/3B7vb7yaz1CZ65
	yWw9tQ+Z4VpfSbu0fbgr/2a0WSfOqd7ss/NeuJi9B72DxWi0+MfJHoZC4yWBuqUKe+YAaQhohfP
	msfCcSfIapz/DAND9ldLLztsHOdwsLQG1iNx8g23rk=
X-Google-Smtp-Source: AGHT+IEeK0yvKgA3yRX6cpZcTle/prdKxJd1FL6NEA99yvjPvuyT/DRTPlo4tjAqTzPUUdmSJQyo6pBhEUR417tWZxc=
X-Received: by 2002:a17:907:3f8a:b0:b2c:fa41:c1be with SMTP id
 a640c23a62f3a-b49c408771fmr1693598466b.61.1759781302586; Mon, 06 Oct 2025
 13:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-3-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-3-74860ef8ba74@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 7 Oct 2025 04:07:44 +0800
X-Gm-Features: AS18NWBjexQzd2EnwnZsGO_L9oSPyUVK26LnGcJddL_wP6CJUXM0pYl52btN_7Y
Message-ID: <CAMgjq7DGy_ZmPqcqUO6s5BN381Zuee_g3KWjVqM3amLhpwE=2g@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm, swap: cleanup swap entry allocation parameter
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Ying Huang <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 4:03=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
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

One trivial issue for myself, I better update the kerneldoc too...
sorry about this:

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 534b21aeef5a..0c2174d6b924 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1417,7 +1417,6 @@ static bool swap_sync_discard(void)
 /**
  * folio_alloc_swap - allocate swap space for a folio
  * @folio: folio we want to move to swap
- * @gfp: gfp mask for shadow nodes
  *
  * Allocate swap space for the folio and add the folio to the
  * swap cache.

