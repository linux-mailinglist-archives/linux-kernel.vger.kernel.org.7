Return-Path: <linux-kernel+bounces-888774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E5C3BE20
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A1B34FA19A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AE434574D;
	Thu,  6 Nov 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Lw+gF5MQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9B3043D2;
	Thu,  6 Nov 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440391; cv=none; b=L+7cvGX1Bl/Pmyi09HkRbUuSUiGvxqIVdWcmCpavXYsAbcxklyshGFDRX9d6Vl74zuglgglmz0QnGSB6I9FoXFm9qA2dSwApSVcvjmaDFiSUzk340dAs4I08aB5vo3BeWG4m4eSmq3CrHKoz1CiEOUfohUMwt3d0t9KWePXKapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440391; c=relaxed/simple;
	bh=dGOlyZRnTXRalBcuIplk4eH5kRwlh1SL2I9sgliJA7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DzWMhEdoXj8qM7xeGXcvTMhnzmGWtyto+75GHseYwujjNQjIYecoHKbeknkmD46G5zL3xXKNNDbZgP33zZojQUyxWuc2RzsiEbqBtmPcP/CKDaJ3xfh0jsU0JqPwORCZD3AUy90X/7rAB5XJcQrMZGeaKeVb8QnHF2DoV5x8u7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Lw+gF5MQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762440387;
	bh=dGOlyZRnTXRalBcuIplk4eH5kRwlh1SL2I9sgliJA7c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Lw+gF5MQXFFl9ynmcctABtq3k21bUx5HiAupg4ybdkPoF/NQil2aqKCXeAshG/8mK
	 qMlQdBNo+XZcPao+2NcGO4If6Eaf0uKx35SVnN3+w7GxG73Icp1bjh8vtXW1BbJ27S
	 iPNHUWbtXlC4cB76egMk8Azv9k8CBpfsId0fYRLLU8u61uV+yWvS/NqNoeoYqhI221
	 p1EMlLumWtsFPo3OP2gvGryIHlzHRnYz9lUGqXLvKkVJ+ntASTFyd2Yz2tG/DJl4tR
	 3NEmcVuQUH4xVU6lYrKPAJo3t9h68XahX5lMPmmNTelgQ1PGnPlaYSTxDyfGuIrWBL
	 4x9BV88PLBBuA==
Received: from [IPv6:2606:6d00:11:ef24::c41] (unknown [IPv6:2606:6d00:11:ef24::c41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB48C17E0CA1;
	Thu,  6 Nov 2025 15:46:24 +0100 (CET)
Message-ID: <899fb4c2ce292bcce4caeb6cf6f38744c449e8e9.camel@collabora.com>
Subject: Re: [PATCH v5 5/8] media: mediatek: vcodec: fix vp9 4096x2176 fail
 for profile2
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
Date: Thu, 06 Nov 2025 09:46:22 -0500
In-Reply-To: <20251106061323.2193-6-kyrie.wu@mediatek.com>
References: <20251106061323.2193-1-kyrie.wu@mediatek.com>
	 <20251106061323.2193-6-kyrie.wu@mediatek.com>
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
	protocol="application/pgp-signature"; boundary="=-RJXZVmVnlFQ3K2q8dvWW"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-RJXZVmVnlFQ3K2q8dvWW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le jeudi 06 novembre 2025 =C3=A0 14:13 +0800, Kyrie Wu a =C3=A9crit=C2=A0:
> The dram addr of vp9 decoder tile number, which use dram mode
> to set tile information, may reach to 36bits for 4096x2176.
> It needs to get the highest 4bit of tile buffer address to
> set tile buffer address.

Please rework that commit message. Perhaps:

	The DRAM address of the VP9 decoder mode info (MI) buffers may require
	as much as 36bits for 4096x2176 resolution. Fold the 4 most significant
	bits into the lower (padding) four bits of address.

>=20
> Fixes: 5d418351ca8f1 ("media: mediatek: vcodec: support stateless VP9 dec=
oding")
>=20
> Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
> =C2=A0.../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9=
_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp=
9_req_lat_if.c
> index d966914db4b9..91c563c049bd 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> @@ -1156,7 +1156,10 @@ static int vdec_vp9_slice_setup_tile_buffer:q(stru=
ct vdec_vp9_slice_instance *inst
> =C2=A0			tiles->size[i][j] =3D size;
> =C2=A0			if (tiles->mi_rows[i]) {
> =C2=A0				*tb++ =3D (size << 3) + ((offset << 3) & 0x7f);
> -				*tb++ =3D pa & ~0xf;
> +				*tb =3D pa & ~0xf;
> +				if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
> +					*tb |=3D (pa >> 32) & 0xf;
> +				tb++;

You are following the style here, so no complaints, though the macros
GENMASK(3, 0) instead of 0xf and GENMASK(31, 4) instead of ~0xf is another =
way
to write this code.

Since this is not always obvious when the alignment padding of an address i=
s
being reused to extend the number of bits of an address, it would be nice i=
f you
add a comment explaining in words what his is doing.

cheers,
Nicolas

> =C2=A0				*tb++ =3D (pa << 3) & 0x7f;
> =C2=A0				mi_row =3D (tiles->mi_rows[i] - 1) & 0x1ff;
> =C2=A0				mi_col =3D (tiles->mi_cols[j] - 1) & 0x3f;

--=-RJXZVmVnlFQ3K2q8dvWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQy0vgAKCRDZQZRRKWBy
9L2NAQC5CFyK0h7cwfX3f6U15ujRa3Ls59ivxET4FMGkhDKXOwEAnBWXXu23j4ET
ZmbIdwMT3KVsp0HnznoqU3/1OIsg7QI=
=MdCW
-----END PGP SIGNATURE-----

--=-RJXZVmVnlFQ3K2q8dvWW--

