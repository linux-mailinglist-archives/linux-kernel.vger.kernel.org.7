Return-Path: <linux-kernel+bounces-850529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7BBBD31BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7EEF34BF33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99892E1EE0;
	Mon, 13 Oct 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pGbrRJgv"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EC2D4B5A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360182; cv=none; b=FLhn6OhZkvhnq3/l0BQtyryf4tSfCFY9nosw7f497K+LtIQdFoOtEFsAyrSyUMZFx+2xEGxhLTKgfcaO3MgnocpXpHNkD4AZL9pzxtkZJ6KenfWBQDmwyuj7mPAOFgeIvWRA8cIMXkzs+tgCHUON2O203d0osvxxngI/GC7zdxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360182; c=relaxed/simple;
	bh=9ukOHl+w8qMGwZyZ+Qzumi8pNiD00jeDUTaNi0oBpG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BqI2rewk043I+lAmLahMUQAlQeUM/Q7sD7932us+Li4C2dRsR8JeBgb6Hrvi+xtKpNXXR+CG9QxZD/nBLOsVJDwcVJTcvSVahvTvqPrAhzICzWk4IO0+KswVPO5iMnI9I8z8Izpy+KcNB6K/WXsVDFkTeU1Y77+lx2nkMvZMO9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pGbrRJgv; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TCnlQ1PVsMzc2uQnpALLB4Ejhm3ZyIkfc4S5MrL7woY=;
	b=pGbrRJgv8c2fzNgdel5jxVMMesNgp4UF/Nja+jJ/vMIMwAbebB5kbGQcfwsNsXhXaH79yLT6t
	rAth/h5pqTb6t3PGgzB1r+iyWKfhSrL202Yh5vY1mHVpliIT6G7W6b44qP+/cOZFlIdLxt5EWg9
	vYOlRp2siWo1B7ugbJ4fgQw=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4clclK0pfQz12LD2;
	Mon, 13 Oct 2025 20:55:25 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 48146180064;
	Mon, 13 Oct 2025 20:56:11 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 20:56:10 +0800
Message-ID: <876040d3-d814-49cd-9829-a36afd320a09@huawei.com>
Date: Mon, 13 Oct 2025 20:56:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/hugetlb: allow overcommitting gigantic
 hugepages
To: Oscar Salvador <osalvador@suse.de>, Usama Arif <usamaarif642@gmail.com>
CC: <muchun.song@linux.dev>, <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, <shakeel.butt@linux.dev>, <linux-mm@kvack.org>,
	<hannes@cmpxchg.org>, <riel@surriel.com>, <kas@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
References: <20251009172433.4158118-1-usamaarif642@gmail.com>
 <20251009172433.4158118-2-usamaarif642@gmail.com>
 <aOyxle8OJPMKlVWX@localhost.localdomain>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <aOyxle8OJPMKlVWX@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2025/10/13 16:00, Oscar Salvador wrote:
> On Thu, Oct 09, 2025 at 06:24:31PM +0100, Usama Arif wrote:
>> Currently, gigantic hugepages cannot use the overcommit mechanism
>> (nr_overcommit_hugepages), forcing users to permanently reserve memory via
>> nr_hugepages even when pages might not be actively used.
>>
>> The restriction was added in 2011 [1], which was before there was support
>> for reserving 1G hugepages at runtime.
>> Remove this blanket restriction on gigantic hugepage overcommit.
>> This will bring the same benefits to gigantic pages as hugepages:
>>
>> - Memory is only taken out of regular use when actually needed
>> - Unused surplus pages can be returned to the system
>> - Better memory utilization, especially with CMA backing which can
>>    significantly increase the changes of hugepage allocation
>>
>> Without this patch:
>> echo 3 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_overcommit_hugepages
>> bash: echo: write error: Invalid argument
>>
>> With this patch:
>> echo 3 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_overcommit_hugepages
>> ./mmap_hugetlb_test
>> Successfully allocated huge pages at address: 0x7f9d40000000
>>
>> cat mmap_hugetlb_test.c
>> ...
>>      unsigned long ALLOC_SIZE = 3 * (unsigned long) HUGE_PAGE_SIZE;
>>      addr = mmap(NULL,
>>                  ALLOC_SIZE, // 3GB
>>                  PROT_READ | PROT_WRITE,
>>                  MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_HUGE_1GB,
>>                  -1,
>>                  0);
>>
>>      if (addr == MAP_FAILED) {
>>          fprintf(stderr, "mmap failed: %s\n", strerror(errno));
>>          return 1;
>>      }
>>      printf("Successfully allocated huge pages at address: %p\n", addr);
>> ...
>>
>> [1] https://git.zx2c4.com/linux-rng/commit/mm/hugetlb.c?id=adbe8726dc2a3805630d517270db17e3af86e526
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> 
> I guess nobody bothered to do this after we added support for 1GB hugepages because
> creating those at runtime is tricky, and in my experience, almost everybody reserves
> those at boot time.
> But I do not have objections to make them behave as normal hugepages:

We do have cases to allocate 1G hugepages at runtime and we enable 
migrate 1G hugepages in alloc_migrate_hugetlb_folio() too :)

I will send a patch to enable gigantic pages migration based on this one.


> 
> Acked-by: Oscar Salvador <osalvador@suse.de>
> 
>   
> 


