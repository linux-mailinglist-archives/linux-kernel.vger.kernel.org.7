Return-Path: <linux-kernel+bounces-890802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08397C40FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F78434FAB9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B3B333448;
	Fri,  7 Nov 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWYsVaza";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpkxQiRx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8931CAA4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762535682; cv=none; b=p4OVh1jzI5A8j9ttm1vPZk4PPJcdFDfAtnj5vof8gxgR2WFTaTtfNmWOQwtlG0B5w9bNYx8SHv1PalQYq0AU9wgHOjaBADPzjEjJGDB+EMtM8dJERE6fu7zDWt6uwKCTnPPSbGMak1GhpVZqtXVvs0DMvGdEdvV6T1ejlnE9Yi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762535682; c=relaxed/simple;
	bh=3wlTv4phN7CVcv3vssAHD4JPd1JZYg4dSxbTxEbEGHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goKWhcqb0yv38tGxMGGuYqpiKDqF0TOUVZ/UEz86Lmr2EYGL7xMylF6gFpjmA7INvfC/dQ8KjHea11AwWfGp7nQ4C8+15Z8vRBuMpc9/3nkXv+KZ2YCodNmpVL5TZg9KPFaAGGZiIdqpnAJV5BR2dOdLrz8VeJVGXEwOxH3rQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWYsVaza; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpkxQiRx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762535679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsGhcNk2ubFrqi2YFZgLMZLjo4nT4sZ1uICkDs7Vo+k=;
	b=OWYsVazaIhlreai+rmh96D4sysHY45FtItorLND2BZvva8VocYiVMfFOz/GYgbl5e5CmIS
	5b/3XYiQbPo3ZIPpvq/a05SiqjP0TIqHhx9xOy3U/O7RalRmZvEbsX5KNCDvD0OJyJE5ZG
	4ahHlf7b8IWvR71PQD6C3yZRdSIUW0Q=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-dm1zga4dN3ml-gjnnA29lA-1; Fri, 07 Nov 2025 12:14:38 -0500
X-MC-Unique: dm1zga4dN3ml-gjnnA29lA-1
X-Mimecast-MFC-AGG-ID: dm1zga4dN3ml-gjnnA29lA_1762535677
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-787c89305a2so9912537b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762535677; x=1763140477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsGhcNk2ubFrqi2YFZgLMZLjo4nT4sZ1uICkDs7Vo+k=;
        b=UpkxQiRxwrukK3oqKM/UhAKyUiEJhgJXmkMVEoYWNclnWkD8855VDMD69tk1GEwxlr
         IcRFdrQRR1txDvqZEaAmVlQ6tL6KuNkpKCf1FGLG+McWXs1BIlDIOYOAhvJc4bMJvpeO
         FbI1j8dyC+wG56ixjgSNqLRSu71WW2W2RIw/ZqxRBv5Zut1aKWy83vUcuS3B0yO7GXqZ
         kA6UuX8rBuxd9vtc8z526NdXi6bPpK7QAq1tUWrO2Xe6Q49iq5+2IX+lwyXZ3Vo4Pr/4
         ZEUHN0Ym10ZmgdXabMyanTBrTaGuUP+JcJDzSKHCLL3h5Vuefs/EIjh5MlOPuU3igjL/
         BHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762535677; x=1763140477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lsGhcNk2ubFrqi2YFZgLMZLjo4nT4sZ1uICkDs7Vo+k=;
        b=T+6kUsWMtyzzolf51VTOGUT6k1LqJfIVE0ro4EKYIjMy3DaEJBwMxoI/SUS+RQo0uy
         OT7s7M+8N8WziQ9WjhK9UAnRz9bIlQi2kYgTi6Qh0ZBUN7bQxhMj7Hpto5Nij+FJp4E3
         U48+c0jRNtWF5GcU4PMIv0qKWNu30c14y7u9B8UoxOGFPvlGzffmCeU1+pazWmESqvgq
         GtgnI4a6d9NNl5TYuApqC9bAzd1OC14tVLgqdR26njWGqit2kXPvUQ+ujBbrnW7cwWnB
         p3JR5oVuN/aa2P4aY9DxjpmgSjbXB3sdVTYfmkDbmtqLpjImS0+xebIOMK0qHhabl2OT
         +lfQ==
X-Gm-Message-State: AOJu0Ywm+tqzhxLbnqAEZQ0kNusdeXe5H1KZb+ZczfF/1X4l7dUFhkWI
	uO0uRu+6v8w2JahSz7+UcR+1wY5ids/NvPSaIsPscgX2dqyLLFujlOvHlizKDj2YZHP1XetcYUJ
	Vzc4C97pSFG9ztf9JZtuIemZ6TbuQ2vOX0LKFx1vCkRLFyv7NIcaI0JDt+Ek+MaeeCcex3u2IxT
	nvi6Y/ZDIty+YbfG82sFHXy7craYEmnCWx+nPAXSmU
