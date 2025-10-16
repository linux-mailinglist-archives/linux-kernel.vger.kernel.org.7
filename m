Return-Path: <linux-kernel+bounces-856128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C5EBE32CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E929E1896BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9AC31D371;
	Thu, 16 Oct 2025 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/M7Hfdp"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D3311960
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615415; cv=none; b=JG0TZF13Avs3BUPxwyA3B03mfGheXO/XeeTb7aIiZfpcOz8WA+7EsgXkrgJEhHSzJJyaOOv/yAt2lrA2NCzgK5/ShSkpk68ZJyauPQnJ9YhZ/WKydGk5QHNhR3K28tZY/vXMSdwLYKuoNsz4P8TKRXcF79SA6vUJqWIxfIooLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615415; c=relaxed/simple;
	bh=N2WgTs/5T5fCBqZ4ODa1es3MMlQZNO1srOLrkvYjBhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5rEvYFgKRKo8EalPCrMf8Q7SAkiTRQlAgooLwbMpjq0uqujaG73AfnqVguM9AHTD4n4lVYTFsBYfyFErEZPspUpK6lkdfGAouhQ5wiQgAiTDYHbUhfCJAWwx46oQFS6wU3wrZqRT+b72499qgwuBgALvjXNjDuf5LbmRdXHE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/M7Hfdp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e9d633b78so147755566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760615411; x=1761220211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEbqZZLSc+qwF2fltsWM8Kb5Qy0LiCcBgh/Rt+CAz50=;
        b=A/M7HfdpMMCcgHIQsnEoPSfDOLdfL2GtalxzoU4elXCRSNPtciJDaOchf3uzyYuXcJ
         9Q4RSi1JFIorxdpZeYjTRVsdT0tcX05KZw+qyCLCv+nilTnDS/hT3FRP82qBY3mBDRKh
         Td8JdQ1ZybSR/jLzCJ8SL2SI2rDEIb8sfmEXQ4IdtTBVH9uGJZ8douDR68l1XUiNX3aV
         KZmfuDi+SieOsm4rcmakS9CXSF9sCjmkVvKPAkUTMmnqHZRKDC/U34MQbZqI96kAVwLI
         Xai91kaKVbgD0qcn97ay/54xnuYEaNUrAagD5uCt67eOQBADkZjAlZoy50gWhq5IteWl
         2JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615411; x=1761220211;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEbqZZLSc+qwF2fltsWM8Kb5Qy0LiCcBgh/Rt+CAz50=;
        b=dYskSH4Bs2QppVVDs6VD5zA661F2n9mWa6PdSo6Y7d3C042yfE0cqpPpgtzdrtNqzC
         soMdcrW4+noi9V+WzmgGLZTzQtNM+95aRFohBnSpA2xQADJU+IJnp97HW8ETuN2snFO0
         DxKc8fDyH3KN20H6WSnU9zCafFzKCrJfyi/29cXnWYkfGieULf/lGXLkuMvcFBrEeQPO
         SsQOQdIcA+JeSqE2SC8eYk0jpJTb1prqOlZlx1yZV/k/M8w3PLtGlu3fXNV9BjG//7ff
         MVsjRmcsrA1FgmrXAI8U1ElENvrb21mg5iHPmP9NAbxjmcmei5xUGzJaY/WtBT3tYA3t
         aZvw==
X-Forwarded-Encrypted: i=1; AJvYcCXRWPt1x7o68/OgIvkQ3NX2oVEwoCW1hJaQtsMZFIpD7+6MbLzy8HYsSKkUuykxlsdxiMrD1SS2Boqfj9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31OkbWoei1emoYHg7MU65cPMX/iUbOCQeG7DQ3uh3eS6F3NAj
	6DyiEawOBKTOic5+tVJE0MymGGKGga7G4b306DTZ+YI3oOvtWWtQeV4KtYrQ8T6BgIY5LJIkxEo
	qj7Wy
