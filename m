Return-Path: <linux-kernel+bounces-886396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDEC356AA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644461A21586
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AD8309F18;
	Wed,  5 Nov 2025 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6U/UrrN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN+vWrX4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16672DF703
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342937; cv=none; b=jJPDSdUqNgHlFVASM0KvIa9c1HTEJb9ly+bKBqPesCKfAyN/Nqv07m+uB3+nGtCUh798h5dLnNCxEB8ycDk8z8Wgpr8u1un8OVVyokKWVdqVQkkEMDAKEEa/4sAun25YjC+Vx+3NhS9U63Xwh1rcl/Lz8tMU2wcIhvBfG9PDQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342937; c=relaxed/simple;
	bh=N0rdPc9mvC7OIenP+Xuk/8sbkIZkeNylGZOswr0v+1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ize3yNGxB//PnOV+fYoQEvrNzGQs1hbpbFqJWtA9ZHYK8YNWPnc1t1VWlSyNT7AtqqcBuEHY9n6GgBek3l82tPzWbvkiTBjh+OI0x00BdX33jCmBlzGos7rNhE/1N6urgqevOKRkn7errcW8+nql/Rfc19XCRzvh/TdEET+2FGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6U/UrrN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YN+vWrX4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762342934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cqj4OVlBy+gvZ7XqMUq9pvYrZ4QvQPUtMEzErvpPvOU=;
	b=b6U/UrrN5kbMp4L7ZlMVCs753Goy4q3weLCHTzvDAVGY3QItZVr+RWnZ2aJeOlbZyt4pit
	6D4pxuoHXjrC55Q5INdBCrJ2kI8qvUbx6JnLGbU1M4tocjuDLE4lQOgaer/aamDcM3Nmwu
	1+v/watySmZX0wG9oMBqKrjgYQ76FlY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-eeGPmYbTPhe7R8XZeHH9LQ-1; Wed, 05 Nov 2025 06:42:13 -0500
X-MC-Unique: eeGPmYbTPhe7R8XZeHH9LQ-1
X-Mimecast-MFC-AGG-ID: eeGPmYbTPhe7R8XZeHH9LQ_1762342932
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4774836c376so25613835e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762342932; x=1762947732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cqj4OVlBy+gvZ7XqMUq9pvYrZ4QvQPUtMEzErvpPvOU=;
        b=YN+vWrX4iwQCJjU9+NrxhjbYYAZ7fVXY8kXjQO+sYFgE6h1sYDx9xJTRX/OMr83dQl
         bBc0KCSqO/DtI4GaGGC4A5fZENpQXWaR8isNoaO/spUcOjFtOKHmSEu6iFi6c6SAD5Ae
         66qzRSCLHnnXIi0/Z3h3bYfOAuk3TkLsCMNh001M4b8Iyb+mS/VxgVxTWztV6k8GG72B
         oi1KI1XfVNklt2CzXlojeY6nr6pq8aAq+S3HbHrpccIx3KFcbBWRMEWqpwF0wMNoX6+r
         YofjmZCX6HkzKMY1RH38fywjCn9CPv/5/lMXNC8Scf0d3s+rDY11mXe/589QD09loD4H
         Ya7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762342932; x=1762947732;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqj4OVlBy+gvZ7XqMUq9pvYrZ4QvQPUtMEzErvpPvOU=;
        b=tGCFVBwafOP9SG3dKDPX7h9PFFoisOR9Z75O9FC1o2zBeTqPHfF95xqDlxl7/gT2IY
         qTMBIKWPpg2Qa11a00sc2EOhwU1TEwS4d4U9uhIXRCdFu1pcN13j+FLZiAqNjzU8R9CL
         atlePl/7UrJP6udUyeNqWrve/1y07hPGaNYTixsq3NqLGrvDJtYajyZ83tf3kQq6d/Le
         boIxnvEUNXdw+xz+GrFEnVQZFPeTYq1Hx+03c6464d9bH//tlH8JIRI/L4hDgyX10xQG
         y0SOJzqZn5oAtMPZ3wE53Sr9CqzzLNibzAAfPxInt/N/NZgEl4OJzPgIHIQECFwt+JbJ
         LH/A==
