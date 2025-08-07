Return-Path: <linux-kernel+bounces-759393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B031BB1DCF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5765F627AA6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4114F262FD1;
	Thu,  7 Aug 2025 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjYYPYcJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F542222BA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590406; cv=none; b=fCwQjJRI5MXOp10qnkPTg9VKv4UlJym5bmYa2OK+uLoPdKO1J/VIT3Vc05cX5S93c99k0AJA1IC845EKur00RzAH+ulRf22S3Pn5IsTQtufKn4c8SzfFo3wS0av3OujKMAPrMDH5K8ePixBY0mQoNIaL6740Mt3k0ayLy3OtBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590406; c=relaxed/simple;
	bh=57R6AIEdC/wfP4X5GjirslcUlWrLN5Xs9++4ZSAw6bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDhTjOms3+3grXA5nrKQed8tGTUwI2dCAVBOYrAcgO+X+mkFIXxwYk324M2CYjtCBUBIpumxpqib+kKpSgT4MlW/wHpNJsZ1F7RfozIJYKl4AN66xXxRlRf0cnCS+ekUjz3CQcA/05oc7E41LFEpm94AZ3zrRoKzo15UubsWyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjYYPYcJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754590403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vZ4qf63/4d76saBrOUo5cTb52Cq5w2s1M6dqccUekpo=;
	b=DjYYPYcJZ5kcfXmRbNkSeS5hcBXo0rulIVEMjOYGobqnFMjGDSqoxKh95E2nSpKI7O0yz6
	ij+L9e2iRO8GnbwHp3G7ct2xihOChdtpSmOHIo06ARbGFFwG8Hfw8y5JUjbWV6vHslWG+u
	+ouVSCpePXODrGlnlrkTTLnN4lzzUxA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-LJyDCfxXNdKn_2e6VQFkdA-1; Thu, 07 Aug 2025 14:13:22 -0400
X-MC-Unique: LJyDCfxXNdKn_2e6VQFkdA-1
X-Mimecast-MFC-AGG-ID: LJyDCfxXNdKn_2e6VQFkdA_1754590401
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459d7ed90baso9430015e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754590401; x=1755195201;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vZ4qf63/4d76saBrOUo5cTb52Cq5w2s1M6dqccUekpo=;
        b=XGaUuUkdlCCsInkWcmp/T5p8QQmZ6RMJQZyjIRfR3/cnoOE7cr5t+bGXAVdu9UBJYm
         pAQltxh3+uMBA0g9UhEKyKibepC4LBGSvhEoFC8zpWCGz24a60wIvEAh2Bf8phB2zt58
         8fSJ+HYQbuggnFhDHd2pmFiZvpBluiwjJHKKMOEyxYXmW/cRCu0tLuk4/6Pypv+wsOdG
         l7im+2m64OxNKZ1uTzLsG7fqX3SWc5DSrkrLNSN9mDrJTYxun44iqJgJnu1K1ATGESb0
         EefhRMd+RZqEV7xIowbAdx1/O8NoQve4wv1lFomu3nyl87UGOw5T+wo2eLeBytBfPtur
         9htw==
X-Forwarded-Encrypted: i=1; AJvYcCUEUYrg9E/Je6nZ1T9n4dENmY5dJUuG3gH2q+d0o7Z5rpSwl4WjFxq0NbfgjY/QIStCeWmK/ZJ0LZBH/Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzgmJzIobOH0XDaZWqviq35hc6W0Ek+S4rGj7dRtAkGZAzjDd
	4RFNn6DSkvcu6sxLzhq7vW4Ay9RmW8yMAR8FhpHeKxxEcWOMRSEYBdO2HGnp3NSY7oY0DtUIvsh
	G5wwLUnsOUxBbvCMW8eLwzgnS+6YSqF8eDjeMjQAXburvMCDYbT1m8x1S0L65QPz4mQ==
