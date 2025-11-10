Return-Path: <linux-kernel+bounces-893171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E2CC46B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487F91885569
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B7F30F93B;
	Mon, 10 Nov 2025 12:49:52 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF430E857
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778991; cv=none; b=t57Jv3Vsb+yxG5VqrckCdpIXXR3hR7H4G70qU2qy88QT0ceLEWZ6BgX90TtE848Ap+JF8ZahC35mVcqqz2Mei+KZUWylrVcHC/PIM06iYwVBMJdYsYJB/PAy6j0cmpSJ0IF/DOD2NdTkvB1Zw2E8S/dXgGfKoG6Pb4KIpNjVPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778991; c=relaxed/simple;
	bh=cAw6KDVicFMiZpuDduunfg3+w/yg4gN+HRNZWYDOi/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCK+K5AAhyGkb9zaSyetAbHUxhS/eoePpXIxNDTATbqY1tlTWSVEazeSGZjXm9xVck2YgCltL6xAN1J4hB+UzDByXW08wGjTSJBXm/hhJSsbpt/OBxiWZNDbv8vbqbT8qZPEME3fNrJHDILABv+mxMHO6lKfq3aHB0RYBJZfi0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93526e2842dso663459241.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778989; x=1763383789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh17CiieclZAsVeAhUA/WaKqsZ8PVmhh++ya3iPI2Ik=;
        b=nxuz4CCfR97YgrtMtkoOTbscJ/j+ugTD+IzyncNJesCBangJpoNB3iT57Kv7dgX0dD
         ubodlnCijm32BC33r6XO3TYta9F9DEW2FNKDBG9gJIhkrfYohi6h66eyQq7VdyqSt8BI
         8WV/iJXoZH/8MtbsZCaT0aFZDUCaoae/PLrUPc3Yq7rCu6NRbevuU2nCsoj9lJuweG/2
         RVHyJpPgKS8GuO2x+Zl26WCwrk18tvueUyLSng+qSItQK+wmgaBKdhRJLfiXn1wz/aWW
         XD+VktLHEHp+jmSoGXdvpRs/VI9kIwjwbe6/b+Xg5SwLDc6mxJhV5PyOgDS9FVXDmpb/
         Jzzg==
X-Forwarded-Encrypted: i=1; AJvYcCWwWreI095jHrUwiNofiKcpUh1BQvdgcPLR7sgjdXPv6R2HTUXgx+mVMkkH32fecq7dE4KM4NZWzD0yk24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5K7d35S44HdR2mZ2+1qKHV/H7SgqPBZdc7ZxmydjioQLR9xo
	ERC+vMzwcXX2rsfCrcI0Rt1rN88rGrYuKKyYQqO4XGz98InL1lpFBNLhXCMYm2f7
X-Gm-Gg: ASbGncv7Piyg2uYrgvAqcihB/0dSVjYzLCA5WbgckGSBKveaP8IA8GG42Z9/nNEOcMo
	3VRfXAx8fkRah8uFGfE0bgQHKDtVQ+0Jj6+jwjrCEP2x6TV9HshLnXSPdWJyvUxWm+1G0X7Tm//
	cZxp4K4KgiDzo1j0D3o/86xGW+jh/BXNasowZS7pE3UsosWpf+vKMhKAfpC0KI7RF+BmN1f5DOi
	oPsi7mOYGh0dlEbDerKfamGiASvoANgDOUGcFPaqzqzRHATtTL1HY4Ko8ZWeu6DLeGk02b5g5Ku
	hbdYXT0BN7ThORKgGAZQdewbxcwB9b45FzqdUiHrQca2nUKCHzSxoA46tF9BCnK/1JR0ZjtfLJP
	SqcVR5sAp1kMdRv16CIH4Si2KVKSFNrAZ8mYehaMMxlMj63EaHoN6PLJX2IMLP2v9mYNbp71TZg
	wHxF/Vbv2yFo+0BMZkqC3mbWeH/e5+prqV8Pd4KYYWiLWYgGWD
X-Google-Smtp-Source: AGHT+IGegd91VATXRHMNbxFF0L+FXxIEOECfjGag11NxkYSExV874Ne0Q5VerPKNsonurX3J/YYZgg==
X-Received: by 2002:a05:6102:dce:b0:5db:e338:ba18 with SMTP id ada2fe7eead31-5ddc4839d63mr2333771137.37.1762778988891;
        Mon, 10 Nov 2025 04:49:48 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda205c0efsm5686259137.13.2025.11.10.04.49.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 04:49:47 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-93720fd0723so614857241.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:49:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWF2cxkabbocUMKW76UaLA1o+b+R/Q2WF5JArG2WOQx98D6GJbhvLzdvyI5//oOa6fLuKzOLl73yAoLJkY=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0a:b0:5db:f352:afbd with SMTP id
 ada2fe7eead31-5ddc467ebffmr2222725137.3.1762778986813; Mon, 10 Nov 2025
 04:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251105104151.1489281-12-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251105104151.1489281-12-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 13:49:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWTH_uuQURgqQrg1RGDMwzdDAWFk__mS9+Gc8mcESfUyA@mail.gmail.com>
X-Gm-Features: AWmQ_bkfRzk8FN2qNNCBLlLG0XaTRUdRgwFG7IJoHivC4Q2Ld9wLwHCuz85ymR8
Message-ID: <CAMuHMdWTH_uuQURgqQrg1RGDMwzdDAWFk__mS9+Gc8mcESfUyA@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] dt-bindings: spi: renesas,rzv2h-rspi: document
 RZ/T2H and RZ/N2H
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 5 Nov 2025 at 11:44, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
> peripherals.
>
> Compared to the previously supported RZ/V2H, these SoCs have a smaller
> FIFO, no resets, and only two clocks: PCLKSPIn and PCLK. PCLKSPIn,
> being the clock from which the SPI transfer clock is generated, is the
> equivalent of the TCLK from V2H.
>
> Document them, and use RZ/T2H as a fallback for RZ/N2H as the SPIs are
> entirely compatible.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> @@ -9,12 +9,15 @@ title: Renesas RZ/V2H(P) Renesas Serial Peripheral Interface (RSPI)
>  maintainers:
>    - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
> -    const: renesas,r9a09g057-rspi # RZ/V2H(P)
> +    oneOf:
> +      - enum:
> +          - renesas,r9a09g057-rspi # RZ/V2H(P)
> +          - renesas,r9a09g077-rspi # RZ/T2H
> +      - items:
> +          - const: renesas,r9a09g087-rspi # RZ/N2H
> +          - const: renesas,r9a09g077-rspi # RZ/T2H
>
>    reg:
>      maxItems: 1
> @@ -36,13 +39,12 @@ properties:
>        - const: tx
>
>    clocks:
> +    minItems: 2
>      maxItems: 3
>
>    clock-names:
> -    items:
> -      - const: pclk
> -      - const: pclk_sfr
> -      - const: tclk
> +    minItems: 2
> +    maxItems: 3
>
>    resets:
>      maxItems: 2
> @@ -62,12 +64,55 @@ required:
>    - interrupt-names
>    - clocks
>    - clock-names
> -  - resets
> -  - reset-names
>    - power-domains
>    - '#address-cells'
>    - '#size-cells'
>
> +allOf:
> +  - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a09g057-rspi
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3

No need for maxItems here (already at 3 above).

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a09g077-rspi
> +              - renesas,r9a09g087-rspi

No need for renesas,r9a09g087-rspi, as it implies renesas,r9a09g077-rspi
is present, too.

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2

No need for minItems.

> +          maxItems: 2

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

