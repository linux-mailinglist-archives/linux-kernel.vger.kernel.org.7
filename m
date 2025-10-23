Return-Path: <linux-kernel+bounces-867446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F20FC02A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED4A189C043
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D360340A67;
	Thu, 23 Oct 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="lAoy7FAG"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5E23A9AE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239167; cv=pass; b=MutxuKjd3stsHfhZ6T0+D1AZRwszzut9cmmfpCfgWLILecceNvcna3ozwlOgsWZ5vIwwDvPLwCBdWH4SqqCRNzPwqnw3QcOKlI4S3JWWP8Kws8KtwKSoBAnCd1LQBszCQmY2S657NUEpN6Y50zfSgijgpue42tKB4v775pBdLyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239167; c=relaxed/simple;
	bh=doFq+KAPnF9d8vUlzJpsUFF/6nlCw0llWQ17gnq+SwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZHCNyGzvFKodM7NqZ4O3tcDv66xFiPcZK7tV+Ez+3tajzFd34PCDCPnCKQT9ux7EBTH7x51MaQYfMwczTXWHd3h+EP+nX4FUQSuKVHw3+6EjSPvI1moLLYdoOSsAGAKDoNGv6mOAL/t0Cu83b0J5YWUVa8eyO7A/ZQVRa736tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=lAoy7FAG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761239142; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B73QoxPD3VyOxVdGEzFNxx59VdD+bX0v1/HUGhLYrWLrFOgQ5ucBpwXQCqSCnEacfznyeTAfH4QIp8hdSsHjcy0PDEUcnWgSNc9ZZlp8LJNg14p5A7kGzUAn3ODpUds3CDkESMSTafr0f/s9D4PeDwNFgS03Yqtyq06aS8OLIGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761239142; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=doFq+KAPnF9d8vUlzJpsUFF/6nlCw0llWQ17gnq+SwA=; 
	b=C3Q3x17n5XrkRG4x7NWK36I+iDh6Tp9rYuqniXPmTfrEBN526Gnv5WNheXYCG0Trr3MdU70V7tqHxx2dex+bVvR++6UrKxCjx/Yaj3UdX+28OGoyBikX5tIl0+IMXipTiqAI/moBXii2VdLQogLHNMF5uxz7GnPKfyc9HBatRhc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761239142;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=doFq+KAPnF9d8vUlzJpsUFF/6nlCw0llWQ17gnq+SwA=;
	b=lAoy7FAGFwNhyfn8q8DeaQz6wgUwvIOG+GI4W2e5sEcs6GV7TO/WaswT0eYu67U/
	iZofSecg8lI+fn71L/TNJqerqjtkM7YGK/PU0XFE2KBloBjLExACJYigstlxCHOJSVw
	0JalTZYeb1cIS5h5/Vfu4mHIb49MxND8bEUzTux8=
Received: by mx.zohomail.com with SMTPS id 1761239140304964.1024061848422;
	Thu, 23 Oct 2025 10:05:40 -0700 (PDT)
Message-ID: <a55c9480da785a8618dd60c3f3e0ddc398c5d45f.camel@collabora.com>
Subject: Re: [PATCH v11 05/11] drm/mediatek: mtk_hdmi_common: Make CEC
 support optional
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Thu, 23 Oct 2025 19:05:31 +0200
In-Reply-To: <CAAOTY_8y6C5=jSjzBVVJ2vJq1L+Nf9U0tZvxzVX-e-3g91xEeQ@mail.gmail.com>
References: <20251023-mediatek-drm-hdmi-v2-v11-0-7873ec4a1edf@collabora.com>
	 <20251023-mediatek-drm-hdmi-v2-v11-5-7873ec4a1edf@collabora.com>
	 <CAAOTY_8y6C5=jSjzBVVJ2vJq1L+Nf9U0tZvxzVX-e-3g91xEeQ@mail.gmail.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi,

On Thu, 2025-10-23 at 15:59 +0000, Chun-Kuang Hu wrote:
> Hi, Louis:
>=20
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> =E6=96=BC 2025=E5=
=B9=B410=E6=9C=8823=E6=97=A5
> =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:32=E5=AF=AB=E9=81=93=EF=BC=9A
> >=20
> > From: AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> >=20
> > In preparation for adding a new driver for HDMIv2, for which CEC
> > is not strictly required, change the of_get_compatible_child()
> > failure error to -ENOTSUPP to be able to differentiate between
> > error conditions in mtk_hdmi_dt_parse_pdata().
> >=20
> > In that case, if -ENOTSUPP is returned, this driver will print
> > an informative message saying that CEC support is unavailable,
> > as the devicetree node for that was not found, but after that,
> > function mtk_hdmi_dt_parse_pdata() will not return error to
> > the caller.
> >=20
> > This will not change functionality of the mtk_hdmi (v1) driver
> > as that is still checking whether CEC is present and, if not,
> > will fail probing with an error saying that CEC is required
> > by HDMIv1.
> >=20
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
> > ---
> > =C2=A0drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 9 +++++----
> > =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> > b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> > index
> > f28e63716d7c2e2c6bdf5b28d24789bc926d2beb..989479fdfe40952762a1b6379
> > 7bf602b520dcac5 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> > @@ -253,12 +253,11 @@ static int mtk_hdmi_get_cec_dev(struct
> > mtk_hdmi *hdmi, struct device *dev, struc
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The CEC module handles HD=
MI hotplug detection */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cec_np =3D of_get_compatible=
_child(np->parent,
> > "mediatek,mt8173-cec");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cec_np)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return dev_err_probe(dev, -EINVAL, "Failed to find
> > CEC node\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return dev_err_probe(dev, -ENOTSUPP, "Failed to
> > find CEC node\n");
>=20
> The checkpatch show the warning:
>=20
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> #40: FILE: drivers/gpu/drm/mediatek/mtk_hdmi_common.c:256:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, -EN=
OTSUPP, "Failed to find CEC
> node\n");
>=20
> I find many driver use ENOTSUPP, so I'm not sure which one is better.
> I really don't understand the description about these two error code
> [1].
> If you choose ENOTSUPP, please give me some explain.
>=20
> [1] https://man7.org/linux/man-pages/man3/errno.3.html
>=20
> Regards,
> Chun-Kuang.
>=20
>=20
I think ENOTSUPP can be replaced by EOPNOTSUPP in this patch safely.

There is only a single call of the mtk_hdmi_get_cec_dev function in the
driver and the code that checks this particular return code value in
mtk_hdmi_dt_parse_pdata function is also added by this patch.

I also don't see no other occurrence of ENOTSUPP code in mediatek-drm
and since checkpatch recommends to prefer EOPNOTSUPP over ENOTSUPP,
let's replace it in this patch (both code and commit message).

Do you want me to send a new version of the series for this change?

Regards,
Louis-Alexis=20

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cec_pdev =3D of_find_device_=
by_node(cec_np);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cec_pdev) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cec_np);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
> > cec_np);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 of_node_put(cec_np);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EPROBE_DEFER;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > @@ -319,7 +318,9 @@ static int mtk_hdmi_dt_parse_pdata(struct
> > mtk_hdmi *hdmi, struct platform_device
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, -EINVAL, "Failed to get
> > ddc i2c adapter by node\n");
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D mtk_hdmi_get_cec_dev=
(hdmi, dev, np);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ENOTSUPP)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_info(dev, "CEC support unavailable: node not
> > found\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (ret)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >=20
> > --
> > 2.51.0
> >=20

