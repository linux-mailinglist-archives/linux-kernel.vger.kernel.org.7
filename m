Return-Path: <linux-kernel+bounces-799776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94356B43023
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A2D1BC59CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8221E25486D;
	Thu,  4 Sep 2025 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pG6mpbbR"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1E23F439;
	Thu,  4 Sep 2025 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954734; cv=none; b=FcUcZfnvCcvFCwufH2mRDIzrNzPQ3s6f3qCDj4EbzzHRy0uwJE/6AEpuXt23+Qko4UpkFnn8YDAXYNvybWEAFd83gfPzixTDI/gIpJbpKqHc3wyuDM/FTroMSM6VVzVvMueIm3KhjJGqvqXZGXa/7b+RvYvCfZ0bFWMuWeKrjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954734; c=relaxed/simple;
	bh=FTXLxSm5XRx5K6N1cUG/Pp8Dj2ugNjB+8Hr6SF2HjF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L48/vTku5wxFaM9ODn8XduSxX8BHK039tK03Kv9qvuhn/K9Ph/4nYi36vcp6WRsArrP3hcqUnvWREhG2WeFbLCWTrdoqmA/hsRLdFlLzvXdmfjjqX0dyAwKECX5WAnubOJdOaxuV0FqNdijI5M9Qg33s/1RB7mt1oujAYEcSZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=pG6mpbbR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1756954727;
	bh=u/cz5gFnPDLf+w3W9DzyMROPsahYfYi4KmvveDhRwgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pG6mpbbRtGd1j7r+3y8B6e69itVB4401JTUPQnONKbE+ldSlrlX73ktF9Cj9X8HiZ
	 MCZdLKcV54hNcvboJGtZXP+sorrgqb5ElvEtFIr4wj0T/vyQ7m3R0EwklMmXR5/K9M
	 /+nv0NnTmyy8IqQf2GESmB3GezMdlMC/LPG8sU3C4RuFyGD4/EEfaEt5kAqyIWzE+P
	 Q2FVFfkVOasRxIuBTI7FJFtOCutqj4A+Be6Mcxbfg9KG9wpromrRH+4/RJbc44AsOa
	 CpiLoItFR1ipH8p65siEXZ2iDHG2QFK3z549puZcEl8ajim+2v4cnepdXIQuaqtk3V
	 d4frzJxEDtp1w==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cHPLv68Rlz4wB1; Thu,  4 Sep 2025 12:58:47 +1000 (AEST)
Date: Thu, 4 Sep 2025 12:58:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: linux-doc@vger.kernel.org, devicetree-spec@vger.kernel.org,
	devicetree@vger.kernel.org, ilias.apalodimas@linaro.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: devicetree: overlay-notes: recommend top-level
 compatible in DTSO
Message-ID: <aLkAYitpWxWx131p@zatzit>
References: <20250902174351.2457022-1-raymond.mao@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LpS/mvko/ul+nKVk"
Content-Disposition: inline
In-Reply-To: <20250902174351.2457022-1-raymond.mao@linaro.org>


--LpS/mvko/ul+nKVk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 10:43:50AM -0700, Raymond Mao wrote:
> When managing multiple base device trees and overlays in a structured
> way (e.g. bundled in firmware or tools), it is helpful to identify the
> intended target base DT for each overlay, which can be done via a
> top-level compatible string in the overlay.
>=20
> This provides a way to identify which overlays should be applied once the
> DT is selected for the case when a device have a common firmware binary
> which only differs on the DT and overlays.
>=20
> This patch updates the document with a note and example for this
> practice.
> For more information on this firmware requirement, please see [1].
>=20
> [1] https://github.com/FirmwareHandoff/firmware_handoff/pull/74

I think this idea is probably useful enough to be a good idea anyway.
However, note that it leans in to an existing ugliness of the overlay forma=
t:

Overlay dtbs kind of mix "in band" information - the actual new
content for the tree - with "out of band" information - how to apply
the overlay itself.  Whether a given property is data or metadata is
determined by it's place in the tree in a moderately complex and not
super obvious way.

