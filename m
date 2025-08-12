Return-Path: <linux-kernel+bounces-765057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C5EB22AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753C3189738D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670DB2ED145;
	Tue, 12 Aug 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lEBq9h3N"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8B2EB5D5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009576; cv=none; b=GH+oLI0mGKCYxB3e+v4Vtq4N4hEjQahlk/9gcIKDEEffuYBSXUpQavAe8Ahy4WjEtqXj2ABh+EbVpUVR3bzWCcP72ifv04TMjWG9yrrpQ8vSIjkXYomVGT1KKJ6KaFIICmHHvblvRDuqEYxeZnU24xZdZ6AqkHD9cJKGxFU+wCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009576; c=relaxed/simple;
	bh=bs9h2krYimGHBRhdWNzTsStILlqiiqAf0nEm20wadXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8Wm1bcfhtRyayrESQX+DS6RmHTl9JNYy4nzSKehTIH/U+mCEGRrtwimBF68D+Jc2jTwzs5TuU6+UmBsj9km1DdSEQvrffXpYinE1kPEzt7sSsiwNNVNLgJd0taeOOjMB3vHef2jk6UFn1dxp9JVrEEAzxgC2QWvN6OTwx2/vHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lEBq9h3N; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af99942ba4cso73546766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755009572; x=1755614372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+GHP7xYbbI91uQJr7ucQdWhdh3ykzBIM0oSGZiOjI4U=;
        b=lEBq9h3NtO4vVzJc6HxB9lROmUeBh/bRiMINhb5tMkXJF09x5Aw8Y0rrw11YC4HdU1
         2mkhrjB44rohX5/PdLM54yzVA4aBsdP3Zeal7iVKsZNyJjaYj59LG6tXfCovwuYHzD3T
         ON8D13AZ2H6WRAFCwcEtqhxMVOBm00YVxOqcAo9E3lj8BOQuPuG6LQ8RL8mR5JGvPrmH
         8pymo9fnzzuR/A43183lWgAVzUYxQtNcrN2fcyj6hJsAepHpla5PD4pOWnSYb9mnjzOl
         3CNangc7Xx3AyBYf+vbli1Vp+3zUWI8ekMC4Lsfq1s+nkYO/tOKNGGGSHxtS2I/6TnKl
         G29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009572; x=1755614372;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GHP7xYbbI91uQJr7ucQdWhdh3ykzBIM0oSGZiOjI4U=;
        b=SAvTIgLRvgZNS7agG9S1nc++ResGTa/ADZsV/s3BPKoQg47253dD81WBPPLF326mSQ
         E8RkQ0jHGgxipn+iVBHW5RC9B5YkYlGe5wZzByhLjFAOoPsAbxzkzIK6ugeUaCF6NY2S
         rXvCYV7Y6fkKOqvU4qichlC6knu/CZ1jPWJYX5JwGjC3aI1bsQUXGREyOFf2icJHIqjH
         XgX5NffLCQhAj8YNalzigLuwfFvOVhJbMMVdrixXrglaIlScnR21VUoNJ6ZFwvNSaLd6
         5UY58YqTmI6LP5yyCMxbr6IbJrp5YhYwr7psAXBfSlCLHD127hTcIs4qH3Ehpk+h+sxE
         fcmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO/wyvg7whdGmikmeu2yJrLa/ZeM4JCKshBvLcy2YEmMZgGD+COF3zwPDF8VhE8ouT59tEWdTtJlZlJmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHXVPlDlttLj3QG+bTpVKhuYtna/+ZXLz5A0mjbdNvXa1t78t
	B8zo+1nTyuKqNZfKjdV3wepwTQHcVEsN3uWIsXfYHAH30ED5KiUsbaAcS4fqFXB2GMc=
X-Gm-Gg: ASbGnctk2XRJuj2cA26JfwPRcbcao3Ix7gPW7sK4/Zo2Gf/p6IXIh/eybuGriUyEJcl
	RQ5IBUzTez3ihMwEC9FfSdmVPBkCjS3JQ5X+N8FW81iyIT1P6t43ljeF3ST4d0XqiRWch/Pjl62
	T67PZODpQAUNIPs0epUA0IkwSZwJhbaJxzRcE59x3USXNkTeE8uMHRZ+rThoIEAp7NDFfV/LhGM
	U5HYqAsfRC27IJ9+bG1IM0OtpxdR2183SE93i20qQcLPLABRDsBQLYvHbNbuer+BodBd9qHTcnI
	F86UqWP5dHMxhyjyxSNuB9YYrR2dNAu3C8Nu++ZDQH8hmRLzLkVUxIe/cU6i9QaMZCJ10cKxQnW
	Tj/FJ+QA7u1f/I1/uWlSUm1PmNsy+Ayiy4dHT6oQhnUM=
