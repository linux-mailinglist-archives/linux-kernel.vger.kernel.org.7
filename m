Return-Path: <linux-kernel+bounces-794692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7241BB3E5D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220803A4DF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA063375AB;
	Mon,  1 Sep 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaNBY+Wd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3162773F5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734231; cv=none; b=QBetbP7RNwMQDgvU6P9t7uPUgZZTkt/KtcmZJHqaWWhDJqUCOxhJmPKrZ0ePrPDf8pXExvcGqAHewGG3FijSounD5zxdB0bK6wEVMiRI4fi6NflEF8/EZ5nrxMJ3j1X6VXSqXZvtceiCxtz5mlhu6feV/GVaJKgv9RIMiAXmKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734231; c=relaxed/simple;
	bh=/dnOt/ajItOYIC3mCoVmSAT/i6u9FZW3eLUl5wuQBvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZSXh3hxcQIsweXlWE4dAYKd/hw34ufNwXCQ9h5Hyuhe7zsaVAn9Emd5SSvamNSFgKSb1uBonMrO1gZqhMXrzZwETzZfSOo59ytv6yBCn/DE6LYjVwd7z9fojgwa2Bust7XyJEJ7X4IdxgAUvVhVxNzqVtBtdLm7P7KW0bZRa2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaNBY+Wd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756734228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xqS2GRqBYqNxRqOzd74tRge4t4k/G8N0BFtPYQcSras=;
	b=aaNBY+WdfJihFCbU6t+kekweLqizA5v5K3LuFvpYPjEpPvXZ+5l2Mbziyk+RMQ55X2/nzu
	+a7nxsQcp2Bc2TVrd5y2KtGknyWmIPRvH/aVw0kFHkzRWnSTUbG9c9bc7MxYFLD1IOD6/t
	ft76FAzlADguwVK/uRwo5M22ZO+iRmg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-LxVR52t-M3uBx3wFXi9S-g-1; Mon, 01 Sep 2025 09:43:47 -0400
X-MC-Unique: LxVR52t-M3uBx3wFXi9S-g-1
X-Mimecast-MFC-AGG-ID: LxVR52t-M3uBx3wFXi9S-g_1756734226
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b87609663so9601415e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734226; x=1757339026;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqS2GRqBYqNxRqOzd74tRge4t4k/G8N0BFtPYQcSras=;
        b=ugHKndLuz/e1LH4hv2rE2LUUZOWToZ+E3dcgm6XDrbfA52gPgKS1eq244P3IX1UCCX
         FV5Ed1AUESDliRkUpXMpF1FPTZGIVjuDjCftHEfXd8dR3Sj0lkAqSV6rvgVjaBwj2hxG
         Gnl0OyhYurh7S3nEzk5SZGB9fr3Ks2TEB3XURZrMIwB55hBAZ0U+VThM48fiatifzDG1
         /D3EuVJH3X4bXGm/UcP4HgnswRnkJI0cC0lepdAhNiP0a/tK+hJNEdixbw0vgn+xg9Sx
         2T9IfBkUdJK/irWPNW8vux5X3ltUvwdjqQYkJ5ZOHoHf8s6O6SCg+v6OEiuJPjMNbnxu
         cq+g==
X-Forwarded-Encrypted: i=1; AJvYcCWIltdALkrQJtn/meY2pRV88ugcyYgo9bSy0C5326aONdHAFQ59U+QWEjcqJQSrCgE1X6TcLm0GZhIIOO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/2sVpC44LzJVM5yWF7WVzIt124Ll28yyNowfBypxcc0CmYID
	nz1gsvGDSgR/MZ0UAQhna9nPmh20DpifNfe/kBfYTXlOZv6silw9VIa29zdEGsemj0sNdK6DXmd
	nt7EHUrI9SudU+flTvFY3eZKUfOPMVXSwBWsNl1AHhIm14FdNdQuzqjTcg0XrigAyOQ==
