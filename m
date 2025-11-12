Return-Path: <linux-kernel+bounces-896758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFAEC5128A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37E544E4679
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4592FB968;
	Wed, 12 Nov 2025 08:45:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B042F531C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937112; cv=none; b=iybGdwqRsICeTq4dZ83Qn1BDnhNaDx1AwszQeszChR2TaMWQW0HXyZkdL8iwkpYQYSkeC3zlTE4YWiNmCjr+DSck6/U5U/QjfkLsk+nUkCk7GqUfiEBfZpnz124TlyNsd2txpuLQXMjp9mrUm7+97sNYLA0WyfgjCHvFs3Nfa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937112; c=relaxed/simple;
	bh=dbthEIOvDC6vM52YAMeye5jTlYYAk8oYzKbjEca+jc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9Y/g+wN9eaTFS+V5nIf4orZU2bKUwB0DKP5X2RHloPDIcRcXWozPnEaCl3f7zq+VIFBfzdctByIprnmueAZoXfICarvsMQXpQ4YXymOp67zvzJsBVRibrfIhVYPIhI6Jd0p0zH6OJTuWaY8hA2fgpqRK8HtCgz4DagxjngWSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6T8-0001qQ-9X; Wed, 12 Nov 2025 09:44:46 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6T6-0003Hx-34;
	Wed, 12 Nov 2025 09:44:44 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8D2B349D91F;
	Wed, 12 Nov 2025 08:44:44 +0000 (UTC)
Date: Wed, 12 Nov 2025 09:44:44 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/8] phy: phy-can-transceiver: Support TJA1048/TJA1051
Message-ID: <20251112-vivid-mysterious-guppy-3bc98a-mkl@pengutronix.de>
References: <20251001-can-v7-0-fad29efc3884@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybnlldmwtejuzxbv"
Content-Disposition: inline
In-Reply-To: <20251001-can-v7-0-fad29efc3884@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ybnlldmwtejuzxbv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/8] phy: phy-can-transceiver: Support TJA1048/TJA1051
MIME-Version: 1.0

On 01.10.2025 21:22:31, Peng Fan wrote:
> TJA1048 is a Dual channel can transceiver with Sleep mode supported.
> TJA105{1,7} is a Single Channel can transceiver with Sleep mode supported.
>
> To support them:
> patch 1: add binding doc
> patch 2/3: To support dual channel,
>    - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
>      has two channels.
>    - Introduce can_transceiver_priv as a higher level encapsulation for
>      phy, mux_state, num_ch.
>    - Alloc a phy for each channel
> patch 4: Simplify code
> patch 5: Add TJA1051,7 support
> Others: Update dts to use phys.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ybnlldmwtejuzxbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUSPkACgkQDHRl3/mQ
kZySvAf+OFcIv9Q1NDa53XdFIdOJfnQshUo1IZMggqNsuPNzMQKJ6R564JfdKSe+
SDr8+3X7K7je0ZNjGNwBlqG67+AUU/WGW2v4ZOEkabVxnNEVbPHz7qJwLmYUs9b3
vOSIMe0uxsXGVN3aFHsbC6kOB3wahwNp/1IDYdmZa/z6YOwA3bQ3eJAiqnbEuQWW
leNCXauhnCw+WTtCdSLzQN7vLWnWKnRFWmuGfFTAK4S8/vEqOc6Y1p/ThTv8wOIh
4UfcCqqRvH6zUWh5SbhQyANm9bO/qbbs4P4qRGEH+0X3/7oCKWc2VAI0lGQ1ndtf
5G51bBe28y6IHAGpb2c1rGNXLw8Cgg==
=tFN5
-----END PGP SIGNATURE-----

--ybnlldmwtejuzxbv--

