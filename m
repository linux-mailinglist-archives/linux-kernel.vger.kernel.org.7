Return-Path: <linux-kernel+bounces-841190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE6BB6744
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC639344E24
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1A92EA494;
	Fri,  3 Oct 2025 10:36:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4F27470
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759487798; cv=none; b=Q73+eF/2LwcMwkko3A+FOQ/pm0yljqvy91Xe2RBkEvXBA348RfJzNx9om+bgxi3DvZ0suwD698Ww+nhE1SGlHUdVqKLEDcBKA8HYNDI9H4xc+keq+GtdVki1NORUgYEC/mPbxl7z/pqqMpv43Se/WPgzpGk86/UefdZ1TaAC7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759487798; c=relaxed/simple;
	bh=Kv/oh3/xw+Z4tU96HcRdl29X4mjMBCXkIuNqBVoKCB4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mhrl/P8KGKoLvYlAkcmcBYn6+mzyupxBOl6XgMDJq03oOx8EJgk1hbGKNjbiU75qC93827vrF+W+OT9D56Yu8hNnE8cIQ2ZnlK0tiR5QDh0todhWtFuSgdCELGdTHvpusDTUTpV0aDmFHX6l7udMxzlMVSqz1N0OGqP8D1MTEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdQ7F5ghXz67Hjq;
	Fri,  3 Oct 2025 18:36:09 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1743F1400D9;
	Fri,  3 Oct 2025 18:36:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 11:36:31 +0100
Date: Fri, 3 Oct 2025 11:36:29 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Bharata B Rao <bharata@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <peterz@infradead.org>,
	<raghavendra.kt@amd.com>, <riel@surriel.com>, <rientjes@google.com>,
	<sj@kernel.org>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <ziy@nvidia.com>, <dave@stgolabs.net>,
	<nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <byungchul@sk.com>,
	<kinseyho@google.com>, <joshua.hahnjy@gmail.com>, <yuanchu@google.com>,
	<balbirs@nvidia.com>, <alok.rathore@samsung.com>
Subject: Re: [RFC PATCH v2 2/8] migrate: implement
 migrate_misplaced_folios_batch
Message-ID: <20251003113629.00004fcb@huawei.com>
In-Reply-To: <20250910144653.212066-3-bharata@amd.com>
References: <20250910144653.212066-1-bharata@amd.com>
	<20250910144653.212066-3-bharata@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 10 Sep 2025 20:16:47 +0530
Bharata B Rao <bharata@amd.com> wrote:

> From: Gregory Price <gourry@gourry.net>
> 
> A common operation in tiering is to migrate multiple pages at once.
> The migrate_misplaced_folio function requires one call for each
> individual folio.  Expose a batch-variant of the same call for use
> when doing batch migrations.
> 
I probably missed an earlier discussion of this but what does the
_batch postfix add over the plural (folios)?

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

Kernel-doc perhaps appropriate?

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


