Return-Path: <linux-kernel+bounces-802617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2E7B454AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025871C858A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1036E2F83D4;
	Fri,  5 Sep 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFo4EfOv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0D2F0689;
	Fri,  5 Sep 2025 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067948; cv=none; b=jPrUJ9ZD64XxXqjeRlyp5j4l7Q4+Pmpbw+ZGtNf3AZ8dH0wQp+MgzM9aRz3Oq+7up8NPkV5CRUBtUp4BZ4VONPGe0BMTW5clIy2WMjrF8aRginmvvuNH1W2u579Op/P6xEwk/6fwR3Sdqhly8JGFgGyAq0XwShehoEWjNFJoH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067948; c=relaxed/simple;
	bh=qK8CT81jgHTuswqY7YSS5DInuFEUAmPzMZvhAbowudY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFyY3TBbmzPucgluL2ViBrlHrkxdTtcx/gWgNnKF8SYI7tiuy7flmJUezsQIDNPLYTjcOQ/l8aXC53oGiWvrJ32/m8TH6xmOZ2EwavCBHqsyMsMjuzdfgmwf+e8HdbUCHevsVwiYcEF7zizNBbXqV25NKwfGoSAwuwKNhuBJmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFo4EfOv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757067947; x=1788603947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qK8CT81jgHTuswqY7YSS5DInuFEUAmPzMZvhAbowudY=;
  b=CFo4EfOvb3R0R+hEpKT0CrZe5HMI99BTs8hDV0QQfGbcZgqDh46eJv1X
   BVK24Qj2+lzvvYrQflhLs0+ipgThjB62lo8/AYrPbe73Gyc7a68qYKgG8
   DecH+llEX95UO0RMsSIIInha9i0Ha0pmtaKOHtMo7Iy5P1h2MIzHKzjwq
   9GVFlkIF5cT2azuhK96g/Gj41PzZn9qEbFxuVhURCKVR6R6XT8AlZc6Fd
   gxqEvVSsB/UEgfWIeaot1FcfT1q2Q1RfWTD+iRpfedFrJgUL5/hYPZ1zx
   3WLDmd674LcfAVFCOxOAZILDfBxwkBzfH508gPCBrbhusIvZuzhvgxj9P
   A==;
X-CSE-ConnectionGUID: wG0XC9jISqOst8+9V+A92A==
X-CSE-MsgGUID: XuZvoVIvS3uB6hzTrWPflw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82009164"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82009164"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 03:25:45 -0700
X-CSE-ConnectionGUID: 6ZkKWX+zQwCYvzooWQGHfw==
X-CSE-MsgGUID: hQ2ZW+VwREe9I+etMNSDbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="176469270"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa004.jf.intel.com with SMTP; 05 Sep 2025 03:25:37 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Sep 2025 13:25:36 +0300
Date: Fri, 5 Sep 2025 13:25:36 +0300
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
Subject: Re: [PATCH v2 4/5] usb: typec: Implement alternate mode priority
 handling
Message-ID: <aLq6oNcA_yoMZyrf@kuha.fi.intel.com>
References: <20250825145750.58820-1-akuchynski@chromium.org>
 <20250825145750.58820-5-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825145750.58820-5-akuchynski@chromium.org>

On Mon, Aug 25, 2025 at 02:57:49PM +0000, Andrei Kuchynski wrote:
> This patch introduces APIs to manage the priority of USB Type-C alternate
> modes. These APIs allow for setting and retrieving a priority number for
> each mode. If a new priority value conflicts with an existing mode's
> priority, the priorities of the conflicting mode and all subsequent modes
> are automatically incremented to ensure uniqueness.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  drivers/usb/typec/Makefile         |  2 +-
>  drivers/usb/typec/mode_selection.c | 38 ++++++++++++++++++++++++++++++
>  drivers/usb/typec/mode_selection.h |  6 +++++
>  include/linux/usb/typec_altmode.h  |  1 +
>  4 files changed, 46 insertions(+), 1 deletion(-)
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
> diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mode_selection.c
> new file mode 100644
> index 000000000000..2179bf25f5d4
> --- /dev/null
> +++ b/drivers/usb/typec/mode_selection.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2025 Google LLC.
> + */
> +
> +#include "mode_selection.h"
> +#include "class.h"
> +#include "bus.h"
> +
> +static int increment_duplicated_priority(struct device *dev, void *data)
> +{
> +	struct typec_altmode **alt_target = (struct typec_altmode **)data;
> +
> +	if (is_typec_altmode(dev)) {
> +		struct typec_altmode *alt = to_typec_altmode(dev);
> +
> +		if (alt != *alt_target && alt->priority == (*alt_target)->priority) {
> +			alt->priority++;
> +			*alt_target = alt;
> +			return 1;

Couldn't you just always return 0?

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void typec_mode_set_priority(struct typec_altmode *alt,
> +		const unsigned int priority)
> +{
> +	struct typec_port *port = to_typec_port(alt->dev.parent);
> +	int res = 1;
> +
> +	alt->priority = priority;
> +
> +	while (res)
> +		res = device_for_each_child(&port->dev, &alt,
> +				increment_duplicated_priority);

Then this could be:

        device_for_each_child(&port->dev, &alt, increment_duplicated_priority);

right?

> +}
> diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mode_selection.h
> new file mode 100644
> index 000000000000..cbf5a37e6404
> --- /dev/null
> +++ b/drivers/usb/typec/mode_selection.h
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/usb/typec_altmode.h>
> +
> +void typec_mode_set_priority(struct typec_altmode *alt,
> +		const unsigned int priority);
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index b3c0866ea70f..571c6e00b54f 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -28,6 +28,7 @@ struct typec_altmode {
>  	int				mode;
>  	u32				vdo;
>  	unsigned int			active:1;
> +	unsigned int			priority;
>  
>  	char				*desc;
>  	const struct typec_altmode_ops	*ops;
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 

-- 
heikki

