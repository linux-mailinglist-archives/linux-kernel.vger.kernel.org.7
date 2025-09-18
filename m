Return-Path: <linux-kernel+bounces-822741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6DB84902
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC7B4A846C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B87A2F7AC4;
	Thu, 18 Sep 2025 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gRLIcHko"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737202F90D8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198210; cv=none; b=b33mVTERF4lQOmtCCr7DUjirwbPNXH+syyOz+xvCtWcRZSe80h7zt2wGpZ2BWqmaFD1FMlUgPu5nPmBHUCK8o3HnWmGtfcXA/rWwhwyFvMPm9ld67ZMnobJGUjAyhvQSKrScey3X4Vbdsk7mnirLZ3n2mGdIHsuIHUF6bQTn9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198210; c=relaxed/simple;
	bh=aqi6B7ioBm41FAk4Q6fI3UWaKs+FmYaH6o18uB3O2Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pezW2HayFtB51PIUsJOEU1DU0Fo4BE/zCuzMGqg8xJMfe7mf+L6k2K5G9G5boG3eRggp0qB4nNAVSdDLURJy9zdTnSazwTcb+66qaXIV+jWFkboOEw3uTvou0K0YLSI6FDxLnohJHKr+sntuQd+qfy+V/qa6h2Otzleay/OliCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gRLIcHko; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCW6EUf3/KXCLS3mcuxuKmD892KTnzzA7DO3XomxKPNABRh0i0RH+Qo5lyVUj636DY0f7MuRcB2YKHXESAk=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758198205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8oe9XvHDnm2FWMpAdWBJmc/z4EhsPkQed7m2jR4/gU=;
	b=gRLIcHkoK0i7PM/hW83L25dukx6NJ3MWezhPKxE9/tQO+E5hw2nH0UD8eIY6UBSDE7bgQR
	lqpEozTntS225MSWnhmob2++JskvQ4fMHj7OcFomWFX/W791d1etoRl+XVLlIjI1srsOKM
	K+5dDUgFj5xdXF2QPEyiQQT5YIXRqa0=
X-Gm-Message-State: AOJu0YxRY6TLU+5LD0BAZNLt2mz6XYPCBXxyHgc5TnsKhYFM2wpK7GrC
	/Ln09MzpC0ZixwwKaXMvQjJm1ac2vIH0g4TE8cYFkZbb6mpSm5OCDRtXBjUlfKx+HyDcUXKHttf
	h/zAknuHb2VMFHxBAX9sHHF0H0VwMR1s=
X-Google-Smtp-Source: AGHT+IGz03gXmFndFmZXYJ3YHSREnajcpjVVXEW6eIe1D1uvauHGkpGBSqDskaN/nzj9+/P0PUMV5wngYh67XvI4jAA=
X-Received: by 2002:a05:6214:2aaf:b0:70d:6df4:1b21 with SMTP id
 6a1803df08f44-78ecf8e940amr56368016d6.62.1758198195042; Thu, 18 Sep 2025
 05:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
 <20240830100438.3623486-3-usamaarif642@gmail.com> <a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com>
 <434c092b-0f19-47bf-a5fa-ea5b4b36c35e@redhat.com>
In-Reply-To: <434c092b-0f19-47bf-a5fa-ea5b4b36c35e@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Thu, 18 Sep 2025 20:22:38 +0800
X-Gmail-Original-Message-ID: <CABzRoyYWQMFTGYgfC7N=cWMnL_+5Y05=jrMhFjBf1aKOGxzq5g@mail.gmail.com>
X-Gm-Features: AS18NWDbqrRo3FfsRakNQRuvHE-tDLRQdNj86jb0FFw9fBQ6yZ3X6shjFvDKfSg
Message-ID: <CABzRoyYWQMFTGYgfC7N=cWMnL_+5Y05=jrMhFjBf1aKOGxzq5g@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
To: David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "usamaarif642@gmail.com" <usamaarif642@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "yuzhao@google.com" <yuzhao@google.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	=?UTF-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>, 
	"npache@redhat.com" <npache@redhat.com>, "rppt@kernel.org" <rppt@kernel.org>, 
	"willy@infradead.org" <willy@infradead.org>, "kernel-team@meta.com" <kernel-team@meta.com>, 
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, 
	"cerasuolodomenico@gmail.com" <cerasuolodomenico@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ryncsn@gmail.com" <ryncsn@gmail.com>, 
	"surenb@google.com" <surenb@google.com>, "riel@surriel.com" <riel@surriel.com>, 
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	=?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= <chinwen.chang@mediatek.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	=?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"baohua@kernel.org" <baohua@kernel.org>, "kaleshsingh@google.com" <kaleshsingh@google.com>, 
	"zhais@google.com" <zhais@google.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 18, 2025 at 5:21=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.09.25 10:53, Qun-wei Lin (=E6=9E=97=E7=BE=A4=E5=B4=B4) wrote:
