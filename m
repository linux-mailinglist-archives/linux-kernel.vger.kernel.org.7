Return-Path: <linux-kernel+bounces-856398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AB3BE40E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85E6C3588C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAF134573F;
	Thu, 16 Oct 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HiN9j2zB"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23512345753
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626752; cv=none; b=M6cBENt3XDx1v+ZxlvbYAQfQoKVpj4zwO7KDA9OJfwyE87ZUvY+HcQc6kdJ4SN02O5U/I0MEIyE0VuBVQFCf5lbAeXMZ0qcc6nXwdS0kWTyAaK6oV1xS2gegGMnLo/toxdv7csD+rtJhzkwSpU0Coqm3HTUo8gjIIt7dV5lziqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626752; c=relaxed/simple;
	bh=aqoyK5b4pV8L0+QOWtOd8nJmahq+LYPH19Z5q3W5EyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=On/k0kVWukLgIjaF0Tl9KLmKh8oeTjKZlLRpY2+MEO4lbi0OnYagKO92V/4QD9cuI2FkhMDePDm88RB1E7kTmuEY9v35zM7i4bkQUXVSzxdLpvghvcHL/K7dbqgdTQXhKYOMJ6zjWtAqWGq2/AS7ZA2koM3Vn2hbrwCjfCd7j4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HiN9j2zB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-591c7a913afso106199e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760626748; x=1761231548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3SCwf4QRuIuRCKS4d3mSdP9dIfExgcs4ZcKTP0uVC8=;
        b=HiN9j2zBvYHcpFFU4vMtcBGHlVjh7Vj+59BH7QPNBwJGin4FqNBswoK36npdq/VaKt
         rnq6kDvIe/NC0Dc9jpagBwMtWCNIWDa+4w0MJojA5OLwXjx3jIHIVNPSH5QQLV4RzsDe
         IpRjhlpZL3p61MD+2YcbI7gjZOTKebWJFK80f9eiarq/mB5eVL60LPYCcKKYQkIrsaPI
         xYzzc6Ey4u0CAYtHN+viHWzv8Iiw+oFrad0oglv4xOmkRQIt31AJ7Z50GAtOyE0a4eDo
         sCd2NLlOLz6ou+auLKJVUxLJFhzDipgBytREaEucrLxRzXM0OpceYtoeHtw/Kibr3q5p
         HPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626748; x=1761231548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3SCwf4QRuIuRCKS4d3mSdP9dIfExgcs4ZcKTP0uVC8=;
        b=HLU0TnbbguYKhr8tfbsp9Q+edscjygtYR+QEUeMK5wxaBpw2Izhg1NVSqH6AeupM1a
         6W4rdfoCHAzN+M0xSaToIkML3/35L42vuduhrIkN86rpGpJ3Uv5EzI8kIzJSiXxpF9tT
         q0wVH5ITPecr5bWuS2CPPvFtincOCz+yFr/+lVz5WrKg4nA3R5oZRrqKvTrSzOKpxWaV
         wzBfUI/gX1sTSETmbM7SNjwqx1NGTx2DJxz7Ryll9YpQ10XsihPnp+LA4JPezzkPjYO8
         jstCOxKl0Ejuo+D6CyjWvY7WNnXREdFjbUUOMhsGMVLG6aVIguTTiOqBmTjFyDWCorjg
         yC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXwvDgjwt/7iH+4NsGKYLm4AqprhAL8UAsESlL1T8J5P2qiYsZADyo5TkOUtnQqdW5lJbpIRTezgkb0gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLLCEjCZEDeFstaKo5Gj+SjeT0QIwwy1YPmPfhnFHTBlf05cS
	MeEIfW65fYliV61+AK4VzG59+/a0LE8JGoTq5r9LWwQ28WX6MECFN3H15cueQLLjiWK9GvulEVH
	zKPRf
