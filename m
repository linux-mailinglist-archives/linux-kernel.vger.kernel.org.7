Return-Path: <linux-kernel+bounces-761771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD861B1FE43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE890178515
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DEC243951;
	Mon, 11 Aug 2025 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJd6knnd"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C648F6F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754884551; cv=none; b=Sn7g21rhrPfJ+8YVhUn8FLSfGxW+1FXr48WAI4rFyLvXizwayiheEma9LnsiqtDeNud9tCKJQA2zW+tzTrBRdLtlK/MZKzH3dgijtFvzp15pr4lhWHKOmXCLVPTvffGlAXqWGP1W5X2wA6n7gBDI3CKnzGTmXTf+pXF8OLs6zYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754884551; c=relaxed/simple;
	bh=3V6Z5JKq1+MeuE22CP60FTPota4GGPjBqp6UZV49FE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kc2eMJ2K8uTYW4DlIDyLCrCT4aSsVnR3YgFY813cCugPnAIJ2cxXBzUWiC8ZkX/55BOC1azpDaMMJbqyWdOZkWINJZ92qmc9slyDT4kxFVYlfehG50goVCwAjUjTiile88DESReP3jV2C/k8yNJaSqkptsgj4gsB9d5klimVvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJd6knnd; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4fe7dd45935so1610504137.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 20:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754884548; x=1755489348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Gh4o/ThwRa02/v9W2VdfL5emsZEKvd+UE9SPTqW1Qw=;
        b=aJd6knndNiJxhACv+McmUT77BiLK6zQg1Em2cbcrfY4DD4oenMi9QkG8H+Vq6+LM/v
         xOHq129Fd0ZMyzw35Bey3JmrH44dIl17vzq2r0U61gGoulFrc6x3wT4rCoxHVDUrZz+1
         ucDCHGe0EPLgs9syDxMXb9C2//IhvdupyHEY8SCGHpianOZ3o8HwfaytI0RTnPrGMAwL
         PbcdF7mJXjYz6MnwMW1y16M8mB/XgHwnfSVfT846M3ROW81lVFw9lh11O+cYjD6bdsC4
         5EXyP+7H/iiO5DfBN4T0i7Mps41/n1uBCT3cjV1gN0NCpjW8zm3HpIHIrzoRntfS1gOG
         j+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754884548; x=1755489348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Gh4o/ThwRa02/v9W2VdfL5emsZEKvd+UE9SPTqW1Qw=;
        b=hMyyBzBY+cEPStyCbWwJHRJQkL+MTdA+4rQ6dxc4NaLiREcuwVusdJnA/K60NGI6up
         TU5mpKjLmfMcElYA4gBF0g1q7DuNAjuiFOUv143H44WoVXj+ITMr90FoQcTMsFf8Oszq
         VILVSF5gSFav1afM7+dqdDebbGY3szYsFiwqENoi9CAZDAVc2TgRny49yIErhTegFuH/
         ABAvPKt+fz4dFTfoK+3kh1xs6OJDlkM04VF8GSK0rUOI2wV+LcSAD5tfseutHavEws/u
         XeMgcOzmAfSMGyqETAIDIw1Gff4GP0g/0ieYnU5KPi5c1D/rmktu67DW5aGPjifmVuAs
         QAzw==
X-Forwarded-Encrypted: i=1; AJvYcCXChOscNGNKw3C40bIU5rg/Q+z39OIDGEfeg+3OKzPPi1bSWV/j6jQQuHBrgCv4Ijs1R/SMMjXOtN/9eNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSkSE4FVW/ofw/A4vukHRZXxwuZiaOpkoxtGkvA+B8jyaLYFoN
	LAe3zuOk9lmi6o7MdA+hZo2aQX/v0d5jMzhCdauQP/btIB7DLf3D07WiUHloTzL98v3AU1Y+Zki
	J1LUCsGzTG44ayQ1tTZAbDJdIqLsRhE8=
