Return-Path: <linux-kernel+bounces-772369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F152B291D8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F060B2084BB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6561F22424C;
	Sun, 17 Aug 2025 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4XdW7xb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DF2236F2;
	Sun, 17 Aug 2025 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755412061; cv=none; b=FqsUaTLqYhnp1NhdLq8rEWT6nagi3v/n+Nk+TQe0mF5zgylpxzUd/MjLgJPe89vNL4P8qmhrCAYuBM9fh+WPEj9gDOYszwO/M6ZgxC4JTl2nbsteNrJuwl4bjskZ5SAEhlHER42wbwYV1kDn0k+0V8OsutSQPGqldzPGVkfv/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755412061; c=relaxed/simple;
	bh=TpmqSwdZ371xVQIviS8OQTjs+jZME4B/LsCHX3bDftw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/qe1AnrfSHNiWDYX5iOtUtWm4sv9KFuMjZmBJbDJ1DQh/ZiYRE4zTQ+Bq/iYdfGiRs7vfX5reUVqs5yU6yFQm060CAvcYUPr0/Fr6vRHqV0ArV6EDhnV463qbahsJJa80EDa42oNVmT+NZoACuvBsj215a8mKXsJF+bSFI/yEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4XdW7xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0C1C4CEEB;
	Sun, 17 Aug 2025 06:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755412061;
	bh=TpmqSwdZ371xVQIviS8OQTjs+jZME4B/LsCHX3bDftw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4XdW7xbTBpqFEORPxC1v3F8aSWpsZ+Ea/95jk9ry8PCZOXJVI+ZamyYFNTPxhbEQ
	 6INhZjVaNkUoxlfLOTIBvpRSlhgB4QOPTStKhXz4gtG4AoiHUW/hMgNK3LW3DI4oX/
	 ksMbj7ImH7mHfYimQfwqymhHw1c7TCzEpOrEflQbr/ABlhHGWv5dKkU+P6OXz4Bj1u
	 LgDQ8T/aDiYzq2nDIC3lR+KqKxwtjg2TFon0nNaRaR7/GcFMEGdVce8R4hFxyFt+Ha
	 QT+1F+o1GJapakOZSMqtE06huxFIx7w6OS7Mro9hVMlGQm5OcciEYHM6jN7jtJmxMP
	 yEgE2yPtudFlA==
Date: Sun, 17 Aug 2025 09:27:33 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Yin Tirui <yintirui@huawei.com>
Cc: robh@kernel.org, saravanak@google.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, david@redhat.com,
	Jonathan.Cameron@huawei.com, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	wangkefeng.wang@huawei.com, chenjun102@huawei.com
Subject: Re: [PATCH v2] of_numa: fix uninitialized memory nodes causing
 kernel panic
Message-ID: <aKF2VZ1y8OuEChmw@kernel.org>
References: <20250816073131.2674809-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816073131.2674809-1-yintirui@huawei.com>

Hi,

On Sat, Aug 16, 2025 at 03:31:31PM +0800, Yin Tirui wrote:
> When the number of CPUs is fewer than the number of memory nodes,
> some memory nodes may not be properly initialized because they are
> not added to numa_nodes_parsed during memory parsing.

Why the issue happens when there are less CPUs than nodes?
Does anything updates numa_nodes_parsed when there are more CPUs than
nodes?
 
> In of_numa_parse_memory_nodes(), after successfully adding a memory
> block via numa_add_memblk(), the corresponding node ID should be
> marked as parsed. However, the current implementation in numa_add_memblk()

... current implementation of of_numa_parse_memory_nodes()?

> only adds the memory block to numa_meminfo but fails to update

maybe "... but skips updating"

> numa_nodes_parsed, leaving some nodes uninitialized.
> 
> During boot in a QEMU-emulated ARM64 NUMA environment, the kernel
> panics when free_area_init() attempts to access NODE_DATA() for
> memory nodes that were uninitialized.
> 
> [    0.000000] Call trace:
> [    0.000000]  free_area_init+0x620/0x106c (P)
> [    0.000000]  bootmem_init+0x110/0x1dc
> [    0.000000]  setup_arch+0x278/0x60c
> [    0.000000]  start_kernel+0x70/0x748
> [    0.000000]  __primary_switched+0x88/0x90

Would have be nice to have the full crash trace here and more details how
qemu was run.

> Cc: stable@vger.kernel.org
> Fixes: 767507654c22 ("arch_numa: switch over to numa_memblks")
> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> 
> ---
> 
> v2: Move the changes to the of_numa related. Correct the fixes tag.
> ---
>  drivers/of/of_numa.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index 230d5f628c1b..cd2dc8e825c9 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -59,8 +59,11 @@ static int __init of_numa_parse_memory_nodes(void)
>  			r = -EINVAL;
>  		}
>  
> -		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++)
> +		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++) {
>  			r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
> +			if (!r)
> +				node_set(nid, numa_nodes_parsed);
> +		}
>  
>  		if (!i || r) {
>  			of_node_put(np);
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

