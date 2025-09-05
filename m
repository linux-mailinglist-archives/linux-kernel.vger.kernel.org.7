Return-Path: <linux-kernel+bounces-803926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC46B4675D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD3DD4E26F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625AE2BD001;
	Fri,  5 Sep 2025 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmpDwfbr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB029ACF7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116782; cv=none; b=Jk0vBL1wjUhbeKtvQHcjby8VxmBp3SGvy/b1eoqV+gstbDms++xT1UCsN9iuldeXic7S/D9sfFLYwr5hmYesCWlwlomgYpSaRu5E6D+6Qu2s8oIn2UXbUa17Zp0bF8zlrvIWCnfIkmqURh51g2b1T6JlYpOuD4yGF6F2SgYCnPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116782; c=relaxed/simple;
	bh=prHCxbT/FKtcefzvbDhaSmgNNkguHFw4eGJyO0KdfRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q16STVsebEK8ec/IIgRQmdvC4tKMCDYNGDsc2WH8bNNsGws/y4S4nL3sUNbxCT/ZfFdQMd7Td7+T6cVCZEFbm9g/M31rOWqMZ3cvKtiTxMA+qoC8td2OHjQvY5McBeaB3pdIOu/XHJTXu+kacVaqgS4g4OZ1fO+7vo13pxMChMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmpDwfbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C606BC4CEFD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 23:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757116781;
	bh=prHCxbT/FKtcefzvbDhaSmgNNkguHFw4eGJyO0KdfRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SmpDwfbrED7Ni+w3AVNeL6q9DVVBWikM4nb7Js4t7wgpDeKxXKuSBik/+/ygBTIE8
	 dcE91xuEKdv3WT+lN/X68ufH+x+xaHQSjZbt7h+JDYX66dgjd5M0WjPBVAFiZjjVlT
	 e4MYwEpXX77Oc2udy1tmHVrY1wRP2h5f2W+44zInQmA9unJMPD4EZsFU3TnQYw1ggB
	 ZhmMoPk/VkkoH9N4MNv3J2J6TRzf9KsdR0rtvYuKin++p9We7fIO3vKrD3t9DZRlZ2
	 8U1StK5bcirvcKyHNX+KdgTj+7NZsz99cHL7eqP7jARGpWS31m1dgZ0aXcQDXiinGe
	 y4I9aGQ3kCJZw==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b886f92ccso33035e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:59:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQOX0iS8dIhPzfQ+OPjKbnIETo/G9czim7GIGyYg+o1lMuTJlJBHVdessGaBLc7kWiqn8ablvqezs3SLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Fj/isO2VZhDr1ECeYLxqokk3JnDkyfa1gKWZKeJmthaFadMh
	j3CGEfJf7lI8ZC6y8C+TRSlmb1SifZcql7g0eZuzYYDoEFmXq7c9Cht+xaN5w1XnOkzMZIN9jMh
	/MNCLWTFeYVie8L/v0fUnPY5d1Q72nq3IOnNDPkYZ
X-Google-Smtp-Source: AGHT+IEmNVdm/ZNO2xj7Acuf0/0sMnvEPvL2QiE++x0zfKILopxcWbw9wOaJ79Q+cHCzvynH0RqPluUDHwM3LCki7ro=
X-Received: by 2002:a05:600c:3ba3:b0:45d:cfca:a92d with SMTP id
 5b1f17b1804b1-45ddda4e7e5mr480365e9.2.1757116780368; Fri, 05 Sep 2025
 16:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-3-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-3-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 5 Sep 2025 16:59:29 -0700
