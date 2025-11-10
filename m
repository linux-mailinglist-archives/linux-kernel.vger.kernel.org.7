Return-Path: <linux-kernel+bounces-893316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90063C4711C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847F03A66B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312D33126D9;
	Mon, 10 Nov 2025 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h6DFsJ4X"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64513112C4;
	Mon, 10 Nov 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783059; cv=none; b=sDGi0gzqbu/SbDC3PpIKawPq0Vs8IKOmJwSUiPYQaaitCYDS31jKMGZP7L+jg3Qo0Es3Ho/tP4FMSL284DnNIENhWM/CzgBQKoyzm7El8ddQ+xjM6dKJb/KcxXdsvSRKi//bcng2/PQEkQRVrwL0767D1kGMvhm454mLA+U9GhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783059; c=relaxed/simple;
	bh=KKRgKuFzrzMKfhZwoLlMMqh/HMidHruZpOkU87ZuQX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RpMUxR2LuSh7knhZSZcvysD0VeuvOR3SGil+doPWQn4O0zl54AJecCqgvf7j9YuUjtRYqNgxYnu7HLYOfCkaKvFNUVjnD29jpaPJ9PxEvp5TfmjKvdJnN7yP4R5HDklf9otZLJg2FUWXGmH+CE3yPDYEIMzip4V5Bh4HYmwmtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h6DFsJ4X; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762783051;
	bh=KKRgKuFzrzMKfhZwoLlMMqh/HMidHruZpOkU87ZuQX8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=h6DFsJ4X6waWfhY3+YKw2XbcsEITbdvCaI7t6SQyO63CqQ2v7RT+/BgjWpLXVWbbJ
	 jOMSwFyatiq0v5ccn8vslvqnFkhtRZMeGGyLVMyBX2WWLvOFokRpOL1U/wG/Dh+j9P
	 AnLTP414aOhJLr5WUkC8YgOpP4az7amlae1b5g59Coun08z2ypdVpQXH8o9LooTpxO
	 1hXBlflRgOWrpHpu+bxCmMTfHrvmBvR6KI+jkul9hmJTGyY06WdGcBvUmDSQktxeO9
	 GUssCYfEMh4Pp9WeclYedwt0Z6fGNwiNeoYJyu6Lpvgjwu0Sh6AL6dZK+DpdLjt5Pm
	 9+ooPKi8idFxg==
