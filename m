Return-Path: <linux-kernel+bounces-799185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BA1B4281C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBBB7C262C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4B3218B3;
	Wed,  3 Sep 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY7xsv1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8E2ECD2E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921138; cv=none; b=tRBFQZNH+queAJuWpsVgTtfIEgp19RrJDjHg2PXmAe+b64tlf/w23WVtgnNU9/1T1vBt6TiAkaDMlXFPiShbro17mB8TsdICJkMFhO120IHFSMB698UHNX/dBiWHus+7tN61kT2H5XABu6w8WNMDYLSBJt9UOHbmVSTQTCJHmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921138; c=relaxed/simple;
	bh=ebP5m5rDo6+Kp50Wqxl6X4LS4zdXwC0dA3Wq2e7AsP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=svHG7E8yj6FRi7l0c+P4tRN9KbarLDhuziOQSlTOXs5oG2ETTf0vfhc5Bi24Z5WJMEueOmjdSFqkt3ggxwdLfU18MlEO4LfXQqn0Oo+lSmsTLFxcN9BtPkU25lo/YKyLbkzJix1//FTrX+3V8xg3BghaiptVxhnMkG/mCfBzSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY7xsv1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F0FC4CEE7;
	Wed,  3 Sep 2025 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756921137;
	bh=ebP5m5rDo6+Kp50Wqxl6X4LS4zdXwC0dA3Wq2e7AsP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SY7xsv1qV1yDxurg0NUe7mkmexWXX7ra3tfgWGxTsOBda7kSPPHuixntzeZZpkJ13
	 dqSXc/vEbOpjGaPVsjCQyHNQx0ivQD2R33sYhrYz8ntmHVNDkPbqdzzDZGkM0JjDSP
	 cyQdrqipOj/9JipwhHNLdDSDBVCbqGYbjAaK2pMRD3IcSUakZ+L1pz36zNFSfduc3a
	 ntx1cYmG7NaUW0Wa7x0lUpaFH2CYQe8yt0DAy2gZbhPXL+M41iNEdDAR/6EFYSz6Zw
	 HnG/va3jb8Xy91zPqV2XQQV/NFAvxd2VB65U9uBGCxM1fzNd/Rdtm5yEBd0+h8VWvh
	 hUErjghZfg6Ew==
Date: Wed, 3 Sep 2025 12:38:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [patch 2/2] PCI/MSI: Remove the conditional parent [un]mask logic
Message-ID: <20250903173856.GA1208089@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903135433.444329373@linutronix.de>

On Wed, Sep 03, 2025 at 04:04:48PM +0200, Thomas Gleixner wrote:
> Now that msi_lib_init_dev_msi_info() overwrites the irq_[un]mask()
> callbacks when the MSI_FLAG_PCI_MSI_MASK_PARENT flag is set by the parent
> domain, the conditional [un]mask logic is obsolete.
> 
> Remove it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |   20 --------------------
>  1 file changed, 20 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -170,22 +170,6 @@ static unsigned int cond_startup_parent(
>  	return 0;
>  }
>  
> -static __always_inline void cond_mask_parent(struct irq_data *data)
> -{
> -	struct msi_domain_info *info = data->domain->host_data;
> -
> -	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> -		irq_chip_mask_parent(data);
> -}
> -
> -static __always_inline void cond_unmask_parent(struct irq_data *data)
> -{
> -	struct msi_domain_info *info = data->domain->host_data;
> -
> -	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> -		irq_chip_unmask_parent(data);
> -}
> -
>  static void pci_irq_shutdown_msi(struct irq_data *data)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
> @@ -208,14 +192,12 @@ static void pci_irq_mask_msi(struct irq_
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
>  
>  	pci_msi_mask(desc, BIT(data->irq - desc->irq));
> -	cond_mask_parent(data);
>  }
>  
>  static void pci_irq_unmask_msi(struct irq_data *data)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
>  
> -	cond_unmask_parent(data);
>  	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
>  }
>  
> @@ -268,12 +250,10 @@ static unsigned int pci_irq_startup_msix
>  static void pci_irq_mask_msix(struct irq_data *data)
>  {
>  	pci_msix_mask(irq_data_get_msi_desc(data));
> -	cond_mask_parent(data);
>  }
>  
>  static void pci_irq_unmask_msix(struct irq_data *data)
>  {
> -	cond_unmask_parent(data);
>  	pci_msix_unmask(irq_data_get_msi_desc(data));
>  }
>  
> 

