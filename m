Return-Path: <linux-kernel+bounces-876429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C28C1BBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219DF583738
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DC02153FB;
	Wed, 29 Oct 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PL6EeOVi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0B1FF1AD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749123; cv=none; b=VdK2z6vl0NajAETQ17fPXsidZr5LyEjyF4B9WVTWyDjH3IsIHgg2hBstNWVDeDgoINNwbVCpOfykSqcnJnmy/wp8kM1xdL7Nol6NPpAGshdUPC5M2jXcSbWG3RQx9jDU5l7S2P5MvuYinhdYkT2MEZEvEmmtH1tMniK01UVYRW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749123; c=relaxed/simple;
	bh=029lJusyETxpw1WBHkIOQjKCi2ec+/SDdWCx5N1rr+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSqbG4s0jNciQZZrt3yXn0eD6Sf8zJ1VV4s/9K39iCEkhG0kjejd9CNZknjnRdXg56Jy9bZdcgFiq8g8S/Dsc0K/Ch+1NBL/aFm2lMhpNZimCCBiCj19yjExvJS7J36UvDdwis88MJEr2ynL/pGCTua8IqRnqJPs3QRRdmbZME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PL6EeOVi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761749120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U8B4g45kp6nicUbsj93IKXnwrHXTFyUlyH0y3Ghhzkk=;
	b=PL6EeOVixUeINeKDfekDlxMDl3VJmRDSGfzA6ROygQH2OY/XMtRFiWRuxapJ/0yxqehlun
	AdWX7QWarloCvtwHABh/dXRFcyL9W6IL5phj3MVaqBoVXPatiJbU65wqYeae4OV0klDDv4
	VGR7dkO3KkAxZN0JHJinkji98lVm67E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-u9BiyOPrMgmwERMsF3USyA-1; Wed, 29 Oct 2025 10:45:19 -0400
X-MC-Unique: u9BiyOPrMgmwERMsF3USyA-1
X-Mimecast-MFC-AGG-ID: u9BiyOPrMgmwERMsF3USyA_1761749117
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4278c82dce6so4362317f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749117; x=1762353917;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8B4g45kp6nicUbsj93IKXnwrHXTFyUlyH0y3Ghhzkk=;
        b=QeBuW0KuoSdJP1tEb+JG2khcHnPDwD7SWnRXwrq48pGaRJh8fYEwAx5dbXAfA6pvYR
         LEQhxpZWkLaRbalYmCfTL9bcY/iBW7aE0dSsCkF7zHBc9V95v9EU2J6JFxzSpKjzYgvJ
         oXBy7fI2bWtixn3zHFe5SwBhj0vCMOkM89YJWy3/Cbpp63T0FWKS9JSVhGhplPxnpIiG
         AliIUdxwz7DD1u0saKzjjrBHBiIYNGZAE2kdVDtY0HU0ZkOMDM9X/GYmJgi3SIx4mEtm
         QDDVf/ProhaxMdxJ/Zd6f1ZvAL+ebFsVWidgmUhieZjxixHypLQBFsV6zfmDCe7/G5mf
         dF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgYcFN8lrdc2DphiA7JI/GxjMob2C5LmIkbtLFC9Zf+/IEwnciY7i19Dqidaj49cgzT/6iQxpaPYVSB8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzodGLr2jlhv26T6pbWMoU5xPt1zRGkmQ3dGEJ6X3SDeoSgrOE0
	kxqCef18qlKMUazxTak9gG410ZjQdAen/ewMaSZgTc9Anow9ZXc6Q+xmeT8MDubRyyWRrWRlfp7
	K4msWqMAtyFYg4QkmenA0t64hxy0hTSPvibd7ImwvOyVSsRANLkkz/DYoq0FqMo5IGQ==
X-Gm-Gg: ASbGncsOvt+qJXk2hVyZYq21zxUEe1MpEPdF4sp0v8lc2j81ued4DtdJpg2oivBSLkx
	7xOV4dNQ/vjgWKjFdjX9RgUppg5+UavRvVRc5XnRnQFlb3vyPyARjx1MZpg/J6JYMYOYr8Nhayt
	csHFpEP5/OzTTd9xvinspQDK0QBDvYpbTIvWbUO9AoSzNUcTvw69XGVBnZ91YOlOM0x82RoWJ1D
	cfAC5dkH3iQD+eARgxIzHVtX+QTGX7g4DRy5XlajrsU+Fs/6DE/zELyrUdnzMh8sKURHJNxkv5+
	yqKPaQ3fhHeOIYPNpqRIq8eUg6Gp49ORSbfvdgHkpFB7fAyUl5k2kTCY7t3LrtToHnysMu3dTbQ
	dE2wj9UNvbTLm/Ynjrzyadw==
X-Received: by 2002:a05:6000:1a8a:b0:429:9197:5b31 with SMTP id ffacd0b85a97d-429aefcaa88mr2902481f8f.53.1761749116799;
        Wed, 29 Oct 2025 07:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxd2TGV6BAsL1K32rrif55rVqRiYFEJwT8e1K7hi0Pnz4IHJEgWL6tCAfAxRD2v1FARSiHDQ==
X-Received: by 2002:a05:6000:1a8a:b0:429:9197:5b31 with SMTP id ffacd0b85a97d-429aefcaa88mr2902456f8f.53.1761749116239;
        Wed, 29 Oct 2025 07:45:16 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5768sm27419982f8f.24.2025.10.29.07.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:45:15 -0700 (PDT)
