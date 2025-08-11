Return-Path: <linux-kernel+bounces-761861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F0B1FF60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E19E3A54C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B782750FB;
	Mon, 11 Aug 2025 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="08oRKhIb"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C57A13A;
	Mon, 11 Aug 2025 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893843; cv=none; b=TKGdDA/CfU7vsBKtWk1682p/2i6Ejrrk1JMjr/fNeXhxI5pGwV4HY7BDR34X2XJX1T3pRWt2YnevFCfr/4LLDeZCQf32VPEohQLizp2uvxM0XwCC9wV4g1y83yd942T+1tHZpcu9cpW06wXrPBTvWegQtDXJxjRh7ZyKXh7obvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893843; c=relaxed/simple;
	bh=27tLMUvOEGy4QmNScTkSr+2tmFWJPWt+RemyBMXltYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6IJevBxHQatPTgwLknyGqDrn0F2aRFoui7VPmrpUCeuS7A5qR2axWjs/0L8exeIqWxKTCadDU1n6fwnjaqtRO2majAosncjIRixlVlwj2I2t6agaxFkzI0tu8KAR7hUTcUgZ0MVdt/8+HqX/of5+0iQiajl0l08/e4DM+TstZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=08oRKhIb; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=jNzVtAsxtGf0lFnJlcfQ3TByjHHmjVeIgw7TiXHmnEM=; b=08oRKhIb1ajpli+TpTvmpRH+tl
	uEKnt6dZtNTopvuqjd613RK0L1/C0hYvZLIhNJjsKR93y1tgjTSYRQPSp5XUObmHBljtmdjC59nw3
	IN3ZtZb37VTpoI+kgkG2ucskyqnRCxJLr3i23yOwX2vbIymb2SOaAMpt3vDnoWx927okoBLRIXSUc
	CMF0m69rvjfBjrIDPSMgYpT8AK9KOinsArvfGZxqL0qlrED7VdOXHRxnniK15BmfWb9OCUto0h4PM
	jhmvqwZdw+GGuKkk4/hCozET4ujSOKMxXAi4hFT2S2NKAR/XnK9xufGxP78quMKKJsd65E+ots8o+
	EQ1ZgrTw==;
Received: from i53875a0c.versanet.de ([83.135.90.12] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulM33-0006sA-Nx; Mon, 11 Aug 2025 08:30:21 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject:
 Re: [PATCH 1/3] arm64: dts: rockchip: disable display subsystem for Radxa
 E52C
Date: Mon, 11 Aug 2025 08:30:19 +0200
Message-ID: <3125650.687JKscXgg@diego>
In-Reply-To: <20250810100020.445053-1-amadeus@jmu.edu.cn>
References: <20250810100020.445053-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Sonntag, 10. August 2025, 12:00:18 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Chukun Pan:
> The Radxa E52C SBC do not have HDMI output, so disable
> the display subsystem.
>=20
> Fixes: 9be4171219b6 ("arm64: dts: rockchip: Add Radxa E52C")
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

What actual problem does this fix?

=46or example we also enable on-soc iommus all the time, because they're on
the soc and don't need board-level properties.

The "display-subsystem" without users looks mostly in the same spot.

So I do expect a description of what proplem gets fixed that this needs
to be disabled.

Thanks
Heiko

> ---
>  arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts b/arch/ar=
m64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> index e04f21d8c831..3b519be6e1ea 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> @@ -207,6 +207,10 @@ &cpu_l3 {
>  	cpu-supply =3D <&vdd_cpu_lit_s0>;
>  };
> =20
> +&display_subsystem {
> +	status =3D "disabled";
> +};
> +
>  &i2c0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&i2c0m2_xfer>;
>=20





