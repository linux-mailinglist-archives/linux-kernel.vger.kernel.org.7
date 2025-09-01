Return-Path: <linux-kernel+bounces-794494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C36B3E29A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B2D7AAD2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92F331159E;
	Mon,  1 Sep 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkZhwX4f"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F82727E0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729367; cv=none; b=dRNzkuBLUENKkwkbUYg0KBY1O4JcuVEVVfBSovWIgyJGcoRBv03SXy2I5/s9IJJbbokfZlimt/B0JQSBJ9/MjQCEAUgS0MYJDpNabg7FS3WfN5uhwybZVYOymGelw+yTaaOVne/v4RCewiwua/E9A6t5IVtHO1Mrc9wDkI0+P7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729367; c=relaxed/simple;
	bh=VxC6+65N7fwjuQSBZWaB2FdQLsbh1mR1wNFbx5IdIN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBc6m8B2vqr7YI0IfU5RNBtwfSPJh9NSIo8MODBT6ZKMJWcQcEvu8e1gYY1Y3Bwtj14Y7c+GGEmaD/KR1smdpZy/fStOB4ed+5ItVwN0pT23TkE1jOqwEmny+Wk7fTfdYWHSf6nLxBkGSpgoZJ8ylXU+Z4UDz1Jq76FgxC/n/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkZhwX4f; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b7c56a987so12164485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756729363; x=1757334163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoSJIL4KWhDGVADj7RHQlobVtqqX19ExJc3z0hs3VMY=;
        b=gkZhwX4f67XZycM8iNmC/aDa18Yx6W5g5tRRPmFMIS480yTP8VgwFHAgPC+XgaAuYI
         mdFg7nR6Z9QX/1KdLf1cmIlalyJe0NliyufIUCFH2egk43pZLeKvRVZ7hW0wwiURV0NN
         RbtQwnHcIGIdJgNHsHY60/I2OYZygHuoZ29Ph3UtWFM3tsv/PvcSBSt0enlyBUPElGMk
         7a/lpBQH4uYoc2auMEMm9Vud2MBI1pcijg2TLU2JZ1tuZMqwt5TnakgjwCSylNyCp10i
         129dWclu3yVpIdnDV/vrGuo2QQdvLTmaRBqNSJYBrChp8/YbDP4d0ySR2oDYhF0Lwiiu
         HzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729363; x=1757334163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoSJIL4KWhDGVADj7RHQlobVtqqX19ExJc3z0hs3VMY=;
        b=IU+oWu9BjBOQVPZ1wpOYJ+M6j15AR2gbg6Hog+qybQi6wJ2EMfGzVeLYJkNgO7Gn9+
         WuJkTzbyQKQeQJAErndPOnuzIWWJMtJPF9jQVBJwwGR50xaFNMQ1FUR97QeCn9U2Ika9
         7gk+e7JraSDdED3QWKAZWtQTBo1olc71Cmbi3/FkRhzfgT4FSSpt4WBrqm8vsLf1M/QN
         3kGPelzwvcSCedh9zxQqQzDGlzW8rCuaRDOro3NudOzSIrGcgnKkQoUMzB5Q80PoMfQV
         xeodZo6irVw7kc3q9lyobS3DW2HJ/iYMmkCvXLid6XO5o0b3vAseNTqm2ryZ9tp3Q9WG
         Q5sA==
X-Forwarded-Encrypted: i=1; AJvYcCWfktXQy0IzGdr4wvn9kFFCFZN1Z1UJu456m3zUGB8XqePmyvcSxQ0E6fVQf7VRbqjPSmjlkWUO12muP98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyPIZG3Ywn34jOdpC0emCRLXbXwXx+QY+ds3d6GHKc3X3v0Lhz
	S75rNYcZrvZS02BH992BCwldWKDXhrQYdwVoZaUkGNGiveSo6NGW/EdJbp9krN5ib4U=
