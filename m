Return-Path: <linux-kernel+bounces-745323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ACBB11866
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B037166CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95451284B25;
	Fri, 25 Jul 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SGwTVuWP"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE48634A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424435; cv=none; b=FcwgFVNlHd357/H1gZsBm77iJ4FkrZz97UMv0cN05OwT+tW489848aja3kIy60xWXBIwmJ/4meXvrRt6NmN76drLK36SNTfeFdVZ/fvbE64+zoZX8aZrlVdI4N2rDc6IJ2AndjN4zhUFFPwUXcqturCF6DLinVWSbZ4jnAXEqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424435; c=relaxed/simple;
	bh=CzNkY+VnDu3peRwB9s6DITK/IEoW+u7ophXXib+eXGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3RxtHCIpMO8qGmR70CewcDKByEgRBlQVREomxkRlCWfHnDoDLwza8FQvCadinq4LFRCqOJmWJJ5vxpZ7btPwIabwcY0ADbQTOAwj9rXZ3dZIcPFdpaIfO0Vq3oIzRSRDyTf4NE2LFqgJgrrsU24faWnTTLEIHwwDdGQtbz6IBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SGwTVuWP; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6187A40304
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1753424014;
	bh=TzyPAUEa1ra9f+Fo595oVFYE4lltInSXTAdJNreFcWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=SGwTVuWPpY6c1sBas8ZSrZFlNSdI+cToZfZTpDnBCyoc3IwaGhT3YzzQtVaa1NLut
	 ovTwZ7OmUcw2zORa0q2Nm8VPL3g5soWaNEXJUcAv+oRYyVsUq5vcX57CLMc3WQm3qF
	 MFAjEA4UZj2hEjU9PhoO05Jz0xqpe5Bx2oIM4ymLfTaYRbd1SPJ++EwQkj5aqP/hyB
	 RxKmNF299j8c9A8zUQN1K47CCyokaFNvJFzilFten1OddENebYsaY/riojolSXZojC
	 YxAH3ZbJHLGIiihaPFxJmskXRlSlOys22+qaLRGcKlPUiqocLFKhz45lHYtfRQh5fU
	 LBpl1JJv4XQBw==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so8898365e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753424013; x=1754028813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzyPAUEa1ra9f+Fo595oVFYE4lltInSXTAdJNreFcWM=;
        b=Ml69Z0PY86+BPL3zLJPhkOiCyILDfM8ChllcBHK5lfp8Hg+reXfI5ZS1dGRnkFwqkI
         3ZKwaFEfNxf5SCcSEBgcJnDCmBgwD+/ZuFhAHPUIyzVAaj8NzCR6hXYVLh51FrZ7cVWG
         mA8lgUnAb/wd4ZhoWAPqrlEa5y+rlvY/8uh6yNjc5i12UqAMp5L5p/7NSZ+LyQPMH4wD
         N0Xh3kpTKtPf/2GpPJa54IXKq68GSs+Lbu9+9wipZ84kdfy4UGqP1dDuV0HODOTZaKmO
         1eho0VVbPJgRb1CWUp9V74CGTUoFBKhoYfyK3vStwaxJLLaUWO7RM8rgiRzdeALkhtu2
         D4Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5Yfeu1tLaPoZGPC85S8jm6v9PkRlgl1mvTEoJHUV2B9bsESNkcHFx1NVx3jOoqYe9tKC9ajJPu4HEv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqeXLKQ27XXmo4uHzfQKOsbK5icbz3OIZM5+QDU7GKGCUkZtRe
	NTiOPqYjYmF1FX84/7/LkvwcZA5y8OS2+kEZuqi7N8h6ELQ7/FvXMkftHYICg2pAHocKxAAr0+z
	P/tdzzzzKE2BJTF51Th/HjIkRU2UWEefWguWC+2aEx9Jhkv7jIw005LspoTkcAEpsA0fIjnkqHk
	cQ1Fu+tg==
