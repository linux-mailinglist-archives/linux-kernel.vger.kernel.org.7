Return-Path: <linux-kernel+bounces-804677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F4B47B7A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8A416634D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD202701DA;
	Sun,  7 Sep 2025 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm8U2bSK"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA32C8E6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757249748; cv=none; b=Ts5i4f23Lco0frOz+T5dlTZy3AnP1teHWLP48EEJE+WdprEUYfTc1vQqNg+RZdQf5QS03aYCo8Z4MtyQDGF6rugmZPSsvXRStG2jiazl+J2BIBAkZeuo+OH3Cg2aSLtpTXFCidrR26YpokOFbACuR4z7AFfJRPYlbRZBYLyh08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757249748; c=relaxed/simple;
	bh=uFFeVrU3Y5DlCo2zoYfJlBfw60tGyMiN2ZvTNyCHTnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJtEYZhHjiKIcXMTpv/gZIUzySlb1iOEeTPgvBxEULpHjCLXYh/bu6efMoJiT9o+GnZOBoYLvhePlaHCCa7t/UXuCnS210hs+ySXwzFIWi8Z0ThX0b64/p13U+K4RNTnmlxjad4a6W5vQ2g2utACOOD0iO8NgwzZkW+SYZVbMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wm8U2bSK; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-337e714b3b4so28124391fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757249744; x=1757854544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdAbborS8C2Ou/xydNKdRzdXdKALgrhR3nsSWFUy6jE=;
        b=Wm8U2bSKDfbmlKcfsZaYM5k31ErVRJLNhLp8gX22e3oelP02s6zdK30SqiHakEcH1r
         bCqDOVX+TSwQIkWgO/yHlQJXokvqlOzackoDOVGkbqQxwKB0SdP2/RKC/ZZfubt11BgT
         VRenaaBf9+zetGt3gMDEtfyQzDQFYrYBk82T64Km1vt6pRTwUaNn0JzOdYTEY0iNi+bm
         b0faikNnzGPBv0BKXHkeanvKgO8EuZHTIes/a60acf6MO/8VyQXTOTKK4dxLJ3cP3E09
         bE0tjZuFa73Wc1Ro2HJHD7Co7stT3uViAamomTEvDDsQAVYamgoRE0zowezGMFjoMHq8
         oTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757249744; x=1757854544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdAbborS8C2Ou/xydNKdRzdXdKALgrhR3nsSWFUy6jE=;
        b=jwRtN7mDVjMnSNkcez9ktdHvaO2Rtp5er0sRatcyl4abIw4Em00oha84agl+5xR28n
         sYGAJTfUMPhXhA4bo1ISmMCUriCucOyL4SdDLu8Qq5+gnw20bzd7UJaUuFWBSN+8oXBx
         E90ODIq8lCKirkvCRV8pQCStmDmXoIYbF91Ac6rVnqOqKcowGq4I3YRXrbRDe+TvKQ2w
         sV/OEXBDbXEHs6Z1uz+2HW8kWpaeGCdUql4Ei991P0+SjtPYvvSwmumqh5BwhuiW98PE
         ABBWYrCeoanzJfeYKRhuf7gApgu7XvqTtzWMWFjZXagqc9TC0A4CPditAEttSXdgACa4
         S1gw==
X-Forwarded-Encrypted: i=1; AJvYcCVo8cNxWD2PWM9Iv+UtZcZ47QM3iXEGuADqhy9nda2BDiRnzs6pkFhWuY/62mHTHNpBjG0qhjALuoCrrcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4MYsvwEh1XDX5hYdrqJOb4QPYxdn2mp9Aex49cpEiNvc7lnRa
	eWplVDj8BenicJfu4BBohjk9XCPzfS/Ut9HtP8OFOpzH46tcnnzB+EeG
X-Gm-Gg: ASbGncvIPr0NM8Ulcr2q4BFGA/9ZAL5Yrgc8PIWclmwlic8okgTOpcl9atsFgPTC0yP
	BC0qNCs5lOmh4skafTT7ul4X4xp9H+IhoFR4k13qWxJjLPnmyH08n3J9G5G8Mm6sk9XHUpS1hjQ
	djwI8rLKatKazrRUgJ73RIzC2tlnihSiJJ3RKKMJuFIIZFILG1o76BH+iB1w0zUNQO+IpvM1q8b
	Mvvg+6w7C/Huh3YNTrTQjoPZzn8entZbajdSyGeRZrKMJNOdh53K97HaoTfpEXUdSiSP/U85om8
	oHBvbDHgScPTUhzq39kqLgJT7LNfvZIlWyN11gA4XrzjD+1lF1DCavRkUIUQagT55JFvskJyH1r
	gO8mt00nI536IcgfK3toADhsVcroIRhuHZ3FzsRy8309uoXE=