About the clearest divide that exists is that generally the root and
first-level subnodes are information only for overlay application,
everything under that is data to be applied to the tree.  This all
tends to have names that would be unlikely (though not strictly
impossible) in a fully applied tree.

Putting 'compatible' at the root of the overlay is putting something
that looks very much like a regular device tree property in a place
and with a function that's purely about applying / validating the
overlay itself.

> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2:
> - Updated commit message.
>=20
>  Documentation/devicetree/overlay-notes.rst | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/d=
evicetree/overlay-notes.rst
> index 35e79242af9a..30b142d1b2ee 100644
> --- a/Documentation/devicetree/overlay-notes.rst
> +++ b/Documentation/devicetree/overlay-notes.rst
> @@ -103,6 +103,34 @@ The above bar.dtso example modified to use target pa=
th syntax is::
>      ---- bar.dtso ------------------------------------------------------=
--------
> =20
> =20
> +Overlay identification
> +----------------------
> +
> +When managing overlays dynamically or bundling multiple base device trees
> +and overlays in a single system (e.g., in firmware, initramfs, or user-s=
pace
> +tools), it becomes important to associate each overlay with its intended
> +target base DT.
> +
> +To support this, overlays should include the top-level compatible string
> +from its base DT.
> +This enables higher-level software or firmware to identify which base DT
> +an overlay is compatible with and apply it accordingly.
> +
> +Example usage::
> +
> +    ---- bar.dtso - overlay with top-level compatible string -----------=
--------
> +	/dts-v1/;
> +	/plugin/;
> +	compatible =3D "corp,foo";

This is not valid dts syntax.  Properties must be within a node.

> +
> +	...
> +    ---- bar.dtso ------------------------------------------------------=
--------
> +
> +This top-level compatible string is not required by the kernel overlay
> +mechanism itself, but it is strongly recommended for managing overlays in
> +scalable systems.
> +
> +
>  Overlay in-kernel API
>  --------------------------------
> =20
> --=20
> 2.25.1
>=20
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--LpS/mvko/ul+nKVk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmi5AGEACgkQzQJF27ox
2GeGuw/9GFIC/VwZAiCLKeFz4rMslFWYRnN5uQDhDzU6gFaRVJZgr2m1P7poSWFX
91KtHcnUfiXc2dFE6ndfBrPnudTyPdMujkVEpKuM/KNGpLoDBDLni0tSIZKJIohs
FW8t4tBVFx+nm8CDjXr/KJWXip4Q79ypUWRlMpUgM50WyYlrVD6nHkzfse/jeRWE
dM0aMFvP9labF9BMWBgM6bSfQRIWQA2TtWEIIkl48vx7G5hOxN3pN65B3XXNZKVJ
Kq8RPizP2amltzd5h+duL/HnWFxWw+2wdKwqRomw24JHlnvUnPLUMO3TP0hsYr+W
0212oiD+XQqLku3yrG/QAodOyOH53w7VauhfhbdTvYJ4qa5xDe866x7TW/408jw0
14sUEKGpDQJvC1cQ89O0KEnvdXar444abNDGB5b4HlJsLVbnDKN/k/OieutTUGI/
fCKk7umFVsgS9VrebgO+FdTO6s+x+X0T+O0/TS2WeRJu+P589c0UL4kYT97jTNFW
nkUX3wvs262xinsInPjneBSYvwVIR2YEnfpbRyGOeDowb7YTSpVxcnCDfp6y3Ksf
e1RqZnuu3/vrrfFWPXxDTjb7nTBSaIGdmSwHO8fwouW0cQe/S4nylIYHsG2NUIsr
g1r19xbeeos3uhwNA8mFQjNS7CLvxsjVE8/Jx8qoasg6O+z0TxY=
=Y1Ke
-----END PGP SIGNATURE-----

--LpS/mvko/ul+nKVk--

