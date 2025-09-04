Return-Path: <linux-kernel+bounces-800496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A71B4387F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C801D3AE08F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932782FC00F;
	Thu,  4 Sep 2025 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRSGsgrv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C392FC005
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980890; cv=none; b=NkE6iuxtxiL5/snSDTqzF0QKrShe2Nk16U3CIZYcf1o8/SK6du8VzeQt0/03LbD/XGRZ2nu5G1NAOUySNtl+X5FDFMH0Tf1ggSlzrMk5uGLTaByLzuRbvFrpV2Syg6zIRMh3AjBsXputlGqZWUIOOJU6sTJqxEwz3expiEtjZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980890; c=relaxed/simple;
	bh=EL98baJQhmYH/tj6NNMMuPuAoPQCES0cmlvz2Z8HyG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxLh9PNIwfjFejxIjq7lBZWJ2HFhsSybxWPM4mW/k9zgPPrlsNJjQtRCPudhOIvW581tf1H9jhf3gKxKSCcoV1hDfHuNMI/2bnMp+ZIuH9czxCffI0wmozBrxmjXyo3T7j6OMumO2zysDLikw9CXrXFUhOdzUy3D5iK7zqiihA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRSGsgrv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756980888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bq3+yZ1Iv8UyqQ7bH3U37W+QYS6AmVPIi3j4M2P4Y0Q=;
	b=RRSGsgrvXn0fec53iL7abEiZfy8A3jvDHbPm3fFe/+eZMmsafGE7HEXSZvGv5e2kvo+EUU
	sv/hNY9ob8t9tjVO80kp9Xw97PV/8IDO5+5kZfnQxWF12CI+3e5a9v18HMEF547bCJuV3m
	iuBGQnbTSRq8SE6fhN52ajfcUq+gfP8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-w4rF9peuNCWdDoiH3ETyDQ-1; Thu, 04 Sep 2025 06:14:47 -0400
X-MC-Unique: w4rF9peuNCWdDoiH3ETyDQ-1
X-Mimecast-MFC-AGG-ID: w4rF9peuNCWdDoiH3ETyDQ_1756980886
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3dabec38299so522619f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980886; x=1757585686;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bq3+yZ1Iv8UyqQ7bH3U37W+QYS6AmVPIi3j4M2P4Y0Q=;
        b=VGxmffzVyn5DBootIr0hJGAxj+mn/PaWhVZ5trgXpliIdlaDQ9nWH6yJ7IBCb9Ftll
         gVcR5Dglpp8MZt/p5P1SktKdDX641fDkaEPQBItOcdLyUr7rAJqIZ2XwTWnlmVVZJ6RT
         Z010Am1D6/lS8H6IU3EahzU/iajZX6QRPd8vk9Cy6OtK3zNNZAmbttKE+8NIDg0lY72s
         VtYi2wyHLFa2sYPOyUcDQrPw2b7ACYb9bk3pe7O2uMYR0dH7LF+YAII/m6/BU+S/z016
         00TOCqS0V1KiKlNi5aZ+Hcry6y1q9uLXcIlaRC9G/D/pFPPOxZk79IVSdzKdsTFfGFDq
         nGvA==
X-Forwarded-Encrypted: i=1; AJvYcCVRT8siFiWSV09k7ywN/ixcv0PgaeFTxwHkYzCarSYV8GNaWXot/CF3+1Wx+2Xe79iIhZGKPPSZt1v6YGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCMEVhZVXjypQzma7FGipW8aKnI/ltvf/zF8yVT/zkJIKcaQ2v
	YSuX/ndmlCl+Z+5nwAhPDFMm8XK3cOXvhv4zywhFFu5g7gcX7Lwdrl3JPS+/1ZiAnP1zjucOKaz
	bxTB702ANtKr4931+tT6XhSWH5znTVE2O8nx2f8Y8cvrQWWzson0VhyQWnuanlEIMLA==
