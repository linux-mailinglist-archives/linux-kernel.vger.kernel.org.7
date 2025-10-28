Return-Path: <linux-kernel+bounces-873598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9BDC14391
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20251A688F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BDF30F520;
	Tue, 28 Oct 2025 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BF563+/k"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30238307AC6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648627; cv=none; b=eD8TLrm+E2LQFXOc3sN+t1r5asd9XSoHZS/7WZJ7yeK0Gac7/MpQlDWcNCqMEw5t7nxla9KICd/Ada+W7CPqeAWO6grSD1IwlEG9YHrt+170PCCzRzphVkVbA8fTUmwLTRu/1JkHN3mephuXxFvcQXXQQNJeaTyijePRmLkdAvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648627; c=relaxed/simple;
	bh=BCtbbIefRxl8ETsCXIFJF+wlsHm3vUU5KSEZnsuKlYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1afXutZs05feSnXsaB4ItR/IIDQqGBXeNxBrq2Hh5AID3T20CDnemErei8oLSXqFLRvkNkxqvsXB4H8ZQENH0+TSxJ5CZ+mm4wAc9kj91clMDbJcNT8FUf33Wxgvanlc2h/k073YY58RyOLemdpkGcSTOkCzNyMVQbY10ggS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BF563+/k; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475dae5d473so33492555e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761648623; x=1762253423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmrMQdnFbXTRUvWSj6UdlngxWpZlUvtP+bCbfxielbc=;
        b=BF563+/kLFb3HWB/fBQR9NxO9fHkMUD0suIKa66ZBSA4qe6gJ8x/ktXlB/qeA0Bu6N
         1w8sxbd+cb5Elugj0ibkHMUM+oMfODpX1YXziu/AZg1+IHMtdrUFtf7u4nSvYMYG2wzT
         /hHR7zdhUabN2YhHutwMioF58VPMknth118aiDmr+RUyyE1d63C+bfk1msPyVT7nYc8/
         xdC0G8Z9CAERV50z4eq9frfz288a/fHvAV1P57SOk+4CvqTnzV2Hs1sw/WTUsHd++7Xv
         ziZAo4b2JSEChQ+1liHRsROOCuQXoEM0QQwdK3wRkkaPY1rj5w9gXBV7z+tBj4kA/avc
         kUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648623; x=1762253423;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmrMQdnFbXTRUvWSj6UdlngxWpZlUvtP+bCbfxielbc=;
        b=XtbpHQ0AHechE410vij/H9BBvLAhiP75FeOCIKL1vBfSJ0Gz5m6sa6itjQ0zUB4lFo
         pF5502qYaVOTEbx9TtKq/Kt2WjO2AwkI9nxodUkQ2akpBgVpfkK/EfeFPODylbPzirs+
         vNI+4Paoz3JMxDQx9UETWZbpqmRibybLpBdjN5xPdPPaKq206f7sSTcQD0zZwDfJfiWg
         NDIjV+a0SXJr/9ebjv2wZwAU+2L9Y5tMwmPxg9vIY0X3dYvrS37yO3dyvM6gTtNQCIPQ
         Oz1+XKXud0kSxLSkMcyHXPF8TNQK0hq6w2rYQZnz5NbSEJjqfCn8njEZhnhw5B5tA70y
         YeQg==
X-Forwarded-Encrypted: i=1; AJvYcCV3AB58/DjZ7U+cgW+2xbtR7cUIgARnlU181Q7reGrPJhDGb6Xpc9dj+0ZCH2oICqH9XVFrAikDV7gLtgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73LYc3P0gTpXeMb5Z/CtONTfhGln0GjKG8vnsiDK0jZ6WLBcY
	+AU6rv4DYfAPFWmfCG4ZP5+Z0qbxcDs6GWP81EW0fEXtjWR/bnfTIkCl1Guyra2Q8ko=
