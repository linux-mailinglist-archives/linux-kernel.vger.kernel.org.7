Return-Path: <linux-kernel+bounces-731850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1299B05A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF157A7469
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD223BCED;
	Tue, 15 Jul 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qB0U8wgK"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C22309B3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583689; cv=none; b=Uraz890XUPPiD0BBxhfgzqT9gzTy3QO/sCeK8850aV3mCuUhXtakNhDAQBXNXaUizPkPu2yIzMP6FM4pTwQIyTPleTv3Mcfimpngpu+LmtlmJm5C+9evFK0qw2b5pqhCyn5kQJWTGJAR4KZIPQaEsgK2bmxwWwYQ0WayKYYlz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583689; c=relaxed/simple;
	bh=EPw4dQ8dfonq0P3aVNF8vSgP2GKEr/WhL3SjzkV20GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK2ZHJ+BKmrvDSCL+UL9f3XLXYGEg2gei2RAjnvpCt2LxwByWqqSEtPvDoq35hauJoHDbbSFRXO2CxbqD3njwIJt9xaEh/s1ASbKQtAEdcdFhExl4Y7FLmjwOmIv9qkN3vDrRDbpS+zuAEJBYKqDiPvunIh2g2G+IdX3djCFco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qB0U8wgK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso22703235e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752583686; x=1753188486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iqo4mhXycGD6rw4UTAUbadK3TxDOKrzOub9ByVVv0xc=;
        b=qB0U8wgKfVafmrdK4SZntgzOzE/kz1dySTTGLPRY+cRfUl+WrBt/VwC2m6FYNU1yH7
         Vh5BLKy73qAclnLkaZjE/fXOjsRaiS/LP4k3CVN1eFuAAlmSk98KJ6ARpQwnDoA7xveM
         OoqV1+X1vjz/ioplbVCKh6qNdpaOY8hji45gbqObDErGAKeuEh8ysJKs8m1bschPqrf/
         owuYOAwLVuJPWGHB7ULe4Co9G7QC+wuMLsztuA5lc2PoBFbi1ZzJut1uySvsfMELl3sQ
         OGr+fmEXoAxqLkign944o2Adn8eacojfmhP7KQ/K+B0S3jc9f1fu06kOC4VgvsogcF64
         RwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752583686; x=1753188486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqo4mhXycGD6rw4UTAUbadK3TxDOKrzOub9ByVVv0xc=;
        b=Xa+chfdTWdfeG636bRZL5hMAFvauM5CtbPOuC3CBY8UmTZJa/oGHr7wBZCXEu/fYMv
         uXp3lsIhXj3x14ZrILoBXsJSxBk3PgsftyXhy+3ywdqYFIUIhSmnxqi3YzAKW8BZh8c0
         2mL/T73ERDsvj3R9Hp46xLHoYUR+WJV0FoXmRb7XzR9dPe6Y3TeiXAej1EUO4i+dnYEj
         0UT97KAHfy24gxRy5aPdHHtl6tQtHZjSlu3qNkRLxp84NJNE6vRxrhVYRQfH/MjAhdZk
         9ef9ykZ2yypbWt5GIgYsMP5hp1q3LqLit7V3Op98d3OKbiuGsEPOlAJFqfJvQJcBhPPF
         sCmg==
X-Forwarded-Encrypted: i=1; AJvYcCUrYgvab1g0hoEPFHYsStaM0FWO5hqtyn5MqIuJNpRp6Gm7oQoJ6qSpsDzS+42cqvMHZdTSCgeVCyI0Kjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9ypIs4sLulF3CKpJCNqAOWZFNhCunEzc2QzUnwJiH52R8YS5
	6ysPxhnQ5It3v6eNWDjTf9w6XcwSPs33/1/aSImtdWkLyOwEzcftkSVLvBwc1Id8Y6Q=
