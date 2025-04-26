Return-Path: <linux-kernel+bounces-621256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6089A9D6E4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 03:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318734A559F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680CF1DF972;
	Sat, 26 Apr 2025 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dNd1PisT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A08282EE
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745629540; cv=none; b=SHa8nTtW4V0Kd5HNk/p1C0jtNZ35EOUVHp47QE6nMg7sXHsrVChEMxr2qX/GuiGEEw6rGT8ARcyzj5eZaycDjMgoUEtPo/NwrOtembKAvOLc15paLYIdH1/iY/T47ZZkHCsK74LAWqewcnCYD8o5bMNpIW04lSPKzUPA/V3fwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745629540; c=relaxed/simple;
	bh=yRkkSopWJBJ2Bj5q9h+LnLhTYo69bmvHBvjCNpIHSMo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Kh9MFrrH5XRZItTPpvBXnVroUSd8/qyAYCOGqyqARaqoJ1AOUotxvEuCZ8gJuQjt7UK1M2Fa2UPTC2qbz4y0U34ld/niC+fEsAA9I4uWzv/bGOKjaGmK79niU8XRy5SbEj5U62zd8U/HD4XxBOp2U5k+MuC7ipurV85JvNkfdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dNd1PisT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0284C4CEE4;
	Sat, 26 Apr 2025 01:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1745629540;
	bh=yRkkSopWJBJ2Bj5q9h+LnLhTYo69bmvHBvjCNpIHSMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dNd1PisT9Z2inqRSOaf++3O+j3G8lSR90Ugh9+x8FPGbLpod0FyGWl9bDZyfIOsX1
	 cgZ48RcefaV1fdsdkTsz59lFUR2utD/US/vQklmdrJaxQEJdqmZxOA2HkvXaaJ1Slq
	 lLitP9QhEdRnsQNspsu+MrVoEiOgZZ1ct+S+qP4s=
Date: Fri, 25 Apr 2025 18:05:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Bernardo C. Gutierrez Cantu" <bercantu@amazon.de>
Cc: <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <lkp@intel.com>, <rppt@kernel.org>,
 <yajun.deng@linux.dev>
Subject: Re: [PATCH] mm: memblock: Fix arguments passed to
 memblock_set_node()
Message-Id: <20250425180539.2b780a8b3d0958fcc2e8a500@linux-foundation.org>
In-Reply-To: <20250425102003.64122-1-bercantu@amazon.de>
References: <bd5842a92bd340799a74063f8da83d96@amazon.de>
	<20250425102003.64122-1-bercantu@amazon.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 10:20:03 +0000 "Bernardo C. Gutierrez Cantu" <bercantu@amazon.de> wrote:

> memblock_set_node() receives a `base` and a `size` arguments, but we are
> passing the `start` and `end` of the memory regions when iterating over
> them in memmap_init_reserved_pages() to set their node ids.
> 
> This results in the function setting the node ids for the reserved memory
> regions in `[base, base + base + size)` instead of `[base, base + size)`.
> 
> Pass `start` and `size`, so that we iterate over the correct range.
> 
> Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
> 
> ...
>
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2196,7 +2196,7 @@ static void __init memmap_init_reserved_pages(void)
>  		if (memblock_is_nomap(region))
>  			reserve_bootmem_region(start, end, nid);
>  
> -		memblock_set_node(start, end, &memblock.reserved, nid);
> +		memblock_set_node(start, region->size, &memblock.reserved, nid);
>  	}
>  
>  	/*

What were the runtime effects of this bug?

