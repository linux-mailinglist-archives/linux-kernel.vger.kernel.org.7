Return-Path: <linux-kernel+bounces-846199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344ECBC7431
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F5E189B55F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA8A212549;
	Thu,  9 Oct 2025 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ilJhnx/f"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03489202961
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979010; cv=none; b=ojTuqZQtDyWNL8gC2H4CfNzJvrFsTGA+7HvPlncoB60ocHW0+Q5NqIYbksLDitNqwVR6qCj8dyrCkZS5V0+EqKEUrQlTNaLbEx4LfrwADtYLvs3EW9Kid0HY/no9ocVj7BdBPIB4XiPBIxkofDWbPU99hvXz1SP661ckKNPiijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979010; c=relaxed/simple;
	bh=Ubbk559EfMb2HzxYynQyFIRVK9pFGnZbZl+pzTy4zGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVpJWqARrpIYYfx6Yu9QuDRqElnzrMOef4cCqmaCfFUky50rEGnRlXuL0j5ZUB0N6IPne64DGPxFS7wdpuGgzXb2tLjxcA6hv6csWsyrxH92SuoX34slrY0/uJ5tAt05pjgS+l6ucqr5RlQUN9Ci+GN4bO/UvEMysURcr1o7YUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ilJhnx/f; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <821faf8b-e61e-4f0a-bbb8-4a0f00c9fe53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759979005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJj6r6vYdVMEeyImI7y3r2/OjUGGxLmQKEZBFpvBlaw=;
	b=ilJhnx/ftLkdNla4VIywngzFsaPQIQwX0mNkGUAXqUJPxKUSRnuS0b+bgKKfts0BW60XOu
	hJLnSG23ToRqVUi7pvzv1wtwUkJN8Yj8i+koZcqos/c3zFHN096KjNSCl6Qr1YTTWl7k6f
	6fpnA8QQHPNUxHpJJbQwsW/4EBr0wFI=
Date: Thu, 9 Oct 2025 11:03:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] mm/zswap: s/red-black tree/xarray/
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251003203851.43128-1-sj@kernel.org>
 <20251003203851.43128-4-sj@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20251003203851.43128-4-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/10/4 04:38, SeongJae Park wrote:
> Changes made by commit 796c2c23e14e ("zswap: replace RB tree with
> xarray") is not reflected on a comment.  Update the comment.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>   mm/zswap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6b1c8832a4f..5d0f8b13a958 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -175,7 +175,7 @@ static struct shrinker *zswap_shrinker;
>    * This structure contains the metadata for tracking a single compressed
>    * page within zswap.
>    *
> - * swpentry - associated swap entry, the offset indexes into the red-black tree
> + * swpentry - associated swap entry, the offset indexes into the xarray
>    * length - the length in bytes of the compressed page data.  Needed during
>    *          decompression.
>    * referenced - true if the entry recently entered the zswap pool. Unset by the

