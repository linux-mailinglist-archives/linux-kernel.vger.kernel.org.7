Return-Path: <linux-kernel+bounces-773100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D58E2B29B66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFF9E4E21DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306BA29B214;
	Mon, 18 Aug 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUu9/U64"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9C2798E1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503789; cv=none; b=HGtWTe68oWK0salvvGdylJzsP2XN4qh2WXsxbqXQZAyrz1H2NcleW8RTM4Vc1f9CVKSqwE53xb82DS3aVpuWL6o9JQVmPZIfdFMs2YYbi8tq1sk8LyYfYemhMCR4a8lLcR+S+s60CyD111TOrkb+i+39zVkiLBa4jUf5cw2YWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503789; c=relaxed/simple;
	bh=yuON3RAO/SPbn7wdOZ9G3BwNB6Xn0S2WhI8ic7+Zm70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psLqJ3SX9Pgp7iJ6ka8FWkKNmI2PO7QIEo/9QHPFtjrnQP5KWLJWW0eTONKCizz9W/9u2HcEneXbs98LNFaS9mzEqXEJl5aEF90B57wlX7w3D3YmNF2VSEpTNNx0gCYvvV/YDocC5yqhuVGkfl1dvSKcHsgGsYFGgChJRHq7MVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUu9/U64; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755503786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MG+P3KZK4DCofFAEgECVm3tRlJVmdNEsPB4AH15/8wI=;
	b=LUu9/U64NZtsOTZxNaSN2LdEJYYjyVG9tD2UV3WN8/tBLQcMYC+xDW5gvYe9zbz+zXXX+s
	CY1ZDYhouUkT0vycbg0oeoxIMG0DbVowWk6NuaCi49nKpx9VurxwCKW7jHn2/iKG4oaPLY
	LRjMvOXy9/DoyTAYgz2cFkbiLH7vF1M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-nVwggmZsOD2mfqEsZb-hsw-1; Mon, 18 Aug 2025 03:56:25 -0400
X-MC-Unique: nVwggmZsOD2mfqEsZb-hsw-1
X-Mimecast-MFC-AGG-ID: nVwggmZsOD2mfqEsZb-hsw_1755503784
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1ad21752so14802685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503784; x=1756108584;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MG+P3KZK4DCofFAEgECVm3tRlJVmdNEsPB4AH15/8wI=;
        b=iUh/6pXHgHCKij/qGsSvuR04itl0qfzpikNQyAFGCSiipU7ynBVXGwuWQhCib+NrOM
         qjIVax4ceYz/1G4fcPR4zsvwcucCfH0TIva7ScPLfPDLLhCZGqJEq6U7S5iUgEBXLmd7
         zjRjCdeANS4/mbvo3qiBAjMsyps78sWj+1fGxsTENgJLCeM4Q33RBVXBqFPZM5scNwGn
         sdXlQaJM1V0klJMTNRbynOI1OLUMK9x50H+PeW/ase6mMVCguSE7OXGPWxB6R/Alby5x
         I5IISCJ6Wuv6yDn8gadQjXoAJ3827fnXBB3+JcYnmJNiAdNEmpQe3AT+dCr/7fnvB2to
         hadQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqbOFFrSnuE7WnybW3hmPEskNjasAYmvywkBZcLm1UjpnzaC9YAziC5aFZuZ/BEtBnbMnFpWwQziTMZU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAiCUGb9T4e302pwLxGWSi6VrF5ecsOuoF+nW1NNdm1V6ZWUlb
	V26T/VvId0a6pKRhOv2kKv0D8wMgv+Fue0xnQfDY57+pJV7bWwyBy3M7VSzbnNDckykYzS6z0mX
	rcole0dB1LuMc1s1P+MosihzBdSuj/IZ5u4YQfR17MqEFG+W33mWvf76vOwGi8dnQug==
X-Gm-Gg: ASbGnctCL7EctdN6tUlhL+pteMFuoHF6wa6gpNsYLrUZsZJTWcu3uSE+en83KsWOguA
	Q7uQmyjn8BHluDnvSyRmSJq4IjT5uGblQc/H1l6JsCM/aSd4zQxz+MTlRFKDb/CJH0jIgKcMu9y
	ul8a7HbyX/zn86VQkqD9LaBBn/S23qjTkaHjn+C952S5MNGD3+78rKgMHKVV4QwPV5PXlP8I9uY
	Xz6bg15c2JllXr5CckhFOqAlDVvgfloDSuiDbTIGxPLMrLVdVIIPN5PlWfO2oxobBijvcmcCLv5
	CrEcY19lQFl2PZkjTJ71SVADYP1YNFYokAGGBHkKx/ubg6j8taySf0cC6B/uAapoKOOtqpaM8SW
	T7JNSFHU28muHa0BEMxyJUsDmLSKYL7rb8GLfcGluoN8FhnS0z6AVr61crjdc80YB
