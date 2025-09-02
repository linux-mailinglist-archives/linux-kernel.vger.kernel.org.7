Return-Path: <linux-kernel+bounces-796090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA4AB3FBCF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ABB54E053D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8337F2EDD4D;
	Tue,  2 Sep 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY83kQQv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4705220F5E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807621; cv=none; b=AWXjNcf+skewj0oGHPSM65wcUyzp60MeP346FkSk7wudxMvWQ0N8+CqYuFmP5bld7VaSyF1u2f6kG5SurfXmexTbrsMWRuKhfQDE/gsb8rG7O1PhmxASSRuyDvhzh52fKTAgqwyIuzhqgL6x5gsILU5/d4yisu8RQ7P9h6eQYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807621; c=relaxed/simple;
	bh=/OjzNObYkpSLTtKN0D3UudbxTJayX3yAACSLNVwxuAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnKcbGZHoDA0NQYYgPTgGwnEUO9nU5NY3syuW04RuM2Wbf5Mt5WopoCT/dosaj1NoTf4R8+HBFwtFrDtjttEyBBMuda2mAVkVYgjQB75Wm1LF9sQ+p4s+m+3/WCjV5KUKwOFZlO2CwLcvMZR2eH88USqCQ1JF40Z5LM0XJmLBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LY83kQQv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756807618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yQBjL6Mz1yywDE3JBeNxw+HRiz9wSeKoX5ELaLVEmP0=;
	b=LY83kQQvetausL4t2XKXQqjAgpUCWpVxI0PLM1Ehn2Hy2a5OII4lxhee042RGWcsPRdZHZ
	gdd1jueyIJpAe+MkL2RtLcN8Xs3rqrdv5rs8ytYbZ1YihJgdLWyQkUnWIe/D+Z63s7uYfm
	pmODCzQx15yLehy6a0KekFlS7FwAFrs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Gr90afrROqGqE4GVj7_fDA-1; Tue, 02 Sep 2025 06:06:57 -0400
X-MC-Unique: Gr90afrROqGqE4GVj7_fDA-1
X-Mimecast-MFC-AGG-ID: Gr90afrROqGqE4GVj7_fDA_1756807616
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ce3e098c48so3368145f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807616; x=1757412416;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQBjL6Mz1yywDE3JBeNxw+HRiz9wSeKoX5ELaLVEmP0=;
        b=fIDCp4/d6afOGtYJIyo+lTyoum6ETR/P0/sU7MI2OMPm5qKwsnB5Fs6SaffS7lxM7L
         nHF3i5oDCuSdvXcOus5m8WsaIk2E2oJbsd9/qavQNQ9NiQ08tpP1SkpbCsh9Huqd+Q6S
         EYwBxBdvuYnQjilbRzwvD5EqVXrO4ffNxty6X1XEpMgxWFxm7STnnriDdmpMBzgiOWHH
         SbbU5s2cQmKlagIYGl9TBnxdQWfh7u8awi3mKl8dAG+JDsq3SSxY+9xlFfbMRq+VPy/T
         0bL+U5faPji0PLfVhUKA79zPmLnmlvaD5Ud/wPufsg0dWiFR+ZBos2PvkHS5oPJscP8b
         VxKw==
X-Forwarded-Encrypted: i=1; AJvYcCXTBitNg+uchu71EfYT+94JJQjMd1znesslyWCJAMeQRNGlMMZAzbkGcDBK6ERdmPO0DncCt9t/ME9saCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/C8BL2q63M2lzlnm4E8VbghQPU8CUzByMC3UgIn3ttHSEueiO
	kHGXGnZIY1eigycH8IOu2zaa61IeIFkiSjKRuVVc6KrwlkMNN3sK22aS8r7e4QaiYw1QRmsIaSr
	NJwVOZeoDmF8QXUpedBSsvbQyFqyqPqREQH0FHxYCYVFRGCrJYXGzGDZgi9UqeM2BQw==
