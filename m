Return-Path: <linux-kernel+bounces-838354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF38BAF041
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C600D19426A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7299D2797AF;
	Wed,  1 Oct 2025 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="D/8ewiY8"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2F3D6F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759286418; cv=none; b=ZrX037TOaYqRg2whYc19clRqGdL2c84t5OXH6pUVnwIYg6f4ozhtT8X6XOkuHJWSSKz0vUFdqacZA30RS7yK+Ifa/fxMTNovuMGS+VllH4G3+PMzpL4Rvaq9gSW+40es6XyKQ4BOhwBtas+cpjMi0Zs8jDYuEkDkPsWXIdGPMcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759286418; c=relaxed/simple;
	bh=jDbkyBlcNbK/IRWIsqyyXB+3OTJLzUTI8ugMTZvEqWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyl+cd9NEI3eBTaT70MTo6hchJWBqOd8m9EcHzAc8gtWPtuoKrzthIluElqJxVXjff0jcPOzDO9mmgk5frAsFPfBEi6Rh/ge07yXvyznAfWOGplvF7zHUExw5ksxHK3oSXTomdoUCookeLsiMAfWYRfkaWjUdbLKJyxXbwOZqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=D/8ewiY8; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-91c93719deaso348485339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1759286416; x=1759891216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxQ2zgdrHb7uD7qDfrNlnD3XXSfWmfO7hzlzDTfXqcQ=;
        b=D/8ewiY8ydB6qvxuUgYumFvOrN4rM6VTlc3y8sKRhhiGyZZXfngDjwDL/aDpVr8V2K
         HFKDqRmvkwDKLnfXUbn5ClF+ZvFPi/rJuyhDzB782mplXby+82KiUUNpeBD/fBmT0rnW
         B6GorFFtjPTMIb6V7novXrM8IEvMRiIrRkj+plmjG2EJpqpj+wDPsOM77devCW01jmry
         +CqPu5SowvxE4ZDe9tpsid4QFuYHerEjDgygXwla1Hv48z39kAicQZR+hKYFcs7AD38V
         cBBcq75W+4Ok3NQ7NXA/iBAG932xSQ8AzZe+Teu0rGP4EhNuVMN+i+hhrewVsj506LSr
         Bt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759286416; x=1759891216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxQ2zgdrHb7uD7qDfrNlnD3XXSfWmfO7hzlzDTfXqcQ=;
        b=VEKmbGiH7Zz85/U910IkyWzE8eCOxVYcr+CtUQtLPQa6VNyoo82Qjj0HfMtlCmYeR5
         w7B5x9tZMyThOwWjIJiYf5emNa4PzZkJyiOiH7RLA27ZXSihqlq6o5hBeohymKsDaKjZ
         CnjJoutBBwRQxEXzidYkIrZRZAo+x2kREvTidt52+mZgUh97vLFmhs1AEVFB+bqEIhFo
         C6cUGB9uWTWifcdrPi3CViyRsnfgOVXdo0JwnDA6KiAJ/VZMRD1STmOQ00Wi7uOlUU1F
         EMwkRG9Vu08LIIKXh20f+UI0IyS6pmML5S5HaR/4wJH8xqS96w6Bq1wlKAFAiknkvC6W
         pOtw==
X-Forwarded-Encrypted: i=1; AJvYcCWOcpLcjaheTMmaw6cScG8+gVjOKId7sHDPpeItq9sCKHcNqktgNKSYY1STYdGqpuZknIeosrSZf88/AG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa374dzuYQOgwdoXAey6TMBjCUxUpB7KWi66XBf2EVGBqAXU2J
	Xsa59IRbTwI6keRFthlPFnsxtZfCUWE5wu7TvCNCY24R+WHmYttTvD2lj7B9yjchVrw=
