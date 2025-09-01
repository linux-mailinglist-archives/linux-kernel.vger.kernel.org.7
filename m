Return-Path: <linux-kernel+bounces-795194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F5B3EE0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BF42C0A40
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949F932ED5B;
	Mon,  1 Sep 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL/2IfJj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB12261B9D;
	Mon,  1 Sep 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752306; cv=none; b=hbUqy1P+GdZJVFQtzgvb6MRsCYMipq6WFu1DEN8/wC1DcdXwLcqo4rhuCZnRdg13pkQqNRONOdEtP93+E2R3uftURRShtj7JzydUMauxumMyuGNYs2PtQs+PKvYDsbeNANeZbppfF0GR9NMOXC7FMh9G0jU1KgeSv+gp88uvXOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752306; c=relaxed/simple;
	bh=1YzNMjZhCaQIrNSILETW5/3BwbAqQWDiIS97qg9unZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTQNO6T1v1K5EE5mr+myFyYbEU5Zl0tBjuNVr5LEZJCrVU6O8fnW8RA9DLT8u83cwF437YLfQSGY5B+y64cFHFtpgQyzyOZmWBELPGEejbSxMVMSzf7jOMuSfI+ZoXR66BTf9SNdHCHNbyAGDMAF43nWdwZ6tZW34VoWeS5pcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL/2IfJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAB8C4CEF1;
	Mon,  1 Sep 2025 18:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756752304;
	bh=1YzNMjZhCaQIrNSILETW5/3BwbAqQWDiIS97qg9unZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oL/2IfJjMvOf9hTAxls37Ft8Y2ur6mM+BzZoaakI2vPs3ciMLlU3/jRe//wfy07C9
	 6s3TO1SxB6u6Gi63CHjkFbRoVd+Evo/VxFqPRAIj3XF8aMhww+cbyn+GHJVsZt0DsA
	 ToPS1G147E+4WKaURLiy2th8hnZtAF7zMm/8/43Fw88P5npLandSfw3+xLiuiJQ3Xs
	 ZJBRp5Pjy9/4yJKkCFm1iJJ+FaMkAB2Q0Xe86moJ/0DvuIsSBJxflBK1EHSahw+dM+
	 acRVjW17njVaRjM6i402t0bMIbbY95A8ecV4vBHpStnAS65n4NdxOTqssMoYokVjXV
	 tnHHGTWt88peg==
Date: Mon, 1 Sep 2025 19:44:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, ajones@ventanamicro.com, brs@rivosinc.com,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com
Subject: Re: [PATCH 2/4] dt-bindings: riscv: Add Zalasr ISA extension
 description
Message-ID: <20250901-caravan-traps-9fb18046b458@spud>
References: <20250901113022.3812-1-luxu.kernel@bytedance.com>
 <20250901113022.3812-3-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AL80nCar+VMsEAi6"
Content-Disposition: inline
In-Reply-To: <20250901113022.3812-3-luxu.kernel@bytedance.com>


--AL80nCar+VMsEAi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 07:30:20PM +0800, Xu Lu wrote:
> Add description for the Zalasr ISA extension
>=20
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index ede6a58ccf534..6b8c21807a2da 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -248,6 +248,11 @@ properties:
>              ratified at commit e87412e621f1 ("integrate Zaamo and Zalrsc=
 text
>              (#1304)") of the unprivileged ISA specification.
> =20
> +        - const: zalasr

This is out of order, no? zalrsc would come after zalasr.

> +          description: |
> +            The standard Zalasr extension for load-acquire/store-release=
 as frozen
> +            at commit 194f0094 ("Version 0.9 for freeze") of riscv-zalas=
r.
> +
>          - const: zawrs
>            description: |
>              The Zawrs extension for entering a low-power state or for tr=
apping
> --=20
> 2.20.1
>=20

--AL80nCar+VMsEAi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLXpqwAKCRB4tDGHoIJi
0q1rAQDS6x9A+kKZpKJrIw66WhCpCrIK6vSliB+s3BMy2XB/bQEA+HyP69er2SfV
sZscX5NUIunelfCqwxnNr3TQUCvIFwc=
=w3HQ
-----END PGP SIGNATURE-----

--AL80nCar+VMsEAi6--