X-Gm-Gg: ASbGncsY4qwUIXZlfTyK0eHxj5Bb+Q3thZYqtg9Xq7hWV2C6M0cLWFcHf2JqygunqzI
	fYpX3GQ7ulZBTTcsTWtFV6743++JyfFLZ/dhjaU8KiNSgSShGNFvTzKSWXDmbZ9mLObT98v2zO0
	kFbxHc5CUvIWNPzOztBiI4fnvGUsDa+vnCckp8bbP32GGWAuf3Q3lb9I/3IP3J7KptLbPN6gzCj
	HAuHeeLh3HJb5OitkIGvxQJ4ACw8GqJqEFATr5A5d3T49K2mz+W7DFTi6ohSCwHGNe5eapTNMqP
	CWd4EaNEEAczKmsx12CSlYmIN3tB6oUPEvRUpdbFkgXImJla9EnSeqXVq9tDFamRrWDl8KtPkbP
	RfG616fXfOB8nTmurYhz+KmitXZRW7cz01ZFmA2MLqTcyqvqJG7VIxNPkmTx3B51HaME=
X-Received: by 2002:a05:6000:2307:b0:3ce:f9b7:4db with SMTP id ffacd0b85a97d-3d1de6a8dc5mr9225613f8f.24.1756807615827;
        Tue, 02 Sep 2025 03:06:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN/f0bU7xidso2QGDLy/JmGY1w4j+2LPFKqk9bXnHh6iqP3ESV1ILbYveFavO2boVsWDG8fQ==
X-Received: by 2002:a05:6000:2307:b0:3ce:f9b7:4db with SMTP id ffacd0b85a97d-3d1de6a8dc5mr9225572f8f.24.1756807615283;
        Tue, 02 Sep 2025 03:06:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b945332adsm36060615e9.4.2025.09.02.03.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:06:54 -0700 (PDT)
