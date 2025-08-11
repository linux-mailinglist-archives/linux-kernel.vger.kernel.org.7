Return-Path: <linux-kernel+bounces-762883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41A9B20BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0C416CDCB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA923C51B;
	Mon, 11 Aug 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOHi0Fbo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727023F41D;
	Mon, 11 Aug 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922350; cv=none; b=uM97LSk79BqDl9+xllbrIOPt707JlsaWrQOczwdwcKblGGXXncpGVwCFTfimhxh3UAaTIjKVgo48JopKuyQ0Mlg1R8mkHGNdH1dAwadITDQM5oJEgMSK0sT92C0uuHR++gpG6vOIi4BTqEjNxP7NeY6fcqFeKYWjEXWyjjsUlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922350; c=relaxed/simple;
	bh=32sSTgeUM0BUngL37Ztz58noqbfxsJxdjfMoPhooq0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4Hw5my14ajms26OEa19uNRi0WPHW75xE+mXZQH5tjnIGexPEC3rXEBZCBcrnbrwIrk89R4yJGxfEslctF8QzYrnBLgRrFDXqDBd+x2y4pkLG+090rmZ/aiR3Eibg4Q7UuCAGK9830xuUJvcLAV5SLyNeHF37ffkAg/mayZQUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOHi0Fbo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754922348; x=1786458348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=32sSTgeUM0BUngL37Ztz58noqbfxsJxdjfMoPhooq0U=;
  b=jOHi0FbocNNOaSPA0dVbTh/ahj97Q+w+If2oSPtRs+bEXUnUoObB6v+t
   3jQkXED8Xb+WlYa2nHG4GJM4tIKx1uV3pwMq/tpYH+bdNYIJYS1cwPUJX
   WTaSwbmU7KKJQRriG2h2cwVnrs5tk+8nF/rYEIFe+q9q3OygTafF2rgXi
   iZFwG4obR2YM6cU/L/U7iPTgF6sFGTquqNUkFz/IDsbYQ5A7Wy3m+abh+
   C+m7FXZ2s5Smdabak5G10Z+9qA1CykgYfW/cbW/xGNRwuE3Fx3dkDdJef
   89L2Mf9WCI+MNSQEPRNojLQ67VFiNjLzDIB+e5Wha/7pTvf8CCXWT55Wn
   w==;
X-CSE-ConnectionGUID: HqVDlmqaReawmm+0XJ2CRg==
X-CSE-MsgGUID: B7Ni+uZBQECRgCfhgfPz5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68545891"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68545891"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 07:25:47 -0700
X-CSE-ConnectionGUID: NllG1AhlRl+wXJgv5liSog==
X-CSE-MsgGUID: E7yKq2a/RkueIsYe9JCFJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170134087"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 11 Aug 2025 07:25:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 Aug 2025 17:25:41 +0300
Date: Mon, 11 Aug 2025 17:25:41 +0300
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
Subject: Re: [PATCH v3 04/10] usb: typec: Expose mode priorities via sysfs
Message-ID: <aJn9ZSy3w4zW4Xvq@kuha.fi.intel.com>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
 <20250804090340.3062182-5-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804090340.3062182-5-akuchynski@chromium.org>

Hi Andrei,

