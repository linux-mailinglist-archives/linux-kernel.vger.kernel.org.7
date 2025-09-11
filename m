Return-Path: <linux-kernel+bounces-811268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11251B526B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66A568053F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFC4223323;
	Thu, 11 Sep 2025 02:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vAnPY+vA"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A991DE2A7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559274; cv=none; b=eWPycUjVs9UuVwFiXkXsVMBpg69+LnHLIGE/qLpNWNR/KAniQxgHVjHgMChHnzh97FE+7x2pzJtmMBfSeqRoEsu7hqfi0I5CH7rIazGj1dwRrs8Ls+jt/p2BpxGVkHDP5uvBYUsNEglAe7sWbLrfC2zvc6b7elJbyS4gXlN4z9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559274; c=relaxed/simple;
	bh=NPKrUrbpxLl6tHMJ/GI7xH3jDwpD95EWbP5WTmIRC58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZzjaOW7GqpI/cLyiCeMXD4/zilj6DAUJd9kp7nKTc4Z0D5KOgjRVeo8qzFVFp0kbZQwCfA9ZFGZwMTcwBpxVCP994hcLCGi3uMgZC1l0lizXrd3vW8f2kHNWJBab43mQEUYcR1Uil1a3O8XruphL76inzIro4xLZ5A2j1uy1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vAnPY+vA; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <223c560b-0234-4203-a11d-661656317808@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757559269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XiKa0acUkKRqbdMSvs1JG5xLdmduIxKCLhayGcZSkRk=;
	b=vAnPY+vADeccfBCQZamqrSAgeEm2pATiGqD7fDvlYAJtj6/AgP3w3/uI/06f20Lw8pvyz7
	sg8fmHnRZmea9pN1PZsVBUdCvI/wJarRUanYXTLay5GyfiWy7lhOMQhahtLpLUQHFcHpG5
	XUwMmtjGf3wH+9FUB1oDCKgEblmGjY8=
Date: Thu, 11 Sep 2025 10:54:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 11/15] mm, swap: use the swap table for the swap cache
 and switch API
Content-Language: en-US
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250910160833.3464-1-ryncsn@gmail.com>
 <20250910160833.3464-12-ryncsn@gmail.com>
 <CABzRoyZc1zHHy5eFaO5hRY=bM36xsk3COd=r18KahmrP11tpSw@mail.gmail.com>
 <CABzRoyaAA3D0nfkQcBMjZ7crUckJXXpGmYfmq6ojQC+BQUigFw@mail.gmail.com>
 <CAMgjq7CtYpe4sEYaw2carqGskvchV9Z+1yn2Wa3nMP2VguV_eQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CAMgjq7CtYpe4sEYaw2carqGskvchV9Z+1yn2Wa3nMP2VguV_eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/11 10:48, Kairui Song wrote:
> On Thu, Sep 11, 2025 at 10:34 AM Lance Yang <lance.yang@linux.dev> wrote:
>>
>> On Thu, Sep 11, 2025 at 10:27 AM Lance Yang <lance.yang@linux.dev> wrote:
>>>
>>> Hi Kairui,
>>>
>>> I'm hitting a build error with allnoconfig:
>>>
>>> In file included from mm/shmem.c:44:
>>> mm/swap.h: In function ‘folio_index’:
>>> mm/swap.h:462:24: error: implicit declaration of function
>>> ‘swp_offset’; did you mean ‘pmd_offset’?
>>> [-Wimplicit-function-declaration]
>>> 462 | return swp_offset(folio->swap);
>>>
>>> It looks like a header might be missing in mm/swap.h. Please let me know
>>> if you need any more information.
>>
>> Confirmed that just adding #include <linux/swapops.h> into mm/swap.h fixes it.
>>
>> diff --git a/mm/swap.h b/mm/swap.h
>> index ad339547ee8c..271e8c560fcc 100644
>> --- a/mm/swap.h
>> +++ b/mm/swap.h
>> @@ -3,6 +3,7 @@
>>   #define _MM_SWAP_H
>>
>>   #include <linux/atomic.h> /* for atomic_long_t */
>> +#include <linux/swapops.h>
>>   struct mempolicy;
>>   struct swap_iocb;
>>
>> Cheers,
>> Lance
>>
> 
> Hi Lance,
> 
> You are testing V2 not V3 right? The build error is in V2 and I can
> confirm that. But In V3 I've added "ifdef CONFIG_SWAP" for the
> swp_offset usage in swap.h. I've just tested allnoconfig and it
> works fine on aarch64 and x86_64.
> 
> V2: https://lore.kernel.org/linux-mm/20250905191357.78298-12-ryncsn@gmail.com/


Ah, I was testing V2. My apologies for the noise!