X-Gm-Gg: ASbGnctQNz9lodpyAWVQMZ9zrEMzICcLItHko05TP3Pi9ioQNRSOpH8ZvwOzKXEjuWS
	omC44xEUu68IZRg7d8/fENStBKqLMIVd0zYJesC1xMzoIWcivBVeLzaJGjBG3UaH2FrFbEX8Mjf
	rmrVWCszkjpyHQMG2bwCx+HunyubYZxzu9aimxudKZEa7jlKT5Wls9PVIm96Y+MVfRNCkEDY7QM
	mODPC1ky5ICpO0kN7jsmJ/8pfSZxdNx6ixd3Ri9B4C4knomafVrK776B6DXQi9Za4wFMwixRW2x
	Bo3eD4ZpmzqsVx61kfQi0n7nVfH+Uu6ewMTgjq6CV7aRvg86Fapdu84/1Y3AW9naTUMEVBl8IC7
	5XG5fN7Lp0XLL07S4428PruEQwxepG35GWEY7ZQ02Dfzy2B2DFJqHfFbdBjjSCzHbag0=
X-Received: by 2002:a05:600c:4707:b0:459:e094:92c2 with SMTP id 5b1f17b1804b1-459e74a861fmr66148005e9.27.1754590400566;
        Thu, 07 Aug 2025 11:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3yhDF4k6z9/RJJDjl6ABCdlp8A+KepCRdH1HEc4EW/M3PvJTf74RIoantFL5NB5UUVs3YmQ==
X-Received: by 2002:a05:600c:4707:b0:459:e094:92c2 with SMTP id 5b1f17b1804b1-459e74a861fmr66147545e9.27.1754590400015;
        Thu, 07 Aug 2025 11:13:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f49:bc00:12fa:1681:c754:1630? (p200300d82f49bc0012fa1681c7541630.dip0.t-ipconnect.de. [2003:d8:2f49:bc00:12fa:1681:c754:1630])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58554f2sm100987285e9.12.2025.08.07.11.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 11:13:19 -0700 (PDT)
Message-ID: <41bdce39-f731-4a93-a91c-34035f2d2814@redhat.com>
Date: Thu, 7 Aug 2025 20:13:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] f822a9a81a:
 stress-ng.bigheap.realloc_calls_per_sec 37.3% regression
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, kernel test robot <oliver.sang@intel.com>,
 Dev Jain <dev.jain@arm.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Barry Song <baohua@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
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
 <cbc2e23d-69ab-4820-9942-c7abf2066ff7@redhat.com>
 <2f0fef16-14ba-4195-b2ec-aabc69f445b1@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <2f0fef16-14ba-4195-b2ec-aabc69f445b1@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.08.25 20:04, Lorenzo Stoakes wrote:
