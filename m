Return-Path: <linux-kernel+bounces-731553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D277B05626
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7EA3BDADC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320822D63E8;
	Tue, 15 Jul 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgoy+s79"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D72D5A08
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571206; cv=none; b=l/9I/RtnwMJv6ywicck/cSFRVeUJfwm+cGa1epJtoWixyPx2RGoS/2PxqIQu82hZoTcMraVHr/o2kmJlRyfJyRtTjMY7uqUE+qg1UliP8VRyFR30HNAgilUFRgTYtSRRoTN7IIUOymjir49oN50foxt7d6U6b1TMlf7VrvriAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571206; c=relaxed/simple;
	bh=WJ0yyfeuefaQ3urFYkT/IqHAzlcYqFbbdEzN9k3/XAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFJorvVR6q73uTqpnBHo/pVzhnZnylEfzqC//xID0N+U7Nap9uCYSAYiSwb26w9isQ52R9aWBER3xNt+LtFp2t0L7VZ5nAFV7+rC8I/0Pl6BPz4V/aZyDJ/upkgxKZ2NBeK7fsDNz6DCPapwhfLVBMuozFI1SHGFklcKJ11XjDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgoy+s79; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55a1eced1abso12700e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752571203; x=1753176003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HNruVe4qBBDUZL0Lbc5vbGw4m9jJzAK3Orw+77L13s=;
        b=fgoy+s79h3rlWgIIY40XSBpLTYu/D+042IdparMa7BxPt1oZjqvcuLPoeuk68FRyH8
         oEUFxiHeinWZTWMKBXv0ls50+UitReQw9t+KQyQckvFTZZxqwOmnKgEKpVNRlcU4A/hO
         cp+1DM6rFrISUhwTo3szQWTZDMKbINkiovoaUeVdF39FAK9wSfIhbCossVlIzZLRM/62
         fqFICLiObWg+7+/qr8bMZ6x/pIXDPxabk9qDJXstehF1m4NwCZADOlR+/OpYOeLYthK6
         sWdBvf7w8sHHL/JAkMReVFPYwoVI0YwiaGTC4rEd3qk1u9DYgZ9TS7hYm1H8Tky7f5t0
         XmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571203; x=1753176003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HNruVe4qBBDUZL0Lbc5vbGw4m9jJzAK3Orw+77L13s=;
        b=YeBPJ+SHSvABXSCINNPIhBjFs2HQCCRJ7QJ9+NXSW8XQvXk2qQR+TkWUQgy8vfyvV8
         WepP4onSAxpzVuFhFs1Z3XlO6gCVJp6eHzjvJNAsNPkKYLS86alskfVkWB5Q7GL9J84t
         SL3I+SOgRrvyq7z7u5YTucE6SNpQtSNg1jOWUIgqTxS16dY2reTL3zYZArdGY6mFhEZp
         VFCyiyduJLASktzjZB8L535yXP3U0vQmBZU0vOQtTTuA/pJCLg4xUhPVvf3Frqe4SiIF
         OGOSKLv2u/zreY0NmAZwX98idh4aBNOKOTCf3ONu1h1I0nJqSdL4pevYHRr4CXB5vhgS
         /nMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFqhFEq7e2eFYX3cTICCwA8az851EUDj03yhPP8Sd1rlQaFV9Ohz6OKIj46vjEtM3DKrNKnA61eSNB+J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhsz19e+Po5i+HoljkKSTXmCb0UkEOUYIjUhb7jj9CVZk5FRjO
	g2eySZD9G8NciVBMqzHf8uyzrgd4QsQpFj7eMwSgf+EoNLWrzO1Ln63u6SE0YJ82nv4=
X-Gm-Gg: ASbGncv1SZrEpJbzQbOZprE8XXe15RQOs61ErF7MIKamcJXedQR2jJ4TCMbNOIfVfZp
	tCE3pTdz6WFO3ZQ1uv1aMl0quC5+5l8sKN2x+jco74OwCCClNIxwvnE/XW6f2ilDEZUi1XKnuvO
	8sjKeGmJVWXm+nu/EeBhZOxzDO34VBg8QHeU7Hlz3woBvk4dsUCcOAiImp8JwfiPTCJA+l4zbKu
	2zsgpf2iCXvPvEubytzwZhlYt8++HJYGeOQoH/yJrPp4JDnffJ4ynT6eAiNO+C+SIuqYbnnM81y
	3YQNTQaaog3i/hjiDu0wQK0XRSoEFmfXa/7tNNaEbE2HZCGSsofLRrprguuIjc16WvxUL5Xjthm
	v7MvjxL+6u41kbkM3vMj3J5TbZtJsjbRwZOoMEOeJwwsxB1L4jxWNxiZzb41uBq07Wq3i/nm+lO
	ZcEL+kZClBJM4=
