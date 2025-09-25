Return-Path: <linux-kernel+bounces-831763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC8CB9D824
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2EC3257DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBFF287258;
	Thu, 25 Sep 2025 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j4qKeBXq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB71FECB0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780016; cv=none; b=qx+NdSK0sSnp3J62MGr/dwr0HgK+z/E8ImWMlgDlY6bK9gpdRh9Le/FsvWlrGU4yqQxJ5tDcvOSOGh36g337UbAzZ2WfQRt83Dh11ZagiwIUHFC20GMqPVt44sSvI8Ry41Re/9Wzb9YgKO80kykaW7+NrrLUJuL5+1vDEFTe29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780016; c=relaxed/simple;
	bh=yEjCUsx/rw7hAtyesvOa4rpNByy966eagEMKxKG0o+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2FlPK2cnqS4YV18Jwv3HjgEvIsaxOzAywPuK9dGJPZG4Q/hPJZAbaiIRd8jUH87VmGgqGdgOCQUvj5e4N4v4kvw76anfzm+Ao2eT+oSYdbitVrBRJM4IgwW7yajr6GfyEsnXT+O62ogzPsX+r260odJuCmS7Xej+m78faqfe9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j4qKeBXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CC1C4CEF0;
	Thu, 25 Sep 2025 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758780015;
	bh=yEjCUsx/rw7hAtyesvOa4rpNByy966eagEMKxKG0o+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4qKeBXq9mKiBRVJrHRDVsmz3LeMPAUQFXrDTferXvUsvK42clHJW+QjexQ+2ceZa
	 zraWaGEiqTd35kj0Q31R0EziTV0HXjIDMFRnJ4QKN4/U8IaTdgcZwgTkO6qtcfdGQi
	 O7gJY9S16cdOUCm76LuZoe20z8KbGMULTW7wcMSQ=
Date: Thu, 25 Sep 2025 08:00:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: linux-kernel@vger.kernel.org, anxu@bosc.ac.cn, zhangjian@bosc.ac.cn,
	wangran@bosc.an.cn
Subject: Re: [RFC v1 2/2] uio: Add Kconfig and Makefile support for
 UIO_PCI_GENERIC_SVA
Message-ID: <2025092541-aspect-catcher-7dfa@gregkh>
References: <20250925040637.14511-1-guoyaxing@bosc.ac.cn>
 <20250925040637.14511-2-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925040637.14511-2-guoyaxing@bosc.ac.cn>

On Thu, Sep 25, 2025 at 12:06:37PM +0800, Yaxing Guo wrote:
> Add config symbol and build infrastructure for the UIO PCI generic
> driver with SVA (Shared Virtual Addressing) support.
> 
> This introduces:
> - A new tristate config option 'UIO_PCI_GENERIC_SVA' in Kconfig,
>   dependent on PCI and IOMMU_SVA.
> - Build rule in Makefile to compile uio_pci_generic_sva.o when enabled.


This should be part of patch 1, no need to split this apart.

> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
> ---
>  drivers/uio/Kconfig  | 5 +++++
>  drivers/uio/Makefile | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index b060dcd7c635..9849e53d1932 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -164,4 +164,9 @@ config UIO_DFL
>  	    opae-sdk/tools/libopaeuio/
>  
>  	  If you compile this as a module, it will be called uio_dfl.
> +
> +config UIO_PCI_GENERIC_SVA
> +	tristate "Generic driver for PCI Express that supports sva"
> +	depends on PCI && IOMMU_SVA
> +

Please provide more information here, like the other entries have.

thanks,

greg k-h

