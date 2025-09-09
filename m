Return-Path: <linux-kernel+bounces-808853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16684B5056D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF632545856
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC03009C8;
	Tue,  9 Sep 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+pi9q6h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5692FFDD3;
	Tue,  9 Sep 2025 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442948; cv=none; b=sDFbya9c40qHnwtgvR5psmtfjg5P/EbRQkaRqjBEYLtsXBI3Qc6+0yGJCyHbIHmPmFdUP52n0LyQbrVG0Kd5L0sj49cqy5h0tCscX1cy18J9iR5GT5WTPvPjTYyCAsGk/Ar7vnCNUDuIbWGRUSCGBLPNsnhiVnTHrb59+JNicxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442948; c=relaxed/simple;
	bh=zCimBEEsW+SFcQwuUGAUgCl9LrL92q1g3x95hB4wno0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD5IqIbcIbhkU6RuEjGD2/6TYAA83NZw7aITmO8uOLsAgYMBbv1JzkZtXWJrYNn+e3oSkLpq6oQVrWdXggAiCcrRl4vT/CcchXT8a/1yDjAB/7i4g8e0FNPKpzvRDgKke3nb0qw4VyQchv9NHiOCsZBzvNggQrrZUw+mA824M8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+pi9q6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79CDC4CEF4;
	Tue,  9 Sep 2025 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757442948;
	bh=zCimBEEsW+SFcQwuUGAUgCl9LrL92q1g3x95hB4wno0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+pi9q6hBYDz9dZm8Tsp21PbpCnT6vybJVHLcbDQvEb1DAy1rrmn6zYM+5hRsEez4
	 K9LRTKLQRSDC09Zs0ErZ+2HLDuG851XcxIeNPxuU/EEuuBLqekUDkpqAYeeK6kZSV5
	 M8uoSMt4XOzk+RWwE2ScKJ8rxiTj0RFP2d4DVTQbiKENh+ftzDmDLYkKuJei74VyB+
	 I41ObBBH5llZtYq/2sBQtXz8lGJBqIHqlcNqY2Yr/5HDYquzEqO7Oelvvax5MTegbt
	 jpvlszHQPIuAxd3p+mDAawoIkDox6rTrCzGVuCdi5UWYDnWY+FhR0FcSXzLmMtNq65
	 GypedVo+G5ggg==
Date: Tue, 9 Sep 2025 19:35:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Josua Mayer <josua@solid-run.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250909-cork-tyke-9b460c1a6f44@spud>
References: <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
 <20250905154150.4tocaiqyumbiyxbh@skbuf>
 <20250905-pamperer-segment-ab89f0e9cdf8@spud>
 <20250908093709.owcha6ypm5lqqdwz@skbuf>
 <2b1f112e-d533-46ae-a9a0-e5874c35c1fc@solid-run.com>
 <20250908153746.7mfobudenttdi4qd@skbuf>
 <fcfbea96-7978-49f6-88c6-f78fe52edb7c@solid-run.com>
 <fcfbea96-7978-49f6-88c6-f78fe52edb7c@solid-run.com>
 <20250909113543.q7zazfy5slrgnhtc@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rgKk0EMXYsQjaFjK"
Content-Disposition: inline
In-Reply-To: <20250909113543.q7zazfy5slrgnhtc@skbuf>


--rgKk0EMXYsQjaFjK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 02:35:43PM +0300, Vladimir Oltean wrote:
> On Mon, Sep 08, 2025 at 04:04:45PM +0000, Josua Mayer wrote:
> > Am 08.09.25 um 17:37 schrieb Vladimir Oltean:
> > > On Mon, Sep 08, 2025 at 02:02:35PM +0000, Josua Mayer wrote:
> > >>> My updated plan is to describe the schema rules for the compatible =
as
> > >>> follows. Is that ok with everyone?
> > >>>
> > >>> properties:
> > >>>   compatible:
> > >>>     oneOf:
> > >>>       - const: fsl,lynx-28g
> > >>>         deprecated: true
> > >>>       - items:
> > >>>           - const: fsl,lx2160a-serdes1
> > >>>           - const: fsl,lynx-28g
> > >>>       - enum:
> > missed fsl,lx2160a-serdes1
>=20
> I didn't miss anything. "fsl,lx2160a-serdes1" is deliberately not in
> "enum" because there's no point specifying this compatible as
> standalone, if for backwards compatibility reasons it will always have
> to be "fsl,lx2160a-serdes1", "fsl,lynx-28g" (it was described as
> "fsl,lynx-28g" before), which is already covered by "items".

I think Josua was pointing out their own omission here.

> > >>>           - fsl,lx2160a-serdes2
> > >>>           - fsl,lx2160a-serdes3
> > >>>           - fsl,lx2162a-serdes1
> > >>>           - fsl,lx2162a-serdes2

--rgKk0EMXYsQjaFjK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMBzfwAKCRB4tDGHoIJi
0uImAP4iSyFG0dBJjo95uX9m0Tmx93AaThmecCO8jIfuKbVbrQD+Jji3Uu3mPaRx
UHP7rBa5RARB+qAIa/QDdFDUDGKfUQY=
=KrBe
-----END PGP SIGNATURE-----

--rgKk0EMXYsQjaFjK--

