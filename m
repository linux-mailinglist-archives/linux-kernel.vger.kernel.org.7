Return-Path: <linux-kernel+bounces-802785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91615B456FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D2B1C85519
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8134A325;
	Fri,  5 Sep 2025 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOSuvZxu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3434A30A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073328; cv=none; b=ZBG+QHf2WJqXxbRlGoULjiMCSzcbFtcEC1Kf5+JQxi2hetOaZ4PBVxjbA0wlMpYOrd3kG0h3e4ttEAYuzj2JX2sD+UBrvzNEYUGtirzEdCWBQlhVYWvhT28MLclXt6hZhnzTtak4PeHfJnBqAK+FISZES8x2aqAlAmSaG5nIQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073328; c=relaxed/simple;
	bh=ncyLYXZ6MoWIQWBf1cFrZizX7OH6Rc2BvPxaUK1PTuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RY3SJf3amiq/MIWTx2L+m+WOGw101JiLwl2ZDoKvsGkCw29cTFXqmldigvvZf8s9VGB7zJkhNkWK/lFJDzUcAOrbsuEpJqubSwOMLQOXsLfTX7Bajofwoz4l7kwcxcaqHmTFTEDbjMEj0GyNNOx25wSoQrMc+DkF+SqeMnbqzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOSuvZxu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757073325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4cRISMBuuCLgX6f4naUjs5MatcD3bZ+89nNOlWRyt7w=;
	b=aOSuvZxubYbE/SAkqcBkVpXQAObT978ivi2G6MijvnE0zUb13GIEob1pINqo3wHXBc5Ep2
	msWZ8o7PN+DsHakYXc3y1Nob5iehqxerKb1cqKDIuhBQaQcP682UT66PlRC+7/AMLWpbek
	6bFNof9YenFUMfrlDzxnczQZDWMlXdw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-YQmUxjGQPFCzmVYAN_yiqA-1; Fri, 05 Sep 2025 07:55:24 -0400
X-MC-Unique: YQmUxjGQPFCzmVYAN_yiqA-1
X-Mimecast-MFC-AGG-ID: YQmUxjGQPFCzmVYAN_yiqA_1757073323
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b920e0c25so14792075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 04:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073323; x=1757678123;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cRISMBuuCLgX6f4naUjs5MatcD3bZ+89nNOlWRyt7w=;
        b=sduMmEthw/Das2FRfvwUNXJaPRWkKicZuoqcY2BOn4iqc5AZ3qVMSf3eXKnzzVmz2d
         vIMfMkb4xuL3DGEOMut7fpT0xkdLWpNGfeFDa5rwE0l4DVPX4Nc9Ms82LKpXWkhCbiq+
         jadF5mZl591Reo6ZiStuoynsZGryaRCvnqhCnsKvDI7ocnxBhjOPS2aJtYTc8uwLqlkk
         wZper7aqlXTW59iOQGLpTmuL3pNDdWVjxR5GLaLFITHYBwD3xKp9sHqHbf0lg1lY6cX1
         x9E+VKNhxbN7LK0AI+5cVxKirckdQXeLyu9d5j3EvZkx+OLD9cgs8xWDtQGcKUWostbO
         Uo1w==
X-Forwarded-Encrypted: i=1; AJvYcCWDOYst57+uFZ9K6uIKMmOKmzAt/FM0wnn5HMA2oqaodaD9xc1LYYcEAf7S+sT3llj+4VuYzB1Ba/uCkmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDcMXZpe8ygcFgbfYNQ+xK8guYfx+9orUhD1d6IfHO4BZEcGDC
	CJqGjqdXa5CPKmp5R2bTxLWc371dTpnR9zQdVj4Bp8kkYxrzMYx6HEZplWlFQ0VK8Pe3JnQbCQS
	e7AintIRqm+XE1jsFb0+BOfxsI9Ed+YRwBDGi1JLIzpqWsXzaHCP+4736+oWjdMfZOA==
X-Gm-Gg: ASbGncsgNOG5rmdjlO0pfsI17ErLljz0FLI/jYwsgZP5xFlYAaQRGD9y2XLZJi1Yljt
	MFAke/ZHsIvWSU3QEbMeN0DZq30Vth9lRrTm5zjLb9iz59JBK1TMkFFnhQrqpf082Ehe3Zv7Ic3
	gZCw6S2WJr2zvAjXMeAEv8zv7bP2gcBY4L14IxA/5TqWoZF+BWyGSguRh20BmAxyKkmYMz1yjwN
	VIXSJQOulacnAd5F+tP9+zEDs4cCYCjK7bWpwS6kJyJGnpSjMGzK8jSV34YobTXit/Thbr8xYjR
	EKU43vraMni8kMXisLr0T438OVp3LtsEYTYdIdfSx8Tkn30VpN2Qx+5yHCstFfV6qeu1wNiyd9h
	ii+4IvzZcPdaPDLEFEl2uoA0/MjWqbaWyJ7Kja2sr0iKT7dJzWTUdwuWS
X-Received: by 2002:a05:600c:1384:b0:45b:7b00:c129 with SMTP id 5b1f17b1804b1-45b8558d694mr190644785e9.35.1757073323354;
        Fri, 05 Sep 2025 04:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCcrnrvc4r4+WNeVxo8uiZgoKTe2Wmsv9/zx+pciFYGL6K13k0lLB8PUGJjfD3xhbwr1XfWg==
