Return-Path: <linux-kernel+bounces-787797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE1B37B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CCA172F89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5FE2C0F65;
	Wed, 27 Aug 2025 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVG+ybQ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D2B27510B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756278244; cv=none; b=P9bY1CE+mklX55uOfIAkrL1LCVRfqO1SX11btGvp9paH49sI3YzhhbFHp0o0/x0jjcaC/XdILwkdwBiVvxligJZxgXB0KIns1g+0SbxjnrFi8dyIf9GB/plBn1cNCSkOAy6F9GV4cXx2SB4mrW2IPLjsM06Cgbz005zBiEJ03Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756278244; c=relaxed/simple;
	bh=H5CZ2tzbkSmKe4NS8/T4DKNGORhGlbgAW543kjz/iq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/+w3Z3Gu0VpBRUZi+BviC90ocxWvnQa9UfFfAl7WISt26w1zy4wnYwTD4GryjR8WJ55DhsSLbkkOCUElHp1BOEQ/oE+KGfXLiFfgJxEGv5/ccOAWRSJtu/xjzrfofFPISsI3jUw2jeDjpAno38wu8yYVMJb5msnhfDPdPAUfOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVG+ybQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431BDC116D0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756278244;
	bh=H5CZ2tzbkSmKe4NS8/T4DKNGORhGlbgAW543kjz/iq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PVG+ybQ97gAPd4LFhIR+G+kvrjKv5810J1QRkFAKGzZgz1DE7OJii/r2BNoPZGfUu
	 7N9Rm8U6y7iLF+KFMZT5TwrDWYOZEq3cgR3462BUv3UG3WRUhbEwC7Jadl69YN3LLs
	 kflnravkk/zUwRDIpr/5sJLyXhOBTquduWLT8LPWOgASvRLLKrIzFyCFU6NSLZq8Xa
	 PJDhiH2B1vblu+tcNjydq4Yj3XPxCXuTTxlansUWkNVhPO2Zh4fN3o9vpxOtkTMf6r
	 Y+J9WF2+6Br5+Z9/jmaKNovnECLjWNbjetoIS3APzDc0scdpfDAEbQFez1PiBiy6oY
	 kC8HlH4aMlTOQ==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b72f7f606so6105e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:04:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwWoXKD/qc9aYISzuwigFA7l+A9rGUqIN/LUBk+qPgRjYYiEBgzHlgD98HMwsR6jMqv/ZfmpFYGpEgDkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojYRhnME9NbEN9EQV+pbrCuNoTAk3B8ZHXTIr26gvXIX433QD
	wTsMIgR2xjM52kct5WqryGEMuuViC4jc272qj+LkpXYxvQhILp/t+IYbE019sBvFudITtr0vQKd
	YFMx0zzb+8jkqzaeAnrxs/Z1TRQGTkpQDM7Z9cMIo
X-Google-Smtp-Source: AGHT+IGBj0S1YqcNqOkhVcoHPopUd0x4JO1ktWGHJxrJEhQxDs2ayKTTjYgC0+ca8SME3350p2Zfcb964yCWaq4vMqc=
X-Received: by 2002:a05:600c:793:b0:442:feea:622d with SMTP id
 5b1f17b1804b1-45b669691bcmr1716945e9.1.1756278242844; Wed, 27 Aug 2025
 00:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-3-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 27 Aug 2025 00:03:51 -0700
X-Gmail-Original-Message-ID: <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com>
X-Gm-Features: Ac12FXy8dmeBtEZtyu95HnMDsR5nhtEyMNmwLO0U59Mi-B1KEbZy2QkKBB2jnbM
Message-ID: <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:

> diff --git a/mm/shmem.c b/mm/shmem.c
> index e9d0d2784cd5..b4d39f2a1e0a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2379,8 +2379,6 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>                         count_vm_event(PGMAJFAULT);
>                         count_memcg_event_mm(fault_mm, PGMAJFAULT);
>                 }
> -       } else {
> -               swap_update_readahead(folio, NULL, 0);

Also this update readahead move to later might have a similar problem.
All the bail out in the move will lose the readahead status update.
The readahead deed is already done. Missing the status update seems
incorrect.


>         }
>
>         if (order > folio_order(folio)) {
> @@ -2431,6 +2429,8 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>                 error =3D -EIO;
>                 goto failed;
>         }
> +       if (!skip_swapcache)
> +               swap_update_readahead(folio, NULL, 0);
>         folio_wait_writeback(folio);
>         nr_pages =3D folio_nr_pages(folio);


