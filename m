Return-Path: <linux-kernel+bounces-619017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05DCA9B64F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 20:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6879D92325C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916F28FFE4;
	Thu, 24 Apr 2025 18:22:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C981428FFC5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518948; cv=none; b=r1fOEjsWSgda2xtUWmrCIqngEb0TQmJ0C326U2zBDhip1uEZthctMn6BHKAeSvnh33WGUqrZ8hMfUG74VlKd3y3Kp3E5abkd1cX4+KReD758s1aDE7f2gkZ3s3O0BrZp+Z6HzDZCv7m0UlB4nWKJrdXe48y925jw34JCpR4/56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518948; c=relaxed/simple;
	bh=/2+e97OVF471bJCXciiWFtM48o66V9jdrYKDtsUcAIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isWKM1jEOIkyGt9+FWZBuu4twi68W0K8fswDU3iA7sFZ6fHo5U3Lq1aZg9GyYbaTPBxAQg8OF6M6icQOaX+qggyrI7yx0OdzTShOzmK8HSH7GgNIHfEXM/vbnvKsCV2waoQSkL/ixge5hQuk2tAlFgYojHPaW1VJzqaogA5uxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9FCF1063;
	Thu, 24 Apr 2025 11:22:18 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21FDB3F59E;
	Thu, 24 Apr 2025 11:22:22 -0700 (PDT)
Message-ID: <335f3b1b-3233-4924-a124-619e249e4a50@arm.com>
Date: Thu, 24 Apr 2025 19:22:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform: Fix race condition during DMA configure at
 IOMMU probe time
To: Will McVicker <willmcvicker@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rob Herring (Arm)" <robh@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Saravana Kannan <saravanak@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20250424180420.3928523-1-willmcvicker@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250424180420.3928523-1-willmcvicker@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2025 7:04 pm, Will McVicker wrote:
> To avoid a race between the IOMMU probing thread and the device driver
> async probing thread during configuration of the platform DMA, update
> `platform_dma_configure()` to read `dev->driver` once and test if it's
> NULL before using it. This ensures that we don't de-reference an invalid
> platform driver pointer if the device driver is asynchronously bound
> while configuring the DMA.

Cheers Will! I have the corresponding changes for the other buses made 
locally (fortuitously, in exactly the same style!), so I'll get a commit 
message written up and those sent out tomorrow.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>   drivers/base/platform.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1813cfd0c4bd..cfccf3ff36e7 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1440,7 +1440,7 @@ static void platform_shutdown(struct device *_dev)
>   
>   static int platform_dma_configure(struct device *dev)
>   {
> -	struct platform_driver *drv = to_platform_driver(dev->driver);
> +	struct device_driver *drv = READ_ONCE(dev->driver);
>   	struct fwnode_handle *fwnode = dev_fwnode(dev);
>   	enum dev_dma_attr attr;
>   	int ret = 0;
> @@ -1451,8 +1451,8 @@ static int platform_dma_configure(struct device *dev)
>   		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>   		ret = acpi_dma_configure(dev, attr);
>   	}
> -	/* @drv may not be valid when we're called from the IOMMU layer */
> -	if (ret || !dev->driver || drv->driver_managed_dma)
> +	/* @dev->driver may not be valid when we're called from the IOMMU layer */
> +	if (ret || !drv || to_platform_driver(drv)->driver_managed_dma)
>   		return ret;
>   
>   	ret = iommu_device_use_default_domain(dev);

