Return-Path: <linux-kernel+bounces-775967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F55B2C6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560083BEE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF67B25F973;
	Tue, 19 Aug 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYduBSp+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE425B30D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613422; cv=none; b=Y1hoAzX1T5WkPD7hbwIC3+hdcqDnkHCKDruy0WqYZ3mWKOD/+Wan2zPq6hBEKP7eZ5btQMwv3TBHUVJlscJoKNLszQ7mHMBteOIxCLyTnmHBE5gOcIPYj8HQU7UNQm5O0oW7vhbmoL0nNAtms1HjJPcYrHmYMfGES24CJcbPdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613422; c=relaxed/simple;
	bh=Svo24zsBad1Yjo2p9ft9iXPbEuLvtl5ExtBxHBI5dC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hna2sA4EppOePjSaCt1orzHPOkS1Z/YUNd6Fa/nc60gSpy5Ujzi5cllZ/KfusT/k+W6DXWRM+n3ZKyGqFGPyIrUQKavt729jc/1fzfSYoiszGWgDzAK+dw5136sCuQGTxFnQI1BsAqm+hmrgQJMbvoorwVC5RSiw6j7bzgwk97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYduBSp+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755613419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3Yx3WbmFOJltwzECtqg3RoGKlDwwsG1Ihs41TRQMQI=;
	b=LYduBSp+CJ5NVLq1H9LvUtCPBLMqHtEWDd6Nhq472bvHROYAL7zO1uJ+F9SwhstRiIy9cR
	VMaYpz/IM6c6KzSODwj02+FNXqkWgGOs4+73z68obR9/9hyC9zrDTtXNOJbMcPL/xW9by8
	iiNq24A/+DYGo8a68ESg3tme+z6lUMU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-Yf9X84ZFPgS0dbQO-n3pCA-1; Tue, 19 Aug 2025 10:23:35 -0400
X-MC-Unique: Yf9X84ZFPgS0dbQO-n3pCA-1
X-Mimecast-MFC-AGG-ID: Yf9X84ZFPgS0dbQO-n3pCA_1755613415
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71d604dcc4dso75833687b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613414; x=1756218214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3Yx3WbmFOJltwzECtqg3RoGKlDwwsG1Ihs41TRQMQI=;
        b=oD63VFPeWN5unvVVw/h/YmxqAM9Omm6y5KRKkNV9kM0Q/GddqKXPdeCnxxGyHQX5Tm
         +u9DYVI++5NCSimqubtb2RlgetYGDvy6JRoa4uAeuCEH7C8WdOocICpGkVJtC+JgxnSx
         mrz6P8/CcK6thpFR82bvnIeejk7YcDhbemtAul9Fp92SiJgfq8mE8nswUxCSCBr/ftzp
         BPJuhLZ4vpd+uG17hgcZywaQHn48N+tyq4JpvYguHWJR4wQer3i95yWR4FBcmyhoz8CT
         yPGQ1cXNxS3U9FgGYeHdH0SNwOD7cDSgtaRSw7Z0fP2HkyPDuJ/bVLao4RYlqHK/FESq
         wyeg==
X-Forwarded-Encrypted: i=1; AJvYcCXrFEfSaWDCLmKDnwPymE5HXRjmFvEy0H2kY+uZ+d7kp7ZlqW8x4NhlbklWz1G6rVXunLcsXIPAQq95w08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfU+b+s1y8w0FyRZ+uez4H9HmGdij4Ma9NqGI28NNk/fdAtqG0
	0lfqt37nHEL6IB6us0RrEGmimpMzFDOz0sxsQ8PxVPe44rrNRstqMqSVc2c20WO7y7uUXCAWPEo
	bsmIwclimCdvt94POYan9g+jTCh8SrxMBBkYtzwDVwqp01w4DMNiIjFp5N2LvhB/TbPfTRExcDC
	dhYYasmuzlZpDwZzBtaF/mU4bPx4FsrAh5C+8Il5KQ
X-Gm-Gg: ASbGncsDAOgpO7l8Dr6+aOMCXAcgAyBsSq+Eo0UI+LGf8U7p5hUyedAl3vEtlgDiN2u
	FB2ITBb/WwbncsWN1G9/pPHqn5gGojOlEuRZna9ER4IizUXdPKOIxSf/FB77JW0izUmX3KhhbBS
	T8e091MBfcspwedMWdvoco1fY=
X-Received: by 2002:a05:6902:3302:b0:e90:6e1f:56b3 with SMTP id 3f1490d57ef6-e94e6094cd0mr2715172276.7.1755613414447;
        Tue, 19 Aug 2025 07:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnzwnibgt/XeaswLHQENR5+DMzayfV7924bb8m3+Q/0aGqUrDD2rGuExgIkd35TqRCyLnp3B2R4M4uEj5nITg=
X-Received: by 2002:a05:6902:3302:b0:e90:6e1f:56b3 with SMTP id
 3f1490d57ef6-e94e6094cd0mr2715129276.7.1755613414012; Tue, 19 Aug 2025
 07:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134824.623535-1-npache@redhat.com>