X-Received: by 2002:a05:600c:1384:b0:45b:7b00:c129 with SMTP id 5b1f17b1804b1-45b8558d694mr190644535e9.35.1757073322777;
        Fri, 05 Sep 2025 04:55:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e18537589dsm5619251f8f.54.2025.09.05.04.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:55:22 -0700 (PDT)
Message-ID: <65ce71c1-72a5-415e-9059-027167abf129@redhat.com>
Date: Fri, 5 Sep 2025 13:55:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <db2320ee-6bd4-49c1-8fce-0468f48e1842@linux.alibaba.com>
 <c8c5e818-536a-4d72-b8dc-36aeb1b61800@arm.com>
 <2a141eef-46e2-46e1-9b0f-066ec537600d@linux.alibaba.com>
 <f34b5fcb-6a97-4d97-86a8-906083b53be6@redhat.com>
 <eb02c281-6d41-44af-8eaf-8ffc29153a3a@linux.alibaba.com>
 <286e2cb3-6beb-4d21-b28a-2f99bb2f759b@redhat.com>
 <17075d6a-a209-4636-ae42-2f8944aea745@gmail.com>
 <287f3b64-bc34-48d9-9778-c519260c3dba@redhat.com>
 <ad6ed55e-2471-46be-b123-5272f3052e01@gmail.com>
 <CAA1CXcCMPFqiiTi7hfVhhEvHs4Mddiktvpmb7dMe4coLDF0bgg@mail.gmail.com>
 <61afc355-1877-4530-86b7-e0aa2b6fb827@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <61afc355-1877-4530-86b7-e0aa2b6fb827@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.09.25 13:48, Lorenzo Stoakes wrote:
> On Wed, Sep 03, 2025 at 08:54:39PM -0600, Nico Pache wrote:
>> On Tue, Sep 2, 2025 at 2:23 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>> So I question the utility of max_ptes_none. If you can't tame page faults, then there is only
>>>>>> limited sense in taming khugepaged. I think there is vale in setting max_ptes_none=0 for some
>>>>>> corner cases, but I am yet to learn why max_ptes_none=123 would make any sense.
>>>>>>
>>>>>>
>>>>>
>>>>> For PMD mapped THPs with THP shrinker, this has changed. You can basically tame pagefaults, as when you encounter
>>>>> memory pressure, the shrinker kicks in if the value is less than HPAGE_PMD_NR -1 (i.e. 511 for x86), and
>>>>> will break down those hugepages and free up zero-filled memory.
>>>>
>>>> You are not really taming page faults, though, you are undoing what page faults might have messed up :)
>>>>
>>>> I have seen in our prod workloads where
>>>>> the memory usage and THP usage can spike (usually when the workload starts), but with memory pressure,
>>>>> the memory usage is lower compared to with max_ptes_none = 511, while still still keeping the benefits
>>>>> of THPs like lower TLB misses.
>>>>
>>>> Thanks for raising that: I think the current behavior is in place such that you don't bounce back-and-forth between khugepaged collapse and shrinker-split.
>>>>
>>>
>>> Yes, both collapse and shrinker split hinge on max_ptes_none to prevent one of these things thrashing the effect of the other.
>> I believe with mTHP support in khugepaged, the max_ptes_none value in
>> the shrinker must also leverage the 'order' scaling to properly
>> prevent thrashing.
> 
> No please do not extend this 'scalling' stuff somewhere else, it's really horrid.
> 
> We have to find an alternative to that, it's extremely confusing in what is
> already extremely confusing THP code.
> 
> As I said before, if we can't have a boolean we need another interface, which
> makes most sense to be a ratio or in practice, a percentage sysctl.
> 
> Speaking with David off-list, maybe the answer - if we must have this - is to
> add a new percentage interface and have this in lock-step with the existing
> max_ptes_none interface. One updates the other, but internally we're just using
> the percentage value.

Yes, I'll try hacking something up and sending it as an RFC.

> 
>> I've been testing a patch for this that I might include in the V11.
>>>
>>>> There are likely other ways to achieve that, when we have in mind that the thp shrinker will install zero pages and max_ptes_none includes
>>>> zero pages.
>>>>
>>>>>
>>>>> I do agree that the value of max_ptes_none is magical and different workloads can react very differently
>>>>> to it. The relationship is definitely not linear. i.e. if I use max_ptes_none = 256, it does not mean
>>>>> that the memory regression of using THP=always vs THP=madvise is halved.
>>>>
>>>> To which value would you set it? Just 510? 0?

Sorry, I missed Usama's reply. Thanks Usama!

>>>>
>>>
>>> There are some very large workloads in the meta fleet that I experimented with and found that having
>>> a small value works out. I experimented with 0, 51 (10%) and 256 (50%). 51 was found to be an optimal
>>> comprimise in terms of application metrics improving, having an acceptable amount of memory regression and
>>> improved system level metrics (lower TLB misses, lower page faults). I am sure there was a better value out
>>> there for these workloads, but not possible to experiment with every value.
> 
> (->Usama) It's a pity that such workloads exist. But then the percentage solution should work.

Good. So if there is no strong case for > 255, that's already valuable 
for mTHP.

-- 
Cheers

David / dhildenb


