Return-Path: <linux-kernel+bounces-782049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E64B31A46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A62189974B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E029303CBD;
	Fri, 22 Aug 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSNG6X4P"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5E2FD7B8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870652; cv=none; b=PcvNAqeJdGZVxNXHjEKKOGruNH9PfJwFU7WitbwFXHghpMfscS2752BIEAQ5TCnwMzbUNfTEMt09zRRV+PdMpxa4045+qdX7fzsJJwnIB1K6WJdGdKqDFejsb70/rIYSsDtSY++w3OLDxHcbg2uthyb1Xvbp0xHnIG/jLNSTfkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870652; c=relaxed/simple;
	bh=b9DISnBr80iRSH4AeTVqCopXwygyz1xeiBqPwwcXcn8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=E+j3FSr7a5INmsNM2nuFRIiX600bJuH3eqaDbaqsvAvpobOBWt3ZYCAabGaKvy/FUtatc1hF9LESWcZUap/dk2z5OXZE8fQNSRmNn2OJyv2+IPma4x7XKEmbrwDSizpV8VZ8BRCbbWfsxptGSXGzydFiWe1sGAymojpF0D7nrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSNG6X4P; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c69724519fso49580f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870649; x=1756475449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGhO3kmVIYGRWufT14ynMiV/yGtuvvh15Hsd9JEr9n8=;
        b=eSNG6X4PARfT7PkNGD0b89kfLvvtMESUb2TsR345vHjhwEPpi8CGMjKTT8BYpUm34A
         dIiDJ0Py+HCCuGRIwnSHUx98OzdQqHeVJfEVS4eS6PPXmpGncvFLhwnGs4iKQMauj4XW
         CnjFcOmawh9GQbdrwleUzpkpeujrJN+fFsNsgIzdWTT/ikVADAgX1OeFt/ZPKPGyC3OL
         LqPhro9S0w/8Qszb1hJG1d6Vpc7ouggVKsdb0na9iLm2WUpUp8e3pSn8p6fwa0Mqko9G
         q+u2H4WBFmrih3HI8LxH/0Zd7P9rcjtFSib5Ru79h79t/cY7ncZCLkVvUfA3Zmjd/RV2
         9Q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870649; x=1756475449;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGhO3kmVIYGRWufT14ynMiV/yGtuvvh15Hsd9JEr9n8=;
        b=YczzOb7Vur0m/ZMhxobiDCJZ41qhiSPsE6Cck27FuJVx88WdUeGjNk4oxAA5639PoG
         aZJhNb9AohEpEKdbWO/Va1w4/wcr1ey9Ht7S28anovJjjdk+nzKe16xSdDkoPfDdqxkq
         YiYcY/sprq/JNZ+UDTiS80uroXw9TQX3DLfr//eTp/Iuq0ksJGU3kwiyta2y7pnbQ0wO
         zoIJiGz6HzUDCuKURn+tQhaOcrcbYnSEQy6n4gFHkAzNWdOboWrt2sh8BcxsiXmRN9k7
         zWB7RL42Wi8mfmzhAZFXUc8bWw3K/0Mx5SCjjS11MZxp6nilHa24KVUgIbIzaFoku/JV
         WqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRXuBuUjKo40SbJwwqSU4IQcJ1AFWp/P9duJltAN+5m+1OYg614df1iRy3Sonet5CG1gefIgNrq9YXWyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrvFtQ3InFyDDG7ehvsX6mhHcfJo+hhB1jCTsN9WtTiKUT+WD
	He4KJxC6M0PhvXbiKtXkvp1Kodrni5oCj97KDAEbHLbCR7Fw5qcX+5wu
X-Gm-Gg: ASbGncstY5kFE4erx+GqBxNN5RmVBBVOiklCJ9kmcmDmyBnNCwjdmU0iYmrE3/avH8V
	n6dnxVmIQvmDE7Wm4eJ4ifNyBq5WOYN7D0Eh+3lFL8VbFH82gMXTcDemYdbqBQGoHPbcntmFzzc
	Rxws2GKpECcDjWb6MgaySk1ECnlDDerlY70eaPGlQqoGpUyE7I8UhMmZBCQ6P9grnSoeAhSgiaS
	nKFz9HC0UDXjXrVJZ72ydrosvnOjfrkkbWmnVTa0aFIlWoVZfi5qKNvNGYeyppIhppste1wOsrH
	bWi1HfhKxz1stMMYxVvyaUcyiLOvM844yDWo64SJE1D5c5lGAaWpLhheMfyHgA7RqgCacA0eZBR
	CIYW8Vp2GD/WiUHfjTIdwZwygs33+lNhzCqqyD5zYL87I7IKQ+BKRvKX/pOA6SucTPs4m/myNxi
	gbD0lgPwd3mRAZl2nWtqI=