X-Google-Smtp-Source: AGHT+IHj19/81SuTdzPteXB8CPyOOlrMzsRut1YcxVSG8nxgf4Uq225zw2mLSAI9+vByDLEE2YBJUw==
X-Received: by 2002:a17:907:9728:b0:ae3:5118:96b3 with SMTP id a640c23a62f3a-afb7cd676a9mr65195866b.3.1755009571677;
        Tue, 12 Aug 2025 07:39:31 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21e44csm2194309266b.113.2025.08.12.07.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 07:39:30 -0700 (PDT)
Message-ID: <7798fa0f-4786-42d2-913b-b76af91c94bc@linaro.org>
Date: Tue, 12 Aug 2025 16:39:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
 <20250806-b4-sm8750-iris-dts-v2-1-2ce197525eed@linaro.org>
 <e414163e-e171-466f-965d-afb9203d32fa@oss.qualcomm.com>
 <be5f18d9-a642-4b4e-bf69-e0108e988faf@kernel.org>
 <6ffa8d6f-d5fb-4a94-ab7c-1a923cae1332@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <6ffa8d6f-d5fb-4a94-ab7c-1a923cae1332@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/08/2025 16:26, Konrad Dybcio wrote:
> On 8/12/25 4:24 PM, Krzysztof Kozlowski wrote:
>> On 12/08/2025 16:21, Konrad Dybcio wrote:
>>> On 8/6/25 2:38 PM, Krzysztof Kozlowski wrote:
>>>> Add Iris video codec to SM8750 SoC, which comes with significantly
>>>> different powering up sequence than previous SM8650, thus different
>>>> clocks and resets.  For consistency keep existing clock and clock-names
>>>> naming, so the list shares common part.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> ---
>>>
>>> [...]
>>>
>>>> +			iris_opp_table: opp-table {
>>>> +				compatible = "operating-points-v2";
>>>> +
>>>> +				opp-240000000 {
>>>> +					opp-hz = /bits/ 64 <240000000>;
>>>> +					required-opps = <&rpmhpd_opp_low_svs_d1>,
>>>> +							<&rpmhpd_opp_low_svs_d1>;
>>>> +				};
>>>> +
>>>> +				opp-338000000 {
>>>> +					opp-hz = /bits/ 64 <338000000>;
>>>> +					required-opps = <&rpmhpd_opp_low_svs>,
>>>> +							<&rpmhpd_opp_low_svs>;
>>>> +				};
>>>> +
>>>> +				opp-420000000 {
>>>> +					opp-hz = /bits/ 64 <420000000>;
>>>> +					required-opps = <&rpmhpd_opp_svs>,
>>>> +							<&rpmhpd_opp_svs>;
>>>> +				};
>>>> +
>>>> +				opp-444000000 {
>>>> +					opp-hz = /bits/ 64 <444000000>;
>>>> +					required-opps = <&rpmhpd_opp_svs_l1>,
>>>> +							<&rpmhpd_opp_svs_l1>;
>>>> +				};
>>>> +
>>>> +				opp-533333334 {
>>>> +					opp-hz = /bits/ 64 <533333334>;
>>>> +					required-opps = <&rpmhpd_opp_nom>,
>>>> +							<&rpmhpd_opp_nom>;
>>>> +				};
>>>
>>> There's an additional OPP: 570 MHz @ NOM_L1
>>>
>>> +Dmitry, Vikash, please make sure you're OK with the iommu entries
>>
>>
>> That opp has troubles with clock, so would need some fixed in videocc or
>> iris, AFAIK. Otherwise you will just PM OPP failures. I can add it
>> though, at the end  DTS should be independent of drivers. :)
> 
> Weird, there's an entry in the frequency table for it (well, * 3 the
> rate) and it comes out of the same PLL as other ones.. what sort of

You mean freq_tbl in P_VIDEO_CC_PLL0_OUT_MAIN? Yeah, I also saw that.

> opp failures do you see?

Only:

[    9.306006] qcom-iris aa00000.video-codec: dev_pm_opp_set_rate:
failed to find OPP for freq 630000000 (-34)
[    9.316078] qcom-iris aa00000.video-codec: power on failed
[    9.322001] qcom-iris aa00000.video-codec: core init failed


Best regards,
Krzysztof

