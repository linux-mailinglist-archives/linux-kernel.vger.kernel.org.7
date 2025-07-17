Return-Path: <linux-kernel+bounces-734897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E89B087D8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD6B58502C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3417127AC41;
	Thu, 17 Jul 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEr/YVZi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB135957
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740576; cv=none; b=sV2YujRuGqvEnxy/UvcHFxQlCmHeHaBrmc3YZZ13GNuZ20HExyrSaY3hU1NRvCZh4h5IqTSv2etNWY2i3XFvartTIOMyZYQe4tfTcePR2LQrIX6rBFGw/Ky5CWLyRCr9Ep80ZE2Irfe/gQfNCX2PBRW5PWl0Bien0jGobExWfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740576; c=relaxed/simple;
	bh=mor0Lc3BIMDLgsQ3FDhBvmyPG564x9lXZmqKBQdHmgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABe2mvqJQ/YZ7bKhOR2Vrzbh48rmyWrzn8dJvwR87+D7W1onxx21F9mCO/FfCHu4O0eNWj/Oo9boKVZIYkREmO0fu928plwVcSdHBp5XulHtmqLlCWABbdyDTEs31K7ao5ufxbVRarCvl+HhgzN9kXrQGwd4Rtm2NraBbtS64MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GEr/YVZi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752740573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2mqJS3et2ZSRNW2i5XCwL2/M6iyAhSDP2a7lJi9KcHs=;
	b=GEr/YVZi9ULvDCtLUjgAkUPMzpSTkcWkwkQdHLblUNXi/7fWXlo5T0pa/mGEGZWQK83vRl
	GyKDnERwajhckQ0AJ+yrejTWLd9RtlMKhn58breA9W58g7WxvqZBguOmbObKnTWfQIqRS4
	2SCawdmkZZCi3AqeE4ekUi7VOaUu1BY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-OZG9rpg3OVWQIqaggreYhg-1; Thu, 17 Jul 2025 04:22:51 -0400
X-MC-Unique: OZG9rpg3OVWQIqaggreYhg-1
X-Mimecast-MFC-AGG-ID: OZG9rpg3OVWQIqaggreYhg_1752740570
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-456175dba68so4762075e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752740570; x=1753345370;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2mqJS3et2ZSRNW2i5XCwL2/M6iyAhSDP2a7lJi9KcHs=;
        b=ZOW0Qsz7XiYuxU8gW0qlfl09B4qMGesPvCi5tFyyCpKb74wYRRqNYUMEMLl0I709jy
         I8GuLrtIaA8v6CWjP3Zhw7gpLK/3ZmjzmTtUcTh6dzP9G4Bxa4ib7A685eJk2rLQU4/Z
         ikB//mkEu+j1YK1CrBtlOKJNKrJ5oOGVRJEk9xU1CqonYbvuPbo8tofjYCdCvCVP/xaX
         qjCar1vkiFLY1CB7C9v13CDXwaA1KgJEAwciKy6HjyuOxj0DIaTIm7rvlzSU1veFp3ID
         cHRfWXsfh8cY7pmOmHP6U7VUT02ZaxTfEXToan46VVR8D4KeTyYryXsFNohSgsqdao9i
         ldFA==
X-Forwarded-Encrypted: i=1; AJvYcCXwYlednTRvDsRPUM14uWH+maH/yvNZydxZbzfPkgQekmVeeYJbMAjEE/RnKbR8HofFm+AkbkItf9XypFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNac5PMQxn0/cPSfDfv5+7/vWb8m8jejTEvRepvLNNOIiu4R2v
	reS0hsHiC4yLhTxobTwHFp0/+kp6jjwtTEmSLIpNMlrcLGWLSnnk+NFNlNTC60bWoDwlhmUhwll
	V3xwz0pvqa87XiJir4+Sa/f5+nxFWr0Z3hOWZQ+cJiQe7cG4/iSWuxI71wjW2JpGQZQ==
X-Gm-Gg: ASbGncvWmAtxq8p/0Emg0rfnZBPsFCdNxBqyqkPCC+t7WpWbNnnnLsNAu36HuXSWKRm
	8Y0tNL8Q8ibbiniGiKdAZW8QObBraa+wYQY7oIiKvPxhs3SdSU6fRrAp+BLwc9iU0+b6czVTZbr
	NZYXQw8zj3BPHHdMtyuSdu+ACU3pFBk5+ksigSmVKu5Xmzs33rtXXsfB2ZDpB3BbVscg3pZU3jQ
	nRlW3CP0fg26tfKDPITkYVBz1zAproy7OAaCVjIl8K5gEgIw/XQmmd0pgt/HuWgfG0gT+6HxjTa
	DutjDk0T6ACLkwb12WVyuqdJydJ5iM6y8DfZNpAksaeK9tYDMo3l8afgRP/CUiEMesaUP7qt/y8
	1hrPUk63kKgj6uFHZ9GkOkiMm07I2TaFOzeMmIc86Bp7R6ZfXt/6xt3H7QX66bZHX
