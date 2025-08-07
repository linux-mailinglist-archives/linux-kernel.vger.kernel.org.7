Return-Path: <linux-kernel+bounces-759380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B64B1DCD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B4A560647
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692F221F20;
	Thu,  7 Aug 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8njI4zX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55720299E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589722; cv=none; b=LAVW+/Y0BRAY8c4pMjtJ6esktl1Ew31X55aSAwsdSCVBCn9zDsQcc2S62fOFhzwkhChg35ApvKIBxX/zwa/2ridwxMj7jLZ4yZW7bqsKihrLwNhu93H4QR5U1mnAbqkUc24b6a1+6uk+MIGmPLL3xqgXPMEobpHcQFJmwYORLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589722; c=relaxed/simple;
	bh=q3CNsz9tOfecntu9d/V65Vv9GgNI01Z6fqbb8cjo1Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKSfrSDKOVtXOcqb6SqrkeGwjfOhPpqRKfW0peGtnIXWKHw9ROr5BLzv6lsFzjK++/yy4r6gGGW8EqS1jPBWMbL/2dSrp7rVli1UZCoSh5Pz+qrRqG8CcZewfWOUxEMcjogTdrNH2dYmQot+yJ/p8GtVy2uXgJLGKvt4HEwGXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8njI4zX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754589719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mhUS2sM+ExcCQ6yCHHvb67H8y6ZDFz4/8Rje0oa/xWU=;
	b=U8njI4zXjWpDZWTPBngiZo/+uZvx2VcQSOvC6rnleRy6mfT5J6SU0Yu0Dr4k2kTwkjzAA1
	VXHtZcG+C/gLIIS7GVl6ZLfY0Wlya5KMz58Cf7kb2sbeHbFk6Lo/1Mjf9e8jBwS6fU1OmG
	1odoG0ee0R9F7zSZjFzeodtG1vy9ewY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-5lcxTr8RNvyBTfoDUvJUjA-1; Thu, 07 Aug 2025 14:01:55 -0400
X-MC-Unique: 5lcxTr8RNvyBTfoDUvJUjA-1
X-Mimecast-MFC-AGG-ID: 5lcxTr8RNvyBTfoDUvJUjA_1754589715
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459e30eeea3so7727745e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754589715; x=1755194515;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mhUS2sM+ExcCQ6yCHHvb67H8y6ZDFz4/8Rje0oa/xWU=;
        b=FJq7ZYTa2hKPspIFASW1/Al6FJkv7tSfpL15cOWIt6dqACBu/UkEPP+KlIQAZWf4VT
         VZObohHoxGeJGrOtUY2Ek4WH6FYz9YMLRwumIRXY02QOWBqJ03P+Pw2n/56KxXK5ddM4
         b90y+yaJpodrvh9CwTvqVb0EKox0xRhHCkUNzAsbL4ExtnfxpYNDjkF5aLOK8YFCvRqr
         shtgHW6u2Wc2MxRhIX5HYadoqdNxNYi3F1uc6di1wYDYL9m1Eyf5lrLiscXc1U6Sm9j9
         RGOIlcSG4pqdBYCNHZHk7/yiaDPcR9gCxh9/HzDsNgHLsJ9hm1670UUBQPjgj6op6Mqu
         7BIA==
X-Forwarded-Encrypted: i=1; AJvYcCV7DKQ51rxkxjGrHxHpOv4lH6We5aM/ASMXOlCFYzn3M+9pMEodp0c3QvjIdfogLxpDlhj2MDX+sq1beZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71mOLYZq89rhrH4cbAUkwBldAJAGsxJGHMHfxA/5Af+owhW2r
	D5Hym0txq/JN2cUKPiAdV3XIPbqQIm+lVlAzO3u0IdUeBIVq3ADmn4G8FxhYJIw5LCsUaWxNQy7
	q1ccB9irUlDIShBaHBg3imlx3gXXpA5uqLSct7xOWAffuZNNdL27UyS/PUZhuBVtk2A==
