Return-Path: <linux-kernel+bounces-819503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C1B5A1B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B887D4E1B91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3872D061E;
	Tue, 16 Sep 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiA3Ub8X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB522E5B3D;
	Tue, 16 Sep 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052817; cv=none; b=d4YNcnnLVHRh75peQi9sSEREYGPvezWhaqnkTqNUckgLZvVg0FAl52qzbeBCK61JkpbwB6ZOBvPCDrK5NeFV+4yO65g8YYZESqzpUXFgyOF43Z7tCfhoSluERipdJN5EONHJmHWs5Hsg5K4XOgN52kMA0JVVi7GXFXZTxGIL4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052817; c=relaxed/simple;
	bh=l5RcyRudbMnKY2qL2IjniShJoq21cxYpHC73/ta/rIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKPaWAU7uLY9UvqmPmuW1RZ6na1tDJcYO1gy2FDveKFIT55XvDwzEC7lJojTm49m7G8mgXwbZrbA54Il7CwZFOSf1+HcM3d62owdSKbcTCd3hiB5WM8chf9vYNyf+v3IuGf2maGDT9fayUTimCutD6W20UBpSsO/cXIfgF6QG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiA3Ub8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E73C4CEEB;
	Tue, 16 Sep 2025 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758052816;
	bh=l5RcyRudbMnKY2qL2IjniShJoq21cxYpHC73/ta/rIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WiA3Ub8XYcwT1DFXZ/U0zg5fVLhMo7zwb3vorV4CSHFeQkUaVUq0q/CcVo5dbTCRk
	 aPvmEYLA9+g3C/ITecGWf6qg5a8JnZVAk3Qe5uBKQIvTfxwC/4lgnrY2pC6YWbDFK5
	 arFTIMQKar9g7mjl3iQlr2LF3mDLMra3Snc4fUmcG0LunKMwM5V2jviFidtfZpvqrQ
	 w7KXuW/8WmwN7zuWpmN8xPWfrGl0Y5R97VRre8Av68zN8Irn9vejQ51dZ1i1vWPA2T
	 9fqDiTXb0y1BhPfgTm1rp1aAgCixpG7jTm/0U3ApDjycvMMxdO5JvDRFch0alA+nwd
	 TuZEb8t8eLaEA==
Date: Tue, 16 Sep 2025 13:00:14 -0700
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
Message-ID: <aMnBzqgoUrLMAtxw@x1>
References: <20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org>
 <20250915-ssqosid-v6-17-rc5-v2-1-2d4b0254dfd6@kernel.org>
 <20250916-landfall-easeful-782b60eb7d69@spud>
 <aMm4n2PlI8JqmK2c@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="10bvof6Yj50fwpad"
Content-Disposition: inline
In-Reply-To: <aMm4n2PlI8JqmK2c@x1>


--10bvof6Yj50fwpad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:21:03PM -0700, Drew Fustini wrote:
> On Tue, Sep 16, 2025 at 07:36:01PM +0100, Conor Dooley wrote:
> > On Mon, Sep 15, 2025 at 10:13:41PM -0700, Drew Fustini wrote:
> > > Document the ratified Supervisor-mode Quality of Service ID (Ssqosid)
> > > extension v1.0.
> > >=20
> > > Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> > > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml =
b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > index ede6a58ccf5347d92785dc085a011052c1aade14..38e3d8d38cce55022ea70=
eb52423b1163e3cb097 100644
> > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > @@ -165,6 +165,12 @@ properties:
> > >              ratified at commit d70011dde6c2 ("Update to ratified sta=
te")
> > >              of riscv-j-extension.
> > > =20
> > > +        - const: ssqosid
> > > +          description: |
> > > +            The ratified Supervisor-mode Quality of Service ID (Ssqo=
sid)
> > > +            extension v1.0 which adds the Supervisor Resource Manage=
ment
> > > +            Configuration (srmcfg) CSR.
> >=20
> > Please cite when it was added, as is done for other extensions.
>=20
> I had seen the pattern of commit X from Unpriv or Priv spec but I was
> having trouble adapting that for Ssqosid as it has its own v1.0 PDF.
>=20
> However, I now notice 'zacas' seems to have its own spec. Would this
> work for 'ssqosid'?
>=20
>         - const: ssqosid
>           description: |
>             The Ssqosid extension for Quality of Service ID is ratified
> 	      as v1.0 in commit 5059e0ca641c of riscv-ssqosid.

I'll change it to use the kernel style of commit reference:

        - const: ssqosid
          description: |
            The Ssqosid extension for Quality of Service ID is ratified
            as v1.0 in commit 5059e0ca641c  ("Merge pull request #7 from
	    ved-rivos/Ratified") of riscv-ssqosid.

-Drew

--10bvof6Yj50fwpad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSy8G7QpEpV9aCf6Lbb7CzD2SixDAUCaMnBvwAKCRDb7CzD2Six
DGI2AQDqcVG90uwlP30BH0fXNY11iff7sli6pD7f9SZz6jEMrAEA2BRJtcXM8MdC
qHtH4+VmDypq4EK6VlAvtKryUzkWigU=
=euQh
-----END PGP SIGNATURE-----

--10bvof6Yj50fwpad--