X-Gm-Gg: ASbGncsCnpXYgHSpK7BOQ3OxXXx4pHWldrP05OJLZOGqppcF4z5aJOpv3jzQ5ySMXkx
	bTBA72ar2xKHmqysrfA2ofC+b7bGqFe4rUT+viEoFaHkOyMArDSA86koDt7LL9o4qgEO9HRO7SH
	Qnvd0w6nLpQDRGklvuventaIrVX3JWiHfhtmK4b+3/L1yX7NUoYo6QgpUxZ/3s0Vb2sJ1Wr7go9
	MvytEs6L3mu2BtsWMUusD1M+P/3OLtVr7PxFEBQE5dKip6K8H2IYEq/Op0ssp/GamUqMVNPxwkP
	c/9JWqqVnTPPCgUFYcmxlZOf+HtpdbtnKZda039BwifjF2LU3DgOHW8XI4C+fEFCZBDkQO15zEf
	lwE0/iXgcCsbPks5u21XYnLbqJ1zwOlBKMNyyI7ZjFRLxea+S38Ag3T6dsNJANfSYYMEE8wngw/
	HwMjQ9DyaeFXii9OlOlNKL
X-Google-Smtp-Source: AGHT+IFQFvztbn8UfbzR8C12GJuYMM6yN5QwMW7n9lxY6XdpjQ/LdhbflFmYGAY5ytHhPYAVoI2Qfg==
X-Received: by 2002:a05:6602:2c08:b0:935:90f6:892e with SMTP id ca18e2360f4ac-937aebad412mr291037439f.17.1759286415752;
        Tue, 30 Sep 2025 19:40:15 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-92d06cc3b9esm184392139f.12.2025.09.30.19.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 19:40:15 -0700 (PDT)
Message-ID: <365ade7c-bb2c-42ff-a2e7-9a291b1faab7@riscstar.com>
Date: Tue, 30 Sep 2025 21:40:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: phy: spacemit: introduce PCIe root
 complex
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de,
 johan+linaro@kernel.org, thippeswamy.havalige@amd.com, namcao@linutronix.de,
 mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, inochiama@gmail.com,
 quic_schintav@quicinc.com, fan.ni@samsung.com, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-4-elder@riscstar.com>
 <tmdq6iut5z2bzemduovvyarya6ho2lwlxvvqqhazw6dnnyjpq3@72xrd2pij42h>
 <804ea57f-699f-41cc-a27c-844f107e627f@riscstar.com>
 <kam6fgc7ykxwnksu562etrib2z4w3sucvr27ojxq62iwyrdai3@i76ygp2anscy>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <kam6fgc7ykxwnksu562etrib2z4w3sucvr27ojxq62iwyrdai3@i76ygp2anscy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/25 12:55 AM, Manivannan Sadhasivam wrote:
> On Fri, Sep 19, 2025 at 03:14:05PM -0500, Alex Elder wrote:
>> On 9/15/25 3:14 AM, Manivannan Sadhasivam wrote:
>>> On Wed, Aug 13, 2025 at 01:46:57PM GMT, Alex Elder wrote:
>>>
>>> Subject should have 'pci' prefix, not 'phy'.
>>
>> OK I'll update that in the next version.

I have a new version of this code ready, but I'll delay sending
it until the end of the merge window.

>>>> Add the Device Tree binding for the PCIe root complex found on the
>>>> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
>>>> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
>>>> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
>>>> typically used to support a USB 3 port.
>>>>
>>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>>> ---
>>>>    .../bindings/pci/spacemit,k1-pcie-rc.yaml     | 141 ++++++++++++++++++
>>>>    1 file changed, 141 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
>>>> new file mode 100644
>>>> index 0000000000000..6bcca2f91a6fd
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
>>>> @@ -0,0 +1,141 @@

. . .