> On Thu, Aug 07, 2025 at 08:01:51PM +0200, David Hildenbrand wrote:
>> On 07.08.25 19:51, Lorenzo Stoakes wrote:
>>> On Thu, Aug 07, 2025 at 07:46:39PM +0200, Jann Horn wrote:
>>>> On Thu, Aug 7, 2025 at 7:41 PM Lorenzo Stoakes
>>>> <lorenzo.stoakes@oracle.com> wrote:
>>>>> On Thu, Aug 07, 2025 at 07:37:38PM +0200, Jann Horn wrote:
>>>>>> On Thu, Aug 7, 2025 at 10:28 AM Lorenzo Stoakes
>>>>>> <lorenzo.stoakes@oracle.com> wrote:
>>>>>>> On Thu, Aug 07, 2025 at 04:17:09PM +0800, kernel test robot wrote:
>>>>>>>> 94dab12d86cf77ff f822a9a81a31311d67f260aea96
>>>>>>>> ---------------- ---------------------------
>>>>>>>>            %stddev     %change         %stddev
>>>>>>>>                \          |                \
>>>>>>>>        13777 ą 37%     +45.0%      19979 ą 27%  numa-vmstat.node1.nr_slab_reclaimable
>>>>>>>>       367205            +2.3%     375703        vmstat.system.in
>>>>>>>>        55106 ą 37%     +45.1%      79971 ą 27%  numa-meminfo.node1.KReclaimable
>>>>>>>>        55106 ą 37%     +45.1%      79971 ą 27%  numa-meminfo.node1.SReclaimable
>>>>>>>>       559381           -37.3%     350757        stress-ng.bigheap.realloc_calls_per_sec
>>>>>>>>        11468            +1.2%      11603        stress-ng.time.system_time
>>>>>>>>       296.25            +4.5%     309.70        stress-ng.time.user_time
>>>>>>>>         0.81 ą187%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>>>         9.36 ą165%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>>>         0.81 ą187%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>>>         9.36 ą165%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>>>         5.50 ą 17%    +390.9%      27.00 ą 56%  perf-c2c.DRAM.local
>>>>>>>>       388.50 ą 10%    +114.7%     834.17 ą 33%  perf-c2c.DRAM.remote
>>>>>>>>         1214 ą 13%    +107.3%       2517 ą 31%  perf-c2c.HITM.local
>>>>>>>>       135.00 ą 19%    +130.9%     311.67 ą 32%  perf-c2c.HITM.remote
>>>>>>>>         1349 ą 13%    +109.6%       2829 ą 31%  perf-c2c.HITM.total
>>>>>>>
>>>>>>> Yeah this also looks pretty consistent too...
>>>>>>
>>>>>> FWIW, HITM hat different meanings depending on exactly which
>>>>>> microarchitecture that test happened on; the message says it is from
>>>>>> Sapphire Rapids, which is a successor of Ice Lake, so HITM is less
>>>>>> meaningful than if it came from a pre-IceLake system (see
>>>>>> https://lore.kernel.org/all/CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGvXCq7Xr-w@mail.gmail.com/).
>>>>>>
>>>>>> To me those numbers mainly look like you're accessing a lot more
>>>>>> cache-cold data. (On pre-IceLake they would indicate cacheline
>>>>>> bouncing, but I guess here they probably don't.) And that makes sense,
>>>>>> since before the patch, this path was just moving PTEs around without
>>>>>> looking at the associated pages/folios; basically more or less like a
>>>>>> memcpy() on x86-64. But after the patch, for every 8 bytes that you
>>>>>> copy, you have to load a cacheline from the vmemmap to get the page.
>>>>>
>>>>> Yup this is representative of what my investigation is showing.
>>>>>
>>>>> I've narrowed it down but want to wait to report until I'm sure...
>>>>>
>>>>> But yeah we're doing a _lot_ more work.
>>>>>
>>>>> I'm leaning towards disabling except for arm64 atm tbh, seems mremap is
>>>>> especially sensitive to this (I found issues with this with my abortive mremap
>>>>> anon merging stuff too, but really expected it there...)
>>>>
>>>> Another approach would be to always read and write PTEs in
>>>> contpte-sized chunks here, without caring whether they're actually
>>>> contiguous or whatever, or something along those lines.
>>>
>>> Not sure I love that, you'd have to figure out offset without cont pte batch and
>>> can it vary? And we're doing this on non-arm64 arches for what reason?
>>>
>>> And would it solve anything really? We'd still be looking at folio, yes less
>>> than now, but uselessly for arches that don't benefit?
>>>
>>> The basis of this series was (and I did explicitly ask) that it wouldn't harm
>>> other arches.
>>
>> We'd need some hint to detect "this is either small" or "this is
>> unbatchable".
>>
>> Sure, we could use pte_batch_hint(), but I'm curious if x86 would also
>> benefit with larger folios (e.g., 64K, 128K) with this patch.
> 
> For the record I did think of using this prior to being mentioned, product of
> actually trying to get the data to back this up instead of talking...
> 
> Anyway, isn't that chicken and egg? We'd have to go get the folio to find out if
> large folio and incur the cost before we knew?
> 
> So how could we make that workable?

E.g., a best-effort check if the next pte likely points at the next PFN.

But as Jann mentioned, there might actually be no benefit on other 
architectures (benchmarking would probably tell us the real story).

-- 
Cheers,

David / dhildenb