> > On Fri, 2024-08-30 at 11:03 +0100, Usama Arif wrote:
> >> From: Yu Zhao <yuzhao@google.com>
> >>
> >> Here being unused means containing only zeros and inaccessible to
> >> userspace. When splitting an isolated thp under reclaim or migration,
> >> the unused subpages can be mapped to the shared zeropage, hence
> >> saving
> >> memory. This is particularly helpful when the internal
> >> fragmentation of a thp is high, i.e. it has many untouched subpages.
> >>
> >> This is also a prerequisite for THP low utilization shrinker which
> >> will
> >> be introduced in later patches, where underutilized THPs are split,
> >> and
> >> the zero-filled pages are freed saving memory.
> >>
> >> Signed-off-by: Yu Zhao <yuzhao@google.com>
> >> Tested-by: Shuang Zhai <zhais@google.com>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>   include/linux/rmap.h |  7 ++++-
> >>   mm/huge_memory.c     |  8 ++---
> >>   mm/migrate.c         | 72 ++++++++++++++++++++++++++++++++++++++----
> >> --
> >>   mm/migrate_device.c  |  4 +--
> >>   4 files changed, 75 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> >> index 91b5935e8485..d5e93e44322e 100644
> >> --- a/include/linux/rmap.h
> >> +++ b/include/linux/rmap.h
> >> @@ -745,7 +745,12 @@ int folio_mkclean(struct folio *);
> >>   int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages,
> >> pgoff_t pgoff,
> >>                    struct vm_area_struct *vma);
> >>
> >> -void remove_migration_ptes(struct folio *src, struct folio *dst,
> >> bool locked);
> >> +enum rmp_flags {
> >> +    RMP_LOCKED              =3D 1 << 0,
> >> +    RMP_USE_SHARED_ZEROPAGE =3D 1 << 1,
> >> +};
> >> +
> >> +void remove_migration_ptes(struct folio *src, struct folio *dst, int
> >> flags);
> >>
> >>   /*
> >>    * rmap_walk_control: To control rmap traversing for specific needs
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 0c48806ccb9a..af60684e7c70 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3020,7 +3020,7 @@ bool unmap_huge_pmd_locked(struct
> >> vm_area_struct *vma, unsigned long addr,
> >>      return false;
> >>   }
> >>
> >> -static void remap_page(struct folio *folio, unsigned long nr)
> >> +static void remap_page(struct folio *folio, unsigned long nr, int
> >> flags)
> >>   {
> >>      int i =3D 0;
> >>
> >> @@ -3028,7 +3028,7 @@ static void remap_page(struct folio *folio,
> >> unsigned long nr)
> >>      if (!folio_test_anon(folio))
> >>              return;
> >>      for (;;) {
> >> -            remove_migration_ptes(folio, folio, true);
> >> +            remove_migration_ptes(folio, folio, RMP_LOCKED |
> >> flags);
> >>              i +=3D folio_nr_pages(folio);
> >>              if (i >=3D nr)
> >>                      break;
> >> @@ -3240,7 +3240,7 @@ static void __split_huge_page(struct page
> >> *page, struct list_head *list,
> >>
> >>      if (nr_dropped)
> >>              shmem_uncharge(folio->mapping->host, nr_dropped);
> >> -    remap_page(folio, nr);
> >> +    remap_page(folio, nr, PageAnon(head) ?
> >> RMP_USE_SHARED_ZEROPAGE : 0);
> >>
> >>      /*
> >>       * set page to its compound_head when split to non order-0
> >> pages, so
> >> @@ -3542,7 +3542,7 @@ int split_huge_page_to_list_to_order(struct
> >> page *page, struct list_head *list,
> >>              if (mapping)
> >>                      xas_unlock(&xas);
> >>              local_irq_enable();
> >> -            remap_page(folio, folio_nr_pages(folio));
> >> +            remap_page(folio, folio_nr_pages(folio), 0);
> >>              ret =3D -EAGAIN;
> >>      }
> >>
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 6f9c62c746be..d039863e014b 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -204,13 +204,57 @@ bool isolate_folio_to_list(struct folio *folio,
> >> struct list_head *list)
> >>      return true;
> >>   }
> >>
> >> +static bool try_to_map_unused_to_zeropage(struct
> >> page_vma_mapped_walk *pvmw,
> >> +                                      struct folio *folio,
> >> +                                      unsigned long idx)
> >> +{
> >> +    struct page *page =3D folio_page(folio, idx);
> >> +    bool contains_data;
> >> +    pte_t newpte;
> >> +    void *addr;
> >> +
> >> +    VM_BUG_ON_PAGE(PageCompound(page), page);
> >> +    VM_BUG_ON_PAGE(!PageAnon(page), page);
> >> +    VM_BUG_ON_PAGE(!PageLocked(page), page);
> >> +    VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
> >> +
> >> +    if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags &
> >> VM_LOCKED) ||
> >> +        mm_forbids_zeropage(pvmw->vma->vm_mm))
> >> +            return false;
> >> +
> >> +    /*
> >> +     * The pmd entry mapping the old thp was flushed and the pte
> >> mapping
> >> +     * this subpage has been non present. If the subpage is only
> >> zero-filled
> >> +     * then map it to the shared zeropage.
> >> +     */
> >> +    addr =3D kmap_local_page(page);
> >> +    contains_data =3D memchr_inv(addr, 0, PAGE_SIZE);
> >> +    kunmap_local(addr);
> >> +
> >> +    if (contains_data)
> >> +            return false;
> >> +
> >> +    newpte =3D pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
> >> +                                    pvmw->vma->vm_page_prot));
> >> +    set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte,
> >> newpte);
> >> +
> >> +    dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
> >> +    return true;
> >> +}
> >> +
> >> +struct rmap_walk_arg {
> >> +    struct folio *folio;
> >> +    bool map_unused_to_zeropage;
> >> +};
> >> +
> >>   /*
> >>    * Restore a potential migration pte to a working pte entry
> >>    */
> >>   static bool remove_migration_pte(struct folio *folio,
> >> -            struct vm_area_struct *vma, unsigned long addr, void
> >> *old)
> >> +            struct vm_area_struct *vma, unsigned long addr, void
> >> *arg)
> >>   {
> >> -    DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC |
> >> PVMW_MIGRATION);
> >> +    struct rmap_walk_arg *rmap_walk_arg =3D arg;
> >> +    DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->folio, vma, addr,
> >> PVMW_SYNC | PVMW_MIGRATION);
> >>
> >>      while (page_vma_mapped_walk(&pvmw)) {
> >>              rmap_t rmap_flags =3D RMAP_NONE;
> >> @@ -234,6 +278,9 @@ static bool remove_migration_pte(struct folio
> >> *folio,
> >>                      continue;
> >>              }
> >>   #endif
> >> +            if (rmap_walk_arg->map_unused_to_zeropage &&
> >> +                try_to_map_unused_to_zeropage(&pvmw, folio,
> >> idx))
> >> +                    continue;
> >>
> >>              folio_get(folio);
> >>              pte =3D mk_pte(new, READ_ONCE(vma->vm_page_prot));
> >> @@ -312,14 +359,21 @@ static bool remove_migration_pte(struct folio
> >> *folio,
> >>    * Get rid of all migration entries and replace them by
> >>    * references to the indicated page.
> >>    */
> >> -void remove_migration_ptes(struct folio *src, struct folio *dst,
> >> bool locked)
> >> +void remove_migration_ptes(struct folio *src, struct folio *dst, int
> >> flags)
> >>   {
> >> +    struct rmap_walk_arg rmap_walk_arg =3D {
> >> +            .folio =3D src,
> >> +            .map_unused_to_zeropage =3D flags &
> >> RMP_USE_SHARED_ZEROPAGE,
> >> +    };
> >> +
> >>      struct rmap_walk_control rwc =3D {
> >>              .rmap_one =3D remove_migration_pte,
> >> -            .arg =3D src,
> >> +            .arg =3D &rmap_walk_arg,
> >>      };
> >>
> >> -    if (locked)
> >> +    VM_BUG_ON_FOLIO((flags & RMP_USE_SHARED_ZEROPAGE) && (src !=3D
> >> dst), src);
> >> +
> >> +    if (flags & RMP_LOCKED)
> >>              rmap_walk_locked(dst, &rwc);
> >>      else
> >>              rmap_walk(dst, &rwc);
> >> @@ -934,7 +988,7 @@ static int writeout(struct address_space
> >> *mapping, struct folio *folio)
> >>       * At this point we know that the migration attempt cannot
> >>       * be successful.
> >>       */
> >> -    remove_migration_ptes(folio, folio, false);
> >> +    remove_migration_ptes(folio, folio, 0);
> >>
> >>      rc =3D mapping->a_ops->writepage(&folio->page, &wbc);
> >>
> >> @@ -1098,7 +1152,7 @@ static void migrate_folio_undo_src(struct folio
> >> *src,
> >>                                 struct list_head *ret)
> >>   {
> >>      if (page_was_mapped)
> >> -            remove_migration_ptes(src, src, false);
> >> +            remove_migration_ptes(src, src, 0);
> >>      /* Drop an anon_vma reference if we took one */
> >>      if (anon_vma)
> >>              put_anon_vma(anon_vma);
> >> @@ -1336,7 +1390,7 @@ static int migrate_folio_move(free_folio_t
> >> put_new_folio, unsigned long private,
> >>              lru_add_drain();
> >>
> >>      if (old_page_state & PAGE_WAS_MAPPED)
> >> -            remove_migration_ptes(src, dst, false);
> >> +            remove_migration_ptes(src, dst, 0);
> >>
> >>   out_unlock_both:
> >>      folio_unlock(dst);
> >> @@ -1474,7 +1528,7 @@ static int unmap_and_move_huge_page(new_folio_t
> >> get_new_folio,
> >>
> >>      if (page_was_mapped)
> >>              remove_migration_ptes(src,
> >> -                    rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : src,
> >> false);
> >> +                    rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : src, 0);
> >>
> >>   unlock_put_anon:
> >>      folio_unlock(dst);
> >> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> >> index 8d687de88a03..9cf26592ac93 100644
> >> --- a/mm/migrate_device.c
> >> +++ b/mm/migrate_device.c
> >> @@ -424,7 +424,7 @@ static unsigned long
> >> migrate_device_unmap(unsigned long *src_pfns,
> >>                      continue;
> >>
> >>              folio =3D page_folio(page);
> >> -            remove_migration_ptes(folio, folio, false);
> >> +            remove_migration_ptes(folio, folio, 0);
> >>
> >>              src_pfns[i] =3D 0;
> >>              folio_unlock(folio);
> >> @@ -840,7 +840,7 @@ void migrate_device_finalize(unsigned long
> >> *src_pfns,
> >>                      dst =3D src;
> >>              }
> >>
> >> -            remove_migration_ptes(src, dst, false);
> >> +            remove_migration_ptes(src, dst, 0);
> >>              folio_unlock(src);
> >>
> >>              if (folio_is_zone_device(src))
> >
> > Hi,
> >
> > This patch has been in the mainline for some time, but we recently
> > discovered an issue when both mTHP and MTE (Memory Tagging Extension)
> > are enabled.
> >
> > It seems that remapping to the same zeropage might causes MTE tag
> > mismatches, since MTE tags are associated with physical addresses.
>
> Does this only trigger when the VMA has mte enabled? Maybe we'll have to
> bail out if we detect that mte is enabled.

It seems RISC-V also has a similar feature (RISCV_ISA_SUPM) that uses
the same prctl(PR_{GET,SET}_TAGGED_ADDR_CTRL) API.

config RISCV_ISA_SUPM
        bool "Supm extension for userspace pointer masking"
        depends on 64BIT
        default y
        help
          Add support for pointer masking in userspace (Supm) when the
          underlying hardware extension (Smnpm or Ssnpm) is detected at boo=
t.

          If this option is disabled, userspace will be unable to use
          the prctl(PR_{SET,GET}_TAGGED_ADDR_CTRL) API.

I wonder if we should disable the THP shrinker for such architectures that
define PR_SET_TAGGED_ADDR_CTRL (or PR_GET_TAGGED_ADDR_CTRL).

Cheers,
Lance

>
> Also, I wonder how KSM and the shared zeropage works in general with
> that, because I would expect similar issues when we de-duplicate memory?
>
> --
> Cheers
>
> David / dhildenb
>
>

