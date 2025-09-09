Return-Path: <linux-kernel+bounces-808863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E269B50598
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552633B01B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2E0302741;
	Tue,  9 Sep 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tapbt60H"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FD226D1F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443924; cv=none; b=Kys4OMm4ZXVNyhQ+N4YXppK3bQb5bv90j9iU6YkgvxvExct8EePSTl5OkrB7gFVjqDYTYXxXPRRjZTvNiNDDy/JGOpZhul8QUaM+4HMo2GC/RdomHztypKwzRCu8u0koT6mx8d6bmONb/fJS4Yj0Epl9lR6HCQn4BcgaAc3DcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443924; c=relaxed/simple;
	bh=TcsIrI9a7FNZlawAyTnDT++aBGUDnxHF9Z6NLW3CvSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BL5Yvb0Ep/6gFMylbdE0Rztq2EtL0V+6wptJu54ojdF8AWzkHyn8gF/mLZyAnZU0Z3jaKbqvPitpQo1zm5BcNxVm9owv4Iqj7gBOI7k9q2wFRZqHcACBVLEn/o1dmiyBwtObg6EJM88bhKsgF7IulSXHiYQHCd4zKZmoIX+5kZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tapbt60H; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-412a2fe2f36so22765ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757443921; x=1758048721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAwDhU2WUoYnohm20pg+eapTEZHSXIxK7W5ZKC0ZArg=;
        b=tapbt60HiLUI4QoljJGEjvsSOv8u7JBaINXeRyL3wSoxitWuqJXoK7H9JObdXRX/zX
         Z7tfRUWQHnNaveR8ziwhwCEYO7muOIU48ZyJQlst3BZb23i7FGSrOMK5cnnVb5vxZS1l
         G9lnhMp+H4l0TZEgsByG8WUoNRp5wT5kaOSC8eOmHS+S2Paboq2vgV+NUGSVRtHMLxoB
         5dKMwCVvW1sPw7YFAOZiZe3vW/vyGEtNX1Q8bP+N0Pva8qDqRNORWamiYwB/2CKLHjzK
         Xc4xZJBK1G92XmvIzazhszbUMouOgCHxCktEM2JnskurRtMm8szoW3dBw3RPrWOc5e8P
         V68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443921; x=1758048721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAwDhU2WUoYnohm20pg+eapTEZHSXIxK7W5ZKC0ZArg=;
        b=G6N9odV3vxpiUrtgWduUBBD1obxOYTfxvOZPJKlABsPvdxZ7T5vAJ5Oqyd16BthVnG
         l4+kTAMYV//dhcwHqQL+MM7MpptKxzF2QTios0JBXQO4McCU6LZmT3WlrbuaHF2YURPT
         AE/2BggBzmm0WsMTNLfj5ruqEHjwHBuPlWoRUHYWkJc4P48p2bGqeasoIvDjjqqYwqYm
         YGVZKnvzMGX/EpbCi6JzZ6NAaO5Ca5T2BTceZPIf/A9aFT6SHQcssftHp8TzMXRRfyzG
         AgcJYbLs+1hDVeiBwqW09HV4T7sPDrWsw9wdALkOsjJSxYsJarKYf51bcQWdxN4OHuWo
         hF2A==
X-Forwarded-Encrypted: i=1; AJvYcCUgVltcyWkaJcRaMYg5GVL+PS/Tyt6Fg/PLU/pRmcEFpMR6Y6kUrACJcdQmKvAgFlx5PWhCbECBNB7Cn4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWT2z/2EaOdou78ToAtiqDcuS3Of2+YXmSE1lci3a48SfDtkDa
	bZJG113kAymoezH6pYtk9sYF3wkZWHXQMCM6JpT36iMBxFq/Najk2KD5Ot5557gn45A8AKHam3X
	jAVE6ZGM8ZrXvp8lBeSn7QVUQjhs+WetaVXmJS7U0
X-Gm-Gg: ASbGncsrJOF/XYF6+5lVF0yJym3u7Yrw8IaOtt8eN8I+ECVrnYt497tXoNdNY94ErID
	LO3scknV7MswuogFefHTULhvtwzhkA2IP1VY+u00VdXaLdcOcgc29kJEYM/QnxHJ/c9gbFSS/Ml
	t8l1y1TI2zH+hYReHe0Ak1j+5LRF0PFAKeqOFW5p/yU+F46AmJf+ajat5q2s8drjOyCSXkZJO70
	0gBymaAX8G0IFo=
