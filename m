Return-Path: <linux-kernel+bounces-769892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE51B274D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0258F3BE1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEADA286D5E;
	Fri, 15 Aug 2025 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JyCHEiYG"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D427E7E1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222013; cv=none; b=Bkda+0bRL3m4Kgg3A+Ef6hWDES5ZQ+bxDUDtQOFWG1Ips1F14hUivf56LeiuiZSnRT5t0loxdtBspXep/WDvZaXspJ80PNbb4vdXRgyCnWCh+2duwjRVxnAvekcYMcxYljf9Zy8YSRYvf7HXU8KOgbOz0NKITPqp/dx1pOtMg0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222013; c=relaxed/simple;
	bh=7b5AOffM5L7v+I1MHxn4CQwk/s6C0jf/sj+ji86lezE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzVkdTK1NkA41JXqxiZDtqZ013XnV3t2LKBuk8rAUrASz/KPSFfuBNPoM9XVJoJHP7qTF3by79bMM64plDOJlm5Wwlxqhqt70Vnr9+rxmCNga9ELAqcI99NuBu4g/1I6OUo7m83CD8rwrz7sVuW1Ntr7+Tt86i01OZAMT3jt0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JyCHEiYG; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755222002; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=mM6ETlRb4AUaAvsKe6UppqbUP1u8KlXUj2EtKdJpteA=;
	b=JyCHEiYGxKkS7TCdZ1j/3onv6mb2JBU4J2UUxJsqzM/h7BPIvmtSeD84E4X751/MRjrjk+Z0I9yGWQLU8ovtbNyR+rvWZB0euKifwj+BoZ3s+SMrYo5OirENoZ1TR9YDZ86fqA/7JkB4w5bXxQMItds9Mgyb6rsPDv+PhDyasFY=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WlmgyQm_1755222000 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 09:40:00 +0800
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
Subject: Re: [RFC PATCH v1 2/7] migrate: implement
 migrate_misplaced_folios_batch
In-Reply-To: <20250814134826.154003-3-bharata@amd.com> (Bharata B. Rao's
	message of "Thu, 14 Aug 2025 19:18:21 +0530")
References: <20250814134826.154003-1-bharata@amd.com>
	<20250814134826.154003-3-bharata@amd.com>
Date: Fri, 15 Aug 2025 09:39:59 +0800
Message-ID: <87a541e51s.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> From: Gregory Price <gourry@gourry.net>
>
> A common operation in tiering is to migrate multiple pages at once.

Is it common now?  If so, you can replace some callers of
migrate_misplaced_folio() with migrate_misplaced_folios_batch().

> The migrate_misplaced_folio function requires one call for each

IMHO, migrate_misplaced_folio() is more concise than
migrate_misplaced_folio function.

> individual folio.  Expose a batch-variant of the same call for use
> when doing batch migrations.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>  include/linux/migrate.h |  6 ++++++
>  mm/migrate.c            | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index acadd41e0b5c..0593f5869be8 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -107,6 +107,7 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
>  int migrate_misplaced_folio_prepare(struct folio *folio,
>  		struct vm_area_struct *vma, int node);
>  int migrate_misplaced_folio(struct folio *folio, int node);
> +int migrate_misplaced_folios_batch(struct list_head *foliolist, int node);
>  #else
>  static inline int migrate_misplaced_folio_prepare(struct folio *folio,
>  		struct vm_area_struct *vma, int node)
> @@ -117,6 +118,11 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>  {
>  	return -EAGAIN; /* can't migrate now */
>  }
> +static inline int migrate_misplaced_folios_batch(struct list_head *foliolist,
> +						 int node)
> +{
> +	return -EAGAIN; /* can't migrate now */
> +}
>  #endif /* CONFIG_NUMA_BALANCING */
>  
>  #ifdef CONFIG_MIGRATION
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7e356c0b1b5a..1268a95eda0e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2714,5 +2714,36 @@ int migrate_misplaced_folio(struct folio *folio, int node)
>  	BUG_ON(!list_empty(&migratepages));
>  	return nr_remaining ? -EAGAIN : 0;
>  }
> +
> +/*
> + * Batch variant of migrate_misplaced_folio. Attempts to migrate
> + * a folio list to the specified destination.
> + *
> + * Caller is expected to have isolated the folios by calling
> + * migrate_misplaced_folio_prepare(), which will result in an
> + * elevated reference count on the folio.
> + *
> + * This function will un-isolate the folios, dereference them, and
> + * remove them from the list before returning.
> + */
> +int migrate_misplaced_folios_batch(struct list_head *folio_list, int node)

In addition to working on a list of folios instead of single folio, I
found there are some difference about memcg counting between
migrate_misplaced_folios_batch() and migrate_misplace_folio().  Why?

And, can we merge the implementation of two functions to reduce code
duplication?

> +{
> +	pg_data_t *pgdat = NODE_DATA(node);
> +	unsigned int nr_succeeded;
> +	int nr_remaining;
> +
> +	nr_remaining = migrate_pages(folio_list, alloc_misplaced_dst_folio,
> +				     NULL, node, MIGRATE_ASYNC,
> +				     MR_NUMA_MISPLACED, &nr_succeeded);
> +	if (nr_remaining)
> +		putback_movable_pages(folio_list);
> +
> +	if (nr_succeeded) {
> +		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> +		mod_node_page_state(pgdat, PGPROMOTE_SUCCESS, nr_succeeded);
> +	}
> +	BUG_ON(!list_empty(folio_list));
> +	return nr_remaining ? -EAGAIN : 0;
> +}
>  #endif /* CONFIG_NUMA_BALANCING */
>  #endif /* CONFIG_NUMA */

---
Best Regards,
Huang, Ying