X-Gm-Gg: ASbGncsNXj/pyRcWvrDGSNvZrUC1gYDBVPjgwCrSzNi0uQHAd0DtLXEOuh5ZxhPLUax
	OHPcdjTJuDdetT5UyTfTdgoAPDxVb8vikDSZCb9DCQJBke3ZlPERbnRQSnbYAE9AhkvBifVA+rR
	rQTOu5hY4MTojTvIIK2bjJQjoX8rEZ5irGU3NIs3kL3WIuRAH0far4x+4vq17q0gbIg6BLQCn2/
	mMxC68=
X-Google-Smtp-Source: AGHT+IFuCuY5dTS+gnjZcz8kZyq/PTrA6lRvEfUTYKjHfwC/P//oJLtzXwRySSL/4pDgGVaHOn5dc67+foYoBpF+dJU=
X-Received: by 2002:a05:6102:1516:b0:4ec:c548:e10e with SMTP id
 ada2fe7eead31-5060d9e08d1mr4041717137.3.1754884548093; Sun, 10 Aug 2025
 20:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810062912.1096815-1-lokeshgidra@google.com>
In-Reply-To: <20250810062912.1096815-1-lokeshgidra@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 11 Aug 2025 11:55:36 +0800
X-Gm-Features: Ac12FXzbJ-_yy5er3Lm57YLRpVrw9PyphF4Al2lvVnCy5IbrGwHuniddeoo8dnA
Message-ID: <CAGsJ_4wbXkfaAn+79g20SfE-0Ak4QACVP+Mw2vAvMnxBCcLAsQ@mail.gmail.com>
Subject: Re: [PATCH v4] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lokesh,


On Sun, Aug 10, 2025 at 2:29=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> for moving present pages. Mitigate this cost by opportunistically
> batching present contiguous pages for TLB flushing.
>
> Without batching, in our testing on an arm64 Android device with UFFD GC,
> which uses MOVE ioctl for compaction, we observed that out of the total
> time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> ~20% in vm_normal_folio().
>
> With batching, the proportion of vm_normal_folio() increases to over
> 70% of move_pages_pte() without any changes to vm_normal_folio().
> Furthermore, time spent within move_pages_pte() is only ~20%, which
> includes TLB-flush overhead.
>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
> Changes since v3 [1]
> - Fix unintialized 'step_size' warning, per Dan Carpenter
> - Removed pmd_none() from check_ptes_for_batched_move(), per Peter Xu
> - Removed flush_cache_range() in zero-page case, per Peter Xu
> - Added comment to explain why folio reference for batched pages is not
>   required, per Peter Xu
> - Use MIN() in calculation of largest extent that can be batched under
>   the same src and dst PTLs, per Peter Xu
> - Release first folio's reference in move_present_ptes(), per Peter Xu
>
> Changes since v2 [2]
> - Addressed VM_WARN_ON failure, per Lorenzo Stoakes
> - Added check to ensure all batched pages share the same anon_vma
>
> Changes since v1 [3]
> - Removed flush_tlb_batched_pending(), per Barry Song
> - Unified single and multi page case, per Barry Song
>
> [1] https://lore.kernel.org/all/20250807103902.2242717-1-lokeshgidra@goog=
le.com/
> [2] https://lore.kernel.org/all/20250805121410.1658418-1-lokeshgidra@goog=
le.com/
> [3] https://lore.kernel.org/all/20250731104726.103071-1-lokeshgidra@googl=
e.com/
>
>  mm/userfaultfd.c | 178 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 127 insertions(+), 51 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index cbed91b09640..39d81d2972db 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1026,18 +1026,64 @@ static inline bool is_pte_pages_stable(pte_t *dst=
_pte, pte_t *src_pte,
>                pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
>  }
>
> -static int move_present_pte(struct mm_struct *mm,
> -                           struct vm_area_struct *dst_vma,
> -                           struct vm_area_struct *src_vma,
> -                           unsigned long dst_addr, unsigned long src_add=
r,
> -                           pte_t *dst_pte, pte_t *src_pte,
> -                           pte_t orig_dst_pte, pte_t orig_src_pte,
> -                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> -                           spinlock_t *dst_ptl, spinlock_t *src_ptl,
> -                           struct folio *src_folio)
> +/*
> + * Checks if the two ptes and the corresponding folio are eligible for b=
atched
> + * move. If so, then returns pointer to the locked folio. Otherwise, ret=
urns NULL.
> + *
> + * NOTE: folio's reference is not required as the whole operation is wit=
hin
> + * PTL's critical section.
> + */
> +static struct folio *check_ptes_for_batched_move(struct vm_area_struct *=
src_vma,
> +                                                unsigned long src_addr,
> +                                                pte_t *src_pte, pte_t *d=
st_pte,
> +                                                struct anon_vma *src_ano=
n_vma)
> +{
> +       pte_t orig_dst_pte, orig_src_pte;
> +       struct folio *folio;
> +
> +       orig_dst_pte =3D ptep_get(dst_pte);
> +       if (!pte_none(orig_dst_pte))
> +               return NULL;
> +
> +       orig_src_pte =3D ptep_get(src_pte);
> +       if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_src_pt=
e)))
> +               return NULL;
> +
> +       folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
> +       if (!folio || !folio_trylock(folio))
> +               return NULL;
> +       if (!PageAnonExclusive(&folio->page) || folio_test_large(folio) |=
|
> +           folio_anon_vma(folio) !=3D src_anon_vma) {
> +               folio_unlock(folio);
> +               return NULL;
> +       }
> +       return folio;
> +}
> +

