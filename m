Return-Path: <linux-kernel+bounces-866844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83096C00D14
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5193B3633
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210630ACFC;
	Thu, 23 Oct 2025 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOtyPfxp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDA1222564;
	Thu, 23 Oct 2025 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219403; cv=none; b=k8HGvexZZnE6vvnGPy0tzNZoE1Gs7dxfTaBZrpDMYxyYvDw01Jfrn2RNFl53IBl2pgkANzOstpYYwq93ONexCTERQOG4IsHQww6vlpaTLYNKys7mkZcLGDRUkyCrATplkQFt9Z+uj4F464wQZMGnaNIkmeo6UcJlFXFTTWQgnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219403; c=relaxed/simple;
	bh=f2YqjnkzS7XblEQQzbQJuEEnfM++QTqRRHZndsLcws0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4lPXfcu8FxjOSos5ppHI4wqGuSdWqjg/FV0XMkVSow2vmmabtAWrAFZFYy9YKS18S8wZymKKSkIGr71gDJmxzDajtTEZ7+TRHb7hvRguhdaRdMt4iATAov4k4EEbe/HWldoWrzZjeeT931L/1aYRREL9S0rp9ulgvgbVKu0GsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOtyPfxp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761219402; x=1792755402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f2YqjnkzS7XblEQQzbQJuEEnfM++QTqRRHZndsLcws0=;
  b=EOtyPfxpBfg6Pohg/Oojgqne1KRQmVhUfYF6itMUF4GQzxrriGJCUQ7E
   pRxOKGYF1OcsgxShPVJ9nzrNGWvQ9GU733iLnxjpAUpBML7vttko5fEIY
   m5vUIHijA+3kVU6iocMmncjz8zfg4e6rmB5VFgiZimUSr6mGMyx2tibCt
   wgZEZBsK53jAFv7f9AXAlSZYjdB0s9MhKT9QWZEfZRyIE9ccNSpq69wmp
   8ftMe9Xvwrjv9fQmqviAUKR7pM2abT9IUprg3PgqJ35SW6Lmx9B2LZfGR
   yoMNqY2vbqMlCOiMShIh+GhReaF36fLIRIxOCJMM8nV+ciM7FhyEQ7i3q
   A==;
X-CSE-ConnectionGUID: xLzcgR/7QF+OIpIyJMhuIg==
X-CSE-MsgGUID: XlsSWyU5QEaOygUReQOeWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66000956"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="66000956"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 04:36:41 -0700
X-CSE-ConnectionGUID: 1TqIq3snTL+ZCxmH6TFP0g==
X-CSE-MsgGUID: z60IloovRZGSCzaw8UIrVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="189267971"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.165])
  by orviesa005.jf.intel.com with SMTP; 23 Oct 2025 04:36:31 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 23 Oct 2025 14:36:30 +0300
Date: Thu, 23 Oct 2025 14:36:30 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
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
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 1/9] usb: typec: Add notifier functions
Message-ID: <aPoTPr28cBzwbH0T@kuha.fi.intel.com>
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-2-kernel@airkyi.com>
 <aPni4AeDaem_rfZH@kuha.fi.intel.com>
 <aPnvoSRJefwDlpNO@kuha.fi.intel.com>
 <aPn4-S7upPOOtenr@kuha.fi.intel.com>
 <9c52db41-14f3-41a8-9423-3efe604361aa@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c52db41-14f3-41a8-9423-3efe604361aa@rock-chips.com>


> Thank you for your detailed explanation. I noticed that there is a
> device_register() action in typec_register_altmode(), so we can just take
> advantage of this.
> 
> Another thing is that we need to distinguish between different devices in the
> notifier callback, as
> typec_register_altmode()/typec_register_partner()/typec_register_plug()/typec_register_cable()
> may all register devices. Since the data passed in bus_notify() is struct
> device *dev, I think we can distinguish them through `dev->type.name`? We may
> already have such names, "typec_alternate_mode", "typec_partner", "typec_plug"
> in class.c . And then extract these names as macros and put them in the typec
> header file.

You don't need to worry about that. Only partner altmodes are bind to
the bus. The device you see in the notifier will always be an altmode.

But in general, if you need to identify the device type, then
you use the device type itself, not the name of the type. It would
require that the device types are exported, but as said, you don't
need to worry about that in this case.

thanks,

-- 
heikki

