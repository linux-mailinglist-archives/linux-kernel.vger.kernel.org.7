Return-Path: <linux-kernel+bounces-585689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19186A79629
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 21:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B277F1895064
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 19:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD7D2AF14;
	Wed,  2 Apr 2025 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ncccPar3"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238251EFF99
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743623867; cv=none; b=b5wby3j4o1a7cayguoxVIhnxxUsTru6VDVqaacHLuP66oGScji9jW/PZQ0wynKbnNBhNp8qsIVtBdkFgAs00jAEHEuXRDE9NywUTGvPBBJOIYbvzCYDMjulow7L6sEuU6ysR8a/YO4fe1AolgzSXvOmSDlttEgN8Ulz09yHxOEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743623867; c=relaxed/simple;
	bh=EJwqlq0Lg7dFZWE4wiac4v4UWCM1ZT6Lxn7UCwHrXB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3EWkGlhkRZN4PS61w+UyIeucZ5XnCnmITQGdj5q0Hu4kCmgIJ+I0Hwc63exb7CZDIMlupzrh4sVmMGVmJ8eDtjJuD6FIlj0UJ8JPRLrjZb9kObJ21OcKjuCClfew3RVGpFqIRHoskxo8VI7V5kAvMCdmHf6FnZbAk8uXm2KNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ncccPar3; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so1667406d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1743623864; x=1744228664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/arAk71omemZ9BOkrPpo5LzhJig+JDI2M6opIBMZzFY=;
        b=ncccPar3jLgfAOahgILYZ01t8FKNa0qGZCuzsur+sw1xws5iARuJw90b1mSf9vsn7c
         XIUDL+qw0+fyGrzz+TlHlNeAwIF+7iICZvAVNLvrgtarCXwuICXDBGM+jvfq/wpwXixV
         978wU3R4A0nZUBaumvmseAeiKv3P2bNQTia+sL++ejPEZWH3UUExruGjrqjwM14g8ibU
         fHQLJe3MZR5J8PYPGAKHiWecPw1j4JROmtcjQsqmbKXP+zg7jP7TRKs2u8V441nIpyEp
         Skxke4eri8xUSte7bfvgTNjiKtFxbPkLehmDILUP+mwIS353+Xb3wGDEh9yHdHd303ED
         aOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743623864; x=1744228664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/arAk71omemZ9BOkrPpo5LzhJig+JDI2M6opIBMZzFY=;
        b=iryAhAf+EpZcHSORStZOnVD0oTndY3U8MsrghfvjSVHXeYZwxskVfrB/EBCnAHF6mQ
         +v+5g/gFPR8TADTL17PGRdNV/sGW6v/DnPa1hIA+QHV+MP1c02yaxunTK6bsoJSOEjct
         n58RK9Puho/0rzH6PpZcxtuZuqHNUa6v7FgHHv4Hqnx4jZ/z4h/6dG4Z6duhmRV0EJ7z
         RnGjB0qrW0qmOfUSIrNv9/yEuuzYGiPwor7UAB/+s1Gf/tkdk1ccZorg42jx/7nHP6ad
         RUf715s99b86pg0jZOgb6GFm2Z3UhRFIkhHLA8YQ/RRDyPrGo0QtDEoo4Xlhgc+rZtRA
         3UQw==
X-Forwarded-Encrypted: i=1; AJvYcCWXoTiX6DIEtdgwe2GDQh5ITOseF+UeAfNByE/BPizDAxeQwaNBXURqIPoZMpSj3th4CplTyuI4ikesm8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ch3tesd+QXqL167RXB99GDHN22n+OEZzuvadDT2kCTk8nRmn
	4HL5XCYg+N6XLNRsb433f1PpJu1NAu2cS/rX5KvzqL/fM1LDVjxy4OihXovH0Ec=
