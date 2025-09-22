Return-Path: <linux-kernel+bounces-826589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B02FB8EDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2784B189925E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B42ECEA7;
	Mon, 22 Sep 2025 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PhyVxSFc"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0602F56;
	Mon, 22 Sep 2025 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758512178; cv=none; b=J+q1AFCOK+Tp/NfZZGvY1mEUt/XbWtwgQSi0yxG3gkj3tRx/heq6RXRIS/WhST9nJoROVrgU8MgEOysvHQvdiNfFvplekTcp1VS7NZl27igPmBIbNY+CCG5guQPDv8j+sGOtk33Nu03wwouFddLOhyim9xWNBMACUtxeLhTSojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758512178; c=relaxed/simple;
	bh=TIX+OPq5VsJQopdnKBQ7105sBu1OVyzJD3kp43BUElM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b9ampgDsjYsDce8tIi9ojy7CpmGlRq/DheqT/STSVOuF1I1OMuqYelqPv3i5TqVGIDE4RANWWhssQQU5qSzCT+Ub0J0NNEhDPyDElHqr7arm7TLsEhUhqpdwvklstq3x3peinY4B9DQqN5uM9OvfSxyP83RR9IXyxAdmiKM7OaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PhyVxSFc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758512174;
	bh=C/MA4CH24q3vH1Fg6NkJo5567qQeBbiW70Nn6q7iLP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PhyVxSFcTfc9Oo8dueczD60UiCANixn9E8qDfta9Ku/liDAwjXHVuX3vQnnsTrXJW
	 5ERAGjnfO5QiF0Jp+/d+0eK7IkwlFFCLbVlmAH4ahig3H73iQNgxAh67w+RG7UXo5M
	 3/9PtKiRLZiMgLKMCL9hnaEpr24Lf0eAZ41/oNFvHbezOxv9CFcTXWa5sU0jFQZqJc
	 L7XeCPEYyCbS6BDYCU63Sz662dbCACkN/l2TF0WT7KCCbVN8o8OsJCpTlyvdHG3zCU
	 us2wfYniNkbasR1sd6zDXKfcGK5+X/Od9nSaaB/AFZukn6uuE4jLfAtm0OoccZYxkS
	 89Hsty8AkIDBQ==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B4D2364755;
	Mon, 22 Sep 2025 11:36:13 +0800 (AWST)
Message-ID: <f76e867ca4dff82744958a8b555cf226139bcd78.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/4] ARM: dts: aspeed: harma: add sq52206 power
 monitor device
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org
Date: Mon, 22 Sep 2025 13:06:12 +0930
In-Reply-To: <20250917101828.2589069-4-peteryin.openbmc@gmail.com>
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
	 <20250917101828.2589069-4-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 18:18 +0800, Peter Yin wrote:
> Add the SQ52206 power monitor device and reorder the sequence.
>=20
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-harma.dts=C2=A0 | 28 +++++++++++=
------
> --
> =C2=A01 file changed, 17 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> index bcef91e6eb54..fe72d47a7632 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> @@ -353,14 +353,15 @@ eeprom@52 {
> =C2=A0		reg =3D <0x52>;
> =C2=A0	};
> =C2=A0
> -	power-monitor@69 {
> -		compatible =3D "pmbus";
> -		reg =3D <0x69>;
> +	power-monitor@40 {
> +		compatible =3D "infineon,xdp710";
> +		reg =3D <0x40>;
> =C2=A0	};
> =C2=A0
> -	temperature-sensor@49 {
> -		compatible =3D "ti,tmp75";
> -		reg =3D <0x49>;
> +	power-monitor@41 {
> +		compatible =3D "silergy,sq52206";
> +		reg =3D <0x41>;
> +		shunt-resistor =3D <500>;
> =C2=A0	};
> =C2=A0
> =C2=A0	power-monitor@44 {
> @@ -369,16 +370,21 @@ power-monitor@44 {
> =C2=A0		shunt-resistor-micro-ohms =3D <250>;
> =C2=A0	};
> =C2=A0
> -	power-monitor@40 {
> -		compatible =3D "infineon,xdp710";
> -		reg =3D <0x40>;
> -	};
> -
> =C2=A0	power-monitor@45 {
> =C2=A0		compatible =3D "ti,ina238";
> =C2=A0		reg =3D <0x45>;
> =C2=A0		shunt-resistor =3D <500>;
> =C2=A0	};
> +
> +	power-monitor@69 {
> +		compatible =3D "pmbus";

I realise you're just moving this node, but I'm surprised it hasn't
caused trouble otherwise. This happens to work due to a quirk of I2C
device IDs in the kernel but it's not a documented compatible.

Compatible strings need to represent the physical device. Can you
please split out a patch either dropping this node, or replacing the
compatible string with something appropriate?

Andrew

