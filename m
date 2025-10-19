Return-Path: <linux-kernel+bounces-859714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DBFBEE651
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B88F4E2593
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA82EAB81;
	Sun, 19 Oct 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+ON6Dyk"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628D29D29B
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760882342; cv=none; b=PWsTf3BuEwIj0ZrsXiGu2LSOrAo+84AMuKCOj+CIPxW5yyFtk855yE43dSj11ndf4aj+/E91OAIGu3s7UQjYD3ixBOSCjC3td36Gkop0RNb9rkRnl7DsKBXJcXMYwWfWSi3yAu9lUZmyQEg2PvoxTzasItWxRpIQAluQI6jXWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760882342; c=relaxed/simple;
	bh=hRkplG1ra9s4vBIWDyFAgQ3Zlr+bwaWbOINHQ5iTB2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLxYm9qHkAcNk56KFcEnhndHa2Pnpwr2F5Bk/G3ozqomzs1wwfHbWknQEo1a8rdfw7+XqwGtVQdIoc6hZJpdKkKbEXLuYhxC7lQIYvtGS2L1umDTUmaI7cZ1Mw/UbRpcOMCVmPOpxkdaR85LxpiUPJdPtYQVuPmUP26c15p8N+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+ON6Dyk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-279e2554c8fso32819885ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760882339; x=1761487139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uIvRt0vzEtUfOdf1MrHqv5pQ80dvz1yAdmfgYjIUz1s=;
        b=f+ON6DykLdVDTVIG8s0mkIE7AleRp3w0tj6QJvexYX/p7eCDmR7PTuN1uVMSn4xT9B
         Smb4EdROcd0zwE7kytA17/4airMvtOgF+WCb2TVKdzwC4NRMWS5GKGmV5+vcvAGC3M81
         hvd2GD+doDlOlLW+hGzwB/e619Yi6QNCiUkfzuKSEoA9sx4gcGUQK90O8Esyg6JsPI5m
         1Y7ylMFwsQibgWVznlyrTOsQ8+qL/xakbSikABsboGzW23jcUMI1soq9gp//eXvHtdEl
         04Zqkx40pmuWeMF4RWwrjizo5OfQSFXzbAPp9/haF2YrCsbExxKM4z8NNDr5A0IbfRgO
         ItIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760882339; x=1761487139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIvRt0vzEtUfOdf1MrHqv5pQ80dvz1yAdmfgYjIUz1s=;
        b=bidM3rl7INQZj66fwb/BajA+/prvl5xNSpXFR+K5sZPXM/HC4WrOkMUiNRHUrWWsNh
         bFwdXx+2cC0AjH8icQgUXGXeSYhEWJ5iD0EjdaeBm+D2LEam5hgGsJIgbPAgTOAGbRi7
         ud16K0yAC5VwrwawxwjdRAXcjXlIFQdXppS5aTzOS5oK1zSXnfOjnbZ0Wpfox3Qtm7kk
         0ilh/Ve+c2dXmzXMBehWeuNrF6CiHGq7vESNeijnZBpY8H0PBZm9Ut2dMtNOwiDbq9pu
         VlMr8r2aQzSYr8LzQtm6wc35ocKyb1HoPB4uZrUzOxCyRJPCL8YOstElUcBtow3B9tYj
         guhA==
X-Forwarded-Encrypted: i=1; AJvYcCXMxl7khBSs3RVNEEF41NOx41r2Uyh6ysUIMDqOp1O7D04XwG5+TFlYVm0W8BpQ0cn/zB9gwx/jrYHwXzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPe68NwbSpfZYAHFs2JoEV47zH0b6aIIND61SjT7gmnj+DDpGk
	4NYYZ8DrZjWPCUpIzT4/zRJzqDl9lCrqMPXtGXWgY982kZqo9q8JXbmb
X-Gm-Gg: ASbGncvXcw2OsafPdcQBCGj4jLAyFv7zvTK3gHBKepocdOAKiO2HeJKd0Vu+gH4Fq7Z
	3gPOWnjWf80AupUGXc9dZytLw7VBywDKq2EuJVylULTFf8oY324dZjD6hnL9GlqbWQ/6S3BT1xL
	SBUwMPAbjWUmDnxF1dPTQQFxXq9w/iyBqLplGxCvGGSJvg80bmvRuvngik6ilQnl0gQNJBXL2fV
	McIrpGUB2WC903FZMJPpAqAu5jHWPMKkcffRoeVBTFMZ/tKou2DKYSU+A+CUSIgil86Vdbb3Em0
	eYkaDT4yjtZ+OY7tlLON8kH8PrCZtW5JUrGvfzUi16bDs3b66jJGO5VaVYEScWmR6WCEeXv6nvE
	1XP1mv7pE7HhLPMduTXx084bLSicWyBfRXAnigSNVV7JN2LL7lnVjD/RiVVEP0SoQhV8b+sgetO
	HCQ17QjuCtBvGKG+KRq+PNWjftRA==
X-Google-Smtp-Source: AGHT+IGfMFiuCP3pNp6JLr8ZsJfilLCsq2Iy14veN19sT8WT/30N57bEv0uqUBgvns7qDZN+JiYhLQ==
X-Received: by 2002:a17:903:32ca:b0:290:b92d:907 with SMTP id d9443c01a7336-290cb376121mr146870135ad.53.1760882338934;
        Sun, 19 Oct 2025 06:58:58 -0700 (PDT)
