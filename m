Return-Path: <linux-kernel+bounces-851219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE532BD5CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A1D18A7820
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B716224F3;
	Mon, 13 Oct 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAXS73r4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8B2C235D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381743; cv=none; b=h3XP2i0mVteBJkaSsGHXOpa96Q+JisiWMEWTA6JcEsDTnoh4+GnjHBac8z5IS1RxL72W30DXuFmQwReVMOIxisJmPjmow7Cc+ptjNuGVHiGbR0Xr3PI88NTNFUIcS7eu/ZJTjrtnK18LAqSOMYqESMcGPXotNmzP3/9O1WG+bBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381743; c=relaxed/simple;
	bh=4Ex0P+tfVz4kBpuRmYs9rqrYjsfEOMS2CwulZ3z+W+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sq/N+i5OaGfvLJU1WquPPhnVyOESVjH1Fcf84rzL17OJ1pl4w/L0uaY1rTFYhNhAGJLe4RLS8Y+o8RnVTU9+aEMj0Ah5+Yq6bxzz5tjpgu6MThzEsNJR4eBNCvoMPJgWwpxBc34HN2ojB0p59G2uPKUSw9SMfWYYE31UddV6MDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAXS73r4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760381740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c2l1X4zxpuuQEOMhoTZtWvPktW5G66gnU+2hRZgipMs=;
	b=SAXS73r4YwxIQdpEjp+YOLUQJtNsmjVApZA0eOF6UqMx6RxQpSIsvAlMIF+GHCpPMfDd0P
	d0CmZmK+TU1dZpqCguRfD9+ZdO9awDnm7S8tNVGVV29NgmhfPf6NUQMsLbtfoEz39jNjFz
	+3ztT5487WMwqAQVXSQ/cJfz3OC4VE0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-iJP12g1oOceTBoazrdyKeQ-1; Mon, 13 Oct 2025 14:55:39 -0400
X-MC-Unique: iJP12g1oOceTBoazrdyKeQ-1
X-Mimecast-MFC-AGG-ID: iJP12g1oOceTBoazrdyKeQ_1760381738
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426d2cd59e4so2646469f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381738; x=1760986538;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2l1X4zxpuuQEOMhoTZtWvPktW5G66gnU+2hRZgipMs=;
        b=JV9z1rqgF2i+5pHBDNu6GtT5CGa0yJw/iZBFCQOQTulUGZNZlSN+91EOgiN1xu0G88
         t4jBOrfKvkj6p/8FocNrAVxQyrSpoSLR73+XR2LgWQAwcalCCDSBurSfJwtFWMJEjhyo
         GYijrmQOESzMevzoqrmKR77Uf5l64Uv4FW8n4mZG+loSE6qt/EyvuZxSOLM/S/a5DXo/
         V8AlGkg/RAJKm6mt2784vCnyKeI8085LwojqvAqlylVbOCYxIoFBmRBTVsOZ0/IbEwOa
         6sGJaOYnUgIXO4H7QGJbj6pDaX48mSWg+zn75BtrSuCdUmN8o9Zq+/sHyGoY+5K4PTen
         DZyA==
X-Forwarded-Encrypted: i=1; AJvYcCVp/c8O9s71H6bGdnVb9SR6QetKQZvyT4SsjYKS8/73hEryfMsJndoCpTdsVaVcNTOhSBz+fWIMdatva28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsW4MTyrw1cSvhjmolio4YrCvDPDVg6MiTEJmNxNyj7RaGTSFb
	513ZuD5Uty9sco1eKANbym0FnrMvZxHqEt9nafqI9CRQljc63fZ9BLNvcyiq+bB3vhFcCtVd73H
	ZJLenhdTy2DjkP0OgTsokIfWiLwGuEJ3TmyE/up0ZEY+h/qOtSF6tO3/PZQPmd5WpTw==
X-Gm-Gg: ASbGnculRtADuUHS/4SU18rFagGHX2aWZqlrI6Ww16Fb3VSeLwGXHK37Sw5wzYUJfA6
	M41pepq1/4q/U/bq2XAwJvdAht7H1bIDIuIgsNhRD/InFqcdecdlxOrWmqWY0SjKJtHhPK6Hxly
	yLWyk/v/eL8kKCgll/CtrkmCB67OQlbKOuAkdTDtyRX73PnNsdqQfSPKLTkIZDa7eKj9oPpL0V3
	CeMi6VBfS6IEKpqolygFzZERafJ8saPGRHexxJyaKz8L6sY047iDQaTIsPfHbqLgDaAtqhBFbyU
	MGhh2jysaZgSSUM/+r7sU5l4BfKJRHGxyDHIzOw2ys85jjUI+6FVwwPKy0GSWxN9nbmf+MW9+7x
	nV5I=
