Return-Path: <linux-kernel+bounces-775709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B58FEB2C3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6702188C19E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A83043CF;
	Tue, 19 Aug 2025 12:33:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C39D2C11D3;
	Tue, 19 Aug 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606804; cv=none; b=XjEzH9pPqRxlZr/HLw3Gfx78mYqMUANkrqH/BEvPbokPwUJ1SPp+xfUpdHQzQRjl0EKLfktefOUksR7nrr4ygqkozYeibNoPi3qxuEwf9TMnsxdpPOL7hGeZIktFXv+waWdxCckaqI9wMY+RMeO4ePA92Qpxs5sbKSOw6WhFNIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606804; c=relaxed/simple;
	bh=BwJdGjVx4p3Eg2GuSRrf3CyAm8Bn8j9VQyyjwV9g7Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDJVlYDExT3cV+vLcqL4lOp3BJ0GneKqxn9/YE1nn4kRYfx1WPr3jtES/h6S1bQQQVBhuLTucnP8Lnm3QXGP5tRl+9GZKA7AeC2wD3xsgkJ+zutXW45KyYHvxPzOa2kx0Fos32GKi9bYWTagwymORbsbY9BcPs/i5Ph9CBxXjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFC0116A3;
	Tue, 19 Aug 2025 05:33:12 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15C753F63F;
	Tue, 19 Aug 2025 05:33:18 -0700 (PDT)
Date: Tue, 19 Aug 2025 13:33:10 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com,
	florian.fainelli@broadcom.com, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lei19.wang@samsung.com, q1.huang@samsung.com
Subject: Re: [PATCH] firmware: arm_scmi: Set device ready before register
 scmi_virtio_driver
Message-ID: <aKRvBrRstEFDu93g@pluto>
References: <CGME20250812075350epcas5p1cc4533582704978ec3a4a8b73dc1535c@epcas5p1.samsung.com>
 <20250812075343.3201365-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812075343.3201365-1-junnan01.wu@samsung.com>

On Tue, Aug 12, 2025 at 03:53:43PM +0800, Junnan Wu wrote:
> Fix irregularities in scmi driver probe.
> 

Good catch, thanks for this: indeed after the transports have been
converted to modules the probe sequence changed a bit and we cannot
leverage anymore the virtio_device_ready() called by the core in
virtio_dev_probe() since the scmi_vio_probe() does not complete until
the core SCMI stack has probed with scmi_probe() which in turn transmits
the first BASE protocol exchanges.

I did not know about this behaviour of type_1 hyp..

> After 'commit 20bda12a0ea0 ("firmware: arm_scmi: Make VirtIO transport a standalone driver")'
> making SCMI VirtIO transport a standalone driver,
> `scmi_virtio_probe` will follow `scmi_vio_probe`,
> and during `scmi_virtio_probe`, it will do `scmi_probe` which will invoke
> function `scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE)`,
> and this function will send message via virtqueue and wait device's reply
> 
> Before this patch, only after `scmi_vio_probe`,
> frontend will mark device DRIVER_OK by function `virtio_dev_probe`
> in 'drivers/virtio/virtio.c' itself.
> 
> Accroding to chapter '3.1 Device Initialization' in virtio-spec,
> ```
> The driver MUST NOT send any buffer available notifications
> to the device before setting DRIVER_OK.
> ```
> 
> In some type1-hypervisor, available buffer notifications
> will be intercepted until virtio driver is okay. In this case,
> `scmi_vio_probe` will be blocked at `scmi_wait_for_reply`
> and probe can never complete.
> 
> Therefore, the operation to set DRIVER_OK must follow
> perform device-specific setup immediately,
> then available buffer notifications can be sent in function `scmi_probe`.
> 
> Fixes: 20bda12a0ea0 ("firmware: arm_scmi: Make VirtIO transport a standalone driver")
> Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
> ---
>  drivers/firmware/arm_scmi/transports/virtio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/transports/virtio.c b/drivers/firmware/arm_scmi/transports/virtio.c
> index cb934db9b2b4..326c4a93e44b 100644
> --- a/drivers/firmware/arm_scmi/transports/virtio.c
> +++ b/drivers/firmware/arm_scmi/transports/virtio.c
> @@ -871,6 +871,9 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>  	/* Ensure initialized scmi_vdev is visible */
>  	smp_store_mb(scmi_vdev, vdev);
>  
> +	/* Set device ready */
> +	virtio_device_ready(vdev);
> +
>  	ret = platform_driver_register(&scmi_virtio_driver);
>  	if (ret) {
>  		vdev->priv = NULL;

...also, I suppose, that here nothing is to be done on the error path
regarding the vdedv status, becasue is already taken care in the error
path of virtio_dev_probe()...am I right ? (just confirming..)

Maybe you could simplify a bit the commit message but other than this

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

