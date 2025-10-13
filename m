Return-Path: <linux-kernel+bounces-850146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECB2BD20E4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD393C1591
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454B2EFDAC;
	Mon, 13 Oct 2025 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIpSkemC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF472264B2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344057; cv=none; b=e4oo+UvmgaTk4gOuKv/vw4XvODu3P9MRqr4Pp6xVTKYO6yhJ9h9NzOX7TlsxFHlzAwk3735OXZ1dbNGlIWjc4Kp5ffbiixf/t4bOmU7npZLKqMxZej3AxSCWzhXl38OOoCV6pyQF73vHpOiQ3V2udUi2K0l9rZWqbfV1+08pWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344057; c=relaxed/simple;
	bh=Qxjf5Jlch/O1ZiQQRuNt9+vPkzfobJQi5UDSDmjzEIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFV0ZQEKgeACby/QpcTB4u+tXh1LUON1sNeUBDRgt2c/JA/XDNwj2G0Do1UYSeXUDZyAONJhePsqsbNpAeehlvtpYj7i7t0Hxf0bZHGoBlNGGH/zF7Wd3lGwsUBq4Qm11fusEJCkI0wkLG6xKkyRj7OTzN7FkNrMHvBXbTHAcOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIpSkemC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760344054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IYc0yyeIWxSa0xUCnbG6eH4WRp+VUx0D733T1/rtD3M=;
	b=AIpSkemCVeeLUkb4t6mtT350nDqEsUZtR9niwOTm6QqtlC2ohsq8LXZvPHEkaRVKhZKjj9
	y+Wu5+t1/lBJh+1FYXFcaqUMIszY6lKfeo3yClgoF1gBrmGRLk34ifK/LsQsWxqxFd+Yt/
	1dysrd/uE4i5OaM//Jl0J7wB3UbRbPA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-ZOLtMVEaOEej5uzJGXEG6w-1; Mon, 13 Oct 2025 04:27:33 -0400
X-MC-Unique: ZOLtMVEaOEej5uzJGXEG6w-1
X-Mimecast-MFC-AGG-ID: ZOLtMVEaOEej5uzJGXEG6w_1760344052
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e3af78819so19765805e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760344052; x=1760948852;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYc0yyeIWxSa0xUCnbG6eH4WRp+VUx0D733T1/rtD3M=;
        b=PGVqWO222EuWjqU3LtlI4ObUET1jEoso6J7MK/0ooqhVT3+31BaZHA09no8FHrZ20L
         ZIRdyEo+NxUydhwFCIS+1ZkIf4jXITWVi3pBYORINoSDFhqY7gy1MXEe/unUzPF5AwVo
         hp8VBkxiF1vBlmqFeny4vXU8OKT8CJk3TOc6Gh/mVwYBSL6i+ZFgmokUBOfyjJY60RMJ
         FEYmRAtYE/Z6cP1sr8QKjplrqKcYCAv67rWE2wp9wERBYa/AJUsmneRbHu13CefE/hIE
         lOK+NO8iU1L3tnKUrQkwCcaW5CE28pT6BwY7Isah7qZ8HTvHbOCdHulfDaFO9QOUOMFe
         Pc5A==
X-Forwarded-Encrypted: i=1; AJvYcCUtyHRJhf8Ve/m8Go9h593NWqMu9lGKS2MH+dzvEKWFux4+X5rK3p7n6VhpV8nCguEp1N67T+cZd9YYmIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbbvRsz18beXn1hZ5AtNg7g/b2pjCZhKo4lIwwLHuXcdcCduBh
	GO6o0XWKjhALfaU/pGm2ONWNT7jtPPOtvpOaQ6A/Cl1ENYMKbPo5dBr9VHlR4UoNZNeuog8/16i
	C7MjKwrV+6EYtVHHxD4VImjhaEyjv0OVr644pmi9K+c6kXrwxlcCDYbgSjXxi5BaZwg==
X-Gm-Gg: ASbGncsk0//5mfLWd2O/vKmdpoQuYmPSsbmIIqWEPiOYTfiFD9F2THD14R0klYSLbSn
	V9N5hNibOnPscG/kV6yE6UTM7FOxxzgPgLfQ/xQLy6q+2CmllW872iQEx44uhtL8VdtO0JxJ6nE
	dtpXvSr9Sf0FnWMG1LFzbGFGkRG5mbsEzg2wdqi2RxdA2wDSglyDuTUVfqkFxD63cI1j5ddmrfp
	oQCDZU7oBNEA+fMYhCBsa4Lx2TvT1/EXU0odsx0rehoM3igkpL4AvNd/JUgnHogYZHKgKnZtR1a
	FAjeSxvnb5mbqCiMKuvRaQzNvENfetRvl1ypCnIX4aQoDsslh/RkoqgGiCRJCEiLdEr1Ot3WXh+
	NKY8=
X-Received: by 2002:a05:600c:8b37:b0:46f:b42e:e366 with SMTP id 5b1f17b1804b1-46fbbeb30afmr56925025e9.40.1760344051730;
        Mon, 13 Oct 2025 01:27:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA2SBh7ozmWj8p4x8T0KaKYDgKMnupDj5F/SOVScJTQCghcNRaFN3WsoBZ6GD+Qz5jMvZobQ==
