Return-Path: <linux-kernel+bounces-802563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDEDB453D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397F8A40E40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B94298CA5;
	Fri,  5 Sep 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbBysEbq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF691D555;
	Fri,  5 Sep 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066267; cv=none; b=IeJ8tvPNptZ33NzgX3De1XsSbU8R4QRoMRZ/YVdoRNEi9vAk7rrzZWNYI8RmtWOzToKzVXRHkHoOQlGOZ/7wUwWgWHLxpzUVI/EJeBp7rggKqr+w0CxlLxUcipBzKr4rRJtiBnPFl1//AnyAV+RxzCmEdEtuB4Tt/SlHQa7DNPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066267; c=relaxed/simple;
	bh=8q8nnACbLJ2cv9OUfaS30eEGHF3yr2aXfrpwZpdTxko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WspvI0hDIpCmSmLswZUAvqbTGTW1Sr1UAd3z2JyMl+VVzjEICQXE9DqqZiis9/SOgOChEay+Lbch02Jg0rhJDTXT+mlATJx74Tsr9QoCUpALC90Pti5rnbhLeL64Np2WpuPPpVyg7RujdoxbQu5GjY8n/JW5CuZSLxehPcn5/XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbBysEbq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757066266; x=1788602266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8q8nnACbLJ2cv9OUfaS30eEGHF3yr2aXfrpwZpdTxko=;
  b=cbBysEbq+p6NxfzEB/Pu+DXZU2x6QQwdQMGcTyYwC7ZmEfvenp3RCl0D
   vbB6/M79+AvIL5D5Ag3i19CzsNEaj152pv3+5SGTDga7XWwQsJicABj3N
   RdwG5+bhOyxh3JGtX0RCDhM/uxQv85oxG4TF74WcjBf3TlF0fdlf8vrZm
   kLEbrw1gRRYwW5wfP6rnNJT0pMw6oGuL5DEFkQj/7ZxY3JX2FbiiOedE9
   QL8f8wnt08yuYgg0tlkrOeBamHbOn/cnYwxkj2NyOZUkJE6pZcZ6yMolR
   l36RbUpBjvVXD457unJ7dfNeGX6sBYMPsWizY73vx87aAn1uq4764NtUC
   g==;
X-CSE-ConnectionGUID: XqQjnu5NQ0eqHGiZQMQEgQ==
X-CSE-MsgGUID: ANbHkn6fSM67vwtGARVXpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="69674223"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="69674223"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 02:57:46 -0700
X-CSE-ConnectionGUID: 6PjwMeliRNKQnt9UZ2URIA==
X-CSE-MsgGUID: MS9w3seGQie4fm37vdOTBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="176454114"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa005.fm.intel.com with SMTP; 05 Sep 2025 02:57:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Sep 2025 12:57:40 +0300
Date: Fri, 5 Sep 2025 12:57:40 +0300
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
Subject: Re: [PATCH v2 1/5] usb: typec: Add alt_mode_override field to port
 property
Message-ID: <aLq0FCAq-LiB139t@kuha.fi.intel.com>
References: <20250825145750.58820-1-akuchynski@chromium.org>
 <20250825145750.58820-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825145750.58820-2-akuchynski@chromium.org>

On Mon, Aug 25, 2025 at 02:57:46PM +0000, Andrei Kuchynski wrote:
> This new field in the port properties dictates whether the Platform Policy
> Manager (PPM) allows the OS Policy Manager (OPM) to change the currently
> active, negotiated alternate mode.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  drivers/usb/typec/class.c | 9 ++++++---
>  drivers/usb/typec/class.h | 2 ++
>  include/linux/usb/typec.h | 1 +
>  3 files changed, 9 insertions(+), 3 deletions(-)

This is okay by me, but you forgot to document the file.

thanks,

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
>  };
>  
>  #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 252af3f77039..cbc94282e45e 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -304,6 +304,7 @@ struct typec_capability {
>  	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
>  	unsigned int		orientation_aware:1;
>  	u8			usb_capability;
> +	bool			no_mode_control;
>  
>  	struct fwnode_handle	*fwnode;
>  	void			*driver_data;
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 

-- 
heikki

