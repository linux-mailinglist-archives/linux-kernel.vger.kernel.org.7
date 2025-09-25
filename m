Return-Path: <linux-kernel+bounces-831688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4442B9D52B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5850F3830C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3A82E62B1;
	Thu, 25 Sep 2025 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avZiLHJm"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F943233134
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758771559; cv=none; b=ihvpz/fZGX7WmHuyerfnaWC0KRXnmEanjxkCNJp9NTZpqxOF8r6mOTPNcaPqa9O1KQhdlY1IoeKh8RAPGyzckQ9CLecVw1MSeDTjjEGhFLArTZC/penR/ShO0sDfbQC4LJ07p9dUawLpsh44M6bWq31hnaWHs8LIUhnFoohYRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758771559; c=relaxed/simple;
	bh=gBPWkNFjdMQE8rx2St2Cxhve3tgGKE50NAP2JhU7zkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc/kLPvgIEt+p3jo8x+I4z4vSsBWCyDNx6BPpXIYAXIi9eKT4Un2LNC3Dhowjk4X9tHhMx+jO8pIN38fHPQd9JlVv7ubwjI2Ie7MQd4ruRIKNVgL4ifJDoI4znAYoepc0Q6rUlRC/f/6gI9OrHDfjvQVfVIUrN2YX4oKz8EZOU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avZiLHJm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f169d8153so599996b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758771557; x=1759376357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQlHV/LeA8zP8BB0iU6hiP/ahF2MMcZ9HvPXMFvYOqo=;
        b=avZiLHJm79MbudNol9kHinWx3c+L/msP1MrGBZGtf2WjWwvrXgUEuvabYFAbZjPSj4
         MVlAIMzYdPJH3om999VmM74brZy7LTmDmx/Ma5J6dclCs11ByNmxqGvxRTSyzdeFqfek
         ejk8oJHbyJkWCWmEKHqEVK7k/qnOC4gy8f2Scct3PkRuBcmOrC9ZPoa5ygEs6VeeQpfs
         JF2NiK7sLzhRk6KR25JruGgOfDQtAVYGerjO9+de7KD4plfL7dfTvPNaftzPMv5+hRVH
         91HgxBBMEnw/mU0L3v/G3pt7nDlAjz2bUu449UJ5Bk1jKdY4hiKDDdMwzcq5XJPZR5Ad
         5Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758771557; x=1759376357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQlHV/LeA8zP8BB0iU6hiP/ahF2MMcZ9HvPXMFvYOqo=;
        b=Rd0QPzttEOxkZRGLw98ZQbvybTMGm8u6Cj0L3ceQidigo4MWLU0yDVGFxeumM5IFYV
         hY3Tv2yUl0aqZEUOpaaBWRCSWk3kH0n1ZxifmtnlkIufjhJuhhECR3aZcSveQ3YYrgWx
         EtiFQQPpCcyO8iFzkYF46CTaXwup0mSzHPph2lm4kDcrfyzMpNfY9/h+gppaMVjKD8U8
         d9xtX7uLWSCmE+cXULwTA/A8ePZ5XdHQkzXOfI9M/0g2+94frzqY3EXn1uHY6zHPhOO7
         JkK9UFWugxEoD2HdfL64g4hGBx2YGk4oZiKs/tMk2hCwk9CcwgYprptWKJILw6j9V72M
         bLFw==
X-Forwarded-Encrypted: i=1; AJvYcCWbRGx75wujZqW3i8qmWMY1ZJ+IPFg7poPvWueoWT4g6lEXRbF688GCy5Vd2f4Ltmg4fLPbYjOCBVTjCJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwILrMsj2ZO2MiC9aK5CRFvsV5lior4vxT5Ar3qJ1zxo/7M0utN
	G0vQUv2pOrwPIzg+vxyxxet0jW8miOUF0qxeMq+SR4hsrJaZ/Fyr/KXV
X-Gm-Gg: ASbGncutWVUrxb73B2cfVBrhP6do8nM8LKHgdSTWGulnbC5h/4Lv7P8bhm+xezhMOS2
	zmNLiF6I4Ym/GwW/mBLX331zRNLiw/CDg/dY9p0CBe0GNsENTxrjBztnzCD0P2WuszYTjTG7r7H
	cduhzFNtKWHry/mGGkaH033dXoLVhDa1znW6yQ78hObKvZi2JcV+d0k0cMC/wtBSYXQTr+rdSeI
	UZsO8PYFSvugavLVWnBw3HycALREuEGtQkFSh8Ui4hxyliDFGfeZr4wijPDiOxwlVVzWH85+4aF
	KmeJcANLXsjygKbCtR77mKfrkuZzVY8ax5lg47abLVal7pGAh9YHpY4Sld6jW7BZD2FonLnIbdL
	bnECy1GTsP0joMiyUMTbiR4pnSLJFFS3+98OFPRcLnA==
X-Google-Smtp-Source: AGHT+IEdkFvVbxoA7GFliYOsJ4pCAsy6bdrcfcexouLuoLDLtxCPYRQvWRRpt1KbJ7IscFaYe+dvwg==
X-Received: by 2002:a05:6a21:99aa:b0:2b7:949d:63e9 with SMTP id adf61e73a8af0-2e7be809954mr2350343637.7.1758771557487;
        Wed, 24 Sep 2025 20:39:17 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3341bda12eesm3952578a91.7.2025.09.24.20.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:39:16 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:40:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux@roeck-us.net, rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com, michal.simek@amd.com,
	grantpeltier93@gmail.com, farouk.bouabid@cherry.de
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: add binding for mpl3115
Message-ID: <aNS5lGpv6ezZ8HpZ@debian-BULLSEYE-live-builder-AMD64>
References: <20250921133327.123726-1-apokusinski01@gmail.com>
 <20250921133327.123726-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921133327.123726-2-apokusinski01@gmail.com>

Hi Antoni,

Some inline suggestions for making this binding better comply with the
'attempt to make bindings complete' guideline.

On 09/21, Antoni Pokusinski wrote:
> MPL3115 is an I2C pressure and temperature sensor. It features 2
> interrupt lines which can be configured to indicate events such as data
> ready or pressure/temperature threshold reached.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
...
> +description: |
> +  MPL3115 is a pressure/altitude and temperature sensor with I2C interface.
> +  It features two programmable interrupt lines which indicate events such as
> +  data ready or pressure/temperature threshold reached.
> +  https://www.nxp.com/docs/en/data-sheet/MPL3115A2.pdf
> +
> +properties:
> +  compatible:
> +    const: fsl,mpl3115
> +
> +  reg:
> +    maxItems: 1

For completeness, could also add the power supplies.

  vdd-supply: true

  vddio-supply: true

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
> +  drive-open-drain:
> +    type: boolean
> +    description:
> +      set if the specified interrupt pins should be configured as
> +      open drain. If not set, defaults to push-pull.
> +
> +required:
> +  - compatible
> +  - reg
  - vdd-supply
  - vddio-supply

and also add the supplies to the example below.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pressure@60 {
> +            compatible = "fsl,mpl3115";
> +            reg = <0x60>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "INT2";
> +        };
> +    };

Best regards,
Marcelo

