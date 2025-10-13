Return-Path: <linux-kernel+bounces-850328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212D0BD2861
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139243B8A69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605FB2FF172;
	Mon, 13 Oct 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6V6XmT8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C72FF154;
	Mon, 13 Oct 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350732; cv=none; b=NG4C+DJ7Zt9KQRBPQgflKn11jx8AOCw6ajnAqNOQZzxjwyvhye8y+G2YxEDMiln4tAXZhtlIp9bjGQZEClvI55TMKBu9a9ricQrB5Gg6P8AQ+eIIAZ8/Bz7ALbZ+MJLOL1Qw1fu/5Pr/mwa5K0ap5azOsRBLdhMGuztdGC7oJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350732; c=relaxed/simple;
	bh=ouuqUBDWHlhYA/UeSBYZG7v0qdrIikgKeIsUG354HMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vpk2H6RaJhH6sjtTXzIkHSRUMtgj70xBppEODWRhC/8u/z+WgPi3ClY5FifGHalcfTEXa+SYwqmc4GicdzXCkJvGC45/hx8/3CEts+Vt94+gFoDMU6o08AvbS5ZWAUwCcrofHjY2oizE5k9t65b0gyqFgrdlrF/GT5lQrGfSYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6V6XmT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8F4C4CEFE;
	Mon, 13 Oct 2025 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760350731;
	bh=ouuqUBDWHlhYA/UeSBYZG7v0qdrIikgKeIsUG354HMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6V6XmT8AMmRZZZjj2K4xW3xsCtRTlPQe7+ISoXf1jIQEH1gwGfqLRnYn4ZuVlldt
	 2aLtgi4gPMC+zQIQXSdOaEB5WC12V2nVf6nSVYTzfF2aiK7HAyu2ZseeMS9SXfgwUn
	 7+ywyxXqdM+hwoVzZBzUut5uvpgLItDxre++xuX347u3G6P7vjZtoSAkfZRX00IXt/
	 edKxQo8yBatMkh27B14Eja+/yFHtK4K0UydSWCAHer8YqK5i01rLTPvOrFdt9UfSFe
	 XuUsDjrV+gnqENRIpcTlP0hil9vHzVcG8H2sGQ9zbwv0PZQgsixp74DLgxBUN3G9ee
	 k9epFFO3Si0gw==
Date: Mon, 13 Oct 2025 12:18:46 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v5: Add PCI bus msi-parent property handling
Message-ID: <aOzSBlTUdN6sLQds@lpieralisi>
References: <20250922142610.80200-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922142610.80200-1-lpieralisi@kernel.org>

On Mon, Sep 22, 2025 at 04:26:10PM +0200, Lorenzo Pieralisi wrote:
> In some legacy platforms the MSI controller for a PCI host bridge is
> identified by an msi-parent property whose phandle points at an MSI
> controller node with no #msi-cells property, that implicitly
> means #msi-cells == 0.
> 
> For such platforms, mapping a device ID and retrieving the MSI controller
> node becomes simply a matter of checking whether in the device hierarchy
> there is an msi-parent property pointing at an MSI controller node with
> such characteristics.
> 
> Add a helper function to its_v5_pci_msi_prepare() to check the msi-parent
> property in addition to msi-map and retrieve the MSI controller node (with
> a 1:1 ID deviceID-IN<->deviceID-OUT mapping) to provide support for
> deviceID mapping and MSI controller node retrieval for such platforms.
> 
> Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sascha Bischoff <sascha.bischoff@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
> Follow-up to [1] in that it is a fix and too risky to fix generic OF code at
> this stage of development since it might affect other platforms.
> 
> Apply a fix to GIC ITS v5 MSI parent code - follow-up will clean up
> the msi-parent parsing in the kernel tree.
> 
> [1] https://lore.kernel.org/lkml/20250916091858.257868-1-lpieralisi@kernel.org/

Hi Thomas,

just asking you please to ignore this patch, I will carry on fixing the issue
with the core OF approach in [1] above, sorry for the noise, it is better
to fix it in generic OF code rather than a temporary plaster as this one.

Thanks,
Lorenzo

>  drivers/irqchip/irq-gic-its-msi-parent.c | 34 ++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
> index eb1473f1448a..198fb4e9a22d 100644
> --- a/drivers/irqchip/irq-gic-its-msi-parent.c
> +++ b/drivers/irqchip/irq-gic-its-msi-parent.c
> @@ -101,6 +101,33 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
>  }
>  
> +static int its_v5_get_msi_parent(struct device *dev, struct device_node **msi_np)
> +{
> +	struct of_phandle_args out_msi;
> +	struct device *parent_dev;
> +	int ret;
> +
> +	/*
> +	 * Walk up the device parent links looking for one with a
> +	 *  "msi-parent" property.
> +	 */
> +	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
> +		ret = of_parse_phandle_with_optional_args(parent_dev->of_node, "msi-parent",
> +							  "#msi-cells",
> +							  0, &out_msi);
> +		if (!ret) {
> +			if (!out_msi.args_count) {
> +				/* Return with a node reference held */
> +				*msi_np = out_msi.np;
> +				return 0;
> +			}
> +			of_node_put(out_msi.np);
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  				  int nvec, msi_alloc_info_t *info)
>  {
> @@ -117,8 +144,11 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  	pdev = to_pci_dev(dev);
>  
>  	rid = pci_msi_map_rid_ctlr_node(pdev, &msi_node);
> -	if (!msi_node)
> -		return -ENODEV;
> +	if (!msi_node) {
> +		ret = its_v5_get_msi_parent(&pdev->dev, &msi_node);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = its_translate_frame_address(msi_node, &pa);
>  	if (ret)
> -- 
> 2.48.0
> 

