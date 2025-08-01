Return-Path: <linux-kernel+bounces-753878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98D4B18958
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60055A1457
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE2E23ABB5;
	Fri,  1 Aug 2025 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DLb6kv/p"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115B207E03
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089981; cv=none; b=qzi37mO93RgpGg5zz9D6x7eIegxezedkKKHjH2Hv1EsThxSQ9eM3dAWPbPSlu5Gq40f/E6A7amMdyy2A9RfNkPGqRJW7aIm6/LpZrgtp19cQ6c/BxGjIl18jpCW0vmNx3UcjtLrzDvyaE08i+a6qgLd+RpGp3yc45fzLq0DN4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089981; c=relaxed/simple;
	bh=cFsxKHNUWz5X8MPXIcuVQApigpPigQKjMIVXFGISYG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8zEv2B9pGTUrs8KHNR64aKWK6bMf6qITEy1NhWw8JC/7q2dYWPa8VsrXY8+/nJGsxLpRwOPPfUscwOvMg92tY14kjDjcX0qr9WNSPAB79HNwCDNYESnEQ2iKUcVhihyg9+EjhI8D+r3qiof1XFdO5D4EERzWx+fmTli3wryr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DLb6kv/p; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-712be7e034cso22357457b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754089978; x=1754694778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qnr0gleEzCaWRPAfwAkPAasxmEHLjKhxCSZjhfl6r00=;
        b=DLb6kv/p0njiWKJONSXelNcyidLwN7ZMYoja5yEtN0CEQ2GU8UPhcZg2YCqZMOn3j3
         4KtaOK3TEftlA7fJeIaxpwcbe8I691a3xihMz1utaQFXjPdWkwV5WLP1JnjQrcnzZoXK
         076IaE/t5ZJQ+ZtjpN4w0H8XazKrWygwzb1oAETsxyDm/OZyoCoynzZXBtLizzSewm6E
         l65fB5ylkGRnDylkxLaNWiCBTmBAHag7mfByBUa78qg9aLEdQDyw4+R94fwuTZ1TH3CQ
         ujOGu5ZrbflALuG0XyUsPv1PGGTveoR4GtGDhftUcjhjSJHig/dyRJMRkclJ2wZ8js6W
         C4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754089978; x=1754694778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qnr0gleEzCaWRPAfwAkPAasxmEHLjKhxCSZjhfl6r00=;
        b=Sevtdcz9oFeokPK04MO6TfwbVzuOXmlETJIVaAk9Tpbnz3oJOE06lI9ZDuVL3pwR0Q
         g8Kn4XHta7D428FQnoa0xFjfyzBz0aTUJnLVZzYrt32Eleq29/PC98vZ+rRT6huQkR7L
         GgP37v3rh7bQiWL2rquyQp0+TZILcNtUY63QCIlBItCGCI7sS45mTJJwCj5QSzP4nWx6
         Dl8J+2cUNcNdOgqk6hL0bzA9IHsIKs+hu37xhFZ4a6HafyjYzNIKfAM4krPF5a8+tg7V
         M0tpIovfmUQQF1yX97yTNXHFrRBp2zbTv3aI5SVWmNIHzLXWYI08tIIJM7LBXS9rcJ+/
         Is7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmvmdN5OIvoBX0/u3o3nc7Pk9c82Fne8JkYDzaHsuZs3Ist5+tLuGfPLim3tZ42tLkkV3RX+yDrnRrksg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpF8WMx72A5ez7xGoNVSXwLpfDJOERB0eEGc79qJbjr5LV3gjj
	D2WHiY8Sl7UOZRalY9lrvdIttVOGSkBNhAVUGMbaRDOYByJCrFd6ufhNWQCxXnv0ptp2motohY2
	UYMfETWDbdsiWHyj3OHSCXw9dF8q7XhiU1l0SoaA62Q==
X-Gm-Gg: ASbGnctM0PeMcWR8E0VgVa8oVdPCHuT2q9LTlNvZkzmmHYIKPUhbdNqdvvc8t2kEGxJ
	uKq7rEzcMMm0+H6r7QdMvip7PXAgRxWw57P+TtR6mnkOtvDl9/TJRaKuGXvklnYj7fzpf/m9aOo
	5K57odn/llfMl3SRNrff/XOBMZ9hoaaBa+mHEB5hCgUgwKE6qTtz3eNL7l+kWitD6Ywwu/1ddIm
	Au3kA==
X-Google-Smtp-Source: AGHT+IFgbhp0zycvCOOvLLcXqyA8OgsubbXQ2AW066KqqN7IDoR7AWFw0XrDwVG6iqqj5YKOJnybVqjIOE+529ZV8Tc=
X-Received: by 2002:a05:690c:d96:b0:71a:1e72:84c6 with SMTP id
 00721157ae682-71b7f5e133emr20973427b3.1.1754089978267; Fri, 01 Aug 2025
 16:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730074253.1884111-1-ivo.ivanov.ivanov1@gmail.com> <20250730074253.1884111-5-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250730074253.1884111-5-ivo.ivanov.ivanov1@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Aug 2025 18:12:47 -0500
