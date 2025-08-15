Return-Path: <linux-kernel+bounces-770783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EDCB27EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDDF1D019E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022AA285CA4;
	Fri, 15 Aug 2025 11:11:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C6A935
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256286; cv=none; b=lXBEbt2pqfBRtKZDAB+SnvEVYtQuRgK0vq0GMBatke8S711JQY150dbVJ539jvbrTeSWyuebuhBBXp1kSMZZl2J4bA9ZGzqT1ubkiy+JR2nchd16tC9vt1oltqwrrvNW+GBqeu37YPWkPtbTGp9sI67J51zlAWFI14gWp99vCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256286; c=relaxed/simple;
	bh=7GvVS+FWJlGaHfMtq0NY7qEbpgXcUxwhOBqmcov+gzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bQPWSNF7StlO6um1P1WKAztLtk+AwLfNlpqsvGr8ukj6hfYQBIOQ6SZYtCTw4BlChd/aVKbD4LEIbQuq26tAd7VZqNsA78clQoelByN5aklj+zdk5eVagK00m+0bkiGsiW/okEUiWu+ktZ+3sjzYdkDkunfpfpSIbWz5PiZ2i7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c3K9B2y9mz2gKyr;
	Fri, 15 Aug 2025 19:08:30 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FB6A140145;
	Fri, 15 Aug 2025 19:11:21 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 19:11:20 +0800
Message-ID: <dd536c65-0f00-4b29-9042-f1e84c374c81@huawei.com>
Date: Fri, 15 Aug 2025 19:11:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/numa: fix uninitialized memory nodes causing kernel
 panic
To: Yin Tirui <yintirui@huawei.com>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <david@redhat.com>, <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <chenjun102@huawei.com>
References: <20250815103040.511627-1-yintirui@huawei.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20250815103040.511627-1-yintirui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2025/8/15 18:30, Yin Tirui wrote:
> When the number of CPUs is fewer than the number of memory nodes,
> some memory nodes may not be properly initialized because they are
> not added to numa_nodes_parsed during memory parsing.
> 
> In of_numa_parse_memory_nodes(), after successfully adding a memory
> block via numa_add_memblk(), the corresponding node ID should be
> marked as parsed. However, the current implementation in numa_add_memblk()
> only adds the memory block to numa_meminfo but fails to update
> numa_nodes_parsed, leaving some nodes uninitialized.

The issue is not existed in ACPI NUMA,

     acpi_parse_memory_affinity
       numa_add_memblk
       node_set(node, numa_nodes_parsed);

so we only need to fix of_numa_parse_memory_nodes(),
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
> 
> Cc: stable@vger.kernel.org
> Fixes: 87482708210f ("mm: introduce numa_memblks")

I think the Fixes tag should be commit 767507654c22
（"arch_numa: switch over to numa_memblks").


> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> ---
>   mm/numa_memblks.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index 541a99c4071a..1dfe434e71b5 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -197,7 +197,13 @@ static void __init numa_move_tail_memblk(struct numa_meminfo *dst, int idx,
>    */
>   int __init numa_add_memblk(int nid, u64 start, u64 end)
>   {
> -	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
> +	int ret;
> +
> +	ret = numa_add_memblk_to(nid, start, end, &numa_meminfo);
> +	if (!ret)
> +		node_set(nid, numa_nodes_parsed);
> +
> +	return ret;
>   }
>   
>   /**