X-Google-Smtp-Source: AGHT+IF36wKKwGkJ1cLAeJf4fLbOD7OzXHE1njTd3XXg8omeRunLVwqO6h+W/bsXU80Mdzc12gq4Aw==
X-Received: by 2002:a05:651c:b0e:b0:338:1daf:f162 with SMTP id 38308e7fff4ca-33b58408280mr10992991fa.42.1757249744197;
        Sun, 07 Sep 2025 05:55:44 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-337f4c91a6bsm27836881fa.21.2025.09.07.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 05:55:43 -0700 (PDT)
Date: Sun, 7 Sep 2025 14:55:43 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/15] mm, swap: use the swap table for the swap cache
 and switch API
Message-ID: <vj7utcgrseaot6ktpbwgshthmjza7w7vk2glede273tza7yfi6@cyxppxoney5u>
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-12-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905191357.78298-12-ryncsn@gmail.com>

On 2025-09-06 03:13:53 +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Introduce basic swap table infrastructures, which are now just a
> fixed-sized flat array inside each swap cluster, with access wrappers.
> 
> Each cluster contains a swap table of 512 entries. Each table entry is
> an opaque atomic long. It could be in 3 types: a shadow type (XA_VALUE),
> a folio type (pointer), or NULL.
> 
> In this first step, it only supports storing a folio or shadow, and it
> is a drop-in replacement for the current swap cache. Convert all swap
> cache users to use the new sets of APIs. Chris Li has been suggesting
> using a new infrastructure for swap cache for better performance, and
> that idea combined well with the swap table as the new backing
> structure. Now the lock contention range is reduced to 2M clusters,
> which is much smaller than the 64M address_space. And we can also drop
> the multiple address_space design.
> 
> All the internal works are done with swap_cache_get_* helpers. Swap
> cache lookup is still lock-less like before, and the helper's contexts
> are same with original swap cache helpers. They still require a pin
> on the swap device to prevent the backing data from being freed.
> 
> Swap cache updates are now protected by the swap cluster lock
> instead of the Xarray lock. This is mostly handled internally, but new
> __swap_cache_* helpers require the caller to lock the cluster. So, a
> few new cluster access and locking helpers are also introduced.
> 
> A fully cluster-based unified swap table can be implemented on top
> of this to take care of all count tracking and synchronization work,
> with dynamic allocation. It should reduce the memory usage while
> making the performance even better.
> 
> Co-developed-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  MAINTAINERS          |   1 +
>  include/linux/swap.h |   2 -
>  mm/huge_memory.c     |  13 +-
>  mm/migrate.c         |  19 ++-
>  mm/shmem.c           |   8 +-
>  mm/swap.h            | 157 +++++++++++++++++------
>  mm/swap_state.c      | 289 +++++++++++++++++++------------------------
>  mm/swap_table.h      |  97 +++++++++++++++
>  mm/swapfile.c        | 100 +++++++++++----
>  mm/vmscan.c          |  20 ++-
>  10 files changed, 458 insertions(+), 248 deletions(-)
>  create mode 100644 mm/swap_table.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1c8292c0318d..de402ca91a80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16226,6 +16226,7 @@ F:	include/linux/swapops.h
>  F:	mm/page_io.c
>  F:	mm/swap.c
>  F:	mm/swap.h
> +F:	mm/swap_table.h
>  F:	mm/swap_state.c
>  F:	mm/swapfile.c
>  

...

