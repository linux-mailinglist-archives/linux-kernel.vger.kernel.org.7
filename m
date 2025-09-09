Return-Path: <linux-kernel+bounces-809121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D5CB508DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FA3442EF2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36FE26CE2F;
	Tue,  9 Sep 2025 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSFA++qd"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F324DD11
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757456850; cv=none; b=p3eamWOGTQpKJrg3k4rzgG2qGopo966F4w/98OX4oKFLhD92mEx0kGaW4WQ2zCl0OsrckDkItX84K2LCVeHV7KjegGK7x9dROLXh2yJOkjbnwyswUqZL+n8QwVMYi9vANCjH1NV5rN1kafqo4dGBRDcJatl2zVEcXJennm963qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757456850; c=relaxed/simple;
	bh=7WoXG1OFZx7rZPZb5YBfaQi+uE8iaPGL7TUtCjErU8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ew2ACo6hhHNq0QrpEpyX0iwfxOf2cBNj09xRCyp6zCAukyJJMZIzWyVD2J19udZvYci9XEF2wBkWlcY8TrdBxMRqBtzzFFJPrxX+UDc/3YLVKckCC9j1U94+Pm9BSlNL0cI6RzcFZMFIZ8OXpjNb80NEgJekpTU9jM3cXru3rAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSFA++qd; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b4bcb9638aso190621cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757456847; x=1758061647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8BzVWhX0R5cEUCY7Xkosw1VZPrvaUx+cbbGdJLdaNY=;
        b=aSFA++qdDoQ6KW7TCkdSpZ0rxPyrmMrkdd5suAyZ/QvkhBghDUumAHOHDkMdoHOAOb
         MwBJJ6Q9YmqUyBPpsgZrMk5J8llpMsMtf1q9yRlcR9vUO6jQdUACeGi7d27vVbvSzYqG
         BHPcX9ByifRUyt/8nBMOPwSQPJFQmmTpS5+d2Xz6QyHnHibm22ThazGOespQO1ce+Oi6
         PeS/N48wbqyiPFsUPzfArw9Ma9Oc5tCrp77DOKKOkx1upfl1uUWYy1MxUlUHiywa7QwL
         A772hyFyyMrYGcssgQUj7P/It0m+K+/hn6+LXrseM+6dc+QagLSAAZlcNDGj4LIHwe5c
         x1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757456847; x=1758061647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8BzVWhX0R5cEUCY7Xkosw1VZPrvaUx+cbbGdJLdaNY=;
        b=vO2EUfHCoTp+7rVOY2srvZthtYVJbyf5XouM9Z8otuKHJcR0TWCp0GX4x3UrhOwOc0
         f9QyaGwL0IFn+OqR1zy6/VMGRVW2qsuBlcTeHsFMw/DPrC/fPndfYryNZCFSx4DGm1Oy
         +2Yu7hrel8J4bq94D240+2l5Od3XlTvmB1NKh5gp0BlrL5P1r2DAwZR0p1rA7TMYps+R
         18H2JAey3HQt6fKCQaTBAmvIpHh7msSRfR8kET02j7Wv53+PxUw/1KyLKKt915/U1Aqm
         kfgxOOsa1sMd2ycYFLooeeNCUCKVzBa3Oo27LG7btJmert40XsRpw2JJFgEBudXNAA5F
         RygQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIDctw8Igz7XonmmBQed3tsvtWY0fIfc7toefeL3u/pktxFaBu9wNtO7z+AhsAgjkTPpr9mAISCajllfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRuk5mlm2AzMrx77kntYDUTLTFRHbwkgig2ZT7hrqPp5GCbtyv
	7K+ipXvycEva7tOcw4W3MEVZMICcML1vZLfY2DQiJgG3Z5tMpx+B0AQIid5QB1HO1VLbayinmYv
	fy+qqs7C6pV7k18d19oBj/GSv7tX4ObU4S8rcAUyk
