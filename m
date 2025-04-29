Return-Path: <linux-kernel+bounces-625580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843FFAA18D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 20:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085DF1BC79E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8632522AB;
	Tue, 29 Apr 2025 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="Fxwj7p23"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D040C03
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949862; cv=none; b=NZKXtngKsIj4RlHhA9zsjjq49c9vUBdzvyzXgq+dwoRSIkbuJMGPfCvKfVDcE80nbO8fHcG5EHVAPraAWfI55wq+9UxU5P4UFKqE6iPhk9YTsvbW0pgkaHA3rejB4/4qIGHsgxSMml5gFPJ+ueQMwLH2dSUrkBjNKPW97UXvKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949862; c=relaxed/simple;
	bh=rAks88TKI5UJtVnpuF6h5jVqqQnNM42d6RJm/OLQMxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqVJPSffcvJ2u8bncsQB+bbzVqM2dAPMK2lD9sa7vdeiyFswHVzr34gsYpJ1zKbGrQwcICLM328JzbkfM+OXrpKQmeTd4mo/zYxNQkoySIkPnw0S/Gim6wzcDq/oE0+gwvIdmEd454ZAustlkhnTJ1TJDNoLXOKKoLWDTKZogB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=Fxwj7p23; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7394945d37eso5536550b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1745949859; x=1746554659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TF5zvq+dwouurJsmOFisci0GfULvxMNmW9FvbbMePLQ=;
        b=Fxwj7p23ujTAx41E8ObrcpbBLq0sL7mfPhtS7srtaHqgpWTdFUgQKU6vBVFiU2xX4V
         q0IEPH4CfjGYXgdMYdvSTnqBU2dV8NpfvgYkbiqhSMcZf1Mb9oD5/lVEL5MDS+UUMOMu
         XeLBtNaiJJ9CZydsV1OPnSBMHoDxuCDOPGpd87s1wLeJx7KP2pHHykhX7hWOUz6KTQNA
         ude5FjEbhrWmQb5vb5GgfgyOiHMPJp7oW+GLotarH8W6U1f121/xR3LkeGLp2KkekyC9
         3sbD1KFMlVXAmbbliIE3xarT4tXL9ipAYk03Kg2393V1pGChPPOu6URPuSWJ3zwQ41e8
         QiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949859; x=1746554659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TF5zvq+dwouurJsmOFisci0GfULvxMNmW9FvbbMePLQ=;
        b=HukyPttyOqCASPZ9dy2J1KuxkkhnHdfnJTOCD57d7pDdqtb60rxBH4m4YrMBVislP5
         cF05DQ9g51Z+B2+ax1xt+j5HfWPDFX6xFgnKzqilC6WNchGpwbMBsqodyezUtS7+v9Um
         mLG5EAm2OCssJ81TACTPZH6bDA6w8EDohDnOE3L2Ask3oIy3JZhvpbet0UZ9/aJUkO5/
         /E8A8OgCfHCftJoCXbb8MSglbyNSPebFY/L6Y06bPwTvY9h/vK9Wn7ny+4PJq/zmkYt8
         tBjWvUO6BVw6WFp5SvoVawZEGsFMoo1zFBLJSf4akX6sJmke2Srbb+rQSr2dlNZzLUHA
         h0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGrPL3Ay545E7pc8vJRTRW82svLiC4Q5ZxUUJgaWOQ+yE+kCOfvTDSxTMjWxXnjN1PanhcJLngcdqebBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XxcVy+7FrrWpMxRAn5jRgA96NUq9hCIZiYRtOPNptfpHvOmN
	w5+q2DR1lOWrIHFTuUkOh8OeH7H9C1Kfncp3Z40fZtmVDhEZ98VUs9hOE4mHig==