X-Received: by 2002:a5d:588a:0:b0:3ec:4e41:fd86 with SMTP id ffacd0b85a97d-4267260e213mr13243092f8f.50.1760381738069;
        Mon, 13 Oct 2025 11:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPPqcNOmGlljHBCVN9bgaBU+6o1qzRmLmYYfIm1ap1ibvD+SWGiqQat1UD7EflXC06Qt9AEg==
X-Received: by 2002:a5d:588a:0:b0:3ec:4e41:fd86 with SMTP id ffacd0b85a97d-4267260e213mr13243074f8f.50.1760381737607;
        Mon, 13 Oct 2025 11:55:37 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb497af18sm198743305e9.3.2025.10.13.11.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:55:37 -0700 (PDT)
Message-ID: <80b153cd-8bba-4bcd-9b56-3b2ad3f295e1@redhat.com>
Date: Mon, 13 Oct 2025 20:55:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regerssion] [KSM] KSM CPU overhead in 6.16+ kernel compared to
 <=6.15 versions ("folio_walk_start" kernel object overhead)
To: 423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
 craftfever@murena.io, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 regressions@lists.linux.dev, xu.xin16@zte.com.cn,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com>
 <34d27471-80a4-49f8-b6cb-f2e51518d9ea@airmail.cc>
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
In-Reply-To: <34d27471-80a4-49f8-b6cb-f2e51518d9ea@airmail.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 19:09, craftfever wrote:
>   > Looking again, no, that's not the case. We do a cond_resched() after
> every page we looked up.
>   >
>   > Also, b1d3e9bbccb4 was introduced in v6.12 already. Regarding
> folio_walk_start(), also nothing major changed ever since v6.12.
>   >
>   > Looking at scan_get_next_rmap_item(). I guess we might hold the mmap
> lock for quite a long time (if we're iterating large areas where there
> are no suitable pages mapped -- very large sparse areas).
>   >
>   > That would explain why we end up calling folio_walk_start() that
> frequently.
>   >
>   > But nothing really changed in that regard lately in KSM code.
>   >
>   > What we probably should be doing, is give up the mmap lock after
> scanning a certain size. Or better, switch to per-VMA locks if possible.
>   >
>   > Also, looking up each address is highly inefficient if we end up having
>   > large empty areas. A range-walk function would be much better suited
> for that, so we can just jump over holes completely.
>   >
>   > But anyhow, nothing seems to have changed ever since 6.15 AFAIKT, so
> I'm not really sure what's going on here. Likely it's unrelated to KSM
> changes.
>   >
>   > -- Cheers
>   >
>   > David / dhildenb
>   >
> 
> I have to make a correction, folio_start_walk is present in "perf top"
> statistics on 6.12-6.15, it just consumes 0.5-1% of kernel time compared
> to 11-14% on 6.16+, where it causes ksmd 100% cpu usage compared <=6.15
> kernels.

I'm currently looking at the diff from 6.15 -> 6.16.

In KSM code nothing changed, really.

In folio_walk_start() itself nothing changed.

In the functions it calls also nothing relevant should have changed.


So the only explanation would be that it is simply called much more frequently.

And that might be the case if we are now scanning much, much larger VMAs that
are mostly empty, that would otherwise not be scanned.

I now recall that we had a fix from Lorenzo:

commit cf7e7a3503df0b71afd68ee84e9a09d4514cc2dd
Author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date:   Thu May 29 18:15:47 2025 +0100

     mm: prevent KSM from breaking VMA merging for new VMAs
     
     If a user wishes to enable KSM mergeability for an entire process and all
     fork/exec'd processes that come after it, they use the prctl()
     PR_SET_MEMORY_MERGE operation.

That went into 6.17.

Assuming we merge more carefully now, we might no longer run into the

	if (!vma->anon_vma)
		ksm_scan.address = vma->vm_end;

For the gigantic VMAs and possibly end up scanning these gigantic empty VMAs.

Just a thought:

A) Can you reproduce on 6.17?

B) Does the 6.16 you are testing with contain a backport of that commit?

Definitely, scan_get_next_rmap_item() must be optimized to walk a sparse page table
more efficiently.


> I understand, that something changed in linked function, that
> affecting KSM behavior. Maybe, you can reproduce it with same settings,
> especially it happens with Chromium apps, there is V8 sandbox with huge
> VM size. Maybe, you could reproduce the problem with the same
> MemoryKSM=yes in user@.service, that sets KSM processing for all user
> processes, especially, when Chromium is running. KSM CPU usage really
> differs between 6.12-6.15 and 6.16+. Maybe, it's related to your
> explanation.

I'm afraid I don't currently have time to reproduce.

-- 
Cheers

David / dhildenb


