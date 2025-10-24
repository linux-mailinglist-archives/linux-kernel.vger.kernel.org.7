Return-Path: <linux-kernel+bounces-868350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C746BC0503F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F33F4F944C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC25303A20;
	Fri, 24 Oct 2025 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4iS8vy6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9530277D;
	Fri, 24 Oct 2025 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293791; cv=none; b=mQ2ujT7EODP5FxtAmhRS0AQOZ7UrdGlxUwe1dqiM7dEr6/6Zwp79VFGEiRMQBFhJLyyAX2o9rjP1OMJpe2J7aMfKW3boto1kPRv6QxXVoIzdRRj3GbE29NVdEJPzULlv6hiGheM4vWpaDxBxs2+M/Y6vpyKjzai8fgX3dozxfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293791; c=relaxed/simple;
	bh=Y6hIryfME2/PZmCw4H4nq4PMUJueVx80pY8OjCr1KyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBXdZdghR5PvzWvNszqyOL6J/b8aqBWSRaM2w0GvSmizcbT3FL5qdhVLHeDA7fdGtlLNsowHIUVV77+24NklZWT3/nkJK/Ll63B/hUJ8IcYXy2hEYIUsGzh45WqmRDhK8r9bUCuRl1CnonriGd8BVtFcr/vR2udzD2c6MALHtKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4iS8vy6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761293789; x=1792829789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y6hIryfME2/PZmCw4H4nq4PMUJueVx80pY8OjCr1KyY=;
  b=g4iS8vy6q5JvMmzMps77tHvI90cEA4UYPIvl0SdkIAmyc/4CGdjeAts6
   mqc+I5nZ5dAAjCFANskfCZv/Aomj7+74nngllAugfs5M8uS84buN/0q2k
   0RwJerjflp9EnA025DOiAs6P+DXQKnpssePSUD+rLJVBkVqJ7JkWSHTcD
   R5Ux0FacINPl80akVR3pte8gyI+KkTb6HPQEyDFRLC0WWJaOqk0x6bq25
   T/w0Pc6PIX7QcC+ZS4MH4v6v5lmDVrKqWbdcIDwAN3dcQQcAJkzdQDrEc
   P2NcvujPA8r9NWSXtEZtvc97KGwRdJxNVjcZjm9c5V5mLbH2On9yKWjFX
   w==;
X-CSE-ConnectionGUID: FM+F3peDReuUNw9RGelWJw==
X-CSE-MsgGUID: Sc2lb3AVSxuAyYHvnBPBeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74818597"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="74818597"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:16:28 -0700
X-CSE-ConnectionGUID: Chd3dXKyQl6vo1nUEb8nyA==
X-CSE-MsgGUID: CnAOpA8XQ3utXO3rexXLig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="215297555"
Received: from mjruhl-desk.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.255])
  by fmviesa001.fm.intel.com with SMTP; 24 Oct 2025 01:16:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 24 Oct 2025 11:16:16 +0300
Date: Fri, 24 Oct 2025 11:16:16 +0300
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
Message-ID: <aPs10Ay_cQ5TZ7nb@kuha.fi.intel.com>
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

> +#include <linux/notifier.h>
> +#include <linux/usb/typec_notify.h>
> +
> +static BLOCKING_NOTIFIER_HEAD(typec_notifier_list);
> +
> +int typec_register_notify(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&typec_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(typec_register_notify);
> +
> +int typec_unregister_notify(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&typec_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(typec_unregister_notify);

Better name these more clearly:

typec_altmode_register_notify()
typec_altmode_unregister_notify()

thanks,

-- 
heikki

