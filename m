Return-Path: <linux-kernel+bounces-800841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59D7B43CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7608A0186B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA2198851;
	Thu,  4 Sep 2025 13:16:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03D5B21A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991783; cv=none; b=GrcajfRBdyJ4ojXRWIzZzwJuW2X2YOFkSRno7G5Etp5DxHiAvUEjKNnA9G9CH18Xb5qTf/+kloGJSqiOGecM4WQTV313AH084PkzYdag+3xIjvYfn7HXmT2WKEV4aMR4iw1rM92LqDEgO2l8dFCOmPpU0fK6QXlVPuKX4rGz/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991783; c=relaxed/simple;
	bh=ZXSUpN/scWTZdwwxWq/GFsY7VIvD7QuqUXuC78DvoAM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j+0saZQhP0zAoDqz8YR4UeCIvAxvjErY6zOEO0uXgxQtTsZ/ERFbXAilKOYowF0ceTqIvh2lrcJH8LoxV/+SX/qEPVrzaC9tkEToob8XPIc3V7nYJ3L9VQxKrhpe+QymaKdq+VwC6bx3BP8J0k6HwQRqFJmXIiic6bDJVaeP470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1D9F1756;
	Thu,  4 Sep 2025 06:16:12 -0700 (PDT)
Received: from [10.1.37.179] (XHFQ2J9959.cambridge.arm.com [10.1.37.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EC433F6A8;
	Thu,  4 Sep 2025 06:16:19 -0700 (PDT)
Message-ID: <f8cf1823-1ee9-4935-9293-86f58a9e2224@arm.com>
Date: Thu, 4 Sep 2025 14:16:17 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
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
 <1471ea27-386d-4950-8eaa-8af7acf3c34a@arm.com>
In-Reply-To: <1471ea27-386d-4950-8eaa-8af7acf3c34a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/09/2025 14:14, Ryan Roberts wrote:
> On 03/09/2025 01:50, Yang Shi wrote:
>>>>>
>>>>>
>>>>> I am wondering whether we can just have a warn_on_once or something for the
>>>>> case
>>>>> when we fail to allocate a pagetable page. Or, Ryan had
>>>>> suggested in an off-the-list conversation that we can maintain a cache of PTE
>>>>> tables for every PMD block mapping, which will give us
>>>>> the same memory consumption as we do today, but not sure if this is worth it.
>>>>> x86 can already handle splitting but due to the callchains
>>>>> I have described above, it has the same problem, and the code has been working
>>>>> for years :)
>>>> I think it's preferable to avoid having to keep a cache of pgtable memory if we
>>>> can...
>>>
>>> Yes, I agree. We simply don't know how many pages we need to cache, and it
>>> still can't guarantee 100% allocation success.
>>
>> This is wrong... We can know how many pages will be needed for splitting linear
>> mapping to PTEs for the worst case once linear mapping is finalized. But it may
>> require a few hundred megabytes memory to guarantee allocation success. I don't
>> think it is worth for such rare corner case.
> 
> Indeed, we know exactly how much memory we need for pgtables to map the linear
> map by pte - that's exactly what we are doing today. So we _could_ keep a cache.
> We would still get the benefit of improved performance but we would lose the
> benefit of reduced memory.
> 
> I think we need to solve the vm_reset_perms() problem somehow, before we can
> enable this.

Sorry I realise this was not very clear... I am saying I think we need to fix it
somehow. A cache would likely work. But I'd prefer to avoid it if we can find a
better solution.


> 
> Thanks,
> Ryan
> 
>>
>> Thanks,
>> Yang
>>
>>>
>>> Thanks,
>>> Yang
>>>
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>
>>
> 


