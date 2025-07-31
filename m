Return-Path: <linux-kernel+bounces-751786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66356B16D74
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9735A7A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE51242D7A;
	Thu, 31 Jul 2025 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgXjs34V"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5421B8F6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950280; cv=none; b=mertlHB5qGbFW5mxozPjVyPMucMRVmQPfyojYOCgZuvFcYHdBym7Uufz3z9FkhyQtck9rHYhJmumKXPVoaMGlFy6viiQtW58qJDzUJSxELesJqTXFJSZBsfcyXHyu1/zDQkBXq0wY2PQWo3MhxCXFrvENZtz7wmHN1cIaoYOuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950280; c=relaxed/simple;
	bh=FOjf0BV0+IGLLxoC7Oso0aLNj9+WBkpQIo0cAC3Dh08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s86RN+hbXHLdFbUz/XgIAs9H53VqoOQrxmbkIP1yGLKnH+1SgCOFKJ+n09wH0MPJEWo0G2Vmfune0qtxu9yRRvZUeMeNzEwhR0W7o7dbFovnGSUentw6jsTDwpk54vhQ6jzwDh5E878M7UAanNa2UmKnEkX4GBgDe8KiCLZAa+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VgXjs34V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-455b00339c8so1111435e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753950277; x=1754555077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7ObA2owZIXNSWWy7ooxxBkOpHxPovglE/R/foejS2M=;
        b=VgXjs34VtYxu/0z1RtbyjGNgSO59jJkbZwDCL+NeDqAJhh5boAZV30/1otZQLOUW/t
         mOnuYyFRC4/eyQ3chiRuDbLy+mVI+mKP2EF6EGTzEWC/hG+cVvFwgiEclkMDTs+4wUaf
         TnX4ByLOgO5wyNoYe3XEvxFmdur8FdxAw0cKG6m5n/uarylvCweW5P+AE7t2mYSaE8P+
         7yGJ0+7TlAppu6P0NW+bAVzzoD63qFIEw4Vaoh4SU1b0INkRsnlwym/aFsGxUUP9zj2N
         rzRgi1FCtmrpQaVkAIvDmCSmx2tqq5Py92ERHZU8d3FzglA2gK9u0FhI8i0ndaaPUe7q
         yFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753950277; x=1754555077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7ObA2owZIXNSWWy7ooxxBkOpHxPovglE/R/foejS2M=;
        b=FIBCstZ0YCeqofovId8v8nKsfvPneOLs5nWEuAXgG9f64eTZdtMKvvNd53k4Bl8d59
         JENfdVptxo3366SyM3WihimZllZfwYAaSIsvIQZP8ANqgIPCgmbixtIitNX5BWlL6Nar
         YREZYA3hMRUMIMj0RPP3DklGRnBCvN0GCoK3ODm0NNaAwg9zxLE3DhpbxhmP+tiuyp+O
         u3sM9k0D6oTVz2gNj7REEFORgFWlmByDbBajTkRRBK5sZtYqWo+fB4F/V+doucTn88HV
         SNrkNF/vQwrjcYLqEkoXVFBQEIMznRJXSW9LDMZU6WXDiwt7s6ZgZ7Buv4g+j0VCwPpK
         Sc2g==
X-Forwarded-Encrypted: i=1; AJvYcCXwEW+wcBSRSModFNXaer2WeEUXJ2/68Aumqz6RAUaw7TfODKomtpqF4B5YFf63tCJ4hPFFJncqFhshx7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIQnkh9smtDjQz+iSiNNxQiS2qZq5iORSO01Z/vVkB2p2XDKR
	9MCWViu4aIu5xNWbACaPsOb8Z9v+O2emCunPIkRLkDaACDyIuC4rlVJ5q47010HE/j8uBfdnVw1
	PdwEv
