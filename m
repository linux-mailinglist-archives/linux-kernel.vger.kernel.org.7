Return-Path: <linux-kernel+bounces-806111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424CEB49201
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4193AE0D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F743002A2;
	Mon,  8 Sep 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4a9grjF"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9822AE5D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342905; cv=none; b=sKqv6aTZXVC11ZhQStQUe2kOAJUIoKM7pYZLKtJJw2P5ynQ2mPSJA2LPQxEkHYMXH4ScjmwwWOx4fSBNS03z9dcTpGdHLpg9wTNjQjW4iJwvAZYSOVSPoNTjsN4kD4Fwo4zkpXrCh4VNa15FFjW0QZsoRVe+VfwBDJ7c5FSSLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342905; c=relaxed/simple;
	bh=wYxZQsPJWMscRcV0tNuTLF9qxHI86VAlw37g1Uc0WiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlTbfbIS20xPVT0WMzTVuBVSAmU3fCcF1icjz5jIsmyX/qKpR8HYyzGJ5Ja8l5OqxsWyB0v9B600FfKN/+2vDciHAPOQJQlqnaOwpPme8N6k+/HRfXKtFXqmDsfeDrrha7FSvAMdh3d5ArACZR6yBcAoIA045DeKeZmh5Y+dofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L4a9grjF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so30528565e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757342901; x=1757947701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAvCbKbdsh9AD3IPo9PqUkN5Wi8Z7B3asWHTingNxr4=;
        b=L4a9grjFU3jvX8EFIsHVngSMHyPVX+CGkwaN/PKoUS8YmQq7KUAFeU3xSQhs6gp3m4
         4X93SMk8TwGG9IZukBonN6a+6lQcUbmky9kkEzUAzwvUU1pnSrtp7hIasL9vR+bKMxYZ
         hnPb7Kg0Q4fIo6fzQbgKlIPtLzEgDDK1ajZTcKOTui8UrA0v8VHb6xLWyhXrq3+U36gn
         Tv34bkCEOrIe4Ia0m7oLAv0dk+Z6/dzbQl+qrVXi9s/XV1eUf3JJkGVxZPhGavZ7yaBX
         xS5aGagEbpu+jyMhUbyxfjMWMMKMzD7HdtEV33VBbW7Ptki3DevB6X5JWjZ/G60VeuiW
         5UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757342901; x=1757947701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAvCbKbdsh9AD3IPo9PqUkN5Wi8Z7B3asWHTingNxr4=;
        b=R3I4L58of6qI6xtZ0QdtiVIkPsE7MT4HvkDrV447QLAavMjtrn5MhDEToVvldsUAYL
         nYJZreRcQZJo06ZYngGHH3otdZ/1X931DmdfQNLhGwC/vK7T1cCSLfq9G60d7G2mWAx1
         jq96u9OkM1RW/p2/z362kPx3SyeIDSl03WAjQkfEAjm2jlxZN6WgRB9CMnhddd2UEEDr
         fijkZPaxFwCnQZpIo9oeILAmwKUlyV01CMAbOCDhWWAFTyG9jt/dDajEJOMHkD9+2MPK
         2ihxuy0kYc0OIIZSRbsLeF36EwAEY1zNpiy1asF4PJYxx0T86k44o3WW0NiA3P7RJSAT
         yCrw==
X-Forwarded-Encrypted: i=1; AJvYcCVR868j0zGGvJScoCY9h0aUeFId8fuqKQ9XbPIjiy84CQQto+Ru6uHDFQicjDHnKasY9e/9yD2cZls9jKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOiIVye1UgOHpraGtD8Dzanp7eDlqeefkiEFTBhIdF3F48lQd
	cM6Dm0CrSU0CkA3YaZskJmPrMCZLm7ba78rYrIaQF7LBydQiPUXactv93H935aQQcWY=
