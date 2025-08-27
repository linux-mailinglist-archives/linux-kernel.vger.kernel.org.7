Return-Path: <linux-kernel+bounces-787628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EE6B378D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65926887A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F82B277C8E;
	Wed, 27 Aug 2025 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKOL/kSC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5330DD27
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266471; cv=none; b=lZ8K6e6fTDRwQ+ZUTINGeurI51f/tK7p+GsguZayzg1DFUNU+lsIVn9lXeQn0Gg/NtiSE4s/xMkST6xrKlcfK820+kRI7SoSy7uxb8V5A4d9TH/KRqzMiAfqKZnjwwv/zy3Sw/7vYoZM8qDZc+69KawdJMMsQgD/UGSvE4rs3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266471; c=relaxed/simple;
	bh=DP2fGlduqqUOTNx6lblkg2+pOvPjWW7Fpq84dfZPmv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wqiyd5b8nwTWFN8Tj/tsPcc7QPkwtms3tqDdNlxQtsioXeKe7mx6srfTfBRpjgDBp9IFW5uzvdY+7k1BF6qJW4z8rCca/O45+7S+Iecr6VyXIrNpUGahkYHTsntCijAgZuk+rptptuM65uQmVEa6oFh45YjK2Y7MnV14iYjBWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKOL/kSC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756266468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85DwLbI+KR6uSTruQj/cMscoyRTlGN0VbkyP4eDNcbU=;
	b=MKOL/kSC8cLNRYQG0NV112vk9qVRZ8bmRWbTtowS4MPaikWOV9I5haTOpt1wvYhoWKJaJ1
	Qq8oGUf2EUjVgw4uWZ+faLqLODVbPa7DNw9scRDWve6aLVsLuSA5774FJ6SDi0MeSH+oe2
	dDbztjF41b7SeUpy9hwZBc/O3HYLO3E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-0IbwmORUNnmdlMb_tLuFXg-1; Tue,
 26 Aug 2025 23:47:44 -0400
X-MC-Unique: 0IbwmORUNnmdlMb_tLuFXg-1
X-Mimecast-MFC-AGG-ID: 0IbwmORUNnmdlMb_tLuFXg_1756266462
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6A331956095;
	Wed, 27 Aug 2025 03:47:41 +0000 (UTC)
Received: from localhost (unknown [10.72.112.154])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FED31955F24;
	Wed, 27 Aug 2025 03:47:38 +0000 (UTC)
Date: Wed, 27 Aug 2025 11:47:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] mm, swap: tidy up swap device and cluster info
 helpers
Message-ID: <aK5/1so7a0i80+dz@MiWiFi-R3L-srv>
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-5-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822192023.13477-5-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/23/25 at 03:20am, Kairui Song wrote:
......
> diff --git a/mm/swap.h b/mm/swap.h
> index 223b40f2d37e..7b3efaa51624 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -15,6 +15,8 @@ extern int page_cluster;
>  #define swap_entry_order(order)	0
>  #endif
>  
> +extern struct swap_info_struct *swap_info[];
> +
>  /*
>   * We use this to track usage of a cluster. A cluster is a block of swap disk
>   * space with SWAPFILE_CLUSTER pages long and naturally aligns in disk. All
> @@ -53,9 +55,28 @@ enum swap_cluster_flags {
>  #include <linux/swapops.h> /* for swp_offset */
>  #include <linux/blk_types.h> /* for bio_end_io_t */
>  
> +/*
> + * Callers of all swp_* helpers here must ensure the entry is valid, and
> + * pin the swap device by reference or in other ways.
> + */
> +static inline struct swap_info_struct *swp_type_info(int type)
> +{
> +	struct swap_info_struct *si;
> +
> +	si = READ_ONCE(swap_info[type]); /* rcu_dereference() */
> +	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
> +	return si;
> +}
> +
> +static inline struct swap_info_struct *swp_info(swp_entry_t entry)
> +{
> +	return swp_type_info(swp_type(entry));
> +}

swp_type_info() is only used by swp_info() in the whole series, can we
open code it in swp_info()?

If you plan to use it in later phase of swap table patchset, then please
ignore this.

> +
>  static inline struct swap_cluster_info *swp_offset_cluster(
>  		struct swap_info_struct *si, pgoff_t offset)
>  {
> +	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
>  	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
>  }
>  
> @@ -65,6 +86,7 @@ static inline struct swap_cluster_info *swap_cluster_lock(
>  {
>  	struct swap_cluster_info *ci = swp_offset_cluster(si, offset);
>  
> +	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
>  	spin_lock(&ci->lock);
>  	return ci;
>  }
> @@ -164,7 +186,7 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
>  
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
> -	return swp_swap_info(folio->swap)->flags;
> +	return swp_info(folio->swap)->flags;
>  }
>  
>  /*
> @@ -175,7 +197,7 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>  static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
>  		bool *is_zeromap)
>  {
> -	struct swap_info_struct *sis = swp_swap_info(entry);
> +	struct swap_info_struct *sis = swp_info(entry);
>  	unsigned long start = swp_offset(entry);
>  	unsigned long end = start + max_nr;
>  	bool first_bit;
> @@ -194,7 +216,7 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
>  
>  static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
>  {
> -	struct swap_info_struct *si = swp_swap_info(entry);
> +	struct swap_info_struct *si = swp_info(entry);
>  	pgoff_t offset = swp_offset(entry);
>  	int i;
>  
> @@ -213,6 +235,11 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
>  
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
> +static inline struct swap_info_struct *swp_info(swp_entry_t entry)
> +{
> +	return NULL;
> +}
> +
>  static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
>  {
>  }
......


