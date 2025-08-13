Return-Path: <linux-kernel+bounces-767487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AEDB25510
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767221C27001
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F402F0C49;
	Wed, 13 Aug 2025 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEBG+XJo"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237F12BF3F4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119717; cv=none; b=a2Iiy+MtPoOztwrbLhYdGFTCE3O9630UvxN/LMEZt1MjWy8EzO1cMtN3hkPvVx+4b2R1wBIplOFSntqxR7eASMlN569xUeQv9zDAigWnPNZ5j4YTRDys2iJKOh7BtOs2vsQbpVyifj446cG8ox64+A+GUitSRr6r4ceNfflP4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119717; c=relaxed/simple;
	bh=f0mOh5zW36wEzOojcDIcMa7UEWLFOqZuK/fsupPNmY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWmu8ulyvgl8S9mYT9KWcvd1XymX3w7sqY+ji50T4HHTbgRhXfe3vO52HO/Kw+tEM1XAHlUm2DT96wGyM8TEn7q/MPLc7Os066yZCM+5q/fF3RILk2g1tMXoK70yNScaSXd3lLtDzu0gQ7wQ3rYEQtjzOgKUaDn5fgn4DEp/QHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iEBG+XJo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso205323f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755119713; x=1755724513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ewofpmx2u2AWLuh72EpS+Kxy8uzpjMF+7SbnHvsYlc4=;
        b=iEBG+XJoLFsnrn6dm5Fsa2J/ukEKZdfxok99/Qz+ZSBT/ocPZbg0cyOtkO8wFB1KxC
         V3oC2YQBwEQUo2hGLlfssLsSgzJJV2AI0N1RT/sXR4WfEFRmX/hA8VvttnVRe032Y+N2
         zzgGyQ5h0GwZWuNI70flYcztveCpUA8hhA9ql+CCz5tFCVMfipttR+S+z7bfKHcpQguk
         D9rK2uXZtl461kj3WFMQ7hKMksw5q8UJ7Ya9vVG3BquGU1Cx5mYhGhJ9Iyc7ZV0Zjj21
         UpUlgmAxmXwh1WFYYQlopN+fXiKFIkHwVvdOP0ahGMk6YPSfSG3bxu66eiNgMC4EiTHo
         G53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119713; x=1755724513;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ewofpmx2u2AWLuh72EpS+Kxy8uzpjMF+7SbnHvsYlc4=;
        b=dAciwrIwTjatWuzjW/ZwO2KVAmFg6O4C+NVZ15UWoAWSlQOQ6tPsUWU69S7uPm/duc
         2GmCLjhfy99ipI0qGiHEoMdehZ5P4Y5KaQzipQpHgzm7HwYJR0PtOhjD7iCGGXW1WuS2
         A2JOvaTu66swbZDkufbFR8nahDlwZfPckwAW/dAqOEfLSSVKpfcKpJiRBDdhvlThxy6u
         9FUKJc6l4u1BQVRH+Er0eEV1UlqBIiridAetcoAeNj+sIFSLAuZbdBXygPTWxReZ6CDT
         V3BF7nz5fLDqC+1KaCv91Whk2DtcFYmqZZqtcjqyLuSBqsSORNr2G1s9WAYUeH7p+4GR
         KEnA==
X-Forwarded-Encrypted: i=1; AJvYcCXnNNzoGvccT4EXGc0tVoaYhUQZw3soMrPdkBAi7IxfDNIPM4uTTh+YgFy9brSTi1k3bPflFeU/vSjsLwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvXSf0ttc/VRhs43jDYdYQ5TW+wq65FsFgVU/n2/rRzt8GQz7
	Q54S8cGi8zS+vLPoLrxakHgJnAdKr00huxhxycJFPwDxo5pxhTpBcFzuc43iP2m1ds0=
