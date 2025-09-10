Return-Path: <linux-kernel+bounces-809934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE584B5139D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AB017CEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0713128B6;
	Wed, 10 Sep 2025 10:13:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817AF2D1932
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499223; cv=none; b=TykdTWict+PQawSDTaEHihKJU1h0A6t8WA2LBWQp2tgVhmT5450J4HyrpDlr1lf52Qz/h8aD94SIlkxEmGieW+nZew4j2o1rbuqPiRuAwK0lf7IIXBeiN60XCTxVaMCEODNzcUCaFvGSmydgtF1xKS1EDoTzi9LXqTM9qL3Fuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499223; c=relaxed/simple;
	bh=78YxluJnhaZNig66qMrvzo2OHqfMPKTgYywKm5FYRFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6ZZjqA87hcak2JFWoJsJfslDRW94q/7ZiGnnKchLm+w5tKsxFwlR5Z9tsWUe+nHAwVQLynudZ8cqAuX9QKrqvyfGGqBzVJ+Vb2fPRdPf3aqpjqKMN67qc1pOAfW2PEa0zRw2pobo9GlVVPNVcqsMu2e5V80SPzViwVSnox7anQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwHpR-0004AL-Gk; Wed, 10 Sep 2025 12:13:29 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwHpR-000Zh5-0Z;
	Wed, 10 Sep 2025 12:13:29 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwHpR-00GDw4-06;
	Wed, 10 Sep 2025 12:13:29 +0200
Date: Wed, 10 Sep 2025 12:13:28 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma_device
Message-ID: <20250910101328.7rp5ulsrahpqfdtz@pengutronix.de>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-6-ac7bab629e8b@pengutronix.de>
 <aLhWfPjnZZpKr/w1@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhWfPjnZZpKr/w1@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-09-03, Frank Li wrote:
> On Wed, Sep 03, 2025 at 03:06:14PM +0200, Marco Felsch wrote:
> > Make use of the devm_add_action_or_reset() to register a custom devm_
> > release hook. This is required since we want to turn of the IRQs before
> 
> turn off?
> 
> > doing the dma_async_device_unregister().
> >
> > This removes the last goto error handling within the probe function and
> 
> Remove the last ..

I rephrased the commit message.

> > further trims the remove() function. Instead of freeing the irq, we can
> > disable it and let the devm-irq do the job to free the irq, since the
> > only purpose was to have the irqs disabled before calling
> > dma_async_device_unregister().
> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/dma/imx-sdma.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 5a571d3f33158813e0c56484600a49b19a6a72e2..f6bb2f88a62781c0431336c365fa30c46f1401ad 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -2232,6 +2232,14 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
> >  				     ofdma->of_node);
> >  }
> >
> > +static void sdma_dma_device_unregister_action(void *data)
> > +{
> > +	struct sdma_engine *sdma = data;
> > +
> > +	disable_irq(sdma->irq);
> > +	dma_async_device_unregister(&sdma->dma_device);
> > +}
> > +
> >  static int sdma_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -2358,10 +2366,12 @@ static int sdma_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >
> > +	devm_add_action_or_reset(dev, sdma_dma_device_unregister_action, sdma);
> > +
> 
> need check return value.

Sure, thanks.

Regards,
  Marco

> 
> Frank
> 
> >  	ret = of_dma_controller_register(np, sdma_xlate, sdma);
> >  	if (ret) {
> >  		dev_err(dev, "failed to register controller\n");
> > -		goto err_register;
> > +		return ret;
> >  	}
> >
> >  	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> > @@ -2388,11 +2398,6 @@ static int sdma_probe(struct platform_device *pdev)
> >  	}
> >
> >  	return 0;
> > -
> > -err_register:
> > -	dma_async_device_unregister(&sdma->dma_device);
> > -
> > -	return ret;
> >  }
> >
> >  static void sdma_remove(struct platform_device *pdev)
> > @@ -2400,8 +2405,6 @@ static void sdma_remove(struct platform_device *pdev)
> >  	struct sdma_engine *sdma = platform_get_drvdata(pdev);
> >  	int i;
> >
> > -	devm_free_irq(&pdev->dev, sdma->irq, sdma);
> > -	dma_async_device_unregister(&sdma->dma_device);
> >  	/* Kill the tasklet */
> >  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
> >  		struct sdma_channel *sdmac = &sdma->channel[i];
> >
> > --
> > 2.47.2
> >
> 

