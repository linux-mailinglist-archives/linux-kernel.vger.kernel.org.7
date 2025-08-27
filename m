Return-Path: <linux-kernel+bounces-788244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF0AB381B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218A9980F14
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C52FAC0B;
	Wed, 27 Aug 2025 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9Zuxf28"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4B2D8DA9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295482; cv=none; b=VcGkCwDU2ChIErny5bGNIeDiZQGsz0oaWP0GCFN1rLwa1oBG4KvaAmPtrRsDKe/nkUcb/FBcl74mMoFRvbnYwuC3gzhzMD3HMvKouelELr5GwcaO/S7VDbyhaSKZ2nCO5h6hO2b+sSNpoPYM+126z/GCplGkmKiRakUxHFO2zWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295482; c=relaxed/simple;
	bh=cTI1Fhwm9QigQTj4jlBzBG62+BgcgXwdk+Ld3xpU0rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggiVoFIYzMMndY7dIfvsHmWfao7siPACNSVqKtBCYeLIjfo56TDx29Ak2+sWlr90CA83gF4CtP4tN69B5N1B1d/IEhJbzgb4UJjEl0EwM5mS3IX5nt1J+jNARQnQY5/++mOUTvKqPj5YPjNpf3uzqZed2eoveORva2nKiD+w9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9Zuxf28; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756295480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Kj+WQqNx6mfeEUrQ2egTOZFN5drPRSU994Gb6Ia13Mw=;
	b=P9Zuxf28pi7DArlsanmjzRZ3r7dEFnlNMY7SGAJ2+NR3LzJ+inTXFzmot/dptQfAPTBmsQ
	yWdNLB3TSCEi7UsUoSFxtMMymSBNdfAKH8gKW2cD+TZzp3Ulh8Vu6a2AO4HACmZKBAbMfV
	YqWFedqnhcRB/jeP7uS6Yr/yIY85Bkg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-h2ZCWK_2PVeLUfgg0FpOVw-1; Wed, 27 Aug 2025 07:51:18 -0400
X-MC-Unique: h2ZCWK_2PVeLUfgg0FpOVw-1
X-Mimecast-MFC-AGG-ID: h2ZCWK_2PVeLUfgg0FpOVw_1756295478
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7f2942a1aa1so214390885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756295478; x=1756900278;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kj+WQqNx6mfeEUrQ2egTOZFN5drPRSU994Gb6Ia13Mw=;
        b=L7XryZTMDz6cV3TEloZ2DHmphpiaPPTpjuQFXlgd2NVayJBCEQ/fP0JR0fbLDdRCgR
         U8zajHYLqHDsm9ARY8hqYs+CUpivsJBLLi87rUGdLDZF56kiUgBc/OUIQLgeyN0LUxSq
         bHogeIZJddhgCsM5V4NiQZ2UMYbikDhP0AlWvCUSKeMcv4l6GvZjcqFqFm/LfE1/L68W
         Mxn/oS0loO4TwlClqLFGrb0Ng8Mgh3ifAePhzn4P7kpKAfj61d/aJc61acK4T4OmeYSi
         JPA8sSxAqBHVWhWwc4d5ICQpqT5e2kZG5n9RGZaJ89SRDvO2BW/DMDXvjzjEhbHhwKIR
         vEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqg6CsH3XQ1VopOqg8ankV+gP9/zYvICAAX4PU27zqRSvjPRg2c1+toAdCv1mehORhDnU16TFUW7F4l6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsgFV83DN7IocT4s1nVJa6IR3ZvcyeyGNDXg67TrYW9ormdaXA
	x7BSlZh+eVwIMmV2bbanRDY8d1rTU47JR3UqoDEdIkdyXf56YDAd8LAvV9VOsexpOL2gYNTiOHJ
	84SffyWd1757I/IUkEG99v4toK/6SOsQ+TX/oReUBN2cczXixtJ1VQuvYOD1T83lFqA==
X-Gm-Gg: ASbGnct+gJ0MVgmWO+iadZ0HUsNm/qCdP+j3I38MlTFOsykIxdNS2HLeFmNarXU7qop
	kGY4XtfzsvnxqO3iZjLaeZwGyvSWfDgOArOSANAlftESv3xbyIVMIm/TZsjvi/JGWCdragSlhPx
	mPJghfSZaghMAcbmj8dW4llbRDN7QPFfTMAlAR1H5BT3Rp40kDSCiczQhRk3BFpNoUKTJRvt8m+
	NeFXyRYNhhl9ZloVYP6B9TEJ4HsOmwrIgKoRCxIuQ/Ria3xBVEfBEBwVs0xuefHcMCsBBq9kptS
	8jkT7X4CApslvrKu8H3SA6+s5zads5ZnDkVRv8rwKwy4ABuuPsU+Qz/lPwvimQ==
