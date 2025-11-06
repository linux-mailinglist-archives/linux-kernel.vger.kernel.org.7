Return-Path: <linux-kernel+bounces-888776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F1C3BE26
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A7B1B25A6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657F342CA5;
	Thu,  6 Nov 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P8Sv5o1K"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA918D65C;
	Thu,  6 Nov 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440485; cv=none; b=VHv5FitHW5aKdlGp/6CqAqMI7p/Gj02lqyfeQMfV638mgfWKlS2j5tFKaBR823vYlJSLxgZWAYTRNx4i66MtBYo+avvHQWw0ATTv2wUmetREXYhyj4L0T4mUlyG3EAs1mJdvHbHHIiym8UgDQBYS5Fx4DpXcmQU+dACOCvCcF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440485; c=relaxed/simple;
	bh=NVoG3xWPvFWyuV2+Q1vbOfMzlKfY/nHbZuN7h+LhVCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e5xsVCy1ieytesySBK3/4Y8iKrdgrPXFewBpeXQJbi0Ea0LCIyHo3c7Gj3yzuCl6idcoeooOtGWAFX4ThGVKlugSde5q6lykiaG6+FZ+sB4bGzaN/KuCDhiSgbxy5kCeSV3B0fkAoZ4d32d4fLqV1tplwoRSgzHMid/9OECmIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P8Sv5o1K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762440482;
	bh=NVoG3xWPvFWyuV2+Q1vbOfMzlKfY/nHbZuN7h+LhVCE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P8Sv5o1Kb09LlCaWkB+QK7hoSOb16P0TO5TFjuDulBvhJRcJkGPowf8PaKnBxRJdG
	 V2YobvLU02bh8dJcu0Gf+dMocbbQOKJbRyczUiBFfL90h+f5yEVW7yqOTCXU/vVGGv
	 5adodBHM5VC44k3x8MBmzUTIuIr+YHZc4LjF1SkRrgzv4zOhQlclVxVrLxlLe4rOUL
	 8bS8LeSNZM64HoNojXzX2AlyOJ8PESU304M5KdQ8DnTiMKWA8wHAAKxZQNkP8YcEZK
	 Jr7FHovQBnYRLW7uNCLuJacBtpE99T2SR12WKzNvMqpAXs4GmGHTYXMTX6JMjPGD0I
	 FISUbrf33E2lw==
Received: from [IPv6:2606:6d00:11:ef24::c41] (unknown [IPv6:2606:6d00:11:ef24::c41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9746D17E0CA1;
	Thu,  6 Nov 2025 15:47:59 +0100 (CET)
Message-ID: <b5daa900a1af6f379d5fb9757d2712102ca0fc51.camel@collabora.com>
Subject: Re: [PATCH v5 6/8] media: mediatek: vcodec: fix media device node
 number
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
Date: Thu, 06 Nov 2025 09:47:58 -0500
In-Reply-To: <20251106061323.2193-7-kyrie.wu@mediatek.com>
References: <20251106061323.2193-1-kyrie.wu@mediatek.com>
	 <20251106061323.2193-7-kyrie.wu@mediatek.com>
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
	protocol="application/pgp-signature"; boundary="=-dw0k1cyaTR4cTZonInhf"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-dw0k1cyaTR4cTZonInhf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

fix -> Fix

Le jeudi 06 novembre 2025 =C3=A0 14:13 +0800, Kyrie Wu a =C3=A9crit=C2=A0:
> change media register device node number to a correct value

You already say that in the subject, the description should explain why vfd=
_dec-
>minor was wrong.

Nicolas
=09

>=20
> Fixes: 41f03c673cb7b ("media: mediatek: vcodec: replace pr_* with dev_* f=
or
> v4l2 debug message")
>=20
> Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
> ---
> =C2=A0.../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git
> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> index fca60e81e3c7..f3e49597602a 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> @@ -516,7 +516,8 @@ static int mtk_vcodec_probe(struct platform_device *p=
dev)
> =C2=A0			goto err_media_reg;
> =C2=A0		}
> =C2=A0
> -		dev_dbg(&pdev->dev, "media registered as /dev/media%d",
> vfd_dec->minor);
> +		dev_dbg(&pdev->dev, "media registered as /dev/media%d",
> +			dev->mdev_dec.devnode->minor);
> =C2=A0	}
> =C2=A0
> =C2=A0	mtk_vcodec_dbgfs_init(dev, false);

--=-dw0k1cyaTR4cTZonInhf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQy1HgAKCRDZQZRRKWBy
9BVgAQC+iAI0ZqnWQqu2KvJUTK7prLEhAUHzmKwd9pG9Nx+E7AEAo7bjfYGdm8u7
z40OWyl6fz38vMuFu2rqg/NIamcIKwQ=
=vTvd
-----END PGP SIGNATURE-----

--=-dw0k1cyaTR4cTZonInhf--