X-Gm-Gg: ASbGncsZNBzEM/Fk2Q0OljtHaKwk9rl9MGw4z4UJiAbPmIeEe88Ud6eY8CVORkP94am
	ef7LnJc+zn2iz3fyP4gPSrmEphgcalMpSvB/5qRI6kSIRQ077r1J1OuW2hBwiW24XcKrz0G8AJn
	EWoGcmXeKpaIKjSR1ZrxXPMtFYyour3Fnac3lk0CXcOAwIeAChfHXVTNOUDfHIvo9mP1qoudL+R
	50epOb4EJ4Q3r2bW/n+g08ll9Hmv/57wbRU2EMUvNzYnmfYSLW0OjUJyxHVkl9U6OPZ4XyPkDy4
	hL81nR2X2bWULN8xVXX5+YxVRln+xghvnM/ih8p5THSZR1FqxTst1ETsasd/w/mBWmSNObBnR2t
	GoJ2rkY0SqVFgd8leVanlioLroNg=
X-Google-Smtp-Source: AGHT+IHksQQexPF9xeIAPmAN5RQVQtwJAwRE0OCzaS0bMryNoBsPAdHpgVxKs40ogsxaKO2X4QSDVw==
X-Received: by 2002:a05:600c:8483:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-455bd87a4a2mr140606855e9.4.1752583685607;
        Tue, 15 Jul 2025 05:48:05 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45610c518e9sm84882505e9.17.2025.07.15.05.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 05:48:05 -0700 (PDT)
Message-ID: <04d52182-6043-4eaf-a898-9f8ccc893e5f@linaro.org>
Date: Tue, 15 Jul 2025 13:48:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
 <20250605-james-perf-feat_spe_eft-v3-4-71b0c9f98093@linaro.org>
 <aHUMMk9JUdK6luLN@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aHUMMk9JUdK6luLN@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/07/2025 2:54 pm, Will Deacon wrote:
> On Thu, Jun 05, 2025 at 11:49:02AM +0100, James Clark wrote:
>> SPE data source filtering (optional from Armv8.8) requires that traps to
>> the filter register PMSDSFR be disabled. Document the requirements and
>> disable the traps if the feature is present.
>>
>> Tested-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   Documentation/arch/arm64/booting.rst | 11 +++++++++++
>>   arch/arm64/include/asm/el2_setup.h   | 14 ++++++++++++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
>> index dee7b6de864f..abd75085a239 100644
>> --- a/Documentation/arch/arm64/booting.rst
>> +++ b/Documentation/arch/arm64/booting.rst
>> @@ -404,6 +404,17 @@ Before jumping into the kernel, the following conditions must be met:
>>       - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
>>       - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
>>   
>> +  For CPUs with SPE data source filtering (FEAT_SPE_FDS):
>> +
>> +  - If EL3 is present:
>> +
>> +    - MDCR_EL3.EnPMS3 (bit 42) must be initialised to 0b1.
>> +
>> +  - If the kernel is entered at EL1 and EL2 is present:
>> +
>> +    - HDFGRTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
>> +    - HDFGWTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
>> +
>>     For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
>>   
>>     - If the kernel is entered at EL1 and EL2 is present:
>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>> index 1e7c7475e43f..02b4a7fc016e 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -279,6 +279,20 @@
>>   	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
>>   	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
>>   .Lskip_pmuv3p9_\@:
>> +	mrs	x1, id_aa64dfr0_el1
>> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>> +	/* If SPE is implemented, */
>> +	cmp	x1, #ID_AA64DFR0_EL1_PMSVer_IMP
>> +	b.lt	.Lskip_spefds_\@
>> +	/* we can read PMSIDR and */
>> +	mrs_s	x1, SYS_PMSIDR_EL1
>> +	and	x1, x1,  #PMSIDR_EL1_FDS
>> +	/* if FEAT_SPE_FDS is implemented, */
>> +	cbz	x1, .Lskip_spefds_\@
>> +	/* disable traps to PMSDSFR. */
>> +	orr	x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
> 
> Why is this being done here rather than alongside the existing SPE
> configuration of HDFGRTR_EL2 and HDFGWTR_EL2 near the start of
> __init_el2_fgt?
> 
> Will

I thought everything was separated by which trap configs it writes to, 
rather than the feature. This SPE feature is in HDFGRTR2 so I put it in 
__init_el2_fgt2 rather than __init_el2_fgt.

I suppose we could have a single __init_el2_spe that writes to both 
HDFGRTR and HDFGRTR2 but we'd have to be careful to not overwrite what 
was already done in the other sections.


