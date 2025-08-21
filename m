Return-Path: <linux-kernel+bounces-779164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCAAB2EFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF7E7B2E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B368296BA6;
	Thu, 21 Aug 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsyOGwXA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74432475E3;
	Thu, 21 Aug 2025 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761795; cv=none; b=qgpTJFxNjXUnPM/AhhRFg1qV/TPGv3HV+GYLX2+8uJd/a9M6VIRmFDCYeTs36nDz1RN2KjJj1Szdt+5QN/pAakYs5yMygNPmaD8llQOqSGdwdc832+RZxq7wszvjuRxek/buAPkmLMnIO/JtGzKIEARkv0eJH15B44EfSTdstVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761795; c=relaxed/simple;
	bh=YZkwDPYNk80itruFLYL1PliWkKr5+IoGi3ov2d0PhyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO/73E8+bJkN9XCaSii79c7k2n4l01Veeyos4hrNZ8HD5rR/Zwt9rvRn/h95YBX0GCC4sjLm/8TyrmqSVXY3xOqRuT4l2tBFfHfp4HNeJVAa+3hzx7BTm+nqNX8JUlYe+FoxYQN3UVTkLq1c2Zs8X9mg43oONwOOC4E6tty+G9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsyOGwXA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755761794; x=1787297794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YZkwDPYNk80itruFLYL1PliWkKr5+IoGi3ov2d0PhyY=;
  b=hsyOGwXAR5WCIenRNV5mmN2eo3NInGvrz0NfJab54fozxR4yp8+8mxxA
   No1CWft58NCD1RU3/TlNAirOVNySnvG0SYd+LGr4WQjVsF/Obb5DJYbRx
   kQm4fq3aKNG/1nbIukuaAR2J6H990/uEpE3WV+AQwn7YxPeFEnb/1EVsI
   Q7LJYmusZL5Hp8omSS4l/RO5cT84kTdaH/a2T4GULK44/oyiNajI/JQgU
   TOgOlc3bRyFsFO3C0JvqJXqmWAxtpY7y4FQ2eIY8LM62DVrRrZnj6t12o
   1+uE/D2nlHlsqsIPWbAAeJtX8suDbThO7kEOod2mtxSfK9un3OMN7V1rY
   A==;
X-CSE-ConnectionGUID: Eil3ozniTsag+8hhFWem6g==
X-CSE-MsgGUID: iCIX7lNxT5y0wlN5ONh+KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68638815"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68638815"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 00:36:33 -0700
X-CSE-ConnectionGUID: 2dMsqFG0QcSzB+3gJFySTw==
X-CSE-MsgGUID: tqeg8/XVQSytM7etCX/cZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172757008"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa004.jf.intel.com with SMTP; 21 Aug 2025 00:36:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Aug 2025 10:36:25 +0300
Date: Thu, 21 Aug 2025 10:36:25 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] usb: typec: Expose alternate mode priority via
 sysfs
Message-ID: <aKbMeSCHf-ZhbcvT@kuha.fi.intel.com>
References: <20250814184455.723170-1-akuchynski@chromium.org>
 <20250814184455.723170-6-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814184455.723170-6-akuchynski@chromium.org>

Hi Andrei,

On Thu, Aug 14, 2025 at 06:44:55PM +0000, Andrei Kuchynski wrote:
> This patch introduces a priority sysfs attribute to the USB Type-C
> alternate mode port interface. This new attribute allows user-space to
> configure the numeric priority of alternate modes managing their preferred
> order of operation.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-class-typec | 12 ++++++
>  drivers/usb/typec/class.c                   | 47 ++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 38e101c17a00..001202d651fa 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -162,6 +162,18 @@ Description:	Lists the supported USB Modes. The default USB mode that is used
>  		- usb3 (USB 3.2)
>  		- usb4 (USB4)
>  
> +		What:		/sys/class/typec/<port>/<alt-mode>/priority
> +Date:		July 2025
> +Contact:	Andrei Kuchynski <akuchynski@chromium.org>
> +Description:
> +		Displays and allows setting the priority for a specific alt-mode.
> +		When read, it shows the current integer priority value. Lower numerical
> +		values indicate higher priority (0 is the highest priority).
> +		If the new value is already in use by another mode, the priority of the
> +		conflicting mode and any subsequent modes will be incremented until they
> +		are all unique.
> +		This attribute is visible only if the kernel supports mode selection.

