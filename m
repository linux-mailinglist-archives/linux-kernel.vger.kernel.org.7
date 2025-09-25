Return-Path: <linux-kernel+bounces-831574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C7B9D0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB14B1BC47E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E38B2DE6F7;
	Thu, 25 Sep 2025 01:43:51 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE896E55A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764631; cv=none; b=nVbycjAK1vb48OW0+eoqF56i5xbg7vDA869l+zW5vAl24ZMXpvpMcJBhQJ3EaB+vpjZB2HLKOB5D0J8kqlSOi9633Trtsssh6OZtqPvEC65/4dMC/NlBGnY4RRcAivebnpjrdi6BpXCVusXX45qMOfo4A019yp+2vWLK97QW+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764631; c=relaxed/simple;
	bh=6fvEYqF7LhBRq+bdHhpoToXVlngkZX0IW+7BL676UUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j3IcekLM7fWZBcyWy6rcBMGbs43PS6qAudDUWsKC1cE0JJQVxjrWEpQP1B9T0V61nsgff0Ije3UVoMgZFtoo5uE4uReSa460AL6gxBFWBKx+xgeK6KbTWyZ0O2XVAFQZWdGCedh9XKsn7U+d0w7w66n/NJ7vEEZ8BPgDbBq8qdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cXGb80jBLzddVk;
	Thu, 25 Sep 2025 09:39:00 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D3111401E9;
	Thu, 25 Sep 2025 09:43:39 +0800 (CST)
Received: from [10.174.179.35] (10.174.179.35) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 09:43:37 +0800
Message-ID: <8313b0c1-bf62-4257-951c-fd7e29193ae2@huawei.com>
Date: Thu, 25 Sep 2025 09:43:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] mm: add PMD-level huge page support for
 remap_pfn_range()
To: David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <anshuman.khandual@arm.com>,
	<yangyicong@hisilicon.com>, <ardb@kernel.org>, <willy@infradead.org>,
	<apopple@nvidia.com>, <samuel.holland@sifive.com>,
	<luxu.kernel@bytedance.com>, <abrestic@rivosinc.com>,
	<yongxuan.wang@sifive.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <wangkefeng.wang@huawei.com>, <chenjun102@huawei.com>
References: <20250923133104.926672-1-yintirui@huawei.com>
 <20250923133104.926672-3-yintirui@huawei.com>
 <f8571506-30c0-4dc8-9995-41a6469f8fc7@redhat.com>
From: Yin Tirui <yintirui@huawei.com>
In-Reply-To: <f8571506-30c0-4dc8-9995-41a6469f8fc7@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500001.china.huawei.com (7.202.194.229)



On 9/24/2025 5:50 PM, David Hildenbrand wrote:
>> Introduce pfnmap_max_page_shift parameter to control maximum page
>> size and "nohugepfnmap" boot option to disable huge pfnmap entirely.
> 
> Why? If an arch supports it we should just do it. Or what's the reason 
> behind that?
> 
There's no specific reason for this - it was just intended to provide an 
additional option. I'll remove it in the next version.

...
> Are you sure we can just entirely remove this block for ! 
> vma_is_anonymous(vma)?
>
Thank you for pointing this out!
There is definitely a problem with removing this block entirely for 
non-anonymous VMAs. I've also found some other problems. I'll fix all of 
them in the next version.

-- 
Best regards,
Yin Tirui


