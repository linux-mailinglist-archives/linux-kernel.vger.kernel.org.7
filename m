Return-Path: <linux-kernel+bounces-825177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E1B8B2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349971CC3FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2429ACC2;
	Fri, 19 Sep 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="jATh2H/C"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE628466C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312851; cv=none; b=IpwgOYI9QWeWMfZtrWziOd3dUcWuWoQRDW7l87gjQnJqIoWm2NRZBjjbd29ZKLIqJ/bTzJzdO3DlGSfGNI3ZmMkvq+uQ1QGrAewwNshhusIa4uTJqVgXgBET64qe79Fdpn0aKRY94OpbsD9ro24SkBDwiY48/e6DAqTR9ZjlVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312851; c=relaxed/simple;
	bh=VRK+pmEe7PbC45zTMGIrHgpzmAUjzNw9/dwoa9Zpgsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcBYZdvuqLlr0Zw3qF2HpzhSlUw1fBCUfWZyaTNJs0diXn2CV3NrBJroUOEWb4P3twht8in9Pbz8obEnBAi0I8Xo8eQZFLz7ddl4fEWjWnZWKcG9m2ahvLzAe3rBvwFyhoVmoAO02yZp3xoO9vJsg2OszxKh9WbluARGaW6uXms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=jATh2H/C; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88428b19ea9so119872339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758312848; x=1758917648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laoMcSCfK07azaBjCslDo0m3+R/kL+S83GK1yKfDxF8=;
        b=jATh2H/CRu5A3jcxiBkzcaOrJ4L/RLHdXp4FdZxhSTfIM9Ek0j9tTCIXSj1fg2hfZ0
         B+sgsn8GEyRoYlHkVvbU9WniFM1o0CYGhEjds8CLrvhAWesk7nffhU+WCxXeBGyt6mZr
         e9mtVXTsLcZuLLzJ6346cAzsmueflgmRv8u2SK1IwD0ddKroRFD5rgtYAFyxXFCPcPjZ
         LtSEzDeM/KGZrmD509l8TB6iZ6XQjbio9GU+FebDjwWAVXSnosZhXNyjVUey2QWcFE3o
         QLfHCtC8Q4IRta9EprRaS5T5CQHhS9sIST8QqaytEKYVmCS1BCMVKvB01g4uF5T5jYvW
         gkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758312848; x=1758917648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laoMcSCfK07azaBjCslDo0m3+R/kL+S83GK1yKfDxF8=;
        b=eq8D0ifWH61AE5ZG2ZmrfW+48yoHsog98Whu4T6FCUD38U5JS2L7yDHjhKgFA6NoQx
         HwSCxYa/L7QU5kV5p/t6vOkJQHMT7iiFFztMgmLDzrlOZ1j1uI5ywsRu6F+Kxm+Phwta
         G2RgSeqn4zK7POEDahWZDGlL8ysxGN9YPC/xhJ94OZ2vzG/QGsI0cnN4l/0+FZMQta84
         YH7Y1wBrmuQO1DZPJlJX9CopNmzX8DoANKJ47fD88C5gRJDunea/eayqiqPYL0+DNvxS
         WzwgPoq3rqDrq4rmYFwelrJJ5Oy3AmAhbmoxQW9O2e1Vj50hPNYihFRxmBG9mHKb4zzd
         RNvg==
X-Forwarded-Encrypted: i=1; AJvYcCXtCqzKlxiSddwKVq43QVGQrHkjc9i9cgYuiRgEEgPOw1/jlbLW9uDjAKmnbfQ6iZrJYF23C37lfLgSwj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Y+u/oebiHDq/K6ukow8YucRmSLuPEXkguC4qRsJ45+exSz5J
	aBk7DxzDrOA4xINufcjNQRih0XMrXAgLe75VSEre2x059QN5z9fBqt8CHoV8jH/RJuc=
X-Gm-Gg: ASbGnctottChilNfAUCACdI5uwHKkea975+muBY4ZwUYjFDWvRh3YAD3ts+l8lc8kIc
	Hb55yC3yM/kbjEFJ3pO9Tc06EohMQwmYtf7vLFN/VS88RRjuw99T+wbUoiuIb48TnoQl/eSQqkb
	GoEVOy+C7SuhY97D8yc6O0LH+wpUBeu6QBvwxgPaOoBtNKrvf+ZZ6cgcNtn7qrmnKYBLg9HeB+6
	wmoZrGix5BdQKmTGye4JuNRhO8vUgVwHSGnse99YQHOIkVMWhUwVlKIGEh7G50eJSDj+SYGJS/C
	Z1OenWCxtYgRvGVJkQUffUZD22HbP7u+LqxmVQOQBzvl+crF6P9dEiiYWQPZ1gzSRHof4G2rPA6
	NZQhDTcr6DbjBofsAYldosptq3c5xVGu6hZ+dBRzu0EED9Jks0Q55k0S2udfL6g==
