Return-Path: <linux-kernel+bounces-740665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DEBB0D773
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207A55617EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C202E2F16;
	Tue, 22 Jul 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdww0zWn"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB42BEFE3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180641; cv=none; b=VEVQSoD0kUkZMimGTrm0seRgVpaVtJeW50VwbZOuw7fTHFxsGMCBKMXdHPCzy0SxLFcdzGEI5ujuDZD/U3R5+SG05Ryg9Mj4Xsw/h98CHnz5iA2JqKvd1/Envbj573koe98ce5fDb+nS+MUf1DuuQ4SScsd/cckP0pf8SYnU1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180641; c=relaxed/simple;
	bh=EcaPmOZF17vzAybqgUPsCVqCSYrKhcslVWazMxbu63M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTpVBFS1ZzpCKEsbBJ3tFPL8/DQCbPF6SdoN1FeJBfZXc+eZ0ZtQAB8TcKZrhWms45nICsIgdAt6FjfL7TgypW4iFkT3Um5c7MxZNo8QIpsK2j8eFN4MV+xJMdwU+iNTrCbCPpv43w7++CciUnORWC5xPeXq+n9rCLE2uB/af7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vdww0zWn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b611665b96so2986864f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753180637; x=1753785437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Y4ZK31qukkhLkAHxdpW7gih6/ZCt1oA0i9NknuiOE4=;
        b=vdww0zWnoWp9QeU1u00mPbHHCE6Vq4Dszs2UlBmvmeWgey68lOYoQJnaur6eL3KcFv
         0/+0RPu9W91z6Q3ecq4lE6WyCvswGAqgyIXkGWc4N8QlvXw2+Glzldt8KvssKewDUvj2
         AyUJJ8y4pVZGU8GlvkrWyd3w2GOO5VrfBLw22K+KT08m+OevW7xqIcZSXScCbxAcX/Qc
         xTQeXTIJOPa6+PIj23bDw236w5oaHfrMg/+WG7lCIvR5v1Z3ycsXL28iai6H11IlZB43
         aLzrvNmbs8073u+Zd1Y2d2zfDnulnM8BvS54LdYeBxG0wND9tGGPf2PQYtgDTY5zxNB3
         CDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753180637; x=1753785437;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y4ZK31qukkhLkAHxdpW7gih6/ZCt1oA0i9NknuiOE4=;
        b=LR0QATj7XnKlEChGT5lsMh67oI/NaQy09sQewQuCrXzXtzFAYoq20IihAm+VxxvpLj
         LPHfu2+ljsRaASWcJFACgXvL1eqVE05E37/ZfjpQWViTTMZ8HtYyWo4LZFVRwzB8MlyE
         75ARMQWFgzBHIUsy1tNs7UBIfla5uIw1R9pcBvFXjHC2J6XIS1/5hlP+XNTaydilGchw
         Wduyu1+8yYphzioFYEF3d1BKgP2gNpShCDZk0/VZ2XbTNvmJ0vJ0wL3jS0K3mTRFQGJ2
         ci+Cusglvm7t8mDNW52l778nyoG6cB5oyR7qL9CTc8bfqOzZGK69bZ1vrglH2p5honqz
         UH8w==
X-Forwarded-Encrypted: i=1; AJvYcCWOxpnalYIT8abbjFyabsy60vZarNII5lGUYVQqdMO5FMElzlAHgBgrbr3kvqXSt3V3NuVVQ2nzxFsVvn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzx2TUtIc54IhRvTQbkIkk1SNJnUkB3f5zwJheL/hmxLFAkfbN
	v0fBv8b9w3YMlyPFXPyLcCRc8ErW72flH4Ip4UrsFqxGWH9rW12IGij8Cy+MdlkNN1Y=
X-Gm-Gg: ASbGncsC0XK8QghkBRsAZpbGG/lGm7v95sMHEg4vLvmopRFe9QWmG6iG33TPooWRBqx
	0UybwZHZiEMMBGGK5P+CHwJ4gKZA4mLndmD6bTT7HZx+MVetJXnz/EH84xNGK4Y3QIbmE46kJNE
	+Rq/+/akHWmSDR+GFN0UVLbGObhAX6Ee6H+xztueTeyYAKwVgu3RV3Hel1dlXRbUYNPeTjZMiUE
	6q0kKCdFa5lkhnLlO4Ndwkdyt5v/yJBlD3M+5vNYh5W2GcZy3FSIHTMLddaCEEoLOOH3R5oPaZ4
	yp1LuF8sASh2eBSlPpn5MLzlmwgdhMfCI17To0e7W16zQ/NFeAry/K8l4pBV3CqZwuWS238HoQk
	QstYiPU8rmgVPB0goUuYd1N0BCv3yuCOGxu21QWXZjfDdt2CwQ+tHy0ZY1RpkH2k=
