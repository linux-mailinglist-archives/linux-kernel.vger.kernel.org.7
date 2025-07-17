Return-Path: <linux-kernel+bounces-735267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F87B08D03
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A17816BFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B162C17B4;
	Thu, 17 Jul 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+K21GzY"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258629E0E7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755674; cv=none; b=OGfzL5gDBsrhxIfFDYkQVb9MeOaaOOJtqedrUIS+b/2m0mUR2uKlleLCkuRnkeYQyxo+74GyfMRzVsv2QJflOITtGyWRoUQ/FA86B+f0wUtZvdlOlLI7no2COs1RmLmS6n66gMsx/O0V7aCtZZJU4QWM6Z4COT6SC218ebCzl+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755674; c=relaxed/simple;
	bh=Fu3nuu23EbvvSVOu1mAukGHD/lAbi8qN77BPJLokZ3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6dOxZ0zH1HgAhL+USdcZKDJjL9mcgw/eMu+bNkSDPRS8++EokHX6kaGlMTVgLs4b2eNM6kjJIiKkQMYXau/XiWx5f8AnM3F+wnkmcQuEnJXk2nRF28aG8S6uJOo2b6qEVq7QeFsyvnSP72d7yXzYTjhGLiqxIYxtGfNyFc0VZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B+K21GzY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae3521a129aso18013166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752755670; x=1753360470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zHTKqCPAfMzdTGOW3I4KaEoXSVvKGLzal9dHLRXowAw=;
        b=B+K21GzY1aBj56Fz+UswXylk2MB/1Xgf7DvLqu8JExj49y366ax2SceMl5BaxQ95dH
         JG0MW89XeF3ThrqIz/B8z/swqQBnrh0EjrCAoVE8fdfMZyeTsqNoHwHQbdjfzX37EgRU
         qAWUQet1v/LB9MqOTaD1sFF+DsLucZkVs3YYpLQP2Tc0NSIfx3xKxhG+JLMRx08nigQj
         53brjCSK/MbDNbUWbxE+wwiAh5KTZqsYjEEYZxfE9lp6VR9Gw7F0XI+P8FYT+AfmFUWH
         z9K9jfpAb3uhvbUEHpppLs1jInLj3Y3zk4L95Rgp9FXfjoLgpHu5CbdJowE6gZ5G9Pll
         Wn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755670; x=1753360470;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHTKqCPAfMzdTGOW3I4KaEoXSVvKGLzal9dHLRXowAw=;
        b=Alol6UZAsbCKRjlBI+ENkBqEQkzt1TLIYILnNCbxxtzZArubuhFITvZlq5FZi+m1eA
         Nr6zpWY5RsrlemEkUbQHPTZx4ziYufaXRJzehZ4iUItq+uBr14QhvzZ1+gFoLnKbad53
         onGnhKQCWLUsPrwZZLaY6Jom9pjrZkPobA0BpNfH7TE2kpV1/zDCJRyjiLE+82/XiDYj
         9YvWula+UcsHxpYIAdxxu1UIwkUR+OZw7I3b4Gpi+M214ASVwryUizbrHOYcsYeYDqAQ
         sFV6+h1q1et0OrXcz8L5WyjDR6HtSbdEnqgEiV9q9QBVINvnjnZzBURym8mdIkNUShse
         l9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1cQ0SkxyaaYcv62gZEBpuNB9MUZT1zpyvldOryO1Q6lAPAR2HzWMLpNRVwr7uhJy0EdURpi8qLepqfSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZgp0D9d1zJ5bcZ4UNyklPCWpHu49t6rGoy/nsfBd1shpT5zS
	ee9tP2DcFzlF8A02v+NnqRHXx9tFgIWrEltR7gshIcMTevENaMG2QV1ilueOaU1YIWY=
X-Gm-Gg: ASbGncvSEfhkl/5fiMOaZeABQIR/pbip2fBu8HR6Bn8vuGABihNm4v2ROakPjk+3Rjp
	rOZyzqBJm5lxmHwL4R1bDoEskiaZNFVLrIt7uZve8Cy3jdva46EYmC72rsHS3NxgI4dAu0HBHHn
	q+TBejtkbI9FzH3ZvdAuMhdnUg7pp+APANQ4gOTgXPxAtOsS2XgMcfFwAozssZnnAMupol9D0F7
	IM16RpcvNBJciCCAW4FDmxtpyzE4Qop8E7ITEpkL6wK4R2aF1vt0w8aao72S2+QOL+61TtC6wM8
	v0tSRrKXwEPKlpzjEaQPC4SXyJPFVNbmmXt+b4vc2Iyalf/iK0ajS+PedOT0Q4JX+6pC3i/t6Qq
	n0P2Oao3HzJ6cnHHUcEld5cAaVxDZ7HCEutGdo4wJPg==
