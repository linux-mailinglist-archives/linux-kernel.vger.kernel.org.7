Return-Path: <linux-kernel+bounces-811728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E76B52D10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B59B7B88D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630AE2E88B1;
	Thu, 11 Sep 2025 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIR1aPlq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5425214A8B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582561; cv=none; b=u/JKRvdsA2X7HbZmBhEGhgncwZNgSf2Qb+zItxk0ok38f0ju4H538tMgknM0cVKL/9mU4wsGEey5vTNR+VPHH8LzddK5rP70wgHrpAQAMWHtCxBK/ItmwWpAHqaBFNOQtG1gb9RJozacgDbgb8EOQR0hTQxQpZRdsNmDOATnLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582561; c=relaxed/simple;
	bh=ZjVVnoHhrPqz/FPMsoLDvBz4JjcKWiP+0Lb4taSWY+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYgHFkhu6RCFSSX1WojFcfGi+4kq2keMraewBJBHEcgYEyl4JSLl36CYf2Gku1lJWZ4LoP8LEvbArkMN8BU5XbdhAiVkcxV8yyPu27J9zpp+qazBsYhdvAYMlgblAvD235smVXo25ydiXvzXo7R2K5se5L7DxTJuC9h6gPwLuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIR1aPlq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757582558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XlIY77OqGXzNcygBXjtu96M6CtVN4R5XfEMEcIT0Idg=;
	b=EIR1aPlqGHPNbWHLgBS5mIhh+fhdAraOj1Lvhsp+7SLDji5N4LOJ6TABkV4qRR/ntoHPfR
	34M8S5XdJ2GcNnRMHLLLgSwLyFGLN6LRV2NToH1OPXjXBfKTpnR9AK+C+p8soXYA8iJXMh
	/TGjzRQvMU/mlTWy8/poyNgr7jPEGCc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-YyVBx7WNOXe_qTJj79tIyg-1; Thu, 11 Sep 2025 05:22:37 -0400
X-MC-Unique: YyVBx7WNOXe_qTJj79tIyg-1
X-Mimecast-MFC-AGG-ID: YyVBx7WNOXe_qTJj79tIyg_1757582556
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dcf5f1239so2152975e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582556; x=1758187356;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlIY77OqGXzNcygBXjtu96M6CtVN4R5XfEMEcIT0Idg=;
        b=GMjp/FslE2FJVOLBNRvp2mJRIMaKTQpBv45JOME1hUnbQzvk7kzt2shcUX0TA7cpQt
         UMmZrXT/xpVIGZe7C5D0Wk0W/dh3XM0NsBjfZe6vsDLXEEDh2Lf9GgwKPbdkCqS+ibXK
         HsfYgHeibb0nAD/7avgRsIYNl/QxRolt2CKj0ckywgdJlFzGpAbfgC4k4a6K/6M/CtRn
         XHvQvu6/KA/op5f4R8CdOQMo/F1BrYAgYg1ztdZPSMpvVc5VPLli1vUSDfddkO7z1Oso
         IWUC0M0myOLNxwhK1uhI1I+OJfsWncsWmotdpeDNzdvOR6Y9jxTUQKQ/LHGwzICO5HOv
         iR0w==
X-Forwarded-Encrypted: i=1; AJvYcCVvYNlitaNWjbjn69RgSCVezDljYIxA6lqXBpnhRrDS1Un92+aM/diTmqvthaJavz+OVO9FY928CgWCu4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/BV1f2iiQmWqdKnKIq/Q3c4OXhrSkbJt4deocgidfx/8tkX/Q
	RA/ep/gnMTBangZaLl8aajiCDM3jNA6pvVzLvqluDvcNfaYrqDHwU7CZLydKPOmvBrqttu3etgt
	5YQWCtMnDEeP4ePp/JW8Htaodhz/9QF1Va+9teAfAqUSghrBgx1Ml7+GEQQatENY06g==
X-Gm-Gg: ASbGncsup3D6Gry6mTu5wdmGF4EAnfIoBg009TXPzlF1o5QVttajH083HaJSGRJBTr7
	COoFP+MrBWN9P2IoFB7emfezzpg8OTLikDpQsUcgBX8mAGFMEgwrgtDQER+29OmA/NUL/IAaSzP
	AyZ3cmOhpH/o8OeQZKnFyqrlYY4v/gH86TV0k6a+RvuamszHTNtqLoLv3aGbo9lhx7be4DyKILR
	ts6u3Z9zxWSBkhfk/+Qfoa7PGk1fFhBP5XOGTQPYeM84MRaCfhXznVba2j9djbbdxh9EITTjEIv
	y5oH0dNJIu83INZzvotGOA0v8k7y7udbFVM+jBj2eZYg4Ks2W0Ih8snW5K+QvbMGI9P8Su0GPOG
	vZbzeTK+aamrdvF1NMYjHQfN7hR4TGcJCqwzT1+d99j8iyp+q8f0YIIxXMFlhAbhly9Y=
X-Received: by 2002:a05:600c:45c9:b0:45b:97d9:4127 with SMTP id 5b1f17b1804b1-45ddde88188mr158168295e9.1.1757582555886;
        Thu, 11 Sep 2025 02:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWbNRfXbRs0WpzaUFArlf/GGodKR5SPmBVwxNVpsnCRj1ui246HIUyFHPhNTL9+yDtBq71HQ==
X-Received: by 2002:a05:600c:45c9:b0:45b:97d9:4127 with SMTP id 5b1f17b1804b1-45ddde88188mr158167895e9.1.1757582555471;
        Thu, 11 Sep 2025 02:22:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5c5dsm19695035e9.14.2025.09.11.02.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:22:34 -0700 (PDT)
Message-ID: <59283f53-e249-411f-993b-1ed50f899c42@redhat.com>
Date: Thu, 11 Sep 2025 11:22:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] mm/vma: Add limits to unmap_region() for vmas
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com,
 kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org,
 chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-4-Liam.Howlett@oracle.com>
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
In-Reply-To: <20250909190945.1030905-4-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 21:09, Liam R. Howlett wrote:
> Add a limit to the vma search instead of using the start and end of the
> one passed in.
> 
> No functional changes intended.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   mm/vma.c | 6 ++++--
>   mm/vma.h | 1 +
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index abe0da33c8446..a648e0555c873 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -474,6 +474,7 @@ void remove_vma(struct vm_area_struct *vma)
>    * Called with the mm semaphore held.
>    */
>   void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> +		unsigned long vma_min, unsigned long vma_max,

Why not call it "start" and "end" ? :)

In any case

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


