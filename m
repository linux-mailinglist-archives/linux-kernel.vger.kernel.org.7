Return-Path: <linux-kernel+bounces-888782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAFFC3BE71
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABDA418C6192
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD334676F;
	Thu,  6 Nov 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Stdd40Ra"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850B346777;
	Thu,  6 Nov 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440655; cv=none; b=FGoioU0n75n24ZvLuZcMxm9b9Dxoc/yl49ztv18pOAMrpojhQrX7QYRW1DfqDjXbUTA2LcD+AdAcp5cQQQRoBKsWUMmTjhJNXO/WI0QoPGCXOVUE1DPdfQ20B+Vmqh5b2dEsvO8wddhEu+3kihwp+vXES3u/CWQsVOZhGxAP5Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440655; c=relaxed/simple;
	bh=/SG/uHMsoaaVW3+7tXj7IiAdklogSCYak1q0Xfk61P0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=odqoMWdSSpRuwTYTWJURSuLV/sWT9QfJ9ws01JeQFUlzLTKA4E+tREpx9rzWJMCFitcfMm6JTJf4JXTtxqXZmTad8wFdJ6B/cInLGCUINaIXUKFlKuCXS04j/U0j9C5rvrhjfaE34uDwOn+/kR44JC+gpfnlSuu+XzWzBNKnOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Stdd40Ra; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762440651;
	bh=/SG/uHMsoaaVW3+7tXj7IiAdklogSCYak1q0Xfk61P0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Stdd40RacKZw2D0Fy/FjlcXcwk25KKymleVxtYJOCdyMfxKbcp73AX8F67dj17YlC
	 pHUMHHR7pZteAcofaqFrO8wCKp8uONFwA+Pj9k87pAaHosCb4I3P5RVOmgtY3S+Mw/
	 hWS47k66EaSNIpjOBLRAvI7MOYKkRKlT0HvK4+h0KNRlxekneKNCxtRSUg85jbfn7b
	 zAdwHWkb9OARETdi44ww05eCHH1rS+SDb2oxvMgk0ycPyMMp4TFpaRB3t5UTbgcnn+
	 Jj4E6AeKO8lqRjyjgNkTKAQYAhfOLkrZKht2CCdS70mPoiBakitrNAqDXc+SaTXrWO
	 sMx1KtXZ8W/xw==
Received: from [IPv6:2606:6d00:11:ef24::c41] (unknown [IPv6:2606:6d00:11:ef24::c41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 54A9917E1352;
	Thu,  6 Nov 2025 15:50:49 +0100 (CET)
Message-ID: <21be57561dbf7bd28367193e62296a43212e6030.camel@collabora.com>
Subject: Re: [PATCH v5 8/8] media: mediatek: encoder: Add MT8189 encoder
 compatible data
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
Date: Thu, 06 Nov 2025 09:50:47 -0500
In-Reply-To: <20251106061323.2193-9-kyrie.wu@mediatek.com>
References: <20251106061323.2193-1-kyrie.wu@mediatek.com>
	 <20251106061323.2193-9-kyrie.wu@mediatek.com>
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
	protocol="application/pgp-signature"; boundary="=-bxeZ/yTsP3Z84TE9zFdJ"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-bxeZ/yTsP3Z84TE9zFdJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 06 novembre 2025 =C3=A0 14:13 +0800, Kyrie Wu a =C3=A9crit=C2=A0:
> add compatible data to support MT8189 encoding.

Don't copy your subject, briefly describe the configuration instead.

Nicolas

>=20
> Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com>
> ---
> =C2=A0.../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c=C2=A0=C2=A0 | 14 +=
+++++++++++++
> =C2=A01 file changed, 14 insertions(+)
>=20
> diff --git
> a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> index 6b3d2e72fad9..2cc92a8f7a0d 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> @@ -467,6 +467,19 @@ static const struct mtk_vcodec_enc_pdata mt8196_pdat=
a =3D {
> =C2=A0	.set_dma_bit_mask =3D true,
> =C2=A0};
> =C2=A0
> +static const struct mtk_vcodec_enc_pdata mt8189_pdata =3D {
> +	.venc_model_num =3D 8189,
> +	.capture_formats =3D mtk_video_formats_capture_h264,
> +	.num_capture_formats =3D ARRAY_SIZE(mtk_video_formats_capture_h264),
> +	.output_formats =3D mtk_video_formats_output,
> +	.num_output_formats =3D ARRAY_SIZE(mtk_video_formats_output),
> +	.min_bitrate =3D 64,
> +	.max_bitrate =3D 100000000,
> +	.core_id =3D VENC_SYS,
> +	.uses_common_fw_iface =3D true,
> +	.set_dma_bit_mask =3D true,
> +};
> +
> =C2=A0static const struct of_device_id mtk_vcodec_enc_match[] =3D {
> =C2=A0	{.compatible =3D "mediatek,mt8173-vcodec-enc",
> =C2=A0			.data =3D &mt8173_avc_pdata},
> @@ -477,6 +490,7 @@ static const struct of_device_id mtk_vcodec_enc_match=
[] =3D
> {
> =C2=A0	{.compatible =3D "mediatek,mt8192-vcodec-enc", .data =3D &mt8192_p=
data},
> =C2=A0	{.compatible =3D "mediatek,mt8195-vcodec-enc", .data =3D &mt8195_p=
data},
> =C2=A0	{.compatible =3D "mediatek,mt8196-vcodec-enc", .data =3D &mt8196_p=
data},
> +	{.compatible =3D "mediatek,mt8189-vcodec-enc", .data =3D &mt8189_pdata}=
,
> =C2=A0	{},
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, mtk_vcodec_enc_match);

--=-bxeZ/yTsP3Z84TE9zFdJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQy1xwAKCRDZQZRRKWBy
9Nw3AP46aJhDUk8PCHIbnonlNvXHPCIlwt4w3LWBJOBQeHlX8wD/cpB2lPrG4xJG
OyCOr3eXLc3FFA8/ZvNPBkKHgRQIpQs=
=nBUW
-----END PGP SIGNATURE-----

--=-bxeZ/yTsP3Z84TE9zFdJ--

