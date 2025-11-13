Return-Path: <linux-kernel+bounces-899179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1CEC57028
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78885355F88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD6F334394;
	Thu, 13 Nov 2025 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mVUp5sG1"
Received: from mx-relay50-hz3.antispameurope.com (mx-relay50-hz3.antispameurope.com [94.100.134.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503522A80D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.239
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030888; cv=pass; b=Hud0juDlRDx4JHNjDyfiSLQrY/pjpN8AV/a7Ga40DiCSE5Mb2veUIKWaaZiy+32EdqtdEwVMF6QgDlz0h0NTM/hkSuiZleU8VTvlX/6Z3NMliPKuVWLQoTvJYQEa5iwhSWr6WsXXCszYOgrpLFlRZGrJwRraRq/QLpGHWQPGlQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030888; c=relaxed/simple;
	bh=+7g+UtPmV34BNSCav0a+cKt01S3ncAII8xDayvopAW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olqj5UYzUjEmTKOlPcJu7ZJXM842iZyTk8C5F+8FV6MnRwbzGFQ0521BdIgbWjOblo0PqsRDwoF3gGglvQdBplcuP8qfHM74mLd+ZnSlhZMcpeM/76aIkPAbYY7uyr+U0MeIDBspoeLOpJqujg4KPqCeJI+ivCenwcXdx5CFQy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=mVUp5sG1; arc=pass smtp.client-ip=94.100.134.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate50-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=cPfvqiPK0XBbGB7jgxZcnmtoFkef5Esy2Ux2OKDfXoY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763030848;
 b=OKD9Mb87iokPK9qy1E+ZH/TRd2k9XGze+FbEPnK2jdMs1simK1NA3oF849DpQZmpzRtiBhnq
 K9otDnfZ+gkUMnNGgeCQdjTnlpgEvRsiA41MLt4+dmir9jjAClbI/rVuujZYU3uD/ZehMtgWuku
 d1WPymmvc4hVkmc0FvSSE+tMlMQk4bSGyEexdwI9rolk7zcuSCtL6QVeBXypS5Vp/pefBLfyJHh
 2SR/PwE9GdVIyYstsie3JPip3LgRfdV6eOMlHVjdjb2gSpcePLW1oii91o1mfsbeZ9ealLmDdsm
 IpKLbmTmDdEiDuc4eT/8yaRAY4g6cn+IiHxIP3gQWiAKg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763030848;
 b=KapKfPRYxPX5IrVqfL3gIdvO28tgiZRRpjUbTtbXLSQuHWCw7B3422rLAPQLrl9U3S5NxYxF
 QF4fDcarVXlQVE6rf3mPMyr0ThTH6pAFAqtpBhmwyFJHaBEKCI0faEBM9itfNR+kM2PY+1rV0jl
 +tX+rsoH+KbCEL5kAE8dBJy98i/03cniBMVvwI/aIb+U3lyXT246ykDk+DgtMToY7LjtN8XqCUh
 YBWGhCvziOP1SEKA4Xg5/SWSwsbeo/kB/7695x3t8KuEHKU6adwnVyfgsBQtPeNkplNnrkzc+zK
 ya7G8hwDrdFsWjDpKlCqnMh5HKEG6/+fFVmpAVdodH3Ng==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay50-hz3.antispameurope.com;
 Thu, 13 Nov 2025 11:47:28 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 7250ECC0A1D;
	Thu, 13 Nov 2025 11:47:14 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Liu Ying <victor.liu@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 1/1] drm: lcdif: Use dev_err_probe()
Date: Thu, 13 Nov 2025 11:47:13 +0100
Message-ID: <3410946.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20251020095846.116202-1-alexander.stein@ew.tq-group.com>
References: <20251020095846.116202-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay50-hz3.antispameurope.com with 4d6cR73sMNz2nGtR
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:8e80b3bb434ae492471754dc7e2ef656
X-cloud-security:scantime:2.077
DKIM-Signature: a=rsa-sha256;
 bh=cPfvqiPK0XBbGB7jgxZcnmtoFkef5Esy2Ux2OKDfXoY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763030848; v=1;
 b=mVUp5sG1El/bJ3r4RX8jZKFDeg7gem6l+T/JpjnrTCRxTgQBkX+SHQZzPW/Big4HbLqfut7Y
 twsJq248dil/Bb5lBN9BhmdwWQEtb5PBbUUnoi2fPPevyIg0dW5qkVKGMvLk7CbySV1RjAU1unH
 ZvMxtcf/9UpgI+q0wE0FfLwQgUttdgyUVWibxRFIbx4rEy7roKrbdFXK+3cQbVhECdqRde/Ch7R
 CrtraAyDUOhExs2LD2zl9v9tXM5uu56sBrQPLcNichMRB1OYuwpEmYv/d0KLNnTZnxvLr2EOnct
 hQFdQmGbA+TOefG4Qc5wuTccMzwIgQVW2Kge0jfiVKYDg==

Hi,

Am Montag, 20. Oktober 2025, 11:58:45 CET schrieb Alexander Stein:
> Use dev_err_probe() to add a reason for deferred probe. This can
> especially happen on lcdif3 which uses hdmi_tx_phy for 'pix' clock
>=20
> Reviewed-by: Liu Ying <victor.liu@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Any other feedback?

Thanks and best regards
Alexander
> ---
> Changes in v2:
> * Collected Liu's and Marcos' R-b
>=20
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lc=
dif_drv.c
> index fcb2a7517377e..47da1d9336b90 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -149,15 +149,17 @@ static int lcdif_load(struct drm_device *drm)
> =20
>  	lcdif->clk =3D devm_clk_get(drm->dev, "pix");
>  	if (IS_ERR(lcdif->clk))
> -		return PTR_ERR(lcdif->clk);
> +		return dev_err_probe(drm->dev, PTR_ERR(lcdif->clk), "Failed to get pix=
 clock\n");
> =20
>  	lcdif->clk_axi =3D devm_clk_get(drm->dev, "axi");
>  	if (IS_ERR(lcdif->clk_axi))
> -		return PTR_ERR(lcdif->clk_axi);
> +		return dev_err_probe(drm->dev, PTR_ERR(lcdif->clk_axi),
> +				     "Failed to get axi clock\n");
> =20
>  	lcdif->clk_disp_axi =3D devm_clk_get(drm->dev, "disp_axi");
>  	if (IS_ERR(lcdif->clk_disp_axi))
> -		return PTR_ERR(lcdif->clk_disp_axi);
> +		return dev_err_probe(drm->dev, PTR_ERR(lcdif->clk_disp_axi),
> +				     "Failed to get disp_axi clock\n");
> =20
>  	platform_set_drvdata(pdev, drm);
> =20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



