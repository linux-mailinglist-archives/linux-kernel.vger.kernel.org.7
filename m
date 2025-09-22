Return-Path: <linux-kernel+bounces-827088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD04B9044D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF65163CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF22FE077;
	Mon, 22 Sep 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qn15K+BD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013D2D97A9;
	Mon, 22 Sep 2025 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538199; cv=none; b=Pm43gXjwT+iySY9wFflVmu9NTWkEVruCVLvyJINFLUcrbPhh0tZOOeSwEJ0o3nhbnKAnE9cNDQgW1RLwiP+BQq3RRqXGC8C9l0DJMz8b1iU+3K9VlowVINWkB93is1YQZlRYZNtYQKPm+tgi8k/q7GpSpNKciOGNe8tglv6Mlcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538199; c=relaxed/simple;
	bh=niid4/G+12MRj1IFs6hp4sxeglXjyvGTGDPW0mtxjKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueijESFLhaByMQbqA4AVztgRV6OrqWmretnLoZbQiIhzQbyhaI+vJJGTkHYcyJjoeggZ4ZQ8v/bB6wrxHKM39Pxbt1ffx5z6WnAxqptKZ6ry94mIpahuIHDUW5vY5OcmHfC+cB1e8H1uAXGQOX2EzFY/b31AN/NA2Rit6W4Y6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qn15K+BD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACBFC4CEF0;
	Mon, 22 Sep 2025 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758538198;
	bh=niid4/G+12MRj1IFs6hp4sxeglXjyvGTGDPW0mtxjKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qn15K+BDQCMdtm8fPWDiC0Citf1LHeyLNl9kXRi5WJvwj2/1hIuCpVvsRxGMiSXBP
	 X1RnlBTgKC6NFyFOYs4Ht4cTAKrG289MkmevTZU02K+unBfSI+7zLjm+dY9XGQsONM
	 7lfD8Fs5lCSaRp7iG/bLU3B9HB7R1UByh08z+VA/wlsghF52gImFrpJpqb4RfsYH6z
	 ovVNgbPNhwvW+PRUn4J+Jhqq8YIvSn3QU6DmZ6Z3BDmodPCTMWLjh/1wNOI0WJbnIJ
	 kTbDqYeC8arkwbeOcl8N4TP51f0ZjiM8O7wsFZv7XPtqlYd5qmvoh3IQU0LEZjc/fB
	 yAne/WZgkp6yw==
Date: Mon, 22 Sep 2025 12:49:53 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] of/irq: Add msi-parent check to of_msi_xlate()
Message-ID: <aNEp0Ty3+a2oxLNm@lpieralisi>
References: <20250916091858.257868-1-lpieralisi@kernel.org>
 <20250918135555.GA1540012-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918135555.GA1540012-robh@kernel.org>

On Thu, Sep 18, 2025 at 08:55:55AM -0500, Rob Herring wrote:
> On Tue, Sep 16, 2025 at 11:18:58AM +0200, Lorenzo Pieralisi wrote:
> > In some legacy platforms the MSI controller for a PCI host
> > bridge is identified by an msi-parent property whose phandle
> > points at an MSI controller node with no #msi-cells property,
> > that implicitly means #msi-cells == 0.
> > 
> > For such platforms, mapping a device ID and retrieving the
> > MSI controller node becomes simply a matter of checking
> > whether in the device hierarchy there is an msi-parent property
> > pointing at an MSI controller node with such characteristics.
> > 
> > Add a helper function to of_msi_xlate() to check the msi-parent
> > property in addition to msi-map and retrieve the MSI controller
> > node (with a 1:1 ID deviceID-IN<->deviceID-OUT mapping) to
> > provide support for deviceID mapping and MSI controller node
> > retrieval for such platforms.
> 
> Your line wrapping is a bit short.
> 
> I had a look at who is parsing "msi-parent" themselves as that's 
> typically a recipe for doing it incorrectly ('interrupt-map' anyone). 
> Can we make iproc_pcie_msi_enable() use this? It's quite ugly reaching 
> into the GICv3 node...
> 
> And perhaps irq-gic-its-msi-parent.c could use this? 
> 
> And looks like pcie-layerscape-gen4 is leaking a node reference...

Hi Rob,

given where we are in the development cycle and that technically this
is a GICv5 fix I would send a patch to fix the issue in GICv5 MSI
parent code in drivers/irqchip (yes, it is more code handling the
msi-parent property scattered around) and then will resume this
thread for v6.19 - starting the clean-up.

This patch affects more platforms than GICv5 and I am not sure
it is safe to rush it in.

Thanks,
Lorenzo

> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Sascha Bischoff <sascha.bischoff@arm.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/of/irq.c | 38 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index e7c12abd10ab..d0e2dfd0ee28 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -670,6 +670,35 @@ void __init of_irq_init(const struct of_device_id *matches)
> >  	}
> >  }
> >  
> > +static int of_check_msi_parent(struct device_node *dev_node, struct device_node **msi_node)
> > +{
> > +	struct of_phandle_args msi_spec;
> > +	int ret;
> > +
> > +	/*
> > +	 * An msi-parent phandle with a missing or == 0 #msi-cells
> > +	 * property identifies a 1:1 ID translation mapping.
> > +	 *
> > +	 * Set the msi controller node if the firmware matches this
> > +	 * condition.
> > +	 */
> > +	ret = of_parse_phandle_with_optional_args(dev_node, "msi-parent", "#msi-cells",
> > +						  0, &msi_spec);
> > +	if (!ret) {
> > +		if ((*msi_node && *msi_node != msi_spec.np) || msi_spec.args_count != 0)
> > +			ret = -EINVAL;
> > +
> > +		if (!ret) {
> > +			/* Return with a node reference held */
> > +			*msi_node = msi_spec.np;
> > +			return 0;
> > +		}
> > +		of_node_put(msi_spec.np);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * of_msi_xlate - map a MSI ID and find relevant MSI controller node
> >   * @dev: device for which the mapping is to be done.
> > @@ -677,7 +706,7 @@ void __init of_irq_init(const struct of_device_id *matches)
> >   * @id_in: Device ID.
> >   *
> >   * Walk up the device hierarchy looking for devices with a "msi-map"
> > - * property. If found, apply the mapping to @id_in.
> > + * or "msi-parent" property. If found, apply the mapping to @id_in.
> >   * If @msi_np points to a non-NULL device node pointer, only entries targeting
> >   * that node will be matched; if it points to a NULL value, it will receive the
> >   * device node of the first matching target phandle, with a reference held.
> > @@ -691,12 +720,15 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
> >  
> >  	/*
> >  	 * Walk up the device parent links looking for one with a
> > -	 * "msi-map" property.
> > +	 * "msi-map" or an "msi-parent" property.
> >  	 */
> > -	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
> > +	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
> >  		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
> >  				"msi-map-mask", msi_np, &id_out))
> >  			break;
> > +		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
> > +			break;
> > +	}
> >  	return id_out;
> >  }
> >  
> > -- 
> > 2.48.0
> > 

