Return-Path: <linux-kernel+bounces-895910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC7C4F3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637EF18C2D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063903A1CE1;
	Tue, 11 Nov 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pfqk8Swc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111A369973;
	Tue, 11 Nov 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882113; cv=none; b=UeE7j+ZMI4ZO9qY7lAAJdljjvXJDYCUG6j6n3vnSEHdFPt23iqiEgtfvSMWxA920fR3SkHpc9PZFlPkfAeo4VcKmUVZTrF//sKaMKSNzlmMQQBXEoUyuamzjNQvNSS9Iuh7DK4tRtp1gPKpYe5025Lz7ZLChJEH4SomUuHhmJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882113; c=relaxed/simple;
	bh=bsmd7kg6qnIb8MlMDLkiQd6rQpcUfqqxFWYPX1fT4WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYL4PPe6v4par+OgAvjQKhf1/B2961TGMAG/T+DPXoIWQSKL9Uo637L9oI8Oc78fXZk1c66r37mVlyc8I0dXJ6jUeceHqK6vU86PyG4z59y3jf2fesiZFX59W+IDar6aR8NpWK6K0oZV5/TfR6juvWFZWAI6fTxTpy0kz7+m/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pfqk8Swc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CD3211D29;
	Tue, 11 Nov 2025 18:26:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762881983;
	bh=bsmd7kg6qnIb8MlMDLkiQd6rQpcUfqqxFWYPX1fT4WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfqk8SwcT5h2+q1NJF3KwQzpmFNVGC595cqR5z3NIVjAegXLrB56owuRgJqc6E9EP
	 ACkTo6j2Ub5YCF3saLI3kxZD2yo9WNAWD6EYbbntbHiNqX5gLpxhiTIFz07LTO/Dc1
	 ygB8oCU1JnuLQ8JWd20ngFgqS/AlJhIqU6wQvChc=
Date: Tue, 11 Nov 2025 19:28:15 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "G.N. Zhou (OSS)" <guoniu.zhou@oss.nxp.com>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <frank.li@nxp.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"G.N. Zhou" <guoniu.zhou@nxp.com>
Subject: Re: [PATCH v7 2/5] media: imx8mq-mipi-csi2: Use
 devm_clk_bulk_get_all() to fetch clocks
Message-ID: <20251111172815.GA12331@pendragon.ideasonboard.com>
References: <20251023-csi2_imx8ulp-v7-0-5ecb081ce79b@nxp.com>
 <20251023-csi2_imx8ulp-v7-2-5ecb081ce79b@nxp.com>
 <20251027001151.GN13023@pendragon.ideasonboard.com>
 <AS8PR04MB908014E336F99BEEB504EDB7FAC4A@AS8PR04MB9080.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS8PR04MB908014E336F99BEEB504EDB7FAC4A@AS8PR04MB9080.eurprd04.prod.outlook.com>

On Tue, Nov 04, 2025 at 07:47:43AM +0000, G.N. Zhou (OSS) wrote:
> On Monday, October 27, 2025 8:12 AM, Laurent Pinchart wrote:
> > On Thu, Oct 23, 2025 at 05:19:43PM +0800, Guoniu Zhou wrote:
> > > From: Guoniu Zhou <guoniu.zhou@nxp.com>
> > >
> > > Use devm_clk_bulk_get_all() helper to simplify clock handle code.
> > >
> > > No functional changes intended.
> > >
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
> > > ---
> > >  drivers/media/platform/nxp/imx8mq-mipi-csi2.c | 52
> > > ++++++++-------------------
> > >  1 file changed, 15 insertions(+), 37 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
> > > b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
> > > index d333ff43539f061b8b9cf88af2cda8c44b3ec2a9..fd202601d401145da8be23df4451
> > > f6af660642c5 100644
> > > --- a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
> > > +++ b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
> > > @@ -71,21 +71,6 @@ enum {
> > >  	ST_SUSPENDED	= 4,
> > >  };
> > >
> > > -enum imx8mq_mipi_csi_clk {
> > > -	CSI2_CLK_CORE,
> > > -	CSI2_CLK_ESC,
> > > -	CSI2_CLK_UI,
> > > -	CSI2_NUM_CLKS,
> > > -};
> > > -
> > > -static const char * const imx8mq_mipi_csi_clk_id[CSI2_NUM_CLKS] = {
> > > -	[CSI2_CLK_CORE] = "core",
> > > -	[CSI2_CLK_ESC] = "esc",
> > > -	[CSI2_CLK_UI] = "ui",
> > > -};
> > > -
> > > -#define CSI2_NUM_CLKS	ARRAY_SIZE(imx8mq_mipi_csi_clk_id)
> > > -
> > >  struct imx8mq_plat_data {
> > >  	int (*enable)(struct csi_state *state, u32 hs_settle);
> > >  	void (*disable)(struct csi_state *state); @@ -111,7 +96,8 @@ struct csi_state {
> > >  	struct device *dev;
> > >  	const struct imx8mq_plat_data *pdata;
> > >  	void __iomem *regs;
> > > -	struct clk_bulk_data clks[CSI2_NUM_CLKS];
> > > +	struct clk_bulk_data *clks;
> > > +	int num_clks;
> > >  	struct reset_control *rst;
> > >  	struct regulator *mipi_phy_regulator;
> > >
> > > @@ -384,24 +370,16 @@ static void imx8mq_mipi_csi_set_params(struct csi_state *state)
> > >  			      CSI2RX_SEND_LEVEL);
> > >  }
> > >
> > > -static int imx8mq_mipi_csi_clk_enable(struct csi_state *state) -{
> > > -	return clk_bulk_prepare_enable(CSI2_NUM_CLKS, state->clks);
> > > -}
> > > -
> > > -static void imx8mq_mipi_csi_clk_disable(struct csi_state *state)
> > > +static struct clk *find_esc_clk(struct csi_state *state)
> > 
> > This is one of the reasons why I don't like devm_clk_bulk_get_all(). I won't
> > object to this patch, but I don't like it. At the very lest, you should look up the
> > clock at probe time and cache it in the imx8mq_plat_data structure, to avoid
> > looking it up multiple times at runtime.
> 
> Ok, but could we cache the clock in the csi_state structure? Because the imx8mq_plat_data
> structure instance is const.

