Return-Path: <linux-kernel+bounces-739002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E81B0C07B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2C01895C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51F28C5B6;
	Mon, 21 Jul 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmEYQWyH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E0285074;
	Mon, 21 Jul 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090997; cv=none; b=BppfdXUvKEbW+VXz+fMXl3eDxJ4M3nvk5hebo9v2DMrIrzxrxpc2KaEV4+cxiX/YeXJpJSAPaj9g6v9Ss8Hk/494u3m3GKeoEb14h8edhIAtrJJolgDF9WF2XPh5hEKzd7td/nU55R4tsQO5CAkRWM3ZZRgYx5zYQcRi8hTiDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090997; c=relaxed/simple;
	bh=AWUhJfFtDs1Xp/8DjHKe4FrCLD+NnAwcchCeln8sQRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjbX8642JgNeNQTDHMdygVD5UEhg98osErwoYduAgNLIkz7M5fMeIcdaxNQVwl4N9nKezMQieUlHcrqXohdbpusoXFsvBTe1kKWgUdMsgud8/2W06QirE6gMSfcviCIEeKi6/saUYG3NEuJZV9+mc1jukogu2d/Bk5f8fx0/6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmEYQWyH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753090996; x=1784626996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AWUhJfFtDs1Xp/8DjHKe4FrCLD+NnAwcchCeln8sQRg=;
  b=OmEYQWyH6HvCfQOTwQi2/zFrVrhDysgoP7jxHXVkmoh7dGmM9mlHQwpM
   UELnfhWc45NdOdiBmKjVM77ZCYKjDf56bjkyVZuqeKIMhrMGCI7eVDx5U
   Z/IyqE8awVzRXjeqGIOXKh3aI9EvfjFKY+AdA4xQKz8+sHVGmWl47pa2s
   0epQCOoFRrimc3rhqlPlAPuYlIwwELfzCpFZaTw+2wDb7Mchsf5uS3GGn
   4uRcLCn605tEhDf/J6oLLgIeHAo8r6JzkrNtuMdYTdXpnYRSmn4loSyk4
   8c12HhOUKau1/adC+Cfj2I1lSMJYVZdhHldAEfBEmwTwxdgZZIehbzLpE
   g==;
X-CSE-ConnectionGUID: wOFZvNGqT6SNtHRauEuUww==
X-CSE-MsgGUID: iqxboJSIS36MViQr87IGNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55258292"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55258292"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 02:43:16 -0700
X-CSE-ConnectionGUID: A6wiIx91Tm+wVN+NWuMXQw==
X-CSE-MsgGUID: TjXFQEImSzGOO74gprIFnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="164270901"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa004.fm.intel.com with SMTP; 21 Jul 2025 02:43:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Jul 2025 12:43:10 +0300
Date: Mon, 21 Jul 2025 12:43:10 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>, Pavan Holla <pholla@chromium.org>,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	Yue Haibing <yuehaibing@huawei.com>,
	Pengyu Luo <mitltlatltl@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: yoga-c630: add DRM dependency
Message-ID: <aH4Lrl72BTAWfMdv@kuha.fi.intel.com>
References: <20250717133045.991254-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717133045.991254-1-arnd@kernel.org>

On Thu, Jul 17, 2025 at 03:30:41PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Selecting DRM_AUX_HPD_BRIDGE is not possible from a built-in driver when
> CONFIG_DRM=m:
> 
> WARNING: unmet direct dependencies detected for DRM_AUX_HPD_BRIDGE
>   Depends on [m]: HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
>   Selected by [y]:
>   - UCSI_LENOVO_YOGA_C630 [=y] && USB_SUPPORT [=y] && TYPEC [=y] && TYPEC_UCSI [=y] && EC_LENOVO_YOGA_C630 [=y] && DRM_BRIDGE [=y] && OF [=y]
> arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/aux-hpd-bridge.o: in function `drm_aux_hpd_bridge_notify':
> aux-hpd-bridge.c:(.text.drm_aux_hpd_bridge_notify+0x28): undefined reference to `drm_bridge_hpd_notify'
> arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/aux-hpd-bridge.o: in function `drm_aux_hpd_bridge_probe':
> aux-hpd-bridge.c:(.text.drm_aux_hpd_bridge_probe+0x20): undefined reference to `__devm_drm_bridge_alloc'
> 
> Add a dependency to force UCSI_LENOVO_YOGA_C630 to be a loadable module as
> well in this configuration.
> 
> Fixes: eb90d36bfa06 ("usb: typec: ucsi: yoga-c630: register DRM HPD bridge")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> index 52b53bb6dfed..7fcb1e1de5d6 100644
> --- a/drivers/usb/typec/ucsi/Kconfig
> +++ b/drivers/usb/typec/ucsi/Kconfig
> @@ -85,6 +85,7 @@ config CROS_EC_UCSI
>  config UCSI_LENOVO_YOGA_C630
>  	tristate "UCSI Interface Driver for Lenovo Yoga C630"
>  	depends on EC_LENOVO_YOGA_C630
> +	depends on DRM || !DRM
>  	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
>  	help
>  	  This driver enables UCSI support on the Lenovo Yoga C630 laptop.
> -- 
> 2.39.5

-- 
heikki

