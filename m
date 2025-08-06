Return-Path: <linux-kernel+bounces-757942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D983FB1C89A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B151118C3705
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B028FFDA;
	Wed,  6 Aug 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="P+7dfSRW"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00708634;
	Wed,  6 Aug 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493765; cv=none; b=QmjiNMHKFWzSoN8a2TQCt0DUnVydw7krvvhmN+lXDOzrfsKkstAFfqMFcLkXg/uZMtHS5XR/iJKAZ+WHxe18V365Jh6+nytzwGbbY/8zN3LNv46nhHW379693/U59mPqVzDfBrM4V12klAg0ge8filX+EJU9wHSU34oU7ZPAiWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493765; c=relaxed/simple;
	bh=06Mcj2GVE1YkEZdSmKYte3+tEomoMneuSz4WIM6kBC4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=X8ovT60TQQRD1reWkkzWsARSDM5bGW0zRwSUIWYel/qNMec66Kr2ZQfLPV/k3XxaUqb8hJJWD7Gepr0rl400IpnCLTgpefr3a6jmJC8eZ2FR+qGSOJtOyzZnoFO76Bw/x2HsFYkCYoOKmt34YmOYGJIjAFtnzv6V6flEEYE1oDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=P+7dfSRW; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2CFF1206A5;
	Wed,  6 Aug 2025 17:22:33 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vjs5PDVGcX1W; Wed,  6 Aug 2025 17:22:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754493752; bh=06Mcj2GVE1YkEZdSmKYte3+tEomoMneuSz4WIM6kBC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P+7dfSRWqkaK418eicsL1z4mQXT7S9DXjupPvbGJm0AVNhgLBz8hU1mkzNfhiZHL9
	 2+3oVIv0lUfLexjuR3oSLlLDPE8rTB2B2sQ2nUzHS3d//KvQ/YHFKMnrI7H5GfPOH4
	 5vPZDZ92YzFR0mmz3p7ip7/lsrdh619aQ36RfvKQZxJsAB684kBv6NLx0Z9B9yHuBp
	 SUWKIQsU1mg2bEJhvzBJZd5E4Zm0g51IPCrMPT3pRHpo4yENcKsnyGPbbR98F1iTxz
	 2VvOmozDDdOvynuNmDfpjn3wSQtI1gJhQ9t8i4OlOQQhksZWpfB13QCvaS4Ucjc5kT
	 qNCppk543pADQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 06 Aug 2025 15:22:32 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang
 <jessica.zhang@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: document Synaptics
 TDDI panel
In-Reply-To: <7rk5cgjiublkrczl6khkjepixppbatee25w6gc5utfvrcl45o7@6oouraafet2f>
References: <20250720-panel-synaptics-tddi-v3-0-43a5957f4b24@disroot.org>
 <20250720-panel-synaptics-tddi-v3-1-43a5957f4b24@disroot.org>
 <7rk5cgjiublkrczl6khkjepixppbatee25w6gc5utfvrcl45o7@6oouraafet2f>
Message-ID: <7f3098a04a6c709a5fff5869046512e5@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-03 12:02, Dmitry Baryshkov wrote:
> On Sun, Jul 20, 2025 at 05:31:54PM +0530, Kaustabh Chakraborty wrote:
>> Document the Synaptics TDDI (Touch/Display Integration) panel 
>> hardware.
>> Along with the MIPI-DSI panel, these devices also have an in-built LED
>> backlight device and a touchscreen, all packed together in a single 
>> chip.
>> 
>> Also, add compatibles for supported panels - TD4101 and TD4300. Both
>> have the '-panel' suffix so as to remove any ambiguity between the 
>> panel
>> and touchscreen chips.
>> 
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>  .../display/panel/synaptics,td4300-panel.yaml      | 89 
>> ++++++++++++++++++++++
>>  1 file changed, 89 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/display/panel/synaptics,td4300-panel.yaml 
>> b/Documentation/devicetree/bindings/display/panel/synaptics,td4300-panel.yaml
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..152d94367130e9d80a885fe87a2da53db88e3393
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/display/panel/synaptics,td4300-panel.yaml
>> @@ -0,0 +1,89 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: 
>> http://devicetree.org/schemas/display/panel/synaptics,td4300-panel.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Synaptics TDDI Display Panel Controller
>> +
>> +maintainers:
>> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - syna,td4101-panel
>> +      - syna,td4300-panel
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vio-supply:
>> +    description: core I/O voltage supply
>> +
>> +  vsn-supply:
>> +    description: negative voltage supply for analog circuits
>> +
>> +  vsp-supply:
>> +    description: positive voltage supply for analog circuits
>> +
>> +  backlight-gpios:
>> +    maxItems: 1
>> +    description: backlight enable GPIO
>> +
>> +  reset-gpios: true
>> +  width-mm: true
>> +  height-mm: true
>> +  panel-timing: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - width-mm
>> +  - height-mm
>> +  - panel-timing
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    dsi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        panel@0 {
>> +            compatible = "syna,td4300-panel";
>> +            reg = <0>;
>> +
>> +            vio-supply = <&panel_vio_reg>;
>> +            vsn-supply = <&panel_vsn_reg>;
>> +            vsp-supply = <&panel_vsp_reg>;
>> +
>> +            backlight-gpios = <&gpd3 5 GPIO_ACTIVE_LOW>;
>> +            reset-gpios = <&gpd3 4 GPIO_ACTIVE_LOW>;
>> +
>> +            width-mm = <68>;
>> +            height-mm = <121>;
>> +
>> +            panel-timing {
> 
> Are the timings defined by the 'TD4300' name or might there be 
> different
> panels with the same name but different timings?

Yes, if I recall correctly, the same panel was used by some Huawei 
phones
with different panel timings. So this is just future-proofing.

> 
>> +                clock-frequency = <144389520>;
>> +
>> +                hactive = <1080>;
>> +                hsync-len = <4>;
>> +                hfront-porch = <120>;
>> +                hback-porch = <32>;
>> +
>> +                vactive = <1920>;
>> +                vsync-len = <2>;
>> +                vfront-porch = <21>;
>> +                vback-porch = <4>;
>> +            };
>> +        };
>> +    };
>> +
>> +...
>> 
>> --
>> 2.50.0
>> 
> 
> --
> With best wishes
> Dmitry

