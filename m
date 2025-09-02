Return-Path: <linux-kernel+bounces-796382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A26B3FFD7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99857B617B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B153074B3;
	Tue,  2 Sep 2025 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AI7bS1mL"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EC307489
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814948; cv=none; b=geX0OIdUeLg0TUJzK4kcrISUgUGBsf8hszWka5NWRJNEnBrgHVgTNMPdu5P3FVy2/hy2F0v5tYvXd0xB1ExTCd6+6Q6pMZtq0m15/t+z5egiIvXovtoavECaVVmXWDeuS2XSRYGJAuvYaKgCjTk7InfXVgx+ekiZmLjDYhwlMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814948; c=relaxed/simple;
	bh=Ij1igEqKsRhS+Z6uovlOkZFN0QQkKhfrphu9YL6ybHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AR+n0XA2SYXm/E3Sr3ZbRSi9RXpv0s92QZ9jT7C8UMWq2sueq4WpfRn7ZBqjsni6pt/w5vo4FohPG1gcN2hERjE/l/Wd6/T8Y60nbaATAo/WnC0QpKL2ztFRoTJ8vE9J91yC7/0qmWb9hFpGZv6kk5+juf7eOPN+nJ0/hI5NXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AI7bS1mL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b017e4330c9so16977266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756814945; x=1757419745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1/HPI6NFGoV16FBD+omQL69pnrsn5PdoSWunfVTM3zE=;
        b=AI7bS1mLv7lF4veODDO5Q+PVc7Cn+Y90JBx1DM/uN4eOV8L8RgIb1nyeBlsIaNKJ4K
         Ue4e9U3VfdVZxOet2BZLYS+wNo90GHL1Fs4yilMj7CTM7It6mXwrjMOKz9qfxUlTRczq
         wB9q09jNZwQDc6+7n/znNNKcllqFo9doclGxlVsL4atfg4Y5iFx31zEQUKc/2GUKgDnq
         6htKhicDBIHQL9EY+3m2ahgOkG7sfS3ItUEOg26duSB2eonKyBTkQXF6KWSmCb8hXbI3
         /fap/wWz9E9puIpFcQxuuL1yvb+ORVuFsneDmF3oStvo3WehHNL+BWs/IA2UutmnR/Ll
         UmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814945; x=1757419745;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/HPI6NFGoV16FBD+omQL69pnrsn5PdoSWunfVTM3zE=;
        b=vfYCH0RPYhmWR4fnIyYeziyr7OBO42jaGa9AQlIg7CR4iPuW6oCtfFC3ztm6WsTONs
         TuvBsGU45S0svemQwxKrvKdfWZY1jfyWReDgfABZ60mxviWoHZMiZdCKl0iabcGgNTKi
         uCyr9xO46fH54EDCeHQC6MlVyUXFQvulFTN6RtiVluAlJ7tsZgTdXHeUj0VE5/2iTQY5
         T7OTJgQF6LQ79gT6LHJimL4O4ZMqej4zZKobnUSA60n4Dt6oyzOjSucit4VYgBM08+ZX
         P6JBhiGor4gNErpQQa6lP+ZG8p/k2ccpCy4305c+KVSg88a9SyRcMvX7GCJ+hmtX+lmm
         PCZw==
X-Forwarded-Encrypted: i=1; AJvYcCXjrWpVwqek9s8DKgNdV+E1ObWM5DVuPfX/tqyHDQfNR+QPtwK8grMnxKtjxhP5WdBJZYUfCSGBr3viAnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZbCR1hGstKUofyLZTjXrOKnD2PJj+DghPIsrQb65liL5xVzn
	UEx5WDogVOU6Q8HmfMDzmuKal6A3QCcS0Oz0N2LEcG0Bh2B6tOjoSXD3iDtiUPfC7mA=
