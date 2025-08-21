Return-Path: <linux-kernel+bounces-779500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8FB2F4DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3FF5E13DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E92F0C5E;
	Thu, 21 Aug 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+e5QXy1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FC241136;
	Thu, 21 Aug 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770999; cv=none; b=cV/Ibr3gL6OVnsAQkal7DEK/jSOj0B0pIVTvHDXymvCHvAydGgIAWEDx0z44oxoxIsUweTij46QSnAnXHRuUQOxF+OXW+wfqkLK53G3p2FbYsXDGTbh0JF9RaY5tS3Ib/yFEUxrjy1h4aHM7mE6WfNc9kDppsFvj0C8pSmJs1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770999; c=relaxed/simple;
	bh=ODCiSt050/93YT63kH5y8LEYeVrA2YtuNNgCp2LPkNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/7Zd+AadrRf2yOJJvAAIVPnUquNecEXy0oeHuWVUeadhE7sBQifx0FzbQDm5HNFkDdMJ58UBzfQ5ZtWskS6Z/ugA17U1z2EuGes6vhDDnEH3oSGtXAQCcr2oZcxqd+Ji3vdZVy/kavDkW13HQ8BEgHBVN3YyN76lQ1YUm5NZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+e5QXy1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755770997; x=1787306997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODCiSt050/93YT63kH5y8LEYeVrA2YtuNNgCp2LPkNI=;
  b=D+e5QXy1B+3Nh4OWPI8FMmPV1iwdujo1l+kacYbQQhmjDAhLRHQKqu9H
   jMpOxsRMpqn8ihTZ/w04IuSJA4aDVg3ydFwy+kQw90CTSC7Xi3zk5j221
   cH0mK/e1HvRf36v3lxTSQJKTrpSCYRkMX9ZuJp9CY8uqSpoNN2oybGG97
   INTttbvSlYYvmrKfEAX11KLgkQ4Nag28V8V4QwIOrtEhK2dYxWdhyH8Sw
   kCGM7m1+0+aswp+ZEhbPYZJdZ8ML5sjhPi5eie6HolB32am0pIt3Lj9AO
   5Bz1hhpoz2jUBkl4DvVD3Yz4KXY7G5SExmiXdjNFUlqp5Od96UCcgLmQz
   w==;
X-CSE-ConnectionGUID: 3PccLsndTpGkXyof8hrXvA==
X-CSE-MsgGUID: bOs3vb69Td6CBf/YtypT+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69430966"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69430966"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 03:09:57 -0700
X-CSE-ConnectionGUID: tpdXCjnAQm2IibFKPyDYsw==
X-CSE-MsgGUID: lSilGxVqSRWLZHQSPcK3Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="205555210"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa001.jf.intel.com with SMTP; 21 Aug 2025 03:09:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Aug 2025 13:09:51 +0300
Date: Thu, 21 Aug 2025 13:09:51 +0300
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
Subject: Re: [PATCH v1 4/5] usb: typec: Implement alternate mode priority
 handling
Message-ID: <aKbwby7OYdUpLvhA@kuha.fi.intel.com>
References: <20250814184455.723170-1-akuchynski@chromium.org>
 <20250814184455.723170-5-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814184455.723170-5-akuchynski@chromium.org>

Hi Andrei,

On Thu, Aug 14, 2025 at 06:44:54PM +0000, Andrei Kuchynski wrote:
> This patch introduces APIs to manage the priority of USB Type-C alternate
> modes. These APIs allow for setting and retrieving a priority number for
> each mode. If a new priority value conflicts with an existing mode's
> priority, the priorities of the conflicting mode and all subsequent modes
> are automatically incremented to ensure uniqueness.

I think this needs to be simplified. You don't need this elaborate
implementation in the beginning.

I'm going to do some suggestions. I don't know if all of them work,
but hopefully you get the idea how I would like to see the initial
support to be implemented.

> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  drivers/usb/typec/Makefile         |   2 +-
>  drivers/usb/typec/class.h          |   1 +
>  drivers/usb/typec/mode_selection.c | 127 +++++++++++++++++++++++++++++
>  drivers/usb/typec/mode_selection.h |   8 ++
>  include/linux/usb/typec_altmode.h  |   9 ++
>  5 files changed, 146 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/typec/mode_selection.c
>  create mode 100644 drivers/usb/typec/mode_selection.h
> 
> diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> index 7a368fea61bc..8a6a1c663eb6 100644
> --- a/drivers/usb/typec/Makefile
> +++ b/drivers/usb/typec/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TYPEC)		+= typec.o
> -typec-y				:= class.o mux.o bus.o pd.o retimer.o
> +typec-y				:= class.o mux.o bus.o pd.o retimer.o mode_selection.o
>  typec-$(CONFIG_ACPI)		+= port-mapper.o
>  obj-$(CONFIG_TYPEC)		+= altmodes/
>  obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index f05d9201c233..c6467e576569 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -82,6 +82,7 @@ struct typec_port {
>  	struct device			*usb3_dev;
>  
>  	bool				alt_mode_override;
> +	struct list_head		mode_list;

I'm not sure we need this.

>  };
>  
>  #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
> diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mode_selection.c
> new file mode 100644
> index 000000000000..8a54639b86bf
> --- /dev/null
> +++ b/drivers/usb/typec/mode_selection.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2025 Google LLC.
> + */
> +
> +#include <linux/usb/typec_altmode.h>
> +#include <linux/slab.h>
> +#include <linux/list.h>
> +#include "mode_selection.h"
> +#include "class.h"
> +
> +static const char * const mode_names[TYPEC_ALTMODE_MAX] = {
> +	[TYPEC_ALTMODE_DP] = "DisplayPort",
> +	[TYPEC_ALTMODE_TBT] = "Thunderbolt3",
> +	[TYPEC_ALTMODE_USB4] = "USB4",
> +};

