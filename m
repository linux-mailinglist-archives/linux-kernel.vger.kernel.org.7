Return-Path: <linux-kernel+bounces-884105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8DEC2F5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1833B7A83
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB89A2C11F0;
	Tue,  4 Nov 2025 05:26:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B1E286885
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234007; cv=none; b=b7VsJYpWoF9pZ+ip5GAHYtxbPevZiQET3WZqZ6utdjE8docVaJEm12yMKjS7+Hy9ji6QgXFrU1TbIBaahom/nD+FLe0IhoxfKgyRoXqJlGv9fs3vQ0Yx34aBvSPKPqqIwfwX+Qh0NuUrkl0FEdpH8Kq2qfZdk5D+lJBWqvvsPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234007; c=relaxed/simple;
	bh=blFs3Nnkx2tTKk80+jF/bZSZsfa6YMYZt/Cm6L77Pgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2rhRqatH+etwRhCrVZyzpVfCmFDtnDKfwWttV4UDcgcqHi38qiw5GYyp6c4g9kFUmQ8QA7KmT7pDhn0Dlr9+zCR/LBnC/GrulLycae9mWImXQwXoY1TVpG+NTHfEra+7/NuNqYfONXNsWVsZgBVh2TRTdBAfJeSjxOgHxBNp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BEC51CE0;
	Mon,  3 Nov 2025 21:26:36 -0800 (PST)
Received: from [10.164.18.64] (unknown [10.164.18.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC0BE3F63F;
	Mon,  3 Nov 2025 21:26:40 -0800 (PST)
Message-ID: <5bb311a5-b59f-4897-b4d0-4e06d7d2b3f2@arm.com>
Date: Tue, 4 Nov 2025 10:56:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: prevent infinite loop in kmalloc_nolock() with
 debugging
To: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251103-fix-nolock-loop-v1-1-6e2b3e82b9da@suse.cz>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251103-fix-nolock-loop-v1-1-6e2b3e82b9da@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 03/11/25 5:54 pm, Vlastimil Babka wrote:
> In review of a followup work, Harry noticed a potential infinite loop.
> Upon closed inspection, it already exists for kmalloc_nolock() on a
> cache with debugging enabled, since commit af92793e52c3 ("slab:
> Introduce kmalloc_nolock() and kfree_nolock().")
>
> When alloc_single_from_new_slab() fails to trylock node list_lock, we
> keep retrying to get partial slab or allocate a new slab. If we indeed
> interrupted somebody holding the list_lock, the trylock fill fail

Hi Vlastimil,

I see that we always take n->list_lock spinlock by disabling irqs. So
how can we interrupt someone holding the list_lock?
If we are already in a path holding list_lock, and trigger a slab allocation
and recursively end up in the same path again, we can get the situation
you mention, is that possible?

> deterministically and we end up allocating and defer-freeing slabs
> indefinitely with no progress.
>
> To fix it, fail the allocation if spinning is not allowed. This is
> acceptable in the restricted context of kmalloc_nolock(), especially
> with debugging enabled.
>
> Reported-by: Harry Yoo <harry.yoo@oracle.com>
> Closes: https://lore.kernel.org/all/aQLqZjjq1SPD3Fml@hyeyoo/
> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> as we discussed in the linked thread, 6.18 hotfix to be included in
> slab/for-next-fixes
> ---
>   mm/slub.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index d4367f25b20d..f1a5373eee7b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4666,8 +4666,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>   	if (kmem_cache_debug(s)) {
>   		freelist = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
>   
> -		if (unlikely(!freelist))
> +		if (unlikely(!freelist)) {
> +			/* This could cause an endless loop. Fail instead. */
> +			if (!allow_spin)
> +				return NULL;
>   			goto new_objects;
> +		}
>   
>   		if (s->flags & SLAB_STORE_USER)
>   			set_track(s, freelist, TRACK_ALLOC, addr,
>
> ---
> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> change-id: 20251103-fix-nolock-loop-854e0101672f
>
> Best regards,

