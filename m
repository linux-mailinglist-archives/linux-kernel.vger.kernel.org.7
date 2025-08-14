Return-Path: <linux-kernel+bounces-769622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F15B2710F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461A21CC7BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CBE27AC59;
	Thu, 14 Aug 2025 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="vkOQpKgT"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9D277C8A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208136; cv=none; b=UPT3Mv3GkOX3rswzg4EPz6JigG/hpDKnOd6R1IGFAg+x4kxuz02jCaEKXtGqp9IjSOK6DN18jzb0cSbZNUlzwD088NDaPtrKvZoLRxRxEvbl/f4sd8qSO/6brWMckE8vBKxg5XP2Zu9r/h5ZEjR+87RmP3mRHapypIsnBDY8CGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208136; c=relaxed/simple;
	bh=aeCT1ChAfnxrV4QBH+I+d7ZQyWZZMGksEWhBzA5kDbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3jmog//UDIJqu/1L0/ThvXwtxCruzLI52dHYsE1C8mAzrszrqYs11OQxx3IYJQ8hnlGeGJld20kOYNuYB4VCdylIwswuB6QQUMnJTQFE9OqL+Wk41of1NqFAJoSFzFCZlc1JMJ0VXm81aPRzM4+7fI476lRxHkwcrwjZPvR1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=vkOQpKgT; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e57376f661so4538625ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755208132; x=1755812932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCt+/c8MTw4m0fkTKSEjZUjQW40svl96k4sq8RtcJzA=;
        b=vkOQpKgT+BPApKwxS5X8TyBvF5j26rqE1h1nQdq7NRERcZM7hCM2wbcX+sZ1Ly25Y1
         K3cU2souPuDI8/OpAtwBeaakb58xqcRH4TymECwD+FiLhznEgZB1DmkBNc6cMS8/pHuG
         KQTGPjz9LZf2VxPXiiewrqBokwGHNhupBWqn192OzGBODgkkoYu9ZrDNiXm1z8gGL6s7
         j3cErejIRZFyA1ncN1CsOo8d7s+Tp5LAA8nQCu4rFBLZE4xTeNSWiGI8YvT/u++pcvg/
         VsjJwzkqQCxtbV4Caw8zalSyArrLJ/gHYm8OtcnyVnzHnvzL5YqHBdsYpFuR7nkeidJ7
         1GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755208132; x=1755812932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCt+/c8MTw4m0fkTKSEjZUjQW40svl96k4sq8RtcJzA=;
        b=LpigQap4rVJpl5w6YA1Z0GqVqzwmhS+TJhvmEiP7tl/xqau0jXr6d1wDGJ/+WJskP4
         V2ZikNL/c5kDteKEKGvTHnP6zg1+8S7txXc+iY1pJ2ijm4ufyp8+iuF0oRgk/f6i1v45
         qSvZ5Ic38/KhOh+H7eyRUkvtjG8P5NZ1qugr8ZVzjpSDzrD31QmJSZqPf07nzYF4LHpd
         Q3TyKQT8Rk9OqVt3bOykLoshsNVmRpG5syL2mGASOmDlyd5ivOfgsz5BVBsnosFLhqHO
         D/XerYDyoRdh1rmAhNjk/3b/ePDNXc7eaJDQWa815TubyrOsZ8ySeb8UbV1sJ6DJqBVs
         /uZg==
X-Forwarded-Encrypted: i=1; AJvYcCVuA3mcR6mn6D5oiANtGtEs2Nxh/wvl7NHg+rcW1/4ebo4ww3cgxT2ZUSxbro9n9MmSYHwHPJnzbyYEEqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl2DIe6ztCsaXsYPOGam5W1dOrZAh27V9sF/IBy88G7ouPQ+wr
	QesXF0VsV4d8ibPminEJK21ClTVy7HhCgg3d/PiolO/oA4dL5VHkBgNKyI7GgSrgcQM=