Received: from [192.168.1.4] ([223.181.116.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5995sm54198275ad.70.2025.10.19.06.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 06:58:58 -0700 (PDT)
Message-ID: <bffddadc-4235-4ccf-a0ed-7a0de68e2fbe@gmail.com>
Date: Sun, 19 Oct 2025 19:28:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mmc: ti,da830-mmc: convert to DT schema
To: Conor Dooley <conor@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251011-davinci-mmc-v2-1-355da3e25123@gmail.com>
 <20251012-nickname-morale-e1e21796f1f1@spud>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20251012-nickname-morale-e1e21796f1f1@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12-10-2025 19:05, Conor Dooley wrote:
> On Sat, Oct 11, 2025 at 08:52:07AM +0000, Charan Pedumuru wrote:
>> Convert TI Highspeed MMC host controller binding to YAML format. Define
>> 'clocks' and 'interrupts' properties to resolve errors identified by
>> 'dt_check' and 'dtb_check'.
>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>> ---
>> Changes in v2:
>> - Modified the commit message.
>> - Removed 'interrupts' from required properties following the old binding.
>> - Changed the maintainer for the binding to "Conor Dooley".
> 
> Bro, what? Where did that come from? I know nothing about this device at
> all. Find someone from TI to put there.


I checked for the compatible driver and found the author but no email address, so can I add Ulf Hansson <ulf.hansson@linaro.org> to the maintainers then?

> 
> Conor.
> 
> 
>> - Link to v1: https://lore.kernel.org/r/20250523-davinci-mmc-v1-1-ceebd8352d9c@gmail.com
>> ---
>>  .../devicetree/bindings/mmc/davinci_mmc.txt        | 32 ------------
>>  .../devicetree/bindings/mmc/ti,da830-mmc.yaml      | 61 ++++++++++++++++++++++
>>  2 files changed, 61 insertions(+), 32 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
>> deleted file mode 100644
>> index 516fb0143d4c21d1c8e44a8846d55ea5458d7b74..0000000000000000000000000000000000000000
>> --- a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
>> +++ /dev/null
>> @@ -1,32 +0,0 @@
>> -* TI Highspeed MMC host controller for DaVinci
>> -
>> -The Highspeed MMC Host Controller on TI DaVinci family
>> -provides an interface for MMC, SD and SDIO types of memory cards.
>> -
>> -This file documents the properties used by the davinci_mmc driver.
>> -
>> -Required properties:
>> -- compatible:
>> - Should be "ti,da830-mmc": for da830, da850, dm365
>> - Should be "ti,dm355-mmc": for dm355, dm644x
>> -
>> -Optional properties:
>> -- bus-width: Number of data lines, can be <1>, <4>, or <8>, default <1>
>> -- max-frequency: Maximum operating clock frequency, default 25MHz.
>> -- dmas: List of DMA specifiers with the controller specific format
>> -	as described in the generic DMA client binding. A tx and rx
>> -	specifier is required.
>> -- dma-names: RX and TX  DMA request names. These strings correspond
>> -	1:1 with the DMA specifiers listed in dmas.
>> -
>> -Example:
>> -mmc0: mmc@1c40000 {
>> -	compatible = "ti,da830-mmc",
>> -	reg = <0x40000 0x1000>;
>> -	interrupts = <16>;
>> -	bus-width = <4>;
>> -	max-frequency = <50000000>;
>> -	dmas = <&edma 16
>> -		&edma 17>;
>> -	dma-names = "rx", "tx";
>> -};
>> diff --git a/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..1a97c3e447fd10f14bfe0af9e22f9479304f0f26
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
>> @@ -0,0 +1,61 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/ti,da830-mmc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI Highspeed MMC host controller for DaVinci
>> +
>> +description:
>> +  The Highspeed MMC Host Controller on TI DaVinci family
>> +  provides an interface for MMC, SD and SDIO types of memory cards.
>> +
>> +allOf:
>> +  - $ref: mmc-controller.yaml
>> +
>> +maintainers:
>> +  - Conor Dooley <conor+dt@kernel.org>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,da830-mmc
>> +      - ti,dm355-mmc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 2
>> +
>> +  dmas:
>> +    maxItems: 2
>> +
>> +  dma-names:
>> +    items:
>> +      - const: rx
>> +      - const: tx
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    mmc@1c40000 {
>> +        compatible = "ti,da830-mmc";
>> +        reg = <0x40000 0x1000>;
>> +        interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <17 IRQ_TYPE_LEVEL_HIGH>;
>> +        bus-width = <4>;
>> +        max-frequency = <50000000>;
>> +        dmas = <&edma 16>, <&edma 17>;
>> +        dma-names = "rx", "tx";
>> +    };
>> +...
>>
>> ---
>> base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
>> change-id: 20250523-davinci-mmc-c704440c3dd0
>>
>> Best regards,
>> -- 
>> Charan Pedumuru <charan.pedumuru@gmail.com>
>>

-- 
Best Regards,
Charan.