X-Gm-Gg: ASbGncvVdId58fIWv/I6h8rLOJe3ID9ipNTDgqzejPlfwHHBDwt9h6/7dcjayaYq/Hh
	BTRhR2qO+TZwlASmSJmiAGf7niwd8nktrX8sf04kcez3to85mKvludlrPXGnc+Jzxi4M9HinvQD
	d0c+2m5f7bev4ksGtHmer7bh1dVyky+F/IiiHLnxoxmUe8moH2XVcmDscZZZkYF4yKZVg8GeVeh
	8c5GLljuvBlJsqXq5P0YkfQvvuxRAgzKXnVeu/kJKbY5l9Qn861y/f4xYflen7XfcsrN+2ZiQMU
	wwZKTJ7b/Q9Tte7ShmaN/V3VEUnkUeZDVw/PH7W9NfteXSnFuT0LxJ40g947ik1jn3mwFMnZ2fI
	YM/aQuUitDM3Py1hbCxegGK8tu27gxsRUrU667HB/ociejm6Utj6Xxpqjvz5o/hXRW8R0PwLwDz
	NGVPrqEX07HULgdpwVqeE+RyVWyHWR2GLn8m7l5SyFIWhkrqq5p7FBs5WT71XSD7AJWOz6nA==
X-Google-Smtp-Source: AGHT+IGdNDgtmwm6+LARkC9Pg+AOicIgMi7tFiszGJ9W+MAY//8AYywpy9+uYECJSeW8kXaGcH2ugw==
X-Received: by 2002:a05:6512:2398:b0:55f:433b:e766 with SMTP id 2adb3069b0e04-591d874d51fmr56008e87.7.1760626746704;
        Thu, 16 Oct 2025 07:59:06 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908820d20bsm7161649e87.54.2025.10.16.07.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 07:59:06 -0700 (PDT)
Message-ID: <628b0080-9977-4230-85ca-8685562e3fa6@linaro.org>
Date: Thu, 16 Oct 2025 17:59:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Enable setting the rate to
 camnoc_rt_axi clock
Content-Language: ru-RU
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com>
 <9984bc23-05ef-4d46-aeb8-feb0a18e5762@kernel.org>
 <bc0caeb8-c99b-4bef-a69e-5ce433e6b890@oss.qualcomm.com>
 <c4fd6bfc-cc9a-4f37-99b3-f36466691a1e@linaro.org>
 <CAFEp6-2=GJL-gc+PSyAL4=prp_sXdZJS=Ewg5nP2kcp_Gu85Fw@mail.gmail.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <CAFEp6-2=GJL-gc+PSyAL4=prp_sXdZJS=Ewg5nP2kcp_Gu85Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/25 15:22, Loic Poulain wrote:
> On Thu, Oct 16, 2025 at 1:50 PM Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>>>>
>>>>> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
>>>>> index ee08dbbddf88..09b29ba383f1 100644
>>>>> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
>>>>> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
>>>>> @@ -914,7 +914,8 @@ static int vfe_match_clock_names(struct vfe_device *vfe,
>>>>>      return (!strcmp(clock->name, vfe_name) ||
>>>>>              !strcmp(clock->name, vfe_lite_name) ||
>>>>>              !strcmp(clock->name, "vfe_lite") ||
>>>>> -           !strcmp(clock->name, "camnoc_axi"));
>>>>> +           !strcmp(clock->name, "camnoc_axi") ||
>>>>> +           !strcmp(clock->name, "camnoc_rt_axi"));
>>>>
>>>> Just use camnoc_axi for both. Look at your bindings - why do you keep
>>>> different names for same signal?
>>>
>>> I think the correct question to ask is:
>>>
>>> Is camnoc_axi going to represent the other (NRT) clock in this
>>> setting?
>>>
>>> Konrad
>>
>> I'm - perhaps naively - assuming this clock really is required ... and
>> that both will be needed concurrently.
> 
> AFAIU, the NRT clock is not in use for the capture part, and only
> required for the offline processing engine (IPE, OPE), which will
> likely be described as a separated node.
> 

Does it mean the clock handling should be removed from QCM2290 or
X1E80100 VFEx resources? Has it been tested/verified?

-- 
Best wishes,
Vladimir