X-Gm-Gg: ASbGncsos740GWUM7NHcOBBJuTtDjrD0nIqcVYTAOyBL17vBXaMmlPdLBk0tZVnO+02
	2iy7RYEbTKSsIVndR+mTfjNBa4TbOOCQi2W9wKbKBJtNHTf+NRm0glYE0lbQdgYolxodKLx2H8B
	2H5pwsg1zeW6YlLYbAhJ7N0hFth7PGWidPy1RaedmA4cC4hsfpgiaX/fSDcAkmZR9adc9v+c9Dr
	DULzg5GNunVTLbkQ5c5jc+hAkBOOeEAPKhQCwZthS37JAaxqtTT2rcllHtUVmtSK9Go4Qdzd5+q
	ADEVGx4xHTedyFMSv6ZNaudmcBIs4O5hMocgoaMLvk1J9/CW1f+K0mW6Zcop/0UiB7Kt+TwJmDh
	h7lTT6vUzU1dt3zJ7WGXwlArxb4IZf/5aZt32nk1gvphlm/wF4IpvMQI3H5pEaQ==
X-Google-Smtp-Source: AGHT+IFztpZaPjE0ea4cNoutzDsxWfnWI0H8yYAAWojxd3NMEw8UDJycdrDTch6nLLHh52NEA2N7Sw==
X-Received: by 2002:a92:cd8c:0:b0:3e5:4eb2:73e3 with SMTP id e9e14a558f8ab-3e57ba5c53emr13235285ab.16.1755208131603;
        Thu, 14 Aug 2025 14:48:51 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bd3291sm4605468173.63.2025.08.14.14.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 14:48:51 -0700 (PDT)
Message-ID: <bc6975bd-cc1a-41ff-887c-0509bc8f03c3@riscstar.com>
Date: Thu, 14 Aug 2025 16:48:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: phy: spacemit: add SpacemiT PCIe/combo
 PHY
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
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
 <20250813184701.2444372-2-elder@riscstar.com>
 <20250814205128.GA3873683-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250814205128.GA3873683-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 3:51 PM, Rob Herring wrote:
> On Wed, Aug 13, 2025 at 01:46:55PM -0500, Alex Elder wrote:
>> Add the Device Tree binding for the PCIe/USB 3.0 combo PHY found in
>> the SpacemiT K1 SoC.  This is one of three PCIe PHYs, and is unusual
>> in that only the combo PHY can perform a calibration step needed to
>> determine settings used by the other two PCIe PHYs.
>>
>> Calibration must be done with the combo PHY in PCIe mode, and to allow
>> this to occur independent of the eventual use for the PHY (PCIe or USB)
>> some PCIe-related properties must be supplied: clocks; resets; and a
>> syscon phandle.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/phy/spacemit,k1-combo-phy.yaml   | 110 ++++++++++++++++++
>>   1 file changed, 110 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
>> new file mode 100644
>> index 0000000000000..ed78083a53231
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
>> @@ -0,0 +1,110 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/spacemit,k1-combo-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SpacemiT K1 PCIe/USB3 Combo PHY
>> +
>> +maintainers:
>> +  - Alex Elder <elder@riscstar.com>
>> +
>> +description:
> 
> You need a '>' or the paragraphs formatting will not be maintained
> (should we ever render docs from this).

OK.

>> +  Of the three PHYs on the SpacemiT K1 SoC capable of being used for
>> +  PCIe, one is a combo PHY that can also be configured for use by a
>> +  USB 3 controller.  Using PCIe or USB 3 is a board design decision.
>> +
>> +  The combo PHY is also the only PCIe PHY that is able to determine
>> +  PCIe calibration values to use, and this must be determined before
>> +  the other two PCIe PHYs can be used.  This calibration must be
>> +  performed with the combo PHY in PCIe mode, and is this is done
>> +  when the combo PHY is probed.
>> +
>> +  During normal operation, the PCIe or USB port driver is responsible
>> +  for ensuring all clocks needed by a PHY are enabled, and all resets
>> +  affecting the PHY are deasserted.  However, for the combo PHY to
>> +  perform calibration independent of whether it's later used for
>> +  PCIe or USB, all PCIe mode clocks and resets must be defined.
>> +
>> +properties:
>> +  compatible:
>> +    const: spacemit,k1-combo-phy
>> +
>> +  reg:
>> +    items:
>> +      - description: PHY control registers
>> +
>> +  clocks:
>> +    items:
>> +      - description: DWC PCIe Data Bus Interface (DBI) clock
>> +      - description: DWC PCIe application AXI-bus Master interface clock
>> +      - description: DWC PCIe application AXI-bus Slave interface clock.
> 
> End with a period or don't. Just be consistent.

OK.

> You need DWC PCIe clocks for your PHY? A ref clock would make sense, but
> these? I've never seen a PHY with a AXI master interface.

*This* is what I was waiting for.  I explained it briefly in
the patch headers and elsewhere but I expected questions.

This is needed to support USB mode, while also supporting the other
PCIe interfaces.

The SpacemiT IP requires its PCIe interfaces to have 4-bit RX and TX
receiver termination values be configured during initialization.  The
values to use must be determined dynamically by doing a calibration
step, then reading a (PCIe) register that contains the values to use.

Only the combo PHY is able to perform this calibration. and the
configuration values it determines must then be used to configure
the other two PCIe (only) PHYs.

This means that to calibrate, the combo PHY must be started (clocks
enabled, resets de-asserted) in PCIe mode.

If the combo PHY were going to be used for PCIe, this could be done
when it is initialized, because the PCIe driver would ensure the
clocks and resets were set up properly.

But if the combo PHY is going to be used for USB, the PCIe
calibration step would (otherwise) never be done, and that
means the other two PCIe interfaces could not be used.

So my solution is to move this calibration step into the PHY.
The combo PHY performs the calibration step when it is probed,
and to do that the driver needs to use its PCIe clocks and resets.
Once the calibration values are known, the clocks and resets
are essentially forgotten, and the PHY is available for use (by
either PCIe or USB 3).

The other two PCIe interfaces cannot probe (-EPROBE_DEFER) until
the calibration values are known, which means they might have to
wait until after the combo PHY has probed successfully.

I asked SpacemiT about this a lot, but their answer is that the
combo PHY is the only one that can determine these values, and
they must be determined each time the hardware is powered up.

I think this approach is less ugly than some alternatives.

Is this clear?  Can you think of a different way of handling it?

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
> 
> Same here (on both points).

I will remove the period on the third one.

> 
>> +      - description: Global reset; must be deasserted for PHY to function
>> +
>> +  reset-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +      - const: global
>> +
>> +  spacemit,syscon-pmu:
>> +    description:
>> +      PHandle that refers to the APMU system controller, whose
>> +      regmap is used in setting the mode
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  "#phy-cells":
>> +    const: 1
>> +    description:
>> +      The argument value (PHY_TYPE_PCIE or PHY_TYPE_USB3) determines
>> +      whether the PHY operates in PCIe or USB3 mode.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - spacemit,syscon-pmu
>> +  - "#phy-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
>> +    combo_phy: phy@c0b10000 {
> 
> Drop unused labels.

OK.

>> +        compatible = "spacemit,k1-combo-phy";
>> +        reg = <0xc0b10000 0x1000>;
>> +        clocks = <&syscon_apmu CLK_PCIE0_DBI>,
>> +                 <&syscon_apmu CLK_PCIE0_MASTER>,
>> +                 <&syscon_apmu CLK_PCIE0_SLAVE>;
>> +        clock-names = "dbi",
>> +                      "mstr",
>> +                      "slv";
>> +        resets = <&syscon_apmu RESET_PCIE0_DBI>,
>> +                 <&syscon_apmu RESET_PCIE0_MASTER>,
>> +                 <&syscon_apmu RESET_PCIE0_SLAVE>,
>> +                 <&syscon_apmu RESET_PCIE0_GLOBAL>;
>> +        reset-names = "dbi",
>> +                      "mstr",
>> +                      "slv",
>> +                      "global";
>> +        spacemit,syscon-pmu = <&syscon_apmu>;
>> +        #phy-cells = <1>;
>> +        status = "disabled";

Krzysztof also pointed out that I can't disable it so I'll drop
the above line as well.

Thanks for the review.

					-Alex

>> +    };
>> -- 
>> 2.48.1
>>