In-Reply-To: <20250819134824.623535-1-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 19 Aug 2025 08:23:07 -0600
X-Gm-Features: Ac12FXwnn2MMnUVTpNFBn4Ff3i8_FNGdV8T00Ku52kXw2sNhN4OlDuPKu8EOG9k
Message-ID: <CAA1CXcCS+eVoS_XyWgO2Xexwo-9pc_sUaTpmnet1EHqOGDGwWg@mail.gmail.com>
Subject: Re: [PATCH v10 12/13] khugepaged: add per-order mTHP khugepaged stats
To: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 7:49=E2=80=AFAM Nico Pache <npache@redhat.com> wrot=
e:
>
> With mTHP support inplace, let add the per-order mTHP stats for
> exceeding NONE, SWAP, and SHARED.
>
> Signed-off-by: Nico Pache <npache@redhat.com>

I had git send email error and had to resend this patch (12) and patch
13, but i forgot the in-reply-to
please ignore this one and reply to correct version

https://lore.kernel.org/lkml/20250819141610.626140-1-npache@redhat.com/
--in-reply-to=3D20250819141610.626140-1-npache@redhat.com


-- Nico

> ---
>  Documentation/admin-guide/mm/transhuge.rst | 17 +++++++++++++++++
>  include/linux/huge_mm.h                    |  3 +++
>  mm/huge_memory.c                           |  7 +++++++
>  mm/khugepaged.c                            | 16 +++++++++++++---
>  4 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 7ccb93e22852..b85547ac4fe9 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -705,6 +705,23 @@ nr_anon_partially_mapped
>         an anonymous THP as "partially mapped" and count it here, even th=
ough it
>         is not actually partially mapped anymore.
>
> +collapse_exceed_swap_pte
> +       The number of anonymous THP which contain at least one swap PTE.
> +       Currently khugepaged does not support collapsing mTHP regions tha=
t
> +       contain a swap PTE.
> +
> +collapse_exceed_none_pte
> +       The number of anonymous THP which have exceeded the none PTE thre=
shold.
> +       With mTHP collapse, a bitmap is used to gather the state of a PMD=
 region
> +       and is then recursively checked from largest to smallest order ag=
ainst
> +       the scaled max_ptes_none count. This counter indicates that the n=
ext
> +       enabled order will be checked.
> +
> +collapse_exceed_shared_pte
> +       The number of anonymous THP which contain at least one shared PTE=
.
> +       Currently khugepaged does not support collapsing mTHP regions tha=
t
> +       contain a shared PTE.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 4ada5d1f7297..6f1593d0b4b5 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -144,6 +144,9 @@ enum mthp_stat_item {
>         MTHP_STAT_SPLIT_DEFERRED,
>         MTHP_STAT_NR_ANON,
>         MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
> +       MTHP_STAT_COLLAPSE_EXCEED_SWAP,
> +       MTHP_STAT_COLLAPSE_EXCEED_NONE,
> +       MTHP_STAT_COLLAPSE_EXCEED_SHARED,
>         __MTHP_STAT_COUNT
>  };
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 20d005c2c61f..9f0470c3e983 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -639,6 +639,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_=
FAILED);
>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>  DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
>  DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIA=
LLY_MAPPED);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXCEE=
D_SWAP);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXCEE=
D_NONE);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_EXC=
EED_SHARED);
> +
>
>  static struct attribute *anon_stats_attrs[] =3D {
>         &anon_fault_alloc_attr.attr,
> @@ -655,6 +659,9 @@ static struct attribute *anon_stats_attrs[] =3D {
>         &split_deferred_attr.attr,
>         &nr_anon_attr.attr,
>         &nr_anon_partially_mapped_attr.attr,
> +       &collapse_exceed_swap_pte_attr.attr,
> +       &collapse_exceed_none_pte_attr.attr,
> +       &collapse_exceed_shared_pte_attr.attr,
>         NULL,
>  };
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index c13bc583a368..5a3386043f39 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -594,7 +594,9 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>                                 continue;
>                         } else {
>                                 result =3D SCAN_EXCEED_NONE_PTE;
> -                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +                               if (order =3D=3D HPAGE_PMD_ORDER)
> +                                       count_vm_event(THP_SCAN_EXCEED_NO=
NE_PTE);
> +                               count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_NONE);
>                                 goto out;
>                         }
>                 }
> @@ -633,10 +635,17 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
>                          * shared may cause a future higher order collaps=
e on a
>                          * rescan of the same range.
>                          */
> -                       if (order !=3D HPAGE_PMD_ORDER || (cc->is_khugepa=
ged &&
> -                           shared > khugepaged_max_ptes_shared)) {
> +                       if (order !=3D HPAGE_PMD_ORDER) {
> +                               result =3D SCAN_EXCEED_SHARED_PTE;
> +                               count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_SHARED);
> +                               goto out;
> +                       }
> +
> +                       if (cc->is_khugepaged &&
> +                           shared > khugepaged_max_ptes_shared) {
>                                 result =3D SCAN_EXCEED_SHARED_PTE;
>                                 count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
> +                               count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_SHARED);
>                                 goto out;
>                         }
>                 }
> @@ -1084,6 +1093,7 @@ static int __collapse_huge_page_swapin(struct mm_st=
ruct *mm,
>                  * range.
>                  */
>                 if (order !=3D HPAGE_PMD_ORDER) {
> +                       count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_=
SWAP);
>                         pte_unmap(pte);
>                         mmap_read_unlock(mm);
>                         result =3D SCAN_EXCEED_SWAP_PTE;
> --
> 2.50.1
>


