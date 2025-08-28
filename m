Return-Path: <linux-kernel+bounces-790048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2227AB39EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F5E1C83B64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E81313E02;
	Thu, 28 Aug 2025 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgM2fblx"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FA31196C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387327; cv=none; b=ZjyL3O95If7yYXSCXZ8+JEe8PPg7jYDSmWG8pVJX0GDu0aFDhKBm6581AKQGYZj574zC5fN6moFhPtnXs1mGOvVeQk/x9ICYXPaeIR+U9mBLw4+4K4s6+vg3yqG+RUIrOWxNYFq1q+emCC1lo7+79qbLNjtS8PIth2dt+JWHt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387327; c=relaxed/simple;
	bh=jh74Bm9FuYTHqI0n6vq3i4l68ZMyCp1NQ4+AezIBvsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=el3u1ihtcPzpRwSZOxPPi+sMPsZtHkRoofQzcKm9/X6L8vbZi9doCIBx4CkDU8qYLNaLV/3OYDGTWfwOc6SV8bArsN1e0fxXG21qtVMWiWKqMRSaC1MO7pxBKMvi9rhpgZ8lArJnrGp/k2ZOZsYYAxmEnSlzlzv8SJJASMS8Etk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pgM2fblx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb73394b4so135417666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756387324; x=1756992124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vejRaEijRO8+CORhQowxHuuY85LG5Du7ZSdJ6Jjs0g=;
        b=pgM2fblxgg5vEKG5kWw5ti6/0oDeJ0/4cmG+qLWn9ygVjZBVXPEcBgmERxzqPWp2jb
         jdfL7PxpR1kCt84llzptVYArXvce7Ofqv3E2G5tKVhoZv9n0FB0wHr0SuFPpEwl+n5at
         ERQ2UMYwSH8JMvwc+rgk/6N5R+NZP1ChfmWvY/+WIHkoveCnWgw2KZuNlMnDTDnoZw1A
         nky8jJo19dVSLCUrY4Wh4wtGFHX6uDLcF6SrS/A/IKykXutQl4iGmyVC7WA9+i+zqU7G
         ZNpuI6kmhDqDWh8WjsFtT1v3/Fnad8jUjJQn3bqQJX5+LfBOOvleDsM4eC0DNyWcevH1
         p4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387324; x=1756992124;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vejRaEijRO8+CORhQowxHuuY85LG5Du7ZSdJ6Jjs0g=;
        b=vu8I7WiVkIC8hiH/SV4I39sGuHatCfbNAqo1r/+HPItF4b7EiiP3dSOM0KdtqwZ/74
         bRt9XOP0v+DiaDFQmH5Z/4nMMwrDyewb6w5OWslkOAkC1oeoHrCUOJei4U9OeT/wiei3
         BPYzxCPPpTlOvgwrzEFAiZeMLYD0V8yXPFgW4v1k7WwDwweN6YJX1EFA+xNhraaU4C6F
         3VfvEs5prLKdLRCzkmqZGqzkPWEfd2+tzWF9qdYNqKm9tFsdi6mUtAhCQJUqHxJkd10K
         4VwMQuJxKRfqO4Qfc8CoJSTfcHgGFiycbBhu+io6VnTRjbrxWAAZsIgaHjhHdjSYuW5h
         gQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgd+6GrfzPE4P4xncmVC85mWtwzVfJuDJkH+VkG81/k2wHUho1q07pzmQ9jXvA/4OGTdUSR0iqk9GUu1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1JTC1J/sHtk1AriPaZbIEL/gtQpAZObYscvra4LJhCCgidsqJ
	aCsLkuZ49klPeV2BGchuaiUypZYY325wGIC1OBt6/L0ddy77tFbqZ19cj11tvJ0lAts=
X-Gm-Gg: ASbGnct1F8olMSovx3h7VFGiHU0xyR3I917dyZWx7Ua9AZ/z0zRQlE/R0nfiM7PwYqd
	8XoMjqT/Jq/fYTv3II8zhfk+mXAc45xZeFFtDnXtjUhjNTsQJn2xSgU13I348iIs0v4nFvj7Tga
	IMdS9Jm8nFxmfBZn21WK5mgyYSMNf4TkIHc2BNlA8euO5iVePmK1WbyqkKiQBuI5OGHraT6fid+
	j66ZwPkxf3YoS1Oo+AIAGf/T+j9SynxgLe++ECKQCHG6tdB6nHws6Miwql/kTUbzBwkOIsKWTMd
	UtW693MFcYsw21FDwvakq80d9LfT7eOi/mXuEd6vfRoVPNNlt4lrnIMWW6GDNmxIf+/E/WUVlMO
	VOcPI8QvDHx+uNH42zVNH/TnX+hIauTiL6kvczXpCBhB7G3aHg9HK/9hHKGJcpu6C7lU3wTD7Ba
	jTKQ==