X-Gm-Gg: ASbGncv0yT/4EpJW+kxiT5w3WqDAwuqh5vWnHM7gp/nRGsJkPJ82kF1CGcoor+QuKNs
	I98l/KgKTzxgAoxhXGLdbNg2lYAZ6Urcho1swAbDToISklazcZViu6qi3jjig58uEZOnxF3mZSV
	yN7V9L435N/e4pVkbgrBm4ZWg81Ah87SMzUMKVmgKK5GdCyciaNmZN8kWBV77CVS8vTr+G9D3ns
	VtaM0c0LOomxJGtQ7OAiXKk2hWsVoBCR2ZGs+CyIPRpg63OaRmZoWB2hvano7hIiuHPH/oPcsta
	4HW/iWQXp7timW/5s1Wf9JS6tN7PJ9Qtncb9wcYY5r/Jy5V1fKIygNDyEUrjXV1aPkeq1GPnWlt
	Mfr5RKCL5lK7ONzd86Repbb9BXM2JYfpTaF28
X-Received: by 2002:a05:600c:861a:b0:456:1bae:5470 with SMTP id 5b1f17b1804b1-45876b12ab6mr2569925e9.8.1753424013106;
        Thu, 24 Jul 2025 23:13:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnuDATio1q8lhm2BzVtYuo6oTtxWHR46flKXtmOHWUTwYg4EBDhbjT8wj0HyskkwGEINn1ow==
X-Received: by 2002:a05:600c:861a:b0:456:1bae:5470 with SMTP id 5b1f17b1804b1-45876b12ab6mr2569725e9.8.1753424012699;
        Thu, 24 Jul 2025 23:13:32 -0700 (PDT)
Received: from [192.168.123.154] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bcb61sm41269355e9.20.2025.07.24.23.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 23:13:31 -0700 (PDT)
Message-ID: <2ba0c09d-2783-4dce-a889-06e16abbde61@canonical.com>
Date: Fri, 25 Jul 2025 08:13:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] riscv: add landing pad for asm routines.
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
 <20250724-riscv_kcfi-v1-1-04b8fa44c98c@rivosinc.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250724-riscv_kcfi-v1-1-04b8fa44c98c@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 01:36, Deepak Gupta wrote:
> SYM_* macros are used to define assembly routines. In this patch series,
> re-define those macros in risc-v arch specific include file to include
> a landing pad instruction at the beginning. This is done only when the
> compiler flag for landing pad is enabled (i.e. __riscv_zicfilp).
> 
> TODO: Update `lpad 0` with `lpad %lpad_hash(name)` after toolchain
> support.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/include/asm/linkage.h | 42 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/linkage.h b/arch/riscv/include/asm/linkage.h
> index 9e88ba23cd2b..162774b81158 100644
> --- a/arch/riscv/include/asm/linkage.h
> +++ b/arch/riscv/include/asm/linkage.h
> @@ -6,7 +6,49 @@
>   #ifndef _ASM_RISCV_LINKAGE_H
>   #define _ASM_RISCV_LINKAGE_H
>   
> +#ifdef __ASSEMBLY__
> +#include <asm/assembler.h>
> +#endif
> +
>   #define __ALIGN		.balign 4
>   #define __ALIGN_STR	".balign 4"
>   
> +#ifdef __riscv_zicfilp
> +/*
> + * A landing pad instruction is needed at start of asm routines
> + * re-define macros for asm routines to have a landing pad at
> + * the beginning of function. Currently use label value of 0x1.

Your code below uses label value 0 which disables tag checking. As long 
as we don't have tool support for calculating function hashes that is an 
appropriate approach.

%s/Currently use label value of 0x1./Label value 0x0 disables tag checking./

Best regards

Heinrich

> + * Eventually, label should be calculated as a hash over function
> + * signature.
> + */
> +#define SYM_FUNC_START(name)				\
> +	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
> +	lpad 0;
> +
> +#define SYM_FUNC_START_NOALIGN(name)			\
> +	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
> +	lpad 0;
> +
> +#define SYM_FUNC_START_LOCAL(name)			\
> +	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
> +	lpad 0;
> +
> +#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
> +	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
> +	lpad 0;
> +
> +#define SYM_FUNC_START_WEAK(name)			\
> +	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
> +	lpad 0;
> +
> +#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
> +	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
> +	lpad 0;
> +
> +#define SYM_TYPED_FUNC_START(name)				\
> +	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
> +	lpad 0;
> +
> +#endif
> +
>   #endif /* _ASM_RISCV_LINKAGE_H */
> 


