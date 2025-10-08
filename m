Return-Path: <linux-kernel+bounces-845225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B0ABC40F1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D54E4E479E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588802EACE9;
	Wed,  8 Oct 2025 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jan40Xu7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9E01A76DE
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914162; cv=none; b=CCSPSUw0scTD4/i4TEFl9s1bwBIE9Gi3gYmDGLOULNgOVeH3aSWpGTzb1YKnmwkdICIEODQa1qzizyGRWquSw39tT/ki8fbUL/yef/H4tFmTwBVf2zuReytrR+YX8I+voxhF+YHcfK4lzfYUiP+KvlcA8w45oJae2fCpoug4Fz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914162; c=relaxed/simple;
	bh=yMdOiUD0dzwvB80DlJnuHw2Ce19ytfqdBPHjNuT4ObA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0iI9/pnErPfkBFEBEsZSVp7sjFdjcAf7O6KgR31Mlw9Qrb6vtC5cmI584DqA3ILFv2Bh34skFj0r+zwD1E8WgsiuJhY1tE4rRRB9mqZ/5YMz3Dj2i6ijE9S4UUMi/PS8fJHR5hkEnLxoI1IZZLAkVeorkLCTm0rncEj6OIilFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jan40Xu7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759914160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=46R1sN9igUgUTPSQIseFwe6Ew94wbjQckrXFCJzXdDs=;
	b=Jan40Xu7teejpk+UXCaOMyvcWrhXS8chvS/diqEGfj+KLuz8A9YZ4otDvYxjV4FrMPXIfi
	q6M8MfATYXmD2NGKesnQsFqps4MSMRzIPzAkT8qBsg6D1M16SRBMcvK3jsTYgKBg+1wFfv
	HOWrw4hAMajMy3cqrvj2uQmxcphgUxs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-jf7m6CISPoSdvwNKm6Dj_Q-1; Wed, 08 Oct 2025 05:02:38 -0400
X-MC-Unique: jf7m6CISPoSdvwNKm6Dj_Q-1
X-Mimecast-MFC-AGG-ID: jf7m6CISPoSdvwNKm6Dj_Q_1759914157
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso4103114f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759914157; x=1760518957;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46R1sN9igUgUTPSQIseFwe6Ew94wbjQckrXFCJzXdDs=;
        b=wO7QUiivtZpg0cKt+KkXrMxl/y2ewDs8kh3m1WFI/dOPvZLlaiuRWFzMOzn6ii81RT
         jr/WRkNVsjD13Yi3/OnDWj1lgLHFaYjjUpl1w9oAQE0VEhR+qWR5SgGfqkcWcSiPsMv8
         t5EAUmY+TktY+OSzvDQJdFdew/hw4UYuhHgrk8TJYg3vxMO1mMfYuFy+7YJgSSTa4Bdq
         O1tTBB5yVDhCBwmM/T3gS6ST8mf1ZDiFrH4iBVi2d4ahQ6huBs2KjqAhU4GMKk4nEcYi
         VPPUrbD0WWk9aqsbztMinE7mR04QMzLMAzP4owiynGWGDEIrSGOUnce/aP52YCMn28hi
         hQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu87nsnIu5u2iss6obIeeFVdcYPqflcWTsA/m4JdD/MsB0mncXDKI3WaeoKNgu87fgNTkSi+/G7C5/Yks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEGUNPNyM7LwvjekTKu8qgqDazLRYb42opqWhNjd8U+RHKfbd
	y8fz8oW51PdfPJMeofmsoiJiPqtxac4ak0aPSaBfBN0ygVyDkiycH3i1VGbTjLokLNs4IPqsvDd
	+EeXFQw9F4Uda0NEE0PK1HOAKhm9+mZiYqN0RpMctSOhwiHNMr1nX7l9cdq6+SvbUWw==
X-Gm-Gg: ASbGncsgE2K8L2gMgGoDp7L/Af7zW+3WwieKH67RLQMHxF8IvlT6V4rMOQUhh161QHu
	yggdJqLtBvDLu5ws0037zLYwi0Hry3SdagS/hV8YdrPFhU7BZIp5kJvqshOiGiK0JBpHN0fKXCC
	bvLuUmZ5P/vrkJlI9osEob7NbZaEvIxC2yThPCIR4dB7TSWJT6g4hr0tKh5oZJVKJ2Rs4lPZi3A
	OBeQqkVnEtruHQSBwbuH8Tpof8MZJOzPLQaZCx43fDGe1SKvcbMcCqrEy3WOIQQJirKCub1efjK
	zIKbFrhQKIk7sjWkAxznrg2cY31+L4bkqADTmjdquveJcffrs1wJWF4R6g9AlK3OyKIILk93mD4
	U3l8Ac+N9
X-Received: by 2002:a05:6000:607:b0:3ee:15b4:174c with SMTP id ffacd0b85a97d-42666ac2cbcmr1573575f8f.3.1759914157280;
        Wed, 08 Oct 2025 02:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQrhrRDYxj/7YEx0y++lris7ibeBPqVXd2rLjuE7tAoZ6C3HRHe/JUbaoHFYJ1fdK5oQlE5w==
X-Received: by 2002:a05:6000:607:b0:3ee:15b4:174c with SMTP id ffacd0b85a97d-42666ac2cbcmr1573547f8f.3.1759914156861;
        Wed, 08 Oct 2025 02:02:36 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9724sm28761707f8f.28.2025.10.08.02.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:02:36 -0700 (PDT)
Message-ID: <df3566e4-82dd-4e1f-b043-e9de4879b5a0@redhat.com>
Date: Wed, 8 Oct 2025 11:02:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: allow overcommitting gigantic hugepages
To: Usama Arif <usamaarif642@gmail.com>, muchun.song@linux.dev,
 osalvador@suse.de, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com, kas@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20251006185607.3257340-1-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251006185607.3257340-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.10.25 20:56, Usama Arif wrote:
> Currently, gigantic hugepages cannot use the overcommit mechanism
> (nr_overcommit_hugepages), forcing users to permanently reserve memory via
> nr_hugepages even when pages might not be actively used.
> 
> Remove this blanket restriction on gigantic hugepage overcommit.
> This will bring the same benefits to gigantic pages as hugepages:
> 
> - Memory is only taken out of regular use when actually needed
> - Unused surplus pages can be returned to the system
> - Better memory utilization, especially with CMA backing which can
>    significantly increase the changes of hugepage allocation
> 
> Without this patch:
> echo 3 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_overcommit_hugepages
> bash: echo: write error: Invalid argument
> 
> With this patch:
> echo 3 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_overcommit_hugepages
> ./mmap_hugetlb_test
> Successfully allocated huge pages at address: 0x7f9d40000000
> 
> cat mmap_hugetlb_test.c
> ...
>      unsigned long ALLOC_SIZE = 3 * (unsigned long) HUGE_PAGE_SIZE;
>      addr = mmap(NULL,
>                  ALLOC_SIZE, // 3GB
>                  PROT_READ | PROT_WRITE,
>                  MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_HUGE_1GB,
>                  -1,
>                  0);
> 
>      if (addr == MAP_FAILED) {
>          fprintf(stderr, "mmap failed: %s\n", strerror(errno));
>          return 1;
>      }
>      printf("Successfully allocated huge pages at address: %p\n", addr);
> ...
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---

No opinion from my side. I guess it won't harm anybody (but people 
should be aware that "overcommit" with huge pages where we have no 
allocation guarantees is a flawed concept).

-- 
Cheers

David / dhildenb


