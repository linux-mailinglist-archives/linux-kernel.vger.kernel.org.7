Return-Path: <linux-kernel+bounces-745334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC49B11891
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AA8586F46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD44626A1B8;
	Fri, 25 Jul 2025 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="phEwOnb1"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5C1A41
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753425235; cv=none; b=YDsZBqi/RNokfr8eVau5V/P35wAe5wZ/8vxFq1ORq7XxVDAo0VLHQSBsPb/OuBnJVZXM/HFTd16jbpRM5s0zt962S7YC/WobI8uKOr043gISA+9X3OGJSGdpK3d0sV2IAFimCjsknguZ+Nu+HU/YhxUv4K0MtDFfcP/vzzv3qEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753425235; c=relaxed/simple;
	bh=O5sZvO2bRfOkG7bX13D5V4uZzof7+lq/HEk97vq2bZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIfxO/P0qjaUpehtC6+amGX0V/DuA9ABnsNfx+vlNTCIcIReo7pP5X7pYRD9fXbvPlj9tBa4PNbUPHu1nDiiSgN+C0pFvREUmW7qs3fdsZHCaBei3geljzkgCVnSFtb+0cgtkMl3ejCv9wd1NYzqplvP6UCQniRzw76goZBJSkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=phEwOnb1; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A54DC3F730
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1753425230;
	bh=AcnKBfE2a+S1VW5IMnseKsBzXFCCOskdFvDUc4TUQMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=phEwOnb1DModCaYwXaWXibJB64jBHa77xqhVFBDHf6x6EbdOA87Q832mcL3YNzFX4
	 xEwhEMIfO45Bj/nq1pIB89Z080OqkPLtBuog7g3OSMwRhVIMewcGSveJhb7RomZd6+
	 yKXM4Tz/Rya7ndza+aDDeZmQfQ/sR0nzWndwnfc78zBJXUVlUy/6NKLYeR/yBtz9BA
	 wtRfn+xcusMIDM4fT9qtrnTWBKx3x/FVryBgNoV/nYKO1CNT17ETCwP+NAcWC2VNq/
	 FC2R6RJlTfzGP7FopI0bv5cd039PPux5DLleFrdL7Qbn4qFKh4WedGXTy7pY4/SLn1
	 g1c40HUipmHhQ==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a503f28b09so958922f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753425230; x=1754030030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcnKBfE2a+S1VW5IMnseKsBzXFCCOskdFvDUc4TUQMs=;
        b=RD706dJu3ctSHa2gKCjQGazjTDthgCDALZiDYcFdvS25o4GB1OvJPwqsKmJUUMzfDT
         2kIzq8ewoeYQ5bNewdWj9PJ7jx37jGpgVzoqgdSo7Vvatt7aDJb1/s4F45dgsU63CbS2
         /bqHb2eeqO7u+pJI3SlnHQrKRz0622/7FNR+Hl2Q7E0ZZwRzrCPljD3q5OBTx+2MumJO
         szMDknTv8MgJsb2/ATKQE5sHvWJI1TqWs6bAFG9vsqwX7jYUQBS/fNm8TuyVT/KoXFTQ
         r//VdiXHA3b4OFGBvqCLaLvo/4Z3g7Qf5PRyf7VhEBgapF/PDfScvUxJrz1B8Kb5nLru
         //gg==
X-Forwarded-Encrypted: i=1; AJvYcCVf8wIArERBHiXHWNvwlbjfEuXLmGF1afJxKGiXhiRwBSRfAR3cpx3z7is+cIejKixpnjDQb7lkX0W1ITY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97D7J9z/526PU0IfPRmxUOGkCu+PWk4iOd/Ll06T4Hcy6DZQf
	i12hZ3FxsN+vb3I8LvWypnPeBObCQvR1Kh0Fq/0mT6by0oqcrd6+HN8iR+rIFAAkiC2GC+YEd5N
	4RvQ3QlI7Vs8Mf5ovytvjj9Q8IAi7GR9oN/+7/VwIgTxUq/61GFc+ThQwI5qFPp3aVR0r5w7XiH
	nu2+WoiA==