> diff --git a/mm/swap.h b/mm/swap.h
> index a139c9131244..bf4e54f1f6b6 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -2,6 +2,7 @@
>  #ifndef _MM_SWAP_H
>  #define _MM_SWAP_H
>  
> +#include <linux/atomic.h> /* for atomic_long_t */
>  struct mempolicy;
>  struct swap_iocb;
>  
> @@ -35,6 +36,7 @@ struct swap_cluster_info {
>  	u16 count;
>  	u8 flags;
>  	u8 order;
> +	atomic_long_t *table;	/* Swap table entries, see mm/swap_table.h */
>  	struct list_head list;
>  };
>  
> @@ -55,6 +57,11 @@ enum swap_cluster_flags {

>  #include <linux/swapops.h> /* for swp_offset */

Now that swp_offset() is used in folio_index(), should this perhaps also be
included for !CONFIG_SWAP?

>  #include <linux/blk_types.h> /* for bio_end_io_t */
>  
> +static inline unsigned int swp_cluster_offset(swp_entry_t entry)
> +{
> +	return swp_offset(entry) % SWAPFILE_CLUSTER;
> +}
> +
>  /*
>   * Callers of all helpers below must ensure the entry, type, or offset is
>   * valid, and protect the swap device with reference count or locks.
> @@ -81,6 +88,25 @@ static inline struct swap_cluster_info *__swap_offset_to_cluster(
>  	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
>  }
>  
> +static inline struct swap_cluster_info *__swap_entry_to_cluster(swp_entry_t entry)
> +{
> +	return __swap_offset_to_cluster(__swap_entry_to_info(entry),
> +					swp_offset(entry));
> +}
> +
> +static __always_inline struct swap_cluster_info *__swap_cluster_lock(
> +		struct swap_info_struct *si, unsigned long offset, bool irq)
> +{
> +	struct swap_cluster_info *ci = __swap_offset_to_cluster(si, offset);
> +
> +	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
> +	if (irq)
> +		spin_lock_irq(&ci->lock);
> +	else
> +		spin_lock(&ci->lock);
> +	return ci;
> +}
> +
>  /**
>   * swap_cluster_lock - Lock and return the swap cluster of given offset.
>   * @si: swap device the cluster belongs to.
> @@ -92,11 +118,48 @@ static inline struct swap_cluster_info *__swap_offset_to_cluster(
>  static inline struct swap_cluster_info *swap_cluster_lock(
>  		struct swap_info_struct *si, unsigned long offset)
>  {
> -	struct swap_cluster_info *ci = __swap_offset_to_cluster(si, offset);
> +	return __swap_cluster_lock(si, offset, false);
> +}
>  
> -	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
> -	spin_lock(&ci->lock);
> -	return ci;
> +static inline struct swap_cluster_info *__swap_cluster_lock_by_folio(
> +		const struct folio *folio, bool irq)
> +{
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
> +	return __swap_cluster_lock(__swap_entry_to_info(folio->swap),
> +				   swp_offset(folio->swap), irq);
> +}
> +
> +/*
> + * swap_cluster_lock_by_folio - Locks the cluster that holds a folio's entries.
> + * @folio: The folio.
> + *
> + * This locks the swap cluster that contains a folio's swap entries. The
> + * swap entries of a folio are always in one single cluster, and a locked
> + * swap cache folio is enough to stabilize the entries and the swap device.
> + *
> + * Context: Caller must ensure the folio is locked and in the swap cache.
> + * Return: Pointer to the swap cluster.
> + */
> +static inline struct swap_cluster_info *swap_cluster_lock_by_folio(
> +		const struct folio *folio)
> +{
> +	return __swap_cluster_lock_by_folio(folio, false);
> +}
> +
> +/*
> + * swap_cluster_lock_by_folio_irq - Locks the cluster that holds a folio's entries.
> + * @folio: The folio.
> + *
> + * Same as swap_cluster_lock_by_folio but also disable IRQ.
> + *
> + * Context: Caller must ensure the folio is locked and in the swap cache.
> + * Return: Pointer to the swap cluster.
> + */
> +static inline struct swap_cluster_info *swap_cluster_lock_by_folio_irq(
> +		const struct folio *folio)
> +{
> +	return __swap_cluster_lock_by_folio(folio, true);
>  }
>  
>  static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
> @@ -104,6 +167,11 @@ static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
>  	spin_unlock(&ci->lock);
>  }
>  
> +static inline void swap_cluster_unlock_irq(struct swap_cluster_info *ci)
> +{
> +	spin_unlock_irq(&ci->lock);
> +}
> +
>  /* linux/mm/page_io.c */
>  int sio_pool_init(void);
>  struct swap_iocb;
> @@ -123,10 +191,11 @@ void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
>  #define SWAP_ADDRESS_SPACE_SHIFT	14
>  #define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
>  #define SWAP_ADDRESS_SPACE_MASK		(SWAP_ADDRESS_SPACE_PAGES - 1)
> -extern struct address_space *swapper_spaces[];
> -#define swap_address_space(entry)			    \
> -	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
> -		>> SWAP_ADDRESS_SPACE_SHIFT])
> +extern struct address_space swap_space;
> +static inline struct address_space *swap_address_space(swp_entry_t entry)
> +{
> +	return &swap_space;
> +}
>  
>  /*
>   * Return the swap device position of the swap entry.
> @@ -136,15 +205,6 @@ static inline loff_t swap_dev_pos(swp_entry_t entry)
>  	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
>  }
>  
> -/*
> - * Return the swap cache index of the swap entry.
> - */
> -static inline pgoff_t swap_cache_index(swp_entry_t entry)
> -{
> -	BUILD_BUG_ON((SWP_OFFSET_MASK | SWAP_ADDRESS_SPACE_MASK) != SWP_OFFSET_MASK);
> -	return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
> -}
> -
>  /**
>   * folio_matches_swap_entry - Check if a folio matches a given swap entry.
>   * @folio: The folio.
> @@ -177,16 +237,15 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
>   */
>  struct folio *swap_cache_get_folio(swp_entry_t entry);
>  void *swap_cache_get_shadow(swp_entry_t entry);
> -int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> -			 gfp_t gfp, void **shadow);
> +void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow);
>  void swap_cache_del_folio(struct folio *folio);
> -void __swap_cache_del_folio(struct folio *folio,
> -			    swp_entry_t entry, void *shadow);
> -void __swap_cache_replace_folio(struct address_space *address_space,
> -				swp_entry_t entry,
> -				struct folio *old, struct folio *new);
> -void swap_cache_clear_shadow(int type, unsigned long begin,
> -			     unsigned long end);
> +/* Below helpers require the caller to lock and pass in the swap cluster. */
> +void __swap_cache_del_folio(struct swap_cluster_info *ci,
> +			    struct folio *folio, swp_entry_t entry, void *shadow);
> +void __swap_cache_replace_folio(struct swap_cluster_info *ci,
> +				swp_entry_t entry, struct folio *old,
> +				struct folio *new);
> +void __swap_cache_clear_shadow(swp_entry_t entry, int nr_ents);
>  
>  void show_swap_cache_info(void);
>  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
> @@ -254,6 +313,32 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
>  
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
> +static inline struct swap_cluster_info *swap_cluster_lock(
> +	struct swap_info_struct *si, pgoff_t offset, bool irq)
> +{
> +	return NULL;
> +}
> +
> +static inline struct swap_cluster_info *swap_cluster_lock_by_folio(
> +		struct folio *folio)
> +{
> +	return NULL;
> +}
> +
> +static inline struct swap_cluster_info *swap_cluster_lock_by_folio_irq(
> +		struct folio *folio)
> +{
> +	return NULL;
> +}
> +
> +static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
> +{
> +}
> +
> +static inline void swap_cluster_unlock_irq(struct swap_cluster_info *ci)
> +{
> +}
> +
>  static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t entry)
>  {
>  	return NULL;
> @@ -271,11 +356,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
>  	return NULL;
>  }
>  
> -static inline pgoff_t swap_cache_index(swp_entry_t entry)
> -{
> -	return 0;
> -}
> -
>  static inline bool folio_matches_swap_entry(const struct folio *folio, swp_entry_t entry)
>  {
>  	return false;
> @@ -322,17 +402,22 @@ static inline void *swap_cache_get_shadow(swp_entry_t entry)
>  	return NULL;
>  }
>  
> -static inline int swap_cache_add_folio(swp_entry_t entry, struct folio *folio,
> -				       gfp_t gfp, void **shadow)
> +static inline void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow)
>  {
> -	return -EINVAL;
>  }
>  
>  static inline void swap_cache_del_folio(struct folio *folio)
>  {
>  }
>  
> -static inline void __swap_cache_del_folio(swp_entry_t entry, struct folio *folio, void *shadow)
> +static inline void __swap_cache_del_folio(struct swap_cluster_info *ci,
> +			    struct folio *folio, swp_entry_t entry, void *shadow)
> +{
> +}
> +
> +static inline void __swap_cache_replace_folio(
> +		struct swap_cluster_info *ci, swp_entry_t entry,
> +		struct folio *old, struct folio *new)
>  {
>  }
>  
> @@ -367,7 +452,7 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
>  static inline pgoff_t folio_index(struct folio *folio)
>  {
>  	if (unlikely(folio_test_swapcache(folio)))

> -		return swap_cache_index(folio->swap);
> +		return swp_offset(folio->swap);

This is outside CONFIG_SWAP.

>  	return folio->index;
>  }

...

Regards,
Klara Modin

