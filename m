Return-Path: <linux-kernel+bounces-804073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C3FB4697D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFD9583DE7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98427A123;
	Sat,  6 Sep 2025 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d+0Kqinv"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437125394B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757140563; cv=none; b=Yc10UrPomN55B99+iA1wymt/bmMrYJGwd8jvfRx9KzvlXfI89bzR0upO+UeLETixtulNCQV4Ls7tARVA4zNxrndNoBYvL1Lk+oVKlJVy6L32G6PZqHZkYZg1XVSNaMRRWe+UYw0dcQJ4YYVidJ3Wn2y69q7lcH+4gncRblWJFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757140563; c=relaxed/simple;
	bh=MnNLQEymmg4QobwarpARW49QkAOAEhylyeHtrEnsWpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQLNkWW7H1Gy+jkFkAv08TGucB0WNEAXHghNa2jZnmumD8HFEgmYm+Le+JD8480H7e0Rh1nug+uWj1ehuWbt3XPWa3F31JMd9JZMPOIgClmgTERW3MRFXEDXQm/UvkeVP+9+ic+zrYwl/tlr/UkaZpJPDRTeJ/QVZ9OHp5KegbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d+0Kqinv; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCWz9jUK4r2/Bdmh/NX+brG7hB0W2Iq95Yp5o5eedrsGxitBZtr6v5r336UsF0czBu6bTY9YLj4VTaB4z90=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757140558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZI+7xxBYSUjf2DkYRpNjguP0eowa/Qcb8yf8x4bp6o=;
	b=d+0Kqinv/l81lEXiPldvtXWHOhEelQmGVTy9O0A+U2SYMQ6Bho7ah+W/G4u6py6BEAhd7X
	lsA9AeeKVaHPonoOIAleXDXgBgKeY7lEe4Fjq4Xh8CkLJTd+3iGrWxFLWuaS8k3zgyA/SJ
	LRp1zEHVLy0hkx3KH4uk5IZJvCxtGIM=
X-Gm-Message-State: AOJu0YynfjT0mSyeVruXFzhy/UGbEIKb+RvP5wd35ideRHgIpa0VM9yD
	HZMjS/aqyZjbFTiHOsLTUEjW5EpfB7xBey2/gsnKTBSa7r8EMByG2kiK3/ecxI76je0/PJMwNJU
	QaAN4fuRR8iUVofUdLPzIRvvq362tV3c=
X-Google-Smtp-Source: AGHT+IGNxstH+GnVHJBOvOkXVFQ94aleFh61ynH/0fgSb7qxhJXuopaMmAthk78PTShzywiIxlJt1lhTtSRXJ8mx3gI=
X-Received: by 2002:a05:6214:2302:b0:712:9051:c001 with SMTP id
 6a1803df08f44-73922f67c33mr15297266d6.12.1757140556079; Fri, 05 Sep 2025
 23:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905141137.3529867-1-david@redhat.com> <7B0B1E09-5083-449F-851D-FD63D32D2B3D@nvidia.com>
 <2f4141b3-bd66-415d-b2ff-00544b03b908@redhat.com>