X-Gm-Gg: ASbGnct58c3M2gDvNg0wrHm06/FBWFTMA9jPNUjhPCt/3G4Ida8C/nx2AFjUrjkZF+8
	hNnaDUfkRXOQ4LCU4PJJbvXBc+ocb1lL3KYcEkmAL8tv0qB7TnKH+2GredvfEb2lOXbeVeop44I
	d9bW7PiZiIORahasx6UccMJX+kytr6lE8NNp16B6t4n0IQqb5DPH/4dRqqBmUYfedqASTCF8HD+
	brcMiuCG4miwMv63ItUab8rNWT+cUhO7cpF4YlFcTb8ceskFm9RecS9tWpcZnXqoRylxKhdh5Yc
	sDcyq5rq8tqTrg5EYeO9bzpSLd2uLMtuHCIOA7ryH7HxGH40yvS9XMyzENv5Zt2Q8UqEB/ncm+7
	Bq983cOaW5/oi9Kp8jvUABG+ZnBu9A1fc5ALof12hzJCCEvqOPpZwB1zydWaxOIHl6oM=
X-Received: by 2002:a05:600c:46c8:b0:459:ddad:a3a3 with SMTP id 5b1f17b1804b1-459e74a4ad6mr64013225e9.25.1754589714383;
        Thu, 07 Aug 2025 11:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxcVatWP7rFIfVWx9CqdmH8FLM3Nm306vOiRTmVXgWVKdqiIY4890kJtBR5KGb3c604MXHrw==
X-Received: by 2002:a05:600c:46c8:b0:459:ddad:a3a3 with SMTP id 5b1f17b1804b1-459e74a4ad6mr64012855e9.25.1754589713826;
        Thu, 07 Aug 2025 11:01:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f49:bc00:12fa:1681:c754:1630? (p200300d82f49bc0012fa1681c7541630.dip0.t-ipconnect.de. [2003:d8:2f49:bc00:12fa:1681:c754:1630])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c33fesm27989570f8f.29.2025.08.07.11.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 11:01:53 -0700 (PDT)
Message-ID: <cbc2e23d-69ab-4820-9942-c7abf2066ff7@redhat.com>
Date: Thu, 7 Aug 2025 20:01:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] f822a9a81a:
 stress-ng.bigheap.realloc_calls_per_sec 37.3% regression
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, Dev Jain <dev.jain@arm.com>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Bang Li <libang.li@antgroup.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, bibo mao <maobibo@loongson.cn>,
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, Liam Howlett <liam.howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Yang Shi <yang@os.amperecomputing.com>,
 Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <202508071609.4e743d7c-lkp@intel.com>
 <9e3a59b2-11c0-43ca-aff3-414091f04aa4@lucifer.local>
 <CAG48ez3=8f3eShjAe9hrvivP+Dvyisw=X_Tr_phc-OX_4MzeDw@mail.gmail.com>
 <be074809-e1fd-43a2-9396-8f7264532c4d@lucifer.local>
 <CAG48ez3=kLL4wBxAVSa2Ugrws+-RFQMdNY9jx5FAdbhpNt8fGg@mail.gmail.com>
 <e4f5faea-ccec-4cc7-83de-1a3c7013b81b@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <e4f5faea-ccec-4cc7-83de-1a3c7013b81b@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.08.25 19:51, Lorenzo Stoakes wrote:
> On Thu, Aug 07, 2025 at 07:46:39PM +0200, Jann Horn wrote:
>> On Thu, Aug 7, 2025 at 7:41 PM Lorenzo Stoakes
>> <lorenzo.stoakes@oracle.com> wrote:
>>> On Thu, Aug 07, 2025 at 07:37:38PM +0200, Jann Horn wrote:
>>>> On Thu, Aug 7, 2025 at 10:28 AM Lorenzo Stoakes
>>>> <lorenzo.stoakes@oracle.com> wrote:
>>>>> On Thu, Aug 07, 2025 at 04:17:09PM +0800, kernel test robot wrote:
>>>>>> 94dab12d86cf77ff f822a9a81a31311d67f260aea96
>>>>>> ---------------- ---------------------------
>>>>>>           %stddev     %change         %stddev
>>>>>>               \          |                \
>>>>>>       13777 ą 37%     +45.0%      19979 ą 27%  numa-vmstat.node1.nr_slab_reclaimable
>>>>>>      367205            +2.3%     375703        vmstat.system.in
>>>>>>       55106 ą 37%     +45.1%      79971 ą 27%  numa-meminfo.node1.KReclaimable
>>>>>>       55106 ą 37%     +45.1%      79971 ą 27%  numa-meminfo.node1.SReclaimable
>>>>>>      559381           -37.3%     350757        stress-ng.bigheap.realloc_calls_per_sec
>>>>>>       11468            +1.2%      11603        stress-ng.time.system_time
>>>>>>      296.25            +4.5%     309.70        stress-ng.time.user_time
>>>>>>        0.81 ą187%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>        9.36 ą165%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>        0.81 ą187%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>        9.36 ą165%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>        5.50 ą 17%    +390.9%      27.00 ą 56%  perf-c2c.DRAM.local
>>>>>>      388.50 ą 10%    +114.7%     834.17 ą 33%  perf-c2c.DRAM.remote
>>>>>>        1214 ą 13%    +107.3%       2517 ą 31%  perf-c2c.HITM.local
>>>>>>      135.00 ą 19%    +130.9%     311.67 ą 32%  perf-c2c.HITM.remote
>>>>>>        1349 ą 13%    +109.6%       2829 ą 31%  perf-c2c.HITM.total
>>>>>
>>>>> Yeah this also looks pretty consistent too...
>>>>
>>>> FWIW, HITM hat different meanings depending on exactly which
>>>> microarchitecture that test happened on; the message says it is from
>>>> Sapphire Rapids, which is a successor of Ice Lake, so HITM is less
>>>> meaningful than if it came from a pre-IceLake system (see
>>>> https://lore.kernel.org/all/CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGvXCq7Xr-w@mail.gmail.com/).
>>>>
>>>> To me those numbers mainly look like you're accessing a lot more
>>>> cache-cold data. (On pre-IceLake they would indicate cacheline
>>>> bouncing, but I guess here they probably don't.) And that makes sense,
>>>> since before the patch, this path was just moving PTEs around without
>>>> looking at the associated pages/folios; basically more or less like a
>>>> memcpy() on x86-64. But after the patch, for every 8 bytes that you
>>>> copy, you have to load a cacheline from the vmemmap to get the page.
>>>
>>> Yup this is representative of what my investigation is showing.
>>>
>>> I've narrowed it down but want to wait to report until I'm sure...
>>>
>>> But yeah we're doing a _lot_ more work.
>>>
>>> I'm leaning towards disabling except for arm64 atm tbh, seems mremap is
>>> especially sensitive to this (I found issues with this with my abortive mremap
>>> anon merging stuff too, but really expected it there...)
>>
>> Another approach would be to always read and write PTEs in
>> contpte-sized chunks here, without caring whether they're actually
>> contiguous or whatever, or something along those lines.
> 
> Not sure I love that, you'd have to figure out offset without cont pte batch and
> can it vary? And we're doing this on non-arm64 arches for what reason?
> 
> And would it solve anything really? We'd still be looking at folio, yes less
> than now, but uselessly for arches that don't benefit?
> 
> The basis of this series was (and I did explicitly ask) that it wouldn't harm
> other arches.

We'd need some hint to detect "this is either small" or "this is 
unbatchable".

Sure, we could use pte_batch_hint(), but I'm curious if x86 would also 
benefit with larger folios (e.g., 64K, 128K) with this patch.

-- 
Cheers,

David / dhildenb


