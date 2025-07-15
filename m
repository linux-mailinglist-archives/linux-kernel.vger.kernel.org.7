Return-Path: <linux-kernel+bounces-731257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A8BB051DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBD13B0A73
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA0226B2A6;
	Tue, 15 Jul 2025 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hiUAmNQJ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E760B672
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561320; cv=none; b=T8xJc0bmhItQnXqAyqGCd3UUrqomeiUlY9Li4E/wsymk9hJshqbZGs32jI0Tb1Hyz+iLEt8po8d9sOFy5WMlZV/lynQ2FF+3pJaBylh6pCorZjOKEKFoFsrwiRLtab8Qt6gXusozAQbhLNQpPP1GfttOakef0z+OW0vm1L2dVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561320; c=relaxed/simple;
	bh=p3LPkjq+uZRwh2andFI5/6qsRT2nuhoh6ljdJGtYBr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kK7jOQ5kvox4nlp5+MzPtpcXyKo/ZhFvmYHuwH02/CRHrQMKoXo7sCDNBeMkiPwuOKM2jB+u/YY+L3hhzRxj9t0sBFhpw1OpK6at4GDBmqLC+exhF/eMEKQcad35HklulDIl6+/zu8AacJFcaQlZDssf59/vs0R6iEBDdMrckyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hiUAmNQJ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32c9ebe7190so6971471fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752561317; x=1753166117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWk+3HwoE658WoVjEcyuNKZKmpUhfuUyOmAf2RcohLk=;
        b=hiUAmNQJCN0jsnmgo54T2V+NhPaaXi8OmgkDeQ7a4XDPVeOz3Ub6H7Y5yFk5R9on1n
         bMjrGigb9PBQFesc26UZZkh3tYWIAW1Zi9/NfKNr2icpwFRnCP1E6voKVwCzW4HeLzfD
         +abHHoTyZbXz81G1WIRxktNTArxCJJQLmI3SVRS5zHMICk8rJT4xxjRvo//fTaD3A2QO
         IbDaH2/w9J13owz6pKWGg7Zreg6OZlkFwk2itPfNxkGh7F6+E0rbJINDU+wc7edY5Tj5
         lS8YI5gaDoE7QEJPcpKt4fguwwtrI3m2jIogC0IQmE5+Ph//4wdlftQLsRmdNBZoyn1x
         kpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752561317; x=1753166117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWk+3HwoE658WoVjEcyuNKZKmpUhfuUyOmAf2RcohLk=;
        b=Jgd9N0fZpIzX1o/SGUgX7KXy3BG3zaPNLY77Fa96vn0UfELd1LNM3HUB89QhcIiE6t
         xvjMv+xqXONhOxqqrMXHv0fvNfW6E1IuDnezuNPzmcOorAzmyjkyisfODQv+3m3ybL3O
         8ulr0/NVhToc0By2n/dKHECVE0eScf9JhjIb0oIv5gpK1hHRwIdtnuFwE9gleEMbI6R4
         bpVdI+cfwXg4bG1VCGdM8msanmdEIlJGKNrX4v4S11fM3Svef9CfAgd0aTHKtfxeqalk
         gbrkAULq21Xc7/c7yX78XMfbn7Fhl4Ziy/13UPet7LxBhC5dj7+Q0124g3xMOCkWYni2
         fNMA==
X-Forwarded-Encrypted: i=1; AJvYcCVXQA/WnZMQSqnimyG8ZAr/e526RvBGCbasKQcx9IY5sSu0wmQXaJFogXYlartTPAtLhFvb7YtzbVoYHIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEc2A0a5IlW+iA+GYT4kqhfWVpsMk7Yko3gJjG7X62QdsM+PX
	KXd/VYCF95UI6ZPYPBsckCduzWKwWqalb6A8a50o2gB5fuOeF6CfKstWFuHp9AhTF0Y=
X-Gm-Gg: ASbGncvCe1qQxWVUOUcJeV2AkVkztj0G9FrQUeUOOeSjm0Ms2Pvohdo1DhF7AJStBvg
	n61ekOJs0hWX4r0+6PgiEm1TFMjLPNKflBbAjiRc1BLrf8atZsfrN6ljXQd91fr/WAlNkm2h/1D
	HC8yo7v9bkv3oKXcTjIHQk7oyN7vjrKZx5UY5NmkHB0EL1mfJKAhqg+SOe2dyUOFjvT5vOc02lb
	wsc1b4KZIIAKNc2Pwz+DYn0I8Hi/FWDQD8K3+9traLCF7NPEaA4VEfITpGg9Bzrph7afDj3NHA2
	P6zks0O7rrfJYVd4YbayM3EYMxp9x8S+8bpdKdGtjbqUx+NV/oeK69GcFV/dIri7xXSUxBhs/BL
	absSZVLd5p4eGWz6LDJBmzyXDnzt+Z2VIcJ97EgeyaF38ToOWrljAgnHMn8rPmsjO0dplBaeKm5
	e5
X-Google-Smtp-Source: AGHT+IG21/AaIAze5CnrFzbotIk5+WCyNnr4M3ziM12QE2WUONELVSCj8ppEhywifIeaLqF5Jft+XA==
X-Received: by 2002:a05:6512:3b24:b0:558:f60d:d4a1 with SMTP id 2adb3069b0e04-55a1fd758c0mr46377e87.5.1752561316877;
        Mon, 14 Jul 2025 23:35:16 -0700 (PDT)
Received: from [192.168.1.100] (88-112-128-43.elisa-laajakaista.fi. [88.112.128.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b736d5sm2167082e87.213.2025.07.14.23.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 23:35:16 -0700 (PDT)
Message-ID: <53a19b1d-5665-4937-a07c-5dd1fcde06c5@linaro.org>
Date: Tue, 15 Jul 2025 09:35:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
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
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <0a12879f-dc4a-47fb-87a0-ac4b8bcd4d75@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 03:13, Bryan O'Donoghue wrote:
> On 14/07/2025 16:30, Vladimir Zapolskiy wrote:
>>>
>>> I think that is genuinely something we should handle in camss-csid.c
>>> maybe with some meta-data inside of the ports/endpoints..
>>>
>>
>> This is a CSIPHY property, a CSIPHY hardware configuration and a wiring
>> of sensors to a CSIPHY. Where is the relation to CSID here? There is no.
> 
> All the PHY really needs to know is the # of lanes in aggregate, which
> physical lanes to map to which logical lanes and the pixel clock.
> 
> We should add additional support to the Kernel's D-PHY API parameters
> mechanism to support that physical-to-logical mapping but, that's not
> required for this series or for any currently know upstream user of CAMSS.
> 
>> Please share at least a device tree node description, which supports
>> a connection of two sensors to a single CSIPHY, like it shall be done
>> expectedly.
> &camss {
>       port@0 {
>           csiphy0_lanes01_ep: endpoint0 {
>               data-lanes = <0 1>;
>               remote-endpoint = <&sensor0_ep>;
>           };
> 
>           csiphy0_lanes23_ep: endpoint0 {
>               data-lanes = <2 3>;
>               remote-endpoint = <&sensor1_ep>;
>           };
>        };
> };

Don't you understand that this is broken?.. That's no good.

Please listen and reread the messages given to you above, your proposed
"solution" does not support by design a valid hardware setup of two
sensors connected to the same CSIPHY.

I would propose to stop force pushing an uncorrectable dt scheme, it
makes no sense.

-- 
Best wishes,
Vladimir