X-Google-Smtp-Source: AGHT+IEydpmL/CGGlYRxIOHwyq2SzsRVG+uSKGaJVOpWYTkFto5PXtB9f5EDZvVuQAcMg4VMfo+bpw==
X-Received: by 2002:a17:906:398f:b0:afe:b7b5:555a with SMTP id a640c23a62f3a-afeb7b56482mr637165366b.63.1756387323855;
        Thu, 28 Aug 2025 06:22:03 -0700 (PDT)
Received: from [10.41.150.230] ([77.241.232.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe849d7e6bsm850780866b.61.2025.08.28.06.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:22:03 -0700 (PDT)
Message-ID: <45fa25b0-076e-4df5-a3e3-118b1034c71b@linaro.org>
Date: Thu, 28 Aug 2025 15:22:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/13] media: dt-bindings: add rockchip px30 vip
To: michael.riesch@collabora.com, Mehdi Djait <mehdi.djait@linux.intel.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Gerald Loacker <gerald.loacker@wolfvision.net>,
 Markus Elfring <Markus.Elfring@web.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Collabora Kernel Team <kernel@collabora.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Alexander Shiyan <eagle.alexander923@gmail.com>,
 Val Packett <val@packett.cool>, Rob Herring <robh@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Mehdi Djait <mehdi.djait@bootlin.com>
References: <20240220-rk3568-vicap-v10-0-62d8a7b209b4@collabora.com>
 <20240220-rk3568-vicap-v10-3-62d8a7b209b4@collabora.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20240220-rk3568-vicap-v10-3-62d8a7b209b4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2025 01:25, Michael Riesch via B4 Relay wrote:
> From: Mehdi Djait <mehdi.djait@bootlin.com>
> 
> Add documentation for the Rockchip PX30 Video Input Processor (VIP).
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> [revised description]
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
> ---
>   .../bindings/media/rockchip,px30-vip.yaml          | 122 +++++++++++++++++++++
>   MAINTAINERS                                        |   1 +
>   2 files changed, 123 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> new file mode 100644
> index 000000000000..9f7ab6965636
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/rockchip,px30-vip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip PX30 Video Input Processor (VIP)
> +
> +maintainers:
> +  - Mehdi Djait <mehdi.djait@linux.intel.com>
> +  - Michael Riesch <michael.riesch@collabora.com>
> +
> +description:
> +  The Rockchip PX30 Video Input Processor (VIP) receives the data from a camera
> +  sensor or CCIR656 encoder and transfers it into system main memory by AXI bus.
> +
> +properties:
> +  compatible:
> +    const: rockchip,px30-vip
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: ACLK
> +      - description: HCLK
> +      - description: PCLK
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk
> +      - const: pclk
> +
> +  resets:
> +    items:
> +      - description: AXI
> +      - description: AHB
> +      - description: PCLK IN
> +
> +  reset-names:
> +    items:
> +      - const: axi
> +      - const: ahb
> +      - const: pclkin
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: input port on the parallel interface
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              bus-type:
> +                enum: [5, 6]
> +
> +            required:
> +              - bus-type
> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/px30-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/media/video-interfaces.h>
> +    #include <dt-bindings/power/px30-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        video-capture@ff490000 {
> +            compatible = "rockchip,px30-vip";
> +            reg = <0x0 0xff490000 0x0 0x200>;
> +            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
> +            clock-names = "aclk", "hclk", "pclk";
> +            power-domains = <&power PX30_PD_VI>;
> +            resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
> +            reset-names = "axi", "ahb", "pclkin";
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +
> +                    cif_in: endpoint {
> +                        remote-endpoint = <&tw9900_out>;
> +                        bus-type = <MEDIA_BUS_TYPE_BT656>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d2adf483426..356679cfdcaa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21768,6 +21768,7 @@ M:	Michael Riesch <michael.riesch@collabora.com>
>   L:	linux-media@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/admin-guide/media/rkcif*
> +F:	Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
>   
>   ROCKCHIP CRYPTO DRIVERS
>   M:	Corentin Labbe <clabbe@baylibre.com>
> 

I think your example could use with some newlines per dtsi files in real 
life, i.e. newline after the reg as an example.

Other than that this looks fine to me, please consider incorporating.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

