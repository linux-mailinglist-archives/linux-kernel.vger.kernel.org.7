Return-Path: <linux-kernel+bounces-772187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D43B28FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03486AE337B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B72F8BE0;
	Sat, 16 Aug 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5rcNgra"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2DF1DB13A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755363852; cv=none; b=PL0OUS1Esxkym5bOyyN7RNItMfHoZOEX5pZdrahnyUzT54nC8NgWknBRxTr2I80vMx8DrRZN+zvhA+r29TOSd6JzCO0taW+ijAyhMi3hdfRc04Z5vJ0kEZ6SOOZr+pu1wC56FBEFiwrI2TcLyCtZyiSsL7Qc4+njEuBpaSM8V4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755363852; c=relaxed/simple;
	bh=TG3Jt/7V+yOc1IhxiSM4dKHPX2ZlN9fdEf0yfPnjr/w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lAmGWz2lrYFbkpThuACVWHUhV+D5LVfGatg5oELVYGYPFqGdX2R5UtDSLkQ+k82kX+E/Sx23e+8GYOJSCy8AsNV609Ri76cb2O7j4Qv4BSANErPoab9lG0XM8vyjtSznv3Qmve/QILklTzZKzoRc9ayfhfg9Sr+9MQG/v8T3FWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5rcNgra; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755363849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4Vdzv3DmlnaOpYN+0D5wTRGqHnadxEawRnToIYrOHH0=;
	b=B5rcNgrakPzhoL+BCyp6Qx9sDFiB/nr0sBwqLkDe8vHEYXmJLLPF90xbidiiMgC1nosmtB
	AhiaLxq+jyY45Z/y6Vueb78HHktqy1A00P2l3BWSMUKpbXbFo3mXper2YOI37RqtPmJCRr
	B+HwIQYrVeYQDOg09u9J6r7OcqM1a0s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-xMwwh_jcMVmclx_pc7H-zg-1; Sat, 16 Aug 2025 13:04:06 -0400
X-MC-Unique: xMwwh_jcMVmclx_pc7H-zg-1
X-Mimecast-MFC-AGG-ID: xMwwh_jcMVmclx_pc7H-zg_1755363845
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e87031d3e5so716245485a.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755363845; x=1755968645;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Vdzv3DmlnaOpYN+0D5wTRGqHnadxEawRnToIYrOHH0=;
        b=UbOROH0bUW6aHDZkNZb5JrzyQE+nTnMCm/x2o+GCqQiOQoDRqPr9XWLyZdJerbEFE8
         mXKiyxkUuOE/6kJyQMOHBUhZz06G6NoNEHC0tUz/8Xi+E2xhw87uwGQ/JZrh6WxJ+FJz
         Tl/V2tQZMKyV14J6CgJFEYoSKSS+7gypoUNkYxvOz0CwPPubpkGhkyjPTDyC6St59fsn
         mjaUWbc/z442m3yPkM97Y9ZYZlgFDja28NQaI8DKpwh2E66kEGPJxr4F709iONG3tZAc
         EHnF3+pbT5MlP1hNK7Bb4KV943cYrye6L8Xa+8BzIvt1ZM+/jbD7C50iZ04SflwPwjFc
         E8NA==
X-Forwarded-Encrypted: i=1; AJvYcCXLG7AL0D17Bq2/pdpgfRpfqlvFFRrPhxeYxD1mb5Er3FhtMjeXD/GO5B0PzdAF4qE9XS4LFOkODNLgLt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNIA0TM02+Dr4vzFnwtPybU3IjM4Yn7y0Gm/4Vjj4VzcMLzYT1
	l+ZKt+8pVSJ4Mb2wcqENs8nAFM5Grf/gvO1Y5KJ5qJSwIgFAYHdpZTZLiuwndIJs+l4IR9E4E8Y
	P4nZafbRVsJWLerBuXx+3vBN5bLZl3Y6XmUNCAiuTsjKYbalsHWELbES/fuTqFu61wg==
