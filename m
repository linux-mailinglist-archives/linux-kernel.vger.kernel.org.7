Return-Path: <linux-kernel+bounces-826180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B63B8DC53
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5E3176603
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9942D7DCA;
	Sun, 21 Sep 2025 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KFon5MuA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C424E4D4;
	Sun, 21 Sep 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461710; cv=none; b=XBdqVzaevsoKcOlf/aCv+XVk6ObVnqC/S9Qs95d6OqhlxuydMB+QtjmIhdeJvWbQQwfRwbrX8ftytttuzRq4sAGvKSsedU0v6bRx4YjUGSQi12RwWeEV9fUpTl0NptkOmrcc9k9V9qFHRNBb2+OwRm3Tt6IAfGZCu7LANPe4noc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461710; c=relaxed/simple;
	bh=IpP0NlL/USvxuGF1Y7rTBAGTIUiwSl/ulgWhzrykW0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnWePjx2Ck1dkyH1vgx9wSQ4gxPf54VBw8OvhZvNmxCFxu6BLJm/+1yNgNkaEYx7g7oc4snG5aht/xVl8lM86KFRQPc/nMUBv/4C4x0sRGQhxKkWYDUwJEi9ZzQAXc73NZg54YwG9HWPwjKXEpXMje2ZtAM5UCY//aQzKmtte4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KFon5MuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16154C4CEE7;
	Sun, 21 Sep 2025 13:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758461710;
	bh=IpP0NlL/USvxuGF1Y7rTBAGTIUiwSl/ulgWhzrykW0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFon5MuAF1vIHtn0Sc6D1ecmtv/1kI1WkfFAhWFhU2xgAJgkHKzYRajDK/4UDqZnb
	 LVC97SRKgWHoWBnAJEdfDlAxYga0IIxuK7o3VhGJe0+oLpF7jcQHGQZ6LmPnrnopqd
	 jakWO2z8M/YoLaFk52VIq6+Tm/GKxzVRhOZ/VaiY=
Date: Sun, 21 Sep 2025 15:35:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joshua Jayasingh <joshuajayasingh08@gmail.com>
Cc: groeck@chromium.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Subject: [PATCH] firmware: google: Add comments to
 coreboot_table.c
Message-ID: <2025092130-caliber-hypocrisy-5742@gregkh>
References: <20250921132446.1974-1-joshuajayasingh08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921132446.1974-1-joshuajayasingh08@gmail.com>

On Sun, Sep 21, 2025 at 06:54:46PM +0530, Joshua Jayasingh wrote:
> The coreboot_table.c file contains no comments, making it difficult
> for new developers to understand the logic for parsing the coreboot
> tables and locating firmware entries.

Nit, your Subject: line has "Subject" in it again :)

> This patch adds comprehensive comments throughout the file, explaining
> the purpose of key functions, structs, and complex operations to improve
> overall readability and maintainability.
> 
> Signed-off-by: Joshua Jayasingh <joshuajayasingh08@gmail.com>
> ---
>  drivers/firmware/google/coreboot_table.c | 187 +++++++++++++++++++++--
>  1 file changed, 177 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> index 882db32e51be..d78038bd069f 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -2,7 +2,11 @@
>  /*
>   * coreboot_table.c
>   *
> - * Module providing coreboot table access.
> + * Module providing coreboot table access. This module creates a new bus type
> + * ("coreboot") and a platform driver. The driver finds the coreboot table in
> + * memory (via ACPI or Device Tree), parses it, and creates a new device on the
> + * coreboot bus for each entry in the table. Other drivers can then register
> + * with the coreboot bus to interact with these specific entries.
>   *
>   * Copyright 2017 Google Inc.
>   * Copyright 2017 Samuel Holland <samuel@sholland.org>
> @@ -21,26 +25,52 @@
>  
>  #include "coreboot_table.h"
>  
> +/* Helper macro to get the coreboot_device from a struct device. */
>  #define CB_DEV(d) container_of(d, struct coreboot_device, dev)
> +/* Helper macro to get the coreboot_driver from a const struct device_driver. */
>  #define CB_DRV(d) container_of_const(d, struct coreboot_driver, drv)

Close, but not quiet correct documentation for this last macro.  Why do
you think that it has to be "const"?  It should work without it, right?

> +/**
> + * coreboot_bus_match - Match a coreboot device with a coreboot driver.
> + * @dev: The coreboot device.
> + * @drv: The coreboot device driver.
> + *
> + * This function is called by the driver core to determine if a driver can
> + * handle a specific device. It iterates through the driver's ID table and
> + * compares the coreboot entry tag of the device with the tags supported by
> + * the driver.
> + *
> + * Return: 1 if the device's tag matches an ID in the driver's table,
> + * 0 otherwise.
> + */
>  static int coreboot_bus_match(struct device *dev, const struct device_driver *drv)

Why are you documenting static functions that do "obvious" things?

I'm all for documenting stuff, but why do all of this to this old
driver?  Where did this documentation come from?  Was it generated by a
tool?

thanks,

greg k-h

