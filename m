Return-Path: <linux-kernel+bounces-890850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C36EC412DB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123C21881F31
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2343396E5;
	Fri,  7 Nov 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1xoS26d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1233711C;
	Fri,  7 Nov 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538185; cv=none; b=Xze3BXx9cltkpAUaSoTtvIOUVtiTvcVyrI9x2pEmRI9qstdZ6lzFrNOqqakeqOk4aOQ3VZwrFPdlKdlKkrj+n67gEex5rfkxxJadwvlhI6vVXqM5fSxW4zjRxVW98BwwMVlGuEYNzHjyOo5IvnpncslEzwuOfdalJBuQdadh/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538185; c=relaxed/simple;
	bh=9x4vHTWLDDV/EjZbLueO2qDkSixymH79Wp6H2fnVmhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeRUkErO3610XZb37vn8LQmFyv7DZ5yz6LcAGxRzOBBRuwB8I90Sp9pew6PJfyc5zhtnbL2n/X7yngwdQyPdDXWENsCBIyiCANmEMdbbfDmbXNkF6fZnuzQyzxyK+XEwriY0ijU/hf1fhxU+rfGRjXjJEMyGnUmti8fMQRuHC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1xoS26d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066D0C4CEF8;
	Fri,  7 Nov 2025 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762538185;
	bh=9x4vHTWLDDV/EjZbLueO2qDkSixymH79Wp6H2fnVmhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1xoS26d7PrUkPjZ5qve3wL37bUFTIk5DTkt2j1bBZlXdPQrZfiNYI+1tr0YLTVx5
	 rJy/dsLIw/XpBulzSlFC0fuM41D6d1cNO+/TFEL60UeWyDQb8v9ILtcljZB/vxcUUm
	 hOUDyvzUGzUkulXkACbZjLRUApFped5PYzjxSG8gOjtebxGSm3qJVDkZHUV7IC59Ny
	 /KzolGTa1PjqFDg6/b5cbmKcV3zT/2bklBTSdsfugZNroaQ5bxBZYCoo1a+z9fxWCU
	 X63npk7V261yOxoaLYPsIarxawGSl18+gjgG5zQW96JOE4xHIsxxQz2pTWTo4qiX42
	 jYrFGOH63kcXA==
Date: Fri, 7 Nov 2025 17:56:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add Skov Rev.C HDMI support
Message-ID: <20251107-selection-operation-872d258103c5@spud>
References: <20251107-v6-18-skov-revc-hdmi-v1-0-595549e5b496@pengutronix.de>
 <20251107-v6-18-skov-revc-hdmi-v1-1-595549e5b496@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f0HiALue791MdAzQ"
Content-Disposition: inline
In-Reply-To: <20251107-v6-18-skov-revc-hdmi-v1-1-595549e5b496@pengutronix.de>


--f0HiALue791MdAzQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--f0HiALue791MdAzQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ4yxAAKCRB4tDGHoIJi
0lyfAQDVSalTcYUJmk0ioM/yeJUganCmrgpGbR20PSmMd21+bwD9HWuM9Wc0F74/
lbNwWA+HHw469PXUotscxIRfjMsmwQU=
=7C8A
-----END PGP SIGNATURE-----

--f0HiALue791MdAzQ--

