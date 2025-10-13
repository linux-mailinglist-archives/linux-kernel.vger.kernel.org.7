Return-Path: <linux-kernel+bounces-851180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15034BD5B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DD51890C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EC42D6E5E;
	Mon, 13 Oct 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRURLY3C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078502D4B5E;
	Mon, 13 Oct 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379960; cv=none; b=q2eLQE+aqls4P201OOJADZKswGzoDsh05dDRhPct35amb9sXajKQt+44JIGvlE1M+oZyvD2x6Peg+kUEU5qTkZsV86R4wGvxKfoFUZ12UIPaIhlIIrt8kVy0TRTZbroXvHSEgEHoQwGUpJ9Hs+bqXAAqtn2CjvMn/SrFwYOfMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379960; c=relaxed/simple;
	bh=fp7n/OOANDDliKGGy2ySxRmFqBsywUsfLoN+oaMFd0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCiFtPOWjHTCkaXT0exLm3Rrre1ieoTSRvC5+g2inezNvT7hqagt7/kAP4uLRGfaZWNALg6xfBKf/YN2uH0PL66UXjUdsGyjrI0+9+MFFMNHViLlncAXZWB4EY7h+d7ospRPw8Sct9L2j2Xrynkg7lYSeRfzIajnBw41h2n+bSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRURLY3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8C8C4CEE7;
	Mon, 13 Oct 2025 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760379959;
	bh=fp7n/OOANDDliKGGy2ySxRmFqBsywUsfLoN+oaMFd0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRURLY3C9C8FjB3TlBWIqqo3yWGvkrvJmuPRgQ+pKDdL05ZQApdR3TtgFSNrjvmIS
	 TphiU/sdUT2P9f2gcv/tHfNFyHyzuUZMTrBdjXna0qFPlwr34iCTO+SvMjvHlWeKj7
	 hXVep5z8Bjm3mnQXg9aqhr2v5zefiOGlhpwke1Jfg2Nyex4U8Fu+LW+MSNDEYTJWT3
	 4oSrN2RKwSqoPZ5nO9Xe/LZzCvYgV0nlXru5eEiYDfAlrBDTxQkVS0+6iG1+fI8pEJ
	 sqnqDsMR0YjHSrn2+u4VE1HvByz9tl8ed925A0TrBeLkljJrB4eTgw0vahqq7EmQGk
	 Y+TZxGzUvnNWg==
Date: Mon, 13 Oct 2025 19:25:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: devicetree@vger.kernel.org, Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: interrupt-controller: add UltraRISC
 DP1000 PLIC
Message-ID: <20251013-commute-bountiful-208ade035c86@spud>
References: <20251013111539.2206477-1-lzampier@redhat.com>
 <20251013111539.2206477-3-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wFtD2X/HwE536WvW"
Content-Disposition: inline
In-Reply-To: <20251013111539.2206477-3-lzampier@redhat.com>


--wFtD2X/HwE536WvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 12:15:37PM +0100, Lucas Zampieri wrote:
> From: Charles Mirabile <cmirabil@redhat.com>
>=20
> Add a new compatible string for UltraRISC DP1000 PLIC.
>=20
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index 5b827bc24301..a419de50f5a8 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -74,6 +74,8 @@ properties:
>                - sophgo,sg2044-plic
>                - thead,th1520-plic
>            - const: thead,c900-plic
> +      - items:
> +          - const: ultrarisc,dp1000-plic
> +          - const: ultrarisc,cp100-plic

Based on your cover letter, this is problem not incorrect, but this fails
the eye test and looks wrong. Please mention in your commit message that
dp1000 is an soc and cp100 is a purchasable IP core.

pw-bot: changes-requested

>        - items:
>            - const: sifive,plic-1.0.0
>            - const: riscv,plic0
> --
> 2.51.0
>=20

--wFtD2X/HwE536WvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO1EMgAKCRB4tDGHoIJi
0tGzAP0dGNd0JliXtDwRb8D0K4PzFMBq3ub1ejdol4QlhY6Z7wEA3xBHPIr6Yi17
qe/9vOFHNa0ggaottW5iXQNZoRx2twc=
=1jAl
-----END PGP SIGNATURE-----

--wFtD2X/HwE536WvW--

