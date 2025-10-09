Return-Path: <linux-kernel+bounces-846200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B249BBC7437
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A3AB4E35E7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84151212550;
	Thu,  9 Oct 2025 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bx8vpW1o"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9C1FF5E3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979052; cv=none; b=BFk/IYml7SICQrQBOM929kYHQbVJBJR+HQVlYcFhfV59ByH/vxz8dJ0nyT2CxB2igyLro1/29Wbaczyao4I43O+1dae7FCRYUvWwD5IjYfpunD7z7qMewRCC0cXAOzmU510dlislZ2w/FOtYX/Pp2RKyolvP2plzUJu+Zjpx7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979052; c=relaxed/simple;
	bh=VTEvkMLVlG2PxqlVtlSF/7ys2dSIRaMlXK+DQqTTTZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+tpdCaTRufDxMkLB4fqzI7rTQuSmf41zXZkAtuJGdt23zZ/wpozb/HN5oxfYGGM3DKUt9LHlaBt1vCQmNNvZ10pkMTDTBjmXBHgBSNe2QWHzpp7gB57iGkS45UaDex2lrqfdXdMv8KyyrnqwwkdABPOcqINSwb7uX/M2Rphy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bx8vpW1o; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <612e4576-437f-4c63-b56a-fa2ad62779b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759979048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nc0BA2368cULBNmhkzmu+0aM1upoZ74WV8ag6VwaBtA=;
	b=Bx8vpW1oUFLWj43pRUUUQ3p9yQWAM9Mc5ScpXQ9Ot2Ldetq+STH3gt0F6xAKeixN2Ofllf
	fhwoKwYK1XCEhRqnEA53npfuPDmTUgjlYoykw9p4X5FpziER+YUHMod/7SPcdT303S7fmr
	fxTGJEFylUvKfpGONQLLa+rw/PBwpsE=
Date: Thu, 9 Oct 2025 11:03:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] Docs/admin-guide/mm/zswap: s/red-black tree/xarray/
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 kernel-team@meta.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251003203851.43128-1-sj@kernel.org>
 <20251003203851.43128-5-sj@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20251003203851.43128-5-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/10/4 04:38, SeongJae Park wrote:
> The change from commit 796c2c23e14e ("zswap: replace RB tree with
> xarray") is not reflected on the document.  Update the document.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>   Documentation/admin-guide/mm/zswap.rst | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
> index 283d77217c6f..2464425c783d 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -59,11 +59,11 @@ returned by the allocation routine and that handle must be mapped before being
>   accessed.  The compressed memory pool grows on demand and shrinks as compressed
>   pages are freed.  The pool is not preallocated.
>   
> -When a swap page is passed from swapout to zswap, zswap maintains a mapping
> -of the swap entry, a combination of the swap type and swap offset, to the
> -zsmalloc handle that references that compressed swap page.  This mapping is
> -achieved with a red-black tree per swap type.  The swap offset is the search
> -key for the tree nodes.
> +When a swap page is passed from swapout to zswap, zswap maintains a mapping of
> +the swap entry, a combination of the swap type and swap offset, to the zsmalloc
> +handle that references that compressed swap page.  This mapping is achieved
> +with an xarray per swap type.  The swap offset is the search key for the xarray
> +nodes.
>   
>   During a page fault on a PTE that is a swap entry, the swapin code calls the
>   zswap load function to decompress the page into the page allocated by the page