X-Received: by 2002:a05:600c:8b37:b0:46f:b42e:e366 with SMTP id 5b1f17b1804b1-46fbbeb30afmr56924695e9.40.1760344051179;
        Mon, 13 Oct 2025 01:27:31 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489accbsm196059665e9.14.2025.10.13.01.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:27:30 -0700 (PDT)
Message-ID: <adf3cb95-916b-4513-b763-48aa8fbfb700@redhat.com>
Date: Mon, 13 Oct 2025 10:27:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hugetlbfs: check for shareable lock before calling
 huge_pmd_unshare()
To: Deepanshu Kartikey <kartikey406@gmail.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, broonie@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
References: <20251003174553.3078839-1-kartikey406@gmail.com>
 <20251008052759.469714-1-kartikey406@gmail.com>
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
In-Reply-To: <20251008052759.469714-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.25 07:27, Deepanshu Kartikey wrote:
> When hugetlb_vmdelete_list() processes VMAs during truncate operations,
> it may encounter VMAs where huge_pmd_unshare() is called without the
> required shareable lock. This triggers an assertion failure in
> hugetlb_vma_assert_locked().
> 
> The previous fix in commit dd83609b8898 ("hugetlbfs: skip VMAs without
> shareable locks in hugetlb_vmdelete_list") skipped entire VMAs without
> shareable locks to avoid the assertion. However, this prevented pages
> from being unmapped and freed, causing a regression in fallocate(PUNCH_HOLE)
> operations where pages were not freed immediately, as reported by Mark Brown.
> 
> Instead of skipping VMAs or adding new flags, check __vma_shareable_lock()
> directly in __unmap_hugepage_range() right before calling huge_pmd_unshare().
> This ensures PMD unsharing only happens when the VMA has a shareable lock
> structure, while still allowing page unmapping and freeing to proceed for
> all VMAs.
> 
> Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Reported-by: Mark Brown <broonie@kernel.org>
> Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Link: https://lore.kernel.org/mm-commits/20250925203504.7BE02C4CEF7@smtp.kernel.org/ [v1]
> Link: https://lore.kernel.org/mm-commits/20250928185232.BEDB6C4CEF0@smtp.kernel.org/ [v2]
> Link: https://lore.kernel.org/linux-mm/20251003174553.3078839-1-kartikey406@gmail.com/ [v3]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v4:
> - Simplified approach per Oscar's suggestion: check __vma_shareable_lock()
>    directly in __unmap_hugepage_range() before calling huge_pmd_unshare()
> - Removed ZAP_FLAG_NO_UNSHARE flag per David's feedback to avoid polluting
>    generic mm.h header
> - Reverted hugetlb_vmdelete_list() to not skip VMAs
> 
> Changes in v3:
> - Added ZAP_FLAG_NO_UNSHARE to skip only PMD unsharing, not entire VMA
> 
> Changes in v2:
> - Skip entire VMAs without shareable locks in hugetlb_vmdelete_list()
>    (caused PUNCH_HOLE regression)
> 
> Changes in v1:
> - Initial fix attempt
> ---
>   fs/hugetlbfs/inode.c | 10 +---------
>   mm/hugetlb.c         |  2 +-
>   2 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 9c94ed8c3ab0..1e040db18b20 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -478,14 +478,6 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>   		if (!hugetlb_vma_trylock_write(vma))
>   			continue;
>   
> -		/*
> -		 * Skip VMAs without shareable locks. Per the design in commit
> -		 * 40549ba8f8e0, these will be handled by remove_inode_hugepages()
> -		 * called after this function with proper locking.
> -		 */
> -		if (!__vma_shareable_lock(vma))
> -			goto skip;
> -
>   		v_start = vma_offset_start(vma, start);
>   		v_end = vma_offset_end(vma, end);
>   
> @@ -496,7 +488,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>   		 * vmas.  Therefore, lock is not held when calling
>   		 * unmap_hugepage_range for private vmas.
>   		 */
> -skip:
> +
>   		hugetlb_vma_unlock_write(vma);
>   	}
>   }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6cac826cb61f..9ed85ab8420e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5885,7 +5885,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   		}
>   
>   		ptl = huge_pte_lock(h, mm, ptep);
> -		if (huge_pmd_unshare(mm, vma, address, ptep)) {
> +		if (__vma_shareable_lock(vma) && huge_pmd_unshare(mm, vma, address, ptep)) {
>   			spin_unlock(ptl);
>   			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
>   			force_flush = true;

Wondering, couldn't we handle that in huge_pmd_unshare()?

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eed59cfb5d218..f167cec4a5acc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7598,13 +7598,14 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
         p4d_t *p4d = p4d_offset(pgd, addr);
         pud_t *pud = pud_offset(p4d, addr);
  
-       i_mmap_assert_write_locked(vma->vm_file->f_mapping);
-       hugetlb_vma_assert_locked(vma);
         if (sz != PMD_SIZE)
                 return 0;
         if (!ptdesc_pmd_pts_count(virt_to_ptdesc(ptep)))
                 return 0;
  
+       i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+       hugetlb_vma_assert_locked(vma);
+
         pud_clear(pud);
         /*
          * Once our caller drops the rmap lock, some other process might be

-- 
Cheers

David / dhildenb


