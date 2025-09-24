Return-Path: <linux-kernel+bounces-830946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F42B9AF92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733F3169347
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA95E3115AF;
	Wed, 24 Sep 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bN/DBDcz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A826E311596
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733568; cv=none; b=UavtqIhGe/WerR/abIN7ySat/c1bIKZIaN7ukbPUUlSFZ02OpkctbmZJTPZMbns8fVbNju7935yS8syQ4Hoq89/6FNlAhc5SR+HBpTniHdqhNDC7AXNnSL58gO/fprJ+y8lv62Xc6FzQRcw3jKQ3qqBQDBF9gWTJyKdvhkNwPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733568; c=relaxed/simple;
	bh=ENC0tIbBcEsxxiCkuhYlzl1GTTO9qN+D02vbreZ3950=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDBMkRS7fUW2DXr6LfYcvqrv0/h+nQ6UfOoOobbDiDIwm5hCyQx6At1+dzGoBPRn8v8DrSB9Uq21dEmbMHhZY2WX9/TasG3/Vz8GELoYBhlJGko8tQtLhanEiTv8IOfgRFEO9Km8RmJACZC/ayzVJXniS92RPsNDw3oSLelBTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bN/DBDcz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758733562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gDng6eTC/50ODCGQBWOqYwAMIQif6a+HS5dFEqQoJ4Q=;
	b=bN/DBDczd4+owWRabjKVOie7OsGUzU71Qg0ANPR7a2Iw98ZgWCUem81bjS9R+3rBsgAv2r
	qz3KcXde4KwJy5oW4XDBujIcy2Xf0/B+UnLkog2oUJnxruNPlJ0TNevRoqpclS58V5p6Mz
	mB46CzkqLpFAgXGZZ1H4T7ZP5dpQGhg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-EycEOqI2NgmGnV1npQuSFw-1; Wed, 24 Sep 2025 13:05:59 -0400
X-MC-Unique: EycEOqI2NgmGnV1npQuSFw-1
X-Mimecast-MFC-AGG-ID: EycEOqI2NgmGnV1npQuSFw_1758733557
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46dee484548so100485e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733556; x=1759338356;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDng6eTC/50ODCGQBWOqYwAMIQif6a+HS5dFEqQoJ4Q=;
        b=DtFmjWqHwDXqjXZnslAI8fSCwL4/89yGTX8FLClAzWWq8bb7Mjity3dgxS6BugW07q
         whm3VKHoAw0pQV1oFHJSpCpkK8DUxngnSuHQhJiXJ5INhFkPOj4JzIOk3XwG2dV9soab
         186Agkb4Sc9P2bghFlJYzq3gPTi2NrsMMYfUyT0NrZnq/uNhNB3mU7K1CXlOJCS+Ho8h
         PeHFcDeEWxvxljKgoOcU1gzmxUMSWuPZpouNTvNcyRO/mS6v2YpZEEizaor191IZHhu3
         Va4MwTx0/zd9/KTccWqhAFSSvrprXN/WWexKsfR4HbiXku/mkSLykFx5X1JxZDSwz5mK
         5sRw==
X-Forwarded-Encrypted: i=1; AJvYcCUukqxIdjXYKVk1eS4W6MU6Q+SpiDXS7ryJozjAdQZTP1botUMmVF8OCvdn7ZFyzSJV/mCkhGJAjlFG/Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmtX+hp+cPWGkZrMBRTrMe6BGIqeSH7dPdEXMwugWC9ps+x3LP
	RM9Q7I1j+Qmz6ayFM+fkI16f1YXnl0A0LY7ILuaPGydGSSUrhy/qRXD4sDMWBx2fWaw9g49urIQ
	9/IJR60r+ZwzkFSEVpQ5srQ4M5z4qfvKm737vJRXB38sFe5jXiv3nVLXN8UiSGu7cnj43O62YdG
	zF
