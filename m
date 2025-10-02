Return-Path: <linux-kernel+bounces-840126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09234BB3A16
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88DC324CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FAF2FD1B1;
	Thu,  2 Oct 2025 10:30:29 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F393207
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401029; cv=none; b=nvQ1b4VbDFitOtaRle9gv2NyrxuXVDTXVxKWObW+CltepJvqkYOw2XxkxaoOw8x+V9OPTcIqKB94yRzDeJDG+HxobQ00Xdfvc+p/bwsqfigqcR7kNuUZY4koQt60tn8OeWCON9gNQiCmTc/2SH/Uk3A5dBDn70Myh9OQSrRRi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401029; c=relaxed/simple;
	bh=u4YCbc8hcSi7/DjwsRT0aNQug0a7hUliX3zh7nItUHY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmJQAtNRcNk+XkWTXr+4il42f1gw7hSRex+sk3RguTyNmDhrXclyEwncT1+BkPyVDTU35m3YCOtHDPIxOAgSHCuXzIYtHn9h9DP4iTWwml90mOJ12wY8KQrkE0DxXAqGzLTTvd9FmD+cWP1Zr0H6EOTY03ncT5ylFHq90dgCNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccnzP1K9zz6M4cM;
	Thu,  2 Oct 2025 18:27:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id DA495140278;
	Thu,  2 Oct 2025 18:30:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 11:30:21 +0100
Date: Thu, 2 Oct 2025 11:30:19 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shivank Garg <shivankg@amd.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>, <ziy@nvidia.com>,
	<willy@infradead.org>, <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>,
	<rakie.kim@sk.com>, <byungchul@sk.com>, <gourry@gourry.net>,
	<ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<vkoul@kernel.org>, <lucas.demarchi@intel.com>, <rdunlap@infradead.org>,
	<jgg@ziepe.ca>, <kuba@kernel.org>, <justonli@chromium.org>,
	<ivecera@redhat.com>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<rientjes@google.com>, <Raghavendra.KodsaraThimmappa@amd.com>,
	<bharata@amd.com>, <alirad.malek@zptcorp.com>, <yiannis@zptcorp.com>,
	<weixugc@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC V3 1/9] mm/migrate: factor out code in move_to_new_folio()
 and migrate_folio_move()
Message-ID: <20251002113019.000074df@huawei.com>
In-Reply-To: <20250923174752.35701-2-shivankg@amd.com>
References: <20250923174752.35701-1-shivankg@amd.com>
	<20250923174752.35701-2-shivankg@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 23 Sep 2025 17:47:36 +0000
Shivank Garg <shivankg@amd.com> wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> No function change is intended. The factored out code will be reused in
> an upcoming batched folio move function.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
Hi.  A few code structure things inline.

The naming of the various helpers needs some more thought I think as
with it like this the loss of readability of existing code is painful.

Jonathan

