Return-Path: <linux-kernel+bounces-810267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AB0B517F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9F51C8316A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3030CDA5;
	Wed, 10 Sep 2025 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MFExHsTn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C4D4A1A;
	Wed, 10 Sep 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511100; cv=none; b=Gj5pEOjZvf8UccGW0nYe4Ps1WUy12YoWqJzWsg83L8FEQhi6vkRriLq3EFQ8DWiYMPQPcNNx3nktZIjhG88Nt2cHxMv+1SaFo93r6RnqgL0RryzvBg3yYGDVoOhMu+3mQLsYEtz5cE7dZdkyT6KSFioJ+a05THflN/2Q3ZmHJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511100; c=relaxed/simple;
	bh=UDpje6m1xlgONj6ZK3LPa5ZB65IKuApE8hhhpSoZSZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBcsCZqYZAfMMEwhf+KIMmr1y9GCl03lFC8MOv44EJCVtLm4Flh6vz8MuKAux5CvrV7618zEOex61/IMxtiXuk/AlkRI6LuUhDPIEMheWWvhwPFwAcKKhN/Tii03OA97nhWuhIBYz+jMt/bOjny/zyoipwmf2O9bibnsgEUe0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MFExHsTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4158BC4CEF0;
	Wed, 10 Sep 2025 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757511100;
	bh=UDpje6m1xlgONj6ZK3LPa5ZB65IKuApE8hhhpSoZSZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFExHsTnPFKyUcqjBFXkokDS2qNnzJ4U3lyqbyLL3XjeT8sOye5qBo8Wg2JSbCf5z
	 72vl34xODtA2omsbutw1nIlI99rKEB4Am2Tz1kJ6lhp3oZgMt3c2JMc1qz5dm+GtkL
	 DB/wxtJNLOYLRRwdu7HNrx9qQJr9IERJrVHXkvTQ=
Date: Wed, 10 Sep 2025 15:31:37 +0200
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
Subject: Re: [PATCH v3 4/5] usb: typec: Implement alternate mode priority
 handling
Message-ID: <2025091029-snarl-decimal-aea2@gregkh>
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

What is the range of this?  And this value is only incremented, never
decremented?

thanks,

greg k-h

