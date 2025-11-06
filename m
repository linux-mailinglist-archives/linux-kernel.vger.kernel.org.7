Return-Path: <linux-kernel+bounces-888721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F554C3BBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 366834EA2FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9FB33DEEB;
	Thu,  6 Nov 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WlkdRfaT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4C16F0FE;
	Thu,  6 Nov 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439019; cv=none; b=FEbtFX+d987KBw+YUY9MAxEN2I4zUEAVTyWIOjSEe5FqCXiaZDBxEUsPHVdCwmrtbFxRPaKKPl1k2Iy0OiJf2wO1PblWLKttCppT4FbQs5k2RYE1ZQC7hu/UWQ1n6jEYLHUubsbP+uH+zrL+wdDZuCwUy1eQBGGIVzwC+ByFP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439019; c=relaxed/simple;
	bh=lbvG7apBTU01DmFiJ5pQJMotoKQvfUuEd42+VAzjllY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6jJmr4eeycz6uELp0MIUO7TeRQx1IeYncJXRhCTvtRtk94yr7+uIpc3CFMJ55niXLJy266lLfc4aW0bbIVeNwrynHkqnSLct3kkOCpJHIsTwMPPnyGQzmoIFwQFlnzVsLqr1SRPo8RupXkJTdJuPt0jgCCSxo2Sux9N3Z3h4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WlkdRfaT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762439016;
	bh=lbvG7apBTU01DmFiJ5pQJMotoKQvfUuEd42+VAzjllY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WlkdRfaThTmQ5vALbmN2tsccBhZ5y++BNDlJ8tiQgzWN70PkaWxB+BxTDkBPN8/Le
	 lRxbl2OjYq7/3Lfd6VX6vaTXdaz6DZrY91a0FAUvusHGaidzEFGNxbZ2dobccQThAJ
	 XE2FU7DC/q8UY/Sg170ztacS4DCgUC+48vw2OJP+qHUapP9nsIeJq/Ke3gXdcJ7K0H
	 T7wzR0MVrteYgTFNE/3e0m2BwbvpUhT2B2ISNRapbQI3C1jm01OQuifXqRllY1E8nA
	 FSY+HIbbexDC635nLn46kyhP6Ae2jo1QOFPyVh20FAdHAeq0HaJWJvjmLMKm98bO65
	 JB4siQxtnb19w==
Received: from [IPv6:2606:6d00:11:ef24::c41] (unknown [IPv6:2606:6d00:11:ef24::c41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B69D317E0CA1;
	Thu,  6 Nov 2025 15:23:33 +0100 (CET)
Message-ID: <8408b589db4c31e32dafb6cf7c80a80c94b488c7.camel@collabora.com>
Subject: Re: [PATCH v5 3/8] media: mediatek: vcodec: add profile and level
 supporting for MT8189
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
Date: Thu, 06 Nov 2025 09:23:32 -0500
In-Reply-To: <20251106061323.2193-4-kyrie.wu@mediatek.com>
References: <20251106061323.2193-1-kyrie.wu@mediatek.com>
	 <20251106061323.2193-4-kyrie.wu@mediatek.com>
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
	protocol="application/pgp-signature"; boundary="=-oN0nrYRIFHsUPQUtneGT"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-oN0nrYRIFHsUPQUtneGT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le jeudi 06 novembre 2025 =C3=A0 14:13 +0800, Kyrie Wu a =C3=A9crit=C2=A0:
> add profile and level supporting for H264 and vp9 of MT8189
>=20
> Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
> =C2=A0.../mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_d=
ec_stateless.c
> index c1cef78471a9..0a9bdc5316f9 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> @@ -552,6 +552,7 @@ static void mtk_vcodec_dec_fill_h264_level(struct v4l=
2_ctrl_config *cfg,
> =C2=A0	switch (ctx->dev->chip_name) {
> =C2=A0	case MTK_VDEC_MT8192:
> =C2=A0	case MTK_VDEC_MT8188:
> +	case MTK_VDEC_MT8189:
> =C2=A0		cfg->max =3D V4L2_MPEG_VIDEO_H264_LEVEL_5_2;

Please consider my suggestion in 2/8, you could then move all of this into =
the
static compatible data structure.

Nicolas

> =C2=A0		break;
> =C2=A0	case MTK_VDEC_MT8195:
> @@ -573,6 +574,7 @@ static void mtk_vcodec_dec_fill_h264_profile(struct v=
4l2_ctrl_config *cfg,
> =C2=A0{
> =C2=A0	switch (ctx->dev->chip_name) {
> =C2=A0	case MTK_VDEC_MT8188:
> +	case MTK_VDEC_MT8189:
> =C2=A0	case MTK_VDEC_MT8195:
> =C2=A0	case MTK_VDEC_MT8196:
> =C2=A0		cfg->max =3D V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10;
> @@ -623,6 +625,7 @@ static void mtk_vcodec_dec_fill_vp9_level(struct v4l2=
_ctrl_config *cfg,
> =C2=A0	case MTK_VDEC_MT8188:
> =C2=A0		cfg->max =3D V4L2_MPEG_VIDEO_VP9_LEVEL_5_1;
> =C2=A0		break;
> +	case MTK_VDEC_MT8189:
> =C2=A0	case MTK_VDEC_MT8195:
> =C2=A0	case MTK_VDEC_MT8196:
> =C2=A0		cfg->max =3D V4L2_MPEG_VIDEO_VP9_LEVEL_5_2;
> @@ -641,6 +644,7 @@ static void mtk_vcodec_dec_fill_vp9_profile(struct v4=
l2_ctrl_config *cfg,
> =C2=A0{
> =C2=A0	switch (ctx->dev->chip_name) {
> =C2=A0	case MTK_VDEC_MT8188:
> +	case MTK_VDEC_MT8189:
> =C2=A0	case MTK_VDEC_MT8195:
> =C2=A0	case MTK_VDEC_MT8196:
> =C2=A0		cfg->max =3D V4L2_MPEG_VIDEO_VP9_PROFILE_2;

--=-oN0nrYRIFHsUPQUtneGT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQyvZAAKCRDZQZRRKWBy
9HgOAQCcOPqEipHaLaMrsEybD4wMnGsF5eIZwMZBS7s8CI99yQD/WfKVqeU7qjJN
qGe3ad5qCAZQWikimukLeXwioptSOw8=
=F5b3
-----END PGP SIGNATURE-----

--=-oN0nrYRIFHsUPQUtneGT--

