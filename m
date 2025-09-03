Return-Path: <linux-kernel+bounces-797912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB80B4171A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC2818858F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70362D8387;
	Wed,  3 Sep 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWtjDNvd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D492D8385
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885611; cv=none; b=iu8ZIcihihOXexINm1ZevzoY9beJCrqDaHCGzhfYCF1NK8oc41kspVhSAE8SWj2GEzH4scI1DgzwffgS8fYV16K8tNhbsOt9t2ic0kYRmYT/2aZl3n4adz1rgp3DuX/x+0TY1jsCRGauc6OCURfhyUNGl8IqCv1OsWDOEXXc70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885611; c=relaxed/simple;
	bh=VohJYPQSn/qDfeZzY91QyNv1p6HI9UaC6T22BC67i5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmyOUpmdx3bxd4eEinFXABvIq0QMik5VstcyiN4+w6/JbM55D9/G3i/sxMGP9SK11vL3aBgwwNCy6DUW25Uzu1xzoa2cfOwSRJK3BH73q7UJR+Ioa+HzPiCh/OhSYm7OEWbGGtQJkEo9MD/CgfYm+aA6lkjOADwrDNLgk3lAlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWtjDNvd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756885609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aShlhK0M5I/4dFVaTyFFcCXOwiHo3P/PmXViFObtfNA=;
	b=ZWtjDNvd0KDnXiEQrcWgdp16KgNDXk80TIXrkaISZtnfqlAeQs5ezMKU76VxgPQWrpgYXm
	JelOER1D76XcPcLpAa7nlcso8KVRxjd3c8X6b9VlLUI7fuIpAQ7NNmEYoYLpXjUQz9U/3X
	JA9UvFXcPuVk6Hr96lyMlL6wQmZpZNo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-DqJjxesWMJarUbldZLioRA-1; Wed, 03 Sep 2025 03:46:47 -0400
X-MC-Unique: DqJjxesWMJarUbldZLioRA-1
X-Mimecast-MFC-AGG-ID: DqJjxesWMJarUbldZLioRA_1756885607
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b920e0c25so16217325e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885606; x=1757490406;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aShlhK0M5I/4dFVaTyFFcCXOwiHo3P/PmXViFObtfNA=;
        b=K4n128bushoISBSLIuTuM9C1XTzFpkkMoIf4rax8EFx+VzvEW2MofQLAXtzq5S+F4a
         248gT9gotEEYncrpFy6kSr8pKSR0YJ946Jac5NVY7+gI2gWkQw1O74HDHWuLyYZe6TUq
         JNMKm0CZe+0SAXR46iZ7oeU69YF8yfz+v/4WEryhj0e2WsB4WI82QlPrVQ+RXhy0x9y2
         5KsUCaLWOMsewaTuHUQgJv7LgXO8SLuFmUaCOTFe5p+fqYtYJ9+UZimbyart2AP8BpQs
         EcKL86pFdh0uE+CFtxmkZSLwU2EpSpzCYzbkMnBn0/rCd3cqXjAtPDnwlyBnmtZNV45m
         qaQw==
X-Forwarded-Encrypted: i=1; AJvYcCWVlOJ78CShP/ewjmHBKr9KviqO2kWmXPxe1WgHwH8d5wp/paFzX2doPP6VNT071PCx6JCTkJ6KbuGYG5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3mZ83zFj3B348hH2PMBU7Z05izbjNBGFK0AeAJxIrlPlK40g
	mbNIVfffDUQqLemtxT81aLMib7FaALp3BOsLQsI5AOap0zO6ZKFc+842HxuxDFXAyNmzRQo39B9
	tqzPKYVryzn/62bziNnbO37DlZyCuEenZYaqgD3xjtOwmUU0VPw6lBZ6MOdy/A5YTBw==
X-Gm-Gg: ASbGncs15vGMinj00mH1IDDC/ui+bWqIf2Pb0UOuthyReAxpcDnOwc8h8zk6e6SpaKG
	wNswxE4tqhGHE6sEvPATnO7HsxbnOJK3zURNYtvsPUV+nU+hBNAWCb2OijToNPW3n3B+9rDYorr
	iSZqwsSXJLu/GF35LPY8hG1Bun3Ha3+i+VOhXL9F4mb2l+YeyTVm3Gfiav+rcBI1CEdbZue/o4B
	53+ODrWnNRx1aNhCt+MKQLzry0F6swfZ/R55ILtiLSC70AUcxpcOzvPIJT5GXk0STCSAVjkE3jy
	cRXtofVVotG98xPEiG/mUdrETDZ/Zrqr7DHRH+cg92lcYIgANTXmaTSZMWyZo18VtHNokjmgfcl
	8N+teyEpqiyqO+Ylmfb1yJ4e9/C6HObQhFA+EcyMKDJfI86LI+QmaMYwbdCioEm+drTc=
