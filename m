Return-Path: <linux-kernel+bounces-846531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 678DBBC8416
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628B51A60344
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DAC2C0F68;
	Thu,  9 Oct 2025 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilgZSr2H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D428CF42
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001553; cv=none; b=nvOj3xl/xIlOwxmSXhsoGkVMFxjuLB0P4gixNYTgkZ+qBBmuGa/WBX0wYqU3ge0QrwG7Ji4qOzhxvwS00CUSv2SNhZIeG9a5isk0tDzvnEErTB6UzYyNDmyIkgzIiv5dyDQWHOwrGITwQUGz1bPCBIcMYfeex4VT6jPYSeANrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001553; c=relaxed/simple;
	bh=iAbbBMOs6KgHnQbdcFFLs+hJKFOpiHY/OWCzq6L2+2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BjbRhVwOquao/XFJObeO0rdxcMenaH9aZbOB9Ed7dYLCp3qyJkOqlPq8BFQYPPCbRo7ldgLhfleFevOFV0MRmruXvo2N9N8mjbF7vSVld8ngnG+i4d0VJzvsMdr4dyqe4JdSkwRrIRJuVHB/rwLmDaEXrJuAeMMKTHXtc6Mma80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilgZSr2H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760001550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ym+DdkcmRG4wvpfz5ykb6s+kf1elRde6oG+aT4Hjw8w=;
	b=ilgZSr2HEImNC5QZj95O0lu8TUGYqTX2fQ6e6IlYDAP1wnBuq5sexMcb++pbEsDwx/yn6r
	TEmETUzcno/2kF9RJGMv1JF5v4TjGqV9iQgTvKmqJ2n7FuUHrCrezjvXLyz0L2FWtHWUJX
	qBdt5xgxV4EXb7NNfVK+cmyi5VyCIek=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-23orbOXZNAWo8CcNZ7sCYw-1; Thu, 09 Oct 2025 05:19:08 -0400
X-MC-Unique: 23orbOXZNAWo8CcNZ7sCYw-1
X-Mimecast-MFC-AGG-ID: 23orbOXZNAWo8CcNZ7sCYw_1760001547
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e38957979so3306705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760001547; x=1760606347;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ym+DdkcmRG4wvpfz5ykb6s+kf1elRde6oG+aT4Hjw8w=;
        b=fOKq9V9esjM8TSC3IVaRbF7/PPC5DSCmxcSvo9fh0ndngq82QTBgcLwyxhiISSOge8
         1rYpnoHoxcy+exe0FE3gC+k77W7B6DYjKb3Lexc91tK7wlFCU0f/af7LCY98tHYt1rzF
         lg9SqU1zEpnDkZ/YO8H3JM6UUCbHuA791WW/Un9Xr6FG+ASYY68IsyTTkXd7EGfGqBSX
         25tCT3sXVYxwsVxF6a3CVLZysSs6zYDvdwHu1qTv39K52h2C264XQ3jouCdDmec+f+QQ
         7/y38qsgK5jewRiYIbJpVxffHl4vUNlyEHFATnvXHA8cymtxqHRj76O6RwLkT63IDD3s
         eoEw==
X-Forwarded-Encrypted: i=1; AJvYcCUaGsdZKLqIFPLx+fDIwzY7kc/u04T1FP+sj8giVmHGB0spTLaaH3wjBgE6usW0a4EL2BX2lOR0BnjRRDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmf0QCEYCRHPySktbad0Z8yAhhx8TgkdqpkW9OVPuAaMx3Yaro
	qosYXe4S4pXiQNEYeg3bhv+R97am4WSJxbXkE7NU60ePsXM+fyLRSLDNTS9zYIaqnhfyjKBHv6u
	7lojVNyrmDvIp56OUhNkIkQKPwe+oPKvuMzq/Aq/EdKUYbZ2RfpnNysIS8czAFUjaXg==
