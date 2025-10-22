Return-Path: <linux-kernel+bounces-866016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C053BFE9BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88253A710D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9F429617D;
	Wed, 22 Oct 2025 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI8gSQpa"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C842472AE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176971; cv=none; b=MG4n7Fc5xk3UGBiaPpkWJSsFXBPtZCDF0KDRfkKcQsjV/FshMBChtAztlLp9w/gqyFBlVEIPXNkbdxWUFVHKqIfhhIgxTCkRCwqzrNCXWSBhwmV8ewWGXsIYVSABYLvbvXx9gkkFIvK+hewa0spv4BQz5JjGaLjLLcq33WkayK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176971; c=relaxed/simple;
	bh=fqYMAKlqtZJtiuJ1ERUUL+oJvskTG+jxNptCeiCYtag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZgvuFxbJyV+8S4H5Xd8BWahX4fYs2b+pHul3jvj9htZWjzIMOSnjnD6pS2ZYttRTYO/5UlFyQTq8xe1vlnrA8LQB8tUnpymb+BpOiIdSJj9Hv8kOuqrTG0EuqPIg86XKnnL00pzTq4GZhg3E0lR/v+/qxy9A9n8b1B3ykM7Njs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI8gSQpa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475c696ab23so683935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761176968; x=1761781768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iAsIQREh+zGURAyjuCvUwYmGkRo9NPMoW7K+cQ8Syg=;
        b=PI8gSQpaxmAxoUKAcxlaZycH694Z6BqI5eLDQSYD2or5t367pZWjvTvBG2x/MF6Z75
         tM1k3g/6GsQ4G26pgonIaBFT7xXT/dDQoC2UJIUMkjiUtA1iRyqpMBlSBGCAfpZIEiKq
         YHBJ6TZoUcFvwWrrCSVAw6LYlYvKlYk2jf0WpbjE4P3Mexs4Xr2CbtIPB9xlY+v5QmIM
         eCghWImf8I59o4DvwAe65W0Om+RJZ7c1jLIZ174WLfsuVNmJPKxqurp0L++2DaIaihNI
         G9nc0Ys1UTYDHsabsFVgs0ozLlN0qIfEbB0+G40kjVzvZAMAh5gvmtenui1mXtU0ptIz
         SR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176968; x=1761781768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iAsIQREh+zGURAyjuCvUwYmGkRo9NPMoW7K+cQ8Syg=;
        b=nG6//rLJ4dsnrobE5HdiMVWOhDPQ9WTpBVUSZ7yytMpVfG9JcpuKyIG+JqS1ZUFF9Y
         xkODVotpCMAmp3jmOD8u60BqwROR9tCfvORHk37mFp+M6aInEQriTMiyrqbE9AtSb2Ur
         t/Ti6krrEK2plc1u+d8Vaz/UH501CpHduH0NaJXOgwwN+ylyPasQYovnuEROxqMAsIA/
         oSu5vzcn5aPHCEAJps1RpuijscW7ZWoG1yNuQ0tz93NhKvsudu1qY/ayZ83LlSfqgmv1
         Ull9uZzceQ9GxQQd4xN17D6PqpDK24VrKRlcg4hlWbJe303CKki+WJWzmCPH7r+HD23V
         miJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLYrbK5AdcSKX2FzSHVO2naMdtYSAArSYrc3DFYfDQklZaKDhXE+wF1mdmcT35nlSF8yHKQLOP5TQ8utE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwocRYzzV94hhcgz1RbMhWJ49tv/cHhzalWkQr6yKZVP5/Rfz3c
	0kS0jDedyLZ77IuKPr19n2DbaKAjk2wzdlhWdhRU7ZgMwXw+ZiYDo72W
X-Gm-Gg: ASbGncuOjx1reh985NF8cMedKMzz3Dvlq4kSTgPMyprXfB1C4DTy6gPYhkYX/ZrKfua
	OekJfwPZkzo/zvpf25VsH6qEPGNKznFQL/M18fTzCDWi6iBQsKTtokvUvKjcD6iyprb5ibeBEUo
	uhsn/uM2dMNnEYhle3nJ/uWjeP3453X7HtMj43YH/Tdd6RrXNlKJkfA4rwbp7kQhAyT76KMILCj
	xFgG3ZGZIqxolxw/LPGylvzT3yv/SYGDK6WO73C+emkDmpkJBaq1hJ9L+WQ1WJDcQx0D+J2+lLd
	94vFxra8wucMXxuhTGBQPm55VhkfevuKHh0TEtywnCy8qLBBwe/XH0C+Y+oVT8y3kLhtgEGBf2z
	dffi4q7dfQbSpP9/XZf5Lm53kuUyMln1CVMYqCxLVvtqzvRLv9PiSMpYVG9nGnp5Dgl+8c+ioKQ
	BJ8GEVfv8ZMjokD3DzSTzgOSeYggw9JP2TVBG1/aQSH8G3qpQ9rwdQC3eZNElKVdHzcGBvlU8Y5
	C5XjLE6Jw==
X-Google-Smtp-Source: AGHT+IEnIvYXuGkCzSV8+nhk+aDTUal3owkvZ8NNI/eJ4nC+WbM60rYIhbD7kTnRmJpNaU5p4X+VNg==
X-Received: by 2002:a05:600c:8217:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-4711790c372mr174343665e9.22.1761176967548;
        Wed, 22 Oct 2025 16:49:27 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494a91c47sm49161355e9.1.2025.10.22.16.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 16:49:26 -0700 (PDT)
Message-ID: <1a7a28d2-5a49-4522-b6e6-a42a14397aa0@gmail.com>
Date: Thu, 23 Oct 2025 00:49:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] x86/boot: Fix page table access in 5-level to 4-level
 paging transition
Content-Language: en-GB
To: Dave Hansen <dave.hansen@intel.com>, dwmw@amazon.co.uk,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com
Cc: x86@kernel.org, apopple@nvidia.com, thuth@redhat.com,
 nik.borisov@suse.com, kas@kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, kernel-team@meta.com,
 Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
 <20251022220755.1026144-2-usamaarif642@gmail.com>
 <8283c1b6-1487-49e2-b220-7dbd043a2913@intel.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <8283c1b6-1487-49e2-b220-7dbd043a2913@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/10/2025 00:16, Dave Hansen wrote:
> On 10/22/25 15:06, Usama Arif wrote:
>> +		pgdp = (pgd_t *)read_cr3_pa();
>> +		new_cr3 = (u64 *)(pgd_val(pgdp[0]) & PTE_PFN_MASK);
>> +		memcpy(trampoline_32bit, new_cr3, PAGE_SIZE);
> 
> Heh, somebody like casting, I see!

haha yeah its a lot here.
> 
> But seriously, read_cr3_pa() should be returning a physical address. No?
> Today it does:
> 
> static inline unsigned long read_cr3_pa(void)
> {
>         return __read_cr3() & CR3_ADDR_MASK;
> }
> 
> So shouldn't CR3_ADDR_MASK be masking out any naughty non-address bits?
> Shouldn't we fix read_cr3_pa() and not do this in its caller?

So we need to mask 2 things here:
- cr3, which is done by read_cr3_pa using CR3_ADDR_MASK/(__sme_clr(PHYSICAL_PAGE_MASK))
  as you pointed out.
- pgdp[0] (the deferenced value), i.e. the p4d table pointer (This was previously
  *(unsigned long *)__native_read_cr3()). This needs to be masked by PTE_PFN_MASK and
  and not PAGE_MASK which was done previously in order to take care of _PAGE_BIT_NOPTISHADOW.




