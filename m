Return-Path: <linux-kernel+bounces-753373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6038BB18205
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFA04E7850
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6124728A;
	Fri,  1 Aug 2025 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4q1fHlS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18789238142;
	Fri,  1 Aug 2025 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754052954; cv=none; b=uzm3sqyZIICifaAs9TM++jBn84L/QyySulEi9V4ea3XdYJ6/NqTUpr21w98KD4dPS53mUhmzAjUCPJPUH0VRlV3lz1TlNTVmRHd1NBjsM6Sw7QFVnFK2sp9B/wItcO0TINWKPBDpnFNkWjOacaWf/jeO78+5OarLYpjGDvj36Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754052954; c=relaxed/simple;
	bh=pUtTWnJnFCUFZnOCDhSCjqlj1w/7DHhEYnzdKUIWCGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=df97mp4toMdR3doA9MLy2XpjytYMvqXdVpzsa2hvgxIfGgpnAgBQ/31psOsZFwe0qjX/0PZ4p68dhc7m9YPRVBUAS2XQXDcWZijTgbU/2SYLivQMOIkFuut5rcG3dJmKRhH1BgANwGiveCwofHcBUEhG163JKro1HYoMNA7MW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4q1fHlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07280C4CEE7;
	Fri,  1 Aug 2025 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754052953;
	bh=pUtTWnJnFCUFZnOCDhSCjqlj1w/7DHhEYnzdKUIWCGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4q1fHlSZqScI1D+FYZNRuBmbRKsUuAL19Fff9b5hfrsGDU7TOx0e7nuTJ6H8edA0
	 lFMK0Dh27cnAmrPkOL02WAPXsZD/U0C6Iy8rFAWNivNHy9MCFomJcPOH4FwC/m4J+9
	 6w4CtFk/aifSDnBeLk8aNJQaFgryEv7YmA6BzYkUex+p/fNOZFm4TAIrwhCzdH8y1x
	 SD3/fuaogok4GYXou0SeXlvfXdG2OLy61IaNW6NKYjb4lhOtbohBr5DETMso6Ej/1f
	 EMWAGVMe1XqOBFkFhDln5EpwqvEjghte/vcLcQD2vW3HSJzHatla+B9YZpnGbW7zAC
	 UTCKAgmiN7JPw==
Date: Fri, 1 Aug 2025 13:55:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Shawn Guo <shawnguo2@yeah.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Message-ID: <59b874bf-e23b-40c4-b095-016fe6b14ed6@sirena.org.uk>
References: <20250610160152.1113930-1-laurentiumihalcea111@gmail.com>
 <20250610160152.1113930-5-laurentiumihalcea111@gmail.com>
 <aHDNmVE23O4V4rqJ@dragon>
 <69f6a044-be90-490f-b0ad-e7867a4825da@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="giqwk26NsK1VBXtr"
Content-Disposition: inline
In-Reply-To: <69f6a044-be90-490f-b0ad-e7867a4825da@gmail.com>
X-Cookie: Who messed with my anti-paranoia shot?


--giqwk26NsK1VBXtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 01, 2025 at 03:36:01PM +0300, Laurentiu Mihalcea wrote:

> How should we proceed with this? The fix for the issue reported by Alexander
> Stein was already picked up by Shawn via [1]. We also have [2], which is meant
> to fix the Verdin issues pointed out by Mark. However, I'm still unsure about the
> EVK issues reported by Mark, which I was not able to reproduce on my local setup.

FWIW the EVK issues are still present in -next.

--giqwk26NsK1VBXtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiMuVIACgkQJNaLcl1U
h9Ddzwf7B+1qvYnmWp1lrZr/Rt+m6pRPpt7K9BLW6292BCBsvBTh9lApj7nBItkN
Q8GNfxqVr5+tKBzyyzMj0p+0Ey//XcbAHM0y6SYHolp7t0Xarltf/4M9tFlgZWr1
qyOixSeu4dD6bMZLRg0UkBbAi0mAlfj3yPvpfLch+t9H9kdDJZ2GjrGCErdSSjEW
tbEonKmQ9pEcjxRw4DOeE+DvSeZ+i4nLBj0NiqMDoIIMe/Cz/uVTVDa1zlki0Qyi
/mb74K82IA+7oRtKaKIrV0qlUg4NixhoTehWmykKG3Ihwu6NjHK+cnG+ThmdgN4T
EdQWGyarTplqMDK7aaeRxl8Pc464bQ==
=leE3
-----END PGP SIGNATURE-----

--giqwk26NsK1VBXtr--

