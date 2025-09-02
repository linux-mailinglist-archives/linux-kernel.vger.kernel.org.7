Return-Path: <linux-kernel+bounces-796802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E76B40734
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7105A7B0FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6150311970;
	Tue,  2 Sep 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HKUumRHj"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF992E040B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824057; cv=none; b=uvJZVBODxo5TyU95ak0XwVfB2Q9TW0eMqK/g95n3MhaelRis8GroeOQJPZYSChxTNrDS89hUo0fZ3qrr9Lq8dIJS+RNTs+yuVVcCogNEOVMC5wV0GmybuHF2ENejstOrJBWGmP6XhAs4inexb8zo9o5LEf78ie2Oej/SS3tORTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824057; c=relaxed/simple;
	bh=bpCiLxzPGHz1ZPNfp6XMm4A3lNYSEu26Uv2+DYraBZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBFTuVcUASQPVrEKidDc699SwrCaTvO66dewCHHMWQpeoMbELLl0TRi5zjNno/xmyHjTAi3dxr6pMBVix3CbOS1BugnWYgJVaZQDMEzzlOE6kWJrjfJZHLwL/vT/ixK80oa9vUxgvZduf7wbdgYHtjw9blCsaOAauza/okGkFxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HKUumRHj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b86157e18so17468205e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756824053; x=1757428853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPQ5lbQT+ktG5exTeK6ZYWJdIi8XeD/6BpVRa1QfAiM=;
        b=HKUumRHj7RrhlQgiX5uvG5NalF5DmuWumeyf2EGFzbcYyQVLvEQ+bffnT1IicaTErb
         zHuwmg6ryqu6VAhUO1rTplSPk+vbT+luCty4cNryIw/jKEiQwGqw2dsK37Oc3PuffxZR
         cgxX/jAYDjE2f3vcfELqtS1zSIOL3hFvXo4z4cGcBYUty5C0ltdSRNMGDp7a4+TnV/zW
         1uabKNxdPUVdMpOb0i5jBVOlsVSbs1i+aPNNk/1zIPC+5QRGLx2cKaZJQPbHa/nuzn8W
         JUspq6OJWy41dorfwXOAN/yChKs/zcYPQ4elCO6gQP+o8nhsj/Jicm6AC5ppKsC8dsXG
         RzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824053; x=1757428853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPQ5lbQT+ktG5exTeK6ZYWJdIi8XeD/6BpVRa1QfAiM=;
        b=Wu0ysolqtYl2HrxAVZwfacPiNI2lYBrgUX92/JX8X2gJfASoDWQGzIOiqgTTxdXGc1
         GuG1R3QllLpEF/5a3CgJo5p7rO4/lzyZXhZklfSHgIFflZYWXySpbmeRaHQV/IoSrFSs
         UOunsBAIKHnj7lbpOvKN+laSmFLBNUkZXcarBpwOUL3OhnzzNyxbFYLV8t8BszAute3T
         sKsUQC+JIxhj8QBzTUVZhC225RZ7a8uQLlIRx4VVREU9ZZ52BGLSrX4NHldK0bW0rxvV
         kwmgKjdsvGSbQroRVn/9TdCHdPMBZcE0F7JIAvZkMmVmVB4rJfIHQe3V4KmpI3q8h9pB
         Fnyw==
X-Forwarded-Encrypted: i=1; AJvYcCX5DOX426EMiug1iGgfxfvUf6ZZUyypwhEVytC3FH/8PhHxEbr9ag4CiQwK+o0cwyPL+S8KbeYbwHvPzJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykfzmiUgR5CQPnSQswlBbcKUaZAZJSNPIX1byD6WpzGLX0zAfZ
	xtb1B03c4vIyOY1+XP9s7/yKJB5kGOL2nC5k/skqueCcIZASgYOFEKx94nOsSm5eBE0=
