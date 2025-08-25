Return-Path: <linux-kernel+bounces-784879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1C3B342E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B62B3B1487
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC82F1FDC;
	Mon, 25 Aug 2025 14:12:34 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04D2F0C5E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131154; cv=none; b=LLEEvptlodLgpBxbmsrdnCSUeFOoBm8EfmmQzXhDH7fcxsQpeCEuVLG5MhkV6CV/37MwdagSooUcRU0P/OEdapt0ejgOPDnwhNPlzcdHd4Tb4jNYVdfJ2CiYMU1jhSCzPW8pK4PiiScwRyEH3H3cI59AEUfoyknRlDr/T4/qvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131154; c=relaxed/simple;
	bh=AhKin/oJw93d0eCE9MBAnNtOPh+jAA2BcwHteFo8B5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okbBWPfECaHS0ls2zkcLLz/TvHXDTVVbj1V7z7P6nnFlEf9quFf4Qs0RcLELCgnjQvJrT/f1FmH2TDWKaLvBE7e4mEQldEiW77H+lWVl92KUVMz9AYAKbRPXMfwnkgp9XxKCMGd/gtS7nhDzgEj668SvDhh255Kg2kGWKO+geyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4c9XmY4F8LzYlYVR;
	Mon, 25 Aug 2025 22:12:13 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 22:12:29 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 22:12:29 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <lorenzo.stoakes@oracle.com>
CC: <akpm@linux-foundation.org>, <andrealmeid@igalia.com>,
	<dave@stgolabs.net>, <dvhart@infradead.org>, <feng.han@honor.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <liulu.liu@honor.com>, <mhocko@suse.com>,
	<mingo@redhat.com>, <npache@redhat.com>, <peterz@infradead.org>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <tglx@linutronix.de>,
	<zhongjinji@honor.com>
Subject: Re: [PATCH v4 3/3] mm/oom_kill: Have the OOM reaper and exit_mmap() traverse the maple tree in opposite orders
Date: Mon, 25 Aug 2025 22:12:24 +0800
Message-ID: <20250825141224.2108-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c2b5c573-c0a3-4063-9a79-d3b06a615fe2@lucifer.local>
References: <c2b5c573-c0a3-4063-9a79-d3b06a615fe2@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

> >
> > |--99.74%-- oom_reaper
> > |    |--76.67%-- unmap_page_range
> > |    |    |--33.70%-- __pte_offset_map_lock
> > |    |    |    |--98.46%-- _raw_spin_lock
> > |    |    |--27.61%-- free_swap_and_cache_nr
> > |    |    |--16.40%-- folio_remove_rmap_ptes
> > |    |    |--12.25%-- tlb_flush_mmu
> > |    |--12.61%-- tlb_finish_mmu
> >
> >
> > |--98.84%-- oom_reaper
> > |    |--53.45%-- unmap_page_range
> > |    |    |--24.29%-- [hit in function]
> > |    |    |--48.06%-- folio_remove_rmap_ptes
> > |    |    |--17.99%-- tlb_flush_mmu
> > |    |    |--1.72%-- __pte_offset_map_lock
> > |    |
> > |    |--30.43%-- tlb_finish_mmu
> 
> Right yes thanks for providing this.
> 
> I'm still not convinced by this approach however, it feels like you're papering
> over a crack for a problematic hack that needs to be solved at a different
> level.
> 
> It feels like the whole waiting around thing is a hack to paper over something
> and then we're introducing another hack to make that work in a specific
> scenario.
> 
> I also am not clear (perhaps you answered it elsewhere) how you're encountering
> this at a scale for it to be a meaningful issue?

On low-memory Android devices, high memory pressure often requires killing
processes to free memory, which is generally accepted on Android. When
killing a process on Android, there is also an asynchronous process reap
mechanism, which is implemented through process_mrelease, similar to the
oom reaper. OOM events are also not rare. Therefore, it makes sense to
reduce the load on the reaper.

> Also not sure we should be changing core mm to support perf issues with using an
> effectively-deprecated interface (cgroup v1)?
Yeah, it is not that appealing.


