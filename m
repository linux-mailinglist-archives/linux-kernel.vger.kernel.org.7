Return-Path: <linux-kernel+bounces-775628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF16B2C293
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC26517DD85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B23334707;
	Tue, 19 Aug 2025 12:04:01 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9377326D59;
	Tue, 19 Aug 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605041; cv=none; b=fcv91im8cpTYF4Fb7nPpc+qw3wNABYyZ4oro+jgY+FkDV1mVTFVhWbRtu2yJJG0VckbU2UItfmtiZ68sZWmPYx7CbIi/hrFna4vlZHVom4JS16BHQMFC1uhDuFEJxEPDt5g2gwOxkRIpaDXbvdkkJjVAhMBif06KYHQ7+bdmwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605041; c=relaxed/simple;
	bh=t0YrYUfgTkQBH0rrdVOzMVhjuygnPsj75eDoXcmVm8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RDrmdCAf58W0LNd9XqvTDigT65bch5tz8MaCtFE5kr4d21AHCFu5EssR6vUdBk/T99/HCYMAO0tgiRQaQAxM0g3KiePueuqRV5LpXgWy/Fju+yqTHVZP03/GhYfupCn9gozFoGzM5DIZh4INcM/lHLQoZxRHm6bJRcjmZRbxLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c5pCD09CCz14MdQ;
	Tue, 19 Aug 2025 20:03:52 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 6927118007F;
	Tue, 19 Aug 2025 20:03:55 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 20:03:54 +0800
Message-ID: <8ee28bfb-9434-4c3e-b039-6c80c00af1cd@huawei.com>
Date: Tue, 19 Aug 2025 20:03:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] of_numa: fix uninitialized memory nodes causing kernel
 panic
To: Yin Tirui <yintirui@huawei.com>, <robh@kernel.org>,
	<saravanak@google.com>, <dan.j.williams@intel.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <rppt@kernel.org>,
	<Jonathan.Cameron@huawei.com>, <devicetree@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <chenjun102@huawei.com>
References: <20250819075510.2079961-1-yintirui@huawei.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20250819075510.2079961-1-yintirui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2025/8/19 15:55, Yin Tirui wrote:
> When there are memory-only nodes (nodes without CPUs), these nodes
> are not properly initialized, causing kernel panic during boot.
> 
...
> 
> v2: Move the changes to the of_numa related. Correct the fixes tag.
> v3: Only amend commit message with no code changes.
> 

This part should be moved under "---",

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>


> Cc: stable@vger.kernel.org
> Fixes: 767507654c22 ("arch_numa: switch over to numa_memblks")
> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>   drivers/of/of_numa.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index 230d5f628c1b..cd2dc8e825c9 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -59,8 +59,11 @@ static int __init of_numa_parse_memory_nodes(void)
>   			r = -EINVAL;
>   		}
>   
> -		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++)
> +		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++) {
>   			r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
> +			if (!r)
> +				node_set(nid, numa_nodes_parsed);
> +		}
>   
>   		if (!i || r) {
>   			of_node_put(np);


