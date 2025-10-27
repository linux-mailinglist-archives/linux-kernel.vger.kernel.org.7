Return-Path: <linux-kernel+bounces-871329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C5DC0CF16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFC1A4F0641
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B644A2F4A10;
	Mon, 27 Oct 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q/x+HhBG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C61DF252;
	Mon, 27 Oct 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560653; cv=none; b=khkcz6+eR2RrST+qZg8aeiyi1GQa2AFQ3A9bq/+GXyOkWDdTWzZWFglDvIXDEeNpJGkbMMZyhLk7ExozGtMuIjLeakGd+3OS2OvQPZ4El+gxr9WJ5PRo8iMeisbqAUbGEZVXA+otIzgy7PRSFLciizbdq82AaUOH9HCLBamfBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560653; c=relaxed/simple;
	bh=vTOgKCvRxuU4DjEERkogKbYBwYp5CJEVMp8MP00NiNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptJUlZLlDdJZdej3uy6dKr4XecmiH2fUixOXr3+Qr9EEpaQ/wKmoS9+Xp81sjh603IzUy4MXoEC+UCyMO3SjK3lgd0ZEheVhzGt6C3uDk/xEW0l8h+BAH4/KagX7692saNezzVA933ldG4CpPbKHat9oqMNUwDBTW3N/R3Sh7kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q/x+HhBG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761560649;
	bh=vTOgKCvRxuU4DjEERkogKbYBwYp5CJEVMp8MP00NiNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q/x+HhBGKnpTKn2N5nEE4FDydXMkf2mF7Es8DR3RffdoxC92ZTWgWqrrHpCDaCZuk
	 oIPsuFiydf4481020UeYYiimLYzj0qXpN0RMHnulqg9acGnOxUu7NgCSBD2Tn+0vUS
	 lhzb/YrkoCdluGk3mbqla60dMsoJJTmeeFZT+uFyUzggR3iq9rhpwTCRA9SWtKwQGN
	 YEKZe/l1nG5CT8Vky2wFRmPLhn6GYDO3kgm7esVXiXS/1iaLl06ulab1Xlh79VJ1Ti
	 bZNwvWwufZ8iPqwwMYmOA4iClBJ4EljDeZB9RRfEEXm3Jd8wejSZwITHLpgS4s+kJP
	 lyX80kJgnefkg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C1CB17E0DC0;
	Mon, 27 Oct 2025 11:24:08 +0100 (CET)
Message-ID: <e9de0c51-01f1-4aa2-8950-cbfa54347729@collabora.com>
Date: Mon, 27 Oct 2025 11:24:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/7] dt-bindings: clock: Describe MT6685 PM/Clock IC
 Clock Controller
To: Conor Dooley <conor@kernel.org>
Cc: sboyd@kernel.org, mturquette@baylibre.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 laura.nao@collabora.com, nfraprado@collabora.com, wenst@chromium.org,
 y.oudjana@protonmail.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20251024083301.25845-1-angelogioacchino.delregno@collabora.com>
 <20251024083301.25845-7-angelogioacchino.delregno@collabora.com>
 <20251024-trophy-clause-7db540d073fa@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251024-trophy-clause-7db540d073fa@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/10/25 18:25, Conor Dooley ha scritto:
> On Fri, Oct 24, 2025 at 10:33:00AM +0200, AngeloGioacchino Del Regno wrote:
>> Add bindings to describe the SCK_TOP clock controller embedded
>> in the MT6685 IC, reachable over the SPMI bus.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>
>> NOTE: This does not contain any example because the MT6685 RTC
>>        will be added to the mfd binding for MediaTek SPMI PMICs
>>        and examples will be there.
>>
>> ** For reviewing purposes, this is how the example will look like: **
>>
>>    - |
>>      #include <dt-bindings/interrupt-controller/irq.h>
>>      #include <dt-bindings/spmi/spmi.h>
>>
>>      spmi {
>>        #address-cells = <2>;
>>        #size-cells = <0>;
>>
>>        pmic@9 {
>>          compatible = "mediatek,mt6363";
>>          reg = <0x9 SPMI_USID>;
>>          interrupts = <9 1 IRQ_TYPE_LEVEL_HIGH>;
>>          interrupt-controller;
>>          #address-cells = <1>;
>>          #interrupt-cells = <3>;
>>          #size-cells = <0>;
>>
>>          clock-controller@514 {
>>            compatible = "mediatek,mt6685-sck-top";
>>            reg = <0x514>;
>>            #clock-cells = <1>;
>>          };
>>
>>          rtc@580 {
>>            compatible = "mediatek,mt6685-rtc";
>>            reg = <0x580>;
>>            interrupts = <9 0 IRQ_TYPE_LEVEL_HIGH>;
>>          };
>>        };
>>      };
>>
>>   .../bindings/clock/mediatek,mt6685-clock.yaml | 37 +++++++++++++++++++
>>   .../dt-bindings/clock/mediatek,mt6685-clock.h | 17 +++++++++
>>   2 files changed, 54 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
>>   create mode 100644 include/dt-bindings/clock/mediatek,mt6685-clock.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
>> new file mode 100644
>> index 000000000000..5407ebf2f3b5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/mediatek,mt6685-clock.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek Clock Controller for MT6685 SPMI PM/Clock IC
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +
>> +description: |
>> +  The clock architecture in MediaTek PMICs+Clock ICs is structured like below:
>> +  Crystal(XO) or Internal ClockGen -->
>> +          dividers -->
>> +                      muxes
>> +                           -->
>> +                              clock gate
> 
> Is this the intended formatting? Looks weird with "dividers" being
> unaligned with the --> above it, but maybe you were just going for x
> number of spaces?
> 

Yeah I was just going for x number of spaces, otherwise that may become a bit
"too long"...

>> +
>> +  The device nodes provide clock gate control in different IP blocks.
> 
> I think this is more understandable as "This device provides clock gate
> control", if this sck-top is only doing gating. Otherwise, not clear if
> the dividers and muxes are here or elsewhere.

-> Datasheets are incomplete (sad-face-here) <-

Most of the information here is grabbed from more than one downstream kernel
for more than one SoC/device, and assembled together.

The XO/clockgen and dividers are not in SCKTOP - those should be partially in
the "TOP" portion (yeah, there's a top and a sck-top), and partially in another
block that controls only the clockgen.

I didn't want to implement those two, even though I almost precisely know how to
do that (and I did it in some local tests), because I could only gather partial
information and I didn't feel confident in upstreaming something that I'm not
entirely sure about.

Same goes for the MUX part: there's some here, some there, one in scktop as well
(but I didn't describe it because again incomplete info, and even downstream the
only mux in scktop seems to be unused).

So yeah - apart from one mux, anything before clock gate is elsewhere... I can
change that statement to the one you proposed, looks a bit better than what I
came up with, so thanks for that :-D

> 
>> +properties:
>> +  compatible:
>> +    const: mediatek,mt6685-sck-top
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> diff --git a/include/dt-bindings/clock/mediatek,mt6685-clock.h b/include/dt-bindings/clock/mediatek,mt6685-clock.h
>> new file mode 100644
>> index 000000000000..acc5e2e15ce1
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/mediatek,mt6685-clock.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +/*
>> + * Copyright (c) 2025 Collabora Ltd.
>> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_MT6685_H
>> +#define _DT_BINDINGS_CLK_MT6685_H
>> +
>> +/* SCK_TOP_CKPDN */
>> +#define CLK_RTC_SEC_MCLK		0
>> +#define CLK_RTC_EOSC32			1
>> +#define CLK_RTC_SEC_32K			2
>> +#define CLK_RTC_MCLK			3
>> +#define CLK_RTC_32K			4
>> +
>> +#endif /* _DT_BINDINGS_CLK_MT6685_H */
>> -- 
>> 2.51.1
>>



