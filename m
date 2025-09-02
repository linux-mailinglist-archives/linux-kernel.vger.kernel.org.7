Return-Path: <linux-kernel+bounces-795593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADE0B3F4F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED27C3A6D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4722E090C;
	Tue,  2 Sep 2025 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6tieQTu"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEE2765D2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793101; cv=none; b=EGem4vKL893VGm8X8b9R3AVT+GIKjsM4TadzntW9qMHzje+JYzeMNQVk8YBGCWPAVmv/zXVYA0nAJJWriofYvDbAm6qcvHlA/Rl/q2k7afsjQ8J+UhFuwx11/cTTxhViAuzv7TYPBoxop2FnvyUzEjMQdX/WGintPMFEW2XHvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793101; c=relaxed/simple;
	bh=VpE8wK0YIOoaEuss6FDJDDOgvvJkk4hgdGuL0nfvsf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l96IeV8HWoWKaUZc1CdiZdm4hWoRw7zcG9sapBddu4vzm41VsMxo/xxH2aC1nGKPt4snuCo2Liq9mIZGxDmGC/t8IQ7YKYMHDS8KrqAenkgokP8mdOaUTuQKSzG2qJfMYjDVeJmJyqssdFOb1w0B4YUFbJdrbBfL3m8pgAe90Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T6tieQTu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3cd44b9496fso649488f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756793098; x=1757397898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2b3JuSsnshEbB2H24ad5BMEkyTFrlBTid3O0T6ibdMc=;
        b=T6tieQTuFnWKSfMspzWBL9GPwnoxbmRxAHdIhK1N4mfnaN3XWTrtI4t4KWT5Jsog63
         Jrh3Q44aocdJFJTOLo4O/9GgXYD0jEWIHkTk3c/HzLEUh94oyYjknw8RTVfTbivWJiXW
         1DTL0rmfvQDdkaKAiOWq6HfpTzra/r9zgXTO311jdLzB3o0zdokyo39JYTMs8x/vwRjS
         vptdVPswfEnRwUArHLhyLeE/k4B5V6nk6X4J/mBEfzBQipeUh/pjMmGbmesD8JidDLRn
         6Y3PeHneq0m8hpISpyWY4Kpg25IvmOvzMUfvo+vbk16I5D0z6Z/wseK83In5/sJ31XRg
         vReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756793098; x=1757397898;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2b3JuSsnshEbB2H24ad5BMEkyTFrlBTid3O0T6ibdMc=;
        b=Pck5/j2o1eZqKJmRRoNPSj8E3D6N6YrjITtrizzwXcdq0is/Hoe3OAgOvTDnjosTnU
         MJVPYiWDHjJnuTb6EUOVJ/pNo7PGeIh/mBRIP4ppwB08GceND/PTS9/vNOk2uB/7QNzN
         rY4JAPE0NdWBF0brlY9+ybkBC3TJJGqMdSDIZW+dkP5yD4tFSmJieKRqWksEQsBX4gLH
         mr0bgPisJi1ffNoG+WLyi5FoysfQTiQsYD/4uDm2NrJgfyRQMzpb7+J1yUGcy6a2xNpa
         ND3F1pO9aP6MmOxk+M/bHtTmQ5qhLjCTesztKc7iTCi71AARb+O8KcyLhaV6yOS+PMpn
         5biQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE0bMcdH3qa5GO50LqtdDLFA4zRrh9njkX9uaN4pk8vfSDA8HVIntIyDKV1Hq779ufdKBqliJZ/GSXwGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGRYIdt/aYfcuMQwz0AkoB4LmbCxDTann4OWCVMuD2rMoOXgI9
	qlEH5Y5JloooxyOKbU8VfHPjLRmN1twgzczuwFNjjiIs/exEoacuIWeDHw9iNswBwVE=