X-Received: by 2002:a05:600c:4f08:b0:45b:6b0f:caf3 with SMTP id 5b1f17b1804b1-45b8843e109mr99804515e9.4.1756885606516;
        Wed, 03 Sep 2025 00:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcK11Fj01Y4VYea50OLhr0MjERaXU7HBpVg+QX6sa8pEoH5KpraGIdHQTkUtzFV9er9RgALg==
X-Received: by 2002:a05:600c:4f08:b0:45b:6b0f:caf3 with SMTP id 5b1f17b1804b1-45b8843e109mr99804165e9.4.1756885605992;
        Wed, 03 Sep 2025 00:46:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8879cesm227680705e9.12.2025.09.03.00.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:46:45 -0700 (PDT)
Message-ID: <b0ed22cd-ebf9-41f7-b5fb-6fb078db593e@redhat.com>
Date: Wed, 3 Sep 2025 09:46:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix kernel stack tagging for certain configs
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Kees Cook <kees@kernel.org>,
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250902175903.1124555-1-vishal.moola@gmail.com>
 <f41383c3-913a-489a-82e6-d2c8d5519eed@redhat.com> <aLdOLQLjt-A1DBGi@fedora>
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
In-Reply-To: <aLdOLQLjt-A1DBGi@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 22:06, Vishal Moola (Oracle) wrote:
> On Tue, Sep 02, 2025 at 08:23:06PM +0200, David Hildenbrand wrote:
>> On 02.09.25 19:59, Vishal Moola (Oracle) wrote:
>>> Commit 4ef905bda61f ("mm: tag kernel stack pages") began marking pages
>>> that were being used for the kernel stack.
>>>
>>> There are 3 cases where kernel pages are allocated for kernel stacks:
>>> CONFIG_VMAP_STACK, THREAD_SIZE >= PAGE_SIZE, THREAD_SIZE < PAGE_SIZE.
>>> These cases use vmalloc(), alloc_pages() and kmem_cache_alloc()
>>> respectively.
>>>
>>> In the first 2 cases, THREAD_SIZE / PAGE_SIZE will always be greater
>>> than 0, and pages are tagged as expected. In the third case,
>>> THREAD_SIZE / PAGE_SIZE evaluates to 0 and doesn't tag any pages at all.
>>> This meant that in those configs, the stack tagging was a no-op, and led
>>> to smatch build warnings.
>>>
>>> We definitely have at least 1 page we want tagged at this point, so fix
>>> it by using a do {} while loop instead of a for loop.
>>>
>>> Fixes: 4ef905bda61f ("mm: tag kernel stack pages")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> Closes: https://lore.kernel.org/r/202508300929.TrRovUMu-lkp@intel.com/
>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>> ---
>>
>> You sent the patch on August 20 and I replied on August 21.
>>
>> I did not receive any reply so far.
> 
> Ah sorry, I didn't mean to miss your reply.
> 
> I can't find your reply in my inboxes so I definitely missed it somehow.
> I'll go find it and respond.

I had a mail server config issue on one day last month (sending 
@redhat.com through kernel.org :) ), let me check if that was on that 
problematic day and it might have went straight into your spam folder 
due to dkim mismatch.

So the mailing list did not reject it:

https://lore.kernel.org/all/96148baf-f008-449b-988b-ea4f07d18528@redhat.com/

And yes, indeed, it was on that problemtic day, and there is:

	Received: from smtp.kernel.org

So, problem on my side. Willy already replied, but let me resend that mail.

> 
>> And now I realize that this patch is not upstream yet and the commit id not
>> stable. So the Fixes/Closes etc. do not really apply.
> 
> Gotcha.

If there are bigger changes it usually makes sense to send a v2, or a 
simple fixup as reply to the original patch (I prefer as inline reply).

Of course, once it's in mm-stable or upstream, things get more tricky :)

-- 
Cheers

David / dhildenb