X-Gm-Gg: ASbGncsWRcbm2RBq8sJl75jNeEgqlRyYXYvMga95bMY7rf46IDMuGp4pAyETRbUs9Br
	jSAvPUYYVcIkmDnqaUfFLJwnsZbsynGiQsdoV+KJU+PUTLqVQFvOesGKmBQnRRgrCl+t6oqNazh
	z61enjNkHht4mScV9wAtELzC+Ekvb0M03AO4DCcGm/XkGMHJB0hM0FMBJe88mjlgFDqAhWFftT2
	4QkEivGOgJ1xrzKnK3Zg/73ws3OqWlyK3SliH8+OIRgHaOGiAJ6OK1xfkgYY3uhntk8MkgebkZh
	4Tda9keSHGLV8vwZWjmhS2im9TJxGRVut903ByL5gP2IsTdoyk0EA9QmsR2xgMyyP+gHBtWYFSs
	qkWWRzP5YvpLkCRJ0DyXFl6JhjgKXrGxav0r3WJDbPe6UtJOnoQIpDSAb3BkIcg==
X-Google-Smtp-Source: AGHT+IHqMPfEUGXtW/1KVB805ClqisCQcJBlHTWCw7ppIiNvGTbRcVUtbSqLbRahp7lhWcj3NI8Ifg==
X-Received: by 2002:a05:600c:5185:b0:456:1846:6566 with SMTP id 5b1f17b1804b1-45892bee39cmr51405685e9.29.1753950276988;
        Thu, 31 Jul 2025 01:24:36 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm17174995e9.28.2025.07.31.01.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 01:24:36 -0700 (PDT)
Message-ID: <b3884959-cddb-47ac-be4b-87e9e37e5679@linaro.org>
Date: Thu, 31 Jul 2025 10:24:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] dt: bindings: fsl,vf610-pit: Add compatible for
 s32g2 and s32g3
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: tglx@linutronix.de, S32@nxp.com, linux-kernel@vger.kernel.org,
 ghennadi.procopciuc@oss.nxp.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-20-daniel.lezcano@linaro.org>
 <20250730233547.GA1887794-robh@kernel.org>
 <858e9dd6-b3a7-4ff7-aaa1-02a140b93de8@linaro.org>
 <6011eb0d-e57e-4220-a9f1-c09fc4c6799e@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6011eb0d-e57e-4220-a9f1-c09fc4c6799e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/07/2025 09:50, Krzysztof Kozlowski wrote:
> On 31/07/2025 09:41, Daniel Lezcano wrote:
>>
>> Hi Rob,
>>
>> On 31/07/2025 01:36, Rob Herring wrote:
>>> On Wed, Jul 30, 2025 at 10:27:21AM +0200, Daniel Lezcano wrote:
>>>> The Vybrid Family is a NXP (formerly Freescale) platform having a
>>>> Programmable Interrupt Timer (PIT). This timer is an IP found also on
>>>> the NXP Automotive platform S32G2 and S32G3.
>>>>
>>>> Add the compatible for those platforms to describe the timer.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>    .../devicetree/bindings/timer/fsl,vf610-pit.yaml          | 8 ++++++--
>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
>>>> index bee2c35bd0e2..2aac63a58bfd 100644
>>>> --- a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
>>>> +++ b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
>>>> @@ -15,8 +15,12 @@ description:
>>>>    
>>>>    properties:
>>>>      compatible:
>>>> -    enum:
>>>> -      - fsl,vf610-pit
>>>> +    oneOf:
>>>> +      - const: fsl,vf610-pit
>>>> +      - const: nxp,s32g2-pit
>>>
>>> These 2 can be a single enum. Otherwise,
>>
>> Do you mean this ?
>>
>>      enum:
>>        - fsl,vf610-pit
>>        - nxp,s32g2-pit
>>
> Yes.
> And also please correct the subject prefix to match subsystem, git log
> --oneline or:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Sure I'll replace it by:

dt-bindings: timer: Add the PIT for s32g2 and s32g3

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