X-Gm-Gg: ASbGncuI6KVKlVhhVnqx43CNt51j5MZS/DbJtCnmsvYdHaZohX5OpOE1+PAXABb5N23
	kfcgEi+/QL2K/3zUs43bGF179kgdiJxsCXpFY4T+hzkQEJTV1FwkwSwU54wIqJnfaaYSlVZfF4G
	sJK6koGzwZX882OEqengJJ4Ei32vQIAii8d6eYYPt+tJ5+E3G+IhaunFg9ul7zj9KrMhoTxZuRv
	Qk7XChC45UtiMydr+cykechbZ+b6t++DTuoFodmdAokqlGTukJQGSrHqfR3+j8gKpj2wikj5jDn
	ezQtV9ub5adzQtcj00jqFWYr09ZxIY7RZmcC1OEphQFxnZHEWPaiTSEidVYfL4jb3uv7xHGsDFw
	jMm8ksMW3DWypc1N0cTE3ZBU3EXryTAZWBMHlIJan0NY=
X-Google-Smtp-Source: AGHT+IGzQvNWUwBdb294u3aSfKMN/4Lhuayvos0l/gCcNz8KPqZ1Si6aA9RC3fHNpONP2IXnMVzHIA==
X-Received: by 2002:a05:6000:2307:b0:3c9:774f:6484 with SMTP id ffacd0b85a97d-3d0fa72c0d8mr4993112f8f.5.1756793097550;
        Mon, 01 Sep 2025 23:04:57 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d1007c0dc8sm16442802f8f.53.2025.09.01.23.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 23:04:56 -0700 (PDT)
Message-ID: <24999a53-ea5a-4823-a84f-2ca0ca184bb4@linaro.org>
Date: Tue, 2 Sep 2025 08:04:54 +0200
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <qy6c2gundpbz5ixqpt2hefzfb56wcrzcaclqwg2opof4zc7lep@dpc3nv6usurk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2025 06:03, Dmitry Baryshkov wrote:
> On Mon, Sep 01, 2025 at 05:45:49AM +0200, Krzysztof Kozlowski wrote:
>> On Fri, Aug 29, 2025 at 01:48:15AM +0300, Dmitry Baryshkov wrote:
>>> The SM6350 doesn't have MST support, as such it is not compatible with
>>> the SM8350 platform. Add new entry for SM6350 with fallback to SC7180
>>> (which belongs to the same generation and also doesn't have MST
>>> support).
>>>
>>> Fixes: 39086151593a ("dt-bindings: display: msm: dp-controller: document SM6350 compatible")
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>>  .../devicetree/bindings/display/msm/dp-controller.yaml     | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> index aed3bafa67e3c24d2a876acd29660378b367603a..0f814aa6f51406fdbdd7386027f88dfbacb24392 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> @@ -31,13 +31,25 @@ properties:
>>>            - qcom,sm8650-dp
>>>        - items:
>>>            - enum:
>>> -              - qcom,sar2130p-dp
>>>                - qcom,sm6350-dp
>>> +          - const: qcom,sc7180-dp
>>> +
>>> +      # deprecated entry for compatibility with old DT
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,sm6350-dp
>>> +          - const: qcom,sm8350-dp
>>> +        deprecated: true
>>
>> If it is only about bindings then there is little benefit in keeping
>> this, just drop this case.  However you cannot drop it from DTS, so this
>> is a bit pointless.
> 
> Our plan is:
> - land updated DT bindings, describing MST clocks on MST-enabled
>   platforms,
> - land updated DTS, adding MST clocks where applicable,

This part breaks all out-of-tree users of DTS.

> - land driver changes, keeping legacy support for non-MST DTs on
>   MST-enabled SoCs
> 
>>
>> Lack of MST support is not informative enough to claim it is not
>> compatible with 8350. For example if it was working fine via fallback,
>> then that statement is simply not correct.
>>
>> And it HAD to work fine, because there is nothing binding to
>> qcom,sm6350-dp.
> 
> It is working fine since currently we don't have MST support on the
> driver side (nor do we describe MST clocks in DT). It's true that the
> driver will have to handle non-MST DT for SM8350. However I definitely
> don't want to describe both cases in the bindings. SM6350 is not going
> to be compatible with the MST-enabled SM8350 schema.

The question is rather: is SM6350 going to be compatible (working) with
MST-enabled drivers.

Best regards,
Krzysztof

