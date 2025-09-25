Return-Path: <linux-kernel+bounces-831610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD3B9D1E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17EF1B2740B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B61E7660;
	Thu, 25 Sep 2025 02:17:46 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1015746F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766665; cv=none; b=Xp7MBpva9F3DfYfR1mrLeiA559VYpCeQh0IbBJKOY6RFlnm3BuFILMlP7Fsa0c+FKHN1yyDxMQ1pWKTV35bNuDX6Dd34H8JQm8GMbrqhU9/b6Wkmqa1LEFaFIAUsuYUGE+naXjbJzC7W+3NOugD+1kKuU0cQUvNWFN0RhEKjMcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766665; c=relaxed/simple;
	bh=xWiGGfBsPM+Vpar2QxqxiM++mze4uDBoSCQmvttXBD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WI6BrYDYXBadgmd9bc+i8PwuVjr063Lz7eTMuyfd4/6VyLp/j8ai78IgfnDwA7/G06YCiCNw9uJR7J2SpGOfiJmAqFCIMY9ldiYQCYtQ18duYvPChjqIwNbuJi8wy2HeXhh/O78PKXK+ecMwrew4yoP1oJ0whcKyO99vkp3XGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cXHLG6dwBzTh3F;
	Thu, 25 Sep 2025 10:12:54 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EA3B180B63;
	Thu, 25 Sep 2025 10:17:33 +0800 (CST)
Received: from [10.174.179.35] (10.174.179.35) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 10:17:31 +0800
Message-ID: <620d202a-6078-4b5d-a42a-8a52543bc14a@huawei.com>
Date: Thu, 25 Sep 2025 10:17:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] mm: add PMD-level huge page support for
 remap_pfn_range()
To: Matthew Wilcox <willy@infradead.org>
CC: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <anshuman.khandual@arm.com>,
	<yangyicong@hisilicon.com>, <ardb@kernel.org>, <apopple@nvidia.com>,
	<samuel.holland@sifive.com>, <luxu.kernel@bytedance.com>,
	<abrestic@rivosinc.com>, <yongxuan.wang@sifive.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <wangkefeng.wang@huawei.com>,
	<chenjun102@huawei.com>
References: <20250923133104.926672-1-yintirui@huawei.com>
 <20250923133104.926672-3-yintirui@huawei.com>
 <aNMhiZ4FiEE1Rk_T@casper.infradead.org>
From: Yin Tirui <yintirui@huawei.com>
In-Reply-To: <aNMhiZ4FiEE1Rk_T@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)



On 9/24/2025 6:39 AM, Matthew Wilcox wrote:
> On Tue, Sep 23, 2025 at 09:31:04PM +0800, Yin Tirui wrote:
>> +			entry = pte_clrhuge(pfn_pte(pmd_pfn(old_pmd), pmd_pgprot(old_pmd)));
> 
> This doesn't make sense.  And I'm not saying you got this wrong; I
> suspect in terms of how things work today it's actually necessary.
> But the way we handle this stuff is so insane.

Thank you for pointing this out and the broader context.

> 
> pte_clrhuge() should not exist.  If we have a PTE, it can't have the
> huge bit set, by definition (don't anybody mention hugetlbfs because
> that is an entirely separate pile of broken horrors).  I understand what
> you're trying to do here.  You want to construct a PTE that points to
> the same address as the first page of the PMD and has the same
> permissions.  But that *should* be written as:
> 
> 	entry = pfn_pte(pmd_pfn(old_pmd), pmd_pgprot(old_pmd)));
> 
> right?  Now, pmd_pgprot() might or might not want to return the huge bit
> set.  I'm not sure.  Perhaps you could have a look through and figure it

I've tested this on arm64, and pmd_pgprot() does return the huge bit 
set, which is exactly why I added pte_clrhuge().

> out.  But pfn_pte() should never return a PTE with the huge bit set.
> So if it is set in the pgorot on entry, it should filter it out.
> 
> There are going to be consequences to this.  Maybe there's code
> somewhere that relies on pfn_pte() returning a PTE with the huge bit
> set.  Perhaps it's hugetlbfs.

I'll try to refactor pfn_pte() and related functions to filter out the 
huge bit set and test its impact on hugetlbfs.

> 
> But we have to start cleaning this garbage up.  I did some work with
> e3981db444a0 and the commits leading up to that.  See
> https://lkml.kernel.org/r/20250402181709.2386022-12-willy@infradead.org
> 
> I'd like pte_clrhuge() to be deleted from x86, not added to arm and
> riscv.
> 
I completely agree with the goal of deleting pte_clrhuge() rather than 
expanding it. I'll study your referenced work and align my approach with 
your efforts.

Would you recommend I address the pfn_pte() and related function 
refactoring as part of this patch series, or should I submit it as a 
separate patch series?

-- 
Best regards,
Yin Tirui


