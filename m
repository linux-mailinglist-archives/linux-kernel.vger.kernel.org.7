Return-Path: <linux-kernel+bounces-895997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E8DC4F765
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04DC64EFE53
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6E1284894;
	Tue, 11 Nov 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td5CWsFi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EF627EFEF;
	Tue, 11 Nov 2025 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886248; cv=none; b=RkKNzgEGeXalz5CEtA0JHZ5zOyjly9YhRJGtxV9amza2YVDLFaLxlyoFbqOia5z993I+FIrbqkUUEWrkTnQkK6b4jgRX/YazyxedE59u4KtziHCFZgDZMvDSYlwX1v8vJyGvBDQK43WINUgQuLJf7UlcArgBqXKf8gJIL2nlk0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886248; c=relaxed/simple;
	bh=pgKLi07v3nAzgSWrbOhew+tkCftrGPnHwK+HWRmbZgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh672mAzq7P+NJmhBqbZL5/67OqpJTdhNeFQI/HrS2U6Hz2SJaTJlfy79szAhO7ZF4qedB0j8cVjbppojjjaGlc8LVe3sZXUUNUTBU7G6J/wA+cPpLobCLvb30kNHlAWdFwvfhERNRj8i4w3r97h+LNxAVWnaWhJPtHpTqmJoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td5CWsFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A888C4CEF7;
	Tue, 11 Nov 2025 18:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886248;
	bh=pgKLi07v3nAzgSWrbOhew+tkCftrGPnHwK+HWRmbZgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Td5CWsFiCm4X1/AxMKmU39/vysxniGwqTFaV8jeP7qaIc3yIbF1rA/+YLuR6zMsf4
	 TzZ7i3+8tluttQnfUp9v5hCiYFbUfU0MNj8NSDs8ANlJhbW4W1wJY+07jc+k52guAO
	 tLNgouUqw99pq5Mv7o8Cs1G9BygfFX9HZXCykZdE6GK5yDbPMeX47V8ivCfBIFxsv3
	 TL7BN7hwsQdaMGPH/4pVTNj9tPrV2p01diVJ3OygK6ut4ZJ7jQbmbEEeAoCcHctlDm
	 aKX5cwajRuJEWXEH1AEUPJkIuxSttxv7QI5sfExLHhSH7t+d0CCfpkDGNvv+ag2N+K
	 ObPnOLSezIrcQ==
Date: Tue, 11 Nov 2025 18:37:19 +0000
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
Subject: Re: [PATCH RFC 00/13] drm: starfive: jh7110: Enable display subsystem
Message-ID: <20251111-matriarch-diocese-b314e7bdaf81@spud>
References: <CGME20251108010451eucas1p1c7bf340dbd2b1b7cbfb53d6debce7a2e@eucas1p1.samsung.com>
 <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
 <20251110-clang-baking-b8b27730356e@spud>
 <00e897dc-9966-439b-a74a-7604a1870027@samsung.com>
 <20251111-footing-eclair-332f5f0769f2@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oEuULB+ZwvMAwWb+"
Content-Disposition: inline
In-Reply-To: <20251111-footing-eclair-332f5f0769f2@spud>


--oEuULB+ZwvMAwWb+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 06:14:48PM +0000, Conor Dooley wrote:
> On Tue, Nov 11, 2025 at 04:33:28PM +0100, Michal Wilczynski wrote:
> >=20
> >=20
> > On 11/10/25 20:35, Conor Dooley wrote:
> > > On Sat, Nov 08, 2025 at 02:04:34AM +0100, Michal Wilczynski wrote:
> > >> This series enables the display subsystem on the StarFive JH7110 SoC.
> > >> This hardware has a complex set of dependencies that this series aim=
s to
> > >> solve.
> > >>
> > >> I believe this is a PHY tuning issue that can be fixed in the new
> > >> phy-jh7110-inno-hdmi.c driver without changing the overall architect=
ure.
> > >> I plan to continue debugging these modes and will submit follow up f=
ixes
> > >> as needed.
> > >>
> > >> The core architectural plumbing is sound and ready for review.
> > >>
> > >> Notes:
> > >> - The JH7110 does not have a centralized MAINTAINERS entry like the
> > >>   TH1520, and driver maintainership seems fragmented. I have therefo=
re
> > >>   added a MAINTAINERS entry for the display subsystem and am willing=
 to
> > >>   help with its maintenance.
> > >=20
> > > Yeah, bunch of different folks wrote the drivers, so lots of entries.
> > > Pretty much all as you've done here, authors are responsible for the
> > > individual components and Emil is the platform maintainer but
> > > responsible for most drivers.
> > >=20
> > > Do you need any feedback dt wise on the RFC, or is it too likely that
> > > we'll both waste our breath if the DRM folks don't approve of your
> > > approach for the rest of this series?
> >=20
> > Hi Conor,
> >=20
> > Thank you for your response.
> >=20
> > That's a fair point about the risk of the DRM approach being rejected.
> > While I can't be certain, I'm hopeful that part is relatively
> > straightforward, as it primarily integrates other recently reviewed
> > (though not yet merged) components like the inno-hdmi bridge and dc8200
> > drivers.
> >=20
> > To be honest, I was more concerned that the DT part of the series would
> > be more problematic. Given that, I would find it very helpful to get
> > your feedback on the DT aspects now, if you have the time.
>=20
> Right. You'll definitely want some actual DRM people to weigh in though
> before making changes, I am really not familiar enough with this type of
> hardware to know if the breakdown is correct.

It looks generally sane to me chief, but as I said I am not really
familiar enough with this sort of hardware to have a real take on it.
Sorry, you'll need to get your affirmation about how you've laid stuff
out elsewhere :/

--oEuULB+ZwvMAwWb+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaROCXwAKCRB4tDGHoIJi
0lHNAP0VY2m9JP4EgIKWtYcUv/PdugQ015SJrRdoXUnsVhh14gEA7/E/wvGod2Wf
uGM6z13gp3dI+KrJhyqfO1LThr8IXwE=
=h9/B
-----END PGP SIGNATURE-----

--oEuULB+ZwvMAwWb+--

