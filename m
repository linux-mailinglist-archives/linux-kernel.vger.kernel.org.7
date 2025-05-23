Return-Path: <linux-kernel+bounces-660569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D639EAC1F70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 11:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0063B3BEBC9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EDF224243;
	Fri, 23 May 2025 09:11:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666C72253A9
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747991472; cv=none; b=Whv8Ur/a/xbtjQrmvmZ44dWxwk6QipDAv+OATKw4NHYBz/+sNQkfxzT41AEMIfaE7IC9Iwp2VOSZet3qy/VuskYzu5bWcbfGV3JoTqD3Z3Qon1VdlZczdm1vNpElbJZE1m0GLjI3k/7ilhBRnK/UdfgCPILs2mMMg8YLpvpK8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747991472; c=relaxed/simple;
	bh=eexH6QMbd2Kh/Ok2YWOCEhjR9QzioGxm6Cv/En2atvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaC1d2Yxg4/QHArFZfvMrMlL+hfw7/7XWgZM3TFAcnN2Bsxr8YlkpRmw/rQRntLojnNhlHwdNITy4YITnLp3K4WD1JIXwSusbg3rQivkPY9UUgOhEzbcAhUcX1kDb6F+MbensmfSljLD07p3qhPxN/F4M5eU/gLMD5CJKHkNpVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uIOQI-0005Zj-48; Fri, 23 May 2025 11:10:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uIOQH-000sRD-1o;
	Fri, 23 May 2025 11:10:37 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009:2000::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 840C141822A;
	Fri, 23 May 2025 09:10:36 +0000 (UTC)
Date: Fri, 23 May 2025 11:10:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/4] net: can: rockchip: support dma for rk3576 rx
Message-ID: <20250523-shrewd-berserk-sheep-315ac5-mkl@pengutronix.de>
References: <20250523075422.4010083-1-zhangqing@rock-chips.com>
 <20250523075422.4010083-5-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="el4f565f524arurf"
Content-Disposition: inline
In-Reply-To: <20250523075422.4010083-5-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--el4f565f524arurf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 4/4] net: can: rockchip: support dma for rk3576 rx
MIME-Version: 1.0

On 23.05.2025 15:54:22, Elaine Zhang wrote:
> The new can controller of rk3576 supports rx dma.

| drivers/net/can/rockchip/rockchip_canfd-rx.c:297:47: warning: incorrect t=
ype in argument 1 (different address spaces)
| drivers/net/can/rockchip/rockchip_canfd-rx.c:297:47:    expected void con=
st volatile [noderef] __iomem *addr
| drivers/net/can/rockchip/rockchip_canfd-rx.c:297:47:    got unsigned int =
[usertype] *
| drivers/net/can/rockchip/rockchip_canfd-rx.c:299:44: warning: incorrect t=
ype in argument 1 (different address spaces)
| drivers/net/can/rockchip/rockchip_canfd-rx.c:299:44:    expected void con=
st volatile [noderef] __iomem *addr
| drivers/net/can/rockchip/rockchip_canfd-rx.c:299:44:    got unsigned int =
[usertype] *
| drivers/net/can/rockchip/rockchip_canfd-rx.c:302:58: warning: incorrect t=
ype in argument 1 (different address spaces)
| drivers/net/can/rockchip/rockchip_canfd-rx.c:302:58:    expected void con=
st volatile [noderef] __iomem *addr
| drivers/net/can/rockchip/rockchip_canfd-rx.c:302:58:    got unsigned int =
[usertype] *

Install "sparse" and compile with C=3D1.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--el4f565f524arurf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgwO4UACgkQDHRl3/mQ
kZz30Af/SIdkXHiO0CuLJro2DVr7juoDO/LnF1KqldXc/haDI6pxWfU2dx8oBmQm
x1wOLu5MWD0dvDB/R8ZBirZ87apAG+9QHJuaUHtiYAcwTzR4WWnRFPaqwonwNd7H
x4b/Rs5FcRhd+zeisoHMz9siFjTtTI7I5n6w/1jW5u6Tr/6xxLOhbWbhaNM74G+n
pSczJTP7HSSR/umMuVMEV53owHa3pK05izJCdENRzg2iLSrBR2/51jBW3IpRwq5f
3VvSodv67x1rpip453K0NUU43qqoqa04E/XPH5WP4Lt5llHVNqbh/1f8F0TMMe2p
KoEaxA4D3GmHFgFUM+0BIPa2aFFhGA==
=e387
-----END PGP SIGNATURE-----

--el4f565f524arurf--

