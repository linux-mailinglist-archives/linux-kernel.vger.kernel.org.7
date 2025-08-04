Return-Path: <linux-kernel+bounces-754796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B109B19CDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A1B3BB513
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA323A994;
	Mon,  4 Aug 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="SBsNe4Qc"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C1239581
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293468; cv=none; b=Xmhn8SSC4Ia9eFMDTISouvPuhcB6BvnUWeuxSZ51vIsTVBjs7B5JspCCBPz2zKBfHii7hp+M8HvGBV83odq4k8f4KIbqjNPy81CLLrQ+QWObEamTJb9zthV2EDVZ6ss6mKdKqL3JSkmjtbb7rmA3psLmFiOJlpqGo2tcnOyEaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293468; c=relaxed/simple;
	bh=J9+T6wYa6DATt7z15Y/JLMvaA2fcTjVIpMM1PAmN1Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djYx3YvxlkzF8qpOr6mCoDFgcmNFwKHECmcy/dhKdFTA5r85UrM/iLEtdrGNORcwP5pCWpvuVYcv/wichf3N7Fkn7D/CmGmHTyRwbHnLWsFSIS1C+fuvYnGkSeRWOwSQ3g4VnI6moq7hNHiZGk0lyGqElRaktgdKHZ5SV2KMVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=SBsNe4Qc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b786421e36so2309945f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754293464; x=1754898264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qE5bqfc6/gRoBQGgH93Iqh8i5yh90xnviBWYEKgsbs=;
        b=SBsNe4Qc7YW4SxNMSjLRmkLUrprfXZzAowNoiky5ubYNt0fzDnNkeJZM1P6H97KOdS
         FI+0f/L+QPxRW93DoJ8PdKFVea4B/k7Cg64l7fwE0gT22W81T+Vu0T8FUXffj23TBVk/
         s96du7+dkqyiefN//NpRMOT/b2XXvokGxgkhA4VpjqZ3J+KBbGBKyMxhip/i4GVAKNyv
         L+NagBXQ4q6z+5tG9OD5V9JS3IUpp0W1f+nZHvZD1Y9CGZibosg77LYDpwgHUO1kdS38
         XKS4hFM8vWTBFDC+uNe/D9pVRF/LGBjU0m9P5IpbaYhjK9zwk56nB2tlokwvzG+edvGX
         Y4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754293464; x=1754898264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qE5bqfc6/gRoBQGgH93Iqh8i5yh90xnviBWYEKgsbs=;
        b=Ae/uT3gpKvimGa6/tMHVnLhlrhzyYSTtIdkg+c5KP+3Fi2UuMy7fronh8AhEYnfabh
         bnCjwSlL+yOmMJRTcHmSj8p/2jaDnnDrE4i1+kUbW9qgAlCkSsEjvGgoTjXFYIbI+/NS
         Si2E47OvYMTc/g3/eUu6kwEP0DBjeZk2rnFpcBn3q6Isu1uU7LZCUvFd3la5qNqJoYnc
         ZkUsOvYv3bY0B+DS9cBtBvdeJEnaPPnpEzwetdeMdfeG8B2botxa+bxJmKW/jBrenwVr
         Z4HRlcaCoDuGCFNARncUb451l573OlImsDFXqUMr6i9/rMiGDbSfAyaxjmD2YEa1skEg
         hrbw==
X-Forwarded-Encrypted: i=1; AJvYcCViLMeeI+AAK+SMm7q7rXmNCug+LWIBu2PDPknNOte1ddPwjhcnn00J0hxP1LBGESeAc2ATZX92ZFvX7wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF77ouXB3oQhaj0gcxa/KFg/y3mnjstO0QI98MOHXBJn4KFcG7
	tCCvtu8m6tpqH4zQE8rtR9l5W3gLkVzrJK3BE0/O1oX9Hz1Z4QXLeEqHyqPJUkjmrrM=
