Return-Path: <linux-kernel+bounces-810261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669B2B517ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2623B84E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77BB31B13F;
	Wed, 10 Sep 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yM8lskni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CF28DF07;
	Wed, 10 Sep 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511014; cv=none; b=O66SoYIeBIJDDxeNZhJ1320nVunxegjBpS5XtCRq7O3VgZ5HyxIp8oTXtg4Kl8rXSXC1EI44utCDsPndjcG94kgb2zRGVsZbdvfQdpJ3BM6Qf5y2deAUj3WhZjknY5WK6DGGYvi+N2wDcdPWJIP7ujRgRc6L6Rm71FWBGJ3SBIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511014; c=relaxed/simple;
	bh=Qz2mO85q1kVwec8We02B67RFangkqvGYgZLpXbZJFkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCgvvFtrH4JEIRoS9Jlw+U7AgVC1gFnyaSId1EiOQCbWAObJu8IxBfbQLMtTM8DyywvRcP86AFAtAwLfUlkC+4nZd+sfsFXYX4XCTmlQ5HxjvWrI/+5OiBw3SNleFiCSM8NvvGsqK82afXprI6+W4JZUiWkSIY7Z+hZ8g2aOX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yM8lskni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39808C4CEF8;
	Wed, 10 Sep 2025 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757511013;
	bh=Qz2mO85q1kVwec8We02B67RFangkqvGYgZLpXbZJFkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yM8lskniPdIv8ddSiJKSGuJ5GzUgLRvVHnqDNfQD3zyN9KWpf3lql0+NekAXNXd81
	 mMIbHsGw6tHBVJKvK5QirRDR4bLOISbV/yicisQ8q3ir6iKn2NHHQaYGnr+7/wuKZh
	 KSfAH6cEEwT0efryE7oN6equpHM4NcJgKLLdxdwM=
Date: Wed, 10 Sep 2025 15:30:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] usb: typec: Add mode_control field to port
 property
Message-ID: <2025091018-slather-dispose-015d@gregkh>
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905142206.4105351-2-akuchynski@chromium.org>

On Fri, Sep 05, 2025 at 02:22:02PM +0000, Andrei Kuchynski wrote:
> This new field in the port properties dictates whether the Platform Policy
> Manager (PPM) allows the OS Policy Manager (OPM) to change the currently
> active, negotiated alternate mode.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  drivers/usb/typec/class.c | 9 ++++++---
>  drivers/usb/typec/class.h | 2 ++
>  include/linux/usb/typec.h | 2 ++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 67a533e35150..9f86605ce125 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -457,11 +457,13 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
>  					     struct attribute *attr, int n)
>  {
>  	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
> +	struct typec_port *port = typec_altmode2port(adev);
>  
>  	if (attr == &dev_attr_active.attr)
> -		if (!is_typec_port(adev->dev.parent) &&
> -		    (!adev->ops || !adev->ops->activate))
> -			return 0444;
> +		if (!is_typec_port(adev->dev.parent)) {
> +			if (!port->mode_control || !adev->ops || !adev->ops->activate)
> +				return 0444;
> +		}
>  
>  	return attr->mode;
>  }
> @@ -2681,6 +2683,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  	}
>  
>  	port->pd = cap->pd;
> +	port->mode_control = !cap->no_mode_control;
>  
>  	ret = device_add(&port->dev);
>  	if (ret) {
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index db2fe96c48ff..c53a04b9dc75 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -80,6 +80,8 @@ struct typec_port {
>  	 */
>  	struct device			*usb2_dev;
>  	struct device			*usb3_dev;
> +
> +	bool				mode_control;

Shouldn't this go up higher in this structure, to avoid the hole you
created, and to take advantage of the existing hole?  Perhaps after
orientation?

thanks,

greg k-h

