Return-Path: <linux-kernel+bounces-803621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1988BB46310
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7545175723
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0101B0437;
	Fri,  5 Sep 2025 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+bOVARx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693D315D22;
	Fri,  5 Sep 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098984; cv=none; b=ot++Yq86wsnMrLups/hPy3q0qZnYJbqbgbx9R7y5q9bEdp5xNfv4KEzPaQZgZyRQHIoDQL42fqpGA0lxin5oOWX99865a0CHV/w9fV4q06L34mk+0Mm7yJUxsX1ahjzY9qnPBxL153Dw7vp5Ayc4CHwI23pqr4+af/kkzYN0tpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098984; c=relaxed/simple;
	bh=RnVOVM/uuNuDbILZAhvH4NRZDyKw6b856IwUxGZu7y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDt3Jf5eeE6YEUMG/C2Cz36l49r5Zh7MG5of+nQDkuK5L8cO12hzKn2fUk1GY9QIr/5doxwba3eQ5bj8FuuO6ITTmEXEzhXKApccNRwwRAiYv2EVjKtcNUJ/cnNlCbzBXfI3M6p2XhOa9MdRqntrwGrJaaZGeKb2laiBe5C2m3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+bOVARx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A51C4CEF1;
	Fri,  5 Sep 2025 19:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098984;
	bh=RnVOVM/uuNuDbILZAhvH4NRZDyKw6b856IwUxGZu7y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+bOVARxitIxQ33KU0TqmSWbdqoVPPHWIpFZQ61dQdQE3J4cTCoTkNoFfWM7w5uWH
	 wXIG2AgiV04mKBBou+gon/wis5v+4+cEjQu/pCdw7Vh8RpLhYY75tVTs0XTIaK6kwN
	 H3PLy9ifhfEoz4aTT8vB4nD0Xlu7D3mru0xcqUjvZOYE6zM40KetDm3xm2kZsIvm2L
	 0W9ih2Z+GoRebWX57CRmkZugiUUrXpdogP+cySYdQWcQjDlbd3O4wDVdwy6bE6YUj6
	 ddhCKHTFcn0PkJAGD/Mv/VxO7F9s/n+QhPfp+abdI7vt/qa/U0ggXohoY5uK4JfoVU
	 OBKzh8wpV7gvA==
Date: Fri, 5 Sep 2025 20:02:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-phy@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250905-pamperer-segment-ab89f0e9cdf8@spud>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
 <20250905154150.4tocaiqyumbiyxbh@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3D4+jggI92W+mz5y"
Content-Disposition: inline
In-Reply-To: <20250905154150.4tocaiqyumbiyxbh@skbuf>


--3D4+jggI92W+mz5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05, 2025 at 06:41:50PM +0300, Vladimir Oltean wrote:
> On Fri, Sep 05, 2025 at 10:29:33AM +0200, Krzysztof Kozlowski wrote:
> > >  properties:
> > >    compatible:
> > > -    enum:
> > > -      - fsl,lynx-28g
> > > +    oneOf:
> > > +      - items:
> > > +          - const: fsl,lynx-28g
> >=20
> > Don't change that part. Previous enum was correct. You want oneOf and
> > enum.
>=20
> Combining the feedback from Conor and Josua, I should only be permitting
> the use of "fsl,lynx-28g" as a fallback to "fsl,lx216{0,2}a-serdes{1,2}",
> or standalone. The description below achieves just that. Does it look ok
> to you?
>=20
> properties:
>   compatible:
>     oneOf:
>       - enum:
>           - fsl,lx2160a-serdes1
>           - fsl,lx2160a-serdes2
>           - fsl,lx2160a-serdes3
>           - fsl,lx2162a-serdes1
>           - fsl,lx2162a-serdes2
>       - const: fsl,lynx-28g
>         deprecated: true

>       - items:
>           - const: fsl,lx2160a-serdes1
>           - const: fsl,lynx-28g
>         deprecated: true
>       - items:
>           - const: fsl,lx2160a-serdes2
>           - const: fsl,lynx-28g
>         deprecated: true
>       - items:
>           - const: fsl,lx2162a-serdes1
>           - const: fsl,lynx-28g
>         deprecated: true
>       - items:
>           - const: fsl,lx2162a-serdes2
>           - const: fsl,lynx-28g
>         deprecated: true

This doesn't really make sense, none of these are currently in use
right? Everything is just using fsl,lynx-28g right?
Adding new stuff and immediately marking it deprecated is a
contradiction, just don't add it at all if you don't want people using
it. Any users of it would be something you're going to retrofit in now,
so you may as well just retrofit to use what you want people to use
going forward, which has no fallbacks.

I didn't read the back and forth with Josua (sorry!) but is the fallback
even valid? Do those devices have a common minimum set of features that
they share?

--3D4+jggI92W+mz5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLsz4wAKCRB4tDGHoIJi
0r3AAP4k3M2Rfs96+5+KCmi6TXeQ9mYQHTo4X1jbmyL+SNNR5QD/d4ym1J0jM4Us
aJvkVP5gvEEy0FxwEdh7BwhvQHfAqQs=
=mIu7
-----END PGP SIGNATURE-----

--3D4+jggI92W+mz5y--