X-Forwarded-Encrypted: i=1; AJvYcCUhFgS+pNxLgubG728OyulYudErb/8T7tkw9AOZDfhyUnROSoky8LWXRneadFzskefDPXlb/3yWBaDG5kA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7BNCCZE6azU8WZnsml9MemmgrmyAnfMVsQCOg1YVSnNv02Upz
	eLcvWc1svs4EuGTU6K8YWQwtD0wgMN47Gj7+Rejx7BbPVDPrMPc9GL1egIUuVpB/lyM0yr2WnUW
	OBXAbdA2n01ZUgr1iDj+8lOWWYnSqm8Ls3XfqZ3YmDD3JzqbV26F+p5tD9fb2Fur19g==
X-Gm-Gg: ASbGncspzM8jR+/p7w0GJbtAvyydpVw+ppTE6mWbso/0+m5qQ52nBRWIVsgOiigjeEy
	pDtIYxFYTgH1WkzJGziMSR09VWBnf6WkB07LxP7RcdDoMiqy3Vc9yoGxFiB5c7ZISZVPoRviiAd
	S1l354dmV4WijBlh5iym/+tALIY/OIRl2KEfVrzimKRxoCJv6t/w+4NwUohYOjFLRHzjJeTGuof
	Id7Oq0zDMMxGCeW+ur3KKF4NYMTLZrfSDjiZEMb4/AGE3ZvyU8EloE2U1vooCom5zf+1IpCHdmL
	I2k+XbVoqFOIKV13D2FW+Ey+49UCjusiLw7ebHPIw3H1uF2Nq+8btqpT/CLMbQXp2caQS4K7IPN
	ruT+/xfII6WiIDvfF7xFaeInYgDM9mvLlJYm28Lr23Lt94o/LG1XfNrONSac0M+doWtwTYjwrv+
	aqL9ogPotNyBesrfkxg/B2ILM=
X-Received: by 2002:a05:600c:4e88:b0:471:13fc:e356 with SMTP id 5b1f17b1804b1-4775cdad3abmr24308245e9.3.1762342931911;
        Wed, 05 Nov 2025 03:42:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2aR4k/KEuxXU0V5B0fBQhVFJdHvYsc7oYnt0nj/Pl2tNdjM1eHshBthcnnfeWZdiu9Bf6jQ==
X-Received: by 2002:a05:600c:4e88:b0:471:13fc:e356 with SMTP id 5b1f17b1804b1-4775cdad3abmr24307915e9.3.1762342931385;
        Wed, 05 Nov 2025 03:42:11 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ee3sm43411365e9.9.2025.11.05.03.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 03:42:10 -0800 (PST)
Message-ID: <9e29972b-6f72-4228-89bb-0ede44ed5e83@redhat.com>
Date: Wed, 5 Nov 2025 12:42:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/hugetlb: extract sysfs into hugetlb_sysfs.c
To: Hui Zhu <hui.zhu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Hui Zhu <zhuhui@kylinos.cn>, Geliang Tang <geliang@kernel.org>
References: <cover.1762245157.git.zhuhui@kylinos.cn>
 <6c2479ad2a5227cc025954a68c9f3c43b659b698.1762245157.git.zhuhui@kylinos.cn>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <6c2479ad2a5227cc025954a68c9f3c43b659b698.1762245157.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.11.25 09:37, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> Currently, hugetlb.c contains both core management logic and sysfs
> interface implementations, making it difficult to maintain. This patch
> extracts the sysfs-related code into a dedicated file to improve code
> organization.
> 
> The following components are moved to mm/hugetlb_sysfs.c:
> - hugetlb page demote functions (demote_free_hugetlb_folios,
>    demote_pool_huge_page)
> - sysfs attribute definitions and handlers
> - sysfs kobject management functions
> - NUMA per-node hstate attribute registration
> 
> Several inline helper functions and macros are moved to
> mm/hugetlb_internal.h:
> - hstate_is_gigantic_no_runtime()
> - next_node_allowed()
> - get_valid_node_allowed()
> - hstate_next_node_to_alloc()
> - hstate_next_node_to_free()
> - for_each_node_mask_to_alloc/to_free macros
> 
> To support code sharing, these functions are changed from static to
> exported symbols:
> - remove_hugetlb_folio()
> - add_hugetlb_folio()
> - init_new_hugetlb_folio()
> - prep_and_add_allocated_folios()
> - __nr_hugepages_store_common()
> 
> The Makefile is updated to compile hugetlb_sysfs.o when
> CONFIG_HUGETLBFS is enabled. This maintains all existing functionality
> while improving maintainability by separating concerns.
> 
> MAINTAINERS is updated to add new file hugetlb_sysfs.c.
> 
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---