X-Gmail-Original-Message-ID: <CAF8kJuP3TePwm-Yv9k=8caDN_OHsEXLjkQyqzX8Zi5rByAxRzw@mail.gmail.com>
X-Gm-Features: Ac12FXwQoJgVKBu9ZgwBfG40kCMz84rUJdGEibuR9rX3WbxfQjIbxFt_Dtiuufs
Message-ID: <CAF8kJuP3TePwm-Yv9k=8caDN_OHsEXLjkQyqzX8Zi5rByAxRzw@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] mm, swap: use unified helper for swap cache look up
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

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> The swap cache lookup helper swap_cache_get_folio currently does
> readahead updates as well, so callers that are not doing swapin from any
> VMA or mapping are forced to reuse filemap helpers instead, and have to
> access the swap cache space directly.
>
> So decouple readahead update with swap cache lookup. Move the readahead
> update part into a standalone helper. Let the caller call the readahead
> update helper if they do readahead. And convert all swap cache lookups
> to use swap_cache_get_folio.
>
> After this commit, there are only three special cases for accessing swap
> cache space now: huge memory splitting, migration, and shmem replacing,
> because they need to lock the XArray. The following commits will wrap
> their accesses to the swap cache too, with special helpers.
>
> And worth noting, currently dropbehind is not supported for anon folio,
> and we will never see a dropbehind folio in swap cache. The unified
> helper can be updated later to handle that.
>
> While at it, add proper kernedoc for touched helpers.
>
> No functional change.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
>  mm/memory.c      |   6 ++-
>  mm/mincore.c     |   3 +-
>  mm/shmem.c       |   4 +-
>  mm/swap.h        |  13 ++++--
>  mm/swap_state.c  | 109 +++++++++++++++++++++++++----------------------
>  mm/swapfile.c    |  11 +++--
>  mm/userfaultfd.c |   5 +--
>  7 files changed, 81 insertions(+), 70 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d9de6c056179..10ef528a5f44 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4660,9 +4660,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (unlikely(!si))
>                 goto out;
>
> -       folio =3D swap_cache_get_folio(entry, vma, vmf->address);
> -       if (folio)
> +       folio =3D swap_cache_get_folio(entry);
> +       if (folio) {
> +               swap_update_readahead(folio, vma, vmf->address);
>                 page =3D folio_file_page(folio, swp_offset(entry));
> +       }
>         swapcache =3D folio;
>
>         if (!folio) {
> diff --git a/mm/mincore.c b/mm/mincore.c
> index 2f3e1816a30d..8ec4719370e1 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -76,8 +76,7 @@ static unsigned char mincore_swap(swp_entry_t entry, bo=
ol shmem)
>                 if (!si)
>                         return 0;
>         }
> -       folio =3D filemap_get_entry(swap_address_space(entry),
> -                                 swap_cache_index(entry));
> +       folio =3D swap_cache_get_folio(entry);
>         if (shmem)
>                 put_swap_device(si);
>         /* The swap cache space contains either folio, shadow or NULL */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 2df26f4d6e60..4e27e8e5da3b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2354,7 +2354,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>         }
>
>         /* Look it up and read it in.. */
> -       folio =3D swap_cache_get_folio(swap, NULL, 0);
> +       folio =3D swap_cache_get_folio(swap);
>         if (!folio) {
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
>                         /* Direct swapin skipping swap cache & readahead =
*/
> @@ -2379,6 +2379,8 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>                         count_vm_event(PGMAJFAULT);
>                         count_memcg_event_mm(fault_mm, PGMAJFAULT);
>                 }
> +       } else {
> +               swap_update_readahead(folio, NULL, 0);
>         }
>
>         if (order > folio_order(folio)) {
> diff --git a/mm/swap.h b/mm/swap.h
> index 1ae44d4193b1..efb6d7ff9f30 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -62,8 +62,7 @@ void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>                                   unsigned long end);
>  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int=
 nr);
> -struct folio *swap_cache_get_folio(swp_entry_t entry,
> -               struct vm_area_struct *vma, unsigned long addr);
> +struct folio *swap_cache_get_folio(swp_entry_t entry);
>  struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>                 struct vm_area_struct *vma, unsigned long addr,
>                 struct swap_iocb **plug);
> @@ -74,6 +73,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry,=
 gfp_t flag,
