Return-Path: <linux-kernel+bounces-613614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8AA95EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 09:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9585177EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 07:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA102356DE;
	Tue, 22 Apr 2025 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkL2/m+V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099122AE49
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305549; cv=none; b=gBtkudG5KAsFdvLlLkjVydsfXwcVTCHrSq2JY6DEhTIceULuiaVxcZ1wJqF8HB2ZwZwKJhu+BheIqp791bQN4lx4ArGc3LAelwXMl4M/003UvSO+rjIE9f5M6zI+tr8V8XGy6F8h/nkYP95NMxYWf1/NCnfYFrepq7RhLwddRNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305549; c=relaxed/simple;
	bh=EPQkZr3mHxiGcf03Q4jAvGz4dSfcpVrqRKeYrNLMegQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUbG8jxbeD3QcwhzJhSFy2nOqLcJVPNgd93tPNev9QKuJov8O2OgMFB8em7QtgYHKo43lcBzFIg93CcvL6w1rITocLg3iza0eky1v4cR/LVodRrbfm92NvbW2RPcaBNeQxZ1mW029DFAowCmUEcSGGbdDFcqV7CS9eV9kLeTs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkL2/m+V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745305546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jF+wFy+WZJrXig0sm8RWiuDKt94+0heDSw+sib+cbbA=;
	b=NkL2/m+Vm+sHuRAB7kGxgaLolE6GrxYGDNPWajFQCembWC6FyUcPE8Nz68Jzog6jigrzvl
	OnooRFlYbF3E2ysS7QFqoMXFJZKaQSqaZcww4eTXpZ2mJE9xQceVn4xkb8x31BNcI1YZQJ
	WYm2NF7W8qK2A8keK2IRwLohAYCmlO4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-J9eZB9cLMQ2gdqEA1mM7UA-1; Tue, 22 Apr 2025 03:05:44 -0400
X-MC-Unique: J9eZB9cLMQ2gdqEA1mM7UA-1
X-Mimecast-MFC-AGG-ID: J9eZB9cLMQ2gdqEA1mM7UA_1745305543
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so35203275e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 00:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745305543; x=1745910343;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jF+wFy+WZJrXig0sm8RWiuDKt94+0heDSw+sib+cbbA=;
        b=ogIDuAy1tS60OOjeNwHyMG2kU/MGQ6NpFJgoXFg2vCJiDFMYhxZvs/BKh1w+hMmNhM
         0Bfhj48uFA6Bk+2xOLfYWp4PAWsHZNb8usX3kaP7GfKp5xDOIFWs4SLEwR4Z8DE5jfaF
         Q5792UwkAj/fDU25IrwmaOw8LFRXuRQ4LaaAnAY0xYVanW5EOsKQ21BCSIgFMgW8jXS5
         6qqcM9tmSrw01n+Ho2OVlR90KqpwQXhalg+Y/a8CzrP9i7UbTbsK6kfdTYF6H4vftJPu
         1hxGB9y8JVHDP1UxRpj/53zyDkxx9gT7GHscIuVarqNc2R/ZPLfWZZWJJFZ39Lpr5W3G
         1GAQ==
X-Gm-Message-State: AOJu0YxpMgHrSXFkQKsWEExGDeWXVDpyozaIDTYJYYvK4nCh0iJzTcSs
	gvbQr8sRDvtpV8k9+xAxfY6E0dG0P1t77uPAUE44tPBKo6bn7TZkrlcSxPj0Tb4r+ap/Fx8XrBw
	I4uXUfhPqpbh226kKdXSO0AsI+b+PTJXriSPFqQ4Tv23BT29Akhx/YodcyayzaIAHZo8jgP+A