X-Gm-Gg: ASbGncsKZnGzeX5feMpym9RKywG4dkv8Mi3nbzoUVv5+QbDW8iuIBsBAnZATd+eASM1
	n7iWhQVeMLjM2XfNIzLAXDBz7IeH4EibNQYEUbt0YimdY7iMo1XUJs6eL6lJ6hmKGRJ/d35uABG
	fe2/zlzlfGurwe4Z9FDeOXxEbd4H6xxE2tNSVkwbK2zKO9XCUgzEt1ntpeEre1YnlVjBs6QU/jM
	1WnljPJ6p3M/MPjUHmTlhHcvJZnaXZoY5kzO3DYsWLMxwuXot7EHiG8QJ9VeHFDjXN2LAUpa1lP
	/o30+HHJcGxZ4XJxv7hr/79h/q/TUt8LCGE4BxoUG66fRCBAa9cRgDjFGkYSaLFLttdNx+TU9eG
	Tnqjp6ZRCEZKq2VEl2w0rB54CXep3n8ZEyoA8j2tuDEfkFl/oJRi83LYXBvScXK8u+gs=
X-Received: by 2002:a05:620a:319c:b0:7e6:3f78:8f08 with SMTP id af79cd13be357-7e88688587fmr514791385a.60.1755363845427;
        Sat, 16 Aug 2025 10:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNaUZO42WuGpZxpSuCZqndfUjaEylzUym4Cf72hFk1jzKC0ptFmeGKh1sj47e4Q0dIMo8G4g==
X-Received: by 2002:a05:620a:319c:b0:7e6:3f78:8f08 with SMTP id af79cd13be357-7e88688587fmr514786285a.60.1755363845013;
        Sat, 16 Aug 2025 10:04:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1e5a7bsm290177485a.75.2025.08.16.10.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 10:04:04 -0700 (PDT)
Message-ID: <07b17e1c-92e6-432a-9af6-13d3fc8246bc@redhat.com>
Date: Sat, 16 Aug 2025 19:04:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
From: David Hildenbrand <david@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Huacai Chen
 <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250815090539.1578484-1-chenhuacai@loongson.cn>
 <a20d605c-79a0-4d89-985b-9512a990b492@redhat.com>
 <CAAhV-H470h2HDEN_NY2qNBxUqQrSRQhLzwqZe9PB8GjnNsZVFQ@mail.gmail.com>
 <66ebc632-6704-4637-b62d-1cb11e5a4782@redhat.com>
 <9db98f7f-b90f-464b-ae7f-e94ac523bc28@redhat.com>
 <aKCwjCJTEhX4Q6wW@casper.infradead.org>
 <e06f23d9-adcf-4d0a-8ba1-bda6d4b483b1@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <e06f23d9-adcf-4d0a-8ba1-bda6d4b483b1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.25 19:02, David Hildenbrand wrote:
> On 16.08.25 18:23, Matthew Wilcox wrote:
>> On Sat, Aug 16, 2025 at 12:54:52PM +0200, David Hildenbrand wrote:
>>> +++ b/mm/balloon_compaction.c
>>> @@ -256,8 +256,10 @@ const struct movable_operations balloon_mops = {
>>>    static int __init balloon_init(void)
>>>    {
>>> -	movable_ops[MOVABLE_BALLOON] = &balloon_mops;
>>> -	return 0;
>>> +	int rc;
>>> +
>>> +	rc = register_movable_ops(&balloon_mops, PGTY_offline);
>>> +	return rc;
>>
>> Using 'rc' as the name of this variable is an anti-pattern.  All it
>> tells you is "this is the return value".  Calling it 'err' is far
>> better because now we know it's an error number (or zero for success,
>> of course).
> 
> I know, we all have our things to complain about. Some about Cc: above
> --, others about the name of error variables :P
> 
> $ git grep "int rc" | wc -l
> 12730
> $ git grep "int ret" | wc -l
> 80386
> $ git grep "int error" | wc -l
> 4349
> $ git grep "int err " | wc -l
> 6117
> 
>>
>> It seems to be a particularly IBM derived antipattern ;-)
> 
> Careful miser :D

"mister". No idea if "miser" exist and if so, whether it could be 
considered offensive ;)

-- 
Cheers

David / dhildenb