X-Gm-Gg: ASbGncub9psjDezEzeNwYVklWyeh+ogcbkoVnQfokc/XDyAAT6Tv++JQfeGk4wqzJnk
	LD1bcNQ3Rspua8R8VjkrYvqFn+7MlxsV4I98LjgZKcPImpmQAaG4DuaUIYH+cC80puX0iTuPPgz
	KnoHTotfRfrGURQdwl19dg5kE6BeTCf5NBffG47TIF4ae66Z+pqlcFOVtEm1FsnS6myQJxUvMAu
	2+iw0sZUnDjKoha874cNzkabChXQODqCqI7zXvVgXvdUYy2qFAwFK9NV34sZhnIzv6ORGkbJhqk
	1dZO5EjIYD057fCaPcst3uj8sp05kCJkbgNwEdJygboYcKhSu9F9iIKMEP21EYc90uFQ5IZ0+YT
	+bzpabSkysn9exy0P51RbmXJ3nke66n1qiBKX
X-Received: by 2002:a05:6000:2c0d:b0:3a5:7895:7f6b with SMTP id ffacd0b85a97d-3b7765ecfd6mr508097f8f.7.1753425230195;
        Thu, 24 Jul 2025 23:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF33NxRWxXDTDDBoqgqdvHkBJufwM8gnuJUTxJTRNJxH7wzbKZ2u1yPOgBX88LofGXQiRQPhA==
X-Received: by 2002:a05:6000:2c0d:b0:3a5:7895:7f6b with SMTP id ffacd0b85a97d-3b7765ecfd6mr508059f8f.7.1753425229758;
        Thu, 24 Jul 2025 23:33:49 -0700 (PDT)
Received: from [192.168.123.154] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcc3429sm4041277f8f.75.2025.07.24.23.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 23:33:48 -0700 (PDT)
Message-ID: <1149732f-bc8d-4339-90c3-e34aeac9f1be@canonical.com>
Date: Fri, 25 Jul 2025 08:33:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] riscv: enable landing pad enforcement
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev,
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com,
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com,
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com,
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com,
 andrew@sifive.com, ved@rivosinc.com, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>,
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-5-04b8fa44c98c@rivosinc.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250724-riscv_kcfi-v1-5-04b8fa44c98c@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 01:36, Deepak Gupta wrote:
> Enables landing pad enforcement by invoking a SBI FWFT call.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/kernel/asm-offsets.c |  1 +
>   arch/riscv/kernel/head.S        | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index e4d55126dc3e..e6a9fad86fae 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -536,6 +536,7 @@ void asm_offsets(void)
>   	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
>   	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
>   	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
> +	DEFINE(SBI_FWFT_LANDING_PAD, SBI_FWFT_LANDING_PAD);
>   	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
>   #endif
>   }
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 9c99c5ad6fe8..59af044bf85c 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -185,6 +185,16 @@ secondary_start_sbi:
>   1:
>   #endif
>   	scs_load_current
> +
> +#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_KERNEL_CFI)
> +	li a7, SBI_EXT_FWFT
> +	li a6, SBI_EXT_FWFT_SET
> +	li a0, SBI_FWFT_LANDING_PAD
> +	li a1, 1 /* enable landing pad for supervisor */
> +	li a2, SBI_FWFT_SET_FLAG_LOCK
> +	ecall	/* check for error condition and take appropriate action */
> +#endif
> +
>   	call smp_callin
>   #endif /* CONFIG_SMP */
>   
> @@ -359,6 +369,15 @@ SYM_CODE_START(_start_kernel)
>   #endif
>   	scs_load_current
>   
> +#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_KERNEL_CFI)
> +	li a7, SBI_EXT_FWFT
> +	li a6, SBI_EXT_FWFT_SET
> +	li a0, SBI_FWFT_LANDING_PAD
> +	li a1, 1 /* enable landing pad for supervisor */

The SBI specification calls BIT(0) "LOCK".
Shouldn't we define a constant for the lock bit instead of using a magic 
value?

Best regards

Heinrich

> +	li a2, SBI_FWFT_SET_FLAG_LOCK
> +	ecall	/* check for error condition and take appropriate action */
> +#endif
> +
>   #ifdef CONFIG_KASAN
>   	call kasan_early_init
>   #endif
> 