X-Gm-Gg: ASbGncskgpB408roBcwuZpO4pkJSqqueTERDUFf71R0fUb4atFSSF5atYrOxpygMr0h
	7WAJj5hoSyeUhVg+R239abtFHj05UjIBcajSYUSYpmDUwMND93dOJ1J3ySyjFNpcBsZ+ekDUvQW
	BF52hTFaDvCwgQadyNDBCGsY3srfo0BzU5jUWu8fUGMxG9/2oGqEKEwA6TCwb5cXseDT6HhOPoc
	F+xSu0QytLQ8NwsIkftFyERp1idoLq9Rf3T3zJYPE3pH06lAUvy3nU=
X-Google-Smtp-Source: AGHT+IEdGi/d24y72Sxmx6WAkfXK/iDy1MEOtaD5CvEAQeQEYkSu881knGHU9baU8fe1W1ZSjLG2XGRiAndq5H5katk=
X-Received: by 2002:ac8:5d09:0:b0:4b3:46e4:38ee with SMTP id
 d75a77b69052e-4b625174b03mr1814331cf.6.1757456846670; Tue, 09 Sep 2025
 15:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com> <20250909190945.1030905-10-Liam.Howlett@oracle.com>
In-Reply-To: <20250909190945.1030905-10-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 15:27:15 -0700
X-Gm-Features: AS18NWDFXXcz2H0b4WCBtGCngTAlRviZ_OVajr-POu4PX9407-Nsa_TiEj-HyIA
Message-ID: <CAJuCfpHp2sgKBqrfyn+xfCJTA-AFGFUTdhSz4dxNff=SNYLJgg@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] mm: Use unmap_desc struct for freeing page tables.
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> Pass through the unmap_desc to free_pgtables() because it almost has
> everything necessary and is already on the stack.
>
> Updates testing code as necessary.
>
> No functional changes intended.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/internal.h                    |  5 +----
>  mm/memory.c                      | 21 ++++++++++-----------
>  mm/mmap.c                        |  6 +++---
>  mm/vma.c                         |  7 ++-----
>  tools/testing/vma/vma_internal.h | 11 ++---------
>  5 files changed, 18 insertions(+), 32 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 1239944f2830a..f22329967e908 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -445,10 +445,7 @@ bool __folio_end_writeback(struct folio *folio);
>  void deactivate_file_folio(struct folio *folio);
>  void folio_activate(struct folio *folio);
>
> -void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
> -                  struct vm_area_struct *start_vma, unsigned long floor,
> -                  unsigned long ceiling, unsigned long tree_max,
> -                  bool mm_wr_locked);
> +void free_pgtables(struct mmu_gather *tlb, struct unmap_desc *desc);
>
>  void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 8d4d976311037..98c5ffd28a109 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -387,15 +387,14 @@ void free_pgd_range(struct mmu_gather *tlb,
>   * The tree_max differs from the ceiling when a dup_mmap() failed and th=
e tree

"ceiling" is not a parameter anymore, so the comments should also change.

>   * has unrelated data to the mm_struct being torn down.
>   */
> -void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
> -                  struct vm_area_struct *vma, unsigned long floor,
> -                  unsigned long ceiling, unsigned long tree_max,
> -                  bool mm_wr_locked)
> +void free_pgtables(struct mmu_gather *tlb, struct unmap_desc *desc)
>  {
>         struct unlink_vma_file_batch vb;
> +       struct ma_state *mas =3D desc->mas;
> +       struct vm_area_struct *vma =3D desc->first;
>
>         /* underflow can happen and is fine */
> -       WARN_ON_ONCE(tree_max - 1 > ceiling - 1);
> +       WARN_ON_ONCE(desc->tree_max - 1 > desc->last_pgaddr - 1);
>
>         tlb_free_vmas(tlb);
>
> @@ -407,13 +406,13 @@ void free_pgtables(struct mmu_gather *tlb, struct m=
a_state *mas,
>                  * Note: USER_PGTABLES_CEILING may be passed as ceiling a=
nd may
>                  * be 0.  This will underflow and is okay.
>                  */
> -               next =3D mas_find(mas, tree_max - 1);
> +               next =3D mas_find(mas, desc->tree_max - 1);
>
>                 /*
>                  * Hide vma from rmap and truncate_pagecache before freei=
ng
>                  * pgtables
>                  */
> -               if (mm_wr_locked)
> +               if (desc->mm_wr_locked)
>                         vma_start_write(vma);
>                 unlink_anon_vmas(vma);
>
> @@ -425,16 +424,16 @@ void free_pgtables(struct mmu_gather *tlb, struct m=
a_state *mas,
>                  */
>                 while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE=
) {
>                         vma =3D next;
> -                       next =3D mas_find(mas, tree_max - 1);
> -                       if (mm_wr_locked)
> +                       next =3D mas_find(mas, desc->tree_max - 1);
> +                       if (desc->mm_wr_locked)
>                                 vma_start_write(vma);
>                         unlink_anon_vmas(vma);
>                         unlink_file_vma_batch_add(&vb, vma);
>                 }
>                 unlink_file_vma_batch_final(&vb);
>
> -               free_pgd_range(tlb, addr, vma->vm_end,
> -                       floor, next ? next->vm_start : ceiling);
> +               free_pgd_range(tlb, addr, vma->vm_end, desc->first_pgaddr=
,
> +                              next ? next->vm_start : desc->last_pgaddr)=
;

Much better names IMO. Thank you!

>                 vma =3D next;
>         } while (vma);
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6011f62b0a294..9908481452780 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1311,10 +1311,10 @@ void exit_mmap(struct mm_struct *mm)
>          */
>         mm_flags_set(MMF_OOM_SKIP, mm);
>         mmap_write_lock(mm);
> +       unmap.mm_wr_locked =3D true;
>         mt_clear_in_rcu(&mm->mm_mt);
> -       vma_iter_set(&vmi, vma->vm_end);
> -       free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS,
> -                     USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true)=
;
> +       vma_iter_set(&vmi, unmap.tree_reset);
> +       free_pgtables(&tlb, &unmap);
>         tlb_finish_mmu(&tlb);
>
>         /*
> diff --git a/mm/vma.c b/mm/vma.c
> index ad64cd9795ef3..ba155a539d160 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -476,16 +476,13 @@ void remove_vma(struct vm_area_struct *vma)
>  void unmap_region(struct unmap_desc *desc)
>  {
>         struct mm_struct *mm =3D desc->first->vm_mm;
> -       struct ma_state *mas =3D desc->mas;
>         struct mmu_gather tlb;
>
>         tlb_gather_mmu(&tlb, mm);
>         update_hiwater_rss(mm);
>         unmap_vmas(&tlb, desc);
> -       mas_set(mas, desc->tree_reset);
> -       free_pgtables(&tlb, mas, desc->first, desc->first_pgaddr,
> -                     desc->last_pgaddr, desc->tree_max,
> -                     desc->mm_wr_locked);
> +       mas_set(desc->mas, desc->tree_reset);
> +       free_pgtables(&tlb, desc);
>         tlb_finish_mmu(&tlb);
>  }
>
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index d73ad4747d40a..435c5a24480bc 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -892,17 +892,10 @@ static inline void unmap_vmas(struct mmu_gather *tl=
b, struct unmap_desc *unmap)
>         (void)unmap;
>  }
>
> -static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state=
 *mas,
> -                  struct vm_area_struct *vma, unsigned long floor,
> -                  unsigned long ceiling, unsigned long tree_max,
> -                  bool mm_wr_locked)
> +static inline void free_pgtables(struct mmu_gather *tlb, struct unmap_de=
sc *desc)
>  {
>         (void)tlb;
> -       (void)mas;
> -       (void)vma;
> -       (void)floor;
> -       (void)ceiling;
> -       (void)mm_wr_locked;
> +       (void)desc;
>  }
>
>  static inline void mapping_unmap_writable(struct address_space *)
> --
> 2.47.2
>

