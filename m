Return-Path: <linux-kernel+bounces-801829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D5CB44A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6C11C27DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706942F619B;
	Thu,  4 Sep 2025 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0tclXte"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10652D73B3;
	Thu,  4 Sep 2025 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029082; cv=none; b=b0nYvtLu8dyBkxORh9bbquf5bulrtPUCmoKMVEBBSMKH4znLlB05XhjsfcCwrKSls1iqfi/2CCt+H7CxmjFBMbel5nSTp0AzFDNl3FGDQbkG02Ze1oE/xvFCOTVjLMv3h2TAHmq9unyjk6NHn7mXRrIsAQNivztnbdeLewkj6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029082; c=relaxed/simple;
	bh=i+01YYY1wAETl8uPU7E8Ydrb8Pq90kKfcxjQN9XqHmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbkvQuhKVKNiYGLR5GzchF0VFj5BzQp5jd/405ixKAzN/xv7bnRNOLpLaNEFJ85ZppvphFcS0LTM9ag5v1RvJDQEgmhktEVYsU/Q2Lmk6zspINSC9dBs+VgE196GQsdq5b3o/cpef2IHL2FFEHJbDtoYpzqONBiXKC25fAV+xaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0tclXte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE71C4AF0B;
	Thu,  4 Sep 2025 23:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757029082;
	bh=i+01YYY1wAETl8uPU7E8Ydrb8Pq90kKfcxjQN9XqHmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s0tclXteDCYT7ZyezWUyvRUi0f5+96I4ovEgEgImvic6Dv+KBtSrWdbVnK2tqLq+c
	 zYTydfFUT5LZM1VFk21uICVuI/giz7wjdwFJDSQ+7tF8SQyT/UFWr8OkNG32WL00jx
	 /QjjqDhpXIf4Ou8VyU5G2Si6Xc/JFkS8Xr/RhxiV/fMjiaVTDLyeqa7LVm40D5+MMJ
	 Ree6mP727tgdQSBFo2kWqF5I0F28o8OGWGgfAVPskBIcOeCY4gtS7aoa894ol+jfND
	 5IU34nskxf63KG6x5GrV2FgGM356CeFuiYSwbStPpfHj1MAfafOS+mhmCbLLpkSD8g
	 6rpdd21u5PA0Q==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61e4254271dso2980823a12.2;
        Thu, 04 Sep 2025 16:38:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaxpDJPtteGe1364WeKKKZfi6vxNueNayyJ0YvzkxZpjHUWraqViwPt7Jjy5+dmEwo+y5jtRtBmvew@vger.kernel.org, AJvYcCWSDB2hP8tUVHAJbyGdIehe1H4iKICcncAt96xUGoN48DWfZBhdTljqaQMyhXZLWCZmrQW2Sk9VEzzXaedi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Z4WAtNLaj74svRP98LqDxfuRXo6q8RB9UIFos8bUAFrVdLBP
	L2c7rXOLbYVvULHIZ4lThN84+/ZythN0qGboO1dnzhxp8SjfFLSRtQxTPY061844XZYeorYDZWz
	bmHD5qRK6Rjr2c6tjSLvtCl1QykoYBQ==
X-Google-Smtp-Source: AGHT+IFFN6fk5YVg+B1Gm6YAlYwOQG6ufa/AOFFGb2DahNQbjmVf7LcAWNTuQcant4szK9wxkX0bXwvOq8gcg3FZDZM=
X-Received: by 2002:a05:6402:90a:b0:61e:1636:aeee with SMTP id
 4fb4d7f45d1cf-61e1636b01bmr14623674a12.38.1757029080874; Thu, 04 Sep 2025
 16:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-sti-rework-v2-0-f4274920858b@gmail.com> <20250714-sti-rework-v2-1-f4274920858b@gmail.com>
In-Reply-To: <20250714-sti-rework-v2-1-f4274920858b@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 4 Sep 2025 18:37:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ0ckZ529gm781uF52yR3-gj2ctHR11hUK=4q8_Eq65EQ@mail.gmail.com>
X-Gm-Features: Ac12FXyVHTjBeXc1k7EZQPMmRZXJqAQXLxtZHtgAqDf9uO9vDCivi8C1SxLEoVo
Message-ID: <CAL_JsqJ0ckZ529gm781uF52yR3-gj2ctHR11hUK=4q8_Eq65EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: sti: drop B2120 board support
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 8:54=E2=80=AFAM Raphael Gallais-Pou
<rgallaispou@gmail.com> wrote:
>
> B2120 boards are internal boards which never were commercialised.
>
> Drop them.
>
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  arch/arm/boot/dts/st/Makefile           |   2 -
>  arch/arm/boot/dts/st/stih407-b2120.dts  |  27 -----
>  arch/arm/boot/dts/st/stih407.dtsi       | 145 ----------------------
>  arch/arm/boot/dts/st/stih410-b2120.dts  |  66 ----------
>  arch/arm/boot/dts/st/stihxxx-b2120.dtsi | 206 --------------------------=
------
>  5 files changed, 446 deletions(-)
>
> diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefil=
e
> index cc9948b9870f7f73629573149bfd342af75b07da..f57fc6dc48a00c9a9323b4508=
e5e4e161b197c47 100644
> --- a/arch/arm/boot/dts/st/Makefile
> +++ b/arch/arm/boot/dts/st/Makefile
> @@ -13,8 +13,6 @@ dtb-$(CONFIG_ARCH_SPEAR3XX) +=3D \
>  dtb-$(CONFIG_ARCH_SPEAR6XX) +=3D \
>         spear600-evb.dtb
>  dtb-$(CONFIG_ARCH_STI) +=3D \
> -       stih407-b2120.dtb \
> -       stih410-b2120.dtb \
>         stih410-b2260.dtb \
>         stih418-b2199.dtb \
>         stih418-b2264.dtb
> diff --git a/arch/arm/boot/dts/st/stih407-b2120.dts b/arch/arm/boot/dts/s=
t/stih407-b2120.dts
> deleted file mode 100644
> index 9c79982ee7ba8fadb1a2a92e732bf7f652b74c38..0000000000000000000000000=
000000000000000
> --- a/arch/arm/boot/dts/st/stih407-b2120.dts
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
> - * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> - */
> -/dts-v1/;
> -#include "stih407.dtsi"
> -#include "stihxxx-b2120.dtsi"
> -/ {
> -       model =3D "STiH407 B2120";
> -       compatible =3D "st,stih407-b2120", "st,stih407";
> -
> -       chosen {
> -               stdout-path =3D &sbc_serial0;
> -       };
> -
> -       memory@40000000 {
> -               device_type =3D "memory";
> -               reg =3D <0x40000000 0x80000000>;
> -       };
> -
> -       aliases {
> -               serial0 =3D &sbc_serial0;
> -               ethernet0 =3D &ethernet0;
> -       };
> -
> -};
> diff --git a/arch/arm/boot/dts/st/stih407.dtsi b/arch/arm/boot/dts/st/sti=
h407.dtsi
> deleted file mode 100644
> index aca43d2bdaad44ef2a0e8a120c679c217709af44..0000000000000000000000000=
000000000000000
> --- a/arch/arm/boot/dts/st/stih407.dtsi
> +++ /dev/null
> @@ -1,145 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2015 STMicroelectronics Limited.
> - * Author: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> - */
> -#include "stih407-clock.dtsi"

Looks like this file is unused now too and can be removed.

Rob

