Return-Path: <linux-kernel+bounces-807545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A703B4A5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFD53B9313
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C11273D66;
	Tue,  9 Sep 2025 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q74+7OPk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1324DD0E;
	Tue,  9 Sep 2025 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407843; cv=none; b=IlAF0ThQbdbZiS5G/XY8I6DFf4rZZaAR16xQ0mbW1Tu/3D6sW01bhOqscs4YEkHR6jJjw55t9V33hjgVW9Jj12d7djsTQIyrmplxF4/PRtDy91A+HksG3ugBMSKDWLIN3fqqhCb+uXfNTu8t4mBs9hnuhNCxkhnzxTzka6IRYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407843; c=relaxed/simple;
	bh=ed7e5OBmwQDDoEsNMC34AA4fThwgfnoPnie6p3nRVzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC05ffK7eP13dS/fAENAXspLkbijyjHgTsZeOoXj3anyvpxAiTppkhR8S4+CkvHRPoexWCx04pn0ynq+tysv/qxc6u98ezbRt8wSQEIf5/+73cYPQjQFeao0jMokYurL5fQwmjYzvfHy8OzCfqWoNru2qfXyiK/4hSQaYUaEi8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q74+7OPk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757407841; x=1788943841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ed7e5OBmwQDDoEsNMC34AA4fThwgfnoPnie6p3nRVzE=;
  b=Q74+7OPkJxEH7UOA7JUuFZUj6IkrT3I6IU9kutcZAb+miVE3ZTRx27EJ
   EzBEcmgzO0pN7ffQCUG04NVI6SDNK5esGptLqaNG5sRzEDuZKBhgS36Mv
   vSsWlCF0E3/slxCQk5slYjo3PIaIleRC7Ua1yMJ5NCP10IVm8U3uZyeMx
   xkspz6yjXEcAjLFEhfVu4Mwe4RkxoDKu7okwGZoFK0MNA8vZWXCZgJmcZ
   Hpub3Hwxt9WjsVh+IU5K6eJ3j4Azp86FFMPNsjb8NqbLdlaixFc9vpnOT
   NLiPqxiP7WqDf6CjHGTKcPrCod5k5eO7ZddggUnCf2Z3DjGuFzCK8ccrY
   A==;
X-CSE-ConnectionGUID: T+AlKPNuQdOEmLm3Ad3uMQ==
X-CSE-MsgGUID: tCUBA2GxQVWldKH8BQf/UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="85130631"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="85130631"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 01:50:40 -0700
X-CSE-ConnectionGUID: FOTGJ6SvSHynYKXNF3iYCg==
X-CSE-MsgGUID: icqoi7buS/+IowwG595ldg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="210180574"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa001.jf.intel.com with SMTP; 09 Sep 2025 01:50:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Sep 2025 11:50:35 +0300
Date: Tue, 9 Sep 2025 11:50:35 +0300
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
Subject: Re: [PATCH v3 4/5] usb: typec: Implement alternate mode priority
 handling
Message-ID: <aL_qW-fYN8PMoBv2@kuha.fi.intel.com>
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-5-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905142206.4105351-5-akuchynski@chromium.org>

On Fri, Sep 05, 2025 at 02:22:05PM +0000, Andrei Kuchynski wrote:
> This patch introduces APIs to manage the priority of USB Type-C alternate
> modes. These APIs allow for setting and retrieving a priority number for
> each mode. If a new priority value conflicts with an existing mode's
> priority, the priorities of the conflicting mode and all subsequent modes
> are automatically incremented to ensure uniqueness.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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
> 2.51.0.355.g5224444f11-goog

-- 
heikki

