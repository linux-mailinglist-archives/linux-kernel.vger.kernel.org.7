Return-Path: <linux-kernel+bounces-847371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCC8BCAA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F9348372B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DE256C87;
	Thu,  9 Oct 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKsykWIM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812A24113D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037196; cv=none; b=Y7zyisKfucS8gVCJo3U3XAZUzg0GsXqKMdx6JoplkzrzCB8E5t+li9W4vKXEUBWTNHaJVEDfnUvGyqvGPVSUNDGFJQN6nI6rDy1FftxEUH2UCi9KM2SP6Y93JMtHL8N43qBpgfkWq8R+1Z3YAeBPOLOFaLr3CCEy/VtGtfhmr70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037196; c=relaxed/simple;
	bh=ENC6amdDkAm4vf7SRoBraXZjYWz3wUySAT+4cMfHVRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8mUshxO1skeI/5mCTApb/f+HLH4ADg0bmNau8jNNCWYrileD5aGkXwcHeXLI81VWRPT3+a061x8vPYnblOByEoHqTjU36hJUZV0LDCLMQlXxkMq+5JPeD+vSqqUHwuFXr0xlYRtF8UX2sux8iio07HHf+Jt0TWwx58++bdq47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKsykWIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760037193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uMfDHaIXjP5qW70eAEFIPvcXKGAAk4uyl5DbHMEw+mw=;
	b=QKsykWIMNMUfC19kOsG2B/N4Ub3BlmOCXnsKHMqJyhKEWdySN+hha/NS/yRfBUArFDKCTS
	3zSlCPgMfvL1pn21ptiAB5+AuIaPrJb5JgGLua77E/UYBJ2NoSbdraERXAIMf8h8HTY8er
	EV10vWEO520LIIMyuhrvzedi7mL79cA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-OpPjJp4WMaOkxDqVv1kJDA-1; Thu, 09 Oct 2025 15:13:10 -0400
X-MC-Unique: OpPjJp4WMaOkxDqVv1kJDA-1
X-Mimecast-MFC-AGG-ID: OpPjJp4WMaOkxDqVv1kJDA_1760037189
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e31191379so9064815e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760037189; x=1760641989;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMfDHaIXjP5qW70eAEFIPvcXKGAAk4uyl5DbHMEw+mw=;
        b=eRUSnKLqiwVqMuRFLuO+TBGYcLQWSzwUbsLkYKd1WitlDcYJ6A3U7z1MUWVdAUMj4j
         4Qq8xhtGWeiUxhycAgEOB8yUVgBRE1u5MXLeUezj6RoXcOwEkh3PKhJAoLEI6+J5WXxE
         m/uscSDRvO28z1FetpwXX9sCmqUKNI41zADZPkYuImikH5QCbNIyb3GLrkC3dQvucr2R
         wo3wr/dOv1Kc3pKLc+lFnaSNRUthgR/8DU2xmPenyn8jjdKuH96wbFgQHiul7oWDpLUl
         pmlx9g4zDtqiM/NO2+LzGC7vc1rpuTFXOZrU3GN1YjZC72TL5Wyu3PX1g0dSTSkC5To8
         UWhA==
X-Gm-Message-State: AOJu0YyvHBNEqXL0usqCa5yPa/SaNPhuG0HbnWoUZO11D1zck5kdVUXz
	g2JlOd7jOOC0H3QCzP4x6GDj6iZUHv7OqA9Y++UYg7Q3eqY5pPzL/aEi3bAXC++Yj05Pgoc/QNh
	kZWOBMJWI3zyLHUpPSlK+so2R0PrHzY3hlIjniHfmHw8lvDiUQn0uCWAtp1o3M5v8BQ==
X-Gm-Gg: ASbGncv8kO8PETI3Tjbb3/AuEEYqH9umIjtGdsXUPBShk1zK1VATM0VQbDkB8r9jIXa
	VRGtDXEKbUjXRmy2B/tYfwGat4hrG7GgITeU1NeNZ0Bz664RkC++zmRtBGnNGsC7P3JZkLO3Gij
	gbsKDMDDOthB00iX8H/jh7bJLRfnZR8Fx9a1ZJ+xKfC9UHX2XvHcGlDK45apxtDW+aH84u4EYJT
	FTdg2TOSJ+5uxSt6pIujCh3d/JsliWraL2YaZSL+BqBd0ddEYicJUQ1KXH//P/LoVmX/ymgoA2+
	Bg9EJUQHBfpLnB+ExcxzL+ZX2uXNEASjuhuRUqQyDarlHMfGNF1UV9A7BKe9sbUoQ4zDL4ftBlu
	HCORfuOsr
