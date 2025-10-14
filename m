Return-Path: <linux-kernel+bounces-853165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0467BDAD51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9014D546A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B94303CBD;
	Tue, 14 Oct 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvL3sS4O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913026B971;
	Tue, 14 Oct 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760463881; cv=none; b=fuf5cFjIAkjS6f48tnA7zTCDPbQ+qndKDRfz/rEg2okGX/RNaiYkzAehxT0Qbe27yXZMIMQWy/HiabV/8DFr3h+xb2x8ZQjjtpddzZfVThK05MyWXKk/yheD6GPKnxrCobqhUFT4qubHKdZZJ4MqDoJhQMgvJfvmUxigtmGgXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760463881; c=relaxed/simple;
	bh=PND3tMFcHSXQbftmY3sVLMvaNBKZSZ0hGpr0vDTs9sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfxeGfpyEIkE7PqBA9zNCZvt4u79Z+JOnVjh6JG3+fe1YMbpEehF6acTF3TY1lGtcSwQNsbsbU/DCE7sroYubIa6twb08ErRUzrd5UBb2bV7yzs08bUo9djlAHITj3F3OR6IEjXBdqPBrUsy0v0Wp7F6jHWoAR3ZPMcVQNkTjjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvL3sS4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B73C4CEE7;
	Tue, 14 Oct 2025 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760463881;
	bh=PND3tMFcHSXQbftmY3sVLMvaNBKZSZ0hGpr0vDTs9sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvL3sS4O0/9Rp25fZny11LsDbx8NYa863vhybCfL5A96ugwuGYbS5uKASWQbsO200
	 XT3CeYL63+CYtUITLF0WuMgsTYwHiAApLc3S3MmF+BQXZTv8hwTu3kqyddnK1nYZg8
	 0NXQZD1JNENF/DcAfg8vSUlyuT0aiqfqk9F34lU3rEUBQQBVEdxyBpWxejZGZ6QzF3
	 eD9HP7P1Nv9iCxnEFYKrat/ahxk3u0SsEjezu4HfXs/iRmW4AEwmeLi8a5jorS8npe
	 d7E3UqwiFejKguvpLz1t90LebXig7Fgkys2bK915snVhBqj41dUvFK1k3e3sZ37A3J
	 Vke1bYn3IQVJQ==
Date: Tue, 14 Oct 2025 18:44:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-kernel@vger.kernel.org, Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dt-bindings: interrupt-controller: add UltraRISC
 DP1000 PLIC
Message-ID: <20251014-petted-papyrus-435129236562@spud>
References: <20251014154100.168236-1-lzampier@redhat.com>
 <20251014154100.168236-3-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SBMBPhePSwNwsQCs"
Content-Disposition: inline
In-Reply-To: <20251014154100.168236-3-lzampier@redhat.com>


--SBMBPhePSwNwsQCs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 04:40:56PM +0100, Lucas Zampieri wrote:
> From: Charles Mirabile <cmirabil@redhat.com>
>=20
> Add compatible strings for the PLIC found in UltraRISC DP1000 SoC.
>=20
> The PLIC is part of the UR-CP100 core and has a hardware bug requiring
> a workaround, so the driver will match on the more generic core-specific
> compatible (ultrarisc,cp100-plic) to apply the quirk across all SoCs
> using UR-CP100 cores.

The exact driver behaviour itself is not really appropriate here, all
you need to do is say that the core has the bug!
With the prescriptive bit about driver matching behaviour removed,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

>=20
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index 5b827bc24301..34591d64cca3 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -74,6 +74,9 @@ properties:
>                - sophgo,sg2044-plic
>                - thead,th1520-plic
>            - const: thead,c900-plic
> +      - items:
> +          - const: ultrarisc,dp1000-plic
> +          - const: ultrarisc,cp100-plic
>        - items:
>            - const: sifive,plic-1.0.0
>            - const: riscv,plic0
> --
> 2.51.0
>=20

--SBMBPhePSwNwsQCs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO6MAwAKCRB4tDGHoIJi
0gnNAP9TKWqhJhzUUp3cCJPe5+VCmmPgdq2b1gK6o5qQaZNGSQEAvjL2WCBzA58u
c8FoKcIciUJjkEw/LooNWCUxOKL2Ywk=
=cYxS
-----END PGP SIGNATURE-----

--SBMBPhePSwNwsQCs--

