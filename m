Return-Path: <linux-kernel+bounces-836153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F16BA8E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1BB17895D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC22FBDE0;
	Mon, 29 Sep 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wid7aqin"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958F1A9FBD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141782; cv=none; b=a0yLMbXYUi3rtBGTaHFry68obZufBHzn7qgqKOjp/COyJWzg6lYF3oFXSKDYShcD31rEKvzsWD9UnQXx2o92DclNKWxjEYOVXo5gnWRLZKJ+rC7tQpTmEsShzkoGWB54dWx5iO1K0GB7LCHeA0OghStRgY0fTYwFkwEG5iuoLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141782; c=relaxed/simple;
	bh=eEiPHfTMmuwOrZDzHfXf2xPKPKN4D5mbPkOeG0QGAio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rz4txzGEbA2Y9OQxX9gtnEwROqlMVV81rnLEZiXMkqqycFS/5EPcW1sLDQHCBbG5ovKJ4LKIp5nzs8S3n/S6hMRLK+usoWxJUAwTb20K5513+h7pJrZaD5a8REZFd/Jcs8oPEs2SkX7M9v/uNrI8zOX94SY+asoiOBDejhMMSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wid7aqin; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759141779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WXWt4HHulcMFjL1Aq+0YxiHfHwYLE0hFtn8pXo5MFNg=;
	b=Wid7aqinmg2iLXj3HURYCA7PZkqnly0f09e0aUuZ4Krwl7ma3Jq6yORHxKSyMJxPSKrtrU
	IKS/larvDdwcJvzR7M2XzB0lr8ovpj9rsTm6LB4amGaPF3AVPrdEIrHnWb65QmzbmVXia9
	uhGfyCRPrOLDwbpGmYMTn9/9xR7CpWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-iNc9q9EaOCWSBMX_Hug8Qw-1; Mon, 29 Sep 2025 06:29:37 -0400
X-MC-Unique: iNc9q9EaOCWSBMX_Hug8Qw-1
X-Mimecast-MFC-AGG-ID: iNc9q9EaOCWSBMX_Hug8Qw_1759141776
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f3c118cbb3so2854628f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759141776; x=1759746576;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXWt4HHulcMFjL1Aq+0YxiHfHwYLE0hFtn8pXo5MFNg=;
        b=OwxixJaIgXkeBNVv42acOlIbuygrJgkOM0Ul/2OZXQdPjuaZfjtHAeFpGa98iv07aa
         pt65pFIGXs/IjX5oH7vjJ+Ts+F/AxME3QUWZwnpZ9GzAPg1eEzxpCsFWChATaVECZWV2
         Of67bj7SEvYhMVm47tbOLbJKcrUDoKfV34mli3q6935PLVuDjMYhTFrm/4veIJGxZzGG
         LdNDRVuoDMxSpeyQHwEac/99Bsk7z3GLnrvQoo2Aop3cY9QUl6BXuiQB/0RHRTzctFtD
         DtO7+is9FqKFl9+CY2uC5vqSNhdK5y+ZYKNK5ejmUqV4C6ntDP6mFU2v7CRHb5AvVgxf
         6Ngg==
X-Forwarded-Encrypted: i=1; AJvYcCULHGE5zSZ/VhspWGGeTSQEcYNKseazKAUzpXbaMTTrSwbGqi7CxOL3HR6DckbmgxWmK9SCLy1RiqpM+b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHI5Lg0tHWtsXSA+TLH9YWjBqRSZSR954GON/d+50pQYLqJS15
	M3/R7h7M2uUSlyFlB+3CptHw8ZOSZ6Lif0MPOJpOXUXdniv+ACy6dO9nOavSKFbODHbrLOKU1Ng
	u4OfvaQPz6fLCDAv+XTOsztKTlicxodqEIBHNAS9qqNxJU57i/0plX0zJ7kyCtVvVGw==
X-Gm-Gg: ASbGnctf3S0vH97BtIqKc109Yu9+zRe1rwua23PTKgNhwooKPk2QaJI8vpA8XI/mLRo
	bVA5NzLwFexjiX0pxQwn16WtdGLEeocUtGrWUWhSTOi4fdsRudfK3ydXu3YXIN3RY3odzcVSSy6
	Dft3OrmYEaKvRHlrq03Uo9rYwBlkBIx5BJl7KslaDJBJUiaEP4pZAkS4W+fTyIuf2/yj1lBEif7
	hD+UZSEwwQHWAeNVZAd7598sVpU/z7389Tc78s3Jb1gy7b6akmWBNZdVHeJCGKjavhTE80RsuFX
	u6MQaqj3LMny+CMafUcu48TkP07TGo7oORRBKKOeYKvYIM5300MocxFxHYpUZSRk5xRM/OZcLnP
	CfgwMf2VzZ+JdGtT22naEFwf1ct5Eskpbpv1FaB9jSGFWjYHMm3ZOIzs2apfDCgPvAg==