Message-ID: <c4a729b8-be9e-4005-aab6-91723fcf0080@redhat.com>
Date: Tue, 2 Sep 2025 12:06:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-2-ryncsn@gmail.com>
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
In-Reply-To: <20250822192023.13477-2-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 21:20, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Always use swap_cache_get_folio for swap cache folio look up. The reason
> we are not using it in all places is that it also updates the readahead
> info, and some callsites want to avoid that.
> 
> So decouple readahead update with swap cache lookup into a standalone
> helper, let the caller call the readahead update helper if that's
> needed. And convert all swap cache lookups to use swap_cache_get_folio.
> 
> After this commit, there are only three special cases for accessing swap
> cache space now: huge memory splitting, migration and shmem replacing,
> because they need to lock the Xarray. Following commits will wrap their
> accesses to the swap cache too with special helpers.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   mm/memory.c      |  6 ++-
>   mm/mincore.c     |  3 +-
>   mm/shmem.c       |  4 +-
>   mm/swap.h        | 13 +++++--
>   mm/swap_state.c  | 99 +++++++++++++++++++++++-------------------------
>   mm/swapfile.c    | 11 +++---
>   mm/userfaultfd.c |  5 +--
>   7 files changed, 72 insertions(+), 69 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d9de6c056179..10ef528a5f44 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4660,9 +4660,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	if (unlikely(!si))
>   		goto out;
>   
> -	folio = swap_cache_get_folio(entry, vma, vmf->address);
> -	if (folio)
> +	folio = swap_cache_get_folio(entry);
> +	if (folio) {
> +		swap_update_readahead(folio, vma, vmf->address);
>   		page = folio_file_page(folio, swp_offset(entry));
> +	}
>   	swapcache = folio;
>   
>   	if (!folio) {
> diff --git a/mm/mincore.c b/mm/mincore.c
> index 2f3e1816a30d..8ec4719370e1 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -76,8 +76,7 @@ static unsigned char mincore_swap(swp_entry_t entry, bool shmem)
>   		if (!si)
>   			return 0;
>   	}
> -	folio = filemap_get_entry(swap_address_space(entry),
> -				  swap_cache_index(entry));
> +	folio = swap_cache_get_folio(entry);
>   	if (shmem)
>   		put_swap_device(si);
>   	/* The swap cache space contains either folio, shadow or NULL */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 13cc51df3893..e9d0d2784cd5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2354,7 +2354,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   	}
>   
>   	/* Look it up and read it in.. */
> -	folio = swap_cache_get_folio(swap, NULL, 0);
> +	folio = swap_cache_get_folio(swap);
>   	if (!folio) {
>   		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
>   			/* Direct swapin skipping swap cache & readahead */
> @@ -2379,6 +2379,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   			count_vm_event(PGMAJFAULT);
>   			count_memcg_event_mm(fault_mm, PGMAJFAULT);
>   		}
> +	} else {
> +		swap_update_readahead(folio, NULL, 0);
>   	}
>   
>   	if (order > folio_order(folio)) {
> diff --git a/mm/swap.h b/mm/swap.h
> index 1ae44d4193b1..efb6d7ff9f30 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -62,8 +62,7 @@ void delete_from_swap_cache(struct folio *folio);
>   void clear_shadow_from_swap_cache(int type, unsigned long begin,
>   				  unsigned long end);
>   void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
> -struct folio *swap_cache_get_folio(swp_entry_t entry,
> -		struct vm_area_struct *vma, unsigned long addr);
> +struct folio *swap_cache_get_folio(swp_entry_t entry);
>   struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   		struct vm_area_struct *vma, unsigned long addr,
>   		struct swap_iocb **plug);
> @@ -74,6 +73,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>   		struct mempolicy *mpol, pgoff_t ilx);
>   struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
>   		struct vm_fault *vmf);
> +void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
> +			   unsigned long addr);
>   
>   static inline unsigned int folio_swap_flags(struct folio *folio)
>   {
> @@ -159,6 +160,11 @@ static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
>   	return NULL;
>   }
>   
> +static inline void swap_update_readahead(struct folio *folio,
> +		struct vm_area_struct *vma, unsigned long addr)
> +{
> +}
> +
>   static inline int swap_writeout(struct folio *folio,
>   		struct swap_iocb **swap_plug)
>   {
> @@ -169,8 +175,7 @@ static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entr
>   {
>   }
>   
> -static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
> -		struct vm_area_struct *vma, unsigned long addr)
> +static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
>   {
>   	return NULL;
>   }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 99513b74b5d8..ff9eb761a103 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -69,6 +69,21 @@ void show_swap_cache_info(void)
>   	printk("Total swap = %lukB\n", K(total_swap_pages));
>   }
>   
> +/*

While at it, proper kerneldoc?

/**

etc.

Also documenting that it will only return a valid folio pointer or NULL

> + * Lookup a swap entry in the swap cache. A found folio will be returned
> + * unlocked and with its refcount incremented.
> + *
> + * Caller must lock the swap device or hold a reference to keep it valid.
> + */
> +struct folio *swap_cache_get_folio(swp_entry_t entry)
> +{
> +	struct folio *folio = filemap_get_folio(swap_address_space(entry),
> +						swap_cache_index(entry));
> +	if (!IS_ERR(folio))
> +		return folio;
> +	return NULL;

Maybe better as (avoid one !)

if (IS_ERR(folio))
	return NULL;
return folio;

or simply

return IS_ERR(folio) ? NULL : folio.

> +}
> +
>   void *get_shadow_from_swap_cache(swp_entry_t entry)
>   {
>   	struct address_space *address_space = swap_address_space(entry);
> @@ -273,54 +288,40 @@ static inline bool swap_use_vma_readahead(void)
>   }
>   
>   /*
> - * Lookup a swap entry in the swap cache. A found folio will be returned
> - * unlocked and with its refcount incremented - we rely on the kernel
> - * lock getting page table operations atomic even if we drop the folio
> - * lock before returning.
> - *
> - * Caller must lock the swap device or hold a reference to keep it valid.
> + * Update the readahead statistics of a vma or globally.
>    */
> -struct folio *swap_cache_get_folio(swp_entry_t entry,
> -		struct vm_area_struct *vma, unsigned long addr)

This also sounds like a good kerneldoc candidate :)

In particular, documenting that it is valid to pass in vma == NULL (in 
which case the addr is ignored).

> +void swap_update_readahead(struct folio *folio,
> +			   struct vm_area_struct *vma,
> +			   unsigned long addr)
>   {


Apart from that LGTM.

-- 
Cheers

David / dhildenb


