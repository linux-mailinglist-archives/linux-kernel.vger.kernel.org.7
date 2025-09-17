Return-Path: <linux-kernel+bounces-820163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD443B7DA4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD971BC3DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D762027B34D;
	Wed, 17 Sep 2025 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzMt3d0U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E4226D04
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094860; cv=none; b=kb0lT3yET4uk84eT5YvCpenrTCmq8dgmzI6X4sDiLm7L/iop0P4s8SHUaNI+66sOAIvaCMshOvNqM/u0oIYlwSqwfFRgYAu7nnNfYyKcEoHSY/Mi7kbWkKsielDugWPOaP3I5YumJ8TM93NQRzEgEcw7+vUu7BGfyen6D0M8glQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094860; c=relaxed/simple;
	bh=18bpwHtErb5vCbN1kZz48PXrp6N12ofSDxcENCQubrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aspmm3L1Du44/hPi1sEWXgUnFLcG+7nvOfwmKrQUGOu6Yhc0rMpJYoYQoPqFOh312x0KV4VBKo51XzsYZ1AfpulV9GKV1X+JU9RmSq7L/pPIu2cWXQ0pTXy0sm9C6JsV8pCgiSqx5lP4z/wrt26p6TVSkHgkW20kYBZ0InD9e7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzMt3d0U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758094857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8sUfnI24jFzcwd8XU/KgXpzRD8VbKCrbOhCqit8MucI=;
	b=VzMt3d0Uweyy9dcjibg/LkB43EfOiAvaKbI4cuAsNBRVA211zDPySOqfeB0Lm/MYJ2gi2T
	bKpHxt3lBby0rWqmnmBbhK0cTZAbMlBZlVNM8kysflKaDnQqwxDaz01310zanxyeEPHWcS
	Pljt6iZCcXr4MvB0u2fAiupx4fPQmLc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-xstIXQ-LMqqOJSL6Fg8Vnw-1; Wed, 17 Sep 2025 03:40:55 -0400
X-MC-Unique: xstIXQ-LMqqOJSL6Fg8Vnw-1
X-Mimecast-MFC-AGG-ID: xstIXQ-LMqqOJSL6Fg8Vnw_1758094855
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2c41c819so21885735e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094854; x=1758699654;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sUfnI24jFzcwd8XU/KgXpzRD8VbKCrbOhCqit8MucI=;
        b=UK7JoIx3Tz2mEPCMbim7oS080Oogt8kovPX5aRufKB1R6AXYFapEdLNZ9y5OZvKkG/
         q7KgG5hPnqzbXD30+vZbrPEnqtt/J+gvJiUHf/K9Mlq5Sqfz9kpDW/absuxTt1AosNwj
         b1A+X3njJ5Rhq3SbOXAl7rec5WI3AjYC8oRm/nirrpWY71yBLyOIEBE2AjPpNb89IJFs
         qw36GJ4nKYfOlLjj2cBDPE30u59WMXjTO1ycYsAFb2XCNnE1NmgIcf0tnSzjBCDZaL7K
         Y2UXb2xi9d+0LhtxTfvkEzpw4i3h+sO7X2aC5Jb3OAl/3nQ6oSZ7P2FKmM8Fp9+rckvH
         vLGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1pq0Bjy0juk0KXRfyFf8jPA7ZuQMsqL/Luto51j+YqquEewAH5j17O73qdwrmtnOdofpTE+i/zlVVRm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJaZ3o3Nk8O1odSfawzlvwf9uBJY9Zlkv3zL/Q4LcN1yEvEnEL
	yiaGMZtrGgq+2RxzqV3DyyMysedWYwG+PqJUCnwOfUitT5uLQXzWN87Vw+5PitUmpB+MwLemsPm
	/7xnaafMzARniXb1d1pOALDPzFQao8jxpzR3fJbKLH82/b+DVsqnqInd+FvHaBHpiSQ==
X-Gm-Gg: ASbGncuIgJOBvf4tTWeFgFbe+VGYNVQWCj011nFQMCDxgh3ZEekl17WdsVyRpuNEQ0e
	xTep4W8W4IxCkbjtraeNtzg8i3Rne1x98u68LKVKw0kBn5vacr3U2p7/ALwN3lLkgApz921rUp+
	L41uDenuPTBLfw/J0++2c89QIuPXMwxwvPYjXtGTAwSNK4kJHWvgDecjjvRUAgCTi7jqsgfapyH
	6MSytw6Vke2sjM7hvJdumHiTHzTaplTdmvDbA9EfwX7JyDRZWWbv5a230i1P2EDHH3MmJyEcQG9
	2jks/InZq5j0QR8Oy4Vtgf30nCV+MaeXIcAGy2OdwAQLJs27yFWfnc+JLhDAIkytlaTPLXVHxi1
	BSgfhQygS6BjvXMVUlf0xKLKPNwY97yCMbjD4leourYLKuK/efpEfDWVvB0iAhXom
