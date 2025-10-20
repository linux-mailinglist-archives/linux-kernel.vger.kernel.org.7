Return-Path: <linux-kernel+bounces-861413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8ABF2A91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED4E1895076
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62704331A7B;
	Mon, 20 Oct 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0N7qB7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB11D5CDE;
	Mon, 20 Oct 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980536; cv=none; b=PP/5Fm/iReGM9lDgKdU78HQyMun1biBLibNxXuXCuvqfVbWF9iW4oNlqW/6qGKNFzdHk+495sjUmabo4NLRBFuJU7Jm5/Zw46PBe1cTUiVxSo2e8Kd3ZZKYEnv+gwB50ge959vJSa84OEWx8sCKJbd5PzmKi2W6j0q893+p0rTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980536; c=relaxed/simple;
	bh=QFq5LOrpzBT+0cc2xULTJJjO/I/ewFbE34Rwz7Vzghc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTfeEvB10bJ/aAlqUMzawGxFrp1LB6cX2kR3GmXjOa59LKOyJseBsAsHPrety6a21cDefyvTfrSohKeeNB2pcauQfGXY/grUyC7pHWhVzj4jo+viBRBGkJmM/wDPQxNbzA5Emtanl5kVrJgB8pd6+C6p/Vkr9RgKmeHhXbSpP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0N7qB7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5DFC4CEF9;
	Mon, 20 Oct 2025 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980536;
	bh=QFq5LOrpzBT+0cc2xULTJJjO/I/ewFbE34Rwz7Vzghc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0N7qB7eyOf+og4EajM32N6iSDRWii4pM4IRcRrlLHUUVPxxeAz/pUZH5GMV0asoc
	 a/Df+2Ka9Q2b6okE6DBFL3ITMbpWGE+y+MbvRLu0+t+PJUS719uYEWje+KG8ITeCFH
	 ozdIKrp0R1hh96xNsggx5xkzmrCKG0fZ1isIa+sTaA/OMuxB+xwEciezZz3clKHFWF
	 0NtqxouSG8TySG1CitJoiLEi0iSaKLxoJxib5jZhg2ag/9aaE6/VeJXwjXMF+XwYzq
	 JGR4rmdw9/AMzO0kMie+fivm5M/VNz4r1QkijaZdvhVHaeNmO4QkApK7JwQNJuSqzo
	 +yaddHAuR95gw==
Date: Mon, 20 Oct 2025 18:15:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: add TQ-Systems boards
 MBLS1028A and MBLS1028A-IND
Message-ID: <20251020-closure-eating-5562565a4032@spud>
References: <20251020133536.303471-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y5gaGBfQOuF8CKPP"
Content-Disposition: inline
In-Reply-To: <20251020133536.303471-1-alexander.stein@ew.tq-group.com>


--y5gaGBfQOuF8CKPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--y5gaGBfQOuF8CKPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZuMwAKCRB4tDGHoIJi
0idqAP99wn9rZ3vdX/HiKOVJU/T6U0epcn96qhI5HbBPOZrMCgD/fDSstymKGmQ+
e0eW7q6qrX43inmNTqVE9GCARUNQpAU=
=f5RB
-----END PGP SIGNATURE-----

--y5gaGBfQOuF8CKPP--