On Mon, Aug 04, 2025 at 09:03:33AM +0000, Andrei Kuchynski wrote:
> This patch introduces new sysfs attributes to allow users to configure
> and view Type-C mode priorities.
> 
> `priority`, `usb4_priority` attributes allow users to assign a numeric
> priority to DisplayPort alt-mode, Thunderbolt alt-mode, and USB4 mode.
> 
> `mode_priorities` - read-only attribute that displays an ordered list
> of all modes based on their configured priorities.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-class-typec |  33 +++++
>  drivers/usb/typec/Makefile                  |   2 +-
>  drivers/usb/typec/class.c                   | 103 +++++++++++++++-
>  drivers/usb/typec/class.h                   |   1 +
>  drivers/usb/typec/mode_selection.c          | 130 ++++++++++++++++++++
>  drivers/usb/typec/mode_selection.h          |  23 ++++
>  include/linux/usb/typec_altmode.h           |   7 ++
>  7 files changed, 295 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/usb/typec/mode_selection.c
>  create mode 100644 drivers/usb/typec/mode_selection.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 38e101c17a00..575dd94f33ab 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -162,6 +162,39 @@ Description:	Lists the supported USB Modes. The default USB mode that is used
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
> +
> +		What:		/sys/class/typec/<port>/usb4_priority
> +Date:		July 2025
> +Contact:	Andrei Kuchynski <akuchynski@chromium.org>
> +Description:
> +		Displays and allows setting the priority for USB4 mode. Its behavior and
> +		priority numbering scheme are identical to the general alt-mode
> +		"priority" attributes.

I'm not sure those above two file make any sense.

> +What:		/sys/class/typec/<port>/mode_priorities
> +Date:		July 2025
> +Contact:	Andrei Kuchynski <akuchynski@chromium.org>
> +Description:	This read-only file lists the modes supported by the port,
> +		ordered by their activation priority. It reflects the preferred sequence
> +		the kernel will attempt to activate modes (DisplayPort alt-mode,
> +		Thunderbolt alt-mode, USB4 mode).
> +		This attribute is visible only if the kernel supports mode selection.
> +
> +		Example values:
> +		- "USB4 Thunderbolt3 DisplayPort"
> +		- "DisplayPort": the port only supports Displayport alt-mode

Why not just use this one instead so that you write the highest
priority mode to it?

