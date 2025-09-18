Return-Path: <linux-kernel+bounces-823117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA37B858C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4161171CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0930CB33;
	Thu, 18 Sep 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtvKWjPe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D86927FD6E;
	Thu, 18 Sep 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208885; cv=none; b=QeMifoZM9aiH8Kdq5whgYaRSEAjNKburzp9ME+NwJOPgWuxAdQ1KrSRBhFL0ln2J1JhfykJvWvUTdf9XSN1iaQzl+wc0C1kQfDp9Eh1eq6nKOdML+BtdKUbCqSZCVUVXYhVjmItFefOpSqsDj+eJDnh/eh710cSg1kW3DPWgjd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208885; c=relaxed/simple;
	bh=7/PcDCApIZDlkgzvsXPVNcvnV9qW0ZVXMY2lmhDLV2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJxuWU0D8CriKJANo2nB3zBSP5Po74f8vBBQUM+L5791mUagBAztv23N4FXE65BdE49VvdA79NMCZjBd5sppbQ0vWOrkSmynobnvrlONXhPbB2mJXfvZiy4IdkwY9isNsdY58kDmNOLDlm4DP0cStJUgNqsX8xJFFmX2j6IJ3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtvKWjPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4786BC4CEE7;
	Thu, 18 Sep 2025 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208885;
	bh=7/PcDCApIZDlkgzvsXPVNcvnV9qW0ZVXMY2lmhDLV2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtvKWjPeuOqZewrc1jvLPZENqzSs3NQI9uGuhxJy8CL9PFwJ2F9KXKAh4WLxaxByF
	 TbwKpbHP5xZiC+a90zgvrkrk41BXYnPdF8zsIzW9iTNK6srHz4gnJlM93aN49AFT6P
	 LYKxXLxIpe1VJxD5feXdvZvPQDfmHd+dErzpsGnqyDyEgUiJIoAOPErwri6cswMZx0
	 JmKEHYoiTXdOre5XfoqXJuAvFpA4ScNpoGft8cnVPC4EIBBlAIu6jVXOVrO8vrTtFV
	 Ipace+FhpGJ7cQZNu19SL1v+EZFOWZrxcYNsNd2u0KXYYxoZL5xGif0ObfGTfFp1d0
	 DwnV7lyBBiy+Q==
Date: Thu, 18 Sep 2025 17:21:20 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] of/irq: Add msi-parent check to of_msi_xlate()
Message-ID: <aMwjcIS/rvxkSZdr@lpieralisi>
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

I am not sure I get what you mean here. Possibly iproc_pcie_msi_enable()
can reuse this patch's code if I extend it and make it a global function,
yes and somehow use that function to carry out the check for an
msi-parent property with no #msi-cells property or an #msi-cells == 0.

Don't get what GICv3 node has to do with that though, sorry.

> And perhaps irq-gic-its-msi-parent.c could use this? 

Yes and I have to fix leaks there too (and there are other
of_phandle_with_args() calls in the kernel that don't put the args.np
pointer on success - though not to retrieve msi-parent).
> 
> And looks like pcie-layerscape-gen4 is leaking a node reference...

It looks like it is in good company I am afraid :(

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

