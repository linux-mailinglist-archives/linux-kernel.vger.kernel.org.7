Return-Path: <linux-kernel+bounces-840158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CA5BB3B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD49F3272A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBCA30F94F;
	Thu,  2 Oct 2025 11:03:29 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5BE2EC099
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403008; cv=none; b=ddJbM7jOV1fCegU1PKTYj4hTJtvh0mySpXGONwIIa0QfXcEyj4Cuc4PCNINqUv/+/roaOZcXjq84Sy2f4CSqrCqyAG4zfjitzX5e1e4EyOKNqaWPZteApDpRKYVMJI/sVPT4H038jr0FjH9HAMNEvgbmLfStPkuVB7T8CD3zqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403008; c=relaxed/simple;
	bh=ZUCdPUTGkEt0v0lb4ITMH1udbOVULhS45YDus7CEMj8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7ILEv468JGzktlzc9dQzN5r/nGHoIaLJK/CvUGxJzT9TMNK8XynaSGGAembxEfttA5rxlQQ0tEjs4003C82t5QwTu4yCBSAolIiNCwVD1hxT2TNCrl92MF+dUpdvB8sdswSWtKX40COYJtzxoJaPJ7dro+EVvhUf5Y4/TQINsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccpkX0rtWz6L4tv;
	Thu,  2 Oct 2025 19:01:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D51CE140278;
	Thu,  2 Oct 2025 19:03:23 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 12:03:22 +0100
Date: Thu, 2 Oct 2025 12:03:20 +0100
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
Subject: Re: [RFC V3 4/9] mm/migrate: add migrate_folios_batch_move to 
 batch the folio move operations
Message-ID: <20251002120320.00003ab7@huawei.com>
In-Reply-To: <20250923174752.35701-5-shivankg@amd.com>
References: <20250923174752.35701-1-shivankg@amd.com>
	<20250923174752.35701-5-shivankg@amd.com>
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

On Tue, 23 Sep 2025 17:47:39 +0000
Shivank Garg <shivankg@amd.com> wrote:

> This is a preparatory patch that enables batch copying for folios
> undergoing migration. By enabling batch copying the folio content, we can
> efficiently utilize the capabilities of DMA hardware or multi-threaded
> folio copy. It uses MIGRATE_NO_COPY to skip folio copy during metadata
> copy process and performed the copies in a batch later.
> 
> Currently, the folio move operation is performed individually for each
> folio in sequential manner:
> for_each_folio() {
>         Copy folio metadata like flags and mappings
>         Copy the folio content from src to dst
>         Update page tables with dst folio
> }
> 
> With this patch, we transition to a batch processing approach as shown
> below:
> for_each_folio() {
>         Copy folio metadata like flags and mappings
> }
> Batch copy all src folios to dst
> for_each_folio() {
>         Update page tables with dst folios
> }
> 
> dst->private is used to store page states and possible anon_vma value,
> thus needs to be cleared during metadata copy process. To avoid additional
> memory allocation to store the data during batch copy process, src->private
> is used to store the data after metadata copy process, since src is no
> longer used.
> 
> Co-developed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  mm/migrate.c | 197 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 193 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3fe78ecb146a..ce94e73a930d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -843,12 +843,15 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>  			   enum migrate_mode mode)
>  {
>  	int rc, expected_count = folio_expected_ref_count(src) + 1;
> +	unsigned long dst_private = (unsigned long)dst->private;
Why not just stash it in a void * and void the casts?

>  
>  	/* Check whether src does not have extra refs before we do more work */
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
>  
> -	if (mode != MIGRATE_NO_COPY) {
> +	if (mode == MIGRATE_NO_COPY) {
> +		dst->private = NULL;
> +	} else {
>  		rc = folio_mc_copy(dst, src);
>  		if (unlikely(rc))
>  			return rc;
> @@ -862,6 +865,10 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>  		folio_attach_private(dst, folio_detach_private(src));
>  
>  	folio_migrate_flags(dst, src);
> +
> +	if (mode == MIGRATE_NO_COPY)

I'd add a comment on what you mention in the commit message about this being a safe place
to stash this.

> +		src->private = (void *)dst_private;
> +
>  	return MIGRATEPAGE_SUCCESS;
>  }
>  
> @@ -1149,7 +1156,7 @@ static void __migrate_folio_record(struct folio *dst,
>  	dst->private = (void *)anon_vma + old_page_state;
>  }
>  
> -static void __migrate_folio_extract(struct folio *dst,
> +static void __migrate_folio_read(struct folio *dst,
>  				   int *old_page_state,
>  				   struct anon_vma **anon_vmap)
>  {
> @@ -1157,6 +1164,12 @@ static void __migrate_folio_extract(struct folio *dst,
>  
>  	*anon_vmap = (struct anon_vma *)(private & ~PAGE_OLD_STATES);
>  	*old_page_state = private & PAGE_OLD_STATES;
> +}

Probably a blank line here.

> +static void __migrate_folio_extract(struct folio *dst,
> +				   int *old_page_state,
> +				   struct anon_vma **anon_vmap)
> +{
> +	__migrate_folio_read(dst, old_page_state, anon_vmap);
>  	dst->private = NULL;
>  }
>  
> @@ -1776,6 +1789,176 @@ static void migrate_folios_move(struct list_head *src_folios,
>  	}
>  }
>  
> +static void migrate_folios_batch_move(struct list_head *src_folios,
> +		struct list_head *dst_folios,
> +		free_folio_t put_new_folio, unsigned long private,
> +		enum migrate_mode mode, int reason,
> +		struct list_head *ret_folios,
> +		struct migrate_pages_stats *stats,
> +		int *retry, int *thp_retry, int *nr_failed,
> +		int *nr_retry_pages)
> +{
> +	struct folio *folio, *folio2, *dst, *dst2;
> +	int rc, nr_pages = 0, nr_batched_folios = 0;
> +	int old_page_state = 0;
> +	struct anon_vma *anon_vma = NULL;
> +	int is_thp = 0;

Always set in each loop before use. So no need to init here that I can see.

> +	LIST_HEAD(err_src);
> +	LIST_HEAD(err_dst);

> +	/* Batch copy the folios */
> +	rc = folios_mc_copy(dst_folios, src_folios, nr_batched_folios);
> +
> +	/* TODO:  Is there a better way of handling the poison
> +	 * recover for batch copy, instead of falling back to serial copy?

Is there a reason we might expect this to be common enough to care about
not using the serial path?

> +	 */
> +	/* fallback to serial page copy if needed */
> +	if (rc) {
> +		dst = list_first_entry(dst_folios, struct folio, lru);
> +		dst2 = list_next_entry(dst, lru);
> +		list_for_each_entry_safe(folio, folio2, src_folios, lru) {
> +			is_thp = folio_test_large(folio) &&
> +				 folio_test_pmd_mappable(folio);
> +			nr_pages = folio_nr_pages(folio);
> +			rc = folio_mc_copy(dst, folio);
> +


