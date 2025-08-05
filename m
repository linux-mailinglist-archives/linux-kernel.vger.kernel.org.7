Return-Path: <linux-kernel+bounces-755855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B8EB1AC8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577CD189E161
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 02:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752911E32D7;
	Tue,  5 Aug 2025 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzXN9p1E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301AC1DF759
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754362339; cv=none; b=tuSxOt6CipCU8ITDl1uXBI8GoCZxJs07pGX+fMW5stHc9TKJrQb+lTHa4JpRYczLFjtkdYBS0IP89HSZgEAPqvH1J1HbbdtckiUuSOIB6HRG7h0E60+9t7QbYtrKwDEucZeF/8/HXdccXTuYq6JD48mc87UxCSbtTBlMrxb8Xkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754362339; c=relaxed/simple;
	bh=xWrtF2tYxg+vd0XZ4zy3xUBL5mHYjDp8KuWsqUmiJ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvYIkByEyY0WOBGC9Prixz4N1Dai8oVdv1xa36y4OgKWtFgwaTq/0dplmkOqiFmV3LQ+mq3nK9082qDqEkFqWyofm6RSq3RqHLrg6UoSVaYZJxfRYJjTshn7OM1/xC28n6m880HSqRziM2Ni+00sluz2gltaQJi1HNAYCXUscBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzXN9p1E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754362338; x=1785898338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xWrtF2tYxg+vd0XZ4zy3xUBL5mHYjDp8KuWsqUmiJ64=;
  b=lzXN9p1EE5bqSNh3X2OPPuHd5BPtI04Sy9pOBDdokjBoR7fs+mw4iD9Z
   PYXVSvHtn30Q6hmfeQ8j6TEGovT6/p1H5o5vDoHo6AtbAfpqTZwTQopj7
   z4wn5j861brMVgYyCZ6bQ1fU6CBTC/6iC5DEEryyrTGfcvhNLVYp/9f/N
   FyE2KXqD839LjI2wB7kJeL+8V/2h13B6buBmjT91B7hBMtDWONQs+Wd8Z
   tAZ1T86s1YjmPc+zK1N0DBdnAbdw8pTVcRDmympr9KUJLgKXA9TT9lXqO
   xsebTWJJX+Enr+s3jD54FlPXAxuzX0WEbdqAAwmFUJbnTjFKbq3//TLJ4
   w==;
X-CSE-ConnectionGUID: xgNRSfV3T32evQ6dAoQYoQ==
X-CSE-MsgGUID: wCPpCsOrS7Crx2LYFXfGBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56558367"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="56558367"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 19:52:17 -0700
X-CSE-ConnectionGUID: +QD27GhQRrGOrsaI9i9K0w==
X-CSE-MsgGUID: jd9PHEawTMeqV1/KL6z4Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="195169335"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.53])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 19:52:14 -0700
Date: Tue, 5 Aug 2025 10:52:10 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>, yi1.lai@intel.com
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
Message-ID: <aJFx2mg5RRq1uzvR@ly-workstation>
References: <20250607220150.2980-1-21cnbao@gmail.com>
 <aJAFrYfyzGpbm+0m@ly-workstation>
 <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com>
 <CAGsJ_4ypaAySaWyatH4Vu_dz--gEXUWk3yAQwM_8JTdR6U3fQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4ypaAySaWyatH4Vu_dz--gEXUWk3yAQwM_8JTdR6U3fQA@mail.gmail.com>

On Tue, Aug 05, 2025 at 09:48:32AM +1200, Barry Song wrote:
> On Mon, Aug 4, 2025 at 7:57 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 04.08.25 02:58, Lai, Yi wrote:
> > > Hi Barry Song,
> > >
> > > Greetings!
> > >
> > > I used Syzkaller and found that there is general protection fault in __pte_offset_map_lock in linux-next next-20250801.
> > >
> > > After bisection and the first bad commit is:
> > > "
> > > a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
> > > "
> > >
> > > All detailed into can be found at:
> > > https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock
> > > Syzkaller repro code:
> > > https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock/repro.c
> > > Syzkaller repro syscall steps:
> [...]
> >
> > Skimming over the reproducer, we seem to have racing MADV_DONTNEED and
> > MADV_COLLAPSE on the same anon area, but the problem only shows up once
> > we tear down that MM.
> >
> 
> This seems to be where the race happens.
> Hi Lai, can you also double check if the below diff fixes the problem?
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 374a6a5193a7..6b40bdfd224c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1172,11 +1172,11 @@ static int collapse_huge_page(struct mm_struct
> *mm, unsigned long address,
>         if (result != SCAN_SUCCEED)
>                 goto out_up_write;
>         /* check if the pmd is still valid */
> +       vma_start_write(vma);
>         result = check_pmd_still_valid(mm, address, pmd);
>         if (result != SCAN_SUCCEED)
>                 goto out_up_write;
> 
> -       vma_start_write(vma);
>         anon_vma_lock_write(vma->anon_vma);
> 
>         mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
>

Applied this change on top of both linux-next next-20250801 and
next-20250804 separately. Issue cannot be reproduced using the
reproducer.
 
> > If I would have to guess, I'd assume it's related to PT_RECLAIM
> > reclaiming empty page tables during MADV_DONTNEED -- but the kconfig
> > does not indicate that CONFIG_PT_RECLAIM was set.
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
> 
> Thanks
> Barry

