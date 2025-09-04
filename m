Return-Path: <linux-kernel+bounces-800600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5AB439B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935DC1B25460
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB02E2DC4;
	Thu,  4 Sep 2025 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deQJKgST"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD329B8E1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984624; cv=none; b=IwBQH3UiQUbPuuJRyp6Fssh/jAL2plOTN9vZsP10apMryPBp/YLPcc9+w3YYOZzgwg1UPJvKHJIbXA+CAolOyHpoKDJMIAmUqhIj1SWbbTMf0iENc2t3Z9K9/nl9GEV4rAMsypK7bWkRiE7aKQWV7EIlJh+my5OKR16I31P3nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984624; c=relaxed/simple;
	bh=WsLUEb1T+nYnrgVpUQhTFIOqErSDz9PfneZ0I0RRfrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0QKJLKQJ73KuAR/PxdH2ROEnJBH/ot3IEmWtgo7r9/stVg0BTp+5LFNATwf7Mncr9YJrBT6nPtQt5yZL6+WAFZlQVKQUSTkG6BFX+4Gmd99BpPIbFtb97tQ4NKuprF23M3Ij6Fdvd+XQ/S/ruwLG18+zC4iNIJcD8ETXED0FbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=deQJKgST; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756984621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s7d3QrGdbJp+/2V2GPguzX/iKX654TAzNMpDtBKIxPw=;
	b=deQJKgSTEE4USQdNiNYTN3dqTw9Bm5Pp83uTYsjQJu7cSwC0oawNwFd6vNwJh3ItjoyToi
	L9NYFIh4Egaz6fvD5PQO0GOFU33jvpNaKOSqDJtE8Ncj4eXnFbXzc1oKfNG4T1avL1tnaw
	20GM2NBMxdMNLw8VKog32GLHAWIkt48=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-kYTyebXOMkyL2vTrDz4VYw-1; Thu, 04 Sep 2025 07:17:00 -0400
X-MC-Unique: kYTyebXOMkyL2vTrDz4VYw-1
X-Mimecast-MFC-AGG-ID: kYTyebXOMkyL2vTrDz4VYw_1756984619
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45dcfc6558cso5784925e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756984619; x=1757589419;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7d3QrGdbJp+/2V2GPguzX/iKX654TAzNMpDtBKIxPw=;
        b=kf6JG90h2gCfqVCZ3QMRq6MKhSywIQeQrQkHSEC+ab/VsFiP8BTXJWHpthCRTwza8b
         8MHEJkc5fPL31QyMOKz0yQ0I/M9BsiEiMJ7U3w59JBf4+L4pOvEvRHcMT2McP7iNBwdV
         FC9YCAUzOtyLFIbsHwZaZ4jPs1fIqdIM2eJruYRE/KAYmgOgYAVi4Y9kkblIpBnEIUuY
         yWEcoeq1WQEJFPFbcZLDjxT2YlO8I0QIsZEMqm7bhIyFqFsCXaePzNjxYLfJQ+2VGiOP
         uEjdqArBFfWHI3lGxxB4usry35cFo2yg5HXfeaX8XU2dSzX7nFwjl9hyDqzJPocq9vuN
         SweA==
X-Gm-Message-State: AOJu0YxjSfn05FUZqNW1vH1L7v3fYDhT1Wx/NldY7eb+0Fzu8x0PInBw
	jDzJuYc/otSXQebxBFJgIJdRKIYt/T+aVuKFB+ob9dPeDYrbZyx+lKv4uWQr0zSYDMlWrhDiFMU
	8XQ9rnxitSK1121kx7kQFdMQU3DRbWYKczPCSoTmsnsDZg9uo7lJec5yjr9D2ehf/rw==
X-Gm-Gg: ASbGncsyZA6APxqnJ6z2DtYaSeKvTFR4Segrq1LWV0oh4jput7/y64eSXhYCOfIgdH/
	pM6Cb3RnXpPiRG+PUWaUD/haIusM5tol4V4W2zCsdozrQKi14h6lZSSQi44L12LDGoQteJcKGSi
	d40ywCc0n8JP5/c9ZcjLLsfDR6yNRQh8SJqI+3K8haTWzq0y/Yzgj8Y5SGlExoisnzzzo3o9Uj3
	4SYWZcob+epNq/mYfnTSjT8zbvy/3TwRMyfj/xpVgNHwB7UxwKjbqPb8Pc3DHPwkUePwkl6I1Cc
	1G5QGrpnBJqYHMByrCjEhmnF6t+CjLq5u6eYAno2DTb8haHY1jCQ3lXSPF/K96fsNWSRSzAGnN3
	ZUDHbMzCilOjHlpIQUO7QxGf61doDUQvMILhUCTLTKVDz0S9d7xB4YCRaSA/XZpNe
X-Received: by 2002:a05:600c:46c8:b0:45b:7e6b:c235 with SMTP id 5b1f17b1804b1-45b85533095mr162326245e9.9.1756984619196;
        Thu, 04 Sep 2025 04:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx751BiMLQs/FNMfN6KJoTuC8FPL2UJjSm5CNJuLuA/Pa37blHAWbSxjxwgfN/PV3xa30Lsg==
X-Received: by 2002:a05:600c:46c8:b0:45b:7e6b:c235 with SMTP id 5b1f17b1804b1-45b85533095mr162325995e9.9.1756984618777;
        Thu, 04 Sep 2025 04:16:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a32dbc5sm24550519f8f.11.2025.09.04.04.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 04:16:58 -0700 (PDT)
Message-ID: <c6780d87-1d0c-4075-b351-40f3c8f6e4b1@redhat.com>
Date: Thu, 4 Sep 2025 13:16:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fork: simplify overcomplicated if conditions
To: Joey Pabalinas <joeypabalinas@gmail.com>,
 Kiryl Shutsemau <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Kees Cook <kees@kernel.org>
References: <357638f71edc7f1d9814b1851a64e09a8895bffc.1756968204.git.joeypabalinas@gmail.com>
 <tzjq757k4tt7k2mkcapttjuax6zgzr3nl7ivusuvxfmok5kvb4@vub2gw7vp7vu>
 <ka3dhrfkc42ydbiiqa4ygr545ndydcpekjco36sdwf2nypuy33@vpsgevacmzjv>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <ka3dhrfkc42ydbiiqa4ygr545ndydcpekjco36sdwf2nypuy33@vpsgevacmzjv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.09.25 12:04, Joey Pabalinas wrote:
> On Thu, Sep 04, 2025 at 10:56:44AM +0100, Kiryl Shutsemau wrote:
>> On Wed, Sep 03, 2025 at 08:46:29PM -1000, Joey Pabalinas wrote:
>>> Since `((a & (b|c)) == (b|c))` is the same thing as `(a & (b|c))`, use
>>> the second version which is simpler.
>>
>> Huh? No it is not the same thing.
>>
>> a = 1;
>> b = 1;
>> c = 2;
>>
>> (a & (b|c)) is 1 which is true.
>> ((a & (b|c)) == (b|c)) is false.
> 
> Ah, you are right. My mistake.

I suspect you didn't even test that patch?

Please do us all a favor and don't send any more such patches.

-- 
Cheers

David / dhildenb