>                 struct mempolicy *mpol, pgoff_t ilx);
>  struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
>                 struct vm_fault *vmf);
> +void swap_update_readahead(struct folio *folio, struct vm_area_struct *v=
ma,
> +                          unsigned long addr);
>
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
> @@ -159,6 +160,11 @@ static inline struct folio *swapin_readahead(swp_ent=
ry_t swp, gfp_t gfp_mask,
>         return NULL;
>  }
>
> +static inline void swap_update_readahead(struct folio *folio,
> +               struct vm_area_struct *vma, unsigned long addr)
> +{
> +}
> +
>  static inline int swap_writeout(struct folio *folio,
>                 struct swap_iocb **swap_plug)
>  {
> @@ -169,8 +175,7 @@ static inline void swapcache_clear(struct swap_info_s=
truct *si, swp_entry_t entr
>  {
>  }
>
> -static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
> -               struct vm_area_struct *vma, unsigned long addr)
> +static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
>  {
>         return NULL;
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 99513b74b5d8..68ec531d0f2b 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -69,6 +69,27 @@ void show_swap_cache_info(void)
>         printk("Total swap =3D %lukB\n", K(total_swap_pages));
>  }
>
> +/**
> + * swap_cache_get_folio - Looks up a folio in the swap cache.
> + * @entry: swap entry used for the lookup.
> + *
> + * A found folio will be returned unlocked and with its refcount increas=
ed.
> + *
> + * Context: Caller must ensure @entry is valid and protect the swap devi=
ce
> + * with reference count or locks.
> + * Return: Returns the found folio on success, NULL otherwise. The calle=
r
> + * must lock and check if the folio still matches the swap entry before
> + * use.
> + */
> +struct folio *swap_cache_get_folio(swp_entry_t entry)
> +{
> +       struct folio *folio =3D filemap_get_folio(swap_address_space(entr=
y),
> +                                               swap_cache_index(entry));
> +       if (IS_ERR(folio))
> +               return NULL;
> +       return folio;
> +}
> +
>  void *get_shadow_from_swap_cache(swp_entry_t entry)
>  {
>         struct address_space *address_space =3D swap_address_space(entry)=
;
> @@ -272,55 +293,43 @@ static inline bool swap_use_vma_readahead(void)
>         return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate=
_swap);
>  }
>
> -/*
> - * Lookup a swap entry in the swap cache. A found folio will be returned
> - * unlocked and with its refcount incremented - we rely on the kernel
> - * lock getting page table operations atomic even if we drop the folio
> - * lock before returning.
> - *
> - * Caller must lock the swap device or hold a reference to keep it valid=
.
> +/**
> + * swap_update_readahead - Update the readahead statistics of VMA or glo=
bally.
> + * @folio: the swap cache folio that just got hit.
> + * @vma: the VMA that should be updated, could be NULL for global update=
.
> + * @addr: the addr that triggered the swapin, ignored if @vma is NULL.
>   */
> -struct folio *swap_cache_get_folio(swp_entry_t entry,
> -               struct vm_area_struct *vma, unsigned long addr)
> +void swap_update_readahead(struct folio *folio, struct vm_area_struct *v=
ma,
> +                          unsigned long addr)
>  {
> -       struct folio *folio;
> -
> -       folio =3D filemap_get_folio(swap_address_space(entry), swap_cache=
_index(entry));
> -       if (!IS_ERR(folio)) {
> -               bool vma_ra =3D swap_use_vma_readahead();
> -               bool readahead;
> +       bool readahead, vma_ra =3D swap_use_vma_readahead();
>
> -               /*
> -                * At the moment, we don't support PG_readahead for anon =
THP
> -                * so let's bail out rather than confusing the readahead =
stat.
> -                */
> -               if (unlikely(folio_test_large(folio)))
> -                       return folio;
> -
> -               readahead =3D folio_test_clear_readahead(folio);
> -               if (vma && vma_ra) {
> -                       unsigned long ra_val;
> -                       int win, hits;
> -
> -                       ra_val =3D GET_SWAP_RA_VAL(vma);
> -                       win =3D SWAP_RA_WIN(ra_val);
> -                       hits =3D SWAP_RA_HITS(ra_val);
> -                       if (readahead)
> -                               hits =3D min_t(int, hits + 1, SWAP_RA_HIT=
S_MAX);
> -                       atomic_long_set(&vma->swap_readahead_info,
> -                                       SWAP_RA_VAL(addr, win, hits));
> -               }
> -
> -               if (readahead) {
> -                       count_vm_event(SWAP_RA_HIT);
> -                       if (!vma || !vma_ra)
> -                               atomic_inc(&swapin_readahead_hits);
> -               }
> -       } else {
> -               folio =3D NULL;
> +       /*
> +        * At the moment, we don't support PG_readahead for anon THP
> +        * so let's bail out rather than confusing the readahead stat.
> +        */
> +       if (unlikely(folio_test_large(folio)))
> +               return;
> +
> +       readahead =3D folio_test_clear_readahead(folio);
> +       if (vma && vma_ra) {
> +               unsigned long ra_val;
> +               int win, hits;
> +
> +               ra_val =3D GET_SWAP_RA_VAL(vma);
> +               win =3D SWAP_RA_WIN(ra_val);
> +               hits =3D SWAP_RA_HITS(ra_val);
> +               if (readahead)
> +                       hits =3D min_t(int, hits + 1, SWAP_RA_HITS_MAX);
> +               atomic_long_set(&vma->swap_readahead_info,
> +                               SWAP_RA_VAL(addr, win, hits));
>         }
>
> -       return folio;
> +       if (readahead) {
> +               count_vm_event(SWAP_RA_HIT);
> +               if (!vma || !vma_ra)
> +                       atomic_inc(&swapin_readahead_hits);
> +       }
>  }
>
>  struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
> @@ -336,14 +345,10 @@ struct folio *__read_swap_cache_async(swp_entry_t e=
ntry, gfp_t gfp_mask,
>         *new_page_allocated =3D false;
>         for (;;) {
>                 int err;
> -               /*
> -                * First check the swap cache.  Since this is normally
> -                * called after swap_cache_get_folio() failed, re-calling
> -                * that would confuse statistics.
> -                */
> -               folio =3D filemap_get_folio(swap_address_space(entry),
> -                                         swap_cache_index(entry));
> -               if (!IS_ERR(folio))
> +
> +               /* Check the swap cache in case the folio is already ther=
e */
> +               folio =3D swap_cache_get_folio(entry);
> +               if (folio)
>                         goto got_folio;
>
>                 /*
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index a7ffabbe65ef..4b8ab2cb49ca 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -213,15 +213,14 @@ static int __try_to_reclaim_swap(struct swap_info_s=
truct *si,
>                                  unsigned long offset, unsigned long flag=
s)
>  {
>         swp_entry_t entry =3D swp_entry(si->type, offset);
> -       struct address_space *address_space =3D swap_address_space(entry)=
;
>         struct swap_cluster_info *ci;
>         struct folio *folio;
>         int ret, nr_pages;
>         bool need_reclaim;
>
>  again:
> -       folio =3D filemap_get_folio(address_space, swap_cache_index(entry=
));
> -       if (IS_ERR(folio))
> +       folio =3D swap_cache_get_folio(entry);
> +       if (!folio)
>                 return 0;
>
>         nr_pages =3D folio_nr_pages(folio);
> @@ -2131,7 +2130,7 @@ static int unuse_pte_range(struct vm_area_struct *v=
ma, pmd_t *pmd,
>                 pte_unmap(pte);
>                 pte =3D NULL;
>
> -               folio =3D swap_cache_get_folio(entry, vma, addr);
> +               folio =3D swap_cache_get_folio(entry);
>                 if (!folio) {
>                         struct vm_fault vmf =3D {
>                                 .vma =3D vma,
> @@ -2357,8 +2356,8 @@ static int try_to_unuse(unsigned int type)
>                (i =3D find_next_to_unuse(si, i)) !=3D 0) {
>
>                 entry =3D swp_entry(type, i);
> -               folio =3D filemap_get_folio(swap_address_space(entry), sw=
ap_cache_index(entry));
> -               if (IS_ERR(folio))
> +               folio =3D swap_cache_get_folio(entry);
> +               if (!folio)
>                         continue;
>
>                 /*
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 50aaa8dcd24c..af61b95c89e4 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1489,9 +1489,8 @@ static long move_pages_ptes(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd
>                  * separately to allow proper handling.
>                  */
>                 if (!src_folio)
> -                       folio =3D filemap_get_folio(swap_address_space(en=
try),
> -                                       swap_cache_index(entry));
> -               if (!IS_ERR_OR_NULL(folio)) {
> +                       folio =3D swap_cache_get_folio(entry);
> +               if (folio) {
>                         if (folio_test_large(folio)) {
>                                 ret =3D -EBUSY;
>                                 folio_put(folio);
> --
> 2.51.0
>
>