X-Gm-Gg: ASbGncsTxmM/A32Nf52NgeydyxMqoLDPobpdcMM1yOhbWw2JXLlsjvgG0gJT/UjDv9N
	+rBxqfqC7gST1EvTzCSq40fJ3XVkCf6ZCyRrCFroToaOPj3I1a6fqUb//4ShfThPDymc97KQJxl
	HFnVyV5XjpjkhaP7K/zd2OpwYlfB3xKUmTTdPoFH+hvaGOFp0FqKMCYS7WyPLYJrZCpHzwjxotM
	ul44bv7uE8saD3DID0rYBh0KlbRKcxomnY928vQfq8laky1sI7+5iv9wye0H38jZAitKPJXOifI
	cytLlQ5HBUy54DD7Q6UvDkAx20NZxdu8cY1TcPshYTBfUN6t7XbNj89Aq0vsTNUjepMMgvnQ6wv
	4UuOM1ob8dSC3UEt2ao7NhFxQFGhtHEWLVlAmw+25187ctnp+1SqwWebP+gMRtfYVXZycATQUfL
	3e7bxgPWX0229+e3eQb+dDQq2WRjWoW1A47N4BYsKqvO5kyA==
X-Google-Smtp-Source: AGHT+IEW+wnaN71oLRojt+JZzgYMxYoG0XidbWJwYAOsWETEDggOgPEoiox0/+MITAms2gR7IjA89A==
X-Received: by 2002:a17:907:96a7:b0:b2f:4970:8720 with SMTP id a640c23a62f3a-b6052a71b33mr472940466b.8.1760615411486;
        Thu, 16 Oct 2025 04:50:11 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb965c35csm489533266b.8.2025.10.16.04.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:50:11 -0700 (PDT)
Message-ID: <c4fd6bfc-cc9a-4f37-99b3-f36466691a1e@linaro.org>
Date: Thu, 16 Oct 2025 12:50:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Enable setting the rate to
 camnoc_rt_axi clock
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com>
 <9984bc23-05ef-4d46-aeb8-feb0a18e5762@kernel.org>
 <bc0caeb8-c99b-4bef-a69e-5ce433e6b890@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <bc0caeb8-c99b-4bef-a69e-5ce433e6b890@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2025 12:30, Konrad Dybcio wrote:
> On 10/16/25 7:54 AM, Krzysztof Kozlowski wrote:
>> On 15/10/2025 04:43, Hangxiang Ma wrote:
>>> On hardware architectures where a single CAMNOC module is split into
>>> two, one for each of the real time (RT) and non real time (NRT) modules
>>> within camera sub system, processing VFE output over the AXI bus
>>> requires enabling and setting the appropriate clock rate for the RT
>>> CAMNOC. This change lays the groundwork for supporting such
>>> configurations.
>>>
>>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>> ---
>>> This change lays the groundwork for supporting configurations for
>>> hardware architectures that split a single CAMNOC module into real time
>>> (RT) and non real time (NRT).
>>> ---
>>>   drivers/media/platform/qcom/camss/camss-vfe.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
>>> index ee08dbbddf88..09b29ba383f1 100644
>>> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
>>> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
>>> @@ -914,7 +914,8 @@ static int vfe_match_clock_names(struct vfe_device *vfe,
>>>   	return (!strcmp(clock->name, vfe_name) ||
>>>   		!strcmp(clock->name, vfe_lite_name) ||
>>>   		!strcmp(clock->name, "vfe_lite") ||
>>> -		!strcmp(clock->name, "camnoc_axi"));
>>> +		!strcmp(clock->name, "camnoc_axi") ||
>>> +		!strcmp(clock->name, "camnoc_rt_axi"));
>>
>> Just use camnoc_axi for both. Look at your bindings - why do you keep
>> different names for same signal?
> 
> I think the correct question to ask is:
> 
> Is camnoc_axi going to represent the other (NRT) clock in this
> setting?
> 
> Konrad

I'm - perhaps naively - assuming this clock really is required ... and 
that both will be needed concurrently.

---
bod

