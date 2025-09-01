Return-Path: <linux-kernel+bounces-794493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D25B3E298
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC901A82D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE421322C97;
	Mon,  1 Sep 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULaJqvFx"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831FA1DFFD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729266; cv=none; b=O5nSMIBeqUZ7o6/g+0184CpTTmvNxPGMk5l44f0Q9L7RMtOZ0ETJ3GuZ87Wlw13qzbdfhnQZi0VL8zU2foJ9BeEBPZv4AXri4TwymEsPtadcY6z0CPkZgmDN0vKj9UPZkoKw0jU8ooaoW/P88VHMVZVu9yh6mTVAcMjHzVlenf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729266; c=relaxed/simple;
	bh=Jnllh8eNr0YzeochvFJKtwkXdFGoYn3ypA9uJyfTXXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntzHT2zsMO7lLXDfHoAZKq5XpF/MNDhns3Ey0+VbjYRpP+YNYVmZKc9n/HX4cKz629AlqjGYLlIIwQI4E1S9ru2pBK48dLNpEhYGulca8oZFbDbmlCP13kbs9R07+jhE9mN8aRf1XTjsylJkKu0ztnFpMR0sPLpVvv/g5SftHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ULaJqvFx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d4dcf3863dso839286f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756729263; x=1757334063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkH9UhD037/tOlhct2dcf8bkxNsOyHNCUyc1hozxGl4=;
        b=ULaJqvFxfIftOlwf/72p/nMP0olKtrlanxB3y/KUc1WxDD0cmS3zX8CO1g6hfaSNcS
         rlxSjXMZ9VI/VU2F6bxtXxL8hY8TqDbc8wnkMvIPaIApsql2WMlMUeTpAGAfJnJbUrjR
         J6LjkjxyyIZ8uMHrUeyRJ4qhjrIHZrLGn6ZOkvm9R1Rpm2q2xXe+01pgqkYie1R9U+o5
         nuji2yDDII7L+ezfzuS5Nq036wAEyPPjdzI5nYUrqSxjXurAxissIufKNkgOl+xoq8W/
         Cm3Dq2G+JAccHdLt95TZfH5svSMRC86lYFK6ziCuxZ2ZzrJrLstatKInw8xo0K2n6r0z
         ff+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729263; x=1757334063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkH9UhD037/tOlhct2dcf8bkxNsOyHNCUyc1hozxGl4=;
        b=MKktLcp8vHwCu/G4h/EIy7HrgZNtFzqwkzHpXUuDUbM6AwEZZdI6vH7a6enSgdKKH4
         y5EHUoSuQ+WskiPtnKBocF3wEacfmRadL0FtolGeJ+2yEnoedyTCv7j5UE/2GMT8AIjj
         MTElTf/U0gSGYFHkW7r926lfuInhaACCkYsycLI4Txs1u6rIiXYHdiHPNPcEh3GN3qSL
         Snlx5xNbytkpiZq1PqxvlJauVVBHFaJ2d2ESqLNwK7bgR4VlixLmFNPmq6ACCTo2g5Jc
         ObtSOHOpHqBuhky5UkB4r3Y+WzFIdAc7yOI4b6v2QOLUt5sbsY0FfnvHDJdyF4aodQIU
         R3eA==
X-Forwarded-Encrypted: i=1; AJvYcCUJutDPkAUeHr123QcAWL/Jfix+DFA/EKynQeKPu8ePTcrpfNn1dxuoFHkyGjOIOO7FR57OEYIbK5soa4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTk1z2ZlfPyvuamQSaf/q+wqWlFCZguMlW4ZVBlLV+1/8Fa+Py
	BMikgsS+Eu/LKKSrRlBytCTMdVeqSu5Lfb+3GcesVvOtNuudRvHc5EhP1mGekk3CPAM=
X-Gm-Gg: ASbGncsUjY5wYManl8qIOZpr31vsiLmxO8GtwPo5VQ++7Fwad7u7DB9FmBhxDYQwsjT
	SDVV01y3+SFfkYo3EhreSfuPBvA7zP+2sYwKpXMFVDyPRH1MRojk9PkkG7gkBdas+OgLFl+fJHh
	dGesOlThu7st7ueY1Vh+mQ+bn4Ie6/+E8RuwAVmOLDALwtsF/W9Xh0COudXbAhpGdxJsc5UMDnF
	QP+oGxikgSSYtK488ENwVpyWDC2QN91vUylOENKrAxjVdqg9tOsKr8Z1pOl7coszJ6nEgkFv82Z
	tl+aV99kDq6un7KrS7L7tQ7DAMhIiGZecbzdr+DtpxO1DwARi5AtcqrPoauKp4EKqkIAbzsBFgr
	Qg9tJd8xndG6p7kvJYQ54GYytYrs=
X-Google-Smtp-Source: AGHT+IHbSmwRu3Gk1EehF9mFzPZ3IgKGG6T2VrHQ2WXexIn9NyB08JhzOfdoNYyeZhdmO1rufQhWyA==
X-Received: by 2002:a05:6000:1ace:b0:3c4:bc55:65e1 with SMTP id ffacd0b85a97d-3d1dd434397mr6103249f8f.24.1756729262852;
        Mon, 01 Sep 2025 05:21:02 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d60cf93cb2sm5542282f8f.12.2025.09.01.05.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:21:02 -0700 (PDT)
Message-ID: <bd224e52-d786-4922-b2ba-b52f0c73badf@linaro.org>
Date: Mon, 1 Sep 2025 13:21:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/12] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
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
 <20250814-james-perf-feat_spe_eft-v7-6-6a743f7fa259@linaro.org>
 <20250901101904.GK745921@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250901101904.GK745921@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/09/2025 11:19 am, Leo Yan wrote:
> On Thu, Aug 14, 2025 at 10:25:28AM +0100, James Clark wrote:
> 
> [...]
> 
>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>> index 3a4ca7f9acfb..a0361ddcdca4 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -392,6 +392,17 @@
>>   	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
>>   	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
>>   .Lskip_pmuv3p9_\@:
>> +	/* If SPE is implemented, */
>> +	__spe_vers_imp .Lskip_spefds_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x1
>> +	/* we can read PMSIDR and */
>> +	mrs_s	x1, SYS_PMSIDR_EL1
>> +	and	x1, x1,  #PMSIDR_EL1_FDS
>> +	/* if FEAT_SPE_FDS is implemented, */
>> +	cbz	x1, .Lskip_spefds_\@
>> +	/* disable traps to PMSDSFR. */
> 
> Nitpick: the comment is a bit ambiguous for me. Would it be better to
> say "disable traps to EL2" or "set the PMSDSFR bit to disable trapping" ?
> 
> Otherwise, LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

The bit we're setting is actually called nPMSDSFR_EL1, but I can change 
it to:

   /* disable traps of PMSDSFR to EL2 */

> 
>> +	orr	x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
>> +
>> +.Lskip_spefds_\@:
>>   	msr_s   SYS_HDFGRTR2_EL2, x0
>>   	msr_s   SYS_HDFGWTR2_EL2, x0
>>   	msr_s   SYS_HFGRTR2_EL2, xzr
>>
>> -- 
>> 2.34.1
>>


