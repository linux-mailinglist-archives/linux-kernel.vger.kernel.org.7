Return-Path: <linux-kernel+bounces-825023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AA5B8ABB5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DFA1CC546D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649A257852;
	Fri, 19 Sep 2025 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iymj/G9D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D437464;
	Fri, 19 Sep 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302369; cv=none; b=H2oIeQSior+iBeEcVlzq47WdScL2NpM9athyHErzqAhYhERmwZSgHpHhe8Z3052Yar1adKeE3nJbJzDrJk4pvtf5IG40U4jNiTaVk/IcLmJbhlBzY7NBup6qZeOsha0a0SaDX2C2+eRoCLeHvEkLm67Qv+aY8xHB8dAgFfqjiVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302369; c=relaxed/simple;
	bh=28A9uM4X7e2ZNVe8qhQ8fIkUj3C1V3V4fslqHjLnzfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7svdhP0CGB6y5CuAdHkEl+mD0GmR8ZnIGpjEMMR38qW+bQopzzwf2/hzBbfomvwKWOk0n64I1W4vrKOgWxxE6r6K1ejiPfkwP0B3Tmif/UDLNuUBgWwqEYZzF2p8uBv6rKkqAKLSC2I8UyJCJ1Iy9Kj9TXR7bk/MUusA3pw33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iymj/G9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8C4C4CEF0;
	Fri, 19 Sep 2025 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758302369;
	bh=28A9uM4X7e2ZNVe8qhQ8fIkUj3C1V3V4fslqHjLnzfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iymj/G9D84B9WaNlTScmWaoN/OuOIZ0zHkTtCLhUvHvmcXXNRfZkG/+9l6FMnOGrz
	 oad1I/J7yfBgF2A+A2bcmBabIpIE1nbTlEV2HGCz0mN9qHvFDzVkNq632CCTA/GSj4
	 BvJDOwuRq67pNNhvgYyR657M+7nOA7HgnMeWHDnfb/kFLvzEl8LfNLivaJH4u4BcGM
	 neoPY3+Grb3E3eGDu+9kbbnJa7ZQB704U8f6q/hDUy0zrIMFRyyXBdh+zjPLgMG9Sp
	 ofSlngt/HlmgqRvz4rz9BjvUS4UxL4RQTVUu4dNiZc/9YWJZeu4zxOlQEwrvMLvwG5
	 jrxjMw2fr+GzQ==
Date: Fri, 19 Sep 2025 18:19:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: clock: nxp,imx95-blk-ctl: add support
 for USB in HSIO Block Control
Message-ID: <20250919-dedicate-dowry-cd9b408a66d0@spud>
References: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
 <20250919-usb-phy-alt-clk-support-v1-2-57c2a13eea1c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4FmryPusHC6DnCgr"
Content-Disposition: inline
In-Reply-To: <20250919-usb-phy-alt-clk-support-v1-2-57c2a13eea1c@nxp.com>


--4FmryPusHC6DnCgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--4FmryPusHC6DnCgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaM2QmwAKCRB4tDGHoIJi
0hidAQDbsEO3QRwY4G2oIVCB5TSVdSmQWhyUOe76nIh68pLsPAD8D16pfZ5hXBSX
oexTv2EHkYMIE3HIFguwNVJULkXCzAs=
=IHUS
-----END PGP SIGNATURE-----

--4FmryPusHC6DnCgr--