X-Gm-Gg: ASbGnctno7jfCW4XxCD3yGHaV/9hbXnSf6nlhrQ9m5eWdvfKmxVr9lYAZpY63UM1M2j
	vIiA33ovCMVP0bILrsvRVSRzmFPG1P6aGkCELNZSMRu7G0C0nSX4f7911tPiopf/+ce6p0ad4Wt
	dGAUg4QwMcnOPyjaeIQrZ1xFxv2jjbGYQ/zwxU0dH0k/uBtpE7onQIQA7Skg+xP204XBCKVJIa3
	Lj5q8yHAW6US5iUfJy2KPF4iOoAYPxjQgXEVsTteYXziRF9g055Z5XkKsX/smmxxmjeKGIs9zxx
	Z4uWOsWz2UlwQ5DZ9k5txNhuRkHWJ9S85o9hbKEY7MQZgYZPU5MRKJygSspQ8y2VpVnnt2bSmT6
	sDoDyVhJrHKfxIKsSlBCkAI1cQlDZofdAVVe/+mT0CtY=
X-Google-Smtp-Source: AGHT+IE5iykgRl5Fdf/l0FPdyq9PirAB29rWNIujMfMrRP+NStLniASxEozwLpyAKtofELQa/w5UNA==
X-Received: by 2002:a17:907:25c3:b0:afe:b131:1820 with SMTP id a640c23a62f3a-aff0f01e9fcmr675915066b.6.1756814944908;
        Tue, 02 Sep 2025 05:09:04 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0421939da1sm554565766b.27.2025.09.02.05.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:09:04 -0700 (PDT)
Message-ID: <c69ced3d-d1f1-46a8-9930-463306b1ba41@linaro.org>
Date: Tue, 2 Sep 2025 14:09:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/9] dt-bindings: display/msm: dp-controller: fix
 fallback for SM6350
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
 <20250829-dp_mst_bindings-v7-2-2b268a43917b@oss.qualcomm.com>
 <20250901-arboreal-gay-wolf-bcaaec@kuoka>
 <qy6c2gundpbz5ixqpt2hefzfb56wcrzcaclqwg2opof4zc7lep@dpc3nv6usurk>
 <24999a53-ea5a-4823-a84f-2ca0ca184bb4@linaro.org>
 <ysj4ndb4twcvmlxb3marh2vktxxsup5l6ioljdgzlod46uimh2@pkgta6r3ydqx>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmgXUEoF
 CRaWdJoACgkQG5NDfTtBYpudig/+Inb3Kjx1B7w2IpPKmpCT20QQQstx14Wi+rh2FcnV6+/9
 tyHtYwdirraBGGerrNY1c14MX0Tsmzqu9NyZ43heQB2uJuQb35rmI4dn1G+ZH0BD7cwR+M9m
 lSV9YlF7z3Ycz2zHjxL1QXBVvwJRyE0sCIoe+0O9AW9Xj8L/dmvmRfDdtRhYVGyU7fze+lsH
 1pXaq9fdef8QsAETCg5q0zxD+VS+OoZFx4ZtFqvzmhCs0eFvM7gNqiyczeVGUciVlO3+1ZUn
 eqQnxTXnqfJHptZTtK05uXGBwxjTHJrlSKnDslhZNkzv4JfTQhmERyx8BPHDkzpuPjfZ5Jp3
 INcYsxgttyeDS4prv+XWlT7DUjIzcKih0tFDoW5/k6OZeFPba5PATHO78rcWFcduN8xB23B4
 WFQAt5jpsP7/ngKQR9drMXfQGcEmqBq+aoVHobwOfEJTErdku05zjFmm1VnD55CzFJvG7Ll9
 OsRfZD/1MKbl0k39NiRuf8IYFOxVCKrMSgnqED1eacLgj3AWnmfPlyB3Xka0FimVu5Q7r1H/
 9CCfHiOjjPsTAjE+Woh+/8Q0IyHzr+2sCe4g9w2tlsMQJhixykXC1KvzqMdUYKuE00CT+wdK
 nXj0hlNnThRfcA9VPYzKlx3W6GLlyB6umd6WBGGKyiOmOcPqUK3GIvnLzfTXR5DOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92Vcmzn/jaEBcq
 yT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbThLsSN1AuyP8wF
 KChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH5lSCjhP4VXiG
 q5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpFc1D/9NV/zIWB
 G1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzePt/SvC0RhQXNj
 XKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60RtThnhKc2kLI
 zd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7qVT41xdJ6KqQM
 NGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZv+PKIVf+zFKu
 h0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1qwom6QbU06ltb
 vJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHpcwzYbmi/Et7T
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <ysj4ndb4twcvmlxb3marh2vktxxsup5l6ioljdgzlod46uimh2@pkgta6r3ydqx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2025 12:01, Dmitry Baryshkov wrote:
> On Tue, Sep 02, 2025 at 08:04:54AM +0200, Krzysztof Kozlowski wrote:
>> On 02/09/2025 06:03, Dmitry Baryshkov wrote:
>>> On Mon, Sep 01, 2025 at 05:45:49AM +0200, Krzysztof Kozlowski wrote:
>>>> On Fri, Aug 29, 2025 at 01:48:15AM +0300, Dmitry Baryshkov wrote:
>>>>> The SM6350 doesn't have MST support, as such it is not compatible with
>>>>> the SM8350 platform. Add new entry for SM6350 with fallback to SC7180
>>>>> (which belongs to the same generation and also doesn't have MST
>>>>> support).
>>>>>
>>>>> Fixes: 39086151593a ("dt-bindings: display: msm: dp-controller: document SM6350 compatible")
>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>> ---
>>>>>  .../devicetree/bindings/display/msm/dp-controller.yaml     | 14 +++++++++++++-
>>>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>>> index aed3bafa67e3c24d2a876acd29660378b367603a..0f814aa6f51406fdbdd7386027f88dfbacb24392 100644
>>>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>>> @@ -31,13 +31,25 @@ properties:
>>>>>            - qcom,sm8650-dp
>>>>>        - items:
>>>>>            - enum:
>>>>> -              - qcom,sar2130p-dp
>>>>>                - qcom,sm6350-dp
>>>>> +          - const: qcom,sc7180-dp
>>>>> +
>>>>> +      # deprecated entry for compatibility with old DT
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - qcom,sm6350-dp
>>>>> +          - const: qcom,sm8350-dp
>>>>> +        deprecated: true
>>>>
>>>> If it is only about bindings then there is little benefit in keeping
>>>> this, just drop this case.  However you cannot drop it from DTS, so this
>>>> is a bit pointless.
>>>
>>> Our plan is:
>>> - land updated DT bindings, describing MST clocks on MST-enabled
>>>   platforms,
>>> - land updated DTS, adding MST clocks where applicable,
>>
>> This part breaks all out-of-tree users of DTS.
> 
> User of which one? SM6350 or all DTS?

