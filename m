Return-Path: <linux-kernel+bounces-851712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67828BD71E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0515C4E9225
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B383054D3;
	Tue, 14 Oct 2025 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="07DD0Elf"
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403524E4D4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409772; cv=none; b=hasWoM7wkYuVdlEpRO24RkxqsQR76VjRdiJQtOaf4gMdwrv54T7UYlE8POYEr8lGT7hsG3wdESGdIjAmpjtK3LBgg5eofa1IwS7Lk3BHuJl08PmEL/waVwe2VGlr5tlQhq/sDrKGAhZqwlYsQlhcgQXvKmH/+hswE6QOYSd+rQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409772; c=relaxed/simple;
	bh=ufwSis+dqMj2iORGLrxMyRhfQat/i+Nh0sxIq0CEZuU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H/tqXtRsj7IV9R9mtLtUwz3etkQ5KjV/V5v+IEAwHMQyFIjKLzzGAWHQie7j+I3TzhxvQ8ePA3aZ03l3N6FMCpZ7Cz7jssPKAkhYZ3+Hl7T+Zf+V4pjNj7SDg091I6F429qudpPjr/XCqRPqt1tJTznTGbBDB9ESCNG9RgDumT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=07DD0Elf; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kIwr8YgoSYJTUz0mk+fkFoDy4KcY1CFydN/oz9Xg81E=;
	b=07DD0ElfGUUuMojzHFUJ1tNA8PA29/f2GGt9V9pRJ5ueXAGRIFEj5FyGPl9hWtNvnrrXICNt2
	phT9H6wcjzIqf8E+66e8gp8U40cc86LCmhR1QaTz1p12TpkJBGzdTEvsCkv77+XgjkY4wqO7p0b
	UQ8wHBGNeACAWaWK3RDJ+H8=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4clz5T26wPzLlVR;
	Tue, 14 Oct 2025 10:42:21 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id CD5C818001B;
	Tue, 14 Oct 2025 10:42:40 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 10:42:40 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 10:42:39 +0800
Subject: Re: [PATCH v2 1/1] mm: prevent poison consumption when splitting THP
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
	<Liam.Howlett@oracle.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <nao.horiguchi@gmail.com>,
	<farrah.chen@intel.com>, <jiaqiyan@google.com>, <lance.yang@linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <tony.luck@intel.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <20251011075520.320862-1-qiuxu.zhuo@intel.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cb58512e-e789-612a-7142-f0fdb505becf@huawei.com>
Date: Tue, 14 Oct 2025 10:42:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251011075520.320862-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/11 15:55, Qiuxu Zhuo wrote:
> When performing memory error injection on a THP (Transparent Huge Page)
> mapped to userspace on an x86 server, the kernel panics with the following
> trace. The expected behavior is to terminate the affected process instead
> of panicking the kernel, as the x86 Machine Check code can recover from an
> in-userspace #MC.
> 
>   mce: [Hardware Error]: CPU 0: Machine Check Exception: f Bank 3: bd80000000070134
>   mce: [Hardware Error]: RIP 10:<ffffffff8372f8bc> {memchr_inv+0x4c/0xf0}
>   mce: [Hardware Error]: TSC afff7bbff88a ADDR 1d301b000 MISC 80 PPIN 1e741e77539027db
>   mce: [Hardware Error]: PROCESSOR 0:d06d0 TIME 1758093249 SOCKET 0 APIC 0 microcode 80000320
>   mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>   mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
>   Kernel panic - not syncing: Fatal local machine check
> 
> The root cause of this panic is that handling a memory failure triggered by
> an in-userspace #MC necessitates splitting the THP. The splitting process
> employs a mechanism, implemented in try_to_map_unused_to_zeropage(), which
> reads the sub-pages of the THP to identify zero-filled pages. However,
> reading the sub-pages results in a second in-kernel #MC, occurring before
> the initial memory_failure() completes, ultimately leading to a kernel
> panic. See the kernel panic call trace on the two #MCs.
> 
>   First Machine Check occurs // [1]
>     memory_failure()         // [2]
>       try_to_split_thp_page()
>         split_huge_page()
>           split_huge_page_to_list_to_order()
>             __folio_split()  // [3]
>               remap_page()
>                 remove_migration_ptes()
>                   remove_migration_pte()
>                     try_to_map_unused_to_zeropage()  // [4]
>                       memchr_inv()                   // [5]
>                         Second Machine Check occurs  // [6]
>                           Kernel panic
> 
> [1] Triggered by accessing a hardware-poisoned THP in userspace, which is
>     typically recoverable by terminating the affected process.
> 
> [2] Call folio_set_has_hwpoisoned() before try_to_split_thp_page().
> 
> [3] Pass the RMP_USE_SHARED_ZEROPAGE remap flag to remap_page().
> 
> [4] Try to map the unused THP to zeropage.
> 
> [5] Re-access sub-pages of the hw-poisoned THP in the kernel.
> 
> [6] Triggered in-kernel, leading to a panic kernel.
> 
> In Step[2], memory_failure() sets the poisoned flag on the sub-page of the
> THP by TestSetPageHWPoison() before calling try_to_split_thp_page().
> 
> As suggested by David Hildenbrand, fix this panic by not accessing to the
> poisoned sub-page of the THP during zeropage identification, while
> continuing to scan unaffected sub-pages of the THP for possible zeropage
> mapping. This prevents a second in-kernel #MC that would cause kernel
> panic in Step[4].
> 
> [ Credits to Andrew Zaborowski <andrew.zaborowski@intel.com> for his
>   original fix that prevents passing the RMP_USE_SHARED_ZEROPAGE flag
>   to remap_page() in Step[3] if the THP has the has_hwpoisoned flag set,
>   avoiding access to the entire THP for zero-page identification. ]
> 
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
> v1 -> v2:
>   - Apply David Hildenbrand's fix suggestion.
> 
>   - Update the commit message to reflect the new fix.
> 
>   - Add David Hildenbrand's "Suggested-by:" tag.
> 
>   - Remove Andrew Zaborowski's SoB but add credits to him in the commit message.
>     [ I cannot reach him to get his SoB for the completely rewritten commit
>       message and new fix approach. ]
> 
>  mm/huge_memory.c | 3 +++
>  mm/migrate.c     | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

LGTM. Thanks for your fix.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