[...]

> --- /dev/null
> +++ b/mm/hugetlb_internal.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Internal HugeTLB definitions.
> + */
> +
> +#ifndef _LINUX_HUGETLB_INTERNAL_H
> +#define _LINUX_HUGETLB_INTERNAL_H
> +
> +#include <linux/hugetlb.h>
> +#include <linux/hugetlb_cgroup.h>
> +
> +/*
> + * Check if the hstate represents gigantic pages but gigantic page
> + * runtime support is not available. This is a common condition used to
> + * skip operations that cannot be performed on gigantic pages when runtime
> + * support is disabled.
> + */
> +static inline bool hstate_is_gigantic_no_runtime(struct hstate *h)
> +{
> +	return hstate_is_gigantic(h) && !gigantic_page_runtime_supported();
> +}
> +
> +/*
> + * common helper functions for hstate_next_node_to_{alloc|free}.
> + * We may have allocated or freed a huge page based on a different
> + * nodes_allowed previously, so h->next_node_to_{alloc|free} might
> + * be outside of *nodes_allowed.  Ensure that we use an allowed
> + * node for alloc or free.
> + */
> +static inline int next_node_allowed(int nid, nodemask_t *nodes_allowed)
> +{
> +	nid = next_node_in(nid, *nodes_allowed);
> +	VM_BUG_ON(nid >= MAX_NUMNODES);
> +
> +	return nid;
> +}
> +
> +static inline int get_valid_node_allowed(int nid, nodemask_t *nodes_allowed)
> +{
> +	if (!node_isset(nid, *nodes_allowed))
> +		nid = next_node_allowed(nid, nodes_allowed);
> +	return nid;
> +}
> +
> +/*
> + * returns the previously saved node ["this node"] from which to
> + * allocate a persistent huge page for the pool and advance the
> + * next node from which to allocate, handling wrap at end of node
> + * mask.
> + */
> +static inline int hstate_next_node_to_alloc(int *next_node,
> +					    nodemask_t *nodes_allowed)
> +{
> +	int nid;
> +
> +	VM_BUG_ON(!nodes_allowed);
> +
> +	nid = get_valid_node_allowed(*next_node, nodes_allowed);
> +	*next_node = next_node_allowed(nid, nodes_allowed);
> +
> +	return nid;
> +}
> +
> +/*
> + * helper for remove_pool_hugetlb_folio() - return the previously saved
> + * node ["this node"] from which to free a huge page.  Advance the
> + * next node id whether or not we find a free huge page to free so
> + * that the next attempt to free addresses the next node.
> + */
> +static inline int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
> +{
> +	int nid;
> +
> +	VM_BUG_ON(!nodes_allowed);
> +
> +	nid = get_valid_node_allowed(h->next_nid_to_free, nodes_allowed);
> +	h->next_nid_to_free = next_node_allowed(nid, nodes_allowed);
> +
> +	return nid;
> +}
> +
> +#define for_each_node_mask_to_alloc(next_node, nr_nodes, node, mask)		\
> +	for (nr_nodes = nodes_weight(*mask);				\
> +		nr_nodes > 0 &&						\
> +		((node = hstate_next_node_to_alloc(next_node, mask)) || 1);	\
> +		nr_nodes--)
> +
> +#define for_each_node_mask_to_free(hs, nr_nodes, node, mask)		\
> +	for (nr_nodes = nodes_weight(*mask);				\
> +		nr_nodes > 0 &&						\
> +		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
> +		nr_nodes--)
> +
> +extern void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
> +				 bool adjust_surplus);
> +extern void add_hugetlb_folio(struct hstate *h, struct folio *folio,
> +			      bool adjust_surplus);
> +extern void init_new_hugetlb_folio(struct folio *folio);
> +extern void prep_and_add_allocated_folios(struct hstate *h,
> +					  struct list_head *folio_list);
> +extern ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
> +					   struct hstate *h, int nid,
> +					   unsigned long count, size_t len);
> +