X-Gm-Gg: ASbGncvWaYJrO2MC2JYmXG2NQ66ZFUhS4+Pjt70vNPjFNPsNhK2DNDq0eb3ffEs+WXd
	hVbnFjUOQ/msI5P8sR5qkChgLxyYgnuuxfwBJxQxBlfabOZmOHgy3KT4nhQjAEbOLlGVCOsXLfE
	vlewv2SqdzfhfOHew/hMAYQy0d2CgbjIk8n5s4z81WpTtV274D0hgybaDBwIdsLURW54TOanXOs
	c6ehEp7kGE2ETXr9v1KTCXFIVLPDxtyC6lEsuBpqHZPBn/AlVY1dqlcdsAvvWuLv7MepseFAhU+
	50m/AH6b40mDYzPAQAb7HrabLjZ7PMJVz50qBFgcgQe0OaB+g8gMKQ==
X-Google-Smtp-Source: AGHT+IHy6QeY7a8yJUt9hJrNflcfkJNYEEj7ZgU7hjOFP0BZQAnXXMq17Ms1f18ggo+ZGs85mSN/sg==
X-Received: by 2002:a05:6214:1941:b0:6ee:ba5b:d8d1 with SMTP id 6a1803df08f44-6ef0dc230eamr1343376d6.16.1743623863658;
        Wed, 02 Apr 2025 12:57:43 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eec9645a69sm78002106d6.31.2025.04.02.12.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 12:57:43 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:57:41 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev, sj@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, gourry@gourry.net,
	ying.huang@linux.alibaba.com, jonathan.cameron@huawei.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	minchan@kernel.org, senozhatsky@chromium.org
Subject: Re: [PATCH] zswap/zsmalloc: prefer the the original page's node for
 compressed data
Message-ID: <20250402195741.GD198651@cmpxchg.org>
References: <20250402191145.2841864-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402191145.2841864-1-nphamcs@gmail.com>

On Wed, Apr 02, 2025 at 12:11:45PM -0700, Nhat Pham wrote:
> Currently, zsmalloc, zswap's backend memory allocator, does not enforce
> any policy for the allocation of memory for the compressed data,
> instead just adopting the memory policy of the task entering reclaim,
> or the default policy (prefer local node) if no such policy is
> specified. This can lead to several pathological behaviors in
> multi-node NUMA systems:
> 
> 1. Systems with CXL-based memory tiering can encounter the following
>    inversion with zswap: the coldest pages demoted to the CXL tier
>    can return to the high tier when they are zswapped out, creating
>    memory pressure on the high tier.
> 
> 2. Consider a direct reclaimer scanning nodes in order of allocation
>    preference. If it ventures into remote nodes, the memory it
>    compresses there should stay there. Trying to shift those contents
>    over to the reclaiming thread's preferred node further *increases*
>    its local pressure, and provoking more spills. The remote node is
>    also the most likely to refault this data again. This undesirable
>    behavior was pointed out by Johannes Weiner in [1].
> 
> 3. For zswap writeback, the zswap entries are organized in
>    node-specific LRUs, based on the node placement of the original
>    pages, allowing for targeted zswap writeback for specific nodes.
> 
>    However, the compressed data of a zswap entry can be placed on a
>    different node from the LRU it is placed on. This means that reclaim
>    targeted at one node might not free up memory used for zswap entries
>    in that node, but instead reclaiming memory in a different node.
> 
> All of these issues will be resolved if the compressed data go to the
> same node as the original page. This patch encourages this behavior by
> having zswap pass the node of the original page to zsmalloc, and have
> zsmalloc prefer the specified node if we need to allocate new (zs)pages
> for the compressed data.
> 
> Note that we are not strictly binding the allocation to the preferred
> node. We still allow the allocation to fall back to other nodes when
> the preferred node is full, or if we have zspages with slots available
> on a different node. This is OK, and still a strict improvement over
> the status quo:
> 
> 1. On a system with demotion enabled, we will generally prefer
>    demotions over zswapping, and only zswap when pages have
>    already gone to the lowest tier. This patch should achieve the
>    desired effect for the most part.
> 
> 2. If the preferred node is out of memory, letting the compressed data
>    going to other nodes can be better than the alternative (OOMs,
>    keeping cold memory unreclaimed, disk swapping, etc.).
> 
> 3. If the allocation go to a separate node because we have a zspage
>    with slots available, at least we're not creating extra immediate
>    memory pressure (since the space is already allocated).
> 
> 3. While there can be mixings, we generally reclaim pages in
>    same-node batches, which encourage zspage grouping that is more
>    likely to go to the right node.
> 
> 4. A strict binding would require partitioning zsmalloc by node, which
>    is more complicated, and more prone to regression, since it reduces
>    the storage density of zsmalloc. We need to evaluate the tradeoff
>    and benchmark carefully before adopting such an involved solution.
> 
> This patch does not fix zram, leaving its memory allocation behavior
> unchanged. We leave this effort to future work.