X-Gm-Gg: ASbGncuTyQjAo43rDAqkLzePLFnXBTSFt1VHlQOHNuG7oxFY95gzVmqOmFCZSwfrh7y
	OFAxdoU56tpyjzp8wQNGH11/Tav+9XssDatZ0PCwtXDSk6Hx7XwGdjW3kIYs0YXJSOG7E/hjhyq
	fU/yHosByj5otbfpC792YpcrjxfL+zWHEHD0w+WNq6FnRL4qFsYHYCkNwO/1u2jU2GbmJwR40Tl
	+D1lG85KmImEj3XN+FCNEeGBnUmg26DBFH/9alCZhdR7TXkeQTyRyUwFZDWwNvXMLbJRwEIIAyj
	sKGWWJ7GFNxcgp4QIJD3vDJ71gXteC3fnOeBUoc4WIvxP/FyM/Sgig3zXQ==
X-Google-Smtp-Source: AGHT+IH6MS3bZbEKvU9ZIkPz0etq8wy02LqJGtPPuVrhlRpUYewJVc/Smzwo8DIrS9bHhVaeokgm0A==
X-Received: by 2002:a05:6a20:9d93:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-2046a3abe8amr17646432637.3.1745949859182;
        Tue, 29 Apr 2025 11:04:19 -0700 (PDT)
Received: from [172.16.116.85] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f76f580asm7724722a12.2.2025.04.29.11.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 11:04:18 -0700 (PDT)
Message-ID: <6afe226c-4bf4-48be-84be-034261914ee5@beagleboard.org>
Date: Tue, 29 Apr 2025 23:34:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] schemas: i2c: Introduce I2C bus extensions
To: Herve Codina <herve.codina@bootlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250401081041.114333-1-herve.codina@bootlin.com>
 <20250401081041.114333-3-herve.codina@bootlin.com>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20250401081041.114333-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/25 13:40, Herve Codina wrote:

