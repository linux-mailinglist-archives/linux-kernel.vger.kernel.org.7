Return-Path: <linux-kernel+bounces-828668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 690E8B9523D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C5D7B2F30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71F320CA4;
	Tue, 23 Sep 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3m+U6KH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDB320A1D;
	Tue, 23 Sep 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618461; cv=none; b=XZo90WrFWXoE7LIIqXm8sXcaJCY5u6FGWIhmDxO6jrakA0Md0P7EjR0npGx/IvzubojBzYYNeMDyKP+Ik9aY1gStStPGZVR+zrerjdoMsPbd4xV0nzND2Il2GXUpHCrkBQh/QOQcqXROHMA0Sly3TRkRcpMMFgYkRcBAk17OkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618461; c=relaxed/simple;
	bh=kkCA8SAuPlhfPf3erMCajqMN5ix6aRl7bFBdFcZEqRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl/dGBI37Kz5uVBBGdFu1XXsCfxhbeO1t4P0sIecvSuJCeSRDe3fjXmfEO+r89WEInruYDUpj+exM6Z4AVRHgx2oqhp+IbMz4n3g7DrVG2bpRgb2SxKO3d5Me9ilwhkmZiIukofAfq2tdElCRlGlr/qFMgNfD93Okq6wEwoFnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3m+U6KH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF76C116B1;
	Tue, 23 Sep 2025 09:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758618461;
	bh=kkCA8SAuPlhfPf3erMCajqMN5ix6aRl7bFBdFcZEqRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3m+U6KH9WiE7acahlltWpsy+84oMewDE/TQ5owV4ijWPp5icWn03RwVcgUjBc5gS
	 zXTUDNGiHIbCrbV9C/iYOeNGz+M5m+BGWUKgHcgqvv+2CaTkbDZWIDq0WK2sLlOxCE
	 04yk/Pq7o+L4cbjk8HtcVEYXpt+N5+caHnL1x8r5637Ith7QRC0JdwIcHlYLwobVwe
	 IYN9qboRdoRAb5DO5lcPXnQF1CHt0GCSThptzuNU91oOFv6Q+R543hdrSjlgilb6kk
	 Rw9QTdfe0ovaIqYnaLZWrp8YFhj3KlVeQtqH/vCyGPkiJ4b/auE+cDvm3tcNEhMsfJ
	 muJVgYi9XANYQ==
Date: Tue, 23 Sep 2025 11:07:38 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Kevin Hilman <khilman@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andrew Davis <afd@ti.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: keystone: don't cache clock rate
Message-ID: <20250923-brave-zebu-of-growth-a6426b@penduick>
References: <20250915143440.2362812-1-mwalle@kernel.org>
 <20250915143440.2362812-3-mwalle@kernel.org>
 <7hv7lhp0e8.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3iw34lfkiliihfo7"
Content-Disposition: inline
In-Reply-To: <7hv7lhp0e8.fsf@baylibre.com>


--3iw34lfkiliihfo7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] clk: keystone: don't cache clock rate
MIME-Version: 1.0

On Wed, Sep 17, 2025 at 08:24:47AM -0700, Kevin Hilman wrote:
> Michael Walle <mwalle@kernel.org> writes:
>=20
> > The TISCI firmware will return 0 if the clock or consumer is not
> > enabled although there is a stored value in the firmware. IOW a call to
> > set rate will work but at get rate will always return 0 if the clock is
> > disabled.
> > The clk framework will try to cache the clock rate when it's requested
> > by a consumer. If the clock or consumer is not enabled at that point,
> > the cached value is 0, which is wrong.
>=20
> Hmm, it also seems wrong to me that the clock framework would cache a
> clock rate when it's disabled.  On platforms with clocks that may have
> shared management (eg. TISCI or other platforms using SCMI) it's
> entirely possible that when Linux has disabled a clock, some other
> entity may have changed it.

It doesn't really help that the CCF doesn't seem to agree on if it
should do that in the first place :)

In the original clk API definition, you're not supposed to call
clk_get_rate() when the clock is disabled.

https://elixir.bootlin.com/linux/v6.16.8/source/include/linux/clk.h#L746

However, it's been allowed by the CCF since forever:

https://elixir.bootlin.com/linux/v6.16.8/source/drivers/clk/clk.c#L1986

But then, some drivers will return 0 as a valid value, and not an error
code (whatever 0Hz for a clock means).

It's kind of a mess, and very regression prone, so I don't really expect
it to change anytime soon.

Maxime

--3iw34lfkiliihfo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNJjVAAKCRAnX84Zoj2+
ds0nAX9cnO1qMu1gRrt93wqZ3E7heejWdZkXiLTOlsXu2u9hW0VAjJeUYt9/k6vh
40iU+joBf0oNZk2TNHK5NY8d4PR+uru6sGDJqMFK0BBGGGWdlzNH5mgiIfgwVMdV
1rDRIy6m2g==
=8+3Q
-----END PGP SIGNATURE-----

--3iw34lfkiliihfo7--

