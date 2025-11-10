Return-Path: <linux-kernel+bounces-892570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FB3C455F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D3F5346E58
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C022F998D;
	Mon, 10 Nov 2025 08:27:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1D2F83AC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763258; cv=none; b=qBdNGivLGIG9zXPyjk5tzgZeCiAYPnsM49iJ8Dk2q1SExELbpEYxFlQxVNPcq4uxyJwN9agwfltIMV4VcZvUOkzZj/jOviUIaXOORBetiCcKVsdbhUfnM6hG6o50pvIutQ5rkOQppWd8Jadmb3o4BZHLIsk6SJpYWm0Gf+pzmIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763258; c=relaxed/simple;
	bh=1pCml4h8G2RzejcPO09IpeB8HRIK4qZx7GIqLp3Rmc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rNHVDofZ0375LntAVsBYUaC67m5CdBhpmmSRiH93l1GZCjwymLGiy0jX+5ddLC7ZNwZeI6XE6Vvt4zZLUXEyUN2rBgtTi06YKzPj0c4kE9tXPPIbKO48/Ti9fDwt+bE3H5qJZkUxscWAU1qWQswOaf6zMrA07V9KhtWs13n/m1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINFB-0006EL-PQ; Mon, 10 Nov 2025 09:27:21 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINFB-007zQY-0g;
	Mon, 10 Nov 2025 09:27:21 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINFB-00000000472-0YzL;
	Mon, 10 Nov 2025 09:27:21 +0100
Message-ID: <90e5e430743eaca4b21097c64c42dd4f579bc48b.camel@pengutronix.de>
Subject: Re: [PATCH 5/6] media: staging: media: imx6-mipi-csi2: use guard()
 to simplify code
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Steve Longerbeam <slongerbeam@gmail.com>, 
 Mauro Carvalho Chehab	 <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team	 <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 10 Nov 2025 09:27:21 +0100
In-Reply-To: <20251107-stage-csi2-cleanup-v1-5-5d42535243ac@nxp.com>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
	 <20251107-stage-csi2-cleanup-v1-5-5d42535243ac@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fr, 2025-11-07 at 15:44 -0500, Frank Li wrote:
> Use guard() to simplify mutex locking. No functional change.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/staging/media/imx/imx6-mipi-csi2.c | 54 +++++++++++-------------=
------
>  1 file changed, 19 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging=
/media/imx/imx6-mipi-csi2.c
> index f8d0b3b8b250774af51f2aba731e639131aceff9..54e9491d3428686288a5bc9bb=
58a5a0a25aca696 100644
> --- a/drivers/staging/media/imx/imx6-mipi-csi2.c
> +++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
> @@ -413,21 +413,17 @@ static int csi2_s_stream(struct v4l2_subdev *sd, in=
t enable)
>  	struct csi2_dev *csi2 =3D sd_to_dev(sd);
>  	int i, ret =3D 0;
> =20
> -	mutex_lock(&csi2->lock);
> +	guard(mutex)(&csi2->lock);
> =20
> -	if (!csi2->src_sd) {
> -		ret =3D -EPIPE;
> -		goto out;
> -	}
> +	if (!csi2->src_sd)
> +		return -EPIPE;
> =20
>  	for (i =3D 0; i < CSI2_NUM_SRC_PADS; i++) {
>  		if (csi2->sink_linked[i])
>  			break;
>  	}
> -	if (i >=3D CSI2_NUM_SRC_PADS) {
> -		ret =3D -EPIPE;
> -		goto out;
> -	}
> +	if (i >=3D CSI2_NUM_SRC_PADS)
> +		return -EPIPE;
> =20
>  	/*
>  	 * enable/disable streaming only if stream_count is
> @@ -442,14 +438,12 @@ static int csi2_s_stream(struct v4l2_subdev *sd, in=
t enable)
>  	else
>  		csi2_stop(csi2);
>  	if (ret)
> -		goto out;
> +		return ret;
> =20
>  update_count:
>  	csi2->stream_count +=3D enable ? 1 : -1;
>  	if (csi2->stream_count < 0)
>  		csi2->stream_count =3D 0;
> -out:
> -	mutex_unlock(&csi2->lock);
>  	return ret;

This is mixing goto and cleanup in the same function, which the scope-
based cleanup helpers documentation suggests shouldn't be done.

In this case I see no problem because we only jump to update_count from
under the lock, but since issues with gotos around automatic cleanup
are easy to miss, I think it would be better to also turn the
update_count jump into a conditional block.


regards
Philipp