I was expecting this to be already used in this series.

IMO this file should be the only thing the user space needs to use by
default at least.

>  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>  
>  What:		/sys/class/typec/<port>-partner/accessory_mode
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index a72325ff099a..708f3487222a 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -19,6 +19,7 @@
>  #include "bus.h"
>  #include "class.h"
>  #include "pd.h"
> +#include "mode_selection.h"
>  
>  static DEFINE_IDA(typec_index_ida);
>  
> @@ -445,11 +446,41 @@ svid_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(svid);
>  
> +static ssize_t priority_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t size)
> +{
> +	unsigned int val;
> +	int err = kstrtouint(buf, 10, &val);
> +
> +	if (!err) {
> +		err = typec_mode_set_priority(to_typec_altmode(dev), val);
> +		if (!err)
> +			return size;
> +	}
> +
> +	return err;
> +}
> +
> +static ssize_t priority_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	int val;
> +	const int err = typec_mode_get_priority(to_typec_altmode(dev), &val);
> +
> +	if (err)
> +		return err;
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +static DEVICE_ATTR_RW(priority);
> +
>  static struct attribute *typec_altmode_attrs[] = {
>  	&dev_attr_active.attr,
>  	&dev_attr_mode.attr,
>  	&dev_attr_svid.attr,
>  	&dev_attr_vdo.attr,
> +	&dev_attr_priority.attr,
>  	NULL
>  };
>  
> @@ -458,7 +489,7 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
>  {
>  	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
>  
> -	if (attr == &dev_attr_active.attr)
> +	if (attr == &dev_attr_active.attr) {
>  		if (!is_typec_port(adev->dev.parent)) {
>  			struct typec_partner *partner =
>  				to_typec_partner(adev->dev.parent);
> @@ -469,6 +500,15 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
>  				!adev->ops->activate)
>  				return 0444;
>  		}
> +	} else if (attr == &dev_attr_priority.attr) {
> +		if (is_typec_port(adev->dev.parent))  {
> +			struct typec_port *port = to_typec_port(adev->dev.parent);
> +
> +			if (!port->alt_mode_override)
> +				return 0;
> +		} else
> +			return 0;
> +	}

If we have the local port variable, this should be enough:

                if (!is_typec_port(adev->dev.parent) || !port->alt_mode_override)
                        return 0;

>  	return attr->mode;
>  }
> @@ -2029,6 +2069,7 @@ static void typec_release(struct device *dev)
>  	typec_mux_put(port->mux);
>  	typec_retimer_put(port->retimer);
>  	kfree(port->cap);
> +	typec_mode_selection_destroy(port);
>  	kfree(port);
>  }
>  
> @@ -2496,6 +2537,8 @@ typec_port_register_altmode(struct typec_port *port,
>  		to_altmode(adev)->retimer = retimer;
>  	}
>  
> +	typec_mode_set_priority(adev, -1);

This really should not be necessary. Why can't we set the priority
based on the order the drives registers the altmodes for the port?

>  	return adev;
>  }
>  EXPORT_SYMBOL_GPL(typec_port_register_altmode);
> @@ -2645,6 +2688,8 @@ struct typec_port *typec_register_port(struct device *parent,
>  	port->con.attach = typec_partner_attach;
>  	port->con.deattach = typec_partner_deattach;
>  
> +	INIT_LIST_HEAD(&port->mode_list);
> +
>  	if (cap->usb_capability & USB_CAPABILITY_USB4)
>  		port->usb_mode = USB_MODE_USB4;
>  	else if (cap->usb_capability & USB_CAPABILITY_USB3)

thanks,

-- 
heikki