X-Gm-Features: Ac12FXzKSBmhmwqRZhR5hadTWEjBctW2rRjuv0sswLAzvNtoYbb40IWjhC7MaD8
Message-ID: <CAPLW+4kOiBOZYQVA-ZiMEn+-_ZF1HD8QTm9AH0y34bcY+Mu92A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: exynos2200: add serial_0/1 nodes
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 2:43=E2=80=AFAM Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:
>
> Add nodes for serial_0 (UART_DBG) and serial_1 (UART_BT), which
> allows using them.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos2200.dtsi | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos2200.dtsi b/arch/arm64/boot=
/dts/exynos/exynos2200.dtsi
> index bab77b442..22c6da907 100644
> --- a/arch/arm64/boot/dts/exynos/exynos2200.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos2200.dtsi
> @@ -336,6 +336,19 @@ pinctrl_peric1: pinctrl@10730000 {
>                         reg =3D <0x10730000 0x1000>;
>                 };
>
> +               serial_1: serial@10840000 {
> +                       compatible =3D "samsung,exynos2200-uart", "google=
,gs101-uart";
> +                       reg =3D <0x10840000 0x100>;
> +                       clocks =3D <&cmu_peric1 CLK_MOUT_PERIC1_NOC_USER>=
,
> +                                <&cmu_peric1 CLK_DOUT_PERIC1_UART_BT>;
> +                       clock-names =3D "uart", "clk_uart_baud0";
> +                       interrupts =3D <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       pinctrl-0 =3D <&uart1_bus>;
> +                       pinctrl-names =3D "default";
> +                       samsung,uart-fifosize =3D <256>;
> +                       status =3D "disabled";
> +               };
> +
>                 cmu_hsi0: clock-controller@10a00000 {
>                         compatible =3D "samsung,exynos2200-cmu-hsi0";
>                         reg =3D <0x10a00000 0x8000>;
> @@ -458,6 +471,19 @@ pinctrl_peric2: pinctrl@11c30000 {
>                         reg =3D <0x11c30000 0x1000>;
>                 };
>
> +               serial_0: serial@11c40000 {
> +                       compatible =3D "samsung,exynos2200-uart", "google=
,gs101-uart";
> +                       reg =3D <0x11c40000 0x100>;
> +                       clocks =3D <&cmu_peric2 CLK_MOUT_PERIC2_NOC_USER>=
,
> +                                <&cmu_peric2 CLK_DOUT_PERIC2_UART_DBG>;
> +                       clock-names =3D "uart", "clk_uart_baud0";
> +                       interrupts =3D <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       pinctrl-0 =3D <&uart0_bus_single>;
> +                       pinctrl-names =3D "default";
> +                       samsung,uart-fifosize =3D <256>;
> +                       status =3D "disabled";
> +               };
> +

Shouldn't these two serial nodes be children of some corresponding USI
nodes? IIUC, the downstream counterpart of this device tree is [1]? I
can see the corresponding USI node is missing there. And if you don't
have the TRM, it might get confusing. But, apart from my intuition
telling me that those UART blocks *should* be implemented as a part of
USI IP blocks in Exynos2200, there is also a fact that the downstream
driver is actually accessing USI registers in exynos_usi_init()
function, in the exynos-uart driver here: [2]. If that's correct, it
means there should exist a USI block, which should be modeled like so:

8<-------------------------------------------------------------------------=
>8
    usi_...: usi@11c400c0 {
        compatible =3D ...;
        reg =3D <0x138200c0 0x20>;
        samsung,sysreg =3D <...>;
        samsung,mode =3D <USI_MODE_UART>;
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        ranges;
        clocks =3D <&cmu_peric2 CLK_MOUT_PERIC2_NOC_USER>,
                 <&cmu_peric2 CLK_DOUT_PERIC2_UART_DBG>;
        clock-names =3D "pclk", "ipclk";
        status =3D "disabled";

        serial_0: serial@11c40000 {
            compatible =3D "samsung,exynos2200-uart", "google,gs101-uart";
            reg =3D <0x11c40000 0x100>;
            clocks =3D <&cmu_peric2 CLK_MOUT_PERIC2_NOC_USER>,
                     <&cmu_peric2 CLK_DOUT_PERIC2_UART_DBG>;
            clock-names =3D "uart", "clk_uart_baud0";
            interrupts =3D <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH 0>;
            pinctrl-0 =3D <&uart0_bus_single>;
            pinctrl-names =3D "default";
            samsung,uart-fifosize =3D <256>;
            status =3D "disabled";
        };
    };
8<-------------------------------------------------------------------------=
>8

This way you can achieve the same behavior as in downstream kernel, by
making the (upstream) USI driver to initialize corresponding USI
registers for you.

Does that make any sense?

Thanks!

[1] https://github.com/jgudec/android_kernel_samsung_exynos2200/blob/CWAI/a=
rch/arm64/boot/dts/exynos/s5e9925.dts#L4648
[2] https://github.com/jgudec/android_kernel_samsung_exynos2200/blob/CWAI/d=
rivers/tty/serial/exynos_tty.c#L2181


>                 cmu_cmgp: clock-controller@14e00000 {
>                         compatible =3D "samsung,exynos2200-cmu-cmgp";
>                         reg =3D <0x14e00000 0x8000>;
> --
> 2.43.0
>
>