> An I2C bus can be wired to the connector and allows an add-on board to
> connect additional I2C devices to this bus.
>
> Those additional I2C devices could be described as sub-nodes of the I2C
> bus controller node however for hotplug connectors described via device
> tree overlays there is additional level of indirection, which is needed
> to decouple the overlay and the base tree:
>
>    --- base device tree ---
>
>    i2c1: i2c@abcd0000 {
>        compatible = "xyz,i2c-ctrl";
>        i2c-bus-extension@0 {
>            i2c-bus = <&i2c_ctrl>;
>        };
>        ...
>    };
>
>    i2c5: i2c@cafe0000 {
>        compatible = "xyz,i2c-ctrl";
>        i2c-bus-extension@0 {
>            i2c-bus = <&i2c-sensors>;
>        };
>        ...
>    };
>
>    connector {
>        i2c_ctrl: i2c-ctrl {
>            i2c-parent = <&i2c1>;
>            #address-cells = <1>;
>            #size-cells = <0>;
>        };
>
>        i2c-sensors {
>            i2c-parent = <&i2c5>;
>            #address-cells = <1>;
>            #size-cells = <0>;
>        };
>    };
>
>    --- device tree overlay ---
>
>    ...
>    // This node will overlay on the i2c-ctrl node of the base tree
>    i2c-ctrl {
>        eeprom@50 { compatible = "atmel,24c64"; ... };
>    };
>    ...
>
>    --- resulting device tree ---
>
>    i2c1: i2c@abcd0000 {
>        compatible = "xyz,i2c-ctrl";
>        i2c-bus-extension@0 {
>            i2c-bus = <&i2c_ctrl>;
>        };
>        ...
>    };
>
>    i2c5: i2c@cafe0000 {
>        compatible = "xyz,i2c-ctrl";
>        i2c-bus-extension@0 {
>            i2c-bus = <&i2c-sensors>;
>        };
>        ...
>    };
>
>    connector {
>        i2c-ctrl {
>            i2c-parent = <&i2c1>;
>            #address-cells = <1>;
>            #size-cells = <0>;
>
>            eeprom@50 { compatible = "atmel,24c64"; ... };
>        };
>
>        i2c-sensors {
>            i2c-parent = <&i2c5>;
>            #address-cells = <1>;
>            #size-cells = <0>;
>        };
>    };
>
> Here i2c-ctrl (same goes for i2c-sensors) represent the part of I2C bus
> that is on the hot-pluggable add-on. On hot-plugging it will physically
> connect to the I2C adapter on the base board. Let's call the 'i2c-ctrl'
> node an "extension node".
>
> In order to decouple the overlay from the base tree, the I2C adapter
> (i2c@abcd0000) and the extension node (i2c-ctrl) are separate nodes.
>
> The extension node is linked to the I2C bus controller in two ways. The
> first one with the i2c-bus-extension available in I2C controller
> sub-node and the second one with the i2c-parent property available in
> the extension node itself.
>
> The purpose of those two links is to provide the link in both direction
> from the I2C controller to the I2C extension and from the I2C extension
> to the I2C controller.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>   dtschema/schemas/i2c/i2c-controller.yaml | 67 ++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
>
> diff --git a/dtschema/schemas/i2c/i2c-controller.yaml b/dtschema/schemas/i2c/i2c-controller.yaml
> index 018d266..509b581 100644
> --- a/dtschema/schemas/i2c/i2c-controller.yaml
> +++ b/dtschema/schemas/i2c/i2c-controller.yaml
> @@ -30,6 +30,13 @@ properties:
>       minimum: 1
>       maximum: 5000000
>   
> +  i2c-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      In case of an I2C bus extension, reference to the I2C bus controller
> +      this extension is connected to. In other word, reference the I2C bus
> +      controller on the fixed side that drives the bus extension.
> +
>     i2c-scl-falling-time-ns:
>       description:
>         Number of nanoseconds the SCL signal takes to fall; t(f) in the I2C
> @@ -159,6 +166,25 @@ allOf:
>           - i2c-scl-has-clk-low-timeout
>   
>   patternProperties:
> +  'i2c-bus-extension@[0-9a-f]+$':
> +    type: object
> +    description:
> +      An I2C bus extension connected to an I2C bus. Those extensions allow to
> +      decouple I2C busses when they are wired to connectors.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      i2c-bus:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description:
> +          Reference to the extension bus.
> +
> +    required:
> +      - reg
> +      - i2c-bus
> +
>     '@[0-9a-f]+$':
>       type: object
>   
> @@ -221,3 +247,44 @@ dependentRequired:
>     i2c-digital-filter-width-ns: [ i2c-digital-filter ]
>   
>   additionalProperties: true
> +
> +examples:
> +  # I2C bus extension example involving an I2C bus controller and a connector.
> +  #
> +  #  +--------------+     +-------------+     +-------------+
> +  #  | i2c@abcd0000 |     |  Connector  |     | Addon board |
> +  #  |    (i2c1)    +-----+ (i2c-addon) +-----+ (device@10) |
> +  #  |              |     |             |     |             |
> +  #  +--------------+     +-------------+     +-------------+
> +  #
> +  # The i2c1 I2C bus is wired from a I2C controller to a connector. It is
> +  # identified at connector level as i2c-addon bus.
> +  # An addon board can be connected to this connector and connects a device
> +  # (device@10) to this i2c-addon extension bus.
> +  - |
> +    i2c1: i2c@abcd0000 {
> +        compatible = "xyz,i2c-ctrl";
> +        reg = <0xabcd0000 0x100>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        i2c-bus-extension@0 {
> +            reg = <0>;
> +            i2c-bus = <&i2c_addon>;
> +        };
> +    };
> +
> +    connector {
> +        i2c_addon: i2c-addon {
> +            i2c-parent = <&i2c1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            device@10 {
> +                compatible = "xyz,foo";
> +                reg = <0x10>;
> +            };
> +        };
> +    };
> +
> +...


Reviewed-by: Ayush Singh <ayush@beagleboard.org>