X-Google-Smtp-Source: AGHT+IGTCim13XVcGSW21AueFsi3fYd4EJtmzmvQeTtBGNVJD3KZN4i5HjdFzRy4dW3lSossDfE26A==
X-Received: by 2002:a05:6000:288b:b0:3a5:8934:493a with SMTP id ffacd0b85a97d-3b60e51bb18mr20015822f8f.44.1753180637147;
        Tue, 22 Jul 2025 03:37:17 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d581sm12938939f8f.64.2025.07.22.03.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 03:37:16 -0700 (PDT)
Message-ID: <7e1073da-6773-489e-80f5-97409f013acc@linaro.org>
Date: Tue, 22 Jul 2025 11:37:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
 <94b75177-9401-4e0c-966b-5847a29cb6f7@linaro.org>
 <427548c0-b0e3-4462-a15e-bd7843f00c7f@oss.qualcomm.com>
 <3UXVZ6ANM9mDjVdMV4SXsiIx_pT3S1lp3RC_Q7mh_o7jF2dpYsni1Sl2TAWv6OCMCRTFmi9aE6BxDquGkOnwEg==@protonmail.internalid>
 <8b908a20-0bf3-447d-82ea-a5ecee1bf54c@linaro.org>
 <57501e81-7e9c-4cb1-9a37-18307d1e06ca@linaro.org>
 <33d76d7f-ab14-4e76-8ffb-eb370901a046@linaro.org>
 <4edefe21-27b6-4884-befa-ddb451bb9376@linaro.org>
 <84eea632-02d8-4b7f-a4ca-36ce7159a170@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <84eea632-02d8-4b7f-a4ca-36ce7159a170@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2025 10:59, Neil Armstrong wrote:
> On 22/07/2025 11:08, Bryan O'Donoghue wrote:
>> On 22/07/2025 09:32, Neil Armstrong wrote:
>>> The whole key point here is the combo mode, as I understood the combo 
>>> mode feature
>>> makes the PHY lanes available as 2 separate streams, like if you got 
>>> 2 "controllers"
>>> attached to the same PHY. So in fact, the PHY should have a single 
>>> node, but 2 PHY
>>> interfaces in combo mode.
>>>
>>> This makes all this controller/phy model very complex to handle and 
>>> add a lot of
>>> logic in the camss side. Moving the "csiphy" as an independent media 
>>> device that
>>> can declare up to 2 endpoints in combo mode makes things much 
>>> simpler, and allows
>>> us to attach each "csiphy" stream to any "controller" side of camss.
>>
>> I think there should be a generic extension to PHY/linux-media to 
>> support that instead of something Qualcomm specific.
> 
> Can you point out what's missing ? AFAIK it's more a matter of proper 
> representation of all
> the CAMSS components with a proper ports/endpoint graph design that 
> adding new kernel APIs.

Perhaps I'm not understanding the pushback.

Vlad's design puts the CSIPHY nodes under CAMSS and doesn't use the 
upstream PHY API, which if I've understood right is done to facilitate 
multiple sensors on the same CSIPHY.

If the kernel APIs or standard representations of CSIPHYs in the 
upstream kernel are insufficent to facilitate this model, then I think 
that change should be done separately so that all of the existing 
upstream stuff can benefit.

CAMSS should have a standard PHY interface. That's what this series 
provides.

If multiple sensors on the CSIPHY can't fit into that standard model, 
then we need a series to rectify.

I've given an example of how two sensors could be routed to one CSIPHY 
in DT. Another possibility is virtual channels.

I don't know if your sensors support VCs, have you explored that ?

If the message is "we need a custom PHY interface in CAMSS for multiple 
sensors" then I think in fact what that points to additional work that 
needs to be done in CAMSS and perhaps in the kernel linux-media and PHY 
layer to facilitate.

Like I say I'm happy to help you guys do that, ship me some hardware.

---
bod