X-Received: by 2002:a05:600c:4e8c:b0:456:1fd9:c8f0 with SMTP id 5b1f17b1804b1-4562e32e669mr62039225e9.2.1752740570001;
        Thu, 17 Jul 2025 01:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx08OSLhPGt3YPyqddHzKgpSak7sIe+Ln7zA5D5N8r+GtXX0XTFT09KimbjZO7HxCEMVUzrQ==
X-Received: by 2002:a05:600c:4e8c:b0:456:1fd9:c8f0 with SMTP id 5b1f17b1804b1-4562e32e669mr62038895e9.2.1752740569493;
        Thu, 17 Jul 2025 01:22:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7? (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2025sm20378744f8f.31.2025.07.17.01.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 01:22:48 -0700 (PDT)
Message-ID: <2513a63d-b11a-48fc-922a-288785817df4@redhat.com>
Date: Thu, 17 Jul 2025 10:22:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fault in complete folios instead of individual
 pages for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Hugh Dickins <hughd@google.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, ziy@nvidia.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>
 <20250704151858.73d35a24b4c2f53bdb0c1b85@linux-foundation.org>
 <4c055849-d7dd-4b9f-9666-fcb0bccf8681@linux.alibaba.com>
 <007c4a94-c94a-418e-9907-7510422f8ca4@lucifer.local>
 <23f1c3ab-16ca-41db-b008-22448d9e08f2@linux.alibaba.com>
 <d0b24095-d7fc-459d-85ed-9c0797e9fca3@lucifer.local>
 <3bf50873-4d1b-a7c7-112e-3a17ac16077f@google.com>
 <a1c9ba0f-544d-4204-ad3b-60fe1be2ab32@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <a1c9ba0f-544d-4204-ad3b-60fe1be2ab32@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.25 10:01, Baolin Wang wrote:
> 
> 
> On 2025/7/16 04:03, Hugh Dickins wrote:
>> On Wed, 9 Jul 2025, Lorenzo Stoakes wrote:
>>> On Tue, Jul 08, 2025 at 03:53:56PM +0800, Baolin Wang wrote:
>>>> On 2025/7/7 21:33, Lorenzo Stoakes wrote:
>>>>> On Sun, Jul 06, 2025 at 10:02:35AM +0800, Baolin Wang wrote:
>>>>>> On 2025/7/5 06:18, Andrew Morton wrote:
>>>>>>> On Fri,  4 Jul 2025 11:19:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>>>>
>>>>>>>> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
>>>>>>>> tmpfs can also support large folio allocation (not just PMD-sized large
>>>>>>>> folios).
>>>>>>>>
>>>>>>>> However, when accessing tmpfs via mmap(), although tmpfs supports large folios,
>>>>>>>> we still establish mappings at the base page granularity, which is unreasonable.
>>>>>>>>
>>>>>>>> We can map multiple consecutive pages of a tmpfs folios at once according to
>>>>>>>> the size of the large folio. On one hand, this can reduce the overhead of page
>>>>>>>> faults; on the other hand, it can leverage hardware architecture optimizations
>>>>>>>> to reduce TLB misses, such as contiguous PTEs on the ARM architecture.
>>>>>>>>
>>>>>>>> Moreover, tmpfs mount will use the 'huge=' option to control large folio
>>>>>>>> allocation explicitly. So it can be understood that the process's RSS statistics
>>>>>>>> might increase, and I think this will not cause any obvious effects for users.
>>>>>>>>
>>>>>>>> Performance test:
>>>>>>>> I created a 1G tmpfs file, populated with 64K large folios, and write-accessed it
>>>>>>>> sequentially via mmap(). I observed a significant performance improvement:
>>>>>>>
>>>>>>> That doesn't sound like a crazy thing to do.
>>>>>>>
>>>>>>>> Before the patch:
>>>>>>>> real	0m0.158s
>>>>>>>> user	0m0.008s
>>>>>>>> sys	0m0.150s
>>>>>>>>
>>>>>>>> After the patch:
>>>>>>>> real	0m0.021s
>>>>>>>> user	0m0.004s
>>>>>>>> sys	0m0.017s
>>>>>>>
>>>>>>> And look at that.
>>>>>>>
>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>> index 0f9b32a20e5b..9944380e947d 100644
>>>>>>>> --- a/mm/memory.c
>>>>>>>> +++ b/mm/memory.c
>>>>>>>> @@ -5383,10 +5383,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>>>>>      	/*
>>>>>>>>      	 * Using per-page fault to maintain the uffd semantics, and same
>>>>>>>> -	 * approach also applies to non-anonymous-shmem faults to avoid
>>>>>>>> +	 * approach also applies to non shmem/tmpfs faults to avoid
>>>>>>>>      	 * inflating the RSS of the process.
>>>>>>>>      	 */
>>>>>>>> -	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
>>>>>>>> +	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
>>>>>>>>      	    unlikely(needs_fallback)) {
>>>>>>>>      		nr_pages = 1;
>>>>>>>>      	} else if (nr_pages > 1) {
>>>>>>>
>>>>>>> and that's it?
>>>>>>>
>>>>>>> I'm itching to get this into -stable, really.  What LTS user wouldn't
>>>>>>> want this?
>>>>>>
>>>>>> This is an improvement rather than a bugfix, so I don't think it needs to go
>>>>>> into LTS.
>>>>>>
>>>>>> Could it be viewed as correcting an oversight in
>>>>>>> acd7ccb284b8?
>>>>>>
>>>>>> Yes, I should have added this optimization in the series of the commit
>>>>>> acd7ccb284b8. But obviously, I missed this :(.
>>>>>
>>>>> Buuut if this was an oversight for that patch that causes an unnecessary
>>>>> perf degradation, surely this should have fixes tag + cc stable no?
>>>>
>>>> IMO, this commit acd7ccb284b8 won't cause perf degradation, instead it is
>>>> used to introduce a new feature, while the current patch is a further
>>>> reasonable optimization. As I mentioned, this is an improvement, not a
>>>> bugfix or a patch to address performance regression.
>>>
>>> 4Well :) you say yourself it was an oversight, and it very clearly has a perf
>>> _impact_, which if you compare backwards to acd7ccb284b8 is a degradation, but I
>>> get your point.
>>>
>>> However, since you say 'oversight' this seems to me that you really meant to
>>> have included it but hadn't noticed, and additionally, since it just seems to be
>>> an unequivical good - let's maybe flip this round - why NOT backport it to
>>> stable?
>>
>> I strongly agree with Baolin: this patch is good, thank you, but it is
>> a performance improvement, a new feature, not a candidate for the stable
>> tree.  I'm surprised anyone thinks otherwise: Andrew, please delete that
>> stable tag before advancing the patch from mm-unstable to mm-stable.
>>
>> And the Fixee went into 6.14, so it couldn't go to 6.12 LTS anyway.
> 
> Agree.
> 
>> An unequivocal good? I'm not so sure.
>>
>> I expect it ought to be limited, by fault_around_bytes (or suchlike).
>>
>> If I understand all the mTHP versus large folio versus PMD-huge handling
>> correctly (and of course I do not, I'm still weeks if not months away
>> from understanding most of it), the old vma_is_anon_shmem() case would
>> be limited by the shmem mTHP tunables, and one can reasonably argue that
>> they would already take fault_around_bytes-like considerations into account;
>> but the newly added file-written cases are governed by huge= mount options
>> intended for PMD-size, but (currently) permitting all lesser orders.
>> I don't think that mounting a tmpfs huge=always implies that mapping
>> 256 PTEs for one fault is necessarily a good strategy.
>>
>> But looking in the opposite direction, why is there now a vma_is_shmem()
>> check there in finish_fault() at all?  If major filesystems are using
>> large folios, why aren't they also allowed to benefit from mapping
>> multiple PTEs at once (in this shared-writable case which the existing
>> fault-around does not cover - I presume to avoid write amplification,
>> but that's not an issue when the folio is large already).
> 
> This is what I'm going to do next. For other filesystems, I think they
> should also map multiple PTEs at once.

I recall [1]. But that would, of course, only affect the RSS of a 
program and not the actual memory consumption (the large folio resides 
in memory ...).

The comments in the code spells that out: "inflating the RSS of the 
process."

[1] https://www.suse.com/support/kb/doc/?id=000019017

-- 
Cheers,

David / dhildenb


