Return-Path: <linux-kernel+bounces-847615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 410DBBCB481
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB4F7352555
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ED519597F;
	Fri, 10 Oct 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j+gYBVsu"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6D2868B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760056351; cv=none; b=M930USdxF8UmyBF0zI1eHvyNLRZ1rDLQhfwd2YJJuMvcWiFkcVo9bYgV+OuvqcqoR0nJ/NKY4Gmd2YnRcIIu2pAPCTFZhbIJkgPF7Fol7UIGUTvybP+VSxBSPlHJoUCKloEb3pLi2QcJk9z6f8XNhhPX0vhlDqqS3kvXl9GEfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760056351; c=relaxed/simple;
	bh=neb4BWhF1kpeQu72uBvATE2RS3RFn5OZSCDuRrSjeyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkKWvYsmjMnF8A5F5xk5hfkCD9Y/swcLzh3vkvdRvmCn5h8tNCegA63XpBJV5tKyKtlGHaOnyPXofHFY0sTCGgjdqSLaA/9iU+H+JHuHfqI5sk6XJ5V/mJbCqRXSM+FMxTKytq++E4FiLgGfrD+aWuHKcFiDJhieZuxeULWaEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j+gYBVsu; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 Oct 2025 17:32:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760056347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XjmMM8FOadfDH2bKmNKtpW1btFVf4eiY20naezZdF8=;
	b=j+gYBVsu2udOpyZ76DEdDaJVwJ1nFBy7pAC7jMSF3bNmmF69PxxdYmONjSwcF1gIGyTI5R
	G6h2jq7IkvpOFUBX+dkvvwEr+O1EvqL9PKO0gqYs0YFHEWZM+8O2gTIOspsXUG4x57lCyn
	//tr3wkFHutTugKihehv79TmGaq48nY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Usama Arif <usamaarif642@gmail.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com, 
	kas@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] mm/hugetlb: allow overcommitting gigantic
 hugepages
Message-ID: <6bzfxls4dltmmogvjbr5q7wr2zf5grgcbla3mr4bah7kg6pdbu@qgx5lslkza57>
References: <20251009172433.4158118-1-usamaarif642@gmail.com>
 <20251009172433.4158118-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009172433.4158118-2-usamaarif642@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 09, 2025 at 06:24:31PM +0100, Usama Arif wrote:
> Currently, gigantic hugepages cannot use the overcommit mechanism
> (nr_overcommit_hugepages), forcing users to permanently reserve memory via
> nr_hugepages even when pages might not be actively used.
> 
> The restriction was added in 2011 [1], which was before there was support
> for reserving 1G hugepages at runtime.
> Remove this blanket restriction on gigantic hugepage overcommit.
> This will bring the same benefits to gigantic pages as hugepages:
> 
> - Memory is only taken out of regular use when actually needed
> - Unused surplus pages can be returned to the system
> - Better memory utilization, especially with CMA backing which can
>   significantly increase the changes of hugepage allocation
> 
> Without this patch:
> echo 3 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_overcommit_hugepages
> bash: echo: write error: Invalid argument
> 
> With this patch:
> echo 3 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_overcommit_hugepages
> ./mmap_hugetlb_test
> Successfully allocated huge pages at address: 0x7f9d40000000
> 
> cat mmap_hugetlb_test.c
> ...
>     unsigned long ALLOC_SIZE = 3 * (unsigned long) HUGE_PAGE_SIZE;
>     addr = mmap(NULL,
>                 ALLOC_SIZE, // 3GB
>                 PROT_READ | PROT_WRITE,
>                 MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_HUGE_1GB,
>                 -1,
>                 0);
> 
>     if (addr == MAP_FAILED) {
>         fprintf(stderr, "mmap failed: %s\n", strerror(errno));
>         return 1;
>     }
>     printf("Successfully allocated huge pages at address: %p\n", addr);
> ...
> 
> [1] https://git.zx2c4.com/linux-rng/commit/mm/hugetlb.c?id=adbe8726dc2a3805630d517270db17e3af86e526
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