zram's zs_malloc() calls all have page context. It seems a lot easier
to just fix the bug for them as well than to have two allocation APIs
and verbose commentary?

> -static inline struct zpdesc *alloc_zpdesc(gfp_t gfp)
> +static inline struct zpdesc *alloc_zpdesc(gfp_t gfp, const int *nid)
>  {
> -	struct page *page = alloc_page(gfp);
> +	struct page *page;
> +
> +	if (nid)
> +		page = alloc_pages_node(*nid, gfp, 0);
> +	else {
> +		/*
> +		 * XXX: this is the zram path. We should consider fixing zram to also
> +		 * use alloc_pages_node() and prefer the same node as the original page.
> +		 *
> +		 * Note that alloc_pages_node(NUMA_NO_NODE, gfp, 0) is not equivalent
> +		 * to allloc_page(gfp). The former will prefer the local/closest node,
> +		 * whereas the latter will try to follow the memory policy of the current
> +		 * process.
> +		 */
> +		page = alloc_page(gfp);
> +	}
>  
>  	return page_zpdesc(page);
>  }
> @@ -461,10 +476,13 @@ static void zs_zpool_destroy(void *pool)
>  	zs_destroy_pool(pool);
>  }
>  
> +static unsigned long zs_malloc_node(struct zs_pool *pool, size_t size,
> +				gfp_t gfp, const int *nid);
> +
>  static int zs_zpool_malloc(void *pool, size_t size, gfp_t gfp,
> -			unsigned long *handle)
> +			unsigned long *handle, const int nid)
>  {
> -	*handle = zs_malloc(pool, size, gfp);
> +	*handle = zs_malloc_node(pool, size, gfp, &nid);
>  
>  	if (IS_ERR_VALUE(*handle))
>  		return PTR_ERR((void *)*handle);

>  }
>  
>  
> -/**
> - * zs_malloc - Allocate block of given size from pool.
> - * @pool: pool to allocate from
> - * @size: size of block to allocate
> - * @gfp: gfp flags when allocating object
> - *
> - * On success, handle to the allocated object is returned,
> - * otherwise an ERR_PTR().
> - * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
> - */
> -unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> +static unsigned long zs_malloc_node(struct zs_pool *pool, size_t size,
> +				gfp_t gfp, const int *nid)
>  {
>  	unsigned long handle;
>  	struct size_class *class;

> @@ -1397,6 +1406,21 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>  
>  	return handle;
>  }
> +
> +/**
> + * zs_malloc - Allocate block of given size from pool.
> + * @pool: pool to allocate from
> + * @size: size of block to allocate
> + * @gfp: gfp flags when allocating object
> + *
> + * On success, handle to the allocated object is returned,
> + * otherwise an ERR_PTR().
> + * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
> + */
> +unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> +{
> +	return zs_malloc_node(pool, size, gfp, NULL);
> +}
>  EXPORT_SYMBOL_GPL(zs_malloc);
>  
>  static void obj_free(int class_size, unsigned long obj)