X-Google-Smtp-Source: AGHT+IFgLJnsa2QDWZ7yy8ttoVwSdR672VRHn6w/2d2eIUK/l081Cm2xTXQ1WfEHFk7l29E3EP1adg==
X-Received: by 2002:a05:6000:240c:b0:3c3:c280:d43c with SMTP id ffacd0b85a97d-3c5d7ea4ba8mr1184915f8f.0.1755870648896;
        Fri, 22 Aug 2025 06:50:48 -0700 (PDT)
Received: from [192.168.100.6] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c6e2d3f2aesm165454f8f.58.2025.08.22.06.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 06:50:48 -0700 (PDT)
Message-ID: <4391e3f5-e0a5-4920-bd50-05337b7764e7@gmail.com>
Date: Fri, 22 Aug 2025 17:50:47 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lirongqing@baidu.com
Cc: akpm@linux-foundation.org, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev,
 osalvador@suse.de, xuwenjie04@baidu.com
References: <20250822112828.2742-1-lirongqing@baidu.com>
Subject: Re: [PATCH] mm/hugetlb: two-phase hugepage allocation when
 reservation is high
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <20250822112828.2742-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi there. The 90% split is solid. Would it make sense to (a) log a 
one-time warning if the second pass is triggered, so operators know why 
boot slowed, and (b) make the 90% cap a Kconfig default ratio, so 
distros can lower it without patching? Both are low-risk and don’t 
change the ABI

Thanks
On 8/22/2025 3:28 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> When the total reserved hugepages account for 95% or more of system RAM
> (common in cloud computing on physical servers), allocating them all in one
> go can lead to OOM or fail to allocating huge page during early boot.
> 
> The previous hugetlb vmemmap batching change (91f386bf0772) can worsen
> peak memory pressure under these conditions by deferring page frees,
> exacerbating allocation failures. To prevent this, split the allocation
> into two equal batches whenever
> 	huge_reserved_pages >= totalram_pages() * 90 / 100.
> 
> This change does not alter the number of padata worker threads per batch;
> it merely introduces a second round of padata_do_multithreaded(). The added
> overhead of restarting the worker threads is minimal.
> 
> Before:
> [    8.423187] HugeTLB: allocation took 1584ms with hugepage_allocation_threads=48
> [    8.431189] HugeTLB: allocating 385920 of page size 2.00 MiB failed.  Only allocated 385296 hugepages.
> 
> After:
> [    8.740201] HugeTLB: allocation took 1900ms with hugepage_allocation_threads=48
> [    8.748266] HugeTLB: registered 2.00 MiB page size, pre-allocated 385920 pages
> 
> Fixes: 91f386bf0772 ("hugetlb: batch freeing of vmemmap pages")
> 
> Co-developed-by: Wenjie Xu <xuwenjie04@baidu.com>
> Signed-off-by: Wenjie Xu <xuwenjie04@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   mm/hugetlb.c | 21 +++++++++++++++++++--
>   1 filechanged <https://lore.kernel.org/linux-mm/20250822112828.2742-1-lirongqing@baidu.com/#related>, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c index 753f99b..a86d3a0 100644 
> --- a/mm/hugetlb.c +++ b/mm/hugetlb.c @@ -3587,12 +3587,23 @@ static 
> unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)  		.numa_aware	= true
>   	};
>   
> + unsigned long huge_reserved_pages = h->max_huge_pages << h->order; + 
> unsigned long huge_pages, remaining, total_pages;  	unsigned long jiffies_start;
>   	unsigned long jiffies_end;
>   
> + total_pages = totalram_pages() * 90 / 100; + if (huge_reserved_pages > 
> total_pages) { + huge_pages = h->max_huge_pages * 90 / 100; + remaining 
> = h->max_huge_pages - huge_pages; + } else { + huge_pages = h- 
>  >max_huge_pages; + remaining = 0; + } +  	job.thread_fn	= hugetlb_pages_alloc_boot_node;
>   	job.start	= 0;
> - job.size = h->max_huge_pages; + job.size = huge_pages;  
>   	/*
>   	 * job.max_threads is 25% of the available cpu threads by default.
> @@ -3616,10 +3627,16 @@ static unsigned long __init 
> hugetlb_pages_alloc_boot(struct hstate *h)  	}
>   
>   	job.max_threads	= hugepage_allocation_threads;
> - job.min_chunk = h->max_huge_pages / hugepage_allocation_threads; + 
> job.min_chunk = huge_pages / hugepage_allocation_threads;  
>   	jiffies_start = jiffies;
>   	padata_do_multithreaded(&job);
> + if (remaining) { + job.start = huge_pages; + job.size = remaining; + 
> job.min_chunk = remaining / hugepage_allocation_threads; + 
> padata_do_multithreaded(&job); + }  	jiffies_end = jiffies;
>   
>   	pr_info("HugeTLB: allocation took %dms with hugepage_allocation_threads=%ld\n",
> -- 
> 2.9.4
> 
> 


