Return-Path: <linux-kernel+bounces-827717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94CB92862
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584034455EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41131691C;
	Mon, 22 Sep 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N64cQPf2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778E316902
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563949; cv=none; b=a7jhYzoWkmqi1aKWl4L9iTeigxfdMfJFVmvF5Fcpf7PdFgRocwit2BhPotZunV8iVp3E+tQpEgf8KDNhUl4MkwOSgesy5IK1MDbZUHo/IJyEnppJxF2nr8IizWcU75fj550s7lQBmnmyrXEDetZ5YAszBCcljyWFZ3cAkx/VaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563949; c=relaxed/simple;
	bh=2T4zLs4jG8JoEW1uy+yo4cXbnhpDwcJdi6/5sAutWr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZWXfWURdl6+nSUhv2Z15CUbhDsitlgbByG1jl7P98FgFm9NNTLwjXdO/MMGx3H7rtS2tgyY87EP0DCHFxWXu788fQJj/yZ1113WMHhRFV9uB+qcp0sa/3k9zeLluMESyEwg+gXwzCrm09Q+J9swFYqYlgmu8N9Ef4FNK9wYdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N64cQPf2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758563946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X+NpTFRiqIAeX32lj/YJRRr02h3IMluyoifxGje7HdY=;
	b=N64cQPf23OMOKn8TGNdXivCw5IxXdU+/0DpoI6atO/EuAOX/IzzQVVa+2tecxAhUexQr+H
	2vvm/pLkhVPR3uKa3BQ8sB4sUaRNcxibWiDxZOMzN+v9SCMvfFVUgfOqVdv7uxIVcjMhZF
	mefGu7QTh5oPip1a8hkIP9nhszRqWAY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-mw0CjLxPMKaebpR8GUOHrg-1; Mon, 22 Sep 2025 13:59:05 -0400
X-MC-Unique: mw0CjLxPMKaebpR8GUOHrg-1
X-Mimecast-MFC-AGG-ID: mw0CjLxPMKaebpR8GUOHrg_1758563944
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de07b831dso33248335e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563944; x=1759168744;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+NpTFRiqIAeX32lj/YJRRr02h3IMluyoifxGje7HdY=;
        b=RKJPaAsUI8uXLtTVjfDl1YJcTR4YBiblgUUSDIeJp+gEaECeBCO+IwtKgF3z77wi4m
         m1dNi3K3cTpQ5M34/yZgSbQDtZcTDbEt/wUa9ZcN37hsXeXW7ZzG7B3/5ULEWssYkhro
         qGGN6XpKYvgdxp+/TuKJpc/XTXlfSP7e6yBAPE3dmYk+JS+CAg+KwIi11n3M0r7QhlEw
         ZJikaYU/sZmEEoYq24IcnyHFaL1xOOkZ6X03TK35o0Fw+QWmhi6dkuKV3YZ4RQvnsF1c
         hPSBahCrasol7dhAEKoTELwJkmIHtVuLSffpshsnt8NMjnTrwI53LYAC06iAhPHh6PUm
         FEVg==
X-Forwarded-Encrypted: i=1; AJvYcCXGyo7In+GFm9LSuMonpP/QslUTUTQod4dzqU2qgYN0OczIQrt1BntGKra6Lw2l7I/EtGPNYdm8csTtn2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJAjuqw/tq2UWhzcwGXCp8rmesLr6SHUqcwDfCDe13GQNnE0t
	YfYRtwr4I7CBR0tDOfqrkbpQMGmBIkxqg6ll8LWC2NQ3M2RQrrWVc+FQv9xyTvJpDfiCPtg6v+7
	tz3ZGtA5QkqyTWdQ595F7uJMNU+rrohx+FQmE6VCmxeqR3VD/e+1fawcCU0BPzNUGaA==
X-Gm-Gg: ASbGncsLMtwO8wYMz2va3qfopjCB44il7g/klsVV6kIKhoHXBSNt/RC5WjQe6uLQZ2N
	WEPCPm++xX0VMZVnvHJLPsDMGfsL2FKk3FHEciqi+TJ6oibquxjdk6E0oRl2jlROwvddCJL7I3m
	Wp4qiKyvkAd/EfrPkZHe64UiMwWs23Wkqn9+iWtwq9GbBwon2lqIA45DF9+Rg4pUitQFr4QID8w
	b9yzXA/zC6RG4O/FFeaWpzXLiGBwF4F62FAIdd8ulmE6qJk9OStSwiViZa1qQjm6EbxVetx5dYI
	8pn0Qc8UP+eSbEJooBB9FDDbc4d8CLGJcySeZeGcBMFSyodeEySK0BJ8vqNg6pGoVyACmJiRn0p
	9fFlh+eUUXbxKLbHYn+3YbF5snojhCqgKwx1u0K2sesnuG0d7GdxIEIqIhOhpyiU=
