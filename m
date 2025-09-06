Return-Path: <linux-kernel+bounces-803976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95256B46829
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E573BD251
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5061C3C08;
	Sat,  6 Sep 2025 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK9BoNxT"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123511AF0A4;
	Sat,  6 Sep 2025 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123419; cv=none; b=Ps1ooC3Lsn5IW6o3v27scQMJbiCCCulcmEAh/Ku+4zdgj0Rnbmrd+nTl+83l255speRmwdh/SKXXA24nqwUUrBUqr1WnB0geaefMJmVkm/BYtNZQNVguUb3mv69zQ21caLnaAh07K8WcKWESCDjVHLrFs4lBWgU7iBfOSZkJD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123419; c=relaxed/simple;
	bh=iXRq99HWmzLJTx11IPN0Cm6k5Z1XvCKIC4V0rqrUCIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHQLgZlPtXUuEjJe9nomekoRqKqH+r3AJRIc8rpvX/xGMWIMTd7Mq8vCkrcuWHiCBd7hYxq0qgHDVF0EkGn3GrKDG9Zasvfn6nO6W9pyb+SEtl+V4w2zlYofod5K+tYqDNRz0TBYMNmjzHKmE7KjkMoBw+rS953aluic2JcXXWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK9BoNxT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso2181013f8f.0;
        Fri, 05 Sep 2025 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757123416; x=1757728216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T8mhgY9nX4b1GTDoanzs4NGx5M5/HhR9wB18Kbszzk=;
        b=SK9BoNxT/6eyFVJg4r0ka45qeXMyT4cbm08E0tW92dWRSO2F4oa7rhKOGCp5oVBNgR
         Wh/cl+FIJ6M/KN56Hz58dlHZtVjaBLhS6iCDZ5hTqMBJioSrA7doUks9zB8vnC+0EdLO
         MWLn+McM0r2eO8SAzpatTNCYrZ1bvIISbggir3jjj2Sj3E6qeYBL/pKABXPEsMxSocfn
         rH8CdCSK9Z2CXah2eUPyzVfVirGeykU1AfRplVKb3tpUBz9hazGd8ac+UtJ7XRZeTldI
         tyiUlTtZtckHkwkI51GAb0IYfeOCFcUS1Pbj/i2F8juqvMRw2VidCVSzcZZsYtyMkOH+
         n9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757123416; x=1757728216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9T8mhgY9nX4b1GTDoanzs4NGx5M5/HhR9wB18Kbszzk=;
        b=lrlIbYGBsnWygnAb2/SIWgSXhjBKxEOg6SKHopVnWYsL9uD2qjoUC1HWplbfKtMY8E
         iaPBUCsT1GLhL3HruJOizB/0s854PfBqFo5P9+0rHzB6zGWY5iankVK8bjRRbIRixc/6
         zGyWpn8ogNxCLTu2Tlaa0P9sXjb9qp7/3LyxgCNzFzRd1CqmoOHkR84DnectDUL1CgmH
         pyaS8e9D4Pk0kOYiWckPjhMcZG8TD7Rnha8YJgWUXr2OIcWf0b7n5KNczKGR2+4Yq2gX
         rFgjRRPGh7L9tSRxdtNuhken5jwUO3Dz7QUcJRK5rAawtjUhewC+Os+777MVQRYTTE4c
         EDYg==
X-Forwarded-Encrypted: i=1; AJvYcCUngxz2jZuyQub7q3/BHlZyFeV3jF6DE6YYCZB7Q1B4dSO6g/i2Ct3elxHRuNOSHsizxycLN5ug1vauM+R3@vger.kernel.org, AJvYcCVQPhOncL5jLYVqm7NX9lFof6CZeJUnjIWwmRb+Zn1QDM5Rzcw5aIfCFOBbOm3H//hAAgw7Y4bRoxCt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxexlo1EfLRk0oe1WJazinZhNrQTtHj7GCqfr+x1HaiJxpsNwYn
	XYjlgtuKpR+84KMikj8Ze9pznPT/d3HFPpO/yzDSHfG9dlq3WkelCLH/Ih3oS2gEOeSnt3GX7PB
	JYTeeV8EhQ0T9x/91oleVSs8sWBszStg=
X-Gm-Gg: ASbGncsKbD22UkgreW6VpfC0J3ELWuXb41msZyJg/FRHod0UQ43NmHsmabUwXtspb1D
	dKgBDiTKFalug5oQTo3puw+hreoB+c+TojP7wxzWXxvI4Uo/oaJUexAtp9dCooqi5CV1sqB1NSN
	b2TWPPE6KN23GxeDYPzorBOvdxjx1puutlyrLoclBW8hpxrUfKE2VaAPvoS03uI/qCRuMV3Kk22
	ZqnMVltHt8ddnWz8T7j8gf67sXcl3Vqan2NVSQpXcHQlFI=
