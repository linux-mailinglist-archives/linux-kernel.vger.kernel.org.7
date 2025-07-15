Return-Path: <linux-kernel+bounces-731501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577EB05550
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE87A1639CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15052D1916;
	Tue, 15 Jul 2025 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ow2PVbW3"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72566273D82
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569336; cv=none; b=Etw2Oh0Tw+G2J5C/Eh6kvmi6FV7fbyIT37ov627yDuQoMLR19XfrtzqMwXoL0ShO/KaIMohWcL5Aat01pGnIlTirIWm+GUC7H2EnvEL077egSzkDoL0nX+EakiJ9CnaBId6TvIj6sUjq0gNnomAjPrRD8eu2kkOCRatMtHu5tWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569336; c=relaxed/simple;
	bh=pD1Le8OV0RXrqAj6LsQRy5Z5NKQWRjpP+G6eQrk5178=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlHiEPT9B9oLYNi7d7WhrC7T8Q9ziaHj6dLiG/wR5S6Nobqp+ywaf5zuH0laG7kDjLztJpoFZF96tWQcMWEoZpwOlqjgrbxAQalJUIcCe4ok3us+UMS6Rjmf1qIs5QHR4OKtgw5HFG6C94q93qYvY8Xt3smC7TytEGbwibd+VmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ow2PVbW3; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso4984412f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752569333; x=1753174133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9mBnIKvAWdT630/iy9ORQBp2rYWTT3yVkBYpDCTfjY=;
        b=ow2PVbW3HTD+dAyI1T/07+N87D3UIC55x1rIVD/CDmW+Y5sjkV0dpW+VnMk3jfnvsK
         HJ7+suBML8Hfhk5oL/w0J+IGmf+lifIFfsgZjmXovJIF4ALZhReNOkQEVube+gECuc+f
         uDYdp7KwMlWSfWQDRGDBR117ZMFUQMMx40BLw0IKS21FnQCiFEdNb6eIdBrgclofGAV+
         sikL9Pa2Ghs2i6VVg+NEOa6fcuR4/gwuw0CH7kJ5kgLV9EFcfqGjdNAYDvv/JP89eXnu
         VeKifpUdzvmIJe1kwxGApER2Re41if8X1ya1rDQxibaSx+6S3pHJ6kabYzb/jDxNPCFe
         9Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752569333; x=1753174133;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9mBnIKvAWdT630/iy9ORQBp2rYWTT3yVkBYpDCTfjY=;
        b=fM3IOeGH8l+H1Hgsip8ef62d1yCrkR/dPIQr370GRCQGWwfy4HsWtcMg5SD44EHM47
         kX2/fE3nzP1zmo94mohxVWnd9BIWVrrBkareT3OUbXsdEIGDq6wrJsjcldJl0GlUIeOy
         C75fiK3LYmbi/8WSh+9tjRL516T2cRy47OmIFGxxhA7weVIG+Rnr9aF60tHhkXTgwNac
         wOou+QdW2oOB/ULMXJ489wAEJOukfAkupsNITHvG8qIk6kBPZ5FK8EtxRn1oF4+J6xKd
         8jArSMEtbQED7y/mZ+CHiKsxc214+dhYMX3w8ZFSfb3sTSNe36g76Gcx1yKweX0awrFu
         IuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVVdrEMYfFOE6DPdnptiSCYLUezN5LBMKxVvS3qT1MFid/KIGQ1DkMpBrHiw3msTK72NntBYf0ROqY32M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4NvJlwTHnjzW5Iqw26q6FxVVT23IdkEw0SC/GtrF1QIo8Q9pj
	siRSygaqxgGZ7kTou5LGh/+f5/zg5m6CjDz7Rse+IQXiEp0LGnkXAh03YsoSVsU8Hhg=
