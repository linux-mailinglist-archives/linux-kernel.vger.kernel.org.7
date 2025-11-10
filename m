Return-Path: <linux-kernel+bounces-892558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE748C455A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E993B3324
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06532E8E14;
	Mon, 10 Nov 2025 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeMklAA8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DB2EC088;
	Mon, 10 Nov 2025 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762890; cv=none; b=ZoT8vtaIXE5xrKx5yVA8VtVq13ZE2KvfWnjEGqiovA6lD0Xw1rUf59QhXNs/uTeDefVIZHWwPvmgks1cPfnCTU/MfdaVDIYHbjJaKlEb7NBG2tNZjbigzuPrVHDMVKwbBR+MApQINGa1dDQ6nvkPeHm8B8PtWQvboBTurk4B1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762890; c=relaxed/simple;
	bh=KZPEfdtjgCevG4AWR7XY1pgwOA01nvey7oaq3eTS84Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etiZcttU3Hzi5/By8RFHxPzXRCZ14NM9Nn9YbsEXra6ULdbGncMEK0b1gLZ/GdTkLrBzqYPMssxu2HBnE592ydAGcIyEokjGtQrptFRTmX6jlQtk1UHdDJODHbFE15dUvacIFnrxeHQu61aVegIKefM3ipmQrnxAQwC4iY8jNq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeMklAA8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762762888; x=1794298888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZPEfdtjgCevG4AWR7XY1pgwOA01nvey7oaq3eTS84Q=;
  b=GeMklAA8YHtJpr8cbJRuOSPBtDZ7CfDxv+Xl46rYxsCst/Q+LKXiA8Yq
   CAei3iwRhH5Ii+mHvY4qkdBqgLNLmgCCHZzOQb0a1Y4fFtf0kSG4xvkfQ
   XdpkuYqnRO7+krdV93HA9kopqeQ6NujTgOe9jl+i6gvNJdiZRk/ZH5DZu
   9EuELd9iaembmpHOabCy32px3I0EBdBEo8rD2kxZUFZ4R5Al41+NzrBd6
   DcZESQsJBWd5yv++rCCJy8xQeHO7gcm30+mKdFvIbjJB3muIoIeINA1Jd
   OGsXOu3RpspgSzSJpGpDEQJn+nJ3vWF6okgmMBUv5PBrZrPUWAq/Tjtxo
   Q==;
X-CSE-ConnectionGUID: 56f6xU0IRBSYg6qNz2ZWRQ==
X-CSE-MsgGUID: rQF0W4OWQQ+Ty+rSySVMMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="67415832"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="67415832"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 00:21:27 -0800
X-CSE-ConnectionGUID: bnk5T85hQWusgdYT0/9ibw==
X-CSE-MsgGUID: xr56bQ1ORcqyTDxJfH1Czg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="189053823"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.222.208])
  by fmviesa009.fm.intel.com with SMTP; 10 Nov 2025 00:21:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 10 Nov 2025 10:21:22 +0200
Date: Mon, 10 Nov 2025 10:21:22 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Peter Korsgaard <peter@korsgaard.com>
Cc: javier.carrasco@wolfvision.net, neal@gompa.dev,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tipd: mark as orientation aware
Message-ID: <aRGggpULQM3xH-pS@kuha.fi.intel.com>
References: <20251107151311.2089806-1-peter@korsgaard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107151311.2089806-1-peter@korsgaard.com>

Fri, Nov 07, 2025 at 04:13:10PM +0100, Peter Korsgaard kirjoitti:
> The driver contains orientation detection logic and correctly calls
> typec_set_orientation(), but forgets to set the orientation_aware
> capability, so the orientation value is not visible in sysfs - Fix that.
> 
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 2b1049c9a6f3..d561032a2970 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1695,6 +1695,7 @@ tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  	typec_cap.data = ret;
>  	typec_cap.revision = USB_TYPEC_REV_1_3;
>  	typec_cap.pd_revision = 0x300;
> +	typec_cap.orientation_aware = true;
>  	typec_cap.driver_data = tps;
>  	typec_cap.ops = &tps6598x_ops;
>  	typec_cap.fwnode = fwnode;
> -- 
> 2.39.5

-- 
heikki

