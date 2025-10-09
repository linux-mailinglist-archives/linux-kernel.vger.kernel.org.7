Return-Path: <linux-kernel+bounces-847072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9917BC9CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104833AB10C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775D01F63FF;
	Thu,  9 Oct 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xb5Z2aEK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98C1DE3DC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023823; cv=none; b=pPCTxc57kYazu26BYNe76qui42oaYmcGtVSyFVQGVDWgC+r1z1Fi+38HOBvOIRbBmNBwUMuq/TqPkbKRauYFyuetq9rtvL7gY+4y+GB2Fw7EpYvj2uXF4qfk7qR0czrMHpyJS3odbbrmb1EueJ0hJ1znm2+JT2fiqGKnCCKg00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023823; c=relaxed/simple;
	bh=thfHYurlbthid+DZICCyxI6F4AVTKLfU3gbgDUaAuE4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L+LcTmWqdKysw6xxfw2+jgsKWCddH9npHutrdedf1MGbCZegDvvH9cyq0xY8jaUW6Qebofv0h53filg5/TxOoW8e3mNNP1Vb0jIPnq4GP/TxPQZoqWYYqPU5gXCxg3uCOB8abgs5MX/QF5/PEIGx5aQiNSYt2FVm7bKrYJUQfN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xb5Z2aEK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so944635f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023820; x=1760628620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaR01KCIJ6ZP9VbmR0WJ2PYnA5mouv06D/TKethyhUs=;
        b=Xb5Z2aEKjlXsmdsR58qfnERrIlUFXOJN7uFfsCa102xCRmjkoMKe9/93S9zATibQcP
         KD+HMllAOQfPHb8v0iZ7i4JpqxM4XfoOpkoFBJ+KhB9+pEfIwabjGSz8SfqI+yQPPZrr
         eMjEhlZ73GH79EovoqmwiqADvgy0u46Vo0YNXmONSPoiieWv0jms5dcxIdMuPKqvWUvG
         j5jzic543or4d9zsVfoUp2R73s2MLFUxcfF5wQ/y1laQKpIhVlOCmC9gU1AeMLdq6TPn
         Fwg5hF1B60dgjJah23WguqIsupr3qq/iSRdKGgKmswLCqcPbd5aGkMY1TP5bXL5kspKh
         qyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023820; x=1760628620;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JaR01KCIJ6ZP9VbmR0WJ2PYnA5mouv06D/TKethyhUs=;
        b=JN6EPAjvc2BuZ1XNigif4hKFj8GD3UBRBkRoDUSs52ocbzruRY9xwGBguhjnPARFgP
         ZiBV9gDwaMMUAyji/ClWkysGAutzGVUQAhq8us762ithzF/+TZIljOUVdRey/w9niOI1
         wstlZP3ho8xAtwCL7fmY1th09QL9XxDuOp8jx54FhUlF9niJXjodMJnnGXIFgzNw9Txk
         rPnQBZE1ZqMs7nWO+x9Jxle4hflzk1Y8q4RbF4mOTh4Hs1iUF4MOyj5dz5QY6ai/TVLY
         NeNTLPEtEJke9iiZ81aCgmNhRY4Rr5s9ahXEU357i+89UicRtySNZd1sHp31BzfDlkzl
         7zlA==
X-Forwarded-Encrypted: i=1; AJvYcCVUVRZQhw3UjLfCOcFD/hM/K+8g353NB6K9Tb65tFnBPxihZ+Xo+zmHa3OMd9VeeLF4rGngqiCw5bFHL+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfd6by1XRkHQ01R3UBWYtQEhLKBptVJQbeXRbrYQMgvIBhKU5
	snNbPv76WxKs4w75xraavwsR3AngojdzXA9Evej3YbOsIQaZbl+ZrRIUpHRgoUSvfm4=
X-Gm-Gg: ASbGncuc7Kk45/suRGodgaZtyTywNO0hG7XVz6qwsbzLRw31z+k4IuO3da5hgmJXSYS
	GYdFN6cNUwlbG9RLv0LbMjJFdMSF5Iy03jWIX3g4fUMD5eidmAGoVHCGS2BMbZd/cNiSLctL5B9
	Z4AMNLuSNsrGnm+eq8wsK93BQrnueSuly4RGyKAp7mOsRivCR8nPWzyq8Tm8D6E4MbjPZ9Dj20o
	viYtMeW2czeJS8htunHoWWOZVejah+sEtPaKRI7GGx+Ddzron5wJazK78gwPczlwlJ/6blyIXix
	0qNWXTh2TkOR7/YT+kfhFGRSVrzvgO2XNY6BB3nBWeaWo79Q8GQ3ix3nVmdbOSpx6Rn613ve74O
	Vcpxm1IYQNMA0kfYQZegONrpsSwzIIBXUNuCMuP+aG32wcyScolrUSnE5LQUmVaoGobVsHKBoMN
	bsHzj83FIAizUfz8TDaSHf28wwn+0=
