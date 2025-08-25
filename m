Return-Path: <linux-kernel+bounces-784664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF5B33F59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D789F7A857E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E933244662;
	Mon, 25 Aug 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxuTB6ER"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907D246BC6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124765; cv=none; b=J5Hml0ZKulCFp6r5C3nvere3qQ/DGVfpnZhvXLqJ+YMmW1i94p+sI9/DpTY31454TL8QMOw174LnTONM73Snb7vO19ojTcSY5g5g34VJXyJF2RogHjz78RJaU+gSnKrhRmcb2w849y8z0nCsCWGjWKZP9vkSrMdOWmnjsZTgiT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124765; c=relaxed/simple;
	bh=EPuhLSFemzDPHkQuDCqfWriMem09waSvO1qYO3wPP1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2gtQT/J65+lBHO4Gs46G/AzLrK+L0u1N2LLrgGioWv1fXeZ0FLX1vKoqJC8CKtRLZWoX2HIajhjPUYatoTJlyiw1DgCfDYZJteIXesWqCFrpor7cKrfgd7fBl/22U/IkqWS0auQ1q8tAXD1yMamsO3cSozZuFhUe4jCIlQTI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WxuTB6ER; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c79f0a606eso950846f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756124762; x=1756729562; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iD4A2gYEHhEqDDI4pv93pPk9MPb3yUNXkPrSTp8pI48=;
        b=WxuTB6ERMv7BKfPQBXBpLnvVDxz9VleDngFk4UyfWG/32lzt0A4MYFO6C6dosP93eb
         3Y1cNeabm6W+8iO5UzANswTTKPIsh8QV/ld/JjZHegTFxHddCl7WJHSH/kFcSjhUjYbr
         jn/ax6UIwej8buRnfAOI0fvUO1/UWs7RePsXe2D5DOVJKWAmyLOqDPKEsKWmmBQcWTIe
         +KjnXOvSj4mbX0RGKmr2SGZMsFmvIq1Yy0tE6hrPqTi7hkWHhal9ai6dupsfe0N5hJIc
         8K4zGGvI0DxaFkNOENqLJi9GLKFKoACVMfN74zMCTFkTLbt21MIEY/NWP5dAy4iVJFxz
         +Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756124762; x=1756729562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iD4A2gYEHhEqDDI4pv93pPk9MPb3yUNXkPrSTp8pI48=;
        b=jxZef6HxvDKGuRdYL3HlROHt0XtqAnPtD6gb82dbEcSUtjtwF2QRttrxGBY13+YgG/
         bBFNA3uyd5mFhTD3lfBb7uA/t2F2+Ao9UvtZ3NDIK6o2v7yQFcPzofagxwoS2SAb7xn+
         pz75BXQj75PIgLDk0EA25YyIGe0u/Dp0DN/OXr3ZhSzqWsuTSD4DGP0a/WM70S29RgxN
         gCvNhIrRJMjA2eJMcLkPdOlYfc/g0mp3arTQb+W57dxtVZOa/WjAmuERS9sGcUC1u6Lw
         zIfgCOL+Ht7kIWrKbWexIAmRh1rnZaKFC82J7lPvco8kc6AL9t8CCjHzk+f+JDOZkcge
         qnuQ==
X-Gm-Message-State: AOJu0YxFKVLD1sVuHXyABwkikSCpD45K7uan5HtI/FNqSBQP47OWR54h
	2OaT8SX650mrHP21e/wu81MEala0In2dD2j9T/nyqnenGVqaIRzj0ExdNP1uw+mrQjI=
X-Gm-Gg: ASbGncubL64MniiQrvN8T6oMOm3pE0DR9YdsK1vcjQxfRqZUmRkFYiYHt7zNO9yCDsd
	EVjr7WagvZdgSdmcWn0DzL8FjS+6yqVMZLIbYS4aygQic31Xhj3RZhddafzMt0gMpRd/Y4SFvOf
	qh2b2LujSBcpCcDMxL+MmNPZT4dshDA9N54EmP1/+fKnF6HuM4Wy1VXzBpZ+vu94jQ3ZopXPF/i
	FDa1BuxjesrZ0HhXa5PcBAgIuhWwH3dtnfllhSjw3UBZ4jRy4508nfWoEcYbzxxtjmrBeRrVKf+
	+Zp76g0xATCn3d7sBCt7wLQZAygGqqqFsXNDd/Jds7E/LnaUG5e6XtSwzirH9DMeazkSGoa6iM+
	GOrxhL11/rmEjcx0tpYjDzMziGw==