X-Gm-Gg: ASbGncvDGH2pWIajwnpeMmkdu9Y7T5GhAUncVfyqfZT/2hqceukusd+1BRKR5ZgNdO9
	x2vTfZLZ4T0Yv+7SE7XTptpDXnGCCYJ6nCcUkRJh2Rr5ik2QVUkdq+cYn6ZT/fAz0MmcVc5CbtZ
	I2AdBNRq8nYcrBp/dBMIe60K+ULdoOf6iegumhXUQedIxL0+VQ8CG+9J0cCxh+hrHBiUsAqzuE/
	ZpgvsbtmFUXM7ODHzYNNxst605kSiFIfWotGWqdpT5eBn01zUPzeNOAwB9MNG4A2cFoSON4ZyEk
	20/zcwxiiROIZg+a9tMHMLBffmck+0nURLj7xC5oTaIoirEeU+YLgJQwKvUNclXwXY5l4LAqUvF
	nxSgkzXbtboI1M+gvtWFyZArSKSeSbexGwcpj
X-Received: by 2002:a5d:47ab:0:b0:39c:142a:ed6c with SMTP id ffacd0b85a97d-39efbad3df4mr11838916f8f.40.1745305543524;
        Tue, 22 Apr 2025 00:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4fD+rv1vFvSzw5y7MZVEXu2KkMb+wX9rdoQ/fOSpSvepAK7BkNGVhNuqRwxxPUqcFRd8B1g==
X-Received: by 2002:a5d:47ab:0:b0:39c:142a:ed6c with SMTP id ffacd0b85a97d-39efbad3df4mr11838889f8f.40.1745305543188;
        Tue, 22 Apr 2025 00:05:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:8700:3969:7786:322:9641? (p200300cbc73187003969778603229641.dip0.t-ipconnect.de. [2003:cb:c731:8700:3969:7786:322:9641])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acca9sm161960395e9.12.2025.04.22.00.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 00:05:42 -0700 (PDT)
Message-ID: <3cb85c4b-7e28-4a70-92da-1d835eaf467d@redhat.com>
Date: Tue, 22 Apr 2025 09:05:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/20] mm: Copy-on-Write (COW) reuse support for
 PTE-mapped THP
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-14-david@redhat.com>
 <CAMgjq7D+ea3eg9gRCVvRnto3Sv3_H3WVhupX4e=k8T5QAfBHbw@mail.gmail.com>
 <c7e85336-5e34-4dd9-950f-173f48ff0be1@redhat.com>
 <da399be3-4219-4ccf-a41d-9db7e1e45c14@redhat.com>
 <CAMgjq7CcSZf0be+OwttyzC3ZQJWZPOtDK1AtXvaPkuVuVk-XOg@mail.gmail.com>
 <CAMgjq7B_7jb9MRt+npesVhz1QV3sZ_6qzZQKHKP5J3rGVNJv6w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAMgjq7B_7jb9MRt+npesVhz1QV3sZ_6qzZQKHKP5J3rGVNJv6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.04.25 04:52, Kairui Song wrote:
> On Sun, Apr 20, 2025 at 12:35 AM Kairui Song <ryncsn@gmail.com> wrote:
>>
>> On Sun, Apr 20, 2025 at 12:32 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 19.04.25 18:25, David Hildenbrand wrote:
>>>
>>> Oh, re-reading the condition 3 times, I realize that the sanity check is wrong ...
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 037b6ce211f1f..a17eeef3f1f89 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3789,7 +3789,7 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
>>>
>>>           /* Stabilize the mapcount vs. refcount and recheck. */
>>>           folio_lock_large_mapcount(folio);
>>> -       VM_WARN_ON_ONCE(folio_large_mapcount(folio) < folio_ref_count(folio));
>>> +       VM_WARN_ON_ONCE(folio_large_mapcount(folio) > folio_ref_count(folio));
>>
>> Ah, now it makes sense to me now :)
>>
>> Thanks for the quick response.
>>
>>>
>>>           if (folio_test_large_maybe_mapped_shared(folio))
>>>                   goto unlock;
>>>
>>> Our refcount must be at least the mapcount, that's what we want to assert.
>>>
>>> Can you test and send a fix patch if that makes it fly for you?
>>
>> Sure I'll keep the testing, I think it will just fix it, I have a few
>> WARN_ON_FOLIO reports all reporting mapcount is smaller than refcount.
> 
> Hi David,
> 
> I'm no longer seeing any warning after this, it fixed the problem well.

Cool, can you send a fix?

-- 
Cheers,

David / dhildenb


