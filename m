Return-Path: <linux-kernel+bounces-769955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA77B27555
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84632189F2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8325729BDA3;
	Fri, 15 Aug 2025 01:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lURjpKAA"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A3299A85
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222976; cv=none; b=sbOypx673BU78CPm9Lw8q5/4uxB6A71DUjCC+N+7RLKd5uc6hSZZfi0Npjx9xDI7gRQulWBMs5uXk+mLPKpAgtZVbftxhwyU9vhAG5FUlR5hqPg8T92nlctFY3taghQlH3G/zORxQ2oppAjIky9lMUmsx3Fas4xhCVYQnS4mkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222976; c=relaxed/simple;
	bh=SJo8LY601xEru7a0YSTWUgAhw5z2CElZwlMwBGY8XZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o5fCTbO+oPtueGcVCKTf6D5HQDt79V+KvOcONlY/pY/AKqSxjUxiVMDe7cDg96j+XmZ9JaKKN5MF9O2lviyChIjIl/KItpURWc9Ug7nHon5whA8hdu3Vs6NqOlhES4s4U/dZEZ3+uI9W96y4u6BAX9Xk1Vp5Qnl+T/9NpJMUy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lURjpKAA; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755222965; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=fXdEI8668zYGp/a36im+Wgc5iWXhk6DJ+ceX7JfkERo=;
	b=lURjpKAAhiJc/v0g1rionHyU0T0ZzX8NiUUZcIPEsYFfhhzGFVmvOyF0gzIK/K79UvmChGuoQjHmvn9/rwO6CPkTtqBcTUNDWfAkZ5QiREZ5ZK9bw9VDS9nQzLvraLs5aN9uyqupi7Z3NAzE5ecbaj7EgiQtMnYpFNTW1PJlGzs=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WlmqoOh_1755222962 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 09:56:03 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <Jonathan.Cameron@huawei.com>,  <dave.hansen@intel.com>,
  <gourry@gourry.net>,  <hannes@cmpxchg.org>,
  <mgorman@techsingularity.net>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <raghavendra.kt@amd.com>,  <riel@surriel.com>,
  <rientjes@google.com>,  <sj@kernel.org>,  <weixugc@google.com>,
  <willy@infradead.org>,  <ziy@nvidia.com>,  <dave@stgolabs.net>,
  <nifan.cxl@gmail.com>,  <xuezhengchu@huawei.com>,  <yiannis@zptcorp.com>,
  <akpm@linux-foundation.org>,  <david@redhat.com>,  <byungchul@sk.com>,
  <kinseyho@google.com>,  <joshua.hahnjy@gmail.com>,  <yuanchu@google.com>,
  <balbirs@nvidia.com>
Subject: Re: [RFC PATCH v1 3/7] mm: Hot page tracking and promotion
In-Reply-To: <20250814134826.154003-4-bharata@amd.com> (Bharata B. Rao's
	message of "Thu, 14 Aug 2025 19:18:22 +0530")
References: <20250814134826.154003-1-bharata@amd.com>
	<20250814134826.154003-4-bharata@amd.com>
Date: Fri, 15 Aug 2025 09:56:01 +0800
Message-ID: <871ppde4b2.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> This introduces a sub-system for collecting memory access
> information from different sources. It maintains the hotness
> information based on the access history and time of access.
>
> Additionally, it provides per-lowertier-node kernel threads
> (named kpromoted) that periodically promote the pages that
> are eligible for promotion.
>
> Sub-systems that generate hot page access info can report that
> using this API:
>
> int pghot_record_access(u64 pfn, int nid, int src,
> 			unsigned long time)
>
> @pfn: The PFN of the memory accessed
> @nid: The accessing NUMA node ID
> @src: The temperature source (sub-system) that generated the
>       access info
> @time: The access time in jiffies

How will the page hotness information gather with NUMA balancing hint
page fault be expressed with this interface?

> Some temperature sources may not provide the nid from which
> the page was accessed. This is true for sources that use
> page table scanning for PTE Accessed bit. For such sources,
> the default toptier node to which such pages should be promoted
> is hard coded.
>
> Also, the access time provided some sources may at best be
> considered approximate. This is especially true for hot pages
> detected by PTE A bit scanning.
>
> The hot PFN records are stored in hash lists hashed by PFN value.
> The PFN records that are categorized as hot enough to be promoted
> are maintained in a per-lowertier-node max heap from which
> kpromoted extracts and promotes them.
>
> Each record stores the following info:
>
> struct pghot_info {
> 	unsigned long pfn;
>
> 	unsigned long last_update; /* Most recent access time */
> 	int frequency; /* Number of accesses within current window */
> 	int nid; /* Most recent access from this node */
>
> 	struct hlist_node hnode;
> 	size_t heap_idx; /* Position in max heap for quick retreival */
> };
>
> The way in which a page is categorized as hot enough to be
> promoted is pretty primitive now.
>

[snip]

---
Best Regards,
Huang, Ying

