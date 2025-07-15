Return-Path: <linux-kernel+bounces-731879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8AFB05AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4543916E1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DDA19E97A;
	Tue, 15 Jul 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEl4XVD1"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6142DAFBD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585024; cv=none; b=M6LvQUGCG99tGxRBwf3NJiRr7C5/jrbfcZascQOUEzx3z0if1lBztLeyUMWw9CaZ8R4zmNoOfBkiiySASuChYPis5sqqrhRHc9sTZ+FCjZYcQWXvQBVb+CRpJqAAl98UKOsIJTZiuxfJ5Rr9obBMsPH5vHmow5yGcmapR0Pxo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585024; c=relaxed/simple;
	bh=DHGtu4HwP1LgM2IMWFzTtkDx34BllDYI/W2+QZldCzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoaWAYWCbIWWHh/Buo2mk9tqwtlwOYbAVB9SLW9I5r/2Kn6sz4hWEIAmiGjEvQNMCwxWVafkoTJ+VAC6Op11ZprG+iolRAqXaDM5TDY16GWng1JGVe3w9cLZBlIg+DKyYTKidZ+sspX8yAPXVmpO8fiaF02kwXNutyTV7NuG4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEl4XVD1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a5257748e1so3609983f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752585020; x=1753189820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLie5zOVyoKUjA33oPyC/WGRzvoFygYuppsebPS2FNA=;
        b=mEl4XVD14MO1nfdjWt4JCOVbSCTujFDcM+zfnjma1mwgyk9+RK+sW6dKwY2wkOP9aK
         KknmyInPBkmneEUNpkb4tmjX5Zl3ecyLYHzDrWyVXF1f5iBRiX+G/b/GSTW2v+L/5hH5
         AaCGbRE5e82AKA3PkM5B7JYmdWirKAicJ4IHFC5hGTpAmPi2gM/dcQxnoAW6qDeRoQnO
         +l4uI/kA+6ygSkcEPtKx9HgtznrHp8pibIaS1pnBZ0RBdVJSL0UI47rch5ilSSYcSLpw
         DhQysSJeagdRFBU7/k+P9mPHIuzEXKew71Sy2RmOogaekESDaTTsuMyat3c3AqVUHoxd
         VFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585020; x=1753189820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLie5zOVyoKUjA33oPyC/WGRzvoFygYuppsebPS2FNA=;
        b=k+7Sqz8Ar2P1C01HUoRZB+5/Kz2CrOdpN8LZKSLFOMyB2wA8oYH/al1IaxU+XrTUul
         vJHfRSdpguPmjiX1t3I5xX6B+/NwKp8PbAAvr+Jq7IbdYNjG0maypVYG8r9znDo4rKyI
         SssjA/+rrWc8T/9sZLCVKjZQCBrAnbeW/o8F0qb0vHpBbRoiZNCVU13RHSLcYbcfJS9U
         JuFN+DA90doxtatwQG0fYcg881nYoqHr3jlwtRu1JW460tGH8FVWVBhQymaBbxkEisVg
         nvs+u7idpjEk4AFxderwk33rptaljWjrg0QKx/fSLG93Ee85mRpD51Pq/Kd+T2LASuLe
         y+4A==
X-Forwarded-Encrypted: i=1; AJvYcCXIdy3ulQJ8i2+NmpOTCf5RPJaSLamw/tn4mWJoimi3E39K92BvxmVjHc+81IIrEl6uCQUopvekn7j4NFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQbjuTbKp1NEGciRocsq733WdPi0py1dR2f7JJXJen8rWlJXgP
	iz2k/WAzQTyf3/sAYSb+UzyYiJ/ylct7XUR1QkUW0548f7yNtdeGyBOBuFGmKZ5OC50=
X-Gm-Gg: ASbGnctO8kNnTcDGLJVTCjO/CtE3sBhsAu8whoxiOIJAffvI8jNQuh3+18do/gbcpPr
	YuDA+v6B+ifxuev7Tcxjnm4/WTj/hBodE8W5s2CxPtxhBn7d5IPDcuZTLEkDut45Cl5hdz6Km8N
	Zx3m7Ae/3QzPFnJgn7+PbPfOFlpyedHTJZzpW6CyfMU//GiVK+yoH2PWpxO7Fo8T1E0nEbgu/Eo
	LJ+0xgcjB2iIrkJL9a1TNnX8NvTjJLwTgU/oH2IUHD6lKXySUkKM8U1LPeoK7Sov7LhkGHkPOwx
	L5jdWukz3Kgjvbi+3K1TwLnsK707UQ7M6oKxET/cMw7leVhGGysQV0Fqk25EbeYotm6mkLzPrpk
	ak8NewyLFw7pGKym3nZS6mOjcwXs=
