Return-Path: <linux-kernel+bounces-832419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F3CB9F456
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511553B238E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01609283138;
	Thu, 25 Sep 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m8cj/QZL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEAC19F48D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803543; cv=none; b=gJbRW2eBijjBt3Irj8/KB5KksFWMWIEaBmQSaXbyrXAgsqjmO11CH74aYuHvq03KEh87E1uzdrALrTguAWtSjK1ChOambkK4v15W1wF/U0PPXro8847u+4BwBuzK88L7TLnKCrzEan81+AlCfY2cmA/66kx2QxD5vVKe6QyLKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803543; c=relaxed/simple;
	bh=QHijB74P7Ce9ZIKM0PF8KYBrrclMFOdIOYmNJkyJwc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaVpsNyBZzT3AQ50cbCB42YE25+/kY3DlP1hUv2BigofakfBXptB6gG7PpJuDvmQGFcNy6rzD/gLT8fHg7NG1Ma7gyWPVX+UuMreYUCArrVie3/pYcgbLh4al8bPiqLkSpqLnpS8ETEv3UjsSzz5HWhJo7c4wYLHbqH3HtjFsB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m8cj/QZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4338CC4CEF7;
	Thu, 25 Sep 2025 12:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758803542;
	bh=QHijB74P7Ce9ZIKM0PF8KYBrrclMFOdIOYmNJkyJwc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8cj/QZLQLxwnfd+fHHY0+AWk1pj31P7rQTub7maAq9lk/ekEoQ9YLsvQssllmZ+t
	 JlJUacWLHgTqktf+iQpCizvzDj2c4Jk1PkdlyJLOe6YF5zdswKN7ttltDDCg4F1zbz
	 NDO49XnvJCbfiOYXhQAZkaK19B7duytbva5TTocI=
Date: Thu, 25 Sep 2025 14:32:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: linux-kernel@vger.kernel.org, wangran@bosc.ac.cn, zhangjian@bosc.ac.cn,
	anxu@bosc.ac.cn
Subject: Re: [PATCH v2 3/3] doc: Add ABI documentation for uio_pci_sva driver
 sysfs attributes
Message-ID: <2025092538-spokesman-disparity-1aca@gregkh>
References: <20250925104018.57053-1-guoyaxing@bosc.ac.cn>
 <20250925104018.57053-3-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925104018.57053-3-guoyaxing@bosc.ac.cn>

On Thu, Sep 25, 2025 at 06:40:18PM +0800, Yaxing Guo wrote:
> Add ABI documentation for the sysfs interface provided by the
> uio_pci_sva driver, specifically the 'pasid' attribute.
> 
> The 'pasid' attribute exposes the Process Address Space ID (PASID)
> assigned by the IOMMU to the device for use with Shared Virtual
> Addressing (SVA). User-space UIO applications read this attribute
> to obtain the PASID and program it into the device's configuration
> registers, enabling the device to perform DMA using user-space
> virtual addresses.
> 
> This attribute appears under:
> /sys/bus/pci/drivers/uio_pci_sva/<pci_dev>/pasid
> 
> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
> ---
>  .../ABI/testing/sysfs-driver-uio_pci_sva-pasid    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid b/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
> new file mode 100644
> index 000000000000..a6afa8c2775c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/pci/drivers/uio_pci_sva/<pci_dev>/pasid
> +Date:		September 2025
> +Contact:	Yaxing Guo <guoyaxing@bosc.ac.cn>
> +Description:
> +		Process Address Space ID (PASID) assigned by IOMMU driver to
> +		the device for use witch Shared Virtual Addressing (SVA).

"with", not "witch", right?

> +
> +		This read-only attribute exposes the PASID allocated by the
> +		IOMMU driver during sva device binding.
> +
> +		User-space UIO applications must read this attribute to
> +		obtain the PASID and program it into the device's configuration
> +		registers. This enables the device to perform DMA using
> +		user-space virtual address, with address translation handled
> +		by IOMMU.

What is a PASID?  What format is it in?

How can it then be used in userspace?  What is a "device configuration
register" and what api uses it?

And where is the userspace code that interacts with all of this?

And finally, this too can be part of the first commit.

thanks,

greg k-h

