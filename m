Return-Path: <linux-kernel+bounces-868481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F1C05481
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE2554E38B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981632FC877;
	Fri, 24 Oct 2025 09:15:34 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7A26B0BE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297334; cv=none; b=UL7C96pfyeNOprtdqlJCoKNqP3b+RZmYx1AAijVM/saFrZrEHJI/gmJHYIClGLxSDmMGm0cnjLCV5a3DMVJOir7bEFdYVN8WGLJyzrHmDOT9eLmY/x3soYoUvoGLjSzTIVXv+Oz2SCIuZAB2THV8UJQid5m6yroTwuf+4+9GUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297334; c=relaxed/simple;
	bh=J8mSVI/f12nth1gkWB8k+uvzYuiJaePL/O3be6q4RNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FClxn2CDQzgmwNk0kq6WIw7a4Ef1hlu9kMAXQbwT3GPCwdBZz0VN1wcJeW5JpUOJ6fNjQKGzVjSAJlxWb5LYbJUpgIeYbLwfhCSnXvf9nyIluxMGR+7fF32XiPGYDdxtl5OkvEMWmWh5E6TrWWqYFEGvO9yXdrd2Z0fz4on/6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5c7fda918feso2186869137.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297331; x=1761902131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrBpEYe9bLey+4S4JjtKCcOIac4hS6dnR1uT91EPVAM=;
        b=Xw6lvVJu596DND5lP/gP6EVxt3NkDJvc1zmQ5LTtMbWQx+SgdPacJj40i75C8tErp5
         iEIL2QT7k8kI8Q+X/gaNuXRb1grppWuwiIAqM7hzq7FUiXtFDMGeXtvQ5aMO0Wiap8Km
         FIE/VQadK1Q+JW4on4s+HRMG55EsRcVimk0Y0fSAnIoXLSWaPJemhzswb56Sd7BRuo8g
         2UaBl5DwjmxfDfQeXErwXwvojY2vgA1iGeYlfY7bXVtoRvJgJUwY46p6cRHI59TeReYx
         4auq0msVkc/A+y2P+THM9Cygu0EMXdNJQL7cTT8AmTCUAAMY/5ha5aAioW/3gpuTg7ON
         vUTw==
X-Forwarded-Encrypted: i=1; AJvYcCV3zm08+SJ3yeGzdLGaBrjXD8WmAf3XmOHC6NMXdUtdxa+PUUYIzgkV68nj5PeP3jU+v8Ox5Y/U3rpgXcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0lu+ghR47V6wzM2d2aIlTleilh7Nhxiq2ySgQqdhVys4gn/0
	KPdnzLTJG4PJLbrWB2W+xMet1IBZqpSZOqmZTa4dgi811pmsRd0M9erHd3RANZ9r
X-Gm-Gg: ASbGncsupwHnRx5UGWLlW92/xKCOfoHf7VjH3KLPgWldjelGT5vqHLhjqXrj6LKV30O
	oed8i0istrLpbavIbI7bAZrcwIgluwbPo3GVeWjoONs30yaQzZDIZGrV1BuZFoMeRoQRT7KGOf0
	2hGTlHOTHm5oJf94oUzVmdax28Iv5QzG9clTdZTmoJxn5vB3Noi2g8eRE4YcXL22hKtd//5S3Jm
	5SfU/Aalbjf4XtCy1FzzdLc33NtdQIarLqzjFB4dT7+fafMK/k3dKSBr5NEO2EZbBd7qJ/6V2Qf
	zzO6bK7pg3gN8UoDbTgsrc+StAjj2pvaSj8QRjW0OV2zloWLqD0kJXRdeQOR529ewn7PRxGDpHX
	rwvzjK1qwOOM3TD6+CXNlA+xX6dXSdwwHOFGbPn9C4vn1oeeuc02s/mObrDpm9VTPkLBfFozTAl
	aOmAt9WWaAghvI3JFqh+LLCahpRVKJIjwmhXDVQRu5EcYOt43B
X-Google-Smtp-Source: AGHT+IGA1HTKcGYnrBrMkpyp/m/V+lwTQxu+kQXWiAFDZV64MVMzAn6maUe2cqr/ZB6gYuqhi1Okog==
X-Received: by 2002:a05:6102:d87:b0:59c:93df:4fe with SMTP id ada2fe7eead31-5db3f88a253mr344074137.9.1761297331395;
        Fri, 24 Oct 2025 02:15:31 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934abaad7adsm1835385241.6.2025.10.24.02.15.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 02:15:31 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5db221488bfso2122207137.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:15:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEXc1bJgpT6xCD9kRupJWU53Al9GMAs17G7/ZuqJfY9cmT75Y4XOLsyA+BghotzFDfQ6tM/YyT18VsZks=@vger.kernel.org
X-Received: by 2002:a05:6102:12d4:b0:59e:a2d5:2945 with SMTP id
 ada2fe7eead31-5db3f88a5f3mr252149137.8.1761297331043; Fri, 24 Oct 2025
 02:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com> <20251023135810.1688415-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251023135810.1688415-8-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 11:15:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV7ScKUw7bGFW4v0wS9caXKDeT02MXkLWpk2LZfYw8GfQ@mail.gmail.com>
X-Gm-Features: AS18NWAoeA07bJLB0nX88rm2l0IWTdjwxg2U5L-RZOoaf-8oTt8PVHt9R1PDCKg
Message-ID: <CAMuHMdV7ScKUw7bGFW4v0wS9caXKDeT02MXkLWpk2LZfYw8GfQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] arm64: dts: renesas: rzg3s-smarc: Enable USB support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com, 
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Thu, 23 Oct 2025 at 20:41, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Enable USB support (host, device, USB PHYs).
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi

>  &pinctrl {
>         audio_clock_pins: audio-clock {
>                 pins = "AUDIO_CLK1", "AUDIO_CLK2";
> @@ -207,6 +230,27 @@ ssi3_pins: ssi3 {
>                          <RZG2L_PORT_PINMUX(18, 4, 8)>, /* TXD */
>                          <RZG2L_PORT_PINMUX(18, 5, 8)>; /* RXD */
>         };
> +
> +       usb0_pins: usb0 {
> +               peri {
> +                       pinmux = <RZG2L_PORT_PINMUX(5, 0, 1)>, /* VBUS */
> +                                <RZG2L_PORT_PINMUX(5, 2, 1)>; /* OVC */
> +               };
> +
> +               otg {
> +                       pinmux = <RZG2L_PORT_PINMUX(5, 3, 1)>; /* OTG_ID */
> +                       bias-pull-up;
> +               };
> +       };
> +
> +       usb1_pins: usb1 {
> +               pinmux = <RZG2L_PORT_PINMUX(5, 4, 5)>, /* OVC */
> +                        <RZG2L_PORT_PINMUX(6, 0, 1)>; /* VBUS */
> +       };
> +};
> +
> +&phyrst {
> +       status = "okay";
>  };

This node should be located before pinctrl.
No need to resend just for this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