X-Gm-Gg: ASbGncujabeugKmH4erZWHCc04ZriiFXoTNeUTt+XAfhAUV53i2o9+z6GNuhD246icq
	UJMlOGKqRvFbUYtTGNm0N+B0v0MY8Gs8FtojgxCe+MTLsevpJArIB7Obu+ACGbVazY1blAoVLFA
	LZ9bZca9SI4Tbow19vgy/lbWsA1z6fGmqSRFBgaQc0hW9Dlj80XcN1jgyofAzKkk3CiukNGA==
X-Received: by 2002:a05:690c:868d:20b0:787:c2be:33ff with SMTP id 00721157ae682-787d537693fmr714657b3.20.1762535677331;
        Fri, 07 Nov 2025 09:14:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQek+0t4w48azAVl2zrNoGHztFPdW8lJvf083PafgskTvQqA5rrsO6WLqA1i+ny2NLFGpojXq6gxXmP3Am90Y=
X-Received: by 2002:a05:690c:868d:20b0:787:c2be:33ff with SMTP id
 00721157ae682-787d537693fmr714427b3.20.1762535676754; Fri, 07 Nov 2025
 09:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-10-npache@redhat.com>
 <ffcf2c28-d0ae-4a45-8693-10fb4dff8479@lucifer.local>
In-Reply-To: <ffcf2c28-d0ae-4a45-8693-10fb4dff8479@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Fri, 7 Nov 2025 10:14:10 -0700
X-Gm-Features: AWmQ_blPYWAWamFBzA1ly_X3usXllN1louZ3uBjkPVp_-hEefXw_Vu-oIqBHt-w
Message-ID: <CAA1CXcDT19rV_08pVP7CLuUZiVHW_1rSOv2oMXUHyRxh5sGCcA@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 09/15] khugepaged: add per-order mTHP collapse
 failure statistics
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:47=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Oct 22, 2025 at 12:37:11PM -0600, Nico Pache wrote:
> > Add three new mTHP statistics to track collapse failures for different
> > orders when encountering swap PTEs, excessive none PTEs, and shared PTE=
s:
> >
> > - collapse_exceed_swap_pte: Increment when mTHP collapse fails due to s=
wap
> >       PTEs
> >
> > - collapse_exceed_none_pte: Counts when mTHP collapse fails due to
> >       exceeding the none PTE threshold for the given order
> >
> > - collapse_exceed_shared_pte: Counts when mTHP collapse fails due to sh=
ared
> >       PTEs
> >
> > These statistics complement the existing THP_SCAN_EXCEED_* events by
> > providing per-order granularity for mTHP collapse attempts. The stats a=
re
> > exposed via sysfs under
> > `/sys/kernel/mm/transparent_hugepage/hugepages-*/stats/` for each
> > supported hugepage size.
> >
> > As we currently dont support collapsing mTHPs that contain a swap or
> > shared entry, those statistics keep track of how often we are
> > encountering failed mTHP collapses due to these restrictions.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  Documentation/admin-guide/mm/transhuge.rst | 23 ++++++++++++++++++++++
> >  include/linux/huge_mm.h                    |  3 +++
> >  mm/huge_memory.c                           |  7 +++++++
> >  mm/khugepaged.c                            | 16 ++++++++++++---
> >  4 files changed, 46 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 13269a0074d4..7c71cda8aea1 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -709,6 +709,29 @@ nr_anon_partially_mapped
> >         an anonymous THP as "partially mapped" and count it here, even =
though it
> >         is not actually partially mapped anymore.
> >
> > +collapse_exceed_none_pte
> > +       The number of anonymous mTHP pte ranges where the number of non=
e PTEs
>
> Ranges? Is the count per-mTHP folio? Or per PTE entry? Let's clarify.

I dont know the proper terminology. But what we have here is a range
of PTEs that is being considered for mTHP folio collapse; however, it
is still not a mTHP folio which is why I hesitated to call it that.

Given this counter is per mTHP size I think the proper way to say this woul=
d be:

The number of collapse attempts that failed due to exceeding the
max_ptes_none threshold.

>
> > +       exceeded the max_ptes_none threshold. For mTHP collapse, khugep=
aged
> > +       checks a PMD region and tracks which PTEs are present. It then =
tries
> > +       to collapse to the largest enabled mTHP size. The allowed numbe=
r of empty
>
> Well and then tries to collapse to the next and etc. right? So maybe wort=
h
> mentioning?
>
> > +       PTEs is the max_ptes_none threshold scaled by the collapse orde=
r. This
>
> I think this needs clarification, scaled how? Also obviously with the pro=
posed
> new approach we will need to correct this to reflect the 511/0 situation.
>
> > +       counter records the number of times a collapse attempt was skip=
ped for
> > +       this reason, and khugepaged moved on to try the next available =
mTHP size.
>
> OK you mention the moving on here, so for each attempted mTHP size which =
exeeds
> max_none_pte we increment this stat correct? Probably worth clarifying th=
at.
>
> > +
> > +collapse_exceed_swap_pte
> > +       The number of anonymous mTHP pte ranges which contain at least =
one swap
> > +       PTE. Currently khugepaged does not support collapsing mTHP regi=
ons
> > +       that contain a swap PTE. This counter can be used to monitor th=
e
> > +       number of khugepaged mTHP collapses that failed due to the pres=
ence
> > +       of a swap PTE.
>
> OK so as soon as we encounter a swap PTE we abort and this counts each in=
stance
> of that?
>
> I guess worth spelling that out? Given we don't support it, surely the op=
ening
> description should be 'The number of anonymous mTHP PTE ranges which were=
 unable