X-Google-Smtp-Source: AGHT+IGZKR4ycwSMzrqSf8EzPWzEYvLi9+vxNDQf6ku1dpyxkwx330HC9znsLRd8NyKKnUo4pxNj8g==
X-Received: by 2002:a05:6000:2705:b0:3c6:a970:1505 with SMTP id ffacd0b85a97d-3c6a9701ec9mr4679656f8f.43.1756124761743;
        Mon, 25 Aug 2025 05:26:01 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c86a8ccd1bsm7068027f8f.27.2025.08.25.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:26:01 -0700 (PDT)
Message-ID: <2855688dcb6898af0d4b03913c6193da8b115760.camel@linaro.org>
Subject: Re: [PATCH v5 4/4] arm64: dts: exynos: google: add Maxim MAX77759
 Fuel-gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: t.antoine@uclouvain.be, Sebastian Reichel <sre@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Peter
 Griffin	 <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Mon, 25 Aug 2025 13:25:59 +0100
In-Reply-To: <20250804-b4-gs101_max77759_fg-v5-4-03a40e6c0e3d@uclouvain.be>
References: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be>
	 <20250804-b4-gs101_max77759_fg-v5-4-03a40e6c0e3d@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-04 at 16:26 +0200, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> Add the node for the Maxim MAX77759 fuel gauge as a slave of the i2c.
>=20
> The TODO is still applicable given there are other slaves on the
> bus (e.g. PCA9468, other MAX77759 functions and the MAX20339 OVP).
>=20
> For the device specific values (full design capacity and terminal
> current), the device should check an EEPROM at address 0x50 of the
> hsi2c_8 for a battery id stored in register 0x17. A set of parameters
> for the initialization of the fuel gauge should be chosen based on
> this id. Those sets are defined here:
>=20
> Link:
> https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviol=
e-5.10-android15/arch/arm64/boot/dts/google/gs101-oriole-battery-data.dtsi
> Link:
> https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviol=
e-5.10-android15/arch/arm64/boot/dts/google/gs101-raven-battery-data.dtsi
>=20
> This does not seem to be a standard pattern in the kernel currently
> so it is not implemented. Values observed on tested devices are
> instead used. The driver or the devicetree should be should be
> extended in the future to take versions into account.
>=20
> The pinctrl name follows the convention proposed in
> Link: https://lore.kernel.org/all/20250524-b4-max77759-mfd-dts-v2-2-b4795=
42eb97d@linaro.org/
>=20
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
> =C2=A0arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 10 ++++++++
> =C2=A0.../boot/dts/exynos/google/gs101-pixel-common.dtsi | 30 +++++++++++=
+++++++++++
> =C2=A0arch/arm64/boot/dts/exynos/google/gs101-raven.dts=C2=A0 | 11 ++++++=
++
> =C2=A03 files changed, 51 insertions(+)

[...]

> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi b/=
arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
> index d6ddcc13f7b20c6dfbe92e86abafe965870d0c78..3362ad89ef6bacb7349259cf9=
e14452193ff7361 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
> @@ -10,6 +10,7 @@
> =C2=A0
> =C2=A0#include <dt-bindings/gpio/gpio.h>
> =C2=A0#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> =C2=A0#include <dt-bindings/usb/pd.h>
> =C2=A0#include "gs101-pinctrl.h"
> =C2=A0#include "gs101.dtsi"
> @@ -99,6 +100,16 @@ &hsi2c_8 {
> =C2=A0	eeprom: eeprom@50 {
> =C2=A0		compatible =3D "atmel,24c08";
> =C2=A0		reg =3D <0x50>;
> +
> +		nvmem-layout {
> +			compatible =3D "fixed-layout";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			fg_state: fgstate@42 {
> +				reg =3D <0x42 0x17>;
> +			};
> +		};
> =C2=A0	};
> =C2=A0};
> =C2=A0
> @@ -188,6 +199,18 @@ usbc0_role_sw: endpoint {
> =C2=A0			};
> =C2=A0		};
> =C2=A0	};
> +
> +	fuel_gauge: fuel-gauge@36 {
> +		compatible =3D "maxim,max77759-fg";
> +		reg =3D <0x36>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&if_pmic_fg_int>;
> +		interrupt-parent =3D <&gpa9>;
> +		interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;

small nit - for consistency with other interrupt specs in this file,
could you switch to using interrupts-extended please?

Cheers,
Andre'