X-Google-Smtp-Source: AGHT+IEKNjxibAxv1AfgJxTvJn5B0kzJMG6nPy7yfiMaYwP6fvdKYN5v/N8vavDSij2H8a/O9KlZs6Vgz5lU92981k4=
X-Received: by 2002:a05:6e02:250d:b0:400:7d06:dd68 with SMTP id
 e9e14a558f8ab-41655b596admr576495ab.14.1757443921008; Tue, 09 Sep 2025
 11:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908075028.38431-1-dev.jain@arm.com> <20250908075028.38431-3-dev.jain@arm.com>
In-Reply-To: <20250908075028.38431-3-dev.jain@arm.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Tue, 9 Sep 2025 11:51:23 -0700
X-Gm-Features: Ac12FXwgKz23RzNrJlXWoPmYg-m3zmsRje2pwnne6Wug2tegfeiTYXWBxKPK1qs
Message-ID: <CAAa6QmSf4yFMXrCLNgrk6jYGyceox_DtZ0uOOA5OgqOpmR7Ljg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: Drop all references of writable and SCAN_PAGE_RO
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, kas@kernel.org, 
	willy@infradead.org, hughd@google.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Dev.

On Mon, Sep 8, 2025 at 12:51=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
> Now that all actionable outcomes from checking pte_write() are gone,
> drop the related references.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Zach O'Keefe <zokeefe@google.com>


> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  include/trace/events/huge_memory.h | 19 ++++++-------------
>  mm/khugepaged.c                    | 14 +++-----------
>  2 files changed, 9 insertions(+), 24 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/hu=
ge_memory.h
> index 2305df6cb485..dd94d14a2427 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -19,7 +19,6 @@
>         EM( SCAN_PTE_NON_PRESENT,       "pte_non_present")              \
>         EM( SCAN_PTE_UFFD_WP,           "pte_uffd_wp")                  \
>         EM( SCAN_PTE_MAPPED_HUGEPAGE,   "pte_mapped_hugepage")          \
> -       EM( SCAN_PAGE_RO,               "no_writable_page")             \
>         EM( SCAN_LACK_REFERENCED_PAGE,  "lack_referenced_page")         \
>         EM( SCAN_PAGE_NULL,             "page_null")                    \
>         EM( SCAN_SCAN_ABORT,            "scan_aborted")                 \
> @@ -55,15 +54,14 @@ SCAN_STATUS
>
>  TRACE_EVENT(mm_khugepaged_scan_pmd,
>
> -       TP_PROTO(struct mm_struct *mm, struct folio *folio, bool writable=
,
> +       TP_PROTO(struct mm_struct *mm, struct folio *folio,
>                  int referenced, int none_or_zero, int status, int unmapp=
ed),
>
> -       TP_ARGS(mm, folio, writable, referenced, none_or_zero, status, un=
mapped),
> +       TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
>
>         TP_STRUCT__entry(
>                 __field(struct mm_struct *, mm)
>                 __field(unsigned long, pfn)
> -               __field(bool, writable)
>                 __field(int, referenced)
>                 __field(int, none_or_zero)
>                 __field(int, status)
> @@ -73,17 +71,15 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
>         TP_fast_assign(
>                 __entry->mm =3D mm;
>                 __entry->pfn =3D folio ? folio_pfn(folio) : -1;
> -               __entry->writable =3D writable;
>                 __entry->referenced =3D referenced;
>                 __entry->none_or_zero =3D none_or_zero;
>                 __entry->status =3D status;
>                 __entry->unmapped =3D unmapped;
>         ),
>
> -       TP_printk("mm=3D%p, scan_pfn=3D0x%lx, writable=3D%d, referenced=
=3D%d, none_or_zero=3D%d, status=3D%s, unmapped=3D%d",
> +       TP_printk("mm=3D%p, scan_pfn=3D0x%lx, referenced=3D%d, none_or_ze=
ro=3D%d, status=3D%s, unmapped=3D%d",
>                 __entry->mm,
>                 __entry->pfn,
> -               __entry->writable,
>                 __entry->referenced,
>                 __entry->none_or_zero,
>                 __print_symbolic(__entry->status, SCAN_STATUS),
> @@ -117,15 +113,14 @@ TRACE_EVENT(mm_collapse_huge_page,
>  TRACE_EVENT(mm_collapse_huge_page_isolate,
>
>         TP_PROTO(struct folio *folio, int none_or_zero,
> -                int referenced, bool  writable, int status),
> +                int referenced, int status),
>
> -       TP_ARGS(folio, none_or_zero, referenced, writable, status),
> +       TP_ARGS(folio, none_or_zero, referenced, status),
>
>         TP_STRUCT__entry(
>                 __field(unsigned long, pfn)
>                 __field(int, none_or_zero)
>                 __field(int, referenced)
> -               __field(bool, writable)
>                 __field(int, status)
>         ),
>
> @@ -133,15 +128,13 @@ TRACE_EVENT(mm_collapse_huge_page_isolate,
>                 __entry->pfn =3D folio ? folio_pfn(folio) : -1;
>                 __entry->none_or_zero =3D none_or_zero;
>                 __entry->referenced =3D referenced;
> -               __entry->writable =3D writable;
>                 __entry->status =3D status;
>         ),
>
> -       TP_printk("scan_pfn=3D0x%lx, none_or_zero=3D%d, referenced=3D%d, =
writable=3D%d, status=3D%s",
> +       TP_printk("scan_pfn=3D0x%lx, none_or_zero=3D%d, referenced=3D%d, =
status=3D%s",
>                 __entry->pfn,
>                 __entry->none_or_zero,
>                 __entry->referenced,
> -               __entry->writable,
>                 __print_symbolic(__entry->status, SCAN_STATUS))
>  );
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a0f1df2a7ae6..af5f5c80fe4e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -39,7 +39,6 @@ enum scan_result {
>         SCAN_PTE_NON_PRESENT,
>         SCAN_PTE_UFFD_WP,
>         SCAN_PTE_MAPPED_HUGEPAGE,
> -       SCAN_PAGE_RO,
>         SCAN_LACK_REFERENCED_PAGE,
>         SCAN_PAGE_NULL,
>         SCAN_SCAN_ABORT,
> @@ -557,7 +556,6 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>         struct folio *folio =3D NULL;
>         pte_t *_pte;
>         int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
> -       bool writable =3D false;
>
>         for (_pte =3D pte; _pte < pte + HPAGE_PMD_NR;
>              _pte++, address +=3D PAGE_SIZE) {
> @@ -671,9 +669,6 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>                      folio_test_referenced(folio) || mmu_notifier_test_yo=
ung(vma->vm_mm,
>                                                                      addr=
ess)))
>                         referenced++;
> -
> -               if (pte_write(pteval))
> -                       writable =3D true;
>         }
>
>         if (unlikely(cc->is_khugepaged && !referenced)) {
> @@ -681,13 +676,13 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
>         } else {
>                 result =3D SCAN_SUCCEED;
>                 trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
> -                                                   referenced, writable,=
 result);
> +                                                   referenced, result);
>                 return result;
>         }
>  out:
>         release_pte_pages(pte, _pte, compound_pagelist);
>         trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
> -                                           referenced, writable, result)=
;
> +                                           referenced, result);
>         return result;
>  }
>
> @@ -1280,7 +1275,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>         unsigned long _address;
>         spinlock_t *ptl;
>         int node =3D NUMA_NO_NODE, unmapped =3D 0;
> -       bool writable =3D false;
>
>         VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>
> @@ -1344,8 +1338,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>                         result =3D SCAN_PTE_UFFD_WP;
>                         goto out_unmap;
>                 }
> -               if (pte_write(pteval))
> -                       writable =3D true;
>
>                 page =3D vm_normal_page(vma, _address, pteval);
>                 if (unlikely(!page) || unlikely(is_zone_device_page(page)=
)) {
> @@ -1435,7 +1427,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>                 *mmap_locked =3D false;
>         }
>  out:
> -       trace_mm_khugepaged_scan_pmd(mm, folio, writable, referenced,
> +       trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
>                                      none_or_zero, result, unmapped);
>         return result;
>  }
> --
> 2.30.2
>
>