>  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>  
>  What:		/sys/class/typec/<port>-partner/accessory_mode
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
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index a72325ff099a..414d94c45ab9 100644
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
> @@ -445,11 +446,45 @@ svid_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(svid);
>  
> +static ssize_t priority_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t size)
> +{
> +	struct typec_altmode *adev = to_typec_altmode(dev);
> +	unsigned int val;
> +	int err = kstrtouint(buf, 10, &val);
> +
> +	if (!err) {
> +		err = typec_mode_set_priority(to_typec_port(adev->dev.parent),
> +			typec_svid_to_altmode(adev->svid), val);
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
> +	struct typec_altmode *adev = to_typec_altmode(dev);
> +	int val;
> +	const int err = typec_mode_get_priority(to_typec_port(adev->dev.parent),
> +			typec_svid_to_altmode(adev->svid), &val);
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
> @@ -458,7 +493,7 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
>  {
>  	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
>  
> -	if (attr == &dev_attr_active.attr)
> +	if (attr == &dev_attr_active.attr) {
>  		if (!is_typec_port(adev->dev.parent)) {
>  			struct typec_partner *partner =
>  				to_typec_partner(adev->dev.parent);
> @@ -469,6 +504,15 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
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
>  
>  	return attr->mode;
>  }
> @@ -1942,6 +1986,44 @@ static ssize_t orientation_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(orientation);
>  
> +static ssize_t mode_priorities_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	return typec_mode_get_priority_list(to_typec_port(dev), buf);
> +}
> +static DEVICE_ATTR_RO(mode_priorities);
> +
> +static ssize_t usb4_priority_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct typec_port *port = to_typec_port(dev);
> +	int val;
> +	const int err = typec_mode_get_priority(port, TYPEC_USB4_MODE, &val);
> +
> +	if (err)
> +		return err;
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t usb4_priority_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t size)
> +{
> +	struct typec_port *port = to_typec_port(dev);
> +	unsigned int val;
> +	int err = kstrtouint(buf, 10, &val);
> +
> +	if (!err) {
> +		err = typec_mode_set_priority(port, TYPEC_USB4_MODE, val);
> +		if (!err)
> +			return size;
> +	}
> +
> +	return err;
> +}
> +static DEVICE_ATTR_RW(usb4_priority);
> +
>  static struct attribute *typec_attrs[] = {
>  	&dev_attr_data_role.attr,
>  	&dev_attr_power_operation_mode.attr,
> @@ -1954,6 +2036,8 @@ static struct attribute *typec_attrs[] = {
>  	&dev_attr_port_type.attr,
>  	&dev_attr_orientation.attr,
>  	&dev_attr_usb_capability.attr,
> +	&dev_attr_mode_priorities.attr,
> +	&dev_attr_usb4_priority.attr,
>  	NULL,
>  };
>  
> @@ -1992,6 +2076,13 @@ static umode_t typec_attr_is_visible(struct kobject *kobj,
>  			return 0;
>  		if (!port->ops || !port->ops->default_usb_mode_set)
>  			return 0444;
> +	} else if (attr == &dev_attr_mode_priorities.attr) {
> +		if (!port->alt_mode_override)
> +			return 0;

I think the mode order could be visible even when it's read only.

> +	} else if (attr == &dev_attr_usb4_priority.attr) {
> +		if (!port->alt_mode_override ||
> +			!(port->cap->usb_capability & USB_CAPABILITY_USB4))
> +			return 0;
>  	}
>  
>  	return attr->mode;
> @@ -2029,6 +2120,7 @@ static void typec_release(struct device *dev)
>  	typec_mux_put(port->mux);
>  	typec_retimer_put(port->retimer);
>  	kfree(port->cap);
> +	typec_mode_selection_destroy(port);
>  	kfree(port);
>  }
>  
> @@ -2496,6 +2588,8 @@ typec_port_register_altmode(struct typec_port *port,
>  		to_altmode(adev)->retimer = retimer;
>  	}
>  
> +	typec_mode_set_priority(port, typec_svid_to_altmode(adev->svid), -1);
> +
>  	return adev;
>  }
>  EXPORT_SYMBOL_GPL(typec_port_register_altmode);
> @@ -2645,9 +2739,12 @@ struct typec_port *typec_register_port(struct device *parent,
>  	port->con.attach = typec_partner_attach;
>  	port->con.deattach = typec_partner_deattach;
>  
> -	if (cap->usb_capability & USB_CAPABILITY_USB4)
> +	typec_mode_selection_init(port);
> +
> +	if (cap->usb_capability & USB_CAPABILITY_USB4) {
>  		port->usb_mode = USB_MODE_USB4;
> -	else if (cap->usb_capability & USB_CAPABILITY_USB3)
> +		typec_mode_set_priority(port, TYPEC_USB4_MODE, -1);
> +	} else if (cap->usb_capability & USB_CAPABILITY_USB3)
>  		port->usb_mode = USB_MODE_USB3;
>  	else if (cap->usb_capability & USB_CAPABILITY_USB2)
>  		port->usb_mode = USB_MODE_USB2;
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index f05d9201c233..c6467e576569 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -82,6 +82,7 @@ struct typec_port {
>  	struct device			*usb3_dev;
>  
>  	bool				alt_mode_override;
> +	struct list_head		mode_list;
>  };
>  
>  #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
> diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mode_selection.c
> new file mode 100644
> index 000000000000..9a7185c07d0c
> --- /dev/null
> +++ b/drivers/usb/typec/mode_selection.c
> @@ -0,0 +1,130 @@
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
> +static const char * const mode_names[TYPEC_MODE_MAX] = {
> +	[TYPEC_DP_ALTMODE] = "DisplayPort",
> +	[TYPEC_TBT_ALTMODE] = "Thunderbolt3",
> +	[TYPEC_USB4_MODE] = "USB4",
> +};
> +
> +static const int default_priorities[TYPEC_MODE_MAX] = {
> +	[TYPEC_DP_ALTMODE] = 2,
> +	[TYPEC_TBT_ALTMODE] = 1,
> +	[TYPEC_USB4_MODE] = 0,
> +};
> +
> +/**
> + * struct mode_selection_state - State tracking for a specific Type-C mode
> + * @mode: The type of mode this instance represents
> + * @name: Name string pointer
> + * @priority: The mode priority. Higher values indicate a more preferred mode.
> + * @list: List head to link this mode state into a prioritized list.
> + */
> +struct mode_selection_state {
> +	enum typec_mode_type mode;
> +	const char *name;
> +	int priority;
> +	struct list_head list;
> +};

The name member looks unnecessary, but maybe you use it out side of
this file in the following patches.

> +/* -------------------------------------------------------------------------- */
> +/* port 'mode_priorities' attribute */
> +void typec_mode_selection_init(struct typec_port *port)
> +{
> +	INIT_LIST_HEAD(&port->mode_list);
> +}

Useless function.

> +void typec_mode_selection_destroy(struct typec_port *port)
> +{
> +	struct mode_selection_state *ms, *tmp;
> +
> +	list_for_each_entry_safe(ms, tmp, &port->mode_list, list) {
> +		list_del(&ms->list);
> +		kfree(ms);
> +	}
> +}
> +
> +int typec_mode_set_priority(struct typec_port *port,
> +		const enum typec_mode_type mode, const int priority)
> +{
> +	struct mode_selection_state *ms_target = NULL;
> +	struct mode_selection_state *ms, *tmp;
> +
> +	if (mode >= TYPEC_MODE_MAX || !mode_names[mode])
> +		return -EOPNOTSUPP;
> +
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
> +		ms_target->name = mode_names[mode];
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
> +int typec_mode_get_priority(struct typec_port *port,
> +		const enum typec_mode_type mode, int *priority)
> +{
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
> +ssize_t typec_mode_get_priority_list(struct typec_port *port, char *buf)
> +{
> +	struct mode_selection_state *ms;
> +	ssize_t count = 0;
> +
> +	list_for_each_entry(ms, &port->mode_list, list)
> +		count += sysfs_emit_at(buf, count, "%s ", ms->name);
> +
> +	return count + sysfs_emit_at(buf, count, "\n");
> +}
> diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mode_selection.h
> new file mode 100644
> index 000000000000..151f0f8b6632
> --- /dev/null
> +++ b/drivers/usb/typec/mode_selection.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_tbt.h>
> +
> +static inline enum typec_mode_type typec_svid_to_altmode(const u16 svid)
> +{
> +	switch (svid) {
> +	case USB_TYPEC_DP_SID:
> +		return TYPEC_DP_ALTMODE;
> +	case USB_TYPEC_TBT_SID:
> +		return TYPEC_TBT_ALTMODE;
> +	}
> +	return TYPEC_MODE_MAX;
> +}
> +
> +void typec_mode_selection_init(struct typec_port *port);
> +void typec_mode_selection_destroy(struct typec_port *port);
> +int typec_mode_set_priority(struct typec_port *port,
> +		const enum typec_mode_type mode, const int priority);
> +int typec_mode_get_priority(struct typec_port *port,
> +		const enum typec_mode_type mode, int *priority);
> +ssize_t typec_mode_get_priority_list(struct typec_port *port, char *buf);
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index b3c0866ea70f..5d14363e02eb 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -145,6 +145,13 @@ enum {
>  
>  #define TYPEC_MODAL_STATE(_state_)	((_state_) + TYPEC_STATE_MODAL)
>  
> +enum typec_mode_type {
> +	TYPEC_DP_ALTMODE = 0,
> +	TYPEC_TBT_ALTMODE,
> +	TYPEC_USB4_MODE,
> +	TYPEC_MODE_MAX,
> +};
> +
>  struct typec_altmode *typec_altmode_get_plug(struct typec_altmode *altmode,
>  					     enum typec_plug_index index);
>  void typec_altmode_put_plug(struct typec_altmode *plug);

It looks like this patch would allow the user space to write the mode
priority order without it taking effect. You need to re-organise this
series.

Please introduce the kernel APIs first followed by the user space ABI
changes. That should also make these a bit easier to review.

thanks,

-- 
heikki

