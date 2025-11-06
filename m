Return-Path: <linux-kernel+bounces-888727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10BBC3BC91
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602C4422E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D2C339B43;
	Thu,  6 Nov 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X6YkEiQJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449A2343B6;
	Thu,  6 Nov 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439359; cv=none; b=Yh/6lCGcdi4r1rvrKG6HoyL+OqOll/JK7s1XTu1KK6E29ISYK/tGD4oXbjFClySyJGqiI4EY8Ys2tsysyMm+bzt5EAufjFi25HjWVB0qxuVe06KHigLECBXWAaidg91DMJ/Gzw8gLB+fZcXeCIqmjBhH7hj2ldaPDW1Kd+dwUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439359; c=relaxed/simple;
	bh=V144ITPhJaheSq6B4sSkjanob0iMvCwByWKwZnn8vVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AE5YWjgUspXpbdHRKhiJK7xxuS4lM7hizPloU2aMoz6DTsMpqct3/8BjlkVRArt6MCkzfIZId7mihlTh3nTPyliNpIA/DfKkJnpMObIAD2PeaDBFACSMPNzUi9ehCMl8QwAO7T4MFeM/HNugZMdJZJad+4/dEZZzhXpEGjVT7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X6YkEiQJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762439355;
	bh=V144ITPhJaheSq6B4sSkjanob0iMvCwByWKwZnn8vVw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=X6YkEiQJfoguC+wfJWLl+scVfOt+2BoboFhF58RJ+alMJ4GUR2Vdx+lDly6tm4VgK
	 rHtU0GhiHNskumXYJWcQX2/Jbplhmlhypv1gfS6bN/C7/Yt14dYC7hobmYOvLtRpo1
	 JhR+GbWromFuLorTVZBoD1aYamepfJ9KllMKxykYjEBIQApOBSR9GrE5jZe9uspPsF
	 0ho/FgxfUIOVmnsXByjnP4zw7lWO58a2Z0p8a8vPC8aOdLl4veltCZWSnBX8hO/fgL
	 gpBGlhRehaozRgIDWekWlXmK5ew/BhN4K+5y9bakveGYamaP6xcbWhbLYSZ4ooHud/
	 El0bRpp2Loakg==
