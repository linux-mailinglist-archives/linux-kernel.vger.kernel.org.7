Return-Path: <linux-kernel+bounces-880288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F5AC2558C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B63C9343926
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA90134BA2B;
	Fri, 31 Oct 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4EWlK+z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9D34B436;
	Fri, 31 Oct 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918561; cv=none; b=J4xTef+a8KS8W4XomIK+1pimd+o3YUXYBkYTGcCHxdP7QXkFbQc7rND/YaC9aNVDVRh2P+Kw/vOfmxQI4AGz5BVQRw7jfxE8d/aOOkXfrQlMJi+pEmaH+/+1+ArGOkNSIFIfXlf1nNypTW3sjujxhx74lsaO1aIaRqp+dnAjT6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918561; c=relaxed/simple;
	bh=HYOEnKzDkgpEufqlLglR4PKxYUcxwU5/7H2j5fZg/Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVQvijR3/Tv6BX7usCXvIhmGIWPFeAwRfiw8sYqFLOXVTePTCmWa1Nza/vhbUKsQI9eMHyZc8u+pT/SylU23j0d0DqCZA5o77N+6xzRlyEMyedCeenBx8vF/0/x5yJTM4bsCVnd08nArLG8hZnlDtRScAwiqqmMzhhrQxgtvVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4EWlK+z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761918559; x=1793454559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HYOEnKzDkgpEufqlLglR4PKxYUcxwU5/7H2j5fZg/Vg=;
  b=R4EWlK+z4e6am9QTFBTHWmljvZRNduqev2hYPHtKPVLf9PQ6REo76Um3
   wp7DB74GXzVEwBU4zTQ7QcBxlyKObf9xy3I5KilbID5JX4rVQIZzsu9HH
   E31vP6VPKqonZ3Taai+t7MSo67aO/KasomoXdOM8YnNTqjYIIKcyhBO4l
   398aOaAMEf2noBvfNAhqwNQp4FJuCll79HliXusMnusxS8xQxflggsn5b
   XkyPBr50QHfFSe4B0ey4DEy7LbZ+WGdDpX75aTkKp5ZDEkbVugCzvvQxM
   LvkkuseyyKTrSP2Z/Z3kwoFo8YLCj23z3Kcr+1Lf8RxwUKp4nN531XQnY
   Q==;
X-CSE-ConnectionGUID: GggTo1s/TgWCgVrDCvI2vA==
X-CSE-MsgGUID: exwZhliIQ7SE8aGugv56FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67939387"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="67939387"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:49:18 -0700
X-CSE-ConnectionGUID: 7+2Rt3wtTpGrCunfhDOadg==
X-CSE-MsgGUID: THGSvAIfTTaI5GaWq7/fJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185512675"
Received: from jjgreens-desk20.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.81])
  by orviesa010.jf.intel.com with SMTP; 31 Oct 2025 06:49:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 31 Oct 2025 15:49:06 +0200
Date: Fri, 31 Oct 2025 15:49:06 +0200
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
Subject: Re: [PATCH v8 02/10] usb: typec: Export all typec device types
Message-ID: <aQS-UtR7JGyXKmTB@kuha.fi.intel.com>
References: <20251029071435.88-1-kernel@airkyi.com>
 <20251029071435.88-3-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029071435.88-3-kernel@airkyi.com>

Wed, Oct 29, 2025 at 03:14:27PM +0800, Chaoyi Chen kirjoitti:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Export all typec device types for identification.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c |  4 ++++
>  drivers/usb/typec/class.h | 10 ----------
>  include/linux/usb/typec.h | 10 ++++++++++
>  3 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 51e971bc68d1..04b55f066b06 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -793,6 +793,7 @@ const struct device_type typec_partner_dev_type = {
>  	.groups = typec_partner_groups,
>  	.release = typec_partner_release,
>  };
> +EXPORT_SYMBOL_GPL(typec_partner_dev_type);
>  
>  static void typec_partner_link_device(struct typec_partner *partner, struct device *dev)
>  {
> @@ -1147,6 +1148,7 @@ const struct device_type typec_plug_dev_type = {
>  	.groups = typec_plug_groups,
>  	.release = typec_plug_release,
>  };
> +EXPORT_SYMBOL_GPL(typec_plug_dev_type);
>  
>  /**
>   * typec_plug_set_num_altmodes - Set the number of available plug altmodes
> @@ -1295,6 +1297,7 @@ const struct device_type typec_cable_dev_type = {
>  	.groups = typec_cable_groups,
>  	.release = typec_cable_release,
>  };
> +EXPORT_SYMBOL_GPL(typec_cable_dev_type);
>  
>  /**
>   * typec_cable_get - Get a reference to the USB Type-C cable
> @@ -2034,6 +2037,7 @@ const struct device_type typec_port_dev_type = {
>  	.uevent = typec_uevent,
>  	.release = typec_release,
>  };
> +EXPORT_SYMBOL_GPL(typec_port_dev_type);
>  
>  /* --------------------------------------- */
>  /* Driver callbacks to report role updates */
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index db2fe96c48ff..f04f6987bed8 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -87,16 +87,6 @@ struct typec_port {
>  #define to_typec_cable(_dev_) container_of(_dev_, struct typec_cable, dev)
>  #define to_typec_partner(_dev_) container_of(_dev_, struct typec_partner, dev)
>  
> -extern const struct device_type typec_partner_dev_type;
> -extern const struct device_type typec_cable_dev_type;
> -extern const struct device_type typec_plug_dev_type;
> -extern const struct device_type typec_port_dev_type;
> -
> -#define is_typec_partner(dev) ((dev)->type == &typec_partner_dev_type)
> -#define is_typec_cable(dev) ((dev)->type == &typec_cable_dev_type)
> -#define is_typec_plug(dev) ((dev)->type == &typec_plug_dev_type)
> -#define is_typec_port(dev) ((dev)->type == &typec_port_dev_type)
> -
>  extern const struct class typec_mux_class;
>  extern const struct class retimer_class;
>  extern const struct class typec_class;
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 309251572e2e..02fed8293415 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -56,6 +56,16 @@ enum typec_role {
>  	TYPEC_SOURCE,
>  };
>  
> +extern const struct device_type typec_partner_dev_type;
> +extern const struct device_type typec_cable_dev_type;
> +extern const struct device_type typec_plug_dev_type;
> +extern const struct device_type typec_port_dev_type;
> +
> +#define is_typec_partner(dev) ((dev)->type == &typec_partner_dev_type)
> +#define is_typec_cable(dev) ((dev)->type == &typec_cable_dev_type)
> +#define is_typec_plug(dev) ((dev)->type == &typec_plug_dev_type)
> +#define is_typec_port(dev) ((dev)->type == &typec_port_dev_type)
> +
>  static inline int is_sink(enum typec_role role)
>  {
>  	return role == TYPEC_SINK;
> -- 
> 2.49.0

-- 
heikki