X-Google-Smtp-Source: AGHT+IF/1Bf6FjG2s85ZEcZvlS57Mzf5kDdUZySVUGALWKCNyJGWzPVLZfqNWOxGh/9d2jvI0LV4rw==
X-Received: by 2002:a05:6e02:2163:b0:424:2c9:26b5 with SMTP id e9e14a558f8ab-42441af5e02mr127967325ab.9.1758312847889;
        Fri, 19 Sep 2025 13:14:07 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d5399014dsm2475887173.59.2025.09.19.13.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 13:14:07 -0700 (PDT)
Message-ID: <804ea57f-699f-41cc-a27c-844f107e627f@riscstar.com>
Date: Fri, 19 Sep 2025 15:14:05 -0500
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
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <tmdq6iut5z2bzemduovvyarya6ho2lwlxvvqqhazw6dnnyjpq3@72xrd2pij42h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 3:14 AM, Manivannan Sadhasivam wrote:
> On Wed, Aug 13, 2025 at 01:46:57PM GMT, Alex Elder wrote:
> 
> Subject should have 'pci' prefix, not 'phy'.

OK I'll update that in the next version.

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
>> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
>> new file mode 100644
>> index 0000000000000..6bcca2f91a6fd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
>> @@ -0,0 +1,141 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-rc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SpacemiT K1 PCI Express Root Complex
>> +
>> +maintainers:
>> +  - Alex Elder <elder@riscstar.com>
>> +
>> +description:
>> +  The SpacemiT K1 SoC PCIe root complex controller is based on the
>> +  Synopsys DesignWare PCIe IP.
>> +
>> +properties:
>> +  compatible:
>> +    const: spacemit,k1-pcie-rc.yaml
>> +
>> +  reg:
>> +    items:
>> +      - description: DesignWare PCIe registers
>> +      - description: ATU address space
>> +      - description: PCIe configuration space
>> +      - description: Link control registers
>> +
>> +  reg-names:
>> +    items:
>> +      - const: dbi
>> +      - const: atu
>> +      - const: config
>> +      - const: link
>> +
>> +  clocks:
>> +    items:
>> +      - description: DWC PCIe Data Bus Interface (DBI) clock
>> +      - description: DWC PCIe application AXI-bus Master interface clock
>> +      - description: DWC PCIe application AXI-bus Slave interface clock.
>> +
>> +  clock-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +
>> +  resets:
>> +    items:
>> +      - description: DWC PCIe Data Bus Interface (DBI) reset
>> +      - description: DWC PCIe application AXI-bus Master interface reset
>> +      - description: DWC PCIe application AXI-bus Slave interface reset.
>> +      - description: Global reset; must be deasserted for PHY to function
>> +
>> +  reset-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +      - const: global
>> +
>> +  interrupts-extended:
>> +    maxItems: 1
> 
> What is the purpose of this property? Is it for MSI or INTx?

It is for MSIs, which are translated into this interrupt.
I'll add a short description indicating this.

Is there a better way to represent this?

>> +
>> +  spacemit,syscon-pmu:
>> +    description:
>> +      PHandle that refers to the APMU system controller, whose
>> +      regmap is used in managing resets and link state.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  device_type:
>> +    const: pci
>> +
>> +  max-link-speed:
>> +    const: 2
> 
> Why do you need to limit it to 5 GT/s always?

It's what the hardware overview says is the speed
of the ports.
     PCIE PortA Gen2x1
     PCIE PortB Gen2x2
     PCIE PortC Gen2x2

But I think what you're asking might be "why do you
need to specify in DT that the link speed is limited".
And in that case, I realize now that it is not needed.
I will specify dw_pcie->max_link_speed to 2 before
calling dw_pcie_host_init().

If that's not what you meant, please let me know.

>> +  num-viewport:
>> +    const: 8
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - spacemit,syscon-pmu
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - device_type
>> +  - max-link-speed
> 
> Same comment as above.
> 
>> +  - bus-range
>> +  - num-viewport
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
>> +    pcie0: pcie@ca000000 {
>> +        compatible = "spacemit,k1-pcie-rc";
>> +        reg = <0x0 0xca000000 0x0 0x00001000>,
>> +              <0x0 0xca300000 0x0 0x0001ff24>,
>> +              <0x0 0x8f000000 0x0 0x00002000>,
>> +              <0x0 0xc0b20000 0x0 0x00001000>;
>> +        reg-names = "dbi",
>> +                    "atu",
>> +                    "config",
>> +                    "link";
>> +
>> +        ranges = <0x01000000 0x8f002000 0x0 0x8f002000 0x0 0x100000>,
> 
> I/O port CPU address starts from 0.

First, I'm not sure what this comment means.

But second, this ranges value (which I'm sure I just copied from
the working DTS file) somehow got munged.

I know there were other errors in this YAML file that I have
to fix, and I'll fix this too.

Thank you Mani.

					-Alex

> 
> - Mani
> 


