Return-Path: <linux-kernel+bounces-765042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA46B22A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7E21B6601D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14162EA498;
	Tue, 12 Aug 2025 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbADEbf7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4552E9757;
	Tue, 12 Aug 2025 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008658; cv=none; b=M+rWON4dPR0PCXxuy3lpDhPctzy5iAwxVxh7wIT8Joz94MqkZP3LyvDOqbiXKTcZiLX0CnlCjAhLoY/fkgwWfa1hmH/bb/CalA+wLloHgKQGpjvtrek9F2+08CO8bt6icAv++mCHFE3rKy02q2d49c5fXWDrLLu9sWiqnUwJ7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008658; c=relaxed/simple;
	bh=1vyyr8C2zOlS6zNdltWJ9HYZujL5Uy9677XNN3QAu/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaY7oaddppW9S5aUGNsI1EaHcR4N63ffiaPSF4gaFHRTt3u4+ebfEgASAQg3+SKHrbyjuQcBzTlG1Xrid2KR3lLdcl3MPEPvLSEYnctRh5A+GEDaSnL6XtU0JsxuwPPj1Eud+GX4eeOrnsUPXWRjoIoeCMZLNPGGHakuOOxJFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbADEbf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885FBC4CEF1;
	Tue, 12 Aug 2025 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755008656;
	bh=1vyyr8C2zOlS6zNdltWJ9HYZujL5Uy9677XNN3QAu/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HbADEbf7+k9gq0Di3wAdimeGH1mjEiRbXBg/k3RsxkSOAjwOiiUawhl0XRzOq/mPm
	 JfD74btQ9raSICJM02c1WaW4Rbp/6TVlJpyVbULPx+HK/zQNRjbC9qMh4IJBT0qTwR
	 hJtHUWKitU5CGugii01bLNArCtwA2nUPO5XtiV+fUCfQFPEsZh4zaWopUOtE3VQ9Zu
	 mQNYsoSx8boe2O1kpGLatCmoSyEXeyzhBxwjjEO/SjlgNKxuZdtQuG/Uj5I+Tyq8OS
	 awnULnFFxVQXzuxn/aL+tbl8XmT/MHhlUq70HbrVbChLRjbJgwteK2oDIyKUwHleZ9
	 NnToImbvlKu2w==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso919791866b.1;
        Tue, 12 Aug 2025 07:24:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQVUnv8BUO5SQrasyL/XkXmzuMY9dwgohUZKMgjpI1EhxAE5AFVXqmZ3Pg75jA6VdmRnQUIyYHex3n@vger.kernel.org
X-Gm-Message-State: AOJu0YysXTEhnTn+BCoZ3ljTXMIUGOvIXU30SVps1k7e16YdFglRpHfg
	glnxlp2QwCrUL/33ct98d3gwJS8SZSEbEw/fn861t8Y2XBwbIzzmMFPcx1YtIcuo7b+V9AyQOeI
	O8jY641g8KLI8XIZJbmiUE0ODnkYw9g==
X-Google-Smtp-Source: AGHT+IHmRYjvc/55DKRxWdDkLyGXMRZPhOKnGEaxwBrSckIck/xZueHSci5zBgYwsEzuPzWfG+yan6fLYjsFgXLFnwQ=
X-Received: by 2002:a17:907:96a5:b0:ae0:ad8c:a559 with SMTP id
 a640c23a62f3a-afa1dfa0b22mr376770966b.4.1755008655115; Tue, 12 Aug 2025
 07:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752837842.git.michal.simek@amd.com> <05ff505c6b6517e3aba983a21454c568c5e86389.1752837842.git.michal.simek@amd.com>