X-Google-Smtp-Source: AGHT+IFe4r8KriuNAFHXNYf/4cwh/PGYuzAM7nUnVEwSGtbr0UTcF5cgzYyzCdphFsVFvt+3gZMD1g==
X-Received: by 2002:adf:9d82:0:b0:3a4:f5f6:b4ab with SMTP id ffacd0b85a97d-3b5f2dfd6f7mr10433427f8f.30.1752585020307;
        Tue, 15 Jul 2025 06:10:20 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560733e736sm104730995e9.29.2025.07.15.06.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:10:19 -0700 (PDT)
Message-ID: <e1210c84-69d1-4fb2-88c2-a6a1bcb179c5@linaro.org>
Date: Tue, 15 Jul 2025 14:10:18 +0100
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
 <04d52182-6043-4eaf-a898-9f8ccc893e5f@linaro.org>
 <aHZQH7QGhi5pbXU8@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aHZQH7QGhi5pbXU8@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/07/2025 1:57 pm, Will Deacon wrote:
> On Tue, Jul 15, 2025 at 01:48:03PM +0100, James Clark wrote:
>>
>>
>> On 14/07/2025 2:54 pm, Will Deacon wrote:
>>> On Thu, Jun 05, 2025 at 11:49:02AM +0100, James Clark wrote:
>>>> SPE data source filtering (optional from Armv8.8) requires that traps to
>>>> the filter register PMSDSFR be disabled. Document the requirements and
>>>> disable the traps if the feature is present.
>>>>
>>>> Tested-by: Leo Yan <leo.yan@arm.com>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    Documentation/arch/arm64/booting.rst | 11 +++++++++++
>>>>    arch/arm64/include/asm/el2_setup.h   | 14 ++++++++++++++
>>>>    2 files changed, 25 insertions(+)
>>>>
>>>> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
>>>> index dee7b6de864f..abd75085a239 100644
>>>> --- a/Documentation/arch/arm64/booting.rst
>>>> +++ b/Documentation/arch/arm64/booting.rst
>>>> @@ -404,6 +404,17 @@ Before jumping into the kernel, the following conditions must be met:
>>>>        - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
>>>>        - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
>>>> +  For CPUs with SPE data source filtering (FEAT_SPE_FDS):
>>>> +
>>>> +  - If EL3 is present:
>>>> +
>>>> +    - MDCR_EL3.EnPMS3 (bit 42) must be initialised to 0b1.
>>>> +
>>>> +  - If the kernel is entered at EL1 and EL2 is present:
>>>> +
>>>> +    - HDFGRTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
>>>> +    - HDFGWTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
>>>> +
>>>>      For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
>>>>      - If the kernel is entered at EL1 and EL2 is present:
>>>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>>>> index 1e7c7475e43f..02b4a7fc016e 100644
>>>> --- a/arch/arm64/include/asm/el2_setup.h
>>>> +++ b/arch/arm64/include/asm/el2_setup.h
>>>> @@ -279,6 +279,20 @@
>>>>    	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
>>>>    	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
>>>>    .Lskip_pmuv3p9_\@:
>>>> +	mrs	x1, id_aa64dfr0_el1
>>>> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>>>> +	/* If SPE is implemented, */
>>>> +	cmp	x1, #ID_AA64DFR0_EL1_PMSVer_IMP
>>>> +	b.lt	.Lskip_spefds_\@
>>>> +	/* we can read PMSIDR and */
>>>> +	mrs_s	x1, SYS_PMSIDR_EL1
>>>> +	and	x1, x1,  #PMSIDR_EL1_FDS
>>>> +	/* if FEAT_SPE_FDS is implemented, */
>>>> +	cbz	x1, .Lskip_spefds_\@
>>>> +	/* disable traps to PMSDSFR. */
>>>> +	orr	x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
>>>
>>> Why is this being done here rather than alongside the existing SPE
>>> configuration of HDFGRTR_EL2 and HDFGWTR_EL2 near the start of
>>> __init_el2_fgt?
>>>
>> I thought everything was separated by which trap configs it writes to,
>> rather than the feature. This SPE feature is in HDFGRTR2 so I put it in
>> __init_el2_fgt2 rather than __init_el2_fgt.
> 
> That's fair; __init_el2_fgt isn't the right place. But the redundancy of
> re-reading PMSVer from DFR0 is a little jarring.
> 
>> I suppose we could have a single __init_el2_spe that writes to both HDFGRTR
>> and HDFGRTR2 but we'd have to be careful to not overwrite what was already
>> done in the other sections.
> 
> Right, perhaps it would be clearer to have trap-preserving macros for
> features in a specific ID register rather than per-trap configuration
> register macros.
> 
> In other words, we have something like __init_fgt_aa64dfr0 which would
> configure the FGT and FGT2 registers based on features in aa64dfr0. I
> think you'd need to have a play to see how it ends up looking but the
> main thing to avoid is having duplicate ID register parsing code for
> setting up FGT and FGT2 traps.
> 
> Will

I'll give it a go but that could end up being fragile to something that 
is dependent on two different ID registers in the future. Then we'd end 
up in the same situation for a different reason.


