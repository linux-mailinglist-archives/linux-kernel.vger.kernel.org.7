Return-Path: <linux-kernel+bounces-803115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C150EB45AB9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775E91B26F09
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7E371E95;
	Fri,  5 Sep 2025 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFlXxeUT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F071FDE19
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083246; cv=none; b=Gz9M6pR7qBsnkMCm0hh78BX6TcJQrC3e9rXQYMwDyWKAp+K+ZqFZgj2nr2mFiS6qKB8ivblu9LpgVKBIMjPYiqEFiDPab2AcE29QeThxwcPVFtgnphId44OZG6A8HrO1qlz302tr2mn9KT7c557bSNeSUPY9i6KKkpNaT278eKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083246; c=relaxed/simple;
	bh=vU8T33SrW8SoqB8aI7JCNNyGkZuyD4dQhjuCUCMCAog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UE2Dx+O/S9XOtBkM3p0kIKX7DUeGVwNvEs4aD1xKpQvQYggA+w75tQnrNTlJdQiuN2BZZVCalUAVTQw30CS5FuZS4EqvYfyUHSbxyDRm9ThAPTC75AMQkpCwp29UnQxqPC9SuYhSIQZKc0R8P/9fVbT+zvkevd59ptTnAlTJpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFlXxeUT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b8b2712d8so20196205e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757083243; x=1757688043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruv15YVZGd+unn8eyN2kDSKfSxE6YIH+rd+SuV6Cw4g=;
        b=UFlXxeUTBAg/Mo2nyEZWMdxldwykkH+txh6H5suElxy2GO4VQTOq4neUwV9te6uEPF
         dezATmfIceS3kdZZMqmRSpMUUOnJc56ZsDCS7DW4vawSk0qhOdbQe26J+ze+b0YphWIv
         VO2vt4tBgKSMrj1Eot4XfLLY5Hcwus/gWBPy9VJmpeX0RYYp4B6IPoq0QeoTh84Zoie5
         pYTuXthaiLpJATiqF6QXh21QNGlS0hcD5xA7121iLEH+mMuG/Ox1z4YyxrzSfeP3iKsB
         lYaWjlQPRYfYSOsbAHdf5Qaruia3kZnyOi04x1m2h81q5NkUwzzyyK0boGVzgfLw/vZn
         hGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757083243; x=1757688043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruv15YVZGd+unn8eyN2kDSKfSxE6YIH+rd+SuV6Cw4g=;
        b=dKd4CCnf/8gr4TeShchBCXU7/8u8dQJPNSi7fkM6KW0YLkQZG3xx+CUE0Mzs/7OwPq
         jEtO68l7lcVUCf19CXeHCHx0N51noRNMu0I6EwUYHZMvjdgJwa0Ox+Otz25KpUFm/X7R
         xkbkd+qeliAse9fz1DrnstvyeueMf0hM/V8/dORcUNTdCoKs+OtRVpk4tfAtLnIu0UCG
         NE0GoSfjZkqS/EFj4GQRPvUP2QMwnjToFanAP8wlWsqRCYQYMR5p8f42md+Q+ArKeOA2
         4cT2SYNrjC+2/wMwk3KCB3SQhAFa9I4fHKrLcD0T/39/OqIngKOgXBEPX8PRmltpY5FG
         vPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWctrFwwlAOzNgo2GBTCob7s9B+HT67O4Fur1WdrWFf9AdkZRNeKUmJKhbvdY2+PtDe6HkLx/JGpU6YumA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26icJQ0SOzd0j46/sd1DwQPyu5SO+9ddZ4u0aUpzfpHA0RG79
	c97xgpjdur889d0LFHW9T8o0rmPk0LiaYq9svuCROWaylEjRPm5C85kbXabGKQI45+M=