>
> diff --git a/mm/swap.h b/mm/swap.h
> index efb6d7ff9f30..bb2adbfd64a9 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -52,6 +52,29 @@ static inline pgoff_t swap_cache_index(swp_entry_t ent=
ry)
>         return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
>  }
>
> +/**
> + * folio_contains_swap - Does this folio contain this swap entry?
> + * @folio: The folio.
> + * @entry: The swap entry to check against.
> + *
> + * Swap version of folio_contains()
> + *
> + * Context: The caller should have the folio locked to ensure
> + * nothing will move it out of the swap cache.
> + * Return: true or false.
> + */
> +static inline bool folio_contains_swap(struct folio *folio, swp_entry_t =
entry)
> +{
> +       pgoff_t offset =3D swp_offset(entry);
> +
> +       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +       if (unlikely(!folio_test_swapcache(folio)))
> +               return false;
> +       if (unlikely(swp_type(entry) !=3D swp_type(folio->swap)))
> +               return false;
> +       return offset - swp_offset(folio->swap) < folio_nr_pages(folio);
> +}
> +
>  void show_swap_cache_info(void);
>  void *get_shadow_from_swap_cache(swp_entry_t entry);
>  int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> @@ -144,6 +167,11 @@ static inline pgoff_t swap_cache_index(swp_entry_t e=
ntry)
>         return 0;
>  }
>
> +static inline bool folio_contains_swap(struct folio *folio, swp_entry_t =
entry)
> +{
> +       return false;
> +}
> +
>  static inline void show_swap_cache_info(void)
>  {
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index ff9eb761a103..be0d96494dc1 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -70,10 +70,12 @@ void show_swap_cache_info(void)
>  }
>
>  /*
> - * Lookup a swap entry in the swap cache. A found folio will be returned
> - * unlocked and with its refcount incremented.
> + * swap_cache_get_folio - Lookup a swap entry in the swap cache.
>   *
> - * Caller must lock the swap device or hold a reference to keep it valid=
.
> + * A found folio will be returned unlocked and with its refcount increas=
ed.
> + *
> + * Context: Caller must ensure @entry is valid and pin the swap device, =
also
Is the "pin" the same as  "lock the swap device or hold a reference"?
Not sure why you changed that comment to "pin".

It seems to me that you want to add the comment for the return value check.
Is that it?

> + * check the returned folio after locking it (e.g. folio_swap_contains).
>   */
>  struct folio *swap_cache_get_folio(swp_entry_t entry)
>  {
> @@ -338,7 +340,10 @@ struct folio *__read_swap_cache_async(swp_entry_t en=
try, gfp_t gfp_mask,
>         for (;;) {
>                 int err;
>
> -               /* Check the swap cache in case the folio is already ther=
e */
> +               /*
> +                * Check the swap cache first, if a cached folio is found=
,
> +                * return it unlocked. The caller will lock and check it.
> +                */
>                 folio =3D swap_cache_get_folio(entry);
>                 if (folio)
>                         goto got_folio;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4b8ab2cb49ca..12f2580ebe8d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -240,12 +240,12 @@ static int __try_to_reclaim_swap(struct swap_info_s=
truct *si,
>          * Offset could point to the middle of a large folio, or folio
>          * may no longer point to the expected offset before it's locked.
>          */
> -       entry =3D folio->swap;
> -       if (offset < swp_offset(entry) || offset >=3D swp_offset(entry) +=
 nr_pages) {
> +       if (!folio_contains_swap(folio, entry)) {
>                 folio_unlock(folio);
>                 folio_put(folio);
>                 goto again;
>         }
> +       entry =3D folio->swap;

Can you also check this as well? The "goto again" will have entries
not assigned compared to previously.
Too late for me to think straight now if that will cause a problem.

To be continued.

Chris

