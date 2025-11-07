Return-Path: <linux-kernel+bounces-890866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30F4C413E0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F8A3ABBB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D41338F45;
	Fri,  7 Nov 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi5QEyLr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062032D0E6;
	Fri,  7 Nov 2025 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539203; cv=none; b=NZmgRzqBddx4INyF9lpckVGoPv4HJTQl5mIijji34EgqCS+Zs/DwrHHoPWOJjx2url3oYkZFECQvhNMkceIy7SyHWZzgzr2XtLr9q3mnLGrhXbj5jxfDCBXpkBlsQbo7JYhPOraw0sp1nDvy3l4QfjpQjL5e7t08Ol11or6YC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539203; c=relaxed/simple;
	bh=/lgbv0xkkeEeyCFTxzletftyEsQCLKdX/zZrCKZT90Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8ck54xT82OdcV5Y6G66R8hLo/xsIcn7OMcDz1/XltNhv0LHqWniArhnbpsNs7+R11H72Tl8iqTUNZU+Qj2JFEKal+UyH1Tm4aok9u6arsBz6/OgRHBztu2ofA7jD4rXKYHarZ0Q3gk9p1mbrHw5rPD1fxwJQhX5EVzpBPUrUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi5QEyLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD698C19423;
	Fri,  7 Nov 2025 18:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762539203;
	bh=/lgbv0xkkeEeyCFTxzletftyEsQCLKdX/zZrCKZT90Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bi5QEyLrlIvHfU1JgbyRk1+DvTo+x8gaYn8el+yDhjo+Q/r6xqEaJ1GCgrciPTGVz
	 SDGNRXdUSm6u6gSKlv5ANzbyxkL566qHADV8aWXLnSTXztPC2ace9lwFA3XwRy8hcu
	 ZqaImqFajA8peXiyJRkmBLtO8Kw5MlqcMjq/y7Y1hP4XdypVHjZougqdIRDW07JcRV
	 lJujxFkBr5zwfNxCjBDfHpTV0MQmMhz7Yubh4LE2+LM7eeKKgzUFcAhiCqtMmP/Add
	 Kvi6uavYpwPkMSnMwPTMnK5mwhWVqK6tSz4niZFIZ7uKbwLrZq7E8pJHcCWt6LUcGh
	 h8QxbbxL00WBQ==
Date: Fri, 7 Nov 2025 18:13:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: phy: Add documentation for Airoha
 AN7581 USB PHY
Message-ID: <20251107-marina-cramp-cf3d60a52524@spud>
References: <20251107160251.2307088-1-ansuelsmth@gmail.com>
 <20251107160251.2307088-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fzr6I2tBaj3GaUW"
Content-Disposition: inline
In-Reply-To: <20251107160251.2307088-3-ansuelsmth@gmail.com>


--2fzr6I2tBaj3GaUW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 05:02:44PM +0100, Christian Marangi wrote:
> Add documentation for Airoha AN7581 USB PHY that describe the USB PHY
> for the USB controller.
>=20
> Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> always supported. The USB 3.0 mode is optional and depends on the Serdes
> mode currently configured on the system for the relevant USB port.
>=20
> To correctly calibrate, the USB 2.0 port require correct value in
> "airoha,usb2-monitor-clk-sel" property. Both the 2 USB 2.0 port permit
> selecting one of the 4 monitor clock for calibration (internal clock not
> exposed to the system) but each port have only one of the 4 actually
> connected in HW hence the correct value needs to be specified in DT
> based on board and the physical port. Normally it's monitor clock 1 for
> USB1 and monitor clock 2 for USB2.
>=20
> To correctly setup the Serdes mode attached to the USB 3.0 mode, the
> "airoha,usb3-serdes" property is required. This can be either
> AIROHA_SCU_SERDES_USB1 or AIROHA_SCU_SERDES_USB2 and is used to identify
> what modes support the PHY and what register to use to setup the
> requested mode.
>=20
> The first USB port on the SoC can be both used for USB 3.0 operation or
> Ethernet (HSGMII).
> The second USB port on the SoC can be both used for USB 3.0 operation or
> for an additional PCIe line.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the updates.

--2fzr6I2tBaj3GaUW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ42vgAKCRB4tDGHoIJi
0m0kAP4gAHkA1J0WWkcLSZGH7kvvrR6oW8Jlf337BzlRYd59+gEAy2sT0GPBd5a+
zrhUJiag68MXCXu33BAdntJ5dD5L/wY=
=VZaV
-----END PGP SIGNATURE-----

--2fzr6I2tBaj3GaUW--