X-Google-Smtp-Source: AGHT+IHpP6w5GzvbXXFlvKAAQxHUSfL37e1hWvT3bz8kbu7/7Pa0mGOtryXuWMnczjfJlf1h6yPGeg==
X-Received: by 2002:a05:6000:40dc:b0:3ce:f0a5:d594 with SMTP id ffacd0b85a97d-42666ab297amr5168972f8f.13.1760023819556;
        Thu, 09 Oct 2025 08:30:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee? ([2a01:e0a:3d9:2080:7a0c:da2f:6591:67ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9762sm35723226f8f.38.2025.10.09.08.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 08:30:19 -0700 (PDT)
Message-ID: <4c5dc916-ea7a-4d73-b509-49f82ff36666@linaro.org>
Date: Thu, 9 Oct 2025 17:30:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC v2 2/6] ASoC: dt-bindings: qcom,sm8250: Add clocks
 properties for I2S
To: Srinivas Kandagatla <srini@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org>
 <20251008-topic-sm8x50-next-hdk-i2s-v2-2-6b7d38d4ad5e@linaro.org>
 <44606de8-3446-472f-aa6b-25ff8b76e0ec@kernel.org>
 <3620feb6-12bf-48c1-b47a-ccb486e5b5de@linaro.org>
 <c0b71974-65df-47ad-902b-45c2dbe66be0@kernel.org>
 <f27cad88-b1fd-41a3-bdb1-b07de3dea8a2@linaro.org>
 <b614913e-7ebf-4abe-9eb5-f41b81d91ad3@kernel.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <b614913e-7ebf-4abe-9eb5-f41b81d91ad3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/25 16:29, Srinivas Kandagatla wrote:
> 
> 
> On 10/9/25 3:25 PM, Neil Armstrong wrote:
>> On 10/9/25 16:06, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 10/9/25 3:03 PM, Neil Armstrong wrote:
>>>> On 10/9/25 15:36, Srinivas Kandagatla wrote:
>>>>>
>>>>>
>>>>> On 10/8/25 7:56 PM, Neil Armstrong wrote:
>>>>>> In order to describe the block and master clock of each I2S bus, add
>>>>>> the first 5 I2S busses clock entries.
>>>>>>
>>>>>> The names (primary, secondary, tertiarty, quaternary, quinary, senary)
>>>>>> uses the LPASS clock naming which were used for a long time on
>>>>>> Qualcomm
>>>>>> LPASS firmware interfaces.
>>>>>>
>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> ---
>>>>>>     .../devicetree/bindings/sound/qcom,sm8250.yaml      | 21 ++++++++++
>>>>>> +++++++++++
>>>>>>     1 file changed, 21 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>>>>> b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>>>>> index
>>>>>> 8ac91625dce5ccba5c5f31748c36296b12fac1a6..d1420d138b7ed8152aa53769c4d495e1674275e6 100644
>>>>>> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>>>>> @@ -64,6 +64,27 @@ properties:
>>>>>>         $ref: /schemas/types.yaml#/definitions/string
>>>>>>         description: User visible long sound card name
>>>>>>     +  clocks:
>>>>>> +    minItems: 2
>>>>>> +    maxItems: 12
>>>>>> +
>>>>>> +  clock-names:
>>>>>> +    minItems: 2
>>>>>> +    items:
>>>>>> +      # mclk is the I2S Master Clock, mi2s the I2S Bit Clock
>>>>>> +      - const: primary-mi2s
>>>>>> +      - const: primary-mclk
>>>>>> +      - const: secondary-mi2s
>>>>>> +      - const: secondary-mclk
>>>>>> +      - const: tertiary-mi2s
>>>>>> +      - const: tertiary-mclk
>>>>>> +      - const: quaternary-mi2s
>>>>>> +      - const: quaternary-mclk
>>>>>> +      - const: quinary-mi2s
>>>>>> +      - const: quinary-mclk
>>>>>> +      - const: senary-mi2s
>>>>>> +      - const: senary-mclk
>>>>>> +
>>>>>
>>>>> I don't this is correct way to handling bitclk and mclks for I2S, these
>>>>> are normally handled as part of snd_soc_dai_set_sysclk() transparently
>>>>> without need of any device tree description.
>>>>>
>>>>> Also doing this way is an issue as this is going to break existing
>>>>> Elite
>>>>> based platforms, and the device description should not change across
>>>>> these both audio firmwares.
>>>>
>>>> This is only for AudioReach platforms, on those platforms the
>>>> clocks are registered in DT and are not accessible by the card.
>>>>
>>> Clocks will be acessable via snd_soc_dai_set_sysclk ->
>>> q6prm_set_lpass_clock once set_sysclk support is added to q6apm-lpass
>>> i2s dai ops.
>>>
>>>
>>>> Device description is obviously different for the AudioReach platforms.
>>>
>>> Why should it be different, its same device.
>>> We have platforms that use both Elite and Audioreach.
>>
>> I'm perfectly aware of that, it's the case for sc7280/qcm6490. And I agree
>> the card bindings is the same, but it doesn't mean the DSP elements are the
>> same and uses in the same manner.
>>
>> So let's forget the bindings and forget those clocks entries, and imagine
>> I'll implement those _sys_sysclk calls like for the Elite platforms.
>> This means I'll bypass the clock framework by directly setting the PRM
>> clocks, this is clearly a layer violation.
> 
> You can claim clocks in the dsp layer (q6apm-lpass-dais) instead of
> claiming it in machine layer, it does not necessarily have to bypass the
> clk framework.

The current q6afe implementation totally bypasses the clock framework:

static int q6afe_set_lpass_clock_v2(struct q6afe_port *port,
				 struct afe_clk_set *cfg)
{
	return q6afe_port_set_param(port, cfg, AFE_PARAM_ID_CLOCK_SET,
				    AFE_MODULE_CLOCK_SET, sizeof(*cfg));
}

I have no time right now to implement all that for q6apm & q6prm in the
way you propose, so I'll probably not send a new version.

Neil

> 
> --srini
>>
>> Neil
>>
>>>
>>> --srini
>>>>
>>>> Neil
>>>>
>>>>>
>>>>> thanks,
>>>>> Srini
>>>>>
>>>>>>     patternProperties:
>>>>>>       ".*-dai-link$":
>>>>>>         description:
>>>>>>
>>>>>
>>>>
>>>
>>
> 