X-Gm-Gg: ASbGnctBXeVQMov3xd/+VpL2k8gCsrovEdR+xnFCCgDVZR2z9A09aTDSHhThtdaqvex
	71I46PMdsT6JWpwxue4m1mKIZZggruUIt534blMYrFBrm8dVRW48s0FBL0VWUtfg465iu3lWBAm
	wn+L3qoIJbH8m626z2L4+Pd4agCblOdF3V/XUjmOL979wk8m8jAugygBTZeCwEsSnXlXknlgDGc
	hQjaqy6SG+mcEnoEPkPbxi1nLU8iWxVeyov8IOq3CdMT4G6jpXuf1cKKv65+DShgb3exBARWRXS
	Rp9y6ggCNHeJKIQ+cB9cx7wvxtFlNN3aY0W4cNl7P/A4xTRAAX0QFOjMKK7AMUeo+cpXwSpnGgd
	SfKlLAjmzJfjAIjDcAazYiUu27GnHnqAtUm8vBkAo6G/7ERO39A9Vf6KSX6ForITcHs8=
X-Received: by 2002:a05:600c:4694:b0:459:443e:b177 with SMTP id 5b1f17b1804b1-45b8557a72cmr65263685e9.25.1756734226410;
        Mon, 01 Sep 2025 06:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYoZ0BPbL9v6uAJga/QA3m1S7cO7hcDA2K3cyp4xTbWqS8UlVJpDGlbGtewdsXMiEue3w9pw==
X-Received: by 2002:a05:600c:4694:b0:459:443e:b177 with SMTP id 5b1f17b1804b1-45b8557a72cmr65263415e9.25.1756734226016;
        Mon, 01 Sep 2025 06:43:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d64ba4ff83sm5013587f8f.4.2025.09.01.06.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:43:45 -0700 (PDT)
Message-ID: <d8640bd6-1a72-4969-86de-e63736af53d8@redhat.com>
Date: Mon, 1 Sep 2025 15:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: Enable khugepaged to operate on non-writable VMAs
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org, hughd@google.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250901074817.73012-1-dev.jain@arm.com>
 <7towtl2pjubgdil4csn5rg3usbai5xvzz73wqkwj5b5awh2iim@wfvahykzjrlo>
 <9c3a2ecd-ceae-4e87-a6d7-6a7121ab7a15@redhat.com>
 <csqlc5ajszg6bybykeezkpcfqlx7nv5ochikrgttzrhqqjaxjv@y2hwbmqu4qfr>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <csqlc5ajszg6bybykeezkpcfqlx7nv5ochikrgttzrhqqjaxjv@y2hwbmqu4qfr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 15:15, Kiryl Shutsemau wrote:
> On Mon, Sep 01, 2025 at 10:32:34AM +0200, David Hildenbrand wrote:
>>
>>>> @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>>>    			writable = true;
>>>>    	}
>>>> -	if (unlikely(!writable)) {
>>>> -		result = SCAN_PAGE_RO;
>>>> -	} else if (unlikely(cc->is_khugepaged && !referenced)) {
>>>> +	if (unlikely(cc->is_khugepaged && !referenced)) {
>>>>    		result = SCAN_LACK_REFERENCED_PAGE;
>>>>    	} else {
>>>>    		result = SCAN_SUCCEED;
>>>> @@ -1421,9 +1419,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>>>    		     mmu_notifier_test_young(vma->vm_mm, _address)))
>>>>    			referenced++;
>>>>    	}
>>>> -	if (!writable) {
>>>> -		result = SCAN_PAGE_RO;
>>>> -	} else if (cc->is_khugepaged &&
>>>> +	if (cc->is_khugepaged &&
>>>
>>> The only practical use of the writable is gone. The only other usage is
>>> tracing which can be dropped to as it is not actionable anymore.
>>>
>>> Could you drop writable? Maybe as a separate commit.
>>
>> I think we should just do it in the same patch.
> 
> Change in trace_mm_collapse_huge_page_isolate() interface doesn't belong
> to the same patch in my view.

We frequently adjust tracing code (which is specific to khugepaged in 
this case) in the same patch.

Anyhow, no strong opinion.

-- 
Cheers

David / dhildenb