X-Gm-Gg: ASbGncvXzvGtd1Yhld6vlFrDIS3V7eWoj4NMzGrV5bkwh7l8mrCIUcb6J7+TBM2baB3
	ddqVpQqdm4w+w0Kk+l+tOE2cg858f1blV62DeGpd5BPJogaMwfwopJc7G9UQjftVzDKXlx5U3Id
	2Hq5Ed0i4G7SzgCD+Dnrf5A3knAikESXO8lmB1Z9jU43Iq9XDoVG1jkXZpNZoeNdKl/tbanYHK9
	2ubRk2VMxaa9hRVR9EGtnflG7dpTNC6tMlAew519yfz7B9iuLloxEWKRaLn98hbg5jDZhr+U477
	IUQEDdwgc+4jCVEIlALIC2FRIw3RLXQuJLMxhRRtCEUUibeT3b64KWL8Y+zyNLgyoj5tcn3wn5z
	Mz/9OEKPel5Hh2tmq1GYvyc/laQmaFMhODmtqlBRQyEmyoX5sHyNKYLD3B/bcB7A=
X-Google-Smtp-Source: AGHT+IGJMK52kdHoKat08gh9ZxE9vJbWot+So4R3frmu9VhxvGSm01AjcQ47N5lRHMsqjgkWlHkYvg==
X-Received: by 2002:a05:6000:1449:b0:3a5:2fae:1348 with SMTP id ffacd0b85a97d-3b60a1bacb9mr1597786f8f.51.1752569332760;
        Tue, 15 Jul 2025 01:48:52 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e8b1sm14424155f8f.82.2025.07.15.01.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 01:48:52 -0700 (PDT)
Message-ID: <ae0a309f-7e52-4d3c-8f26-989f22da5b07@linaro.org>
Date: Tue, 15 Jul 2025 09:48:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/15] Add dt-bindings and dtsi changes for CAMSS on
 x1e80100 silicon
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
 <9361e954-e2c9-41c6-be4c-12b0e4f367f5@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <9361e954-e2c9-41c6-be4c-12b0e4f367f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/07/2025 07:53, Vladimir Zapolskiy wrote:
>>    Finally I believe we should contine to have endpoints go from the 
>> sensor
>>    to CAMSS not the PHY as CAMSS' CSI decoder is the consumer of the data
>>    not the PHY.
>>
> 
> 1. This is an incorrect assumption, unfortunately it was not discussed
> previously for whatever reason, good news now it gets a discussion under
> drivers/phy changeset.

Perhaps you can explain why ?

Taking the example of other setups similar to CAMSS I believe as laid 
out above we should have

- Dedicated CSIPHY nodes
- Use the upstream PHY API

I believe individual CSIPHY nodes and endpoints from sensor to CSID are 
more consistent with established upstream schema.

> 2. The whole new changes for legacy/new CSIPHY support is not present
> in v1-v6 of this changeset, it just appears out of nowhere in the v7,
> and since it is broken it should be removed from v8 expectedly.
Broken how though ?

> It's a pity to realize that instead of providing any review comments
> for the CSIPHY support series sent to you one month ago a lot of time
> is wastefully burnt on a broken by design change development.

I've been working on this on-and-off since the end of April:
Link: 
https://lore.kernel.org/linux-media/c5cf0155-f839-4db9-b865-d39b56bb1e0a@linaro.org

The length of time isn't a good argument to apply a patch but, of course 
its annoying.

The rationale here is:

- Follow existing examples and best practices [1][2][3]
- Minimize code bombs being generally conservative
   in the amount of churn going in per release cycle
- Help people get changes merged - which can conflict with the
   previous statement

Which from my reading of the state of the art means:

- Dedicated CSIPHY nodes
- Endpoints from sensor to CSI decoder
- And picking up on point #2 above minimizing the churn

[1] Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
[2] Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
[3] 
https://lore.kernel.org/linux-media/20240220-rk3568-vicap-v9-12-ace1e5cc4a82@collabora.com/

---
bod

