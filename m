Return-Path: <linux-kernel+bounces-753370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7CB181FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6C84E7814
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CAF24728A;
	Fri,  1 Aug 2025 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6Nr6og6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3073137923
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754052804; cv=none; b=qIK/CNxtUlv7QwywtyDXG+RAkXHb6/jwzDHHBIZcbLkXLSTJsaR2rz7Sl1kEgd5S12Bkbv4oYhs3qoNBZJrqoGpBqZvnbVoz+kS52K+ra4Qgt+sRv08dT/C2mvmWtR3zJE+wF2+owFAnjF/TwOUvbWoofkozRd3bwfznR2DqWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754052804; c=relaxed/simple;
	bh=aH7oGvLM6qjD1D4LjlsahaN0JbiUXKD9cVat+vL0Hro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCqLxBNebJS6Fjg8gcWeXiQHbZCz+12RfXMM3R4g4bCNoUEnckNc2bxVZ1DSmhyD/AnLHo1eDF6pIuxZnrD4zKzN/OtygXeqvbxfkhCI+kSgFm/sbY19NeVS0DzdcKA3AgnplS0FJdEl2ullW5WTkU1vH7ezc8Z2TOv2MVaEYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6Nr6og6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754052801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h3ruNDNlPjMbrJaLbLdhknmMkmPcPZs8o/QuFn2NwxE=;
	b=H6Nr6og6YmFWQMwJ5gVzWly92bsTpp5UXTmgfl+OTay177QxFKZDygEoT4mxjtukwR4qdc
	oCoDFhH5GevqD+gnDDXryJA+xcuBYJ4sPr0bJxxSgm7ZR7Nyyl7paox+En4WaZOGQ1Cu+Z
	FH0qnSvOXBwREluRjZ1dJizUAJTtSv0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-BItBGz3aPMC10fz_ZfxuOw-1; Fri, 01 Aug 2025 08:53:20 -0400
X-MC-Unique: BItBGz3aPMC10fz_ZfxuOw-1
X-Mimecast-MFC-AGG-ID: BItBGz3aPMC10fz_ZfxuOw_1754052799
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45867ac308dso4572545e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 05:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754052799; x=1754657599;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h3ruNDNlPjMbrJaLbLdhknmMkmPcPZs8o/QuFn2NwxE=;
        b=IlTlILeqnR1Ztqp19APW9U6yTazTYA+1U2TjvIaEeCHzqnfRVQs73N7n43khBsnE1a
         crKys9uismKk1cQQKhbymrT6mxP5zTPLXb1pQlClo0AiT582H11fycrOwi/js6WcCbh5
         N+1iPo5b1ndZgtndAVvYvwOxCaP+IvfAKvFZGPykMfiYOVd/qVFvFgpQYiNxcqVMT6Yn
         qXn3gnCr45LCcfxO/BzYIQmMEONidXCeBRGTCoAU9WqlwqHMsQJk0uxl3xN+UrUhmgAZ
         WzH3YjWHt9/ZnA6trTA/s2zazEq8LPOBgZFI+aql6ui/Ixw63h5VeVDdrlvlI1MHeHd4
         YZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCW8NsFopiyLtB2zhyAldf3lhC8mljEXdEq75XA2zQwmWLaLfMcbJpxned/4hdgsdO7/9OHc3JjVewLlGiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiQ+TyW8d7LpFpddZSPZ5iVT+MgW/kvpqWhOkACFWtijd97Y2
	7xJmeRyUQAGaEl2FqNvVjog8qw2eiCE10smWlv6jMUPamiPzvdeFQ5KNbcbrrN06ltNm13pJobi
	3pwKBWeu31v3+dNfKYXsiuUCRi0c73aLI47bMY3tCS+uLUGDkTX9T1uqCfPKDNVITfA==
X-Gm-Gg: ASbGncvXHcdx4pKSj1zI+z2hW8UorDPlNijxwFWIeOrAfLjugJLvLAi2qcUwVbWwi78
	sf91dozq26O681Q9zkHOnK/P3RudTSd7FcGFUB3nhp/oGGneIHahhJtxLVs1QMwI5qzTxY0LK30
	mDPKdO91mXv/1p0WEzWKr2CmhSyykiMKNntDpFvOM2m6ZK2MtmToUEPR828ueWlQ01CgApF4ey8
	zl6Ia6RcrJv8/v5B3v1Fpi6vyeETkdm17rVmkjDuBBeGZK12PXVG81EObvk2dUyYOde57F21Zhj
	pupMnM0LMahhRtUF1cdnC8YGs1MWZQ/AT89oTtosvilg/mKGJCTFWg8gHdMWJFD0+GFq35NVfrH
	o6iAnEXVi5cEvfCMdD1f0ezk0wJocR0aNbNfYYVVVesUGNC6ebw4vnJECo9EqDi1R
X-Received: by 2002:a05:600c:8b6e:b0:456:27a4:50ad with SMTP id 5b1f17b1804b1-45892be4bf9mr87196525e9.33.1754052799241;
        Fri, 01 Aug 2025 05:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdOjdW1qaq63aXhEjK0A1+Z+TR4so0aHNv+en625bxoCoFF4KP1QmdOz4NRJh+MBuuVmlFrA==
X-Received: by 2002:a05:600c:8b6e:b0:456:27a4:50ad with SMTP id 5b1f17b1804b1-45892be4bf9mr87196295e9.33.1754052798771;
        Fri, 01 Aug 2025 05:53:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458a99ce1d2sm26772525e9.23.2025.08.01.05.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 05:53:17 -0700 (PDT)
