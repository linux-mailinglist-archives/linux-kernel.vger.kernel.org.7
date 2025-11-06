Return-Path: <linux-kernel+bounces-888704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC2AC3BB5E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E962E1AA7022
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C233F8DD;
	Thu,  6 Nov 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pHS0e98b"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE72E7F1C;
	Thu,  6 Nov 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438701; cv=none; b=Vh1CwRVtrEF2VNYeVUf9COU86YGTibBHrsrQpy2n71z1J9LFM4CGxLcwfQdslNUvE3bMiBv5IKaM1ndphIko/C0JCAKAGq6DRwrya28/amskPRg+Nenx78c1KVNXORp7nchvJGJzA/alfukQNMqeRIKexWEMrEYat/WOEB9QfWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438701; c=relaxed/simple;
	bh=D1YqLCZ+wLztmcGu4DKC3azE74VCT3buGcL50oC22eU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qNTDgGWMF1OyerFPpvpNtONBxmYCvZxvd8xrPwHVRahcjit13iJgOpXw4YLuwqOONc268zm9ztrUVqOOekaktC8WrM6eAekPRnN650K7WlNqkLEaiy+KEPglIn56txRi6IUbD1Jk1oWWvg8MgqYw1ITWeHC9QS7qMTsfWBa1CxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pHS0e98b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762438690;
	bh=D1YqLCZ+wLztmcGu4DKC3azE74VCT3buGcL50oC22eU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pHS0e98bq+XlRk1N9o9qiu5PBFQRLoK8tS0F0eg6MyGsSEDmpq5aGzsBXdGA/LFla
	 zOay8S0aKHGlPX5dPqGUIqBCToYQjXKFXU9r6OxDTHAAW6opc7D6jLbwvNiwsTa7U6
	 veFCOG4PgaL77nH4Vbsy+4mjMCgaYgVqeD/paKL5CCyNFwKUFFXR+UNhveCb8m66RR
	 2jtKQNsK+nCMJHZ1UNizKFYB3aX9MyJOv2CN/PWJkEPYVq+OMgqsWu8tDw3t3mTnQT
	 pGRh4WA6JN4FjINHYkc5/rkhH3ZDix99BreqWFTYGCvw98WzVeWxGsErhBWpQKvqQ4
	 yvUvpGLKg3YSg==
