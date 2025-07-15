Return-Path: <linux-kernel+bounces-731924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570EB05CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDA2188242B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7606E2E4984;
	Tue, 15 Jul 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4BvB3MG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941F2E7F02
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586104; cv=none; b=mvKJCznr8c7J8tGXGSx65R+NVhrzl8oPwFtqGvGQBJp/aR5qwn7WSzLMhzcpCxHgksph6ImCLI/StbtOCib2ZGg4J6fXl4+YXKm9cSwRZsS4/mQGpJvIAs0bEtxc7kVo4FIHJ77AVDfJZNFFNiGlIEBnfMYq10AO6kEb/QcrKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586104; c=relaxed/simple;
	bh=YvW4jirI2u/zHSYKM94R24WsGr7Kz4QvYaY5H8NCEfc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iYobdeD4UJuZbyE2nKxQdjaOtJX+xMbwxJMOrsnShMgqXUVHofT5AnMbxvnk2Twg+w7WBPqBgAuw79l8FLAeYR7vdlUe8GJZzIEEIx8ePmVMv3NtptU59w8lW+SDH56TnI8bNOP3++uoxdA1mMfvoguooOTRpfMoiTWquCw3LaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4BvB3MG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso40073275e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752586101; x=1753190901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zw74VlTE+k1LGKzfAzB+538GU13x3ojR1l0lw7GXER0=;
        b=s4BvB3MGfQf0Jv6yGqNrE2o8Q7SUcpcQUoMob/JRgtBD6OuWS7ouoL1Bod9ehBzgNZ
         iGKDK+Qi+OkIHdAeQEZDO2eNc3HApps2qfIjhG6U2rR/dvoUAeB3q1OFo4w0IoNB3IlH
         PFD70VRX4fZ9AGBYztakAug7IRFl8fImBS/R4vZRkuV53rZM5PtTKpt7G5CJNTHoFMDa
         ckL3WPSJBX0YElPQZXgtzqNON9MYGWIpB1R05dd6jI9XsKamox1wiuAueL/GUGA6aW6r
         nuwh7eOoWqk7KDUeJERoGSwxt04rN991CAbeH21ATKZT61MWhq2ykk48F9AIEBQYkKY/
         RLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752586101; x=1753190901;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zw74VlTE+k1LGKzfAzB+538GU13x3ojR1l0lw7GXER0=;
        b=LN+GSqZ7cEyYACsg0Ds/rkFMNvOMsURFtCBQ6JYCPgYUNnbhuMUq0hy8RqWj55dVqi
         00Cie1TLiKVR1kV5zMn7vlJ4FtMBcNnRsMm0rOfVDGionnBp7iNQtbXPVPjml3kTDK7l
         eWoBX3/Yy377iQ2STnbIdP1F0+VdAChWC2FHTQ0D1CK76KjJS2gFxXo1Ez5fFWl4hYwF
         G1nMXQOR+QCyVbCMuUaZoFDqo1mNxoEX/U+tpku7MFsndpMyh2osg1gB/yq0rgZZVMZR
         43C/VpoXwX6tlESPUJM+9uOA145n7Um2osACaSotERUGasUeqUiVB1lCheJAr9o3Llka
         KfWA==
X-Forwarded-Encrypted: i=1; AJvYcCVB53P57eBGhauSDTCWWLy/WZrJDb+XA/cUGE8v1+7SV8YQTiRO1kc1KJAH3KhnsAhu/+ncD4xIVQXnxu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+MKH0MB/Kgo0KjsrnZ6MMdJViIDxGm50Eahj8kdNMVJonFG/7
	63qaEf0VHXzn2xtN/SjLodpSGY4ASDNQ6VQFhgQ/pAIw4IyB8bTk2f8G8o2xP29pbBc=
X-Gm-Gg: ASbGncucaZADW49LTu4iDhTVCWZgCyFPmSSNREmv7/YPOCMzbMIKCoH7anfvRzPikCy
	8LPK5tvF2nOILbluyRhHLMdch83KefQEgitJxEIuAn7uZy4g5RwhkQDM7/InoV5Z8BwHZbx3egO
	EEek2M5gAUGwwfihOcHmVOircRABfLNg3PN9oXwtoBMPnRnGbnz790BSNsE253RXOsU1Xjo825s
	Ls+BbtmC5MwSYrWFKKLxdjpmrRQavCPNTfwmOkyAMulgbkejVwqqomlUW5ZIHjc3mwuc2rEN4Y0
	YC+p3ganiR1j+AUh0TP677sCZRXNWdyD5jjgR9baIyoY90l3LmAMUJUFK4e01Eqffy8DVib8csU
	pRZci0EzWFc2YMKLTFQ6sECLCxyU=
X-Google-Smtp-Source: AGHT+IEwYlVhkOTzgfZvBe2oJ6/DRqksM/2DDeWWAHWtXNUNAJyWtZXeDWpFZAMAarhRitTCjZMLeA==
X-Received: by 2002:a05:600c:4695:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-454f4259c7cmr140093315e9.20.1752586100864;
        Tue, 15 Jul 2025 06:28:20 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd540b52sm161683955e9.28.2025.07.15.06.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:28:20 -0700 (PDT)