X-Gm-Gg: ASbGncvTkEklhUK8vjo0cOioXKnkHOpOZD9J0nw59fytGmm/m4b8k1TRO3HhsEfnimw
	5EfOv7rviHOtCE+BSAWsusYc50+PXwfsCD1DKn46QVCQM5Ss4LzeAfIMy6fSA1fu68Qu0XEndnr
	1/FfCwMlODO1K+Xfkw9M5ImgXHEWk5qJYLovQntBDQBVdyf/tsxx5ASYz5mnB0MW5y6ow8z0Hp4
	bGxD2MNptOvhZIPMfNaEFWyQ7YBO4EFo0a8Lh63Iqxp8JgZcKayLSaH6lPAXUtW3bLEJ1KNBkcA
	2ijO2C5VFjpeZBtPWLd5kSlelwsHrdl8eKbYLQ7LbLCSlhlm2Kp/Bz4KfoCsxpN+KvL0n2gq3Wj
	VeKi2Or1F8oFgH2CVNb5lDqAnXvpnwEPvxEsILRpNcIG2tfAcW/2Qlge24Zro+dDiiw==
X-Received: by 2002:a05:600c:a01:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-46e3299ed75mr7553965e9.5.1758733556571;
        Wed, 24 Sep 2025 10:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQQ/c5CHHYeXnXbXM85BLoItT272YRWfgKDNPvYG9xrftCMnPW5ERT86Mv9UcXuEUMFv/tEw==
X-Received: by 2002:a05:600c:a01:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-46e3299ed75mr7553545e9.5.1758733556170;
        Wed, 24 Sep 2025 10:05:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32c10823sm1255775e9.3.2025.09.24.10.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 10:05:55 -0700 (PDT)
Message-ID: <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
Date: Wed, 24 Sep 2025 19:05:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: Zi Yan <ziy@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linmiaohe@huawei.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nao.horiguchi@gmail.com,
 syzkaller-bugs@googlegroups.com
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
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
In-Reply-To: <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>>>
>>> What I can think of is:
>>> 0. split code always does a split to allowed minimal order,
>>>      namely max(fs_min_order, order_from_caller);
>>
>> Wouldn't max mean "allowed maximum order" ?
>>
>> I guess what you mean is "split to this order or smaller" -- min?
> 
> But LBS imposes a fs_min_order that is not 0. When a caller asks
> to split to 0, folio split code needs to use fs_min_order instead of 0.
> Thus the max.

I'd say, the point is that if someone wants to split to 0 but that is 
impossible, then we should fail :)

> 
>>
>>> 1. if split order cannot reach to order_from_caller, it just return fails,
>>>      so most of the caller will know about it;
>>
>> Yes, I think this would be the case here: if we cannot split to order-0, we can just fail right away.
>>
>>> 2. for LBS code, when it sees a split failure, it should check the resulting
>>>      folio order against fs min_order. If the orders match, it regards it as
>>>      a success.
>>>
>>> At least, most of the code does not need to be LBS aware. WDYT?
>>
>> Is my understand correct that it's either that the caller wants to
>>
>> (a) Split to order-0 -- no larger folio afterwards.
>>
>> (b) Split to smallest order possible, which might be the mapping min order.
> 
> Right. IIRC, most of callers are (a), since folio split was originally
> called by code that cannot handle THPs (now large folios). For (b),
> I actually wonder if there exists such a caller.
> 
>> If so, we could keep the interface simpler than allowing to specify arbitrary orders as request.
> 
> We might just need (a), since there is no caller of (b) in kernel, except
> split_folio_to_order() is used for testing. There might be future uses
> when kernel wants to convert from THP to mTHP, but it seems that we are
> not there yet.
> 

Even better, then maybe selected interfaces could just fail if the 
min-order contradicts with the request to split to a non-larger 
(order-0) folio.

> 
> 
> +Luis and Pankaj for their opinions on how LBS is going to use split folio
> to any order.
> 
> Hi Luis and Pankaj,
> 
> It seems that bumping split folio order from 0 to mapping_min_folio_order()
> instead of simply failing the split folio call gives surprises to some
> callers and causes issues like the one reported by this email. I cannot think
> of any situation where failing a folio split does not work. If LBS code
> wants to split, it should supply mapping_min_folio_order(), right? Does
> such caller exist?
> 
> Thanks.
> 
> 
> Best Regards,
> Yan, Zi
> 


-- 
Cheers

David / dhildenb