Received: from [IPv6:2606:6d00:11:ef24::c41] (unknown [IPv6:2606:6d00:11:ef24::c41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A83117E0299;
	Thu,  6 Nov 2025 15:18:08 +0100 (CET)
Message-ID: <c49b979fd911f2587bbfed129b07065f1cd2a2db.camel@collabora.com>
Subject: Re: [PATCH v5 0/8] Enable video decoder & encoder for MT8189
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
Date: Thu, 06 Nov 2025 09:18:06 -0500
In-Reply-To: <20251106061323.2193-1-kyrie.wu@mediatek.com>
References: <20251106061323.2193-1-kyrie.wu@mediatek.com>
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
	protocol="application/pgp-signature"; boundary="=-AX19oTKFu1+mQq19n1Qb"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-AX19oTKFu1+mQq19n1Qb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le jeudi 06 novembre 2025 =C3=A0 14:13 +0800, Kyrie Wu a =C3=A9crit=C2=A0:
> This series have the follow changing:
> Firstly add mt8189 video decoder compatible, profile and level to support
> MT8189 kernel driver.
> Secondly fix some bugs, including vp 4K profile2 and media device node
> number bug.
> Lastly, add mt8189 video encoder compatible.
>=20
> This series has been tested with MT8189 tast test.
> Encoding and decoding worked for this chip.
>=20
> Patches 1-2 Add decoder compatible.
> Patches 3 Add profile and level supporting.
> Patches 4 Add core-only VP9 decoding supporting.
> Patches 5-6 fix some bugs.
> Patches 7-8 Adds encoder compatible.
>=20
> ---
> H264 test results:
> ./fluster.py run -d GStreamer-H.264-V4L2SL-Gst1.0 -j2 -t 90
> =C2=A0=C2=A0=C2=A0 JVT-AVC_V1	Ran 96/135 tests successfully
>=20
> VP9 test results:
> ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0 -j2 -t 90
> 	VP9-TEST-VECTORS	Ran 276/305 tests successfully
>=20
> v4l2-compliance test results:
> Compliance test for mtk-vcodec-enc device /dev/video2:
> Total for mtk-vcodec-enc device /dev/video2: 47, Succeeded: 46, Failed: 1=
, Warnings: 0

There is one fail, can you explain it ?

Nicolas

> Compliance test for mtk-vcodec-dec device /dev/video3:
> Total for mtk-vcodec-dec device /dev/video3: 48, Succeeded: 48, Failed: 0=
, Warnings: 0
>=20
> scp upstream link:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20250811015922.=
32680-1-huayu.zong@mediatek.com/
> dtsi upstream link:
> https://lore.kernel.org/linux-mediatek/20251030134541.784011-12-jh.hsu@me=
diatek.com/T/#m847e35de0a5b18fac0ca0624a8559d84964ad5c7
>=20
> Changes compared with v4:
> --update H264 & vp9 fluster test results
> --update vp9 single core decoder prob size setting and commit messages
>=20
> Changes compared with v3:
> --add reviewer to commit messages
> --Rebased on top of the latest media tree
>=20
> Changes compared with v2:
> --add H264 fluster test results
> --reorder compatible string for dt-bindings
>=20
> Changes compared with v1:
> --add v4l2-compliance test results
> --add scp upstream link
> --add HW difference discriptions for dt-bindings commit messages
>=20
> This series patches dependent on:
> [1]
> https://patchwork.linuxtv.org/project/linux-media/cover/20250510075357.11=
761-1-yunfei.dong@mediatek.com/
> [2]
> https://patchwork.linuxtv.org/project/linux-media/cover/20250814085642.17=
343-1-kyrie.wu@mediatek.com/
>=20
> Kyrie Wu (8):
> =C2=A0 dt-bindings: media: mediatek: decoder: Add MT8189
> =C2=A0=C2=A0=C2=A0 mediatek,vcodec-decoder
> =C2=A0 media: mediatek: vcodec: add decoder compatible to support MT8189
> =C2=A0 media: mediatek: vcodec: add profile and level supporting for MT81=
89
> =C2=A0 media: mediatek: vcodec: Add single core VP9 decoding support for
> =C2=A0=C2=A0=C2=A0 MT8189
> =C2=A0 media: mediatek: vcodec: fix vp9 4096x2176 fail for profile2
> =C2=A0 media: mediatek: vcodec: fix media device node number
> =C2=A0 dt-bindings: media: Add MT8189 mediatek,vcodec-encoder
> =C2=A0 media: mediatek: encoder: Add MT8189 encoder compatible data
>=20
> =C2=A0.../media/mediatek,vcodec-encoder.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A0.../media/mediatek,vcodec-subdev-decoder.yaml |=C2=A0 5 +-
> =C2=A0.../vcodec/decoder/mtk_vcodec_dec_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 9 +++-
> =C2=A0.../vcodec/decoder/mtk_vcodec_dec_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> =C2=A0.../vcodec/decoder/mtk_vcodec_dec_stateless.c |=C2=A0 4 ++
> =C2=A0.../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c | 48 ++++++++++++++--=
---
> =C2=A0.../vcodec/encoder/mtk_vcodec_enc_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 14 ++++++
> =C2=A07 files changed, 68 insertions(+), 15 deletions(-)

--=-AX19oTKFu1+mQq19n1Qb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQyuHgAKCRDZQZRRKWBy
9GzzAQC9JvEjAqGmbr6LW33oZiyGcWY0ryOA79ls2yujy1q7iwEA0bH9kaKtrf0m
Qb5ZjB7rfho2ovN2pheFNN9ADJ88AQw=
=8/5c
-----END PGP SIGNATURE-----

--=-AX19oTKFu1+mQq19n1Qb--

