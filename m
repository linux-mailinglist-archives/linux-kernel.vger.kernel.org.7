Return-Path: <linux-kernel+bounces-825024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7874B8ABBE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832E05A598C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48718272E54;
	Fri, 19 Sep 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mlhjjq8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958927464;
	Fri, 19 Sep 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302401; cv=none; b=nLALlo5e+XkX+WU5F9RSYOYjRpVXUK2IkAPHwXuB6lU3DW/lgcBeD8QJBONPYWaQOKZmsdHQLEGSh1mcU5CFuckd5k2gW9dHnhTybj0PiarLrMRNOMhThmk7nCqXA7nWcp2gkU+o0fso1JvfUGVzP1njWWHNibKiUD+ZQVN1Kpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302401; c=relaxed/simple;
	bh=P8x/eMZ4ysHf6169CDhNGxNw96kygqzrg9hkanFrlGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2Dlzq+cLSxQYFMGiLH0Ma4tNSWpaa71SW68n+2xXJRElG4lzweSxrQsN/Pz+2EAU8act7Zhw2tAYeKhfjeDvDOO4HGHL8cEtRRm2jbg7YP7YTrenU007SFH7wbsh1oGePtd06hlwvyi9IFILpRMXfObC3xRb5deHpQ2PatuROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mlhjjq8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ECFC4CEF0;
	Fri, 19 Sep 2025 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758302401;
	bh=P8x/eMZ4ysHf6169CDhNGxNw96kygqzrg9hkanFrlGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mlhjjq8WDK42H4gNlUa4mYvFKEzxmrU5EI8zJv8/w8qWavmR/5R8F6plDcxGBgQCH
	 DUbFcBRjxDQ8xCqlrYIAlLuiJyoR+uOkcsn85uWMEbMk8zr4rHRxm28IQZeFZ7tx2E
	 Q3Nf1zcQxLKh6HWkTywOj6dYC8tdWRzrj/c9taFU483ZLbuULWTRcq7yyKwDvOdcRN
	 HV6Qq7QXzeezUCD3WSzgOIrkeB7EPv+nhJxt0pAaQvLYmscvp8GCpHs/HOIC8IWeli
	 my2Gg/BbGOdn0yN9o1Dv5oqaVXLJqgAe7c1rn8xXTj8VuSYKqZ6ebt9hkHoYt1J7mn
	 K+nHrgqqf4NEg==
Date: Fri, 19 Sep 2025 18:19:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, gregkh@linuxfoundation.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: dwc3-imx8mp: dma-range is required
 only for imx8mp
Message-ID: <20250919-margarita-upon-689b3c7a7739@spud>
References: <20250919062534.2443959-1-xu.yang_2@nxp.com>
 <aM1+3WMeFln6pHwF@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vz/GWGcyBaaMSPo6"
Content-Disposition: inline
In-Reply-To: <aM1+3WMeFln6pHwF@lizhi-Precision-Tower-5810>


--Vz/GWGcyBaaMSPo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Vz/GWGcyBaaMSPo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaM2QuwAKCRB4tDGHoIJi
0h7GAP9NaCBsLswpHXyt3d3r8bi33aL/tmxH6vAEgQ4e/NCLDgD/cEWbZPVs3LvQ
ztFKwMCIwRmQvql61+SgPZIkT7tIRQk=
=7Jw1
-----END PGP SIGNATURE-----

--Vz/GWGcyBaaMSPo6--