X-Gm-Gg: ASbGnctlO2FGrkKEVCmhH2JuAtxQuwR7hXy9I138yqe8pjo5j2xhwKWCiVQWjZ3dns9
	tbuBDeaTGP45rWBESQDn0YwUw6DTCGLH3rZcbTmi6ohLkGZjaNDt8s2vE8PDWZY+D/3lNGnyKpt
	cpTWA7a5zEsUb9KMvSQAYRGlftmWp5ddrtcOiCKZcRbM2byQb5/M8GGrJssOzM8tMqMdfDzVL2L
	p3uTYSAASOkGdQ7DAj35zYy6Hm95HwPxnpYdadpMdvYjB8lKlLGoOt9nziqko0ucideETyvGORI
	0dOxwzfGfj3mnDxzMYBduabVIl2AyiE4lWqehI8uCAWh8J+nLn4sWq4h8SBGUu3jbouUHgDXcgx
	BgIZXisIHicbaWNbrw/xNkcAxspAxxqyATnILtKb8/eRfIZ/cCzDgwvRTf7VxxasI
X-Received: by 2002:a05:6000:65b:b0:3d4:a64:6758 with SMTP id ffacd0b85a97d-3d40a646c13mr11675670f8f.3.1756980885753;
        Thu, 04 Sep 2025 03:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoV8B0ddFyYBgqKe2A0XZ6K4brZeQS35NUh1Kk9RoGnZ+inndQam3GisCaFoly+ljkesvlfg==
X-Received: by 2002:a05:6000:65b:b0:3d4:a64:6758 with SMTP id ffacd0b85a97d-3d40a646c13mr11675651f8f.3.1756980885372;
        Thu, 04 Sep 2025 03:14:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e21e4c0e6fsm584448f8f.17.2025.09.04.03.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 03:14:44 -0700 (PDT)
Message-ID: <3997965c-4cc6-405c-b6fe-a70b4e75afa6@redhat.com>
Date: Thu, 4 Sep 2025 12:14:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, lorenzo.stoakes@oracle.com
Cc: kernel-team@android.com, android-mm@google.com,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250903232437.1454293-1-kaleshsingh@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250903232437.1454293-1-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.09.25 01:24, Kalesh Singh wrote:
> The check against the max map count (sysctl_max_map_count) was
> open-coded in several places. This led to inconsistent enforcement
> and subtle bugs where the limit could be exceeded.
> 
> For example, some paths would check map_count > sysctl_max_map_count
> before allocating a new VMA and incrementing the count, allowing the
> process to reach sysctl_max_map_count + 1:
> 
>      int do_brk_flags(...)
>      {
>          if (mm->map_count > sysctl_max_map_count)
>              return -ENOMEM;
> 
>          /* We can get here with mm->map_count == sysctl_max_map_count */
> 
>          vma = vm_area_alloc(mm);
>          ...
>          mm->map_count++   /* We've now exceeded the threshold. */
>      }
> 
> To fix this and unify the logic, introduce a new function,
> exceeds_max_map_count(), to consolidate the check. All open-coded
> checks are replaced with calls to this new function, ensuring the
> limit is applied uniformly and correctly.
> 
> To improve encapsulation, sysctl_max_map_count is now static to
> mm/mmap.c. The new helper also adds a rate-limited warning to make
> debugging applications that exhaust their VMA limit easier.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>   include/linux/mm.h | 11 ++++++++++-
>   mm/mmap.c          | 15 ++++++++++++++-
>   mm/mremap.c        |  7 ++++---
>   mm/nommu.c         |  2 +-
>   mm/util.c          |  1 -
>   mm/vma.c           |  6 +++---
>   6 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..d4e64e6a9814 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -192,7 +192,16 @@ static inline void __mm_zero_struct_page(struct page *page)
>   #define MAPCOUNT_ELF_CORE_MARGIN	(5)
>   #define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
>   
> -extern int sysctl_max_map_count;
> +/**
> + * exceeds_max_map_count - check if a VMA operation would exceed max_map_count
> + * @mm: The memory descriptor for the process.
> + * @new_vmas: The number of new VMAs the operation will create.

It's not always a "will" right? At least I remember that this was the 
worst case scenario in some ("may split").

"The number of new VMAs the operation may create in the worst case.


-- 
Cheers

David / dhildenb


