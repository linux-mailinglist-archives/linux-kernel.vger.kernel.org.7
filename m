Return-Path: <linux-kernel+bounces-833631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B24BA27D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1992A1B43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9364279DA9;
	Fri, 26 Sep 2025 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IAT64utk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C634BA5F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758866642; cv=none; b=jLUxnZops7ytkfuhuuTKprf+6to7BYEsb+IkvdyJEM9SHCWnoiGW1XSRMooCEej7slpaFRDd8wGQhyIPmqyfEAtUWBWgcR/R0en9+FVbkX2eR/Wi9C1xPuI+PDS6cFlnsscvXvwdGvaTordogAf9X2UDgkoWIFPBx8Mk+OB9cng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758866642; c=relaxed/simple;
	bh=myPg4NBIH/TXjxVRTUdcnCDnLEi3l5RawQZuvDqVuWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRqZAAiwvMxfvWBm/ax3efyvdJ1MnrA8xZ+CkQ2bkoRdrM/Nafz/uYEkvc6WOAmNRBg12YeAO8Pk+s3Hg3ohxb+TOy2RVQwknSjcILcKSDEpV64jV9KHO9UX9oxYUma15AEh6/g47m8jc4ZTpuRhCeVvPnyNVTVfTbE8A2yuitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IAT64utk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9C8C4CEF4;
	Fri, 26 Sep 2025 06:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758866640;
	bh=myPg4NBIH/TXjxVRTUdcnCDnLEi3l5RawQZuvDqVuWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAT64utk/j5DNOps1TS5BtaKN0Bja63usaMorsQMq5SYBoEjnviahWnV2fGALpt02
	 mm/MoKhbJOk4Vsp9qGqWibCByJv+r5f4eHNoDo4TiCAbcYNeVaNH3K56C7CRORVi6g
	 a95I8K3gMmLW299TtF6i5UteXhpVtSbUqTexjamU=
Date: Fri, 26 Sep 2025 08:03:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: yaxing guo <guoyaxing@bosc.ac.cn>
Cc: linux-kernel@vger.kernel.org, wangran@bosc.ac.cn, zhangjian@bosc.ac.cn,
	anxu@bosc.ac.cn
Subject: Re: [PATCH v2 3/3] doc: Add ABI documentation for uio_pci_sva driver
 sysfs attributes
Message-ID: <2025092658-reenact-nastiness-a195@gregkh>
References: <20250925104018.57053-1-guoyaxing@bosc.ac.cn>
 <20250925104018.57053-3-guoyaxing@bosc.ac.cn>
 <2025092538-spokesman-disparity-1aca@gregkh>
 <dbc55234-58b2-4d3f-8d0e-e78e148b9944@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc55234-58b2-4d3f-8d0e-e78e148b9944@bosc.ac.cn>

On Fri, Sep 26, 2025 at 01:57:58PM +0800, yaxing guo wrote:
> Hi, Greg,
> 
> Thank you for your feedback.
> 
> On 9/25/2025 8:32 PM, Greg KH wrote:
> > On Thu, Sep 25, 2025 at 06:40:18PM +0800, Yaxing Guo wrote:
> > > Add ABI documentation for the sysfs interface provided by the
> > > uio_pci_sva driver, specifically the 'pasid' attribute.
> > > 
> > > The 'pasid' attribute exposes the Process Address Space ID (PASID)
> > > assigned by the IOMMU to the device for use with Shared Virtual
> > > Addressing (SVA). User-space UIO applications read this attribute
> > > to obtain the PASID and program it into the device's configuration
> > > registers, enabling the device to perform DMA using user-space
> > > virtual addresses.
> > > 
> > > This attribute appears under:
> > > /sys/bus/pci/drivers/uio_pci_sva/<pci_dev>/pasid
> > > 
> > > Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
> > > ---
> > >   .../ABI/testing/sysfs-driver-uio_pci_sva-pasid    | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid b/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
> > > new file mode 100644
> > > index 000000000000..a6afa8c2775c
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
> > > @@ -0,0 +1,15 @@
> > > +What:		/sys/bus/pci/drivers/uio_pci_sva/<pci_dev>/pasid
> > > +Date:		September 2025
> > > +Contact:	Yaxing Guo <guoyaxing@bosc.ac.cn>
> > > +Description:
> > > +		Process Address Space ID (PASID) assigned by IOMMU driver to
> > > +		the device for use witch Shared Virtual Addressing (SVA).
> > 
> > "with", not "witch", right?
> > 
> > > +
> > > +		This read-only attribute exposes the PASID allocated by the
> > > +		IOMMU driver during sva device binding.
> > > +
> > > +		User-space UIO applications must read this attribute to
> > > +		obtain the PASID and program it into the device's configuration
> > > +		registers. This enables the device to perform DMA using
> > > +		user-space virtual address, with address translation handled
> > > +		by IOMMU.
> > 
> > What is a PASID?  What format is it in?
> > 
> > How can it then be used in userspace?  What is a "device configuration
> > register" and what api uses it?
> > 
> > And where is the userspace code that interacts with all of this?
> > 
> 
> The UIO userspace code is inherently tied to the hardware and its
> register layout. Therefore, there isn't a single open-source userspace
> implementation(In my job, this is for a simple FPAG-based test device used
> for iommu-sva functionality validation).

That's ok to publish it, userspace UIO drivers need to also be released
under an open license as they are explicitly tied to the kernel
interface.  Without that, it's hard to judge if the api is correct or
not.

thanks,

greg k-h

