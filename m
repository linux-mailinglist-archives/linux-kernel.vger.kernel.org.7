Return-Path: <linux-kernel+bounces-805993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE4B4906F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049C7346177
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B02830B511;
	Mon,  8 Sep 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XryH/dZC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC622759C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339676; cv=none; b=p/jFloj0t52YdvdzwAwgtss/gMXtgdb+tCyhMkC+Qcqpr5EwbrVEj2EiXCUEjqR/jBmPKP2K2vNRwxck3zuLVS+4u6y4veprlFPyGQI0/NIB+amLwxNSHROc0I+5U7Ine3lxFfdMQB5kCymjgvHa16nHyOkVACj9Dicu3GjVJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339676; c=relaxed/simple;
	bh=dJu5haeXP/GbMsCGjaEPTCUARkEEutJkdZ6n7JJnInk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnjDqQkxPXkWCYeh+mQKq0R4OTHyNzO05NnIKcfzZtZ9GPDieeON7OPKzEok91qhLpZKtmwz+exrMVW5NLUC4l0/zCRdXhqQWoplTQ2JEfbCLbqisG5yQvW5XTy+wmQWxTMzigz5EfK8ODD+WBApeYuDryoqGGll30K7RC9kPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XryH/dZC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45de1f2cdeeso8564785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757339673; x=1757944473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCHpJvxz6Qb8QBxhEywwqTxUHZsPubTDT4UbMJARa5E=;
        b=XryH/dZCrAly1hwlkUGNZGOzB1js/FPdmgTvwc6IEhWYxXHjY4WoEDEhgOxhwK/6QR
         jz3TjiXMTLAymKFIKdAGPSnShY5Gj1P28H8hfh4bM8OMdQiI6ylQPvVvi1OrBrWSuaMf
         1Lo+NE7rJfD7ohljBuasx+4+L/m9C7JuFVv4MpaN5/DH6sbBuPYUT9mjNv/wd33t7glD
         qZhJZtwgzJaTvKpBpPB8zLFTtUEdxc6PgbfVB1fNR0BAsrMjjFZRX8QyEOYInJrr0RCr
         UH9dw90cXhIPKYKYPvdPCC94DDvTdpk7akFsnOhk2pOBXKruha3+xRKD34DZVSkHqghF
         F0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757339673; x=1757944473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCHpJvxz6Qb8QBxhEywwqTxUHZsPubTDT4UbMJARa5E=;
        b=qlJoX2QXzQy9vAjaYyrGHWLFMFQiRdaenL6aa/bFOklc8c+tu7yjB+oXImbaA1JaQn
         zWo56cmbx7+TfALRHW23Pe70JjuUZbS1Y1LUmt96SagoO4o4VVlMoNXNWPg5FjMoxnxC
         pQR2K0nZGRg/IXMqMNZnQFAoOf320QDCPogGctcT2akHOuauSgFu1R+dmEstly/XQJHP
         mz4ljhxJsyijFat5nz3HGoPl2JuVWaOoRSialwJDazZmxk1QaHK4wk3RUD1RxrnCBnjs
         0nOVc2rkR85cfFbO3NYAOn5UBRO74o3xSSCi9z8g7BytcvYtyb301EWvva+gDGBB56Ad
         PGDw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Vc6c6tMBpqTM+MeoPNYQ9nqd4Z3JADG45oRCYo0nrXdA4/PYG+wG5zxeO0gckWTUSobHSy1i+CXATok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExBe9o8qGv0l15QiwJgpXbTdHmOzR0kJPs/IjGYH4w3wr7ayG
	L5bVt63WZrflTxRv93GZPB7hNWoCSmkDIzSPpt3KY6mQg3Y23tC9KTU6yPJF21M1a/s=
X-Gm-Gg: ASbGnctFnDLMYHLr6Q1R3Zb2c8/Xp6uX+cDa54HDHx5TNlM/FZBhWz16hxOl8C5appj
	WCOPeD72ip/6ZgNw5rNBgHvKlMEiWg6Xyvgdmbh3/OtJOUyWJveZSGEvLLOig1FLqwiSQVB1VFK
	49+HYnqUCs+qriqApc+Nyyjm/jXBXGL7bpf04S0ukeh/mheXlkiduvOVrcsR/ptikpTxB3bEWSk
	BP16LxxPqccHNPaeMBkqhdC8UwnPee1J3LHQW+YbX/Wc3IeHMPpTonjBPxIYmthekMurAAwju+q
	1qNMippt9lOVtiaEr8e4Q6vEFAwKBk/dD0XZ3j3POoOLL1jVnGWpZ3hQj+sBRzGfXoF2FJOUiZw
	oT4NO0DOLdg5vnjvwktu12T0ILXg=
X-Google-Smtp-Source: AGHT+IF+ypPVfQCAEOxwFI3Zr/SauvJzp3o2msqjq7oBAEzx5/Zdo6XXLDnm5bhPV93Qax8SeMujHg==
X-Received: by 2002:a05:600c:4f8b:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45dddecd860mr67247425e9.20.1757339673359;
        Mon, 08 Sep 2025 06:54:33 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm189909035e9.3.2025.09.08.06.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:54:33 -0700 (PDT)
Message-ID: <b4bcb7cf-da03-4263-9101-feec6d0e0d8d@linaro.org>
Date: Mon, 8 Sep 2025 14:54:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf: arm_spe: Add barrier before enabling profiling
 buffer
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexandru Elisei <Alexandru.Elisei@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-1-52a2cd223d00@linaro.org>
 <aL7dFIzEgiEETcIb@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aL7dFIzEgiEETcIb@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/09/2025 2:41 pm, Will Deacon wrote:
> On Tue, Jul 01, 2025 at 04:31:57PM +0100, James Clark wrote:
>> DEN0154 states that PMBPTR_EL1 must not be modified while the profiling
>> buffer is enabled. Ensure that enabling the buffer comes after setting
>> PMBPTR_EL1 by inserting an isb().
>>
>> This only applies to guests for now, but in future versions of the
>> architecture the PE will be allowed to behave in the same way.
>>
>> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/perf/arm_spe_pmu.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index 3efed8839a4e..6235ca7ecd48 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -537,6 +537,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>>   	limit += (u64)buf->base;
>>   	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
>>   	write_sysreg_s(base, SYS_PMBPTR_EL1);
>> +	isb();
> 
> 
> Hmm.
> 
> arm_spe_perf_aux_output_begin() is only called in two places:
> 
> 1. From arm_spe_pmu_start()
> 2. From arm_spe_pmu_irq_handler()
> 
> For (1), we know that profiling is disabled by PMSCR_EL1.ExSPE.
> For (2), we know that profiling is disabled by PMBSR_EL1.S.
> 
> In both cases, we already have an isb() before enabling profiling again
> so I don't understand what this additional isb() is achieving.
> 
> Will

It's to prevent PMBPTR_EL1 from being written to after the PMBLIMITR_EL1 
write than enables the buffer again. So you're right it's already 
disabled up to this point, which is why we didn't need to add another 
isb(). This change is only for the re-enabling bit.

If the instructions were reordered you could get this ordering at the 
end of arm_spe_perf_aux_output_begin():

   write_sysreg_s(limit, SYS_PMBLIMITR_EL1); // Enables buffer

   write_sysreg_s(base, SYS_PMBPTR_EL1);  // Invalid write to PMBPTR

Instead of the new version with the barrier where PMBPTR must come before:

   write_sysreg_s(base, SYS_PMBPTR_EL1);
   isb()
   write_sysreg_s(limit, SYS_PMBLIMITR_EL1);

Thanks
James


