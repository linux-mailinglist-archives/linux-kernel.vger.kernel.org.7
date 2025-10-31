Return-Path: <linux-kernel+bounces-880273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63921C254A2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECA4188F7C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957022A4F6;
	Fri, 31 Oct 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6Ob6ym9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1D221D96;
	Fri, 31 Oct 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917998; cv=none; b=L4bUaGwfZaOD+FwvsPLBwadUK/q2FOxpqX52N8WnrZtdznsfct1nuAGnDOip2O1cdMZw7U8pdm1jxxh83YAnd+10lkJebvMWt8D7JqFyMwxGkrwF3VkerJPm0NRdD12+fXz6+sk2E/GHXVG26x4rO6QLEjl+p2dHLjxNY+lz4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917998; c=relaxed/simple;
	bh=2cVyjKey4dFxUiUnROSgPcOL0J7KqoBoYiJcjCFDf/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxSM9i1Rp2BUMiEy5br8R49DlAuEUG2UH+KcB/3AEXsWH+kFMTYdqrHh0ZrB7aM3ErTVzQHr1C28pQBu5hZxv9z/Mvx0ItiELxHRr13UGU07LZn67oIglTTPPhLC2h49g6I2gWP93JXuniRla7uovrggCjqpp75cf1lYI+IwMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6Ob6ym9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761917997; x=1793453997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2cVyjKey4dFxUiUnROSgPcOL0J7KqoBoYiJcjCFDf/g=;
  b=c6Ob6ym9n9gA/m1b3ZXr0SXhcqvC7gnyPvmfAGVzWXQfwsn6V1LB2/4H
   IL4i1rz7p6w+gDykz9d+RMbTv1g6l23IjyskjzM+oIugPZ1Xt8x3ENaZ5
   weAxNJwr5wS/4Lse/CA4dylqWAM84RgjLtRrFcqBCoN8VxsnLPfHgReja
   lDOu8tO5a4hG9UHzXW9Srzo9Wyx1/l2ijjZfgxUKThNQgW5jRWfXIIR3b
   IONUOolxBHZ6sD6k62Wl9lB1Xu0by/lQbx6IadSoh1ynGNuReivwgbMLK
   XlKjmD9S4OV+lx5bsGYWrJ0FQEmxsb6XvMZjNbGbptD5btUPueup/Cqsg
   Q==;
X-CSE-ConnectionGUID: /pKmpWuiQeyHR4UaiUK6fA==
X-CSE-MsgGUID: XhL4Tk4RRoigv2YvJIv56Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75195119"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="75195119"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:39:57 -0700
X-CSE-ConnectionGUID: a3xtnYTPQP+uCyKoQ92d0Q==
X-CSE-MsgGUID: C/6GFGJvSTi0FjPfK6/uAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186115249"
Received: from jjgreens-desk20.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.81])
  by fmviesa006.fm.intel.com with SMTP; 31 Oct 2025 06:39:46 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 31 Oct 2025 15:39:45 +0200
Date: Fri, 31 Oct 2025 15:39:45 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 01/10] usb: typec: Add notifier functions
Message-ID: <aQS8IatWiAUzBUxd@kuha.fi.intel.com>
References: <20251029071435.88-1-kernel@airkyi.com>
 <20251029071435.88-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029071435.88-2-kernel@airkyi.com>

Hi,

> diff --git a/include/linux/usb/typec_notify.h b/include/linux/usb/typec_notify.h
> new file mode 100644
> index 000000000000..f3a7b5f5b05b
> --- /dev/null
> +++ b/include/linux/usb/typec_notify.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __USB_TYPEC_NOTIFY
> +#define __USB_TYPEC_NOTIFY
> +
> +#include <linux/notifier.h>

Replace that include with a forward declaration:

struct notifier_block;

> +enum usb_typec_event {
> +	TYPEC_ALTMODE_REGISTERED,
> +	TYPEC_ALTMODE_UNREGISTERED,
> +};
> +
> +int typec_altmode_register_notify(struct notifier_block *nb);
> +int typec_altmode_unregister_notify(struct notifier_block *nb);
> +
> +#endif /* __USB_TYPEC_NOTIFY */

I don't see any need for a separate header file for this. Intoduce
those in typec_altmode.h.

thanks,

-- 
heikki