You only need string for USB4. The altmode names come from the drivers.

> +static const int default_priorities[TYPEC_ALTMODE_MAX] = {
> +	[TYPEC_ALTMODE_DP] = 2,
> +	[TYPEC_ALTMODE_TBT] = 1,
> +	[TYPEC_ALTMODE_USB4] = 0,
> +};

The default priorities is an array of svids. And I really think that
the highest priority should be 1 not 0.

> +static inline enum typec_mode_type typec_svid_to_altmode(const u16 svid)
> +{
> +	switch (svid) {
> +	case USB_TYPEC_DP_SID:
> +		return TYPEC_ALTMODE_DP;
> +	case USB_TYPEC_TBT_SID:
> +		return TYPEC_ALTMODE_TBT;
> +	case USB_TYPEC_USB4_SID:
> +		return TYPEC_ALTMODE_USB4;
> +	}
> +	return TYPEC_ALTMODE_MAX;
> +}

Get rid of this.

> +/**
> + * struct mode_selection_state - State tracking for a specific Type-C mode
> + * @mode: The type of mode this instance represents
> + * @priority: The mode priority. Lower values indicate a more preferred mode.
> + * @list: List head to link this mode state into a prioritized list.
> + */
> +struct mode_selection_state {
> +	enum typec_mode_type mode;
> +	int priority;
> +	struct list_head list;
> +};

Get rid of this. I don't see why you would need to separate the
priority handling at this point. Keep it as simply as possible first.

Just place the priority member to struct typec_altmode. 0 should
indicate that there is no specific priority set, or default order
should be used IMO.

> +/* -------------------------------------------------------------------------- */
> +/* port 'mode_priorities' attribute */
> +
> +int typec_mode_set_priority(struct typec_altmode *adev, const int priority)
> +{
> +	struct typec_port *port = to_typec_port(adev->dev.parent);
> +	const enum typec_mode_type mode = typec_svid_to_altmode(adev->svid);
> +	struct mode_selection_state *ms_target = NULL;
> +	struct mode_selection_state *ms, *tmp;
> +
> +	if (mode >= TYPEC_ALTMODE_MAX || !mode_names[mode])
> +		return -EOPNOTSUPP;

Just support every altmode bind to a driver and USB4. USB4 you
identify with a specific usb4 device type.

> +	list_for_each_entry_safe(ms, tmp, &port->mode_list, list) {
> +		if (ms->mode == mode) {
> +			ms_target = ms;
> +			list_del(&ms->list);
> +			break;
> +		}
> +	}
> +
> +	if (!ms_target) {
> +		ms_target = kzalloc(sizeof(struct mode_selection_state), GFP_KERNEL);
> +		if (!ms_target)
> +			return -ENOMEM;
> +		ms_target->mode = mode;
> +		INIT_LIST_HEAD(&ms_target->list);
> +	}
> +
> +	if (priority >= 0)
> +		ms_target->priority = priority;
> +	else
> +		ms_target->priority = default_priorities[mode];
> +
> +	while (ms_target) {
> +		struct mode_selection_state *ms_peer = NULL;
> +
> +		list_for_each_entry(ms, &port->mode_list, list)
> +			if (ms->priority >= ms_target->priority) {
> +				if (ms->priority == ms_target->priority)
> +					ms_peer = ms;
> +				break;
> +			}
> +
> +		list_add_tail(&ms_target->list, &ms->list);
> +		ms_target = ms_peer;
> +		if (ms_target) {
> +			ms_target->priority++;
> +			list_del(&ms_target->list);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int typec_mode_get_priority(struct typec_altmode *adev, int *priority)
> +{
> +	struct typec_port *port = to_typec_port(adev->dev.parent);
> +	const enum typec_mode_type mode = typec_svid_to_altmode(adev->svid);
> +	struct mode_selection_state *ms;
> +
> +	list_for_each_entry(ms, &port->mode_list, list)
> +		if (ms->mode == mode) {
> +			*priority = ms->priority;
> +			return 0;
> +		}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +void typec_mode_selection_destroy(struct typec_port *port)
> +{
> +	struct mode_selection_state *ms, *tmp;
> +
> +	list_for_each_entry_safe(ms, tmp, &port->mode_list, list) {
> +		list_del(&ms->list);
> +		kfree(ms);
> +	}
> +}
> diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mode_selection.h
> new file mode 100644
> index 000000000000..69adfcf39d7c
> --- /dev/null
> +++ b/drivers/usb/typec/mode_selection.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_tbt.h>
> +
> +int typec_mode_set_priority(struct typec_altmode *adev, const int priority);
> +int typec_mode_get_priority(struct typec_altmode *adev, int *priority);
> +void typec_mode_selection_destroy(struct typec_port *port);
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index b3c0866ea70f..318858fc7bec 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -145,6 +145,15 @@ enum {
>  
>  #define TYPEC_MODAL_STATE(_state_)	((_state_) + TYPEC_STATE_MODAL)
>  
> +#define USB_TYPEC_USB4_SID	0xff00

I would suggest that you create a separate patch or patches for the
USB4 mode registration.

> +enum typec_mode_type {
> +	TYPEC_ALTMODE_DP = 0,
> +	TYPEC_ALTMODE_TBT,
> +	TYPEC_ALTMODE_USB4,
> +	TYPEC_ALTMODE_MAX,
> +};

Drop this completely.

thanks,

-- 
heikki

