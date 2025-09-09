Return-Path: <linux-kernel+bounces-807539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45084B4A5E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96247B76E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBC9274B46;
	Tue,  9 Sep 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5VnWrky"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456D2737EE;
	Tue,  9 Sep 2025 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407647; cv=none; b=IQ/LKk4gGjM2jpG8I4Lf2fy+KDyPJhlJ3n6f8L8ZxB+cWKYZAI0MW3xptPBVqgzPos/PdVmiOXeVNcEqNSK85xxrcCf5sQvXPILp9amPFpTcMCg/JYP2fotyj2qqJmENalU2Nr5WgXsWB3z4UY1kpuNokl+ej2Yqr89wvnWupPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407647; c=relaxed/simple;
	bh=L+Z5YiGdi8+dIpyCxBvtSfmQwmDJ8SouRsPp5IbBzfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL5MfzEwh7zYuZEeIb3m7b1to7OjiSboP+ZhrQk6HiiOdlWB+9Cx8LfkSFExsrvVbj9+YbwUTM9yRXrWr5RwpsnHPr0y5q60RKHuBaTk2Ja8A9PEXSnfsXrUzbm8qJwqABKqVUA9C48Y/RcaJgb2cj/gPVGQfUCC1/Js6PGPfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5VnWrky; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757407646; x=1788943646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L+Z5YiGdi8+dIpyCxBvtSfmQwmDJ8SouRsPp5IbBzfw=;
  b=g5VnWrky7bvOfzAIO69GekBTkoofONec996QSYh6RygT5F2vyc85SoeV
   bRHPKXWAoroqlbATW0+WYNQPj+nblIvnlEFAv4AbvtoUfEV+n9+hhH6yY
   gnxsU1v3DGl0jgyJ5Bb0FwygAn3+YNlv3FO5gFGiCQMOCXzmAdtrMYnAs
   XeHq+QbRQJXxLqO6K4RMydIPXd9ctOiIh9CsPZ4fPOdnvpgewJWndWzYc
   c/+zqrs9L3PnNaiMlF5pX2Uh82oF7/sK5MhsycdQmK47R0TgPT6UTx9JQ
   Dqrt5DFLE9FaZIZaFy11yE9t1SV2907NC8mnDcrKEgla59RjIP+CepzEC
   w==;
X-CSE-ConnectionGUID: yaH0A9FrTiyVVpzYS32xxQ==
X-CSE-MsgGUID: tz25Sae8RfupwbPFgafmxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59608805"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59608805"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 01:47:26 -0700
X-CSE-ConnectionGUID: 7kcscwhbTtqYl7ysNJfz2Q==
X-CSE-MsgGUID: f0NuAjZtStOxgmvSP9FWmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="204017950"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa001.fm.intel.com with SMTP; 09 Sep 2025 01:47:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Sep 2025 11:47:20 +0300
Date: Tue, 9 Sep 2025 11:47:20 +0300
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
Subject: Re: [PATCH v3 1/5] usb: typec: Add mode_control field to port
 property
Message-ID: <aL_pmB2A9oKre2t2@kuha.fi.intel.com>
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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
>  };
>  
>  #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 252af3f77039..8f51665d44ec 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -287,6 +287,7 @@ enum usb_pd_svdm_ver {
>   * @prefer_role: Initial role preference (DRP ports).
>   * @accessory: Supported Accessory Modes
>   * @usb_capability: Supported USB Modes
> + * @no_mode_control: Ability to manage Alternate Modes
>   * @fwnode: Optional fwnode of the port
>   * @driver_data: Private pointer for driver specific info
>   * @pd: Optional USB Power Delivery Support
> @@ -304,6 +305,7 @@ struct typec_capability {
>  	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
>  	unsigned int		orientation_aware:1;
>  	u8			usb_capability;
> +	bool			no_mode_control;
>  
>  	struct fwnode_handle	*fwnode;
>  	void			*driver_data;
> -- 
> 2.51.0.355.g5224444f11-goog

-- 
heikki

