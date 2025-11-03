Return-Path: <linux-kernel+bounces-883736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF74C2E361
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88AC34E52CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD422D660D;
	Mon,  3 Nov 2025 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/UxAeHx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179D2D5940
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207675; cv=none; b=qHTtRs9cp7eZ1smGvDTcUd/XOHLEvB43331k4RmkJMkp378JsT+RuQAIoIye7UQd8bZiQswp9/Jaz+GwI5n/iKi941UoWM602CosXgY/V61RJMcT4aT9ma9xyi77RHzCCle0WcsFUnIyW9JOBqWCDbGqpwxg0ei+CamZ9O2NY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207675; c=relaxed/simple;
	bh=2DR7h+1jxsdywkQTNzsrebtck92hsKLGJI+1GUT8xto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVjPFB/KjeHlyubS6hvXgmZTJtXdDCNuElHzetcQ7AHaNEZeOMJ44NBMUMcULaf1FoWJJaUUUH65A0PgxJDkq0KYMD4yCgnjDcGAlxdxO6B+E1IH5XUdUULJ9X9x+SSGaUvaNL8Np97fLIY6zT8PWmzzJ2KVfjo2Z2ow7IvAsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/UxAeHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E24C116B1;
	Mon,  3 Nov 2025 22:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762207674;
	bh=2DR7h+1jxsdywkQTNzsrebtck92hsKLGJI+1GUT8xto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/UxAeHxkkfLb4MJdoxgpKHvncKyituzo9p2J2gz5bGXH2TuiKOkibybomTU0KeAc
	 Lca624f3aSpgMgFq1LfaJZTthMyQilJAh7QJO1yLKL5Yqv0Ndt4UUa8xOkWWqJZdUr
	 m+1jlvywuk/r+m3y7J1CMUVDVQtQuyZE5caTXekv1F+5IsUu+jjZ32G3DWochqPtdH
	 BKjvZSZZPguS+vdaB9VR9NoPMI0wJjDlDx3AmNoe+6CMCh5D/lVpHtLvCmpAiUQ7zF
	 nPzPArA67JVSm0UadefMUjxhIrXSVn03zbfnjdiGXNJPl0A5cgEV42a0Uf4UQtybBR
	 f2PY9UNgTujfQ==
Date: Mon, 3 Nov 2025 22:07:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Djordje Todorovic <djordje.todorovic@htecgroup.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chao-ying Fu <cfu@wavecomp.com>
Subject: Re: [PATCH] riscv: Update MIPS vendor id to 0x127.
Message-ID: <20251103-tabby-laurel-bc895f236a69@spud>
References: <20251103-mips-vendorid-v1-1-4fcb5f4d53fe@htecgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XT64vcUASahEeAk1"
Content-Disposition: inline
In-Reply-To: <20251103-mips-vendorid-v1-1-4fcb5f4d53fe@htecgroup.com>


--XT64vcUASahEeAk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 04:05:48PM +0100, Aleksa Paunovic wrote:
> From: Chao-ying Fu <cfu@wavecomp.com>
>=20
> [1] defines MIPS vendor id as 0x127.
>=20
> [1] https://mips.com/wp-content/uploads/2025/06/P8700_Programmers_Referen=
ce_Manual_Rev1.84_5-31-2025.pdf
>=20
> Fixes: a8fed1bc03ace27902338e4f0d318335883ac847 ("riscv: Add xmipsexectl =
as a vendor extension")

Incorrect format for fixes tags!

> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> ---
>  arch/riscv/include/asm/vendorid_list.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/=
asm/vendorid_list.h
> index 3b09874d7a6dfb8f8aa45b0be41c20711d539e78..55205f7938055ba2b744dba51=
18bba935bcac008 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -9,6 +9,6 @@
>  #define MICROCHIP_VENDOR_ID	0x029
>  #define SIFIVE_VENDOR_ID	0x489
>  #define THEAD_VENDOR_ID		0x5b7
> -#define MIPS_VENDOR_ID		0x722
> +#define MIPS_VENDOR_ID		0x127

How was this ever wrong? Do devices exist with this old ID? Do we need
to support both as vendor IDs for MIPS?
Also, this was added in the wrong point in the list (it's meant to be
alphanumeric order IIRC). Sorting by the ID makes things annoying to
humans to read.

> =20
>  #endif
>=20
> ---
> base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
> change-id: 20251031-mips-vendorid-df103aedf117
>=20
> Best regards,
> --=20
> Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
>=20

--XT64vcUASahEeAk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQknsgAKCRB4tDGHoIJi
0grwAP9hSkh4d4dpb6ujhlwQh+NgR7Y8Z+xjcqBOtioVXX3Q7AEAsWp8nvW8ztsF
WthfV4obgjRQtHadgx5MjdfnkxWLtw8=
=dMyF
-----END PGP SIGNATURE-----

--XT64vcUASahEeAk1--

