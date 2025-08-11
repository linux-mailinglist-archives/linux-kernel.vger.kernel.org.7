Return-Path: <linux-kernel+bounces-762016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E85B2011B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DF73BABBF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB62DAFD8;
	Mon, 11 Aug 2025 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuLOyZdP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F04270542
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899299; cv=none; b=AMMDwydgWchLI7bMW8FvcaFRhdU2Qkt2xcSxWxnfJz7MahNkXdeK+raFPU4oz/OeQBsb9n5Fvy726ci2Uafc4K3kZbib+3/4l5/9Jj9kKYd3R/bKSSu8TCPlk4UuJyV4Q/Vm1mQsdDX7wzwLRaSzKgFB73A/7OfzjoZnJmbO2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899299; c=relaxed/simple;
	bh=cRDAcnSTfM6+4j9YMSLVpxr+sl6lD4Ia4qXp2Y2QPMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1tjpf3EUzAoyYuSX1vX307lJi2PU8zbEoSsUE7k206gEDSBAINVS6ww9i+fEgLQbPeisRju5eVTNbvk7wP9Gdu5QBhAvXQcRim64CN8nFTs7Un0adm/Ts5Awc3Xi2X2Eth+Ak/Z+qs525ORHqrnq8oFtnn8bOtxqayE0ewoz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuLOyZdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7F1C4CEED;
	Mon, 11 Aug 2025 08:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754899298;
	bh=cRDAcnSTfM6+4j9YMSLVpxr+sl6lD4Ia4qXp2Y2QPMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuLOyZdPb/GhGEiVasAWpmi4l5P9GYfX7kda8eRZI31q1A74LlBC6abw3g2Smzg4w
	 tJV3+jWPQpR9x4GMKNyjwc5wvSqW3n5gt0VN1NlnKmXYrjOWOq/wEnw/R6S45ub8tf
	 ry0ogOZMx9770+6joHrAlRZpeHMdd/ps6RdLAtLQ9n9bIp17ZiTMcaffO+e7xYR6qh
	 q1Js5hYKEYAaeCL8pUOFg0jldGTiH5w7YZZbDKUrZN3BzFKkSf5YsLyIvfj/vipGng
	 ET7htCJmsCkQRhU8eNwdcpjYRBNguO28rP707Qn2JGsZClRpn/7bPJd2TI+ppwMYtI
	 sW3RjzGV0PFFw==
Date: Mon, 11 Aug 2025 11:01:32 +0300
From: Mike Rapoport <rppt@kernel.org>
To: pratyush.brahma@oss.qualcomm.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v2] mm/numa_memblks: Use pr_debug instead of
 printk(KERN_DEBUG)
Message-ID: <aJmjXABrInqumY1-@kernel.org>
References: <20250811-numa-dbg-v2-1-7842aa2d4c41@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-numa-dbg-v2-1-7842aa2d4c41@oss.qualcomm.com>

On Mon, Aug 11, 2025 at 12:13:54PM +0530, pratyush.brahma@oss.qualcomm.com wrote:
> From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> 
> Replace the direct usage of printk(KERN_DEBUG ...) with pr_debug(...) to
> align with the consistent `pr_*` API usage within the file.
> 
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> ---
> Changes in v2:
> - Removed printk header as suggested by Joshua.
> - Link to v1: https://lore.kernel.org/r/20250808-numa-dbg-v1-1-2ddd1ec634aa@oss.qualcomm.com
> ---
>  mm/numa_memblks.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index 541a99c4071a67e5b0ef66f4136dee268a880003..ed6fcfca057ab4c9a8aa26cd1929551b4ded4a5b 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -2,7 +2,6 @@
>  
>  #include <linux/array_size.h>
>  #include <linux/sort.h>
> -#include <linux/printk.h>

Please don't, pr_debug is defined there.

>  #include <linux/memblock.h>
>  #include <linux/numa.h>
>  #include <linux/numa_memblks.h>
> @@ -76,7 +75,7 @@ static int __init numa_alloc_distance(void)
>  		for (j = 0; j < cnt; j++)
>  			numa_distance[i * cnt + j] = i == j ?
>  				LOCAL_DISTANCE : REMOTE_DISTANCE;
> -	printk(KERN_DEBUG "NUMA: Initialized distance table, cnt=%d\n", cnt);
> +	pr_debug("NUMA: Initialized distance table, cnt=%d\n", cnt);
>  
>  	return 0;
>  }
> 
> ---
> base-commit: 479058002c32b77acac43e883b92174e22c4be2d
> change-id: 20250808-numa-dbg-62a8b2092c56
> 
> Best regards,
> -- 
> Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> 

-- 
Sincerely yours,
Mike.