X-Received: by 2002:a05:600c:468c:b0:46d:4f41:3704 with SMTP id 5b1f17b1804b1-46d4f41384dmr40724625e9.24.1758563943636;
        Mon, 22 Sep 2025 10:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoE/UaKLNkRz3YUEvL7yXGK4SAbmQlqVmH48OgbeeBRyoglBEIuVbqUV5YzWqsII28Z7eKwA==
X-Received: by 2002:a05:600c:468c:b0:46d:4f41:3704 with SMTP id 5b1f17b1804b1-46d4f41384dmr40724115e9.24.1758563943097;
        Mon, 22 Sep 2025 10:59:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2a:e200:f98f:8d71:83f:f88? (p200300d82f2ae200f98f8d71083f0f88.dip0.t-ipconnect.de. [2003:d8:2f2a:e200:f98f:8d71:83f:f88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461383b7b9csm253669505e9.2.2025.09.22.10.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 10:59:02 -0700 (PDT)
Message-ID: <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
Date: Mon, 22 Sep 2025 19:59:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
To: Catalin Marinas <catalin.marinas@arm.com>,
 Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 usamaarif642@gmail.com, yuzhao@google.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, voidice@gmail.com,
 Liam.Howlett@oracle.com, cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
 kaleshsingh@google.com, npache@redhat.com, riel@surriel.com,
 roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
 dev.jain@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, hughd@google.com, willy@infradead.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, qun-wei.lin@mediatek.com, Andrew.Yang@mediatek.com,
 casper.li@mediatek.com, chinwen.chang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-mm@kvack.org, ioworker0@gmail.com,
 stable@vger.kernel.org
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNGGUXLCn_bWlne5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.09.25 19:24, Catalin Marinas wrote:
> On Mon, Sep 22, 2025 at 10:14:58AM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When both THP and MTE are enabled, splitting a THP and replacing its
>> zero-filled subpages with the shared zeropage can cause MTE tag mismatch
>> faults in userspace.
>>
>> Remapping zero-filled subpages to the shared zeropage is unsafe, as the
>> zeropage has a fixed tag of zero, which may not match the tag expected by
>> the userspace pointer.
>>
>> KSM already avoids this problem by using memcmp_pages(), which on arm64
>> intentionally reports MTE-tagged pages as non-identical to prevent unsafe
>> merging.
>>
>> As suggested by David[1], this patch adopts the same pattern, replacing the
>> memchr_inv() byte-level check with a call to pages_identical(). This
>> leverages existing architecture-specific logic to determine if a page is
>> truly identical to the shared zeropage.
>>
>> Having both the THP shrinker and KSM rely on pages_identical() makes the
>> design more future-proof, IMO. Instead of handling quirks in generic code,
>> we just let the architecture decide what makes two pages identical.
>>
>> [1] https://lore.kernel.org/all/ca2106a3-4bb2-4457-81af-301fd99fbef4@redhat.com
>>
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
>> Closes: https://lore.kernel.org/all/a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com
>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> 
> Functionally, the patch looks fine, both with and without MTE.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 32e0ec2dde36..28d4b02a1aa5 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -4104,29 +4104,20 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
>>   static bool thp_underused(struct folio *folio)
>>   {
>>   	int num_zero_pages = 0, num_filled_pages = 0;
>> -	void *kaddr;
>>   	int i;
>>   
>>   	for (i = 0; i < folio_nr_pages(folio); i++) {
>> -		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
>> -		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
>> -			num_zero_pages++;
>> -			if (num_zero_pages > khugepaged_max_ptes_none) {
>> -				kunmap_local(kaddr);
>> +		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
>> +			if (++num_zero_pages > khugepaged_max_ptes_none)
>>   				return true;
> 
> I wonder what the overhead of doing a memcmp() vs memchr_inv() is. The
> former will need to read from two places. If it's noticeable, it would
> affect architectures that don't have an MTE equivalent.
> 
> Alternatively we could introduce something like folio_has_metadata()
> which on arm64 simply checks PG_mte_tagged.

We discussed something similar in the other thread (I suggested 
page_is_mergable()). I'd prefer to use pages_identical() for now, so we 
have the same logic here and in ksm code.

(this patch here almost looks like a cleanup :) )

If this becomes a problem, what we could do is in pages_identical() 
would be simply doing the memchr_inv() in case is_zero_pfn(). KSM might 
benefit from that as well when merging with the shared zeropage through 
try_to_merge_with_zero_page().

-- 
Cheers

David / dhildenb