Message-ID: <8ba84519-7e69-4058-9ac1-d3e2e622a6ab@redhat.com>
Date: Fri, 1 Aug 2025 14:53:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] selftests: prctl: introduce tests for disabling
 THPs completely
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-5-usamaarif642@gmail.com>
 <7b13d8b5-a534-47f8-b6c5-09a65bffc691@redhat.com>
 <22e263a3-a1d2-4159-b3c8-44f7a29bace9@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmgsLPQFCRvGjuMACgkQTd4Q
 9wD/g1o0bxAAqYC7gTyGj5rZwvy1VesF6YoQncH0yI79lvXUYOX+Nngko4v4dTlOQvrd/vhb
 02e9FtpA1CxgwdgIPFKIuXvdSyXAp0xXuIuRPQYbgNriQFkaBlHe9mSf8O09J3SCVa/5ezKM
 OLW/OONSV/Fr2VI1wxAYj3/Rb+U6rpzqIQ3Uh/5Rjmla6pTl7Z9/o1zKlVOX1SxVGSrlXhqt
 kwdbjdj/csSzoAbUF/duDuhyEl11/xStm/lBMzVuf3ZhV5SSgLAflLBo4l6mR5RolpPv5wad
 GpYS/hm7HsmEA0PBAPNb5DvZQ7vNaX23FlgylSXyv72UVsObHsu6pT4sfoxvJ5nJxvzGi69U
 s1uryvlAfS6E+D5ULrV35taTwSpcBAh0/RqRbV0mTc57vvAoXofBDcs3Z30IReFS34QSpjvl
 Hxbe7itHGuuhEVM1qmq2U72ezOQ7MzADbwCtn+yGeISQqeFn9QMAZVAkXsc9Wp0SW/WQKb76
 FkSRalBZcc2vXM0VqhFVzTb6iNqYXqVKyuPKwhBunhTt6XnIfhpRgqveCPNIasSX05VQR6/a
 OBHZX3seTikp7A1z9iZIsdtJxB88dGkpeMj6qJ5RLzUsPUVPodEcz1B5aTEbYK6428H8MeLq
 NFPwmknOlDzQNC6RND8Ez7YEhzqvw7263MojcmmPcLelYbfOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaCwtJQUJG8aPFAAKCRBN3hD3AP+DWlDnD/4k2TW+HyOOOePVm23F5HOhNNd7nNv3
 Vq2cLcW1DteHUdxMO0X+zqrKDHI5hgnE/E2QH9jyV8mB8l/ndElobciaJcbl1cM43vVzPIWn
 01vW62oxUNtEvzLLxGLPTrnMxWdZgxr7ACCWKUnMGE2E8eca0cT2pnIJoQRz242xqe/nYxBB
 /BAK+dsxHIfcQzl88G83oaO7vb7s/cWMYRKOg+WIgp0MJ8DO2IU5JmUtyJB+V3YzzM4cMic3
 bNn8nHjTWw/9+QQ5vg3TXHZ5XMu9mtfw2La3bHJ6AybL0DvEkdGxk6YHqJVEukciLMWDWqQQ
 RtbBhqcprgUxipNvdn9KwNpGciM+hNtM9kf9gt0fjv79l/FiSw6KbCPX9b636GzgNy0Ev2UV
 m00EtcpRXXMlEpbP4V947ufWVK2Mz7RFUfU4+ETDd1scMQDHzrXItryHLZWhopPI4Z+ps0rB
 CQHfSpl+wG4XbJJu1D8/Ww3FsO42TMFrNr2/cmqwuUZ0a0uxrpkNYrsGjkEu7a+9MheyTzcm
 vyU2knz5/stkTN2LKz5REqOe24oRnypjpAfaoxRYXs+F8wml519InWlwCra49IUSxD1hXPxO
 WBe5lqcozu9LpNDH/brVSzHCSb7vjNGvvSVESDuoiHK8gNlf0v+epy5WYd7CGAgODPvDShGN
 g3eXuA==
Organization: Red Hat
In-Reply-To: <22e263a3-a1d2-4159-b3c8-44f7a29bace9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> +
>>> +struct test_results {
>>> +    int prctl_get_thp_disable;
>>
>> The result is always one, does that here make sense?
> 
> Its 3 in the next patch for PR_THP_DISABLE_EXCEPT_ADVISED :)
> 
> I will remove this struct, but I think maybe it might have been a good idea to squash this
> with the next patch to show why the struct was useful.

I think it's reasonable to keep them separate.

> 
>>
>>> +    int prctl_applied_collapse_none;
>>
>> "prctl_applied" is a bit confusing. And most of these always have the same value.
>>
>> Can't we special case the remaining two cases on the current policy and avoid this struct compeltely?
>>
> 
> The values are different in the next patch when PR_THP_DISABLE_EXCEPT_ADVISED is used.
> 
> Just to explain how I came about using this struct test_results (though it doesnt matter as
> I will remove it for the next revision):
> I wanted to maximise code reuse and only wanted to have one instance of prctl_thp_disable_test.
> I actually started with special casing, but went the brute force way of adding too many if else
> statements and it was looking quite messy after I added the tests for PR_THP_DISABLE_EXCEPT_ADVISED.
> I saw this struct test_results in another kselftest and thought this should make it much better and
> extendable.
> 
> I have removed struct test_results and changed prctl_thp_disable_test to the following for next revision:

Yeah, or just duplicate that function and call it 
prctl_thp_disable_unless_advised_test() in the next patch.

Makes the code easier to read and the duplication is limited.

-- 
Cheers,

David / dhildenb


