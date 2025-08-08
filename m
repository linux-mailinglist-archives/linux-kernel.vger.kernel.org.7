Return-Path: <linux-kernel+bounces-760162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980FEB1E73D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DBE17E9B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75D27585D;
	Fri,  8 Aug 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fN9GHOOf"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6983F275851
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652288; cv=none; b=TCgXOeaTPj8zRDijm+2XorcB99Z193hxXA/W/1/6jleD3pXIQNUibN+oN0QrTtawMihM4vwEogU2MmoIPDo1vDyKeQnNK1NITH5uOGAWSR7Tcc0OSk9Q0z8Dw5mYhgw6rkaIRiW85fWI4K0wJSFZGdVnkcRLB04q1ncDcRCRbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652288; c=relaxed/simple;
	bh=tdqmTZskz+yQCU0OtNWJ7hb3SLauZy7LX8Gd3jyLS4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEx1IL87a6r5AjmCrOPhXuO1tsC3LKjVF94NmlAQsg48/8YTUpf/eHwgSxmFKA1dMcIDRE+sOKeFWc2s9qMRlf5nKL6Z3p7Tum97eeHnRuACeBjMEHXx0h1HrvV9tgNywhsIB0WNcVqqEi+ZuIGFAvpQ5Rvqj99l/Id/70UIjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fN9GHOOf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459e1338565so18589085e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754652285; x=1755257085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDaDKFrE9tePMwqIpXfK3gAKisGxx+wlPAiFTrZ+JsA=;
        b=fN9GHOOff3ZEYCkEguHUtX8uGA0gAEZF67S3H+eextsE/KrKMpS1HFfVm/Q/Hf8dSd
         EaIz3Bxxa6hXvRNGpAjtqCgcNmT1nIwRJcZcI+Zhy0iO+tJ4HqxL7zo6W2PBxzGANZkv
         NSk6tPHvj1kBAfo5igO9cOejjMtv9LsyVBMMMdeJw5Efe1gCCdNhhBLaDBUYcyZJYmWr
         aIx7qnHovjrVuEm/BbShu2n9m5m2/y6zZdo0diZL3qyym22CfSBQHA77RpswFKDrqpF8
         xxBwLfAm47whs8aXsUmU+mhcPHTlPIieoPS/VmvVQgQy8rYAJxDupii152uNWYHfVTj6
         jKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652285; x=1755257085;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDaDKFrE9tePMwqIpXfK3gAKisGxx+wlPAiFTrZ+JsA=;
        b=H8+F+cxYGwtU7PRdSi5O0natJO+6f2HH/XoUxo7lP20usMWbPbmf1m9nPpsaJKaGoN
         W2XK3hUwLI9FlbOMwsBHMJCWjjdzrseAXU4fd79tdC7HCVZFEKWQ07L+lzVGHRik8DGy
         bQyzWv3iBD97EkrkLaQ1cVFqRqubUDlrbh5ky7nQi+A6Nfv+i9HVwMHtOmCw/QTyma7I
         s3EsYiIa4NCprNIwjLlX5sVT5kdkZPSNuUr9+0g5y3v+G00H67Bk7UCSos8keMWPGxof
         ShFZ9Ir9k+Pl6R1+iMBZs4OuqNEQNbAZgcq5rAaasO08mwtmMQIQDE1m6qeCiZhPvYzU
         q2qw==
X-Forwarded-Encrypted: i=1; AJvYcCVt99nxTmZoqojVT5Xszyw6qSKig8OjdMTflPnkMMISKrf+SWOMfGgmXUmM6S3RksTzp/UHDYnSp4IK9WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzobMdfwrbdH0ERnRiRtyiVrcCcr6vnrH3zOWgeJgQQ46f77qS6
	EbI/5mdjn8AYs33bfFgFF5Qxj8FWNVWjdGckMs3Jazv55d0XYWZaiUVMF/8LMbRB6qE=
X-Gm-Gg: ASbGncvYUM5POWMwG/2eSct992mlzAh4PrPz32i9Vt+f97HjPeIlLQac0P1xbDFE5fE
	kWspSQH80IQmjWRcx6ua0ZJ1BfFMMogYDsomcWsKHW0U4n3a/K2SdNyTtWS0TNyWy/oSA7MHMgP
	BuGSaH2K9r7T2eYHCPGUKBQ7fKVokOJy+VI9liRf7hNUqebF+xO8Mt/K9ez6MWyPaY5WpUJjtxv
	3ilEEBPiPM2n7cjNN1BrVCrrBzuniM0+cygCzhMx+INIHa8ivMZILsHOSQUNN9wcljHo/qIhhky
	Q7/6kRlaBXwGCH6Vctb50+xzusdpzNIFNJ6FZE76Y8GKG/1GenHy2huU8Kg2cW/FXk7C+WuuITr
	MDQzCKhHYoiVcsYcMOFoEQsVuWcO5RGo=
X-Google-Smtp-Source: AGHT+IGFc+AaIxGFA2SLKc1CBodgdE5FKKCWRuNF/M1Z18xEptVX+bZf7YDkhLJM8Nb3ewYalAQT8w==
X-Received: by 2002:a05:600c:4f4b:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-459f4e9df86mr24463835e9.4.1754652284753;
        Fri, 08 Aug 2025 04:24:44 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm128153435e9.6.2025.08.08.04.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 04:24:44 -0700 (PDT)
Message-ID: <efdf5d48-c105-4e1b-8dbe-14706302aa2d@tuxon.dev>
Date: Fri, 8 Aug 2025 14:24:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, catalin.marinas@arm.com,
 will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, lizhi.hou@amd.com, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250708165540.GA2148533@bhelgaas>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250708165540.GA2148533@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Bjorn,

On 08.07.2025 19:55, Bjorn Helgaas wrote:
> On Fri, Jul 04, 2025 at 07:14:07PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The first 128MB of memory is reserved on this board for secure area.
>> Update the PCIe dma-ranges property to reflect this.
> 
> Can we include a sentence or two about what the "secure area" means?

I'll update it.

Basically, it is a RAM region that is used by firmware.

Thank you for your review,
Claudiu

> I don't know how to connect this with anything in the driver.
> 
>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v3:
>> - collected tags
>>
>> Changes in v2:
>> - none, this patch is new
>>
>>  arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> index 39845faec894..1b03820a6f02 100644
>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> @@ -214,6 +214,11 @@ &sdhi2 {
>>  };
>>  #endif
>>  
>> +&pcie {
>> +	/* First 128MB is reserved for secure area. */
>> +	dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
>> +};
>> +
>>  &pinctrl {
>>  #if SW_CONFIG3 == SW_ON
>>  	eth0-phy-irq-hog {
>> -- 
>> 2.43.0
>>


