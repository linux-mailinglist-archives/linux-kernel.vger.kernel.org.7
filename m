Return-Path: <linux-kernel+bounces-899530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276FC58183
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549F13B07FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88267283C93;
	Thu, 13 Nov 2025 14:48:57 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9428027F00A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045337; cv=none; b=l6BlwGvnxt8PqTaHS8XuqG3IjcythG/nKKaqm6XucYoVORCqj43fNBa4Kgmp/WJMt0v1d6m3BTvmd9WJN+wvW2FtBpBPoKDeTxvc+b5hTYCjn4f7poRnnXfgeFSCvL11d1riAPF1ZbS/qhUDiUfSVlmN9TtMO0arXR6YAROHeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045337; c=relaxed/simple;
	bh=yUTC0EvqYswBfkQQ6OYPcTdAct3w2ul1w7D+PC7nB1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuA++LXOCKWkXqmOHDiu96JthdDETjpMLyXuZ6OsE3A+bH2LA3/tOaVuYsgUdWUEPuhPN4tbbcIACVWDnAKX4tPnXm4mn4sQJ0rAN40kzdCDT+hRlzQq/LDOmqvQDb6gMFzp3S0wlTxhkwkN9/StOMTP96c77jHInuXdqQ/v3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dbd3dbbde3so625120137.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045334; x=1763650134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+9uOsoz58vq1sUJ8SvSSoBxDJHfhxT++1tWVBAE5aI=;
        b=VmhT1WXmaC+6dyFpkXG6FAcXWN6iNUx1d46IZkPQFCFQBlVbkiOiBGLll89dHC20FE
         PXBbvEtdUfUU1Dn7mFiZ3s8I0Scp+XUahKmWAT+pjBkQTMaTI+M9yLGzxmkZT79zE5YI
         Kxzzq6HL7dHn6AoSC6KYmIQtHiL341di7dVBi/7SnhV0/JSXGPKmFTjs4IySkQ55R109
         l2R77KrX2Z5f5I2A5cffRrh+VCzrM2r+f1p9fNBC5iZTDEfms2Qn8AwIC8g7/MMSQCHk
         BEA3HL+9LqVg525t+UmmW6pWJy5qabbBfpzvO0+SfnKg60XXckR1HzPrm8qOPKX3W+Jn
         U7Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX8qJ9fveRA6ciVtJmJpP0ReXAOs8Nl/k5eCSluNimL9k6uZbMAVOjBUA2di/eJWe6+BWRRRtyOdDWtfR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rEvztcIvVg3tUClVkwR6TwSWrNhex3Erg9NgpmtdIEd7qmh0
	rxfI6CmVjFcioMPGLkx+rxQwfbrXBtxLNjv0LoDGFNLj9DuuUAAWJFqJhRWV/7Yk58c=
X-Gm-Gg: ASbGncsc7NZl3qQb1cvgFPAT7XWtLN2EAZmzn41LgW0ZyG35AkcTD74ri48wTracJrQ
	8ithCZ1u+csj47XHki4zWYtWMKILdeA59B0JOQ4qFefi2TZVcSr5H3e1/3tg/w8iADOZ/XTPjnM
	Y5WMCibswc2Xl+z33DfxDCpYBgg6IynKUZlfASytSBEealNw4J1Cp9tybB53l6yKdYVapOKvFWV
	S1TTe9T/d5eU/yhrUcGHEckLZBoT64VtBwR7Z0TqcfG25ldfsPXBrh/Tc7fPGbftnVh/w6Epuwo
	CeLsbrIOrflYQn1g5W8lmrcSYtT7aTpTrI/IXiIUpyTitaY6WYhKMhOnBzvcmd/5STFl25V+kom
	/GDoMPokUetOQwKAG/Aua8x+6hyJCsZGunQJV1fagV65shVDAD0QI7uRWS1XZjPzbFQ8iYpgeuD
	7k0mybEj6lzTHRpo0p1L5NyYRl1BvLReSCnf940Q==
X-Google-Smtp-Source: AGHT+IGW2w/6lGP5OVzJVW1JC8eWQAh6NFjaFP3eCakSewDiPtGssmzr7MacyLqreHWTRzb+71+QCg==
X-Received: by 2002:a05:6102:259a:10b0:5db:f424:5b9f with SMTP id ada2fe7eead31-5de07e0cb2fmr2057785137.25.1763045334005;
        Thu, 13 Nov 2025 06:48:54 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937611ef833sm629566241.16.2025.11.13.06.48.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:48:53 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-89018e9f902so503136241.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:48:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWK8SN1jmeubQm3b1FIi6Pq1XHBVTu6XdjxrILYcbrg7lhrB6rlwfu1gSLIv8+6sQVPAP1a11s/V7TYxrM=@vger.kernel.org
X-Received: by 2002:a05:6102:5114:b0:5db:d60a:6b1f with SMTP id
 ada2fe7eead31-5de07e06ef4mr2746009137.23.1763045333120; Thu, 13 Nov 2025
 06:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027140651.18367-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251027140651.18367-1-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 15:48:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXWwGo0bVmDpqxABH7aP0HcNDuqvv7D76xUv2Fa_48zEg@mail.gmail.com>
X-Gm-Features: AWmQ_bkLEJtOlbvS4476ZL74m55cEfNUL-RzWUnhLnjFntgzgnUJvf7opsRO570
Message-ID: <CAMuHMdXWwGo0bVmDpqxABH7aP0HcNDuqvv7D76xUv2Fa_48zEg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Add NMI
 pushbutton support
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ovidiu,

On Mon, 27 Oct 2025 at 15:07, Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
> RZ/V2H EVK has a user pushbutton connected to the SoC NMI pin, which
> can be used to wake up the system from suspend to idle. Add a DT node
> in the device tree to instantiate the gpio-keys driver for this button.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
> @@ -9,6 +9,7 @@
>
>  #include <dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  #include "r9a09g057.dtsi"
>
>  / {
> @@ -34,6 +35,20 @@ chosen {
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       keys: keys {
> +               compatible = "gpio-keys";
> +               pinctrl-0 = <&nmi_pins>;
> +               pinctrl-names = "default";

Do you need these pinctrl properties? ...

> +
> +               key-wakeup {
> +                       interrupts-extended = <&icu 0 IRQ_TYPE_EDGE_FALLING>;
> +                       linux,code = <KEY_WAKEUP>;
> +                       label = "NMI_SW";
> +                       debounce-interval = <20>;
> +                       wakeup-source;
> +               };
> +       };
> +
>         memory@48000000 {
>                 device_type = "memory";
>                 /* first 128MB is reserved for secure area. */
> @@ -320,6 +335,10 @@ i2c8_pins: i2c8 {
>                          <RZV2H_PORT_PINMUX(0, 7, 1)>; /* I2C8_SCL */
>         };
>
> +       nmi_pins: nmi {
> +               pins = "NMI";

... as no actual pin configuration is done here?

If you confirm, I can drop these while applying.

> +       };
> +
>         scif_pins: scif {
>                 pins = "SCIF_TXD", "SCIF_RXD";
>                 renesas,output-impedance = <1>;

The rest LGTM, so with the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