Yes sorry that's what I meant.

> > >  {
> > > -	clk_bulk_disable_unprepare(CSI2_NUM_CLKS, state->clks);
> > > -}
> > > -
> > > -static int imx8mq_mipi_csi_clk_get(struct csi_state *state) -{
> > > -	unsigned int i;
> > > +	int i;
> > >
> > > -	for (i = 0; i < CSI2_NUM_CLKS; i++)
> > > -		state->clks[i].id = imx8mq_mipi_csi_clk_id[i];
> > > +	for (i = 0; i < state->num_clks; i++) {
> > 
> > Make state->num_clks unsigned instead of making i signed.
> > 
> > > +		if (!strcmp(state->clks[i].id, "esc"))
> > > +			return state->clks[i].clk;
> > > +	}
> > >
> > > -	return devm_clk_bulk_get(state->dev, CSI2_NUM_CLKS, state->clks);
> > > +	return NULL;
> > 
> > This needs to become a probe error.
> 
> Got it, will update in next version.
> 
> > >  }
> > >
> > >  static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
> > > @@ -456,7 +434,7 @@ static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
> > >  	 * documentation recommends picking a value away from the boundaries.
> > >  	 * Let's pick the average.
> > >  	 */
> > > -	esc_clk_rate = clk_get_rate(state->clks[CSI2_CLK_ESC].clk);
> > > +	esc_clk_rate = clk_get_rate(find_esc_clk(state));
> > >  	if (!esc_clk_rate) {
> > >  		dev_err(state->dev, "Could not get esc clock rate.\n");
> > >  		return -EINVAL;
> > > @@ -783,7 +761,7 @@ static void imx8mq_mipi_csi_pm_suspend(struct device *dev)
> > >
> > >  	if (state->state & ST_POWERED) {
> > >  		imx8mq_mipi_csi_stop_stream(state);
> > > -		imx8mq_mipi_csi_clk_disable(state);
> > > +		clk_bulk_disable_unprepare(state->num_clks, state->clks);
> > >  		state->state &= ~ST_POWERED;
> > >  	}
> > >
> > > @@ -801,7 +779,7 @@ static int imx8mq_mipi_csi_pm_resume(struct device *dev)
> > >
> > >  	if (!(state->state & ST_POWERED)) {
> > >  		state->state |= ST_POWERED;
> > > -		ret = imx8mq_mipi_csi_clk_enable(state);
> > > +		ret = clk_bulk_prepare_enable(state->num_clks, state->clks);
> > >  	}
> > >  	if (state->state & ST_STREAMING) {
> > >  		sd_state = v4l2_subdev_lock_and_get_active_state(sd);
> > > @@ -1027,9 +1005,9 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
> > >  	if (IS_ERR(state->regs))
> > >  		return PTR_ERR(state->regs);
> > >
> > > -	ret = imx8mq_mipi_csi_clk_get(state);
> > > -	if (ret < 0)
> > > -		return ret;
> > > +	state->num_clks = devm_clk_bulk_get_all(dev, &state->clks);
> > > +	if (state->num_clks < 0)
> > > +		return dev_err_probe(dev, state->num_clks, "Failed to get
> > > +clocks\n");
> > >
> > >  	platform_set_drvdata(pdev, &state->sd);
> > >

-- 
Regards,

Laurent Pinchart

