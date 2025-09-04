Return-Path: <linux-kernel+bounces-800745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74174B43B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFED41B21750
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121C2EA480;
	Thu,  4 Sep 2025 12:24:54 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C72E1C6F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988694; cv=none; b=DRnI6BWqdAc2Fi4abUmCFk1+HXGMdWN8Fz0cb8Nv4E26Qr4fgPLX3hfU3Ov07JrpCW5ueCfo1UMjaIp2mzeAEVCRcGgIYP2vA9V80DNnh14Ux1U/uIjT5c4KwPIdOnZHYLKuEk2D4/ePLiqttKla3YBPkgTiVrkVYD7PyEGQIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988694; c=relaxed/simple;
	bh=nlvI5R2I4d5Ekcq08wG77He1tpk7ggoqtMgPiSxHnGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZp0Wdbfkqau8j6eM7lMf1uUnju7YPsSs1hmFWIOZ/IEEB63O+0qgkSfsy3EokirpQi0xF36yBscTCMkS7MQ989XzbHY1yb1wNXu7eU/Gth4toYx4VonNtee2McMpbqayR0yVZg7sUTjYyw6sxQrt3pBLE4q8NZvwRTj/dYFw9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cHdvT1XnhzYlNNF;
	Thu,  4 Sep 2025 20:24:21 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 20:24:43 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 20:24:43 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <liulu.liu@honor.com>, <lorenzo.stoakes@oracle.com>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <surenb@google.com>,
	<tglx@linutronix.de>, <zhongjinji@honor.com>
Subject: Re: [PATCH v7 2/2] mm/oom_kill: The OOM reaper traverses the VMA maple tree in reverse order
Date: Thu, 4 Sep 2025 20:24:38 +0800
Message-ID: <20250904122438.22957-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aLg7ajpko2j1qV4h@tiehlicka>
References: <aLg7ajpko2j1qV4h@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a018.hihonor.com
 (10.68.17.250)

> On Wed 03-09-25 17:27:29, zhongjinji wrote:
> > Although the oom_reaper is delayed and it gives the oom victim chance to
> > clean up its address space this might take a while especially for
> > processes with a large address space footprint. In those cases
> > oom_reaper might start racing with the dying task and compete for shared
> > resources - e.g. page table lock contention has been observed.
> > 
> > Reduce those races by reaping the oom victim from the other end of the
> > address space.
> > 
> > It is also a significant improvement for process_mrelease(). When a process
> > is killed, process_mrelease is used to reap the killed process and often
> > runs concurrently with the dying task. The test data shows that after
> > applying the patch, lock contention is greatly reduced during the procedure
> > of reaping the killed process.
> 
> Thank you this is much better!
> 
> > Without the patch:
> > |--99.74%-- oom_reaper
> > |  |--76.67%-- unmap_page_range
> > |  |  |--33.70%-- __pte_offset_map_lock
> > |  |  |  |--98.46%-- _raw_spin_lock
> > |  |  |--27.61%-- free_swap_and_cache_nr
> > |  |  |--16.40%-- folio_remove_rmap_ptes
> > |  |  |--12.25%-- tlb_flush_mmu
> > |  |--12.61%-- tlb_finish_mmu
> > 
> > With the patch:
> > |--98.84%-- oom_reaper
> > |  |--53.45%-- unmap_page_range
> > |  |  |--24.29%-- [hit in function]
> > |  |  |--48.06%-- folio_remove_rmap_ptes
> > |  |  |--17.99%-- tlb_flush_mmu
> > |  |  |--1.72%-- __pte_offset_map_lock
> > |  |--30.43%-- tlb_finish_mmu
> 
> Just curious. Do I read this correctly that the overall speedup is
> mostly eaten by contention over tlb_finish_mmu?

Here is a more detailed perf report, which includes the execution times
of some important functions. I believe it will address your concerns.

tlb_flush_mmu and tlb_finish_mmu perform similar tasks; they both mainly
call free_pages_and_swap_cache, and its execution time is related to the
number of anonymous pages being reclaimed.

In previous tests, the pte spinlock contention was so obvious that I
overlooked other issues.

Without the patch
|--99.50%-- oom_reaper
|    |--0.50%-- [hit in function]
|    |--71.06%-- unmap_page_range
|    |    |--41.75%-- __pte_offset_map_lock
|    |    |--23.23%-- folio_remove_rmap_ptes
|    |    |--20.34%-- tlb_flush_mmu
|    |    |           free_pages_and_swap_cache
|    |    |--2.23%-- folio_mark_accessed
|    |    |--1.19%-- free_swap_and_cache_nr
|    |    |--1.13%-- __tlb_remove_folio_pages
|    |    |--0.76%-- _raw_spin_lock
|    |--16.02%-- tlb_finish_mmu
|    |    |--26.08%-- [hit in function]
|    |    |--72.97%-- free_pages_and_swap_cache
|    |    |--0.67%-- free_pages
|    |--2.27%-- folio_remove_rmap_ptes
|    |--1.54%-- __tlb_remove_folio_pages
|    |    |--83.47%-- [hit in function]
|    |--0.51%-- __pte_offset_map_lock

Period (ms)           Symbol
79.180156             oom_reaper
56.321241             unmap_page_range
23.891714             __pte_offset_map_lock
20.711614             free_pages_and_swap_cache
12.831778             tlb_finish_mmu
11.443282             tlb_flush_mmu

With the patch
|--99.54%-- oom_reaper
|    |--0.29%-- [hit in function]
|    |--57.91%-- unmap_page_range
|    |    |--20.42%-- [hit in function]
|    |    |--53.35%-- folio_remove_rmap_ptes
|    |    |    |--5.85%-- [hit in function]
|    |    |--10.49%-- __pte_offset_map_lock
|    |    |    |--5.17%-- [hit in function]
|    |    |--8.40%-- tlb_flush_mmu
|    |    |--2.35%-- _raw_spin_lock
|    |    |--1.89%-- folio_mark_accessed
|    |    |--1.64%-- __tlb_remove_folio_pages
|    |    |    |--57.95%-- [hit in function]
|    |--36.34%-- tlb_finish_mmu
|    |    |--14.70%-- [hit in function]
|    |    |--84.85%-- free_pages_and_swap_cache
|    |    |    |--2.32%-- [hit in function]
|    |    |--0.37%-- free_pages
|    |     --0.08%-- free_unref_page
|    |--1.94%-- folio_remove_rmap_ptes
|    |--1.68%-- __tlb_remove_folio_pages
|    |--0.93%-- __pte_offset_map_lock
|    |--0.43%-- folio_mark_accessed

Period (ms)           Symbol
49.580521             oom_reaper
28.781660             unmap_page_range
18.105898             tlb_finish_mmu
17.688397             free_pages_and_swap_cache
 3.471721             __pte_offset_map_lock
 2.412970             tlb_flush_mmu


> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> 
> Anyway, the change on its own makes sense to me
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks for working on the changelog improvements.