I=E2=80=99m still quite confused by the code. Before move_present_ptes(), w=
e=E2=80=99ve
already performed all the checks=E2=80=94pte_same(), vm_normal_folio(),
folio_trylock(), folio_test_large(), folio_get_anon_vma(),
and anon_vma_lock_write()=E2=80=94at least for the first PTE. Now we=E2=80=
=99re
duplicating them again for all PTEs. Does this mean we=E2=80=99re doing tho=
se
operations for the first PTE twice? It feels like the old non-batch check
code should be removed?

> +static long move_present_ptes(struct mm_struct *mm,
> +                             struct vm_area_struct *dst_vma,
> +                             struct vm_area_struct *src_vma,
> +                             unsigned long dst_addr, unsigned long src_a=
ddr,
> +                             pte_t *dst_pte, pte_t *src_pte,
> +                             pte_t orig_dst_pte, pte_t orig_src_pte,
> +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> +                             spinlock_t *dst_ptl, spinlock_t *src_ptl,
> +                             struct folio **first_src_folio, unsigned lo=
ng len,
> +                             struct anon_vma *src_anon_vma)
>  {
>         int err =3D 0;
> +       struct folio *src_folio =3D *first_src_folio;
> +       unsigned long src_start =3D src_addr;
> +       unsigned long addr_end;
> +
> +       if (len > PAGE_SIZE) {
> +               addr_end =3D (dst_addr + PMD_SIZE) & PMD_MASK;
> +               len =3D MIN(addr_end - dst_addr, len);
>
> +               addr_end =3D (src_addr + PMD_SIZE) & PMD_MASK;
> +               len =3D MIN(addr_end - src_addr, len);
> +       }

We already have a pmd_addr_end() helper=E2=80=94can we reuse it?

[...]

>         /*
> @@ -1257,7 +1327,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd,
>                 if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
>                         err =3D -ENOENT;
>                 else /* nothing to do to move a hole */
> -                       err =3D 0;
> +                       err =3D PAGE_SIZE;

To be honest, I find `err =3D PAGE_SIZE` quite odd :-) Could we refine the
code to make it more readable?

[...]

> @@ -1857,10 +1930,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, u=
nsigned long dst_start,
>                                 break;
>                         }
>
> -                       err =3D move_pages_pte(mm, dst_pmd, src_pmd,
> -                                            dst_vma, src_vma,
> -                                            dst_addr, src_addr, mode);
> -                       step_size =3D PAGE_SIZE;
> +                       ret =3D move_pages_ptes(mm, dst_pmd, src_pmd,
> +                                             dst_vma, src_vma, dst_addr,
> +                                             src_addr, src_end - src_add=
r, mode);
> +                       if (ret < 0)
> +                               err =3D ret;
> +                       else
> +                               step_size =3D ret;

also looks a bit strange :-)

>                 }
>
>                 cond_resched();
>
> base-commit: 561c80369df0733ba0574882a1635287b20f9de2
> --
> 2.50.1.703.g449372360f-goog
>

Thanks
Barry

