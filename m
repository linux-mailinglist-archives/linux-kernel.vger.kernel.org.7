Return-Path: <linux-kernel+bounces-788248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446FB381CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCFD2061D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4A2F83B1;
	Wed, 27 Aug 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wx5o7ttt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98952F0C66
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295779; cv=none; b=aEima4k7ORhRk+okfku+qYHswY9sM9g1eV0vMmnzjLxomG3W1Rwst6mF9N7k1OFRfBdQj46vM0iZBygDYp0gPTZTD04y428jSJnRn4arc5gX+vBUTQBwe7fgHbWdPDtrczOhg4e4bx+kbb12vmEF/qEtoGXVUxxTSYlN2jRLT44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295779; c=relaxed/simple;
	bh=qWNuJq1pI1gUfa8dF93j+5XqoglzDjHXlUFmD/BAW/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv07fp878IguGgnL5DY7WyEd1BsM0cZOgg5l7m9Nh0SG7LZRjmJQ948k74sJd/mVky/QwlQiETv0Q0iV1ePobYDTZuLLMObHDuWbyV+Yd/jgmnHpedrVQsH+hTiEoQZTFnH8SFUJ4H6iJ4j+ihif+tcxPEuWkv9vducrpsyT65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wx5o7ttt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756295776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UcP+MKIMKTIXme29nP4iQa3HplkH4GbIfVhPmf/w8b4=;
	b=Wx5o7ttt0tnBE5qCgHCWUMS3bD3hOqWmkbUcayrQlqqcsFHXB/3l/wNT8rUELLpbEXSank
	NnOEikjS2mJ8HML4mPJfzMV4WE4+yAJYw56tacBL8cx9CXmKJWs/cbrE44H3w2J2EltnkJ
	snn4+gwogqdUxi5WAzqMn7gq6xTz/lo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-BMnZbrdSPJynBh2Q9leoCg-1; Wed, 27 Aug 2025 07:56:15 -0400
X-MC-Unique: BMnZbrdSPJynBh2Q9leoCg-1
X-Mimecast-MFC-AGG-ID: BMnZbrdSPJynBh2Q9leoCg_1756295774
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70ddd80d02fso9987586d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756295774; x=1756900574;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcP+MKIMKTIXme29nP4iQa3HplkH4GbIfVhPmf/w8b4=;
        b=RPt/MJNBh353ZgJqe3CiKUf3I0mlvlJQ28s7twFQDQxkWCv3IGNFvqMhCThgVPyeJX
         7BVQA2kC5UaqZN6ZQql2x3o1F+I1NcbnYt2OW0d1ijob4q/4227yw45X6j6PijYtobOi
         IkPE9/siZ0/4CkLPCBAZaZkKl1BGvl3WV+mdd++O4qB1O2OC9uddAmy6ZvQACKRzxW1p
         4V9ZLP2Dsg3NvjpRVxWW9XClpIyu0LunWAxHz8zFUPSjYjPDwURWyrXLJAEIdUtMf1hB
         /ukvWwztvR33oGjNhbg8CmQ0VunCNVCd2c1mQuJlWyLKvA56ISRDXu1RBEgOOKkv6ZeH
         QEUA==
X-Forwarded-Encrypted: i=1; AJvYcCU1v7aBTN3NcTN7RehEY3W/dRPI49v1HsRVW6IYDA1PvUiWRW/hlcun+vvoHLj0557NxlVQt9w3ozjCXvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbkQ+XSkkNQYFd764E6S4OTirw/suche1215kjPHN/PBmWEdyV
	kpi00lT9SSc0/mZ1n+i3ykMWI/N36McuCjRgOMMjG1rog31Pmdkk101+mfak759Dpcm8afzUR1s
	jYfLmL8EMwX32M4WM7cfvAB6co7yRuEG94H7ElXM4vvEHrHwzGhBEJRPxuwfQ3LRQFg==
X-Gm-Gg: ASbGncsLexyPfYyDiAt5b634ym3bY82WxCM6WqRXmsmjZrLVNq0Egbu40gCcXqStFHr
	h3nWkd9VSma9TaOAKwA7R3r0RRcwIKwjWod9CAIqX0yGxn+IgkVR4pif1rzedBkhyojavC+z75E
	rVcpk5PPo0w3K9AiZCKB+eIWRTb0vMYH+H3i5iDhReDDutXeCl1xgLMGZGRu6g34lIGcw9GRQRd
	8JtCA4UobImO5T3Du749O7te0f6/AyLalU0GHhOwh9Wdnlq/jIZDg/yC3Y76kCs8PKVPLJ1OMbs
	+CgFSrlbsi1XJQlsR0/FFZsP2VnOzuoW9a7kWcTRcDXoKSRqtCje0CiIKtMKnQ==
X-Received: by 2002:a05:6214:1d09:b0:70d:b0d3:e50c with SMTP id 6a1803df08f44-70db0d3f0b8mr164309576d6.3.1756295773992;
        Wed, 27 Aug 2025 04:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP+7/f9Dza6Dboh0+crUGjlYh2k6wyTyltwaqvnIJ5dLoNHOMhcL4Qv2lqiKTxRR93kuSh9A==
X-Received: by 2002:a05:6214:1d09:b0:70d:b0d3:e50c with SMTP id 6a1803df08f44-70db0d3f0b8mr164309146d6.3.1756295773424;
        Wed, 27 Aug 2025 04:56:13 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da717df65sm81671596d6.30.2025.08.27.04.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 04:56:12 -0700 (PDT)
Message-ID: <11a5d391-3a13-4376-98f1-34b529d3c583@redhat.com>
Date: Wed, 27 Aug 2025 13:56:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] huge_mm.h: is_huge_zero_folio(NULL) should return
 false
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, shikemeng@huaweicloud.com, kasong@tencent.com,
 nphamcs@gmail.com, bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250826231626.218675-1-max.kellermann@ionos.com>
 <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
 <CAKPOu+9wz9g0VuYDPiNDYdaGG-gdK86h1gGSCmVPsC2a5f-GPA@mail.gmail.com>
 <e5783c3d-7eeb-41d9-9fe7-730155f9bf17@redhat.com>
 <CAKPOu+_8_gfko=Sh-YKpbgcMy0aJB=m9yrC5JJKEZm=yeYPOgA@mail.gmail.com>
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
In-Reply-To: <CAKPOu+_8_gfko=Sh-YKpbgcMy0aJB=m9yrC5JJKEZm=yeYPOgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.08.25 12:13, Max Kellermann wrote:
> On Wed, Aug 27, 2025 at 11:36 AM David Hildenbrand <david@redhat.com> wrote:
>> Why should it be allowed to pass in garbage (folio == NULL) into a
>> function that operates on valid folios?
> 
> This patch isn't about the function parameter but about the global
> variable being NULL.
> (Don't mix up with my other patch.)

Huh?

"Calling is_huge_zero_folio(NULL) should not be legal - it makes no
sense, and a different (theoretical) implementation may dereference
the pointer."

And then

"But currently, lacking any explicit documentation, this
call is legal."

No. It isn't. It never was.

-- 
Cheers

David / dhildenb