X-Gm-Gg: ASbGnctS40fpH9agQe9X+BF3kLqKa5X0DlfO8tNOxi/z3iDn+yuRnU6Pn8ydRjHYK9K
	Y9ykjJfx/EbzhTzZoGRDj9ulOXANIQZgPmK/0SdrAACrMu2TieAxwqOguihRVcVDLmVvkc+M5rE
	dH4yXkq0h4k+IUyRnt8SZm/s2yYz0CM6ceNqIvQlk5WfageLdAZJwpOI1cvcgRKwdWqfNvhsS0Z
	UIlei926VoU+WWRRQvIZkQ1Pldhxu6ItEntdchDW9WZkCMSIGxDpHNMfF62iKv7gEUIvYeLvIFT
	ESBzEWchpt/gKtqmzaMZJl3FCP3lQ0uaAoo9p9T35Lg+woS7KqULzgrqvBsyY+rShD5/H5C7XS0
	rtWaZXh3yVsmUsGUMpn9HlllZPx5rOe1T2YrY86qz6Gwdwq+DrPsMh26NSvMr5SADFbu+EY2kl3
	a9j+OoQ+7qqQ1uqc1Z9G4O01Ot3ynf5LLSEqlZse9OiI0=
X-Google-Smtp-Source: AGHT+IEW5Xn6pgsIVIQmh1ZteaU6fBGYQzaGzmRov8RIVgUKjWNp6avGgGE1oXye0/BWbWfHNJ1oGw==
X-Received: by 2002:a05:600c:5492:b0:477:c37:2ea7 with SMTP id 5b1f17b1804b1-47717e37274mr21925335e9.21.1761648623445;
        Tue, 28 Oct 2025 03:50:23 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47793fsm191912885e9.3.2025.10.28.03.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 03:50:22 -0700 (PDT)
Message-ID: <56633bc4-5ef3-475a-9749-a6f455aad9c4@linaro.org>
Date: Tue, 28 Oct 2025 10:50:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: media: camss: Add qcom,sm6350-camss
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251024-sm6350-camss-v1-0-63d626638add@fairphone.com>
 <20251024-sm6350-camss-v1-1-63d626638add@fairphone.com>
 <20251028-defiant-visionary-rottweiler-f97cda@kuoka>
 <DDTUHFIN3IEK.3FY5IS9S73ASO@fairphone.com>
 <0bf4ab2e-9846-4f8b-ad72-e9db6fb7d08e@kernel.org>
 <936ecaf4-8b48-4c93-a666-153a13ee9e16@linaro.org>
 <b8550097-76c5-4843-9b05-0802f3a4e3e6@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <b8550097-76c5-4843-9b05-0802f3a4e3e6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2025 10:39, Krzysztof Kozlowski wrote:
> On 28/10/2025 11:24, Bryan O'Donoghue wrote:
>> On 28/10/2025 09:46, Krzysztof Kozlowski wrote:
>>>>>> +  power-domain-names:
>>>>>> +    items:
>>>>>> +      - const: ife0
>>>>>> +      - const: ife1
>>>>>> +      - const: ife2
>>>>>> +      - const: top
>>>>> Uh, not your fault, but who came with this list in previous generations?
>>>>> Instead of simple and obvious "top+ifeX" which allows growing/shrinking,
>>>>> someone put "top" at the end which means this cannot follow same order
>>>>> as X1E for example... Heh, it follows at least sm8550.
>>>> Shall we put top as first power-domain? I don't think it's an issue to
>>>> change the order.
>>> Well, it matches sm8550, so I am just grumpy complaining. It's fine.
>>
>> The provenance here is "top" was required to be added last because the
>> code depended on magic indexing in dtb to know which was the TOP GDSC.
> 
> 
> That's silly, because if it was first element would be much easier.
> 
> Best regards,
> Krzysztof

I'm sure it was an accident. A bug, we fixed it.

Anyway that's why.

---
bod

