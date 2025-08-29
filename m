Return-Path: <linux-kernel+bounces-792341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98412B3C2E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C627B14F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91265239E70;
	Fri, 29 Aug 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEwjGNuG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F521D3E8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494792; cv=none; b=B3CBi6YfgqoG7OlyihaxbbsfZnMx7McJddY5kzOiVDDlIJr4CbAouWesyhydEjwi2LXykeEI1HI5JW2fuhMtR3pviq/G9bvqak4q6ZB4XTeUnpu1BfoBdrnqvjNveuhRRuCzCE88xrGAkfuNm032P6PbrM8icp17qYWQVMuDvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494792; c=relaxed/simple;
	bh=aF5GEwjNnpQp6Ppnkx++4v6hTGNKye5UToYMMFO+ZXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PECclIA9Ry41uC11ZrOFM6otHvaq+Mt+8GPtSHgNsu972Rj6OdplwgQTJ1eYSwL/u07iaZWClh+PkEEDSYHWdGABdhR9MTlkGUgCfMuj6E/+VU3jzEfUO8fV8dTiQrxKmsuHmO2RRabJNQ2qn16wVxOrMhXSu4JEHfrHsh9uoEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEwjGNuG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756494790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HSeysckHnQabKeNlXpR7/heI2C5aygLCwktZgmt+6TI=;
	b=VEwjGNuGjmJyyQhkKmb7N9/QCYcdSbVAn36byMVg5TN9liqxRXorvMNby3LoEbGs4dyXsX
	inkoU3JPNVwLMsJC91sS6M/IxRscnGv/PEb7Ase0qeqBVkT5FqOcEI5yMGNvE3zI+PxIIu
	ihx2kKvG/OYCmVfevGcBdqMZdhMDaLo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-dcpIY2vvOT2RSD-GWNOukw-1; Fri, 29 Aug 2025 15:13:08 -0400
X-MC-Unique: dcpIY2vvOT2RSD-GWNOukw-1
X-Mimecast-MFC-AGG-ID: dcpIY2vvOT2RSD-GWNOukw_1756494788
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3c7990941d3so1214395f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756494787; x=1757099587;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSeysckHnQabKeNlXpR7/heI2C5aygLCwktZgmt+6TI=;
        b=u0APdeInSAlZxPhtmk5yXTcqQhQRWLfuntOeydzyvhOPIdnJGZthGWeozGR7yrKhMF
         iphPuxqBDTjZianT0jR6MNku90/1GnC5Yab9v9hpOzdYD8ngBm6eX13GJY42Mwk64uBh
         2RRAAmdyIjzNRZy5Hs3Ad+ZRr5hNzAjTk9VbTYCSC7EAdaQ3hHyEZfvWkCwJyTaGJKDe
         Lfr1Xeq+IirlMn5NiQdATl7xaCxgyeos7+XCYupoI1lnbXw0X2b2nA1xCUFr20Vfg3h1
         kK384RoxN3dNGVbdut2/tPTErUPxiGwOUouZ0dRCWJSidEw2wb0pDbAacE8ACqq4SIWX
         toDw==
X-Forwarded-Encrypted: i=1; AJvYcCXTdEoO/X2HRyi7YjbfRu6+Q/hgO1uu3LCg9z7ejn/fGwzRUUvOICql6ufiAdWWFY9ivsbMdSxIGitF3Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0FGQmQ/B+S5qksaaLx/G0nP5vYOAE6kbzpn4pxiB0bgoz9AD
	1rl7qYami+qCPxkVHqf4iB/2l+FJ04Fs+oGv38f6qOoxkF5mfPDidmbuaJUWin3GmCSqQ0Qb3fe
	XWm/fNz5Cn1Mt8r+givPgVAf0hnQn/YuLoTXd42GyHlJWmBAnA6OIyG1/Li4nYKhPcA==
X-Gm-Gg: ASbGnctFYe4QM8Tu1jpY1jLBJ51SRjMxknjyCqvTV0vFueVzqCiZzvou5ShWxcH9ALJ
	QDzpD/hhxRlElV4KMR8f99qkX1zukD9X27CIQ6aYfUZPQbv7P35FUBbkI8zAhRgfXg15DM7bUKI
	bJ7LqJ7TxqBYqG5Scijl8Bn+V2MpyqsK3YtL0WFFkj9nVL6mYR4cfdhHG8vH9zHVL38JlfaBtvu
	akKvVMDCI4VlZiS8nc8x+rB06pA76gpNQC8LnCGf1DFPyUAcVPSw/3U8rmpSVQm/4EpYzWb7+Ot
	qfhqq97qR+pv+kKkuvO97MJ6e2IhSoGXIjQWpWTC/iekANHBfgGv+8V5s1rrG1tQcm7xfTo=