> to be collapsed due to containing one or more swap PTEs'.
>
> > +
> > +collapse_exceed_shared_pte
> > +       The number of anonymous mTHP pte ranges which contain at least =
one shared
> > +       PTE. Currently khugepaged does not support collapsing mTHP pte =
ranges
> > +       that contain a shared PTE. This counter can be used to monitor =
the
> > +       number of khugepaged mTHP collapses that failed due to the pres=
ence
> > +       of a shared PTE.
>
> Same comments as above.
>
> > +
> >  As the system ages, allocating huge pages may be expensive as the
> >  system uses memory compaction to copy data around memory to free a
> >  huge page for use. There are some counters in ``/proc/vmstat`` to help
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 3d29624c4f3f..4b2773235041 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -144,6 +144,9 @@ enum mthp_stat_item {
> >       MTHP_STAT_SPLIT_DEFERRED,
> >       MTHP_STAT_NR_ANON,
> >       MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
> > +     MTHP_STAT_COLLAPSE_EXCEED_SWAP,
> > +     MTHP_STAT_COLLAPSE_EXCEED_NONE,
> > +     MTHP_STAT_COLLAPSE_EXCEED_SHARED,
> >       __MTHP_STAT_COUNT
> >  };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 0063d1ba926e..7335b92969d6 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -638,6 +638,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLI=
T_FAILED);
> >  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >  DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
> >  DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PART=
IALLY_MAPPED);
> > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXC=
EED_SWAP);
> > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXC=
EED_NONE);
> > +DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_E=
XCEED_SHARED);
> > +
> >
> >  static struct attribute *anon_stats_attrs[] =3D {
> >       &anon_fault_alloc_attr.attr,
> > @@ -654,6 +658,9 @@ static struct attribute *anon_stats_attrs[] =3D {
> >       &split_deferred_attr.attr,
> >       &nr_anon_attr.attr,
> >       &nr_anon_partially_mapped_attr.attr,
> > +     &collapse_exceed_swap_pte_attr.attr,
> > +     &collapse_exceed_none_pte_attr.attr,
> > +     &collapse_exceed_shared_pte_attr.attr,
> >       NULL,
> >  };
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index d741af15e18c..053202141ea3 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -592,7 +592,9 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > -                             count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> > +                             if (order =3D=3D HPAGE_PMD_ORDER)
> > +                                     count_vm_event(THP_SCAN_EXCEED_NO=
NE_PTE);
> > +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_NONE);
> >                               goto out;
> >                       }
> >               }
> > @@ -622,10 +624,17 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
> >                        * shared may cause a future higher order collaps=
e on a
> >                        * rescan of the same range.
> >                        */
> > -                     if (order !=3D HPAGE_PMD_ORDER || (cc->is_khugepa=
ged &&
> > -                         shared > khugepaged_max_ptes_shared)) {
> > +                     if (order !=3D HPAGE_PMD_ORDER) {
>

Thanks for the review! I'll go clean these up for the next version

> A little nit/idea in general for series - since we do this order !=3D
> HPAGE_PMD_ORDER check all over, maybe have a predict function like:
>
> static bool is_mthp_order(unsigned int order)
> {
>         return order !=3D HPAGE_PMD_ORDER;
> }

sure!

>
> > +                             result =3D SCAN_EXCEED_SHARED_PTE;
> > +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_SHARED);
> > +                             goto out;
> > +                     }
> > +
> > +                     if (cc->is_khugepaged &&
> > +                         shared > khugepaged_max_ptes_shared) {
> >                               result =3D SCAN_EXCEED_SHARED_PTE;
> >                               count_vm_event(THP_SCAN_EXCEED_SHARED_PTE=
);
> > +                             count_mthp_stat(order, MTHP_STAT_COLLAPSE=
_EXCEED_SHARED);
>
> OK I _think_ I mentioned this in a previous revision so forgive me for be=
ing
> repetitious but we also count PMD orders here?
>
> But in the MTHP_STAT_COLLAPSE_EXCEED_NONE and MTP_STAT_COLLAPSE_EXCEED_SW=
AP
> cases we don't? Why's that?

Hmm I could have sworn I fixed that... perhaps I reintroduced the
missing stat update when I had to rebase/undo the cleanup series by
Lance. I will fix this.


Cheers.
-- Nico
>
>
> >                               goto out;
> >                       }
> >               }
> > @@ -1073,6 +1082,7 @@ static int __collapse_huge_page_swapin(struct mm_=
struct *mm,
> >                * range.
> >                */
> >               if (order !=3D HPAGE_PMD_ORDER) {
> > +                     count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_=
SWAP);
> >                       pte_unmap(pte);
> >                       mmap_read_unlock(mm);
> >                       result =3D SCAN_EXCEED_SWAP_PTE;
> > --
> > 2.51.0
> >
>
> Thanks, Lorenzo
>