X-Gm-Gg: ASbGncsbA1hfTb4GikIAjWj50LlkUZckgjMWczAU5y/VZJv7K+g6Yy8IJMnmDAH06D1
	sBWhsmaF8U8sUwTxdovFj5dawC19WcT8fHXN0zE3yE/L+/SinZoNot5WdvNM/w5XjKd1g9yAAQ7
	UCJn4VENZc4NVS94gySofYUNHDhiBzen6IIu2tz+C8i9ftn03FZkjA6j8OQBS26vbc3nJsEQ2Hu
	H6vLQgXRWNn+LqDH0bqaIqPL4qU3/QxQZwOi3ACd9Z1rYxzeOv+S3lv/gcww0UZFSaUa/i1KtIA
	iiBIbJ464NyA5BHuV/vtw3TpeO0kpt0OWq0fWRD8tH8dUv+nShNQNn8rRwDWppAlS8UAdAVrlZm
	p66fqeWiR/KLlGfGFU/xk8++NY93VwADZWs2Dfw==
X-Google-Smtp-Source: AGHT+IEJo0vSHfdIztLW0ycIdQO2nmVSvnB0WqI6b4WOE4jzB6Nqjlg+ZSbAlvlaOsL9wHYhXgC+lg==
X-Received: by 2002:a05:600c:3149:b0:45d:e326:96d7 with SMTP id 5b1f17b1804b1-45de45f2bb7mr38192255e9.13.1757342901125;
        Mon, 08 Sep 2025 07:48:21 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm297159625e9.21.2025.09.08.07.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:48:20 -0700 (PDT)
Message-ID: <5e0926df-053e-4217-9141-5b1107363a89@linaro.org>
Date: Mon, 8 Sep 2025 15:48:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf: arm_spe: Add barrier before enabling profiling
 buffer
To: Alexandru Elisei <alexandru.elisei@arm.com>, Will Deacon <will@kernel.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-1-52a2cd223d00@linaro.org>
 <aG0tsz1EPbrDFTia@raptor>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aG0tsz1EPbrDFTia@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/07/2025 3:40 pm, Alexandru Elisei wrote:
> Hi James,
> 
> On Tue, Jul 01, 2025 at 04:31:57PM +0100, James Clark wrote:
>> DEN0154 states that PMBPTR_EL1 must not be modified while the profiling
>> buffer is enabled. Ensure that enabling the buffer comes after setting
>> PMBPTR_EL1 by inserting an isb().
>>
>> This only applies to guests for now, but in future versions of the
>> architecture the PE will be allowed to behave in the same way.
>>
>> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> 
> A note on why I think this is a fix.
> 
> The write to PMBLIMITR_EL1 serves two purposes: to enable the buffer and to set
> the limit for the new buffer. The statistical profiling unit (I'm calling it
> SPU) performs indirect reads of the registers. Without the ISB between the
> buffer pointer write and the write that enables + sets limit for the buffer, I
> think it's possible for the SPU to observe the PMBLIMITR_EL1 write before the
> PMBPTR_EL1 write. During this time, from the point of view of the SPU, the
> buffer is incorrectly programmed, and potentially the old PMBPTR_EL1.PTR > new
> PMBLIMITR_EL1.Limit.
> 
> arm_spe_perf_aux_output_begin() can be called after sampling has been enabled
> (PMSCR_EL1.E1SPE = 1).
> 
> Putting it all together, this means that we have all the conditions to break the
> restrictions on the current write pointer and the behaviour is UNPREDICTABLE, as
> per section D17.7.1, ARM DDI 0487L. I think it's worth pointing out that the SPU
> can do any of the folling in this situation: writing to any writable virtual
> address in the current owning translation regime (!), generate a profiling
> management event, discard all data or don't enable profiling.

D17.7.1, ARM DDI 0487L only states this is an issue at the point of 
enabling, not writing:

   "When profiling becomes enabled, all the following must be true..."

I think Will has a point that it's not enabled at this point and it only 
gets enabled after some existing isb()s. This is only an issue if we're 
following DEN0154 which seems to be more strict.

> 
> Thanks,
> Alex
> 
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
>>   
>>   out_write_limit:
>>   	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
>>
>> -- 
>> 2.34.1
>>


