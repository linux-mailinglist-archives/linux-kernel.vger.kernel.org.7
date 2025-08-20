Return-Path: <linux-kernel+bounces-777515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243A6B2DA60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E646A7B4BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1502E2EEF;
	Wed, 20 Aug 2025 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PT2rPObK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F53F19F464;
	Wed, 20 Aug 2025 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687211; cv=none; b=sVJVQRiEI+nQPr7M7nUsKOY9ansA/s7ap0O2jgLZWqXmmAyxhPJcbVJfoytPbUBRzx3y9Kze++m/AF5rpE0duoKnYL7m+8JpS+zRVzqsYhgNPLAqMJ4Uecvtivk8LSRr2MpJ0JoC39A+b5oSIKRkTXcsZT0i7ftcNCRBOtGfeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687211; c=relaxed/simple;
	bh=VrHV56mLIsK7pvqPM+xqm769YJ2QJKhERwjIsezWgxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTA8tZOYAOtdXAhdREiejTSvu4vuvO+4/v3m94+g/klcg/iascUwo5nCm8/vK9A9hS5TNebzfDC3WJqlm7N6T+w8ElRzRmGJvr4dJ2H/8m4pNSoctstqq3SSdGa8dPTMCd6X6YjqN9PLFY15Yip/kLSDvo8xRN79RvYyzWSoYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PT2rPObK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755687210; x=1787223210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VrHV56mLIsK7pvqPM+xqm769YJ2QJKhERwjIsezWgxU=;
  b=PT2rPObKMVc949a1SK6RdACyWqRo9/j6JvkULzlO5XGnCsB9TaIr1A93
   ITtBbPNIny6VYX3IDzY01g08EbznzYowL4qNM/xA2k9CaFe6dwnnqEpFY
   c/gVupCDQzKxMUYgHJOTqhZNHn8kWyIIy0mo0KpE63lqkhi/7xds3c7ON
   UP0E/YJJqSczTwR4fiaxFQ1p2vqUh5aPYdVO3rwjmkSvXoHzbKxJPiYWV
   ljx3TO2uqbq7J8TU3RozW9l9YJIU1u+YhWAW7KK+nr7oR9SNn/28YuC/x
   OCTSokeRvVfUvNdNKJTCYdEbFdhWQW/lUAye9oycmr1rbGxv+yg2xI3wd
   A==;
X-CSE-ConnectionGUID: SlJARmj/T6m3MXPVzyzKQA==
X-CSE-MsgGUID: H4Qoq4KcR/KL0teo+/JEhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68657203"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="68657203"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 03:53:29 -0700
X-CSE-ConnectionGUID: iRnm3Ud9S8ybVfVPYaUkug==
X-CSE-MsgGUID: mnWZaIVkTdOXv98qrsxTaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168445514"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa008.fm.intel.com with SMTP; 20 Aug 2025 03:53:24 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 20 Aug 2025 13:53:23 +0300
Date: Wed, 20 Aug 2025 13:53:23 +0300
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
Subject: Re: [PATCH v1 1/5] usb: typec: Add alt_mode_override field to port
 property
Message-ID: <aKWpI0RhPR2mFlql@kuha.fi.intel.com>
References: <20250814184455.723170-1-akuchynski@chromium.org>
 <20250814184455.723170-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814184455.723170-2-akuchynski@chromium.org>

On Thu, Aug 14, 2025 at 06:44:51PM +0000, Andrei Kuchynski wrote:
> This new field in the port properties dictates whether the Platform Policy
> Manager (PPM) allows the OS Policy Manager (OPM) to change the currently
> active, negotiated alternate mode.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  drivers/usb/typec/class.c | 14 +++++++++++---
>  drivers/usb/typec/class.h |  2 ++
>  include/linux/usb/typec.h |  1 +
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 67a533e35150..a72325ff099a 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -459,9 +459,16 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
>  	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
>  
>  	if (attr == &dev_attr_active.attr)
> -		if (!is_typec_port(adev->dev.parent) &&
> -		    (!adev->ops || !adev->ops->activate))
> -			return 0444;
> +		if (!is_typec_port(adev->dev.parent)) {
> +			struct typec_partner *partner =
> +				to_typec_partner(adev->dev.parent);

That looks a bit unnecessary. Also, can't the altmode be a plug alt mode?

> +			struct typec_port *port =
> +				to_typec_port(partner->dev.parent);
> +
> +			if (!port->alt_mode_override || !adev->ops ||
> +				!adev->ops->activate)
> +				return 0444;
> +		}

How about:

	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
        struct typec_port *port = typec_altmode2port(adev);

        if (attr == &dev_attr_active.attr) {
               if (!is_typec_port(adev->dev.parent)) {
                        if (!port->alt_mode_override || !adev->ops || !adev->ops->activate)
                                return 0444;
                }
        }

>  	return attr->mode;
>  }
> @@ -2681,6 +2688,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  	}
>  
>  	port->pd = cap->pd;
> +	port->alt_mode_override = cap->alt_mode_override;

This needs to be enabled by default:

	port->alt_mode_override = !cap->no_mode_control;

>  	ret = device_add(&port->dev);
>  	if (ret) {
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index db2fe96c48ff..f05d9201c233 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -80,6 +80,8 @@ struct typec_port {
>  	 */
>  	struct device			*usb2_dev;
>  	struct device			*usb3_dev;
> +
> +	bool				alt_mode_override;

s/alt_mode_override/mode_control/ ?

>  };
>  
>  #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 252af3f77039..6e09e68788dd 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -304,6 +304,7 @@ struct typec_capability {
>  	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
>  	unsigned int		orientation_aware:1;
>  	u8			usb_capability;
> +	bool			alt_mode_override;
>  
>  	struct fwnode_handle	*fwnode;
>  	void			*driver_data;
> -- 
> 2.51.0.rc0.215.g125493bb4a-goog

-- 
heikki