X-Gm-Gg: ASbGnct7lXhZvSJ7GSPpVGPaRaQ4yLl50ZhU/02BenU7tpEBDnnD1EasxYUVTidJvH2
	n1KeRIaYy+/7H5pgxURIY6KZg5SCxRib7uQkm0h4eCgZGkjMKUAG8JRiqjtTeZSo/5BW5/kgrly
	bnJaUl5Ayb39T2Rke2P5LAZzzEQPon/3d2G+Dz2qe+86Qg5hBiHM8Ha7y/ILogofk68MjpPl9/7
	e3tQUZskWTGqeHJwq/FyWeZgF+5hcs/944H3HY3/HLwxQs0g++ZIlfuX6BSW3Y50cTUKUGmFRyA
	h/UBuIQEEkOwklPCtsaiJwb/Q5G31L9UjD+dSzDuwQAOsSFHddyL53skicrLR19gi0bSbCf8bU+
	JJ2CPvRXj
X-Received: by 2002:a05:600c:c4a3:b0:46e:1fc2:f9ac with SMTP id 5b1f17b1804b1-46fa9a98fc7mr50624125e9.10.1760001547017;
        Thu, 09 Oct 2025 02:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFReIJdkF3acFZPAnWeL0i3BOZQC/foYxEC2R8ZxnsgKIO/Vq2BUJi9cBf7+x2XtZK2O/u2OA==
X-Received: by 2002:a05:600c:c4a3:b0:46e:1fc2:f9ac with SMTP id 5b1f17b1804b1-46fa9a98fc7mr50623665e9.10.1760001546471;
        Thu, 09 Oct 2025 02:19:06 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6daasm34080730f8f.7.2025.10.09.02.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:19:05 -0700 (PDT)
Message-ID: <129379f6-18c7-4d10-8241-8c6c5596d6d5@redhat.com>
Date: Thu, 9 Oct 2025 11:19:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, baolin.wang@linux.alibaba.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>,
 21cnbao@gmail.com, Shakeel Butt <shakeel.butt@linux.dev>,
 Tejun Heo <tj@kernel.org>, lance.yang@linux.dev,
 Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
 <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com>
 <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
 <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com>
 <CALOAHbD_tRSyx1LXKfFrUriH6BcRS6Hw9N1=KddCJpgXH8vZug@mail.gmail.com>
 <96AE1C18-3833-4EB8-9145-202517331DF5@nvidia.com>
 <f743cfcd-2467-42c5-9a3c-3dceb6ff7aa8@redhat.com>
 <CALOAHbAY9sjG-M=nwWRdbp3_m2cx_YJCb7DToaXn-kHNV+A5Zg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CALOAHbAY9sjG-M=nwWRdbp3_m2cx_YJCb7DToaXn-kHNV+A5Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.10.25 15:11, Yafang Shao wrote:
