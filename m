Return-Path: <linux-kernel+bounces-767499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFBAB2553A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EEA11C845AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8022EFD96;
	Wed, 13 Aug 2025 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="g/vCaV9G"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CD2E9752
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120090; cv=none; b=Pxzd6Mw0JnBS5iLRBTQnW4yOOX8ASWLIUKJQLzf21r/W2Z/5A/UN1bLhnzxrweVK1Ep+EHoo3vsHJ4iV7rN0uY2PDEJfUqtDBh4AzbPOoo5h2W2J4hbpbvJnUfrPEknVUyPcnq35n6qoN6fUCff1Y09nhErhIGsnyXhOS/KVWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120090; c=relaxed/simple;
	bh=YRF7PXYqA5mGk0XIeuHC4a/zpxBzNwCOY5dVKL1K3Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4hMs/dy5fF9YJWJ6URsLemwgUFoXJ304QPXnvFolJ3FqhXTN6bJsawtH1AV11T9JDtpWCImk4gmqI6zpgIz+HiusZZxf3eHW077uCEgVauECdmSKU0Hfr59iUF9u14J6omb5Waare1cX7h040N6Ex788JVD4LBh4cAsn4SX+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=g/vCaV9G; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e5700448fbso2588325ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755120088; x=1755724888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQFA3sAGjQq+4OU7ujcZ9yGUOwCjhbmi0pcUP6tFJ2k=;
        b=g/vCaV9GMoDU2rLwKj0txDggPrHxTKeqRcPwoXupIYVgR4Ns39Z/ygmvR4YeNgqmS4
         fMywMqptBnQw5v0XG9HwYzr3I9k3hKIANDqa/UPF/pPXbzC/m03vx9IrFoE+0BjVfVLm
         VMAk6vnWAzRpRQ261PwIaMhRI19oCtrZ3zp7CdJOXyP75pAPQBSyHk34h8POvV6hw8XK
         bHA1+ToHI7le3lun5WzzLjizc4ykjRWQRhIjNK5Zyl4HUik+kVJc8XvI8/SoJ4aq/nLJ
         823rnk1TKqVKyFAa5FCgVnPwnY2/vMzdhG8Kd+u57FzLncD9QyPGFOMCxeGea8lm37Je
         cIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755120088; x=1755724888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQFA3sAGjQq+4OU7ujcZ9yGUOwCjhbmi0pcUP6tFJ2k=;
        b=Lr/Ii94SWnRBlEhKh1NuQ5sYJA+FGe492yuIIx7YwPgIKlKauauS6VdqQo0UlvZyIY
         2cH8ICCQ3gabk2p+Hqg9MTatRZ5GHZ0rr45OKkoKj782OYVt/ybrgNMSh/OiyXylxQ65
         Z0OEtOiN/X6wXvVloGWifpgDmRyMiWhoQlQLbRK9UThvZd0pjiNkHh/7zhq4IKWVDemD
         GdiBDSyXfxYo5ZSKWZM74phSokKb12jDR76i75HFmeiwH14sMl6wFlc/+TOIp7vX1wN1
         qy0lJe1VpgmfQBUdBuYOYVbd4rXdZ8QYGhzsVBLQNv9BVJz7EypzfHV7piO01OWReGgD
         93Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWvhDo9G24cNGysSAW6q0I3O4cQ6QaqPvnUPzIymgu2KbXQ+CEpZH1CoWE1OKYpZgtRxTicjKvvJyrCt9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPb7N9Sn4qUlIitUfE678BtMr3qbhe5NuSRa2CrJ6UwCP0WwX
	95b8SGnOwY93VNU0ZKRlT4NoOXhmZwxeXAlpCTbNREu6JIxFiEDtP+mcEzl2x7/vTlGjRb3IWGy
	T9LiM
X-Gm-Gg: ASbGncv21s6iI1lPMlh+uZhpQ/ZLWEkSR7LEGey2oASzghzfvf8E3uplVUxhM+BWwPF
	mmnnh/EfzQ/ugM6KuhW3rASeaai2IR5im8eZYtw/GXM+mK1tv4caAxTzuPxSI42nKBl+494ygao
	vchBC+54x9GEMi7Br374upQXh2ddU4j1Fg1EC0ZVfcduOzH7YmO5S4Hb77LytaLveV0Y5dm1nk/
	pKVoG5ai39j/kX1Z+9anjkDRGN282nV13Am60OhYbfCZHrCVyDNVCSM0XXgPQAtyiPP8dzLT3ma
	oGkq9yiG+f2wi3EMSCFHbaafpF6ezQO0TDnbXkBuh/euUwx9BEXqhn6xbBUrFB/uU/R55t3bjNN
	4V2xA1D6HT4fQA7fk1qsYnemL0gEZS7V0keL+y1xz3urUSJaDGiXAlQIDXsg7yJuhGAxnFt44
X-Google-Smtp-Source: AGHT+IE/IGDUbFdQagnAGSx2I8HtgwdLHjigGbzbwJHyQIwj+Wi68+UGSe/1cR20+rAO3AtGn9HtGg==
X-Received: by 2002:a05:6e02:1c0e:b0:3e5:4351:ad0a with SMTP id e9e14a558f8ab-3e57078c28amr12232635ab.7.1755120085109;
        Wed, 13 Aug 2025 14:21:25 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e5418db19csm46937395ab.2.2025.08.13.14.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:21:24 -0700 (PDT)
Message-ID: <8ebc466c-1b9f-4ba3-a38e-bda6007c5b97@riscstar.com>
Date: Wed, 13 Aug 2025 16:21:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: phy: spacemit: introduce PCIe root
 complex
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lpieralisi@kernel.org, quic_schintav@quicinc.com,
 devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, inochiama@gmail.com,
 fan.ni@samsung.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 palmer@dabbelt.com, paul.walmsley@sifive.com, spacemit@lists.linux.dev,
 thippeswamy.havalige@amd.com, namcao@linutronix.de,
 linux-pci@vger.kernel.org, shradha.t@samsung.com, vkoul@kernel.org,
 dlan@gentoo.org, johan+linaro@kernel.org, kishon@kernel.org,
 mani@kernel.org, mayank.rana@oss.qualcomm.com, tglx@linutronix.de,
 bhelgaas@google.com, linux-phy@lists.infradead.org, kwilczynski@kernel.org,
 linux-riscv@lists.infradead.org
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-4-elder@riscstar.com>
 <175511815210.798605.10564052572461813362.robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <175511815210.798605.10564052572461813362.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 3:49 PM, Rob Herring (Arm) wrote:
> 
> On Wed, 13 Aug 2025 13:46:57 -0500, Alex Elder wrote:
>> Add the Device Tree binding for the PCIe root complex found on the
>> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
>> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
>> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
>> typically used to support a USB 3 port.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/pci/spacemit,k1-pcie-rc.yaml     | 141 ++++++++++++++++++
>>   1 file changed, 141 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:

Mine didn't for some reason, so I must be doing something wrong.

Simple inspection shows my compatible string contains ".yaml"!

I'll fix in a new version.  Sorry I missed this.

					-Alex

> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.example.dtb: /example-0/pcie@ca000000: failed to match any schema with compatible: ['spacemit,k1-pcie-rc']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250813184701.2444372-4-elder@riscstar.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 


