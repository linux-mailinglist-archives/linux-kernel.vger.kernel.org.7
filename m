Return-Path: <linux-kernel+bounces-823931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C53B87C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E863D3B95FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9B266582;
	Fri, 19 Sep 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="skDSLzZ+"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96B262FFC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250377; cv=none; b=QzfxhQ0S8STFdTgKY71HmQsBqVrimPM/ZjDs8Rt/b73F0q9Dqbzh7Ak70gs5ZVdbK/iiTXhc2rH4yYK5D4ojFireJBiyvFPBLFmalPs0pqb5Xsqaj7qBaQ+UT8V2qOuuWInACFLGR6lSUC5shp+6bFg+mpfO1JzqO1RjzeG+Ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250377; c=relaxed/simple;
	bh=PiQCNPunC3FQaQFnasvZXtFdq9x2Gkfp9H0MO9LAFXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iV9ZuivhP5NqbRaG2brx2CqxbHbBsVBsAfGk2z5CI+Hak9anuTs8V+KWy/baoY7VgScQxnb3GZg9ySMyyMA9VOTm0VS2QBxJXf+IjH8oincGLX2hLD2j51BJv0sfWzZKEU7NVieX9SyRZLCQVkLDvLnEyLevc/PXEpaBY0Q7gGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=skDSLzZ+; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758250372; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gVFSgUKKAuFnEqSEgabfcIAa5Tbls2E1LiZ7DjuSkOM=;
	b=skDSLzZ+mPBXfnNIPL+k8jhyDEpW2AcATdjj3gzRqrupGROoVY3Utg8SNE7ZDlY1FsO+3/JD+oVyYoYX93Uk8eOkd/mjVhrSApitaRWJVX4H4jG+OmMExARhq+E4/LpdtYRCmQdF43unJW4/0m7TfEItJjmb3/8WDnOa+pyYOfg=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoIF0kP_1758250369 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 10:52:50 +0800
Message-ID: <a06fb734-cd3d-42c8-9b06-4b2427d3030b@linux.alibaba.com>
Date: Fri, 19 Sep 2025 10:52:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/fault: Try to map the entire file folio in
 finish_fault()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, "hughd@google.com" <hughd@google.com>
References: <20250918112157.410172-1-kirill@shutemov.name>
 <20250918112157.410172-2-kirill@shutemov.name>
 <6e6f596a-1817-45d6-b674-04e8aefde6d4@redhat.com>
 <962c9c49-8603-4a57-ba07-36e395eb48a5@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <962c9c49-8603-4a57-ba07-36e395eb48a5@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/18 21:13, Lorenzo Stoakes wrote:
> On Thu, Sep 18, 2025 at 01:30:32PM +0200, David Hildenbrand wrote:
>> On 18.09.25 13:21, kirill@shutemov.name wrote:
>>> From: Kiryl Shutsemau <kas@kernel.org>
>>>
>>> The finish_fault() function uses per-page fault for file folios. This
>>> only occurs for file folios smaller than PMD_SIZE.
>>>
>>> The comment suggests that this approach prevents RSS inflation.
>>> However, it only prevents RSS accounting. The folio is still mapped to
>>> the process, and the fact that it is mapped by a single PTE does not
>>> affect memory pressure. Additionally, the kernel's ability to map
>>> large folios as PMD if they are large enough does not support this
>>> argument.
>>>
>>> When possible, map large folios in one shot. This reduces the number of
>>> minor page faults and allows for TLB coalescing.
>>>
>>> Mapping large folios at once will allow the rmap code to mlock it on
>>> add, as it will recognize that it is fully mapped and mlocking is safe.
>>>
>>> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
>>> ---
>>>    mm/memory.c | 9 ++-------
>>>    1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 0ba4f6b71847..812a7d9f6531 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -5386,13 +5386,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>    	nr_pages = folio_nr_pages(folio);
>>> -	/*
>>> -	 * Using per-page fault to maintain the uffd semantics, and same
>>> -	 * approach also applies to non shmem/tmpfs faults to avoid
>>> -	 * inflating the RSS of the process.
>>> -	 */
>>> -	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
>>> -	    unlikely(needs_fallback)) {
>>> +	/* Using per-page fault to maintain the uffd semantics */
>>> +	if (unlikely(userfaultfd_armed(vma)) || unlikely(needs_fallback)) {
>>>    		nr_pages = 1;
>>>    	} else if (nr_pages > 1) {
>>>    		pgoff_t idx = folio_page_idx(folio, page);
>>
>> I could have sworn that we recently discussed that.
>>
>> Ah yes, there it is
>>
>> https://lkml.kernel.org/r/a1c9ba0f-544d-4204-ad3b-60fe1be2ab32@linux.alibaba.com
>>
>> CCing Baolin as he wanted to look into this.
>>
>> --
>> Cheers
>>
>> David / dhildenb
>>
> 
> Yeah Baolin already did work here [0] so let's get his input first I think! :)
> 
> [0]:https://lore.kernel.org/linux-mm/440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com/

Thanks CCing me. Also CCing Hugh.

Hugh previously suggested adding restrictions to the mapping of file 
folios (using fault_around_bytes). However, personally, I am not 
inclined to use fault_around_bytes to control, because:

1. This doesn't cause serious write amplification issues.
2. It will inflate the RSS of the process, but does it matter? It seems 
not very important.
3. The default configuration for 'fault_around_bytes' is 65536 (16 
pages), which is too small for mapping large file folios.
4. We could try adjusting 'fault_around_bytes' to a larger value, but 
we've found in real customer environments that 'fault_around_bytes' can 
lead to more aggressive readahead, impacting performance. So if 
'fault_around_bytes' controls more, it will bring more different 
intersecting factors into play.

Therefore, I personally prefer Kiryl's patch (it's what I intended to 
do, but I haven't had the time:().