> On Wed, Oct 8, 2025 at 8:07 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.10.25 13:27, Zi Yan wrote:
>>> On 8 Oct 2025, at 5:04, Yafang Shao wrote:
>>>
>>>> On Wed, Oct 8, 2025 at 4:28 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 08.10.25 10:18, Yafang Shao wrote:
>>>>>> On Wed, Oct 8, 2025 at 4:08 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 03.10.25 04:18, Alexei Starovoitov wrote:
>>>>>>>> On Mon, Sep 29, 2025 at 10:59 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
>>>>>>>>> +                                     enum tva_type type,
>>>>>>>>> +                                     unsigned long orders)
>>>>>>>>> +{
>>>>>>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
>>>>>>>>> +       int bpf_order;
>>>>>>>>> +
>>>>>>>>> +       /* No BPF program is attached */
>>>>>>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
>>>>>>>>> +                     &transparent_hugepage_flags))
>>>>>>>>> +               return orders;
>>>>>>>>> +
>>>>>>>>> +       rcu_read_lock();
>>>>>>>>> +       bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
>>>>>>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
>>>>>>>>> +               goto out;
>>>>>>>>> +
>>>>>>>>> +       bpf_order = bpf_hook_thp_get_order(vma, type, orders);
>>>>>>>>> +       orders &= BIT(bpf_order);
>>>>>>>>> +
>>>>>>>>> +out:
>>>>>>>>> +       rcu_read_unlock();
>>>>>>>>> +       return orders;
>>>>>>>>> +}
>>>>>>>>
>>>>>>>> I thought I explained it earlier.
>>>>>>>> Nack to a single global prog approach.
>>>>>>>
>>>>>>> I agree. We should have the option to either specify a policy globally,
>>>>>>> or more refined for cgroups/processes.
>>>>>>>
>>>>>>> It's an interesting question if a program would ever want to ship its
>>>>>>> own policy: I can see use cases for that.
>>>>>>>
>>>>>>> So I agree that we should make it more flexible right from the start.
>>>>>>
>>>>>> To achieve per-process granularity, the struct-ops must be embedded
>>>>>> within the mm_struct as follows:
>>>>>>
>>>>>> +#ifdef CONFIG_BPF_MM
>>>>>> +struct bpf_mm_ops {
>>>>>> +#ifdef CONFIG_BPF_THP
>>>>>> +       struct bpf_thp_ops bpf_thp;
>>>>>> +#endif
>>>>>> +};
>>>>>> +#endif
>>>>>> +
>>>>>>     /*
>>>>>>      * Opaque type representing current mm_struct flag state. Must be accessed via
>>>>>>      * mm_flags_xxx() helper functions.
>>>>>> @@ -1268,6 +1281,10 @@ struct mm_struct {
>>>>>>     #ifdef CONFIG_MM_ID
>>>>>>                    mm_id_t mm_id;
>>>>>>     #endif /* CONFIG_MM_ID */
>>>>>> +
>>>>>> +#ifdef CONFIG_BPF_MM
>>>>>> +               struct bpf_mm_ops bpf_mm;
>>>>>> +#endif
>>>>>>            } __randomize_layout;
>>>>>>
>>>>>> We should be aware that this will involve extensive changes in mm/.
>>>>>
>>>>> That's what we do on linux-mm :)
>>>>>
>>>>> It would be great to use Alexei's feedback/experience to come up with
>>>>> something that is flexible for various use cases.
>>>>
>>>> I'm still not entirely convinced that allowing individual processes or
>>>> cgroups to run independent progs is a valid use case. However, since
>>>> we have a consensus that this is the right direction, I will proceed
>>>> with this approach.
>>>>
>>>>>
>>>>> So I think this is likely the right direction.
>>>>>
>>>>> It would be great to evaluate which scenarios we could unlock with this
>>>>> (global vs. per-process vs. per-cgroup) approach, and how
>>>>> extensive/involved the changes will be.
>>>>
>>>> 1. Global Approach
>>>>      - Pros:
>>>>        Simple;
>>>>        Can manage different THP policies for different cgroups or processes.
>>>>     - Cons:
>>>>        Does not allow individual processes to run their own BPF programs.
>>>>
>>>> 2. Per-Process Approach
>>>>       - Pros:
>>>>         Enables each process to run its own BPF program.
>>>>       - Cons:
>>>>         Introduces significant complexity, as it requires handling the
>>>> BPF program's lifecycle (creation, destruction, inheritance) within
>>>> every mm_struct.
>>>>
>>>> 3. Per-Cgroup Approach
>>>>       - Pros:
>>>>          Allows individual cgroups to run their own BPF programs.
>>>>          Less complex than the per-process model, as it can leverage the
>>>> existing cgroup operations structure.
>>>>       - Cons:
>>>>          Creates a dependency on the cgroup subsystem.
>>>>          might not be easy to control at the per-process level.
>>>
>>> Another issue is that how and who to deal with hierarchical cgroup, where one
>>> cgroup is a parent of another. Should bpf program to do that or mm code
>>> to do that? I remember hierarchical cgroup is the main reason THP control
>>> at cgroup level is rejected. If we do per-cgroup bpf control, wouldn't we
>>> get the same rejection from cgroup folks?
>>
>> Valid point.
>>
>> I do wonder if that problem was already encountered elsewhere with bpf
>> and if there is already a solution.
> 
> Our standard is to run only one instance of a BPF program type
> system-wide to avoid conflicts. For example, we can't have both
> systemd and a container runtime running bpf-thp simultaneously.

Right, it's a good question how to combine policies, or "who wins".

> 
> Perhaps Alexei can enlighten us, though we'd need to read between his
> characteristically brief lines. ;-)

There might be some insights to be had in the bpf OOM discussion at

https://lkml.kernel.org/r/CAEf4BzafXv-PstSAP6krers=S74ri1+zTB4Y2oT6f+33yznqsA@mail.gmail.com

I didn't completely read through that, but that discussion also seems to 
be about interaction between cgroups and bpd programs.

-- 
Cheers

David / dhildenb