SM6350.

> 
> It extends the ABI, so no, it shouldn't. We add regions and clocks,

No, it does not extend the ABI. You are changing the fallback, so you
are changing the ABI.


> existing users can use the previously defined feature set.
> 
> Anyway, is it about adding more explicit note to the cover letter and/or
> commit message or would you have any other proposal on how to handle the
> issue?

Please be explicit if Linux was working with the old fallback or not. In
the DTS change be explicit about impact, e.g. that sc7180 fallback is
there since forever.

> 
>>
>>> - land driver changes, keeping legacy support for non-MST DTs on
>>>   MST-enabled SoCs
>>>
>>>>
>>>> Lack of MST support is not informative enough to claim it is not
>>>> compatible with 8350. For example if it was working fine via fallback,
>>>> then that statement is simply not correct.
>>>>
>>>> And it HAD to work fine, because there is nothing binding to
>>>> qcom,sm6350-dp.
>>>
>>> It is working fine since currently we don't have MST support on the
>>> driver side (nor do we describe MST clocks in DT). It's true that the
>>> driver will have to handle non-MST DT for SM8350. However I definitely
>>> don't want to describe both cases in the bindings. SM6350 is not going
>>> to be compatible with the MST-enabled SM8350 schema.
>>
>> The question is rather: is SM6350 going to be compatible (working) with
>> MST-enabled drivers.
> 
> If somebody implements e.g. U-Boot DP MST support after we land DP MST
> bindings, I would not guarantee that. SM8350 will already have second
> stream clock.


Having second stream clock does not mean device stops working with Linux
kernel. I can easily imagine both cases after adding MST to the drivers,
the SM6350 stops working or keeps working...

Best regards,
Krzysztof