X-Gm-Gg: ASbGncvQGSgXw9wF170u8eif5zgLrFXWNdWUEoW0f3EvEH0QYheJGyBhV92HkGlk38e
	MegCfSgmtg37Xt+aIBLwaOJlABQlK4H8Gb2XkcebrEH8DHci0PWamI/4Gd6DoGDdRwlLFXebyPx
	DJVlgolRTJVt2spNIyD5l4gz31UcqZT0/AWV25tulGEi6ANfwjnpsk4xM525PWBw88Vgc1C2Gd7
	+Eygq5lOUo+K3zJT/OwORc+GMydQr4GS+oBXXMcGjB9S0n3yccGopHeL6Qfskjv+plvhw+0cqTD
	1Rez8+WZbuuI8E0u90+jqFILWzVEWLJ4UX8fz4A8Ii61Ycd0ieAjTC7fcG2g0YgecWdNW3/vUcT
	TLUVYm2UrO2YhimzqnZdwLqDpIRxYdi+KjAxu6IK5lYz42HXVypcdvQ2n7OGrL4p+
X-Google-Smtp-Source: AGHT+IESt7Dqns9DwMc5t6p93qJ/wntgnWbJwzl+NSSOoNpJ0QKJzEMjsB+Jf37ThCfpJRFyEsk/pw==
X-Received: by 2002:a05:6000:4283:b0:3b9:8224:d3cf with SMTP id ffacd0b85a97d-3b9fc2f813bmr578094f8f.54.1755119712975;
        Wed, 13 Aug 2025 14:15:12 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b91b05b28fsm2527911f8f.21.2025.08.13.14.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:15:12 -0700 (PDT)
Message-ID: <93e35282-52a3-4c3e-8065-b2a6c363c974@linaro.org>
Date: Wed, 13 Aug 2025 22:15:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] media: dt-bindings: qcom,sm8550-iris: Add SM8750
 video codec
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-sm8750-iris-v2-0-6d78407f8078@linaro.org>
 <20250804-sm8750-iris-v2-1-6d78407f8078@linaro.org>
 <683024c7-3740-cb9a-6924-33816edd63f3@quicinc.com>
 <8d8dcaef-eb96-4e7b-9a0a-8b3836cb284c@kernel.org>
 <e33a22ba-f82a-412a-b1fd-d1cd50f6b21d@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <e33a22ba-f82a-412a-b1fd-d1cd50f6b21d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2025 09:04, Krzysztof Kozlowski wrote:
> On 12/08/2025 10:00, Krzysztof Kozlowski wrote:
>> On 12/08/2025 09:54, Dikshita Agarwal wrote:
>>>
>>>
>>> On 8/4/2025 7:07 PM, Krzysztof Kozlowski wrote:
>>>> Add binding for Qualcom SM8750 Iris video codec, which comes with
>>>> significantly different powering up sequence than previous SM8650, thus
>>>> different clocks and resets.  For consistency keep existing clock and
>>>> clock-names naming, so the list shares common part.
>>>>
>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>   .../bindings/media/qcom,sm8750-iris.yaml           | 186 +++++++++++++++++++++
>>>>   1 file changed, 186 insertions(+)
>>>>
>>>
>>> Query:
>>> Can the additional reset and clocks be accommodated in existing 8550-iris
>>
>> No, different hardware. Although it is hardware from your domain and
>> your company, so I would assume you know the answer.
> I guess I misread - I thought you want to re-use existing properties or
> something like that, but you just want to create one huge binding?
> 
> No. Don't grow these unmaintainable patterns. We have been changing this
> for some time already :/
> 
> Best regards,
> Krzysztof

@Dikshita can you revert here are you happy with a new binding or 
requesting in-line changes in Iris - my reading here is a binding is 
justified.

@Krzysztof 
https://lore.kernel.org/linux-arm-msm/fb8f154b-3da4-4bee-82e1-3a1597a35c46@kernel.org/

Are you sending a v3 here ?

I can also just add the OPP when applying this patch.

---
bod