X-Received: by 2002:a05:6000:2907:b0:3eb:bbd9:9c08 with SMTP id ffacd0b85a97d-40e499acbc1mr14205638f8f.46.1759141776227;
        Mon, 29 Sep 2025 03:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpBPmaV6bO3po2pQHWtcJCjnCiYBuNOTjULPKnCP+e6Ia2o8aSMMd4yg5DwnQ5GTdH7hrSzg==
X-Received: by 2002:a05:6000:2907:b0:3eb:bbd9:9c08 with SMTP id ffacd0b85a97d-40e499acbc1mr14205609f8f.46.1759141775809;
        Mon, 29 Sep 2025 03:29:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f05:e100:526f:9b8:bd2a:2997? (p200300d82f05e100526f09b8bd2a2997.dip0.t-ipconnect.de. [2003:d8:2f05:e100:526f:9b8:bd2a:2997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb017sm17722543f8f.3.2025.09.29.03.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:29:35 -0700 (PDT)
Message-ID: <d7012c9c-f4a9-4d49-a921-2cc175f3411d@redhat.com>
Date: Mon, 29 Sep 2025 12:29:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: abort collapse scan on non-swap
 entries
To: Lance Yang <lance.yang@linux.dev>
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com,
 akpm@linux-foundation.org
References: <20250924100207.28332-1-lance.yang@linux.dev>
 <1282de5a-3dce-443d-91d1-111103140973@redhat.com>
 <69621b58-5142-48ea-9dd8-6baed69e50f8@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <69621b58-5142-48ea-9dd8-6baed69e50f8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.09.25 13:47, Lance Yang wrote:
> 
> 
> On 2025/9/24 18:10, David Hildenbrand wrote:
>> On 24.09.25 12:02, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> The existing check in hpage_collapse_scan_pmd() is specific to uffd-wp
>>> markers. Other special markers (e.g., GUARD, POISONED) would not be
>>> caught
>>> early, leading to failures deeper in the swap-in logic.
>>>
>>> hpage_collapse_scan_pmd()
>>>    `- collapse_huge_page()
>>>        `- __collapse_huge_page_swapin() -> fails!
>>>
>>> As David suggested[1], this patch skips any such non-swap entries early.
>>> If a special marker is found, the scan is aborted immediately with the
>>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>>> work.
>>
>> Note that I suggested to skip all non-present entries except swap
>> entries, which includes migration entries, hwpoisoned entries etc.
> 
> Oops, I completely misunderstood your suggestion :(
> 
> It should be to handle all special non-present entries (migration,
> hwpoison, markers), not just a specific type of marker ...
> 
> How about this version, which handles all non-swap entries as you
> suggested?
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 7ab2d1a42df3..27f432e7f07c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct
> mm_struct *mm,
>           for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>                _pte++, addr += PAGE_SIZE) {
>                   pte_t pteval = ptep_get(_pte);
> -               if (is_swap_pte(pteval)) {
> +               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> +                       ++none_or_zero;
> +                       if (!userfaultfd_armed(vma) &&
> +                           (!cc->is_khugepaged ||
> +                            none_or_zero <= khugepaged_max_ptes_none)) {
> +                               continue;
> +                       } else {
> +                               result = SCAN_EXCEED_NONE_PTE;
> +                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +                               goto out_unmap;
> +                       }
> +               } else if (!pte_present(pteval)) {
> +                       if (non_swap_entry(pte_to_swp_entry(pteval))) {
> +                               result = SCAN_PTE_NON_PRESENT;
> +                               goto out_unmap;
> +                       }
> +
>                           ++unmapped;
>                           if (!cc->is_khugepaged ||
>                               unmapped <= khugepaged_max_ptes_swap) {
> @@ -1293,7 +1309,7 @@ static int hpage_collapse_scan_pmd(struct
> mm_struct *mm,
>                                    * enabled swap entries.  Please see
>                                    * comment below for pte_uffd_wp().
>                                    */
> -                               if (pte_swp_uffd_wp_any(pteval)) {
> +                               if (pte_swp_uffd_wp(pteval)) {
>                                           result = SCAN_PTE_UFFD_WP;
>                                           goto out_unmap;
>                                   }
> @@ -1304,18 +1320,6 @@ static int hpage_collapse_scan_pmd(struct
> mm_struct *mm,
>                                   goto out_unmap;
>                           }
>                   }
> -               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> -                       ++none_or_zero;
> -                       if (!userfaultfd_armed(vma) &&
> -                           (!cc->is_khugepaged ||
> -                            none_or_zero <= khugepaged_max_ptes_none)) {
> -                               continue;
> -                       } else {
> -                               result = SCAN_EXCEED_NONE_PTE;
> -                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> -                               goto out_unmap;
> -                       }
> -               }
>                   if (pte_uffd_wp(pteval)) {

 From a quick glimpse, this should work. And as raised, we might be able 
to unify later the scanning with the almost-duplicated code when we do 
the second scan.

-- 
Cheers

David / dhildenb


