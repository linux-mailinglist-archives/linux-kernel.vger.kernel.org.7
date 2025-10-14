Return-Path: <linux-kernel+bounces-853376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28459BDB6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 786CD4FA52B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292D62D4B4B;
	Tue, 14 Oct 2025 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmd80W/Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871ED29A301
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478188; cv=none; b=XdmwEestKOlwoZcrC8nnsFVZTp2w7+EeDZwDvpvoLwwJ7TLCgY0ZOVfpag/KnMoIO5WXItRM7CcuM0uqeTpl3VB3z7HG4UmEAEV6hg2cJPZjkK0tPMU6ix8EDXcEfnMQ29B00IRdJBfdSJnNNkOl6OrGMqnYxL/hoJKpTQSWEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478188; c=relaxed/simple;
	bh=LRljLPxaEQbTwtDrQiCyNR63yfM2iVls8Na9Cwrj4uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHQ3Ew1yqZVlP0BVqZrn6vYfcAKIRiHCVAeVz8DBVYq2LZi2A28xY3cCQaor1jJAxJlMhp7OLDG/6S2v+Win+2sPPo7ZptcbPpcN3Giw0lh4jMyMG83RQ8DIJwPuFt0XuBZ5r6l9D4PQy8m370PaRaHDYU3+9XjZl9OY+jz/NDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmd80W/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2523FC4CEE7;
	Tue, 14 Oct 2025 21:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760478186;
	bh=LRljLPxaEQbTwtDrQiCyNR63yfM2iVls8Na9Cwrj4uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmd80W/YRIcA4dQNGPY5FgKHmtjcXYldtMaf70v1N8zwqbvI9jR2MTDv58nrnu3Bv
	 yumduFDeZnKiRACxkP3iMCvBIwrGhbadzQAOvDL+VavMaQdjomOzeboANqOg6YvZB3
	 UCzmgbgza/wSuKMIML7yz8ci2h65hurCSA6vbkpVAkRonXeKzejp/8CmZ670mTUDGr
	 N1Zy20w7k1Pz7b+niSJfKKrrJR9CVqwXNRVAuklWDkpGvf9+YxInyoVcH+NYeo7fdX
	 G2yFzBxoxnUUMAvLhrYiQgY9FHpLtbNWo3/QR2eJnDsMbLC48XtGyf5C4Q3I0sK7Bb
	 PdqRpxSF9NTQQ==
Date: Tue, 14 Oct 2025 22:43:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Anup Patel <apatel@ventanamicro.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Don't print details of CPUs disabled in DT
Message-ID: <20251014-voicing-zoology-7873581cc192@spud>
References: <20251014163009.182381-1-apatel@ventanamicro.com>
 <20251014-5305a0b88ee761d57e3f29bb@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KWNSzEgGgBuTmFqL"
Content-Disposition: inline
In-Reply-To: <20251014-5305a0b88ee761d57e3f29bb@orel>


--KWNSzEgGgBuTmFqL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 12:50:11PM -0500, Andrew Jones wrote:
> On Tue, Oct 14, 2025 at 10:00:09PM +0530, Anup Patel wrote:
> > Early boot stages may disable CPU DT nodes for unavailable
> > CPUs based on SKU, pinstraps, eFuse, etc. Currently, the
> > riscv_early_of_processor_hartid() prints details of a CPU
> > if it is disabled in DT which has no value and gives a
> > false impression to the users that there some issue with
> > the CPU.
> >=20
> > Fixes: e3d794d555cd ("riscv: treat cpu devicetree nodes without status =
as enabled")
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/kernel/cpu.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index f6b13e9f5e6c..3dbc8cc557dd 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -62,10 +62,8 @@ int __init riscv_early_of_processor_hartid(struct de=
vice_node *node, unsigned lo
> >  		return -ENODEV;
> >  	}
> > =20
> > -	if (!of_device_is_available(node)) {
> > -		pr_info("CPU with hartid=3D%lu is not available\n", *hart);
> > +	if (!of_device_is_available(node))
> >  		return -ENODEV;
> > -	}
> > =20
> >  	if (of_property_read_string(node, "riscv,isa-base", &isa))
> >  		goto old_interface;
> > --=20
> > 2.43.0
> >
>=20
> Maybe we should keep the message as a pr_debug()?

I don't even know if that really has any value, there's plenty of places
in userspace to get access to what CPUs are enabled and having no CPUs
triggers a BUG().
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Otherwise,
>=20
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

--KWNSzEgGgBuTmFqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO7D5gAKCRB4tDGHoIJi
0kHFAQDVxoesuzHdEbDDnzDbWdzCv+ITIcqRHGyNWkXnKoO6QAEA/Qa6YcmgxX/J
ZePPxLUzqlVZ+/tdFlC+ibydJ7VqbgQ=
=jt3k
-----END PGP SIGNATURE-----

--KWNSzEgGgBuTmFqL--

