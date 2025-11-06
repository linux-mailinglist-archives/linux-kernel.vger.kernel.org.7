Return-Path: <linux-kernel+bounces-888720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09478C3BB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8219034948E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A9346777;
	Thu,  6 Nov 2025 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AvNHmc91"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A287345CBC;
	Thu,  6 Nov 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438928; cv=none; b=siJf+N2V5Jj0IzIfVD729gc7LX+co6plrXgr+6C0+T4m2NWEg6eRSrVOeu6HJkkF6GKoFTJtthmgedPJ4vtqVhHklXxcenWwtp6NTrEVsFD78WZQWS4b7tDy8dPFd9Pf417IrEDDHuC+JmYSgHGX/bgj3ftvWmfbbfjpmB2ciaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438928; c=relaxed/simple;
	bh=6LTpQ06d4NRkE2ObR0JDxtr4dVIQE2cbJXlCr+9SGQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tw+vigqxULf55ojeTM293YM3+0p8jfJFMXURga+XyXojxIb7SUFiAJtwHGjUJDe3GrCvuMBOZkWy95mZpu2wZMZ4gryrRIl/xXLI4hktllJYPaifwDm6bmXYkTPCv0tB82nVq9Q1M7gjHjK8023VZ0YqB1cuIFQidB7uBYgqW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AvNHmc91; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762438922;
	bh=6LTpQ06d4NRkE2ObR0JDxtr4dVIQE2cbJXlCr+9SGQo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AvNHmc91KLAG8qg2YdrxcA23kBbT0V6pU8eF7ZDi5rzEosUUGyqVDj5OgFWp64ID6
	 bpFNatoHW27V4DLYZAcwOhygMkZVztAYKU1hg7Gmu6yrmI94QlWN6Sng9tsrdXAmyF
	 fjN+RZCVQh+cz/OqyTrYQE/ncAQj9DHLFe3aqhoMtvdvUqUaBQe5YNRXNTOgyoaEze
	 FVxoy/KJzFVuuURroCk5YqtzAOZPmd3bNCi8pbtrwk/GJHJ7/UhCTmxxcP5s/8jMOo
	 YiO/hzwHJEvBc0H7ss2lT4h4bPKgjRsmVFxfhVoATgEUXcXptMrOjt0pwILFK2Cc+/
	 pedulFEpLTLyA==
Received: from [IPv6:2606:6d00:11:ef24::c41] (unknown [IPv6:2606:6d00:11:ef24::c41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 25B5717E0CA1;
	Thu,  6 Nov 2025 15:21:59 +0100 (CET)
Message-ID: <49d55e669473bef7b08882916095f10f409c85a0.camel@collabora.com>
Subject: Re: [PATCH v5 2/8] media: mediatek: vcodec: add decoder compatible
 to support MT8189
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Kyrie Wu <kyrie.wu@mediatek.com>, Tiffany Lin
 <tiffany.lin@mediatek.com>,  Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab	
 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger	
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Hans Verkuil
 <hverkuil@xs4all.nl>,  Nathan Hebert <nhebert@chromium.org>, Arnd Bergmann
 <arnd@arndb.de>, Irui Wang <irui.wang@mediatek.com>,  George Sun
 <george.sun@mediatek.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-mediatek@lists.infradead.org,
 Yilong Zhou <yilong.zhou@mediatek.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Andrzej Pietrasiewicz
	 <andrzejtp2010@gmail.com>
Date: Thu, 06 Nov 2025 09:21:58 -0500
In-Reply-To: <20251106061323.2193-3-kyrie.wu@mediatek.com>
References: <20251106061323.2193-1-kyrie.wu@mediatek.com>
	 <20251106061323.2193-3-kyrie.wu@mediatek.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-IdhGf+gEgY7bxzqJixSa"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-IdhGf+gEgY7bxzqJixSa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le jeudi 06 novembre 2025 =C3=A0 14:13 +0800, Kyrie Wu a =C3=A9crit=C2=A0:
> MT8189 is pure single core architecture. Support its compatible and
> use `mtk_vdec_single_core_pdata` to initialize platform data.
>=20
> Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
> =C2=A0.../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c=C2=A0=C2=
=A0 | 6 ++++++
> =C2=A0.../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h=C2=A0=C2=
=A0 | 1 +
> =C2=A02 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv=
.c
> index 6fb05bb00641..fca60e81e3c7 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> @@ -347,6 +347,8 @@ static void mtk_vcodec_dec_get_chip_name(struct mtk_v=
codec_dec_dev *vdec_dev)
> =C2=A0		vdec_dev->chip_name =3D MTK_VDEC_MT8188;
> =C2=A0	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8196-vc=
odec-dec"))
> =C2=A0		vdec_dev->chip_name =3D MTK_VDEC_MT8196;
> +	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8189-vcodec-=
dec"))
> +		vdec_dev->chip_name =3D MTK_VDEC_MT8189;
> =C2=A0	else
> =C2=A0		vdec_dev->chip_name =3D MTK_VDEC_INVAL;
> =C2=A0}
> @@ -574,6 +576,10 @@ static const struct of_device_id mtk_vcodec_match[] =
=3D {
> =C2=A0		.compatible =3D "mediatek,mt8196-vcodec-dec",
> =C2=A0		.data =3D &mtk_lat_sig_core_pdata,
> =C2=A0	},
> +	{
> +		.compatible =3D "mediatek,mt8189-vcodec-dec",
> +		.data =3D &mtk_vdec_single_core_pdata,
> +	},

Maybe its just me, but its annoying that you match the compatible twice. It=
 is
of course more work to add yet another indirection for the chip_name, but
considering you do 2 soc / year (and sometimes more) this will keep growing=
.

Opinions ? I'd don't want to block this forever, but I'd like to see some
cleanup of this driver happening in the long term.

Nicolas

> =C2=A0	{},
> =C2=A0};
> =C2=A0
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv=
.h
> index 429b32952194..9421fd4fda1d 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> @@ -25,6 +25,7 @@ enum mtk_vcodec_dec_chip_name {
> =C2=A0	MTK_VDEC_MT8183 =3D 8183,
> =C2=A0	MTK_VDEC_MT8186 =3D 8186,
> =C2=A0	MTK_VDEC_MT8188 =3D 8188,
> +	MTK_VDEC_MT8189 =3D 8189,
> =C2=A0	MTK_VDEC_MT8192 =3D 8192,
> =C2=A0	MTK_VDEC_MT8195 =3D 8195,
> =C2=A0	MTK_VDEC_MT8196 =3D 8196,

--=-IdhGf+gEgY7bxzqJixSa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQyvBgAKCRDZQZRRKWBy
9IPJAP9KEcQgbQ/1/dn3z4hh+pf9gIoQw7JY+DY9KFuzQSbuDgEAoYvS0YGR1n9V
ksidpcraN6RLZCAcUMnEhwYavCvi8wg=
=RRDe
-----END PGP SIGNATURE-----

--=-IdhGf+gEgY7bxzqJixSa--