Message-ID: <85604399-40a8-4d13-809d-e5492e74a988@redhat.com>
Date: Wed, 29 Oct 2025 15:45:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ksm: perform a range-walk in break_ksm
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251028131945.26445-1-pedrodemargomes@gmail.com>
 <20251028131945.26445-3-pedrodemargomes@gmail.com>
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
In-Reply-To: <20251028131945.26445-3-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 14:19, Pedro Demarchi Gomes wrote:
> Make break_ksm() receive an address range and change
> break_ksm_pmd_entry() to perform a range-walk and return the address of
> the first ksm page found.
> 
> This change allows break_ksm() to skip unmapped regions instead of
> iterating every page address. When unmerging large sparse VMAs, this
> significantly reduces runtime, as confirmed by benchmark test (see
> cover letter).

Instead of referencing the cover letter, directly include the data here.

> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   mm/ksm.c | 88 +++++++++++++++++++++++++++++++-------------------------
>   1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 2a9a7fd4c777..1d1ef0554c7c 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -607,34 +607,54 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>   	return atomic_read(&mm->mm_users) == 0;
>   }
>   
> -static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> +struct break_ksm_arg {
> +	unsigned long addr;
> +};

You can avoid that by simply passing a pointer to addr.

> +
> +static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   			struct mm_walk *walk)
>   {
> -	struct page *page = NULL;
> +	struct page *page;
>   	spinlock_t *ptl;
> -	pte_t *pte;
> -	pte_t ptent;
> -	int ret;
> +	pte_t *start_ptep = NULL, *ptep, pte;

Is there a need to initialize start_ptep?

> +	int ret = 0;
> +	struct mm_struct *mm = walk->mm;
> +	struct break_ksm_arg *private = (struct break_ksm_arg *) walk->private;

Prefer reverse xmas tree:

struct break_ksm_arg *private = (struct break_ksm_arg *) walk->private;
struct mm_struct *mm = walk->mm;
...

With the break_ksm_arg simplification you'd had

unsigned long *found_addr = (unsigned long *)walk->private;


>   
> -	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> -	if (!pte)
> +	if (ksm_test_exit(walk->mm))
>   		return 0;
> -	ptent = ptep_get(pte);
> -	if (pte_present(ptent)) {
> -		page = vm_normal_page(walk->vma, addr, ptent);
> -	} else if (!pte_none(ptent)) {
> -		swp_entry_t entry = pte_to_swp_entry(ptent);
>   
> -		/*
> -		 * As KSM pages remain KSM pages until freed, no need to wait
> -		 * here for migration to end.
> -		 */
> -		if (is_migration_entry(entry))
> -			page = pfn_swap_entry_to_page(entry);
> +	if (signal_pending(current))
> +		return -ERESTARTSYS;

I assume that's not a problem for the other callsites that wouldn't 
check this before.

> +
> +	start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +	if (!start_ptep)
> +		return 0;
> +
> +	for (ptep = start_ptep; addr < end; ptep++, addr += PAGE_SIZE) {

Best to declare pte and folio (see last mail) here in the loop:

	pte_t pte = ptep_get(ptep);
	struct folio *folio = NULL;

> +		pte = ptep_get(ptep);
> +		page = NULL;
> +		if (pte_present(pte)) {
> +			page = vm_normal_page(walk->vma, addr, pte);
> +		} else if (!pte_none(pte)) {
> +			swp_entry_t entry = pte_to_swp_entry(pte);
> +
> +			/*
> +			 * As KSM pages remain KSM pages until freed, no need to wait
> +			 * here for migration to end.
> +			 */
> +			if (is_migration_entry(entry))
> +				page = pfn_swap_entry_to_page(entry);
> +		}
> +		/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> +		ret = (page && folio_test_ksm(page_folio(page))) || is_ksm_zero_pte(pte);
> +		if (ret) {
> +			private->addr = addr;
> +			goto out_unlock;
> +		}

I suggest you call "ret" "found" instead.

>   	}
> -	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> -	ret = (page && folio_test_ksm(page_folio(page))) || is_ksm_zero_pte(ptent);
> -	pte_unmap_unlock(pte, ptl);
> +out_unlock:
> +	pte_unmap_unlock(ptep, ptl);
>   	return ret;
>   }
>   
> @@ -661,9 +681,11 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
>    * of the process that owns 'vma'.  We also do not want to enforce
>    * protection keys here anyway.
>    */
> -static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_vma)
> +static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
> +		unsigned long end, bool lock_vma)
>   {
>   	vm_fault_t ret = 0;
> +	struct break_ksm_arg break_ksm_arg;
>   	const struct mm_walk_ops *ops = lock_vma ?
>   				&break_ksm_lock_vma_ops : &break_ksm_ops;
>   
> @@ -671,11 +693,10 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
>   		int ksm_page;
>   
>   		cond_resched();
> -		ksm_page = walk_page_range_vma(vma, addr, addr + 1, ops, NULL);
> -		if (WARN_ON_ONCE(ksm_page < 0))
> +		ksm_page = walk_page_range_vma(vma, addr, end, ops, &break_ksm_arg);
> +		if (ksm_page <= 0)
>   			return ksm_page;
> -		if (!ksm_page)
> -			return 0;
> +		addr = break_ksm_arg.addr;
>   		ret = handle_mm_fault(vma, addr,
>   				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
>   				      NULL);
> @@ -761,7 +782,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
>   	mmap_read_lock(mm);
>   	vma = find_mergeable_vma(mm, addr);
>   	if (vma)
> -		break_ksm(vma, addr, false);
> +		break_ksm(vma, addr, addr + 1, false);

Better to use addr + PAGE_SIZE

-- 
Cheers

David / dhildenb