Received: from [IPv6:2606:6d00:11:ef24::c41] (unknown [IPv6:2606:6d00:11:ef24::c41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E43E17E0E63;
	Thu,  6 Nov 2025 15:29:13 +0100 (CET)
Message-ID: <5834fe661f38462d65795a20b5a4f9d2a12d3b35.camel@collabora.com>
Subject: Re: [PATCH v5 4/8] media: mediatek: vcodec: Add single core VP9
 decoding support for MT8189
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
Date: Thu, 06 Nov 2025 09:29:12 -0500
In-Reply-To: <20251106061323.2193-5-kyrie.wu@mediatek.com>
References: <20251106061323.2193-1-kyrie.wu@mediatek.com>
	 <20251106061323.2193-5-kyrie.wu@mediatek.com>
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
	protocol="application/pgp-signature"; boundary="=-wlcyIPJc95NX9hPSGVRO"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-wlcyIPJc95NX9hPSGVRO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 06 novembre 2025 =C3=A0 14:13 +0800, Kyrie Wu a =C3=A9crit=C2=A0:
> 1. add config to support 4K prob size;
> 2. Previously, calling vdec_vp9_slice_setup_single_from_src_to_dst
> with v4l2_m2m_next_src_buf to obtain both buffers resulted in -EINVAL,
> interrupting the decoding process. To resolve this,
> the interface should be updated to set both src and dst buffers
> for metadata configuration.

Please avoid using bullets in commit messages. Everyone will assume that if=
 you
have two bullets, you should have two patches. And I think they would be ri=
ght
for this patch.

>=20
> Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
> ---
> =C2=A0.../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c | 43 ++++++++++++++--=
---
> =C2=A01 file changed, 32 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9=
_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp=
9_req_lat_if.c
> index fa0f406f7726..d966914db4b9 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> @@ -23,6 +23,7 @@
> =C2=A0
> =C2=A0#define VP9_TILE_BUF_SIZE 4096
> =C2=A0#define VP9_PROB_BUF_SIZE 2560
> +#define VP9_PROB_BUF_4K_SIZE 3840
> =C2=A0#define VP9_COUNTS_BUF_SIZE 16384
> =C2=A0
> =C2=A0#define HDR_FLAG(x) (!!((hdr)->flags & V4L2_VP9_FRAME_FLAG_##x))
> @@ -542,6 +543,23 @@ static int vdec_vp9_slice_init_default_frame_ctx(str=
uct vdec_vp9_slice_instance
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> +static size_t mtk_vcodec_get_vp9_prob_size(enum mtk_vcodec_dec_chip_name=
 chip_name)
> +{
> +	size_t prob_size;
> +
> +	switch (chip_name) {
> +	case MTK_VDEC_MT8189:
> +	case MTK_VDEC_MT8196:
> +		prob_size =3D VP9_PROB_BUF_4K_SIZE;
> +		break;
> +	default:
> +		prob_size =3D VP9_PROB_BUF_SIZE;
> +		break;
> +	}
> +
> +	return prob_size;
> +}

This is another example of something that could be in the static compatible
data.

> +
> =C2=A0static int vdec_vp9_slice_alloc_working_buffer(struct vdec_vp9_slic=
e_instance *instance,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vdec_vp9_slice_vsi=
 *vsi)
> =C2=A0{
> @@ -616,7 +634,9 @@ static int vdec_vp9_slice_alloc_working_buffer(struct=
 vdec_vp9_slice_instance *i
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!instance->prob.va) {
> -		instance->prob.size =3D VP9_PROB_BUF_SIZE;
> +		instance->prob.size =3D
> +			mtk_vcodec_get_vp9_prob_size(ctx->dev->chip_name);
> +
> =C2=A0		if (mtk_vcodec_mem_alloc(ctx, &instance->prob))
> =C2=A0			goto err;
> =C2=A0	}
> @@ -696,21 +716,22 @@ static int vdec_vp9_slice_tile_offset(int idx, int =
mi_num, int tile_log2)
> =C2=A0	return min(offset, mi_num);
> =C2=A0}
> =C2=A0
> -static
> -int vdec_vp9_slice_setup_single_from_src_to_dst(struct vdec_vp9_slice_in=
stance *instance)
> +static int vdec_vp9_slice_setup_single_from_src_to_dst(struct vdec_vp9_s=
lice_instance *instance,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mtk_vcodec_mem *bs,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vdec_fb *fb)
> =C2=A0{
> -	struct vb2_v4l2_buffer *src;
> -	struct vb2_v4l2_buffer *dst;
> +	struct mtk_video_dec_buf *src_buf_info;
> +	struct mtk_video_dec_buf *dst_buf_info;
> =C2=A0
> -	src =3D v4l2_m2m_next_src_buf(instance->ctx->m2m_ctx);
> -	if (!src)
> +	src_buf_info =3D container_of(bs, struct mtk_video_dec_buf, bs_buffer);
> +	if (!src_buf_info)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	dst =3D v4l2_m2m_next_dst_buf(instance->ctx->m2m_ctx);
> -	if (!dst)
> +	dst_buf_info =3D container_of(fb, struct mtk_video_dec_buf, frame_buffe=
r);
> +	if (!dst_buf_info)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	v4l2_m2m_buf_copy_metadata(src, dst, true);
> +	v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &dst_buf_info->m2=
m_buf.vb, true);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -1800,7 +1821,7 @@ static int vdec_vp9_slice_setup_single(struct vdec_=
vp9_slice_instance *instance,
> =C2=A0	struct vdec_vp9_slice_vsi *vsi =3D &pfc->vsi;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D vdec_vp9_slice_setup_single_from_src_to_dst(instance);
> +	ret =3D vdec_vp9_slice_setup_single_from_src_to_dst(instance, bs, fb);

I don't see a direct correlation betwen the buffer size change and this cha=
nge.
Please split. Changes looks good, the commit message isn't very clear thoug=
h.

Nicolas

> =C2=A0	if (ret)
> =C2=A0		goto err;
> =C2=A0

--=-wlcyIPJc95NX9hPSGVRO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQywuAAKCRDZQZRRKWBy
9K5IAQCXlmAAzl+iCuLAYIlMe0L1aV3/vtGJvQ4QmLxUy0BkRgEA89XXHgOE2Ewx
OrW4Z94rpraxJcv92KTX7rtrXRkmkw4=
=qhRy
-----END PGP SIGNATURE-----

--=-wlcyIPJc95NX9hPSGVRO--