X-Gm-Gg: ASbGnctK8rTjgwf8E1DRTwoeivt1eUu744jsb/QggWWplmPI2Sc17OwGvjUk/Y+vB3W
	pS9ZTJRgrnbdJhjjroL0biE6YnNa2zqz/hue77bNKRo3OojjQj65QYI1xLcE+xsCbYTnspwEOY1
	vMBwW+naH2tkpw+XKFwqJlBnTLodVA1Gp/HzG+DCjMApdtyVUI2JfyRAgKRGd1m6tlHuCiffqUJ
	ZNZpxb1dm0DLppSTdy/tU3RmSIgVVRYlk4NkJcEIe7PB6OP1bFhF+dtxnIggx8XfrXue/PAnErd
	LJmGRrCTtbXrKAsKvyCvWFDSZJ2rhmA5jnRq6Lu6dqkKLsDhFyZ7MlUzwp6BVQOtJmY/XKmnykt
	sAt/QO+40PHLPco+nHrmv5wHBPRhCHM3ZSb43aFeqxvyufbBp
X-Google-Smtp-Source: AGHT+IEUYIop2eCnZ9cDKO0ghaVfpBEoRkqiBiGK9LUPFsTbQpLi8gzA5x26B8+fFer989zfNL4Sag==
X-Received: by 2002:a05:600c:4f41:b0:45b:8b3e:9f7c with SMTP id 5b1f17b1804b1-45b8b3ea0e1mr33370165e9.19.1756729362553;
        Mon, 01 Sep 2025 05:22:42 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87abc740sm88325035e9.7.2025.09.01.05.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:22:42 -0700 (PDT)
Message-ID: <e759f728-2a77-42a7-ba92-0d5f8afe2273@linaro.org>
Date: Mon, 1 Sep 2025 13:22:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/12] arm64/boot: Factor out a macro to check SPE
 version
To: Leo Yan <leo.yan@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
 <20250814-james-perf-feat_spe_eft-v7-5-6a743f7fa259@linaro.org>
 <20250901100558.GJ745921@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250901100558.GJ745921@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/09/2025 11:05 am, Leo Yan wrote:
> On Thu, Aug 14, 2025 at 10:25:27AM +0100, James Clark wrote:
>> We check the version of SPE twice, and we'll add one more check in the
>> next commit so factor out a macro to do this. Change the #3 magic number
>> to the actual SPE version define (V1p2) to make it more readable.
>>
>> No functional changes intended.
>>
>> Tested-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   arch/arm64/include/asm/el2_setup.h | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>> index 46033027510c..3a4ca7f9acfb 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -103,8 +103,7 @@
>>   	csel	x2, xzr, x0, eq			// all PMU counters from EL1
>>   
>>   	/* Statistical profiling */
>> -	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>> -	cbz	x0, .Lskip_spe_\@		// Skip if SPE not present
>> +	__spe_vers_imp .Lskip_spe_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x0 // Skip if SPE not present
>>   
>>   	mrs_s	x0, SYS_PMBIDR_EL1              // If SPE available at EL2,
>>   	and	x0, x0, #(1 << PMBIDR_EL1_P_SHIFT)
>> @@ -255,6 +254,14 @@
>>   .Lskip_brbe_\@:
>>   .endm
>>   
>> +/* Branch to skip_label if SPE version is less than given version */
>> +.macro __spe_vers_imp skip_label, version, tmp
>> +    mrs    \tmp, id_aa64dfr0_el1
>> +    ubfx   \tmp, \tmp, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>> +    cmp    \tmp, \version
>> +    b.lt   \skip_label
>> +.endm
>> +
> 
> Just wondering if we need to move the macro to the beginning of the
> file, so that we can define it first and call it afterwards.
> 
> Otherwise, LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 

It's not required, but all the other macros are defined before use and 
it looks a bit weird to not do it, so I can move it.

>>   /* Disable any fine grained traps */
>>   .macro __init_el2_fgt
>>   	mrs	x1, id_aa64mmfr0_el1
>> @@ -263,10 +270,8 @@
>>   
>>   	mov	x0, xzr
>>   	mov	x2, xzr
>> -	mrs	x1, id_aa64dfr0_el1
>> -	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>> -	cmp	x1, #3
>> -	b.lt	.Lskip_spe_fgt_\@
>> +	/* If SPEv1p2 is implemented, */
>> +	__spe_vers_imp .Lskip_spe_fgt_\@, #ID_AA64DFR0_EL1_PMSVer_V1P2, x1
>>   	/* Disable PMSNEVFR_EL1 read and write traps */
>>   	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
>>   	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
>>
>> -- 
>> 2.34.1
>>