In-Reply-To: <05ff505c6b6517e3aba983a21454c568c5e86389.1752837842.git.michal.simek@amd.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Aug 2025 09:24:03 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+=mnYipAN2q8gdcDF2pK7e8NTOazgq9V+rZSAs9O4PEg@mail.gmail.com>
X-Gm-Features: Ac12FXz4xyiXZUUwtw2LW0dSI6hHE0Bw5Qka0B72VRitNFnk--s6ts1sG_GhtxQ
Message-ID: <CAL_Jsq+=mnYipAN2q8gdcDF2pK7e8NTOazgq9V+rZSAs9O4PEg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: zynqmp: Add support for kd240 board
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, 
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 6:24=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
> The kit is using k24 SOM by default and it is used for motor control and
> DSP applications.
>
> K24 SOM is also possible to used with kv260 and kr260 CC which are also
> wired in Makefile.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> https://www.amd.com/en/products/system-on-modules/kria/k24/k24i-industria=
l.html
> https://www.amd.com/en/products/system-on-modules/kria/k24/kd240-drives-s=
tarter-kit.html
>
> ---
>  arch/arm64/boot/dts/xilinx/Makefile           |  15 +
>  .../boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso | 390 ++++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-sm-k24-revA.dts    |  23 ++
>  .../boot/dts/xilinx/zynqmp-smk-k24-revA.dts   |  21 +
>  4 files changed, 449 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts
>
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xi=
linx/Makefile
> index 5e84e3c725e2..70fac0b276df 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -39,4 +39,19 @@ dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k26-revA-sck=
-kr-g-revA.dtb
>  zynqmp-smk-k26-revA-sck-kr-g-revB-dtbs :=3D zynqmp-smk-k26-revA.dtb zynq=
mp-sck-kr-g-revB.dtbo
>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k26-revA-sck-kr-g-revB.dtb
>
> +zynqmp-sm-k24-revA-sck-kd-g-revA-dtbs :=3D zynqmp-sm-k24-revA.dtb zynqmp=
-sck-kd-g-revA.dtbo
> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-sm-k24-revA-sck-kd-g-revA.dtb
> +zynqmp-smk-k24-revA-sck-kd-g-revA-dtbs :=3D zynqmp-smk-k24-revA.dtb zynq=
mp-sck-kd-g-revA.dtbo
> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k24-revA-sck-kd-g-revA.dtb
> +
> +zynqmp-sm-k24-revA-sck-kv-g-revB-dtbs :=3D zynqmp-sm-k24-revA.dtb zynqmp=
-sck-kv-g-revB.dtbo
> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-sm-k24-revA-sck-kv-g-revB.dtb
> +zynqmp-smk-k24-revA-sck-kv-g-revB-dtbs :=3D zynqmp-smk-k24-revA.dtb zynq=
mp-sck-kv-g-revB.dtbo
> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
> +
> +zynqmp-sm-k24-revA-sck-kr-g-revB-dtbs :=3D zynqmp-sm-k24-revA.dtb zynqmp=
-sck-kr-g-revB.dtbo
> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-sm-k24-revA-sck-kr-g-revB.dtb
> +zynqmp-smk-k24-revA-sck-kr-g-revB-dtbs :=3D zynqmp-smk-k24-revA.dtb zynq=
mp-sck-kr-g-revB.dtbo
> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-smk-k24-revA-sck-kr-g-revB.dtb
> +
>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D versal-net-vn-x-b2197-01-revA.dtb
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso b/arch/=
arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
> new file mode 100644
> index 000000000000..02be5e1e8686
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for KD240 revA Carrier Card
> + *
> + * Copyright (C) 2021 - 2022, Xilinx, Inc.
> + * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
> + *
> + * Michal Simek <michal.simek@amd.com>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +       compatible =3D "xlnx,zynqmp-sk-kd240-rev1",
> +                    "xlnx,zynqmp-sk-kd240-revB",
> +                    "xlnx,zynqmp-sk-kd240-revA",
> +                    "xlnx,zynqmp-sk-kd240", "xlnx,zynqmp";
> +       model =3D "ZynqMP KD240 revA/B/1";
> +
> +       aliases {
> +               ethernet0 =3D "/axi/ethernet@ff0c0000"; /* &gem1 */
> +       };
> +
> +       ina260-u3 {
> +               compatible =3D "iio-hwmon";
> +               io-channels =3D <&u3 0>, <&u3 1>, <&u3 2>;
> +       };
> +
> +       clk_26: clock2 { /* u17 - USB */
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <26000000>;
> +       };
> +
> +       clk_25_0: clock4 { /* u92/u91 - GEM2 */
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <25000000>;
> +       };
> +
> +       clk_25_1: clock5 { /* u92/u91 - GEM3 */
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <25000000>;
> +       };
> +};
> +
> +&can0 {
> +       status =3D "okay";
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_can0_default>;
> +};
> +
> +&i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       pinctrl-names =3D "default", "gpio";
> +       pinctrl-0 =3D <&pinctrl_i2c1_default>;
> +       pinctrl-1 =3D <&pinctrl_i2c1_gpio>;
> +       scl-gpios =3D <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +       sda-gpios =3D <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +
> +       u3: ina260@40 { /* u3 */
> +               compatible =3D "ti,ina260";
> +               #io-channel-cells =3D <1>;
> +               label =3D "ina260-u14";
> +               reg =3D <0x40>;
> +       };
> +
> +       slg7xl45106: gpio@11 { /* u13 - reset logic */
> +               compatible =3D "dlg,slg7xl45106";
> +               reg =3D <0x11>;
> +               label =3D "resetchip";

'label' is not a documented property for this binding. Please drop.
"dtbs_check" reports this.

Rob