Message-ID: <80b7c29e-83b9-46a4-826e-d252ad425d4d@linaro.org>
Date: Tue, 15 Jul 2025 14:28:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
From: James Clark <james.clark@linaro.org>
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
 <e1210c84-69d1-4fb2-88c2-a6a1bcb179c5@linaro.org>
Content-Language: en-US
In-Reply-To: <e1210c84-69d1-4fb2-88c2-a6a1bcb179c5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/07/2025 2:10 pm, James Clark wrote:
> 
> 
> On 15/07/2025 1:57 pm, Will Deacon wrote:
>> On Tue, Jul 15, 2025 at 01:48:03PM +0100, James Clark wrote:
>>>
>>>
>>> On 14/07/2025 2:54 pm, Will Deacon wrote:
>>>> On Thu, Jun 05, 2025 at 11:49:02AM +0100, James Clark wrote:
>>>>> SPE data source filtering (optional from Armv8.8) requires that 
>>>>> traps to
>>>>> the filter register PMSDSFR be disabled. Document the requirements and
>>>>> disable the traps if the feature is present.
>>>>>
>>>>> Tested-by: Leo Yan <leo.yan@arm.com>
>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>> ---
>>>>>    Documentation/arch/arm64/booting.rst | 11 +++++++++++
>>>>>    arch/arm64/include/asm/el2_setup.h   | 14 ++++++++++++++
>>>>>    2 files changed, 25 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/ 
>>>>> arch/arm64/booting.rst
>>>>> index dee7b6de864f..abd75085a239 100644
>>>>> --- a/Documentation/arch/arm64/booting.rst
>>>>> +++ b/Documentation/arch/arm64/booting.rst
>>>>> @@ -404,6 +404,17 @@ Before jumping into the kernel, the following 
>>>>> conditions must be met:
>>>>>        - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 
>>>>> 0b1.
>>>>>        - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
>>>>> +  For CPUs with SPE data source filtering (FEAT_SPE_FDS):
>>>>> +
>>>>> +  - If EL3 is present:
>>>>> +
>>>>> +    - MDCR_EL3.EnPMS3 (bit 42) must be initialised to 0b1.
>>>>> +
>>>>> +  - If the kernel is entered at EL1 and EL2 is present:
>>>>> +
>>>>> +    - HDFGRTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
>>>>> +    - HDFGWTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
>>>>> +
>>>>>      For CPUs with Memory Copy and Memory Set instructions 
>>>>> (FEAT_MOPS):
>>>>>      - If the kernel is entered at EL1 and EL2 is present:
>>>>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/ 
>>>>> include/asm/el2_setup.h
>>>>> index 1e7c7475e43f..02b4a7fc016e 100644
>>>>> --- a/arch/arm64/include/asm/el2_setup.h
>>>>> +++ b/arch/arm64/include/asm/el2_setup.h
>>>>> @@ -279,6 +279,20 @@
>>>>>        orr    x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
>>>>>        orr    x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
>>>>>    .Lskip_pmuv3p9_\@:
>>>>> +    mrs    x1, id_aa64dfr0_el1
>>>>> +    ubfx    x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>>>>> +    /* If SPE is implemented, */
>>>>> +    cmp    x1, #ID_AA64DFR0_EL1_PMSVer_IMP
>>>>> +    b.lt    .Lskip_spefds_\@
>>>>> +    /* we can read PMSIDR and */
>>>>> +    mrs_s    x1, SYS_PMSIDR_EL1
>>>>> +    and    x1, x1,  #PMSIDR_EL1_FDS
>>>>> +    /* if FEAT_SPE_FDS is implemented, */
>>>>> +    cbz    x1, .Lskip_spefds_\@
>>>>> +    /* disable traps to PMSDSFR. */
>>>>> +    orr    x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
>>>>
>>>> Why is this being done here rather than alongside the existing SPE
>>>> configuration of HDFGRTR_EL2 and HDFGWTR_EL2 near the start of
>>>> __init_el2_fgt?
>>>>
>>> I thought everything was separated by which trap configs it writes to,
>>> rather than the feature. This SPE feature is in HDFGRTR2 so I put it in
>>> __init_el2_fgt2 rather than __init_el2_fgt.
>>
>> That's fair; __init_el2_fgt isn't the right place. But the redundancy of
>> re-reading PMSVer from DFR0 is a little jarring.
>>
>>> I suppose we could have a single __init_el2_spe that writes to both 
>>> HDFGRTR
>>> and HDFGRTR2 but we'd have to be careful to not overwrite what was 
>>> already
>>> done in the other sections.
>>
>> Right, perhaps it would be clearer to have trap-preserving macros for
>> features in a specific ID register rather than per-trap configuration
>> register macros.
>>
>> In other words, we have something like __init_fgt_aa64dfr0 which would
>> configure the FGT and FGT2 registers based on features in aa64dfr0. I
>> think you'd need to have a play to see how it ends up looking but the
>> main thing to avoid is having duplicate ID register parsing code for
>> setting up FGT and FGT2 traps.
>>
>> Will
> 
> I'll give it a go but that could end up being fragile to something that 
> is dependent on two different ID registers in the future. Then we'd end 
> up in the same situation for a different reason.
> 

I think I've run into it already. Wouldn't checking for FGT and FGT2 
have to be repeated when doing each ID register? Now we only do that 
once at the start of __init_el2_fgt and __init_el2_fgt2, even if we 
might sometimes check a different ID register twice. But if we flipped 
it we'd always have to repeat those.


