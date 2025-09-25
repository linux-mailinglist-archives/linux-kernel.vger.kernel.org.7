Return-Path: <linux-kernel+bounces-832416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A43B9F441
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694387A2F91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F518DB01;
	Thu, 25 Sep 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kDdCOKOY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AC186E40
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803436; cv=none; b=mI/akFLFB9zrsmr85nsl4e557NboGUtsYYd/L5FZBDQ1PBZcGGTW1hqQfynEkdAL5IXkKPlK+/D2QNlpFxkw8R0VqJKciKUOfJ8uwwx0picNMng01YvaQs5qYvad7tTME6IGtHqq2rw0yiuVCra0rabUGg5fJZAJV02nPkAJzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803436; c=relaxed/simple;
	bh=kKHBLnDhmyqhh/f/zKKeaRUmSn4M06wNxfs7qgstvaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqW6v9CHKuz9hST6TpaPa78JDTaPu2awiCW7U/kmrg64Mki3uFugKWgMLlTtKpzrZqZZDZ93engOB8K1D/yH4TdAIS+0xRjyif2hwMaWpji2/sgS3it/AUtUIOdMwr3/5Uun8Dh6PmUEsldPeJv3eHmnzngKVuGYRBh7GTB5Lww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kDdCOKOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5034C4CEF0;
	Thu, 25 Sep 2025 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758803436;
	bh=kKHBLnDhmyqhh/f/zKKeaRUmSn4M06wNxfs7qgstvaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDdCOKOYbSl7UBA6pKvmgcwaNxFo1uzbdPAkUFFu7qG+loZzuLZW1/VPGoZNsntVj
	 xgYcygIGQzg94/bC028syoR6orUnjvD7rNIJeGhwLb8BEUQxaHGYy88UIhnZunyhK+
	 mQDWYiX/JNIJbpQYmGLYjJ0W6tI0hGLxikwSiyis=
Date: Thu, 25 Sep 2025 14:30:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: linux-kernel@vger.kernel.org, wangran@bosc.ac.cn, zhangjian@bosc.ac.cn,
	anxu@bosc.ac.cn
Subject: Re: [PATCH v2 2/3] uio: Add Kconfig and Makefile support for
 UIO_PCI_GENERIC_SVA
Message-ID: <2025092524-boneless-sultry-f575@gregkh>
References: <20250925104018.57053-1-guoyaxing@bosc.ac.cn>
 <20250925104018.57053-2-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925104018.57053-2-guoyaxing@bosc.ac.cn>

On Thu, Sep 25, 2025 at 06:40:17PM +0800, Yaxing Guo wrote:
> Add config symbol and build infrastructure for the UIO PCI generic
> driver with SVA (Shared Virtual Addressing) support.
> 
> This introduces:
> - A new tristate config option 'UIO_PCI_GENERIC_SVA' in Kconfig,
>   dependent on PCI and IOMMU_SVA.
> - Build rule in Makefile to compile uio_pci_generic_sva.o when enabled.
> 
> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
> ---
> Changes in v2:
>   -- Add help info in Kconfig
> 
>  drivers/uio/Kconfig  | 12 ++++++++++++
>  drivers/uio/Makefile |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index b060dcd7c635..ae59e3d8a99b 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -164,4 +164,16 @@ config UIO_DFL
>  	    opae-sdk/tools/libopaeuio/
>  
>  	  If you compile this as a module, it will be called uio_dfl.
> +
> +config UIO_PCI_GENERIC_SVA
> +	tristate "Generic driver for PCI Express that supports sva"
> +	depends on PCI && IOMMU_SVA
> +	help
> +	  Userspace I/O driver for PCI devices that support Shared Virtual
> +          Addressing (SVA), enabling direct use of user-space virtual
> +          addresses in device DMA operations via IOMMU hardware.
> +
> +          This driver binds to PCI devices and exposes them to userspace
> +          via the UIO framework.

What is the module name?

