Return-Path: <linux-kernel+bounces-897982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBDAC54126
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C4E3B26F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ED734DCF2;
	Wed, 12 Nov 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEVCNybn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129334C808;
	Wed, 12 Nov 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974476; cv=none; b=Eh46hqqfn5ZeudR2rmNCLsKmTk17iMHNk5O0HW5cLJxUhI1ug8Y6nrXAsiSbRR5mfhcZsHD0oiySQj+RGWoKxqRulwznzIRoJPQFX+mDsiXTlLtbeM6+3n3eyELZGmro/JDL4RlvXKm9YfyE3XtM08wgzfkyVgjg3HSkBFXLXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974476; c=relaxed/simple;
	bh=4X5km6tMQI+rmQ+2RA+kgRbD/MaASgUWl21z9NvFxCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7xozPHM0m3fa4ooLrdt48ub8B2a/qTuXvKLmDpw37yTBlMHowsJc39Ehuw4uq4jj2i9keN5dPqkGiKFh1/Rb6vkovb4usAetXamff7SeZRXPIkH0ymnO85Q5kSDSxjXKdiY5Z/jGHK3pvyJ+CgqGF3bikaCR/Z6rO41oc43ahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEVCNybn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580F6C4CEF8;
	Wed, 12 Nov 2025 19:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762974475;
	bh=4X5km6tMQI+rmQ+2RA+kgRbD/MaASgUWl21z9NvFxCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEVCNybnc6t6289XVBYkcWqOoxpXqCnrLBLYLoiHlIbKyjkbGJommYxYZ4GvUKdzk
	 RvCaaYP4cH5e7LLxqfEh/U5J3NbcNb9zsGx7irU6L2ggZu686KokOvrxociihCrdz5
	 dJwld8Pz0SSqtx5kTdGzsQdfnbx8hipENl9Wi6lNZNvCXnCb9b5gngZtmYSqEKO6wj
	 5nkefY3+3deZoLjCDjmW1duP1O9r17D6AOg4pER2uFLTODAnUbspPTpahmODQvVy32
	 cdL9DSF+KFzEqfM/EGASoFTjqu4im0ljDP7j6qlpVZV6ov6xCd8GSzIZLOvBJkNhd/
	 +2SZ5Fb6iN0MQ==
Date: Wed, 12 Nov 2025 19:07:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michal.simek@amd.com,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH] dt-bindings: usb: dwc3-xilinx: Describe the reset
 constraint for the versal platform
Message-ID: <20251112-bagging-diameter-4ebab1f9ed45@spud>
References: <20251112155430.1326426-1-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="92AFPMtx3g8andt7"
Content-Disposition: inline
In-Reply-To: <20251112155430.1326426-1-radhey.shyam.pandey@amd.com>


--92AFPMtx3g8andt7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 09:24:30PM +0530, Radhey Shyam Pandey wrote:
> AMD Versal platform USB 2.0 IP controller receives one reset input from
> the SoC controlled by the CRL.RST_USB [RESET] register so accordingly
> describe reset constraints.
>=20
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  .../devicetree/bindings/usb/dwc3-xilinx.yaml  | 43 +++++++++++++++----
>  1 file changed, 34 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Doc=
umentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> index 36f5c644d959..cd0cc9da242f 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> @@ -50,17 +50,22 @@ properties:
>      description:
>        A list of phandles for resets listed in reset-names.
> =20
> -    items:
> -      - description: USB core reset
> -      - description: USB hibernation reset
> -      - description: USB APB reset
> +    oneOf:
> +      - items:
> +          - description: USB controller reset
> +      - items:
> +          - description: USB core reset
> +          - description: USB hibernation reset
> +          - description: USB APB reset
> =20
>    reset-names:
> -    items:
> -      - const: usb_crst
> -      - const: usb_hibrst
> -      - const: usb_apbrst
> -
> +    oneOf:
> +      - items:
> +          - const: usb_crst

Why do we need all this oneOf stuff if both have the same first reset?
Can't you just set minItems: 1?

> +      - items:
> +          - const: usb_crst
> +          - const: usb_hibrst
> +          - const: usb_apbrst
>    phys:
>      minItems: 1
>      maxItems: 2
> @@ -95,6 +100,26 @@ required:
>    - resets
>    - reset-names
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - xlnx,versal-dwc3
> +    then:
> +      properties:
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          maxItems: 1
> +    else:
> +      properties:
> +        resets:
> +          minItems: 3
> +        reset-names:
> +          minItems: 3
> +
>  additionalProperties: false
> =20
>  examples:
>=20
> base-commit: b179ce312bafcb8c68dc718e015aee79b7939ff0
> --=20
> 2.34.1
>=20

--92AFPMtx3g8andt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRTbBwAKCRB4tDGHoIJi
0jX7AQCAHa54UizRxsLeHp9VJzAq+vFdLs6YxvkaigFx6sowxAEA+An2kZel0I/A
Ftl+wdLtzBFFGVzZh6cSv2qGpvIuVAU=
=Er4U
-----END PGP SIGNATURE-----

--92AFPMtx3g8andt7--