Using extern for functions is no longer used.

> +extern void hugetlb_sysfs_init(void) __init;
> +
> +#endif /* _LINUX_HUGETLB_INTERNAL_H */
> diff --git a/mm/hugetlb_sysfs.c b/mm/hugetlb_sysfs.c
> new file mode 100644
> index 000000000000..a2567947d32c
> --- /dev/null
> +++ b/mm/hugetlb_sysfs.c
> @@ -0,0 +1,629 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * HugeTLB sysfs interfaces.
> + */
> +

As I said, we usually keep the copyright from the original file.

> +#include <linux/swap.h>
> +#include <linux/page_owner.h>
> +#include <linux/page-isolation.h>
> +
> +#include "hugetlb_vmemmap.h"
> +#include "hugetlb_internal.h"
> +
> +static long demote_free_hugetlb_folios(struct hstate *src, struct hstate *dst,
> +				       struct list_head *src_list)
> +{
> +	long rc;
> +	struct folio *folio, *next;
> +	LIST_HEAD(dst_list);
> +	LIST_HEAD(ret_list);
> +
> +	rc = hugetlb_vmemmap_restore_folios(src, src_list, &ret_list);
> +	list_splice_init(&ret_list, src_list);
> +
> +	/*
> +	 * Taking target hstate mutex synchronizes with set_max_huge_pages.
> +	 * Without the mutex, pages added to target hstate could be marked
> +	 * as surplus.
> +	 *
> +	 * Note that we already hold src->resize_lock.  To prevent deadlock,
> +	 * use the convention of always taking larger size hstate mutex first.
> +	 */
> +	mutex_lock(&dst->resize_lock);
> +
> +	list_for_each_entry_safe(folio, next, src_list, lru) {
> +		int i;
> +		bool cma;
> +
> +		if (folio_test_hugetlb_vmemmap_optimized(folio))
> +			continue;
> +
> +		cma = folio_test_hugetlb_cma(folio);
> +
> +		list_del(&folio->lru);
> +
> +		split_page_owner(&folio->page, huge_page_order(src), huge_page_order(dst));
> +		pgalloc_tag_split(folio, huge_page_order(src), huge_page_order(dst));
> +
> +		for (i = 0; i < pages_per_huge_page(src); i += pages_per_huge_page(dst)) {
> +			struct page *page = folio_page(folio, i);
> +			/* Careful: see __split_huge_page_tail() */
> +			struct folio *new_folio = (struct folio *)page;
> +
> +			clear_compound_head(page);
> +			prep_compound_page(page, dst->order);
> +
> +			new_folio->mapping = NULL;
> +			init_new_hugetlb_folio(new_folio);
> +			/* Copy the CMA flag so that it is freed correctly */
> +			if (cma)
> +				folio_set_hugetlb_cma(new_folio);
> +			list_add(&new_folio->lru, &dst_list);
> +		}
> +	}
> +
> +	prep_and_add_allocated_folios(dst, &dst_list);
> +
> +	mutex_unlock(&dst->resize_lock);
> +
> +	return rc;
> +}
> +
> +static long demote_pool_huge_page(struct hstate *src, nodemask_t *nodes_allowed,
> +				  unsigned long nr_to_demote)
> +	__must_hold(&hugetlb_lock)
> +{
> +	int nr_nodes, node;
> +	struct hstate *dst;
> +	long rc = 0;
> +	long nr_demoted = 0;
> +
> +	lockdep_assert_held(&hugetlb_lock);
> +
> +	/* We should never get here if no demote order */
> +	if (!src->demote_order) {
> +		pr_warn("HugeTLB: NULL demote order passed to demote_pool_huge_page.\n");
> +		return -EINVAL;		/* internal error */
> +	}
> +	dst = size_to_hstate(PAGE_SIZE << src->demote_order);
> +
> +	for_each_node_mask_to_free(src, nr_nodes, node, nodes_allowed) {
> +		LIST_HEAD(list);
> +		struct folio *folio, *next;
> +
> +		list_for_each_entry_safe(folio, next, &src->hugepage_freelists[node], lru) {
> +			if (folio_test_hwpoison(folio))
> +				continue;
> +
> +			remove_hugetlb_folio(src, folio, false);
> +			list_add(&folio->lru, &list);
> +
> +			if (++nr_demoted == nr_to_demote)
> +				break;
> +		}
> +
> +		spin_unlock_irq(&hugetlb_lock);
> +
> +		rc = demote_free_hugetlb_folios(src, dst, &list);
> +
> +		spin_lock_irq(&hugetlb_lock);
> +
> +		list_for_each_entry_safe(folio, next, &list, lru) {
> +			list_del(&folio->lru);
> +			add_hugetlb_folio(src, folio, false);
> +
> +			nr_demoted--;
> +		}
> +
> +		if (rc < 0 || nr_demoted == nr_to_demote)
> +			break;
> +	}
> +
> +	/*
> +	 * Not absolutely necessary, but for consistency update max_huge_pages
> +	 * based on pool changes for the demoted page.
> +	 */
> +	src->max_huge_pages -= nr_demoted;
> +	dst->max_huge_pages += nr_demoted << (huge_page_order(src) - huge_page_order(dst));
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	if (nr_demoted)
> +		return nr_demoted;
> +	/*
> +	 * Only way to get here is if all pages on free lists are poisoned.
> +	 * Return -EBUSY so that caller will not retry.
> +	 */
> +	return -EBUSY;
> +}