X-Google-Smtp-Source: AGHT+IFOdFcxShpFpurlB/Q8b1b3yLPZEBMfzvXZnQuKdcFCkBSgOSeEdtEMf/5d2Kdn1SwqGb5CeQ==
X-Received: by 2002:a17:907:3d05:b0:ae3:63fd:c3b4 with SMTP id a640c23a62f3a-ae9c99cfa45mr272772966b.5.1752755670056;
        Thu, 17 Jul 2025 05:34:30 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e829d061sm1366264566b.142.2025.07.17.05.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 05:34:29 -0700 (PDT)
Message-ID: <cd51f5ee-8f2c-486f-9ab1-526088b17127@linaro.org>
Date: Thu, 17 Jul 2025 14:34:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] media: iris: Add support for SM8750 (VPU v3.5)
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250714-sm8750-iris-v1-0-3006293a5bc7@linaro.org>
 <20250714-sm8750-iris-v1-3-3006293a5bc7@linaro.org>
 <7b0a984f-b62a-ac4d-74bf-a6e839c59272@quicinc.com>
 <d4c39f2c-9f95-4e65-87a3-78173b39adf1@linaro.org>
 <1c5df071-7000-ab45-dbc6-4384d883ba24@quicinc.com>
 <a6dbca7e-4d49-49a6-987c-8cd587501c98@linaro.org>
 <3a87c37b-b392-598a-736f-bb01e4c311e1@quicinc.com>
 <f6f86227-8d26-400b-9ad6-605cee966b56@linaro.org>
 <fedee429-fad8-ab4c-7e8a-91ac13232501@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <fedee429-fad8-ab4c-7e8a-91ac13232501@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/07/2025 14:22, Dikshita Agarwal wrote:
> 
> 
> On 7/17/2025 4:24 PM, Krzysztof Kozlowski wrote:
>> On 17/07/2025 12:50, Dikshita Agarwal wrote:
>>>>>>>> +	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
>>>>>>>> +		ret = readl_poll_timeout(core->reg_base + VCODEC_SS_IDLE_STATUSN + 4 * i,
>>>>>>>> +					 val, val & 0x400000, 2000, 20000);
>>>>>>>> +		if (ret)
>>>>>>>> +			goto disable_power;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
>>>>>>>> +				 val, val & BIT(0), 200, 2000);
>>>>>>> what are you polling here for?
>>>>>>
>>>>>>
>>>>>> This is not different than existing code. I don't understand why you are
>>>>>> commenting on something which is already there.
>>>>>
>>>>> Which code are you referring to?
>>>>
>>>> To the existing vpu33 which had Reviewed-by: Vikash Garodia
>>>> <quic_vgarodia@quicinc.com>
>>>>
>>>> You understand that everything here is the same, everything is a copy
>>>> while adding just few more things?
>>>>
>>>> My patch is not doing in this respect anything different that what you
>>>> reviewed.
>>>>
>>>
>>> It seems to have been missed in vpu33 power off sequence as well and should
>>> be fixed.
>>>
>>> Still, as mentioned earlier as well, your reference should be
>>> HPG/downstream driver of SM8750 not the previous generation (SM8650).
>>
>> Yes and partially no, because we write upstream code matching or
>> extending existing upstream driver. As you said earlier, downstream is
>> not the truth always:
> 
> You're writing the power sequence for a new generation, so referencing the
> previous generation is totally wrong. Power sequences can vary between


No. I am extending existing source code in hopefully compatible or
matching style.

We do not follow here downstream approaches of reimplementing everything
from scratch on every new generation.

> generations — that's precisely why HPG exists.
> 
> I've already pointed this out multiple times, but let me reiterate one last
> time:
> The current power sequence code is incomplete.
> Copying the SM8650 code to SM8750 is not appropriate — it's the wrong
> reference.
You only pointed out missing AON_WRAPPER_MVP_NOC_LPI_CONTROL, so
"multiple times" is not accurate.


Best regards,
Krzysztof