X-Received: by 2002:a05:600c:1394:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-46fa9a8f090mr59071625e9.3.1760037189457;
        Thu, 09 Oct 2025 12:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBcImDsyxTunmBqgZfkDNrdR7pu/FzopoU++FfWBhFLzzgiDgfzJIo/TDjPU5ArHmmJTRIsA==
X-Received: by 2002:a05:600c:1394:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-46fa9a8f090mr59071425e9.3.1760037189032;
        Thu, 09 Oct 2025 12:13:09 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf6b4sm405958f8f.25.2025.10.09.12.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 12:13:08 -0700 (PDT)
Message-ID: <ed7db8b9-e828-420d-a8b2-3e1b8aa8c95c@redhat.com>
Date: Thu, 9 Oct 2025 21:13:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] s390/sclp: Add support for dynamic
 (de)configuration of memory
To: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
 <20251009131839.3739108-3-sumanthk@linux.ibm.com>
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
In-Reply-To: <20251009131839.3739108-3-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Just a couple of nits

> ---
>   drivers/s390/char/sclp_mem.c | 290 +++++++++++++++++++++++++----------
>   1 file changed, 207 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
> index 27f49f5fd358..e1302b1c98ac 100644
> --- a/drivers/s390/char/sclp_mem.c
> +++ b/drivers/s390/char/sclp_mem.c
> @@ -9,9 +9,12 @@
>   #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>   
>   #include <linux/cpufeature.h>
> +#include <linux/container_of.h>
>   #include <linux/err.h>
>   #include <linux/errno.h>
>   #include <linux/init.h>
> +#include <linux/kobject.h>
> +#include <linux/kstrtox.h>
>   #include <linux/memory.h>
>   #include <linux/memory_hotplug.h>
>   #include <linux/mm.h>
> @@ -27,7 +30,6 @@
>   #define SCLP_CMDW_ASSIGN_STORAGE		0x000d0001
>   #define SCLP_CMDW_UNASSIGN_STORAGE		0x000c0001
>   
> -static DEFINE_MUTEX(sclp_mem_mutex);
>   static LIST_HEAD(sclp_mem_list);
>   static u8 sclp_max_storage_id;
>   static DECLARE_BITMAP(sclp_storage_ids, 256);
> @@ -38,6 +40,18 @@ struct memory_increment {
>   	int standby;
>   };
>   
> +struct sclp_mem {
> +	struct kobject kobj;
> +	unsigned int id;
> +	unsigned int memmap_on_memory;
> +	unsigned int config;
> +};
> +
> +struct sclp_mem_arg {
> +	struct sclp_mem *sclp_mems;
> +	struct kset *kset;
> +};

Just one thought: if you keep either as global variable you wouldn't 
need this. (I would just keep both as globals, but whatever you prefer)

Whatever you prefer.

[...]

>   
> -static void __init sclp_add_standby_memory(void)
> +static int __init create_standby_sclp_mems(struct sclp_mem *sclp_mems, struct kset *kset)
>   {
>   	struct memory_increment *incr;
> +	int rc = 0;
>   
>   	list_for_each_entry(incr, &sclp_mem_list, list) {
>   		if (incr->standby)
> -			add_memory_merged(incr->rn);
> +			rc = create_standby_sclp_mems_merged(sclp_mems, kset, incr->rn);
> +		if (rc)
> +			goto out;

Why not "return rc;" to avoid the goto label?

>   	}
> -	add_memory_merged(0);
> +	rc = create_standby_sclp_mems_merged(sclp_mems, kset, 0);
> +out:
> +	return rc;
> +}
> +
> +static int __init init_sclp_mem(void)
> +{
> +	const u64 block_size = memory_block_size_bytes();

Instead of "u64" maybe "unsigned long" like memory_block_size_bytes() 
returns?

> +	const u64 max_sclp_mems = roundup(sclp.rnmax * sclp.rzm, block_size) / block_size;

Instead of u64 maybe "unsigned int" like the ids you store per sclp_mem?

> +	struct sclp_mem *sclp_mems;
> +	struct sclp_mem_arg arg;
> +	struct kset *kset;
> +	int rc;
> +
> +	/* Allocate memory for all blocks ahead of time. */
> +	sclp_mems = kcalloc(max_sclp_mems, sizeof(struct sclp_mem), GFP_KERNEL);
> +	if (!sclp_mems)
> +		return -ENOMEM;
> +
> +	kset = kset_create_and_add("memory", NULL, firmware_kobj);
> +	if (!kset)
> +		return -ENOMEM;

I guess we don't care about freeing sclp_mems in that case? Likely it 
should never ever happen either way.

-- 
Cheers

David / dhildenb