X-Google-Smtp-Source: AGHT+IEtlBg+zNyCSrOBvHI33+JpaeCaJB/UDUCJntM9+i8ejxLCPtnoDTFHXY1bC6tD2cE1QVQIRA==
X-Received: by 2002:a05:6512:3b1f:b0:553:2421:f5e5 with SMTP id 2adb3069b0e04-55a1fdd2b75mr99165e87.9.1752571202789;
        Tue, 15 Jul 2025 02:20:02 -0700 (PDT)
Received: from [192.168.1.100] (88-112-128-43.elisa-laajakaista.fi. [88.112.128.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b6f497sm2192227e87.188.2025.07.15.02.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:20:02 -0700 (PDT)
Message-ID: <94b75177-9401-4e0c-966b-5847a29cb6f7@linaro.org>
Date: Tue, 15 Jul 2025 12:20:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
Content-Language: ru-RU
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-2-74acbb5b162b@linaro.org>
 <11b573d5-ce4d-476c-b94c-216d427cd838@linaro.org>
 <08261aa4-689b-4d6b-bfd2-221c1976d254@linaro.org>
 <a7f64b31-4767-4281-b452-a2bc5351d745@mleia.com>
 <c93624bb-ee7b-45ac-8b53-b5391f11c9c9@linaro.org>
 <eac3a877-a4aa-4789-9013-ab8b6c91e0f3@linaro.org>
 <0a12879f-dc4a-47fb-87a0-ac4b8bcd4d75@linaro.org>
 <53a19b1d-5665-4937-a07c-5dd1fcde06c5@linaro.org>
 <3b760685-97db-46e3-80a3-7fad69ad31cd@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <3b760685-97db-46e3-80a3-7fad69ad31cd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/15/25 12:01, Konrad Dybcio wrote:
> On 7/15/25 8:35 AM, Vladimir Zapolskiy wrote:
>> On 7/15/25 03:13, Bryan O'Donoghue wrote:
>>> On 14/07/2025 16:30, Vladimir Zapolskiy wrote:
>>>>>
>>>>> I think that is genuinely something we should handle in camss-csid.c
>>>>> maybe with some meta-data inside of the ports/endpoints..
>>>>>
>>>>
>>>> This is a CSIPHY property, a CSIPHY hardware configuration and a wiring
>>>> of sensors to a CSIPHY. Where is the relation to CSID here? There is no.
>>>
>>> All the PHY really needs to know is the # of lanes in aggregate, which
>>> physical lanes to map to which logical lanes and the pixel clock.
>>>
>>> We should add additional support to the Kernel's D-PHY API parameters
>>> mechanism to support that physical-to-logical mapping but, that's not
>>> required for this series or for any currently know upstream user of CAMSS.
>>>
>>>> Please share at least a device tree node description, which supports
>>>> a connection of two sensors to a single CSIPHY, like it shall be done
>>>> expectedly.
>>> &camss {
>>>        port@0 {
>>>            csiphy0_lanes01_ep: endpoint0 {
>>>                data-lanes = <0 1>;
>>>                remote-endpoint = <&sensor0_ep>;
>>>            };
>>>
>>>            csiphy0_lanes23_ep: endpoint0 {
>>>                data-lanes = <2 3>;
>>>                remote-endpoint = <&sensor1_ep>;
>>>            };
>>>         };
>>> };
>>
>> Don't you understand that this is broken?.. That's no good.
>>
>> Please listen and reread the messages given to you above, your proposed
>> "solution" does not support by design a valid hardware setup of two
>> sensors connected to the same CSIPHY.
>>
>> I would propose to stop force pushing an uncorrectable dt scheme, it
>> makes no sense.
> 
> If all you're asking for is an ability to grab an of_graph reference
> from the camss (v4l2) driver, you can simply do something along the
> lines of of_graph_get_remote_port(phy->dev->of_node)
> 

It's not about the driver specifics, my comment is about a proper
hardware description in dts notation, please see the device tree node
names.

-- 
Best wishes,
Vladimir