X-Gm-Gg: ASbGncsglPQJXAeMfU6DPkysqTyMzL9B6yXPrlJNyrOVRczAN5jx9zv6Mak58z3JTAH
	i/H9pLMwkRJdKodQ7KrdVM9l3ZezUcwJPqMt5xxr31WafVTvWFx30VR0n0XG0JyHWD0KOOxe295
	upraE1Ht0BJtOgculRVvGehbpwR5o5WckYgZQIOgjvOmo2hPCTulpQHszlgG4jy6wimRpjard6R
	RkTq0d5eO35ZTdKndLi3Sun3i8al4XbbmZWHb2iDZydxzasixxNmRXUuHSa6km+/vWhUROOwcJg
	6Cfonb0YATI5pyBVpXESN3mnPsrO9U8UP3RUBOFsYUj5PgRtjZu6qGYF7WZjLYpf1w71bcH9SF+
	YuBnGeRnRrqBc7Ppa1LIeYPA59hGVmyi1G1oe8+JWWAJKjJyQvfpIlOZEn8PHD8rPE87kQwp0kS
	P1N9I=
X-Google-Smtp-Source: AGHT+IHRl49o6/YtbNy7bdqpWcnR/xIvJV5u5yS14FAAALeyuwfZ5PjGe2f+Fvd/cTOOThpsm4Zpng==
X-Received: by 2002:a05:600c:1396:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-45b9615d7fbmr32758825e9.17.1756824052669;
        Tue, 02 Sep 2025 07:40:52 -0700 (PDT)
Received: from [192.168.27.65] (82-65-114-165.subs.proxad.net. [82.65.114.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e380b77sm205384965e9.11.2025.09.02.07.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 07:40:52 -0700 (PDT)
Message-ID: <0bc124c7-55af-4a25-b02d-3bd9aabf0266@baylibre.com>
Date: Tue, 2 Sep 2025 16:40:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] soc: ti: ti_sci_inta_msi: Enable module
 compilation support
To: Nishanth Menon <nm@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, vigneshr@ti.com,
 Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo <kristo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250812-timsi-v2-0-90c8500f3f18@baylibre.com>
 <20250812-timsi-v2-2-90c8500f3f18@baylibre.com>
 <20250813152610.akcdxrzhev6e2kfa@unturned>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20250813152610.akcdxrzhev6e2kfa@unturned>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I will resend weries because something look not ok i don't find serie in 
lore or patchwork.

Guillaume

Le 13/08/2025 à 17:26, Nishanth Menon a écrit :
> On 22:36-20250812, Guillaume La Roque wrote:
>> Add module support to the TI SCI INTA MSI driver:
>> - Change Kconfig from bool to tristate to allow module compilation
>> - Add linux/module.h include for module functionality
>> - Add MODULE_LICENSE, MODULE_DESCRIPTION, and MODULE_AUTHOR macros
>>
>> This allows the driver to be compiled as a loadable kernel module
>> named ti_sci_inta_msi.
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>   drivers/soc/ti/Kconfig           | 5 ++++-
>>   drivers/soc/ti/ti_sci_inta_msi.c | 5 +++++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
>> index 1a93001c9e36..0a9eb5ac264b 100644
>> --- a/drivers/soc/ti/Kconfig
>> +++ b/drivers/soc/ti/Kconfig
>> @@ -85,7 +85,10 @@ config TI_PRUSS
>>   endif # SOC_TI
>>   
>>   config TI_SCI_INTA_MSI_DOMAIN
>> -	bool
>> +	tristate "TI SCI INTA MSI Domain driver"
>>   	select GENERIC_MSI_IRQ
>>   	help
>>   	  Driver to enable Interrupt Aggregator specific MSI Domain.
>> +
>> +	  Say Y here to compile it into the kernel or M to compile it as a
>> +	  module. The module will be called ti_sci_inta_msi.
>> diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
>> index 193266f5e3f9..d92cab319d57 100644
>> --- a/drivers/soc/ti/ti_sci_inta_msi.c
>> +++ b/drivers/soc/ti/ti_sci_inta_msi.c
>> @@ -8,6 +8,7 @@
>>   
>>   #include <linux/irq.h>
>>   #include <linux/irqdomain.h>
>> +#include <linux/module.h>
>>   #include <linux/msi.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>> @@ -115,3 +116,7 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Texas Instruments K3 Interrupt Aggregator MSI bus");
>> +MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");
>>
>> -- 
>> 2.34.1
>>
> If Thomas doesn't mind picking the full series,
>
> Acked-by: Nishanth Menon <nm@ti.com>
>
> This is probably one of the last hold outs for us to move SoC support
> into kernel modules.
>