[...]

The core demotion logic should stay in hugetlb.c. In egenral, I think 
hugetlb_sysfs.c should not contain any actualy hugetlb logic, but 
primarily only the sysfs interface.

This will also avoid having to export low-level functions like 
init_new_hugetlb_folio() in the internal header.

Likely, demote_store() should simply call a new function 
demote_pool_huge_pages() that ...

> +
> +static ssize_t demote_store(struct kobject *kobj,
> +	       struct kobj_attribute *attr, const char *buf, size_t len)
> +{
> +	unsigned long nr_demote;
> +	unsigned long nr_available;
> +	nodemask_t nodes_allowed, *n_mask;
> +	struct hstate *h;
> +	int err;
> +	int nid;
> +
> +	err = kstrtoul(buf, 10, &nr_demote);
> +	if (err)
> +		return err;
> +	h = kobj_to_hstate(kobj, &nid);
> +
> +	if (nid != NUMA_NO_NODE) {
> +		init_nodemask_of_node(&nodes_allowed, nid);
> +		n_mask = &nodes_allowed;
> +	} else {
> +		n_mask = &node_states[N_MEMORY];
> +	}
> +


... encapsulated the locking + loop below.

> +	/* Synchronize with other sysfs operations modifying huge pages */
> +	mutex_lock(&h->resize_lock);
> +	spin_lock_irq(&hugetlb_lock);
> +> +	while (nr_demote) {
> +		long rc;
> +
> +		/*
> +		 * Check for available pages to demote each time thorough the
> +		 * loop as demote_pool_huge_page will drop hugetlb_lock.
> +		 */
> +		if (nid != NUMA_NO_NODE)
> +			nr_available = h->free_huge_pages_node[nid];
> +		else
> +			nr_available = h->free_huge_pages;
> +		nr_available -= h->resv_huge_pages;
> +		if (!nr_available)
> +			break;
> +
> +		rc = demote_pool_huge_page(h, n_mask, nr_demote);
> +		if (rc < 0) {
> +			err = rc;
> +			break;
> +		}
> +
> +		nr_demote -= rc;
> +	}
> +
> +	spin_unlock_irq(&hugetlb_lock);
> +	mutex_unlock(&h->resize_lock);
> +
> +	if (err)
> +		return err;
> +	return len;
> +}
> +HSTATE_ATTR_WO(demote);



-- 
Cheers

David


