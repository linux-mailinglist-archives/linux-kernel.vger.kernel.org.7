Return-Path: <linux-kernel+bounces-817560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F1B583C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB19C3BF7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EAB299923;
	Mon, 15 Sep 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2ccZRaR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05431AC43A;
	Mon, 15 Sep 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957779; cv=none; b=fvxmFFuGDwEeuucZMkFODEG/ENUtZmatyD0fslWcVPfGWY7/fVGlT3UbIWYxPPAJl/GDDWf161TxvdxwsowN5zwlkJh1hv7LCphNUfJA6dPumKzbJ6G8IbmSGhVpl8H/o9GHBtG4lDC/xxx8bOEE0wg2PsmvzfRyzdA2WD9+1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957779; c=relaxed/simple;
	bh=sPtx8OcQ/LJYfINQ0uP+hDrIGzVtvgamvVg5IwJ3bnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IocKdmxlOgTcEB5W5GTpBlD4UOCAh/FqLTvIQ4286sItdClWIwCpvGDy6i1MFSvxv7W4RcSZw0C0nGnZwqxv56+ktyzIA0xqgh2RGP/7VpYicoY4sPzOWdtrSSwUaaoW/wJmAmyZQlxwG+E6eTc4H45quuVEw0WNodj21ZRqiqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2ccZRaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83539C4CEF1;
	Mon, 15 Sep 2025 17:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757957779;
	bh=sPtx8OcQ/LJYfINQ0uP+hDrIGzVtvgamvVg5IwJ3bnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2ccZRaReh2ZMkpCh3J8H1jBHJ1wzWgEZ/gbkjqf90z3fosGq4uOHYSkq14BWKAyx
	 PORewa6fOGqPAeaTcuXkC2S0680J9J5JjS/n1sKJShmJ4Bl+BKO2l87PqAp0Gb5eLv
	 ys24Z1jjnJri18EHTtXGT/5fyXy0/oqi+fe3+ncitCHrKHgv51pc0TmVNYYac/7Ee/
	 DSuIftRy9EJiP5KWeUXpwvg4AbLHDRvrZZMNkY9/9l2GaNJGDtxjPl3NTpfVTJve0x
	 vmO0p34EIdmnY9Yb2LvnxGmsvxU53dEWUqs1DfMml0jMRniwv8VuWzfBNSnpwIA/R1
	 RZpa2jGYhx+OQ==
Date: Mon, 15 Sep 2025 18:36:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: usb: uhci: Add reset property
Message-ID: <20250915-fifteen-sappy-82f26231843a@spud>
References: <20250915073926.3057368-1-ryan_chen@aspeedtech.com>
 <20250915073926.3057368-2-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZIluQHdooLWuNYaB"
Content-Disposition: inline
In-Reply-To: <20250915073926.3057368-2-ryan_chen@aspeedtech.com>


--ZIluQHdooLWuNYaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 03:39:23PM +0800, Ryan Chen wrote:
> The UHCI controller on Aspeed SoCs (including AST2700) requires
> its reset line to be deasserted before the controller can be used.
> Add an optional "resets" property to the UHCI device tree bindings
> to describe the phandle to the reset controller.

Looks like the property is not optional at all for your aspeed devices,
and you should require it for those compatibles.

>=20
> This property is optional for platforms which do not require
> explicit reset handling.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-uhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.yaml b/Docume=
ntation/devicetree/bindings/usb/usb-uhci.yaml
> index d8336f72dc1f..b1f2b9bd7921 100644
> --- a/Documentation/devicetree/bindings/usb/usb-uhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
> @@ -28,6 +28,9 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  resets:
> +    maxItems: 1
> +
>    '#ports':
>      $ref: /schemas/types.yaml#/definitions/uint32
> =20
> --=20
> 2.34.1
>=20

--ZIluQHdooLWuNYaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhOjwAKCRB4tDGHoIJi
0n3mAQD1ANXrcQzdhyuDWiQkUTSKB6wak20VqB3ZxN6/JezM5gD9EXJ+Tt4iDlrj
BE34lYQMHERi4dDNSRXrHkWpy812OgA=
=eNUF
-----END PGP SIGNATURE-----

--ZIluQHdooLWuNYaB--

