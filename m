Return-Path: <linux-kernel+bounces-844695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFDCBC2871
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DC724F30DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2802E0B74;
	Tue,  7 Oct 2025 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7yGu/ZT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1522D4DC;
	Tue,  7 Oct 2025 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865894; cv=none; b=KqjIA3Q5K+lYnY4Gj+/G85DRIYGZ1WFLEqH9yR9GyTWmDu0SDXbwhdRo27zGd3wQcsBDcCYAc09+k8+r2w0WxaQ/Tdv7pkeH/16CnPztgFS5D+tfzMQxtREww+xc3l7GJ3rWeSdpVbLFfzHDFIjDrIBxGcQNc/MA3g5cyjSKka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865894; c=relaxed/simple;
	bh=bVbxWtXRN8TdFnTML9rLfDnvnmcLd8ZUoTRbVKuIWR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4LFCzUhj3g8gLvt53jYVa5qAXQr7kBKxrqQathTl01K+7JbAAUmi2kyatRXCDMi3BFgldurXAs15BUbdRATr+6dx8nwC+3e9aOIJr6K49XXI8fHHWlLTEaj7t7OBeXm4zL4tMMiA+eCPTbd5tLUfki7hMDsAY5PwmVqeYpKV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7yGu/ZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E67C4CEF1;
	Tue,  7 Oct 2025 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759865892;
	bh=bVbxWtXRN8TdFnTML9rLfDnvnmcLd8ZUoTRbVKuIWR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7yGu/ZTxI8xLh3Cnb5/4MzvbiH0owoSXjs8TDskKitxm16knQdH0r+I0aWfoGyJj
	 gt/feL7tm5D+0dn9MOiGx+8BqrllnGATVBV70x39/P8t4wTrz4PLKkGg38UPfQEEc4
	 JW/YT+XIpERNIewJkoq5FtV2KNtmlngxM5jJKR/ISy9CI/DR59x45M5Dtx5EaZjie3
	 4uBMAbxxDzSaxjoR9eO7d74jl5VXaD7Qcr20hYdwG8zH1bAPFHiPR5fGe0gBN3/5bM
	 yzNdpLNWVQx1F1mtd/+ZoEVHuGNkzXcMArW68HrNF84bzQRYkM5HSgI6zCvl+XpCuF
	 TxA3o7IYRcbDw==
Date: Tue, 7 Oct 2025 20:38:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux@roeck-us.net, corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, cosmo.chou@quantatw.com
Subject: Re: [PATCH 1/2] dt-bindings: trivial-devices: add mps,mp9945
Message-ID: <20251007-waggle-diary-caade2dc90cc@spud>
References: <20251005204855.190270-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ufqc0shhQCJuEozx"
Content-Disposition: inline
In-Reply-To: <20251005204855.190270-1-chou.cosmo@gmail.com>


--Ufqc0shhQCJuEozx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 04:48:54AM +0800, Cosmo Chou wrote:
> Add dt-bindings for MPS mp9945 controller.
>=20
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 58ff948d93c9..08e2ca1b573e 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -317,6 +317,8 @@ properties:
>            - mps,mp5998
>              # Monolithic Power Systems Inc. digital step-down converter =
mp9941
>            - mps,mp9941
> +            # Monolithic Power Systems Inc. digital step-down converter =
mp9945
> +          - mps,mp9945
>              # Temperature sensor with integrated fan control
>            - national,lm63
>              # Temperature sensor with integrated fan control
> --=20
> 2.43.0
>=20

--Ufqc0shhQCJuEozx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOVsGwAKCRB4tDGHoIJi
0sSzAQChYJ3FSFyhwHNVOMQep2i4Bs9/OUOb07GBJ3j0uGUkrQD+LJ4RnW/BemVr
mMdzRc3bCcvSf3yOcbxZuln0BttQEAQ=
=vPcR
-----END PGP SIGNATURE-----

--Ufqc0shhQCJuEozx--