X-Received: by 2002:a05:620a:3885:b0:7f6:9f86:4e76 with SMTP id af79cd13be357-7f69f865039mr312098985a.23.1756295478048;
        Wed, 27 Aug 2025 04:51:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVmBzDtfDq10Nt79ue8F/PO01PWq9Aj/sKChiNk7iQU5whHjgTqD35dLozWe6HEX9Zy0TzKw==
X-Received: by 2002:a05:620a:3885:b0:7f6:9f86:4e76 with SMTP id af79cd13be357-7f69f865039mr312096285a.23.1756295477451;
        Wed, 27 Aug 2025 04:51:17 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebecb1825bsm848326885a.10.2025.08.27.04.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 04:51:17 -0700 (PDT)
Message-ID: <1be63942-f3a8-404f-bf26-cfe7eaf2ef58@redhat.com>
Date: Wed, 27 Aug 2025 13:51:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: two-phase hugepage allocation when
 reservation is high
To: "Li,Rongqing" <lirongqing@baidu.com>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "osalvador@suse.de" <osalvador@suse.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "giorgitchankvetadze1997@gmail.com" <giorgitchankvetadze1997@gmail.com>
Cc: "Xu,Wenjie(ACG CCN)" <xuwenjie04@baidu.com>
References: <33c9676b1fda4cbaa42857787e03c7ec@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <33c9676b1fda4cbaa42857787e03c7ec@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.25 06:12, Li,Rongqing wrote:
> 
> .
>>
>> Also, can't we fail lightly during the first attempt and dynamically decide if we
>> should do a second pase?
>>
> 
> 
> Good idea, like below
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 753f99b..425a759 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3589,6 +3589,7 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
> 
>          unsigned long jiffies_start;
>          unsigned long jiffies_end;
> +       unsigned long remaining;
> 
>          job.thread_fn   = hugetlb_pages_alloc_boot_node;
>          job.start       = 0;
> @@ -3620,6 +3621,18 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
> 
>          jiffies_start = jiffies;
>          padata_do_multithreaded(&job);
> +
> +       if (h->nr_huge_pages != h->max_huge_pages && hugetlb_vmemmap_optimizable(h)) {
> +               remaining = h->max_huge_pages - h->nr_huge_pages;
> +               /* vmemmap optimization can save about 1.6% (4/250) memory */
> +               remaining = min(remaining, (h->nr_huge_pages * 4 / 250));

I don't like hard coding that here.

> +
> +               job.start       = h->nr_huge_pages;
> +               job.size        = remaining;
> +               job.min_chunk   = remaining / hugepage_allocation_threads;
> +               padata_do_multithreaded(&job);
> +       }

Thinking out load, can't we try in a loop until either

a) We allocated all we need

b) We don't make any more progress


Not sure if something like the following could fly:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f42186a85ea4..dfb4d717b8a02 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3595,8 +3595,6 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
         unsigned long jiffies_end;
  
         job.thread_fn   = hugetlb_pages_alloc_boot_node;
-       job.start       = 0;
-       job.size        = h->max_huge_pages;
  
         /*
          * job.max_threads is 25% of the available cpu threads by default.
@@ -3620,10 +3618,24 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
         }
  
         job.max_threads = hugepage_allocation_threads;
-       job.min_chunk   = h->max_huge_pages / hugepage_allocation_threads;
  
         jiffies_start = jiffies;
-       padata_do_multithreaded(&job);
+       /* TODO: comment why we retry and how it interacts with vmemmap op. */
+       while (h->nr_huge_pages != h->max_huge_pages) {
+               unsigned long remaining = h->max_huge_pages - h->nr_huge_pages;
+
+               job.start       = h->nr_huge_pages;
+               job.size        = remaining;
+               job.min_chunk   = remaining / hugepage_allocation_threads;
+               padata_do_multithreaded(&job);
+
+               if (hugetlb_vmemmap_optimizable(h))
+                       break;
+
+               /* Stop if there is no progress. */
+               if (remaining == h->max_huge_pages - h->nr_huge_pages)
+                       break;
+       }
         jiffies_end = jiffies;
  
         pr_info("HugeTLB: allocation took %dms with hugepage_allocation_threads=%ld\n",


-- 
Cheers

David / dhildenb


