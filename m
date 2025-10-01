Return-Path: <linux-kernel+bounces-838655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D8BAFD57
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACAB194412C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1762652AC;
	Wed,  1 Oct 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/wvFM5P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D922EE5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310147; cv=none; b=WdZ60VrOdK/GmlQqD2d646MOOArca86xIl33ehH0Gb0E4Ur2dwaJjE8qW2qjLNKtOQJeqMVQRZCKvnj4eMZ0Jq0K6Fpay21f71991rs0dbDG6SDZhj8i2oR8Lj6Hu3X0Q1uTnEer4TiwHcrg5dr7JggJndZeU/qAokmKbb/xs6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310147; c=relaxed/simple;
	bh=gO6j74hXsrej4fZhVPr/YMp0vw+1bbYLHDEY8na/sAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSYGHWlp2vErwj+ExAJyk98yM0P3Bntb7IV0IKPhvV7zsLRdNvW9An9jSGrgZznzbV1auwDuYhd0yertNB0Nx9HdC28Ky4iIY4dv73bUV4Aft/6TbBIUIidX/DoCfpWvTCKdNIakH9kpFDf6PXVC2BpjhC6tRg8gI2K8b06b4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/wvFM5P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759310144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FXaeyfAqWaRA0FNceCpvAylAa01hDY/ZZeeh2yB8rj8=;
	b=L/wvFM5PFOBAEcAr+Urt5hQgNXNehxyPy0kIiEY8rt6wFl6ZOIEEjHJtYHW4JIkxcnWYOH
	tglC4yfeHBaHERHopHWl8xvFTZB8SaOR0a40x6mA5pUmjuoorYln3CX5F0MAQ+5sRscIl8
	3ZsuZUQdk0y6cMd2beM85fQ0f806eaI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-4h97WF8FOmK1CRr1bSIeaw-1; Wed, 01 Oct 2025 05:15:43 -0400
X-MC-Unique: 4h97WF8FOmK1CRr1bSIeaw-1
X-Mimecast-MFC-AGG-ID: 4h97WF8FOmK1CRr1bSIeaw_1759310142
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so411878f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759310142; x=1759914942;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXaeyfAqWaRA0FNceCpvAylAa01hDY/ZZeeh2yB8rj8=;
        b=Zn85j629u0QUuFwzlwwtjRl+xbFe5mzdITldXBIALF4BeEmwJqTqVMNrxLWs21pqgL
         WWUwcYeaRR7bWqeHoBPVJCNss9+5voPhuHPNAJNVLO0Zq+I62naHXUsXTKmX5o0uslmN
         BV6pJMYCjlpptOrYF8KDpkGuuH5ygkQ2UUwfuYyfyDqC80mRDWcuVlcAk8cHAkD8JlSQ
         L3yPYnvOI55KFA84hNK+evYJBrps1EubaMHZCd8Pn1lMLFW7I5WsVty0Sr05EK8t9iaZ
         x6Y0Flj+E0eHqwnf0NMketHCeS1G+mgJxUxIXZXu/wLc/SWwnmeTJkFK9xx4lFeqKPe0
         0vLw==
X-Forwarded-Encrypted: i=1; AJvYcCVpmpSuYm+CF/dbm6C7o3/181Ou4opmclqFZtoslTiYdhghAjMByMqKr1EbhJ2Gs+L39y+9T/HdqXPLGDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ovEG0yM7k5/37IweKdX4Kn8X77G9/HwG/WijFxO9YcmU1tey
	xnlkXy2ODpKHlHUhnqS9Hfac3FkiylxS2wL3PhJevgB+UzaMSiSMoW8+NxZCUU2Yfie6Z28IbRx
	7zKjfDHgclMxyrbukofSwK4U+PoAQnUwgnKYKofrQDL355v4E9ni2RkapX93mnquA9w==
X-Gm-Gg: ASbGncuhEaJbkzGq7ky4RtAsgZdUuoWfZBQ/l+B+fTZgMPC67+h3kIj9dyk3IHSInf9
	hSslBjN7XWiXyyfpG0amyD9xsZHpddEtVe8Nrj2SEOy3ub+5ytkoSV3S8NoodD54KdTle0s1bZ1
	lafG4xtkmiPmcfaiXYIV8Cczj8El7F9284toqZR0TbYTK1Q0BalmOZz9Cy3LL1K6K1Bh13Pbdd+
	tQ94l5M3/yxWXW9f4Z7n31Jwvv+V86xvTi1UZJ8IZVkrS7DX9ntaZGCt0yUu8P71hmg/mfn3F+7
	GrlB5rfPAtehdzc6Mom/eNUubsvgmSbodT36LAnmL4s0WhPrgeX6/9jzaulGZsp6KD3C2rKdxFY
	SMnmiSKl7
X-Received: by 2002:a05:6000:2c10:b0:414:c2e8:a739 with SMTP id ffacd0b85a97d-425577b43b6mr2280431f8f.31.1759310141946;
        Wed, 01 Oct 2025 02:15:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFFvlvqCMpej7RI94pKLI995PrZUfgpc71b35bS2mBtn+Dx5OH+Jmwv2gbKlHnRII+v//syQ==
X-Received: by 2002:a05:6000:2c10:b0:414:c2e8:a739 with SMTP id ffacd0b85a97d-425577b43b6mr2280355f8f.31.1759310141334;
        Wed, 01 Oct 2025 02:15:41 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4151d0ae6f9sm21782656f8f.51.2025.10.01.02.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:15:40 -0700 (PDT)
Message-ID: <ab5f77a2-c143-485d-9006-ec45493ea56c@redhat.com>
Date: Wed, 1 Oct 2025 11:15:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
To: Wei Yang <richard.weiyang@gmail.com>, Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 dev.jain@arm.com, hughd@google.com, ioworker0@gmail.com,
 kirill@shutemov.name, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <20251001085425.5iq2mgfom6sqkbbx@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251001085425.5iq2mgfom6sqkbbx@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.10.25 10:54, Wei Yang wrote:
> On Wed, Oct 01, 2025 at 11:22:51AM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Currently, special non-swap entries (like migration, hwpoison, or PTE
>> markers) are not caught early in hpage_collapse_scan_pmd(), leading to
>> failures deep in the swap-in logic.
>>
>> hpage_collapse_scan_pmd()
>> `- collapse_huge_page()
>>      `- __collapse_huge_page_swapin() -> fails!
>>
>> As David suggested[1], this patch skips any such non-swap entries
>> early. If any one is found, the scan is aborted immediately with the
>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>> work.
>>
>> [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
>> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> v1 -> v2:
>> - Skip all non-present entries except swap entries (per David) thanks!
>> - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/
>>
>> mm/khugepaged.c | 32 ++++++++++++++++++--------------
>> 1 file changed, 18 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 7ab2d1a42df3..d0957648db19 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>> 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>> 	     _pte++, addr += PAGE_SIZE) {
>> 		pte_t pteval = ptep_get(_pte);
>> -		if (is_swap_pte(pteval)) {
> 
> It looks is_swap_pte() is mis-leading?

Yeah, it nowadays includes non-swap entries as well.

Maybe we should consider renaming it at some point to something better.

-- 
Cheers

David / dhildenb


