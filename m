Return-Path: <linux-kernel+bounces-772660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF14B295B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5FA17F31A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 23:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ACD206F23;
	Sun, 17 Aug 2025 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UqhTu58U"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89626AE4;
	Sun, 17 Aug 2025 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755474343; cv=none; b=cSUoRDfrjSFERhozE2iu9e2Ur1qUGthEePdGPou+ZHYBke0LpP0sxVGsGVACNu1c31I9whwWSX55JItucu3v9XS88A7DQM3c3t3yc+Bpfsxpuasa06toiuO2LRdvlwIxTxirrSLjcSJi/7dKO/PB1zUvvMynO9WMIhLCU90tPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755474343; c=relaxed/simple;
	bh=HPtoXLcu0qggH4jysGzi620Wy9aVXaa/e+YuoQWCNgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOh4F8KXJyY7L8QYe35XQSRCYANnKkY938zsVspSCSkOC5O/0UKOudEor7uGjNxXcykN3vp+WDLA+5AcERRil21b3lbJVQLaE9T0kGrMsYWgz/Dyzz0I+C1KKfNP8pPklDQXFKWggdjWU/jBXUeSEOW3xYZN/AtWyY3MQTx3aWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=UqhTu58U; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1755474338;
	bh=2P+EHdBkMskSxtDh++Brhi8O6amrL6pAeciOLHwpaDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UqhTu58UYwkwvVPt9UoW2gxCZFnzSRz5A0JN9TTjwKgboLp7DPyn334kh4FEAeD5o
	 eMhfshQt4y3OxhqlB3hAwGbicKxb6gD1cU/j01QoJhpY2iLqkjBsaGj2uQvL5IcxT5
	 TXHndWs8ulV3qT3XSDFZ1r1qUTvaXWIeWw3e6IwGAtUwZo9KZO12dSoe0YVgr5eu6I
	 SaXJiryEN3YiGrzZedtUySivIv0+nU6FdhctGLbShcsyZ7+70oExZZDFrg+/XPfhFc
	 Yu20zD3VqV0svo/V5IlybP2mfutpooMav8pNWAcCqUMXrMioIYN9LMVJTyi4vskeMp
	 xd+/Xh9uunW5Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4c4ssq4xMTz4wbr;
	Mon, 18 Aug 2025 09:45:35 +1000 (AEST)
Date: Mon, 18 Aug 2025 09:45:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux DRI Development
 <dri-devel@lists.freedesktop.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Antonino Maniscalco <antomani103@gmail.com>, =?UTF-8?B?QW5kcsOp?= Almeida
 <andrealmeid@igalia.com>, Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH] drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected
 usage in literal code block
Message-ID: <20250818094535.34358d39@canb.auug.org.au>
In-Reply-To: <fefba786-57d4-4138-9454-7cd3d924239d@infradead.org>
References: <20250709024501.9105-1-bagasdotme@gmail.com>
	<aade485e-0880-4c68-9b37-d8a27dc122e3@kernel.org>
	<fefba786-57d4-4138-9454-7cd3d924239d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RA3ANG7T.uTmLH1kJb1QB+j";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/RA3ANG7T.uTmLH1kJb1QB+j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Sun, 17 Aug 2025 16:24:02 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> On 7/9/25 12:37 AM, Danilo Krummrich wrote:
> > On 7/9/25 4:45 AM, Bagas Sanjaya wrote: =20
> >> Stephen Rothwell reports multiple indentation warnings when merging
> >> drm-msm tree:
> >>
> >> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2445: ERRO=
R: Unexpected indentation. [docutils]
> >> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2447: WARN=
ING: Block quote ends without a blank line; unexpected unindent. [docutils]
> >> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2451: WARN=
ING: Definition list ends without a blank line; unexpected unindent. [docut=
ils]
> >> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2452: WARN=
ING: Definition list ends without a blank line; unexpected unindent. [docut=
ils]
> >> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2456: ERRO=
R: Unexpected indentation. [docutils]
> >> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2457: WARN=
ING: Definition list ends without a blank line; unexpected unindent. [docut=
ils]
> >> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2458: WARN=
ING: Definition list ends without a blank line; unexpected unindent. [docut=
ils]
> >> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2459: WARN=
ING: Definition list ends without a blank line; unexpected unindent. [docut=
ils]
> >>
> >> Fix these by wrapping drm_gpuvm_sm_map_exec_lock() expected usage
> >> example in literal code block.
> >>
> >> Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
> >> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >> Closes: https://lore.kernel.org/linux-next/20250708192038.6b0fd31d@can=
b.auug.org.au/
> >> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com> =20
> >=20
> > I assume this has to go through the MSM tree?
> >=20
> > Acked-by: Danilo Krummrich <dakr@kernel.org>
> >  =20
>=20
> Hi,
> What's happening with this patch?
> It was posted about 6 weeks ago and the build warnings
> are still in mainline (6.17-rc2).

This is commit

  bb324f85f722 ("drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected usag=
e in literal code block")

in the drm-msm-fixes tree in linux-next.  I assume that will migrate to
the drm-fixes tree and thence to Linus' tree in the next week (or so).

--=20
Cheers,
Stephen Rothwell

--Sig_/RA3ANG7T.uTmLH1kJb1QB+j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiiaZ8ACgkQAVBC80lX
0Gyt2wf+NqmxZi/kfKr9oBpm5/Cg5mbT0lTbONN0etRgSh6JkLk1evERWcsyhTAo
VrxYiVtHOHGqjasqfSdy2IhciNF5A3YpN58nz6fobL154gWcPEFfyJYX+71Y2qaX
OJrLg06Tx5nFXCznXy2/pHAJozPkuSgpFD4gqiuE/R71ef/13YICDJTBhCVAMihk
3d3MZsL10Ku27GcaNGNZojvCBKc/+IcTg1KXiPODv967JGFBpJLig58naKU6j4BU
glNAaOmKxL+D8qegT+TNjrd+rpsnVD6XS9EAK3fhazps7k6F27eeZSNcljdFVHqk
GY24rkFlYggFL2t1lLsocS44A3rFug==
=yEjJ
-----END PGP SIGNATURE-----

--Sig_/RA3ANG7T.uTmLH1kJb1QB+j--