X-Google-Smtp-Source: AGHT+IG6oix8mLMZHDuSE3WNnpjGJG/3AhhOv3u2JxvodBrLWsljciM9kQJmzeRwfNEpuDP8Q7Dg/c797dvznUQWxEc=
X-Received: by 2002:a05:6000:2883:b0:3e3:f332:73f0 with SMTP id
 ffacd0b85a97d-3e64c693923mr284627f8f.49.1757123415784; Fri, 05 Sep 2025
 18:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090115.718622-1-dkx@t-chip.com.cn>
In-Reply-To: <20250905090115.718622-1-dkx@t-chip.com.cn>
From: Jimmy Hon <honyuenkwun@gmail.com>
Date: Fri, 5 Sep 2025 20:50:04 -0500
X-Gm-Features: Ac12FXwbiLHfVMuDhY7SOkXke4RxqgSQCIhrk8FrjSiEnCfjNXAuJcrVNoPzTFc
Message-ID: <CALWfF7+6dTqLRHYKHL1iBf9YknLQ5yTrwPur8VySmjiy3mzh0Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add devicetree for the ROC-RK3588-RT
To: Kaison Deng <dkx@t-chip.com.cn>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Wayne Chou <zxf@t-chip.com.cn>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Dragan Simic <dsimic@manjaro.org>, 
	Jonas Karlman <jonas@kwiboo.se>, FUKAUMI Naoki <naoki@radxa.com>, Peter Robinson <pbrobinson@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:32=E2=80=AFAM Kaison Deng <dkx@t-chip.com.cn> wrot=
e:
>
> The Firefly ROC-RK3588-RT is RK3588 based SBC featuring:
>
> - TF card slot
> - NVME 2242 socket
Could you update the commit description to match device tree. It looks
like the M.2 2242 socket is configured as a SATA (i.e. "sata2")
instead of NVME.

Is the M.2 slot also wired for NVME operation? If so, will you be
providing a DT overlay to use it in that mode?

https://wiki.t-firefly.com/en/ROC-RK3588-RT/usage_sata.html#software-config=
uration

> - 1x USB 3.0 Port, 1x USB 2.0 Port, 1x Typec Port
> - 1x HDMI 2.1 out, 1x HDMI 2.0 out
> - 2x Gigabit Ethernet, 1x 2.5G Ethernet
> - M.2 E-KEY for Extended WiFI and Bluetoolh
> - ES8388 on-board sound codec - jack in/out
> - RTC
> - LED: WORK, DIY
> - BTB connector for PCie, UART, USB, CAN, SARADC, GPIO
>
> Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>  .../arm64/boot/dts/rockchip/rk3588-roc-rt.dts | 1120 +++++++++++++++++
>  2 files changed, 1121 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/=
rockchip/Makefile
> index 9d56d4146b20..ad684e3831bc 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -181,6 +181,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-orangepi-5-ma=
x.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-orangepi-5-plus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-orangepi-5-ultra.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-quartzpro64.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-roc-rt.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-rock-5-itx.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-rock-5b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-rock-5b-pcie-ep.dtbo
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts b/arch/arm64/=
boot/dts/rockchip/rk3588-roc-rt.dts
> new file mode 100644
> index 000000000000..1d50009d3153
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts

[snip]

> +
> +&hdmi0 {
> +       status =3D "okay";
> +};
> +
> +&hdmi0_in {
> +       hdmi0_in_vp0: endpoint {
> +               remote-endpoint =3D <&vp0_out_hdmi0>;
> +       };
> +};
> +
> +&hdmi0_out {
> +       hdmi0_out_con: endpoint {
> +               remote-endpoint =3D <&hdmi0_con_in>;
> +       };
> +};
Does the board support hdmi0_sound and hdmi1_sound (and the
corresponding i2s5_8ch and i2s6_8ch)?

> +
> +&hdmi1 {
> +       status =3D "okay";
> +};

[snip]

> +
> +&sdhci {
> +       bus-width =3D <8>;
> +       no-sdio;
> +       no-sd;
> +       non-removable;
> +       max-frequency =3D <200000000>;
> +       mmc-hs400-1_8v;
> +       mmc-hs400-enhanced-strobe;
These properties should be in alphabetical order.

> +       status =3D "okay";
> +};
> +
> +&sdmmc {
> +       bus-width =3D <4>;
> +       cap-sd-highspeed;
> +       disable-wp;
> +       max-frequency =3D <150000000>;
> +       no-sdio;
> +       no-mmc;
> +       sd-uhs-sdr104;
> +       vmmc-supply =3D <&vcc3v3_sd_s0>;
> +       vqmmc-supply =3D <&vccio_sd_s0>;
> +       status =3D "okay";
> +};

Jimmy

