Return-Path: <linux-kernel+bounces-720448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05923AFBBE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511097A1C12
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C36E25A320;
	Mon,  7 Jul 2025 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxGvlBtf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47B13A244
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917745; cv=none; b=Y+vDI2QWOUXBXkqAXu5Rp/zMU91vLXg0TBSiftRWykKvcaBfla+6GeE8h21VGC88F8s32E5LutIX7MXCOI3KLCWvgqDzcZxSccJ4IRcEFV6jDsiRmA3gy74D4p+fGPnG4tY73Icl3m8fiZVm7ohf+kJcQZjerSDC1HO2KlaqkPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917745; c=relaxed/simple;
	bh=NmZU/MvLGmPv9MmKPyMivMr0TayXVXZyGExLDNpv+RM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZnP5ybiEQ8RlQhmS6+DxLnIyNsyz2DHNecaLKDOCvWAa8In/aYvXoJbfLpPfRM7Lc6hVuGczvnvN24J4eoC7An6TApAitg7mO2UCZSmH5TjKk1Z31OwFdrcrmpfBgLmuuSRgruz44jeS9dvHpIoWQ3EEdeYLfE5fCEWQesDSzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxGvlBtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1DBC4CEE3;
	Mon,  7 Jul 2025 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751917745;
	bh=NmZU/MvLGmPv9MmKPyMivMr0TayXVXZyGExLDNpv+RM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XxGvlBtfs/ge7p8M0zGPA+Gwy2B6tksexs4+73gYjML3bpJPSKYopa6zkhl6hCUB3
	 YeuUfYmP8/HYTo3Zjr+GpCt4B5Q7sLHMRJ7Idi3ocNR6KxMv0BHjUAlfygSm4o4EcR
	 zJ6jJW7BbKiHII5CNoL2FzYPdobPlGaZ+/G9lfe3w7sugfPjSRQkNeq0Judpt71aQW
	 p11NboEEbXuQmkqieV6qv4AhgwNBHYU1N+gtsnToOOXik2SFoGyzDryjcaRR+NUnsL
	 4XDoDOnAldcZZ8LcmjWLygYdIZXrKahUoursWr5FHt8JqGaZocS2C/epcdtyEKBLhC
	 0pSLzNVNcG6Tg==
Date: Mon, 7 Jul 2025 14:49:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: weilinghan <weilinghan@xiaomi.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	hulingchen <hulingchen@xiaomi.com>,
	weipengliang <weipengliang@xiaomi.com>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: remove call pci_save_aspm_l1ss_state() from
 pci_save_pcie_state()
Message-ID: <20250707194903.GA2096996@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707115236.3076-1-weilinghan@xiaomi.com>

[+cc Vidya, author of 4ff116d0d5fd]

On Mon, Jul 07, 2025 at 07:52:36PM +0800, weilinghan wrote:
> During the suspend-resume process, PCIe resumes by enabling L1.2
> in the pci_restore_state function due to patch 4ff116d0d5fd.
> However, in the following scenario, the resume process
> becomes very time-consuming:
> 
> 1.The platform has multiple PCI buses.
> 2.The link transition time from L1.2 to L0 exceeds 100 microseconds by
> accessing the configuration space of the EP.
> 3.The PCI framework has async_suspend enabled
> (by calling device_enable_async_suspend(&dev->dev)
> in pci_pm_init(struct pci_dev *dev)).
> 4.On ARM platforms, CONFIG_PCI_LOCKLESS_CONFIG is not enabled, which means
> the pci_bus_read_config_##size interfaces contain locks (spinlock).
> 
> Practical measurements show that enabling L1.2 during the
> resume process introduces an additional delay of approximately
> 150ms in the pci_pm_resume_noirq() function for platforms
> with two PCI buses, compared to when L1.2 is disabled.

We really need an argument for why this change would be correct, not
just the fact that it makes resume faster.  Vidya made the change in
4ff116d0d5fd to fix a problem, and it looks like this patch would
reintroduce the problem.

Nits:

  - Look at previous history and follow the subject line convention.

  - Add "()" after function names, e.g., pci_restore_state().

  - Omit "the ... function"; it's sufficient to say "in
    pci_restore_state()" and "in pci_pm_resume_noirq()".

  - Omit function parameter info since it's not really relevant here.

  - Cite commits as: 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates
    Capability for suspend/resume")

  - s/4.0n/4/

> Signed-off-by: weilinghan <weilinghan@xiaomi.com>
> ---
>  drivers/pci/pci.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9e42090fb108..0834211b0f8c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1708,7 +1708,6 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
>  	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
>  
> -	pci_save_aspm_l1ss_state(dev);
>  	pci_save_ltr_state(dev);
>  
>  	return 0;
> @@ -1725,7 +1724,6 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  	 * LTR itself in PCI_EXP_DEVCTL2.
>  	 */
>  	pci_restore_ltr_state(dev);
> -	pci_restore_aspm_l1ss_state(dev);
>  
>  	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
>  	if (!save_state)
> -- 
> 2.43.0
> 

