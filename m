Return-Path: <linux-kernel+bounces-819472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A153AB5A14D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8995B2A821C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB372F5A29;
	Tue, 16 Sep 2025 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbLibwDf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5F30171E;
	Tue, 16 Sep 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050467; cv=none; b=cYFFmyOS2BJ0w1vIFpzH4f2Cgl6TSFnYj0CyCOtpZNmEKKW4FHiObfjvg7T+aJDRKJSy9uE5B+DYrIxEqZo7cNBE9GfMDdqUK1+T0J5MUC0Qk9R7xJLZv3ABBMZ6Bl+6rqvLxxSoO4jbkH1CIoWrw9myfPniwRB0W53r9Pkm/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050467; c=relaxed/simple;
	bh=6+WqFfDAReqi0O3H8d46eKzoBiYaoKSbaFyax7f1R6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beKmt5wgawZTvAdBJ8qwu3xwol4nkmNwlCo2AVfmAHK+UgLM/ntRIcANx6+cToMpa+5mIy2rgQRPREGYSMn1FAHVJWDsB1M62hyC7Jc8wekYS5qvuSWXr/8T5z3kjrYnWnU0b9IB+5t+XsYsu5mnzoI2YSdZ2dWLfIkI4lhR5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbLibwDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2B1C4CEEB;
	Tue, 16 Sep 2025 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758050465;
	bh=6+WqFfDAReqi0O3H8d46eKzoBiYaoKSbaFyax7f1R6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YbLibwDf7yCOcK9svXpIDFUcOn32houdi7d16upgcEbaGLSNZTOrorXqEHyoimOas
	 xizUTKlJ0+Nx/BPNdCxR0b43KWKcf3/DRo3Sd0huDxC7I5LveFpwLW45Pocbe+uvAr
	 Xvhiiqm2ztQqKix/6+XVs+JZey7NT05JprdAdyW6CiYLt1TTKHh/H4WX1TUy3SQ+jq
	 zEr8yM4lpxavP+iD9nNBErkcJVvzNO9WmjP7kNkZ/hi6Fly+FAO7GLPNIYktMMr/U5
	 FDiDEQijdpHQlL8cQ1Lv/tfjS8n+VJ3ABJwsi0IlwQ+cVD9ZQc8fm1s1Vlow9xedKc
	 HLNVwN64wNpmQ==
Date: Tue, 16 Sep 2025 12:21:03 -0700
From: Drew Fustini <fustini@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	James Morse <james.morse@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: Add Ssqosid extension
 description
Message-ID: <aMm4n2PlI8JqmK2c@x1>
References: <20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org>
 <20250915-ssqosid-v6-17-rc5-v2-1-2d4b0254dfd6@kernel.org>
 <20250916-landfall-easeful-782b60eb7d69@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tpbFvsgPwTSnAM87"
Content-Disposition: inline
In-Reply-To: <20250916-landfall-easeful-782b60eb7d69@spud>


--tpbFvsgPwTSnAM87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 07:36:01PM +0100, Conor Dooley wrote:
> On Mon, Sep 15, 2025 at 10:13:41PM -0700, Drew Fustini wrote:
> > Document the ratified Supervisor-mode Quality of Service ID (Ssqosid)
> > extension v1.0.
> >=20
> > Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > index ede6a58ccf5347d92785dc085a011052c1aade14..38e3d8d38cce55022ea70eb=
52423b1163e3cb097 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -165,6 +165,12 @@ properties:
> >              ratified at commit d70011dde6c2 ("Update to ratified state=
")
> >              of riscv-j-extension.
> > =20
> > +        - const: ssqosid
> > +          description: |
> > +            The ratified Supervisor-mode Quality of Service ID (Ssqosi=
d)
> > +            extension v1.0 which adds the Supervisor Resource Manageme=
nt
> > +            Configuration (srmcfg) CSR.
>=20
> Please cite when it was added, as is done for other extensions.

I had seen the pattern of commit X from Unpriv or Priv spec but I was
having trouble adapting that for Ssqosid as it has its own v1.0 PDF.

However, I now notice 'zacas' seems to have its own spec. Would this
work for 'ssqosid'?

        - const: ssqosid
          description: |
            The Ssqosid extension for Quality of Service ID is ratified
	    as v1.0 in commit 5059e0ca641c of riscv-ssqosid.

Thanks,
Drew

--tpbFvsgPwTSnAM87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSy8G7QpEpV9aCf6Lbb7CzD2SixDAUCaMm4jAAKCRDb7CzD2Six
DLUeAQDO5lFaFCk4ig6oiUbCMV1B9ivTXYq9bg45BcgvGSoJ5wEAkSJ5NLq9ohsk
h+B7lIHYwZ3f6UjrMUYCusgwEo4uwgQ=
=FJJd
-----END PGP SIGNATURE-----

--tpbFvsgPwTSnAM87--

