Return-Path: <linux-kernel+bounces-892574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10275C4560D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55B9C4E92E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF092FC007;
	Mon, 10 Nov 2025 08:28:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7D2FBDEC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763325; cv=none; b=G1BB5jclPDtvkyLRz+XZ2EpS5fdlLt1w1XCPAdFyLKrESOJnnmNnZEdifjwuO/FwQ6O9XnVxOaI3zyaEF2dbvMGH7DM65RKaU+EmQb0cFSEqdc0Ecbm+DFmnggDR7H7oZFmix/0v5zOIS9aIRQ9yPy1u9YOPxV/8y7hqdZG+Bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763325; c=relaxed/simple;
	bh=EvtWBQFRZV7DO1p3ObWpe4+6Z7KE718cU+MX/WiuSB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iuerjh7iAHyHfsV9ZAsdLLKQVY8YuTJHCKYmIM6FBHO6Tn9/CFE1homT8mdh8WTsBwGjX9/RGGu7ka/H0M8MMjiBt/suj0gE9MPEWUvlAhs2ys6m1Q0Jf66pGqc4D62Tawa4qwdv0m6eyJYas3RbPvrmAsXzSrKTuhKWlUSlGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINGJ-0006Rp-SA; Mon, 10 Nov 2025 09:28:31 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINGJ-007zQw-2A;
	Mon, 10 Nov 2025 09:28:31 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINGJ-0000000049R-2T7U;
	Mon, 10 Nov 2025 09:28:31 +0100
Message-ID: <b198e853113e39397803d9651f7126566d269601.camel@pengutronix.de>
Subject: Re: [PATCH 1/6] media: staging: media: imx6-mipi-csi2: replace
 space with tab for alignment
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Steve Longerbeam <slongerbeam@gmail.com>, 
 Mauro Carvalho Chehab	 <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team	 <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 10 Nov 2025 09:28:31 +0100
In-Reply-To: <20251107-stage-csi2-cleanup-v1-1-5d42535243ac@nxp.com>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
	 <20251107-stage-csi2-cleanup-v1-1-5d42535243ac@nxp.com>
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
> Replace space with tab to follow coding convention. No functional change.

Which convention? To be honest, this feels a bit like unnecessary churn
to me.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> ---
>  drivers/staging/media/imx/imx6-mipi-csi2.c | 92 +++++++++++++++---------=
------
>  1 file changed, 46 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging=
/media/imx/imx6-mipi-csi2.c
> index dd8c7b3233bccfc34b59e0f0ff813b36752e1526..42256441b881d9f132ad7ff89=
9d6f1e35643b4ac 100644
> --- a/drivers/staging/media/imx/imx6-mipi-csi2.c
> +++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
> @@ -23,65 +23,65 @@
>   * there must be 5 pads: 1 input pad from sensor, and
>   * the 4 virtual channel output pads
>   */
> -#define CSI2_SINK_PAD       0
> -#define CSI2_NUM_SINK_PADS  1
> -#define CSI2_NUM_SRC_PADS   4
> -#define CSI2_NUM_PADS       5
> +#define CSI2_SINK_PAD		0
> +#define CSI2_NUM_SINK_PADS	1
> +#define CSI2_NUM_SRC_PADS	4
> +#define CSI2_NUM_PADS		5
> =20
>  /*
>   * The default maximum bit-rate per lane in Mbps, if the
>   * source subdev does not provide V4L2_CID_LINK_FREQ.
>   */
> -#define CSI2_DEFAULT_MAX_MBPS 849
> +#define CSI2_DEFAULT_MAX_MBPS	849

Personally, I like these changes.

>  struct csi2_dev {
> -	struct device          *dev;
> -	struct v4l2_subdev      sd;
> -	struct v4l2_async_notifier notifier;
> -	struct media_pad       pad[CSI2_NUM_PADS];
> -	struct clk             *dphy_clk;
> -	struct clk             *pllref_clk;
> -	struct clk             *pix_clk; /* what is this? */
> -	void __iomem           *base;
> -
> -	struct v4l2_subdev	*remote;
> -	unsigned int		remote_pad;
> -	unsigned short		data_lanes;
> +	struct device			*dev;
> +	struct v4l2_subdev		sd;
> +	struct v4l2_async_notifier	notifier;
> +	struct media_pad		pad[CSI2_NUM_PADS];
> +	struct clk			*dphy_clk;
> +	struct clk			*pllref_clk;
> +	struct clk			*pix_clk; /* what is this? */
> +	void __iomem			*base;
> +
> +	struct v4l2_subdev		*remote;
> +	unsigned int			remote_pad;
> +	unsigned short			data_lanes;
> =20
>  	/* lock to protect all members below */
> -	struct mutex lock;
> +	struct mutex			lock;
> =20
> -	struct v4l2_mbus_framefmt format_mbus;
> +	struct v4l2_mbus_framefmt	format_mbus;
> =20
> -	int                     stream_count;
> -	struct v4l2_subdev      *src_sd;
> -	bool                    sink_linked[CSI2_NUM_SRC_PADS];
> +	int				stream_count;
> +	struct v4l2_subdev		*src_sd;
> +	bool				sink_linked[CSI2_NUM_SRC_PADS];
>  };

Here I'd prefer just a single space between type and identifier.

regards
Philipp

