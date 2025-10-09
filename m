Return-Path: <linux-kernel+bounces-846198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCADBC742B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6208C4E6F51
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818920FAB2;
	Thu,  9 Oct 2025 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VyIJmssX"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C22137C52
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978983; cv=none; b=Su2XkZ7xk5vxhFEX1z0PsAMHA5vThU1Ey9yUY3KvuzRkPwX1j5+ivXBL5Ygpy2JhWza/zU4LOnDoot5zQaqJZeMQ6aVppUvd881oahgrBhLoLmUS2pv/JwLcgjitWqJy0KHXzPQLDHN8VBFUtGsh7v/Ta88hg2+lSN0B4t3Xd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978983; c=relaxed/simple;
	bh=jXqYSB6FAdmUnZFoKmnXNwGWyrXkXVtJuSNystAZJCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIQJDWlqYUUjBi6Ev8un0oWVTQJy/bcxSOxRmS98CQoaJ3fh4tcoZ5Z+IoZrjATHVOhzI9nrXdPf7NrEpQEiWVXfb+hmPZfUKglmAu+luEuiC/DTqmpy8CpgnOecriEgmss9b+Tv0S9CQ8cqMAUN7KqE2XobidvH6xDNVTnqju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VyIJmssX; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e3de261-0421-439e-a763-7f2895c2496f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759978978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YEIJe1l7uPPwXCLKi51on2x3YEMf9V1p1qQ0Ogt3bY=;
	b=VyIJmssXWpo4mfVElfR8iHujbljan6VThvQAVU7woPIpircc2b+FrP//5zchULofz5Stjn
	Vty8Ap7MH+g+82dkjpSBtZpApBVxWiDXh95a/dWrMrBWNyrHXlpzmdu6C8xKMGwiHtavco
	tNyFnoSdV0823jYmFGf9N6JSVGWtXew=
Date: Thu, 9 Oct 2025 11:02:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] mm/zswap: fix typos: s/zwap/zswap/
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 cgroups@vger.kernel.org, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251003203851.43128-1-sj@kernel.org>
 <20251003203851.43128-3-sj@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20251003203851.43128-3-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/10/4 04:38, SeongJae Park wrote:
> As the subject says.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>   mm/memcontrol.c | 2 +-
>   mm/zswap.c      | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 69c970554e85..74b1bc2252b6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5421,7 +5421,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>    * @size: size of compressed object
>    *
>    * This forces the charge after obj_cgroup_may_zswap() allowed
> - * compression and storage in zwap for this cgroup to go ahead.
> + * compression and storage in zswap for this cgroup to go ahead.
>    */
>   void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
>   {
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 80619c8589a7..f6b1c8832a4f 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -879,7 +879,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>   	 * acomp instance, then get those requests done simultaneously. but in this
>   	 * case, zswap actually does store and load page by page, there is no
>   	 * existing method to send the second page before the first page is done
> -	 * in one thread doing zwap.
> +	 * in one thread doing zswap.
>   	 * but in different threads running on different cpu, we have different
>   	 * acomp instance, so multiple threads can do (de)compression in parallel.
>   	 */
> @@ -1128,7 +1128,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>   	 *
>   	 * 1. We extract the swp_entry_t to the stack, allowing
>   	 *    zswap_writeback_entry() to pin the swap entry and
> -	 *    then validate the zwap entry against that swap entry's
> +	 *    then validate the zswap entry against that swap entry's
>   	 *    tree using pointer value comparison. Only when that
>   	 *    is successful can the entry be dereferenced.
>   	 *

