Return-Path: <linux-kernel+bounces-792716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C43B3C7F5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E33A236AF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 04:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C37276056;
	Sat, 30 Aug 2025 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nI9sURvm"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A2C2FB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756529156; cv=none; b=lxj2A6nVD1G8B9QuZA56uVXtOTtNoJ5gmOGOD9SiLD6Fb2IhaaON/WR6Gfjog58uUZjI1GV3BisOzc5pNHULnE0h4PTVSPdze8hZVtlDHiboi/b/KgzB4Uo2D/J+QSHN++H3t81jB0VwetFUbbivP9vGZcvMevAvAMr/LARfIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756529156; c=relaxed/simple;
	bh=pF2UH9SNriXCdAW3lHet4jellXKzdy6sg2X5z/NP6pg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ty3cDWwkOGzIQy6F7uhRNNvWRB3bsMloEyK1s0owYYjaYVY1ReZWyFDfPKglvM/ScRRBcEyEgLi+7TxAG9z3wkWnlBBqFrx2z8BXtTE10U/5dmQ+qLJxJXrcxOxZacTKTXl7k/iwmSaTVb8sL1cruM545VfxVTpRhcObUKWhlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nI9sURvm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1756529144;
	bh=pt3u/3dhlv3xp9vGi7l7QuBrLsn5dvfeg+GgVr0aTXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nI9sURvmPiBdyeT59pgCA4MQNUS93LYOQ/HVFYC26qyeyL2UX4B4GL3V6PNc5t86x
	 NgxLgK3fLChvRbEQwxirv4wuomxruaelO8l8UwumVA42VQGf4QsqqfeAuJn5wC37UO
	 z8SlawpKnMogSGqKMJZEWnc/Ikv/+1BOnFRgWcjgsSTqIJrEzSX2H6JdLcT8GYeTdE
	 DTs0D1dN848t2+HCYr/BTAkGcr38hDt/lnb73sKkOvpPu7FK1EO0FibhUBqFwjD920
	 gRCxBihmv8xz5Vxh2y5cqK1Kg3UD9HuaaLOjGjGTNqImA9ozmfnJZVnw8cLwNUF9WM
	 G6T16XnUTFzDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4cDMyc0RkSz4wbY;
	Sat, 30 Aug 2025 14:45:43 +1000 (AEST)
Date: Sat, 30 Aug 2025 14:45:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Donet Tom <donettom@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC 8/8] powerpc/book3s64/slb: Add slb faults to vmstat
Message-ID: <20250830144542.6ba0e774@canb.auug.org.au>
In-Reply-To: <e05ac86618d8a52feccf5bac99da44b11871382c.1756522067.git.ritesh.list@gmail.com>
References: <cover.1756522067.git.ritesh.list@gmail.com>
	<e05ac86618d8a52feccf5bac99da44b11871382c.1756522067.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//+ny8ES+6FQIgltakmfkGeI";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//+ny8ES+6FQIgltakmfkGeI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ritesh,

On Sat, 30 Aug 2025 09:21:47 +0530 "Ritesh Harjani (IBM)" <ritesh.list@gmai=
l.com> wrote:
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 71cd1ceba191..8cd17a5fc72b 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1464,6 +1464,11 @@ const char * const vmstat_text[] =3D {
>  	[I(DIRECT_MAP_LEVEL2_COLLAPSE)]		=3D "direct_map_level2_collapses",
>  	[I(DIRECT_MAP_LEVEL3_COLLAPSE)]		=3D "direct_map_level3_collapses",
>  #endif
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	"slb_kernel_faults",
> +	"slb_user_faults",
> +#endif
> +
>  #ifdef CONFIG_PER_VMA_LOCK_STATS
>  	[I(VMA_LOCK_SUCCESS)]			=3D "vma_lock_success",
>  	[I(VMA_LOCK_ABORT)]			=3D "vma_lock_abort",

Should you be using explicit indexes and the I() macro?

--=20
Cheers,
Stephen Rothwell

--Sig_//+ny8ES+6FQIgltakmfkGeI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiygfYACgkQAVBC80lX
0Gw49Af/UHUgpgla969YKk5hog5zPrUt/pqZeUpeCBxUuq7MPlxJcsYXGimAWpRt
0t3emvmvxMn44bEq8pWIIMC/I0zQs5ot02U2idYBNrms/QOyZUPtMOqh8GoqC12R
ZaLygol/LLHTQNnSPKQvTby9VIi+x65d89xiAaaP011YM3Ely6npbON2M/GSAp2e
QxGPXnTyweD8LuTfg5WO42gfR0tZT4kmiYXenIKitwq+etMK2a1aRW363/qDl8JB
hDdJ5MsslmTyrgEIWGZf+oU7KQaW3tDpyVi2G47z3jC4yvoFAM3Zb5aRvaT5Z5/P
ruWRI29KJGH69tamurCkQo92a+Bo8w==
=fKMP
-----END PGP SIGNATURE-----

--Sig_//+ny8ES+6FQIgltakmfkGeI--