X-Gm-Gg: ASbGncuT+ba69yFaaToGBJZegkTk8BgI0W6Baaqf6WwCwCytX5CKFtB3U/FBxpBNkj5
	PAlUrtiGNGOOTTZ4S8MUojK6wC7mDXbwqwNLDlAT+MkKcmxroS04/Bsc+biFeXitdGP7Mt/uYah
	uzVDjnz873hbRZkpD7/MsOkUfTWtNDtp6HYdEVhKfv/GEkG/tPo4yVdIuqf/l9WsF5YqH1iaogk
	KKc4l9u2RA6GDd6h7BZ4J2Hx65pmH98zsOTq0ekdgmYtWvh+0P+rkmCsVqg/mrbrZfhu2TRWDMH
	Jyog2XgC/L+e1xYswSlRAKeOhxrH4PNunJSjaTTlUNQvbKLJ93ZgDPVQmzLmdt/kEM0XKYuqxDG
	vQ9ZdWqbciTu8XLW/tsOTSg9oK5XNU9LpTXm5FMW9Mw2eiza9i0ls89oVjQXeOvNn3uXCeTuJ/S
	PR+DkJMw==
X-Google-Smtp-Source: AGHT+IGu07r/gZnXoPunBkFAHKSx8jyMa/2Jlap3WzA+NjHvNOW/3Z9J7vjwq2h0Xwukh0ua1/Kj4A==
X-Received: by 2002:a05:600c:4513:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-45b8553365bmr200220705e9.12.1757083242842;
        Fri, 05 Sep 2025 07:40:42 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd60b381csm37364505e9.17.2025.09.05.07.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:40:42 -0700 (PDT)
Message-ID: <06874db5-80f2-41a0-98f1-35177f758670@gmail.com>
Date: Fri, 5 Sep 2025 15:40:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250905141137.3529867-1-david@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250905141137.3529867-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/09/2025 15:11, David Hildenbrand wrote:
> We added an early exit in thp_underused(), probably to avoid scanning
> pages when there is no chance for success.
> 

Yes, that was the main reason.

> However, assume we have max_ptes_none = 511 (default).
> 
> Nothing should stop us from freeing all pages part of a THP that
> is completely zero (512) and khugepaged will for sure not try to
> instantiate a THP in that case (512 shared zeropages).

Agree with this point for this patch.

> 
> This can just trivially happen if someone writes a single 0 byte into a
> PMD area, or of course, when data ends up being zero later.
> 
> So let's remove that early exit.
> 
> Do we want to CC stable? Hm, not sure. Probably not urgent.
> 
> Note that, as default, the THP shrinker is active
> (/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
> THPs are added to the deferred split lists. However, with the
> max_ptes_none default we would never scan them. We would not do that. If
> that's not desirable, we should just disable the shrinker as default,
> also not adding all THPs to the deferred split lists.
> 

The reason I did this is for the case if you change max_ptes_none after the THP is added
to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
so that its considered for splitting.

> Easy to reproduce:
> 
> 1) Allocate some THPs filled with 0s
> 
> <prog.c>
>  #include <string.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
> 
>  const size_t size = 1024*1024*1024;
> 
>  int main(void)
>  {
>          size_t offs;
>          char *area;
> 
>          area = mmap(0, size, PROT_READ | PROT_WRITE,
>                      MAP_ANON | MAP_PRIVATE, -1, 0);
>          if (area == MAP_FAILED) {
>                  printf("mmap failed\n");
>                  exit(-1);
>          }
>          madvise(area, size, MADV_HUGEPAGE);
> 
>          for (offs = 0; offs < size; offs += getpagesize())
>                  area[offs] = 0;
>          pause();
>  }
> <\prog.c>
> 
> 2) Trigger the shrinker
> 
> E.g., memory pressure through memhog
> 
> 3) Observe that THPs are not getting reclaimed
> 
> $ cat /proc/`pgrep prog`/smaps_rollup
> 
> Would list ~1GiB of AnonHugePages. With this fix, they would get
> reclaimed as expected.
> 
> Fixes: dafff3f4c850 ("mm: split underused THPs")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 26cedfcd74189..aa3ed7a86435b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4110,9 +4110,6 @@ static bool thp_underused(struct folio *folio)
>  	void *kaddr;
>  	int i;
>  
> -	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
> -		return false;
> -

I do agree with your usecase, but I am really worried about the amount of
work and cpu time the THP shrinker will consume when max_ptes_none is 511
(I dont have any numbers to back up my worry :)), and its less likely that
we will have these completely zeroed out THPs (again no numbers to back up
this statement). We have the huge_zero_folio as well which is installed on read.

>  	for (i = 0; i < folio_nr_pages(folio); i++) {
>  		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
>  		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {


