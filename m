Return-Path: <linux-kernel+bounces-800784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB2B43C05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB835A3D96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2952FD7A3;
	Thu,  4 Sep 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="khXUWC3B"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1B5464D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990093; cv=none; b=DJ4MZrglf/eagZs4xFyw9BGyfP3oXu16ppf9KsrPIkZe5ABPx7uZF+ImihpWIPuoYu7GunDGZNLaWaXDuvMwq2sp4KIECBHw1aqvIKwn/wX/kX1SfA5I/tfflNs8MR6kYX0tZRO/qjcpDM5LKFY4kpnu4LciXSgtZ/t+wmpIY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990093; c=relaxed/simple;
	bh=6rxG2pWFEJTvFC1BzcGpCgHk/ZYKZt3YNNuMhe3GWaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvJ82jVnsQyX/YfChLBee+9hzCsmKT/xE/VuMRL4wg+ITNCA4ADCDPXe8I32Zdo84EyUZeV/0o5WkEVK0RTXYAkmb68hpTNwSPMAZSYCy0B0xuak9BOwdEuyxSkbLsJlq/V97AzVKNzDUHEEMi5nipBRB4ZWdyhKe/JQbjFgKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=khXUWC3B; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=j81zL68CeneemT/sC0l2QYkupmOTxKcm9kYLz1nNSb0=;
	b=khXUWC3BcJ0rkgdIQiz1Wqctm9sksKmBBOwPRmraXsN33GnhIHejbyW/W2jV92MUCkvW/VF0b
	FNSlkJR/KGGcPNUS/M8TwMDRfUqZ46Be9Oh4tFDh48U9niz3tzNcL8vpQkNK6EEXiN0iIs+Y32A
	pGR5rBPUmuq96D9Qe8/s3RQ=
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cHfQW2GLHzYlSv1;
	Thu,  4 Sep 2025 20:47:47 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 20:48:02 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 20:48:01 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <liam.howlett@oracle.com>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<lorenzo.stoakes@oracle.com>, <mhocko@suse.com>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <surenb@google.com>, <tglx@linutronix.de>,
	<zhongjinji@honor.com>
Subject: Re: [PATCH v7 2/2] mm/oom_kill: The OOM reaper traverses the VMA maple tree in reverse order
Date: Thu, 4 Sep 2025 20:47:57 +0800
Message-ID: <20250904124757.25732-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7rvwvuifkav5oz4ftfuziq23wek2bn6ygvrfotpaweypuy7obv@hjuf3eknscii>
References: <7rvwvuifkav5oz4ftfuziq23wek2bn6ygvrfotpaweypuy7obv@hjuf3eknscii>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a018.hihonor.com
 (10.68.17.250)

> > On Wed 03-09-25 17:27:29, zhongjinji wrote:
> > > Although the oom_reaper is delayed and it gives the oom victim chance to
> > > clean up its address space this might take a while especially for
> > > processes with a large address space footprint. In those cases
> > > oom_reaper might start racing with the dying task and compete for shared
> > > resources - e.g. page table lock contention has been observed.
> > > 
> > > Reduce those races by reaping the oom victim from the other end of the
> > > address space.
> > > 
> > > It is also a significant improvement for process_mrelease(). When a process
> > > is killed, process_mrelease is used to reap the killed process and often
> > > runs concurrently with the dying task. The test data shows that after
> > > applying the patch, lock contention is greatly reduced during the procedure
> > > of reaping the killed process.
> > 
> > Thank you this is much better!
> > 
> > > Without the patch:
> > > |--99.74%-- oom_reaper
> > > |  |--76.67%-- unmap_page_range
> > > |  |  |--33.70%-- __pte_offset_map_lock
> > > |  |  |  |--98.46%-- _raw_spin_lock
> > > |  |  |--27.61%-- free_swap_and_cache_nr
> > > |  |  |--16.40%-- folio_remove_rmap_ptes
> > > |  |  |--12.25%-- tlb_flush_mmu
> > > |  |--12.61%-- tlb_finish_mmu
> > > 
> > > With the patch:
> > > |--98.84%-- oom_reaper
> > > |  |--53.45%-- unmap_page_range
> > > |  |  |--24.29%-- [hit in function]
> > > |  |  |--48.06%-- folio_remove_rmap_ptes
> > > |  |  |--17.99%-- tlb_flush_mmu
> > > |  |  |--1.72%-- __pte_offset_map_lock
> > > |  |--30.43%-- tlb_finish_mmu
> > 
> > Just curious. Do I read this correctly that the overall speedup is
> > mostly eaten by contention over tlb_finish_mmu?
> 
> The tlb_finish_mmu() taking less time indicates that it's probably not
> doing much work, afaict.  These numbers would be better if exit_mmap()
> was also added to show a more complete view of how the system is
> affected - I suspect the tlb_finish_mmu time will have disappeared from
> that side of things.

Yes, it would indeed be better to have exit_mmap data, but simpleperf 
does not support capturing perf data from multiple processes. I'll try to
find a solution.

> Comments in the code of this stuff has many arch specific statements,
> which makes me wonder if this is safe (probably?) and beneficial for
> everyone?  At the least, it would be worth mentioning which arch was
> used for the benchmark - I am guessing arm64 considering the talk of
> android, coincidently arm64 would benefit the most fwiu.

Yes, it's on arm64. Thank you, I will memtion it.

> mmu_notifier_release(mm) is called early in the exit_mmap() path should
> cause the mmu notifiers to be non-blocking (according to the comment in
> v6.0 source of exit_mmap [1].
> 
> > 
> > > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > 
> > Anyway, the change on its own makes sense to me
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > Thanks for working on the changelog improvements.
> 
> [1]. https://elixir.bootlin.com/linux/v6.0.19/source/mm/mmap.c#L3089
> 
> ...
> 
> Thanks,
> Liam

