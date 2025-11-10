Return-Path: <linux-kernel+bounces-893989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD5C48FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9235234AFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50959331A72;
	Mon, 10 Nov 2025 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpqC+x8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E578186294;
	Mon, 10 Nov 2025 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802735; cv=none; b=kC5Q46DzcjdrVP5SkUebDSWsfFsAQWKlaOEF/Oh8YkPdwzlFfccvX4NbdMM+7WPJL8OB7dr0oeJeRiMJrn4C4qdiOJCfmASGBIiPLOKfOlQOHU4IlEcfj9AbMQDllETRsKMkaWku3+k7nbuiHKOtNG36nO14wrYvxvmJJ35qoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802735; c=relaxed/simple;
	bh=GrymXJeErTy9u70PVzPmfw43ubyTayEwBn+LiCzgBE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwidPniZDUEpXJSoBBNCvebIm4GHk9NH1eJ42d9k2I9XHLz3Wyq18xYiRx9tAcAsh7zJos2yLxCdcdujOaqcm5lb/YjA2TxqrSn8hyyIM+d9djiN5bws++IbDF5VL4NTqKOeCkjTGVVzTVuaUloVm513OF4iS12gpfJIFGMxC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpqC+x8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E9CC16AAE;
	Mon, 10 Nov 2025 19:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762802735;
	bh=GrymXJeErTy9u70PVzPmfw43ubyTayEwBn+LiCzgBE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpqC+x8V3BJ6v7fmFkIt+t3dVhDH0GKKdgDZh1nM0OX818sGDugtU8rjaIBwPdmKF
	 QiEAvjcAlzFdMnYeBsYbJXlzbd53uuAdTpD+Si2EO8CF5/l2w6IkrAGj7h0drqhYHk
	 zhs/qLZU8Ti3aUUAB6VDwUTDs4Yc2BpZCv3bMcgTEKKeKpHHPWiGfrGv1HUUY6bbaa
	 8eiRsMGt3WbjCUNz2oUWjf+1KVcEWr4yHx07JgpWdX5GZ2IBw0Wn0s6pCx+ubse27h
	 ay/YPZh79ewOXvUjiJMCAOmnLNtXfMj0c/YXq+74ER4kBPBH6xuu+hsRw8IefMlFcX
	 kRcF6RUdPZdug==
Date: Mon, 10 Nov 2025 19:25:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Andy Yan <andyshrk@163.com>, Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC 08/13] soc: starfive: Add jh7110-vout-subsystem driver
Message-ID: <20251110-acetone-slinky-0f8e81291371@spud>
References: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
 <CGME20251108010504eucas1p26e8ee9aa88ab75bebd832eaea81720e9@eucas1p2.samsung.com>
 <20251108-jh7110-clean-send-v1-8-06bf43bb76b1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6w1nrcqngNa0tVG"
Content-Disposition: inline
In-Reply-To: <20251108-jh7110-clean-send-v1-8-06bf43bb76b1@samsung.com>


--d6w1nrcqngNa0tVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2025 at 02:04:42AM +0100, Michal Wilczynski wrote:
> Add the wrapper driver for the StarFive JH7110 VOUT subsystem.
>=20
> This driver is responsible for managing the shared resources for all
> video output devices. It enables the PD_VOUT power domain, enables the
> top-level NoC bus clock, and deasserts the main bus reset.
>=20
> Once these resources are active, it calls of_platform_populate() to
> create and probe the child devices (DC8200, VOUTCRG, HDMI MFD) that
> reside within this subsystem.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS                                  |   1 +
>  drivers/soc/Kconfig                          |   1 +
>  drivers/soc/Makefile                         |   1 +
>  drivers/soc/starfive/Kconfig                 |  25 ++++++
>  drivers/soc/starfive/Makefile                |   2 +
>  drivers/soc/starfive/jh7110-vout-subsystem.c | 117 +++++++++++++++++++++=
++++++
>  6 files changed, 147 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 052876c6538f980f75ff64e78b6ebea460307904..74e562a6b57ac9f776c4be2d6=
f0977c62bc03d46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24051,6 +24051,7 @@ F:	Documentation/devicetree/bindings/display/brid=
ge/starfive,jh7110-inno-hdmi-co
>  F:	Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-mfd.yaml
>  F:	Documentation/devicetree/bindings/phy/starfive,jh7110-inno-hdmi-phy.y=
aml
>  F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-vout-s=
ubsystem.yaml
> +F:	drivers/soc/starfive/jh7110-vout-subsystem.c

The parent directory that you've created here for the driver (or created
in a different patch) should probably be added to the "RISC-V MISC SOC
SUPPORT" entry, along with the binding directory. Otherwise I'm probably
not going to see the patches for the former (Emil maintains the
plarform, but for $reasons I'm the one who applies patches and sends the
PRs to Arnd). Think it used to be there, but got removed when the last
(only?) driver was moved out.

--d6w1nrcqngNa0tVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRI8JQAKCRB4tDGHoIJi
0iL7AQCiyLJiCSE3NKVn/dTVaRDq4/xjTR7nxORX6exO8YKwTAD/f4qo7cSk4n8+
BG25eAfUyQihtYUjB8FnpYKCw2j6mQ8=
=kAFU
-----END PGP SIGNATURE-----

--d6w1nrcqngNa0tVG--

