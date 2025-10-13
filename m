Return-Path: <linux-kernel+bounces-851190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA8BBD5BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCF434EAA04
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145812D661A;
	Mon, 13 Oct 2025 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2OxbWx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427E2727FE;
	Mon, 13 Oct 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380317; cv=none; b=MU1EgRsLtbfK3wEeGAN1pVpRX5jcMGZ2JtaQEyq6IYqcKj0nEbVYhdTwmon6xgcDn5cTWvtZkEKJbwvLu7Y7Wl+3hF0KuToObqZAFGl9/8yAMOj6YpvJN5a+UfP3ONuMNOb1rRTFWELvnCmuzWU9IIVIRX9mPGzhe6vyZ4WXcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380317; c=relaxed/simple;
	bh=KvE45OEOXnKAPc2bpIs5Y2L3V8rbtBIYc4VQXDOlmjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8totP+UAmQYv6dUfFWOqxAOvDVpevNVBpCvK0PEsrl25YIRDDo6DvUM/oFLI6BBJM4Ybx72R8ojNyvTMio1B4VGtdw1SlGU0uAJuqoYTMWujW08/WPVW63rnvW4/My2N6Y+WAbbyTJ5NjeBZSISMB9pUVQkvuhKYucKrjoVbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2OxbWx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57767C4CEFE;
	Mon, 13 Oct 2025 18:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380317;
	bh=KvE45OEOXnKAPc2bpIs5Y2L3V8rbtBIYc4VQXDOlmjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2OxbWx5eXeHgjfVpQe+LnGcGm9ymp/PbQtnnPXsdszl3qPztnmcJPhu24llZA8uE
	 Vf3TmL5UBkOZwrXMmGNTFrWrWexFN1Fjmr4IZtCBwcee32+S4vhfUX+Qj7yP0xNndy
	 92+kMvHk7qszp4r85C1TM1vU8/e6mdtKRj2Ku3pcwjfWaDh44hJtXqfieNRJZCmLjS
	 mowo4cWVo5oNQ6jeMH7Bfx247b0IOVIJfNe+0MwMcBSUBy22zmf+8xGxg5RASB6AZs
	 B3eSEJahmfmFDjYPBXpbWen/ZFtWDK1Xg9DhoscnbMnp7ZA0g8qlh+ta/dy36EDDTU
	 rsGTR60DAr5XQ==
Date: Mon, 13 Oct 2025 19:31:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>
Subject: Re: [PATCH] dt-bindings: hwmon: pmbus/max17616: Add SMBALERT
 interrupt property
Message-ID: <20251013-dynamic-showcase-3fa511afbffb@spud>
References: <20251013-upstream-max17616-v1-1-0e15002479c3@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7jvkY4Y2HxWwgT3/"
Content-Disposition: inline
In-Reply-To: <20251013-upstream-max17616-v1-1-0e15002479c3@analog.com>


--7jvkY4Y2HxWwgT3/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 01:00:47PM +0800, Kim Seer Paller wrote:
> Add interrupt property to document the SMBALERT pin functionality for
> fault condition signal.
>=20
> Suggested-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.y=
aml b/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
> index 4680d354af0ef706bbd90d2546f5f25149654b6c..fa48af81e083cbc69d17c0186=
2f8f771eacf3332 100644
> --- a/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
> @@ -26,6 +26,10 @@ properties:
> =20
>    vcc-supply: true
> =20
> +  interrupts:
> +    description: Fault condition signal provided on SMBALERT pin.
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>=20
> ---
> base-commit: 2a364c163c1fa9fe62c2f06e84fb7d2f995e461f
> change-id: 20251013-upstream-max17616-37a4b8058eed
>=20
> Best regards,
> --=20
> Kim Seer Paller <kimseer.paller@analog.com>
>=20

--7jvkY4Y2HxWwgT3/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO1FmAAKCRB4tDGHoIJi
0qJzAQDlMqN5v7FK7BavC+mP+J/+ceqZvsH/+kwmATmZF3F3iAEAusRl3YawFgJn
uWGIr/a7dEU3AWE6R8ebMqlklt0brg0=
=cq7C
-----END PGP SIGNATURE-----

--7jvkY4Y2HxWwgT3/--

