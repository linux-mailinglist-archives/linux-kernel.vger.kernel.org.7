Return-Path: <linux-kernel+bounces-875958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E11C1A417
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEFF5630C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B50358D35;
	Wed, 29 Oct 2025 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+WtS5yz"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55813587AB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740557; cv=none; b=C7jlFQifaS9fAfd9XuT6dBL3bTJJi9KAzX2ZoSrs3UHojTaXF5nknJhpvAly7oXF2Snil/33MNiTVbajFmclgIMMmiHF6E/hypVZVnUpbiWFv4ez/bUGLRVN879AilDS0TNli6+ErUeZzG6cAK3x7Iw0nFzOrDGl7mjWeqT3pw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740557; c=relaxed/simple;
	bh=2uVsXjqYAFXDMXZsaLDabWe8n3+FWhGwBNQ1WHtgWew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJHHruDGjCtPLHeq0Lga00tQk7poMfwg8d/3eq3DvT6rzGBwrrHizgHEELgN8BvadjMYoH9gy9ebeqDwTaJVunE8Qun9k9Lhg/IRYh8lN6xBz9AEs7+Mcvbtq4xNR8ehSMoeCWhSDC7MSH9S32YR9mOK6jhzcbZFj6hEO8neCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+WtS5yz; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378cfd75fb0so76351771fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761740553; x=1762345353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZgl3eI7vg5tzy1n/3yyz3iAkoVI/IBOnqdMyOqmVk0=;
        b=B+WtS5yzyIwpvOorO9CU/ozNNAtHkPHMMAjXFP3xqgEmQKRpMc19hxES+whEnMzcAP
         Ua+K9G9dmrezmc9/NmRa4iUEjIzTGkY1sJNOcurg27zKfDjsSk7k88GPK2LpN7RGussR
         n+9Antt2eU4T73u4NMvzOvv/58cz8kQd++01nlo8U7vF2ynyxq+t2vixohCpa7fsUsUE
         D7SujO1reH5jhOVg+/rZ7B7kvE2acaQV9nMuMgCcVuLUHdsm5psGYhPJw8Q/kyO8Vcnf
         AhU+tfTqYZReepGb7uXKa+w8I9df0RLPciZwLiEN+nq1O9XO/trAbUFiWpQdpFoyvC53
         Vq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740553; x=1762345353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZgl3eI7vg5tzy1n/3yyz3iAkoVI/IBOnqdMyOqmVk0=;
        b=eWAoqYckhIvTdeoKMMV43feHaupuib/Be0LA1aHr0HW0Hjbhlk0lcqapjJ0Kg2aBmQ
         qs5P/WBZvP0EDpR199JdAmjAKvgSthe2sF7/E7PC7Rdpt6aq+U1YIZtVUGZDu4t8QEuM
         bXs/O1mJvYcP1GaW9U8Y4GRy4UDjT81lxYxnqVBX2Da2irFnx7U/aJtQklOFNwizS/nW
         9xqLzcl5Tewh99ongBCZhYuBK97KMTq2fKfIAom93T/19urqUrE+qGEBNWmNr68BiYe2
         ijHvTzNCAwGIAfcze+1Cn4BBzq927MqnwaTEF6b0td7FXr+TZEuihWjN3ZtcXAzTSgDb
         SFbg==
X-Forwarded-Encrypted: i=1; AJvYcCXSUieWr9q5+IwM5GntqsXMNmF2iXalWsbc/ZjdGjtx3P9lOPEC9pXoK0eJQQe1+XWk03YrxxA9x8tb18w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXu4bs/zS+kyGbWRzAwmQSKVhkiPy5tTbJpN0Tk9/gLKLoIJC
	HW5PQEBhtRFSlcgsNWxMDQrWto6jhkiV6wuQxfAk6zNGMQjxwr7n+UWm
X-Gm-Gg: ASbGncs88mZ9sqbTMU5FYGmYzVlfSJlbhC3z+MOvxFP5kbLlprMWEAw4P/4vYyBPmhc
	xjH/TgeLKzLEVRIFtNlYmthHbJltzrBdICWceQ19PoHAaCEEKxVQbQQSOb25Si48jSDotH5dFFu
	JMPTRmuaPwdg+sPD36dyPmXFRtsMWtXIuboyqSVB4OJCec+lBrmfMt27TMHoJ51v2p8UjA2kTXk
	mQrB5eu+NDdNDVCk/HrwR0FPLdSr+7KDzKYoN2WSdg+FH0lohm7MWEB3Qu+jEE7eeLXaHQKygJ9
	y9j6PoeE6qiMez90EDG9+YxnoelG/GK9+WSxrpa/8LbKa8Wo7JnZFmN6CYJmIirHwf2foC0KlUI
	KbJuzykcmOXGlbhWAyN1/j+y8RmxZI9LjgJ24546COS3u61ruqUkByH2cFFUX4O8mZnnfdJcAVs
	0joSrQAHfcdg==
X-Google-Smtp-Source: AGHT+IE2iQbJln+N7SD4pplQmz5pd5RsqX+x6DtY4QwXN3fjqhUrh1ZJZX1iVGCG3vRTmo+/4QF4Bg==
X-Received: by 2002:a05:651c:1542:b0:36d:114b:52e2 with SMTP id 38308e7fff4ca-37a024017b7mr7425661fa.34.1761740552495;
        Wed, 29 Oct 2025 05:22:32 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee09229asm33470711fa.9.2025.10.29.05.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:22:31 -0700 (PDT)
