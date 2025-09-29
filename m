Return-Path: <linux-kernel+bounces-835704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9FCBA7D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857657B1CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270921FAC42;
	Mon, 29 Sep 2025 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="HRLst9SK"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF734BA50;
	Mon, 29 Sep 2025 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759114846; cv=none; b=FPOTSCcXf6IFZeCuTaE2LKD+f2Gg1YUC9Xj7YVS8BFomVBx5/ItqBhJbog5LvJ32I8Zbx7lxVP5D2gxpnkV5Ro3UD9tbqL/81d9i5DIoHxTl9ZZLXMpcG3iciKjCnbkLZ5o6spAn+Xw0M1Sd2zDwekW51m3/LFUbMu+kImf4uhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759114846; c=relaxed/simple;
	bh=AX+HtxQwX/CQn/4KH0a8zO/HgtliXZqH7S+3rwGIr8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nLm7xIjBbff+aIkddrr0LxfjQVbR67/HPMiPXeKX8/o03qFhSrrdTqvl9KS0IE00MON0weRnyuLT+sLZca0hi3+DYV9SJ5/PXq+B12wZblIFQRk2oNxVszToje4fYTGk8JZv3TQsyRZqgACwhvmAwLBTjMZZO1rInFUaUOXRfto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=HRLst9SK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1759114842;
	bh=3o5g8tvyc3D5BhQU0C72eF73whM2PpU8XTbC1Wbal6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HRLst9SKQFYHPBDXalgv2GH3AOBfYn5FtMoqylSFlM5xLd60OVnv2uYzoWw1eJWe1
	 3FC9W6TKr/wesqHqxt/JqmNJCgKAAzfXplAGDtStVKHvGn3KSe/mxQ13whXLUqAn+1
	 mBW7yxhnH9DkJxBmuEgjr3youMIAwnlpP4RbZh7BWmVfEEUvNKRawh5pqhebs1mP4m
	 qPUWq7H52YhYtewqIJzcTWDMC0C+dZcxglDyJ9EyOwgN9CSwudNN6CithFZ5FhK/lt
	 qn2DnrmVeyAiknzT873AhjSeWDyAlyvFfSCfaxCCXnfQeU4yobhhJWnU3h9SgfyfdO
	 SBOsRdItzNdbQ==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D51C964782;
	Mon, 29 Sep 2025 11:00:41 +0800 (AWST)
Message-ID: <deb2dda58b923f2ae362dc19164dc845c4757e12.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: clemente: Add HDD LED GPIO
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
	leo.jt.wang@fii-foxconn.com
Date: Mon, 29 Sep 2025 12:30:41 +0930
In-Reply-To: <20250926-leo-dts-add-shunt-resistor-v1-1-c871a68792f0@gmail.com>
References: 
	<20250926-leo-dts-add-shunt-resistor-v1-1-c871a68792f0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Leo,

On Fri, 2025-09-26 at 17:37 +0800, Leo Wang wrote:
> Define a GPIO expander pin for the HDD LED and expose it via the
> LED subsystem. This allows the BMC to control the front panel
> HDD activity LED.
>=20
> Changes include:
> =C2=A0- Add `led-hdd` node under the LED definitions
> =C2=A0- Name the expander pin "HDD_LED_N" in io_expander13

Can you please drop this "Changes include" section? What you've written
here is plain to see from the diff below. The commit message should
explain motivations, concerns and trade-offs, and not be a wrote
description of the change. The documentation on submitting patches
explores what's required:

https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es

Cheers,

Andrew

>=20
> Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 7 +++++=
+-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/=
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
> index a614f947dafc9a6628c3f3d45b62ff3ca9d2b618..450446913e36b1418fab901cd=
e44280468990c7a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
> @@ -95,6 +95,11 @@ led-3 {
> =C2=A0			label =3D "bmc_ready_cpld_noled";
> =C2=A0			gpios =3D <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANS=
ITORY)>;
> =C2=A0		};
> +
> +		led-hdd {
> +			label =3D "hdd_led";
> +			gpios =3D <&io_expander13 1 GPIO_ACTIVE_LOW>;
> +		};
> =C2=A0	};
> =C2=A0
> =C2=A0	memory@80000000 {
> @@ -1199,7 +1204,7 @@ io_expander13: gpio@14 {
> =C2=A0		#gpio-cells =3D <2>;
> =C2=A0		gpio-line-names =3D
> =C2=A0			"rmc_en_dc_pwr_on",
> -			"",
> +			"HDD_LED_N",
> =C2=A0			"",
> =C2=A0			"",
> =C2=A0			"",
>=20
> ---
> base-commit: c65261717599d419e9c683d85f515d3ca2261549
> change-id: 20250926-leo-dts-add-shunt-resistor-0cba43f75bce
>=20
> Best regards,

