Return-Path: <linux-kernel+bounces-866457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0062EBFFCEE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731E33A7E29
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4D2EB86F;
	Thu, 23 Oct 2025 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkwmgCx6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F624634F;
	Thu, 23 Oct 2025 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207041; cv=none; b=MUVggGO5cpHtXZ0iNBX9YWehrrY9MrROBf4ecaHp1IbtT4oOvCT7VydIwQCDRhDFU6ccAnw0qpa9P3XIBpsaplv5n+WbCzsYrrplZRDusA2FtpZqwhkdmY2sEX/wW/Dn8LMcoscbFEWcBJYcVuQgLFGyYIFpjcAvtS92N+nnTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207041; c=relaxed/simple;
	bh=X9A+e5HX8/DxioXkaxwvZdY29MB1MDYbmVYOX4ols5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnxqtHK3ZgikSTUzSBsbXllkUUtn78DnqJFcP5eXA/5AuNULaEipTvaRkt+fsQqtFngMUwvjwgLl07LckSWO4FQmaWtN2NAfD7uyA6EibGRrcVxZBezZi32b5rN5bn7jKFhJ2fZgyOAHfEMrMHvaFIr+sgJGFPCXma5Mz8OqxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkwmgCx6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761207039; x=1792743039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X9A+e5HX8/DxioXkaxwvZdY29MB1MDYbmVYOX4ols5k=;
  b=QkwmgCx6ZjHE7F0BLdTLUfNuHCcuyNn8jIceT8CsRK79k5xjCxnhXze1
   XO9z/YKcoDblkxrmUTIPOe0cWMV5qqgkAvl0hk8R8b+C803hQqOkzcKu5
   fNt874eGFwWQSNx0NEHoqSTjdN++GTr0AwUB4S4cewrTbuSZ80aIPZVLZ
   dtEUP4xWSeQd4d7DxgS5b+CWKXET7XJjvNqmxSI6E9S19vMpJKVvITJ+t
   3YD9VqENoCVgyxgFNQyfapK5OIiKg2/YMuU/dpNwvCjLWUIDfUKuoOqun
   zxGwp69eRaQMdJ9lZXb/qOklZJY/Ff4oGTT648shVFtEWIjveGx+tr+av
   Q==;
X-CSE-ConnectionGUID: aXYzEv/qTLyoIgMXB/n+6g==
X-CSE-MsgGUID: YKpVJcArS4e0sCOa8NVd+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74039083"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="74039083"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:10:20 -0700
X-CSE-ConnectionGUID: U/yJ+8RYQ+2huY61DLG6tw==
X-CSE-MsgGUID: qjW+PJi/SHi+vFM/FDi4jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="183988336"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.165])
  by orviesa007.jf.intel.com with SMTP; 23 Oct 2025 01:10:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 23 Oct 2025 11:10:08 +0300
Date: Thu, 23 Oct 2025 11:10:08 +0300
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
Subject: Re: [PATCH v7 1/9] usb: typec: Add notifier functions
Message-ID: <aPni4AeDaem_rfZH@kuha.fi.intel.com>
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023033009.90-2-kernel@airkyi.com>

Hi,

> diff --git a/include/linux/usb/typec_notify.h b/include/linux/usb/typec_notify.h
> new file mode 100644
> index 000000000000..a3f1f3b3ae47
> --- /dev/null
> +++ b/include/linux/usb/typec_notify.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __USB_TYPEC_NOTIFY
> +#define __USB_TYPEC_NOTIFY
> +
> +#include <linux/notifier.h>
> +
> +enum usb_typec_event {
> +	TYPEC_ALTMODE_REGISTERED
> +};

Don't you need to know when the altmode is removed?

> +
> +int typec_register_notify(struct notifier_block *nb);
> +int typec_unregister_notify(struct notifier_block *nb);
> +
> +void typec_notify_event(unsigned long event, void *data);

Declare typec_notify_event() in drivers/usb/typec/bus.h

thanks,

-- 
heikki

