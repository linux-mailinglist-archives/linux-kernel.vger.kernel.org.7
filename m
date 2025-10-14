Return-Path: <linux-kernel+bounces-852206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7484BD86FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B35442544F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1CC2E7F22;
	Tue, 14 Oct 2025 09:29:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163DC2080C1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434155; cv=none; b=ewIC3CbJJ7BJSU1LrQexDeO82+iEM1pZPh/rIuEZNIktXJHrDH2BqElBgcPvwcPx/BuPVeJCg4VxZ6X61dcSFU2UPt5pKOZ/n5xwwrcuPy0CflFuqb5jg8sDaC88TkTbbJBmnX6/TQI+GwaPAtInbMxOZBwfcbKumLYljC7Y1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434155; c=relaxed/simple;
	bh=MSK0YWUfPLP0Mii1r31c4KE8XjBLvtQ+9qfanyzH7fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIyemQT4MuQrqN/NP5BNitvzxP3D9A6R2gBwNJLFH9x+E9XwFsbEMOYYIsBdk4NEDhrxBnPc1kY5aX5pbJngZ58W4fXdTC1CA3AmRFgjgLg8xtiQpl51Wp6SBW2ZjH+Wqkn0Ax+M2ImTTzyXV3b0BwkOMdtAjR7zrSQPGoMgpHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467ED1A9A;
	Tue, 14 Oct 2025 02:29:04 -0700 (PDT)
Received: from [10.44.160.74] (e126510-lin.lund.arm.com [10.44.160.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AF6E3F66E;
	Tue, 14 Oct 2025 02:29:09 -0700 (PDT)
Message-ID: <87f23627-d0cc-4d9a-a4f8-df1f61716b04@arm.com>
Date: Tue, 14 Oct 2025 11:29:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64/mm: Allow __create_pgd_mapping() to
 propagate pgtable_alloc() errors
To: Linu Cherian <linu.cherian@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>
References: <20251013080220.2027757-1-linu.cherian@arm.com>
 <20251013080220.2027757-2-linu.cherian@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20251013080220.2027757-2-linu.cherian@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2025 10:02, Linu Cherian wrote:
> [...]
>
> @@ -1877,23 +1926,30 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	if (force_pte_mapping())
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
> -	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> -			     size, params->pgprot, pgd_pgtable_alloc_init_mm,
> -			     flags);
> +	ret = __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> +				   size, params->pgprot, pgd_pgtable_alloc_init_mm,
> +				   flags);
> +

Nit: usually no empty line between a call and a trivial if (ret).

> +	if (ret)
> +		goto out;
>  
>  	memblock_clear_nomap(start, size);
>  
>  	ret = __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>  			   params);
>  	if (ret)
> -		__remove_pgd_mapping(swapper_pg_dir,
> -				     __phys_to_virt(start), size);
> +		goto out;
>  	else {
>  		/* Address of hotplugged memory can be smaller */
>  		max_pfn = max(max_pfn, PFN_UP(start + size));
>  		max_low_pfn = max_pfn;
>  	}
>  
> +	return 0;
> +
> +out:

Nit: since this is an error path, it'd be clearer to call the label
"err" rather than "out".

- Kevin

> +	__remove_pgd_mapping(swapper_pg_dir,
> +			     __phys_to_virt(start), size);
>  	return ret;
>  }
>  

