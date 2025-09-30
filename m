Return-Path: <linux-kernel+bounces-836875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B69BAAC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C80189EC62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D2B14A4CC;
	Tue, 30 Sep 2025 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aeTUPpAF"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF17263E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759191613; cv=none; b=dkTImJk62jI62rTuCJPu/dJHzn62hdrychNrfhrWKrqBJL+9Ew6NyiqAdsFMQwmYKuZ+/W6by6d/UZ2JMVkZ246fP6s8c3lGiX0Xfx6WlK6bjS1wOxzd3mt5+ImNiIpXTd9ISlRxRYQG5dp6iJFREp9YaFDcENH+1/OeCTbE8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759191613; c=relaxed/simple;
	bh=bGJExyvnphif6tEqyhuSLem/gtWUtTjLU/NamGZuKDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3SjPpt7463Y954q26f8+CVvGipZnHC4E5MPxFUVCAYZazIhBXxbMjfRTf0xhC+FgA78KCYFj9xyfsyfVmJCRvyLwu7ay0CFrWW8cvTgXcKT9d0dy+JdpfXWOODYSGaXfiVEQGMSKbsPFpvdRzERkvkoihVNTO1oBa1KKR9vWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aeTUPpAF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e29d65728so35889015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759191610; x=1759796410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2aCUV6OLkXwTtwNzSY66MPjJRvAozma0kNGW9LaNrE=;
        b=aeTUPpAFcFjVVztIwRLOygSFFOCICyk1pi+SLaBo1O7Q/0i63V4Aw5JK3qb0qKlofx
         V6+M2hwmLuUAzZ8+I4mHrUK5CLaXDQbwlU7wz6KdP6dV3azxKQ6afoE8L+4TJrVHG3MP
         u84FIxpXONcVMyAf8of45olXaSzkU2pz63Dhi8ROpCQsvHjAoYgCBdkYSisgIgNsbGb2
         QlJwDUzDDD4IcIK7hd5NQjBChwPSOqZEeamDCOUq/lBHdDnK03IlfWWnOMjYM1/eaSrX
         0m4ZmKQXC+hykGUbLSLJUDFjSiqDVTa3RD0kzGHUMoG9ivFj7G6m6BlvZqACrRUqifxF
         XYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759191610; x=1759796410;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2aCUV6OLkXwTtwNzSY66MPjJRvAozma0kNGW9LaNrE=;
        b=q7jVoow4cTWRJ6Aw60nHs7dh/rsW8AYsxiz4MQA0DWBATcYdmW7BIBVhFfgSXEMN8j
         i4pDVyc2PNUNnVnU7V6K83zDham/oIQvbq3bMoIZZWyBN0ncopu5nwmCBuVKV+lLVyfl
         0fzor4rUWUnBJ3IMCdWvC3F/Fw/1Hv6OOlJer+7IRUDzWVeGIR0133Ubm5d8UG8Y8u0q
         rAhlLmtuL7s/7KRrQkZTQNg4hfgjT+FmMos3Bx20Z9okrn6E73+WhZUFYHzp4j75zvHk
         /td+Ysc8u70eBkrcyZbQ775JCz0QW2yHxN+Pt1FEIQlHQXAgeUSZg0pT9/slfG/9FHxq
         /PXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaYV6chBeU6WOtNj08/BRfj6WXEqaUz6MCrmY2c2I5SGKFT9RzlZf6N1r4jyUi2CaUHrjOsICLXWe6Go8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNCo8nXP8gHMK5Y+YoelkUd6F40LLPhDrIJNAkKrsKMhqQ9gSh
	T1bZKF7YlsPDj5XPpHyLejQIopu+cNtydCF8uIwXCgRq3Fnxx1O5t8ZMt01EpCOfhGw=
X-Gm-Gg: ASbGncum1/1G9iufj1MxfYsW5c4YuO1Os5XE3D8C/VyD42EW5g8vwBrtCzPv8tFe17z
	YOy8Zds1hITME8ooruW+WZBTmzHqJ8Wzaz/l1J9Chu3fAP9KGmnhjoKHhXH6hl5lIOP7s77ndD5
	pM8p4GD781flY8rDSymdMss9vSFd2eJ9g1FsxYulPsAnX4iOxT8Nj5OR/LVp4iHOkJUesOwdxso
	ImuGzX5+7L6NJIF2W1ZwGWMa0xqauPbXuQiGrCYYhtLlb8r5ZfQh2OcrTKuSFcE9R73QOgtUmGC
	AGbuP0u2R7CyJ/HuxY0J2E+xB0kl9IuqIbHaRd80ZEfL85Smgv6GhK3ms8inG7sxGk4BGO9z7v2
	mrpLeQICJ5/ctBxBC1KJURW69046DOc1k2VntkSMt0ymNa1N/4i4IbnHY+2fv6wDQ0zYEsRvsDb
	edMCx3/YXrBzBoUc9v4aT79gxc8Il/dOo=
X-Google-Smtp-Source: AGHT+IHXl9KNUIAY5LT7IQhdhWGKaz6kpmbHg2ltlnlV5LX2piwjkJPMXt7gP1unlCKB0JI7t/YWLA==
X-Received: by 2002:a05:600c:8b65:b0:46e:36f8:1eb7 with SMTP id 5b1f17b1804b1-46e36f81fbamr160812465e9.10.1759191609420;
        Mon, 29 Sep 2025 17:20:09 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f3dcacsm33715495e9.2.2025.09.29.17.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 17:20:08 -0700 (PDT)
Message-ID: <1ccec2cd-0290-4804-b274-b3dcb481449e@linaro.org>
Date: Tue, 30 Sep 2025 01:20:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/17] media: dt-bindings: add rockchip rk3568 vicap
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
 linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240220-rk3568-vicap-v11-0-af0eada54e5d@collabora.com>
 <20240220-rk3568-vicap-v11-4-af0eada54e5d@collabora.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20240220-rk3568-vicap-v11-4-af0eada54e5d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/09/2025 16:38, Michael Riesch via B4 Relay wrote:
> From: Michael Riesch <michael.riesch@collabora.com>
> 
> Add documentation for the Rockchip RK3568 Video Capture (VICAP) unit.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
> ---
>   .../bindings/media/rockchip,rk3568-vicap.yaml      | 170 +++++++++++++++++++++
>   MAINTAINERS                                        |   1 +
>   2 files changed, 171 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-vicap.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vicap.yaml
> new file mode 100644
> index 000000000000..99861d236f5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vicap.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/rockchip,rk3568-vicap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3568 Video Capture (VICAP)
> +
> +maintainers:
> +  - Michael Riesch <michael.riesch@collabora.com>
> +
> +description:
> +  The Rockchip RK3568 Video Capture (VICAP) block features a digital video
> +  port (DVP, a parallel video interface) and a MIPI CSI-2 port. It receives
> +  the data from camera sensors, video decoders, or other companion ICs and
> +  transfers it into system main memory by AXI bus.
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3568-vicap
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
> +      - description: DCLK
> +      - description: ICLK
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk
> +      - const: dclk
> +      - const: iclk
> +
> +  iommus:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: ARST
> +      - description: HRST
> +      - description: DRST
> +      - description: PRST
> +      - description: IRST
> +
> +  reset-names:
> +    items:
> +      - const: arst
> +      - const: hrst
> +      - const: drst
> +      - const: prst
> +      - const: irst
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to general register file used for video input block control.
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
> +        description: The digital video port (DVP, a parallel video interface).
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              bus-type:
> +                enum: [5, 6]

I meant to add my nit-pick comment here as I added my RB.

Its not important though.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