X-Received: by 2002:a05:600c:3b02:b0:45b:43cc:e557 with SMTP id 5b1f17b1804b1-462074c5382mr8713905e9.34.1758094854469;
        Wed, 17 Sep 2025 00:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5wZM4SkH5EiKp1IscU1Dt+bW/Z0tUdh0H6cNhqcWGNGy5NEAEwmxp1KwF0uBi6Jw2iei8sw==
X-Received: by 2002:a05:600c:3b02:b0:45b:43cc:e557 with SMTP id 5b1f17b1804b1-462074c5382mr8713595e9.34.1758094854060;
        Wed, 17 Sep 2025 00:40:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdb0a2752sm4034782f8f.56.2025.09.17.00.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 00:40:53 -0700 (PDT)
Message-ID: <377db013-4850-4501-a810-552e2f821dd9@redhat.com>
Date: Wed, 17 Sep 2025 09:40:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: fix copy_hugetlb_page_range() to use
 ->pt_share_count
To: Jane Chu <jane.chu@oracle.com>, harry.yoo@oracle.com, osalvador@suse.de,
 liushixin2@huawei.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250916004520.1604530-1-jane.chu@oracle.com>
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
In-Reply-To: <20250916004520.1604530-1-jane.chu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.09.25 02:45, Jane Chu wrote:
> commit 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared count")
> introduced ->pt_share_count dedicated to hugetlb PMD share count tracking,
> but omitted fixing copy_hugetlb_page_range(), leaving the function relying on
> page_count() for tracking that no longer works.
> 
> When lazy page table copy for hugetlb is disabled, that is, revert
> commit bcd51a3c679d ("hugetlb: lazy page table copies in fork()")
> fork()'ing with hugetlb PMD sharing quickly lockup -
> 
> [  239.446559] watchdog: BUG: soft lockup - CPU#75 stuck for 27s!
> [  239.446611] RIP: 0010:native_queued_spin_lock_slowpath+0x7e/0x2e0
> [  239.446631] Call Trace:
> [  239.446633]  <TASK>
> [  239.446636]  _raw_spin_lock+0x3f/0x60
> [  239.446639]  copy_hugetlb_page_range+0x258/0xb50
> [  239.446645]  copy_page_range+0x22b/0x2c0
> [  239.446651]  dup_mmap+0x3e2/0x770
> [  239.446654]  dup_mm.constprop.0+0x5e/0x230
> [  239.446657]  copy_process+0xd17/0x1760
> [  239.446660]  kernel_clone+0xc0/0x3e0
> [  239.446661]  __do_sys_clone+0x65/0xa0
> [  239.446664]  do_syscall_64+0x82/0x930
> [  239.446668]  ? count_memcg_events+0xd2/0x190
> [  239.446671]  ? syscall_trace_enter+0x14e/0x1f0
> [  239.446676]  ? syscall_exit_work+0x118/0x150
> [  239.446677]  ? arch_exit_to_user_mode_prepare.constprop.0+0x9/0xb0
> [  239.446681]  ? clear_bhb_loop+0x30/0x80
> [  239.446684]  ? clear_bhb_loop+0x30/0x80
> [  239.446686]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> There are two options to resolve the potential latent issue:
>    1. warn against PMD sharing in copy_hugetlb_page_range(),
>    2. fix it.
> This patch opts for the second option.
> While at it, simplify the comment, the details are not actually relevant
> anymore.
> 
> Fixes: 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared count")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>   include/linux/mm_types.h |  5 +++++
>   mm/hugetlb.c             | 15 +++++----------
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 08bc2442db93..a643fae8a349 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -631,6 +631,11 @@ static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
>   {
>   	return atomic_read(&ptdesc->pt_share_count);
>   }
> +
> +static inline bool ptdesc_pmd_is_shared(struct ptdesc *ptdesc)
> +{
> +	return !!ptdesc_pmd_pts_count(ptdesc);

No need for the !!, the compiler will do that automatically.

LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


