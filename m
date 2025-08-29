Return-Path: <linux-kernel+bounces-791382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB02FB3B62A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDCD1759AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FA28BAAC;
	Fri, 29 Aug 2025 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AncyNS5Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39427B333
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456985; cv=none; b=rdQac2hPNXorQoMCx+MLAH7P5vgOVLPykabO1IdwpuN7FlI8SUZzbi+k5qFU0TlH87g2u+LsC/yLWh4QfrdyvSDU/2Wogu6YfsGB0JjQOJn1GJxHIrxirIRxKaPK8Zye4t5hd6YtrVbIi+btKwVbclF7oZPGQu6VRmhr762CSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456985; c=relaxed/simple;
	bh=1vNOPUF8kDYmLjDxaTa3VYlbeDpgKJGq1IK29De5gD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y93zhpc3a6ISe843t02pL/OF9qfKV4T6N7PQECFv48kLzV372LamXxNvzw76wWKcrAkNqDRdjqw0pVbMV9YH8YJ629yfKGXzQZ05VAnMVyW/4KB4LixZwfKGXU9bZDWr1GS0afKfkaPiUOeti0IlQuPXOR0Z3vBb5SYFQrd1rIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AncyNS5Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756456981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UbeBHr+taTbsP5JGIPmUvS94n2HMJooGubjx7rvWayk=;
	b=AncyNS5ZNwYAfPB9aNeIlGNJv1xRCpGTIB72EzFiJk+npyjq/e97cFOfKWx4IyrAvbvc1d
	KKRGrUj+ieyrHGhTrGGDUkqk93zb8J1ipoKrp57HCUG/IikczRXtH2dXhw4lFa3assw0r8
	eObpgHLNBOQx7FTJM2GfMz8ZcMDSrJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-XRruW97TNZakcbf8K8nHNg-1; Fri, 29 Aug 2025 04:42:49 -0400
X-MC-Unique: XRruW97TNZakcbf8K8nHNg-1
X-Mimecast-MFC-AGG-ID: XRruW97TNZakcbf8K8nHNg_1756456968
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b7a0d1a71so11625185e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756456968; x=1757061768;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbeBHr+taTbsP5JGIPmUvS94n2HMJooGubjx7rvWayk=;
        b=fuyktAr3JNa7LTVX0O6z1L5u+LqTEgMoAGqdq4CKgOPL1eZNZi7+I+bI/GbuFH33Tg
         HvVBkkCo2MVoepUYiH1ku8/Y7vC1zxaRGvzxDBOn4d0aSerKjCaz02oY+7B96fgJHezm
         O2HafC1NFTFZFR0MZjJ2QMlRDnYv6JOxHTIiXggoCA9wd0IfA0kuC2fxAvRGuErVEhoK
         xI1yAqXoponKBes5SLca/N8Lv1P/GOH9ON14r62w79qrxfKu3+Wu/R/A7ALbCCHI6Hg9
         uGjEt+3WbNsDGwyURtS0utn2zV36viKEx3u/r+kfCuJy3i327i5ThCvvWiZZBKyi+S9H
         R8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPmIGzqkU9e/RJGebT62VYoiGt5a5/efKhftMivZax4F7JNZ0pQOqH+6M+pfOgBISFPe8/U1J9cZdUjYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQb5P9t1nAwhAW/kXR2wfgiXuNUCN1qrNY/v3aljWA9Z7ak0f3
	+x3nR7/x36OIu+WldunOPBro5U7Nb07pRyzU+p98N1i2q44VK54ftdIJ7aI+GEgCaaKAIqiIEhM
	Khm3Q95nQcyVioYgxz3s5wf8OUlqbhzOCf+GIAZMV+2FRIX4Yf7dF0kjolMlDdIIqFA==
X-Gm-Gg: ASbGnctbLJZHXloqwJtdGyVFtYNCVvcX9MZfy/CNOF87WuJ0j3HPKqupxxByXbcD+yk
	zAMi9gQ5t6r2vvWsFf4wiexIXvubJ46WPN4os5EbbTMnvY9tqeyALsK2rNvbRZttZlIqceH1JgT
	l5lvNtb1cI3zOT41wvoN4SzZ8rQSk+I7qG9VBBc4OCsrCO4q/x1pODR+ZJuMk5jlhCc8Lizt4xk
	4RMo1P3/KTfQKW8hO0XQHMhLtRQ/ngkZql13IaLJ326aoyesWdb0Lzbi6JyYLtMStFutKWF+T2h
	PWf8X2HvBVe7E9B5kayPzytnH6xER0zgNIgYZCEDburQ9WB4xTjv6EdPBGZ3P1kMWWmBRpFGgX8
	SmktZBnvOXC5yQs6pMoKSA5SFgDO9jr6mC0VWJODsfBn+NKgDFFUDgnKpkF8xZ8yG
X-Received: by 2002:a05:600c:4a22:b0:45b:7580:6f29 with SMTP id 5b1f17b1804b1-45b75807bd4mr38150595e9.4.1756456968261;
        Fri, 29 Aug 2025 01:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLquX+Mi/AkVH2BhQ59mZtnAzUWapPkSncAvoK+DN68l+a/Jv8BNYFZPh6/XKoEruQOA/2lw==
X-Received: by 2002:a05:600c:4a22:b0:45b:7580:6f29 with SMTP id 5b1f17b1804b1-45b75807bd4mr38150355e9.4.1756456967824;
        Fri, 29 Aug 2025 01:42:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:100:4f8e:bb13:c3c7:f854? (p200300d82f1d01004f8ebb13c3c7f854.dip0.t-ipconnect.de. [2003:d8:2f1d:100:4f8e:bb13:c3c7:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66bbcf19sm70603965e9.4.2025.08.29.01.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 01:42:47 -0700 (PDT)
Message-ID: <f5cb68a7-19eb-40aa-95f7-51fd004a3f8e@redhat.com>
Date: Fri, 29 Aug 2025 10:42:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: Lokesh Gidra <lokeshgidra@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Kalesh Singh <kaleshsingh@google.com>, android-mm <android-mm@google.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <dc92aef8-757f-4432-923e-70d92d13fb37@redhat.com>
 <a0350dd8-748b-41d5-899e-1505bd2b2e80@lucifer.local>
 <CA+EESO73TRAcMWeo_aXkLM+0rT5nt1cxyvf+Ye3Xp9kqxL5=6Q@mail.gmail.com>
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
In-Reply-To: <CA+EESO73TRAcMWeo_aXkLM+0rT5nt1cxyvf+Ye3Xp9kqxL5=6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> I do wonder if we can identify this case and handle things differently.
>>
>> Perhaps even saying 'try and get the rmap lock, but if there's "too much"
>> contention, grab the folio lock.
> 
> Can you please elaborate what you mean? Where do you mean we can
> possibly do something like this?
> 
> UFFD move only works on PageAnonExclusive folios. So, would it help
> (in terms of avoiding contention) if we were to change the condition:

I think we shouldn't be using PAE here. Once could consider using 
folio_maybe_mapped_shared(), and assume contention on the folio lock if 
it is maybe mapped shared.

But the real question is with whom we would be contending for the folio 
lock.

Is it really other processes mapping that folio? I'm not so sure.

-- 
Cheers

David / dhildenb


