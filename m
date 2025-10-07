Return-Path: <linux-kernel+bounces-844869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDB1BC2F83
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE4124E34E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0110125A2A2;
	Tue,  7 Oct 2025 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QqZrbH4y"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8E25A642
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880477; cv=none; b=FFFP7Ikz3t0tBxCYBwxZPfYwTfbc8Ae6HmnOEuq3xlvrU26aSfDuwm/qoUzxRkNyoaFf91jJFAueEWGnzMWjf2lBku/Mki0twoekIQii6GQ8W4xYvWaNlVIoAn5xkUw42jRcJgUUS6J2gZ8o3GN1R37XXKYoxI/QkLCIU2C3IXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880477; c=relaxed/simple;
	bh=3xmrZ7hlyec99mKVWTkw86+6HuXYCk8T0B5mx4jKyic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=silmv9L5ZOGq2pMzVyfGCaUp3uFWiyQJ6jqh6GqjxA57P39B4ayo7s8AOpuirfz6m3DhftBEeRRp/F5ynfLspiwa/psYYMePZP4Lmqyzxy2xrqI2m8XccvUZZ5JO44Pe06mQAHxgK37l/YSqQFu6/OcECgo8loWGq28rsMW6dFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QqZrbH4y; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 Oct 2025 23:41:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759880473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYXV+Qnwlv/z/wJbyc9UEz70EvXyBteIQP5Vd1/xMI0=;
	b=QqZrbH4yImYyWUDdM+niZ73T8dgbBbJWK6HWt/+yM68ii/XRRp8ZvHsewlimuAj5NYkoea
	C0D+GPzYNCbmybAPVpvUBt8JPvK75HU/JYLx22FePVwzMcdXJQM8bVjc9yoL0q30CgyCwF
	uEijvTQnqXHjVXvLXN7FSPTVywP1Wsw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm/zswap: s/red-black tree/xarray/
Message-ID: <yo7yflwtjp3xjqnfkvuakxamvpxlv5jnukaij2vr5gdg546if6@xcooxyrm7awp>
References: <20251003203851.43128-1-sj@kernel.org>
 <20251003203851.43128-4-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003203851.43128-4-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 03, 2025 at 01:38:50PM -0700, SeongJae Park wrote:
> Changes made by commit 796c2c23e14e ("zswap: replace RB tree with
> xarray") is not reflected on a comment.  Update the comment.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  mm/zswap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6b1c8832a4f..5d0f8b13a958 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -175,7 +175,7 @@ static struct shrinker *zswap_shrinker;
>   * This structure contains the metadata for tracking a single compressed
>   * page within zswap.
>   *
> - * swpentry - associated swap entry, the offset indexes into the red-black tree
> + * swpentry - associated swap entry, the offset indexes into the xarray
>   * length - the length in bytes of the compressed page data.  Needed during
>   *          decompression.
>   * referenced - true if the entry recently entered the zswap pool. Unset by the
> -- 
> 2.39.5