> ---
>  mm/migrate.c | 106 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 67 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 9e5ef39ce73a..ad03e7257847 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1061,19 +1061,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
>  	return migrate_folio(mapping, dst, src, mode);
>  }
>  
> -/*
> - * Move a src folio to a newly allocated dst folio.
> - *
> - * The src and dst folios are locked and the src folios was unmapped from
> - * the page tables.
> - *
> - * On success, the src folio was replaced by the dst folio.
> - *
> - * Return value:
> - *   < 0 - error code
> - *  MIGRATEPAGE_SUCCESS - success
> - */
> -static int move_to_new_folio(struct folio *dst, struct folio *src,
> +static int _move_to_new_folio_prep(struct folio *dst, struct folio *src,

I'm not sure the _ prefix is needed. Or maybe it should be __ like
__buffer_migrate_folio()


>  				enum migrate_mode mode)
>  {
>  	struct address_space *mapping = folio_mapping(src);
> @@ -1098,7 +1086,12 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>  							mode);
>  	else
>  		rc = fallback_migrate_folio(mapping, dst, src, mode);
> +	return rc;

May be worth switching this whole function to early returns given we no longer
have a shared block of stuff to do at the end.

	if (!mapping)
		return migrate_folio(mapping, st, src, mode);

	if (mapping_inaccessible(mapping))
		return -EOPNOTSUPP;

	if (mapping->a_ops->migrate_folio)
		return mapping->a_ops->migrate_folio(mapping, dst, src, mode);

	return fallback_migrate_folio(mapping, dst, src, mode);

> +}
>  
> +static void _move_to_new_folio_finalize(struct folio *dst, struct folio *src,
> +				int rc)
> +{
>  	if (rc == MIGRATEPAGE_SUCCESS) {

Perhaps
	if (rc != MIGRATE_PAGE_SUCCESS)
		return rc;

	/*
	 * For pagecache folios,....

...

	return rc;

Unless other stuff is likely to get added in here.
Or drag the condition to the caller.

>  		/*
>  		 * For pagecache folios, src->mapping must be cleared before src
> @@ -1110,6 +1103,29 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>  		if (likely(!folio_is_zone_device(dst)))
>  			flush_dcache_folio(dst);
>  	}
> +}
> +
> +/*
> + * Move a src folio to a newly allocated dst folio.
> + *
> + * The src and dst folios are locked and the src folios was unmapped from
> + * the page tables.
> + *
> + * On success, the src folio was replaced by the dst folio.
> + *
> + * Return value:
> + *   < 0 - error code
> + *  MIGRATEPAGE_SUCCESS - success
> + */
> +static int move_to_new_folio(struct folio *dst, struct folio *src,
> +			enum migrate_mode mode)
> +{
> +	int rc;
> +
> +	rc = _move_to_new_folio_prep(dst, src, mode);
> +
> +	_move_to_new_folio_finalize(dst, src, rc);
> +
>  	return rc;
>  }
>  
> @@ -1345,32 +1361,9 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>  	return rc;
>  }
>  
> -/* Migrate the folio to the newly allocated folio in dst. */
> -static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
> -			      struct folio *src, struct folio *dst,
> -			      enum migrate_mode mode, enum migrate_reason reason,
> -			      struct list_head *ret)
> +static void _migrate_folio_move_finalize1(struct folio *src, struct folio *dst,
> +					  int old_page_state)
>  {
> -	int rc;
> -	int old_page_state = 0;
> -	struct anon_vma *anon_vma = NULL;
> -	struct list_head *prev;
> -
> -	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
> -	prev = dst->lru.prev;
> -	list_del(&dst->lru);
> -
> -	if (unlikely(page_has_movable_ops(&src->page))) {
> -		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
> -		if (rc)
> -			goto out;
> -		goto out_unlock_both;
> -	}
> -
> -	rc = move_to_new_folio(dst, src, mode);
> -	if (rc)
> -		goto out;
> -
>  	/*
>  	 * When successful, push dst to LRU immediately: so that if it
>  	 * turns out to be an mlocked page, remove_migration_ptes() will
> @@ -1386,8 +1379,12 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>  
>  	if (old_page_state & PAGE_WAS_MAPPED)
>  		remove_migration_ptes(src, dst, 0);
> +}
>  
> -out_unlock_both:
> +static void _migrate_folio_move_finalize2(struct folio *src, struct folio *dst,
> +					  enum migrate_reason reason,
> +					  struct anon_vma *anon_vma)
> +{
>  	folio_unlock(dst);
>  	folio_set_owner_migrate_reason(dst, reason);
>  	/*
> @@ -1407,6 +1404,37 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>  		put_anon_vma(anon_vma);
>  	folio_unlock(src);
>  	migrate_folio_done(src, reason);
> +}
> +
> +/* Migrate the folio to the newly allocated folio in dst. */
> +static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
> +			      struct folio *src, struct folio *dst,
> +			      enum migrate_mode mode, enum migrate_reason reason,
> +			      struct list_head *ret)
> +{
> +	int rc;
> +	int old_page_state = 0;
> +	struct anon_vma *anon_vma = NULL;
> +	struct list_head *prev;
> +
> +	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
> +	prev = dst->lru.prev;
> +	list_del(&dst->lru);
> +
> +	if (unlikely(page_has_movable_ops(&src->page))) {
> +		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
> +		if (rc)
> +			goto out;
> +		goto out_unlock_both;
I would drop this..
> +	}
and do
	} else {
		rc = move_to_new_folio(dst, src, mode);
		if (rc)
			goto out;
		_migrate_folio_move_finalize1(src, dst, old_page_state);
	}
	_migrate_folio_move_finalize2(src, dst, reason, anon_vma);
  
  	return rc;

This makes sense now as the amount of code indented more in this approach
is much smaller than it would have been before you factored stuff out.


> +
> +	rc = move_to_new_folio(dst, src, mode);
> +	if (rc)
> +		goto out;
> +
Hmm. These two functions might be useful but this is hurting readability
here.  Can we come up with some more meaningful names perhaps?

> +	_migrate_folio_move_finalize1(src, dst, old_page_state);
> +out_unlock_both:
> +	_migrate_folio_move_finalize2(src, dst, reason, anon_vma);
>  
>  	return rc;
>  out:


