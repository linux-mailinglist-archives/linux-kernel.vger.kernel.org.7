Return-Path: <linux-kernel+bounces-871328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4CC0CF0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DBAF4EFCCE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B02F3C3D;
	Mon, 27 Oct 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rd/JJOKk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6331DF252;
	Mon, 27 Oct 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560640; cv=none; b=sJhJunNS2sSb9vqWMmi86161zj4pbD1gbtWGsmwyjidIoyl6HuFJs0WgLYYQAvV7/xbre5vPlKNzVXy9YPmLDM3BN6mCfKnbpu1EJwdV9XUgXQvMkOHZ2oDcr24zQCgUTEK3ShisZkIAkA2eKYJGpVA568KSFjS/SUxr6yFZzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560640; c=relaxed/simple;
	bh=aFMORePwcPTydUz6VlH0qFjjkLxDJNo9Sxr1SvlX4OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeK7h5MzzPFTc0pgofrvwF+qlRJrasz3Cs7XSWwE9dYVbXeKLQk1Dxvv+rLvUu0Kjly25o2T0pIho6gnSY83Ef4NTWs6WS/KMY+so+XEpRxi+pWUM7ivNGIwqcNmKRGyb/S4TBNbwOaKTbwEI+TCiny2fhrpXezI4eFsKbe8Kto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rd/JJOKk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761560633;
	bh=aFMORePwcPTydUz6VlH0qFjjkLxDJNo9Sxr1SvlX4OI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rd/JJOKkBJ6qfsuqB4Cgu8aRpKGVbvpGEx/Ba7CyBGBbgO/fIWdmBBkbySU5EtwKE
	 JB1+ywk2KG9+72spaR2LMlhL2l7fd2pGl0ExFMZtlMs6Rm9HSFqdQY3wpAAIH92QII
	 P5VqiphDEpMntKyHokuD4Qf9Wpblleqo2yNEhYJx1L42Z/4Z5NNP8S1nhOfEoC79Jr
	 YCIFr7qGrTUi2a6rcqUIclqQGQUk0Y/AM7XUsIj1oMHXABwIybSOWhYWw1eTikrc2+
	 6z0NZIp+EecFE2ZEuggIiVzqF/X+KkkGrYt6HgW05CMEZDfKT091+h2LpBzZxqAXbM
	 DSxMDfhXG5I8Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AC55017E0DC0;
	Mon, 27 Oct 2025 11:23:52 +0100 (CET)
Message-ID: <305a2d9c-92c3-4608-b5f6-57f6db51c08e@collabora.com>
Date: Mon, 27 Oct 2025 11:23:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/9] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
To: Conor Dooley <conor@kernel.org>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org,
 igor.belwon@mentallysanemainliners.org
References: <20251024083221.25758-1-angelogioacchino.delregno@collabora.com>
 <20251024083221.25758-2-angelogioacchino.delregno@collabora.com>
 <20251024-think-handwoven-504634ca620d@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251024-think-handwoven-504634ca620d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/10/25 18:29, Conor Dooley ha scritto:
> On Fri, Oct 24, 2025 at 10:32:13AM +0200, AngeloGioacchino Del Regno wrote:
>> Add bindings for the regulators found in the MediaTek MT6316 PMIC,
>> usually found in board designs using the MT6991 Dimensity 9400 and
>> on MT8196 Kompanio SoC for Chromebooks.
>>
>> This chip is fully controlled by SPMI and has multiple variants
>> providing different phase configurations.
>>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../regulator/mediatek,mt6316b-regulator.yaml | 78 +++++++++++++++++++
>>   .../regulator/mediatek,mt6316c-regulator.yaml | 78 +++++++++++++++++++
>>   .../regulator/mediatek,mt6316d-regulator.yaml | 77 ++++++++++++++++++
>>   3 files changed, 233 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.yaml
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
>> new file mode 100644
>> index 000000000000..65b70dd90728
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6316b-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek MT6316 BP/VP SPMI PMIC Regulators
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +
>> +description:
>> +  The MediaTek MT6316BP/VP PMICs are fully controlled by SPMI interface, both
>> +  feature four step-down DC/DC (buck) converters, and provides 2+2 Phases,
>> +  joining Buck 1+2 for the first phase, and Buck 3+4 for the second phase.
>> +
>> +properties:
>> +  compatible:
>> +    const: mediatek,mt6316b-regulator
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^vbuck(12|34)$":
>> +    type: object
>> +    $ref: regulator.yaml#
>> +    unevaluatedProperties: false
>> +    properties:
>> +      regulator-allowed-modes:
>> +        description: |
>> +          Allowed Buck regulator operating modes allowed. Valid values below.
>> +            0 - Normal mode with automatic power saving, reducing the switching
>> +                frequency when light load conditions are detected
>> +            1 - Forced Continuous Conduction mode (FCCM) for improved voltage
>> +                regulation accuracy with constant switching frequency but lower
>> +                regulator efficiency
>> +            2 - Forced Low Power mode for improved regulator efficiency, used
>> +                when no heavy load is expected, will shut down unnecessary IP
>> +                blocks and secondary phases to reduce quiescent current.
>> +                This mode does not limit the maximum output current but unless
>> +                only a light load is applied, there will be regulation accuracy
>> +                and efficiency losses.
>> +        minItems: 1
>> +        maxItems: 3
>> +        items:
>> +          enum: [ 0, 1, 2 ]
> 
> This property has no default, and the property is not required. Is one
> of these modes the default, or is there another mode beyond what's here
> that is used if the property is absent? Or are all modes allowed with no
> property?
> 

The default is what the bootloader sets before jumping to the kernel... this may
vary from one to the other.

Even though "in theory" the default should be 0, I can't guarantee that this will
really be the default for when Linux boots.... and "resetting" is not possible
(either as a real reset or forcing a default) because those are CPU regulators
and if anything goes wrong the CPUs may freeze execution.

It should be kinda safe to force the default to 0 at boot, but I'm not sure that
I should really take that assumption for granted - I prefer leaving this untouched
and without any "forced" default unless DT specifies some.

So, well, that's why there's no default, and that's why this is not a required
property at the end of the day.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#address-cells'
> 
> Why is address-cells required here? Your bucks don't have addresses.

Ugh. I forgot it there. No, that's not intentional.

The #address-cells makes no sense here.

> If it is actually required, Rob's bot has pointed out that the property
> isn't defined for the device anyway.
> 
> pw-bot: changes-requested
> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/spmi/spmi.h>
>> +
>> +    spmi {
>> +      #address-cells = <2>;
>> +      #size-cells = <0>;
>> +
>> +      pmic@8 {
>> +        compatible = "mediatek,mt6316b-regulator";
>> +        reg = <0x8 SPMI_USID>;
>> +        #address-cells = <0>;
>> +
>> +        vbuck12 {
>> +          regulator-name = "dvdd_core";
>> +          regulator-min-microvolt = <450000>;
>> +          regulator-max-microvolt = <965000>;
>> +          regulator-allowed-modes = <0 1 2>;
>> +          regulator-enable-ramp-delay = <256>;
>> +        };
>> +      };
>> +    };
>> +...