X-Gm-Gg: ASbGncuxmXGYdsirivRnAcbcC/1WrKU+PcRYaAyXdt/13s5SR/fXZB0QX0hyoMa4APA
	Zzjc5rzPXuGUpm/ASVoyIGfPlezDhcFt7Op882qyFO27CMXIuUe7IbohUEAxVgir7fyS/YwwsZj
	+fz3b+YAW68P8ZzpmWcKQvJRM5DwxLLuXhtXT44brVdd01Q91I5WW6Ie9WfAOqMIFZgkXU5DcRs
	F2NL3xWBDoH3VS9J+QDqbDT4JY2Jg1/AtM8eHjiF8Le7pi9YGYtHHrT/Jh6zMAAS18+lSp596tF
	oNKTRpPa5miiX35DPp1vOw7js01m4iCafg09wVFKy9ndIqoxYKClUn5MyNulup4392w6ufmQ454
	tuy8pgVPj7s7MQZqdyn0fzVOhTkM+igkUFd6BXKFICp2iJvUWeVTZWiwv2leZbG60MEM=
X-Google-Smtp-Source: AGHT+IFu/5KFA9iys+eaVKF/vIlZ7l/B2LAyHVQTO16tEiAUvJUct9VjWAPHuEIdPHc9SqHTzkTI1g==
X-Received: by 2002:a05:6000:24c6:b0:3b7:9214:6d70 with SMTP id ffacd0b85a97d-3b8d94728c4mr5701816f8f.15.1754293463896;
        Mon, 04 Aug 2025 00:44:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4818c1sm14399230f8f.65.2025.08.04.00.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:44:23 -0700 (PDT)
Message-ID: <9f37a8b5-7c88-427c-810e-56c0b1c7acf5@rivosinc.com>
Date: Mon, 4 Aug 2025 09:44:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] riscv: insn: __read_insn use copy_from_X_nofault
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Samuel Holland <samuel.holland@sifive.com>, Deepak Gupta
 <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>,
 Atish Patra <atishp@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Conor Dooley <conor.dooley@microchip.com>, WangYuli
 <wangyuli@uniontech.com>, Huacai Chen <chenhuacai@kernel.org>,
 Nam Cao <namcao@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Joel Granados <joel.granados@kernel.org>,
 Celeste Liu <coelacanthushex@gmail.com>, Evan Green <evan@rivosinc.com>,
 Nylon Chen <nylon.chen@sifive.com>
References: <20250722173829.984082-1-jesse@rivosinc.com>
 <20250722173829.984082-4-jesse@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250722173829.984082-4-jesse@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/07/2025 19:38, Jesse Taube wrote:
> __read_insn was using get_user for user space reads and direct
> dereferencing for kernel space reads.
> Update to use copy_from_user_nofault, copy_from_kernel_nofault for this
> as get_user is user context only and may sleep.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> Squash with previous commit as it's breaks bisectability.
> Separated as i'm unsure if copy_from_user_nofault is an acceptable
> replacement.
> ---
>  arch/riscv/kernel/insn.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/insn.c b/arch/riscv/kernel/insn.c
> index dd2a6ef9fd25..b8e5202ddced 100644
> --- a/arch/riscv/kernel/insn.c
> +++ b/arch/riscv/kernel/insn.c
> @@ -2,6 +2,9 @@
>  /*
>   * Copyright 2025 Rivos, Inc
>   */
> +
> +#include <linux/uaccess.h>
> +
>  #include <asm/insn.h>
>  #include <asm/ptrace.h>
>  #include <asm/uaccess.h>
> @@ -11,10 +14,9 @@
>  	int __ret;					\
>  							\
>  	if (user_mode(regs)) {				\
> -		__ret = get_user(insn, (type __user *) insn_addr); \
> +		__ret = copy_from_user_nofault(&insn, (const type __user *) insn_addr, sizeof(type)); \
>  	} else {					\
> -		insn = *(type *)insn_addr;		\
> -		__ret = 0;				\
> +		__ret = copy_from_kernel_nofault(&insn, (const type *) insn_addr, sizeof(type)); \
>  	}						\

Hi Jesse,

This can not be used for misaligned accesses handling. As pointed out by
Samuel in a previous misaligned access handling patch, using the
no_fault() version would lead to access failure if the user memory is
swapped out. For that reason it was swapped from the no_fault() version
to the standard version.

Thanks,

Clément

>  							\
>  	__ret;						\