Received: from [IPv6:2606:6d00:11:ef24::c41] (unknown [IPv6:2606:6d00:11:ef24::c41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C9FD17E110D;
	Mon, 10 Nov 2025 14:57:29 +0100 (CET)
Message-ID: <f4fee7587d8e3e58bab39f1b3202b67f0f5c3e04.camel@collabora.com>
Subject: Re: [PATCH v5 0/8] Enable video decoder & encoder for MT8189
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Kyrie Wu =?UTF-8?Q?=28=E5=90=B4=E6=99=97=29?= <Kyrie.Wu@mediatek.com>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org"	 <linux-mediatek@lists.infradead.org>,
 George Sun =?UTF-8?Q?=28=E5=AD=99=E6=9E=97=29?=	 <George.Sun@mediatek.com>,
 Tiffany Lin =?UTF-8?Q?=28=E6=9E=97=E6=85=A7=E7=8F=8A=29?=	
 <tiffany.lin@mediatek.com>, "nhebert@chromium.org" <nhebert@chromium.org>, 
 "linux-media@vger.kernel.org"	 <linux-media@vger.kernel.org>,
 "devicetree@vger.kernel.org"	 <devicetree@vger.kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,  "hverkuil@xs4all.nl"	
 <hverkuil@xs4all.nl>, Yunfei Dong
 =?UTF-8?Q?=28=E8=91=A3=E4=BA=91=E9=A3=9E=29?=	 <Yunfei.Dong@mediatek.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,  Irui Wang
 =?UTF-8?Q?=28=E7=8E=8B=E7=91=9E=29?=	 <Irui.Wang@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>, 
 "linux-arm-kernel@lists.infradead.org"	
 <linux-arm-kernel@lists.infradead.org>, Yilong Zhou
 =?UTF-8?Q?=28=E5=91=A8=E6=98=93=E9=BE=99=29?=	 <Yilong.Zhou@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,  "krzk+dt@kernel.org"	
 <krzk+dt@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Andrew-CT Chen
 =?UTF-8?Q?=28=E9=99=B3=E6=99=BA=E8=BF=AA=29?=	
 <Andrew-CT.Chen@mediatek.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>
Cc: "andrzejtp2010@gmail.com" <andrzejtp2010@gmail.com>, 
 "neil.armstrong@linaro.org"
	 <neil.armstrong@linaro.org>
Date: Mon, 10 Nov 2025 08:57:26 -0500
In-Reply-To: <09eb315e50aeaf865b093880aaaa5f2c9c0feba9.camel@mediatek.com>
References: <20251106061323.2193-1-kyrie.wu@mediatek.com>
		 <c49b979fd911f2587bbfed129b07065f1cd2a2db.camel@collabora.com>
	 <09eb315e50aeaf865b093880aaaa5f2c9c0feba9.camel@mediatek.com>
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
	protocol="application/pgp-signature"; boundary="=-QUHvuhjIUwreEvkskggy"
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-QUHvuhjIUwreEvkskggy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 10 novembre 2025 =C3=A0 02:32 +0000, Kyrie Wu (=E5=90=B4=E6=99=97)=
 a =C3=A9crit=C2=A0:
>=20
> On Thu, 2025-11-06 at 09:18 -0500, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le jeudi 06 novembre 2025 =C3=A0 14:13 +0800, Kyrie Wu a =C3=A9crit :
> > > This series have the follow changing:
> > > Firstly add mt8189 video decoder compatible, profile and level to
> > > support
> > > MT8189 kernel driver.
> > > Secondly fix some bugs, including vp 4K profile2 and media device
> > > node
> > > number bug.
> > > Lastly, add mt8189 video encoder compatible.
> > >=20
> > > This series has been tested with MT8189 tast test.
> > > Encoding and decoding worked for this chip.
> > >=20
> > > Patches 1-2 Add decoder compatible.
> > > Patches 3 Add profile and level supporting.
> > > Patches 4 Add core-only VP9 decoding supporting.
> > > Patches 5-6 fix some bugs.
> > > Patches 7-8 Adds encoder compatible.
> > >=20
> > > ---
> > > H264 test results:
> > > ./fluster.py run -d GStreamer-H.264-V4L2SL-Gst1.0 -j2 -t 90
> > > =C2=A0=C2=A0=C2=A0=C2=A0JVT-AVC_V1Ran 96/135 tests successfully
> > >=20
> > > VP9 test results:
> > > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0 -j2 -t 90
> > > VP9-TEST-VECTORSRan 276/305 tests successfully
> > >=20
> > > v4l2-compliance test results:
> > > Compliance test for mtk-vcodec-enc device /dev/video2:
> > > Total for mtk-vcodec-enc device /dev/video2: 47, Succeeded: 46,
> > > Failed: 1, Warnings: 0
> >=20
> > There is one fail, can you explain it ?
> >=20
> > Nicolas
>=20
> Dear Nicolas,
>=20
> The failure is caused by subscribed event/dqevent. Our encoder driver
> didn't register those apis, which caused this failure.
> Here is the fail log, which is samed as MT8196:
>=20
> https://patchwork.linuxtv.org/project/linux-media/cover/20250528063633.14=
054-1-irui.wang@mediatek.com/
>=20
> Control ioctls:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test VIDIOC_QUERY_EXT_CTR=
L/QUERYMENU: OK
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test VIDIOC_QUERYCTRL: OK
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test VIDIOC_G/S_CTRL: OK
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test VIDIOC_G/S/TRY_EXT_C=
TRLS: OK
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0fail: v4l2-test-controls.cpp(1171): node->codec_mas=
k &
> STATEFUL_ENCODER
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test VIDIOC_(UN)SUBSCRIBE=
_EVENT/DQEVENT: FAIL
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test VIDIOC_G/S_JPEGCOMP:=
 OK (Not Supported)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Standard Controls: 16 Pri=
vate Controls: 0


The spec says:
  =20
  =20
   For backwards compatibility, the encoder will signal a V4L2_EVENT_EOS ev=
ent when
   the last frame has been encoded and all frames are ready to be dequeued.=
=20

In practice, we test for that on every m2m, see the test code:


	if (node->is_m2m) {
		node_m2m_cap->g_fmt(fmt_q, m2m_q.g_type());
		if (node_m2m_cap->buftype_pixfmts[m2m_q.g_type()][fmt_q.g_pixelformat()] =
&
			V4L2_FMT_FLAG_COMPRESSED)
			valid_output_flags =3D V4L2_BUF_FLAG_TIMECODE | V4L2_BUF_FLAG_TSTAMP_SRC=
_MASK;

		struct v4l2_event_subscription sub =3D { 0 };

		sub.type =3D V4L2_EVENT_EOS;
		if (node->codec_mask & (STATEFUL_ENCODER | STATEFUL_DECODER))
			doioctl(node, VIDIOC_SUBSCRIBE_EVENT, &sub);
	}

please fix,
Nicolas

>=20
> Thanks.
>=20
> Regards,
> Kyrie.
>=20
> >=20
> > > Compliance test for mtk-vcodec-dec device /dev/video3:
> > > Total for mtk-vcodec-dec device /dev/video3: 48, Succeeded: 48,
> > > Failed: 0, Warnings: 0
> > >=20
> > > scp upstream link:
> > >=20
> https://patchwork.kernel.org/project/linux-mediatek/patch/20250811015922.=
32680-1-huayu.zong@mediatek.com/
> > > dtsi upstream link:
> > >=20
> https://lore.kernel.org/linux-mediatek/20251030134541.784011-12-jh.hsu@me=
diatek.com/T/#m847e35de0a5b18fac0ca0624a8559d84964ad5c7
> > >=20
> > > Changes compared with v4:
> > > --update H264 & vp9 fluster test results
> > > --update vp9 single core decoder prob size setting and commit
> > > messages
> > >=20
> > > Changes compared with v3:
> > > --add reviewer to commit messages
> > > --Rebased on top of the latest media tree
> > >=20
> > > Changes compared with v2:
> > > --add H264 fluster test results
> > > --reorder compatible string for dt-bindings
> > >=20
> > > Changes compared with v1:
> > > --add v4l2-compliance test results
> > > --add scp upstream link
> > > --add HW difference discriptions for dt-bindings commit messages
> > >=20
> > > This series patches dependent on:
> > > [1]
> > >=20
> https://patchwork.linuxtv.org/project/linux-media/cover/20250510075357.11=
761-1-yunfei.dong@mediatek.com/
> > > [2]
> > >=20
> https://patchwork.linuxtv.org/project/linux-media/cover/20250814085642.17=
343-1-kyrie.wu@mediatek.com/
> > >=20
> > > Kyrie Wu (8):
> > > =C2=A0=C2=A0dt-bindings: media: mediatek: decoder: Add MT8189
> > > =C2=A0=C2=A0=C2=A0=C2=A0mediatek,vcodec-decoder
> > > =C2=A0=C2=A0media: mediatek: vcodec: add decoder compatible to suppor=
t MT8189
> > > =C2=A0=C2=A0media: mediatek: vcodec: add profile and level supporting=
 for
> > > MT8189
> > > =C2=A0=C2=A0media: mediatek: vcodec: Add single core VP9 decoding sup=
port for
> > > =C2=A0=C2=A0=C2=A0=C2=A0MT8189
> > > =C2=A0=C2=A0media: mediatek: vcodec: fix vp9 4096x2176 fail for profi=
le2
> > > =C2=A0=C2=A0media: mediatek: vcodec: fix media device node number
> > > =C2=A0=C2=A0dt-bindings: media: Add MT8189 mediatek,vcodec-encoder
> > > =C2=A0=C2=A0media: mediatek: encoder: Add MT8189 encoder compatible d=
ata
> > >=20
> > > =C2=A0.../media/mediatek,vcodec-encoder.yaml        |  2 +
> > > =C2=A0.../media/mediatek,vcodec-subdev-decoder.yaml |  5 +-
> > > =C2=A0.../vcodec/decoder/mtk_vcodec_dec_drv.c       |  9 +++-
> > > =C2=A0.../vcodec/decoder/mtk_vcodec_dec_drv.h       |  1 +
> > > =C2=A0.../vcodec/decoder/mtk_vcodec_dec_stateless.c |  4 ++
> > > =C2=A0.../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c | 48 ++++++++++++=
++-
> > > ----
> > > =C2=A0.../vcodec/encoder/mtk_vcodec_enc_drv.c       | 14 ++++++
> > > =C2=A07 files changed, 68 insertions(+), 15 deletions(-)
>=20
> ************* MEDIATEK Confidentiality Notice
> =C2=A0********************
> The information contained in this e-mail message (including any=20
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be=20
> conveyed only to the designated recipient(s). Any use, dissemination,=20
> distribution, printing, retaining or copying of this e-mail (including it=
s=20
> attachments) by unintended recipient(s) is strictly prohibited and may=
=20
> be unlawful. If you are not an intended recipient of this e-mail, or beli=
eve
> =C2=A0
> that you have received this e-mail in error, please notify the sender=20
> immediately (by replying to this e-mail), delete any and all copies of=
=20
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

--=-QUHvuhjIUwreEvkskggy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaRHvRgAKCRDZQZRRKWBy
9IodAP92sXKXxtzBgiSqcP5IWsLSfYE7FE4ekNtUGbBoWcArxAEAm5t9IiBp57Ej
BAdduiviuXeRaE4BvqzLvLjiSOUUiAc=
=JqZh
-----END PGP SIGNATURE-----

--=-QUHvuhjIUwreEvkskggy--

