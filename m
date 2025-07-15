Return-Path: <linux-kernel+bounces-731664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FF4B057EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DA01AA2D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72DE2D63EC;
	Tue, 15 Jul 2025 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhTskiJl"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A382D3A94
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575692; cv=none; b=cvEjYK9oH1JVBuXcIq+xlP4B6VEBYvRRs5nBqPhgXow3oCOMVNsVwkHPSsqIg/+aX//SdyK0HIS7y5Q6BOt3lwNmOvB2lBvhDoWqHUWEvMhSr047HV7AGxrh9KYrvyjOyIqHy7V6nAF7JFHoRjNC1bhyv6IehDVyL88DFRNzCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575692; c=relaxed/simple;
	bh=8I7baJCloE+/y1LGSgYUPcdZD+zveHqtvwIO9TDsLbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADSFqMLDHo6FObv+StJmkQ4GX2eXthnWTmez2nw7Tn175K8FB16Yw3Ew+wE3zIyjFCBFhCW8nCgtjRGDNZgAyPrhrRtpUYpVvuxqxXv6maXqTFEOVzkx8L6hGeGFanHTILNttC39TW4NxcIKGWIB8MQJ1gaImYAx0AgadMMXkCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZhTskiJl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4eb4acf29so297616f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752575689; x=1753180489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CNxV7xxoPlGm2F6RiOrJwV09iY72vMxacZyTqOkrjiI=;
        b=ZhTskiJlUr25FwNH/dqf5FxvLPpv/Q+ku08QZ/PBsqaceV+MLUtjHL0fPKm/TSZkH8
         Sbo06ip9ZL4IV4LNRstXot0WsqLuqNGbbFS0mDQ7JM/oIrh2fKqeW0odn4vvZuacV7Kr
         YZuC7QZA8p1K4Iebozw8x18oh3jdklkzbR+YsIwPIWnPBs143dJ4Qte8ipf0NxX0bR1C
         phFAPOflaHSlbGaOTGLOk2UhyuWlmJQ3k3oBl5oQ4IAkHOap2ySxP01a3HQrngA2Eq+6
         xqhUvRPFUe6ApuvLY9+vFOMxa7nGcY1cEONCjNa0Rr4Ee3pwAs70HngvssG8X5QNMNQn
         P1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752575689; x=1753180489;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNxV7xxoPlGm2F6RiOrJwV09iY72vMxacZyTqOkrjiI=;
        b=IBAy890Fqf02jb9DkPAwpjiQ1clpn0zOyvlT0xbIk0e088Fr8JTwF+s8L8YsYRq/87
         M+rAHTJcWSwJSYIX+OwkmbVWc4Kakx06/j0tT5RWIiOBxagpKPIlc6donWpzDTKSVgYo
         4KmWDZ4jedWrK4P/M90vpVasA3b6cEkTncY3bSatzLu43LszKsAAonseAvN3a9jOv1Sl
         CjNg70YbV6pXBgF/Cd5ClN2Q2Lb3MHfpDbt4JDPS9Hw5sNJjSzPusZxjePNZzGcnh4uM
         u9PiQTuACTPAfOmSQuo5muAsuvbbtuX2yYe/dH5dqK7hP2YUI8MVP/J1YHfHxjQkziKZ
         xmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlzCcnXfckpK6gsum+9enPRoaRUgqqb+P+GWSner+YsPUMVSfO91rVhSo/EO9XB2mBtrAmxWAhxea/JbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2kP7vVBm7dCzedKre1kKNqRe/DG98GFgm+rgOMGBf5ICpDyo
	a6l2fPeXohYox5ecSgT/UwuGsDlALTxALKUL4Cj3406UfrSaXk9B7NJx28YH8jwDjLs=
X-Gm-Gg: ASbGnctlMYZAP3kQDQiSDoVq7kBJkwrH5CSX7xxMidtThZM3iF5IhHQktiDuuY6Uub8
	J4M8CUF9vDqt3GREOURmI7pUr/DIQSVWDunM8MmDy+ZlOMuKBuOGy/YKnfMzFxzuyp7gHrK70hq
	XACqPqTHy2zmFY7bIewnfBfrBzqvTY2l8xfny3mLa9jrXQ/gvGCwuCWeA05LnIrNHXVabuaVnnv
	wm2Do3DkDkGkWfT2KIPtiqjEPc0RpvLlTlAL+glUEpVjBQPRr+bHj2scZSj25XX7U+tRv25EcTB
	sb6BrFq/YL2Rwz/hczXYrfd2MqdYN5ll8ZCQMgWzc+p4t3bfTxYkPLbRzIhDkHLPaTMBYgEfovh
	+JhfX6eaj7QQGlQylkprzSSTWEPd5zEKBaYh3VF0SUg==
X-Google-Smtp-Source: AGHT+IETuuQZNk1ztk9gfzObPzAgZOr4Of8uwioTh5GwswxYSupG3DZe37xS0aszyNTJiNJwZGnV7g==
X-Received: by 2002:a05:600c:19c8:b0:451:dee4:cd07 with SMTP id 5b1f17b1804b1-4562908ddd2mr4817995e9.0.1752575689025;
        Tue, 15 Jul 2025 03:34:49 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd43912dsm159810235e9.2.2025.07.15.03.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:34:48 -0700 (PDT)
Message-ID: <ec0f64c3-bd08-4944-817e-f5f67c317b94@linaro.org>
Date: Tue, 15 Jul 2025 12:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
 <20250714-b4-sm8750-iris-dts-v1-1-93629b246d2e@linaro.org>
 <5dd36649-821c-450e-bdcc-871735d10059@linaro.org>
 <15b8b9e0-a211-4102-9b68-994c8ab50a7a@linaro.org>
 <b5a68138-4eca-4bdd-8f72-d80236b02c0a@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <b5a68138-4eca-4bdd-8f72-d80236b02c0a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2025 12:09, Konrad Dybcio wrote:
> On 7/15/25 12:07 PM, Krzysztof Kozlowski wrote:
>> On 15/07/2025 11:32, Krzysztof Kozlowski wrote:
>>> On 14/07/2025 15:55, Krzysztof Kozlowski wrote:
>>>> +
>>>> +		videocc: clock-controller@aaf0000 {
>>>> +			compatible = "qcom,sm8750-videocc";
>>>> +			reg = <0x0 0x0aaf0000 0x0 0x10000>;
>>>> +			clocks = <&bi_tcxo_div2>,
>>>> +				 <&gcc GCC_VIDEO_AHB_CLK>;
>>>> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
>>>
>>> This is incomplete, need second power domain and I did not check against
>>> qcom,sm8750-videocc schema before sending. I will send a v2 a bit later
>>> (maybe some reviews pop up).
>>
>> Heh, no. The DTS here is correct. The videocc bindings are not correct
>> (and that's not my patch).
> 
> Well, you want two power domains here in either case..
Are you sure? My point was one is correct and downstream confirms that
in their bindings (which is a poor argument, I know). Which one would be
the second? MM? We don't have such...

Best regards,
Krzysztof

