Return-Path: <linux-kernel+bounces-857147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0CBE6091
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137925E3E30
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EA8221543;
	Fri, 17 Oct 2025 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdM5qpIW"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11520297E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760664448; cv=none; b=uicIoDqePtNJE4FpAPAmitDMu4B054MBMQsaalQmbGA/i1fr6NKbnf/byCOD9AISaRh5We3ojhk/l12aLvkA7C9+JTfwX8NaaG/4fOOoXgrnPY236iok+YFGvyrbbw59gD0/v9+izMZAsNgpGWzE81W50nkDn3r8yw/caLR4wqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760664448; c=relaxed/simple;
	bh=LnnvdTSOkEWVM7Fr1wE40a3/3/XIdKXdhXj9eV6Jx5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxoQn6woc4f25WGkT5C1RI8m6Vd6J1uAZkD3WFgJcOTifHLbsDZcskuBdYUYOHTTlzs5sMEE6amdnImdueYJLbA9eh3zBKptsfC62ODuUkmzi70tj6DyYN7k32PNil4f7j7g6aaygDi1m/fvMHRyE95SspQU3vo27AEIz5h/3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdM5qpIW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b48d8deaef9so267924566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760664445; x=1761269245; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toN8uDcHs2UA1ksRfEWAocNXcohSpkKSetMRHMkBztA=;
        b=QdM5qpIWid+9Accll4vTtrUjPGsRkaPaIZwq9DCNeCyX7GXozaHHqov/rmAKWbRt8w
         Rzq5OSCLelnZpYQX5rivDU99oLEGYJ327sz7hUX0Uld8MYrlVqD3FtRquBD/1svseWpL
         a8MHG/8NkUxFGun6RRmZXxsH8T5esFqo+GB2QrYRkXLS3XQir9bWU89465jU65O145VM
         aMmsj0ABqyUU/JREolqciiO14MN/0Y47yj1lZ64fsPOXJHBPeSbNPWBI3KJbTOVCxFJt
         gxznmvfsRDoyMymsPXynRpp4y6R4zAtZzKLziifszWTdis013z7/SRKsFPDFFvrNtd7b
         CLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760664445; x=1761269245;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=toN8uDcHs2UA1ksRfEWAocNXcohSpkKSetMRHMkBztA=;
        b=PVo+ZNbfmOlNQRcUsB5wdm3VUqcmpzr3ugD+hnKJEXnEb27UTBgLR9nxL98owP/INq
         cyZPd+FlaZsHHzKtHBScjNT5uGrYfxpmhhIkOl+ICtz2mIlaW4zIbJNGiyPZqsh+H8Cg
         uvksRLTmyYXb7/SDpDqUThcHqt7kc6EX5Yhxk6iMjvzLz2O+QfWS/mFWDDbXi66B7xuo
         I5F+uFzFC5JAe/DDc34J2K3x2OTEW5VTeNidR+8oQLRPZz5VWlU5f48j123BDU8IRgWY
         rNRTfJR231uJ+Ww05ec+Ck4BTadHqqyo/JHRB4xGbbyD59lzq0moQJTjDB2Lq9/e7RId
         xe6A==
X-Forwarded-Encrypted: i=1; AJvYcCXUThc83af8Ea1X9VWKxSZJiQwPTSXA56kiZKL4wARUu8P4Uz1gemTm+KeVY+TWfHwRZa9suwV9TL44rmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKFyP6ilcQRLX0eZpw4OYPILGE48lyCiNQTgg7mBOyVfyZSi8
	k03GtVQAmGvV1h/mQtOdBeLkGWNcBKLFMCNULiadem1nhJUxfAE6fXee
X-Gm-Gg: ASbGncvBRMbpv09EQ1p9H2DYSc0ZqQjcA7kAIiGZdSiF7LuyZHuNklV4OlvhKIZpjW9
	VLDv1Bsff7DufwUEusDY4hkZ6dFrCclx9qMFSiefvmTzTGEr1+CXLvHP7uwvaujNl8854X6MOW4
	Pw3C9FNj4ML5LJyG7oaQWwqTVEQE7SCy2xGSfRRM57jizcBHVLxKBBE6LSbztuzLGnBQ2065VpY
	d6Qoll7qDN52gVtrFH5szx0ypWFYq97rNqYpaTJnAHCWyPI1DIHFjsZWy7tYI+rckwPRCLodmvV
	YmUqNHGYh9orcmKqYyN2r5q/090ltt5zDXa6olFGwKhkI5UB8ErMKLmqHCoYijKQ16jyA/BnHtI
	TPyyA29OX+7YaruafcFBNJoEJlS94SJApkwlvH6fpWHRMFiCHH8yhe6tpAPJklADiOEZeJD+bto
	z5MV0=
X-Google-Smtp-Source: AGHT+IFUmSUGHTa+ZyXOVo0fn2Et40lgRl36aDqlQg4U7gnNhP3iSC3H9vQYVs/vX439nT0/+aepnQ==
X-Received: by 2002:a17:907:3ea6:b0:b46:31be:e8ea with SMTP id a640c23a62f3a-b646ec7e5bemr217152666b.0.1760664445061;
        Thu, 16 Oct 2025 18:27:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd6b03f3sm653857266b.74.2025.10.16.18.27.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Oct 2025 18:27:24 -0700 (PDT)
Date: Fri, 17 Oct 2025 01:27:24 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
	ioworker0@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with
 pte_present()
Message-ID: <20251017012724.4bo5oj2g6tdmp2fv@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251016033643.10848-1-lance.yang@linux.dev>
 <17c4c5f9-6ac8-4914-838f-f511dfbf948f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c4c5f9-6ac8-4914-838f-f511dfbf948f@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Oct 16, 2025 at 11:47:06AM +0530, Dev Jain wrote:
>
>On 16/10/25 9:06 am, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>> 
>> A non-present entry, like a swap PTE, contains completely different data
>> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
>> non-present entry, it will spit out a junk PFN.
>> 
>> What if that junk PFN happens to match the zeropage's PFN by sheer
>> chance? While really unlikely, this would be really bad if it did.
>> 
>> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
>> in khugepaged.c are properly guarded by a pte_present() check.
>> 
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>> 
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index d635d821f611..0341c3d13e9e 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>>   		pte_t pteval = ptep_get(_pte);
>>   		unsigned long pfn;
>> -		if (pte_none(pteval))
>> +		if (!pte_present(pteval))
>>   			continue;
>>   		pfn = pte_pfn(pteval);
>>   		if (is_zero_pfn(pfn))
>> @@ -690,9 +690,10 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>>   	     address += nr_ptes * PAGE_SIZE) {
>>   		nr_ptes = 1;
>>   		pteval = ptep_get(_pte);
>> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> +		if (pte_none(pteval) ||
>> +		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
>>   			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
>> -			if (is_zero_pfn(pte_pfn(pteval))) {
>> +			if (!pte_none(pteval)) {
>
>Could save a level of indentation by saying
>if (pte_none(pteval))
>    continue;
>

Vote for this :-)

No other comment.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

