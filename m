Return-Path: <linux-kernel+bounces-892234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C4C44ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A684D188B41D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B6219ABC6;
	Mon, 10 Nov 2025 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TTCVHgKQ"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29E2C86D;
	Mon, 10 Nov 2025 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762734193; cv=none; b=n7q3eui4ByWD3AFNKV2CgOho6X3uHmSpD4e/rtGRKqpqZRXxN97SpLZ33G+IqdzXwmiCWEGEctM6rXYD9IBqWWqGnV4Xj8ZyUSNUV5sDFE6CAN9YC0zWgpAgiiRUfkl3VNZ8msFgSLY4LAS+K4dUIx/VHwatZL3gVpe3wDNr1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762734193; c=relaxed/simple;
	bh=D6QCiPHzfB8QTe7/atDwKZumftiZ8NPU3M5KtswN3XY=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Qwg2QDospyerS99KVe/cLry84Z18WDdJHxqahoaYfWqSuOzttPX+gRKnlGTj6/BIwO1+8DC+Opysf+jM/sTsrIB/sKTueFmiycfKdfkx9xhTIoTaMI8RU1LVNUXxYj+8FRl+wXgZ8kwulbvnD5x2ATTkbUKYLw/ltcax/YrzIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TTCVHgKQ; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 7C55140E66;
	Mon, 10 Nov 2025 01:23:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1762734188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7BPbQiZQ1p/FzedWzhYAj/T5KEbE0aQW4yaYgMm8nyA=;
	b=TTCVHgKQL/8h1giAPMPv8LMSy5nUj5vJw409qzY4QYO+lHfiPHboDema3EVL2F5YHOPN7S
	Iz00hJxdT3YlpED5ftFuVuOZ1fKcAVs+0pTmvZBz2nvr6dpckB2XI8yMDhby71hBclJjpK
	LlOqvCqPw+N8Gw5NcQluVM9fHbanbwYe9VIXLgCg8pI2OPIvvRbvAmGqxfdA4jChX8N+Sq
	i4kAfJqpCHY7APfLUJp3zSBsp5bjUm+FG0baQx89kemZBM2Vgsn/UBCJs02c/aBBCFXdt8
	7QJYmgZJngtkeMT3/E5HGJEOfdIPXpFm+YPjYs+OziZQmc9F4b6ZWfmSr6rbtA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <20251109192128.72527-1-sigmaris@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <20251109192128.72527-1-sigmaris@gmail.com>
Date: Mon, 10 Nov 2025 01:23:06 +0100
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Alexey Charkov" <alchark@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Hugh Cole-Baker" <sigmaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <da6721a3-8f59-9c0c-762c-bc02b39ac472@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v2] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= add pwm-fan for NanoPC-T6
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Hugh,

Thanks for the v2!  Please, see a couple of nitpicks below.

On Sunday, November 09, 2025 20:20 CET, Hugh Cole-Baker <sigmaris@gmail=
.com> wrote:
> FriendlyELEC offers an optional heatsink and fan addon for the NanoPC=
-T6
> and T6 LTS, which plugs in to the fan connector on the board driven b=
y
> pwm1. Add the fan as an active cooling device for the SoC package.
>=20
> Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
> ---
> Changes from v1: https://lore.kernel.org/linux-rockchip/2025102619485=
8.92461-1-sigmaris@gmail.com/
> * add the fan to the base board dtsi instead of overlay (Heiko)
> * just use 2 trip points for warm and hot temperatures (Dragan, Alexe=
y)
>=20
> References:
> FriendlyELEC heatsink with fan addon:
> https://www.friendlyelec.com/index.php?route=3Dproduct/product&produc=
t=5Fid=3D305
> Vendor DT with trip points and PWM duty cycle values:
> https://github.com/friendlyarm/kernel-rockchip/blob/4944602540b62f5aa=
d139fe602a76cf7c3176128/arch/arm64/boot/dts/rockchip/rk3588-nanopi6-rev=
01.dts#L75-L90

I think it would be better to move these references to the patch
description, so they become directly available in the repository.
It might be the best to use the "... [n]" form for the references,
which puts them as close to the backed contents as possible.

Oh, and I think that "arm64: dts: rockchip: Enable active cooling
on NanoPC-T6" as the patch subject would read nicer. :)

>  .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi   | 39 +++++++++++++++++=
++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arc=
h/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> index fafeabe9adf9e..9164a0ee6228e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/soc/rockchip,vop2.h>
> +#include <dt-bindings/thermal/thermal.h>
>  #include <dt-bindings/usb/pd.h>
>  #include "rk3588.dtsi"
> =20
> @@ -89,6 +90,14 @@ usr=5Fled: led-1 {
>  		};
>  	};
> =20
> +	fan: pwm-fan {
> +		compatible =3D "pwm-fan";
> +		cooling-levels =3D <0 35 64 100 150 255>;
> +		fan-supply =3D <&vcc5v0=5Fsys>;
> +		pwms =3D <&pwm1 0 50000 0>;
> +		#cooling-cells =3D <2>;
> +	};
> +
>  	sound {
>  		compatible =3D "simple-audio-card";
>  		pinctrl-names =3D "default";
> @@ -591,6 +600,36 @@ &i2s6=5F8ch {
>  	status =3D "okay";
>  };
> =20
> +&package=5Fthermal {
> +	polling-delay =3D <1000>;
> +
> +	trips {
> +		package=5Fwarm: package-warm {
> +			temperature =3D <50000>;
> +			hysteresis =3D <2000>;
> +			type =3D "active";
> +		};
> +
> +		package=5Fhot: package-hot {
> +			temperature =3D <60000>;
> +			hysteresis =3D <2000>;
> +			type =3D "active";
> +		};
> +	};

It should be better to use 55 and 65 oC as the trip thresholds,
because people often report around 50 oC as the observed idle-state
temperature of their RK3588 SoCs, so increasing the first threshold
to 55 oC should be beneficial by preventing the fan from spinning
when the SoC is actually idle.  The second threshold is usually set
to be 10 oC higher, so it should end up at 65 oC.

> +	cooling-maps {
> +		map0 {
> +			trip =3D <&package=5Fwarm>;
> +			cooling-device =3D <&fan THERMAL=5FNO=5FLIMIT 1>;
> +		};
> +
> +		map1 {
> +			trip =3D <&package=5Fhot>;
> +			cooling-device =3D <&fan 2 THERMAL=5FNO=5FLIMIT>;
> +		};
> +	};
> +};
> +
>  &pcie2x1l0 {
>  	reset-gpios =3D <&gpio4 RK=5FPB3 GPIO=5FACTIVE=5FHIGH>;
>  	vpcie3v3-supply =3D <&vcc=5F3v3=5Fpcie20>;


