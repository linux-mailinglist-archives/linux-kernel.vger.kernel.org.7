Return-Path: <linux-kernel+bounces-836288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40702BA934C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CED74E1AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AF304BC4;
	Mon, 29 Sep 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ncYpLbcw"
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB03054E4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149008; cv=none; b=dWjKpU7x+HIEaQbWCM4Mr1oe4Uh2mvooQe4adUcsiYLVSW/tKQkiWuedEKGoBb362QAqkuqORNf+EqAPmvtO1VHjcjHT6J0wrnC4qN2O8EhTJgT7NBOmUK70e4ZhYf5T8j/0FWhBxBJ2xSePmc9qn0PBzEaz+l0yGmlPpGkmD2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149008; c=relaxed/simple;
	bh=xsLwFMEUcR25ONpKlqpo+ANraM/s9VXk27QB5eXtHgM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nCeZyhlzf5CRSyNkaAucUNa+lVX+5KUsHgDcGl53USPeK7UF2Ub7J2Oh8g+TEeerEdUliIffUmg5aN6Gb5dIe+dDS0dcPsjr73glBxM9RHiHRTT5DlpakjnxuuPs/DX3hpmgYPOs4T/MkEnfq7X5cdgam2LnKDUs8/bK4SYjKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ncYpLbcw; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout09.his.huawei.com (unknown [172.19.92.135])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cb0l814z3zTh8C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:25:24 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xwPQpa8YyY/4fqmUTUsxZAf/0tS09vx9t0wYWRdNUL0=;
	b=ncYpLbcwbF08YgdPPX4CVpXE+aN+dyGed0mOtmm9Yb1io98SZhDIOS3IpWVB94YZGb8sS51cQ
	F3GvRpBPwfGQzVP//ABufVlXWHhm71r3cjEYoRcdYbwNE1HU4O3C8kaiRNavtGyF+enhqUDdoaZ
	0Vnl6G/LMcAhi6+Uqya9m98=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cb0r712HNz1cySb;
	Mon, 29 Sep 2025 20:29:43 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id AD39C180042;
	Mon, 29 Sep 2025 20:29:53 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 20:29:53 +0800
Received: from [10.173.125.236] (10.173.125.236) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 20:29:52 +0800
Subject: Re: [PATCH 1/1] mm: prevent poison consumption when splitting THP
To: Jiaqi Yan <jiaqiyan@google.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <tony.luck@intel.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <Liam.Howlett@oracle.com>,
	<npache@redhat.com>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
	<baohua@kernel.org>, <nao.horiguchi@gmail.com>, <farrah.chen@intel.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Andrew Zaborowski
	<andrew.zaborowski@intel.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5f117b73-8d7b-b233-a0a8-2a29ea6312a8@huawei.com>
Date: Mon, 29 Sep 2025 20:29:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/9/29 5:55, Jiaqi Yan wrote:
> On Sat, Sep 27, 2025 at 8:30 PM Qiuxu Zhuo <qiuxu.zhuo@intel.com> wrote:
>>
>> From: Andrew Zaborowski <andrew.zaborowski@intel.com>
>>
>> When performing memory error injection on a THP (Transparent Huge Page)
>> mapped to userspace on an x86 server, the kernel panics with the following
>> trace. The expected behavior is to terminate the affected process instead
>> of panicking the kernel, as the x86 Machine Check code can recover from an
>> in-userspace #MC.
>>
>>   mce: [Hardware Error]: CPU 0: Machine Check Exception: f Bank 3: bd80000000070134
>>   mce: [Hardware Error]: RIP 10:<ffffffff8372f8bc> {memchr_inv+0x4c/0xf0}
>>   mce: [Hardware Error]: TSC afff7bbff88a ADDR 1d301b000 MISC 80 PPIN 1e741e77539027db
>>   mce: [Hardware Error]: PROCESSOR 0:d06d0 TIME 1758093249 SOCKET 0 APIC 0 microcode 80000320
>>   mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>>   mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
>>   Kernel panic - not syncing: Fatal local machine check
>>
>> The root cause of this panic is that handling a memory failure triggered by
>> an in-userspace #MC necessitates splitting the THP. The splitting process
>> employs a mechanism, implemented in try_to_map_unused_to_zeropage(), which
>> reads the sub-pages of the THP to identify zero-filled pages. However,
>> reading the sub-pages results in a second in-kernel #MC, occurring before
>> the initial memory_failure() completes, ultimately leading to a kernel
>> panic. See the kernel panic call trace on the two #MCs.
>>
>>   First Machine Check occurs // [1]
>>     memory_failure()         // [2]
>>       try_to_split_thp_page()
>>         split_huge_page()
>>           split_huge_page_to_list_to_order()
>>             __folio_split()  // [3]
>>               remap_page()
>>                 remove_migration_ptes()
>>                   remove_migration_pte()
>>                     try_to_map_unused_to_zeropage()
> 
> Just an observation: Unfortunately THP only has PageHasHWPoisoned and
> don't know the exact HWPoisoned page. Otherwise, we may still use
> zeropage for these not HWPoisoned.

IIUC, the raw error page will have HWPoisoned flag set while the THP has
PageHasHWPoisoned set. So I think we could use zeropage for healthy sub-pages.

Thanks.
.