Message-ID: <c28bbb75-36b0-4776-b81c-c5dc2dd5ae28@gmail.com>
Date: Wed, 29 Oct 2025 14:22:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] dt-bindings: mfd: ROHM BD72720
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>
 <20251027211351.GC1565353-robh@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251027211351.GC1565353-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2025 23:13, Rob Herring wrote:
> On Mon, Oct 27, 2025 at 01:45:46PM +0200, Matti Vaittinen wrote:
>> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
>> charger, LEDs, RTC and a clock gate.
>>
>> Add dt-binding doc for ROHM BD72720.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>>   RFCv1 => v2:
>>   - Typofixes
>> ---
>>   .../bindings/mfd/rohm,bd72720-pmic.yaml       | 269 ++++++++++++++++++
>>   1 file changed, 269 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
>> new file mode 100644
>> index 000000000000..b0d4bc01d199
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
>> @@ -0,0 +1,269 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/rohm,bd72720-pmic.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ROHM BD72720 Power Management Integrated Circuit
>> +
>> +maintainers:
>> +  - Matti Vaittinen <mazziesaccount@gmail.com>
>> +
>> +description: |
>> +  BD72720 is a single-chip power management IC for battery-powered portable
>> +  devices. The BD72720 integrates 10 bucks and 11 LDOs, and a 3000 mA
>> +  switching charger. The IC also includes a Coulomb counter, a real-time
>> +  clock (RTC), GPIOs and a 32.768 kHz clock gate.
>> +
>> +# In addition to the properties found from the charger node, the ROHM BD72720
>> +# uses properties from a static battery node. Please see the:
>> +# Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml
> 
> Why is all of this a comment?

Hi Rob,

Thanks for (all the) reviews! Much appreciated.

I added these as comments because they aren't meant to be in the BD72720 
charger-node (which is described by this driver), but in a static 
battery node. The battery node does not belong in the charger node.

My idea was still to document (for integrator) the battery properties 
this charger uses from a static battery node when present. Only thing we 
include directly to this node is the:
monitored-battery = <&battery>; - reference.

> 
>> +#
>> +# Following properties are used
>> +# when present:
>> +#
>> +# charge-full-design-microamp-hours: Battry capacity in mAh
>> +# voltage-max-design-microvolt:      Maximum voltage
>> +# voltage-min-design-microvolt:      Minimum voltage system is still operating.
>> +# degrade-cycle-microamp-hours:      Capacity lost due to aging at each full
>> +#                                    charge cycle.
>> +# ocv-capacity-celsius:              Array of OCV table temperatures. 1/table.
>> +# ocv-capacity-table-<N>:            Table of OCV voltage/SOC pairs. Corresponds
>> +#                                    N.th temperature in ocv-capacity-celsius
>> +#
>> +# ROHM specific properties:
>> +# rohm,voltage-vdr-thresh-microvolt: Threshold for starting the VDR correction
>> +# rohm,volt-drop-soc:                Table of capacity values matching the
>> +#                                    values in VDR tables.
>> +# rohm,volt-drop-high-temp-microvolt: VDR table for high temperature
>> +# rohm,volt-drop-normal-temp-microvolt: VDR table for normal temperature
>> +# rohm,volt-drop-low-temp-microvolt:  VDR table for low temperature
>> +# rohm,volt-drop-very-low-temp-microvolt: VDR table for very low temperature
>> +#
>> +# VDR tables are (usually) determined for a specific battery by ROHM.
>> +# The battery node would then be referred from the charger node:
>> +#
>> +# monitored-battery = <&battery>;
>> +
>> +properties:
>> +  compatible:
>> +    const: rohm,bd72720
>> +
>> +  reg:
>> +    description:
>> +      I2C slave address.
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  gpio-controller: true
>> +
>> +  "#gpio-cells":
>> +    const: 2
>> +    description: |

// snip

>> +
>> +  rohm,pin-dvs0:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      BD72720 has 4 different OTP options to determine the use of dvs0-pin.
>> +      OTP0 - regulator RUN state control.
>> +      OTP1 - GPI.
>> +      OTP2 - GPO.
>> +      OTP3 - Power sequencer output.
>> +      This property specifies the use of the pin.
>> +    enum:
>> +      - dvs-input
>> +      - gpi
>> +      - gpo
>> +
>> +  rohm,pin-dvs1:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      see rohm,pin-dvs0
>> +    enum:
>> +      - dvs-input
>> +      - gpi
>> +      - gpo
> 
> These 2 could be combined into a single entry in patternProperties.
> 
>> +
>> +  rohm,pin-exten0:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: BD72720 has an OTP option to use exten0-pin for different
>> +      purposes. Set this property accordingly.
>> +    const: gpo
>> +
>> +  rohm,pin-exten1:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: BD72720 has an OTP option to use exten1-pin for different
>> +      purposes. Set this property accordingly.
>> +    const: gpo
> 
> And these 2 also.
> 
>> +
>> +  rohm,pin-fault_b:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: BD72720 has an OTP option to use fault_b-pin for different
>> +      purposes. Set this property accordingly.
>> +    const: gpo
> 
> Seems like different purposes would have more than 1 option.

They do. I only omitted them because I don't think knowing those 
use-cases is relevant for the software. OTOH, maybe they some day can be 
so I will revise the other uses and make more complete list. Thanks.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - "#clock-cells"
>> +  - regulators
>> +  - gpio-controller
>> +  - "#gpio-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/leds/common.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        pmic: pmic@4b {
>> +            compatible = "rohm,bd71828";
>> +            reg = <0x4b>;
> 
> Just 1 complete example in the mfd schema and drop this example.

Hmm? This is the MFD schema, right? :)

Yours,
	-- Matti



