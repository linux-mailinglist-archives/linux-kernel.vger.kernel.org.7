Return-Path: <linux-kernel+bounces-800836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7CBB43CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D06464E2656
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF712301022;
	Thu,  4 Sep 2025 13:14:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136622EA15D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991669; cv=none; b=g4l2tvbrkvGl7LMHxe0+mnoNqSh2pjn4TwxWIWZ45hh+QTUD5UhAhmJ6JuqLT9SUDt3G+NnUSaePInlJCa7ZWX/GWyvUXlfhYJfUvX6aoc1QUsE3vbtLY2LuGs8dEWZ9PdR3/CKdL/oOtv7bBjxtoIxtNrgFBH2lWkhZx+wYajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991669; c=relaxed/simple;
	bh=jtwr23eYTqBK4QRMx4XXwEq5b02C4wefmqSPLrLOLAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1anHWP15D41r+Cj5q/WALyi1tdSxaVDb4PfUQfexzOxguYZTbVkyWkdly7EN/ZEVvs161HSDxuhItddF4/PdnYKEqyFVsuQQGztvnlB6wFUKbRgELJwdV6+wP8NxCZwJpEDx2zNCoBUA6PjZc3A5I5XcE5m6A+qXKn8XjhWh8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CC1C1756;
	Thu,  4 Sep 2025 06:14:19 -0700 (PDT)
Received: from [10.1.37.179] (XHFQ2J9959.cambridge.arm.com [10.1.37.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E55D3F6A8;
	Thu,  4 Sep 2025 06:14:25 -0700 (PDT)
Message-ID: <1471ea27-386d-4950-8eaa-8af7acf3c34a@arm.com>
Date: Thu, 4 Sep 2025 14:14:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, Dev Jain <dev.jain@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <e722e49a-d982-4b58-98f7-6fef3d0a4468@arm.com>
 <dd242f5b-8bbe-48e8-8d5f-be6a835a8841@arm.com>
 <aeb76956-f980-417f-b4e7-fe0503bb5a2b@os.amperecomputing.com>
 <612940d2-4c8e-459c-8d7d-4ccec08fce0a@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <612940d2-4c8e-459c-8d7d-4ccec08fce0a@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2025 01:50, Yang Shi wrote:
>>>>
>>>>
>>>> I am wondering whether we can just have a warn_on_once or something for the
>>>> case
>>>> when we fail to allocate a pagetable page. Or, Ryan had
>>>> suggested in an off-the-list conversation that we can maintain a cache of PTE
>>>> tables for every PMD block mapping, which will give us
>>>> the same memory consumption as we do today, but not sure if this is worth it.
>>>> x86 can already handle splitting but due to the callchains
>>>> I have described above, it has the same problem, and the code has been working
>>>> for years :)
>>> I think it's preferable to avoid having to keep a cache of pgtable memory if we
>>> can...
>>
>> Yes, I agree. We simply don't know how many pages we need to cache, and it
>> still can't guarantee 100% allocation success.
> 
> This is wrong... We can know how many pages will be needed for splitting linear
> mapping to PTEs for the worst case once linear mapping is finalized. But it may
> require a few hundred megabytes memory to guarantee allocation success. I don't
> think it is worth for such rare corner case.

Indeed, we know exactly how much memory we need for pgtables to map the linear
map by pte - that's exactly what we are doing today. So we _could_ keep a cache.
We would still get the benefit of improved performance but we would lose the
benefit of reduced memory.

I think we need to solve the vm_reset_perms() problem somehow, before we can
enable this.

Thanks,
Ryan

> 
> Thanks,
> Yang
> 
>>
>> Thanks,
>> Yang
>>
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>
> 