In-Reply-To: <2f4141b3-bd66-415d-b2ff-00544b03b908@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Sat, 6 Sep 2025 14:35:18 +0800
X-Gmail-Original-Message-ID: <CABzRoyb7_WfO6GmTnoUdDtejvchvW=xtsTbrdYtuhXD_9=cBfw@mail.gmail.com>
X-Gm-Features: Ac12FXwZXUX6523e25WuhUjfg2Wk6VLSjA3TWPpSs5qJfKafZ8u7MZFwTj20LIg
Message-ID: <CABzRoyb7_WfO6GmTnoUdDtejvchvW=xtsTbrdYtuhXD_9=cBfw@mail.gmail.com>
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 5, 2025 at 11:17=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 05.09.25 16:37, Zi Yan wrote:
> > On 5 Sep 2025, at 10:11, David Hildenbrand wrote:
> >
> >> We added an early exit in thp_underused(), probably to avoid scanning
> >> pages when there is no chance for success.
> >>
> >> However, assume we have max_ptes_none =3D 511 (default).
> >>
> >> Nothing should stop us from freeing all pages part of a THP that
> >> is completely zero (512) and khugepaged will for sure not try to
> >> instantiate a THP in that case (512 shared zeropages).
> >>
> >> This can just trivially happen if someone writes a single 0 byte into =
a
> >> PMD area, or of course, when data ends up being zero later.
> >>
> >> So let's remove that early exit.
> >>
> >> Do we want to CC stable? Hm, not sure. Probably not urgent.
> >>
> >> Note that, as default, the THP shrinker is active
> >> (/sys/kernel/mm/transparent_hugepage/shrink_underused =3D 1), and all
> >> THPs are added to the deferred split lists. However, with the
> >> max_ptes_none default we would never scan them. We would not do that. =
If
> >> that's not desirable, we should just disable the shrinker as default,
> >> also not adding all THPs to the deferred split lists.
> >>
> >> Easy to reproduce:
> >>
> >> 1) Allocate some THPs filled with 0s
> >>
> >> <prog.c>
> >>   #include <string.h>
> >>   #include <stdio.h>
> >>   #include <stdlib.h>
> >>   #include <unistd.h>
> >>   #include <sys/mman.h>
> >>
> >>   const size_t size =3D 1024*1024*1024;
> >>
> >>   int main(void)
> >>   {
> >>           size_t offs;
> >>           char *area;
> >>
> >>           area =3D mmap(0, size, PROT_READ | PROT_WRITE,
> >>                       MAP_ANON | MAP_PRIVATE, -1, 0);
> >>           if (area =3D=3D MAP_FAILED) {
> >>                   printf("mmap failed\n");
> >>                   exit(-1);
> >>           }
> >>           madvise(area, size, MADV_HUGEPAGE);
> >>
> >>           for (offs =3D 0; offs < size; offs +=3D getpagesize())
> >>                   area[offs] =3D 0;
> >>           pause();
> >>   }
> >> <\prog.c>
> >>
> >> 2) Trigger the shrinker
> >>
> >> E.g., memory pressure through memhog
> >>
> >> 3) Observe that THPs are not getting reclaimed
> >>
> >> $ cat /proc/`pgrep prog`/smaps_rollup
> >>
> >> Would list ~1GiB of AnonHugePages. With this fix, they would get
> >> reclaimed as expected.
> >>
> >> Fixes: dafff3f4c850 ("mm: split underused THPs")
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >> Cc: Zi Yan <ziy@nvidia.com>
> >> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> >> Cc: Nico Pache <npache@redhat.com>
> >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> Cc: Dev Jain <dev.jain@arm.com>
> >> Cc: Barry Song <baohua@kernel.org>
> >> Cc: Usama Arif <usamaarif642@gmail.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>   mm/huge_memory.c | 3 ---
> >>   1 file changed, 3 deletions(-)
> >>
> > LGTM. Acked-by: Zi Yan <ziy@nvidia.com>
> >
> > I also notice that thp_underused() checks num_zero_pages directly
> > against khugepaged_max_ptes_none. This means mTHPs will never be regard=
ed
> > as underused. A similar issue you are discussing in Nico=E2=80=99s khug=
epaged
> > mTHP support. Maybe checks against these khugepaged_max* variables
> > should be calculated based on nr_pages of a large folio, like
> > making these variables a ratio in other discussion.
>
> Yeah, factoring that out and cleaning it up is my next step.
>
> But note that mTHPs are not a candidate for the shrinker right now. (see
> my explanation in reply to Nicos patch)

Right. IIUC, the logic in deferred_split_scan() is gated by
!folio_test_partially_mapped(folio). This creates two paths:

1) Splits for mTHPs that are partially mapped. These set the flag and
corectly bypass thp_underused().

2) Optional shrinker splits for new or collapsed THPs. These don't set the
flag and must go through thp_underused().

So, thp_underused() is only for whole, PMD-sized THPs right now. Please
correct me if my understanding is wrong here ;)

Cheers,
Lance