>>>> +  interrupts-extended:
>>>> +    maxItems: 1
>>>
>>> What is the purpose of this property? Is it for MSI or INTx?
>>
>> It is for MSIs, which are translated into this interrupt.
>> I'll add a short description indicating this.
>>
>> Is there a better way to represent this?
>>
> 
> For external MSI controllers, it is recommended to use 'msi-map' property as the
> client often need to pass RID, RID length and other sideband data to the MSI
> controller.

This implementation is using the DWC built-in MSI controller, not an
external controller.  It implements 256 MSIs, and they're handled by
dw_handle_msi_irq().  The interrupt will be given name "msi" in the
next version and I hope that at least helps clarify things.

> 
>>>> +
>>>> +  spacemit,syscon-pmu:
>>>> +    description:
>>>> +      PHandle that refers to the APMU system controller, whose
>>>> +      regmap is used in managing resets and link state.
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +
>>>> +  device_type:
>>>> +    const: pci
>>>> +
>>>> +  max-link-speed:
>>>> +    const: 2
>>>
>>> Why do you need to limit it to 5 GT/s always?
>>
>> It's what the hardware overview says is the speed
>> of the ports.
>>      PCIE PortA Gen2x1
>>      PCIE PortB Gen2x2
>>      PCIE PortC Gen2x2
>>
>> But I think what you're asking might be "why do you
>> need to specify in DT that the link speed is limited".
>> And in that case, I realize now that it is not needed.
>> I will specify dw_pcie->max_link_speed to 2 before
>> calling dw_pcie_host_init().
>>
> 
> You only need to specify this property if you want to limit the link speed to a
> certain data rate by the controller driver than what is supported by the
> hardware.

Yes, this makes sense.

> Looks like your hardware supports 5 GT/s by default for all ports. So you can
> omit this property and also no need to set 'dw_pcie->max_link_speed'. In the
> absence of this property, 'dw_pcie->max_link_speed' will be populated with the
> hardware default value, which will be 2 in your case.

You are correct, and I verified this.  I won't specify the link
speed "manually," and the hardware default (which is 2) will be
used.

>> If that's not what you meant, please let me know.
>>
>>>> +  num-viewport:
>>>> +    const: 8
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - resets
>>>> +  - reset-names
>>>> +  - spacemit,syscon-pmu
>>>> +  - "#address-cells"
>>>> +  - "#size-cells"
>>>> +  - device_type
>>>> +  - max-link-speed
>>>
>>> Same comment as above.
>>>
>>>> +  - bus-range
>>>> +  - num-viewport
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
>>>> +    pcie0: pcie@ca000000 {
>>>> +        compatible = "spacemit,k1-pcie-rc";
>>>> +        reg = <0x0 0xca000000 0x0 0x00001000>,
>>>> +              <0x0 0xca300000 0x0 0x0001ff24>,
>>>> +              <0x0 0x8f000000 0x0 0x00002000>,
>>>> +              <0x0 0xc0b20000 0x0 0x00001000>;
>>>> +        reg-names = "dbi",
>>>> +                    "atu",
>>>> +                    "config",
>>>> +                    "link";
>>>> +
>>>> +        ranges = <0x01000000 0x8f002000 0x0 0x8f002000 0x0 0x100000>,
>>>
>>> I/O port CPU address starts from 0.
>>
>> First, I'm not sure what this comment means.
>>
> 
> Sorry, I meant to say 'PCI address' not 'CPU address'. The second element in
> your 'ranges' example corresponds to the PCI start address of the I/O port and
> it should always start from 0. Also, the encoding for both tuples are wrong. It
> should be:
> 
> 	ranges = <0x01000000 0x0 0x00000000 0x8f002000 0x0 0x100000>,
> 		 <0x02000000 0x0 0x80000000 0x80000000 0x0 0x0f000000>;

Simply switching to what you show works just fine.  PCI
addresses show up being zero-based, as they should be.
What I don't fully understand is why it worked before.
Maybe because this is simply defining bounds in the
mapping?

In any case, I am using ranges properties like what you show.

Thanks Mani.

					-Alex

> - Mani