X-Received: by 2002:a05:6000:2586:b0:3cf:ef30:c808 with SMTP id ffacd0b85a97d-3cfef30cb83mr2947760f8f.47.1756494787313;
        Fri, 29 Aug 2025 12:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfFSQmPSWsWJpQ1EFrfCPCBmA+jrDFQVagOXqI3mWiU8K//z/Ui607sGHoFijBJXlyfIX4Rw==
X-Received: by 2002:a05:6000:2586:b0:3cf:ef30:c808 with SMTP id ffacd0b85a97d-3cfef30cb83mr2947734f8f.47.1756494786855;
        Fri, 29 Aug 2025 12:13:06 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f07b.dip0.t-ipconnect.de. [79.224.240.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm49008435e9.19.2025.08.29.12.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:13:06 -0700 (PDT)
Message-ID: <c13af2e9-a0ac-4e1d-be8e-4612ae8d9c0f@redhat.com>
Date: Fri, 29 Aug 2025 21:13:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
 function signature
To: Kees Cook <kees@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Yue Haibing <yuehaibing@huawei.com>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, James Morse <james.morse@arm.com>,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250829190721.it.373-kees@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250829190721.it.373-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.08.25 21:07, Kees Cook wrote:
> Seen during KPTI initialization:
> 
>    CFI failure at create_kpti_ng_temp_pgd+0x124/0xce8 (target: kpti_ng_pgd_alloc+0x0/0x14; expected type: 0xd61b88b6)
> 
> The call site is alloc_init_pud() at arch/arm64/mm/mmu.c:
> 
>    pud_phys = pgtable_alloc(TABLE_PUD);
> 
> alloc_init_pud() has the prototype:
> 
>    static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>                               phys_addr_t phys, pgprot_t prot,
>                               phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>                               int flags)
> 
> where the pgtable_alloc() prototype is declared.
> 
> The target (kpti_ng_pgd_alloc) is used in arch/arm64/kernel/cpufeature.c:
> 
>    create_kpti_ng_temp_pgd(kpti_ng_temp_pgd, __pa(alloc), KPTI_NG_TEMP_VA,
>                            PAGE_SIZE, PAGE_KERNEL, kpti_ng_pgd_alloc, 0);
> 
> which is an alias for __create_pgd_mapping_locked() with prototype:
> 
>    extern __alias(__create_pgd_mapping_locked)
>    void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys,
>                                 unsigned long virt,
>                                 phys_addr_t size, pgprot_t prot,
>                                 phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>                                 int flags);
> 
> __create_pgd_mapping_locked() passes the function pointer down:
> 
>    __create_pgd_mapping_locked() -> alloc_init_p4d() -> alloc_init_pud()
> 
> But the target function (kpti_ng_pgd_alloc) has the wrong signature:
> 
>    static phys_addr_t __init kpti_ng_pgd_alloc(int shift);
> 
> The "int" should be "enum pgtable_type".
> 
> To make "enum pgtable_type" available to cpufeature.c, move
> enum pgtable_type definition from arch/arm64/mm/mmu.c to
> arch/arm64/include/asm/mmu.h.
> 
> Adjust kpti_ng_pgd_alloc to use "enum pgtable_type" instead of "int".
> The function behavior remains identical (parameter is unused).
> 
> Fixes: c64f46ee1377 ("arm64: mm: use enum to identify pgtable level instead of *_SHIFT")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   v2: Fixed the Fixes line. ;)
>   v1: https://lore.kernel.org/lkml/20250829154913.work.943-kees@kernel.org/
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Yue Haibing <yuehaibing@huawei.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> ---
>   arch/arm64/include/asm/mmu.h   | 7 +++++++
>   arch/arm64/kernel/cpufeature.c | 5 +++--
>   arch/arm64/mm/mmu.c            | 7 -------
>   3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 6e8aa8e72601..49f1a810df16 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -17,6 +17,13 @@
>   #include <linux/refcount.h>
>   #include <asm/cpufeature.h>
>   
> +enum pgtable_type {
> +	TABLE_PTE,
> +	TABLE_PMD,
> +	TABLE_PUD,
> +	TABLE_P4D,
> +};

Just noting that we now have "enum pgtable_level" in 
include/linux/pgtable.h that could at some point possibly be used here 
instead (not in this fix).

-- 
Cheers

David / dhildenb