X-Received: by 2002:a05:600c:1ca8:b0:459:e002:8b1e with SMTP id 5b1f17b1804b1-45a1b6bf03fmr135531765e9.13.1755503783784;
        Mon, 18 Aug 2025 00:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi28hsboEh9Wu3Gf8U19Lp8pFZTMJNS3/XSgcBRFfdKS9JByMGi0h9ov3jkz1u39rS2KFugA==
X-Received: by 2002:a05:600c:1ca8:b0:459:e002:8b1e with SMTP id 5b1f17b1804b1-45a1b6bf03fmr135531535e9.13.1755503783309;
        Mon, 18 Aug 2025 00:56:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22321985sm119855405e9.17.2025.08.18.00.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:56:22 -0700 (PDT)
Message-ID: <5f9eeb98-9881-4c46-93f9-e13419d92b61@redhat.com>
Date: Mon, 18 Aug 2025 09:56:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Ujwal Kundur <ujwal.kundur@gmail.com>, akpm@linux-foundation.org,
 peterx@redhat.com, jackmanb@google.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, shuah@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250817065211.855-1-ujwal.kundur@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250817065211.855-1-ujwal.kundur@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.08.25 08:52, Ujwal Kundur wrote:
> Refactor macros and non-composite global variable definitions into a
> struct that is defined at the start of a test and is passed around
> instead of relying on global vars.
> 
> Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---
> Previous versions and discussion at:
> https://lore.kernel.org/all/20250702152057.4067-1-ujwal.kundur@gmail.com/
> 
>   Changes since v6:
>   - rebased on 6.17-rc1 changes (cd79a1d9b08a)
>     - removes unused args and adds the __unused attribute; since change
> 	 is cosmetic-only, carry forward Acked-by tag
>   - verified output remains unchanged using virtme-ng
>   Changes since v5:
>   - ensure uffd_global_test_opts_t instances are initialized
>   - verified output remains unchanged using virtme-ng
>   Changes since v4:
>   - define gopts as global within uffd-stress.c to retain existing
>     sigalrm handler logic
>   Changes since v3:
>   - more formatting fixes
>   Changes since v2:
>   - redo patch on mm-new branch
>   Changes since v1:
>   - indentation fixes
>   - squash into single patch to assist bisections
> 
>   tools/testing/selftests/mm/uffd-common.c     | 275 ++++-----
>   tools/testing/selftests/mm/uffd-common.h     |  78 +--
>   tools/testing/selftests/mm/uffd-stress.c     | 228 ++++----
>   tools/testing/selftests/mm/uffd-unit-tests.c | 561 ++++++++++---------
>   tools/testing/selftests/mm/uffd-wp-mremap.c  |  23 +-
>   5 files changed, 623 insertions(+), 542 deletions(-)

That's a lot of churn, but sounds reasonable. Only skimmed over it and 
found two nits.

> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index e309ec886fa7..f4e9a5f43e24 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -7,18 +7,30 @@
>   
>   #include "uffd-common.h"
>   
> -#define BASE_PMD_ADDR ((void *)(1UL << 30))
> -
> -volatile bool test_uffdio_copy_eexist = true;
> -unsigned long nr_parallel, nr_pages, nr_pages_per_cpu, page_size;
> -char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
> -int uffd = -1, uffd_flags, finished, *pipefd, test_type;
> -bool map_shared;
> -bool test_uffdio_wp = true;
> -unsigned long long *count_verify;
>   uffd_test_ops_t *uffd_test_ops;
>   uffd_test_case_ops_t *uffd_test_case_ops;
> -atomic_bool ready_for_fork;
> +
> +#define BASE_PMD_ADDR ((void *)(1UL << 30))
> +
> +/* pthread_mutex_t starts at page offset 0 */
> +pthread_mutex_t *area_mutex(char *area, unsigned long nr, uffd_global_test_opts_t *gopts)
> +{
> +	return (pthread_mutex_t *) (area + nr * gopts->page_size);
> +}
> +
> +/*
> + * count is placed in the page after pthread_mutex_t naturally aligned
> + * to avoid non alignment faults on non-x86 archs.
> + */
> +volatile unsigned long long *area_count(
> +		char *area, unsigned long nr,
> +		uffd_global_test_opts_t *gopts)

You can fit some parameters into the first line to make this look less 
weird.

[...]

>   	}
>   
> diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
> index b2b6116e6580..ec860625b25b 100644
> --- a/tools/testing/selftests/mm/uffd-wp-mremap.c
> +++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
> @@ -152,7 +152,11 @@ static bool range_is_swapped(void *addr, size_t size)
>   	return true;
>   }
>   
> -static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb)
> +static void test_one_folio(uffd_global_test_opts_t *gopts,
> +			   size_t size,
> +			   bool private,
> +			   bool swapout,
> +			   bool hugetlb)

Please avoid that.

static void test_one_folio(uffd_global_test_opts_t *gopts, size_t size,
		bool private, bool swapout, bool hugetlb)

-- 
Cheers

David / dhildenb


