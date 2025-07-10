Return-Path: <linux-kernel+bounces-725902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2EBB00545
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39F41C408C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8693F2737E1;
	Thu, 10 Jul 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NWBVZUWG"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A07270EB0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157797; cv=none; b=NJ8LE5wAhv/f5hjEn+eGBqXndVoADAvHB1OyH26oAoGHvA0PI7jkPToGeM8BLgdiX5AexaFZMZVtBvVoSQB37cSNOeO7DBzqUrYOpZUCeLAIfBEe8imGgHmi8Q2D7nQTnIQFAnQiLogmbnFUQAao4k0P8FX4WxONAqrrXhl+iXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157797; c=relaxed/simple;
	bh=oZ7OonWWPb3CLzQvpruAiAZiFnf3bbsaJiYraXkrTTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGuvf/lVaARJjVpcBMSbuTtkX6OgGre2B7M+J6FhM11UD8frECAXMHhxCxj177GCDDeJM5WkmECiMuf26h66hLfylS+JB74fUmR64bCEdBi8mquXKe8r9gYs3xBTlyUbkbgndfIxiuhyKPAgLWMff4t6wdJCMYmg0dlspP/xz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NWBVZUWG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b54cead6cso800403b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752157794; x=1752762594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70T/mtOHoW67bNGMf99k1u6kIp6BUIzmEHFhVe6xe+4=;
        b=NWBVZUWGh9uoxmAsbhwkX5ajR1Dgt+7wCMG+931urg350JwjgwF0rcZ38mkqF6KtJx
         GEYG1ZA9cV7SrXWxr3HOESSdyEbIQ6VGVG8UouGNMIuSwoAYnahqrXPIR+4LkaIKgRc/
         m/PU6vp4wdkAjrRsD3Qt970M7DB/EQuaivplZCXScf6O+teH2RL8zcBKunLVjdVnfG44
         ckuD9p9KltPZpt2e9nB1IWQJ8KsNBSbrFWp8fkuNNpzMaN/JJXoXk/Mr8/zWza5DXOMN
         LsfS3is+PpJqxvbrE7ZncJ8rEUv/87uRSpO6P8MMYGYIdPwthiPxoMldZPn1OMYPrKHi
         /Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752157794; x=1752762594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70T/mtOHoW67bNGMf99k1u6kIp6BUIzmEHFhVe6xe+4=;
        b=FoqUHksobi2UgWqyWvumsmjnw064g1BXpj1wZUpQFid0VEyikljWLVGCFyDPfb8DbM
         h3B7L3FIdqNdHV/BIqU3ZXfdRkVbH6caKTPOOEUPmM6itz7y+YhkyLV+3Eo95wbdzQdP
         I2K1EFApukS6u8+bivcbKWIRMiG3eYZ2gHavRQ4mv5SK/g2XW7ujP2Cen1I0xPsdqFyv
         zhUTyJ4dUD+FCLc8TZBGQw4vZPZnZiLQkDTD4DiLsQFgLR8b9IZ53v2p3/EqHut5mWp1
         u9rSZFKfKPpZt8FdBDx6zTLtAHhWg3v0DAfva/zJJoh+cAl8CldvoB5FUYxRYsF5F4+E
         Ghug==
X-Gm-Message-State: AOJu0YztY7ppyYyubLKeGmRDCdPo28MgmZJ80QxiEOrB2uimzopvdyFw
	BZWlbVPhjzMgpnVjntrHUlnWEWu9wTq2cJRu2gNE2yoGW8/q40H6FoyQBWJ7PSz5E0U=
X-Gm-Gg: ASbGncvOktIqtG5dePPYpo1xqZplRr+7yLBs0wODSWM4l017FVWgXo4xo9CiKNKng4o
	aS1nlFMtfx4o2DBGYd5fL7E6unnYmJOdhjicty9xnHIkfnkPbhiyfo73DSMcec9EfG6ZQkIBnPT
	YRJd2z29U/6N8lb3O+gPWk3wULEUb6/qBGRp3f8lb6j5l5EG+QGUyjRIoyDdn7VBNR9u6e74LKg
	2fH75dVGgfQRvhCu0iSYhMdDy2mxsLCCD6+TaFWKJDttg1XZ/xsd4sHNA0JzjWgU0HLpir6DDBi
	mL8Gy6IXZfejLnSEp6PyIXOlZWG69kmopYOaQEupGRuqUclrsQvp4e3F0gTHy17jh+hmNH0JWdW
	YhLT5+NkR/Bgjuqz0W8Q1ZzGX7NQhGgZtmIie4aHYeQ==
X-Google-Smtp-Source: AGHT+IE6cvc4FDu4lXrrdeGKWhRLkK/Uxe3lGtKWtoiWILObMjxluEPeqmm80yVTtrJwg3ohULnSwA==
X-Received: by 2002:a05:6a00:a27:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-74eb558edfcmr4844441b3a.15.1752157794423;
        Thu, 10 Jul 2025 07:29:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6c5660sm2390825a12.48.2025.07.10.07.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 07:29:53 -0700 (PDT)
Message-ID: <c244c1d4-fef5-439e-8dfe-12c2f8910b18@rivosinc.com>
Date: Thu, 10 Jul 2025 16:29:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftests: riscv: add misaligned access testing
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20250710133506.994476-1-cleger@rivosinc.com>
 <mvmecuognj7.fsf@suse.de> <5db9ec69-d0e4-4113-a989-ac75d0f1e5dd@rivosinc.com>
 <mvma55cgm63.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <mvma55cgm63.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/07/2025 16:23, Andreas Schwab wrote:
> On Jul 10 2025, Clément Léger wrote:
> 
>> On 10/07/2025 15:53, Andreas Schwab wrote:
>>> On Jul 10 2025, Clément Léger wrote:
>>>
>>>> This selftest tests all the currently emulated instructions (except for
>>>> the RV32 compressed ones which are left as a future exercise for a RV32
>>>> user). For the FPU instructions, all the FPU registers are tested.
>>>
>>> If that didn't catch the missing sign extension that I just fixed in
>>> <https://lore.kernel.org/linux-riscv/mvmikk0goil.fsf@suse.de>, you
>>> should consider extending the tests.
>>>
>>
>> Hi Andreas, you link doesn't work and I didn't find anything about sign
>> extension except a patch you wrote for arch_cmpxg().
> 
> lore.k.o is currently down, here's the patch I have sent:
> 
> From 77c8255da24ee4fac54e2371594d7210d1ddee19 Mon Sep 17 00:00:00 2001
> From: Andreas Schwab <schwab@suse.de>
> Date: Thu, 10 Jul 2025 13:52:35 +0200
> Subject: [PATCH] riscv: traps_misaligned: properly sign extend value in
>  misaligned load handler
> 
> Add missing cast to signed long.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  arch/riscv/kernel/traps_misaligned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 93043924fe6c..f760e4fcc052 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -461,7 +461,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
>  	}
>  
>  	if (!fp)
> -		SET_RD(insn, regs, val.data_ulong << shift >> shift);
> +		SET_RD(insn, regs, (long)(val.data_ulong << shift) >> shift);

Hi Andreas,

Nice catch, it seems like it was fixed in OpenSBI but never backported
in the kernel. As you suggested, I'll modify the test to test the sign
extension.

Thanks,

Clément

>  	else if (len == 8)
>  		set_f64_rd(insn, regs, val.data_u64);
>  	else


